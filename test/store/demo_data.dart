// Demoteam voor de storebeelden: een verzonnen club met een volle selectie,
// zodat elk scherm er "in gebruik" uitziet. Data volgt de API-vormen uit de
// fixtures (vogels3 `docs/api/v1/*.md`).
//
// Datums zijn relatief aan vandaag (de app vergelijkt met DateTime.now()):
// de eerstvolgende zaterdag is de wedstrijd.
import '../features/event/event_fixtures.dart';
import '../features/fines/fines_fixtures.dart';
import '../features/live/live_fixtures.dart';
import '../features/poule/poule_fixtures.dart';
import '../features/stats/stats_fixtures.dart';
import '../helpers/api_fixtures.dart';
import '../helpers/fake_http_adapter.dart';

const demoTeam = 'FC Dijkzicht 1';
const demoOpponent = 'SV Polderstad 2';
const demoColor = '#006837';

/// (id, naam, rugnummer, positie)
const demoSquad = [
  (11, 'Daan Visser', 1, 'GK'),
  (12, 'Lars de Boer', 2, 'RB'),
  (13, 'Thijs Mulder', 4, 'CB'),
  (14, 'Bram Jansen', 5, 'CB'),
  (15, 'Ruben Smit', 3, 'LB'),
  (16, 'Sem Bakker', 8, 'CM'),
  (17, 'Jesse de Jong', 6, 'CM'),
  (18, 'Milan Peters', 10, 'CM'),
  (19, 'Luuk Hendriks', 7, 'RW'),
  (20, 'Noah van Dijk', 9, 'ST'),
  (21, 'Finn Vos', 11, 'LW'),
  (22, 'Stijn Kok', 14, 'CM'),
  (23, 'Tim Willems', 16, 'CB'),
  (24, 'Gijs Dekker', 12, 'GK'),
];

const _me = 16;

/// Alle demo-routes op [http] zetten; [trainer] bepaalt de rol.
void demoRoutes(FakeHttpAdapter http, {bool trainer = false}) {
  http
    ..on('GET /me', 200, ApiFixtures.meResponse(teams: [membership(trainer)]))
    ..on('GET /teams/3/agenda', 200, agenda())
    ..on('GET /teams/3/events/412', 200, eventDetail(trainer: trainer))
    ..on('GET /teams/3/events/412/lineup', 200, lineup())
    ..on('GET /teams/3/events/412/live', 200, live())
    ..on('GET /teams/3/stats', 200, stats())
    ..on('GET /teams/3/poule', 200, poule())
    ..on('GET /teams/3/fines', 200, fines())
    ..on('GET /notifications/unread-count', 200, {
      'data': {'count': 0},
    });
}

Map<String, dynamic> membership(bool trainer) {
  final m = ApiFixtures.membership(
    name: demoTeam,
    role: trainer ? 'trainer' : 'player',
    abilities: trainer ? const ['lineup', 'training_points', 'fines'] : [],
    features: const {
      'stats': true,
      'fines': true,
      'savings': true,
      'wheel': true,
      'messages': true,
      'agreements': true,
      'vacations': true,
      'live': true,
      'motm': true,
    },
    hasPoule: true,
    hasDuties: true,
  );
  return {
    ...m,
    'sport': {
      'key': 'football',
      'label': 'Voetbal',
      'field_variant': 'football',
      'tracks_penalties': true,
      'positions': const {
        'GK': 'Keeper',
        'LB': 'Linksback',
        'RB': 'Rechtsback',
        'LCB': 'Centrale verdediger',
        'RCB': 'Centrale verdediger',
        'LCM': 'Middenveld',
        'CM': 'Middenveld',
        'RCM': 'Middenveld',
        'LW': 'Linksbuiten',
        'RW': 'Rechtsbuiten',
        'ST': 'Spits',
      },
      'terms': const {'goal': 'Goal'},
    },
  };
}

// ── Datums ─────────────────────────────────────────────────────────────────

DateTime _day(int offset) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day + offset);
}

/// De eerstvolgende zaterdag, minstens twee dagen vooruit.
DateTime get matchDay {
  var d = _day(2);
  while (d.weekday != DateTime.saturday) {
    d = d.add(const Duration(days: 1));
  }
  return d;
}

