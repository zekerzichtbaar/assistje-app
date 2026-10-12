import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/training_teams/data/models/training_teams_models.dart';
import 'package:assistje/features/training_teams/data/training_teams_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'training_teams_fixtures.dart';

const _base = '/teams/3/events/512/teams';

void main() {
  late FakeHttpAdapter http;
  late TrainingTeamsRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = TrainingTeamsRepository(
      ApiClient(
        buildApiDio(
          baseUrl: 'https://assistje.test/api/v1',
          readToken: () async => '12|abc',
          onUnauthorized: () {},
          adapter: http,
        ),
      ),
    );
  });

  test('leest het scherm', () async {
    http.on('GET $_base', 200, TrainingTeamsFixtures.screen());

    final s = await repository.fetch(3, 512);

    expect(s.event.id, 512);
    expect(s.event.title, 'Training');
    expect(s.event.startsAt, isNotNull);
    expect(s.sides, ['a', 'b', 'c', 'd', 'e', 'f']);
    expect(s.maxTeams, 6);
    expect(s.teams.mayAssign, isTrue);
    expect(s.teams.tracksPoints, isTrue);
    expect(s.teams.tracksTeams, isTrue);
    expect(s.teams.basis, TrainingBasis.strength);
    expect(s.teams.scores, {'a': 3, 'b': 0});
    expect(s.teams.players, hasLength(3));
    final kees = s.teams.players.first;
    expect(kees.side, 'a');
    expect(kees.position, 'MF');
    expect(kees.strength, 4);
    expect(kees.derived, 3.6);
    expect(s.teams.players[1].derived, 2.0);
    expect(s.teams.bench.single.id, 52);
    expect(s.teams.hasTeams, isTrue);
    expect(s.usedSides, ['a', 'b']);
    expect(s.sideNumber('b'), 2);
    expect(s.scoring.first.shirtNumber, 8);
    expect(s.scoring.first.scored, 3);
    expect(s.scoring.first.points, 4);
    expect(s.scoring[1].scored, isNull);
    expect(s.scoringAvailable.single.name, 'Bas Bank');
  });

  test('onbekende basis en lege scores als lijst zijn geen fout', () async {
    http.on(
      'GET $_base',
      200,
      TrainingTeamsFixtures.screen(basis: 'nieuw', scores: <Object>[]),
    );

    final s = await repository.fetch(3, 512);

    expect(s.teams.basis, TrainingBasis.strength);
    expect(s.teams.scores, isEmpty);
  });

  test('indelen met en zonder aantal', () async {
    http.on('POST $_base/draw', 200, TrainingTeamsFixtures.screen());

    await repository.draw(3, 512, teams: 3);
    await repository.draw(3, 512);

    final requests = http.requestsTo('POST $_base/draw');
    expect(requests.first.body, {'teams': 3});
    expect(requests.last.body, anyOf(isNull, isEmpty));
  });

  test('wissen', () async {
    http.on(
      'DELETE $_base',
      200,
      TrainingTeamsFixtures.screen(
        players: TrainingTeamsFixtures.benchPlayers(),
      ),
    );

    final s = await repository.clear(3, 512);

    expect(s.teams.hasTeams, isFalse);
    expect(http.requestsTo('DELETE $_base'), hasLength(1));
  });

  test('ruilen', () async {
    http.on('POST $_base/swap', 200, TrainingTeamsFixtures.screen());

    await repository.swap(3, 512, 37, 41);

    expect(http.requestsTo('POST $_base/swap').single.body, {'a': 37, 'b': 41});
  });

  test('verplaatsen naar een ploeg en naar de bank', () async {
    http.on('PATCH $_base/52', 200, TrainingTeamsFixtures.screen());

    await repository.move(3, 512, 52, 'b');
    await repository.move(3, 512, 52, null);

    final requests = http.requestsTo('PATCH $_base/52');
    expect(requests.first.body, {'side': 'b'});
    expect(requests.last.body, {'side': null});
  });

  test('uitslag per ploeg', () async {
    http.on('POST $_base/points', 200, TrainingTeamsFixtures.screen());

    await repository.setScores(3, 512, {'a': 2, 'b': null});

    expect(http.requestsTo('POST $_base/points').single.body, {
      'points': {'a': 2, 'b': null},
    });
  });

  test('iedereen gelijk', () async {
    http.on('POST $_base/draw-points', 200, TrainingTeamsFixtures.screen());

    await repository.drawPoints(3, 512);

    expect(http.requestsTo('POST $_base/draw-points'), hasLength(1));
  });

  test('punten van één speler', () async {
    http.on('PATCH $_base/41/points', 200, TrainingTeamsFixtures.screen());

    await repository.setPlayerPoints(3, 512, 41, 2);

    expect(http.requestsTo('PATCH $_base/41/points').single.body, {
      'points': 2,
    });
  });

  test('terugzetten en uitsluiten', () async {
    http
      ..on('POST $_base/60/include', 200, TrainingTeamsFixtures.screen())
      ..on('DELETE $_base/41', 200, TrainingTeamsFixtures.screen());

    await repository.include(3, 512, 60);
    await repository.exclude(3, 512, 41);

    expect(http.requestsTo('POST $_base/60/include'), hasLength(1));
    expect(http.requestsTo('DELETE $_base/41'), hasLength(1));
  });

  test('sterkte zetten en weghalen', () async {
    http.on('PATCH /teams/3/players/37/strength', 200, {
      'data': {'player_id': 37, 'strength': 5},
    });

    expect(await repository.setStrength(3, 37, 5), 5);
    expect(http.requestsTo('PATCH /teams/3/players/37/strength').single.body, {
      'strength': 5,
    });

    http.on('PATCH /teams/3/players/37/strength', 200, {
      'data': {'player_id': 37, 'strength': null},
    });
    expect(await repository.setStrength(3, 37, null), isNull);
  });

  test('basis zetten; 422 met de melding van de server', () async {
    http.on('PATCH /teams/3/training-basis', 200, {
      'data': {'basis': 'random'},
    });
    expect(
      await repository.setBasis(3, TrainingBasis.random),
      TrainingBasis.random,
    );
    expect(http.requestsTo('PATCH /teams/3/training-basis').single.body, {
      'basis': 'random',
    });

    http.on('PATCH /teams/3/training-basis', 422, {
      'message': 'Klassement kan alleen met trainingspunten aan.',
      'errors': {
        'basis': ['Klassement kan alleen met trainingspunten aan.'],
      },
    });
    await expectLater(
      repository.setBasis(3, TrainingBasis.points),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.message,
          'message',
          'Klassement kan alleen met trainingspunten aan.',
        ),
      ),
    );
  });

  test('403, 404 en 422 worden ApiExceptions', () async {
    http
      ..on('GET $_base', 403, {'message': 'Nee.'})
      ..on('POST $_base/swap', 404, {'message': 'Niets te ruilen.'})
      ..on('PATCH $_base/52', 422, {
        'message': 'Ongeldige ploeg.',
        'errors': {
          'side': ['Ongeldige ploeg.'],
        },
      });

    await expectLater(
      repository.fetch(3, 512),
      throwsA(isA<ForbiddenException>()),
    );
    await expectLater(
      repository.swap(3, 512, 52, 60),
      throwsA(isA<NotFoundException>()),
    );
    await expectLater(
      repository.move(3, 512, 52, 'z'),
      throwsA(isA<ValidationException>()),
    );
  });

  test('een antwoord zonder data is een fout', () async {
    http.on('GET $_base', 200, {'data': <Object>[]});
    await expectLater(
      repository.fetch(3, 512),
      throwsA(isA<UnknownApiException>()),
    );
  });
}
