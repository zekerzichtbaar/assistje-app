import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../config/env.dart';

/// `platform` zoals `POST /api/v1/devices` hem verwacht.
String? devicePlatformFor(TargetPlatform platform) => switch (platform) {
  TargetPlatform.iOS => 'ios',
  TargetPlatform.android => 'android',
  _ => null,
};

/// Aan- en afmelden van dit toestel voor push (vogels3
/// `docs/api/v1/devices.md`).
class DeviceRepository {
  DeviceRepository(
    this._api, {
    TargetPlatform? platform,
    this.appVersion = Env.appVersion,
  }) : _platform = platform;

  final ApiClient _api;
  final TargetPlatform? _platform;
  final String appVersion;

  /// `POST /devices` — upsert op token; vaak aanroepen kan geen kwaad.
  /// Gooit een `ApiException`.
  Future<void> register(String token) async {
    final platform = devicePlatformFor(_platform ?? defaultTargetPlatform);
    if (platform == null) return;
    await _api.post(
      '/devices',
      data: {'token': token, 'platform': platform, 'app_version': appVersion},
    );
  }

  /// `DELETE /devices/{token}` — altijd 204. Bij uitloggen niet nodig: de
  /// server ruimt het token dan zelf op. FCM-tokens bevatten alleen
  /// `A-Z a-z 0-9 _ : -` (pad-veilig), dus het token gaat ongecodeerd in het
  /// pad.
  Future<void> unregister(String token) => _api.delete('/devices/$token');
}

final deviceRepositoryProvider = Provider<DeviceRepository>(
  (ref) => DeviceRepository(ref.watch(apiClientProvider)),
);
