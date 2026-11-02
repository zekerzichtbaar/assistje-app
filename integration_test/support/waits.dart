import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Wachten op een echte backend: geen `pumpAndSettle` (de live-klok en
/// polling tikken door, dan settelt hij nooit), maar pompen tot de finder iets
/// vindt — in echte tijd, met een time-out.
Future<Finder> waitFor(
  WidgetTester tester,
  Finder finder, {
  Duration timeout = const Duration(seconds: 20),
}) async {
  final end = DateTime.now().add(timeout);
  while (true) {
    await tester.pump(const Duration(milliseconds: 50));
    if (finder.evaluate().isNotEmpty) return finder;
    if (DateTime.now().isAfter(end)) {
      throw TestFailure('Niet gevonden binnen ${timeout.inSeconds} s: $finder');
    }
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }
}

/// Pompt tot [condition] waar is (bv. een status die na een API-aanroep
/// omslaat).
Future<void> waitUntil(
  WidgetTester tester,
  bool Function() condition, {
  required String what,
  Duration timeout = const Duration(seconds: 20),
}) async {
  final end = DateTime.now().add(timeout);
  while (true) {
    await tester.pump(const Duration(milliseconds: 50));
    if (condition()) return;
    if (DateTime.now().isAfter(end)) {
      throw TestFailure('Niet binnen ${timeout.inSeconds} s: $what');
    }
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }
}

/// Een paar frames in echte tijd laten lopen (animaties, sheets).
Future<void> pumpFor(WidgetTester tester, Duration duration) async {
  final end = DateTime.now().add(duration);
  while (DateTime.now().isBefore(end)) {
    await tester.pump(const Duration(milliseconds: 50));
    await Future<void>.delayed(const Duration(milliseconds: 50));
  }
}

/// Wacht op [finder], scrolt hem in beeld en tikt erop.
Future<void> tapOn(WidgetTester tester, Finder finder) async {
  await waitFor(tester, finder);
  await tester.ensureVisible(finder.first);
  await pumpFor(tester, const Duration(milliseconds: 300));
  await tester.tap(finder.first);
  await pumpFor(tester, const Duration(milliseconds: 300));
}

/// Wacht op een tekstveld en vult het in.
Future<void> enterInto(WidgetTester tester, Finder field, String text) async {
  await waitFor(tester, field);
  await tester.ensureVisible(field.first);
  await tester.enterText(field.first, text);
  await pumpFor(tester, const Duration(milliseconds: 300));
}

/// Scrolt de eerste verticale lijst binnen [within] tot [finder] gebouwd is
/// (luie lijsten bouwen niet alles). Geeft `false` als hij er niet is en
/// [required] uit staat.
Future<bool> scrollTo(
  WidgetTester tester,
  Finder finder, {
  required Finder within,
  bool required = true,
}) async {
  await waitFor(tester, within);
  // De lijst moet eerst geladen zijn (skeletons → items).
  await pumpFor(tester, const Duration(seconds: 1));
  if (finder.evaluate().isNotEmpty) {
    await tester.ensureVisible(finder.first);
    await tester.pump();
    return true;
  }
  final scrollable = find
      .descendant(
        of: within,
        matching: find.byWidgetPredicate(
          (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
        ),
      )
      .first;
  try {
    await tester.scrollUntilVisible(
      finder,
      250,
      scrollable: scrollable,
      maxScrolls: 40,
    );
    return true;
  } on StateError {
    if (required) rethrow;
    return false;
  } on TestFailure {
    if (required) rethrow;
    return false;
  }
}

/// Pull-to-refresh op de eerste verticale lijst binnen [within].
Future<void> pullToRefresh(WidgetTester tester, Finder within) async {
  final scrollable = find
      .descendant(
        of: within,
        matching: find.byWidgetPredicate(
          (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
        ),
      )
      .first;
  // Eerst helemaal naar boven, dan omlaag trekken voorbij de rand.
  await tester.fling(scrollable, const Offset(0, 2000), 3000);
  await pumpFor(tester, const Duration(milliseconds: 500));
  await tester.timedDrag(
    scrollable,
    const Offset(0, 400),
    const Duration(milliseconds: 600),
  );
  await pumpFor(tester, const Duration(seconds: 3));
}

/// Alle widgets waarvan de `ValueKey<String>` met [prefix] begint.
Finder byKeyPrefix(String prefix, {Set<String> except = const {}}) =>
    find.byWidgetPredicate((w) {
      final key = w.key;
      return key is ValueKey<String> &&
          key.value.startsWith(prefix) &&
          !except.contains(key.value);
    });
