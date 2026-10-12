import 'dart:async';

import 'package:assistje/core/auth/auth_controller.dart';
import 'package:assistje/core/deep_links/deep_link_handler.dart';
import 'package:assistje/core/deep_links/deep_link_mapper.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/test_app.dart';

/// [DeepLinkSource] die de test zelf vult.
class _FakeSource implements DeepLinkSource {
  _FakeSource(this.controller);

  final StreamController<Uri> controller;

  @override
  Stream<Uri> get links => controller.stream;
}

/// Eén navigatie, met het actieve team op dat moment.
typedef _Nav = ({String location, int? teamId});

void main() {
  late TestBackend backend;
  late _FakeSource source;
  late List<_Nav> navigations;

  final magicToken = 'k' * 64;

  Future<ProviderContainer> start({
    String? token,
    Map<String, Object>? prefs,
  }) async {
    backend = TestBackend(token: token, prefs: prefs);
    await backend.init();
    final links = StreamController<Uri>.broadcast();
    source = _FakeSource(links);
    navigations = [];
    late ProviderContainer container;
    container = ProviderContainer(
      overrides: [
        ...backend.overrides,
        deepLinkSourceProvider.overrideWithValue(source),
        deepLinkNavigatorProvider.overrideWithValue(
          (location) => navigations.add((
            location: location,
            teamId: container.read(currentTeamIdProvider),
          )),
        ),
      ],
      retry: (_, _) => null,
    );
    addTearDown(() async {
      container.dispose();
      await links.close();
    });
    // Zoals `AssistjeApp`: de handler (en dus de bron) staat altijd aan.
    container.listen(deepLinkHandlerProvider, (_, _) {});
    return container;
  }

  /// Laat alle microtasks en nep-HTTP-antwoorden (inwisselen, `/me`)
  /// doorlopen.
  Future<void> settle() => pumpEventQueue(times: 50);

  void serveMe() => backend.http.on(
    'GET /me',
    200,
    ApiFixtures.meResponse(
      teams: [ApiFixtures.vogelsMembership(), ApiFixtures.zwaluwenMembership()],
    ),
  );

  test('koude start: de eerste link uit de bron navigeert', () async {
    await start(token: '12|abc', prefs: {'current_team_id': 3});
    serveMe();

    source.controller.add(Uri.parse('https://vogels-3.assistje.nl/events/12'));
    await settle();

    expect(navigations, [(location: '/events/12', teamId: 3)]);
  });

  test('een latere link uit de stream navigeert ook', () async {
    await start(token: '12|abc', prefs: {'current_team_id': 3});
    serveMe();
    source.controller.add(Uri.parse('https://vogels-3.assistje.nl/agenda'));
    await settle();

    source.controller.add(
      Uri.parse('https://vogels-3.assistje.nl/events/12/lineup'),
    );
    await settle();

    expect(navigations.map((n) => n.location), [
      '/agenda',
      '/events/12/lineup',
    ]);
  });

  test('teamwissel (slug uit het subdomein) vóór de navigatie', () async {
    final container = await start(
      token: '12|abc',
      prefs: {'current_team_id': 3},
    );
    serveMe();

    source.controller.add(
      Uri.parse('https://zwaluwen-vr1.assistje.nl/events/40'),
    );
    await settle();

    expect(navigations, [(location: '/events/40', teamId: 9)]);
    expect(container.read(currentTeamIdProvider), 9);
    expect(backend.prefs.getInt('current_team_id'), 9);
  });

  test('push-data: team_id wint, onbekend team wisselt niet', () async {
    final container = await start(
      token: '12|abc',
      prefs: {'current_team_id': 3},
    );
    serveMe();
    final handler = container.read(deepLinkHandlerProvider);

    await handler.handlePushData({
      'url': '/events/40',
      'team_id': '9',
      'team_slug': 'zwaluwen-vr1',
    });
    await handler.handlePushData({
      'url': '/poule',
      'team_id': '999',
      'team_slug': 'onbekend',
    });

    expect(navigations, [
      (location: '/events/40', teamId: 9),
      (location: '/poule', teamId: 9),
    ]);
  });

  test('uitgelogd: route onthouden en na inloggen alsnog openen', () async {
    final container = await start();
    serveMe();
    backend.http.on('POST /auth/exchange', 200, ApiFixtures.exchangeResponse());

    source.controller.add(
      Uri.parse('https://zwaluwen-vr1.assistje.nl/events/40'),
    );
    await settle();
    expect(navigations, isEmpty);
    expect(
      container.read(deepLinkHandlerProvider).pending,
      const OpenRoute('/events/40', teamSlug: 'zwaluwen-vr1'),
    );

    await container
        .read(authControllerProvider.notifier)
        .signInWithCode(email: 'sam@example.com', code: '042917');
    await settle();

    expect(navigations, [(location: '/events/40', teamId: 9)]);
    expect(container.read(deepLinkHandlerProvider).pending, isNull);
  });

  test('inloglink: signInWithToken en daarna het team van de link', () async {
    final container = await start(prefs: {'current_team_id': 3});
    serveMe();
    backend.http.on('POST /auth/exchange', 200, ApiFixtures.exchangeResponse());

    source.controller.add(
      Uri.parse('https://zwaluwen-vr1.assistje.nl/magic/$magicToken'),
    );
    await settle();

    expect(container.read(authControllerProvider), AuthStatus.signedIn);
    expect(backend.tokens.token, '12|q8YwXkP0…');
    expect(backend.http.requestsTo('POST /auth/exchange').single.body, {
      'token': magicToken,
      'device_name': 'iPhone',
    });
    expect(navigations, [(location: AppRoutes.home, teamId: 9)]);
  });

  test('inloglink verlopen → loginscherm, uitgelogd', () async {
    final container = await start();
    backend.http.on('POST /auth/exchange', 422, {
      'message': 'Deze inloglink is verlopen.',
      'errors': {
        'token': ['Deze inloglink is verlopen.'],
      },
    });

    source.controller.add(
      Uri.parse('https://vogels-3.assistje.nl/magic/$magicToken'),
    );
    await settle();

    expect(container.read(authControllerProvider), AuthStatus.signedOut);
    expect(navigations, [(location: AppRoutes.login, teamId: null)]);
    expect(container.read(deepLinkHandlerProvider).pending, isNull);
  });

  test('inloglink terwijl al ingelogd: niet inwisselen', () async {
    await start(token: '12|abc', prefs: {'current_team_id': 3});
    serveMe();

    source.controller.add(
      Uri.parse('https://zwaluwen-vr1.assistje.nl/magic/$magicToken'),
    );
    await settle();

    expect(backend.http.requestsTo('POST /auth/exchange'), isEmpty);
    expect(navigations, [(location: AppRoutes.home, teamId: 9)]);
  });

  test('niet te tonen link → home (ingelogd)', () async {
    await start(token: '12|abc', prefs: {'current_team_id': 3});
    serveMe();

    source.controller.add(Uri.parse('https://vogels-3.assistje.nl/live/abc'));
    await settle();

    expect(navigations, [(location: Unsupported.fallback, teamId: 3)]);
  });

  test(
    'teamlink uitgelogd: meteen het publieke scherm, geen pending',
    () async {
      final container = await start();

      source.controller.add(
        Uri.parse('https://vogels-3.assistje.nl/events/40'),
      );
      source.controller.add(
        Uri.parse('https://vogels-3.assistje.nl/meedoen/Xk3abc'),
      );
      await settle();

      expect(navigations, [(location: '/meedoen/Xk3abc', teamId: null)]);
      // De onthouden route vervalt: na het meedoen gaat het scherm zelf
      // naar het team.
      expect(container.read(deepLinkHandlerProvider).pending, isNull);
      expect(backend.http.requests, isEmpty);
    },
  );

  test(
    'bevestiglink en uitnodiging ingelogd: publiek scherm, geen teamwissel',
    () async {
      await start(token: '12|abc', prefs: {'current_team_id': 3});
      serveMe();

      source.controller
        ..add(
          Uri.parse(
            'https://zwaluwen-vr1.assistje.nl/meedoen/Xk3abc/bevestig/L0g1n?role=spectator',
          ),
        )
        ..add(Uri.parse('https://assistje.nl/register/invite/inv123'));
      await settle();

      expect(navigations, [
        (location: '/meedoen/Xk3abc/bevestig/L0g1n?role=spectator', teamId: 3),
        (location: '/register/invite/inv123', teamId: 3),
      ]);
    },
  );

  test('aanmeldlink uitgelogd: meteen het aanmeldscherm met sport', () async {
    final container = await start();
    source.controller.add(
      Uri.parse('https://assistje.nl/aanmelden?sport=hockey'),
    );
    await settle();
    expect(navigations, [(location: '/aanmelden?sport=hockey', teamId: null)]);
    expect(container.read(deepLinkHandlerProvider).pending, isNull);
    expect(backend.http.requests, isEmpty);
  });
}
