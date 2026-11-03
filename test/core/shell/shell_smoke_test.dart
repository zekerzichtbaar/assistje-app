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

    await tester.tap(find.byKey(const Key('tab-more')));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/more');

    // Profiel duwt binnen de Meer-tab: de tabbalk blijft staan.
    await tester.tap(find.byKey(const ValueKey('menu-profile')));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/profile');
    expect(find.byKey(const Key('profile-team-name')), findsOneWidget);
    expect(find.byKey(const Key('tab-more')).hitTestable(), findsOneWidget);
    await tester.tap(find.byKey(const Key('shell-back')));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/more');

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

  testWidgets('Meer-tab toont alleen wat geen tab heeft en duwt het scherm', (
    tester,
  ) async {
    final (container, _) = await pumpSignedIn(tester, teams: [player]);
    final router = container.read(routerProvider);

    await openMenu(tester);
    expect(find.text('Sam de Vries'), findsOneWidget);
    expect(find.byKey(const ValueKey('menu-wheel')), findsOneWidget);
    // Agenda, Stats en Ranking zitten al in de tabbalk.
    expect(find.byKey(const ValueKey('menu-agenda')), findsNothing);
    expect(find.byKey(const ValueKey('menu-stats')), findsNothing);

    await tester.tap(find.byKey(const ValueKey('menu-wheel')));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/wheel');
    expect(currentTitle(tester), 'Radje');

    await tester.tap(find.byKey(const Key('shell-back')));
    await tester.pumpAndSettle();
    expect(router.state.uri.path, '/more');
  });

  testWidgets('teamwissel op de Meer-tab wisselt team, kleur en tabs', (
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

  testWidgets(
    'systeem-terug na een deep link gaat naar de ouder, niet de app uit',
    (tester) async {
      final (container, _) = await pumpSignedIn(tester, teams: [player]);
      final router = container.read(routerProvider);

      // Zoals DeepLinkHandler: go(), dus niets om te poppen.
      router.go('/events/7');
      await tester.pumpAndSettle();
      expect(router.canPop(), isFalse);

      // true = de app heeft terug zelf afgehandeld (Android sluit niet).
      expect(await tester.binding.handlePopRoute(), isTrue);
      await tester.pumpAndSettle();
      expect(router.state.uri.path, '/agenda');

      // Op een tabwortel mag terug de app wel verlaten.
      expect(await tester.binding.handlePopRoute(), isFalse);
    },
  );

  testWidgets('uitloggen via de Meer-tab', (tester) async {
    final (_, backend) = await pumpSignedIn(tester, teams: [player]);
    backend.http.on('POST /auth/logout', 204);

    await openMenu(tester);
    await tester.tap(find.byKey(const Key('menu-logout')));
    await tester.pumpAndSettle();
    expect(find.text('Log in bij je team'), findsOneWidget);
    expect(backend.tokens.token, isNull);
  });
}
