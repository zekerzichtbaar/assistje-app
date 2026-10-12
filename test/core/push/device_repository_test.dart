import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/core/push/device_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';

void main() {
  late TestBackend backend;

  setUp(() async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
  });

  DeviceRepository repo(TargetPlatform platform) {
    final container = backend.container();
    addTearDown(container.dispose);
    return DeviceRepository(
      container.read(apiClientProvider),
      platform: platform,
      appVersion: '2.1.0+7',
    );
  }

  test('platform volgt defaultTargetPlatform: ios / android', () {
    expect(devicePlatformFor(TargetPlatform.iOS), 'ios');
    expect(devicePlatformFor(TargetPlatform.android), 'android');
    expect(devicePlatformFor(TargetPlatform.macOS), isNull);
  });

  test('register: POST /devices met token, platform en app_version', () async {
    backend.http.on('POST /devices', 201, {
      'data': {'id': 42, 'platform': 'android', 'app_version': '2.1.0+7'},
    });

    await repo(TargetPlatform.android).register('abc:DEF_123-x');

    final request = backend.http.requestsTo('POST /devices').single;
    expect(request.body, {
      'token': 'abc:DEF_123-x',
      'platform': 'android',
      'app_version': '2.1.0+7',
    });
  });

  test('register zonder ondersteund platform doet niets', () async {
    await repo(TargetPlatform.macOS).register('abc');
    expect(backend.http.requests, isEmpty);
  });

  test('register: 422 → ApiException', () async {
    backend.http.on('POST /devices', 422, {
      'message': 'The given data was invalid.',
      'errors': {
        'token': ['Ongeldig token.'],
      },
    });

    await expectLater(
      repo(TargetPlatform.iOS).register('bad token'),
      throwsA(isA<ApiException>()),
    );
  });

  test('unregister: DELETE /devices/{token}', () async {
    backend.http.on('DELETE /devices/abc:DEF_123-x', 204);

    await repo(TargetPlatform.iOS).unregister('abc:DEF_123-x');

    expect(
      backend.http.requestsTo('DELETE /devices/abc:DEF_123-x'),
      hasLength(1),
    );
  });
}
