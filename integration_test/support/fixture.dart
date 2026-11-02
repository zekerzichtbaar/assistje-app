import 'dart:convert';

/// De seed van `php artisan assistje:e2e`, doorgegeven door `tool/e2e.dart`
/// als dart-define `E2E_FIXTURE` (JSON-string). Ids verschillen per ronde:
/// lees ze hier, nooit hard in een test.
class E2eFixture {
  E2eFixture._(this._json);

  static final E2eFixture current = E2eFixture._(_decode(_raw, 'E2E_FIXTURE'));

  static const String _raw = String.fromEnvironment('E2E_FIXTURE');

  final Map<String, Object?> _json;

  int get teamId => _json['team_id']! as int;

  int event(String name) => (_json['events']! as Map)[name]! as int;

  int get matchUpcoming => event('match_upcoming');
  int get cupMatchLive => event('cup_match_live');
  int get trainingUpcoming => event('training_upcoming');
  int get activityUpcoming => event('activity_upcoming');

  int get dutyTypeMultiId => _json['duty_type_multi_id']! as int;
  int get savingsPotChecklistId => _json['savings_pot_checklist_id']! as int;

  /// `email`, `code`, `name` van `trainer`, `player` of `spectator`.
  Map<String, Object?> user(String role) =>
      ((_json['users']! as Map)[role]! as Map).cast<String, Object?>();
}

/// De inlog voor dit testbestand: een verse code voor de rol uit de kopregel
/// `// e2e-rol: …` (`E2E_LOGIN`), anders die uit de seed.
class E2eLogin {
  const E2eLogin(this.email, this.code);

  factory E2eLogin.forRole(String role) {
    const raw = String.fromEnvironment('E2E_LOGIN');
    final json = raw.isEmpty
        ? E2eFixture.current.user(role)
        : _decode(raw, 'E2E_LOGIN');
    return E2eLogin('${json['email']}', '${json['code']}');
  }

  final String email;
  final String code;
}

Map<String, Object?> _decode(String raw, String name) {
  if (raw.isEmpty) {
    throw StateError(
      '$name ontbreekt. Draai de e2e-tests via `dart run tool/e2e.dart` '
      '(README → End-to-end tests).',
    );
  }
  return (jsonDecode(raw) as Map).cast<String, Object?>();
}
