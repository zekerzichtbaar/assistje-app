import 'package:assistje/core/theme/assistje_tokens.dart';
import 'package:assistje/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_harness.dart';

void main() {
  testBothThemes('kaart: radius 16, haarlijn alleen in donker, tikbaar', (
    tester,
    dark,
  ) async {
    var taps = 0;
    await pumpThemed(
      tester,
      AppCard(onTap: () => taps++, child: const Text('Kaart')),
      dark: dark,
    );

    final material = tester.widget<Material>(
      find
          .ancestor(of: find.text('Kaart'), matching: find.byType(Material))
          .first,
    );
    final shape = material.shape! as RoundedRectangleBorder;
    expect(shape.borderRadius, BorderRadius.circular(AssistjeTokens.radius2xl));
    expect(shape.side.color.a == 0, !dark);
    expect(material.elevation, 0);

    await tester.tap(find.text('Kaart'));
    expect(taps, 1);
  });
}
