import 'dart:async';

import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'training_teams_fixtures.dart';

const _base = '/teams/3/events/512/teams';
const _index = 'GET $_base';

/// Trainer met posities in het sportprofiel (nooit een sport hardcoden).
Map<String, dynamic> _trainer() => {
  ...ApiFixtures.membership(role: 'trainer'),
  'sport': {
    'key': 'football',
    'positions': {'K': 'Keeper', 'MF': 'Middenvelder'},
  },
};

Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  void Function(FakeHttpAdapter http)? setup,
  List<Map<String, dynamic>>? teams,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: teams ?? [_trainer()],
    setup: setup,
  );
  unawaited(
    container.read(routerProvider).push('${AppRoutes.event(512)}/teams'),
  );
  await pumpUntilFound(
    tester,
    find.byKey(const ValueKey('training-teams-screen')),
  );
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Laat de wachttijd van de uitslag verstrijken.
Future<void> _flushScores(WidgetTester tester) async {
  await tester.pump(const Duration(milliseconds: 600));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('toont indeling, bank, uitslag en puntenlijst', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_index, 200, TrainingTeamsFixtures.screen()),
    );

    expect(currentTitle(tester), 'Trainingsteams');
    expect(
      find.byKey(const ValueKey('training-teams-event-title')),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('training-side-a')), findsOneWidget);
    expect(find.byKey(const ValueKey('training-side-b')), findsOneWidget);
    expect(find.byKey(const ValueKey('training-side-c')), findsNothing);
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('training-bench')),
        matching: find.text('Tim Bakker'),
      ),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('training-result')), findsOneWidget);
    expect(find.byKey(const ValueKey('training-result-saved')), findsOneWidget);
    expect(find.byKey(const ValueKey('training-scoring')), findsOneWidget);
    expect(find.byKey(const ValueKey('training-include-60')), findsOneWidget);
    expect(find.text('4 pt'), findsOneWidget);
  });

  testWidgets('geen indeling: uitleg en indelen via de sheet', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(
          _index,
          200,
          TrainingTeamsFixtures.screen(
            players: TrainingTeamsFixtures.benchPlayers(),
            scores: {},
          ),
        )
        ..on('POST $_base/draw', 200, TrainingTeamsFixtures.screen()),
    );

    expect(find.byKey(const ValueKey('training-draw-prompt')), findsOneWidget);
    expect(find.byKey(const ValueKey('training-board')), findsNothing);
    // Zonder ploegen geen uitslag, wel de puntenlijst.
    expect(find.byKey(const ValueKey('training-result')), findsNothing);

    await _tap(tester, find.byKey(const ValueKey('training-open-setup')));
    expect(find.byKey(const ValueKey('training-setup-sheet')), findsOneWidget);
    // Drie aanwezigen: vier ploegen kan niet.
    final four = tester.widget<InkWell>(
      find.descendant(
        of: find.byKey(const ValueKey('training-setup-count-4')),
        matching: find.byType(InkWell),
      ),
    );
    expect(four.onTap, isNull);
    await _tap(tester, find.byKey(const ValueKey('training-setup-count-3')));
    await _tap(tester, find.byKey(const ValueKey('training-setup-draw')));

    expect(http.requestsTo('POST $_base/draw').single.body, {'teams': 3});
    expect(find.byKey(const ValueKey('training-board')), findsOneWidget);
  });

  testWidgets('tik-tik ruilt twee spelers', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on('POST $_base/swap', 200, TrainingTeamsFixtures.screen()),
    );

    await _tap(tester, find.byKey(const ValueKey('training-player-37')));
    expect(
      find.text(
        'Tik nu degene aan met wie hij ruilt, of een kop om hem '
        'daar neer te zetten.',
      ),
      findsOneWidget,
    );
    await _tap(tester, find.byKey(const ValueKey('training-player-41')));

    expect(http.requestsTo('POST $_base/swap').single.body, {'a': 37, 'b': 41});
  });

  testWidgets('kop of bank aantikken verplaatst zonder ruilen', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on('PATCH $_base/52', 200, TrainingTeamsFixtures.screen())
        ..on('PATCH $_base/41', 200, TrainingTeamsFixtures.screen()),
    );

    await _tap(tester, find.byKey(const ValueKey('training-player-52')));
    await _tap(tester, find.byKey(const ValueKey('training-side-header-b')));
    expect(http.requestsTo('PATCH $_base/52').single.body, {'side': 'b'});

    await _tap(tester, find.byKey(const ValueKey('training-player-41')));
    await _tap(tester, find.byKey(const ValueKey('training-bench-header')));
    expect(http.requestsTo('PATCH $_base/41').single.body, {'side': null});
  });

  testWidgets('mislukt ruilen: terug op de oude plek en een fouttoast', (
    tester,
  ) async {
    await _open(
      tester,
      setup: (http) => http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on('POST $_base/swap', 404, {'message': 'Niets te ruilen.'}),
    );

    await _tap(tester, find.byKey(const ValueKey('training-player-37')));
    await _tap(tester, find.byKey(const ValueKey('training-player-52')));

    expect(find.text('Niets te ruilen.'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('training-side-a')),
        matching: find.text('Kees Jansen'),
      ),
      findsOneWidget,
    );
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  });

  testWidgets('opnieuw indelen en wissen (met bevestiging)', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on('POST $_base/draw', 200, TrainingTeamsFixtures.screen())
        ..on(
          'DELETE $_base',
          200,
          TrainingTeamsFixtures.screen(
            players: TrainingTeamsFixtures.benchPlayers(),
          ),
        ),
    );

    await _tap(tester, find.byKey(const ValueKey('training-redraw')));
    expect(http.requestsTo('POST $_base/draw'), hasLength(1));
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    await _tap(tester, find.byKey(const ValueKey('training-clear')));
    await _tap(
      tester,
      find.byKey(const ValueKey('training-teams-confirm-cancel')),
    );
    expect(http.requestsTo('DELETE $_base'), isEmpty);

    await _tap(tester, find.byKey(const ValueKey('training-clear')));
    await _tap(tester, find.byKey(const ValueKey('training-teams-confirm-ok')));
    expect(http.requestsTo('DELETE $_base'), hasLength(1));
    expect(find.byKey(const ValueKey('training-draw-prompt')), findsOneWidget);
  });

  testWidgets('uitslag: snelknop en stepper gaan samen in één verzoek', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(_index, 200, TrainingTeamsFixtures.screen(scores: {}))
        ..on(
          'POST $_base/points',
          200,
          TrainingTeamsFixtures.screen(scores: {'a': 3, 'b': 0}),
        ),
    );

    // Eerst in beeld scrollen; daarna snel achter elkaar tikken (binnen de
    // wachttijd van de uitslag).
    await tester.ensureVisible(find.byKey(const ValueKey('training-score-b')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('training-won-a')));
    await tester.pump();
    await tester.tap(find.byKey(const ValueKey('training-score-a-up')));
    await tester.pump();
    expect(http.requestsTo('POST $_base/points'), isEmpty);
    final value = tester.widget<Text>(
      find.byKey(const ValueKey('training-score-a-value')),
    );
    expect(value.data, '3');
    await _flushScores(tester);

    expect(http.requestsTo('POST $_base/points').single.body, {
      'points': {'a': 3, 'b': 0},
    });
  });

  testWidgets('puntenlijst: bijstellen, iedereen gelijk, uit en terug', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on('PATCH $_base/41/points', 200, TrainingTeamsFixtures.screen())
        ..on('POST $_base/draw-points', 200, TrainingTeamsFixtures.screen())
        ..on('DELETE $_base/41', 200, TrainingTeamsFixtures.screen())
        ..on('POST $_base/60/include', 200, TrainingTeamsFixtures.screen()),
    );

    await _tap(tester, find.byKey(const ValueKey('training-scoring-41-up')));
    expect(http.requestsTo('PATCH $_base/41/points').single.body, {
      'points': 1,
    });
    await _tap(tester, find.byKey(const ValueKey('training-draw-points')));
    expect(http.requestsTo('POST $_base/draw-points'), hasLength(1));
    await _tap(tester, find.byKey(const ValueKey('training-exclude-41')));
    expect(http.requestsTo('DELETE $_base/41'), hasLength(1));
    await _tap(tester, find.byKey(const ValueKey('training-include-60')));
    expect(http.requestsTo('POST $_base/60/include'), hasLength(1));
  });

  testWidgets('sterktes: tik zet het cijfer, nog eens tikken haalt het weg', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on('PATCH /teams/3/players/41/strength', 200, {
          'data': {'player_id': 41, 'strength': 3},
        })
        ..on('PATCH /teams/3/players/37/strength', 200, {
          'data': {'player_id': 37, 'strength': null},
        }),
    );

    await _tap(tester, find.byKey(const ValueKey('training-open-strengths')));
    expect(
      find.byKey(const ValueKey('training-strength-sheet')),
      findsOneWidget,
    );
    // Positie uit het sportprofiel.
    expect(find.text('Middenvelder'), findsOneWidget);
    // Piet heeft geen cijfer: het afgeleide staat ernaast.
    expect(find.text('uit de historie: 2'), findsOneWidget);

    await _tap(tester, find.byKey(const ValueKey('training-strength-41-3')));
    expect(http.requestsTo('PATCH /teams/3/players/41/strength').single.body, {
      'strength': 3,
    });
    await _tap(tester, find.byKey(const ValueKey('training-strength-37-4')));
    expect(http.requestsTo('PATCH /teams/3/players/37/strength').single.body, {
      'strength': null,
    });
  });

  testWidgets('basis kiezen in de instel-sheet', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(_index, 200, TrainingTeamsFixtures.screen())
        ..on('PATCH /teams/3/training-basis', 200, {
          'data': {'basis': 'random'},
        }),
    );

    await _tap(tester, find.byKey(const ValueKey('training-open-setup')));
    expect(find.byKey(const ValueKey('training-basis-points')), findsOneWidget);
    await _tap(tester, find.byKey(const ValueKey('training-basis-random')));
    expect(http.requestsTo('PATCH /teams/3/training-basis').single.body, {
      'basis': 'random',
    });
  });

  testWidgets('zonder trainingspunten geen klassement, uitslag of punten', (
    tester,
  ) async {
    await _open(
      tester,
      setup: (http) => http.on(
        _index,
        200,
        TrainingTeamsFixtures.screen(tracksPoints: false),
      ),
    );

    expect(find.byKey(const ValueKey('training-result')), findsNothing);
    expect(find.byKey(const ValueKey('training-scoring')), findsNothing);
    await _tap(tester, find.byKey(const ValueKey('training-open-setup')));
    expect(find.byKey(const ValueKey('training-basis-points')), findsNothing);
    expect(find.byKey(const ValueKey('training-basis-random')), findsOneWidget);
  });

  testWidgets('kopiëren zet de indeling op het klembord', (tester) async {
    String? copied;
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'Clipboard.setData') {
          copied = (call.arguments as Map)['text'] as String?;
        }
        return null;
      },
    );
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      ),
    );
    await _open(
      tester,
      setup: (http) => http.on(_index, 200, TrainingTeamsFixtures.screen()),
    );

    await _tap(tester, find.byKey(const ValueKey('training-copy')));

    expect(copied, contains('Team 1\n· Kees Jansen'));
    expect(copied, contains('Team 2\n· Piet de Vries'));
    expect(copied, isNot(contains('Tim Bakker')));
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  });

  testWidgets('403 en 404 tonen een eigen lege staat', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_index, 403, {'message': 'Nee.'}),
    );
    expect(
      find.byKey(const ValueKey('training-teams-forbidden')),
      findsOneWidget,
    );
  });

  testWidgets('404: geen partijvorm', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_index, 404, {'message': 'Weg.'}),
    );
    expect(
      find.byKey(const ValueKey('training-teams-not-found')),
      findsOneWidget,
    );
  });

  testWidgets('serverfout: opnieuw proberen laadt alsnog', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(_index, 500, {'message': 'Kapot.'}),
    );
    expect(find.byKey(const ValueKey('training-teams-error')), findsOneWidget);

    http.on(_index, 200, TrainingTeamsFixtures.screen());
    await _tap(tester, find.byKey(const ValueKey('training-teams-retry')));
    expect(find.byKey(const ValueKey('training-board')), findsOneWidget);
  });

  testWidgets('wie niet mag indelen ziet de ploegen alleen', (tester) async {
    await _open(
      tester,
      teams: [
        {
          ...ApiFixtures.membership(abilities: ['training_points']),
        },
      ],
      setup: (http) =>
          http.on(_index, 200, TrainingTeamsFixtures.screen(mayAssign: false)),
    );

    expect(find.byKey(const ValueKey('training-board')), findsOneWidget);
    expect(find.byKey(const ValueKey('training-redraw')), findsNothing);
    expect(find.byKey(const ValueKey('training-clear')), findsNothing);
    expect(find.byKey(const ValueKey('training-pick-hint')), findsNothing);
    expect(find.byKey(const ValueKey('training-scoring')), findsOneWidget);
  });
}