String _iso(DateTime day, int hour, [int minute = 0]) {
  final t = DateTime(day.year, day.month, day.day, hour, minute);
  String two(int n) => n.toString().padLeft(2, '0');
  return '${t.year}-${two(t.month)}-${two(t.day)}T${two(t.hour)}:'
      '${two(t.minute)}:00+01:00';
}

String _date(DateTime d) => _iso(d, 0).substring(0, 10);

// ── Agenda ─────────────────────────────────────────────────────────────────

Map<String, dynamic> _event({
  required int id,
  required String type,
  required String title,
  required DateTime day,
  required int hour,
  int minute = 0,
  int durationMin = 105,
  String? home,
  String? away,
  String? venue,
  String status = 'present',
  Map<String, int> counts = const {
    'present': 13,
    'absent': 2,
    'nonplay': 0,
    'pending': 1,
  },
}) {
  final start = DateTime(day.year, day.month, day.day, hour, minute);
  final end = start.add(Duration(minutes: durationMin));
  return {
    ...ApiFixtures.agendaEvent(id: id, type: type, title: title),
    'starts_at': _iso(day, hour, minute),
    'ends_at': _iso(day, end.hour, end.minute),
    'meet_at': type == 'match'
        ? _iso(day, start.subtract(const Duration(minutes: 45)).hour, 45)
        : null,
    'home_team': home,
    'away_team': away,
    'venue': venue,
    'my_status': status,
    'counts': counts,
    'player_counts': counts,
  };
}

Map<String, dynamic> agenda() {
  final sat = matchDay;
  final tue = sat.subtract(const Duration(days: 4));
  final thu = sat.subtract(const Duration(days: 2));
  final nextTue = sat.add(const Duration(days: 3));
  final nextSat = sat.add(const Duration(days: 7));
  final upcoming = [
    if (tue.isAfter(_day(0)))
      _event(
        id: 401,
        type: 'training',
        title: 'Training',
        day: tue,
        hour: 20,
        durationMin: 90,
        venue: 'Sportpark Dijkzicht',
      ),
    _event(
      id: 402,
      type: 'training',
      title: 'Training',
      day: thu,
      hour: 20,
      durationMin: 90,
      venue: 'Sportpark Dijkzicht',
      counts: const {'present': 11, 'absent': 3, 'nonplay': 0, 'pending': 2},
    ),
    _event(
      id: 412,
      type: 'match',
      title: '$demoTeam - $demoOpponent',
      day: sat,
      hour: 14,
      minute: 30,
      home: demoTeam,
      away: demoOpponent,
      venue: 'Sportpark Dijkzicht',
    ),
    _event(
      id: 403,
      type: 'training',
      title: 'Training',
      day: nextTue,
      hour: 20,
      durationMin: 90,
      venue: 'Sportpark Dijkzicht',
      status: 'pending',
      counts: const {'present': 6, 'absent': 1, 'nonplay': 0, 'pending': 9},
    ),
    _event(
      id: 413,
      type: 'match',
      title: 'VV Molenbeek 1 - $demoTeam',
      day: nextSat,
      hour: 12,
      home: 'VV Molenbeek 1',
      away: demoTeam,
      venue: 'Sportpark De Molenwiek',
      status: 'pending',
      counts: const {'present': 7, 'absent': 1, 'nonplay': 0, 'pending': 8},
    ),
  ];
  return ApiFixtures.agendaResponse(
    upcoming: upcoming,
    upcomingDuties: [
      ApiFixtures.agendaDuty(
        date: _iso(sat, 0),
        playerNames: const ['Sem Bakker'],
        groupName: 'Sem Bakker',
      ),
    ],
    birthdays: [
      {
        'avatar_url': null,
        'key': 'p19',
        'player_id': 19,
        'name': 'Luuk',
        'date': _date(thu),
        'turning': 27,
        'is_today': false,
      },
    ],
  );
}

// ── Event-detail ───────────────────────────────────────────────────────────

Map<String, dynamic> _player(
  (int, String, int, String) p, {
  String status = 'present',
  String? reason,
  bool captain = false,
}) => {
  'avatar_url': null,
  'id': p.$1,
  'kind': 'player',
  'row_key': 'p${p.$1}',
  'name': p.$2,
  'shirt_number': p.$3,
  'is_guest': false,
  'is_injured': false,
  'is_on_vacation': false,
  'status': status,
  'reason': reason,
  'responded_at': _iso(_day(0), 19, 2),
  'changed_by': {'name': p.$2, 'self': true},
  'is_me': p.$1 == _me,
  'on_field': false,
  'is_captain': captain,
  'is_keeper': p.$4 == 'GK',
};

