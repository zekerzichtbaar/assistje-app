import 'package:assistje/app.dart';
import 'package:assistje/core/theme/assistje_tokens.dart';
import 'package:assistje/core/theme/theme_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/api_fixtures.dart';
import 'helpers/pump.dart';
import 'helpers/test_app.dart';

void main() {
  testWidgets('verse start zonder token toont het inlogscherm', (tester) async {
    final backend = TestBackend();
    await backend.init();

    await tester.pumpWidget(
      ProviderScope(
        overrides: backend.overrides,
        retry: (_, _) => null,
        child: const AssistjeApp(),
      ),
    );
    await pumpUntilFound(tester, find.text('Log in bij je team'));

    expect(find.text('Stuur mij een code'), findsOneWidget);
    expect(backend.http.requests, isEmpty);
  });

  testWidgets('ingelogd: tabshell, thema, Nederlandse copy en themawissel', (
    tester,
  ) async {
    final backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http.on('GET /me', 200, ApiFixtures.meResponse());

    await tester.pumpWidget(
      ProviderScope(
        overrides: backend.overrides,
        retry: (_, _) => null,
        child: const AssistjeApp(),
      ),
    );
    await pumpUntilFound(tester, find.byKey(const Key('glass-tab-bar')));

    // Na inloggen: de Agenda-tab.
    expect(find.text('Agenda'), findsWidgets);
    expect(find.text('Mij'), findsOneWidget);

    await tester.tap(find.byKey(const Key('tab-profile')));
    await tester.pumpAndSettle();
    expect(find.text('Vogels 3'), findsOneWidget);
    expect(find.text('Speler'), findsOneWidget);

    final context = tester.element(find.text('Vogels 3'));
    expect(Theme.of(context).extension<AssistjeTokens>(), isNotNull);
    expect(Theme.of(context).colorScheme.primary, const Color(0xFF006837));

    await tester.tap(find.text('Donker'));
    await tester.pumpAndSettle();

    final darkContext = tester.element(find.text('Vogels 3'));
    expect(Theme.of(darkContext).brightness, Brightness.dark);
    expect(Theme.of(darkContext).colorScheme.primary, const Color(0xFF13EC86));
    expect(backend.prefs.getString(ThemeModeNotifier.storageKey), 'dark');
  });
}
