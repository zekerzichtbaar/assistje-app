/// De JSON-voorbeelden uit vogels3 `docs/api/v1/fines.md`.
abstract final class FinesFixtures {
  static Map<String, dynamic> period7() => {
    'id': 7,
    'name': 'Q4 2026',
    'starts_on': '2026-10-01',
    'ends_on': null,
    'closed_at': null,
  };

  static Map<String, dynamic> rowSam({int open = 250, int total = 750}) => {
    'key': 'p17',
    'player_id': 17,
    'user_id': null,
    'name': 'Sam de Vries',
    'shirt_number': 9,
    'avatar_url': 'https://vogels-3.assistje.nl/storage/avatars/abc.jpg',
    'is_staff': false,
    'counting': true,
    'total_cents': total,
    'open_cents': open,
    'count': 2,
  };

  static Map<String, dynamic> rowRonald() => {
    'key': 'u4',
    'player_id': null,
    'user_id': 4,
    'name': 'Coach Ronald',
    'shirt_number': null,
    'avatar_url': null,
    'is_staff': true,
    'counting': true,
    'total_cents': 0,
    'open_cents': 0,
    'count': 0,
  };

  static List<Map<String, dynamic>> fineTypes() => [
    {
      'id': 31,
      'value': 31,
      'label': 'Niet gereageerd (wedstrijd)',
      'default_cents': 250,
      'trigger': 'missed_rsvp_match',
      'trigger_label':
          'Als de deadline van een wedstrijd verstrijkt zonder reactie',
      'archived': false,
    },
    {
      'id': 35,
      'value': 35,
      'label': 'Tas vergeten',
      'default_cents': 100,
      'trigger': null,
      'trigger_label': null,
      'archived': false,
    },
  ];

  static Map<String, dynamic> potEntry12({
    int amount = -1250,
    String description = 'Krat bier',
  }) => {
    'key': 'entry-12',
    'kind': 'entry',
    'id': 12,
    'amount_cents': amount,
    'description': description,
    'occurred_on': '2026-10-04',
    'created_by': 'Coach Ronald',
  };

  /// `GET /teams/{team}/fines` — het voorbeeld, met overschrijfbare velden.
  static Map<String, dynamic> overview([
    Map<String, dynamic> overrides = const {},
  ]) => {
    'data': {
      'period': period7(),
      'periods': [
        {'id': 7, 'name': 'Q4 2026', 'closed_at': null},
        {'id': 6, 'name': 'Q3 2026', 'closed_at': '2026-09-30T21:14:03+02:00'},
      ],
      'rows': [rowSam(), rowRonald()],
      'fine_types': fineTypes(),
      'guests_in_fines': false,
      'staff_in_fines': true,
      'totals': {'open_cents': 250, 'all_cents': 750},
      'pot': {
        'balance_cents': 3750,
        'open_cents': 250,
        'lines': [
          {
            'key': 'period-7',
            'kind': 'fines',
            'id': null,
            'amount_cents': 500,
            'description': 'Betaalde boetes · Q4 2026',
            'occurred_on': '2026-10-09',
            'created_by': null,
          },
          potEntry12(),
          {
            'key': 'settlement-3',
            'kind': 'settlement',
            'id': null,
            'amount_cents': 4500,
            'description': 'Afrekening · Teamuitje',
            'occurred_on': '2026-09-20',
            'created_by': null,
          },
        ],
      },
      'can_manage': false,
      ...overrides,
    },
  };

  /// Overzicht zoals de penningmeester het krijgt.
  static Map<String, dynamic> treasurerOverview([
    Map<String, dynamic> overrides = const {},
  ]) => overview({'can_manage': true, ...overrides});

  static Map<String, dynamic> fine501({String status = 'open'}) => {
    'id': 501,
    'type': 31,
    'type_label': 'Te laat',
    'amount_cents': 250,
    'description': null,
    'status': status,
    'event': {
      'id': 412,
      'title': 'Vogels 3 - Arnhemia 2',
      'starts_at': '2026-10-11T14:30:00+02:00',
    },
    'created_at': '2026-10-11T16:20:41+02:00',
    'created_by': 'Coach Ronald',
  };

