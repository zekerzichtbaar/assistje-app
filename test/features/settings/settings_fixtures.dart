import '../../helpers/api_fixtures.dart';

/// De JSON-voorbeelden uit vogels3 `docs/api/v1/settings.md`.
abstract final class SettingsFixtures {
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

  static Map<String, dynamic> team({
    String? logoUrl,
    String color = '#006837',
    String name = 'Vogels 3',
    String formation = '4-3-3',
    bool logoFills = false,
  }) => {
    'id': 3,
    'name': name,
    'primary_color': color,
    'logo_url': logoUrl,
    'logo_fills': logoFills,
    'formation': formation,
  };

  static Map<String, dynamic> feature(
    String key, {
    required String name,
    required String category,
    bool enabled = true,
    String? description,
  }) => {
    'key': key,
    'name': name,
    'description': description,
    'category': category,
    'enabled': enabled,
  };

  static List<Map<String, dynamic>> features({
    bool fines = true,
    bool stats = true,
    bool carpool = true,
    bool trainingPoints = true,
    bool dutyHelpers = true,
  }) => [
    feature(
      'fines',
      name: 'Boetepot',
      category: 'Geld',
      enabled: fines,
      description: 'Boetes bijhouden en innen.',
    ),
    feature(
      'carpool',
      name: 'Carpoolen',
      category: 'Vervoer',
      enabled: carpool,
    ),
    feature(
      'stats',
      name: 'Hall of Fame & teamstatistieken',
      category: 'Statistieken',
      enabled: stats,
    ),
    feature(
      'training_points',
      name: 'Trainingspunten',
      category: 'Spelers',
      enabled: trainingPoints,
    ),
    feature(
      'duty_helpers',
      name: 'Hulpouders bij diensten',
      category: 'Diensten',
      enabled: dutyHelpers,
    ),
    feature('messages', name: 'Trainer-broadcasts', category: 'Communicatie'),
  ];

  static Map<String, dynamic> wash() => {
    'id': 12,
    'name': 'Wassen',
    'slug': 'wash',
    'icon': 'TShirt',
    'sort_order': 1,
    'mode': 'individual',
    'scope': 'match',
    'auto_rotate': true,
    'on_unavailable': 'reassign',
    'pool': ['players'],
    'pool_members': <String>[],
  };

  static Map<String, dynamic> canteen() => {
    'id': 13,
    'name': 'Kantine',
    'slug': 'kantine',
    'icon': 'BeerStein',
    'sort_order': 2,
    'mode': 'group',
    'scope': 'free',
    'auto_rotate': false,
    'on_unavailable': 'notify',
    'pool': <String>[],
    'pool_members': <String>[],
  };

  static Map<String, dynamic> settings({
    Map<String, dynamic>? team,
    List<Map<String, dynamic>>? features,
    List<Map<String, dynamic>>? dutyTypes,
    Map<String, dynamic>? rsvp,
    Map<String, dynamic>? guests,
    Map<String, dynamic>? ical,
    int carpoolHours = 4,
    bool attendancePoint = false,
    Map<String, dynamic>? period,
  }) => {
    'team': team ?? SettingsFixtures.team(),
    'formations': ['4-3-3', '4-4-2', '3-5-2'],
    'rsvp':
        rsvp ??
        {
          'mode': 'relative',
          'match_hours': 24,
          'training_hours': 4,
          'weekly_day': null,
          'weekly_time': null,
        },
    'features': features ?? SettingsFixtures.features(),
    'duty_types': dutyTypes ?? [wash(), canteen()],
    'duty_people': [
      {'key': 'p_41', 'name': 'Sanne de Vries', 'kind': 'player'},
      {'key': 'p_42', 'name': 'Kees Kaal', 'kind': 'player'},
      {'key': 'u_7', 'name': 'Tom Trainer', 'kind': 'staff'},
    ],
    'ical':
        ical ??
        {
          'events_url': 'https://assistje.nl/calendar/AbC48/events.ics',
          'trainings_url': 'https://assistje.nl/calendar/AbC48/trainings.ics',
        },
    'carpool': {'reminder_hours': carpoolHours},
    'guests':
        guests ??
        {
          'attendance': 'training',
          'in_fines': false,
          'in_stats': true,
          'staff_in_fines': false,
        },
    'training_points': {'attendance_point': attendancePoint},
    'period':
        period ??
        {
          'mode': 'dates',
          'season_label': '2026/2027',
          'season_starts_on': '2026-08-01',
          'season_ends_on': '2027-07-31',
          'season_expired': false,
          'season_match_count': 22,
          'closed_season': {
            'label': '2025/2026',
            'closed_at': '2026-07-31T23:59:00+02:00',
          },
          'periods': [
            {
              'id': 5,
              'name': 'Periode 1',
              'starts_on': '2026-08-01',
              'ends_on': '2026-11-30',
              'target_matches': 8,
              'is_closed': false,
              'played_matches': 3,
              'award_count': 0,
            },
          ],
        },
  };

  /// `{data: …}` rond [settings].
  static Map<String, dynamic> response([Map<String, dynamic>? settings]) => {
    'data': settings ?? SettingsFixtures.settings(),
  };
}
