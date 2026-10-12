/// JSON uit vogels3 `docs/api/v1/absences.md` en `profile.md`.
abstract final class AbsencesFixtures {
  static Map<String, dynamic> vacation({
    int id = 412,
    String startsOn = '2026-10-20',
    String endsOn = '2026-10-27',
    String? note = 'Wintersport',
  }) => {
    'data': {
      'id': id,
      'player_id': 37,
      'user_id': 23,
      'starts_on': startsOn,
      'ends_on': endsOn,
      'note': note,
    },
  };

  static Map<String, dynamic> standingDay({int id = 19, int weekday = 2}) => {
    'data': {
      'id': id,
      'player_id': 37,
      'weekday': weekday,
      'day_name': 'dinsdag',
    },
  };

  static Map<String, dynamic> validation(String field, String message) => {
    'message': message,
    'errors': {
      field: [message],
    },
  };

  static const noPlayer = {'message': 'Geen spelersprofiel gekoppeld.'};
}
