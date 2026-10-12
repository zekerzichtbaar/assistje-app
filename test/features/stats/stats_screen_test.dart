import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'stats_fixtures.dart';

const _stats = 'GET /teams/3/stats';

Map<String, dynamic> _membership(
  Map<String, dynamic> sport, {
  Map<String, bool> features = const {'stats': true},
}) => {...ApiFixtures.membership(features: features), 'sport': sport};

/// Start ingelogd, zet `/stats` klaar en opent de tab.
Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  Map<String, dynamic>? sport,
  Map<String, bool> features = const {'stats': true},
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [
      _membership(sport ?? StatsFixtures.footballSport(), features: features),
    ],
    setup: (http) {
      http.on(_stats, 200, StatsFixtures.response());
      setup?.call(http);
    },
  );
  container.read(routerProvider).go(AppRoutes.stats);
  await pumpUntilFound(tester, find.byKey(const ValueKey('stats-screen')));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Finder _tile(String kind, int playerId) =>
    find.byKey(ValueKey('stats-tile-$kind-$playerId'));

void main() {
  testWidgets('voetbal: titel, rijen, doelpunt-, minuten- en vlagtegels', (
    tester,
  ) async {
    await _open(tester);

    expect(currentTitle(tester), 'Statistieken');
    expect(find.byKey(const ValueKey('stats-row-14')), findsOneWidget);
    expect(find.byKey(const ValueKey('stats-row-22')), findsOneWidget);
    expect(_tile('goals', 14), findsOneWidget);
    expect(_tile('assists', 14), findsOneWidget);
    expect(_tile('minutes', 14), findsOneWidget);
    expect(_tile('flag', 14), findsOneWidget);
    expect(_tile('matches', 14), findsNothing);
    expect(find.text('min · 8 w.'), findsOneWidget);
    expect(find.text('vlag · 1×'), findsOneWidget);
    expect(find.text('⚽ Topscorer'), findsOneWidget);
    // Kaarten: Sam geel, Joris rood.
    expect(find.byKey(const ValueKey('stats-yellow-14')), findsOneWidget);
    expect(find.byKey(const ValueKey('stats-red-22')), findsOneWidget);
    // Sorteerkeuzes volgen de sport.
    expect(find.byKey(const ValueKey('stats-sort-goals')), findsOneWidget);
    expect(
      find.byKey(const ValueKey('stats-sort-flagMinutes')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('stats-sort-trainingPoints')),
      findsNothing,
    );
    // Mijn rij is gemarkeerd.
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('stats-row-14')),
        matching: find.byKey(const ValueKey('stats-me-badge')),
      ),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('stats-me-badge')), findsOneWidget);
  });

  testWidgets('volleybal (sets): geen doelpunten, minuten, vlag of kaarten', (
    tester,
  ) async {
    await _open(
      tester,
      sport: StatsFixtures.volleyballSport(),
      features: const {'stats': true, 'training_points': true},
    );

    expect(_tile('goals', 14), findsNothing);
    expect(_tile('assists', 14), findsNothing);
    expect(_tile('minutes', 14), findsNothing);
    expect(_tile('flag', 14), findsNothing);
    expect(_tile('matches', 14), findsOneWidget);
    expect(find.byKey(const ValueKey('stats-yellow-14')), findsNothing);
    expect(find.byKey(const ValueKey('stats-red-22')), findsNothing);
    expect(find.byKey(const ValueKey('stats-sort-goals')), findsNothing);
    expect(find.byKey(const ValueKey('stats-sort-minutes')), findsNothing);
    expect(
      find.byKey(const ValueKey('stats-sort-trainingPoints')),
      findsOneWidget,
    );
  });

  testWidgets('hockey: doelpunten met de sportterm, geen vlag', (tester) async {
    await _open(tester, sport: StatsFixtures.hockeySport());

    expect(_tile('goals', 14), findsOneWidget);
    expect(_tile('flag', 14), findsNothing);
    expect(find.text('Doelpunten'), findsWidgets);
  });

  testWidgets('sorteren op assists zet Joris bovenaan met medaille', (
    tester,
  ) async {
    await _open(tester);

    double top(int id) =>
        tester.getTopLeft(find.byKey(ValueKey('stats-row-$id'))).dy;
    expect(top(14), lessThan(top(22)));

    await _tap(tester, find.byKey(const ValueKey('stats-sort-assists')));

    expect(top(22), lessThan(top(14)));
    expect(find.text('🥇'), findsOneWidget);
    expect(
      tester.widget<Text>(find.byKey(const ValueKey('stats-metric-22'))).data,
      '5',
    );
  });

  testWidgets('venster en seizoen wisselen vragen de server opnieuw', (
    tester,
  ) async {
    final (_, http) = await _open(tester);

    await _tap(tester, find.text('Laatste 5'));
    expect(http.requestsTo(_stats).last.options.uri.queryParameters, {
      'window': '5',
    });

    await _tap(tester, find.byKey(const ValueKey('stats-season-picker')));
    await _tap(tester, find.byKey(const ValueKey('stats-season-3')));
    expect(http.requestsTo(_stats).last.options.uri.queryParameters, {
      'window': '5',
      'season': '3',
    });
  });

  testWidgets('tik op een speler opent /players/:id', (tester) async {
    final (container, _) = await _open(tester);

    await _tap(tester, find.byKey(const ValueKey('stats-row-22')));

    expect(container.read(routerProvider).state.uri.path, '/players/22');
  });

  testWidgets('lege lijst toont de lege staat', (tester) async {
    await _open(
      tester,
      setup: (http) =>
          http.on(_stats, 200, StatsFixtures.response({'rows': <Object>[]})),
    );

    expect(find.byKey(const ValueKey('stats-empty')), findsOneWidget);
    expect(find.text('Nog geen statistieken'), findsOneWidget);
  });

  testWidgets('fout met opnieuw proberen; titel blijft staan', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(_stats, 500, {'message': 'Kapot'}),
    );

    expect(find.byKey(const ValueKey('stats-error')), findsOneWidget);
    expect(find.text('Kapot'), findsOneWidget);
    expect(currentTitle(tester), 'Statistieken');

    http.on(_stats, 200, StatsFixtures.response());
    await _tap(tester, find.byKey(const ValueKey('stats-retry')));

    expect(find.byKey(const ValueKey('stats-error')), findsNothing);
    expect(find.byKey(const ValueKey('stats-row-14')), findsOneWidget);
  });

  testWidgets('404 (feature uit): eigen melding', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_stats, 404, {'message': 'Not Found'}),
    );

    expect(find.text('Statistieken staan uit voor dit team.'), findsOneWidget);
    expect(currentTitle(tester), 'Statistieken');
  });
}
