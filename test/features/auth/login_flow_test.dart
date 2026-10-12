import 'package:assistje/app.dart';
import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:assistje/core/theme/theme_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/pump.dart';
import '../../helpers/test_app.dart';

void main() {
  late TestBackend backend;

  Future<ProviderContainer> launch(WidgetTester tester, {String? token}) async {
    backend = TestBackend(token: token);
    await backend.init();
    final container = backend.container();
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const AssistjeApp(),
      ),
    );
    return container;
  }

  testWidgets('e-mail → code → ingelogd → agenda van het team', (tester) async {
    final container = await launch(tester);
    backend.http
      ..on('POST /auth/request', 202, ApiFixtures.requestResponse())
      ..on('POST /auth/exchange', 200, ApiFixtures.exchangeResponse())
      ..on(
        'GET /me',
        200,
        ApiFixtures.meResponse(
          teams: [
            ApiFixtures.zwaluwenMembership(),
            ApiFixtures.vogelsMembership(),
          ],
        ),
      );

    await pumpUntilFound(tester, find.text('Log in bij je team'));

    // Ongeldig adres: meteen een melding, geen verzoek.
    await tester.enterText(find.byKey(const Key('login-email')), 'sam');
    await tester.tap(find.text('Stuur mij een code'));
    await tester.pump();
    expect(find.text('Vul een geldig e-mailadres in.'), findsOneWidget);
    expect(backend.http.requests, isEmpty);

    await tester.enterText(
      find.byKey(const Key('login-email')),
      ' sam@example.com ',
    );
    await tester.tap(find.text('Stuur mij een code'));
    await pumpUntilFound(tester, find.text('Vul je code in'));
    expect(backend.http.requestsTo('POST /auth/request').single.body, {
      'email': 'sam@example.com',
    });
    expect(find.textContaining('sam@example.com'), findsOneWidget);

    // Plakken met rommel eromheen: alleen de cijfers, en meteen versturen.
    await tester.enterText(
      find.byKey(const Key('login-code')),
      'Code: 042 917',
    );
    await pumpUntilFound(tester, find.byKey(const Key('glass-tab-bar')));

    expect(backend.http.requestsTo('POST /auth/exchange').single.body, {
      'email': 'sam@example.com',
      'code': '042917',
      'device_name': 'iPhone',
    });
    expect(backend.tokens.token, '12|q8YwXkP0…');
    final me = backend.http.requestsTo('GET /me').single;
    expect(me.authorization, 'Bearer 12|q8YwXkP0…');

    // Eerste team uit /me is actief en bepaalt de kleur; we landen op de
    // agenda.
    expect(container.read(routerProvider).state.uri.path, AppRoutes.agenda);
    expect(
      container.read(currentMembershipProvider)?.team.name,
      'Zwaluwen VR1',
    );
    expect(container.read(teamColorProvider), '#1D4ED8');
    final context = tester.element(find.byKey(const Key('glass-tab-bar')));
    expect(Theme.of(context).colorScheme.primary, const Color(0xFF1D4ED8));
  });

  testWidgets('foute code toont de 422-melding, slot de 429-melding', (
    tester,
  ) async {
    await launch(tester);
    backend.http
      ..on('POST /auth/request', 202, ApiFixtures.requestResponse())
      ..on('POST /auth/exchange', 422, {
        'message': 'De code is ongeldig of verlopen.',
        'errors': {
          'code': ['De code is ongeldig of verlopen.'],
        },
      });

    await pumpUntilFound(tester, find.text('Log in bij je team'));
    await tester.enterText(
      find.byKey(const Key('login-email')),
      'sam@example.com',
    );
    await tester.tap(find.text('Stuur mij een code'));
    await pumpUntilFound(tester, find.text('Vul je code in'));

    await tester.enterText(find.byKey(const Key('login-code')), '000000');
    await pumpUntilFound(
      tester,
      find.text('Deze code klopt niet of is verlopen.'),
    );
    expect(backend.tokens.token, isNull);

    backend.http.on('POST /auth/exchange', 429, {
      'message': 'Te veel pogingen.',
      'errors': {
        'code': ['Te veel pogingen.'],
      },
    });
    await tester.enterText(find.byKey(const Key('login-code')), '111111');
    await pumpUntilFound(
      tester,
      find.text('Te veel pogingen. Vraag een nieuwe code aan.'),
    );

    // Nieuwe code aanvragen.
    await tester.tap(find.text('Stuur een nieuwe code'));
    await pumpUntilFound(
      tester,
      find.text('Nieuwe code verstuurd. Kijk in je mail.'),
    );
    expect(backend.http.requestsTo('POST /auth/request'), hasLength(2));
  });

  testWidgets('teamwissel verandert de kleur en blijft bewaard', (
    tester,
  ) async {
    final container = await launch(tester, token: '12|abc');
    backend.http.on(
      'GET /me',
      200,
      ApiFixtures.meResponse(
        teams: [
          ApiFixtures.vogelsMembership(),
          ApiFixtures.zwaluwenMembership(),
        ],
      ),
    );

    await pumpUntilFound(tester, find.byKey(const Key('glass-tab-bar')));
    expect(container.read(teamColorProvider), '#006837');

    // De teamwissel staat in het menu.
    await tester.tap(find.byKey(const Key('shell-menu')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('team-9')));
    await tester.pumpAndSettle();

    expect(
      container.read(currentMembershipProvider)?.team.name,
      'Zwaluwen VR1',
    );
    expect(container.read(teamColorProvider), '#1D4ED8');
    expect(backend.prefs.getInt('current_team_id'), 9);
  });

  testWidgets('uitloggen roept /auth/logout aan en toont login', (
    tester,
  ) async {
    await launch(tester, token: '12|abc');
    backend.http
      ..on('GET /me', 200, ApiFixtures.meResponse())
      ..on('POST /auth/logout', 204);

    await pumpUntilFound(tester, find.byKey(const Key('glass-tab-bar')));
    await tester.tap(find.byKey(const Key('tab-profile')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('logout')));
    await pumpUntilFound(tester, find.text('Log in bij je team'));

    final logout = backend.http.requestsTo('POST /auth/logout').single;
    expect(logout.authorization, 'Bearer 12|abc');
    expect(backend.tokens.token, isNull);
  });

  testWidgets('een 401 bij opstarten logt uit', (tester) async {
    await launch(tester, token: '12|ingetrokken');
    backend.http.on('GET /me', 401, {'message': 'Unauthenticated.'});

    await pumpUntilFound(tester, find.text('Log in bij je team'));
    expect(backend.tokens.token, isNull);
  });

  testWidgets('ingelogd zonder teams toont het geen-teamscherm', (
    tester,
  ) async {
    await launch(tester, token: '12|abc');
    backend.http.on('GET /me', 200, ApiFixtures.meResponse(teams: []));

    await pumpUntilFound(tester, find.text('Nog geen team'));
  });
}
