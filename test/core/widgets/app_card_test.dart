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

  testWidgets('deukt in onder je vinger, ook op iOS (zonder ripple)', (
    tester,
  ) async {
    await pumpThemed(
      tester,
      AppCard(onTap: () {}, child: const Text('Kaart')),
      dark: false,
      platform: TargetPlatform.iOS,
    );
    double scale() =>
        tester.widget<AnimatedScale>(find.byType(AnimatedScale)).scale;
    expect(scale(), 1);

    final gesture = await tester.startGesture(
      tester.getCenter(find.text('Kaart')),
    );
    await tester.pump(const Duration(milliseconds: 50));
    expect(scale(), AppCard.pressedScale);

    await gesture.up();
    await tester.pumpAndSettle();
    expect(scale(), 1);
  });
}
