import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Eén pushbericht, los van Firebase: [data] is de FCM-`data`
/// (`{url, team_id, team_slug}`, alles strings), [title]/[body] komen uit het
/// `notification`-deel (leeg bij een data-only bericht).
@immutable
class PushMessage {
  const PushMessage({required this.data, this.id, this.title, this.body});

  final String? id;
  final Map<String, String> data;
  final String? title;
  final String? body;

  bool get hasNotification =>
      (title?.isNotEmpty ?? false) || (body?.isNotEmpty ?? false);
}

/// Uitkomst van de toestemmingsvraag.
enum PushPermission { granted, denied }

/// Wat de app van de pushdienst gebruikt. In productie Firebase
/// (`FirebasePushMessaging`), in tests een nep.
abstract interface class PushMessaging {
  /// Vraagt toestemming voor meldingen (iOS-dialoog / Android 13+).
  Future<PushPermission> requestPermission();

  /// Het huidige FCM-token, of `null` als dat (nog) niet beschikbaar is.
  Future<String?> getToken();

  /// Nieuw FCM-token (bv. na herinstallatie of rotatie).
  Stream<String> get onTokenRefresh;

  /// Berichten terwijl de app op de voorgrond staat (het systeem toont ze dan
  /// niet zelf).
  Stream<PushMessage> get onMessage;

  /// Tik op een systeemmelding terwijl de app op de achtergrond draaide.
  Stream<PushMessage> get onMessageOpenedApp;

  /// De melding waarmee de app koud gestart werd, of `null`.
  Future<PushMessage?> getInitialMessage();
}

/// De pushdienst, of `null` als push niet geconfigureerd is (geen
/// Firebase-defines, tests, web). `main.dart` zet hem na
/// `initializePushMessaging()`.
final pushMessagingProvider = Provider<PushMessaging?>((ref) => null);
