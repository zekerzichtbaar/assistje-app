import 'package:assistje/app.dart';
import 'package:assistje/core/auth/auth_controller.dart';
import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/test_app.dart';
import 'join_fixtures.dart';

final _show = 'GET ${JoinFixtures.joinPath}';
final _join = 'POST ${JoinFixtures.joinPath}';
final _confirmShow = 'GET ${JoinFixtures.confirmPath}';
final _confirm = 'POST ${JoinFixtures.confirmPath}';
final _invite = 'GET ${JoinFixtures.invitePath}';
final _accept = 'POST ${JoinFixtures.invitePath}/accept';

/// Start de app (uitgelogd, of ingelogd met [token]) en opent [location].
Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester,
  String location, {
  String? token,
  required Finder until,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  tester.view
    ..physicalSize = const Size(1800, 4200)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final backend = TestBackend(token: token, prefs: {'current_team_id': 9});
  await backend.init();
  backend.http
    ..on(
      'GET /me',
      200,
      ApiFixtures.meResponse(
        teams: [
          ApiFixtures.zwaluwenMembership(),
          ApiFixtures.vogelsMembership(),
        ],
      ),
    )
    ..on('GET /teams/3/agenda', 200, ApiFixtures.emptyAgendaResponse())
    ..on('GET /teams/9/agenda', 200, ApiFixtures.emptyAgendaResponse());
  setup?.call(backend.http);
  final container = ProviderContainer(
    overrides: backend.overrides,
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const AssistjeApp()),
  );
  await pumpUntilFound(
    tester,
    token == null
        ? find.byKey(const Key('login-email'))
        : find.byKey(const Key('glass-tab-bar')),
  );
  container.read(routerProvider).go(location);
  await pumpUntilFound(tester, until);
  return (container, backend.http);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

String _location(ProviderContainer container) =>
    container.read(routerProvider).state.uri.toString();

/// Ingelogd in de app beland, op het team met [teamId].
Future<void> _expectHome(
  WidgetTester tester,
  ProviderContainer container,
  int teamId,
) async {
  await pumpUntilFound(tester, find.byKey(const Key('glass-tab-bar')));
  expect(container.read(authControllerProvider), AuthStatus.signedIn);
  expect(_location(container), AppRoutes.home);
  expect(container.read(currentMembershipProvider)?.team.id, teamId);
}

