import 'package:assistje/core/theme/assistje_tokens.dart';
import 'package:assistje/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_harness.dart';

void main() {
  testBothThemes('primaire knop: teamkleur en contrasttekst', (
    tester,
    dark,
  ) async {
    var taps = 0;
    await pumpThemed(
      tester,
      Center(
        child: PrimaryButton(label: 'Opslaan', onPressed: () => taps++),
      ),
      dark: dark,
    );
    final t = AssistjeTokens.of(tester.element(find.text('Opslaan')));
    final text = tester.widget<Text>(find.text('Opslaan'));
    expect(text.style!.color, t.primaryContrast);
    final box = tester.widget<Container>(
      find
          .ancestor(of: find.text('Opslaan'), matching: find.byType(Container))
          .first,
    );
    expect((box.decoration! as BoxDecoration).color, t.primary);

    await tester.tap(find.text('Opslaan'));
    await tester.pumpAndSettle();
    expect(taps, 1);
  });

  testBothThemes('laden: spinner en geen tikken', (tester, dark) async {
    var taps = 0;
    await pumpThemed(
      tester,
      Center(
        child: PrimaryButton(
          label: 'Opslaan',
          loading: true,
          onPressed: () => taps++,
        ),
      ),
      dark: dark,
    );
    expect(find.byKey(const ValueKey('app-button-spinner')), findsOneWidget);
    await tester.tap(find.text('Opslaan'));
    await tester.pump();
    expect(taps, 0);
  });

  testBothThemes('uitgeschakeld: half doorzichtig', (tester, dark) async {
    await pumpThemed(
      tester,
      const Center(child: SecondaryButton(label: 'Annuleren', onPressed: null)),
      dark: dark,
    );
    final opacity = tester.widget<AnimatedOpacity>(
      find.ancestor(
        of: find.text('Annuleren'),
        matching: find.byType(AnimatedOpacity),
      ),
    );
    expect(opacity.opacity, 0.5);
    expect(
      tester.getSemantics(find.byType(SecondaryButton)),
      matchesSemantics(
        isButton: true,
        hasEnabledState: true,
        label: 'Annuleren',
      ),
    );
  });

  testBothThemes('secundaire knop: rand en inkt', (tester, dark) async {
    var taps = 0;
    await pumpThemed(
      tester,
      Center(
        child: SecondaryButton(
          label: 'Terug',
          expand: true,
          onPressed: () => taps++,
        ),
      ),
      dark: dark,
    );
    final t = AssistjeTokens.of(tester.element(find.text('Terug')));
    expect(tester.widget<Text>(find.text('Terug')).style!.color, t.ink);
    await tester.tap(find.text('Terug'));
    await tester.pumpAndSettle();
    expect(taps, 1);
  });
}
