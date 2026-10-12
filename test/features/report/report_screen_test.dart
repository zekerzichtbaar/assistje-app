import 'dart:async';

import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/session/models/team_membership.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:assistje/core/theme/app_theme.dart';
import 'package:assistje/features/report/presentation/report_view.dart';
import 'package:assistje/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import '../../helpers/test_app.dart';
import 'report_fixtures.dart';

Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  Map<String, dynamic>? data,
  bool editor = true,
  Map<String, dynamic>? flag,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [ReportFixtures.membership(editor: editor)],
    setup: (http) {
      http
        ..on(
          ReportFixtures.get,
          200,
          ReportFixtures.wrap(data ?? ReportFixtures.setsData()),
        )
        ..on(
          ReportFixtures.eventGet,
          200,
          ReportFixtures.eventDetail(flag: flag),
        );
      setup?.call(http);
    },
  );
  unawaited(container.read(routerProvider).push('/events/412/report'));
  await pumpUntilFound(tester, find.byKey(const ValueKey('report-screen')));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Finder _key(String key) => find.byKey(ValueKey(key));

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

String _text(WidgetTester tester, String key) =>
    tester.widget<Text>(_key(key)).data!;

void main() {
  testWidgets('doelpuntensport: uitslag aanpassen, geen blad', (tester) async {
    final (_, http) = await _open(
      tester,
      data: ReportFixtures.goalsData(),
      setup: (http) => http.on(
        ReportFixtures.score,
        200,
        ReportFixtures.wrap(ReportFixtures.goalsData(home: 3)),
      ),
    );

    expect(currentTitle(tester), 'Wedstrijdverslag');
    expect(_text(tester, 'report-match'), 'VV Vogels 3 - SV Merel 2');
    expect(_text(tester, 'report-score'), '2 - 1');
    expect(_key('report-sets'), findsNothing);
    expect(_key('report-stats-card'), findsNothing);
    expect(_key('report-timeline-note'), findsOneWidget);
    expect(_key('report-flag-card'), findsNothing);
    expect(find.text('Stand aanpassen'), findsOneWidget);

    await _tap(tester, _key('report-edit-score'));
    await tester.enterText(_key('report-score-home'), '3');
    await tester.enterText(_key('report-score-away'), '1');
    await _tap(tester, _key('report-score-save'));

    expect(http.requestsTo(ReportFixtures.score).single.body, {
      'home_score': 3,
      'away_score': 1,
    });
    expect(_key('report-score-save'), findsNothing);
    expect(_text(tester, 'report-score'), '3 - 1');
  });

  testWidgets('422 blijft in de sheet staan', (tester) async {
    final (_, http) = await _open(
      tester,
      data: ReportFixtures.goalsData(),
      setup: (http) => http.on(ReportFixtures.score, 422, {
        'message': 'De stand moet tussen 0 en 99 liggen.',
        'errors': {
          'home_score': ['De stand moet tussen 0 en 99 liggen.'],
        },
      }),
    );

    await _tap(tester, _key('report-edit-score'));
    await tester.enterText(_key('report-score-home'), '');
    await _tap(tester, _key('report-score-save'));

    expect(http.requestsTo(ReportFixtures.score).single.body, {
      'home_score': null,
      'away_score': 1,
    });
    expect(_key('report-score-save'), findsOneWidget);
    expect(find.text('De stand moet tussen 0 en 99 liggen.'), findsOneWidget);
    expect(_text(tester, 'report-score'), '2 - 1');
  });

  testWidgets('setsport: sets en kolommen uit het verslag', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        ReportFixtures.sets,
        200,
        ReportFixtures.wrap(
          ReportFixtures.setsData(
            home: 0,
            away: 1,
            sets: const [
              [21, 25],
            ],
          ),
        ),
      ),
    );

    expect(_text(tester, 'report-score'), '1 - 3');
    expect(
      find.descendant(of: _key('report-sets'), matching: find.text('25-21')),
      findsOneWidget,
    );
    // De kolommen naast de naam: de hoofdcijfers uit `stat_columns`.
    for (final (column, label) in [
      ('points', 'PTN'),
      ('aces', 'ACES'),
      ('blocks', 'BLK'),
    ]) {
      expect(
        find.descendant(
          of: _key('report-col-$column'),
          matching: find.text(label),
        ),
        findsOneWidget,
      );
    }
    expect(_key('report-col-attack_kills'), findsNothing);
    expect(_text(tester, 'report-value-37-points'), '12');
    expect(_text(tester, 'report-value-52-points'), '0');
    expect(_key('report-no-lineup'), findsNothing);
    expect(_key('report-import'), findsOneWidget);

    // Setstanden: één rij per mogelijke set (max_sets).
    await _tap(tester, _key('report-edit-score'));
    expect(_key('report-set-5-home'), findsOneWidget);
    expect(_key('report-set-6-home'), findsNothing);
    await tester.enterText(_key('report-set-1-home'), '21');
    await tester.enterText(_key('report-set-1-away'), '25');
    for (final n in [2, 3, 4]) {
      await tester.enterText(_key('report-set-$n-home'), '');
      await tester.enterText(_key('report-set-$n-away'), '');
    }
    await tester.pump();
    expect(_text(tester, 'report-sets-filled'), '1 set ingevuld.');
    await _tap(tester, _key('report-sets-save'));

    final body = http.requestsTo(ReportFixtures.sets).single.body! as Map;
    expect((body['sets'] as List).first, {
      'home_points': 21,
      'away_points': 25,
    });
    expect(body['sets'] as List, hasLength(5));
    expect(_text(tester, 'report-score'), '0 - 1');
  });

  testWidgets('cijfers van een speler invullen (alle kolommen)', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http.on(
        ReportFixtures.stats,
        200,
        ReportFixtures.wrap(
          ReportFixtures.setsData(
            playerStats: [
              {'player_id': 52, 'points': 9, 'aces': 1, 'blocks': 0},
            ],
          ),
        ),
      ),
    );

    await _tap(tester, _key('report-player-52'));
    for (final column in ReportFixtures.volleyColumns) {
      expect(_key('report-stat-$column'), findsOneWidget, reason: column);
    }
    expect(find.text('AANVAL'), findsOneWidget);
    expect(find.text('Kills'), findsOneWidget);
    await tester.enterText(_key('report-stat-points'), '9');
    await tester.enterText(_key('report-stat-aces'), '1');
    await tester.enterText(_key('report-stat-attack_kills'), '6');
    await _tap(tester, _key('report-stats-save'));

    final body = http.requestsTo(ReportFixtures.stats).single.body! as Map;
    final row = (body['stats'] as List).single as Map;
    expect(row['player_id'], 52);
    expect(row['points'], 9);
    expect(row['aces'], 1);
    expect(row['attack_kills'], 6);
    expect(row['blocks'], 0);
    expect(_text(tester, 'report-value-52-points'), '9');
  });

  testWidgets('onbekende kolommen komen leesbaar uit het verslag', (
    tester,
  ) async {
    await _open(
      tester,
      data: {
        ...ReportFixtures.setsData(canImport: false, withLineup: false),
        'stat_columns': ['points', 'assists'],
        'player_stats': [
          {'player_id': 52, 'points': 3, 'assists': 4},
        ],
      },
    );

    expect(
      find.descendant(
        of: _key('report-col-assists'),
        matching: find.text('ASSISTS'),
      ),
      findsOneWidget,
    );
    expect(_text(tester, 'report-value-52-assists'), '4');
    expect(_key('report-no-lineup'), findsOneWidget);
    expect(_key('report-import'), findsNothing);
  });

  testWidgets('scoutrapport lezen en overnemen', (tester) async {
    final (_, http) = await _open(
      tester,
      setup: (http) => http
        ..on(ReportFixtures.scout, 200, ReportFixtures.scoutPreview())
        ..on(
          ReportFixtures.stats,
          200,
          ReportFixtures.wrap(ReportFixtures.setsData()),
        )
        ..on(
          ReportFixtures.sets,
          200,
          ReportFixtures.wrap(ReportFixtures.setsData()),
        ),
    );

    await _tap(tester, _key('report-import'));
    expect(_key('report-scout-pick'), findsOneWidget);
    await tester.enterText(_key('report-scout-text'), 'Nr Naam Ptn\n4 Ilse 14');
    await tester.pump();
    await _tap(tester, _key('report-scout-read'));

    expect(http.requestsTo(ReportFixtures.scout).single.body, {
      'text': 'Nr Naam Ptn\n4 Ilse 14',
    });
    // Onze ploeg (index 1) is voorgekozen: één van de twee gekoppeld.
    expect(
      _text(tester, 'report-scout-linked'),
      contains('1 van de 2 regels gekoppeld'),
    );
    expect(find.text('Ptn 14 · Aces 3 · Blk 2'), findsOneWidget);
    expect(_key('report-scout-sets'), findsOneWidget);

    await _tap(tester, _key('report-scout-apply'));

    final stats = http.requestsTo(ReportFixtures.stats).single.body! as Map;
    final row = (stats['stats'] as List).single as Map;
    expect(row['player_id'], 37);
    expect(row['points'], 14);
    expect(row['aces'], 3);
    expect(row['attack_kills'], 0);
    // Wij spelen uit en de ploeg onderaan is de onze: thuis/uit blijft zo.
    final sets = http.requestsTo(ReportFixtures.sets).single.body! as Map;
    expect((sets['sets'] as List).first, {
      'home_points': 25,
      'away_points': 21,
    });
    expect(_key('report-scout-apply'), findsNothing);
  });

  testWidgets('scout-preview 422 staat in de sheet', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(ReportFixtures.scout, 422, {
        'message': 'Kies een PDF of plak de tabel uit het rapport.',
      }),
    );

    await _tap(tester, _key('report-import'));
    await tester.enterText(_key('report-scout-text'), 'rommel');
    await tester.pump();
    await _tap(tester, _key('report-scout-read'));

    expect(
      find.text('Kies een PDF of plak de tabel uit het rapport.'),
      findsOneWidget,
    );
    expect(_key('report-scout-read'), findsOneWidget);
  });

  testWidgets('vlaggersdienst toewijzen', (tester) async {
    final (_, http) = await _open(
      tester,
      data: ReportFixtures.goalsData(),
      flag: ReportFixtures.flag(),
      setup: (http) =>
          http.routes[ReportFixtures.flagPut] = ReportFixtures.echoFlag(),
    );

    expect(_key('report-flag-card'), findsOneWidget);
    expect(find.text('Kees Jansen vanaf 0′'), findsOneWidget);
    expect(find.text('Trainer Tom vanaf 45′'), findsOneWidget);

    await _tap(tester, _key('report-edit-flag'));
    // Tweede wissel weg, een nieuwe erbij met de gast.
    await _tap(tester, _key('report-flag-remove-1'));
    await _tap(tester, _key('report-flag-add'));
    await tester.enterText(_key('report-flag-minute-1'), '60');
    await _tap(tester, _key('report-flag-person-1'));
    await tester.tap(find.text('Gijs Gast (gast)').last);
    await tester.pumpAndSettle();
    await _tap(tester, _key('report-flag-save'));

    expect(http.requestsTo(ReportFixtures.flagPut).single.body, {
      'shifts': [
        {'player_id': 37, 'user_id': null, 'from_minute': 0},
        {'player_id': 52, 'user_id': null, 'from_minute': 60},
      ],
    });
    expect(_key('report-flag-save'), findsNothing);
    expect(find.text('Gijs Gast vanaf 60′'), findsOneWidget);
  });

  testWidgets('zonder lineup-bevoegdheid: de router laat je er niet in', (
    tester,
  ) async {
    final (container, backend) = await pumpSignedIn(
      tester,
      teams: [ReportFixtures.membership(editor: false)],
    );
    unawaited(container.read(routerProvider).push('/events/412/report'));
    await tester.pumpAndSettle();

    expect(_key('report-screen'), findsNothing);
    expect(backend.http.requestsTo(ReportFixtures.get), isEmpty);
  });

  testWidgets('zonder lineup-bevoegdheid in beeld: 403-scherm, geen verzoek', (
    tester,
  ) async {
    final backend = TestBackend(token: '12|abc');
    await backend.init();
    final player = TeamMembership.fromJson(
      ReportFixtures.membership(editor: false),
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          ...backend.overrides,
          currentMembershipProvider.overrideWithValue(player),
        ],
        child: MaterialApp(
          theme: AppTheme.light(null),
          locale: const Locale('nl'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const ReportView(eventId: 412),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(_key('report-forbidden'), findsOneWidget);
    expect(find.text('Geen toegang'), findsOneWidget);
    expect(backend.http.requests, isEmpty);
  });

  testWidgets('403 van de server', (tester) async {
    await _open(
      tester,
      setup: (http) =>
          http.on(ReportFixtures.get, 403, {'message': 'Geen toegang.'}),
    );
    expect(_key('report-forbidden'), findsOneWidget);
  });

  testWidgets('404 van de server', (tester) async {
    await _open(
      tester,
      setup: (http) =>
          http.on(ReportFixtures.get, 404, {'message': 'Niet gevonden.'}),
    );
    expect(_key('report-not-found'), findsOneWidget);
    expect(_key('report-retry'), findsNothing);
  });

  testWidgets('andere fout: opnieuw proberen', (tester) async {
    var calls = 0;
    await _open(
      tester,
      setup: (http) => http.routes[ReportFixtures.get] = (_) {
        calls++;
        return calls == 1
            ? const FakeResponse(500, {'message': 'Server Error'})
            : FakeResponse(
                200,
                ReportFixtures.wrap(ReportFixtures.goalsData()),
              );
      },
    );
    expect(_key('report-error'), findsOneWidget);

    await _tap(tester, _key('report-retry'));

    expect(_text(tester, 'report-score'), '2 - 1');
  });
}
