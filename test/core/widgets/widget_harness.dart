import 'package:assistje/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const testTeamHex = '#006837';

/// Draait [body] als twee widgettests: één in licht en één in donker thema.
void testBothThemes(
  String description,
  Future<void> Function(WidgetTester tester, bool dark) body,
) {
  for (final dark in [false, true]) {
    testWidgets('$description (${dark ? 'donker' : 'licht'})', (tester) async {
      await body(tester, dark);
    });
  }
}

/// Pompt [child] in een MaterialApp met het Assistje-thema.
Future<void> pumpThemed(
  WidgetTester tester,
  Widget child, {
  required bool dark,
  TargetPlatform? platform,
}) async {
  ThemeData theme(ThemeData base) =>
      platform == null ? base : base.copyWith(platform: platform);
  await tester.pumpWidget(
    MaterialApp(
      theme: theme(AppTheme.light(testTeamHex)),
      darkTheme: theme(AppTheme.dark(testTeamHex)),
      themeMode: dark ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(body: child),
    ),
  );
}
