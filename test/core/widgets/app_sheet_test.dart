import 'package:assistje/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_harness.dart';

Widget _opener({bool scrollable = false}) => Builder(
  builder: (context) => Center(
    child: TextButton(
      onPressed: () => showAppSheet<void>(
        context: context,
        title: 'Titel',
        scrollable: scrollable,
        actions: [const Text('Actie')],
        builder: (_) => const SizedBox(height: 120, child: Text('Inhoud')),
      ),
      child: const Text('open'),
    ),
  ),
);

void main() {
  testBothThemes('sheet toont greep, titel, acties en inhoud', (
    tester,
    dark,
  ) async {
    await pumpThemed(tester, _opener(), dark: dark);
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('app-sheet-grabber')), findsOneWidget);
    expect(find.text('Titel'), findsOneWidget);
    expect(find.text('Actie'), findsOneWidget);
    expect(find.text('Inhoud'), findsOneWidget);
  });

  testBothThemes('omlaag slepen sluit de sheet', (tester, dark) async {
    await pumpThemed(tester, _opener(), dark: dark);
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    await tester.drag(
      find.byKey(const ValueKey('app-sheet-grabber')),
      const Offset(0, 500),
    );
    await tester.pumpAndSettle();
    expect(find.text('Inhoud'), findsNothing);
  });

  testBothThemes('tik op de backdrop sluit de sheet', (tester, dark) async {
    await pumpThemed(tester, _opener(scrollable: true), dark: dark);
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.byType(SingleChildScrollView), findsOneWidget);

    await tester.tapAt(const Offset(20, 20));
    await tester.pumpAndSettle();
    expect(find.text('Inhoud'), findsNothing);
  });

  testWidgets('sheet blijft binnen 88% van de schermhoogte', (tester) async {
    await pumpThemed(
      tester,
      Builder(
        builder: (context) => TextButton(
          onPressed: () => showAppSheet<void>(
            context: context,
            scrollable: true,
            builder: (_) => const SizedBox(height: 3000),
          ),
          child: const Text('open'),
        ),
      ),
      dark: false,
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    final screen = tester.view.physicalSize / tester.view.devicePixelRatio;
    final size = tester.getSize(find.byType(AppSheet));
    expect(size.height, lessThanOrEqualTo(screen.height * 0.88 + 0.01));
    expect(tester.takeException(), isNull);
  });
}
