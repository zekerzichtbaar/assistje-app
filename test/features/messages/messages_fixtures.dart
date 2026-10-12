/// De JSON-voorbeelden uit vogels3 `docs/api/v1/messages.md`.
abstract final class MessagesFixtures {
  static Map<String, dynamic> message({
    int id = 31,
    String title = 'Training afgelast',
    String body = 'Veld onbespeelbaar, we zien elkaar zaterdag.',
    String? url = '/events/412',
    String? sentAt = '2026-10-09T17:42:10+02:00',
    int recipients = 18,
    String? sender = 'Coach Ronald',
  }) => {
    'id': id,
    'title': title,
    'body': body,
    'url': url,
    'sent_at': sentAt,
    'recipients_count': recipients,
    'sender_name': sender,
  };

  static Map<String, dynamic> setting({
    String key = 'birthday',
    String label = 'Verjaardag',
    bool enabled = true,
    String titleTemplate = '',
    String bodyTemplate = '',
    List<String> placeholders = const ['name', 'age'],
    bool templated = true,
  }) => {
    'key': key,
    'label': label,
    'enabled': enabled,
    'title_template': titleTemplate,
    'body_template': bodyTemplate,
    'placeholders': placeholders,
    'templated': templated,
  };

  static List<Map<String, dynamic>> settings({bool birthdayEnabled = true}) => [
    setting(enabled: birthdayEnabled),
    setting(
      key: 'rsvp_late_cancel',
      label: 'Late afmelding (naar trainers & penningmeester)',
      enabled: false,
      placeholders: const [],
      templated: false,
    ),
  ];

  static Map<String, dynamic> overview({
    bool empty = false,
    bool birthdayEnabled = true,
    List<Map<String, dynamic>>? messages,
  }) => {
    'data': {
      'messages': messages ?? (empty ? <Object>[] : [message()]),
      'auto_settings': settings(birthdayEnabled: birthdayEnabled),
      'auto_history': empty
          ? <Object>[]
          : [
              {
                'type': 'BirthdayNotification',
                'label': 'Verjaardag',
                'title': 'Gefeliciteerd Sam!',
                'sent_at': '2026-10-01T09:00:00+02:00',
                'recipients_count': 17,
              },
            ],
      'link_targets': [
        {
          'label': 'Pagina',
          'options': [
            {'value': '/agenda', 'label': 'Agenda'},
            {'value': '/team', 'label': 'Teamgenoten'},
          ],
        },
        {
          'label': 'Uit de agenda',
          'options': [
            {'value': '/events/412', 'label': 'za 11 okt 14:30 · Vogels 3'},
          ],
        },
      ],
    },
  };

  static Map<String, dynamic> sent({int recipients = 18}) => {
    'data': message(
      id: 32,
      title: 'Bal mee',
      body: 'Iedereen een bal mee zaterdag.',
      url: '/agenda',
      sentAt: '2026-10-10T12:03:44+02:00',
      recipients: recipients,
    ),
  };

  static Map<String, dynamic> settingRow({
    bool enabled = false,
    String titleTemplate = '',
  }) => {'data': setting(enabled: enabled, titleTemplate: titleTemplate)};
}
