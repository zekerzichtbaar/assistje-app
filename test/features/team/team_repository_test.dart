import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/team/data/team_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'roster_fixtures.dart';

void main() {
  late FakeHttpAdapter http;
  late TeamRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = TeamRepository(
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

  test('selectie uit het voorbeeld in docs/api/v1/team.md', () async {
    http.on('GET /teams/3/team', 200, RosterFixtures.roster());

    final roster = await repository.fetchRoster(3);

    expect(roster.players.map((p) => p.id), [14, 31]);
    final sam = roster.players.first;
    expect(sam.shirtNumber, 7);
    expect(sam.name, 'Sam de Vries');
    expect(sam.position, 'CM');
    expect(sam.avatarUrl, startsWith('https://'));
    expect(sam.isGuest, isFalse);
    final guest = roster.players.last;
    expect(guest.isGuest, isTrue);
    expect(guest.isOnVacation, isTrue);
    expect(guest.avatarUrl, isNull);
    expect(roster.coaches.single.id, 3);
    expect(roster.coaches.single.name, 'Trainer Tom');
    expect(roster.isEmpty, isFalse);
  });

  test('onbekende velden en ontbrekende optionele velden', () async {
    http.on('GET /teams/3/team', 200, {
      'data': {
        'players': [
          {'id': 1, 'name': 'X', 'shiny_new_field': true},
        ],
      },
    });

    final roster = await repository.fetchRoster(3);

    expect(roster.players.single.position, isNull);
    expect(roster.players.single.shirtNumber, isNull);
    expect(roster.coaches, isEmpty);
  });

  test('403 komt als ForbiddenException', () async {
    http.on('GET /teams/3/team', 403, {'message': 'Geen lid.'});
    await expectLater(
      repository.fetchRoster(3),
      throwsA(isA<ForbiddenException>()),
    );
  });

  test('antwoord zonder data is een fout', () async {
    http.on('GET /teams/3/team', 200, {'nope': true});
    await expectLater(
      repository.fetchRoster(3),
      throwsA(isA<UnknownApiException>()),
    );
  });
}
