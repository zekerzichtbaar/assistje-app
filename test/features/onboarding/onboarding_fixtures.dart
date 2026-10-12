/// JSON uit vogels3 `docs/api/v1/onboarding.md`.
abstract final class OnboardingFixtures {
  static Map<String, dynamic> step(
    String key, {
    required bool done,
    String? href,
  }) => switch (key) {
    'team' => {
      'key': 'team',
      'title': 'Krijg je team erin.',
      'text':
          'Deel één link in de groepsapp; spelers en toeschouwers melden zich '
          'zelf aan. Je hoeft geen e-mailadressen op te zoeken.',
      'href': href ?? '/players',
      'url': 'https://vogels-3.assistje.nl/players',
      'cta': 'Naar de spelers',
      'done': done,
    },
    'schedule' => {
      'key': 'schedule',
      'title': 'Zet de wedstrijden erin.',
      'text':
          'Laat ons het programma erin zetten, of zet de wedstrijden zelf in '
          'de agenda met de +.',
      'href': href ?? '/agenda',
      'url': 'https://vogels-3.assistje.nl/agenda',
      'cta': 'Naar de agenda',
      'done': done,
    },
    _ => {
      'key': 'attendance',
      'title': 'Kijk wie er zijn.',
      'text':
          'Bij de eerste wedstrijd zie je in één oogopslag wie komt en wie '
          'afzegt. Daar doet de app zijn werk.',
      'href': href ?? '/events/412',
      'url': 'https://vogels-3.assistje.nl/events/412',
      'cta': 'Bekijk de opkomst',
      'done': done,
    },
  };

  static Map<String, dynamic> nextMatch() => {
    'id': 412,
    'title': 'Vogels 3 - Arnhemia 2',
    'starts_at': '2026-10-11T14:30:00+02:00',
    'responded': 4,
    'roster': 14,
  };

  static Map<String, dynamic> checklist({
    bool teamDone = true,
    bool scheduleDone = true,
    bool attendanceDone = false,
    String? scheduleRequest,
    bool withMatch = true,
    String? onboardedAt,
  }) => {
    'data': {
      'team': {
        'id': 3,
        'name': 'Vogels 3',
        'onboarded_at': onboardedAt,
        'needs_onboarding': onboardedAt == null,
      },
      'steps': [
        step('team', done: teamDone),
        step('schedule', done: scheduleDone),
        step('attendance', done: attendanceDone),
      ],
      'schedule_request': scheduleRequest,
      'next_match': withMatch ? nextMatch() : null,
    },
  };

  static Map<String, dynamic> completed() =>
      checklist(attendanceDone: true, onboardedAt: '2026-10-11T09:12:44+02:00');

  static const trainerOnly = {'message': 'Alleen de trainer kan dit.'};
}
