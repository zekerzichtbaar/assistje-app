import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/generated/app_localizations.dart';
import 'push_messaging.dart';

/// Toont een pushbericht dat binnenkomt terwijl de app open is (het systeem
/// doet dat dan zelf niet) en meldt tikken erop.
abstract interface class LocalNotifier {
  /// Eenmalig: maakt het Android-kanaal aan en registreert [onTap]. Is de app
  /// gestart door een tik op zo'n melding, dan volgt [onTap] meteen.
  Future<void> initialize(void Function(Map<String, String> data) onTap);

  Future<void> show(PushMessage message);
}

/// Android-kanaal; dezelfde id staat als
/// `com.google.firebase.messaging.default_notification_channel_id` in de
/// AndroidManifest, zodat FCM-meldingen op de achtergrond hetzelfde kanaal
/// gebruiken.
const pushChannelId = 'assistje_default';

/// [LocalNotifier] op `flutter_local_notifications`.
class FlutterLocalNotifier implements LocalNotifier {
  FlutterLocalNotifier([FlutterLocalNotificationsPlugin? plugin])
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin _plugin;
  AppLocalizations get _l10n => lookupAppLocalizations(const Locale('nl'));

  @override
  Future<void> initialize(void Function(Map<String, String> data) onTap) async {
    await _plugin.initialize(
      settings: const InitializationSettings(
        // Placeholder-icoon; Android wil een monochroom drawable.
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        // Geen toestemmingsvraag hier: die stelt PushController na het
        // inloggen (via Firebase).
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: (response) {
        final data = decodePushPayload(response.payload);
        if (data != null) onTap(data);
      },
    );
    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(
          AndroidNotificationChannel(
            pushChannelId,
            _l10n.pushChannelName,
            description: _l10n.pushChannelDescription,
            importance: Importance.high,
          ),
        );
    final launch = await _plugin.getNotificationAppLaunchDetails();
    if (launch?.didNotificationLaunchApp ?? false) {
      final data = decodePushPayload(launch?.notificationResponse?.payload);
      if (data != null) onTap(data);
    }
  }

  @override
  Future<void> show(PushMessage message) => _plugin.show(
    id: notificationIdFor(message),
    title: message.title,
    body: message.body,
    notificationDetails: NotificationDetails(
      android: AndroidNotificationDetails(
        pushChannelId,
        _l10n.pushChannelName,
        channelDescription: _l10n.pushChannelDescription,
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    ),
    payload: jsonEncode(message.data),
  );
}

/// Stabiele, positieve 31-bits id per bericht.
@visibleForTesting
int notificationIdFor(PushMessage message) =>
    (message.id ?? '${message.data}|${message.title}|${message.body}')
        .hashCode &
    0x7fffffff;

/// Leest de `payload` van een lokale melding terug naar push-`data`.
Map<String, String>? decodePushPayload(String? payload) {
  if (payload == null || payload.isEmpty) return null;
  try {
    final decoded = jsonDecode(payload);
    if (decoded is! Map) return null;
    return {
      for (final entry in decoded.entries)
        if (entry.value != null) '${entry.key}': '${entry.value}',
    };
  } on FormatException {
    return null;
  }
}

final localNotifierProvider = Provider<LocalNotifier>(
  (ref) => FlutterLocalNotifier(),
);