Map<String, dynamic> eventDetail({bool trainer = false}) {
  final sat = matchDay;
  final players = [
    for (final p in demoSquad)
      _player(
        p,
        status: switch (p.$1) {
          23 => 'absent',
          24 => 'absent',
          22 => 'pending',
          _ => 'present',
        },
        reason: switch (p.$1) {
          23 => 'Op vakantie',
          24 => 'Werk',
          _ => null,
        },
        captain: p.$1 == 18,
      ),
  ];
  final present = players.where((p) => p['status'] == 'present').length;
  final counts = {'present': present, 'absent': 2, 'nonplay': 0, 'pending': 1};
  return EventFixtures.eventDetail({
    'title': '$demoTeam - $demoOpponent',
    'starts_at': _iso(sat, 14, 30),
    'ends_at': _iso(sat, 16, 15),
    'meet_at': _iso(sat, 13, 45),
    'venue': 'Sportpark Dijkzicht',
    'notes': 'Verzamelen in de kantine. Witte sokken mee!',
    'is_home': true,
    'we_are_home': true,
    'home_team': demoTeam,
    'away_team': demoOpponent,
    'sportlink': {
      'field': 'Veld 1',
      'dressing_room': 'Kleedkamer 3',
      'referee': 'P. de Groot',
      'venue': null,
      'number': '204511',
    },
    'my_status': 'present',
    'my_reason': null,
    'counts': counts,
    'player_counts': counts,
    'players': players,
    'has_lineup': true,
    'lineup_shared': true,
    'carpool_offers': <Object>[],
    'is_trainer': trainer,
    'all_players': [
      for (final p in demoSquad)
        {'id': p.$1, 'name': p.$2, 'shirt_number': p.$3},
    ],
    'motm': {
      'is_open': false,
      'opens_after': true,
      'closes_at': null,
      'eligible': <Object>[],
      'tally': <Object>[],
      'my_vote': null,
      'can_vote': false,
      'self_id': _me,
    },
    'duties': [
      {
        'duty_type_id': 2,
        'name': 'Shirts wassen',
        'icon': 't-shirt',
        'mode': 'rotate',
        'assignment_id': 88,
        'member_key': 'p_$_me',
        'member_keys': ['p_$_me'],
        'assignee_absent': false,
        'duty_group_id': null,
        'label': 'Sem Bakker',
        'member_names': ['Sem Bakker'],
        'notes': null,
        'done': false,
        'mine': true,
        'options': <Object>[],
      },
    ],
    'flag': {
      'shifts': [
        {'key': 'p22', 'player_id': 22, 'user_id': null, 'from_minute': 0},
        {'key': 'p23', 'player_id': 17, 'user_id': null, 'from_minute': 45},
      ],
      'names': ['Stijn Kok', 'Jesse de Jong'],
      'mine': false,
      'match_minutes': 90,
      'pool': <Object>[],
    },
  });
}

// ── Opstelling ─────────────────────────────────────────────────────────────

Map<String, dynamic> _slot(String code, int x, int y, String label) => {
  'code': code,
  'x': x,
  'y': y,
  'label': label,
};

Map<String, dynamic> _lineupPlayer((int, String, int, String) p) => {
  'id': p.$1,
  'shirt_number': p.$3,
  'name': p.$2,
  'position': p.$4,
  'is_guest': false,
  'from_team': null,
  'avatar_url': null,
};

