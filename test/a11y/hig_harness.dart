// Gedeeld harnas voor de HIG-audits (schermen en sheets); zie
// hig_audit_test.dart.
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:assistje/app.dart';
import 'package:assistje/core/router/app_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/api_fixtures.dart';
import '../helpers/fake_http_adapter.dart';
import '../helpers/test_app.dart';

class _Device {
  const _Device(this.name, this.size, this.ratio, this.top, this.bottom);

  final String name;
  final Size size;
  final double ratio;
  final double top;
  final double bottom;
}

const _devices = [
  _Device('se', Size(375, 667), 2, 20, 0),
  _Device('promax', Size(440, 956), 3, 62, 34),
];

/// Tekstgroottes: standaard en AX5 (Body 53 pt / 17 pt).
const _scales = {'1x': 1.0, 'ax5': 3.12};

/// Eén audit-geval: een scherm, en optioneel een handeling die er een sheet
/// of dialoog op opent ([open]); [label] onderscheidt die gevallen.
class AuditScreen {
  const AuditScreen(
    this.path, {
    this.trainer = true,
    this.setup,
    this.open,
    this.label,
    this.contrastFalsePositives = const [],
  });

  final String path;
  final bool trainer;
  final void Function(FakeHttpAdapter http)? setup;
  final Future<void> Function(WidgetTester tester)? open;
  final String? label;

  /// Labels waarvan de contrastmeting aantoonbaar verkeerd meet (de
  /// histogram-heuristiek van `textContrastGuideline` pakt dan bv. de rand
  /// van een invoerveld i.p.v. de tekst). Alleen met een reden bij het geval.
  final List<String> contrastFalsePositives;
}

/// Haalt contrastbevindingen voor [labels] uit [reason] (één blok per
/// `SemanticsNode`); `null` als er niets overblijft.
String? _withoutContrastFor(String reason, List<String> labels) {
  if (labels.isEmpty) return reason;
  final kept = reason
      .split(RegExp(r'(?=SemanticsNode#)'))
      .where(
        (node) => !labels.any(
          (l) => node.contains('label: "$l"') || node.contains('value: "$l"'),
        ),
      )
      .where((node) => node.contains('SemanticsNode#'))
      .toList();
  return kept.isEmpty ? null : kept.join();
}

const auditFeatures = {
  'stats': true,
  'fines': true,
  'savings': true,
  'wheel': true,
  'messages': true,
  'agreements': true,
  'vacations': true,
  'standing_absences': true,
  'injuries': true,
};

final _shotsDir = Platform.environment['HIG_SHOTS_DIR'];
final _shotKey = GlobalKey();

/// Laadt de echte fonts (Figtree, Phosphor, …) uit het FontManifest, zodat
/// tekstmaten kloppen en schermafbeeldingen leesbaar zijn.
Future<void> _loadFonts() async {
  final manifest =
      jsonDecode(await rootBundle.loadString('FontManifest.json'))
          as List<dynamic>;
  for (final entry in manifest.cast<Map<String, dynamic>>()) {
    final loader = FontLoader(entry['family'] as String);
    for (final font in (entry['fonts'] as List).cast<Map<String, dynamic>>()) {
      loader.addFont(rootBundle.load(font['asset'] as String));
    }
    await loader.load();
  }
}

Future<void> _screenshot(WidgetTester tester, String name) async {
  final dir = _shotsDir;
  if (dir == null) return;
  final boundary =
      _shotKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 2);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    File('$dir/$name.png')
      ..createSync(recursive: true)
      ..writeAsBytesSync(bytes!.buffer.asUint8List());
  });
}

Future<void> pumpAuditFrames(WidgetTester tester) async {
  for (var i = 0; i < 40; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

/// Tikt op [finder] (eerst in beeld scrollen) en laat de sheet openen.
Future<void> auditTap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder.first);
  await tester.pump(const Duration(milliseconds: 300));
  await tester.tap(finder.first, warnIfMissed: false);
  await pumpAuditFrames(tester);
}

/// Registreert per toestel × tekstgrootte × [screens] een audit-test.
void registerAudit(List<AuditScreen> screens) {
  setUpAll(_loadFonts);

  for (final device in _devices) {
    for (final scale in _scales.entries) {
      for (final screen in screens) {
        final name =
            '${device.name}-${scale.key}${screen.path.replaceAll('/', '_')}'
            '${screen.label == null ? '' : '+${screen.label}'}';
        testWidgets(name, (tester) async {
          debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
          tester.view
            ..physicalSize = device.size * device.ratio
            ..devicePixelRatio = device.ratio
            ..padding = FakeViewPadding(
              top: device.top * device.ratio,
              bottom: device.bottom * device.ratio,
            )
            ..viewPadding = FakeViewPadding(
              top: device.top * device.ratio,
              bottom: device.bottom * device.ratio,
            );
          tester.platformDispatcher.textScaleFactorTestValue = scale.value;
          addTearDown(() {
            tester.view.reset();
            tester.platformDispatcher.clearTextScaleFactorTestValue();
          });

          // Layoutfouten verzamelen in plaats van meteen te falen.
          final layoutErrors = <String>[];
          final previous = FlutterError.onError;
          FlutterError.onError = (details) {
            layoutErrors.add(details.exceptionAsString().split('\n').first);
          };

          final membership = ApiFixtures.membership(
            role: screen.trainer ? 'trainer' : 'player',
            abilities: screen.trainer
                ? const ['lineup', 'training_points', 'fines']
                : const [],
            features: auditFeatures,
            hasPoule: true,
          );
          final backend = TestBackend(token: '12|abc');
          await backend.init();
          backend.http
            ..on('GET /me', 200, ApiFixtures.meResponse(teams: [membership]))
            ..on('GET /teams/3/agenda', 200, ApiFixtures.emptyAgendaResponse());
          screen.setup?.call(backend.http);
          final container = backend.container();

          final findings = <String>[];
          try {
            await tester.pumpWidget(
              RepaintBoundary(
                key: _shotKey,
                child: UncontrolledProviderScope(
                  container: container,
                  child: const AssistjeApp(),
                ),
              ),
            );
            await pumpAuditFrames(tester);
            container.read(routerProvider).go(screen.path);
            await pumpAuditFrames(tester);
            await screen.open?.call(tester);

            await _screenshot(tester, name);
            findings.addAll(layoutErrors.toSet());
            FlutterError.onError = previous;

            for (final guideline in [
              iOSTapTargetGuideline,
              labeledTapTargetGuideline,
              if (scale.value == 1) textContrastGuideline,
            ]) {
              final result = await guideline.evaluate(tester);
              if (result.passed) continue;
              final reason = guideline == textContrastGuideline
                  ? _withoutContrastFor(
                      result.reason!,
                      screen.contrastFalsePositives,
                    )
                  : result.reason;
              if (reason != null) findings.add(reason);
            }
          } finally {
            // Altijd opruimen, ook als `open` faalt: anders blijft de
            // foutafhandeling omgeleid en hangt de test.
            FlutterError.onError = previous;
            // Timers (polling) stoppen voordat de test eindigt.
            await tester.pumpWidget(const SizedBox.shrink());
            container.dispose();
            debugDefaultTargetPlatformOverride = null;
          }

          if (_shotsDir != null) {
            File('$_shotsDir/$name.txt')
              ..createSync(recursive: true)
              ..writeAsStringSync(findings.join('\n---\n'));
          }
          expect(findings, isEmpty, reason: findings.join('\n'));
        });
      }
    }
  }
}
