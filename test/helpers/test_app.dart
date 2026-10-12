import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/auth/device_name.dart';
import 'package:assistje/core/auth/token_store.dart';
import 'package:assistje/core/theme/theme_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_http_adapter.dart';
import 'in_memory_token_store.dart';

/// Alles wat een test nodig heeft om de app tegen een nep-API te draaien.
class TestBackend {
  TestBackend({String? token, Map<String, Object>? prefs})
    : tokens = InMemoryTokenStore(token),
      _prefs = prefs ?? const {};

  final FakeHttpAdapter http = FakeHttpAdapter();
  final InMemoryTokenStore tokens;
  final Map<String, Object> _prefs;
  late SharedPreferences prefs;

  /// Zet de mock-shared_preferences klaar; aanroepen vóór [overrides].
  Future<void> init() async {
    SharedPreferences.setMockInitialValues(_prefs);
    prefs = await SharedPreferences.getInstance();
  }

  List<Override> get overrides => [
    sharedPreferencesProvider.overrideWithValue(prefs),
    tokenStoreProvider.overrideWithValue(tokens),
    apiHttpAdapterProvider.overrideWithValue(http),
    deviceNameProvider.overrideWithValue('iPhone'),
  ];

  ProviderContainer container() =>
      ProviderContainer(overrides: overrides, retry: (_, _) => null);
}