Map<String, dynamic> lineup() {
  final formation = [
    _slot('GK', 50, 91, 'K'),
    _slot('LB', 14, 70, 'LB'),
    _slot('LCB', 37, 76, 'CV'),
    _slot('RCB', 63, 76, 'CV'),
    _slot('RB', 86, 70, 'RB'),
    _slot('LCM', 25, 50, 'CM'),
    _slot('CM', 50, 55, 'CM'),
    _slot('RCM', 75, 50, 'CM'),
    _slot('LW', 17, 24, 'LV'),
    _slot('ST', 50, 18, 'SP'),
    _slot('RW', 83, 24, 'RV'),
  ];
  const assignment = {
    'GK': 11,
    'LB': 15,
    'LCB': 13,
    'RCB': 14,
    'RB': 12,
    'LCM': 17,
    'CM': 16,
    'RCM': 18,
    'LW': 21,
    'ST': 20,
    'RW': 19,
  };
  final byId = {for (final p in demoSquad) p.$1: p};
  var slotId = 900;
  return {
    'data': {
      'sport': 'football',
      'field_variant': 'football',
      'event': {
        'id': 412,
        'title': '$demoTeam - $demoOpponent',
        'starts_at': _iso(matchDay, 14, 30),
        'home_team': demoTeam,
        'away_team': demoOpponent,
      },
      'pool': [
        for (final p in demoSquad)
          if (p.$1 != 23 && p.$1 != 24) _lineupPlayer(p),
      ],
      'slots': [
        for (final e in assignment.entries)
          {
            'id': ++slotId,
            'slot_code': e.key,
            'player': _lineupPlayer(byId[e.value]!),
          },
      ],
      'formation': '4-3-3',
      'formation_slots': formation,
      'formations': [
        {'key': '4-3-3', 'label': '1-4-3-3'},
        {'key': '4-4-2', 'label': '1-4-4-2'},
      ],
      'formation_label': '1-4-3-3',
      'can_edit': true,
      'captain_player_id': 18,
      'published_at': _iso(_day(0), 9),
      'changed_since_publish': false,
    },
  };
}

// ── Live ───────────────────────────────────────────────────────────────────

Map<String, dynamic> live() {
  final body = LiveFixtures.response(
    homeScore: 2,
    awayScore: 1,
    startsAt: _iso(matchDay, 14, 30),
    live: LiveFixtures.clock(
      running: true,
      startedAt: DateTime.now().toUtc().toIso8601String(),
      seconds: 67 * 60,
      period: 2,
    ),
    goals: [
      LiveFixtures.goal(
        id: 1801,
        minute: 64,
        scorer: 'Noah van Dijk',
        assist: 'Milan Peters',
      ),
      LiveFixtures.goal(
        id: 1802,
        minute: 51,
        type: 'opponent_goal',
        scorer: null,
        assist: null,
      ),
      LiveFixtures.goal(
        id: 1803,
        minute: 23,
        scorer: 'Luuk Hendriks',
        assist: 'Sem Bakker',
      ),
    ],
    subs: [
      {
        'id': 78,
        'item_key': 's78',
        'minute': 60,
        'on': 'Stijn Kok',
        'off': 'Jesse de Jong',
        'created_at': 1760187072000,
      },
    ],
    cards: [
      {
        'id': 1840,
        'item_key': 'c1840',
        'minute': 38,
        'type': 'yellow',
        'player': 'Bram Jansen',
        'created_at': 1760187252000,
      },
    ],
    moments: [LiveFixtures.moment(minute: 57, player: 'Noah van Dijk')],
    reactions: const <String, Object>{},
    canReact: false,
    viewers: 23,
    following: true,
  );
  final data = body['data'] as Map<String, dynamic>;
  data['event'] = {
    ...(data['event'] as Map<String, dynamic>),
    'title': '$demoTeam - $demoOpponent',
    'home_team': demoTeam,
    'away_team': demoOpponent,
  };
  data['reaction_emoji'] = <String>[];
  return body;
}

// ── Statistieken ───────────────────────────────────────────────────────────

Map<String, dynamic> stats() {
  // (id, goals, assists, minuten, wedstr., aanwezig %, training %)
  const rows = [
    (20, 11, 3, 812, 10, 100.0, 92.0),
    (16, 4, 7, 845, 10, 95.0, 88.0),
    (19, 6, 4, 760, 10, 90.0, 80.0),
    (18, 3, 5, 870, 10, 100.0, 96.0),
    (21, 5, 2, 640, 9, 85.0, 70.0),
    (13, 1, 0, 900, 10, 100.0, 84.0),
  ];
  final byId = {for (final p in demoSquad) p.$1: p};
  return StatsFixtures.response({
    'my_player_id': _me,
    'rows': [
      for (final r in rows)
        StatsFixtures.samRow({
          'player_id': r.$1,
          'name': byId[r.$1]!.$2,
          'shirt_number': byId[r.$1]!.$3,
          'position': byId[r.$1]!.$4,
          'avatar_url': null,
          'goals': r.$2,
          'assists': r.$3,
          'minutes': r.$4,
          'matches_played': r.$5,
          'matches_present': r.$5,
          'minutes_per_match': r.$4 ~/ r.$5,
          'attendance_rate': (r.$6 + r.$7) / 2,
          'attendance_match_rate': r.$6,
          'attendance_training_rate': r.$7,
          'yellow': r.$1 == 13 ? 2 : 0,
          'titles': r.$1 == 20
              ? [
                  {'key': 'top_scorer', 'icon': '', 'label': 'Topscorer'},
                ]
              : r.$1 == 16
              ? [
                  {'key': 'top_assister', 'icon': '', 'label': 'Assistkoning'},
                ]
              : <Object>[],
        }),
    ],
  });
}

