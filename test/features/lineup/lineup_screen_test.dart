import 'dart:async';

import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/features/lineup/presentation/widgets/field_painters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'lineup_fixtures.dart';

Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  Map<String, dynamic>? lineup,
  bool editor = true,
  String variant = 'football',
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [LineupFixtures.membership(editor: editor, variant: variant)],
    setup: (http) {
      http
        ..on(
          LineupFixtures.get,
          200,
          lineup ?? LineupFixtures.response(variant: variant),
        )
        ..routes[LineupFixtures.patch] = LineupFixtures.echoSave(
          variant: variant,
        );
      setup?.call(http);
    },
  );
  unawaited(container.read(routerProvider).push('/events/412/lineup'));
  await pumpUntilFound(tester, find.byKey(const ValueKey('lineup-screen')));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Finder _key(String key) => find.byKey(ValueKey(key));

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Lang genoeg vasthouden dat de [LongPressDraggable] meekomt, dan slepen.
Future<void> _drag(WidgetTester tester, Finder from, Finder to) async {
  final gesture = await tester.startGesture(tester.getCenter(from));
  await tester.pump(const Duration(milliseconds: 300));
  final target = tester.getCenter(to);
  await gesture.moveTo(target - const Offset(4, 4));
  await tester.pump();
  await gesture.moveTo(target);
  await tester.pump();
  await gesture.up();
  await tester.pumpAndSettle();
}

List<Object?> _patchSlots(FakeHttpAdapter http) =>
    ((http.requestsTo(LineupFixtures.patch).last.body! as Map)['slots'] as List)
        .map((s) => '${(s as Map)['slot_code']}:${s['player_id']}')
        .toList();

