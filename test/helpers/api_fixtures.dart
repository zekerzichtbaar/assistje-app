/// Voorbeeld-JSON uit vogels3 `docs/api/v1/<onderdeel>.md` (`auth.md`,
/// `me.md`, `agenda.md`, `attendance.md`; letterlijk, met een tweede team
/// erbij waar dat nodig is voor teamwissel).
abstract final class ApiFixtures {
  static Map<String, dynamic> exchangeResponse() => {
    'data': {
      'token': '12|q8YwXkP0…',
      'token_type': 'Bearer',
      'user': {
        'id': 7,
        'name': 'Sam de Vries',
        'email': 'sam@example.com',
        'pending_email': null,
        'avatar_url': 'https://vogels-3.assistje.nl/img/avatar/abc.jpg?v=2',
        'birthdate': '2001-04-12',
        'is_super_admin': false,
        'profile_missing': {
          'avatar': false,
          'birthdate': false,
          'email': false,
        },
      },
    },
  };

  static Map<String, dynamic> requestResponse() => {
    'message':
        'Als sam@example.com een bekende gebruiker is, sturen we zo een inloglink met code.',
  };

  static Map<String, dynamic> vogelsMembership() => {
    'team': {
      'id': 3,
      'name': 'Vogels 3',
      'slug': 'vogels-3',
      'sport': 'football',
      'logo_url': 'https://vogels-3.assistje.nl/storage/logos/vogels.png',
      'logo_fills': false,
      'primary_color': '#006837',
      'url': 'https://vogels-3.assistje.nl',
      'is_demo': false,
    },
    'role': 'player',
    'abilities': ['fines'],
    'features': {'fines': true, 'wheel': true, 'motm': true, 'stats': true},
    'sport': {
      'key': 'football',
      'label': 'Voetbal',
      'field_variant': 'football',
      'score_model': 'goals',
      'positions': ['…'],
      'terms': {'…': '…'},
      '…': 'volledig SportProfile::toArray()',
    },
    'has_poule': false,
    'onboarding_open': false,
    'unread_notifications_count': 2,
  };

  /// Een tweede team (andere kleur, trainer) om te kunnen wisselen.
  static Map<String, dynamic> zwaluwenMembership() => {
    'team': {
      'id': 9,
      'name': 'Zwaluwen VR1',
      'slug': 'zwaluwen-vr1',
      'sport': 'hockey',
      'logo_url': null,
      'logo_fills': false,
      'primary_color': '#1D4ED8',
      'url': 'https://zwaluwen-vr1.assistje.nl',
      'is_demo': false,
    },
    'role': 'trainer',
    'abilities': ['lineup', 'training_points', 'fines'],
    'features': {'fines': true, 'wheel': false},
    'sport': {'key': 'hockey'},
    'has_poule': true,
    'onboarding_open': true,
    'unread_notifications_count': 0,
  };

  /// Een membership met gekozen rol/abilities/features (voor menu- en
  /// tabtests). Teamgegevens als [vogelsMembership], met eigen [teamId].
  static Map<String, dynamic> membership({
    int teamId = 3,
    String name = 'Vogels 3',
    String role = 'player',
    List<String> abilities = const [],
    Map<String, bool> features = const {},
    bool hasPoule = false,
    bool onboardingOpen = false,
    int unread = 0,
    String fieldVariant = 'football',
  }) => {
    'team': {
      ...(vogelsMembership()['team'] as Map<String, dynamic>),
      'id': teamId,
      'name': name,
      'slug': 'team-$teamId',
      'logo_url': null,
    },
    'role': role,
    'abilities': abilities,
    'features': features,
    'sport': {'key': fieldVariant, 'field_variant': fieldVariant},
    'has_poule': hasPoule,
    'onboarding_open': onboardingOpen,
    'unread_notifications_count': unread,
  };

  static Map<String, dynamic> meResponse({
    List<Map<String, dynamic>>? teams,
  }) => {
    'data': {
      'user': {
        'id': 7,
        'name': 'Sam de Vries',
        'email': 'sam@example.com',
        'pending_email': null,
        'avatar_url': null,
        'birthdate': null,
        'is_super_admin': false,
        'profile_missing': {'avatar': true, 'birthdate': true, 'email': false},
      },
      'teams': teams ?? [vogelsMembership()],
    },
  };

  // ── Agenda (`docs/api/v1/agenda.md`) ─────────────────────────────────────

