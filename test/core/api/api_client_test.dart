import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';

void main() {
  late FakeHttpAdapter http;
  late String? token;
  late int unauthorizedCalls;
  late ApiClient api;

  setUp(() {
    http = FakeHttpAdapter();
    token = '12|abc';
    unauthorizedCalls = 0;
    api = ApiClient(
      buildApiDio(
        baseUrl: 'https://assistje.test/api/v1',
        readToken: () async => token,
        onUnauthorized: () => unauthorizedCalls++,
        adapter: http,
      ),
    );
  });

  test('stuurt bearer-token en Accept-header, onder /api/v1', () async {
    http.on('GET /me', 200, {'data': <String, dynamic>{}});

    final body = await api.get('/me');

    expect(body, {'data': <String, dynamic>{}});
    final request = http.requests.single;
    expect(request.options.uri.toString(), 'https://assistje.test/api/v1/me');
    expect(request.authorization, 'Bearer 12|abc');
    expect(request.options.headers['Accept'], 'application/json');
  });

  test('zonder token geen Authorization-header', () async {
    token = null;
    http.on('POST /auth/request', 202, {'message': 'ok'});

    await api.post('/auth/request', data: {'email': 'sam@example.com'});

    expect(http.requests.single.authorization, isNull);
    expect(http.requests.single.body, {'email': 'sam@example.com'});
  });

  test('422 wordt ValidationException met veldfouten', () async {
    http.on('POST /auth/exchange', 422, {
      'message': 'De code is ongeldig of verlopen.',
      'errors': {
        'code': ['De code is ongeldig of verlopen.'],
      },
    });

    await expectLater(
      api.post('/auth/exchange'),
      throwsA(
        isA<ValidationException>()
            .having((e) => e.statusCode, 'status', 422)
            .having(
              (e) => e.message,
              'message',
              'De code is ongeldig of verlopen.',
            )
            .having(
              (e) => e.fieldError('code'),
              'code',
              'De code is ongeldig of verlopen.',
            ),
      ),
    );
  });

  test(
    '429 wordt ThrottledException, 403/404/409/500 hun eigen type',
    () async {
      http
        ..on('POST /a', 429, {
          'message': 'Te veel pogingen.',
          'errors': {
            'code': ['Te veel pogingen.'],
          },
        })
        ..on('GET /b', 403, {'message': 'Geen toegang.'})
        ..on('GET /c', 404, {'message': 'Niet gevonden.'})
        ..on('GET /d', 409, {'message': 'Conflict.'})
        ..on('GET /e', 500, {'message': 'Server Error'});

      await expectLater(
        api.post('/a'),
        throwsA(
          isA<ThrottledException>().having(
            (e) => e.fieldError('code'),
            'code',
            'Te veel pogingen.',
          ),
        ),
      );
      await expectLater(api.get('/b'), throwsA(isA<ForbiddenException>()));
      await expectLater(api.get('/c'), throwsA(isA<NotFoundException>()));
      await expectLater(api.get('/d'), throwsA(isA<ConflictException>()));
      await expectLater(
        api.get('/e'),
        throwsA(isA<ServerException>().having((e) => e.statusCode, 's', 500)),
      );
      expect(unauthorizedCalls, 0);
    },
  );

  test('401 met token meldt onUnauthorized', () async {
    http.on('GET /me', 401, {'message': 'Unauthenticated.'});

    await expectLater(api.get('/me'), throwsA(isA<UnauthorizedException>()));
    expect(unauthorizedCalls, 1);
  });

  test('401 zonder token meldt niets', () async {
    token = null;
    http.on('GET /me', 401, {'message': 'Unauthenticated.'});

    await expectLater(api.get('/me'), throwsA(isA<UnauthorizedException>()));
    expect(unauthorizedCalls, 0);
  });

  test(
    'GET wordt één keer opnieuw geprobeerd bij een verbindingsfout',
    () async {
      var calls = 0;
      http.routes['GET /me'] = (request) {
        calls++;
        if (calls == 1) {
          throw DioException.connectionError(
            requestOptions: request.options,
            reason: 'offline',
          );
        }
        return const FakeResponse(200, {'data': 'ok'});
      };

      expect(await api.get('/me'), {'data': 'ok'});
      expect(calls, 2);
    },
  );

  test('na één retry volgt NetworkException', () async {
    http.routes['GET /me'] = (request) => throw DioException.connectionError(
      requestOptions: request.options,
      reason: 'offline',
    );

    await expectLater(api.get('/me'), throwsA(isA<NetworkException>()));
    expect(http.requests, hasLength(2));
  });

  test('POST wordt niet opnieuw geprobeerd', () async {
    http.routes['POST /auth/logout'] = (request) =>
        throw DioException.connectionError(
          requestOptions: request.options,
          reason: 'offline',
        );

    await expectLater(
      api.post('/auth/logout'),
      throwsA(isA<NetworkException>()),
    );
    expect(http.requests, hasLength(1));
  });

  test('PATCH en DELETE sturen body en geven JSON terug', () async {
    http
      ..on('PATCH /teams/3/events/412/attendance', 200, {
        'data': {'status': 'present'},
      })
      ..on('DELETE /devices/5', 204);

    final patched = await api.patch(
      '/teams/3/events/412/attendance',
      data: {'status': 'present'},
    );
    expect(patched, {
      'data': {'status': 'present'},
    });
    expect(http.requests.first.method, 'PATCH');
    expect(http.requests.first.body, {'status': 'present'});
    expect(http.requests.first.authorization, 'Bearer 12|abc');

    expect(await api.delete('/devices/5'), isEmpty);
    expect(http.requests.last.method, 'DELETE');
  });

  test('PUT stuurt body en geeft JSON terug; geen retry', () async {
    http.on('PUT /teams/3/events/412/flag', 200, {
      'data': {'shifts': <Object?>[]},
    });

    final body = await api.put(
      '/teams/3/events/412/flag',
      data: {'shifts': <Object?>[]},
    );
    expect(body, {
      'data': {'shifts': <Object?>[]},
    });
    final request = http.requests.single;
    expect(request.method, 'PUT');
    expect(
      request.options.uri.toString(),
      'https://assistje.test/api/v1/teams/3/events/412/flag',
    );
    expect(request.body, {'shifts': <Object?>[]});
    expect(request.authorization, 'Bearer 12|abc');

    http.routes['PUT /y'] = (request) => throw DioException.connectionError(
      requestOptions: request.options,
      reason: 'offline',
    );
    await expectLater(api.put('/y'), throwsA(isA<NetworkException>()));
    expect(http.requestsTo('PUT /y'), hasLength(1));
  });

  test('PATCH-fouten worden ApiException; geen retry', () async {
    http.on('PATCH /x', 422, {
      'message': 'Geef een reden op.',
      'errors': {
        'reason': ['Geef een reden op.'],
      },
    });
    await expectLater(
      api.patch('/x', data: {'status': 'absent'}),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.fieldError('reason'),
          'reason',
          'Geef een reden op.',
        ),
      ),
    );

    http.routes['PATCH /y'] = (request) => throw DioException.connectionError(
      requestOptions: request.options,
      reason: 'offline',
    );
    await expectLater(api.patch('/y'), throwsA(isA<NetworkException>()));
    expect(http.requestsTo('PATCH /y'), hasLength(1));
  });

  test('204 zonder body geeft een lege map', () async {
    http.on('POST /auth/logout', 204);

    expect(await api.post('/auth/logout'), isEmpty);
  });
}
