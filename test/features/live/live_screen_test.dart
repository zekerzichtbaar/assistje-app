import 'dart:async';

import 'package:assistje/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'live_fixtures.dart';

Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  Map<String, dynamic>? live,
  bool manager = false,
  String sport = 'football',
  int status = 200,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [LiveFixtures.membership(manager: manager, sport: sport)],
    setup: (http) {
      http.on(
        LiveFixtures.get,
        status,
        status == 200
            ? live ?? LiveFixtures.response(canManage: manager)
            : {'message': 'Nee.'},
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

String _text(WidgetTester tester, String key) =>
    tester.widget<Text>(_key(key)).data!;

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _confirm(WidgetTester tester) =>
    _tap(tester, _key('live-confirm-ok'));

/// Laat het scherm los zodat de timers stoppen.
Future<void> _close(WidgetTester tester, ProviderContainer container) async {
  container.read(routerProvider).pop();
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('kijker: scorebord, tijdlijn, meekijkers en volgen', (
    tester,
  ) async {
    final (container, http) = await _open(tester);

    expect(currentTitle(tester), 'Live');
    expect(_text(tester, 'live-home-team'), 'Test Team');
    expect(_text(tester, 'live-away-team'), 'De Buren');
    expect(_text(tester, 'live-home-score'), '1');
    expect(_text(tester, 'live-away-score'), '0');
    expect(_text(tester, 'live-clock'), "12'");
    // Twee helften: de pauze heet rust.
    expect(_text(tester, 'live-period'), 'Rust');
    expect(find.text('6 kijken mee'), findsOneWidget);

    // Tijdlijn uit de API, kaartlabel uit `rules.card_types`.
    for (final key in ['g1834', 's77', 'c1840', 'm1841']) {
      expect(_key('live-item-$key'), findsOneWidget, reason: key);
    }
    expect(
      find.descendant(
        of: _key('live-item-g1834'),
        matching: find.text('Bram Visser'),
      ),
      findsOneWidget,
    );
    expect(find.text('Gele kaart'), findsOneWidget);
    expect(find.text('Paal of lat'), findsOneWidget);
    expect(find.text('🔥 4'), findsOneWidget);

    // Geen bediening voor een kijker.
    expect(_key('live-controls'), findsNothing);
    expect(_key('live-add'), findsNothing);
    expect(_key('live-delete-g1834'), findsNothing);
    expect(_key('live-react-g1834'), findsOneWidget);

    // Volgen.
    http.on(LiveFixtures.post('follow'), 200, {
      'data': {'event_id': 412, 'following_live': true},
    });
    expect(_text(tester, 'live-follow-label'), 'Meldingen aan');
    await _tap(tester, _key('live-follow'));
    expect(http.requestsTo(LiveFixtures.post('follow')), hasLength(1));
    expect(_text(tester, 'live-follow-label'), 'Aan');

    await _close(tester, container);
  });

  testWidgets('reageren via de emoji-kiezer', (tester) async {
    final (container, http) = await _open(
      tester,
      setup: (http) => http.on(LiveFixtures.post('reactions'), 200, {
        'data': {
          'reactions': {
            'c1840': [
              {'emoji': '👏', 'count': 1, 'mine': true},
            ],
          },
        },
      }),
    );

    await _tap(tester, _key('live-react-c1840'));
    expect(_key('live-emoji-👏'), findsOneWidget);
    await _tap(tester, _key('live-emoji-👏'));

    expect(http.requestsTo(LiveFixtures.post('reactions')).single.body, {
      'item_key': 'c1840',
      'emoji': '👏',
    });
    expect(_key('live-reaction-c1840-👏'), findsOneWidget);

    await _close(tester, container);
  });

  testWidgets('pollt elke 12 s zolang live, en stopt als het scherm dicht is', (
    tester,
  ) async {
    final (container, http) = await _open(tester);
    final before = http.requestsTo(LiveFixtures.get).length;

    http.on(LiveFixtures.get, 200, LiveFixtures.response(viewers: 11));
    await tester.pump(const Duration(seconds: 12));
    await tester.pumpAndSettle();
    expect(http.requestsTo(LiveFixtures.get).length, before + 1);
    expect(find.text('11 kijken mee'), findsOneWidget);

    await _close(tester, container);
    final after = http.requestsTo(LiveFixtures.get).length;
    await tester.pump(const Duration(seconds: 30));
    expect(http.requestsTo(LiveFixtures.get).length, after);
  });

  testWidgets('niet live: geen polling', (tester) async {
    final (container, http) = await _open(
      tester,
      live: LiveFixtures.response(
        live: LiveFixtures.clock(isLive: false, seconds: 0),
        homeScore: null,
        awayScore: null,
        goals: const [],
        subs: const [],
        cards: const [],
        moments: const [],
        reactions: const <String, dynamic>{},
      ),
    );
    expect(find.text('NOG NIET BEGONNEN'), findsOneWidget);
    expect(_key('live-follow'), findsNothing);
    expect(_key('live-timeline-empty'), findsOneWidget);

    final before = http.requestsTo(LiveFixtures.get).length;
    await tester.pump(const Duration(seconds: 30));
    expect(http.requestsTo(LiveFixtures.get).length, before);

    await _close(tester, container);
  });

  testWidgets('beheerder voetbal: rust → 2e helft, verwijderen en hervatten', (
    tester,
  ) async {
    final (container, http) = await _open(
      tester,
      manager: true,
      live: LiveFixtures.response(
        canManage: true,
        live: LiveFixtures.clock(seconds: 45 * 60),
      ),
      setup: (http) => http
        ..on(
          LiveFixtures.post('next'),
          200,
          LiveFixtures.response(
            canManage: true,
            live: LiveFixtures.clock(running: true, period: 2, seconds: 2700),
          ),
        )
        ..on(
          'DELETE ${LiveFixtures.event}/cards/1840',
          200,
          LiveFixtures.response(
            canManage: true,
            live: LiveFixtures.clock(running: true, period: 2, seconds: 2700),
            cards: const [],
          ),
        ),
    );

    expect(_key('live-controls'), findsOneWidget);
    expect(_key('live-resume'), findsOneWidget);
    expect(find.text('2e helft vanaf minuut'), findsOneWidget);
    expect(find.text('Start 2e helft'), findsOneWidget);
    expect(_key('live-delete-c1840'), findsOneWidget);
    expect(_key('live-add'), findsOneWidget);

    await _tap(tester, _key('live-next'));
    expect(find.text('Start 2e helft?'), findsOneWidget);
    await _confirm(tester);
    expect(http.requestsTo(LiveFixtures.post('next')).single.body, {
      'minute': 45,
    });
    // Het antwoord staat er meteen: klok loopt in de tweede helft.
    expect(_text(tester, 'live-period'), '2e helft');
    expect(find.text('Rust'), findsOneWidget);
    expect(_key('live-stop'), findsOneWidget);

    await _tap(tester, _key('live-delete-c1840'));
    await _confirm(tester);
    expect(
      http.requestsTo('DELETE ${LiveFixtures.event}/cards/1840'),
      hasLength(1),
    );
    expect(_key('live-item-c1840'), findsNothing);

    await _close(tester, container);
  });

  testWidgets('beheerder hockey: kwarten en kaarten uit de payload', (
    tester,
  ) async {
    final (container, _) = await _open(
      tester,
      manager: true,
      sport: 'hockey',
      live: LiveFixtures.response(
        sport: 'hockey',
        canManage: true,
        rules: LiveFixtures.hockeyRules(),
        live: LiveFixtures.clock(
          running: true,
          period: 2,
          seconds: 20 * 60,
          periodEnds: const [15, 30, 45, 60],
        ),
        cards: [LiveFixtures.card(type: 'green')],
        moments: const [],
      ),
    );

    expect(_text(tester, 'live-period'), '2e kwart');
    expect(_text(tester, 'live-clock'), "20'");
    // Vier delen: de pauze heet pauze.
    expect(find.text('Pauze'), findsOneWidget);
    expect(find.text('Groene kaart'), findsOneWidget);
    expect(_key('live-card-green'), findsOneWidget);

    // Toevoegen: hockey heeft kaarten maar geen momenten.
    await _tap(tester, _key('live-add'));
    expect(find.text('Doelpunt'), findsOneWidget);
    await _tap(tester, find.text('Overige'));
    expect(_key('live-card-type-green'), findsOneWidget);
    expect(_key('live-kind-woodwork'), findsNothing);

    Navigator.of(tester.element(_key('live-add-sheet'))).pop();
    await tester.pumpAndSettle();
    await _close(tester, container);
  });

  testWidgets('beheerder: aftrap met bevestiging', (tester) async {
    final (container, http) = await _open(
      tester,
      manager: true,
      live: LiveFixtures.response(
        canManage: true,
        startsAt: '2099-10-11T14:30:00+02:00',
        live: LiveFixtures.clock(isLive: false, seconds: 0),
        homeScore: null,
        awayScore: null,
        goals: const [],
        subs: const [],
        cards: const [],
        moments: const [],
        reactions: const <String, dynamic>{},
      ),
      setup: (http) => http.on(
        LiveFixtures.post('start'),
        200,
        LiveFixtures.response(
          canManage: true,
          startsAt: '2099-10-11T14:30:00+02:00',
          live: LiveFixtures.clock(seconds: 0),
          homeScore: 0,
          goals: const [],
          subs: const [],
          cards: const [],
          moments: const [],
        ),
      ),
    );

    expect(find.text('Start 1e helft'), findsOneWidget);
    await _tap(tester, _key('live-start'));
    expect(find.text('Aftrap?'), findsOneWidget);
    await _confirm(tester);
    expect(http.requestsTo(LiveFixtures.post('start')).single.body, isNull);
    expect(_key('live-badge'), findsOneWidget);
    expect(_key('live-stop'), findsOneWidget);
    // Per ongeluk gestart (vóór de aftrap, niets vastgelegd): herstellen.
    expect(_key('live-misfire'), findsOneWidget);

    await _close(tester, container);
  });

  testWidgets('beheerder: doelpunt toevoegen met spelerskeuze', (tester) async {
    final (container, http) = await _open(
      tester,
      manager: true,
      setup: (http) => http.on(
        'POST ${LiveFixtures.event}/goals',
        201,
        LiveFixtures.response(
          canManage: true,
          homeScore: 2,
          goals: [
            LiveFixtures.goal(),
            LiveFixtures.goal(id: 1842, scorer: 'Sem de Wit'),
          ],
          createdId: 1842,
        ),
      ),
    );

    await _tap(tester, _key('live-add'));
    expect(_key('live-add-sheet'), findsOneWidget);
    expect(find.text('Goal'), findsOneWidget);

    await _tap(tester, _key('live-pick-scorer'));
    // Met een opstelling: veld en bank apart.
    expect(find.text('OP HET VELD'), findsOneWidget);
    expect(find.text('BANK'), findsOneWidget);
    await _tap(tester, _key('live-player-21'));
    await _tap(tester, _key('live-penalty'));
    await _tap(tester, _key('live-add-submit'));

    expect(http.requestsTo('POST ${LiveFixtures.event}/goals').single.body, {
      'minute': 12,
      'type': 'goal',
      'player_id': 21,
      'assist_player_id': null,
      'penalty': true,
    });
    expect(_key('live-add-sheet'), findsNothing);
    expect(_text(tester, 'live-home-score'), '2');
    expect(_key('live-item-g1842'), findsOneWidget);

    await _close(tester, container);
  });

  testWidgets('afgelopen: speelduur, heropenen en verslag wissen', (
    tester,
  ) async {
    final ended = LiveFixtures.clock(
      isLive: false,
      seconds: 269 * 60,
      endedAt: '2026-10-11T19:00:00+02:00',
      period: 2,
    );
    final (container, http) = await _open(
      tester,
      manager: true,
      live: LiveFixtures.response(canManage: true, live: ended),
      setup: (http) => http.on(
        LiveFixtures.post('duration'),
        200,
        LiveFixtures.response(
          canManage: true,
          live: {...ended, 'accumulated_seconds': 90 * 60},
        ),
      ),
    );

    expect(find.text('WEDSTRIJDVERSLAG'), findsOneWidget);
    expect(find.text('Afgelopen · 269:00'), findsOneWidget);
    expect(_key('live-reopen'), findsOneWidget);
    expect(_key('live-reset'), findsOneWidget);

    await _tap(tester, _key('live-duration'));
    await _tap(tester, _key('live-duration-suggest'));
    await _tap(tester, _key('live-duration-save'));
    expect(http.requestsTo(LiveFixtures.post('duration')).single.body, {
      'minutes': 90,
    });
    expect(find.text('Afgelopen · 90:00'), findsOneWidget);

    await _close(tester, container);
  });

  testWidgets('403: geen toegang', (tester) async {
    final (container, _) = await _open(tester, status: 403);
    expect(_key('live-forbidden'), findsOneWidget);
    expect(find.text('Geen toegang'), findsOneWidget);
    expect(currentTitle(tester), 'Live');
    await _close(tester, container);
  });

  testWidgets('404: live staat uit of hoort niet bij dit team', (tester) async {
    final (container, _) = await _open(tester, status: 404);
    expect(_key('live-not-found'), findsOneWidget);
    expect(find.text('Geen live-stand'), findsOneWidget);
    await _close(tester, container);
  });
}
