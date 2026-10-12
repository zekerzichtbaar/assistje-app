import 'package:assistje/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'widget_harness.dart';

Widget _opener(AppToastVariant variant, {String title = 'Opgeslagen'}) =>
    Builder(
      builder: (context) => Center(
        child: TextButton(
          onPressed: () => showAppToast(
            context,
            title: title,
            message: 'Je afmelding is verwerkt.',
            variant: variant,
            closeLabel: 'Sluiten',
          ),
          child: const Text('toast'),
        ),
      ),
    );

void main() {
  testBothThemes('succes-toast verdwijnt na 4 seconden', (tester, dark) async {
    await pumpThemed(tester, _opener(AppToastVariant.success), dark: dark);
    await tester.tap(find.text('toast'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Opgeslagen'), findsOneWidget);
    expect(find.text('Je afmelding is verwerkt.'), findsOneWidget);
    final icon = tester.widget<PhosphorIcon>(find.byType(PhosphorIcon).first);
    expect(icon.color, StatusColors.success);
    expect(isAppToastVisible, isTrue);

    await tester.pump(const Duration(seconds: 3));
    expect(find.text('Opgeslagen'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.text('Opgeslagen'), findsNothing);
    expect(isAppToastVisible, isFalse);
  });

  testBothThemes('fout-toast sluit via de sluitknop', (tester, dark) async {
    await pumpThemed(
      tester,
      _opener(AppToastVariant.error, title: 'Er ging iets mis'),
      dark: dark,
    );
    final semantics = tester.ensureSemantics();
    await tester.tap(find.text('toast'));
    await tester.pumpAndSettle();
    final icon = tester.widget<PhosphorIcon>(find.byType(PhosphorIcon).first);
    expect(icon.color, StatusColors.error);
    expect(find.bySemanticsLabel('Sluiten'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('app-toast-close')));
    await tester.pumpAndSettle();
    expect(find.text('Er ging iets mis'), findsNothing);
    semantics.dispose();
  });

  testWidgets('nieuwe toast vervangt de vorige', (tester) async {
    late BuildContext ctx;
    await pumpThemed(
      tester,
      Builder(
        builder: (context) {
          ctx = context;
          return const SizedBox();
        },
      ),
      dark: false,
    );
    showAppToast(ctx, title: 'Eerste');
    await tester.pump();
    final handle = showAppToast(
      ctx,
      title: 'Tweede',
      variant: AppToastVariant.info,
    );
    await tester.pump();
    expect(find.text('Eerste'), findsNothing);
    expect(find.text('Tweede'), findsOneWidget);

    handle.dismiss();
    await tester.pumpAndSettle();
    expect(find.text('Tweede'), findsNothing);
  });
}
