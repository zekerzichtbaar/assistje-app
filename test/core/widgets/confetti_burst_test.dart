import 'package:assistje/core/widgets/widgets.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_harness.dart';

void main() {
  testBothThemes('fire() start de burst via of(context)', (tester, dark) async {
    await pumpThemed(
      tester,
      ConfettiBurst(
        child: Builder(
          builder: (context) => Center(
            child: TextButton(
              onPressed: () => ConfettiBurst.of(context).fire(),
              child: const Text('feest'),
            ),
          ),
        ),
      ),
      dark: dark,
    );
    expect(find.byType(ConfettiWidget), findsOneWidget);
    final state = tester.state<ConfettiBurstState>(find.byType(ConfettiBurst));
    expect(state.isPlaying, isFalse);

    await tester.tap(find.text('feest'));
    await tester.pump(const Duration(milliseconds: 100));
    expect(state.isPlaying, isTrue);

    state.stop();
    await tester.pump();
    expect(state.isPlaying, isFalse);
    // Laat de deeltjes uitvallen.
    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('doet niets bij minder beweging', (tester) async {
    final key = GlobalKey<ConfettiBurstState>();
    await pumpThemed(
      tester,
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: ConfettiBurst(key: key, child: const SizedBox()),
      ),
      dark: false,
    );
    key.currentState!.fire();
    await tester.pump();
    expect(key.currentState!.isPlaying, isFalse);
  });
}
