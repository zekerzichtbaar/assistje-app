import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/stats/data/stats_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'stats_fixtures.dart';

const _stats = 'GET /teams/3/stats';

void main() {
  late FakeHttpAdapter http;
  late StatsRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = StatsRepository(
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

  test('voorbeeld uit docs/api/v1/stats.md', () async {
    http.on(_stats, 200, {
      'data': {
        ...StatsFixtures.data(),
        'rows': [StatsFixtures.samRow()],
        'seasons': [
          {'id': 4, 'label': '2026/2027', 'is_active': true},
          {'id': 3, 'label': '2025/2026', 'is_active': false},
        ],
      },
    });

    final stats = await repository.fetchStats(3);

    expect(http.requests.single.options.uri.queryParameters, isEmpty);
    expect(stats.window, 'season');
    expect(stats.seasonId, 4);
    expect(stats.season?.label, '2026/2027');
    expect(stats.seasons.map((s) => s.isActive), [true, false]);
    expect(stats.myPlayerId, 14);
    final sam = stats.rows.single;
    expect(sam.playerId, 14);
    expect(sam.name, 'Sam de Vries');
    expect(sam.shirtNumber, 7);
    expect(sam.position, 'CM');
    expect(sam.attendanceRate, 80.0);
    expect(sam.attendanceMatchRate, 87.5);
    expect(sam.attendanceTrainingRate, 72.0);
    expect(sam.minutes, 610);
    expect(sam.goals, 3);
    expect(sam.assists, 2);
    expect(sam.yellow, 1);
    expect(sam.red, 0);
    expect(sam.matchesPlayed, 8);
    expect(sam.flagMinutes, 45);
    expect(sam.flagShifts, 1);
    expect(sam.titles.single.label, 'Topscorer');
    expect(sam.titles.single.icon, '⚽');
    expect(sam.trainingPoints, 9);
  });

  test('venster en seizoen gaan als ?window= en ?season= mee', () async {
    http.on(_stats, 200, StatsFixtures.response({'window': '5'}));

    await repository.fetchStats(3, window: StatsWindow.last5, seasonId: 3);

    expect(http.requests.single.options.uri.queryParameters, {
      'window': '5',
      'season': '3',
    });
  });

  test('lenient: ontbrekende velden, getallen als tekst, extra keys', () async {
    http.on(_stats, 200, {
      'data': {
        'window': 10,
        'season_id': null,
        'my_player_id': null,
        'rows': [
          {
            'player_id': '9',
            'goals': '4',
            'attendance_rate': '75.5',
            'minutes': 90.0,
            'shirt_number': null,
            'nieuw_veld': {'x': 1},
          },
        ],
      },
    });

    final stats = await repository.fetchStats(3);

    expect(stats.window, '10');
    expect(StatsWindow.parse(stats.window), StatsWindow.last10);
    expect(stats.seasonId, isNull);
    expect(stats.seasons, isEmpty);
    expect(stats.myPlayerId, isNull);
    final row = stats.rows.single;
    expect(row.playerId, 9);
    expect(row.name, '');
    expect(row.goals, 4);
    expect(row.attendanceRate, 75.5);
    expect(row.minutes, 90);
    expect(row.shirtNumber, isNull);
    expect(row.titles, isEmpty);
  });

  test('onbekend venster valt terug op seizoen', () {
    expect(StatsWindow.parse('season'), StatsWindow.season);
    expect(StatsWindow.parse('5'), StatsWindow.last5);
    expect(StatsWindow.parse('25'), StatsWindow.season);
    expect(StatsWindow.parse(null), StatsWindow.season);
  });

  test('404 (feature uit) komt als NotFoundException', () async {
    http.on(_stats, 404, {'message': 'Not Found'});

    await expectLater(
      repository.fetchStats(3),
      throwsA(isA<NotFoundException>()),
    );
  });
}
