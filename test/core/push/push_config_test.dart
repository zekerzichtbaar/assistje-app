import 'package:assistje/core/push/firebase_push_messaging.dart';
import 'package:assistje/core/push/local_notifier.dart';
import 'package:assistje/core/push/push_config.dart';
import 'package:assistje/core/push/push_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

const _full = PushConfig(
  projectId: 'assistje',
  messagingSenderId: '1234',
  iosApiKey: 'ios-key',
  iosAppId: '1:1234:ios:abc',
  iosBundleId: 'nl.assistje.app',
  androidApiKey: 'android-key',
  androidAppId: '1:1234:android:abc',
);

const _empty = PushConfig(
  projectId: '',
  messagingSenderId: '',
  iosApiKey: '',
  iosAppId: '',
  iosBundleId: 'nl.assistje.app',
  androidApiKey: '',
  androidAppId: '',
);

void main() {
  group('PushConfig', () {
    test('lege defines → geen opties (push uit)', () {
      expect(_empty.optionsFor(TargetPlatform.iOS), isNull);
      expect(_empty.optionsFor(TargetPlatform.android), isNull);
      // De env-bestanden in de repo zijn leeg.
      expect(const PushConfig.fromEnv().optionsFor(TargetPlatform.iOS), isNull);
    });

    test('iOS-opties met bundle id', () {
      final options = _full.optionsFor(TargetPlatform.iOS)!;
      expect(options.apiKey, 'ios-key');
      expect(options.appId, '1:1234:ios:abc');
      expect(options.projectId, 'assistje');
      expect(options.messagingSenderId, '1234');
      expect(options.iosBundleId, 'nl.assistje.app');
    });

    test('Android-opties', () {
      final options = _full.optionsFor(TargetPlatform.android)!;
      expect(options.apiKey, 'android-key');
      expect(options.appId, '1:1234:android:abc');
    });

    test('alleen één platform ingevuld → het andere blijft uit', () {
      const iosOnly = PushConfig(
        projectId: 'assistje',
        messagingSenderId: '1234',
        iosApiKey: 'ios-key',
        iosAppId: '1:1234:ios:abc',
        iosBundleId: 'nl.assistje.app',
        androidApiKey: '',
        androidAppId: '',
      );
      expect(iosOnly.optionsFor(TargetPlatform.iOS), isNotNull);
      expect(iosOnly.optionsFor(TargetPlatform.android), isNull);
      expect(_full.optionsFor(TargetPlatform.macOS), isNull);
    });
  });

  test('initializePushMessaging is inert onder flutter test', () async {
    expect(await initializePushMessaging(config: _full), isNull);
  });

  test('pushDataToStrings: alles strings, null weg', () {
    expect(pushDataToStrings({'url': '/events/12', 'team_id': 3, 'x': null}), {
      'url': '/events/12',
      'team_id': '3',
    });
  });

  group('lokale melding payload', () {
    test('round-trip van push-data', () {
      expect(decodePushPayload('{"url":"/agenda","team_id":"3"}'), {
        'url': '/agenda',
        'team_id': '3',
      });
    });

    test('kapotte of lege payload → null', () {
      expect(decodePushPayload(null), isNull);
      expect(decodePushPayload(''), isNull);
      expect(decodePushPayload('niet-json'), isNull);
      expect(decodePushPayload('[1,2]'), isNull);
    });

    test('notificatie-id is stabiel en positief', () {
      const message = PushMessage(id: 'abc', data: {});
      expect(notificationIdFor(message), notificationIdFor(message));
      expect(notificationIdFor(message), greaterThanOrEqualTo(0));
    });
  });
}
