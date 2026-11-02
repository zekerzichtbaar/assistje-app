// e2e-rol: player
//
// Flow 1: een speler logt in met e-mailadres + code en ziet de agenda met de
// komende wedstrijd uit de seed.
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'support/app.dart';
import 'support/fixture.dart';
import 'support/waits.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('speler logt in met e-mail + code en ziet de agenda', (
    tester,
  ) async {
    await startSignedIn(tester, role: 'player');

    expect(find.byKey(const ValueKey('agenda-screen')), findsOneWidget);
    expect(find.text('Agenda'), findsWidgets);
    await scrollTo(
      tester,
      find.byKey(ValueKey('event-${E2eFixture.current.matchUpcoming}')),
      within: find.byKey(const ValueKey('agenda-screen')),
    );
  });
}
