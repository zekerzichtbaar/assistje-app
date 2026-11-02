// e2e-rol: trainer
//
// Flow 3: de trainer fluit een gelijke, live bekerwedstrijd af, laat
// verlenging spelen, fluit weer af en beslist hem met strafschoppen. Het
// scorebord toont daarna "… na strafschoppen".
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'support/app.dart';
import 'support/fixture.dart';
import 'support/waits.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Finder key(String k) => find.byKey(ValueKey(k));

  testWidgets('beker: gelijk → verlenging → strafschoppen tot een winnaar', (
    tester,
  ) async {
    final container = await startSignedIn(tester, role: 'trainer');
    await openEvent(tester, container, E2eFixture.current.cupMatchLive);
    await tapOn(tester, key('event-action-live'));

    Future<void> confirm() => tapOn(tester, key('live-confirm-ok'));

    // Eindfluit na de reguliere speeltijd: 1-1 → beslissen.
    await tapOn(tester, key('live-stop'));
    await confirm();
    await waitFor(tester, key('live-decide'));

    // Verlenging: de klok staat op het einde; zelf aftrappen.
    await tapOn(tester, key('live-extra-time'));
    await confirm();
    await tapOn(tester, key('live-next'));
    await confirm();
    await waitFor(tester, find.textContaining('verlenging'));

    // Weer afgefloten, nog gelijk → alleen strafschoppen.
    await tapOn(tester, key('live-stop'));
    await confirm();
    await tapOn(tester, key('live-shootout-start'));
    await confirm();
    await waitFor(tester, key('live-shootout'));

    // Wij scoren, zij missen, tot er een winnaar is.
    final winner = key('live-shootout-winner');
    for (var round = 0; round < 10 && winner.evaluate().isEmpty; round++) {
      await tapOn(tester, key('live-kick-us-scored'));
      await pumpFor(tester, const Duration(seconds: 1));
      if (winner.evaluate().isNotEmpty) break;
      await tapOn(tester, key('live-kick-opp-missed'));
      await pumpFor(tester, const Duration(seconds: 1));
    }
    await waitFor(tester, winner);
    expect(
      find.descendant(
        of: winner,
        matching: find.textContaining('strafschoppen'),
      ),
      findsOneWidget,
    );

    final suffix = await waitFor(tester, key('live-result-suffix'));
    expect(
      find.descendant(
        of: suffix,
        matching: find.textContaining('na strafschoppen'),
      ),
      findsWidgets,
    );
  });
}
