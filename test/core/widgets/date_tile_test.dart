import 'package:assistje/core/theme/assistje_tokens.dart';
import 'package:assistje/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'widget_harness.dart';

void main() {
  setUpAll(() => initializeDateFormatting('nl'));

  // Zaterdag 11 oktober 2025, 19:30.
  final date = DateTime(2025, 10, 11, 19, 30);

  test('nl-labels zonder punt', () {
    expect(DateTile.weekdayLabel(date), 'za');
    expect(DateTile.monthLabel(date), 'okt');
    expect(DateTile.monthLabel(DateTime(2025, 3, 2)), 'mrt');
    expect(DateTile.timeLabel(date), '19:30');
  });

  testBothThemes('toont weekdag, dag, maand en tijd', (tester, dark) async {
    await pumpThemed(
      tester,
      Center(
        child: DateTile(date: date, showTime: true, now: DateTime(2025, 10, 2)),
      ),
      dark: dark,
    );
    expect(find.text('ZA'), findsOneWidget);
    expect(find.text('11'), findsOneWidget);
    expect(find.text('okt'), findsOneWidget);
    expect(find.text('19:30'), findsOneWidget);

    final t = AssistjeTokens.of(tester.element(find.text('11')));
    final band = tester.widget<Container>(
      find.byKey(const ValueKey('date-tile-band')),
    );
    expect(band.color, t.raised);
  });

  testBothThemes('vandaag: band in de teamkleur', (tester, dark) async {
    await pumpThemed(
      tester,
      Center(
        child: DateTile(date: date, now: DateTime(2025, 10, 11, 8)),
      ),
      dark: dark,
    );
    expect(find.text('19:30'), findsNothing);
    final t = AssistjeTokens.of(tester.element(find.text('11')));
    final band = tester.widget<Container>(
      find.byKey(const ValueKey('date-tile-band')),
    );
    expect(band.color, t.primary);
    expect(
      tester.widget<Text>(find.text('ZA')).style!.color,
      t.primaryContrast,
    );
  });
}
