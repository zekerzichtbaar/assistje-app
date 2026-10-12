import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'csv_file_picker.dart';
import 'models/player_import_result.dart';
import 'models/player_management_models.dart';

/// De spelersbeheer-endpoints (vogels3 `docs/api/v1/player-management.md`,
/// 17 trainer-routes). Fouten komen als [ApiException]: 403 geen trainer of
/// demo-team (schrijven), 404 van een ander team, 422 validatie (`errors`
/// per veld, of alleen `message` bij een regel die niet bij één veld hoort).
class PlayerManagementRepository {
  const PlayerManagementRepository(this._api);

  final ApiClient _api;

  // Spelers ------------------------------------------------------------------

  /// `GET players`: spelers, trainers, toeschouwers en de teamlink.
  Future<PlayerManagement> fetch(int teamId) async {
    final body = await _api.get('/teams/$teamId/players');
    return PlayerManagement.fromJson(_data(body));
  }

  /// `POST players` (201).
  Future<ManagedPlayer> createPlayer(int teamId, NewPlayer player) async {
    final body = await _api.post(
      '/teams/$teamId/players',
      data: player.toJson(),
    );
    return ManagedPlayer.fromJson(_data(body));
  }

  /// `PATCH players/{player}`.
  Future<ManagedPlayer> updatePlayer(
    int teamId,
    int playerId,
    PlayerUpdate update,
  ) async {
    final body = await _api.patch(
      '/teams/$teamId/players/$playerId',
      data: update.toJson(),
    );
    return ManagedPlayer.fromJson(_data(body));
  }

  /// `DELETE players/{player}` (204).
  Future<void> deletePlayer(int teamId, int playerId) =>
      _api.delete('/teams/$teamId/players/$playerId');

  /// `PATCH players/{player}/role`.
  Future<ManagedPlayer> setTrainer(
    int teamId,
    int playerId, {
    required bool isTrainer,
  }) async {
    final body = await _api.patch(
      '/teams/$teamId/players/$playerId/role',
      data: {'is_trainer': isTrainer},
    );
    return ManagedPlayer.fromJson(_data(body));
  }

  /// `PATCH players/{player}/captain`.
  Future<ManagedPlayer> setCaptain(
    int teamId,
    int playerId, {
    required bool captain,
  }) async {
    final body = await _api.patch(
      '/teams/$teamId/players/$playerId/captain',
      data: {'captain': captain},
    );
    return ManagedPlayer.fromJson(_data(body));
  }

  /// `PATCH players/{player}/abilities`.
  Future<ManagedPlayer> setAbility(
    int teamId,
    int playerId, {
    required String ability,
    required bool granted,
  }) async {
    final body = await _api.patch(
      '/teams/$teamId/players/$playerId/abilities',
      data: {'ability': ability, 'granted': granted},
    );
    return ManagedPlayer.fromJson(_data(body));
  }

  /// `POST players/{player}/invite`.
  Future<ManagedPlayer> invitePlayer(
    int teamId,
    int playerId, {
    required String email,
  }) async {
    final body = await _api.post(
      '/teams/$teamId/players/$playerId/invite',
      data: {'email': email},
    );
    return ManagedPlayer.fromJson(_data(body));
  }

  /// `POST players/{player}/invite/resend`.
  Future<ManagedPlayer> resendPlayerInvite(int teamId, int playerId) async {
    final body = await _api.post(
      '/teams/$teamId/players/$playerId/invite/resend',
    );
    return ManagedPlayer.fromJson(_data(body));
  }

  /// `POST players/import` (multipart): spelers in bulk uit een CSV, zoals
  /// de PWA. Met [sendInvites] krijgen spelers met een e-mailadres een
  /// uitnodiging. Een leeg bestand of ontbrekende kolommen geven een `422`
  /// met de fout op `file`.
  Future<PlayerImportResult> importPlayers(
    int teamId,
    CsvFile file, {
    bool sendInvites = false,
  }) async {
    final body = await _api.post(
      '/teams/$teamId/players/import',
      data: FormData.fromMap({
        'file': MultipartFile.fromBytes(
          file.bytes,
          filename: file.name,
          contentType: DioMediaType('text', 'csv'),
        ),
        'send_invites': sendInvites ? '1' : '0',
      }),
    );
    return PlayerImportResult.fromJson(_data(body));
  }

  // Trainers -----------------------------------------------------------------

  /// `POST trainers` (201).
  Future<ManagedTrainer> addTrainer(
    int teamId, {
    required String name,
    required String email,
  }) async {
    final body = await _api.post(
      '/teams/$teamId/trainers',
      data: {'name': name, 'email': email},
    );
    return ManagedTrainer.fromJson(_data(body));
  }

  /// `DELETE trainers/{user}` (204).
  Future<void> removeTrainer(int teamId, int userId) =>
      _api.delete('/teams/$teamId/trainers/$userId');

  // Toeschouwers -------------------------------------------------------------

  /// `POST spectators` (201).
  Future<ManagedSpectator> addSpectator(
    int teamId, {
    required String name,
    required String email,
  }) async {
    final body = await _api.post(
      '/teams/$teamId/spectators',
      data: {'name': name, 'email': email},
    );
    return ManagedSpectator.fromJson(_data(body));
  }

  /// `POST spectators/{user}/invite/resend`.
  Future<ManagedSpectator> resendSpectatorInvite(int teamId, int userId) async {
    final body = await _api.post(
      '/teams/$teamId/spectators/$userId/invite/resend',
    );
    return ManagedSpectator.fromJson(_data(body));
  }

  /// `DELETE spectators/{user}` (204).
  Future<void> removeSpectator(int teamId, int userId) =>
      _api.delete('/teams/$teamId/spectators/$userId');

  // Teamlink -----------------------------------------------------------------

  /// `GET teamlink`.
  Future<TeamLinkOverview> fetchTeamLink(int teamId) async {
    final body = await _api.get('/teams/$teamId/teamlink');
    return TeamLinkOverview.fromJson(_data(body));
  }

  /// `POST teamlink` (201): een verse link, de vorige werkt niet meer.
  Future<TeamLinkOverview> createTeamLink(int teamId) async {
    final body = await _api.post('/teams/$teamId/teamlink');
    return TeamLinkOverview.fromJson(_data(body));
  }

  /// `DELETE teamlink` (200): intrekken zonder vervanger.
  Future<TeamLinkOverview> revokeTeamLink(int teamId) async {
    final body = await _api.delete('/teams/$teamId/teamlink');
    return TeamLinkOverview.fromJson(_data(body));
  }

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final playerManagementRepositoryProvider = Provider<PlayerManagementRepository>(
  (ref) => PlayerManagementRepository(ref.watch(apiClientProvider)),
);
