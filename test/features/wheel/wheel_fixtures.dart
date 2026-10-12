/// De JSON-voorbeelden uit vogels3 `docs/api/v1/wheel.md` (aangevuld met
/// een tweede speler, een gast en een bankzitter).
abstract final class WheelFixtures {
  static Map<String, dynamic> player(
    int id,
    String name, {
    bool guest = false,
  }) => {
    'key': 'p$id',
    'id': id,
    'user_id': null,
    'name': name,
    'shirt_number': guest ? null : id,
    'is_guest': guest,
    'is_staff': false,
    'avatar_url': null,
  };

  static Map<String, dynamic> staff() => {
    'key': 'u4',
    'id': null,
    'user_id': 4,
    'name': 'Coach Ronald',
    'shirt_number': null,
    'is_guest': false,
    'is_staff': true,
    'avatar_url': null,
  };

  static Map<String, dynamic> spin({
    int id = 31,
    String winner = 'Sam de Vries',
    bool canDelete = true,
    int? eventId = 812,
    int? winnerPlayerId,
    int? winnerUserId,
  }) => {
    'id': id,
    'winner_name': winner,
    'drawn_at': '2026-10-10T11:02:44+02:00',
    'drawn_by': 'Coach Ronald',
    'can_delete': canDelete,
    'event_id': eventId,
    'winner_player_id': ?winnerPlayerId,
    'winner_user_id': ?winnerUserId,
  };

  static Map<String, dynamic> match() => {
    'id': 812,
    'label': 'Vogels 3 - Kraaien 1',
    'date': '12 okt',
    'starts_at': '2026-10-12T14:30:00+02:00',
  };

  static Map<String, dynamic> overview({
    List<Map<String, dynamic>>? spins,
    bool withMatch = true,
    bool withPreset = true,
  }) => {
    'data': {
      'players': [
        player(17, 'Sam de Vries'),
        player(18, 'Kim Bakker'),
        player(21, 'Joep Smit'),
        player(30, 'Gast Gerrit', guest: true),
        staff(),
      ],
      'recent_spins': spins ?? [spin()],
      'upcoming_match': withMatch ? match() : null,
      'preset': withPreset
          ? {
              'label': 'Training',
              'date': 'za 11 okt',
              'present_ids': [17, 18, 99],
              'present_staff_ids': [4],
              'bench_ids': [21],
            }
          : null,
    },
  };
}
