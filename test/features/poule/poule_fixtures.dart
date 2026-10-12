/// JSON uit vogels3 `docs/api/v1/poule.md`.
abstract final class PouleFixtures {
  static Map<String, dynamic> standing({
    int position = 1,
    String team = 'Valleivogels 3',
    bool own = true,
    String? logo = 'https://logoapi.voetbal.nl/logo.php?clubcode=BBCC73H',
    int points = 13,
    int played = 5,
    int goalDiff = 10,
  }) => {
    'position': position,
    'team': team,
    'logo': logo,
    'played': played,
    'won': 4,
    'drawn': 1,
    'lost': 0,
    'goals_for': 14,
    'goals_against': 4,
    'goal_diff': goalDiff,
    'points': points,
    'is_own': own,
  };

  static Map<String, dynamic> result({int? eventId = 812}) => {
    'date': '2026-10-03',
    'time': '14:30',
    'home': "Roda '46 3",
    'away': 'Valleivogels 3',
    'score': '1-3',
    'status': 'Uitgespeeld',
    'is_own': true,
    'home_is_own': false,
    'away_is_own': true,
    'home_logo': 'https://logoapi.voetbal.nl/logo.php?clubcode=BBFW12X',
    'away_logo': 'https://logoapi.voetbal.nl/logo.php?clubcode=BBCC73H',
    'event_id': eventId,
  };

  static Map<String, dynamic> fixture() => {
    'date': '2026-10-17',
    'time': '12:00',
    'home': 'SVL 2',
    'away': 'VVZA 2',
    'score': null,
    'status': 'Gepland',
    'is_own': false,
    'home_is_own': false,
    'away_is_own': false,
    'home_logo': null,
    'away_logo': null,
    'event_id': null,
  };

  static Map<String, dynamic> poule({
    String? fetchedAt = '2026-10-10T14:05:00+02:00',
    List<Map<String, dynamic>>? standing,
    List<Map<String, dynamic>>? results,
    List<Map<String, dynamic>>? fixtures,
  }) => {
    'data': {
      'poule_label': '2e klasse H',
      'competition': 'Mannen zaterdag reserve',
      'fetched_at': fetchedAt,
      'standing':
          standing ??
          [
            PouleFixtures.standing(),
            PouleFixtures.standing(
              position: 2,
              team: 'SVL 2',
              own: false,
              logo: null,
              points: 10,
              goalDiff: -2,
            ),
          ],
      'results':
          results ??
          [
            {
              'date': '2026-10-03',
              'matches': [result()],
            },
          ],
      'fixtures':
          fixtures ??
          [
            {
              'date': '2026-10-17',
              'matches': [fixture()],
            },
          ],
      'results_push': {'enabled': false, 'can_push': true},
    },
  };

  static Map<String, dynamic> neverSynced() => poule(
    fetchedAt: null,
    standing: const [],
    results: const [],
    fixtures: const [],
  );
}
