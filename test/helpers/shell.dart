import 'package:assistje/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'api_fixtures.dart';
import 'fake_http_adapter.dart';
import 'pump.dart';
import 'test_app.dart';

/// Start de app ingelogd met [teams] uit `/me` en wacht tot de tabshell
/// staat. Geeft de container en backend terug.
///
/// [agenda] is het antwoord op `GET teams/{team}/agenda` (standaard een lege
/// agenda); [setup] kan vóór het starten extra routes op de nep-API zetten.
Future<(ProviderContainer, TestBackend)> pumpSignedIn(
  WidgetTester tester, {
  required List<Map<String, dynamic>> teams,
  Map<String, Object>? prefs,
  Map<String, dynamic>? agenda,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  // Hoog genoeg om het hele menu te bouwen. 600 pt breed in plaats van een
  // telefoon: het testfont (elk teken een vierkant) is veel breder dan
  // Figtree, en de agenda-tabpills passen anders niet.
  tester.view
    ..physicalSize = const Size(1800, 4200)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final backend = TestBackend(token: '12|abc', prefs: prefs);
  await backend.init();
  backend.http.on('GET /me', 200, ApiFixtures.meResponse(teams: teams));
  // De Agenda-tab is het eerste scherm: standaard een lege agenda per team.
  for (final membership in teams) {
    final team = membership['team'] as Map<String, dynamic>;
    backend.http.on(
      'GET /teams/${team['id']}/agenda',
      200,
      agenda ?? ApiFixtures.emptyAgendaResponse(),
    );
  }
  setup?.call(backend.http);
  final container = backend.container();
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const AssistjeApp()),
  );
  await pumpUntilFound(tester, find.byKey(const Key('glass-tab-bar')));
  return (container, backend);
}

/// De zichtbare tabs, in volgorde (`tab-<NavItem.name>`).
List<String> visibleTabs(WidgetTester tester) =>
    _keysWithPrefix('tab-').where((k) => k != 'tab-pill').toList();

/// De rijen van de Meer-tab, in volgorde (`menu-<NavItem.name>`), zonder de
/// vaste rijen (Profiel/Uitloggen).
List<String> visibleMenuItems(WidgetTester tester) => _keysWithPrefix('menu-')
    .where((k) => k != 'menu-profile' && k != 'menu-logout' && k != 'menu-list')
    .toList();

List<String> _keysWithPrefix(String prefix) {
  final keys = <String>[];
  for (final element in find.byWidgetPredicate((w) {
    final key = w.key;
    final value = key is ValueKey<String> ? key.value : null;
    return value != null && value.startsWith(prefix);
  }).evaluate()) {
    keys.add((element.widget.key! as ValueKey<String>).value);
  }
  return keys;
}

/// Opent de Meer-tab (de opvolger van het hamburgermenu). Staat er een
/// scherm over de tabs heen, dan eerst terug tot de tabbalk weer zichtbaar is.
Future<void> openMenu(WidgetTester tester) async {
  final more = find.byKey(const Key('tab-more')).hitTestable();
  while (more.evaluate().isEmpty) {
    await tester.tap(find.byKey(const Key('shell-back')));
    await tester.pumpAndSettle();
  }
  await tester.tap(more);
  await tester.pumpAndSettle();
}

/// Opent je profiel via de Meer-tab.
Future<void> openProfile(WidgetTester tester) async {
  await openMenu(tester);
  await tester.tap(find.byKey(const ValueKey('menu-profile')));
  await tester.pumpAndSettle();
}

/// De titel van het zichtbare (placeholder)scherm.
String? currentTitle(WidgetTester tester) {
  final finder = find.byKey(const Key('placeholder-title')).hitTestable();
  final found = finder.evaluate().toList();
  if (found.isEmpty) return null;
  return (found.last.widget as Text).data;
}
