import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/player_detail_models.dart';

/// Het detail van één speler (vogels3 `docs/api/v1/players.md`).
/// Alleen-lezen; fouten komen als [ApiException] (403 geen lid, 404 onbekend
/// of van een ander team).
class PlayerDetailRepository {
  const PlayerDetailRepository(this._api);

  final ApiClient _api;

  Future<PlayerDetail> fetch(int teamId, int playerId) async {
    final body = await _api.get('/teams/$teamId/players/$playerId');
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return PlayerDetail.fromJson(data);
  }
}

final playerDetailRepositoryProvider = Provider<PlayerDetailRepository>(
  (ref) => PlayerDetailRepository(ref.watch(apiClientProvider)),
);
