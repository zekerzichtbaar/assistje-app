import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'poule_fixtures.dart';

const _poule = 'GET /teams/3/poule';

/// Start ingelogd in een team met poule en opent `/poule`.
Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  required void Function(FakeHttpAdapter http) setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [ApiFixtures.membership(hasPoule: true)],
    setup: setup,
  );
  container.read(routerProvider).go(AppRoutes.poule);
  await pumpUntilFound(tester, find.byKey(const ValueKey('poule-screen')));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('stand, uitslagen en programma', (tester) async {
    final (container, _) = await _open(
      tester,
      setup: (http) => http.on(_poule, 200, PouleFixtures.poule()),
    );

    expect(currentTitle(tester), 'Poule');
    expect(find.text('2e klasse H · Mannen zaterdag reserve'), findsOneWidget);
    expect(find.byKey(const ValueKey('poule-updated')), findsOneWidget);
    expect(find.byKey(const ValueKey('poule-standing-1')), findsOneWidget);
    expect(find.byKey(const ValueKey('poule-standing-2')), findsOneWidget);
    expect(find.text('-2'), findsOneWidget);
    expect(find.text('+10'), findsOneWidget);

    await _tap(tester, find.text('Uitslagen'));
    expect(find.byKey(const ValueKey('poule-result-0-0')), findsOneWidget);
    expect(find.text('1 – 3'), findsOneWidget);
    expect(find.text("Roda '46 3"), findsOneWidget);

    await _tap(tester, find.text('Programma'));
    expect(find.byKey(const ValueKey('poule-fixture-0-0')), findsOneWidget);
    expect(find.text('12:00'), findsOneWidget);
    expect(find.text('SVL 2'), findsOneWidget);

    // Eigen uitslag met event → activiteit.
    await _tap(tester, find.text('Uitslagen'));
    await _tap(tester, find.byKey(const ValueKey('poule-result-0-0')));
    expect(container.read(routerProvider).state.uri.path, '/events/812');
  });

  testWidgets('geen poulecode (404) → lege staat', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_poule, 404, {'message': 'Not found.'}),
    );
    expect(find.byKey(const ValueKey('poule-none')), findsOneWidget);
    expect(find.text('Geen poule gekoppeld'), findsOneWidget);
  });

  testWidgets('nog nooit gesynct → uitleg', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_poule, 200, PouleFixtures.neverSynced()),
    );
    expect(find.byKey(const ValueKey('poule-not-synced')), findsOneWidget);
    expect(find.byKey(const ValueKey('poule-tabs')), findsNothing);
  });

  testWidgets('lege uitslagen per tab', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(
        _poule,
        200,
        PouleFixtures.poule(results: const [], fixtures: const []),
      ),
    );
    await _tap(tester, find.text('Uitslagen'));
    expect(find.byKey(const ValueKey('poule-results-empty')), findsOneWidget);
    await _tap(tester, find.text('Programma'));
    expect(find.byKey(const ValueKey('poule-fixtures-empty')), findsOneWidget);
  });

  testWidgets('laadfout → opnieuw proberen', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(_poule, 500, {'message': 'Kapot.'}),
    );
    expect(find.byKey(const ValueKey('poule-error')), findsOneWidget);
    expect(find.text('Kapot.'), findsOneWidget);

    http.on(_poule, 200, PouleFixtures.poule());
    await _tap(tester, find.byKey(const ValueKey('poule-retry')));
    expect(find.byKey(const ValueKey('poule-standing-1')), findsOneWidget);
  });
}
