import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'roster_fixtures.dart';

const _roster = 'GET /teams/3/team';

/// Start ingelogd als [membership] en opent [route].
Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  required Map<String, dynamic> membership,
  String route = AppRoutes.team,
  String screenKey = 'team-screen',
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [membership],
    setup: setup,
  );
  container.read(routerProvider).go(route);
  await pumpUntilFound(tester, find.byKey(ValueKey(screenKey)));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

void main() {
  testWidgets('selectie: coach, linies, gasten, markers en positienamen', (
    tester,
  ) async {
    await _open(
      tester,
      membership: RosterFixtures.membership(),
      setup: (http) => http.on(_roster, 200, RosterFixtures.roster()),
    );

    expect(currentTitle(tester), 'Team');
    expect(
      find.byKey(const ValueKey('roster-section-coaches')),
      findsOneWidget,
    );
    expect(find.text('COACH'), findsOneWidget);
    expect(find.byKey(const ValueKey('roster-coach-3')), findsOneWidget);
    expect(find.text('Trainer Tom'), findsOneWidget);

    // Sam (CM) bij de middenvelders, met de volledige positienaam.
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('roster-section-mid')),
        matching: find.byKey(const ValueKey('roster-player-14')),
      ),
      findsOneWidget,
    );
    expect(find.text('MIDDENVELDERS'), findsOneWidget);
    expect(find.text('Centrale middenvelder'), findsOneWidget);

    // De gastkeeper staat bij Gasten, niet bij de keepers.
    expect(find.byKey(const ValueKey('roster-section-gk')), findsNothing);
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('roster-section-guests')),
        matching: find.byKey(const ValueKey('roster-player-31')),
      ),
      findsOneWidget,
    );
    expect(find.text('gast'), findsOneWidget);
    expect(find.byKey(const ValueKey('roster-vacation-31')), findsOneWidget);
    expect(find.byKey(const ValueKey('roster-agreements')), findsNothing);
  });

  testWidgets('geblesseerd gaat voor vakantie; Overig zonder linie', (
    tester,
  ) async {
    await _open(
      tester,
      membership: RosterFixtures.membership(),
      setup: (http) => http.on(
        _roster,
        200,
        RosterFixtures.roster(
          players: [
            {
              ...RosterFixtures.sam(),
              'position': null,
              'is_injured': true,
              'is_on_vacation': true,
            },
          ],
          coaches: [],
        ),
      ),
    );

    expect(find.byKey(const ValueKey('roster-section-other')), findsOneWidget);
    expect(find.byKey(const ValueKey('roster-injured-14')), findsOneWidget);
    expect(find.byKey(const ValueKey('roster-vacation-14')), findsNothing);
    expect(find.byKey(const ValueKey('roster-section-coaches')), findsNothing);
  });

  testWidgets('tik op een speler opent het detail', (tester) async {
    final (container, _) = await _open(
      tester,
      membership: RosterFixtures.membership(),
      setup: (http) {
        http
          ..on(_roster, 200, RosterFixtures.roster())
          ..on('GET /teams/3/players/14', 200, RosterFixtures.playerDetail());
      },
    );

    await tester.tap(find.byKey(const ValueKey('roster-player-14')));
    await pumpUntilFound(tester, find.byKey(const ValueKey('player-header')));
    await tester.pumpAndSettle();

    expect(container.read(routerProvider).state.uri.path, '/players/14');
    expect(currentTitle(tester), 'Speler');
    expect(find.byKey(const ValueKey('player-name')), findsOneWidget);
  });

  testWidgets('teamafspraken-link bij feature agreements', (tester) async {
    await _open(
      tester,
      membership: RosterFixtures.membership(features: {'agreements': true}),
      setup: (http) => http.on(_roster, 200, RosterFixtures.roster()),
    );
    expect(find.byKey(const ValueKey('roster-agreements')), findsOneWidget);
  });

  testWidgets('lege selectie toont de lege staat', (tester) async {
    await _open(
      tester,
      membership: RosterFixtures.membership(),
      setup: (http) => http.on(
        _roster,
        200,
        RosterFixtures.roster(players: [], coaches: []),
      ),
    );
    expect(find.byKey(const ValueKey('roster-empty')), findsOneWidget);
    expect(find.text('Nog geen spelers in het team.'), findsOneWidget);
  });

  testWidgets('fout (onbekende route = 404) met opnieuw proberen', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      membership: RosterFixtures.membership(),
    );

    expect(currentTitle(tester), 'Team');
    expect(find.byKey(const ValueKey('roster-error')), findsOneWidget);
    expect(find.text('Selectie laden mislukt'), findsOneWidget);

    http.on(_roster, 200, RosterFixtures.roster());
    await tester.tap(find.byKey(const ValueKey('roster-retry')));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('roster-error')), findsNothing);
    expect(find.byKey(const ValueKey('roster-player-14')), findsOneWidget);
  });

  testWidgets('trainer: /players toont het spelersbeheer', (tester) async {
    await _open(
      tester,
      membership: RosterFixtures.membership(role: 'trainer'),
      route: AppRoutes.players,
      screenKey: 'players-screen',
      setup: (http) => http.on('GET /teams/3/players', 200, {
        'data': {
          'players': [
            {'id': 14, 'name': 'Sam Speler', 'position': 'CM'},
          ],
          'trainers': <Object>[],
          'spectators': <Object>[],
          'team_link': null,
          'team_link_state': 'revoked',
        },
      }),
    );

    expect(currentTitle(tester), 'Spelers');
    // Het beheer (zie test/features/player_management), niet de selectie.
    expect(find.byKey(const ValueKey('pm-player-14')), findsOneWidget);
    expect(find.byKey(const ValueKey('roster-player-14')), findsNothing);
  });
}
