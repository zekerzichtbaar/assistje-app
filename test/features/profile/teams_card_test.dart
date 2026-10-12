import 'package:assistje/app.dart';
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
import 'profile_fixtures.dart';

const _leave9 = 'DELETE /teams/9/membership';
const _leave3 = 'DELETE /teams/3/membership';

List<Map<String, dynamic>> _teams() => [
  ApiFixtures.membership(),
  ApiFixtures.membership(teamId: 9, name: 'Zwaluwen VR1'),
];

Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  List<Map<String, dynamic>>? teams,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  tester.view
    ..physicalSize = const Size(1800, 4200)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final backend = TestBackend(token: '12|abc');
  await backend.init();
  backend.http
    ..on('GET /me', 200, ApiFixtures.meResponse(teams: teams ?? _teams()))
    ..on('GET /teams/3/agenda', 200, ApiFixtures.emptyAgendaResponse())
    ..on('GET /teams/9/agenda', 200, ApiFixtures.emptyAgendaResponse())
    ..on('GET /teams/3/profile', 200, ProfileFixtures.profile())
    ..on('GET /teams/9/profile', 200, ProfileFixtures.profile());
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
  container.read(routerProvider).go(AppRoutes.profile);
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
  testWidgets('één team: geen Mijn teams', (tester) async {
    await _open(tester, teams: [ApiFixtures.membership()]);
    expect(find.byKey(const ValueKey('profile-team')), findsOneWidget);
    expect(find.byKey(const ValueKey('profile-teams')), findsNothing);
  });

  testWidgets('meer teams: lijst met nu open en Verlaten', (tester) async {
    await _open(tester);
    expect(find.byKey(const ValueKey('profile-teams')), findsOneWidget);
    expect(find.text('Mijn teams'), findsOneWidget);
    expect(find.byKey(const ValueKey('profile-teams-3')), findsOneWidget);
    expect(find.byKey(const ValueKey('profile-teams-9')), findsOneWidget);
    expect(find.byKey(const ValueKey('profile-teams-leave-3')), findsOneWidget);
    expect(find.byKey(const ValueKey('profile-teams-leave-9')), findsOneWidget);
    expect(find.textContaining('nu open'), findsOneWidget);
  });

  testWidgets('annuleren stuurt niets', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(_leave9, 204),
    );
    await _tap(tester, find.byKey(const ValueKey('profile-teams-leave-9')));
    expect(find.text('Zwaluwen VR1 verlaten?'), findsOneWidget);
    await _tap(tester, find.byKey(const ValueKey('profile-confirm-cancel')));
    expect(http.requestsTo(_leave9), isEmpty);
  });

  testWidgets('bevestigen verlaat het team en ververst /me', (tester) async {
    final (container, http) = await _open(
      tester,
      setup: (http) => http.on(_leave9, 204),
    );
    await _tap(tester, find.byKey(const ValueKey('profile-teams-leave-9')));
    expect(
      find.text(
        'Je ziet dit team daarna niet meer in de app en krijgt er geen '
        'meldingen meer van. Je gegevens blijven bij het team staan.',
      ),
      findsOneWidget,
    );
    http.on(
      'GET /me',
      200,
      ApiFixtures.meResponse(teams: [ApiFixtures.membership()]),
    );
    await _tap(tester, find.byKey(const ValueKey('profile-confirm-ok')));

    expect(http.requestsTo(_leave9), hasLength(1));
    expect(find.text('Je hebt Zwaluwen VR1 verlaten.'), findsOneWidget);
    expect(container.read(currentMembershipProvider)?.team.id, 3);
    // Nog maar één team: de kaart verdwijnt.
    expect(find.byKey(const ValueKey('profile-teams')), findsNothing);
  });

  testWidgets('het open team verlaten wisselt naar een ander team', (
    tester,
  ) async {
    final (container, http) = await _open(
      tester,
      setup: (http) => http.on(_leave3, 204),
    );
    http.on(
      'GET /me',
      200,
      ApiFixtures.meResponse(
        teams: [ApiFixtures.membership(teamId: 9, name: 'Zwaluwen VR1')],
      ),
    );
    await _tap(tester, find.byKey(const ValueKey('profile-teams-leave-3')));
    await _tap(tester, find.byKey(const ValueKey('profile-confirm-ok')));

    expect(http.requestsTo(_leave3), hasLength(1));
    expect(container.read(currentTeamIdProvider), 9);
    expect(container.read(currentMembershipProvider)?.team.id, 9);
  });

  testWidgets('422 toont de melding van de server', (tester) async {
    final (container, http) = await _open(
      tester,
      setup: (http) =>
          http.on(_leave9, 422, {'message': 'Dit is je enige team.'}),
    );
    await _tap(tester, find.byKey(const ValueKey('profile-teams-leave-9')));
    await _tap(tester, find.byKey(const ValueKey('profile-confirm-ok')));

    expect(find.text('Verlaten mislukt'), findsOneWidget);
    expect(find.text('Dit is je enige team.'), findsOneWidget);
    expect(find.byKey(const ValueKey('profile-teams')), findsOneWidget);
    expect(container.read(currentMembershipProvider)?.team.id, 3);
  });
}
