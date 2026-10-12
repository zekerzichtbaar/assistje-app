/// Compile-time configuratie, gezet met
/// `flutter run --dart-define-from-file=env/dev.json` (of `env/prod.json`).
abstract final class Env {
  /// Basis-URL van de JSON-API, inclusief `/api/v1`.
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://assistje.nl/api/v1',
  );

  /// Appversie die bij push-aanmelding meegaat (`app_version`), gelijk aan
  /// `version:` in `pubspec.yaml`.
  static const String appVersion = String.fromEnvironment(
    'APP_VERSION',
    defaultValue: '1.0.0+1',
  );

  // Firebase (push). Leeg = push staat uit: geen Firebase-aanroep, geen
  // aanmelding. Waarden uit de Firebase-console (projectinstellingen → je
  // iOS- en Android-app); zie README "Push".

  static const String firebaseApiKeyIos = String.fromEnvironment(
    'FIREBASE_IOS_API_KEY',
  );
  static const String firebaseApiKeyAndroid = String.fromEnvironment(
    'FIREBASE_ANDROID_API_KEY',
  );
  static const String firebaseProjectId = String.fromEnvironment(
    'FIREBASE_PROJECT_ID',
  );
  static const String firebaseMessagingSenderId = String.fromEnvironment(
    'FIREBASE_MESSAGING_SENDER_ID',
  );
  static const String firebaseIosAppId = String.fromEnvironment(
    'FIREBASE_IOS_APP_ID',
  );
  static const String firebaseAndroidAppId = String.fromEnvironment(
    'FIREBASE_ANDROID_APP_ID',
  );
  static const String firebaseIosBundleId = String.fromEnvironment(
    'FIREBASE_IOS_BUNDLE_ID',
    defaultValue: 'nl.assistje.app',
  );
}
