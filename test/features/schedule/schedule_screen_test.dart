import 'dart:async';

import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'schedule_fixtures.dart';

const _options = 'GET /teams/3/schedule/options';
const _create = 'POST /teams/3/schedule';

/// Start ingelogd als trainer en opent [path] (vanaf de agenda gepusht).
Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  String path = AppRoutes.schedule,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [ApiFixtures.membership(role: 'trainer')],
    setup: (http) {
      http.on(_options, 200, ScheduleFixtures.options());
      setup?.call(http);
    },
  );
  unawaited(container.read(routerProvider).push(path));
  await pumpUntilFound(tester, find.byKey(const ValueKey('schedule-form')));
  return (container, backend.http);
}

Future<void> _tap(WidgetTester tester, String key) async {
  final finder = find.byKey(ValueKey(key));
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('nieuw: training op een gekozen dag; terug naar de agenda', (
    tester,
  ) async {
    final (container, http) = await _open(
      tester,
      setup: (http) => http.on(
        _create,
        201,
        ScheduleFixtures.write(ScheduleFixtures.trainingData(), {
          'created_ids': [498],
          'adopted_ids': <int>[],
        }),
      ),
    );

    expect(currentTitle(tester), 'Nieuw event');
    expect(find.text('Training'), findsWidgets);
    expect(find.text('19:00'), findsOneWidget);
    // Nieuwe training: wekelijks herhalen, geen "alle volgende".
    expect(find.byKey(const ValueKey('schedule-recurring')), findsOneWidget);
    expect(find.byKey(const ValueKey('schedule-following-true')), findsNothing);

    // Zonder datum: niets versturen.
    await _tap(tester, 'schedule-submit');
    expect(find.byKey(const ValueKey('schedule-form-error')), findsOneWidget);
    expect(http.requestsTo(_create), isEmpty);

    await _tap(tester, 'schedule-date');
    await tester.tap(find.text('15'));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const ValueKey('schedule-title')),
      'Conditie',
    );
    await tester.enterText(
      find.byKey(const ValueKey('schedule-venue')),
      'Veld 3',
    );
    await _tap(tester, 'schedule-submit');

    final body = http.requestsTo(_create).single.body! as Map;
    final now = DateTime.now();
    final starts = DateTime.parse(body['starts_at'] as String).toLocal();
    expect(starts.day, 15);
    expect(starts.month, now.month);
    expect((starts.hour, starts.minute), (19, 0));
    expect(body['type'], 'training');
    expect(body['title'], 'Conditie');
    expect(body['venue'], 'Veld 3');
    expect(body.containsKey('recur_until'), isFalse);

    // Terug op de agenda, met een melding.
    expect(container.read(routerProvider).state.uri.path, AppRoutes.agenda);
    expect(find.text('Event aangemaakt'), findsOneWidget);
  });

  testWidgets('wekelijks herhalen vraagt een einddatum', (tester) async {
    final (_, http) = await _open(tester);

    await _tap(tester, 'schedule-date');
    await tester.tap(find.text('15'));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await _tap(tester, 'schedule-recurring');
    expect(find.byKey(const ValueKey('schedule-recur-until')), findsOneWidget);

    await _tap(tester, 'schedule-submit');
    expect(find.text('Kies tot wanneer de training herhaalt.'), findsOneWidget);
    expect(http.requestsTo(_create), isEmpty);
  });

  testWidgets('andere soort: wedstrijdvelden en toeschouwers', (tester) async {
    await _open(tester);

    await _tap(tester, 'schedule-type-match');
    expect(find.byKey(const ValueKey('schedule-opponent')), findsOneWidget);
    expect(find.byKey(const ValueKey('schedule-meet')), findsOneWidget);
    expect(find.text('Valleivogels 3'), findsOneWidget);
    expect(find.byKey(const ValueKey('schedule-competition-cup')), findsOne);
    expect(find.byKey(const ValueKey('schedule-title')), findsNothing);
    expect(find.byKey(const ValueKey('schedule-recurring')), findsNothing);

    await _tap(tester, 'schedule-type-activity');
    expect(find.byKey(const ValueKey('schedule-spectators')), findsOneWidget);
    expect(find.text('Naam'), findsOneWidget);
  });

  testWidgets('bewerken: velden ingevuld, ook alle volgende → PATCH', (
    tester,
  ) async {
    final (container, http) = await _open(
      tester,
      path: '${AppRoutes.schedule}?event=498',
      setup: (http) => http
        ..on(
          'GET /teams/3/events/498',
          200,
          ScheduleFixtures.write(ScheduleFixtures.trainingData()),
        )
        ..on(
          'PATCH /teams/3/schedule/498',
          200,
          ScheduleFixtures.write(ScheduleFixtures.trainingData(), {
            'following_updated': 6,
          }),
        ),
    );

    expect(currentTitle(tester), 'Event bewerken');
    expect(find.text('Conditie'), findsOneWidget);
    expect(find.text('Veld 3'), findsOneWidget);
    expect(find.text('Bidon mee'), findsOneWidget);
    expect(find.byKey(const ValueKey('schedule-recurring')), findsNothing);

    await _tap(tester, 'schedule-following-true');
    expect(
      find.byKey(const ValueKey('schedule-following-hint')),
      findsOneWidget,
    );
    await tester.enterText(
      find.byKey(const ValueKey('schedule-title')),
      'Kracht',
    );
    await _tap(tester, 'schedule-submit');

    final body =
        http.requestsTo('PATCH /teams/3/schedule/498').single.body! as Map;
    expect(body['title'], 'Kracht');
    expect(body['apply_to_following'], isTrue);
    expect(
      DateTime.parse(
        body['starts_at'] as String,
      ).isAtSameMomentAs(DateTime.parse('2099-11-12T19:30:00+01:00')),
      isTrue,
    );
    expect(
      DateTime.parse(
        body['ends_at'] as String,
      ).isAtSameMomentAs(DateTime.parse('2099-11-12T21:00:00+01:00')),
      isTrue,
    );
    expect(container.read(routerProvider).state.uri.path, AppRoutes.agenda);
    expect(
      find.text('Opgeslagen, ook op 6 volgende trainingen'),
      findsOneWidget,
    );
  });

  testWidgets('bewerken wedstrijd: uit, 422 komt bij het veld', (tester) async {
    final (_, http) = await _open(
      tester,
      path: '${AppRoutes.schedule}?event=512',
      setup: (http) => http
        ..on(
          'GET /teams/3/events/512',
          200,
          ScheduleFixtures.write(ScheduleFixtures.matchData()),
        )
        ..on('PATCH /teams/3/schedule/512', 422, {
          'message': 'De tegenstander is verplicht.',
          'errors': {
            'home_team': ['De tegenstander is verplicht.'],
          },
        }),
    );

    expect(find.text('DVS 33'), findsOneWidget);
    // Een wedstrijd heeft geen "alle volgende".
    expect(find.byKey(const ValueKey('schedule-following-true')), findsNothing);

    await _tap(tester, 'schedule-home-false');
    await _tap(tester, 'schedule-competition-cup');
    await tester.enterText(find.byKey(const ValueKey('schedule-opponent')), '');
    await _tap(tester, 'schedule-submit');

    final body =
        http.requestsTo('PATCH /teams/3/schedule/512').single.body! as Map;
    expect(body['is_home'], isFalse);
    expect(body['competition'], 'cup');
    expect(body['away_team'], 'Valleivogels 3');
    expect(body['home_team'], isNull);
    expect(find.text('De tegenstander is verplicht.'), findsOneWidget);
    expect(find.byKey(const ValueKey('schedule-form')), findsOneWidget);
  });

  testWidgets('opties laden mislukt: fout met opnieuw proberen', (
    tester,
  ) async {
    final (container, backend) = await pumpSignedIn(
      tester,
      teams: [ApiFixtures.membership(role: 'trainer')],
      setup: (http) => http.on(_options, 500, {'message': 'Kapot.'}),
    );
    unawaited(container.read(routerProvider).push(AppRoutes.schedule));
    await pumpUntilFound(tester, find.byKey(const ValueKey('schedule-error')));

    backend.http.on(_options, 200, ScheduleFixtures.options());
    await tester.tap(find.byKey(const ValueKey('schedule-retry')));
    await pumpUntilFound(tester, find.byKey(const ValueKey('schedule-form')));
  });
}
