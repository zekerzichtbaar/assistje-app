// Genereert het app-icoon (iOS + Android + Play) en de storebeelden (iPhone
// 6.9", iPad 13", Android-telefoon + Play-featuregraphic) uit de échte app
// met demodata (`demo_data.dart`). Zie docs/store/README.md.
//
//   STORE_OUT=docs/store flutter test test/store --tags store
//
// Zonder STORE_OUT slaat alles zichzelf over (zo draait het niet mee in CI).
// Iconen worden alleen geschreven met STORE_ICONS=1, omdat ze in de
// iOS-/Android-projecten terechtkomen.
//
// Koppen en teksten staan, net als op assistje.nl, in Obviously. Dat is een
// licentiefont dat niet in de repo staat: wijs met STORE_FONT_DIR een map met
// de OTF/TTF-bestanden aan (de gewone breedte; Wide/Extended/Narrow/... worden
// overgeslagen). Zonder STORE_FONT_DIR valt alles terug op Figtree.
//
//   STORE_FONT_DIR=~/Fonts/Obviously STORE_OUT=docs/store \
//     flutter test test/store --tags store
@Tags(['store'])
library;

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
import 'package:image/image.dart' as img;

import '../a11y/hig_harness.dart' show pumpAuditFrames;
import '../helpers/test_app.dart';
import 'demo_data.dart';
import 'store_frames.dart';

final _out = Platform.environment['STORE_OUT'];
final _icons = Platform.environment['STORE_ICONS'] == '1';

/// Een toestel waarop de app wordt gerenderd, en het canvas van het
/// storebeeld.
class _Target {
  const _Target(
    this.dir,
    this.kind,
    this.screen,
    this.ratio,
    this.top,
    this.bottom,
    this.canvas,
    this.canvasRatio,
  );

  final String dir;
  final DeviceKind kind;
  final Size screen;
  final double ratio;
  final double top;
  final double bottom;

  /// Logisch canvas × [canvasRatio] = de exacte storemaat.
  final Size canvas;
  final double canvasRatio;

  TargetPlatform get platform =>
      kind == DeviceKind.android ? TargetPlatform.android : TargetPlatform.iOS;
}

const _targets = [
  // App Store: 6.9" iPhone, 1320 × 2868.
  _Target(
    'ios/iphone-6.9',
    DeviceKind.iphone,
    Size(440, 956),
    3,
    62,
    34,
    Size(440, 956),
    3,
  ),
  // App Store: 6.3" iPhone (verplichte "medium display"), 1206 × 2622.
  _Target(
    'ios/iphone-6.3',
    DeviceKind.iphone,
    Size(402, 874),
    3,
    62,
    34,
    Size(402, 874),
    3,
  ),
  // App Store: 13" iPad, 2064 × 2752.
  _Target(
    'ios/ipad-13',
    DeviceKind.ipad,
    Size(1032, 1376),
    2,
    24,
    20,
    Size(1032, 1376),
    2,
  ),
  // Google Play: telefoon 9:16, 1080 × 1920.
  _Target(
    'android/phone',
    DeviceKind.android,
    Size(412, 915),
    2.625,
    40,
    24,
    Size(360, 640),
    3,
  ),
];

/// Eén storebeeld: het scherm en wie er kijkt (trainer of speler).
class _Shot {
  const _Shot(this.slide, this.path, {this.trainer = false});

  final StoreSlide slide;
  final String path;
  final bool trainer;
}

final _shots = [
  const _Shot(
    StoreSlide(
      name: '01-agenda',
      headline: 'Je hele team\nin *één app*',
      sub: 'Wedstrijden, trainingen en wie er komt',
      backdrop: Backdrop.field,
      mascot: true,
    ),
    '/agenda',
  ),
  const _Shot(
    StoreSlide(
      name: '02-aanwezigheid',
      headline: 'Aanmelden?\n*Eén tik.*',
      sub: 'Zie meteen wie er zijn en wie niet',
      backdrop: Backdrop.sand,
    ),
    '/events/412',
  ),
  const _Shot(
    StoreSlide(
      name: '03-opstelling',
      headline: 'Opstelling\n*klaar in 1 minuut*',
      sub: 'Sleep spelers op het veld en deel hem',
      backdrop: Backdrop.field,
      lightStatusBar: true,
    ),
    '/events/412/lineup',
    trainer: true,
  ),
  const _Shot(
    StoreSlide(
      name: '04-live',
      headline: 'Volg elke\nwedstrijd *live*',
      sub: 'Stand, goals en wissels, ook als je er niet bent',
      backdrop: Backdrop.sand,
    ),
    '/events/412/live',
  ),
  const _Shot(
    StoreSlide(
      name: '05-statistieken',
      headline: 'Wie wordt\n*topscorer?*',
      sub: 'Goals, assists, speelminuten en opkomst',
      backdrop: Backdrop.field,
    ),
    '/stats',
  ),
  const _Shot(
    StoreSlide(
      name: '06-poule',
      headline: 'Altijd de\n*actuele stand*',
      sub: 'Uitslagen en programma van je poule',
      backdrop: Backdrop.sand,
    ),
    '/poule',
  ),
  const _Shot(
    StoreSlide(
      name: '07-boetepot',
      headline: 'Boetepot?\n*Geregeld.*',
      sub: 'Boetes, spaarpot en diensten zonder gedoe',
      backdrop: Backdrop.field,
      mascot: true,
    ),
    '/fines',
  ),
];

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
  await _loadBrandFont();
}

