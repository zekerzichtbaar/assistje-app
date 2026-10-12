/// De JSON-voorbeelden uit vogels3 `docs/api/v1/agreements.md`.
abstract final class AgreementsFixtures {
  static List<Map<String, dynamic>> categories() => [
    {'key': 'training', 'label': 'Trainingen'},
    {'key': 'match', 'label': 'Wedstrijden'},
    {'key': 'attendance', 'label': 'Afmelden & aanwezigheid'},
    {'key': 'locker', 'label': 'Kleedkamer'},
    {'key': 'gear', 'label': 'Materiaal & kleding'},
    {'key': 'money', 'label': 'Geld'},
    {'key': 'conduct', 'label': 'Onderling'},
    {'key': 'other', 'label': 'Overig'},
  ];

  static Map<String, dynamic> overview({
    bool canManage = false,
    String? intro = 'Zo doen we het bij Vogels 3.',
    bool empty = false,
  }) => {
    'data': {
      'groups': empty
          ? <Object>[]
          : [
              {
                'key': 'training',
                'label': 'Trainingen',
                'items': [
                  {
                    'id': 3,
                    'category': 'training',
                    'title': 'Ballen opruimen',
                    'body': null,
                  },
                  {
                    'id': 1,
                    'category': 'training',
                    'title': 'Kwartier voor aanvang aanwezig',
                    'body': 'Omgekleed op het veld.',
                  },
                ],
              },
              {
                'key': 'money',
                'label': 'Geld',
                'items': [
                  {
                    'id': 5,
                    'category': 'money',
                    'title': 'Contributie voor 1 oktober',
                    'body': null,
                  },
                ],
              },
            ],
      'intro': intro,
      'categories': categories(),
      'can_manage': canManage,
    },
  };

  static Map<String, dynamic> saved({
    int id = 7,
    String category = 'training',
    String title = 'Ballen opruimen',
    String? body = 'Na elke training.',
  }) => {
    'data': {
      'id': id,
      'category': category,
      'category_label': 'Trainingen',
      'title': title,
      'body': body,
      'sort_order': 3,
    },
  };
}