void main() {
  // Eén widgettest per veldvariant: veld getekend door de juiste painter,
  // posities op de x/y-procenten uit `formation_slots`.
  final sports = <String, (Type, String, List<(String, int)>)>{
    'football': (FootballFieldPainter, 'football-pitch', [('GK', 11)]),
    'hockey': (HockeyFieldPainter, 'hockey-field', [('GK', 11)]),
    'korfball': (KorfballFieldPainter, 'korfball-field', [('A1', 37)]),
    'volleyball': (VolleyballFieldPainter, 'volleyball-court', [('P1', 37)]),
  };

  for (final MapEntry(key: variant, value: (type, painterKey, slots))
      in sports.entries) {
    testWidgets('$variant: veld en posities uit de API', (tester) async {
      await _open(
        tester,
        variant: variant,
        lineup: LineupFixtures.response(
          variant: variant,
          slots: slots,
          captain: null,
        ),
      );

      expect(currentTitle(tester), 'Opstelling');
      final field = _key('lineup-field-$painterKey');
      expect(field, findsOneWidget);
      expect(tester.widget<CustomPaint>(field).painter.runtimeType, type);

      final rect = tester.getRect(field);
      final formation =
          LineupFixtures.formationsByVariant[variant]!.values.first;
      for (final slot in formation) {
        final center = tester.getCenter(_key('lineup-slot-${slot['code']}'));
        expect(
          center.dx,
          moreOrLessEquals(
            rect.left + rect.width * (slot['x'] as int) / 100,
            epsilon: 1,
          ),
          reason: '${slot['code']} x',
        );
        expect(
          center.dy,
          moreOrLessEquals(
            rect.top + rect.height * (slot['y'] as int) / 100,
            epsilon: 1,
          ),
          reason: '${slot['code']} y',
        );
      }
      // De speler staat op zijn plek; lege plekken tonen het API-label.
      final (code, playerId) = slots.single;
      expect(
        find.descendant(
          of: _key('lineup-slot-$code'),
          matching: _key('lineup-player-$playerId'),
        ),
        findsOneWidget,
      );
      final empty = formation.firstWhere((s) => s['code'] != code);
      expect(
        find.descendant(
          of: _key('lineup-slot-${empty['code']}'),
          matching: find.text(empty['label'] as String),
        ),
        findsOneWidget,
      );
      // Formatiekiezer met de labels uit de API.
      for (final label in LineupFixtures.formationLabels[variant]!.values) {
        expect(find.text(label), findsOneWidget);
      }
    });
  }

  testWidgets('onbekende veldvariant: neutraal veld', (tester) async {
    await _open(
      tester,
      variant: 'handball',
      lineup: LineupFixtures.response(variant: 'handball'),
    );
    final field = _key('lineup-field-neutral');
    expect(field, findsOneWidget);
    expect(
      tester.widget<CustomPaint>(field).painter,
      isA<NeutralFieldPainter>(),
    );
    expect(_key('lineup-slot-GK'), findsOneWidget);
  });

  testWidgets('bank toont positienamen uit het sportprofiel en gasten', (
    tester,
  ) async {
    await _open(tester);
    expect(find.text('BANK (2)'), findsOneWidget);
    expect(
      find.descendant(
        of: _key('lineup-bench-player-60'),
        matching: find.text('Centrale verdediger'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: _key('lineup-bench-player-52'),
        matching: find.text('Gast · JO19-2'),
      ),
      findsOneWidget,
    );
    expect(_key('lineup-filled'), findsOneWidget);
    expect(find.text('2/6'), findsOneWidget);
  });

  testWidgets('kijkstand: gedeelde opstelling zonder bewerkknoppen', (
    tester,
  ) async {
    await _open(
      tester,
      editor: false,
      lineup: LineupFixtures.response(
        canEdit: false,
        publishedAt: '2026-10-11T19:02:11+02:00',
      ),
    );

    expect(find.text('WISSELSPELERS (2)'), findsOneWidget);
    expect(find.text('1-4-3-3'), findsOneWidget);
    expect(_key('lineup-formations'), findsNothing);
    expect(_key('lineup-share'), findsNothing);
    expect(_key('lineup-captain-badge'), findsOneWidget);
    // Lege plekken zijn in kijkstand gewoon gras.
    expect(find.text('CV'), findsNothing);
    expect(find.byType(DragTarget<Object>), findsNothing);

    // Tikken doet niets (geen selectie, geen verzoek).
    await _tap(tester, _key('lineup-player-37'));
    expect(_key('lineup-captain-toggle'), findsNothing);
  });

  testWidgets('403: nog niet gedeeld', (tester) async {
    await _open(
      tester,
      editor: false,
      setup: (http) => http.on(LineupFixtures.get, 403, {'message': 'Nee.'}),
    );
    expect(_key('lineup-not-shared'), findsOneWidget);
    expect(find.text('Nog niet gedeeld'), findsOneWidget);
    expect(currentTitle(tester), 'Opstelling');
  });

  testWidgets('404: ander team', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(LineupFixtures.get, 404, {'message': 'Nee.'}),
    );
    expect(_key('lineup-not-found'), findsOneWidget);
  });

  testWidgets('laadfout met opnieuw proberen', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(LineupFixtures.get, 500, {'message': 'Kapot.'}),
    );
    expect(_key('lineup-error'), findsOneWidget);

    http.on(LineupFixtures.get, 200, LineupFixtures.response());
    await _tap(tester, _key('lineup-retry'));
    expect(_key('lineup-field-football-pitch'), findsOneWidget);
  });

  testWidgets('slepen: bank → positie slaat op', (tester) async {
    final (_, http) = await _open(tester);

    await _drag(tester, _key('lineup-bench-player-60'), _key('lineup-slot-CB'));

    expect(_patchSlots(http), ['GK:11', 'CB:60', 'ST:37']);
    expect(
      find.descendant(
        of: _key('lineup-slot-CB'),
        matching: _key('lineup-player-60'),
      ),
      findsOneWidget,
    );
    expect(_key('lineup-bench-player-60'), findsNothing);
    expect(find.text('opgeslagen'), findsOneWidget);
  });

  testWidgets('slepen: positie → positie ruilt', (tester) async {
    final (_, http) = await _open(tester);
    await _drag(tester, _key('lineup-player-11'), _key('lineup-slot-ST'));
    expect(_patchSlots(http), ['GK:37', 'ST:11']);
  });

  testWidgets('slepen: veld → bank haalt van het veld', (tester) async {
    final (_, http) = await _open(tester);
    await _drag(tester, _key('lineup-player-11'), _key('lineup-bench'));
    expect(_patchSlots(http), ['ST:37']);
    expect(_key('lineup-bench-player-11'), findsOneWidget);
  });

  testWidgets('tikken: bankspeler oppakken en op een positie zetten', (
    tester,
  ) async {
    final (_, http) = await _open(tester);

    await _tap(tester, _key('lineup-bench-player-52'));
    expect(find.text('tik op een positie'), findsOneWidget);

    await _tap(tester, _key('lineup-slot-LB'));
    expect(_patchSlots(http), ['GK:11', 'LB:52', 'ST:37']);
  });

  testWidgets('C geven via de aangetikte kaart; verwijderknop', (tester) async {
    final (_, http) = await _open(tester);

    await _tap(tester, _key('lineup-player-11'));
    await _tap(tester, _key('lineup-captain-toggle'));
    expect(
      (http.requestsTo(LineupFixtures.patch).last.body!
          as Map)['captain_player_id'],
      11,
    );

    // De kaart blijft aangetikt: de verwijderknop staat er nog.
    await _tap(tester, _key('lineup-remove-11'));
    expect(_patchSlots(http), ['ST:37']);
  });

  testWidgets('opslaan mislukt: toast en veld terug', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) =>
          http.on(LineupFixtures.patch, 500, {'message': 'Server kapot.'}),
    );
    await _drag(tester, _key('lineup-bench-player-60'), _key('lineup-slot-CB'));
    expect(find.text('Opslaan mislukt'), findsOneWidget);
    expect(find.text('Server kapot.'), findsOneWidget);
    expect(_key('lineup-bench-player-60'), findsOneWidget);
    expect(http.requestsTo(LineupFixtures.patch), hasLength(1));
  });

  testWidgets('formatie wisselen', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        LineupFixtures.formation,
        200,
        LineupFixtures.response(formation: '4-4-2'),
      ),
    );
    await _tap(tester, _key('lineup-formation-4-4-2'));

    expect(http.requestsTo(LineupFixtures.formation).single.body, {
      'formation': '4-4-2',
    });
    expect(_key('lineup-slot-LS'), findsOneWidget);
    expect(_key('lineup-slot-LB'), findsNothing);
  });

  testWidgets('delen met bevestiging', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        LineupFixtures.publish,
        200,
        LineupFixtures.response(publishedAt: '2026-10-11T19:02:11+02:00'),
      ),
    );
    expect(find.text('Deel met het team'), findsOneWidget);

    await _tap(tester, _key('lineup-share'));
    expect(find.text('Opstelling delen?'), findsOneWidget);
    await _tap(tester, _key('lineup-share-confirm'));

    expect(http.requestsTo(LineupFixtures.publish), hasLength(1));
    expect(find.text('Opstelling gedeeld'), findsOneWidget);
    expect(find.text('Gedeeld met het team'), findsOneWidget);
    expect(_key('lineup-share-status'), findsOneWidget);
  });

  testWidgets('delen annuleren stuurt niets', (tester) async {
    final (_, http) = await _open(tester);
    await _tap(tester, _key('lineup-share'));
    await _tap(tester, _key('lineup-share-cancel'));
    expect(http.requestsTo(LineupFixtures.publish), isEmpty);
  });

  testWidgets('delen 422: toast met de boodschap van de server', (
    tester,
  ) async {
    await _open(
      tester,
      setup: (http) => http.on(LineupFixtures.publish, 422, {
        'message': 'Er staat nog niemand in de opstelling.',
      }),
    );
    await _tap(tester, _key('lineup-share'));
    await _tap(tester, _key('lineup-share-confirm'));

    expect(find.text('Delen mislukt'), findsOneWidget);
    expect(find.text('Er staat nog niemand in de opstelling.'), findsOneWidget);
    expect(find.text('Deel met het team'), findsOneWidget);
  });

  testWidgets('aangepast na delen: "Opnieuw delen"', (tester) async {
    await _open(
      tester,
      lineup: LineupFixtures.response(
        publishedAt: '2026-10-11T19:02:11+02:00',
        changed: true,
      ),
    );
    expect(find.text('Opnieuw delen'), findsOneWidget);
    expect(
      find.text(
        'Aangepast na het delen. Het team ziet nog de oude opstelling.',
      ),
      findsOneWidget,
    );
    await _tap(tester, _key('lineup-share'));
    expect(find.text('Opnieuw delen?'), findsOneWidget);
  });

  testWidgets('leeg veld: delen kan niet', (tester) async {
    await _open(
      tester,
      lineup: LineupFixtures.response(slots: const [], captain: null),
    );
    await _tap(tester, _key('lineup-share'));
    expect(find.text('Opstelling delen?'), findsNothing);
  });
}
