/// Voorbeeldantwoorden uit vogels3 `docs/api/v1/attendance.md` en
/// `guests.md`.
abstract final class AttendanceFixtures {
  static Map<String, dynamic> row({
    String kind = 'player',
    int? playerId,
    int? userId,
    int? shirtNumber,
    required String name,
    String position = '',
    bool isGuest = false,
    String status = 'pending',
    String? vacationNote,
    bool standingAbsent = false,
  }) => {
    'avatar_url': null,
    'kind': kind,
    'player_id': playerId,
    'user_id': userId,
    'shirt_number': shirtNumber,
    'name': name,
    'position': position,
    'is_guest': isGuest,
    'status': status,
    'vacation_note': vacationNote,
    'standing_absent': standingAbsent,
  };

  static Map<String, dynamic> attendance({
    String type = 'training',
    String title = 'Training',
    String? cancelledAt,
    bool canEdit = true,
    List<Map<String, dynamic>>? rows,
  }) => {
    'data': {
      'event': {
        'id': 412,
        'type': type,
        'title': title,
        'starts_at': '2026-10-13T19:30:00+02:00',
        'cancelled_at': cancelledAt,
        'can_edit': canEdit,
      },
      'rows':
          rows ??
          [
            row(
              playerId: 37,
              shirtNumber: 1,
              name: 'Kees Jansen',
              position: 'K',
              status: 'present',
            ),
            row(
              playerId: 42,
              shirtNumber: 9,
              name: 'Piet Bakker',
              position: 'A',
              status: 'absent',
              vacationNote: 'Zuid-Frankrijk',
            ),
            row(
              playerId: 43,
              shirtNumber: 7,
              name: 'Sam de Vries',
              position: 'A',
              standingAbsent: true,
            ),
            row(
              kind: 'staff',
              userId: 51,
              name: 'Trainer Tom',
              position: 'Trainer / staf',
            ),
            row(
              playerId: 88,
              shirtNumber: 30,
              name: 'Gerrit Gast',
              position: 'DF',
              isGuest: true,
              status: 'present',
            ),
          ],
    },
  };

  static Map<String, dynamic> saved({
    int? playerId = 37,
    int? userId,
    String status = 'present',
  }) => {
    'data': {
      'event_id': 412,
      'player_id': playerId,
      'user_id': userId,
      'status': status,
      'reason': null,
      'responded_at': '2026-10-09T21:14:03+02:00',
      'changed_by_user_id': 51,
    },
  };

  static Map<String, dynamic> options({List<Map<String, dynamic>>? list}) => {
    'data':
        list ??
        [
          {'id': 89, 'name': 'Gijs Gast', 'shirt_number': 31, 'position': 'MF'},
        ],
  };

  static Map<String, dynamic> guest({int id = 89, String name = 'Gijs Gast'}) =>
      {
        'data': {
          'id': id,
          'shirt_number': 31,
          'name': name,
          'position': 'MF',
          'is_guest': true,
          'from_team': 'JO19-2',
        },
      };
}
