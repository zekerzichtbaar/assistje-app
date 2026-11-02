import 'dart:async';

import 'package:assistje/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import '../event/event_fixtures.dart';
import 'live_fixtures.dart';

// Klok gelijkzetten, verlenging, strafschoppen en momenten van de
// tegenstander (vogels3 `docs/api/v1/live.md`, "Beker beslissen").

const _event = LiveFixtures.event;

Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  required Map<String, dynamic> live,
  bool manager = true,
  String? competition = 'cup',
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [LiveFixtures.membership(manager: manager)],
    setup: (http) {
      http
        ..on(LiveFixtures.get, 200, live)
        ..on(
          'GET $_event',
          200,
          EventFixtures.eventDetail({'competition': competition}),
        );
      setup?.call(http);
    },
  );
  unawaited(container.read(routerProvider).push('/events/412/live'));
  await pumpUntilFound(tester, find.byKey(const ValueKey('live-screen')));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Finder _key(String key) => find.byKey(ValueKey(key));

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _confirm(WidgetTester tester) =>
    _tap(tester, _key('live-confirm-ok'));

Future<void> _close(WidgetTester tester, ProviderContainer container) async {
  container.read(routerProvider).pop();
  await tester.pumpAndSettle();
}

/// Een gelijke (1-1) wedstrijd met de voetbalregels voor de beker.
Map<String, dynamic> _cup({
  required Map<String, dynamic> live,
  bool manager = true,
  List<Map<String, dynamic>>? moments,
}) => LiveFixtures.response(
  canManage: manager,
  rules: LiveFixtures.cupRules(),
  awayScore: 1,
  live: live,
  moments: moments,
);