  /// Het event uit het voorbeeld (wedstrijd 412), met optionele afwijkingen.
  /// Standaard ver in de toekomst ([year]), zodat RSVP niet "na de aanvang"
  /// op slot gaat; geef `year: 2026` voor de letterlijke datums uit de docs.
  static Map<String, dynamic> agendaEvent({
    int id = 412,
    int year = 2099,
    String type = 'match',
    String title = 'Vogels 3 - Arnhemia 2',
    String? startsAt,
    String? myStatus = 'pending',
    String? cancelledAt,
    bool isLive = false,
    List<String> rsvpStatuses = const ['present', 'absent', 'nonplay'],
    String? venue = 'Sportpark De Groene Velden',
    bool spectatorsCanRsvp = false,
    int spectatorsPresent = 0,
    bool inVacation = false,
    bool canRsvp = true,
  }) => {
    'id': id,
    'type': type,
    'title': title,
    'starts_at': startsAt ?? '$year-10-11T14:30:00+02:00',
    'ends_at': '$year-10-11T16:15:00+02:00',
    'meet_at': type == 'match' ? '$year-10-11T13:45:00+02:00' : null,
    'venue': venue,
    'home_team': type == 'match' ? 'Vogels 3' : null,
    'away_team': type == 'match' ? 'Arnhemia 2' : null,
    'competition': null,
    'home_score': isLive ? 1 : null,
    'away_score': isLive ? 0 : null,
    'cancelled_at': cancelledAt,
    'my_status': myStatus,
    'counts': {'present': 9, 'absent': 2, 'nonplay': 0, 'pending': 5},
    'player_counts': {'present': 8, 'absent': 2, 'nonplay': 0, 'pending': 5},
    'guest_counts': {'present': 0, 'absent': 0, 'nonplay': 0, 'pending': 0},
    'live': {
      'is_live': isLive,
      'running': false,
      'started_at': null,
      'accumulated_seconds': isLive ? 38 * 60 : 0,
      'ended_at': null,
      'period': 1,
      'period_ends': [45, 90],
    },
    'in_vacation': inVacation,
    'can_rsvp': canRsvp,
    'rsvp_statuses': rsvpStatuses,
    'spectators_can_rsvp': spectatorsCanRsvp,
    'spectators_present': spectatorsPresent,
  };

  /// De wasdienst uit het voorbeeld (hangt aan wedstrijd 412).
  static Map<String, dynamic> agendaDuty({
    int dutyId = 88,
    int? eventId = 412,
    bool matchBound = true,
    String date = '2099-10-11T00:00:00+02:00',
    String title = 'Wasdienst',
    List<String> playerNames = const ['Sam de Vries'],
    String? groupName = 'Sam de Vries',
    bool mine = true,
  }) => {
    'kind': 'duty',
    'duty_id': dutyId,
    'event_id': eventId,
    'match_bound': matchBound,
    'date': date,
    'duty_type': 'laundry',
    'title': title,
    'icon': 't-shirt',
    'group_name': groupName,
    'player_names': playerNames,
    'time_range': null,
    'starts_at': null,
    'ends_at': null,
    'notes': null,
    'done': false,
    'mine': mine,
  };

  static Map<String, dynamic> agendaBirthday() => {
    'avatar_url': 'https://vogels-3.assistje.nl/img/avatar/abc.jpg?v=2',
    'key': 'p17',
    'player_id': 17,
    'name': 'Joris',
    'date': '2026-10-20',
    'turning': 24,
    'is_today': false,
  };

  /// `GET teams/{team}/agenda` — standaard het voorbeeld uit de docs.
  static Map<String, dynamic> agendaResponse({
    List<Map<String, dynamic>>? upcoming,
    List<Map<String, dynamic>> past = const [],
    List<Map<String, dynamic>>? upcomingDuties,
    List<Map<String, dynamic>> pastDuties = const [],
    List<Map<String, dynamic>> myTasks = const [],
    List<Map<String, dynamic>>? birthdays,
    Map<String, dynamic>? me = const {
      'is_guest': false,
      'is_staff': false,
      'is_injured': false,
      'is_on_vacation': false,
    },
    int? upcomingTotal,
    int? pastTotal,
    int limit = 30,
  }) {
    final up = upcoming ?? [agendaEvent()];
    return {
      'data': {
        'can_rsvp': true,
        'me': me,
        'upcoming': up,
        'past': past,
        'upcoming_duties': upcomingDuties ?? [agendaDuty()],
        'past_duties': pastDuties,
        'my_tasks': myTasks,
        'birthdays': birthdays ?? [agendaBirthday()],
        'duty_types': [
          {'id': 1, 'name': 'Kantinedienst', 'slug': 'canteen', 'icon': null},
        ],
        'has_matches': true,
        'has_trainings': true,
        'agenda_feed_url':
            'https://vogels-3.assistje.nl/calendar/AbC…48/agenda.ics',
        'needs_schedule': false,
        'can_fetch_schedule': false,
        'schedule_request': null,
        'schedule_feed': null,
      },
      'meta': {
        'limit': limit,
        'page_size': 30,
        'upcoming_total': upcomingTotal ?? up.length,
        'past_total': pastTotal ?? past.length,
      },
    };
  }

  /// Een lege agenda.
  static Map<String, dynamic> emptyAgendaResponse() => agendaResponse(
    upcoming: const [],
    upcomingDuties: const [],
    birthdays: const [],
  );

  // ── Aanwezigheid (`docs/api/v1/attendance.md`) ───────────────────────────

  static Map<String, dynamic> attendanceResponse({
    int eventId = 412,
    String status = 'absent',
    String? reason = 'Ziek',
  }) => {
    'data': {
      'event_id': eventId,
      'player_id': 37,
      'user_id': null,
      'status': status,
      'reason': reason,
      'responded_at': '2026-10-09T21:14:03+02:00',
      'changed_by_user_id': 51,
    },
  };
}
