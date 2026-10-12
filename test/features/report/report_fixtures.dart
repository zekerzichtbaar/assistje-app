import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';

/// Antwoorden van de verslag-API (vogels3 `docs/api/v1/report.md`): een
/// doelpuntensport (voetbal, geen blad) en een setsport (volleybal, met
/// statistiekenblad en scoutimport).
abstract final class ReportFixtures {
  static const eventPath = '/teams/3/events/412';
  static const reportPath = '$eventPath/report';
  static const get = 'GET $reportPath';
  static const score = 'PATCH $reportPath/score';
  static const sets = 'PATCH $reportPath/sets';
  static const stats = 'PATCH $reportPath/player-stats';
  static const scout = 'POST $reportPath/scout-preview';
  static const eventGet = 'GET $eventPath';
  static const flagPut = 'PUT $eventPath/flag';

  static const volleyColumns = [
    'points',
    'aces',
    'blocks',
    'sets_played',
    'serve_attempts',
    'serve_errors',
    'reception_attempts',
    'reception_errors',
    'reception_positive',
    'attack_attempts',
    'attack_errors',
    'attack_blocked',
    'attack_kills',
  ];

  static Map<String, dynamic> player(
    int id,
    String name, {
    int? shirt,
    String position = '',
  }) => {
    'id': id,
    'shirt_number': shirt,
    'name': name,
    'position': position,
    'is_guest': false,
  };

  static Map<String, dynamic> _event({bool weAreHome = false}) => {
    'id': 412,
    'title': 'Wedstrijd — Halley DS1',
    'starts_at': '2026-10-11T14:30:00+02:00',
    'home_team': 'Halley DS1',
    'away_team': 'Vogels DS1',
    'we_are_home': weAreHome,
  };

  /// Volleybal: sets, postmatch-blad, scoutimport.
  static Map<String, dynamic> setsData({
    int? home = 1,
    int? away = 3,
    List<List<int>> sets = const [
      [25, 21],
      [19, 25],
      [22, 25],
      [20, 25],
    ],
    bool canImport = true,
    bool withLineup = true,
    List<Map<String, dynamic>>? playerStats,
    bool weAreHome = false,
  }) => {
    'event': _event(weAreHome: weAreHome),
    'score_model': 'sets',
    'home_score': home,
    'away_score': away,
    'max_sets': 5,
    'sets': [
      for (final (i, s) in sets.indexed)
        {'set_number': i + 1, 'home_points': s[0], 'away_points': s[1]},
    ],
    'stats_mode': 'postmatch',
    'stat_columns': volleyColumns,
    'can_import': canImport,
    'lineup': withLineup
        ? [
            {
              'slot_code': 'S',
              'player': player(37, 'Ilse de Bruin', shirt: 4, position: 'S'),
            },
          ]
        : <Object?>[],
    'bench': [player(52, 'Jessie Koolaard', shirt: 12, position: 'OH')],
    'player_stats':
        playerStats ??
        [
          {
            'player_id': 37,
            for (final c in volleyColumns) c: 0,
            'points': 12,
            'aces': 2,
            'blocks': 1,
            'sets_played': 4,
          },
        ],
  };

  /// Voetbal: doelpunten, tijdlijn (geen blad).
  static Map<String, dynamic> goalsData({int? home = 2, int? away = 1}) => {
    'event': {
      ..._event(weAreHome: true),
      'title': 'Wedstrijd — SV Merel 2',
      'home_team': 'VV Vogels 3',
      'away_team': 'SV Merel 2',
    },
    'score_model': 'goals',
    'home_score': home,
    'away_score': away,
    'max_sets': null,
    'sets': <Object?>[],
    'stats_mode': 'timeline',
    'stat_columns': <Object?>[],
    'can_import': false,
    'lineup': [
      {'slot_code': 'GK', 'player': player(11, 'Kees de Keeper', shirt: 1)},
    ],
    'bench': <Object?>[],
    'player_stats': <Object?>[],
  };