/// Laadt Obviously uit STORE_FONT_DIR: Regular als [Brand.font], Bold als
/// [Brand.fontBold]. Eén familie per gewicht, omdat de testengine bij
/// meerdere bestanden in één familie niet betrouwbaar het juiste kiest.
Future<void> _loadBrandFont() async {
  final raw = Platform.environment['STORE_FONT_DIR'];
  if (raw == null || raw.isEmpty) {
    stderr.writeln('STORE_FONT_DIR niet gezet: storebeelden in Figtree.');
    return;
  }
  final dir = Directory(
    raw.replaceFirst(RegExp(r'^~'), Platform.environment['HOME'] ?? '~'),
  );
  File? find(RegExp style) {
    for (final f in dir.listSync().whereType<File>()) {
      final name = f.uri.pathSegments.last;
      final m = RegExp(
        // Alleen de gewone breedte: niet Comp/Cond/Narrow/Wide/Extd/Demo.
        r'^obviously[-_ ]([a-z]*)\.(otf|ttf)$',
        caseSensitive: false,
      ).firstMatch(name);
      if (m != null && style.hasMatch(m.group(1)!)) return f;
    }
    return null;
  }

  final fonts = {
    Brand.font: find(RegExp(r'^(regular|roman|book|)$', caseSensitive: false)),
    Brand.fontBold: find(RegExp(r'^bold$', caseSensitive: false)),
  };
  for (final MapEntry(key: family, value: file) in fonts.entries) {
    if (file == null) {
      throw StateError('Obviously ($family) niet gevonden in ${dir.path}');
    }
    await (FontLoader(family)
          ..addFont(Future.value(ByteData.sublistView(file.readAsBytesSync()))))
        .load();
  }
}

final _boundary = GlobalKey();

Future<ui.Image> _capture(WidgetTester tester, double ratio) async {
  final boundary =
      _boundary.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  return (await tester.runAsync(() => boundary.toImage(pixelRatio: ratio)))!;
}

/// PNG zonder alfakanaal (App Store weigert alfa in icoon en screenshots;
/// Play wil de featuregraphic als 24-bit).
Future<void> _write(
  WidgetTester tester,
  ui.Image image,
  String path, {
  bool alpha = false,
  int? width,
}) async {
  await tester.runAsync(() async {
    final data = await image.toByteData();
    var decoded = img.Image.fromBytes(
      width: image.width,
      height: image.height,
      bytes: data!.buffer,
      numChannels: 4,
    );
    if (!alpha) decoded = decoded.convert(numChannels: 3);
    // Supersampling: groot gerenderd, netjes verkleind (scherper dan de
    // engine een groot schermbeeld klein tekent).
    if (width != null && width != decoded.width) {
      decoded = img.copyResize(
        decoded,
        width: width,
        interpolation: img.Interpolation.average,
      );
    }
    File(path)
      ..createSync(recursive: true)
      ..writeAsBytesSync(img.encodePng(decoded, level: 9));
  });
}

void _setView(WidgetTester tester, Size size, double ratio, {double top = 0}) {
  tester.view
    ..physicalSize = size * ratio
    ..devicePixelRatio = ratio
    ..padding = FakeViewPadding(top: top * ratio)
    ..viewPadding = FakeViewPadding(top: top * ratio);
}

