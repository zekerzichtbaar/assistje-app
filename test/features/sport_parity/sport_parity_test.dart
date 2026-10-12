import 'dart:async';

import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/features/lineup/presentation/widgets/field_painters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import '../lineup/lineup_fixtures.dart';
import '../live/live_fixtures.dart';
import '../report/report_fixtures.dart';
import '../stats/stats_fixtures.dart';
import '../team/roster_fixtures.dart';
import 'sport_profiles.dart';

/// Pariteit over de vier sporten: elk sportgestuurd scherm (opstelling,
/// statistieken, live, team, verslag) krijgt het échte API-sportprofiel en
/// moet veld, formatie en terminologie dáár vandaan halen. De verwachtingen
/// worden uit hetzelfde profiel gelezen, zodat een gewijzigd profiel in
/// vogels3 hier vanzelf meeloopt.

/// Membership van team 3 als trainer (lineup-bevoegd) met de features die
/// de sportgestuurde schermen nodig hebben, en het volledige [sport]profiel.
Map<String, dynamic> _membership(Map<String, dynamic> sport) => {
  ...ApiFixtures.membership(
    role: 'trainer',
    abilities: const ['lineup'],
    features: const {'stats': true, 'live': true, 'live_reactions': true},
    fieldVariant: sport['field_variant'] as String,
  ),
  'sport': sport,
};

Finder _key(String key) => find.byKey(ValueKey(key));

String _text(WidgetTester tester, String key) =>
    tester.widget<Text>(_key(key)).data!;

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<(ProviderContainer, FakeHttpAdapter)> _pump(
  WidgetTester tester,
  Map<String, dynamic> sport,
  void Function(FakeHttpAdapter http) setup,
) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [_membership(sport)],
    setup: setup,
  );
  return (container, backend.http);
}

/// De `rules` van `GET live` zoals `LiveStateQuery` ze uit het profiel
/// bouwt: delen zonder grenzen, kaarten/momenten als `{type, label}`.
Map<String, dynamic> _liveRules(Map<String, dynamic> sport) {
  final periods = {...sport['periods'] as Map<String, dynamic>}
    ..remove('boundaries');
  List<Map<String, dynamic>> types(String key) => [
    for (final t in sport[key] as List)
      {'type': (t as Map)['value'], 'label': t['label']},
  ];
  return {
    'score_model': sport['score_model'],
    'tracks_scorers': sport['tracks_scorers'],
    'periods': periods,
    'card_types': types('card_types'),
    'moment_types': types('moment_types'),
  };
}

List<String> _values(Map<String, dynamic> sport, String key) => [
  for (final t in sport[key] as List) (t as Map)['value'] as String,
];

