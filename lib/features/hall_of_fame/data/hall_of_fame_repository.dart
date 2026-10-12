import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/hall_of_fame_models.dart';

/// `GET teams/{team}/hall-of-fame` (vogels3 `docs/api/v1/stats.md`). Fouten
/// komen als [ApiException]; `404` = de feature `stats` staat uit.
class HallOfFameRepository {
  const HallOfFameRepository(this._api);

  final ApiClient _api;

  /// Seizoen [seasonId] (standaard het lopende) en periode [periodId]
  /// (standaard het hele seizoen).
  Future<HallOfFame> fetch(int teamId, {int? seasonId, int? periodId}) async {
    final query = <String, Object>{'season': ?seasonId, 'period': ?periodId};
    final body = await _api.get(
      '/teams/$teamId/hall-of-fame',
      query: query.isEmpty ? null : query,
    );
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return HallOfFame.fromJson(data);
  }
}

final hallOfFameRepositoryProvider = Provider<HallOfFameRepository>(
  (ref) => HallOfFameRepository(ref.watch(apiClientProvider)),
);
