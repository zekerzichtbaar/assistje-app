/// Antwoorden uit vogels3 `docs/api/v1/join.md` en `invites.md`.
abstract final class JoinFixtures {
  static const String token = 'Xk3abcDEF';
  static const String login = 'L0g1nT0k3n';
  static const String invite = 'inv123';

  static const String expiredMessage =
      'Deze teamlink werkt niet meer. Vraag je trainer om een nieuwe link.';
  static const String inviteExpiredMessage =
      'Deze uitnodiging is verlopen of ongeldig. Vraag hieronder een nieuwe '
      'inlog-link aan met je e-mailadres.';

  static Map<String, dynamic> team({int id = 3, String name = 'Vogels 3'}) => {
    'id': id,
    'name': name,
    'slug': 'vogels-3',
    'sport': 'korfball',
    'logo_url': null,
    'logo_fills': false,
    'primary_color': '#006837',
    'url': 'https://vogels-3.assistje.nl',
    'is_demo': false,
  };

  static Map<String, dynamic> link({
    bool alreadyMember = false,
    List<Map<String, dynamic>>? players,
    int teamId = 3,
  }) => {
    'data': {
      'team': team(id: teamId),
      'expires_at': '2026-11-09T20:15:00+01:00',
      'already_member': alreadyMember,
      'players':
          players ??
          [
            {'id': 12, 'name': 'Jeroen Bakker', 'shirt_number': 7},
            {'id': 14, 'name': 'Linda de Lange', 'shirt_number': null},
          ],
    },
  };

  static Map<String, dynamic> tokenResponse({
    String token = '41|Zk2pQ',
    String name = 'Jeroen Bakker',
  }) => {
    'data': {
      'token': token,
      'token_type': 'Bearer',
      'user': {
        'id': 88,
        'name': name,
        'email': null,
        'pending_email': 'jeroen@example.com',
        'avatar_url': null,
        'birthdate': null,
        'is_super_admin': false,
        'profile_missing': {'avatar': true, 'birthdate': true, 'email': false},
      },
    },
  };

  static Map<String, dynamic> confirmationSent([
    String email = 'jeroen@example.com',
  ]) => {
    'data': {'status': 'confirmation_sent', 'email': email},
  };

  static Map<String, dynamic> alreadyMember() => {
    'message': 'Je bent al lid van dit team.',
    'team_id': 3,
  };

  static Map<String, dynamic> expired() => {'message': expiredMessage};

  static Map<String, dynamic> demoRefusal() => {
    'message': 'Dit is een demo. Aanmelden kan hier niet.',
  };

  static Map<String, dynamic> validation(String field, String message) => {
    'message': message,
    'errors': {
      field: [message],
    },
  };

  static Map<String, dynamic> confirmation({
    bool valid = true,
    String role = 'player',
    int? playerId = 12,
    String? playerName = 'Jeroen Bakker',
  }) => {
    'data': {
      'team': team(),
      'valid': valid,
      'user_name': valid ? 'Jeroen Bakker' : null,
      'role': role,
      'player_id': playerId,
      'player_name': playerName,
      'name': '',
    },
  };

  static Map<String, dynamic> inviteInfo() => {
    'data': {'name': 'Sam de Vries', 'valid': true},
  };

  static String get joinPath => '/join/$token';
  static String get confirmPath => '/join/$token/confirm/$login';
  static String get invitePath => '/invites/$invite';
}
