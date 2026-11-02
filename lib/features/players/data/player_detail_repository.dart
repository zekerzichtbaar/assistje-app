import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/player_detail_models.dart';

/// Het detail van één speler (vogels3 `docs/api/v1/players.md`), en de
/// blessure namens een speler zetten (trainer). Fouten komen als
/// [ApiException] (403 geen trainer/lid, 404 onbekend of feature uit, 422 gast).
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

  /// `PATCH teams/{team}/players/{player}/injury`; geeft de nieuwe stand terug.
  Future<bool> setInjury(
    int teamId,
    int playerId, {
    required bool injured,
  }) async {
    final body = await _api.patch(
      '/teams/$teamId/players/$playerId/injury',
      data: {'is_injured': injured},
    );
    final data = body['data'];
    return data is Map<String, dynamic> ? data['is_injured'] == true : injured;
  }
}

final playerDetailRepositoryProvider = Provider<PlayerDetailRepository>(
  (ref) => PlayerDetailRepository(ref.watch(apiClientProvider)),
);