/// Rendert de app op [target] op [path] en geeft het scherm terug.
Future<ui.Image> _renderApp(
  WidgetTester tester,
  _Target target,
  String path, {
  bool trainer = false,
}) async {
  debugDefaultTargetPlatformOverride = target.platform;
  tester.view
    ..physicalSize = target.screen * target.ratio
    ..devicePixelRatio = target.ratio
    ..padding = FakeViewPadding(
      top: target.top * target.ratio,
      bottom: target.bottom * target.ratio,
    )
    ..viewPadding = FakeViewPadding(
      top: target.top * target.ratio,
      bottom: target.bottom * target.ratio,
    );
  final backend = TestBackend(token: '12|abc');
  await backend.init();
  demoRoutes(backend.http, trainer: trainer);
  final container = backend.container();
  try {
    await tester.pumpWidget(
      RepaintBoundary(
        key: _boundary,
        child: UncontrolledProviderScope(
          container: container,
          child: const AssistjeApp(),
        ),
      ),
    );
    await pumpAuditFrames(tester);
    container.read(routerProvider).go(path);
    await pumpAuditFrames(tester);
    return await _capture(tester, target.ratio);
  } finally {
    await tester.pumpWidget(const SizedBox.shrink());
    container.dispose();
    debugDefaultTargetPlatformOverride = null;
  }
}

Widget _canvas(Widget child) => Directionality(
  textDirection: TextDirection.ltr,
  child: MediaQuery(
    data: const MediaQueryData(),
    child: RepaintBoundary(key: _boundary, child: child),
  ),
);

void main() {
  final skip = _out == null ? 'STORE_OUT niet gezet' : null;
  setUpAll(_loadFonts);
  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
  });

  group('icoon', skip: skip ?? (_icons ? null : 'STORE_ICONS niet gezet'), () {
    Future<void> render(
      WidgetTester tester,
      int px,
      String path, {
      bool rounded = false,
      bool alpha = false,
      double mascot = 0.68,
    }) async {
      _setView(tester, Size.square(px.toDouble()), 1);
      await tester.pumpWidget(
        _canvas(AppIconArt(rounded: rounded, mascotHeight: mascot)),
      );
      await _write(tester, await _capture(tester, 1), path, alpha: alpha);
    }

    testWidgets('iOS AppIcon.appiconset', (tester) async {
      const dir = 'ios/Runner/Assets.xcassets/AppIcon.appiconset';
      final contents =
          jsonDecode(File('$dir/Contents.json').readAsStringSync())
              as Map<String, dynamic>;
      final files = <String, int>{};
      for (final image
          in (contents['images'] as List).cast<Map<String, dynamic>>()) {
        final points = double.parse((image['size'] as String).split('x')[0]);
        final scale = int.parse((image['scale'] as String).replaceAll('x', ''));
        files[image['filename'] as String] = (points * scale).round();
      }
      for (final f in files.entries) {
        await render(tester, f.value, '$dir/${f.key}');
      }
      tester.view.reset();
    });

    testWidgets('Android mipmaps + Play-icoon', (tester) async {
      const res = 'android/app/src/main/res';
      const densities = {
        'mdpi': 48,
        'hdpi': 72,
        'xhdpi': 96,
        'xxhdpi': 144,
        'xxxhdpi': 192,
      };
      for (final d in densities.entries) {
        await render(
          tester,
          d.value,
          '$res/mipmap-${d.key}/ic_launcher.png',
          rounded: true,
          alpha: true,
          mascot: 0.64,
        );
      }
      // Play rondt zelf af: vol vierkant, 512 × 512.
      await render(tester, 512, '$_out/android/icon-512.png');
      tester.view.reset();
    });
  });

  for (final target in _targets) {
    group(target.dir, skip: skip, () {
      for (final shot in _shots) {
        testWidgets(shot.slide.name, (tester) async {
          final screen = await _renderApp(
            tester,
            target,
            shot.path,
            trainer: shot.trainer,
          );
          _setView(tester, target.canvas, target.canvasRatio);
          await tester.pumpWidget(
            _canvas(
              StoreFrame(
                slide: shot.slide,
                screen: screen,
                screenSize: target.screen,
                kind: target.kind,
                topInset: target.top,
              ),
            ),
          );
          await tester.pump();
          await _write(
            tester,
            await _capture(tester, target.canvasRatio),
            '$_out/${target.dir}/${shot.slide.name}.png',
          );
          tester.view.reset();
        });
      }
    });
  }

  testWidgets('Play-featuregraphic', skip: skip != null, (tester) async {
    final iphone = _targets.first;
    final screen = await _renderApp(tester, iphone, '/agenda');
    // Op 3× renderen en terugschalen naar 1024 × 500: anders wordt het
    // telefoonscherm wazig.
    _setView(tester, const Size(1024, 500), 3);
    await tester.pumpWidget(
      _canvas(
        FeatureGraphic(
          screen: screen,
          screenSize: iphone.screen,
          topInset: iphone.top,
        ),
      ),
    );
    await tester.pump();
    await _write(
      tester,
      await _capture(tester, 3),
      '$_out/android/feature-graphic-1024x500.png',
      width: 1024,
    );
    tester.view.reset();
  });
}
