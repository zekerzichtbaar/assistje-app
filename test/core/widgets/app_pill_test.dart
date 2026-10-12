import 'package:assistje/core/theme/assistje_tokens.dart';
import 'package:assistje/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_harness.dart';

void main() {
  testBothThemes('pill: geselecteerd in teamkleur, anders sunken', (
    tester,
    dark,
  ) async {
    var taps = 0;
    await pumpThemed(
      tester,
      Row(
        children: [
          AppPill(label: 'Aan', selected: true, onTap: () => taps++),
          const AppPill(label: 'Uit'),
        ],
      ),
      dark: dark,
    );
    final t = AssistjeTokens.of(tester.element(find.text('Aan')));
    expect(
      tester.widget<Text>(find.text('Aan')).style!.color,
      t.primaryContrast,
    );
    expect(tester.widget<Text>(find.text('Uit')).style!.color, t.inkSoft);
    await tester.tap(find.text('Aan'));
    expect(taps, 1);
  });

  testBothThemes('tab-pills: actieve tab in teamkleur, wisselen', (
    tester,
    dark,
  ) async {
    var selected = 'a';
    await pumpThemed(
      tester,
      StatefulBuilder(
        builder: (context, setState) => AppTabPills<String>(
          tabs: const [
            AppTabPill(value: 'a', label: 'Komend'),
            AppTabPill(value: 'b', label: 'Geweest'),
          ],
          selected: selected,
          onChanged: (v) => setState(() => selected = v),
        ),
      ),
      dark: dark,
    );
    final t = AssistjeTokens.of(tester.element(find.text('Komend')));
    expect(tester.widget<Text>(find.text('Komend')).style!.color, t.primary);
    await tester.tap(find.text('Geweest'));
    await tester.pumpAndSettle();
    expect(selected, 'b');
    expect(tester.widget<Text>(find.text('Geweest')).style!.color, t.primary);
    expect(tester.widget<Text>(find.text('Komend')).style!.color, t.inkSoft);
  });
}
