import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import '../stats/stats_fixtures.dart';
import 'hall_of_fame_fixtures.dart';

const _hof = 'GET /teams/3/hall-of-fame';

/// Start ingelogd met [sport], zet de Hall of Fame klaar en opent de tab.
Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  Map<String, dynamic>? sport,
  Map<String, dynamic>? data,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [
      {
        ...ApiFixtures.membership(features: {'stats': true}),
        'sport': sport ?? StatsFixtures.footballSport(),
      },
    ],
    setup: (http) {
      http.on(_hof, 200, {'data': data ?? HallOfFameFixtures.data()});
      setup?.call(http);
    },
  );
  container.read(routerProvider).go(AppRoutes.hallOfFame);
  await pumpUntilFound(tester, find.byKey(const ValueKey('hof-screen')));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Finder _key(String key) => find.byKey(ValueKey(key));

void main() {
  testWidgets('voetbal: ranglijsten van de sport, met sporttermen', (
    tester,
  ) async {
    await _open(tester);

    expect(currentTitle(tester), 'Ranking');
    expect(_key('hof-top-scorers'), findsOneWidget);
    expect(_key('hof-top-assisters'), findsOneWidget);
    expect(_key('hof-top-flaggers'), findsOneWidget);
    expect(_key('hof-top-motm'), findsOneWidget);
    expect(_key('hof-points'), findsNothing);
    expect(find.text('Top assists'), findsOneWidget);
    // Lege lijst = nog niemand.
    expect(
      find.descendant(
        of: _key('hof-top-assisters'),
        matching: find.text('Nog niemand op dit podium.'),
      ),
      findsOneWidget,
    );
    expect(find.text('Joris Bakker'), findsOneWidget);
    // Zonder seizoenen-keuze en zonder trainingspunten: geen kiezer/tab.
    expect(_key('hof-season-picker'), findsNothing);
    expect(find.text('Trainen'), findsNothing);
  });

  testWidgets('volleybal: statistiekenblad in plaats van scorers en vlag', (
    tester,
  ) async {
    await _open(
      tester,
      sport: StatsFixtures.volleyballSport(),
      data: HallOfFameFixtures.volleyball(),
    );

    expect(_key('hof-top-scorers'), findsNothing);
    expect(_key('hof-top-assisters'), findsNothing);
    expect(_key('hof-top-flaggers'), findsNothing);
    expect(_key('hof-points'), findsOneWidget);
    expect(_key('hof-aces'), findsOneWidget);
    expect(_key('hof-blocks'), findsOneWidget);
    expect(find.text('Lotte'), findsOneWidget);
  });

  testWidgets('tik op een ranglijstspeler opent /players/:id', (tester) async {
    final (container, _) = await _open(tester);

    await _tap(
      tester,
      find.descendant(
        of: _key('hof-top-flaggers'),
        matching: _key('hof-leader-22'),
      ),
    );

    expect(container.read(routerProvider).state.uri.path, '/players/22');
  });

  testWidgets('mijlpalen: titels, erelijst, badges en periodekiezer', (
    tester,
  ) async {
    final (_, http) = await _open(tester, data: HallOfFameFixtures.rich());

    await _tap(tester, find.text('Mijlpalen'));

    expect(_key('hof-title-season-top_scorer'), findsOneWidget);
    expect(_key('hof-titles-now'), findsOneWidget);
    expect(find.text('2 spelers gelijk'), findsOneWidget);
    expect(_key('hof-awards'), findsOneWidget);
    expect(_key('hof-award-1-top_scorer'), findsOneWidget);
    expect(_key('hof-badge-player-14'), findsOneWidget);
    expect(find.text('🥇 Hattrick hero'), findsOneWidget);
    expect(find.text('Blok 0 (afgesloten)'), findsOneWidget);

    // Gedeelde titel: lijst van houders.
    await _tap(tester, _key('hof-title-now-iron_man'));
    expect(_key('hof-holders-sheet'), findsOneWidget);
    expect(_key('hof-holder-22'), findsOneWidget);
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    // Periode kiezen: ?period= en een periodekop; erelijst en "nu" weg.
    http.on(_hof, 200, {
      'data': HallOfFameFixtures.rich({
        'period_id': 2,
        'period_awards': <Object>[],
      }),
    });
    await _tap(tester, _key('hof-period-2'));

    expect(http.requestsTo(_hof).last.options.uri.queryParameters, {
      'period': '2',
    });
    expect(find.text('Titels · Blok 1'), findsOneWidget);
    expect(_key('hof-titles-now'), findsNothing);
    expect(_key('hof-awards'), findsNothing);
  });

  testWidgets('seizoen kiezen en trainingspunten-tab', (tester) async {
    final (_, http) = await _open(tester, data: HallOfFameFixtures.rich());

    await _tap(tester, find.text('Trainen'));
    expect(_key('hof-training-points'), findsOneWidget);
    expect(find.text('Joris Bakker'), findsOneWidget);

    await _tap(tester, _key('hof-season-picker'));
    await _tap(tester, _key('hof-season-3'));
    expect(http.requestsTo(_hof).last.options.uri.queryParameters, {
      'season': '3',
    });
  });

  testWidgets('fout met opnieuw proberen; titel blijft staan', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(_hof, 500, {'message': 'Kapot'}),
    );

    expect(_key('hof-error'), findsOneWidget);
    expect(find.text('Kapot'), findsOneWidget);
    expect(currentTitle(tester), 'Ranking');

    http.on(_hof, 200, HallOfFameFixtures.response());
    await _tap(tester, _key('hof-retry'));

    expect(_key('hof-error'), findsNothing);
    expect(_key('hof-top-scorers'), findsOneWidget);
  });
}
