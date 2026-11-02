// e2e-rol: trainer
//
// Flow 4: de trainer zet twee mensen op een "één of meer"-dienst (Rijden) bij
// de komende wedstrijd.
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'support/app.dart';
import 'support/fixture.dart';
import 'support/waits.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('trainer plant meerdere mensen op een multi-dienst', (
    tester,
  ) async {
    final fixture = E2eFixture.current;
    final container = await startSignedIn(tester, role: 'trainer');
    await openEvent(tester, container, fixture.matchUpcoming);

    final row = find.byKey(ValueKey('event-duty-${fixture.dutyTypeMultiId}'));
    await scrollTo(
      tester,
      row,
      within: find.byKey(const ValueKey('event-detail-screen')),
    );
    await tapOn(tester, row);

    // Twee opties uit de sheet; bij "multi" blijft hij open na elke tik.
    final options = byKeyPrefix(
      'event-duty-option-',
      except: {'event-duty-option-none', 'event-duty-option-check'},
    );
    await waitFor(tester, options);
    final names = <String>[];
    for (var i = 0; i < 2; i++) {
      final option = options.at(i);
      names.add(
        tester
            .widget<Text>(
              find.descendant(of: option, matching: find.byType(Text)).first,
            )
            .data!,
      );
      await tapOn(tester, option);
      await waitUntil(
        tester,
        () =>
            find
                .byKey(const ValueKey('event-duty-option-check'))
                .evaluate()
                .length ==
            i + 1,
        what: '${i + 1} gekozen',
      );
    }

    // Sheet dicht (buiten tikken) → de rij noemt beide namen.
    await tester.tapAt(const Offset(20, 80));
    await pumpFor(tester, const Duration(seconds: 1));
    for (final name in names) {
      await waitFor(
        tester,
        find.descendant(of: row, matching: find.textContaining(name)),
      );
    }
  });
}