void main() {
  // De painterklasse per `field_variant`: de enige plek waar de test een
  // sportwaarde koppelt, en dan aan een API-waarde, niet aan app-logica.
  const painters = <String, Type>{
    'football': FootballFieldPainter,
    'hockey': HockeyFieldPainter,
    'korfball': KorfballFieldPainter,
    'volleyball': VolleyballFieldPainter,
  };

  test('de vier sporten uit vogels3 zijn allemaal gedekt', () {
    expect(SportProfiles.all().keys.toSet(), painters.keys.toSet());
  });

  for (final key in SportProfiles.all().keys) {
    group(key, () {
      testWidgets(
        'opstelling: veld, formatie en positienamen uit het profiel',
        (tester) async {
          final sport = SportProfiles.of(key);
          final variant = sport['field_variant'] as String;
          final formation =
              LineupFixtures.formationsByVariant[variant]!.values.first;
          final firstSlot = formation.first['code'] as String;
          // De bankspeler krijgt een positiecode die alleen dit profiel kent.
          final positions = sport['positions'] as Map<String, dynamic>;
          final code = positions.keys.last;
          final response = LineupFixtures.response(
            variant: variant,
            slots: [(firstSlot, 11)],
            captain: null,
          );
          final data = response['data'] as Map<String, dynamic>;
          data['pool'] = [
            for (final p in data['pool'] as List)
              (p as Map)['id'] == 60
                  ? {...p.cast<String, dynamic>(), 'position': code}
                  : p,
          ];

          final (container, _) = await _pump(
            tester,
            sport,
            (http) => http.on(LineupFixtures.get, 200, response),
          );
          unawaited(container.read(routerProvider).push('/events/412/lineup'));
          await pumpUntilFound(tester, _key('lineup-screen'));
          await tester.pumpAndSettle();

          final painter = fieldPainterFor(variant);
          expect(painter.runtimeType, painters[variant]);
          final field = _key('lineup-field-${painter.variant}');
          expect(field, findsOneWidget);
          expect(
            tester.widget<CustomPaint>(field).painter.runtimeType,
            painters[variant],
          );
          for (final slot in formation) {
            expect(_key('lineup-slot-${slot['code']}'), findsOneWidget);
          }
          expect(
            find.descendant(
              of: _key('lineup-bench-player-60'),
              matching: find.text(positions[code] as String),
            ),
            findsOneWidget,
          );
        },
      );

      testWidgets('statistieken: kolommen en termen uit het profiel', (
        tester,
      ) async {
        final sport = SportProfiles.of(key);
        final terms = sport['terms'] as Map<String, dynamic>;
        final cards = _values(sport, 'card_types');
        final container = (await _pump(
          tester,
          sport,
          (http) =>
              http.on('GET /teams/3/stats', 200, StatsFixtures.response()),
        )).$1;
        container.read(routerProvider).go(AppRoutes.stats);
        await pumpUntilFound(tester, _key('stats-screen'));
        await tester.pumpAndSettle();

        final scorers = sport['tracks_scorers'] == true;
        expect(
          _key('stats-sort-goals'),
          scorers ? findsOneWidget : findsNothing,
        );
        if (scorers) {
          expect(
            find.descendant(
              of: _key('stats-sort-goals'),
              matching: find.text(terms['goals'] as String),
            ),
            findsOneWidget,
          );
          expect(
            find.descendant(
              of: _key('stats-sort-assists'),
              matching: find.text(terms['assists'] as String),
            ),
            findsOneWidget,
          );
        }
        expect(
          _key('stats-sort-minutes'),
          sport['tracks_playing_time'] == true ? findsOneWidget : findsNothing,
        );
        expect(
          _key('stats-sort-flagMinutes'),
          sport['supports_flag_duty'] == true ? findsOneWidget : findsNothing,
        );
        // Sam heeft één gele kaart: alleen zichtbaar als de sport geel kent.
        expect(
          _key('stats-yellow-14'),
          cards.contains('yellow') ? findsOneWidget : findsNothing,
        );
      });

      testWidgets('live: delen, kaarten en momenten uit het profiel', (
        tester,
      ) async {
        final sport = SportProfiles.of(key);
        final periods = sport['periods'] as Map<String, dynamic>;
        final boundaries = [
          for (final b in periods['boundaries'] as List) b as int,
        ];
        final cards = _values(sport, 'card_types');
        final moments = _values(sport, 'moment_types');
        final terms = sport['terms'] as Map<String, dynamic>;
        final response = LiveFixtures.response(
          sport: key,
          canManage: true,
          rules: _liveRules(sport),
          live: LiveFixtures.clock(
            running: true,
            period: 2,
            seconds: boundaries.isEmpty ? 600 : (boundaries.first + 3) * 60,
            periodEnds: boundaries,
          ),
          goals: sport['tracks_scorers'] == true ? null : const [],
          cards: cards.isEmpty
              ? const []
              : [LiveFixtures.card(type: cards.first)],
          moments: moments.contains('woodwork')
              ? [LiveFixtures.moment()]
              : const [],
        );

        final (container, _) = await _pump(
          tester,
          sport,
          (http) => http.on(LiveFixtures.get, 200, response),
        );
        unawaited(container.read(routerProvider).push('/events/412/live'));
        await pumpUntilFound(tester, _key('live-screen'));
        await tester.pumpAndSettle();

        // Het deel heet zoals het profiel het noemt (helft/kwart/set). Een
        // sport zonder deelgrenzen (geen live klok) blijft in deel 1.
        final period = boundaries.isEmpty ? 1 : 2;
        expect(
          _text(tester, 'live-period'),
          '${period}e ${(periods['label'] as String).toLowerCase()}',
        );
        if (cards.isNotEmpty) {
          final first = (sport['card_types'] as List).first as Map;
          final label = first['label'] as String;
          expect(find.text(label), findsWidgets);
        }

        await _tap(tester, _key('live-add'));
        final sheet = _key('live-add-sheet');
        expect(sheet, findsOneWidget);
        expect(
          find.descendant(
            of: sheet,
            matching: find.text(terms['goal'] as String),
          ),
          sport['tracks_scorers'] == true ? findsOneWidget : findsNothing,
        );
        if (cards.isNotEmpty || moments.isNotEmpty) {
          await _tap(tester, find.text('Overige'));
          for (final card in cards) {
            expect(_key('live-card-type-$card'), findsOneWidget, reason: card);
          }
          for (final moment in moments) {
            expect(_key('live-kind-$moment'), findsOneWidget, reason: moment);
          }
        } else {
          expect(find.text('Overige'), findsNothing);
        }

        Navigator.of(tester.element(sheet)).pop();
        await tester.pumpAndSettle();
        container.read(routerProvider).pop();
        await tester.pumpAndSettle();
      });

      testWidgets('team: linies en positienamen uit het profiel', (
        tester,
      ) async {
        final sport = SportProfiles.of(key);
        final positions = sport['positions'] as Map<String, dynamic>;
        final groups = [
          for (final g in sport['position_groups'] as List)
            g as Map<String, dynamic>,
        ];
        final players = [
          for (final (i, g) in groups.indexed)
            {
              ...RosterFixtures.sam(),
              'id': 100 + i,
              'name': 'Speler ${g['key']}',
              'position': (g['codes'] as List).first,
            },
        ];
        final container = (await _pump(
          tester,
          sport,
          (http) => http.on(
            'GET /teams/3/team',
            200,
            RosterFixtures.roster(players: players),
          ),
        )).$1;
        container.read(routerProvider).go(AppRoutes.team);
        await pumpUntilFound(tester, _key('team-screen'));
        await tester.pumpAndSettle();

        for (final (i, g) in groups.indexed) {
          final section = _key('roster-section-${g['key']}');
          expect(section, findsOneWidget, reason: '${g['key']}');
          expect(
            find.descendant(
              of: section,
              matching: find.text((g['label'] as String).toUpperCase()),
            ),
            findsOneWidget,
          );
          expect(
            find.descendant(
              of: section,
              matching: _key('roster-player-${100 + i}'),
            ),
            findsOneWidget,
          );
          final code = (g['codes'] as List).first as String;
          expect(
            find.descendant(
              of: _key('roster-player-${100 + i}'),
              matching: find.text(positions[code] as String),
            ),
            findsOneWidget,
          );
        }
        expect(_key('roster-section-other'), findsNothing);
      });

      testWidgets('verslag: scoremodel en blad volgen het profiel', (
        tester,
      ) async {
        final sport = SportProfiles.of(key);
        final sets = sport['score_model'] == 'sets';
        final postMatch = sport['match_stats_mode'] == 'postmatch';
        // Het verslag-antwoord draagt `score_model`/`stats_mode` uit het
        // profiel (MatchReportQuery); de rest is de standaardfixture.
        final data = {
          ...(sets ? ReportFixtures.setsData() : ReportFixtures.goalsData()),
          'score_model': sport['score_model'],
          'stats_mode': sport['match_stats_mode'],
        };
        final (container, _) = await _pump(
          tester,
          sport,
          (http) => http
            ..on(ReportFixtures.get, 200, ReportFixtures.wrap(data))
            ..on(ReportFixtures.eventGet, 200, ReportFixtures.eventDetail()),
        );
        unawaited(container.read(routerProvider).push('/events/412/report'));
        await pumpUntilFound(tester, _key('report-screen'));
        await tester.pumpAndSettle();

        expect(_key('report-sets'), sets ? findsOneWidget : findsNothing);
        expect(
          _key('report-stats-card'),
          postMatch ? findsOneWidget : findsNothing,
        );
        expect(
          _key('report-timeline-note'),
          postMatch ? findsNothing : findsOneWidget,
        );
      });
    });
  }
}
