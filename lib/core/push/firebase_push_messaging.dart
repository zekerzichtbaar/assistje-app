import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'push_config.dart';
import 'push_messaging.dart';

/// Start Firebase als push geconfigureerd is en geeft dan de
/// [PushMessaging] terug; anders (lege defines, tests, web, fout) `null`,
/// zonder één Firebase-aanroep.
Future<PushMessaging?> initializePushMessaging({
  PushConfig config = const PushConfig.fromEnv(),
}) async {
  if (kIsWeb || Platform.environment.containsKey('FLUTTER_TEST')) return null;
  final options = config.optionsFor(defaultTargetPlatform);
  if (options == null) return null;
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(options: options);
    }
    return FirebasePushMessaging(FirebaseMessaging.instance);
  } on Object catch (error) {
    debugPrint('Push uitgeschakeld: Firebase start niet ($error)');
    return null;
  }
}

/// [PushMessaging] op `firebase_messaging`.
class FirebasePushMessaging implements PushMessaging {
  FirebasePushMessaging(this._messaging);

  final FirebaseMessaging _messaging;

  @override
  Future<PushPermission> requestPermission() async {
    final settings = await _messaging.requestPermission();
    return switch (settings.authorizationStatus) {
      AuthorizationStatus.authorized ||
      AuthorizationStatus.provisional => PushPermission.granted,
      _ => PushPermission.denied,
    };
  }

  @override
  Future<String?> getToken() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      // Zonder APNs-token geeft getToken() een fout; het APNs-token komt vlak
      // na de toestemming binnen. Ontbreekt het nog, dan volgt het FCM-token
      // via onTokenRefresh.
      final apns = await _messaging.getAPNSToken();
      if (apns == null) return null;
    }
    return _messaging.getToken();
  }

  @override
  Stream<String> get onTokenRefresh => _messaging.onTokenRefresh;

  @override
  Stream<PushMessage> get onMessage => FirebaseMessaging.onMessage.map(_toPush);

  @override
  Stream<PushMessage> get onMessageOpenedApp =>
      FirebaseMessaging.onMessageOpenedApp.map(_toPush);

  @override
  Future<PushMessage?> getInitialMessage() async {
    final message = await _messaging.getInitialMessage();
    return message == null ? null : _toPush(message);
  }

  static PushMessage _toPush(RemoteMessage message) => PushMessage(
    id: message.messageId,
    data: pushDataToStrings(message.data),
    title: message.notification?.title,
    body: message.notification?.body,
  );
}

/// FCM-`data` is `Map<String, dynamic>`; de server stuurt alleen strings.
/// Een cast zou op runtime falen, dus: elke niet-null waarde als string.
Map<String, String> pushDataToStrings(Map<String, dynamic> data) => {
  for (final entry in data.entries)
    if (entry.value != null) entry.key: '${entry.value}',
};
