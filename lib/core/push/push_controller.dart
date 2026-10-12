import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_controller.dart';
import '../deep_links/deep_link_handler.dart';
import 'device_repository.dart';
import 'local_notifier.dart';
import 'push_messaging.dart';

/// Push in de app:
/// - tik op een melding (achtergrond, koude start of lokale voorgrondmelding)
///   → [DeepLinkHandler.handlePushData] (die wacht zelf op inloggen + `/me`
///   en wisselt van team);
/// - na elk inloggen (ook bij een herstelde sessie bij opstart): toestemming
///   vragen, token aanmelden bij `POST /devices`, opnieuw bij token-refresh;
/// - op de voorgrond: bericht tonen als lokale melding.
///
/// Uitloggen: alleen stoppen met luisteren — de server ruimt het
/// toesteltoken zelf op (cascade op het Sanctum-token).
class PushController {
  PushController({
    required PushMessaging messaging,
    required LocalNotifier notifier,
    required DeviceRepository Function() devices,
    required Future<void> Function(Map<String, String> data) openData,
  }) : _messaging = messaging,
       _notifier = notifier,
       _devices = devices,
       _openData = openData;

  final PushMessaging _messaging;
  final LocalNotifier _notifier;
  final DeviceRepository Function() _devices;
  final Future<void> Function(Map<String, String> data) _openData;

  StreamSubscription<PushMessage>? _openedSub;
  StreamSubscription<PushMessage>? _foregroundSub;
  StreamSubscription<String>? _tokenSub;

  /// Telt sessies op, zodat een trage aanmelding van een vorige sessie na
  /// uitloggen niets meer doet.
  int _session = 0;
  bool _active = false;
  bool _disposed = false;

  /// Of er nu een ingelogde push-sessie loopt.
  bool get isActive => _active;

  /// Eenmalig bij opstart: tikken opvangen, ook die waarmee de app startte.
  Future<void> start() async {
    _openedSub = _messaging.onMessageOpenedApp.listen(
      (message) => _open(message.data),
    );
    await _guard('lokale meldingen', () => _notifier.initialize(_open));
    final initial = await _guard('startmelding', _messaging.getInitialMessage);
    if (initial != null && !_disposed) _open(initial.data);
  }

  /// Volgt [AuthStatus]: ingelogd → aanmelden, uitgelogd → stoppen.
  void onAuthChanged(AuthStatus status) {
    switch (status) {
      case AuthStatus.signedIn:
        if (_active) return;
        _active = true;
        unawaited(_activate(++_session));
      case AuthStatus.signedOut:
        _deactivate();
      case AuthStatus.unknown:
        break;
    }
  }

  Future<void> _activate(int session) async {
    final permission = await _guard(
      'toestemming',
      _messaging.requestPermission,
    );
    if (!_current(session) || permission != PushPermission.granted) return;

    _foregroundSub = _messaging.onMessage.listen(_showForeground);
    _tokenSub = _messaging.onTokenRefresh.listen((token) {
      if (_current(session)) unawaited(_register(token));
    });
    final token = await _guard('token', _messaging.getToken);
    if (token != null && token.isNotEmpty && _current(session)) {
      await _register(token);
    }
  }

  void _deactivate() {
    _active = false;
    _session++;
    unawaited(_foregroundSub?.cancel());
    unawaited(_tokenSub?.cancel());
    _foregroundSub = null;
    _tokenSub = null;
  }

  bool _current(int session) => !_disposed && _active && session == _session;

  /// Aanmeldfouten (netwerk, 5xx, 422) slikken: de volgende start of
  /// token-refresh probeert het opnieuw (upsert).
  Future<void> _register(String token) =>
      _guard('aanmelden', () => _devices().register(token));

  void _showForeground(PushMessage message) {
    if (!message.hasNotification) return;
    unawaited(_guard('voorgrondmelding', () => _notifier.show(message)));
  }

  void _open(Map<String, String> data) {
    if (_disposed) return;
    unawaited(_guard('openen', () => _openData(data)));
  }

  static Future<T?> _guard<T>(String what, Future<T> Function() body) async {
    try {
      return await body();
    } on Object catch (error) {
      debugPrint('Push ($what) mislukt: $error');
      return null;
    }
  }

  void dispose() {
    _disposed = true;
    _deactivate();
    unawaited(_openedSub?.cancel());
    _openedSub = null;
  }
}

/// De [PushController], of `null` als push niet geconfigureerd is
/// ([pushMessagingProvider] is `null`: geen Firebase-defines, tests, web) —
/// dan gebeurt er niets. `AssistjeApp` houdt hem aan.
final pushControllerProvider = Provider<PushController?>((ref) {
  final messaging = ref.watch(pushMessagingProvider);
  if (messaging == null) return null;

  final controller = PushController(
    messaging: messaging,
    notifier: ref.watch(localNotifierProvider),
    devices: () => ref.read(deviceRepositoryProvider),
    openData: (data) => ref.read(deepLinkHandlerProvider).handlePushData(data),
  );
  ref.onDispose(controller.dispose);
  unawaited(controller.start());
  ref.listen<AuthStatus>(
    authControllerProvider,
    (_, next) => controller.onAuthChanged(next),
    fireImmediately: true,
  );
  return controller;
});