void main() {
  group('meedoen via de teamlink', () {
    testWidgets(
      'uitgelogd: naam aantikken, bevestigen, adres → ingelogd in dat team',
      (tester) async {
        final (container, http) = await _open(
          tester,
          AppRoutes.joinLink(JoinFixtures.token),
          until: find.byKey(const Key('join-role-player')),
          setup: (http) => http
            ..on(_show, 200, JoinFixtures.link())
            ..on(_join, 200, JoinFixtures.tokenResponse()),
        );

        expect(find.text('Welkom bij Vogels 3'), findsOneWidget);
        expect(find.text('Wat doe jij bij dit team?'), findsOneWidget);

        await _tap(tester, find.byKey(const Key('join-role-player')));
        expect(find.text('Wie ben jij?'), findsOneWidget);
        expect(find.text('Linda de Lange'), findsOneWidget);

        await _tap(tester, find.byKey(const ValueKey('join-player-12')));
        expect(find.text('Ben jij Jeroen Bakker?'), findsOneWidget);
        expect(find.text('Rugnummer 7 in de selectie'), findsOneWidget);

        await _tap(tester, find.byKey(const Key('join-claim-yes')));
        expect(find.text('Hoe kom je er straks weer in?'), findsOneWidget);

        await tester.enterText(
          find.byKey(const Key('join-email')),
          'jeroen@example.com',
        );
        await _tap(tester, find.byKey(const Key('join-submit')));
        await _expectHome(tester, container, 3);

        expect(http.requestsTo(_join).single.body, {
          'role': 'player',
          'player_id': 12,
          'claim_confirmed': true,
          'name': null,
          'email': 'jeroen@example.com',
          'device_name': 'iPhone',
        });
      },
    );

    testWidgets('toeschouwer met naam, adres overslaan', (tester) async {
      final (container, http) = await _open(
        tester,
        AppRoutes.joinLink(JoinFixtures.token),
        until: find.byKey(const Key('join-role-spectator')),
        setup: (http) => http
          ..on(_show, 200, JoinFixtures.link())
          ..on(_join, 200, JoinFixtures.tokenResponse()),
      );

      await _tap(tester, find.byKey(const Key('join-role-spectator')));
      expect(find.text('Dan weet het team wie je bent'), findsOneWidget);
      await tester.enterText(find.byKey(const Key('join-name')), 'Oma Bakker');
      await tester.pump();
      await _tap(tester, find.byKey(const Key('join-next')));
      await _tap(tester, find.byKey(const Key('join-skip')));
      await _expectHome(tester, container, 3);

      expect(http.requestsTo(_join).single.body, {
        'role': 'spectator',
        'player_id': null,
        'claim_confirmed': false,
        'name': 'Oma Bakker',
        'email': null,
        'device_name': 'iPhone',
      });
    });

    testWidgets(
      'ingetikte naam uit de selectie vraagt "ben jij …?"; nee → nieuwe speler',
      (tester) async {
        final (_, http) = await _open(
          tester,
          AppRoutes.joinLink(JoinFixtures.token),
          until: find.byKey(const Key('join-role-player')),
          setup: (http) => http
            ..on(_show, 200, JoinFixtures.link())
            ..on(_join, 202, JoinFixtures.confirmationSent()),
        );

        await _tap(tester, find.byKey(const Key('join-role-player')));
        await _tap(tester, find.byKey(const Key('join-not-listed')));
        await tester.enterText(
          find.byKey(const Key('join-name')),
          '  linda  de lange ',
        );
        await tester.pump();
        await _tap(tester, find.byKey(const Key('join-next')));
        expect(find.text('Ben jij Linda de Lange?'), findsOneWidget);
        expect(
          find.text('Je neemt deze plek in de selectie over'),
          findsOneWidget,
        );

        await _tap(tester, find.byKey(const Key('join-claim-no')));
        expect(find.text('Hoe kom je er straks weer in?'), findsOneWidget);
        await tester.enterText(
          find.byKey(const Key('join-email')),
          'linda@example.com',
        );
        await _tap(tester, find.byKey(const Key('join-submit')));

        final body = http.requestsTo(_join).single.body! as Map;
        expect(body['player_id'], isNull);
        expect(body['name'], 'linda  de lange');
      },
    );

    testWidgets('202 bestaand account: check je mail + inloggen met code', (
      tester,
    ) async {
      final (container, http) = await _open(
        tester,
        AppRoutes.joinLink(JoinFixtures.token),
        until: find.byKey(const Key('join-role-player')),
        setup: (http) => http
          ..on(_show, 200, JoinFixtures.link(players: const []))
          ..on(_join, 202, JoinFixtures.confirmationSent())
          ..on('POST /auth/request', 202, ApiFixtures.requestResponse()),
      );

      // Zonder selectie: meteen het naamveld.
      await _tap(tester, find.byKey(const Key('join-role-player')));
      expect(find.text('Hoe heet je?'), findsOneWidget);
      await tester.enterText(find.byKey(const Key('join-name')), 'Jeroen');
      await tester.pump();
      await _tap(tester, find.byKey(const Key('join-next')));
      await tester.enterText(
        find.byKey(const Key('join-email')),
        'jeroen@example.com',
      );
      await _tap(tester, find.byKey(const Key('join-submit')));

      expect(find.text('Je hebt al een account'), findsOneWidget);
      expect(
        find.text(
          'We hebben je een mail gestuurd. Tik op de knop daarin, dan sta je in Vogels 3.',
        ),
        findsOneWidget,
      );
      expect(find.text('jeroen@example.com'), findsOneWidget);
      expect(container.read(authControllerProvider), AuthStatus.signedOut);

      await _tap(tester, find.byKey(const Key('join-code-login')));
      expect(http.requestsTo('POST /auth/request').single.body, {
        'email': 'jeroen@example.com',
      });
      expect(
        _location(container),
        '${AppRoutes.loginCode}?email=jeroen%40example.com',
      );
    });

    testWidgets('verlopen teamlink (410): de zin van de server', (
      tester,
    ) async {
      await _open(
        tester,
        AppRoutes.joinLink(JoinFixtures.token),
        until: find.byKey(const ValueKey('join-invalid')),
        setup: (http) => http.on(_show, 410, JoinFixtures.expired()),
      );

      expect(find.text('Deze teamlink werkt niet meer'), findsOneWidget);
      expect(find.text(JoinFixtures.expiredMessage), findsOneWidget);
    });

    testWidgets('onbekende teamlink (404) → naar de app = loginscherm', (
      tester,
    ) async {
      final (container, _) = await _open(
        tester,
        AppRoutes.joinLink(JoinFixtures.token),
        until: find.byKey(const ValueKey('join-invalid')),
        setup: (http) => http.on(_show, 404, JoinFixtures.expired()),
      );

      await _tap(tester, find.text('Naar de app'));
      expect(_location(container), AppRoutes.login);
    });

    testWidgets('422 en 403 (demo) blijven op het adresscherm met de melding', (
      tester,
    ) async {
      final (_, http) = await _open(
        tester,
        AppRoutes.joinLink(JoinFixtures.token),
        until: find.byKey(const Key('join-role-spectator')),
        setup: (http) => http
          ..on(_show, 200, JoinFixtures.link())
          ..on(
            _join,
            422,
            JoinFixtures.validation('email', 'Dit e-mailadres klopt niet.'),
          ),
      );

      await _tap(tester, find.byKey(const Key('join-role-spectator')));
      await tester.enterText(find.byKey(const Key('join-name')), 'Oma');
      await tester.pump();
      await _tap(tester, find.byKey(const Key('join-next')));
      await tester.enterText(
        find.byKey(const Key('join-email')),
        'oma@example.com',
      );
      await _tap(tester, find.byKey(const Key('join-submit')));
      expect(find.text('Dit e-mailadres klopt niet.'), findsOneWidget);

      // Ongeldig adres: niet verzonden.
      await tester.enterText(find.byKey(const Key('join-email')), 'oma@');
      await _tap(tester, find.byKey(const Key('join-submit')));
      expect(find.text('Vul een geldig e-mailadres in.'), findsOneWidget);
      expect(http.requestsTo(_join), hasLength(1));

      http.on(_join, 403, JoinFixtures.demoRefusal());
      await tester.enterText(
        find.byKey(const Key('join-email')),
        'oma@example.com',
      );
      await _tap(tester, find.byKey(const Key('join-submit')));
      expect(
        find.text('Dit is een demo. Aanmelden kan hier niet.'),
        findsOneWidget,
      );
      expect(find.byKey(const Key('join-email')), findsOneWidget);
    });

    testWidgets('ingelogd en al lid (already_member): meteen naar dat team', (
      tester,
    ) async {
      final (container, http) = await _open(
        tester,
        AppRoutes.joinLink(JoinFixtures.token),
        token: '12|abc',
        until: find.byKey(const Key('glass-tab-bar')),
        setup: (http) =>
            http.on(_show, 200, JoinFixtures.link(alreadyMember: true)),
      );
      await tester.pumpAndSettle();

      await _expectHome(tester, container, 3);
      expect(http.requestsTo(_show).single.authorization, 'Bearer 12|abc');
      expect(http.requestsTo(_join), isEmpty);
    });

    testWidgets('ingelogd: eigen adres voorgevuld; 409 → naar dat team', (
      tester,
    ) async {
      final (container, http) = await _open(
        tester,
        AppRoutes.joinLink(JoinFixtures.token),
        token: '12|abc',
        until: find.byKey(const Key('join-role-spectator')),
        setup: (http) => http
          ..on(_show, 200, JoinFixtures.link())
          ..on(_join, 409, JoinFixtures.alreadyMember()),
      );
      expect(container.read(currentMembershipProvider)?.team.id, 9);

      await _tap(tester, find.byKey(const Key('join-role-spectator')));
      await tester.enterText(find.byKey(const Key('join-name')), 'Sam');
      await tester.pump();
      await _tap(tester, find.byKey(const Key('join-next')));
      expect(find.text('sam@example.com'), findsOneWidget);
      await _tap(tester, find.byKey(const Key('join-submit')));

      await _expectHome(tester, container, 3);
      expect(
        http.requestsTo(_join).single.body,
        containsPair('email', 'sam@example.com'),
      );
    });
  });

  group('bevestiglink uit de mail', () {
    final confirmLocation = AppRoutes.joinConfirmLink(
      JoinFixtures.token,
      JoinFixtures.login,
      query: {'role': 'player', 'player': '12'},
    );

    testWidgets('uitgelogd: "Doe mee" → ingelogd in dat team', (tester) async {
      final (container, http) = await _open(
        tester,
        confirmLocation,
        until: find.byKey(const Key('join-confirm-submit')),
        setup: (http) => http
          ..on(_confirmShow, 200, JoinFixtures.confirmation())
          ..on(_confirm, 200, JoinFixtures.tokenResponse(token: '42|conf')),
      );

      expect(find.text('Hoi Jeroen Bakker'), findsOneWidget);
      expect(
        find.text(
          'Je doet mee met Vogels 3, als Jeroen Bakker. Je andere teams blijven gewoon staan.',
        ),
        findsOneWidget,
      );
      expect(http.requestsTo(_confirmShow).single.options.uri.queryParameters, {
        'role': 'player',
        'player': '12',
      });

      await _tap(tester, find.byKey(const Key('join-confirm-submit')));
      await _expectHome(tester, container, 3);
      expect(http.requestsTo(_confirm).single.body, {
        'role': 'player',
        'player_id': 12,
        'name': null,
        'device_name': 'iPhone',
      });
    });

    testWidgets('422 errors.login toont de melding', (tester) async {
      await _open(
        tester,
        confirmLocation,
        until: find.byKey(const Key('join-confirm-submit')),
        setup: (http) => http
          ..on(_confirmShow, 200, JoinFixtures.confirmation())
          ..on(
            _confirm,
            422,
            JoinFixtures.validation(
              'login',
              'Deze link is ongeldig of verlopen. Tik opnieuw op de teamlink.',
            ),
          ),
      );

      await _tap(tester, find.byKey(const Key('join-confirm-submit')));
      expect(
        find.text(
          'Deze link is ongeldig of verlopen. Tik opnieuw op de teamlink.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('valid:false → link werkt niet meer, terug naar de teamlink', (
      tester,
    ) async {
      final (container, _) = await _open(
        tester,
        confirmLocation,
        until: find.byKey(const ValueKey('join-confirm-expired')),
        setup: (http) => http
          ..on(_confirmShow, 200, JoinFixtures.confirmation(valid: false))
          ..on(_show, 200, JoinFixtures.link()),
      );

      expect(find.text('Deze link werkt niet meer'), findsOneWidget);
      await _tap(tester, find.text('Naar de teamlink'));
      await pumpUntilFound(tester, find.byKey(const Key('join-role-player')));
      expect(_location(container), AppRoutes.joinLink(JoinFixtures.token));
    });
  });

  group('uitnodiging', () {
    testWidgets('begroeting, Doorgaan → ingelogd', (tester) async {
      final (container, http) = await _open(
        tester,
        AppRoutes.inviteLink(JoinFixtures.invite),
        until: find.byKey(const Key('invite-accept')),
        setup: (http) => http
          ..on(_invite, 200, JoinFixtures.inviteInfo())
          ..on(_accept, 200, JoinFixtures.tokenResponse(token: '43|inv')),
      );

      expect(find.text('Hallo Sam de Vries'), findsOneWidget);
      await _tap(tester, find.byKey(const Key('invite-accept')));
      await _expectHome(tester, container, 9);
      expect(http.requestsTo(_accept).single.body, {'device_name': 'iPhone'});
    });

    testWidgets('verlopen (410) → melding + inloggen met een code', (
      tester,
    ) async {
      final (container, _) = await _open(
        tester,
        AppRoutes.inviteLink(JoinFixtures.invite),
        until: find.byKey(const ValueKey('invite-invalid')),
        setup: (http) => http.on(_invite, 410, {
          'message': JoinFixtures.inviteExpiredMessage,
        }),
      );

      expect(find.text(JoinFixtures.inviteExpiredMessage), findsOneWidget);
      await _tap(tester, find.text('Inloggen met een code'));
      expect(_location(container), AppRoutes.login);
    });

    testWidgets('al gebruikt bij accepteren (404) → melding', (tester) async {
      await _open(
        tester,
        AppRoutes.inviteLink(JoinFixtures.invite),
        until: find.byKey(const Key('invite-accept')),
        setup: (http) => http
          ..on(_invite, 200, JoinFixtures.inviteInfo())
          ..on(_accept, 404, {'message': JoinFixtures.inviteExpiredMessage}),
      );

      await _tap(tester, find.byKey(const Key('invite-accept')));
      expect(find.byKey(const ValueKey('invite-invalid')), findsOneWidget);
      expect(find.text(JoinFixtures.inviteExpiredMessage), findsOneWidget);
    });
  });
}
