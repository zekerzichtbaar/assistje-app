import 'dart:async';

import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'event_fixtures.dart';

// "n.v." / "4–3 n.s." achter de uitslag in het event-detail
// (`live.result_suffix`).

void main() {
  testWidgets('uitslag na verlenging krijgt "n.v."', (tester) async {
    final detail = EventFixtures.eventDetail({
      'starts_at': '2020-10-11T14:30:00+02:00',
      'competition': 'cup',
      'home_score': 3,
      'away_score': 2,
      'live': {
        'is_live': false,
        'running': false,
        'started_at': null,
        'accumulated_seconds': 120 * 60,
        'ended_at': '2020-10-11T16:45:00+02:00',
        'period': 4,
        'period_ends': [45, 90, 105, 120],
        'regular_periods': 2,
        'extra_time': true,
        'shootout': null,
        'result_suffix': 'n.v.',
      },
    });
    final (container, _) = await pumpSignedIn(
      tester,
      teams: [ApiFixtures.membership()],
      setup: (http) => http.on('GET /teams/3/events/412', 200, detail),
    );
    unawaited(container.read(routerProvider).push(AppRoutes.event(412)));
    await pumpUntilFound(tester, find.byKey(const ValueKey('event-score')));

    expect(
      tester.widget<Text>(find.byKey(const ValueKey('event-score'))).data,
      '3 - 2 n.v.',
    );
  });
}
