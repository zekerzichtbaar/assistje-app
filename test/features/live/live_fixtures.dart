import '../../helpers/api_fixtures.dart';

/// Antwoorden van de live-API (vogels3 `docs/api/v1/live.md`), met de regels
/// van twee sporten (voetbal: helften + geel/rood; hockey: kwarten +
/// groen/geel/rood) zoals de server ze meestuurt.
abstract final class LiveFixtures {
  static const event = '/teams/3/events/412';
  static const live = '$event/live';
  static const get = 'GET $live';

  static String post(String action) => 'POST $live/$action';

  static Map<String, dynamic> footballRules() => {
    'score_model': 'goals',
    'tracks_scorers': true,
    'periods': {
      'count': 2,
      'label': 'Helft',
      'plural': 'Helften',
      'minutes': 45,
    },
    'card_types': [
      {'type': 'yellow', 'label': 'Gele kaart'},
      {'type': 'red', 'label': 'Rode kaart'},
    ],
    'moment_types': [
      {'type': 'penalty_missed', 'label': 'Penalty gemist'},
      {'type': 'penalty_saved', 'label': 'Penalty gestopt'},
      {'type': 'woodwork', 'label': 'Paal of lat'},
    ],
  };

  /// Voetbal zoals de server hem nu stuurt: de nieuwe momenten, verlenging
  /// `2 × 15` en strafschoppen.
  static Map<String, dynamic> cupRules() => {
    ...footballRules(),
    'moment_types': [
      {'type': 'penalty_awarded', 'label': 'Penalty toegekend'},
      {'type': 'penalty_missed', 'label': 'Penalty gemist'},
      {'type': 'penalty_saved', 'label': 'Penalty gestopt'},
      {'type': 'post', 'label': 'Schot op de paal'},
      {'type': 'crossbar', 'label': 'Schot op de lat'},
      {'type': 'big_chance', 'label': 'Grote kans'},
    ],
    'extra_time': {'count': 2, 'minutes': 15},
    'has_shootout': true,
  };

  /// Een strafschoppenserie: [us]/[opp] als raak (`true`) of mis.
  static Map<String, dynamic> shootout({
    List<bool> us = const [],
    List<bool> opp = const [],
    List<String?>? players,
    String? winner,
  }) => {
    'us': [
      for (var i = 0; i < us.length; i++)
        {
          'scored': us[i],
          'player': players != null && i < players.length ? players[i] : null,
        },
    ],
    'opp': [
      for (final scored in opp) {'scored': scored},
    ],
    'winner': winner,
  };

  /// Afgefloten (na 90 minuten, of na verlenging met [extraTime]).
  static Map<String, dynamic> ended({
    bool extraTime = false,
    Map<String, dynamic>? shootout,
    String? resultSuffix,
  }) => clock(
    isLive: false,
    seconds: (extraTime ? 120 : 90) * 60,
    endedAt: '2026-10-11T16:20:51+02:00',
    period: extraTime ? 4 : 2,
    periodEnds: extraTime ? const [45, 90, 105, 120] : const [45, 90],
    extraTime: extraTime,
    shootout: shootout,
    resultSuffix: resultSuffix,
  );

  static Map<String, dynamic> hockeyRules() => {
    'score_model': 'goals',
    'tracks_scorers': true,
    'periods': {
      'count': 4,
      'label': 'Kwart',
      'plural': 'Kwarten',
      'minutes': 15,
    },
    'card_types': [
      {'type': 'green', 'label': 'Groene kaart'},
      {'type': 'yellow', 'label': 'Gele kaart'},
      {'type': 'red', 'label': 'Rode kaart'},
    ],
    'moment_types': <Map<String, dynamic>>[],
  };

  static Map<String, dynamic> clock({
    bool isLive = true,
    bool running = false,
    String? startedAt,
    int seconds = 12 * 60,
    String? endedAt,
    int period = 1,
    List<int> periodEnds = const [45, 90],
    int regularPeriods = 2,
    bool extraTime = false,
    Map<String, dynamic>? shootout,
    String? resultSuffix,
  }) => {
    'is_live': isLive,
    'running': running,
    'started_at': startedAt,
    'accumulated_seconds': seconds,
    'ended_at': endedAt,
    'period': period,
    'period_ends': periodEnds,
    'regular_periods': regularPeriods,
    'extra_time': extraTime,
    'shootout': shootout,
    'result_suffix': resultSuffix,
  };

  static Map<String, dynamic> goal({
    int id = 1834,
    int minute = 12,
    String type = 'goal',
    String? scorer = 'Bram Visser',
    String? assist = 'Sem de Wit',
    bool penalty = false,
  }) => {
    'id': id,
    'item_key': 'g$id',
    'minute': minute,
    'type': type,
    'penalty': penalty,
    'scorer': scorer,
    'scorer_avatar': null,
    'assist': assist,
    'created_at': 1760185992000 + id,
  };

