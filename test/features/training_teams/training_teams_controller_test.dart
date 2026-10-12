import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/event/application/event_detail_controller.dart';
import 'package:assistje/features/training_teams/application/training_teams_controller.dart';
import 'package:assistje/features/training_teams/data/models/training_teams_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'training_teams_fixtures.dart';

const _base = '/teams/3/events/512/teams';
const _index = 'GET $_base';
const EventKey _key = (teamId: 3, eventId: 512);

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<TrainingTeamsController> start(
    void Function(FakeHttpAdapter http) setup, {
    Duration debounce = Duration.zero,
  }) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    setup(backend.http);
    container = ProviderContainer(
      overrides: [
        ...backend.overrides,
        trainingScoresDebounceProvider.overrideWithValue(debounce),
      ],
      retry: (_, _) => null,
    );
    addTearDown(container.dispose);
    container.listen(trainingTeamsControllerProvider(_key), (_, _) {});
    await container.read(trainingTeamsControllerProvider(_key).future);
    return container.read(trainingTeamsControllerProvider(_key).notifier);
  }

  TrainingTeams current() =>
      container.read(trainingTeamsControllerProvider(_key)).requireValue;

  String? sideOf(int id) => current().teams.player(id)?.side;

  test('laadt het scherm', () async {
    await start((http) => http.on(_index, 200, TrainingTeamsFixtures.screen()));
    expect(current().teams.players, hasLength(3));
    expect(current().usedSides, ['a', 'b']);
  });

  test('403 en 404 komen als AsyncError', () async {
    for (final (status, matcher) in [
      (403, isA<ForbiddenException>()),
      (404, isA<NotFoundException>()),
    ]) {
      backend = TestBackend(token: '12|abc');
      await backend.init();
      backend.http.on(_index, status, {'message': 'Nee.'});
      container = backend.container();
      addTearDown(container.dispose);
      container.listen(trainingTeamsControllerProvider(_key), (_, _) {});
      await expectLater(
        container.read(trainingTeamsControllerProvider(_key).future),
        throwsA(matcher),
      );
    }
  });

  test('indelen zet het scherm van de server neer', () async {
    final controller = await start((http) {
      http
        ..on(
          _index,
          200,
          TrainingTeamsFixtures.screen(
            players: TrainingTeamsFixtures.benchPlayers(),
          ),
        )
        ..on('POST $_base/draw', 200, TrainingTeamsFixtures.screen());
    });
    expect(current().teams.hasTeams, isFalse);

    expect(await controller.draw(teams: 2), isNull);

    expect(current().teams.hasTeams, isTrue);
    expect(backend.http.requestsTo('POST $_base/draw').single.body, {
      'teams': 2,
    });
  });

  test('indelen zonder may_assign mag niet (geen verzoek)', () async {
    final controller = await start(
      (http) =>
          http.on(_index, 200, TrainingTeamsFixtures.screen(mayAssign: false)),
    );

    expect(await controller.draw(), isA<ForbiddenException>());
    expect(await controller.swap(37, 41), isA<ForbiddenException>());
    expect(backend.http.requestsTo('POST $_base/draw'), isEmpty);
  });

  test('wissen; een fout laat de indeling staan', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on('DELETE $_base', 500, {'message': 'Kapot.'});
    });

    expect(await controller.clear(), isA<ServerException>());
    expect(current().teams.hasTeams, isTrue);

    backend.http.on(
      'DELETE $_base',
      200,
      TrainingTeamsFixtures.screen(
        players: TrainingTeamsFixtures.benchPlayers(),
      ),
    );
    expect(await controller.clear(), isNull);
    expect(current().teams.hasTeams, isFalse);
  });

  test('ruilen is optimistisch en draait terug bij een fout', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on('POST $_base/swap', 404, {'message': 'Niets te ruilen.'});
    });

    final pending = controller.swap(37, 52);
    // Meteen in beeld: Kees op de bank, Tim in ploeg a.
    expect(sideOf(37), isNull);
    expect(sideOf(52), 'a');

    expect(await pending, isA<NotFoundException>());
    expect(sideOf(37), 'a');
    expect(sideOf(52), isNull);
  });

  test('ruilen gelukt: het serverscherm wint', () async {
    final swapped = TrainingTeamsFixtures.drawnPlayers()
      ..[0] = TrainingTeamsFixtures.player(id: 37, name: 'Kees Jansen')
      ..[2] = TrainingTeamsFixtures.player(
        id: 52,
        name: 'Tim Bakker',
        side: 'a',
      );
    final controller = await start((http) {
      http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on(
          'POST $_base/swap',
          200,
          TrainingTeamsFixtures.screen(players: swapped),
        );
    });

    expect(await controller.swap(37, 52), isNull);
    expect(sideOf(37), isNull);
    expect(sideOf(52), 'a');
    expect(backend.http.requestsTo('POST $_base/swap').single.body, {
      'a': 37,
      'b': 52,
    });
  });

  test('verplaatsen naar de bank, met terugdraaien bij 422', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on('PATCH $_base/41', 422, {'message': 'Ongeldige ploeg.'});
    });

    final pending = controller.move(41, null);
    expect(sideOf(41), isNull);
    expect(await pending, isA<ValidationException>());
    expect(sideOf(41), 'b');

    // Al op die plek: geen verzoek.
    expect(await controller.move(41, 'b'), isNull);
    expect(backend.http.requestsTo('PATCH $_base/41'), hasLength(1));
  });

  test('uitslag: snelknop zet alle ploegen en bewaart één keer', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, TrainingTeamsFixtures.screen(scores: {}))
        ..on(
          'POST $_base/points',
          200,
          TrainingTeamsFixtures.screen(scores: {'a': 0, 'b': 2}),
        );
    });

    final first = controller.quickResult('a');
    final second = controller.quickResult('b');
    // Meteen in beeld, ook vóór de server antwoordt.
    expect(current().teams.scores, {'a': 0, 'b': 2});

    expect(await first, isNull);
    expect(await second, isNull);
    final requests = backend.http.requestsTo('POST $_base/points');
    expect(requests, hasLength(1));
    expect(requests.single.body, {
      'points': {'a': 0, 'b': 2},
    });
    expect(current().teams.scores, {'a': 0, 'b': 2});
  });

  test('uitslag: gelijkspel en stepper; fout draait terug', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on('POST $_base/points', 500, {'message': 'Kapot.'});
    });

    final pending = controller.bumpScore('a', 1);
    expect(current().teams.scores['a'], 4);
    expect(await pending, isA<ServerException>());
    expect(current().teams.scores, {'a': 3, 'b': 0});

    backend.http.on('POST $_base/points', 200, TrainingTeamsFixtures.screen());
    final draw = controller.quickResult(null);
    expect(current().teams.scores, {'a': 1, 'b': 1});
    expect(await draw, isNull);

    // Bovengrens 10.
    backend.http.on(
      _index,
      200,
      TrainingTeamsFixtures.screen(scores: {'a': maxTeamPoints}),
    );
    await controller.refresh();
    final before = backend.http.requestsTo('POST $_base/points').length;
    expect(await controller.bumpScore('a', 1), isNull);
    expect(backend.http.requestsTo('POST $_base/points'), hasLength(before));
  });

  test('punten per speler: optimistisch, ook de totaalpunten', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on('PATCH $_base/41/points', 200, TrainingTeamsFixtures.screen());
    });

    final pending = controller.bumpPlayer(41, 1);
    final piet = current().scoring.firstWhere((r) => r.id == 41);
    expect(piet.scored, 1);
    expect(piet.points, 2);
    expect(await pending, isNull);
    expect(backend.http.requestsTo('PATCH $_base/41/points').single.body, {
      'points': 1,
    });

    // Niet onder nul.
    expect(await controller.bumpPlayer(41, -1), isNull);
    expect(backend.http.requestsTo('PATCH $_base/41/points'), hasLength(1));
  });

  test('iedereen gelijk, terugzetten en uitsluiten', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on('POST $_base/draw-points', 200, TrainingTeamsFixtures.screen())
        ..on(
          'POST $_base/60/include',
          200,
          TrainingTeamsFixtures.screen(available: const []),
        )
        ..on(
          'DELETE $_base/41',
          200,
          TrainingTeamsFixtures.screen(
            scoring: [
              TrainingTeamsFixtures.scoringRow(id: 37, name: 'Kees Jansen'),
            ],
          ),
        );
    });

    expect(await controller.drawPoints(), isNull);
    expect(await controller.include(60), isNull);
    expect(current().scoringAvailable, isEmpty);
    expect(await controller.exclude(41), isNull);
    expect(current().scoring.map((r) => r.id), [37]);
  });

  test('zonder trainingspunten geen puntenacties', () async {
    final controller = await start(
      (http) => http.on(
        _index,
        200,
        TrainingTeamsFixtures.screen(tracksPoints: false),
      ),
    );

    expect(await controller.drawPoints(), isA<ForbiddenException>());
    expect(await controller.include(60), isA<ForbiddenException>());
    expect(await controller.exclude(41), isA<ForbiddenException>());
    expect(await controller.bumpPlayer(41, 1), isA<ForbiddenException>());
    expect(await controller.setScores({'a': 1}), isA<ForbiddenException>());
  });

  test('sterkte: optimistisch, terugdraaien bij een fout', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on('PATCH /teams/3/players/41/strength', 200, {
          'data': {'player_id': 41, 'strength': 3},
        })
        ..on('PATCH /teams/3/players/37/strength', 500, {'message': 'x'});
    });

    expect(await controller.setStrength(41, 3), isNull);
    expect(current().teams.player(41)?.strength, 3);

    final pending = controller.setStrength(37, null);
    expect(current().teams.player(37)?.strength, isNull);
    expect(await pending, isA<ServerException>());
    expect(current().teams.player(37)?.strength, 4);
  });

  test('basis: bewaren en opnieuw laden; 422 draait terug', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on('PATCH /teams/3/training-basis', 200, {
          'data': {'basis': 'random'},
        });
    });

    backend.http.on(_index, 200, TrainingTeamsFixtures.screen(basis: 'random'));
    final loads = backend.http.requestsTo(_index).length;
    expect(await controller.setBasis(TrainingBasis.random), isNull);
    expect(current().teams.basis, TrainingBasis.random);
    // Daarna opnieuw geladen (`derived` hangt van de basis af).
    expect(backend.http.requestsTo(_index), hasLength(loads + 1));

    backend.http.on('PATCH /teams/3/training-basis', 422, {
      'message': 'Klassement kan alleen met trainingspunten aan.',
    });
    final error = await controller.setBasis(TrainingBasis.points);
    expect(error, isA<ValidationException>());
    expect(current().teams.basis, TrainingBasis.random);
  });
}
