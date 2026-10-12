import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/core/auth/auth_controller.dart';
import 'package:assistje/core/auth/auth_repository.dart';
import 'package:assistje/core/auth/device_name.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/test_app.dart';

void main() {
  late TestBackend backend;

  Future<ProviderContainer> start({String? token}) async {
    backend = TestBackend(token: token);
    await backend.init();
    final container = backend.container();
    addTearDown(container.dispose);
    return container;
  }

  /// Wacht tot de controller het token heeft gelezen.
  Future<void> settle(ProviderContainer container) async {
    container.read(authControllerProvider);
    await Future<void>.delayed(Duration.zero);
  }

  group('AuthRepository', () {
    test('requestCode post het e-mailadres', () async {
      final container = await start();
      backend.http.on('POST /auth/request', 202, ApiFixtures.requestResponse());

      await container
          .read(authRepositoryProvider)
          .requestCode('sam@example.com');

      expect(backend.http.requests.single.body, {'email': 'sam@example.com'});
    });

    test('exchangeCode bewaart het token en geeft de gebruiker', () async {
      final container = await start();
      backend.http.on(
        'POST /auth/exchange',
        200,
        ApiFixtures.exchangeResponse(),
      );

      final user = await container
          .read(authRepositoryProvider)
          .exchangeCode(
            email: 'sam@example.com',
            code: '042917',
            deviceName: 'iPhone',
          );

      expect(user.id, 7);
      expect(user.name, 'Sam de Vries');
      expect(user.birthdate, '2001-04-12');
      expect(user.profileMissing.avatar, isFalse);
      expect(backend.tokens.token, '12|q8YwXkP0…');
      expect(backend.http.requests.single.body, {
        'email': 'sam@example.com',
        'code': '042917',
        'device_name': 'iPhone',
      });
    });

    test('exchangeCode met foute code gooit ValidationException', () async {
      final container = await start();
      backend.http.on('POST /auth/exchange', 422, {
        'message': 'De code is ongeldig of verlopen.',
        'errors': {
          'code': ['De code is ongeldig of verlopen.'],
        },
      });

      await expectLater(
        container
            .read(authRepositoryProvider)
            .exchangeCode(email: 'a@b.nl', code: '000000', deviceName: 'x'),
        throwsA(isA<ValidationException>()),
      );
      expect(backend.tokens.token, isNull);
    });

    test('exchangeToken (inloglink) bewaart het token', () async {
      final container = await start();
      backend.http.on(
        'POST /auth/exchange',
        200,
        ApiFixtures.exchangeResponse(),
      );
      final linkToken = 'a' * 64;

      final user = await container
          .read(authRepositoryProvider)
          .exchangeToken(linkToken, deviceName: 'iPhone');

      expect(user.id, 7);
      expect(backend.tokens.token, '12|q8YwXkP0…');
      expect(backend.http.requests.single.body, {
        'token': linkToken,
        'device_name': 'iPhone',
      });
    });

    test('exchangeToken met verlopen link gooit ValidationException', () async {
      final container = await start();
      backend.http.on('POST /auth/exchange', 422, {
        'message': 'Deze inloglink is verlopen.',
        'errors': {
          'token': ['Deze inloglink is verlopen.'],
        },
      });

      await expectLater(
        container
            .read(authRepositoryProvider)
            .exchangeToken('verlopen', deviceName: 'x'),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.errors.keys,
            'errors',
            contains('token'),
          ),
        ),
      );
      expect(backend.tokens.token, isNull);
    });

    test('logout trekt het token in en wist het, ook bij een fout', () async {
      final container = await start(token: '12|abc');
      backend.http.on('POST /auth/logout', 500, {'message': 'Server Error'});

      await container.read(authRepositoryProvider).logout();

      final request = backend.http.requestsTo('POST /auth/logout').single;
      expect(request.authorization, 'Bearer 12|abc');
      expect(backend.tokens.token, isNull);
    });
  });

  group('AuthController', () {
    test('zonder token: uitgelogd', () async {
      final container = await start();
      expect(container.read(authControllerProvider), AuthStatus.unknown);
      await settle(container);
      expect(container.read(authControllerProvider), AuthStatus.signedOut);
    });

    test('met token: ingelogd', () async {
      final container = await start(token: '12|abc');
      await settle(container);
      expect(container.read(authControllerProvider), AuthStatus.signedIn);
    });

    test('signInWithCode logt in met de apparaatnaam', () async {
      final container = await start();
      backend.http.on(
        'POST /auth/exchange',
        200,
        ApiFixtures.exchangeResponse(),
      );
      await settle(container);

      await container
          .read(authControllerProvider.notifier)
          .signInWithCode(email: 'sam@example.com', code: '042917');

      expect(container.read(authControllerProvider), AuthStatus.signedIn);
      expect(
        (backend.http.requests.single.body! as Map)['device_name'],
        'iPhone',
      );
    });

    test('signInWithToken logt in met de apparaatnaam', () async {
      final container = await start();
      backend.http.on(
        'POST /auth/exchange',
        200,
        ApiFixtures.exchangeResponse(),
      );
      await settle(container);

      await container
          .read(authControllerProvider.notifier)
          .signInWithToken('b' * 64);

      expect(container.read(authControllerProvider), AuthStatus.signedIn);
      expect(backend.http.requests.single.body, {
        'token': 'b' * 64,
        'device_name': 'iPhone',
      });
    });

    test('signInWithToken met verlopen link blijft uitgelogd', () async {
      final container = await start();
      backend.http.on('POST /auth/exchange', 422, {
        'message': 'Deze inloglink is verlopen.',
        'errors': {
          'token': ['Deze inloglink is verlopen.'],
        },
      });
      await settle(container);

      await expectLater(
        container.read(authControllerProvider.notifier).signInWithToken('x'),
        throwsA(isA<ValidationException>()),
      );
      expect(container.read(authControllerProvider), AuthStatus.signedOut);
    });

    test('een 401 van /me logt uit en wist het token', () async {
      final container = await start(token: '12|verlopen');
      backend.http.on('GET /me', 401, {'message': 'Unauthenticated.'});
      container.listen(meProvider, (_, _) {});
      await settle(container);
      expect(container.read(authControllerProvider), AuthStatus.signedIn);

      // De 401 logt al uit vóórdat de fout terugkomt; /me wordt dan `null`.
      await container.read(meProvider.future).catchError((Object _) => null);
      await Future<void>.delayed(Duration.zero);

      expect(container.read(authControllerProvider), AuthStatus.signedOut);
      expect(backend.tokens.token, isNull);
      expect(await container.read(meProvider.future), isNull);
    });

    test('adoptToken bewaart een uitgegeven token en logt in', () async {
      final container = await start();
      await settle(container);
      expect(container.read(authControllerProvider), AuthStatus.signedOut);

      await container
          .read(authControllerProvider.notifier)
          .adoptToken('41|nieuw');

      expect(container.read(authControllerProvider), AuthStatus.signedIn);
      expect(backend.tokens.token, '41|nieuw');
      expect(backend.http.requests, isEmpty);
    });

    test(
      'adoptToken terwijl ingelogd: nieuw token, /me laadt opnieuw',
      () async {
        final container = await start(token: '12|oud');
        backend.http.on('GET /me', 200, ApiFixtures.meResponse());
        container.listen(meProvider, (_, _) {});
        await settle(container);
        await container.read(meProvider.future);
        final statuses = <AuthStatus>[];
        container.listen(
          authControllerProvider,
          (_, next) => statuses.add(next),
        );

        await container
            .read(authControllerProvider.notifier)
            .adoptToken('41|nieuw');
        await container.read(meProvider.future);

        expect(statuses, [AuthStatus.unknown, AuthStatus.signedIn]);
        expect(backend.tokens.token, '41|nieuw');
        final meCalls = backend.http.requestsTo('GET /me');
        expect(meCalls, hasLength(2));
        expect(meCalls.last.authorization, 'Bearer 41|nieuw');
      },
    );

    test('adoptToken weigert een leeg token', () async {
      final container = await start();
      await settle(container);
      expect(
        () => container.read(authControllerProvider.notifier).adoptToken(''),
        throwsArgumentError,
      );
      expect(container.read(authControllerProvider), AuthStatus.signedOut);
    });

    test('tokenFrom leest de auth/exchange-vorm, anders een fout', () {
      expect(
        AuthRepository.tokenFrom(ApiFixtures.exchangeResponse()),
        '12|q8YwXkP0…',
      );
      expect(
        () => AuthRepository.tokenFrom({
          'data': {'status': 'confirmation_sent'},
        }),
        throwsA(isA<UnknownApiException>()),
      );
    });

    test('logout roept /auth/logout aan', () async {
      final container = await start(token: '12|abc');
      backend.http.on('POST /auth/logout', 204);
      await settle(container);

      await container.read(authControllerProvider.notifier).logout();

      expect(container.read(authControllerProvider), AuthStatus.signedOut);
      expect(backend.http.requestsTo('POST /auth/logout'), hasLength(1));
      expect(backend.tokens.token, isNull);
    });
  });

  test('apparaatnaam per platform', () {
    expect(platformDeviceName(TargetPlatform.iOS), 'iPhone');
    expect(platformDeviceName(TargetPlatform.android), 'Android');
  });
}
