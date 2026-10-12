import 'dart:convert';

/// API-antwoorden voor het event-detail, letterlijk uit vogels3
/// `docs/api/v1/events.md`, `motm.md` en `carpool.md`.
abstract final class EventFixtures {
  /// Het voorbeeld uit `events.md` (speler, uitwedstrijd 412,
  /// `absence_reason` aan), letterlijk.
  static const String _eventDetailJson = r'''
{
  "data": {
    "id": 412,
    "type": "match",
    "title": "Arnhemia 2 - Vogels 3",
    "starts_at": "2026-10-11T14:30:00+02:00",
    "ends_at": "2026-10-11T16:15:00+02:00",
    "meet_at": "2026-10-11T13:15:00+02:00",
    "venue": "Sportpark Arnhemia",
    "notes": "Witte sokken mee.",
    "is_home": false,
    "competition": "league",
    "home_team": "Arnhemia 2",
    "away_team": "Vogels 3",
    "home_score": null,
    "away_score": null,
    "sets": [],
    "we_are_home": false,
    "cancelled_at": null,
    "can_cancel": false,
    "live": {
      "is_live": false,
      "running": false,
      "started_at": null,
      "accumulated_seconds": 0,
      "ended_at": null,
      "period": 1,
      "period_ends": [45, 90]
    },
    "share_url": null,
    "rsvp_statuses": ["present", "nonplay", "absent"],
    "spectators_can_rsvp": false,
    "sportlink": {
      "field": "Veld 2",
      "dressing_room": "Kleedkamer 4",
      "referee": "J. de Vries",
      "venue": null,
      "number": "123456"
    },
    "my_status": "absent",
    "my_reason": "Ziek",
    "counts": { "present": 9, "absent": 2, "nonplay": 1, "pending": 4 },
    "player_counts": { "present": 8, "absent": 2, "nonplay": 1, "pending": 3 },
    "players": [
      {
        "avatar_url": "https://vogels-3.assistje.nl/img/avatar/abc123.jpg?v=2",
        "id": 37,
        "kind": "player",
        "row_key": "p37",
        "name": "Kees Jansen",
        "shirt_number": 1,
        "is_guest": false,
        "is_injured": false,
        "is_on_vacation": false,
        "status": "present",
        "reason": null,
        "responded_at": "2026-10-08T19:02:11+02:00",
        "changed_by": { "name": "Kees Jansen", "self": true },
        "is_me": false,
        "on_field": false,
        "is_captain": false,
        "is_keeper": true
      },
      {
        "avatar_url": null,
        "id": 51,
        "kind": "staff",
        "row_key": "u51",
        "name": "Trainer Tom",
        "shirt_number": null,
        "is_guest": false,
        "is_injured": false,
        "is_on_vacation": false,
        "status": "present",
        "responded_at": "2026-10-07T10:00:00+02:00",
        "changed_by": null,
        "is_me": false,
        "on_field": false,
        "reason": null,
        "is_captain": false,
        "is_keeper": false
      }
    ],
    "can_rsvp": true,
    "can_change": true,
    "has_lineup": false,
    "lineup_shared": false,
    "motm": {
      "is_open": false,
      "opens_after": true,
      "closes_at": null,
      "eligible": [
        { "avatar_url": "https://vogels-3.assistje.nl/img/avatar/abc123.jpg?v=2", "id": 37, "name": "Kees Jansen", "shirt_number": 1 }
      ],
      "tally": [],
      "my_vote": null,
      "can_vote": true,
      "self_id": 42
    },
    "carpool_offers": [
      { "avatar_url": null, "id": 3, "user_id": 51, "user_name": "Trainer Tom", "mode": "from_club", "seats": 3, "is_self": false }
    ],
    "goals": [],
    "subs": [],
    "cards": [],
    "moments": [],
    "reactions": {},
    "can_react": false,
    "reaction_emoji": [],
    "live_viewers": 0,
    "all_players": [
      { "id": 37, "name": "Kees Jansen", "shirt_number": 1 }
    ],
    "following_live": false,
    "is_trainer": false,
    "duties": [
      {
        "duty_type_id": 2,
        "name": "Shirts wassen",
        "icon": "t-shirt",
        "mode": "rotate",
        "assignment_id": 88,
        "member_key": "p_42",
        "member_keys": ["p_42"],
        "assignee_absent": true,
        "duty_group_id": null,
        "label": "Piet Bakker",
        "member_names": ["Piet Bakker"],
        "notes": null,
        "done": false,
        "mine": true,
        "options": []
      }
    ],
    "flag": {
      "shifts": [
        { "key": "p37", "player_id": 37, "user_id": null, "from_minute": 0 }
      ],
      "names": ["Kees Jansen"],
      "mine": false,
      "match_minutes": 90,
      "pool": [
        { "key": "p37", "player_id": 37, "user_id": null, "name": "Kees Jansen", "guest": false, "staff": false }
      ]
    },
    "can_assign_teams": false,
    "savings_pot": null,
    "can_start_savings": false
  }
}
''';

