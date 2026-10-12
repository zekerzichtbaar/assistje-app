import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/wheel_models.dart';

/// De rad-endpoints (vogels3 `docs/api/v1/wheel.md`). Het rad maakt geen
/// boetes. Draaien mag elk teamlid; verwijderen/koppelen alleen de trainer
/// of wie draaide (anders 403); feature uit of draai van een ander team 404;
/// geen wedstrijd om aan te koppelen 422 met `errors.wheel`.
class WheelRepository {
  const WheelRepository(this._api);

  final ApiClient _api;

  Future<WheelOverview> fetch(int teamId) async {
    final body = await _api.get('/teams/$teamId/wheel');
    return WheelOverview.fromJson(_data(body));
  }

  /// Legt een draai vast met [winner] als winnaar en [candidates] als
  /// deelnemers (logboek). De app kiest de winnaar zelf.
  Future<WheelSpin> recordSpin(
    int teamId, {
    required WheelPlayer winner,
    required List<WheelPlayer> candidates,
  }) async {
    final playerIds = [for (final c in candidates) ?c.id];
    final userIds = [
      for (final c in candidates)
        if (c.id == null && c.userId != null) c.userId!,
    ];
    final body = await _api.post(
      '/teams/$teamId/wheel/spin',
      data: {
        if (winner.id case final id?)
          'winner_player_id': id
        else
          'winner_user_id': winner.userId,
        if (playerIds.isNotEmpty) 'candidate_player_ids': playerIds,
        if (userIds.isNotEmpty) 'candidate_user_ids': userIds,
      },
    );
    return WheelSpin.fromJson(_data(body));
  }

  Future<void> deleteSpin(int teamId, int spinId) =>
      _api.delete('/teams/$teamId/wheel/spin/$spinId');

  /// Hangt de winnaar als vlagger aan de eerstvolgende wedstrijd.
  Future<WheelSpin> assign(int teamId, int spinId) async {
    final body = await _api.post('/teams/$teamId/wheel/spin/$spinId/assign');
    return WheelSpin.fromJson(_data(body));
  }

  /// Haalt de draai los van zijn wedstrijd.
  Future<WheelSpin> unassign(int teamId, int spinId) async {
    final body = await _api.delete('/teams/$teamId/wheel/spin/$spinId/assign');
    return WheelSpin.fromJson(_data(body));
  }

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final wheelRepositoryProvider = Provider<WheelRepository>(
  (ref) => WheelRepository(ref.watch(apiClientProvider)),
);
