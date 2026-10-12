import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/notification_models.dart';

/// Pushvoorkeuren op accountniveau (vogels3
/// `docs/api/v1/notification-preferences.md`); niet per team.
class NotificationPreferencesRepository {
  const NotificationPreferencesRepository(this._api);

  final ApiClient _api;

  /// `GET notification-preferences`.
  Future<NotificationPreferences> fetch() async =>
      _parse(await _api.get('/notification-preferences'));

  /// `PATCH notification-preferences` — één categorie aan of uit. Geeft de
  /// stand ná de wijziging terug.
  Future<NotificationPreferences> update(
    String key, {
    required bool enabled,
  }) async => _parse(
    await _api.patch(
      '/notification-preferences',
      data: {'key': key, 'enabled': enabled},
    ),
  );

  static NotificationPreferences _parse(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return NotificationPreferences.fromJson(data);
  }
}

final notificationPreferencesRepositoryProvider =
    Provider<NotificationPreferencesRepository>(
      (ref) => NotificationPreferencesRepository(ref.watch(apiClientProvider)),
    );
