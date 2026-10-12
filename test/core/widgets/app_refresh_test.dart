import 'package:assistje/core/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_harness.dart';

List<Widget> _slivers() => [
  SliverList.builder(
    itemCount: 3,
    itemBuilder: (_, i) => SizedBox(height: 60, child: Text('Rij $i')),
  ),
];

void main() {
  testBothThemes('Android: RefreshIndicator roept onRefresh aan', (
    tester,
    dark,
  ) async {
    var refreshed = 0;
    await pumpThemed(
      tester,
      AppRefresh(onRefresh: () async => refreshed++, slivers: _slivers()),
      dark: dark,
      platform: TargetPlatform.android,
    );
    expect(find.byType(RefreshIndicator), findsOneWidget);
    expect(
      find.byType(CupertinoSliverRefreshControl, skipOffstage: false),
      findsNothing,
    );

    await tester.fling(find.text('Rij 0'), const Offset(0, 400), 1000);
    await tester.pumpAndSettle();
    expect(refreshed, 1);
  });

  testBothThemes('iOS: Cupertino-refresh roept onRefresh aan', (
    tester,
    dark,
  ) async {
    var refreshed = 0;
    await pumpThemed(
      tester,
      AppRefresh(
        onRefresh: () async => refreshed++,
        slivers: _slivers(),
        padding: const EdgeInsets.only(bottom: 80),
      ),
      dark: dark,
      platform: TargetPlatform.iOS,
    );
    expect(
      find.byType(CupertinoSliverRefreshControl, skipOffstage: false),
      findsOneWidget,
    );
    expect(find.byType(RefreshIndicator), findsNothing);

    final gesture = await tester.startGesture(
      tester.getCenter(find.text('Rij 0')),
    );
    for (var i = 0; i < 10; i++) {
      await gesture.moveBy(const Offset(0, 30));
      await tester.pump(const Duration(milliseconds: 16));
    }
    await gesture.up();
    await tester.pumpAndSettle();
    expect(refreshed, 1);
  });
}
