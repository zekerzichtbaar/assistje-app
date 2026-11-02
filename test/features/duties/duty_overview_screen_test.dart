import 'dart:async';

import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'duties_fixtures.dart';

const _overview = 'GET /teams/3/duty-overview';

Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  String role = 'player',
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [ApiFixtures.membership(role: role, hasDuties: true)],
    setup: (http) {
      http.on(_overview, 200, DutiesFixtures.overview());
      setup?.call(http);
    },
  );
  unawaited(container.read(routerProvider).push(AppRoutes.dutyOverview));
  await pumpUntilFound(
    tester,
    find.byKey(const ValueKey('duty-overview-screen')),
  );
  await tester.pumpAndSettle();
  return (container, backend.http);
}

String _path(ProviderContainer c) => c.read(routerProvider).state.uri.path;

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('eigen beurten eerst, dan per dienst gepland en groepen', (
    tester,
  ) async {
    await _open(tester);

    expect(currentTitle(tester), 'Diensten');
    final mine = find.byKey(const ValueKey('duty-overview-mine'));
    expect(
      find.descendant(of: mine, matching: find.text('JOUW BEURTEN')),
      findsOneWidget,
    );
    // Jouw beurten: het diensttype voorop, met wanneer en waarbij.
    expect(
      find.descendant(of: mine, matching: find.text('Rijden')),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: mine,
        matching: find.text('zo 8 nov · Kraaien 1 – Vogels 3'),
      ),
      findsOneWidget,
    );

    // Per type: de namen, "Jij" en "en nog" naar de agenda.
    final rijden = find.byKey(const ValueKey('duty-overview-type-3'));
    expect(
      find.descendant(
        of: rijden,
        matching: find.text('Sam de Vries, Bram Visser'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(of: rijden, matching: find.text('Jij')),
      findsOneWidget,
    );
    expect(find.text('En nog 9 — zie de agenda'), findsOneWidget);

    // Groepsdienst: Gepland + Groepen, een gedane beurt zonder wedstrijd.
    final kantine = find.byKey(const ValueKey('duty-overview-type-4'));
    await tester.ensureVisible(kantine);
    expect(
      find.descendant(of: kantine, matching: find.text('GEPLAND')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: kantine, matching: find.text('GROEPEN')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: kantine, matching: find.text('gedaan')),
      findsOneWidget,
    );
    expect(find.text('zo 8 nov · Sleutel ophalen'), findsOneWidget);
    expect(find.text('Bram Visser, Sam de Vries'), findsOneWidget);
    expect(find.text('Nog niemand ingedeeld'), findsOneWidget);
  });

  testWidgets('een beurt bij een wedstrijd opent de wedstrijd', (tester) async {
    final (container, _) = await _open(tester);

    await _tap(tester, find.byKey(const ValueKey('duty-overview-mine-120')));
    expect(_path(container), '/events/812');
  });

  testWidgets('"en nog" gaat naar de agenda', (tester) async {
    final (container, _) = await _open(tester);

    await _tap(tester, find.byKey(const ValueKey('duty-overview-type-3-more')));
    expect(_path(container), AppRoutes.agenda);
  });

  testWidgets('niets voor jou, en geen diensten', (tester) async {
    await _open(
      tester,
      role: 'spectator',
      setup: (http) =>
          http.on(_overview, 200, DutiesFixtures.overview(mine: const [])),
    );
    expect(find.text('Je staat nergens op ingepland.'), findsOneWidget);
  });

  testWidgets('leeg: nog geen diensten gepland', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(
        _overview,
        200,
        DutiesFixtures.overview(mine: const [], duties: const []),
      ),
    );
    expect(find.byKey(const ValueKey('duty-overview-empty')), findsOneWidget);
    expect(find.text('Er staan nog geen diensten gepland.'), findsOneWidget);
  });

  testWidgets('fout bij laden, opnieuw proberen', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(_overview, 500, {'message': 'Server error'}),
    );
    expect(find.byKey(const ValueKey('duty-overview-error')), findsOneWidget);

    http.on(_overview, 200, DutiesFixtures.overview());
    await _tap(tester, find.byKey(const ValueKey('duty-overview-retry')));
    expect(find.byKey(const ValueKey('duty-overview-mine')), findsOneWidget);
  });

  testWidgets('trekken om te verversen haalt opnieuw op', (tester) async {
    final (_, http) = await _open(tester);
    final before = http.requestsTo(_overview).length;

    await tester.fling(
      find.byKey(const ValueKey('duty-overview-mine')),
      const Offset(0, 400),
      1000,
    );
    await tester.pumpAndSettle();
    expect(http.requestsTo(_overview).length, before + 1);
  });

  group('Meer-tab: Diensten alleen met has_duties, niet voor de trainer', () {
    Future<List<String>> menu(
      WidgetTester tester,
      Map<String, dynamic> membership,
    ) async {
      await pumpSignedIn(tester, teams: [membership]);
      await openMenu(tester);
      return visibleMenuItems(tester);
    }

    testWidgets('speler met diensten', (tester) async {
      final items = await menu(tester, ApiFixtures.membership(hasDuties: true));
      expect(items, contains('menu-dutyOverview'));
      // Direct na Team, als `navItems.ts`.
      expect(
        items.indexOf('menu-dutyOverview'),
        items.indexOf('menu-team') + 1,
      );
    });

    testWidgets('toeschouwer met diensten', (tester) async {
      final items = await menu(
        tester,
        ApiFixtures.membership(role: 'spectator', hasDuties: true),
      );
      expect(items, contains('menu-dutyOverview'));
    });

    testWidgets('speler zonder diensten', (tester) async {
      final items = await menu(tester, ApiFixtures.membership());
      expect(items, isNot(contains('menu-dutyOverview')));
    });

    testWidgets('trainer heeft het beheer, niet het overzicht', (tester) async {
      final items = await menu(
        tester,
        ApiFixtures.membership(role: 'trainer', hasDuties: true),
      );
      expect(items, contains('menu-duties'));
      expect(items, isNot(contains('menu-dutyOverview')));
    });

    testWidgets('de rij opent het overzicht', (tester) async {
      final (container, _) = await pumpSignedIn(
        tester,
        teams: [ApiFixtures.membership(hasDuties: true)],
        setup: (http) => http.on(_overview, 200, DutiesFixtures.overview()),
      );
      await openMenu(tester);
      await _tap(tester, find.byKey(const ValueKey('menu-dutyOverview')));
      expect(_path(container), AppRoutes.dutyOverview);
      expect(
        find.byKey(const ValueKey('duty-overview-screen')),
        findsOneWidget,
      );
    });
  });
}