  static Map<String, dynamic> wrap(Map<String, dynamic> data) => {'data': data};

  /// `flag` uit het event-detail (vogels3 `report.md` PUT flag-voorbeeld).
  static Map<String, dynamic> flag({
    List<Map<String, dynamic>> shifts = const [
      {'key': 'p37', 'player_id': 37, 'user_id': null, 'from_minute': 0},
      {'key': 'u8', 'player_id': null, 'user_id': 8, 'from_minute': 45},
    ],
  }) => {
    'shifts': shifts,
    'names': ['Kees Jansen', 'Trainer Tom'],
    'mine': false,
    'match_minutes': 90,
    'pool': [
      {
        'key': 'p37',
        'player_id': 37,
        'user_id': null,
        'name': 'Kees Jansen',
        'guest': false,
        'staff': false,
      },
      {
        'key': 'u8',
        'player_id': null,
        'user_id': 8,
        'name': 'Trainer Tom',
        'guest': false,
        'staff': true,
      },
      {
        'key': 'p52',
        'player_id': 52,
        'user_id': null,
        'name': 'Gijs Gast',
        'guest': true,
        'staff': false,
      },
    ],
  };

  /// Het event-detail, alleen wat het verslag leest (`flag`).
  static Map<String, dynamic> eventDetail({Map<String, dynamic>? flag}) => {
    'data': {
      'id': 412,
      'type': 'match',
      'title': 'Wedstrijd — SV Merel 2',
      'starts_at': '2026-10-11T14:30:00+02:00',
      'flag': flag,
    },
  };

  /// Een `PUT flag`-handler die de beurten terugrekent zoals de server.
  static FakeHandler echoFlag() => (request) {
    final body = request.body! as Map<String, dynamic>;
    final shifts =
        [
          for (final s in body['shifts'] as List)
            {
              'key': (s as Map)['player_id'] != null
                  ? 'p${s['player_id']}'
                  : 'u${s['user_id']}',
              'player_id': s['player_id'],
              'user_id': s['user_id'],
              'from_minute': s['from_minute'],
            },
        ]..sort(
          (a, b) =>
              (a['from_minute']! as int).compareTo(b['from_minute']! as int),
        );
    return FakeResponse(200, {'data': flag(shifts: shifts)});
  };

  /// Scout-preview: twee ploegen, wij (index 1) met één gekoppelde en één
  /// onbekende speler.
  static Map<String, dynamic> scoutPreview({int? ourTeamIndex = 1}) => {
    'data': {
      'sets': [
        {'home': 25, 'away': 21},
        {'home': 19, 'away': 25},
        {'home': 22, 'away': 25},
      ],
      'teams': [
        {
          'name': 'Halley DS1',
          'players': [
            {
              'shirt_number': 3,
              'name': 'Tegenstander',
              'stats': {'points': 8},
              'player_id': null,
              'matched_on': null,
            },
          ],
        },
        {
          'name': 'Vogels DS1',
          'players': [
            {
              'shirt_number': 4,
              'name': 'Ilse de Bruin',
              'stats': {'points': 14, 'aces': 3, 'blocks': 2},
              'player_id': 37,
              'matched_on': 'shirt_number',
            },
            {
              'shirt_number': 99,
              'name': 'Onbekend',
              'stats': {'points': 1},
              'player_id': null,
              'matched_on': null,
            },
          ],
        },
      ],
      'our_team_index': ourTeamIndex,
      'roster': [
        {'id': 37, 'name': 'Ilse de Bruin', 'shirt_number': 4},
        {'id': 52, 'name': 'Jessie Koolaard', 'shirt_number': 12},
      ],
    },
  };

  /// Lid met (of zonder) de lineup-bevoegdheid.
  static Map<String, dynamic> membership({bool editor = true}) =>
      ApiFixtures.membership(
        role: editor ? 'trainer' : 'player',
        abilities: editor ? const ['lineup'] : const [],
      );
}
