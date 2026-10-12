import '../../helpers/api_fixtures.dart';

/// De JSON-voorbeelden uit vogels3 `docs/api/v1/seasons.md`.
abstract final class SeasonsFixtures {
  /// Trainer-membership van team 3.
  static Map<String, dynamic> trainerMembership({bool demo = false}) {
    final membership = ApiFixtures.membership(role: 'trainer');
    if (demo) {
      membership['team'] = {
        ...(membership['team'] as Map<String, dynamic>),
        'is_demo': true,
      };
    }
    return membership;
  }

  static Map<String, dynamic> season({
    String label = '26/27',
    String startsOn = '2026-07-01',
    String endsOn = '2027-06-30',
    bool expired = false,
    int matchCount = 22,
  }) => {
    'id': 7,
    'label': label,
    'starts_on': startsOn,
    'ends_on': endsOn,
    'is_active': true,
    'expired': expired,
    'match_count': matchCount,
  };

  static Map<String, dynamic> period({
    int id = 42,
    String name = 'Periode 2',
    String startsOn = '2026-10-27',
    String? endsOn,
    int? targetMatches = 7,
    bool isClosed = false,
    int played = 2,
    int awards = 0,
  }) => {
    'id': id,
    'name': name,
    'starts_on': startsOn,
    'ends_on': endsOn,
    'target_matches': targetMatches,
    'is_closed': isClosed,
    'played_matches': played,
    'award_count': awards,
  };

  static List<Map<String, dynamic>> periods() => [
    period(
      id: 41,
      name: 'Periode 1',
      startsOn: '2026-07-01',
      endsOn: '2026-10-26',
      targetMatches: 8,
      isClosed: true,
      played: 8,
      awards: 5,
    ),
    period(),
  ];

  static Map<String, dynamic> data({
    String mode = 'matches',
    Map<String, dynamic>? season,
    bool noSeason = false,
    Map<String, dynamic>? closedSeason,
    bool noClosedSeason = false,
    List<Map<String, dynamic>>? periods,
  }) => {
    'mode': mode,
    'modes': ['off', 'dates', 'matches'],
    'season': noSeason ? null : (season ?? SeasonsFixtures.season()),
    'closed_season': noClosedSeason
        ? null
        : (closedSeason ??
              {'label': '25/26', 'closed_at': '2026-07-03T09:12:00+02:00'}),
    'periods': periods ?? SeasonsFixtures.periods(),
  };

  static Map<String, dynamic> response([
    Map<String, dynamic>? data,
    Map<String, dynamic>? meta,
  ]) => {'data': data ?? SeasonsFixtures.data(), 'meta': ?meta};
}
