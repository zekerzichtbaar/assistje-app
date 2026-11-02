import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/live/data/live_repository.dart';
import 'package:assistje/features/live/data/models/live_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';
import 'live_fixtures.dart';

void main() {
  late TestBackend backend;
  late ProviderContainer container;
  late LiveRepository repository;

  setUp(() async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    container = backend.container();
    addTearDown(container.dispose);
    repository = container.read(liveRepositoryProvider);
  });

  Object? lastBody(String route) => backend.http.requestsTo(route).single.body;

  test('haalt de live-stand op en leest alle velden', () async {
    backend.http.on(
      LiveFixtures.get,
      200,
      LiveFixtures.response(canManage: true, following: true),
    );

    final match = await repository.fetch(3, 412);

    expect(match.sport, 'football');
    expect(match.event.homeTeam, 'Test Team');
    expect(match.event.homeScore, 1);
    expect(match.event.weAreHome, isTrue);
    expect(match.clock.isLive, isTrue);
    expect(match.clock.accumulatedSeconds, 720);
    expect(match.clock.periodEnds, [45, 90]);
    expect(match.rules.periods?.label, 'Helft');
    expect(match.rules.cardTypes.map((c) => c.type), ['yellow', 'red']);
    expect(match.rules.momentTypes, hasLength(3));
    expect(match.goals.single.itemKey, 'g1834');
    expect(match.goals.single.assist, 'Sem de Wit');
    expect(match.subs.single.on, 'Sem de Wit');
    expect(match.cards.single.type, 'yellow');
    expect(match.moments.single.label, 'Paal of lat');
    expect(match.reactions['g1834']!.single.mine, isTrue);
    expect(match.reactionEmoji, hasLength(6));
    expect(match.liveViewers, 6);
    expect(match.followingLive, isTrue);
    expect(match.canManage, isTrue);
    expect(match.pickers!.hasLineup, isTrue);
    expect(match.pickers!.onField.map((p) => p.id), [21]);
    expect(match.pickers!.bench.map((p) => p.id), [20]);
    expect(match.cardLabel('red'), 'Rode kaart');
  });

  test('lege reacties als PHP-array en zonder pickers', () async {
    backend.http.on(
      LiveFixtures.get,
      200,
      LiveFixtures.response(reactions: const <Object>[]),
    );
    final match = await repository.fetch(3, 412);
    expect(match.reactions, isEmpty);
    expect(match.pickers, isNull);
  });

  test('404 (feature uit) en 403 komen als ApiException', () async {
    backend.http.on(LiveFixtures.get, 404, {'message': 'Not found.'});
    await expectLater(
      repository.fetch(3, 412),
      throwsA(isA<NotFoundException>()),
    );
    backend.http.on(LiveFixtures.get, 403, {'message': 'Geen lid.'});
    await expectLater(
      repository.fetch(3, 412),
      throwsA(isA<ForbiddenException>()),
    );
  });

  group('meeleven', () {
    test('volgen: POST follow zonder body', () async {
      backend.http.on(LiveFixtures.post('follow'), 200, {
        'data': {'event_id': 412, 'following_live': true},
      });
      expect(await repository.follow(3, 412), isTrue);
      expect(lastBody(LiveFixtures.post('follow')), isNull);
    });

    test('ontvolgen: DELETE follow (204)', () async {
      backend.http.on('DELETE ${LiveFixtures.live}/follow', 204);
      await repository.unfollow(3, 412);
      expect(
        backend.http.requestsTo('DELETE ${LiveFixtures.live}/follow'),
        hasLength(1),
      );
    });

    test('reageren: POST reactions met item_key + emoji', () async {
      backend.http.on(LiveFixtures.post('reactions'), 200, {
        'data': {
          'reactions': {
            'g1834': [
              {'emoji': '🔥', 'count': 4, 'mine': true},
              {'emoji': '👏', 'count': 1, 'mine': false},
            ],
          },
        },
      });
      final reactions = await repository.react(
        3,
        412,
        itemKey: 'g1834',
        emoji: '🔥',
      );
      expect(lastBody(LiveFixtures.post('reactions')), {
        'item_key': 'g1834',
        'emoji': '🔥',
      });
      expect(reactions['g1834']!.map((r) => r.emoji), ['🔥', '👏']);
    });
  });

  group('klok', () {
    final cases =
        <String, (Future<LiveMatch> Function(LiveRepository), Object?)>{
          'start': ((r) => r.start(3, 412), null),
          'start vanaf minuut': (
            (r) => r.start(3, 412, minute: 3),
            {'minute': 3},
          ),
          'pause': (
            (r) => r.pause(3, 412, minute: 45, trim: true),
            {'minute': 45, 'trim': true},
          ),
          'resume': ((r) => r.resume(3, 412), null),
          'next': ((r) => r.next(3, 412, minute: 45), {'minute': 45}),
          'stop': ((r) => r.stop(3, 412), null),
          'reopen': ((r) => r.reopen(3, 412), null),
          'duration': ((r) => r.duration(3, 412, 92), {'minutes': 92}),
          'reset': ((r) => r.reset(3, 412), null),
        };
    for (final MapEntry(key: name, value: (call, body)) in cases.entries) {
      test('$name: POST …/live/${name.split(' ').first}', () async {
        final action = name.split(' ').first;
        backend.http.on(
          LiveFixtures.post(action),
          200,
          LiveFixtures.response(homeScore: 2),
        );
        final match = await call(repository);
        expect(match.event.homeScore, 2);
        final requests = backend.http.requestsTo(LiveFixtures.post(action));
        expect(requests, hasLength(1));
        expect(requests.single.body, body);
      });
    }
  });

  group('tijdlijn', () {
    const event = LiveFixtures.event;

    test('doelpunt met assist en strafschop', () async {
      backend.http.on(
        'POST $event/goals',
        201,
        LiveFixtures.response(homeScore: 2, createdId: 1842),
      );
      final match = await repository.addGoal(
        3,
        412,
        minute: 12,
        playerId: 20,
        assistPlayerId: 21,
        penalty: true,
      );
      expect(match.event.homeScore, 2);
      expect(lastBody('POST $event/goals'), {
        'minute': 12,
        'type': 'goal',
        'player_id': 20,
        'assist_player_id': 21,
        'penalty': true,
      });
    });

    test('eigen doelpunt: geen assist, geen strafschop', () async {
      backend.http.on('POST $event/goals', 201, LiveFixtures.response());
      await repository.addGoal(
        3,
        412,
        minute: 50,
        playerId: 21,
        ownGoal: true,
        assistPlayerId: 20,
        penalty: true,
      );
      expect(lastBody('POST $event/goals'), {
        'minute': 50,
        'type': 'own_goal',
        'player_id': 21,
        'assist_player_id': null,
        'penalty': false,
      });
    });

    test('tegendoelpunt toevoegen en het laatste weghalen', () async {
      backend.http
        ..on('POST $event/opponent-goal', 201, LiveFixtures.response())
        ..on('DELETE $event/opponent-goal', 200, LiveFixtures.response());
      await repository.addOpponentGoal(3, 412, minute: 20);
      expect(lastBody('POST $event/opponent-goal'), {'minute': 20});
      await repository.deleteLastOpponentGoal(3, 412);
      expect(lastBody('DELETE $event/opponent-goal'), isNull);
    });

    test('kaart, moment en wissel', () async {
      backend.http
        ..on('POST $event/cards', 201, LiveFixtures.response())
        ..on('POST $event/moments', 201, LiveFixtures.response())
        ..on('POST $event/subs', 201, LiveFixtures.response());
      await repository.addCard(
        3,
        412,
        minute: 33,
        type: 'yellow',
        playerId: 21,
      );
      await repository.addMoment(3, 412, minute: 35, type: 'woodwork');
      await repository.addSub(
        3,
        412,
        minute: 60,
        offPlayerId: 20,
        onPlayerId: 21,
      );
      expect(lastBody('POST $event/cards'), {
        'minute': 33,
        'type': 'yellow',
        'player_id': 21,
      });
      expect(lastBody('POST $event/moments'), {
        'minute': 35,
        'type': 'woodwork',
        'player_id': null,
      });
      expect(lastBody('POST $event/subs'), {
        'minute': 60,
        'off_player_id': 20,
        'on_player_id': 21,
      });
    });

    test('verwijderen per soort', () async {
      final routes = [
        'DELETE $event/goals/1834',
        'DELETE $event/cards/1840',
        'DELETE $event/moments/1841',
        'DELETE $event/subs/77',
      ];
      for (final route in routes) {
        backend.http.on(route, 200, LiveFixtures.response(homeScore: 0));
      }
      await repository.deleteGoal(3, 412, 1834);
      await repository.deleteCard(3, 412, 1840);
      await repository.deleteMoment(3, 412, 1841);
      await repository.deleteSub(3, 412, 77);
      for (final route in routes) {
        expect(backend.http.requestsTo(route), hasLength(1), reason: route);
      }
    });

    test('422 komt als ValidationException met de melding', () async {
      backend.http.on('POST $event/subs', 422, {
        'message': 'Deze speler staat niet op het veld.',
        'errors': {
          'off_player_id': ['Deze speler staat niet op het veld.'],
        },
      });
      await expectLater(
        repository.addSub(3, 412, minute: 1, offPlayerId: 20, onPlayerId: 21),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.message,
            'message',
            'Deze speler staat niet op het veld.',
          ),
        ),
      );
    });
  });

  group('beker beslissen', () {
    const event = LiveFixtures.event;

    test('leest verlenging, strafschoppen en uitslag-toevoeging', () async {
      backend.http.on(
        LiveFixtures.get,
        200,
        LiveFixtures.response(
          rules: LiveFixtures.cupRules(),
          homeScore: 2,
          awayScore: 2,
          live: LiveFixtures.ended(
            extraTime: true,
            resultSuffix: '4–3 n.s.',
            shootout: LiveFixtures.shootout(
              us: [true, false],
              opp: [true],
              players: ['Sem de Wit'],
              winner: 'us',
            ),
          ),
          moments: [
            LiveFixtures.moment(
              type: 'post',
              label: 'Schot op de paal',
              side: 'opp',
              player: 'De Buren',
            ),
          ],
        ),
      );

      final match = await repository.fetch(3, 412);
      final clock = match.clock;
      expect(clock.regularPeriods, 2);
      expect(clock.extraTime, isTrue);
      expect(clock.periodEnds, [45, 90, 105, 120]);
      expect(clock.resultSuffix, '4–3 n.s.');
      expect(clock.extraPeriod(2), 2);
      final shootout = clock.shootout!;
      expect(shootout.us.first.player, 'Sem de Wit');
      expect(shootout.us.last.player, isNull);
      expect(shootout.usScore, 1);
      expect(shootout.oppScore, 1);
      expect(shootout.winner, 'us');
      expect(shootout.slots, 5);
      expect(clock.shootoutOpen, isFalse);
      expect(match.rules.extraTime, const LiveExtraTime());
      expect(match.rules.hasShootout, isTrue);
      expect(match.rules.momentTypes.map((m) => m.type), [
        'penalty_awarded',
        'penalty_missed',
        'penalty_saved',
        'post',
        'crossbar',
        'big_chance',
      ]);
      expect(match.moments.single.isOurs, isFalse);
      expect(match.moments.single.player, 'De Buren');
      // Al een serie: niets meer te beslissen.
      expect(match.canDecide(isCup: true), isFalse);
    });

    test('zonder de nieuwe velden: oude defaults', () async {
      backend.http.on(LiveFixtures.get, 200, LiveFixtures.response());
      final match = await repository.fetch(3, 412);
      expect(match.clock.shootout, isNull);
      expect(match.clock.resultSuffix, isNull);
      expect(match.clock.extraPeriod(2), isNull);
      expect(match.rules.extraTime, isNull);
      expect(match.rules.hasShootout, isFalse);
      expect(match.moments.single.isOurs, isTrue);
    });

    test('gelijke beker: verlenging en strafschoppen aanbieden', () async {
      backend.http.on(
        LiveFixtures.get,
        200,
        LiveFixtures.response(
          rules: LiveFixtures.cupRules(),
          awayScore: 1,
          live: LiveFixtures.ended(),
        ),
      );
      final match = await repository.fetch(3, 412);
      expect(match.canDecide(isCup: true), isTrue);
      expect(match.canStartExtraTime(isCup: true), isTrue);
      // Geen beker, dan niet.
      expect(match.canDecide(isCup: false), isFalse);
    });

    test('klok gelijkzetten en verlenging', () async {
      backend.http
        ..on(LiveFixtures.post('clock'), 200, LiveFixtures.response())
        ..on(LiveFixtures.post('extra-time'), 200, LiveFixtures.response());
      await repository.setClock(3, 412, minute: 30, second: 15);
      expect(lastBody(LiveFixtures.post('clock')), {
        'minute': 30,
        'second': 15,
      });
      await repository.extraTime(3, 412);
      expect(lastBody(LiveFixtures.post('extra-time')), isNull);
    });

    test('strafschoppen: starten, schoten, terug en wissen', () async {
      backend.http
        ..on('POST $event/shootout', 200, LiveFixtures.response())
        ..on('POST $event/shootout/kicks', 201, LiveFixtures.response())
        ..on('DELETE $event/shootout/kicks/last', 200, LiveFixtures.response())
        ..on('DELETE $event/shootout', 200, LiveFixtures.response());

      await repository.startShootout(3, 412);
      expect(backend.http.requestsTo('POST $event/shootout'), hasLength(1));

      await repository.shootoutKick(
        3,
        412,
        side: 'us',
        scored: true,
        playerId: 21,
      );
      // Bij de tegenstander gaat er nooit een speler mee.
      await repository.shootoutKick(
        3,
        412,
        side: 'opp',
        scored: false,
        playerId: 21,
      );
      final kicks = backend.http.requestsTo('POST $event/shootout/kicks');
      expect(kicks.map((r) => r.body), [
        {'side': 'us', 'scored': true, 'player_id': 21},
        {'side': 'opp', 'scored': false, 'player_id': null},
      ]);

      await repository.undoShootoutKick(3, 412);
      await repository.clearShootout(3, 412);
      expect(
        backend.http.requestsTo('DELETE $event/shootout/kicks/last'),
        hasLength(1),
      );
      expect(backend.http.requestsTo('DELETE $event/shootout'), hasLength(1));
    });

    test('moment van de tegenstander gaat zonder speler', () async {
      backend.http.on('POST $event/moments', 201, LiveFixtures.response());
      await repository.addMoment(
        3,
        412,
        minute: 70,
        type: 'crossbar',
        playerId: 21,
        opponent: true,
      );
      expect(lastBody('POST $event/moments'), {
        'minute': 70,
        'type': 'crossbar',
        'opponent': true,
      });
    });
  });
}
