import 'dart:async';

import 'package:assistje/core/push/local_notifier.dart';
import 'package:assistje/core/push/push_messaging.dart';

/// [PushMessaging] die de test zelf bestuurt.
class FakePushMessaging implements PushMessaging {
  FakePushMessaging({
    this.permission = PushPermission.granted,
    this.token = 'fcm-token-1',
    this.initialMessage,
  });

  PushPermission permission;
  String? token;
  PushMessage? initialMessage;
  int permissionRequests = 0;

  final tokenRefresh = StreamController<String>.broadcast();
  final foreground = StreamController<PushMessage>.broadcast();
  final opened = StreamController<PushMessage>.broadcast();

  @override
  Future<PushPermission> requestPermission() async {
    permissionRequests++;
    return permission;
  }

  @override
  Future<String?> getToken() async => token;

  @override
  Stream<String> get onTokenRefresh => tokenRefresh.stream;

  @override
  Stream<PushMessage> get onMessage => foreground.stream;

  @override
  Stream<PushMessage> get onMessageOpenedApp => opened.stream;

  @override
  Future<PushMessage?> getInitialMessage() async => initialMessage;

  Future<void> close() async {
    await tokenRefresh.close();
    await foreground.close();
    await opened.close();
  }
}

/// [LocalNotifier] die bijhoudt wat getoond is; [tap] speelt een tik na.
class FakeLocalNotifier implements LocalNotifier {
  FakeLocalNotifier({this.launchData});

  final Map<String, String>? launchData;
  final List<PushMessage> shown = [];
  void Function(Map<String, String> data)? _onTap;
  bool initialized = false;

  @override
  Future<void> initialize(void Function(Map<String, String> data) onTap) async {
    initialized = true;
    _onTap = onTap;
    if (launchData != null) onTap(launchData!);
  }

  @override
  Future<void> show(PushMessage message) async => shown.add(message);

  void tap(PushMessage message) => _onTap?.call(message.data);
}
