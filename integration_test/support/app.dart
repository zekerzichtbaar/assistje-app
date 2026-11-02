import 'dart:async';

import 'package:assistje/app.dart';
import 'package:assistje/core/push/push_messaging.dart';
import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/theme/theme_providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fixture.dart';
import 'waits.dart';

/// Start de echte app zoals `main.dart`, maar altijd uitgelogd: de Keychain
/// (het API-token) overleeft een herinstallatie op de simulator, dus die en de
/// SharedPreferences (gekozen team, thema) gaan eerst leeg.
Future<ProviderContainer> startApp(WidgetTester tester) async {
  await const FlutterSecureStorage().deleteAll();
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();

  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      // Geen Firebase in e2e: push staat uit, geen toestemmingsvraag.
      pushMessagingProvider.overrideWithValue(null),
    ],
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const AssistjeApp()),
  );
  return container;
}

/// Start de app en log in als [role] (`trainer`, `player`, `spectator`) via
/// het echte scherm: e-mailadres → code (verstuurt zichzelf bij 6 cijfers) →
/// Agenda.
Future<ProviderContainer> startSignedIn(
  WidgetTester tester, {
  required String role,
}) async {
  final container = await startApp(tester);
  final login = E2eLogin.forRole(role);

  await enterInto(
    tester,
    find.byKey(const ValueKey('login-email')),
    login.email,
  );
  await tapOn(tester, find.text('Stuur mij een code'));
  await enterInto(tester, find.byKey(const ValueKey('login-code')), login.code);
  await waitFor(
    tester,
    find.byKey(const ValueKey('agenda-title')),
    timeout: const Duration(seconds: 30),
  );
  return container;
}

/// Opent een event: via de kaart in de agenda als die te vinden is, anders
/// direct via de router (zelfde scherm, bv. een live wedstrijd die al onder
/// "Verleden" staat).
Future<void> openEvent(
  WidgetTester tester,
  ProviderContainer container,
  int eventId,
) async {
  final card = find.byKey(ValueKey('event-$eventId'));
  final found = await scrollTo(
    tester,
    card,
    within: find.byKey(const ValueKey('agenda-screen')),
    required: false,
  );
  if (found) {
    // Linksboven tikken: midden op de kaart zitten de RSVP-knoppen.
    await tester.tapAt(tester.getTopLeft(card) + const Offset(24, 20));
    await tester.pump();
  } else {
    unawaited(container.read(routerProvider).push('/events/$eventId'));
  }
  await waitFor(tester, find.byKey(const ValueKey('event-detail-title')));
}

/// Naar een item onder de tab *Meer* (`menu-<naam>`).
Future<void> openFromMore(WidgetTester tester, String menuKey) async {
  await tapOn(tester, find.byKey(const ValueKey('tab-more')));
  final item = find.byKey(ValueKey(menuKey));
  await scrollTo(tester, item, within: find.byKey(const ValueKey('more-list')));
  await tapOn(tester, item);
}
