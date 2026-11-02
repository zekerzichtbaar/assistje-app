// e2e-rol: trainer
//
// Flow 6: de trainer stuurt een teambericht, zonder toeschouwers.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'support/app.dart';
import 'support/waits.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('trainer stuurt een teambericht zonder toeschouwers', (
    tester,
  ) async {
    final title = 'E2E-bericht ${DateTime.now().millisecondsSinceEpoch}';
    await startSignedIn(tester, role: 'trainer');
    await openFromMore(tester, 'menu-messages');

    await tapOn(tester, find.byKey(const ValueKey('messages-compose')));
    await enterInto(
      tester,
      find.byKey(const ValueKey('messages-compose-title')),
      title,
    );
    await enterInto(
      tester,
      find.byKey(const ValueKey('messages-compose-body')),
      'Verstuurd door de integratietest.',
    );

    // Toeschouwers uit (standaard al uit; alleen zichtbaar als die er zijn).
    final spectators = find.byKey(
      const ValueKey('messages-compose-spectators'),
    );
    if (spectators.evaluate().isNotEmpty) {
      final toggle = find.descendant(
        of: spectators,
        matching: find.byType(Switch),
        matchRoot: true,
      );
      if (tester.widget<Switch>(toggle.first).value) {
        await tapOn(tester, toggle);
      }
      expect(tester.widget<Switch>(toggle.first).value, isFalse);
    }

    await tapOn(tester, find.byKey(const ValueKey('messages-compose-send')));
    await tapOn(tester, find.byKey(const ValueKey('messages-confirm-send')));
    await waitFor(tester, find.text('Bericht verstuurd'));
    await waitFor(tester, find.text(title));
  });
}
