/// Voorbeeld-JSON uit vogels3 `docs/api/v1/notifications.md` en
/// `docs/api/v1/notification-preferences.md`.
abstract final class NotificationFixtures {
  static const String lineupId = '9b1f6c1e-6a2d-4c55-9a3e-0f3c2f0b8d11';

  /// De melding uit het voorbeeld, met optionele afwijkingen.
  static Map<String, dynamic> notification({
    String id = lineupId,
    String? type = 'lineup_published',
    String title = '📋 De opstelling is bekend',
    String body = 'Zaterdag tegen VV Noord: je staat in de basis.',
    String? url = '/events/123/lineup',
    bool read = false,
    String createdAt = '2026-10-09T18:02:11+02:00',
  }) => {
    'id': id,
    'type': type,
    'title': title,
    'body': body,
    'url': url,
    'link': url == null ? null : 'https://vogels-3.assistje.nl$url',
    'read': read,
    'read_at': read ? '2026-10-09T18:05:40+02:00' : null,
    'created_at': createdAt,
  };

  static Map<String, dynamic> page({
    List<Map<String, dynamic>>? items,
    int currentPage = 1,
    int lastPage = 1,
    int perPage = 20,
    int? total,
    int? unread,
  }) {
    final data = items ?? [notification()];
    return {
      'data': data,
      'meta': {
        'current_page': currentPage,
        'last_page': lastPage,
        'per_page': perPage,
        'total': total ?? data.length,
        'unread_count': unread ?? data.where((n) => n['read'] != true).length,
      },
    };
  }

  /// [count] meldingen met id `n-<offset+i>`, nieuwste eerst.
  static List<Map<String, dynamic>> many(
    int count, {
    int offset = 0,
    bool read = false,
  }) => [
    for (var i = 0; i < count; i++)
      notification(
        id: 'n-${offset + i}',
        title: 'Melding ${offset + i}',
        body: 'Tekst ${offset + i}',
        read: read,
      ),
  ];

  static Map<String, dynamic> readResponse({int unread = 3}) => {
    'data': notification(read: true),
    'meta': {'unread_count': unread},
  };

  static Map<String, dynamic> readAllResponse({int marked = 3}) => {
    'data': {'marked': marked},
    'meta': {'unread_count': 0},
  };

  // ── Pushvoorkeuren ────────────────────────────────────────────────────────

  /// De 17 categorieën in schermvolgorde: `(key, label, poule_only)`.
  static const List<(String, String, bool)> catalog = [
    ('duty_reminder', 'Diensten', false),
    ('carpool_reminder', 'Rijden', false),
    ('rsvp_deadline', 'Reageren', false),
    ('lineup', 'Opstelling', false),
    ('match_report_reminder', 'Wedstrijdverslag', false),
    ('live_clock_reminder', 'Klok starten', false),
    ('player_status', 'Spelersstatus', false),
    ('rsvp_late_cancel', 'Late afmelding', false),
    ('rsvp_late_join', 'Late aanmelding', false),
    ('poule_results', 'Uitslagen in de poule', true),
    ('title_change', 'Titelstrijd', false),
    ('birthday', 'Verjaardagen', false),
    ('season_ending', 'Einde seizoen', false),
    ('motm', 'Man of the match', false),
    ('live', 'Live wedstrijd', false),
    ('duty_replacement', 'Vervanging dienst', false),
    ('duty_unavailable', 'Dienst afgezegd', false),
  ];

  static Map<String, dynamic> preferences({
    Map<String, bool> overrides = const {},
  }) {
    bool defaultOf(String key) => key != 'poule_results';
    bool valueOf(String key) => overrides[key] ?? defaultOf(key);
    return {
      'data': {
        'preferences': {for (final (key, _, _) in catalog) key: valueOf(key)},
        'types': [
          for (final (key, label, pouleOnly) in catalog)
            {
              'key': key,
              'label': label,
              'description': 'Uitleg bij $label.',
              'poule_only': pouleOnly,
              'enabled': valueOf(key),
              'default': defaultOf(key),
            },
        ],
      },
    };
  }
}
