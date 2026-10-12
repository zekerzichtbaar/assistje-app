import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../config/env.dart';

/// Firebase-instellingen voor push, uit `--dart-define`s (zie [Env]).
///
/// Bewust geen `GoogleService-Info.plist` / `google-services.json` en geen
/// `com.google.gms.google-services`-Gradle-plugin: de app bouwt zonder
/// Firebase-project, en met lege waarden staat push gewoon uit.
@immutable
class PushConfig {
  const PushConfig({
    required this.projectId,
    required this.messagingSenderId,
    required this.iosApiKey,
    required this.iosAppId,
    required this.iosBundleId,
    required this.androidApiKey,
    required this.androidAppId,
  });

  /// De waarden uit `env/*.json`.
  const PushConfig.fromEnv()
    : projectId = Env.firebaseProjectId,
      messagingSenderId = Env.firebaseMessagingSenderId,
      iosApiKey = Env.firebaseApiKeyIos,
      iosAppId = Env.firebaseIosAppId,
      iosBundleId = Env.firebaseIosBundleId,
      androidApiKey = Env.firebaseApiKeyAndroid,
      androidAppId = Env.firebaseAndroidAppId;

  final String projectId;
  final String messagingSenderId;
  final String iosApiKey;
  final String iosAppId;
  final String iosBundleId;
  final String androidApiKey;
  final String androidAppId;

  /// De [FirebaseOptions] voor [platform], of `null` als push daar niet
  /// geconfigureerd is (een verplichte waarde ontbreekt, of web/desktop).
  FirebaseOptions? optionsFor(TargetPlatform platform) {
    if (projectId.isEmpty || messagingSenderId.isEmpty) return null;
    switch (platform) {
      case TargetPlatform.iOS:
        if (iosApiKey.isEmpty || iosAppId.isEmpty) return null;
        return FirebaseOptions(
          apiKey: iosApiKey,
          appId: iosAppId,
          messagingSenderId: messagingSenderId,
          projectId: projectId,
          iosBundleId: iosBundleId,
        );
      case TargetPlatform.android:
        if (androidApiKey.isEmpty || androidAppId.isEmpty) return null;
        return FirebaseOptions(
          apiKey: androidApiKey,
          appId: androidAppId,
          messagingSenderId: messagingSenderId,
          projectId: projectId,
        );
      case TargetPlatform.fuchsia ||
          TargetPlatform.linux ||
          TargetPlatform.macOS ||
          TargetPlatform.windows:
        return null;
    }
  }
}
