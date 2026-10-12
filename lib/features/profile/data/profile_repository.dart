import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/profile_models.dart';

/// Wat `PATCH profile` teruggeeft: het account en, bij een nieuw adres, waar
/// de bevestigingslink heen ging.
typedef AccountUpdate = ({ProfileAccount account, String? emailClaimSentTo});

/// De "Mij"-tab tegen de API (vogels3 `docs/api/v1/profile.md`): per team
/// (`teams/{team}/profile…`) en op accountniveau (`profile…`).
class ProfileRepository {
  const ProfileRepository(this._api);

  final ApiClient _api;

  // ── Per team ────────────────────────────────────────────────────────────

  /// `GET teams/{team}/profile`.
  Future<Profile> fetch(int teamId) async =>
      _parseProfile(await _api.get('/teams/$teamId/profile'));

  /// `POST teams/{team}/profile/player` — "ik speel ook mee".
  Future<Profile> attachPlayer(
    int teamId, {
    required String position,
    int? shirtNumber,
  }) async => _parseProfile(
    await _api.post(
      '/teams/$teamId/profile/player',
      data: {'position': position, 'shirt_number': shirtNumber},
    ),
  );

  /// `DELETE teams/{team}/profile/player`.
  Future<Profile> detachPlayer(int teamId) async =>
      _parseProfile(await _api.delete('/teams/$teamId/profile/player'));

  /// `PATCH teams/{team}/profile/injury`.
  Future<Profile> setInjured(int teamId, {required bool injured}) async =>
      _parseProfile(
        await _api.patch(
          '/teams/$teamId/profile/injury',
          data: {'is_injured': injured},
        ),
      );

  /// `DELETE teams/{team}/membership` — zelf uit een team stappen (`204`).
  /// `422` als het je enige team is.
  Future<void> leaveTeam(int teamId) async {
    await _api.delete('/teams/$teamId/membership');
  }

  // ── Account ─────────────────────────────────────────────────────────────

  /// `PATCH profile` — naam, e-mail (gaat via bevestiging) en geboortedatum.
  Future<AccountUpdate> updateAccount({
    required String name,
    String? email,
    String? birthdate,
  }) async {
    final body = await _api.patch(
      '/profile',
      data: {'name': name, 'email': email, 'birthdate': birthdate},
    );
    final meta = body['meta'];
    final sentTo = meta is Map<String, dynamic>
        ? meta['email_claim_sent_to']
        : null;
    return (
      account: ProfileAccount.fromJson(_data(body)),
      emailClaimSentTo: sentTo is String && sentTo.isNotEmpty ? sentTo : null,
    );
  }

  /// `POST profile/email/resend`. Geeft het adres terug waar hij heen ging.
  Future<String?> resendEmailClaim() async {
    final data = _data(await _api.post('/profile/email/resend'));
    final pending = data['pending_email'];
    return pending is String ? pending : null;
  }

  /// `POST profile/avatar` met een data-URI (`data:image/jpeg;base64,…`).
  /// Geeft de nieuwe (absolute) avatar-URL terug.
  Future<String?> uploadAvatar(String dataUri) async {
    final data = _data(
      await _api.post('/profile/avatar', data: {'avatar_base64': dataUri}),
    );
    final url = data['avatar_url'];
    return url is String ? url : null;
  }

  /// `DELETE profile/avatar`.
  Future<void> removeAvatar() async {
    await _api.delete('/profile/avatar');
  }

  /// `DELETE profile` — account weg. Daarna is elk token ongeldig.
  Future<void> deleteAccount({required String confirm}) async {
    await _api.delete('/profile', data: {'confirm': confirm});
  }

  static Profile _parseProfile(Map<String, dynamic> body) =>
      Profile.fromJson(_data(body));

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) => ProfileRepository(ref.watch(apiClientProvider)),
);