  static Map<String, dynamic> sub({int id = 77, int minute = 30}) => {
    'id': id,
    'item_key': 's$id',
    'minute': minute,
    'on': 'Sem de Wit',
    'off': 'Bram Visser',
    'created_at': 1760187072000,
  };

  static Map<String, dynamic> card({
    int id = 1840,
    int minute = 33,
    String type = 'yellow',
  }) => {
    'id': id,
    'item_key': 'c$id',
    'minute': minute,
    'type': type,
    'player': 'Sem de Wit',
    'created_at': 1760187252000,
  };

  static Map<String, dynamic> moment({
    int id = 1841,
    int minute = 35,
    String type = 'woodwork',
    String label = 'Paal of lat',
    String side = 'us',
    String? player,
  }) => {
    'id': id,
    'item_key': 'm$id',
    'minute': minute,
    'type': type,
    'label': label,
    'side': side,
    'player': player,
    'created_at': 1760187372000 + id,
  };

  static Map<String, dynamic> pickers() => {
    'has_lineup': true,
    'present': [
      {'id': 21, 'name': 'Sem de Wit', 'shirt_number': 7, 'on_field': true},
      {'id': 20, 'name': 'Bram Visser', 'shirt_number': 9, 'on_field': false},
    ],
    'all_players': [
      {'id': 21, 'name': 'Sem de Wit', 'shirt_number': 7},
      {'id': 20, 'name': 'Bram Visser', 'shirt_number': 9},
    ],
  };

  /// De live-stand (`data`); standaard de voetbalwedstrijd uit de docs, op
  /// rust na 12 minuten (klok stil, zodat labels niet van de tijd afhangen).
  static Map<String, dynamic> data({
    String sport = 'football',
    Map<String, dynamic>? rules,
    Map<String, dynamic>? live,
    int? homeScore = 1,
    int? awayScore = 0,
    bool weAreHome = true,
    String startsAt = '2026-10-11T14:30:00+02:00',
    List<Map<String, dynamic>>? goals,
    List<Map<String, dynamic>>? subs,
    List<Map<String, dynamic>>? cards,
    List<Map<String, dynamic>>? moments,
    Object? reactions,
    bool canReact = true,
    int viewers = 6,
    bool following = false,
    bool canManage = false,
  }) => {
    'sport': sport,
    'event': {
      'id': 412,
      'type': 'match',
      'title': 'Test Team - De Buren',
      'starts_at': startsAt,
      'home_team': 'Test Team',
      'away_team': 'De Buren',
      'home_score': homeScore,
      'away_score': awayScore,
      'we_are_home': weAreHome,
      'sets': <Map<String, dynamic>>[],
      'live': live ?? clock(),
      'share_url': 'https://test-team.assistje.nl/live/Xk3',
    },
    'rules': rules ?? footballRules(),
    'goals': goals ?? [goal()],
    'subs': subs ?? [sub()],
    'cards': cards ?? [card()],
    'moments': moments ?? [moment()],
    'reactions':
        reactions ??
        {
          'g1834': [
            {'emoji': '🔥', 'count': 4, 'mine': true},
          ],
        },
    'can_react': canReact,
    'reaction_emoji': ['🔥', '👏', '😱', '😡', '😂', '🎉'],
    'live_viewers': viewers,
    'following_live': following,
    'can_manage': canManage,
    'pickers': canManage ? pickers() : null,
  };

  static Map<String, dynamic> response({
    String sport = 'football',
    Map<String, dynamic>? rules,
    Map<String, dynamic>? live,
    int? homeScore = 1,
    int? awayScore = 0,
    bool weAreHome = true,
    String startsAt = '2026-10-11T14:30:00+02:00',
    List<Map<String, dynamic>>? goals,
    List<Map<String, dynamic>>? subs,
    List<Map<String, dynamic>>? cards,
    List<Map<String, dynamic>>? moments,
    Object? reactions,
    bool canReact = true,
    int viewers = 6,
    bool following = false,
    bool canManage = false,
    int? createdId,
  }) => {
    'data': data(
      sport: sport,
      rules: rules,
      live: live,
      homeScore: homeScore,
      awayScore: awayScore,
      weAreHome: weAreHome,
      startsAt: startsAt,
      goals: goals,
      subs: subs,
      cards: cards,
      moments: moments,
      reactions: reactions,
      canReact: canReact,
      viewers: viewers,
      following: following,
      canManage: canManage,
    ),
    if (createdId != null) 'meta': {'created_id': createdId},
  };

  /// Membership van team 3 met live aan; trainer (lineup) of speler.
  static Map<String, dynamic> membership({
    bool manager = false,
    String sport = 'football',
  }) => {
    ...ApiFixtures.membership(
      role: manager ? 'trainer' : 'player',
      abilities: manager ? const ['lineup'] : const [],
      features: const {'live': true, 'live_reactions': true},
      fieldVariant: sport,
    ),
    'sport': {
      'key': sport,
      'field_variant': sport,
      'tracks_penalties': sport == 'football',
      'terms': {'goal': sport == 'football' ? 'Goal' : 'Doelpunt'},
    },
  };
}
