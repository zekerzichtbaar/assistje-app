// e2e-rol: player
//
// Flow 2: een speler meldt zich aan en af voor de komende wedstrijd; na een
// pull-to-refresh (verse data van de server) staat de keuze er nog.
import 'package:assistje/features/agenda/presentation/widgets/event_card.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'support/app.dart';
import 'support/fixture.dart';
import 'support/waits.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('speler zet aanwezig/afwezig en ziet het na herladen', (
    tester,
  ) async {
    await startSignedIn(tester, role: 'player');
    final id = E2eFixture.current.matchUpcoming;
    final agenda = find.byKey(const ValueKey('agenda-screen'));
    final present = find.byKey(ValueKey('rsvp-$id-present'));
    final absent = find.byKey(ValueKey('rsvp-$id-absent'));
    bool selected(Finder f) =>
        f.evaluate().isNotEmpty && tester.widget<RsvpButton>(f).selected;

    await scrollTo(tester, present, within: agenda);
    await tapOn(tester, present);
    await waitUntil(tester, () => selected(present), what: 'aanwezig gekozen');

    await pullToRefresh(tester, agenda);
    await scrollTo(tester, present, within: agenda);
    await waitUntil(
      tester,
      () => selected(present),
      what: 'aanwezig na herladen',
    );

    await tapOn(tester, absent);
    // Met de feature "reden bij afmelden" volgt eerst een sheet.
    await pumpFor(tester, const Duration(seconds: 1));
    final reason = find.byKey(const ValueKey('reason-quick-Ziek'));
    if (reason.evaluate().isNotEmpty) {
      await tapOn(tester, reason);
    } else if (find
        .byKey(const ValueKey('reason-input'))
        .evaluate()
        .isNotEmpty) {
      await enterInto(
        tester,
        find.byKey(const ValueKey('reason-input')),
        'Ziek',
      );
      await tapOn(tester, find.byKey(const ValueKey('reason-submit')));
    }
    await waitUntil(tester, () => selected(absent), what: 'afwezig gekozen');

    await pullToRefresh(tester, agenda);
    await scrollTo(tester, absent, within: agenda);
    await waitUntil(
      tester,
      () => selected(absent),
      what: 'afwezig na herladen',
    );
    expect(selected(present), isFalse);
  });
}
