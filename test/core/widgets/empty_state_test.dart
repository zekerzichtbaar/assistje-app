import 'package:assistje/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'widget_harness.dart';

void main() {
  testBothThemes('icoon, titel, tekst en actie', (tester, dark) async {
    var taps = 0;
    await pumpThemed(
      tester,
      Center(
        child: EmptyState(
          icon: PhosphorIconsDuotone.calendarBlank,
          title: 'Geen events',
          description: 'Er staat nog niets gepland.',
          action: PrimaryButton(label: 'Toevoegen', onPressed: () => taps++),
        ),
      ),
      dark: dark,
    );
    expect(find.byType(PhosphorIcon), findsOneWidget);
    expect(find.text('Geen events'), findsOneWidget);
    expect(find.text('Er staat nog niets gepland.'), findsOneWidget);
    await tester.tap(find.text('Toevoegen'));
    await tester.pumpAndSettle();
    expect(taps, 1);
  });

  testBothThemes('zonder tekst en actie', (tester, dark) async {
    await pumpThemed(
      tester,
      const Center(
        child: EmptyState(
          icon: PhosphorIconsDuotone.usersThree,
          title: 'Nog geen spelers',
        ),
      ),
      dark: dark,
    );
    expect(find.text('Nog geen spelers'), findsOneWidget);
    expect(find.byType(PrimaryButton), findsNothing);
  });
}
