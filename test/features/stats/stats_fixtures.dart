/// Voorbeeld-JSON uit vogels3 `docs/api/v1/stats.md` (letterlijk), plus
/// sportprofielen (`SportProfile::toArray()`, ingekort) voor de kolomtests.
abstract final class StatsFixtures {
  /// De rij uit het voorbeeld (Sam, speler 14).
  static Map<String, dynamic> samRow([Map<String, dynamic>? overrides]) => {
    'player_id': 14,
    'name': 'Sam de Vries',
    'shirt_number': 7,
    'position': 'CM',
    'avatar_url': 'https://test-team.assistje.nl/avatars/thumb/9f2c.jpg',
    'attendance_rate': 80.0,
    'attendance_match_rate': 87.5,
    'attendance_training_rate': 72.0,
    'minutes': 610,
    'goals': 3,
    'assists': 2,
    'yellow': 1,
    'red': 0,
    'matches_played': 8,
    'flag_minutes': 45,
    'flag_shifts': 1,
    'titles': [
      {'key': 'top_scorer', 'icon': '⚽', 'label': 'Topscorer'},
    ],
    'training_points': 9,
    ...?overrides,
  };

  /// Een tweede speler (niet "ik"), met meer assists en minder aanwezig.
  static Map<String, dynamic> joriRow() => samRow({
    'player_id': 22,
    'name': 'Joris Bakker',
    'shirt_number': 4,
    'position': 'CB',
    'avatar_url': null,
    'attendance_rate': 60.0,
    'attendance_match_rate': 50.0,
    'attendance_training_rate': 70.0,
    'minutes': 400,
    'goals': 1,
    'assists': 5,
    'yellow': 0,
    'red': 1,
    'matches_played': 6,
    'flag_minutes': 90,
    'flag_shifts': 2,
    'titles': <Object>[],
    'training_points': 3,
  });

  static Map<String, dynamic> data([Map<String, dynamic>? overrides]) => {
    'window': 'season',
    'season_id': 4,
    'seasons': [
      {'id': 4, 'label': '2026/2027', 'is_active': true},
      {'id': 3, 'label': '2025/2026', 'is_active': false},
    ],
    'my_player_id': 14,
    'rows': [samRow(), joriRow()],
    ...?overrides,
  };

  static Map<String, dynamic> response([Map<String, dynamic>? overrides]) => {
    'data': data(overrides),
  };

  /// Voetbal: doelpunten op een tijdlijn, speelminuten, vlagdienst, gele en
  /// rode kaarten.
  static Map<String, dynamic> footballSport() => {
    'key': 'football',
    'label': 'Voetbal',
    'field_variant': 'football',
    'score_model': 'goals',
    'match_stats_mode': 'timeline',
    'supports_flag_duty': true,
    'tracks_scorers': true,
    'allows_draw': true,
    'tracks_playing_time': true,
    'terms': {
      'goal': 'Goal',
      'goals': 'Goals',
      'assist': 'Assist',
      'assists': 'Assists',
    },
    'card_types': [
      {'value': 'yellow', 'label': 'Gele kaart'},
      {'value': 'red', 'label': 'Rode kaart'},
    ],
  };

  /// Volleybal: sets, statistiekenblad na afloop, geen speelminuten, geen
  /// vlag en geen kaarten.
  static Map<String, dynamic> volleyballSport() => {
    'key': 'volleyball',
    'label': 'Volleybal',
    'field_variant': 'volleyball',
    'score_model': 'sets',
    'match_stats_mode': 'postmatch',
    'supports_flag_duty': false,
    'tracks_scorers': false,
    'allows_draw': false,
    'tracks_playing_time': false,
    'terms': {
      'goal': 'Punt',
      'goals': 'Punten',
      'assist': 'Set-up',
      'assists': 'Set-ups',
    },
    'card_types': <Object>[],
  };

  /// Hockey: doelpunten, speelminuten, geen vlag; groen/geel/rood.
  static Map<String, dynamic> hockeySport() => {
    'key': 'hockey',
    'score_model': 'goals',
    'match_stats_mode': 'timeline',
    'supports_flag_duty': false,
    'tracks_scorers': true,
    'tracks_playing_time': true,
    'terms': {'goals': 'Doelpunten', 'assists': 'Assists'},
    'card_types': [
      {'value': 'green', 'label': 'Groene kaart'},
      {'value': 'yellow', 'label': 'Gele kaart'},
      {'value': 'red', 'label': 'Rode kaart'},
    ],
  };
}
