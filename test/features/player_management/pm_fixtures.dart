import '../team/roster_fixtures.dart';

/// De JSON-voorbeelden uit vogels3 `docs/api/v1/player-management.md`.
abstract final class PmFixtures {
  /// Trainer-membership van team 3 met de voetbalsport.
  static Map<String, dynamic> trainerMembership({
    Map<String, bool> features = const {},
    bool demo = false,
  }) {
    final membership = RosterFixtures.membership(
      role: 'trainer',
      features: features,
    );
    if (demo) {
      membership['team'] = {
        ...(membership['team'] as Map<String, dynamic>),
        'is_demo': true,
      };
    }
    return membership;
  }

  static Map<String, dynamic> linda({
    bool isCaptain = true,
    bool isTrainer = false,
    List<String> abilities = const ['lineup'],
  }) => {
    'id': 12,
    'user_id': 40,
    'shirt_number': 7,
    'name': 'Linda Lid',
    'position': 'CM',
    'is_guest': false,
    'is_injured': false,
    'is_on_vacation': false,
    'from_team': null,
    'email': 'linda@example.com',
    'avatar_url': 'https://assistje.nl/storage/avatars/40.jpg',
    'is_trainer': isTrainer,
    'is_captain': isCaptain,
    'invite_status': 'accepted',
    'push_status': 'push',
    'strength': 4,
    'birthdate': '2001-02-03',
    'abilities': abilities,
  };

  static Map<String, dynamic> kees({
    String inviteStatus = 'none',
    String? email,
    bool isCaptain = false,
  }) => {
    'id': 13,
    'user_id': inviteStatus == 'none' ? null : 52,
    'shirt_number': 9,
    'name': 'Kees Kaal',
    'position': null,
    'is_guest': false,
    'is_injured': false,
    'is_on_vacation': false,
    'from_team': null,
    'email': email,
    'avatar_url': null,
    'is_trainer': false,
    'is_captain': isCaptain,
    'invite_status': inviteStatus,
    'push_status': inviteStatus == 'none' ? 'na' : 'none',
    'strength': null,
    'birthdate': null,
    'abilities': <String>[],
  };

  static Map<String, dynamic> guest() => {
    ...kees(),
    'id': 31,
    'shirt_number': 1,
    'name': 'Gijs Gast',
    'position': 'GK',
    'is_guest': true,
    'from_team': 'Vogels 2',
  };

  static Map<String, dynamic> tom() => {
    'id': 3,
    'name': 'Tom Trainer',
    'email': 'tom@example.com',
    'avatar_url': null,
    'is_self': true,
    'push_status': 'push',
  };

  static Map<String, dynamic> anja() => {
    'id': 60,
    'name': 'Anja Assistent',
    'email': 'anja@example.com',
    'avatar_url': null,
    'is_self': false,
    'push_status': 'none',
  };

  static Map<String, dynamic> opa({String inviteStatus = 'pending'}) => {
    'id': 51,
    'name': 'Opa Piet',
    'email': 'opa@example.com',
    'avatar_url': null,
    'invite_status': inviteStatus,
  };

  static Map<String, dynamic> link() => {
    'url': 'https://vogels3.assistje.nl/meedoen/Xk3abc',
    'expires_at': '2027-01-08T10:00:00+01:00',
  };

  static Map<String, dynamic> overview({
    List<Map<String, dynamic>>? players,
    List<Map<String, dynamic>>? trainers,
    List<Map<String, dynamic>>? spectators,
    bool linkActive = true,
    String? linkState,
  }) => {
    'data': {
      'players': players ?? [linda(), kees(), guest()],
      'trainers': trainers ?? [tom(), anja()],
      'spectators': spectators ?? [opa()],
      'team_link': linkActive ? link() : null,
      'team_link_state': linkState ?? (linkActive ? 'active' : 'revoked'),
    },
  };

  static Map<String, dynamic> teamLink({String state = 'active'}) => {
    'data': {
      'link': state == 'active' ? link() : null,
      'link_state': state,
      'expires_days': 90,
      'joined': [
        {
          'id': 40,
          'name': 'Linda Lid',
          'avatar_url': null,
          'role': 'player',
          'joined_at': '2026-10-09T20:15:00+02:00',
        },
        {
          'id': 51,
          'name': 'Opa Piet',
          'avatar_url': null,
          'role': 'spectator',
          'joined_at': '2026-10-08T20:15:00+02:00',
        },
      ],
    },
  };

  static Map<String, dynamic> data(Map<String, dynamic> body) => {'data': body};
}
