import '../../helpers/api_fixtures.dart';

/// De JSON-voorbeelden uit vogels3 `docs/api/v1/team.md` en `players.md`,
/// plus een (ingekorte) voetbal-`SportProfile::toArray()`.
abstract final class RosterFixtures {
  static Map<String, dynamic> footballSport() => {
    'key': 'football',
    'label': 'Voetbal',
    'field_variant': 'football',
    'tracks_scorers': true,
    'positions': {
      'K': 'Keeper',
      'RB': 'Rechtsback',
      'CB': 'Centrale verdediger',
      'LB': 'Linksback',
      'DM': 'Verdedigende middenvelder',
      'CM': 'Centrale middenvelder',
      'AM': 'Aanvallende middenvelder',
      'RW': 'Rechtsbuiten',
      'ST': 'Spits',
      'LW': 'Linksbuiten',
      'GK': 'Keeper',
    },
    'position_groups': [
      {
        'key': 'gk',
        'label': 'Keepers',
        'codes': ['K', 'GK'],
      },
      {
        'key': 'def',
        'label': 'Verdedigers',
        'codes': ['RB', 'CB', 'LB'],
      },
      {
        'key': 'mid',
        'label': 'Middenvelders',
        'codes': ['DM', 'CM', 'AM'],
      },
      {
        'key': 'att',
        'label': 'Aanvallers',
        'codes': ['RW', 'ST', 'LW'],
      },
    ],
    'terms': {'goals': 'Goals', 'assists': 'Assists'},
    'card_types': [
      {'value': 'yellow', 'label': 'Gele kaart'},
      {'value': 'red', 'label': 'Rode kaart'},
    ],
  };

  /// Een membership (team 3) met de volledige voetbalsport.
  static Map<String, dynamic> membership({
    String role = 'player',
    Map<String, bool> features = const {},
    Map<String, dynamic>? sport,
  }) => {
    ...ApiFixtures.membership(role: role, features: features),
    'sport': sport ?? footballSport(),
  };

  static Map<String, dynamic> sam() => {
    'id': 14,
    'shirt_number': 7,
    'name': 'Sam de Vries',
    'position': 'CM',
    'avatar_url': 'https://test-team.assistje.nl/avatars/thumb/9f2c.jpg',
    'is_guest': false,
    'is_injured': false,
    'is_on_vacation': false,
  };

  static Map<String, dynamic> guestKeeper() => {
    'id': 31,
    'shirt_number': 1,
    'name': 'Gast Keeper',
    'position': 'K',
    'avatar_url': null,
    'is_guest': true,
    'is_injured': false,
    'is_on_vacation': true,
  };

  static Map<String, dynamic> trainerTom() => {
    'id': 3,
    'name': 'Trainer Tom',
    'avatar_url': null,
    'is_on_vacation': false,
  };

  static Map<String, dynamic> roster({
    List<Map<String, dynamic>>? players,
    List<Map<String, dynamic>>? coaches,
  }) => {
    'data': {
      'players': players ?? [sam(), guestKeeper()],
      'coaches': coaches ?? [trainerTom()],
    },
  };

  static Map<String, dynamic> stats({
    int matches = 8,
    int goals = 3,
    double matchRate = 87.5,
  }) => {
    'matches_played': matches,
    'wins': 5,
    'draws': 1,
    'losses': 2,
    'win_pct': 62.5,
    'goals': goals,
    'assists': 2,
    'green': 0,
    'yellow': 1,
    'red': 0,
    'clean_sheets': 2,
    'motm': 1,
    'attendance_match_rate': matchRate,
    'attendance_training_rate': 72.0,
  };

  /// Het voorbeeld uit `players.md` (kijker is geen trainer).
  static Map<String, dynamic> playerDetail() => {
    'data': {
      'player': {
        'id': 14,
        'name': 'Sam de Vries',
        'shirt_number': 7,
        'position': 'CM',
        'is_guest': false,
        'is_injured': false,
        'is_on_vacation': false,
        'from_team': null,
        'avatar_url': 'https://test-team.assistje.nl/avatars/thumb/9f2c.jpg',
        'has_account': true,
        'email': null,
        'invited_at': null,
        'invite_accepted': true,
        'is_trainer': false,
        'abilities': <String>[],
        'is_self': false,
        'is_captain': true,
      },
      'can_manage': false,
      'vacations': <Object>[],
      'standing_absences': null,
      'personal_stats': {
        'season': stats(),
        'career': {
          ...stats(matches: 41, goals: 12, matchRate: 84.1),
          'wins': 22,
          'draws': 7,
          'losses': 12,
          'win_pct': 53.7,
          'assists': 9,
          'yellow': 4,
          'clean_sheets': 9,
          'motm': 5,
          'attendance_training_rate': 70.3,
        },
      },
      'duties': [
        {'slug': 'vlaggen', 'name': 'Vlaggen', 'count': 2},
        {'slug': 'wassen', 'name': 'Wassen', 'count': 1},
      ],
      'achievements': [
        {
          'key': 'hattrick_hero',
          'icon': '🥇',
          'label': 'Hattrick hero',
          'detail': '3 goals in één wedstrijd',
          'count': 1,
        },
      ],
    },
  };

  /// Zelfde speler, gezien door een trainer (`can_manage`): beheervelden
  /// gevuld.
  static Map<String, dynamic> managedPlayerDetail() {
    final body = playerDetail();
    final data = body['data'] as Map<String, dynamic>;
    final player = data['player'] as Map<String, dynamic>;
    player
      ..['email'] = 'sam@example.com'
      ..['invited_at'] = '2026-09-01T10:00:00+02:00'
      ..['invite_accepted'] = false
      ..['has_account'] = false;
    data
      ..['can_manage'] = true
      ..['vacations'] = [
        {
          'id': 5,
          'starts_on': '2026-10-20',
          'ends_on': '2026-10-27',
          'note': 'Skiën',
        },
      ]
      ..['standing_absences'] = {
        'days': [
          {'id': 2, 'weekday': 2},
        ],
        'choices': [2, 4],
      };
    return body;
  }
}