  /// `POST …/motm` uit `motm.md`, letterlijk.
  static const String _motmVoteJson = r'''
{
  "data": {
    "event_id": 412,
    "my_vote": 37,
    "is_open": true,
    "closes_at": "2026-10-12T14:30:00+02:00"
  }
}
''';

  /// `POST …/carpool` uit `carpool.md`, letterlijk.
  static const String _carpoolJson = r'''
{
  "data": {
    "id": 88,
    "user_id": 23,
    "user_name": "Ruud de Rijder",
    "avatar_url": "https://vogels-3.assistje.nl/img/avatar/abc123.jpg?v=2",
    "mode": "from_club",
    "seats": 3,
    "is_self": true
  }
}
''';

  /// De `422` bij een thuiswedstrijd uit `carpool.md`, letterlijk.
  static const String _carpoolErrorJson = r'''
{
  "message": "Carpool is alleen voor uitwedstrijden.",
  "errors": { "event": ["Carpool is alleen voor uitwedstrijden."] }
}
''';

  static Map<String, dynamic> _decode(String json) =>
      jsonDecode(json) as Map<String, dynamic>;

  /// Het docs-voorbeeld; [overrides] vervangen velden in `data`.
  static Map<String, dynamic> eventDetail([
    Map<String, dynamic> overrides = const {},
  ]) {
    final body = _decode(_eventDetailJson);
    final data = body['data'] as Map<String, dynamic>;
    return {
      'data': {...data, ...overrides},
    };
  }

  /// Alleen de `data` van [eventDetail].
  static Map<String, dynamic> eventDetailData([
    Map<String, dynamic> overrides = const {},
  ]) => eventDetail(overrides)['data'] as Map<String, dynamic>;

  static Map<String, dynamic> motmVote() => _decode(_motmVoteJson);

  static Map<String, dynamic> carpoolOffer() => _decode(_carpoolJson);

  static Map<String, dynamic> carpoolError() => _decode(_carpoolErrorJson);

  /// Ik (speler 42) in de lijst, met [status].
  static Map<String, dynamic> mePlayer({
    String status = 'absent',
    String? reason = 'Ziek',
  }) => {
    'avatar_url': null,
    'id': 42,
    'kind': 'player',
    'row_key': 'p42',
    'name': 'Piet Bakker',
    'shirt_number': 9,
    'is_guest': false,
    'is_injured': false,
    'is_on_vacation': false,
    'status': status,
    'reason': reason,
    'responded_at': null,
    'changed_by': null,
    'is_me': true,
    'on_field': false,
    'is_captain': true,
    'is_keeper': false,
  };

  /// Het docs-voorbeeld met mij als speler in de lijst.
  static Map<String, dynamic> withMe([
    Map<String, dynamic> overrides = const {},
  ]) {
    final base = eventDetailData();
    final players = [...(base['players'] as List<dynamic>), mePlayer()];
    return eventDetail({'players': players, ...overrides});
  }

  /// Een open MOTM-stemming bij een gespeelde wedstrijd.
  static Map<String, dynamic> openMotm({int? myVote}) => {
    'is_open': true,
    'opens_after': false,
    'closes_at': '2026-10-12T14:30:00+02:00',
    'eligible': [
      {'avatar_url': null, 'id': 37, 'name': 'Kees Jansen', 'shirt_number': 1},
      {'avatar_url': null, 'id': 42, 'name': 'Piet Bakker', 'shirt_number': 9},
      {'avatar_url': null, 'id': 44, 'name': 'Joris Smit', 'shirt_number': 7},
    ],
    'tally': <Object>[],
    'my_vote': myVote,
    'can_vote': true,
    'self_id': 42,
  };
}
