import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/shell.dart';

void main() {
  final player = ApiFixtures.membership(
    features: {'stats': true, 'fines': true, 'wheel': true},
    unread: 2,
  );
  final trainer = ApiFixtures.membership(
    teamId: 9,
    name: 'Zwaluwen VR1',
    role: 'trainer',
    features: {'stats': true},
    hasPoule: true,
  );

  testWidgets('landt op de agenda; tabs wisselen en onthouden', (tester) async {
    final (container, _) = await pumpSignedIn(tester, teams: [player]);
    final router = container.read(routerProvider);

    expect(router.state.uri.path, '/agenda');
    expect(find.byKey(const Key('agenda-title')).hitTestable(), findsOneWidget);
    expect(find.byKey(const Key('tab-pill')), findsOneWidget);
    expect(find.byKey(const Key('shell-home')), findsOneWidget);

    await tester.tap(find.byKey(const Key('tab-stats')));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/stats');
    expect(currentTitle(tester), 'Statistieken');

    await tester.tap(find.byKey(const Key('tab-hallOfFame')));
    await tester.pumpAndSettle();
    expect(currentTitle(tester), 'Ranking');

    await tester.tap(find.byKey(const Key('tab-profile')));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/profile');
    expect(find.byKey(const Key('profile-team-name')), findsOneWidget);

    await tester.tap(find.byKey(const Key('tab-agenda')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('agenda-title')).hitTestable(), findsOneWidget);
  });

  testWidgets('bel met badge opent meldingen; terug-pil gaat terug', (
    tester,
  ) async {
    final (container, _) = await pumpSignedIn(tester, teams: [player]);
    final router = container.read(routerProvider);

    expect(
      find.descendant(
        of: find.byKey(const Key('shell-bell-badge')),
        matching: find.text('2'),
      ),
      findsOneWidget,
    );

    await tester.tap(find.byKey(const Key('shell-bell')));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/notifications');
    expect(currentTitle(tester), 'Meldingen');
    expect(find.byKey(const Key('shell-back')), findsOneWidget);

    await tester.tap(find.byKey(const Key('shell-back')));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/agenda');
    expect(find.byKey(const Key('shell-home')), findsOneWidget);
  });

  testWidgets('menu opent, navigeert en sluit', (tester) async {
    final (container, _) = await pumpSignedIn(tester, teams: [player]);
    final router = container.read(routerProvider);

    expect(find.byKey(const Key('menu-wheel')), findsNothing);
    await openMenu(tester);
    expect(find.byKey(const Key('menu-wheel')), findsOneWidget);
    expect(find.text('Sam de Vries'), findsOneWidget);

    await tester.tap(find.byKey(const Key('menu-wheel')));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/wheel');
    expect(currentTitle(tester), 'Radje');
    expect(find.byKey(const Key('menu-wheel')), findsNothing);

    // Vanaf een gepusht scherm vervangt het menu dat scherm.
    await openMenu(tester);
    await tester.tap(find.byKey(const Key('menu-fines')));
    await tester.pumpAndSettle();
    expect(currentTitle(tester), 'Boetepot');
    await tester.tap(find.byKey(const Key('shell-back')));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/agenda');

    // Een tik op de weggeschoven app sluit het menu.
    await openMenu(tester);
    // De app ligt dan links in beeld (het menu neemt 80% rechts).
    await tester.tapAt(const Offset(20, 300));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('menu-wheel')), findsNothing);
  });

  testWidgets('teamwissel in het menu wisselt team, kleur en tabs', (
    tester,
  ) async {
    final (container, backend) = await pumpSignedIn(
      tester,
      teams: [player, trainer],
    );
    final router = container.read(routerProvider);
    expect(find.byKey(const Key('tab-poule')), findsNothing);

    await openMenu(tester);
    expect(find.text('Wissel van team'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('team-9')));
    await tester.pumpAndSettle();

    expect(container.read(currentMembershipProvider)?.team.id, 9);
    expect(backend.prefs.getInt('current_team_id'), 9);
    expect(router.state.uri.path, '/agenda');
    expect(find.byKey(const Key('tab-poule')), findsOneWidget);
    expect(find.byKey(const Key('menu-team')), findsNothing);

    await openMenu(tester);
    expect(find.byKey(const Key('menu-players')), findsOneWidget);
  });

  testWidgets(
    'route-guard: verboden pad → agenda; diep pad → terug naar ouder',
    (tester) async {
      final (container, _) = await pumpSignedIn(tester, teams: [player]);
      final router = container.read(routerProvider);

      router.go('/settings');
      await tester.pumpAndSettle();
      expect(router.state.uri.path, '/agenda');

      router.go('/poule');
      await tester.pumpAndSettle();
      expect(router.state.uri.path, '/agenda');

      router.go('/');
      await tester.pumpAndSettle();
      expect(router.state.uri.path, '/agenda');

      router.go('/events/7/lineup');
      await tester.pumpAndSettle();
      expect(currentTitle(tester), 'Opstelling');
      await tester.tap(find.byKey(const Key('shell-back')));
      await tester.pumpAndSettle();
      expect(router.state.uri.path, '/events/7');
      expect(currentTitle(tester), 'Activiteit');
      await tester.tap(find.byKey(const Key('shell-back')));
      await tester.pumpAndSettle();
      expect(router.state.uri.path, '/agenda');
    },
  );

  testWidgets('uitloggen via het menu', (tester) async {
    final (_, backend) = await pumpSignedIn(tester, teams: [player]);
    backend.http.on('POST /auth/logout', 204);

    await openMenu(tester);
    await tester.tap(find.byKey(const Key('menu-logout')));
    await tester.pumpAndSettle();
    expect(find.text('Log in bij je team'), findsOneWidget);
    expect(backend.tokens.token, isNull);
  });
}
