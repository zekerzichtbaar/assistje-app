import 'dart:async';

import 'package:assistje/core/shell/shell_bar.dart';
import 'package:assistje/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../widgets/widget_harness.dart';

/// Een minimale shell: de scope boven een navigator, zoals in `AppShell`.
Future<(ShellBarController, GlobalKey<NavigatorState>)> _pump(
  WidgetTester tester,
  Widget home,
) async {
  final controller = ShellBarController();
  addTearDown(controller.dispose);
  final nav = GlobalKey<NavigatorState>();
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(testTeamHex),
      navigatorKey: nav,
      builder: (context, child) =>
          ShellBarScope(controller: controller, child: child!),
      home: home,
    ),
  );
  await tester.pumpAndSettle();
  return (controller, nav);
}

Widget _screen(String title, {List<ShellAction> actions = const []}) =>
    ShellBar(
      title: title,
      actions: actions,
      child: Scaffold(body: Text('body $title')),
    );

void main() {
  testWidgets('het bovenste scherm vult de balk', (tester) async {
    final (controller, nav) = await _pump(tester, _screen('Eerste'));
    expect(controller.data?.title, 'Eerste');

    unawaited(
      nav.currentState!.push(
        MaterialPageRoute<void>(builder: (_) => _screen('Tweede')),
      ),
    );
    await tester.pumpAndSettle();
    expect(controller.data?.title, 'Tweede');

    nav.currentState!.pop();
    await tester.pumpAndSettle();
    expect(controller.data?.title, 'Eerste');
  });

  testWidgets('een scherm zonder ShellBar maakt de balk leeg', (tester) async {
    final (controller, nav) = await _pump(tester, _screen('Eerste'));
    unawaited(
      nav.currentState!.push(
        MaterialPageRoute<void>(
          builder: (_) => const Scaffold(body: Text('kaal')),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(controller.data, isNull);
  });

  testWidgets('acties: de sheet roept de gekozen actie aan', (tester) async {
    var tapped = 0;
    final action = ShellAction(
      key: const ValueKey('do-it'),
      icon: Icons.edit,
      label: 'Doe het',
      onTap: () => tapped++,
    );
    // Twee acties: met één voert de ⋯ hem meteen uit (eigen test hieronder).
    final (controller, _) = await _pump(
      tester,
      _screen(
        'Eerste',
        actions: [
          action,
          ShellAction(
            key: const ValueKey('other'),
            icon: Icons.delete,
            label: 'Anders',
            onTap: () {},
          ),
        ],
      ),
    );
    final context = tester.element(find.text('body Eerste'));
    unawaited(showShellActions(context, controller.data!.actions));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('do-it')));
    await tester.pumpAndSettle();
    expect(tapped, 1);
    expect(find.byKey(const ValueKey('shell-actions-sheet')), findsNothing);
  });

  testWidgets('buiten de shell: eigen balk met titel en knoppen', (
    tester,
  ) async {
    var tapped = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(testTeamHex),
        home: _screen(
          'Los',
          actions: [
            ShellAction(
              key: const ValueKey('do-it'),
              icon: Icons.edit,
              label: 'Doe het',
              onTap: () => tapped++,
            ),
          ],
        ),
      ),
    );
    expect(find.text('Los'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('do-it')));
    expect(tapped, 1);
  });

  testWidgets('acties: met één actie voert de ⋯ hem meteen uit', (
    tester,
  ) async {
    var tapped = 0;
    final (controller, _) = await _pump(
      tester,
      _screen(
        'Eerste',
        actions: [
          ShellAction(
            key: const ValueKey('only'),
            icon: Icons.settings,
            label: 'Beheer',
            onTap: () => tapped++,
          ),
        ],
      ),
    );
    final context = tester.element(find.text('body Eerste'));
    await showShellActions(context, controller.data!.actions);
    await tester.pumpAndSettle();
    expect(tapped, 1);
    expect(find.byKey(const ValueKey('shell-actions-sheet')), findsNothing);
  });
}
