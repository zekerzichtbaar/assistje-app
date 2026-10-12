/// Voorbeeld-JSON uit vogels3 `docs/api/v1/stats.md` (Hall of Fame,
/// letterlijk) en varianten (periodes, gedeelde titel, volleybal).
abstract final class HallOfFameFixtures {
  static const _samAvatar =
      'https://test-team.assistje.nl/avatars/thumb/9f2c.jpg';

  /// Het voorbeeld uit de docs.
  static Map<String, dynamic> data([Map<String, dynamic>? overrides]) => {
    'season_id': 4,
    'seasons': [
      {'id': 4, 'label': '2026/2027', 'is_active': true},
    ],
    'period_id': null,
    'periods': [
      {
        'id': 2,
        'name': 'Blok 1',
        'starts_on': '2026-08-15',
        'ends_on': '2026-10-31',
        'is_closed': false,
      },
    ],
    'period_awards': <Object>[],
    'titles': [
      {
        'key': 'top_scorer',
        'label': 'Topscorer',
        'icon': '⚽',
        'group': 'season',
        'holder': {
          'player_id': 14,
          'name': 'Sam de Vries',
          'avatar_url': _samAvatar,
        },
        'holders': <Object>[],
        'value': '3',
        'caption': 'goals',
      },
    ],
    'top_scorers': [
      {
        'player_id': 14,
        'name': 'Sam de Vries',
        'goals': 3,
        'avatar_url': _samAvatar,
      },
    ],
    'top_assisters': <Object>[],
    'top_flaggers': [
      {
        'player_id': 22,
        'name': 'Joris Bakker',
        'minutes': 90,
        'shifts': 2,
        'avatar_url': null,
      },
    ],
    'post_match_leaderboards': null,
    'top_motm': [
      {
        'player_id': 14,
        'name': 'Sam de Vries',
        'wins': 2,
        'avatar_url': _samAvatar,
      },
    ],
    'players_with_badges': [
      {
        'player_id': 14,
        'name': 'Sam de Vries',
        'shirt_number': 7,
        'avatar_url': _samAvatar,
        'badges': [
          {'key': 'hattrick_hero', 'icon': '🥇', 'label': 'Hattrick hero'},
        ],
      },
    ],
    'training_points_enabled': false,
    'top_training_points': <Object>[],
    ...?overrides,
  };

  static Map<String, dynamic> response([Map<String, dynamic>? overrides]) => {
    'data': data(overrides),
  };

  /// Seizoensweergave met twee seizoenen, een afgesloten periode met
  /// erelijst, een gedeelde "nu"-titel en trainingspunten aan.
  static Map<String, dynamic> rich([Map<String, dynamic>? overrides]) => data({
    'seasons': [
      {'id': 4, 'label': '2026/2027', 'is_active': true},
      {'id': 3, 'label': '2025/2026', 'is_active': false},
    ],
    'periods': [
      {
        'id': 1,
        'name': 'Blok 0',
        'starts_on': '2026-06-01',
        'ends_on': '2026-08-14',
        'is_closed': true,
      },
      {
        'id': 2,
        'name': 'Blok 1',
        'starts_on': '2026-08-15',
        'ends_on': null,
        'is_closed': false,
      },
    ],
    'period_awards': [
      {
        'period_id': 1,
        'period_name': 'Blok 0',
        'winners': [
          {
            'title_key': 'top_scorer',
            'label': 'Topscorer',
            'icon': '⚽',
            'value': 5,
            'player_id': 22,
            'name': 'Joris Bakker',
            'avatar_url': null,
          },
        ],
      },
    ],
    'titles': [
      ...(data()['titles'] as List),
      {
        'key': 'iron_man',
        'label': 'IJzeren man',
        'icon': '🔥',
        'group': 'now',
        'holder': {'player_id': 14, 'name': 'Sam de Vries', 'avatar_url': null},
        'holders': [
          {'player_id': 14, 'name': 'Sam de Vries', 'avatar_url': null},
          {'player_id': 22, 'name': 'Joris Bakker', 'avatar_url': null},
        ],
        'value': '6',
        'caption': 'op rij aanwezig',
      },
    ],
    'training_points_enabled': true,
    'top_training_points': [
      {'player_id': 22, 'name': 'Joris Bakker', 'points': 12},
    ],
    ...?overrides,
  });

  /// Volleybal: geen scorers/vlag, wel het statistiekenblad.
  static Map<String, dynamic> volleyball() => data({
    'top_scorers': null,
    'top_assisters': null,
    'top_flaggers': null,
    'post_match_leaderboards': {
      'points': [
        {'player_id': 31, 'name': 'Lotte', 'points': 41, 'avatar_url': null},
      ],
      'aces': <Object>[],
      'blocks': [
        {'player_id': 32, 'name': 'Mila', 'blocks': '7', 'avatar_url': null},
      ],
    },
  });
}
