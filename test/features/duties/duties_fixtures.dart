/// De JSON-voorbeelden uit vogels3 `docs/api/v1/duties.md`.
abstract final class DutiesFixtures {
  static List<Map<String, dynamic>> dutyTypes() => [
    {
      'id': 1,
      'name': 'Wassen',
      'slug': 'wassen',
      'icon': 'shirt',
      'mode': 'group',
      'scope': 'free',
      'auto_rotate': false,
    },
    {
      'id': 3,
      'name': 'Vlaggen',
      'slug': 'vlaggen',
      'icon': 'flag',
      'mode': 'individual',
      'scope': 'match',
      'auto_rotate': true,
    },
  ];

  static Map<String, dynamic> assignment({
    int id = 120,
    String? markedDoneAt,
    String? notes,
  }) => {
    'id': id,
    'scheduled_for': '2026-10-12',
    'starts_at': null,
    'ends_at': null,
    'notes': notes,
    'group_id': null,
    'group_name': null,
    'player_id': 17,
    'member_key': 'p_17',
    'player_name': 'Sam de Vries',
    'event_id': 812,
    'event_label': 'Vogels 3 – Kraaien 1',
    'marked_done_at': markedDoneAt,
  };

  /// Het overzicht van het individuele wedstrijdtype "vlaggen".
  static Map<String, dynamic> individual({
    List<Map<String, dynamic>>? assignments,
    List<Map<String, dynamic>>? types,
  }) => {
    'data': {
      'type': 'vlaggen',
      'duty_type_id': 3,
      'duty_type_mode': 'individual',
      'duty_type_scope': 'match',
      'duty_type_auto_rotate': true,
      'duty_type_pool': ['players'],
      'duty_types': types ?? dutyTypes(),
      'groups': <Object>[],
      'assignments': assignments ?? [assignment()],
      'all_people': [
        {
          'key': 'p_17',
          'name': 'Sam de Vries',
          'kind': 'player',
          'is_trainer_only': false,
          'count': 2,
        },
        {
          'key': 'p_18',
          'name': 'Kim Jansen',
          'kind': 'player',
          'is_trainer_only': false,
          'count': 1,
        },
      ],
      'pool_people': [
        {'key': 'p_17', 'name': 'Sam de Vries', 'kind': 'player'},
        {'key': 'u_4', 'name': 'Coach Ronald', 'kind': 'staff'},
      ],
      'matches': [
        {
          'id': 812,
          'label': 'Vogels 3 – Kraaien 1',
          'date': '2026-10-12',
          'starts_at': '2026-10-12T14:30:00+02:00',
        },
        {
          'id': 815,
          'label': 'Merels 2 – Vogels 3',
          'date': '2026-10-19',
          'starts_at': '2026-10-19T12:00:00+02:00',
        },
      ],
    },
  };

  static Map<String, dynamic> group({
    int id = 7,
    String name = 'Groep A',
    int count = 4,
  }) => {
    'id': id,
    'name': name,
    'last_assigned_at': '2026-10-01T20:15:00+02:00',
    'count': count,
    'members': [
      {'key': 'u_4', 'name': 'Coach Ronald'},
      {'key': 'p_17', 'name': 'Sam de Vries'},
    ],
  };

  /// Het overzicht van de losse groepsdienst "wassen".
  static Map<String, dynamic> groups({
    List<Map<String, dynamic>>? groups,
    List<Map<String, dynamic>>? assignments,
  }) => {
    'data': {
      'type': 'wassen',
      'duty_type_id': 1,
      'duty_type_mode': 'group',
      'duty_type_scope': 'free',
      'duty_type_auto_rotate': false,
      'duty_type_pool': ['players', 'staff'],
      'duty_types': dutyTypes(),
      'groups':
          groups ??
          [
            group(),
            {...group(id: 8, name: 'Groep B', count: 3), 'members': <Object>[]},
          ],
      'assignments':
          assignments ??
          [
            {
              ...assignment(id: 130),
              'scheduled_for': '2026-10-14',
              'starts_at': '19:00',
              'ends_at': '20:00',
              'group_id': 7,
              'group_name': 'Groep A',
              'player_id': null,
              'member_key': null,
              'player_name': null,
              'event_id': null,
              'event_label': null,
            },
          ],
      'all_people': [
        {
          'key': 'p_17',
          'name': 'Sam de Vries',
          'kind': 'player',
          'is_trainer_only': false,
          'count': 2,
        },
        {
          'key': 'u_4',
          'name': 'Coach Ronald',
          'kind': 'staff',
          'is_trainer_only': true,
          'count': 0,
        },
      ],
      'pool_people': <Object>[],
      'matches': <Object>[],
    },
  };