// ── Poule ──────────────────────────────────────────────────────────────────

Map<String, dynamic> poule() {
  // (team, gespeeld, w, g, v, voor, tegen)
  const table = [
    ('VV Molenbeek 1', 10, 8, 1, 1, 27, 9),
    (demoTeam, 10, 7, 2, 1, 29, 12),
    ('Rapid Waalkant 1', 10, 6, 2, 2, 21, 13),
    (demoOpponent, 10, 5, 2, 3, 18, 15),
    ('SC Lindenhof 3', 10, 4, 2, 4, 16, 17),
    ('VV De Brug 1', 10, 3, 3, 4, 14, 18),
    ('RKSV Heidevogels 2', 10, 2, 2, 6, 11, 22),
    ('SC Noorderhaven 1', 10, 0, 2, 8, 7, 37),
  ];
  return PouleFixtures.poule(
    fetchedAt: _iso(_day(0), 8, 5),
    standing: [
      for (var i = 0; i < table.length; i++)
        {
          ...PouleFixtures.standing(
            position: i + 1,
            team: table[i].$1,
            own: table[i].$1 == demoTeam,
            logo: null,
            points: table[i].$3 * 3 + table[i].$4,
            played: table[i].$2,
            goalDiff: table[i].$6 - table[i].$7,
          ),
          'won': table[i].$3,
          'drawn': table[i].$4,
          'lost': table[i].$5,
          'goals_for': table[i].$6,
          'goals_against': table[i].$7,
        },
    ],
    results: [
      {
        'date': _date(_day(-5)),
        'matches': [
          {
            ...PouleFixtures.result(),
            'date': _date(_day(-5)),
            'home': 'Rapid Waalkant 1',
            'away': demoTeam,
            'score': '1-3',
            'home_logo': null,
            'away_logo': null,
          },
        ],
      },
    ],
    fixtures: [
      {
        'date': _date(matchDay),
        'matches': [
          {
            ...PouleFixtures.fixture(),
            'date': _date(matchDay),
            'time': '14:30',
            'home': demoTeam,
            'away': demoOpponent,
            'is_own': true,
            'home_is_own': true,
          },
        ],
      },
    ],
  );
}

// ── Boetepot ───────────────────────────────────────────────────────────────

Map<String, dynamic> fines() {
  final byId = {for (final p in demoSquad) p.$1: p};
  Map<String, dynamic> row(int id, int total, int open, int count) => {
    ...FinesFixtures.rowSam(open: open, total: total),
    'key': 'p$id',
    'player_id': id,
    'name': byId[id]!.$2,
    'shirt_number': byId[id]!.$3,
    'avatar_url': null,
    'count': count,
  };
  return FinesFixtures.overview({
    'rows': [
      row(19, 1250, 500, 5),
      row(20, 1000, 0, 4),
      row(16, 750, 250, 3),
      row(21, 500, 0, 2),
      row(14, 250, 0, 1),
    ],
    'totals': {'open_cents': 750, 'all_cents': 3750},
    'pot': {
      'balance_cents': 14250,
      'open_cents': 750,
      'lines': [
        {
          'key': 'period-7',
          'kind': 'fines',
          'id': null,
          'amount_cents': 3000,
          'description': 'Betaalde boetes',
          'occurred_on': _date(_day(-2)),
          'created_by': null,
        },
        FinesFixtures.potEntry12(amount: -2450, description: 'Bitterballen'),
        {
          'key': 'settlement-3',
          'kind': 'settlement',
          'id': null,
          'amount_cents': 4500,
          'description': 'Afrekening · Teamuitje',
          'occurred_on': _date(_day(-30)),
          'created_by': null,
        },
      ],
    },
  });
}
