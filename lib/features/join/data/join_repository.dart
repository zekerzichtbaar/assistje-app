import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../../../core/auth/auth_repository.dart';
import '../../../core/auth/device_name.dart';
import 'models/join_models.dart';

/// De publieke "kom in een team"-endpoints (vogels3
/// `docs/api/v1/join.md` en `docs/api/v1/invites.md`). Geen token nodig;
/// een meegestuurd token wordt wel gelezen (`already_member`, `409`).
///
/// Ongeldige link: `404` (`NotFoundException`) of `410`
/// (`UnknownApiException`, `statusCode` 410), beide met de webzin in
/// `message`. Demo-team bij een `POST`: `403`.
class JoinRepository {
  const JoinRepository(this._api, this._deviceName);

  final ApiClient _api;
  final String _deviceName;

  static String _join(String token) => '/join/${Uri.encodeComponent(token)}';

  static String _confirm(String token, String login) =>
      '${_join(token)}/confirm/${Uri.encodeComponent(login)}';

  static String _invite(String token) =>
      '/invites/${Uri.encodeComponent(token)}';

  /// `GET /join/{token}`.
  Future<JoinLink> fetchLink(String token) async =>
      JoinLink.fromJson(_data(await _api.get(_join(token))));

  /// `POST /join/{token}`. Met [playerId] claimt de gebruiker die naam uit
  /// de selectie (`claim_confirmed` gaat dan mee: het scherm vroeg "ben jij
  /// …?"). Een leeg [email] gaat als `null`.
  Future<JoinOutcome> join(
    String token, {
    required JoinRole role,
    int? playerId,
    String? name,
    String? email,
  }) async {
    final claim = role == JoinRole.player ? playerId : null;
    final trimmedName = name?.trim();
    final trimmedEmail = email?.trim();
    final body = await _api.post(
      _join(token),
      data: {
        'role': role.name,
        'player_id': claim,
        'claim_confirmed': claim != null,
        'name': trimmedName == null || trimmedName.isEmpty ? null : trimmedName,
        'email': trimmedEmail == null || trimmedEmail.isEmpty
            ? null
            : trimmedEmail,
        'device_name': _deviceName,
      },
    );
    final data = _data(body);
    if (data['status'] == 'confirmation_sent') {
      return JoinConfirmationSent('${data['email'] ?? trimmedEmail ?? ''}');
    }
    return JoinSignedIn(AuthRepository.tokenFrom(body));
  }

  /// `GET /join/{token}/confirm/{login}`; [query] is de query uit de
  /// maillink (`role`, `player`, `name`), ongewijzigd.
  Future<JoinConfirmation> fetchConfirmation(
    String token,
    String login, {
    Map<String, String> query = const {},
  }) async => JoinConfirmation.fromJson(
    _data(
      await _api.get(
        _confirm(token, login),
        query: query.isEmpty ? null : query,
      ),
    ),
  );

  /// `POST /join/{token}/confirm/{login}` → het nieuwe Sanctum-token.
  /// Ongeldige link: `422` met `errors.login`.
  Future<String> confirm(
    String token,
    String login, {
    required String role,
    int? playerId,
    String? name,
  }) async => AuthRepository.tokenFrom(
    await _api.post(
      _confirm(token, login),
      data: {
        'role': role,
        'player_id': playerId,
        'name': name == null || name.isEmpty ? null : name,
        'device_name': _deviceName,
      },
    ),
  );

  /// `GET /invites/{token}`.
  Future<InviteInfo> fetchInvite(String token) async =>
      InviteInfo.fromJson(_data(await _api.get(_invite(token))));

  /// `POST /invites/{token}/accept` → het nieuwe Sanctum-token.
  Future<String> acceptInvite(String token) async => AuthRepository.tokenFrom(
    await _api.post(
      '${_invite(token)}/accept',
      data: {'device_name': _deviceName},
    ),
  );

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final joinRepositoryProvider = Provider<JoinRepository>(
  (ref) => JoinRepository(
    ref.watch(apiClientProvider),
    ref.watch(deviceNameProvider),
  ),
);
