import 'dart:async';

import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/live/application/live_controller.dart';
import 'package:assistje/features/live/data/models/live_feed.dart';
import 'package:assistje/features/live/data/models/live_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'live_fixtures.dart';

const LiveKey _key = (teamId: 3, eventId: 412);

/// Een nep-timer: de test vuurt hem zelf af met [FakeTicker.tick].
class FakeTimer implements Timer {
  FakeTimer(this.interval, this.onTick);

  final Duration interval;
  final void Function() onTick;
  bool _active = true;

  @override
  void cancel() => _active = false;

  @override
  bool get isActive => _active;

  @override
  int get tick => 0;
}

class FakeTicker {
  final List<FakeTimer> timers = [];

  Timer call(Duration interval, void Function() onTick) {
    final timer = FakeTimer(interval, onTick);
    timers.add(timer);
    return timer;
  }

  List<FakeTimer> get active => [
    for (final t in timers)
      if (t.isActive) t,
  ];

  /// Vuurt alle actieve timers één keer af en laat de polls uitlopen.
  Future<void> tick() async {
    for (final timer in active) {
      timer.onTick();
    }
    await pumpEventQueue();
  }
}

void main() {
  late TestBackend backend;
  late ProviderContainer container;
  late FakeTicker ticker;

  Future<LiveController> start({
    Map<String, dynamic>? live,
    void Function(FakeHttpAdapter http)? setup,
  }) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    ticker = FakeTicker();
    backend.http.on(
      LiveFixtures.get,
      200,
      live ?? LiveFixtures.response(canManage: true),
    );
    setup?.call(backend.http);
    container = ProviderContainer(
      overrides: [
        ...backend.overrides,
        liveTickerProvider.overrideWithValue(ticker.call),
      ],
      retry: (_, _) => null,
    );
    addTearDown(container.dispose);
    container.listen(liveControllerProvider(_key), (_, _) {});
    await container.read(liveControllerProvider(_key).future);
    return container.read(liveControllerProvider(_key).notifier);
  }

  LiveMatch current() =>
      container.read(liveControllerProvider(_key)).requireValue;

  int gets() => backend.http.requestsTo(LiveFixtures.get).length;

  group('polling', () {
    test('pollt elke 12 s zolang de wedstrijd live is', () async {
      final controller = await start();
      expect(controller.isPolling, isTrue);
      expect(ticker.active.single.interval, const Duration(seconds: 12));
      final before = gets();

      backend.http.on(LiveFixtures.get, 200, LiveFixtures.response(viewers: 9));
      await ticker.tick();
      expect(gets(), before + 1);
      expect(current().liveViewers, 9);
    });

    test('pollt niet als de wedstrijd niet live is', () async {
      final controller = await start(
        live: LiveFixtures.response(
          live: LiveFixtures.clock(isLive: false, seconds: 0),
        ),
      );
      expect(controller.isPolling, isFalse);
      expect(ticker.timers, isEmpty);
    });

    test('stopt na de eindfluit en start na de aftrap', () async {
      final controller = await start(
        setup: (http) => http.on(
          LiveFixtures.post('stop'),
          200,
          LiveFixtures.response(
            live: LiveFixtures.clock(
              isLive: false,
              endedAt: '2026-10-11T16:15:00+02:00',
            ),
          ),
        ),
      );
      expect(controller.isPolling, isTrue);
      expect(await controller.stop(), isNull);
      expect(controller.isPolling, isFalse);
      expect(ticker.active, isEmpty);

      backend.http.on(
        LiveFixtures.post('start'),
        200,
        LiveFixtures.response(live: LiveFixtures.clock(running: true)),
      );
      expect(await controller.start(), isNull);
      expect(controller.isPolling, isTrue);
      expect(ticker.active, hasLength(1));
    });

    test('stopt als de poll laat zien dat de wedstrijd voorbij is', () async {
      final controller = await start();
      backend.http.on(
        LiveFixtures.get,
        200,
        LiveFixtures.response(
          live: LiveFixtures.clock(
            isLive: false,
            endedAt: '2026-10-11T16:15:00+02:00',
          ),
        ),
      );
      await ticker.tick();
      expect(controller.isPolling, isFalse);
      expect(current().clock.isEnded, isTrue);
    });

    test(
      'inactief (achtergrond) pauzeert, terug actief pollt meteen',
      () async {
        final controller = await start();
        final before = gets();
        controller.setActive(false);
        expect(controller.isPolling, isFalse);
        expect(ticker.active, isEmpty);

        controller.setActive(true);
        await pumpEventQueue();
        expect(controller.isPolling, isTrue);
        expect(gets(), before + 1);
      },
    );

    test('stopt wanneer de provider weg is (scherm dicht)', () async {
      await start();
      final timer = ticker.active.single;
      container.dispose();
      expect(timer.isActive, isFalse);
    });

    test('een mislukte poll laat de vorige stand staan', () async {
      await start();
      backend.http.on(LiveFixtures.get, 500, {'message': 'Kapot'});
      await ticker.tick();
      expect(current().liveViewers, 6);
      expect(container.read(liveControllerProvider(_key)).hasError, isFalse);
    });
  });

  group('schrijfacties', () {
    test(
      'een doelpunt zet de stand uit het antwoord neer (geen GET)',
      () async {
        final controller = await start(
          setup: (http) => http.on(
            'POST ${LiveFixtures.event}/goals',
            201,
            LiveFixtures.response(
              canManage: true,
              homeScore: 2,
              goals: [
                LiveFixtures.goal(),
                LiveFixtures.goal(id: 1842, minute: 40),
              ],
              createdId: 1842,
            ),
          ),
        );
        final before = gets();
        final error = await controller.addGoal(minute: 40, playerId: 20);
        expect(error, isNull);
        expect(current().event.homeScore, 2);
        expect(current().goals, hasLength(2));
        expect(gets(), before);
      },
    );

    test('een fout laat de vorige stand staan en geeft de fout', () async {
      final controller = await start(
        setup: (http) => http.on('POST ${LiveFixtures.event}/subs', 422, {
          'message': 'Deze speler staat niet op het veld.',
        }),
      );
      final error = await controller.addSub(
        minute: 60,
        offPlayerId: 20,
        onPlayerId: 21,
      );
      expect(error, isA<ValidationException>());
      expect(current().subs, hasLength(1));
      expect(current().event.homeScore, 1);
    });

    test('verwijderen kiest het pad op soort', () async {
      final controller = await start(
        setup: (http) => http
          ..on(
            'DELETE ${LiveFixtures.event}/cards/1840',
            200,
            LiveFixtures.response(canManage: true, cards: const []),
          ),
      );
      final item = buildLiveFeed(
        current(),
      ).firstWhere((i) => i.kind == LiveFeedKind.card);
      expect(await controller.deleteItem(item), isNull);
      expect(current().cards, isEmpty);
    });

    test('een poll tijdens een schrijfactie wordt overgeslagen', () async {
      final controller = await start(
        setup: (http) => http.on(
          LiveFixtures.post('pause'),
          200,
          LiveFixtures.response(canManage: true, viewers: 3),
        ),
      );
      backend.http.on(
        LiveFixtures.get,
        200,
        LiveFixtures.response(viewers: 99),
      );
      final before = gets();
      final write = controller.pause(minute: 45);
      await ticker.tick();
      expect(await write, isNull);
      expect(gets(), before);
      expect(current().liveViewers, 3);
      expect(backend.http.requestsTo(LiveFixtures.post('pause')).single.body, {
        'minute': 45,
      });
    });
  });

  group('meeleven', () {
    test('volgen is optimistisch en blijft staan', () async {
      final controller = await start(
        setup: (http) => http.on(LiveFixtures.post('follow'), 200, {
          'data': {'event_id': 412, 'following_live': true},
        }),
      );
      final done = controller.toggleFollow();
      expect(current().followingLive, isTrue);
      expect(await done, isNull);
      expect(current().followingLive, isTrue);
    });

    test('ontvolgen dat mislukt draait terug', () async {
      final controller = await start(
        live: LiveFixtures.response(following: true),
        setup: (http) => http.on('DELETE ${LiveFixtures.live}/follow', 500, {
          'message': 'x',
        }),
      );
      final error = await controller.toggleFollow();
      expect(error, isA<ServerException>());
      expect(current().followingLive, isTrue);
    });

    test('reageren: optimistisch, daarna de telling van de server', () async {
      final controller = await start(
        setup: (http) => http.on(LiveFixtures.post('reactions'), 200, {
          'data': {
            'reactions': {
              'g1834': [
                {'emoji': '🔥', 'count': 3, 'mine': false},
                {'emoji': '👏', 'count': 2, 'mine': true},
              ],
            },
          },
        }),
      );
      final done = controller.toggleReaction('g1834', '👏');
      // Optimistisch: je 🔥 gaat eraf, 👏 erbij.
      expect(
        current().reactions['g1834']!.map((r) => (r.emoji, r.count, r.mine)),
        [('🔥', 3, false), ('👏', 1, true)],
      );
      expect(await done, isNull);
      expect(current().reactions['g1834']!.last.count, 2);
    });

    test('reageren dat mislukt draait terug', () async {
      final controller = await start(
        setup: (http) => http.on(LiveFixtures.post('reactions'), 422, {
          'message': 'Reageren kan alleen tijdens de wedstrijd.',
        }),
      );
      final error = await controller.toggleReaction('g1834', '🔥');
      expect(error, isA<ValidationException>());
      expect(current().reactions['g1834']!.single.count, 4);
    });
  });

  group('logica', () {
    test('applyReactionToggle: zelfde emoji haalt je stem weg', () {
      final result = applyReactionToggle(
        {
          'g1': [const LiveReaction(emoji: '🔥', count: 1, mine: true)],
        },
        'g1',
        '🔥',
        const ['🔥', '👏'],
      );
      expect(result.containsKey('g1'), isFalse);
    });

    test('klok-label met blessuretijd en per deel', () {
      const clock = LiveClock(
        isLive: true,
        accumulatedSeconds: 48 * 60 + 5,
        periodEnds: [45, 90],
      );
      final now = DateTime(2026);
      expect(clock.labelAt(now), "45+3'");
      expect(clock.mmssAt(now), '48:05');
      expect(clock.copyWith(period: 2).labelAt(now), "48'");
      expect(clock.copyWith(periodEnds: const []).labelAt(now), "48'");
    });

    test('feed: nieuwste bovenaan, kant en doorlopende stand', () {
      final match = LiveMatch.fromJson(
        LiveFixtures.data(
          awayScore: 1,
          goals: [
            LiveFixtures.goal(),
            LiveFixtures.goal(
              id: 1850,
              minute: 50,
              type: 'opponent_goal',
              scorer: 'De Buren',
              assist: null,
            ),
          ],
        ),
      );
      final feed = buildLiveFeed(match);
      expect(feed.map((i) => i.itemKey), [
        'g1850',
        'm1841',
        'c1840',
        's77',
        'g1834',
      ]);
      expect(feed.first.ours, isFalse);
      expect(feed.first.score, '1 - 1');
      expect(feed.last.score, '1 - 0');
    });
  });
}
