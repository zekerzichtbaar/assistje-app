// e2e-rol: trainer
//
// Flow 5: de trainer vinkt iemand af op de afvinklijst-spaarpot.
import 'package:assistje/features/savings/presentation/widgets/savings_grid.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'support/app.dart';
import 'support/fixture.dart';
import 'support/waits.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('trainer vinkt iemand af op de afvinklijst', (tester) async {
    final potId = E2eFixture.current.savingsPotChecklistId;
    await startSignedIn(tester, role: 'trainer');
    await openFromMore(tester, 'menu-savings');
    await tapOn(tester, find.byKey(ValueKey('savings-pot-$potId')));
    await waitFor(tester, find.byKey(const ValueKey('savings-pot-title')));

    final cell = byKeyPrefix('savings-cell-').first;
    await waitFor(tester, cell);
    final cellKey = tester.widget(cell).key!;
    final target = find.byKey(cellKey);
    bool paid() =>
        target.evaluate().isNotEmpty && tester.widget<SavingsCell>(target).paid;
    expect(paid(), isFalse);

    await tapOn(tester, target);
    await waitUntil(tester, paid, what: 'afgevinkt');
    // Na de server-roundtrip (geen "pending" meer) blijft hij afgevinkt.
    await pumpFor(tester, const Duration(seconds: 2));
    expect(paid(), isTrue);
  });
}
