import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/poule_models.dart';

/// De poule van een team (vogels3 `docs/api/v1/poule.md`). Alleen lezen;
/// `404` ([NotFoundException]) = het team heeft geen poulecode.
class PouleRepository {
  const PouleRepository(this._api);

  final ApiClient _api;

  /// `GET teams/{team}/poule`.
  Future<Poule> fetch(int teamId) async {
    final body = await _api.get('/teams/$teamId/poule');
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return Poule.fromJson(data);
  }
}

final pouleRepositoryProvider = Provider<PouleRepository>(
  (ref) => PouleRepository(ref.watch(apiClientProvider)),
);
