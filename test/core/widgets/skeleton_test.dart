import 'package:assistje/core/theme/assistje_tokens.dart';
import 'package:assistje/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_harness.dart';

void main() {
  testBothThemes('skeleton-lijst pulseert in de line-kleur', (
    tester,
    dark,
  ) async {
    await pumpThemed(tester, const SkeletonList(count: 3), dark: dark);
    expect(find.byType(SkeletonRow), findsNWidgets(3));
    expect(find.byType(Skeleton), findsNWidgets(9));

    final t = AssistjeTokens.of(tester.element(find.byType(SkeletonList)));
    final block = tester.widget<Container>(
      find.descendant(
        of: find.byType(Skeleton).first,
        matching: find.byType(Container),
      ),
    );
    expect((block.decoration! as BoxDecoration).color, t.line);

    final fade = find
        .descendant(
          of: find.byType(Skeleton).first,
          matching: find.byType(FadeTransition),
        )
        .first;
    final start = tester.widget<FadeTransition>(fade).opacity.value;
    await tester.pump(const Duration(milliseconds: 1000));
    final mid = tester.widget<FadeTransition>(fade).opacity.value;
    expect(start, closeTo(1, 0.01));
    expect(mid, closeTo(0.5, 0.05));
  });

  testWidgets('staat stil bij minder beweging', (tester) async {
    await pumpThemed(
      tester,
      const MediaQuery(
        data: MediaQueryData(disableAnimations: true),
        child: Skeleton(width: 40),
      ),
      dark: false,
    );
    await tester.pumpAndSettle();
    expect(tester.hasRunningAnimations, isFalse);
  });
}
