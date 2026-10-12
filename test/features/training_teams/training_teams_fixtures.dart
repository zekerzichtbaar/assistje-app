/// Antwoorden van `docs/api/v1/training-teams.md` (vogels3), voor de tests.
abstract final class TrainingTeamsFixtures {
  static Map<String, dynamic> player({
    required int id,
    required String name,
    String? side,
    String? position,
    int? strength,
    num? derived,
  }) => {
    'id': id,
    'name': name,
    'side': side,
    'position': position,
    'strength': strength,
    'derived': derived,
  };

  /// Drie aanwezigen: Kees (a), Piet (b), Tim (bank).
  static List<Map<String, dynamic>> drawnPlayers() => [
    player(
      id: 37,
      name: 'Kees Jansen',
      side: 'a',
      position: 'MF',
      strength: 4,
      derived: 3.6,
    ),
    player(id: 41, name: 'Piet de Vries', side: 'b', derived: 2),
    player(id: 52, name: 'Tim Bakker'),
  ];

  static List<Map<String, dynamic>> benchPlayers() => [
    player(id: 37, name: 'Kees Jansen', position: 'MF', strength: 4),
    player(id: 41, name: 'Piet de Vries'),
    player(id: 52, name: 'Tim Bakker'),
  ];

  static Map<String, dynamic> scoringRow({
    required int id,
    required String name,
    int? shirtNumber,
    int? scored,
    int points = 1,
  }) => {
    'id': id,
    'name': name,
    'shirt_number': shirtNumber,
    'avatar_url': null,
    'scored': scored,
    'points': points,
  };

  static Map<String, dynamic> screen({
    bool mayAssign = true,
    bool tracksPoints = true,
    bool tracksTeams = true,
    String basis = 'strength',
    Object? scores,
    List<Map<String, dynamic>>? players,
    List<Map<String, dynamic>>? scoring,
    List<Map<String, dynamic>>? available,
  }) => {
    'data': {
      'event': {
        'id': 512,
        'title': 'Training',
        'starts_at': '2026-10-14T19:30:00+02:00',
      },
      'sides': ['a', 'b', 'c', 'd', 'e', 'f'],
      'max_teams': 6,
      'teams': {
        'may_assign': mayAssign,
        'tracks_points': tracksPoints,
        'tracks_teams': tracksTeams,
        'basis': basis,
        'scores': scores ?? {'a': 3, 'b': 0},
        'players': players ?? drawnPlayers(),
      },
      'scoring':
          scoring ??
          [
            scoringRow(
              id: 37,
              name: 'Kees Jansen',
              shirtNumber: 8,
              scored: 3,
              points: 4,
            ),
            scoringRow(id: 41, name: 'Piet de Vries', shirtNumber: 9),
          ],
      'scoring_available':
          available ??
          [
            {'id': 60, 'name': 'Bas Bank', 'shirt_number': 14},
          ],
    },
  };
}
