import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/players/data/player_detail_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../team/roster_fixtures.dart';

void main() {
  late FakeHttpAdapter http;
  late PlayerDetailRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = PlayerDetailRepository(
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

  test('detail uit het voorbeeld in docs/api/v1/players.md', () async {
    http.on('GET /teams/3/players/14', 200, RosterFixtures.playerDetail());

    final detail = await repository.fetch(3, 14);

    final p = detail.player;
    expect(p.id, 14);
    expect(p.name, 'Sam de Vries');
    expect(p.shirtNumber, 7);
    expect(p.position, 'CM');
    expect(p.isCaptain, isTrue);
    expect(p.hasAccount, isTrue);
    expect(p.inviteAccepted, isTrue);
    expect(p.email, isNull);
    expect(p.invitedAt, isNull);
    expect(p.abilities, isEmpty);
    expect(detail.canManage, isFalse);
    expect(detail.vacations, isEmpty);
    expect(detail.standingAbsences, isNull);

    final season = detail.personalStats!.season;
    expect(season.matchesPlayed, 8);
    expect(season.winPct, 62.5);
    expect(season.attendanceTrainingRate, 72.0);
    expect(season.trainingPoints, isNull);
    expect(detail.personalStats!.career.matchesPlayed, 41);
    expect(detail.duties.map((d) => d.slug), ['vlaggen', 'wassen']);
    expect(detail.duties.first.count, 2);
    final badge = detail.achievements.single;
    expect(badge.key, 'hattrick_hero');
    expect(badge.icon, '🥇');
    expect(badge.detail, '3 goals in één wedstrijd');
  });

  test('beheervelden voor een trainer', () async {
    http.on(
      'GET /teams/3/players/14',
      200,
      RosterFixtures.managedPlayerDetail(),
    );

    final detail = await repository.fetch(3, 14);

    expect(detail.canManage, isTrue);
    expect(detail.player.email, 'sam@example.com');
    expect(detail.player.invitedAt, DateTime.utc(2026, 9, 1, 8));
    final vacation = detail.vacations.single;
    expect(vacation.startsOn, DateTime(2026, 10, 20));
    expect(vacation.endsOn, DateTime(2026, 10, 27));
    expect(vacation.note, 'Skiën');
    final absences = detail.standingAbsences!;
    expect(absences.choices, [2, 4]);
    expect(absences.isAbsentOn(2), isTrue);
    expect(absences.isAbsentOn(4), isFalse);
  });

  test('integers als kommagetal en ontbrekende stats', () async {
    http.on('GET /teams/3/players/14', 200, {
      'data': {
        'player': {'id': 14, 'name': 'X'},
        'personal_stats': {
          'season': {'matches_played': 3, 'win_pct': 50, 'points': 12},
        },
      },
    });

    final detail = await repository.fetch(3, 14);

    expect(detail.personalStats!.season.winPct, 50.0);
    expect(detail.personalStats!.season.points, 12);
    expect(detail.personalStats!.career.matchesPlayed, 0);
    expect(detail.duties, isEmpty);
  });

  test('404 komt als NotFoundException', () async {
    http.on('GET /teams/3/players/99', 404, {'message': 'Niet gevonden.'});
    await expectLater(
      repository.fetch(3, 99),
      throwsA(isA<NotFoundException>()),
    );
  });
}