  static Map<String, dynamic> savedGroup() => {
    'data': {...group(), 'duty_type_id': 1, 'sort_order': 3},
  };

  /// Het individuele wedstrijdtype, maar als "Eén of meer personen" (`multi`,
  /// bv. rijden).
  static Map<String, dynamic> multi() {
    final base = individual();
    final data = base['data'] as Map<String, dynamic>;
    return {
      'data': {
        ...data,
        'type': 'rijden',
        'duty_type_id': 5,
        'duty_type_mode': 'multi',
        'duty_type_auto_rotate': false,
        'duty_types': [
          ...dutyTypes(),
          {
            'id': 5,
            'name': 'Rijden',
            'slug': 'rijden',
            'icon': 'car',
            'mode': 'multi',
            'scope': 'match',
            'auto_rotate': false,
          },
        ],
      },
    };
  }

  static Map<String, dynamic> stored({
    String message = 'Toewijzing aangemaakt.',
  }) => {
    'data': {
      'message': message,
      'duty_type_id': 3,
      'assignments': [assignment()],
    },
  };

  static Map<String, dynamic> autoAssigned() => {
    'data': {
      'message': '2 wedstrijden ingedeeld.',
      'count': 2,
      'duty_type_id': 3,
      'assignments': [assignment()],
    },
  };

  static Map<String, dynamic> savedAssignment({String? markedDoneAt}) => {
    'data': {
      ...assignment(markedDoneAt: markedDoneAt, notes: 'Vlag meenemen'),
      'player_id': 18,
      'member_key': 'p_18',
      'player_name': 'Kim Jansen',
      'duty_type_id': 3,
      'user_id': null,
    },
  };

  static Map<String, dynamic> eventAssigned() => {
    'data': {
      'message': 'Vlaggen toegewezen.',
      'event_id': 812,
      'duty_type_id': 3,
      'assignments': [assignment()],
    },
  };

  /// Eén rij uit `duty-overview` (`App\Support\DutyRows`).
  static Map<String, dynamic> overviewRow({
    int dutyId = 120,
    int? eventId = 812,
    bool mine = true,
    bool done = false,
    String title = 'Rijden',
    String icon = 'car',
    String? groupName = 'Sam de Vries, Bram Visser',
    List<String> playerNames = const ['Sam de Vries', 'Bram Visser'],
    String? notes,
  }) => {
    'kind': 'duty',
    'duty_id': dutyId,
    'duty_type_id': 3,
    'event_id': eventId,
    'match_bound': eventId != null,
    'date': '2026-11-08T00:00:00+01:00',
    'duty_type': 'rijden',
    'title': title,
    'icon': icon,
    'group_name': groupName,
    'player_names': playerNames,
    'time_range': null,
    'starts_at': null,
    'ends_at': null,
    'notes': notes,
    'done': done,
    'mine': mine,
    'event_label': eventId == null ? null : 'Kraaien 1 – Vogels 3',
  };

  /// `GET teams/{team}/duty-overview` (het voorbeeld uit de API-doc, plus
  /// een losse beurt zonder wedstrijd en "en nog meer").
  static Map<String, dynamic> overview({
    List<Map<String, dynamic>>? mine,
    List<Map<String, dynamic>>? duties,
  }) => {
    'data': {
      'mine': mine ?? [overviewRow()],
      'duties':
          duties ??
          [
            {
              'id': 3,
              'name': 'Rijden',
              'icon': 'car',
              'mode': 'multi',
              'upcoming': [overviewRow()],
              'upcoming_total': 10,
              'groups': <Object>[],
            },
            {
              'id': 4,
              'name': 'Kantine',
              'icon': 'coffee',
              'mode': 'group',
              'upcoming': [
                overviewRow(
                  dutyId: 140,
                  eventId: null,
                  mine: false,
                  done: true,
                  title: 'Kantine',
                  icon: 'coffee',
                  groupName: 'Groep B',
                  playerNames: const [],
                  notes: 'Sleutel ophalen',
                ),
              ],
              'upcoming_total': 1,
              'groups': [
                {
                  'id': 11,
                  'name': 'Groep A',
                  'members': ['Bram Visser', 'Sam de Vries'],
                  'mine': true,
                },
                {
                  'id': 12,
                  'name': 'Groep B',
                  'members': <String>[],
                  'mine': false,
                },
              ],
            },
          ],
    },
  };
}
