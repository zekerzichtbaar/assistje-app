import 'package:flutter_test/flutter_test.dart';

/// Pompt frames tot [finder] iets vindt (spinners maken `pumpAndSettle`
/// onbruikbaar zolang er geladen wordt), en laat daarna alles uitlopen.
/// Gebruik het dus niet voor een scherm met een blijvende spinner.
Future<void> pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  int maxFrames = 100,
}) async {
  for (var i = 0; i < maxFrames; i++) {
    await tester.pump(const Duration(milliseconds: 50));
    if (finder.evaluate().isNotEmpty) {
      // Laat de routeovergang uitlopen, zodat taps het nieuwe scherm raken.
      await tester.pumpAndSettle();
      return;
    }
  }
  throw TestFailure('Niet gevonden na $maxFrames frames: $finder');
}