void main() {
  testWidgets('klok gelijkzetten tijdens de wedstrijd', (tester) async {
    final (container, http) = await _open(
      tester,
      live: LiveFixtures.response(canManage: true),
      setup: (http) => http.on(
        LiveFixtures.post('clock'),
        200,
        LiveFixtures.response(
          canManage: true,
          live: LiveFixtures.clock(seconds: 30 * 60 + 15),
        ),
      ),
    );

    await _tap(tester, _key('live-clock-set'));
    expect(_key('live-clock-sheet'), findsOneWidget);
    // Voorgevuld met de klok (12:00); de klok staat stil.
    expect(find.text('Zet op 12:00'), findsOneWidget);
    expect(find.textContaining('blijft stilstaan'), findsOneWidget);

    await tester.enterText(
      find.descendant(
        of: _key('live-clock-minute'),
        matching: find.byType(TextField),
      ),
      '30',
    );
    await tester.enterText(
      find.descendant(
        of: _key('live-clock-second'),
        matching: find.byType(TextField),
      ),
      '15',
    );
    await tester.pump();
    await _tap(tester, _key('live-clock-save'));

    expect(http.requestsTo(LiveFixtures.post('clock')).single.body, {
      'minute': 30,
      'second': 15,
    });
    expect(tester.widget<Text>(_key('live-clock')).data, "30'");
    await _close(tester, container);
  });

  testWidgets('gelijke beker: verlenging starten en aftrappen', (tester) async {
    final extra = LiveFixtures.clock(
      seconds: 90 * 60,
      period: 2,
      periodEnds: const [45, 90, 105, 120],
      extraTime: true,
    );
    final (container, http) = await _open(
      tester,
      live: _cup(live: LiveFixtures.ended()),
      setup: (http) => http
        ..on(LiveFixtures.post('extra-time'), 200, _cup(live: extra))
        ..on(
          LiveFixtures.post('next'),
          200,
          _cup(
            live: {...extra, 'running': true, 'period': 3, 'started_at': null},
          ),
        ),
    );

    expect(_key('live-decide'), findsOneWidget);
    expect(
      find.text('Gelijk in de beker. Hoe gaat het verder?'),
      findsOneWidget,
    );
    expect(_key('live-shootout-start'), findsOneWidget);

    await _tap(tester, _key('live-extra-time'));
    expect(
      find.text(
        '2 × 15 minuten. De klok staat klaar op 90; je trapt de verlenging '
        'zelf af.',
      ),
      findsOneWidget,
    );
    await _confirm(tester);
    expect(http.requestsTo(LiveFixtures.post('extra-time')), hasLength(1));

    // Op rust aan het einde van de reguliere speeltijd; het volgende deel
    // heet naar de verlenging.
    expect(_key('live-decide'), findsNothing);
    expect(find.text('Verlenging vanaf minuut'), findsOneWidget);
    expect(find.text('Start verlenging'), findsOneWidget);

    await _tap(tester, _key('live-next'));
    await _confirm(tester);
    expect(http.requestsTo(LiveFixtures.post('next')).single.body, {
      'minute': 90,
    });
    expect(tester.widget<Text>(_key('live-period')).data, '1e verlenging');
    await _close(tester, container);
  });

  testWidgets('competitie of geen gelijkspel: niets te beslissen', (
    tester,
  ) async {
    final (container, http) = await _open(
      tester,
      competition: 'league',
      live: _cup(live: LiveFixtures.ended()),
    );
    expect(_key('live-duration'), findsOneWidget);
    expect(_key('live-decide'), findsNothing);
    expect(_key('live-reopen'), findsOneWidget);
    await _close(tester, container);
  });

  testWidgets('strafschoppen bijhouden', (tester) async {
    final shootout = LiveFixtures.ended(
      shootout: LiveFixtures.shootout(us: [true], opp: [false]),
    );
    final (container, http) = await _open(
      tester,
      live: _cup(live: shootout),
      setup: (http) => http
        ..on('POST $_event/shootout/kicks', 201, _cup(live: shootout))
        ..on('DELETE $_event/shootout/kicks/last', 200, _cup(live: shootout))
        ..on('DELETE $_event/shootout', 200, _cup(live: LiveFixtures.ended())),
    );

    expect(_key('live-shootout'), findsOneWidget);
    expect(_key('live-kick-1-scored'), findsOneWidget);
    expect(_key('live-kick-1-missed'), findsOneWidget);
    // Tijdens de serie geen heropenen (en niets meer te beslissen).
    expect(_key('live-reopen'), findsNothing);
    expect(_key('live-decide'), findsNothing);
    expect(tester.widget<Text>(_key('live-period')).data, 'Strafschoppen');

    // Raak voor ons, met de nemer erbij.
    await _tap(tester, _key('live-shooter'));
    await _tap(tester, _key('live-shooter-21'));
    expect(find.text('7 · Sem de Wit'), findsOneWidget);
    await _tap(tester, _key('live-kick-us-scored'));
    // Mis voor de tegenstander: nooit met een speler.
    await _tap(tester, _key('live-kick-opp-missed'));
    expect(http.requestsTo('POST $_event/shootout/kicks').map((r) => r.body), [
      {'side': 'us', 'scored': true, 'player_id': 21},
      {'side': 'opp', 'scored': false, 'player_id': null},
    ]);
    // De nemer is na het schot weer leeg.
    expect(find.text('Nemer (hoeft niet)'), findsOneWidget);

    await _tap(tester, _key('live-shootout-undo'));
    expect(http.requestsTo('DELETE $_event/shootout/kicks/last'), hasLength(1));

    await _tap(tester, _key('live-shootout-clear'));
    expect(
      find.text(
        'Alle schoten gaan weg. De stand van de wedstrijd blijft staan.',
      ),
      findsOneWidget,
    );
    await _confirm(tester);
    expect(http.requestsTo('DELETE $_event/shootout'), hasLength(1));
    expect(_key('live-shootout'), findsNothing);
    expect(_key('live-reopen'), findsOneWidget);
    await _close(tester, container);
  });

  testWidgets('kijker: alleen-lezen bord, winnaar en uitslag', (tester) async {
    final (container, http) = await _open(
      tester,
      manager: false,
      live: _cup(
        manager: false,
        live: LiveFixtures.ended(
          resultSuffix: '4–3 n.s.',
          shootout: LiveFixtures.shootout(
            us: [true, true, true, true],
            opp: [true, true, false, true, false],
            winner: 'us',
          ),
        ),
      ),
    );

    expect(_key('live-shootout'), findsOneWidget);
    expect(
      tester.widget<Text>(_key('live-result-suffix')).data,
      '4–3 na strafschoppen',
    );
    expect(find.text('🏆 Test Team wint na strafschoppen'), findsOneWidget);
    expect(_key('live-kick-panel-us'), findsNothing);
    expect(_key('live-shootout-undo'), findsNothing);
    expect(_key('live-shootout-clear'), findsNothing);
    // Kijkers halen het event-detail niet op voor de competitie.
    expect(http.requestsTo('GET $_event'), isEmpty);
    await _close(tester, container);
  });

  testWidgets('moment van de tegenstander: zonder speler, aan hun kant', (
    tester,
  ) async {
    final opp = LiveFixtures.moment(
      id: 1850,
      type: 'post',
      label: 'Schot op de paal',
      side: 'opp',
      player: 'De Buren',
    );
    final (container, http) = await _open(
      tester,
      live: LiveFixtures.response(
        canManage: true,
        rules: LiveFixtures.cupRules(),
        moments: const [],
      ),
      setup: (http) => http.on(
        'POST $_event/moments',
        201,
        LiveFixtures.response(
          canManage: true,
          rules: LiveFixtures.cupRules(),
          moments: [opp],
          createdId: 1850,
        ),
      ),
    );

    await _tap(tester, _key('live-add'));
    await _tap(tester, find.text('Overige'));
    await _tap(tester, _key('live-kind-post'));
    expect(_key('live-moment-side'), findsOneWidget);
    expect(_key('live-pick-player'), findsOneWidget);
    await _tap(
      tester,
      find.descendant(
        of: _key('live-moment-side'),
        matching: find.text('De Buren'),
      ),
    );
    // Hun namen kennen we niet: geen spelerskeuze.
    expect(_key('live-pick-player'), findsNothing);
    await _tap(tester, _key('live-add-submit'));

    final body =
        http.requestsTo('POST $_event/moments').single.body!
            as Map<String, dynamic>;
    expect(body['type'], 'post');
    expect(body['opponent'], isTrue);
    expect(body.containsKey('player_id'), isFalse);

    // In de tijdlijn aan de kant van de tegenstander (wij thuis = links).
    expect(_key('live-moment-icon-post'), findsOneWidget);
    final row = tester.getCenter(_key('live-item-m1850'));
    expect(
      tester.getCenter(find.text('De Buren').last).dx,
      greaterThan(row.dx),
    );
    await _close(tester, container);
  });
}
