import 'package:assistje/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_harness.dart';

void main() {
  test('initialen zoals Avatar.tsx', () {
    expect(AppAvatar.initialsOf('jan de vries'), 'JD');
    expect(AppAvatar.initialsOf('  Piet  '), 'P');
    expect(AppAvatar.initialsOf(''), '?');
    expect(AppAvatar.initialsOf('Émile Zola Extra'), 'ÉZ');
  });

  testBothThemes('zonder foto: initialen', (tester, dark) async {
    await pumpThemed(
      tester,
      const Center(child: AppAvatar(name: 'Sanne Bakker')),
      dark: dark,
    );
    expect(find.text('SB'), findsOneWidget);
    expect(find.byType(Image), findsNothing);
  });

  testBothThemes('foto faalt: initialen blijven staan', (tester, dark) async {
    // In tests geeft elke netwerkfoto een 400 → errorBuilder.
    await pumpThemed(
      tester,
      const Center(
        child: AppAvatar(
          name: 'Sanne Bakker',
          imageUrl: 'https://example.test/a.jpg',
          size: 56,
        ),
      ),
      dark: dark,
    );
    await tester.pumpAndSettle();
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('SB'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testBothThemes('statusstip en ring', (tester, dark) async {
    await pumpThemed(
      tester,
      const Center(
        child: AppAvatar(
          name: 'Kees',
          ring: Colors.green,
          statusColor: StatusColors.present,
        ),
      ),
      dark: dark,
    );
    final dot = tester.widget<Container>(
      find.byKey(const ValueKey('app-avatar-status')),
    );
    expect((dot.decoration! as BoxDecoration).color, StatusColors.present);
    expect(find.text('K'), findsOneWidget);
  });
}
