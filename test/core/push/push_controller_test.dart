import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/auth/auth_controller.dart';
import 'package:assistje/core/deep_links/deep_link_handler.dart';
import 'package:assistje/core/push/device_repository.dart';
import 'package:assistje/core/push/local_notifier.dart';
import 'package:assistje/core/push/push_controller.dart';
import 'package:assistje/core/push/push_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'fake_push.dart';

/// Auth-status die de test zelf zet.
class _FakeAuth extends AuthController {
  _FakeAuth(this.initial);

  final AuthStatus initial;

  @override
  AuthStatus build() => initial;

  // ignore: use_setters_to_change_properties
  void set(AuthStatus status) => state = status;
}

/// Legt push-data vast in plaats van te navigeren.
class _RecordingHandler extends DeepLinkHandler {
  _RecordingHandler(super.ref, this.opened);

  final List<Map<String, String>> opened;

  @override
  Future<void> handlePushData(Map<String, String> data) async =>
      opened.add(data);
}

const _eventData = {
  'url': '/events/12',
  'team_id': '3',
  'team_slug': 'vogels-3',
};
const _eventMessage = PushMessage(
  id: 'm1',
  data: _eventData,
  title: 'Nieuwe wedstrijd',
  body: 'Za 12 okt tegen De Zwaluwen',
);

