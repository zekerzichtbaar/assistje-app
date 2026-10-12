import 'package:assistje/app.dart';
import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/test_app.dart';
import 'onboarding_fixtures.dart';

const _show = 'GET /teams/3/onboarding';
const _complete = 'POST /teams/3/onboarding/complete';

Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  required Map<String, dynamic> checklist,
  void Function(FakeHttpAdapter http)? setup,
  int status = 200,
}) async {
  tester.view
    ..physicalSize = const Size(1800, 4200)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final backend = TestBackend(token: '12|abc');
  await backend.init();
  backend.http
    ..on(
      'GET /me',
      200,
      ApiFixtures.meResponse(
        teams: [ApiFixtures.membership(role: 'trainer', onboardingOpen: true)],
      ),
    )
    ..on('GET /teams/3/agenda', 200, ApiFixtures.emptyAgendaResponse())
    ..on(_show, status, checklist);
  setup?.call(backend.http);
  final container = ProviderContainer(
    overrides: backend.overrides,
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const AssistjeApp()),
  );
  await pumpUntilFound(tester, find.byKey(const Key('glass-tab-bar')));
  container.read(routerProvider).go(AppRoutes.onboarding);
  await pumpUntilFound(tester, find.byKey(const ValueKey('onboarding-screen')));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

String _location(ProviderContainer container) =>
    container.read(routerProvider).state.uri.path;

void main() {
  testWidgets('toont de checklist: welkom, stappen, eerste wedstrijd', (
    tester,
  ) async {
    await _open(tester, checklist: OnboardingFixtures.checklist());

    expect(find.byKey(const Key('placeholder-title')), findsOneWidget);
    expect(find.text('Welkom bij'), findsOneWidget);
    expect(find.byKey(const ValueKey('onboarding-team-name')), findsOneWidget);
    expect(
      find.text('Nog 1 stap tot jullie eerste wedstrijd met de opkomst erbij.'),
      findsOneWidget,
    );
    expect(find.text('EERSTE STAPPEN · 2 VAN 3'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('onboarding-step-team-done')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('onboarding-step-schedule-done')),
      findsOneWidget,
    );
    // Alleen de huidige stap heeft een knop.
    expect(
      find.byKey(const ValueKey('onboarding-step-attendance-cta')),
      findsOneWidget,
    );
    expect(find.text('Bekijk de opkomst'), findsOneWidget);
    expect(find.text('Kijk wie er zijn'), findsOneWidget);
    expect(find.text('4 van 14 reageerden'), findsOneWidget);
    expect(find.byKey(const ValueKey('onboarding-skip')), findsOneWidget);
    expect(find.byKey(const ValueKey('onboarding-finish')), findsNothing);
  });

  testWidgets('aangevraagd programma en wachten op een wedstrijd', (
    tester,
  ) async {
    await _open(
      tester,
      checklist: OnboardingFixtures.checklist(
        scheduleRequest: 'pending',
        withMatch: false,
      ),
    );
    expect(
      find.text('Aangevraagd. Je krijgt bericht zodra het erin staat.'),
      findsOneWidget,
    );
    expect(
      find.text(
        'Zodra er een komende wedstrijd in de agenda staat, zie je hier wie '
        'er komen.',
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('onboarding-step-attendance-cta')),
      findsNothing,
    );
    expect(find.byKey(const ValueKey('onboarding-next-match')), findsNothing);
  });

  testWidgets('de knop van een stap opent het app-scherm', (tester) async {
    final (container, _) = await _open(
      tester,
      checklist: OnboardingFixtures.checklist(scheduleDone: false),
    );
    await _tap(
      tester,
      find.byKey(const ValueKey('onboarding-step-schedule-cta')),
    );
    expect(_location(container), AppRoutes.agenda);
  });

  testWidgets('alles gedaan: "Naar de app" rondt af en gaat naar huis', (
    tester,
  ) async {
    final (container, http) = await _open(
      tester,
      checklist: OnboardingFixtures.checklist(attendanceDone: true),
      setup: (http) => http.on(_complete, 200, OnboardingFixtures.completed()),
    );
    expect(find.text('Alles staat. Jullie team draait.'), findsOneWidget);
    final meLoads = http.requestsTo('GET /me').length;
    // Na afronden is de checklist dicht.
    http.on(
      'GET /me',
      200,
      ApiFixtures.meResponse(teams: [ApiFixtures.membership(role: 'trainer')]),
    );

    await _tap(tester, find.byKey(const ValueKey('onboarding-finish')));

    expect(http.requestsTo(_complete), hasLength(1));
    expect(http.requestsTo('GET /me').length, greaterThan(meLoads));
    expect(_location(container), AppRoutes.home);
  });

  testWidgets('afronden mislukt: fouttoast en blijft staan', (tester) async {
    final (container, http) = await _open(
      tester,
      checklist: OnboardingFixtures.checklist(),
      setup: (http) => http.on(_complete, 403, {'message': 'Dit is een demo.'}),
    );
    await _tap(tester, find.byKey(const ValueKey('onboarding-skip')));
    expect(find.text('Afronden mislukt'), findsOneWidget);
    expect(find.text('Dit is een demo.'), findsOneWidget);
    expect(_location(container), AppRoutes.onboarding);
  });

  testWidgets('403 voor een niet-trainer: foutscherm met opnieuw', (
    tester,
  ) async {
    await _open(tester, checklist: OnboardingFixtures.trainerOnly, status: 403);
    expect(find.byKey(const ValueKey('onboarding-error')), findsOneWidget);
    expect(find.text('Alleen de trainer kan dit.'), findsOneWidget);
    expect(find.byKey(const ValueKey('onboarding-retry')), findsOneWidget);
  });
}
