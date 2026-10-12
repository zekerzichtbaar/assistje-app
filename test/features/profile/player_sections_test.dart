import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/shell.dart';
import 'profile_fixtures.dart';

void main() {
  for (final (key, path) in [
    ('profile-vacations-edit', AppRoutes.vacations),
    ('profile-standing-edit', AppRoutes.standingAbsences),
  ]) {
    testWidgets('"Aanpassen" op de Mij-tab opent $path', (tester) async {
      final (container, _) = await pumpSignedIn(
        tester,
        teams: [
          ApiFixtures.membership(
            features: {'vacations': true, 'standing_absences': true},
          ),
        ],
        setup: (http) =>
            http.on('GET /teams/3/profile', 200, ProfileFixtures.profile()),
      );
      final router = container.read(routerProvider)..go(AppRoutes.profile);
      await tester.pumpAndSettle();

      expect(
        find.text('Aanpassen kan voorlopig via assistje.nl.'),
        findsNothing,
      );
      final link = find.byKey(ValueKey(key));
      await tester.ensureVisible(link);
      await tester.pumpAndSettle();
      await tester.tap(link);
      await tester.pumpAndSettle();

      expect(router.state.uri.path, path);
    });
  }
}
