import 'package:assistje/features/stats/application/sport_stats_profile.dart';
import 'package:assistje/features/stats/data/models/stats_models.dart';
import 'package:flutter_test/flutter_test.dart';

import 'stats_fixtures.dart';

void main() {
  group('SportStatsProfile.fromSport', () {
    test('voetbal: doelpunten, minuten, vlag, geel en rood', () {
      final p = SportStatsProfile.fromSport(StatsFixtures.footballSport());
      expect(p.tracksScorers, isTrue);
      expect(p.tracksPlayingTime, isTrue);
      expect(p.supportsFlagDuty, isTrue);
      expect(p.postMatchStats, isFalse);
      expect(p.showsYellow, isTrue);
      expect(p.showsRed, isTrue);
      expect(p.goalsTerm, 'Goals');
    });

    test('volleybal: sets — geen doelpunten, minuten, vlag of kaarten', () {
      final p = SportStatsProfile.fromSport(StatsFixtures.volleyballSport());
      expect(p.tracksScorers, isFalse);
      expect(p.tracksPlayingTime, isFalse);
      expect(p.supportsFlagDuty, isFalse);
      expect(p.postMatchStats, isTrue);
      expect(p.showsYellow, isFalse);
      expect(p.showsRed, isFalse);
      expect(p.goalsTerm, 'Punten');
    });

    test('ontbrekende velden: standaard van SportProfile', () {
      final p = SportStatsProfile.fromSport(const {'key': 'football'});
      expect(p.tracksScorers, isFalse);
      expect(p.tracksPlayingTime, isTrue);
      expect(p.supportsFlagDuty, isFalse);
      expect(p.cardTypes, isEmpty);
      expect(p.goalsTerm, isNull);
    });

    test('tracks_scorers ontbreekt: afgeleid van match_stats_mode', () {
      final p = SportStatsProfile.fromSport(const {
        'match_stats_mode': 'timeline',
      });
      expect(p.tracksScorers, isTrue);
    });
  });

  group('availableSorts', () {
    test('voetbal met trainingspunten', () {
      final p = SportStatsProfile.fromSport(StatsFixtures.footballSport());
      expect(availableSorts(p, trainingPoints: true), [
        StatsSort.overview,
        StatsSort.trainingPoints,
        StatsSort.attendanceMatch,
        StatsSort.attendanceTraining,
        StatsSort.matchesPlayed,
        StatsSort.minutes,
        StatsSort.goals,
        StatsSort.assists,
        StatsSort.flagMinutes,
        StatsSort.flagShifts,
        StatsSort.name,
      ]);
    });

    test('volleybal', () {
      final p = SportStatsProfile.fromSport(StatsFixtures.volleyballSport());
      expect(availableSorts(p), [
        StatsSort.overview,
        StatsSort.attendanceMatch,
        StatsSort.attendanceTraining,
        StatsSort.matchesPlayed,
        StatsSort.name,
      ]);
    });
  });

  group('sortStatsRows', () {
    final sam = StatsRow.fromJson(StatsFixtures.samRow());
    final joris = StatsRow.fromJson(StatsFixtures.joriRow());
    final anna = StatsRow.fromJson(
      StatsFixtures.samRow({'player_id': 30, 'name': 'Anna', 'goals': 3}),
    );

    test('overzicht: op aanwezigheid aflopend', () {
      expect(
        sortStatsRows([joris, sam], StatsSort.overview).map((r) => r.playerId),
        [14, 22],
      );
    });

    test('metric aflopend met naam als tiebreak', () {
      expect(
        sortStatsRows([sam, joris, anna], StatsSort.goals).map((r) => r.name),
        ['Anna', 'Sam de Vries', 'Joris Bakker'],
      );
      expect(
        sortStatsRows([sam, joris], StatsSort.assists).map((r) => r.playerId),
        [22, 14],
      );
    });

    test('naam oplopend', () {
      expect(
        sortStatsRows([sam, joris, anna], StatsSort.name).map((r) => r.name),
        ['Anna', 'Joris Bakker', 'Sam de Vries'],
      );
    });
  });
}
