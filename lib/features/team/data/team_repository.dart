import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/roster_models.dart';

/// De selectie van een team (vogels3 `docs/api/v1/team.md`). Alleen-lezen;
/// fouten komen als [ApiException] (403 geen lid).
class TeamRepository {
  const TeamRepository(this._api);

  final ApiClient _api;

  Future<TeamRoster> fetchRoster(int teamId) async {
    final body = await _api.get('/teams/$teamId/team');
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return TeamRoster.fromJson(data);
  }
}

final teamRepositoryProvider = Provider<TeamRepository>(
  (ref) => TeamRepository(ref.watch(apiClientProvider)),
);
