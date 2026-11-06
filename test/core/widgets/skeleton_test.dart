import 'package:assistje/core/theme/assistje_tokens.dart';
import 'package:assistje/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_harness.dart';

double _opacity(WidgetTester tester) => tester
    .widget<FadeTransition>(
      find
          .descendant(
            of: find.byType(Skeleton).first,
            matching: find.byType(FadeTransition),
          )
          .first,
    )
    .opacity
    .value;

void main() {
  testBothThemes('skeleton-lijst in de line-kleur, fadet na een tel in', (
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

    // Snel geladen data geeft geen flits: eerst onzichtbaar.
    expect(_opacity(tester), 0);
    await tester.pump(const Duration(milliseconds: 100));
    expect(_opacity(tester), 0);
    await tester.pumpAndSettle();
    expect(_opacity(tester), 1);
  });

  testWidgets('zonder ShimmerScope staat hij stil (geen glans)', (
    tester,
  ) async {
    await pumpThemed(tester, const Skeleton(width: 40), dark: false);
    await tester.pumpAndSettle();
    expect(tester.hasRunningAnimations, isFalse);
  });

  testWidgets('één gedeelde glans die alleen loopt met skeletons in beeld', (
    tester,
  ) async {
    final show = ValueNotifier(true);
    await pumpThemed(
      tester,
      ShimmerScope(
        child: ValueListenableBuilder<bool>(
          valueListenable: show,
          builder: (context, on, _) =>
              on ? const SkeletonList(count: 2) : const SizedBox.shrink(),
        ),
      ),
      dark: false,
    );
    await tester.pump(const Duration(milliseconds: 500));
    expect(tester.hasRunningAnimations, isTrue);

    final scope = ShimmerScope.maybeOf(
      tester.element(find.byType(SkeletonRow).first),
    );
    expect(scope, isNotNull);
    expect(scope!.progress.status, isNot(AnimationStatus.dismissed));

    show.value = false;
    await tester.pump();
    await tester.pumpAndSettle();
    expect(tester.hasRunningAnimations, isFalse);
  });

  testWidgets('staat meteen en stil bij minder beweging', (tester) async {
    await pumpThemed(
      tester,
      const MediaQuery(
        data: MediaQueryData(disableAnimations: true),
        child: ShimmerScope(child: Skeleton(width: 40)),
      ),
      dark: false,
    );
    expect(_opacity(tester), 1);
    await tester.pump();
    expect(tester.hasRunningAnimations, isFalse);
  });
}
