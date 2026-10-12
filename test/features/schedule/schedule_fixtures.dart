import '../event/event_fixtures.dart';

/// API-antwoorden voor agenda beheren, uit vogels3 `docs/api/v1/schedule.md`.
abstract final class ScheduleFixtures {
  /// `GET teams/{team}/schedule/options`, letterlijk uit de docs.
  static Map<String, dynamic> options() => {
    'data': {
      'team_name': 'Valleivogels 3',
      'timezone': 'Europe/Amsterdam',
      'types': [
        {'value': 'training', 'label': 'Training'},
        {'value': 'match', 'label': 'Wedstrijd'},
        {'value': 'activity', 'label': 'Activiteit'},
      ],
      'competitions': [
        {'value': 'league', 'label': 'Competitie'},
        {'value': 'cup', 'label': 'Beker'},
        {'value': 'friendly', 'label': 'Oefenwedstrijd'},
      ],
      'defaults': {
        'type': 'training',
        'training_start_time': '19:00',
        'competition': 'league',
        'is_home': true,
        'duration_minutes': {'match': 105, 'training': 90, 'activity': 90},
      },
    },
  };

  /// Een training (event 498) in de vorm van `GET events/{event}`.
  static Map<String, dynamic> trainingData([
    Map<String, dynamic> overrides = const {},
  ]) => EventFixtures.eventDetailData({
    'id': 498,
    'type': 'training',
    'title': 'Conditie',
    'starts_at': '2099-11-12T19:30:00+01:00',
    'ends_at': '2099-11-12T21:00:00+01:00',
    'meet_at': null,
    'venue': 'Veld 3',
    'notes': 'Bidon mee',
    'is_home': null,
    'competition': null,
    'home_team': null,
    'away_team': null,
    'cancelled_at': null,
    'can_cancel': true,
    'spectators_can_rsvp': false,
    'sportlink': null,
    ...overrides,
  });

  /// Een wedstrijd (event 512) zoals het antwoord op aanmaken in de docs.
  static Map<String, dynamic> matchData([
    Map<String, dynamic> overrides = const {},
  ]) => EventFixtures.eventDetailData({
    'id': 512,
    'type': 'match',
    'title': 'Valleivogels 3 - DVS 33',
    'starts_at': '2099-11-14T14:00:00+01:00',
    'ends_at': '2099-11-14T15:45:00+01:00',
    'meet_at': '2099-11-14T13:15:00+01:00',
    'venue': 'Sportpark De Groene Velden',
    'is_home': true,
    'competition': 'league',
    'home_team': 'Valleivogels 3',
    'away_team': 'DVS 33',
    'cancelled_at': null,
    'can_cancel': true,
    'sportlink': null,
    ...overrides,
  });

  /// `{data, meta}`.
  static Map<String, dynamic> write(
    Map<String, dynamic> data, [
    Map<String, dynamic>? meta,
  ]) => {'data': data, 'meta': ?meta};
}
