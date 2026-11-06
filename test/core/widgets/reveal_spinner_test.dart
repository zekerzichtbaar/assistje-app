import 'package:assistje/core/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_harness.dart';

double _revealOpacity(WidgetTester tester) => tester
    .widget<Opacity>(
      find.descendant(of: find.byType(Reveal), matching: find.byType(Opacity)),
    )
    .opacity;

void main() {
  group('Reveal', () {
    testWidgets('inhoud die een skeleton vervangt fadet in', (tester) async {
      final loaded = ValueNotifier(false);
      await pumpThemed(
        tester,
        ShimmerScope(
          child: ValueListenableBuilder<bool>(
            valueListenable: loaded,
            builder: (context, on, _) => on
                ? const Reveal(child: Text('klaar'))
                : const SkeletonList(count: 1),
          ),
        ),
        dark: false,
      );
      await tester.pump(const Duration(milliseconds: 500));
      loaded.value = true;
      await tester.pump();
      expect(find.text('klaar'), findsOneWidget);
      expect(_revealOpacity(tester), lessThan(0.1));
      await tester.pumpAndSettle();
      expect(_revealOpacity(tester), 1);
    });

    testWidgets('bewaarde data (geen skeleton ervoor) staat er meteen', (
      tester,
    ) async {
      await pumpThemed(
        tester,
        const ShimmerScope(child: Reveal(child: Text('klaar'))),
        dark: false,
      );
      expect(_revealOpacity(tester), 1);
      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('meteen zichtbaar bij minder beweging', (tester) async {
      final loaded = ValueNotifier(false);
      await pumpThemed(
        tester,
        MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: ShimmerScope(
            child: ValueListenableBuilder<bool>(
              valueListenable: loaded,
              builder: (context, on, _) => on
                  ? const Reveal(child: Text('klaar'))
                  : const SkeletonList(count: 1),
            ),
          ),
        ),
        dark: false,
      );
      loaded.value = true;
      await tester.pump();
      expect(_revealOpacity(tester), 1);
    });
  });

  group('AppSpinner', () {
    testWidgets('iOS-bloem op iOS', (tester) async {
      await pumpThemed(
        tester,
        const AppSpinner(),
        dark: false,
        platform: TargetPlatform.iOS,
      );
      expect(find.byType(CupertinoActivityIndicator), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('Material-cirkel op Android', (tester) async {
      await pumpThemed(
        tester,
        const AppSpinner(),
        dark: false,
        platform: TargetPlatform.android,
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(CupertinoActivityIndicator), findsNothing);
    });
  });
}