  /// `GET /teams/{team}/fines/players/{player}`.
  static Map<String, dynamic> player({
    bool canManage = false,
    List<Map<String, dynamic>>? fines,
  }) => {
    'data': {
      'period': {'id': 7, 'name': 'Q4 2026', 'closed_at': null},
      'player': {
        'id': 17,
        'name': 'Sam de Vries',
        'shirt_number': 9,
        'avatar_url': 'https://vogels-3.assistje.nl/storage/avatars/abc.jpg',
      },
      'fines': fines ?? [fine501()],
      'totals': {'all_cents': 250, 'open_cents': 250},
      'fine_types': <Object>[],
      'can_manage': canManage,
    },
  };

  /// `GET /teams/{team}/fines/staff/{user}`.
  static Map<String, dynamic> staff() => {
    'data': {
      'period': {'id': 7, 'name': 'Q4 2026', 'closed_at': null},
      'player': {
        'id': 4,
        'name': 'Coach Ronald',
        'shirt_number': null,
        'avatar_url': null,
      },
      'fines': <Object>[],
      'totals': {'all_cents': 0, 'open_cents': 0},
      'fine_types': <Object>[],
      'can_manage': true,
    },
  };

  static Map<String, dynamic> _created(int id, int playerId) => {
    'id': id,
    'period_id': 7,
    'player_id': playerId,
    'user_id': null,
    'type': 35,
    'type_label': 'Tas vergeten',
    'amount_cents': 100,
    'description': 'Tas vergeten',
    'status': 'open',
    'paid_at': null,
    'event': null,
    'created_at': '2026-10-11T16:25:00+02:00',
    'created_by': 'Coach Ronald',
  };

  /// `201` op `POST /teams/{team}/fines`.
  static Map<String, dynamic> recorded() => {
    'data': {
      'count': 2,
      'fines': [_created(502, 17), _created(503, 18)],
    },
  };

  /// `200` op `PATCH /teams/{team}/fines/{fine}`.
  static Map<String, dynamic> updated() => {
    'data': {
      'id': 501,
      'period_id': 7,
      'player_id': 17,
      'user_id': null,
      'type': 31,
      'type_label': 'Te laat',
      'amount_cents': 250,
      'description': null,
      'status': 'paid',
      'paid_at': '2026-10-12T09:01:12+02:00',
      'event': {
        'id': 412,
        'title': 'Vogels 3 - Arnhemia 2',
        'starts_at': '2026-10-11T14:30:00+02:00',
      },
      'created_at': '2026-10-11T16:20:41+02:00',
      'created_by': 'Coach Ronald',
    },
  };

  static Map<String, dynamic> potEntryResponse({
    int amount = -1250,
    String description = 'Krat bier',
  }) => {'data': potEntry12(amount: amount, description: description)};

  // ── Beheer (penningmeester) ────────────────────────────────────────────

  static Map<String, dynamic> period8() => {
    'id': 8,
    'name': 'Voorjaar 2027',
    'starts_on': '2026-10-11',
    'ends_on': null,
    'closed_at': null,
  };

  /// `201` op `POST fine-periods`, `200` op `PATCH fine-periods/{period}`.
  static Map<String, dynamic> periodResponse([
    Map<String, dynamic> overrides = const {},
  ]) => {
    'data': {...period8(), ...overrides},
  };

  /// `200` op `POST fine-periods/{period}/close`.
  static Map<String, dynamic> closeResponse() => {
    'data': {
      'id': 7,
      'name': 'Q4 2026',
      'starts_on': '2026-10-01',
      'ends_on': '2026-12-31',
      'closed_at': '2026-12-31T20:03:11+01:00',
    },
    'meta': {
      'active_period': {
        'id': 9,
        'name': 'Q1 2027',
        'starts_on': '2027-01-01',
        'ends_on': null,
        'closed_at': null,
      },
    },
  };

  /// `200` op `PATCH fine-settings`.
  static Map<String, dynamic> settingsResponse() => {
    'data': [
      {...fineTypes().first, 'default_cents': 300},
      fineTypes().last,
    ],
  };

  /// Een rij uit `fine_types` als antwoord op `fine-types`.
  static Map<String, dynamic> fineTypeResponse({
    int id = 36,
    String label = 'Douchen overgeslagen',
    int cents = 500,
    bool archived = false,
  }) => {
    'data': {
      'id': id,
      'value': id,
      'label': label,
      'default_cents': cents,
      'trigger': null,
      'trigger_label': null,
      'archived': archived,
    },
  };
}
