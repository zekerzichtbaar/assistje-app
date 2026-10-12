/// De JSON-voorbeelden uit vogels3 `docs/api/v1/savings.md`.
abstract final class SavingsFixtures {
  /// `GET /teams/{team}/savings`.
  static Map<String, dynamic> overview({
    bool canManage = false,
    List<Map<String, dynamic>>? pots,
  }) => {
    'data': {
      'pots':
          pots ??
          [
            {
              'id': 3,
              'name': 'Trainingskamp',
              'amount_cents': 4000,
              'goal_cents': 440000,
              'months': 11,
              'member_count': 14,
              'saved_cents': 96000,
            },
          ],
      'can_manage': canManage,
    },
  };

  static Map<String, dynamic> event412({bool cancelled = false}) => {
    'id': 412,
    'title': 'Eindfeest',
    'starts_at': '2026-11-21T19:00:00+01:00',
    'cancelled': cancelled,
  };

  /// De kop van de eenmalige pot 7 (Eindfeest).
  static Map<String, dynamic> pot7({
    bool cancelled = false,
    int? actualCostCents,
    String? settledOn,
  }) => {
    'id': 7,
    'name': 'Eindfeest',
    'amount_cents': 2500,
    'goal_cents': null,
    'months': 1,
    'starts_on': '2026-11-01',
    'scope': 'event',
    'one_off': true,
    'event': event412(cancelled: cancelled),
    'actual_cost_cents': actualCostCents,
    'settled_on': settledOn,
  };

  /// `GET /teams/{team}/savings/7` — het voorbeeld (eenmalig, op een event).
  static Map<String, dynamic> oneOffDetail({
    bool canManage = true,
    bool cancelled = false,
    bool refunded = false,
    int? actualCostCents,
    String? settledOn,
    List<Map<String, dynamic>>? payments,
  }) => {
    'data': {
      'pot': pot7(
        cancelled: cancelled,
        actualCostCents: actualCostCents,
        settledOn: settledOn,
      ),
      'fines_enabled': true,
      'periods': ['2026-11'],
      'participants': [
        {
          'key': 'p17',
          'name': 'Sam de Vries',
          'kind': 'player',
          'shirt_number': 7,
          'refund': false,
          'refund_reason': null,
          'refunded': false,
        },
        {
          'key': 'p21',
          'name': 'Joris Bakker',
          'kind': 'player',
          'shirt_number': 9,
          'refund': true,
          'refund_reason': 'absent',
          'refunded': refunded,
        },
        {
          'key': 'u4',
          'name': 'Coach Ronald',
          'kind': 'staff',
          'shirt_number': null,
          'refund': false,
          'refund_reason': null,
          'refunded': false,
        },
      ],
      'payments':
          payments ??
          [
            {'key': 'p17', 'ym': '2026-11', 'cents': 2500},
            {'key': 'p21', 'ym': '2026-11', 'cents': 2500},
          ],
      'can_manage': canManage,
    },
  };

  /// Maandpot 3 (Trainingskamp): 3 maanden, 2 deelnemers.
  static Map<String, dynamic> monthlyDetail({
    bool canManage = false,
    List<Map<String, dynamic>>? payments,
  }) => {
    'data': {
      'pot': {
        'id': 3,
        'name': 'Trainingskamp',
        'amount_cents': 4000,
        'goal_cents': 24000,
        'months': 3,
        'starts_on': '2026-09-01',
        'scope': 'all_staff',
        'one_off': false,
        'event': null,
        'actual_cost_cents': null,
        'settled_on': null,
      },
      'fines_enabled': false,
      'periods': ['2026-09', '2026-10', '2026-11'],
      'participants': [
        {
          'key': 'p17',
          'name': 'Sam de Vries',
          'kind': 'player',
          'shirt_number': 7,
          'refund': false,
          'refund_reason': null,
          'refunded': false,
        },
        {
          'key': 'u4',
          'name': 'Coach Ronald',
          'kind': 'staff',
          'shirt_number': null,
          'refund': false,
          'refund_reason': null,
          'refunded': false,
        },
      ],
      'payments':
          payments ??
          [
            {'key': 'p17', 'ym': '2026-09', 'cents': 4000},
            {'key': 'p17', 'ym': '2026-10', 'cents': 3500},
            {'key': 'u4', 'ym': '2026-09', 'cents': 4000},
          ],
      'can_manage': canManage,
    },
  };

  /// `GET /teams/{team}/savings/create`.
  static Map<String, dynamic> createOptions({int? presetEventId}) => {
    'data': {
      'people': {
        'players': [
          {
            'key': 'p17',
            'name': 'Sam de Vries',
            'shirt_number': 7,
            'is_guest': false,
          },
          {
            'key': 'p30',
            'name': 'Gastspeler Tim',
            'shirt_number': null,
            'is_guest': true,
          },
        ],
        'staff': [
          {'key': 'u4', 'name': 'Coach Ronald'},
        ],
      },
      'activities': [event412()],
      'preset_event_id': presetEventId,
    },
  };

  /// `GET /teams/{team}/savings/9/edit`.
  static Map<String, dynamic> editOptions() => {
    'data': {
      'people': {
        'players': [
          {
            'key': 'p17',
            'name': 'Sam de Vries',
            'shirt_number': 7,
            'is_guest': false,
          },
          {
            'key': 'p21',
            'name': 'Joris Bakker',
            'shirt_number': 9,
            'is_guest': false,
          },
        ],
        'staff': [
          {'key': 'u4', 'name': 'Coach Ronald'},
        ],
      },
      'activities': <Object>[],
      'pot': {
        'event_id': null,
        'id': 9,
        'name': 'Weekendje weg',
        'scope': 'custom',
        'include_guests': false,
        'amount': 12.5,
        'goal': 300,
        'start_month': '2026-11',
        'months': 6,
        'members': ['p17', 'p21', 'u4'],
      },
    },
  };

  /// De kop van pot 9 (antwoord op aanmaken/wijzigen).
  static Map<String, dynamic> pot9Response() => {
    'data': {
      'id': 9,
      'name': 'Weekendje weg',
      'amount_cents': 1250,
      'goal_cents': 30000,
      'months': 6,
      'starts_on': '2026-11-01',
      'scope': 'custom',
      'one_off': false,
      'event': null,
      'actual_cost_cents': null,
      'settled_on': null,
    },
  };

  /// Antwoord op afrekenen (pot 7).
  static Map<String, dynamic> settledResponse({int? cost = 41234}) => {
    'data': pot7(
      actualCostCents: cost,
      settledOn: cost == null ? null : '2026-10-01',
    ),
  };

  static Map<String, dynamic> toggleResponse({
    String key = 'p17',
    String ym = '2026-11',
    bool paid = true,
    int? cents = 2500,
  }) => {
    'data': {'key': key, 'ym': ym, 'paid': paid, 'cents': cents},
  };
}
