import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../api/api_exception.dart';
import 'models/me.dart';

/// `GET /me`.
class MeRepository {
  const MeRepository(this._api);

  final ApiClient _api;

  Future<Me> fetch() async {
    final body = await _api.get('/me');
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return Me.fromJson(data);
  }
}

final meRepositoryProvider = Provider<MeRepository>(
  (ref) => MeRepository(ref.watch(apiClientProvider)),
);
