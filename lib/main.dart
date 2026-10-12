import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/push/firebase_push_messaging.dart';
import 'core/push/push_messaging.dart';
import 'core/theme/theme_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  // `null` zonder Firebase-defines: push staat dan uit.
  final pushMessaging = await initializePushMessaging();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        pushMessagingProvider.overrideWithValue(pushMessaging),
      ],
      child: const AssistjeApp(),
    ),
  );
}
