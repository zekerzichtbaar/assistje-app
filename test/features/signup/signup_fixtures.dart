/// Antwoorden uit vogels3 `docs/api/v1/signup.md`.
abstract final class SignupFixtures {
  static Map<String, dynamic> football() => {
    'value': 'football',
    'label': 'Voetbal',
    'designation': {
      'word': 'elftal',
      'question': 'Welk elftal?',
      'hint':
          'Zoals het bij de club heet, bijvoorbeeld 3, JO17-1 of Zaterdag 2',
      'example': '3',
    },
    'federation_import': {
      'method': 'paste',
      'name': 'voetbal.nl',
      'hint': 'Uit de URL van de programmapagina',
      'example': 'T429576725',
    },
  };

  static Map<String, dynamic> volleyball() => {
    'value': 'volleyball',
    'label': 'Volleybal',
    'designation': {
      'word': 'team',
      'question': 'Welk team?',
      'hint': 'Zoals DS1 of HS2',
      'example': 'DS1',
    },
    'federation_import': {
      'method': 'feed',
      'name': 'volleybal.nl',
      'hint': 'De iCal-link van je team op volleybal.nl',
      'example':
          'https://api.nevobo.nl/export/team/CKL8Y9N/dames/3/programma.ics',
    },
  };

  static Map<String, dynamic> hockey() => {
    'value': 'hockey',
    'label': 'Hockey',
    'designation': {
      'word': 'team',
      'question': 'Welk team?',
      'hint': 'Zoals Heren 3',
      'example': 'Heren 3',
    },
    'federation_import': null,
  };

  static Map<String, dynamic> options({String? sport}) => {
    'data': {
      'sports': [football(), volleyball(), hockey()],
      'sport': sport,
      'limits': {
        'trainings_min': 1,
        'trainings_max': 7,
        'logo_max_kb': 2048,
        'logo_mimetypes': ['image/png', 'image/jpeg', 'image/svg+xml'],
        'club_search_min_chars': 2,
      },
    },
  };

  static Map<String, dynamic> clubs({int more = 0}) => {
    'data': [
      {
        'id': 412,
        'name': 'Valleivogels',
        'place': 'Scherpenzeel',
        'logo_url': null,
      },
      {'id': 413, 'name': 'VV Vogelenzang', 'place': null, 'logo_url': null},
    ],
    'meta': {'more': more},
  };

  static Map<String, dynamic> noClubs() => {
    'data': <Object>[],
    'meta': {'more': 0},
  };

  static Map<String, dynamic> team() => {
    'id': 31,
    'name': 'Valleivogels 3',
    'slug': 'valleivogels-3',
    'sport': 'football',
    'url': 'https://valleivogels-3.assistje.nl',
  };

  static Map<String, dynamic> existing({bool found = true}) => {
    'data': {'team': found ? team() : null},
  };

  static Map<String, dynamic> sent({bool already = false}) => {
    'data': {
      'status': 'sent',
      'email': 'patrick@example.com',
      'already': already,
      'team': team(),
    },
  };

  static Map<String, dynamic> requested() => {
    'data': {
      'status': 'requested',
      'sport': 'Handbal',
      'email': 'patrick@example.com',
    },
  };

  static const String duplicateMessage =
      'Valleivogels 3 staat er al op valleivogels-3.assistje.nl.';

  static Map<String, dynamic> validation(Map<String, List<String>> errors) => {
    'message': errors.values.first.first,
    'errors': errors,
  };

  static Map<String, dynamic> throttled() => {'message': 'Too Many Attempts.'};
}
