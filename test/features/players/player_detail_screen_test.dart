import 'dart:async';

import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import '../team/roster_fixtures.dart';

const _detail = 'GET /teams/3/players/14';

Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  required Map<String, dynamic> membership,
  int playerId = 14,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [membership],
    setup: setup,
  );
  unawaited(container.read(routerProvider).push(AppRoutes.player(playerId)));
  await pumpUntilFound(
    tester,
    find.byKey(const ValueKey('player-detail-screen')),
  );
  await tester.pumpAndSettle();
  return (container, backend.http);
}

String _text(WidgetTester tester, String key) =>
    tester.widget<Text>(find.byKey(ValueKey(key))).data ?? '';

void main() {
  testWidgets('teamgenoot: kop, badges, seizoen-stats, diensten; geen beheer', (
    tester,
  ) async {
    await _open(
      tester,
      membership: RosterFixtures.membership(),
      setup: (http) => http.on(_detail, 200, RosterFixtures.playerDetail()),
    );

    expect(currentTitle(tester), 'Speler');
    expect(_text(tester, 'player-name'), 'Sam de Vries');
    expect(_text(tester, 'player-position'), 'Centrale middenvelder');
    expect(find.byKey(const ValueKey('player-shirt-number')), findsOneWidget);
    expect(find.byKey(const ValueKey('player-captain')), findsOneWidget);
    expect(find.byKey(const ValueKey('player-guest')), findsNothing);

    expect(find.byKey(const ValueKey('player-manage')), findsNothing);
    expect(find.byKey(const ValueKey('player-vacations')), findsNothing);
    expect(
      find.byKey(const ValueKey('player-standing-absences')),
      findsNothing,
    );

    expect(
      find.byKey(const ValueKey('player-achievement-hattrick_hero')),
      findsOneWidget,
    );
    expect(_text(tester, 'stat-matches'), '8');
    expect(_text(tester, 'stat-wins'), '5');
    expect(_text(tester, 'stat-goals'), '3');
    expect(_text(tester, 'stat-yellow'), '1');
    expect(find.byKey(const ValueKey('stat-green')), findsNothing);
    expect(_text(tester, 'stat-attendance-match'), '88%');
    expect(_text(tester, 'stat-win-pct'), '62,5% gewonnen');
    expect(_text(tester, 'player-duty-vlaggen'), '2×');
  });

  testWidgets('wissel naar carrière toont de carrièrecijfers', (tester) async {
    await _open(
      tester,
      membership: RosterFixtures.membership(),
      setup: (http) => http.on(_detail, 200, RosterFixtures.playerDetail()),
    );

    await tester.ensureVisible(find.text('Carrière'));
    await tester.tap(find.text('Carrière'));
    await tester.pumpAndSettle();

    expect(_text(tester, 'stat-matches'), '41');
    expect(_text(tester, 'stat-goals'), '12');
    expect(_text(tester, 'stat-attendance-match'), '84%');

    await tester.tap(find.text('Seizoen'));
    await tester.pumpAndSettle();
    expect(_text(tester, 'stat-matches'), '8');
  });

  testWidgets('trainer: e-mail, uitnodiging, vakanties en vaste dagen', (
    tester,
  ) async {
    await _open(
      tester,
      membership: RosterFixtures.membership(
        role: 'trainer',
        features: {'vacations': true},
      ),
      setup: (http) =>
          http.on(_detail, 200, RosterFixtures.managedPlayerDetail()),
    );

    expect(find.byKey(const ValueKey('player-manage')), findsOneWidget);
    expect(_text(tester, 'player-email'), 'sam@example.com');
    expect(_text(tester, 'player-invite'), 'Uitgenodigd op 1 sep. 2026');
    expect(find.byKey(const ValueKey('player-vacation-5')), findsOneWidget);
    expect(find.text('20 okt. 2026 t/m 27 okt. 2026'), findsOneWidget);
    expect(find.text('Skiën'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('player-standing-absences')),
      findsOneWidget,
    );
    expect(find.text('dinsdag'), findsOneWidget);
    expect(find.text('donderdag'), findsOneWidget);
  });

  testWidgets('sport zonder scorers en met groene kaarten', (tester) async {
    await _open(
      tester,
      membership: RosterFixtures.membership(
        sport: {
          ...RosterFixtures.footballSport(),
          'key': 'hockey',
          'field_variant': 'hockey',
          'tracks_scorers': false,
          'positions': <String, String>{},
          'card_types': [
            {'value': 'green', 'label': 'Groene kaart'},
            {'value': 'yellow', 'label': 'Gele kaart'},
          ],
        },
      ),
      setup: (http) => http.on(_detail, 200, RosterFixtures.playerDetail()),
    );

    expect(find.byKey(const ValueKey('stat-goals')), findsNothing);
    expect(find.byKey(const ValueKey('stat-green')), findsOneWidget);
    expect(find.byKey(const ValueKey('stat-red')), findsNothing);
    // Onbekende positiecode: de code zelf.
    expect(_text(tester, 'player-position'), 'CM');
  });

  testWidgets('onbekende speler: foutmelding en opnieuw proberen', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      membership: RosterFixtures.membership(),
      playerId: 99,
      setup: (http) =>
          http.on('GET /teams/3/players/99', 404, {'message': 'Weg.'}),
    );

    expect(currentTitle(tester), 'Speler');
    expect(find.byKey(const ValueKey('player-error')), findsOneWidget);
    expect(
      find.text('Deze speler bestaat niet (meer) in dit team.'),
      findsOneWidget,
    );

    http.on('GET /teams/3/players/99', 200, RosterFixtures.playerDetail());
    await tester.tap(find.byKey(const ValueKey('player-retry')));
    await tester.pumpAndSettle();
    expect(find.byKey(const ValueKey('player-header')), findsOneWidget);
  });
}