void main() {
  late TestBackend backend;
  late FakePushMessaging messaging;
  late FakeLocalNotifier notifier;
  late List<Map<String, String>> opened;

  Future<ProviderContainer> start({
    AuthStatus auth = AuthStatus.signedIn,
    bool configured = true,
    FakePushMessaging? push,
    FakeLocalNotifier? local,
    TestBackend? reuseBackend,
  }) async {
    if (reuseBackend == null) {
      backend = TestBackend(token: '12|abc');
      await backend.init();
      backend.http.on('POST /devices', 201, {
        'data': {'id': 42, 'platform': 'ios', 'app_version': '1.0.0+1'},
      });
    }
    messaging = push ?? FakePushMessaging();
    notifier = local ?? FakeLocalNotifier();
    opened = [];
    final container = ProviderContainer(
      overrides: [
        ...backend.overrides,
        authControllerProvider.overrideWith(() => _FakeAuth(auth)),
        if (configured) pushMessagingProvider.overrideWithValue(messaging),
        localNotifierProvider.overrideWithValue(notifier),
        deepLinkHandlerProvider.overrideWith(
          (ref) => _RecordingHandler(ref, opened),
        ),
        deviceRepositoryProvider.overrideWith(
          (ref) => DeviceRepository(
            ref.watch(apiClientProvider),
            platform: TargetPlatform.iOS,
          ),
        ),
      ],
      retry: (_, _) => null,
    );
    addTearDown(container.dispose);
    // Zoals `AssistjeApp`.
    container.listen(pushControllerProvider, (_, _) {});
    await settle();
    return container;
  }

  void setAuth(ProviderContainer container, AuthStatus status) =>
      (container.read(authControllerProvider.notifier) as _FakeAuth).set(
        status,
      );

  List<RecordedRequest> registrations() =>
      backend.http.requestsTo('POST /devices');

  test('niet geconfigureerd: inert, geen Firebase- of API-aanroep', () async {
    final container = await start(configured: false);

    expect(container.read(pushControllerProvider), isNull);
    expect(messaging.permissionRequests, 0);
    expect(notifier.initialized, isFalse);
    expect(backend.http.requests, isEmpty);
  });

  test('ingelogd bij opstart: toestemming, daarna aanmelden met '
      'token/platform/app_version', () async {
    await start();

    expect(messaging.permissionRequests, 1);
    expect(registrations(), hasLength(1));
    expect(registrations().single.body, {
      'token': 'fcm-token-1',
      'platform': 'ios',
      'app_version': '1.0.0+1',
    });
    expect(registrations().single.authorization, 'Bearer 12|abc');
  });

  test('uitgelogd bij opstart: geen toestemmingsvraag, aanmelden pas na '
      'inloggen', () async {
    final container = await start(auth: AuthStatus.signedOut);
    expect(messaging.permissionRequests, 0);
    expect(registrations(), isEmpty);

    setAuth(container, AuthStatus.signedIn);
    await settle();

    expect(messaging.permissionRequests, 1);
    expect(registrations(), hasLength(1));
  });

  test(
    'elke nieuwe login meldt opnieuw aan; uitloggen stopt luisteren',
    () async {
      final container = await start();
      expect(registrations(), hasLength(1));

      setAuth(container, AuthStatus.signedOut);
      await settle();
      messaging.tokenRefresh.add('fcm-token-2');
      messaging.foreground.add(_eventMessage);
      await settle();
      expect(registrations(), hasLength(1));
      expect(notifier.shown, isEmpty);

      setAuth(container, AuthStatus.signedIn);
      await settle();
      expect(registrations(), hasLength(2));
    },
  );

  test('token-refresh meldt het nieuwe token aan', () async {
    await start();
    messaging.tokenRefresh.add('fcm-token-2');
    await settle();

    expect(registrations().map((r) => (r.body! as Map)['token']), [
      'fcm-token-1',
      'fcm-token-2',
    ]);
  });

  test(
    'toestemming geweigerd: geen aanmelding, geen voorgrondmeldingen',
    () async {
      await start(push: FakePushMessaging(permission: PushPermission.denied));
      messaging.tokenRefresh.add('fcm-token-2');
      messaging.foreground.add(_eventMessage);
      await settle();

      expect(registrations(), isEmpty);
      expect(notifier.shown, isEmpty);
    },
  );

  test(
    'geen token (nog geen APNs-token): niets aanmelden, wel bij refresh',
    () async {
      await start(push: FakePushMessaging(token: null));
      expect(registrations(), isEmpty);

      messaging.tokenRefresh.add('fcm-token-late');
      await settle();
      expect(registrations(), hasLength(1));
    },
  );

  test(
    'API-fout wordt geslikt en bij de volgende start opnieuw geprobeerd',
    () async {
      backend = TestBackend(token: '12|abc');
      await backend.init();
      backend.http.on('POST /devices', 500, {'message': 'Server Error'});
      final first = await start(reuseBackend: backend);
      expect(registrations(), hasLength(1));
      expect(first.read(pushControllerProvider)!.isActive, isTrue);
      first.dispose();

      backend.http.on('POST /devices', 201, {
        'data': {'id': 42},
      });
      await start(reuseBackend: backend);
      expect(registrations(), hasLength(2));
    },
  );

  test('tik op melding (achtergrond) → handlePushData', () async {
    await start();
    messaging.opened.add(_eventMessage);
    await settle();

    expect(opened, [_eventData]);
  });

  test(
    'koude start vanaf een melding → handlePushData, ook uitgelogd',
    () async {
      await start(
        auth: AuthStatus.signedOut,
        push: FakePushMessaging(initialMessage: _eventMessage),
      );

      expect(opened, [_eventData]);
    },
  );

  test(
    'voorgrondbericht → lokale melding; tik daarop → handlePushData',
    () async {
      await start();
      messaging.foreground.add(_eventMessage);
      await settle();

      expect(notifier.shown, [_eventMessage]);
      expect(opened, isEmpty);

      notifier.tap(_eventMessage);
      await settle();
      expect(opened, [_eventData]);
    },
  );

  test('data-only voorgrondbericht wordt niet getoond', () async {
    await start();
    messaging.foreground.add(const PushMessage(data: _eventData));
    await settle();

    expect(notifier.shown, isEmpty);
  });

  test('app gestart door tik op een lokale melding → handlePushData', () async {
    await start(local: FakeLocalNotifier(launchData: _eventData));

    expect(opened, [_eventData]);
  });
}

/// Laat microtasks en nep-HTTP-antwoorden doorlopen.
Future<void> settle() => pumpEventQueue(times: 50);
