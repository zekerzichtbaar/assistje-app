import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../schedule/schedule_import_fixtures.dart';

const _button = ValueKey('agenda-schedule-import');
const _signpost = ValueKey('agenda-schedule-signpost');
const _sheet = ValueKey('schedule-import-sheet');

void main() {
  group('wie het ziet', () {
    testWidgets('speler: geen programmaknop, geen wegwijzer, geen actie', (
      tester,
    ) async {
      await pumpImportApp(
        tester,
        membership: importTrainer(role: 'player'),
        agenda: importAgenda(needsSchedule: true, request: 'available'),
      );
      expect(find.byKey(_button), findsNothing);
      expect(find.byKey(_signpost), findsNothing);
      expect(find.text('Nog niets gepland'), findsOneWidget);
      expect(find.byKey(const ValueKey('agenda-empty-schedule')), findsNothing);
      expect(find.byKey(const ValueKey('agenda-empty-request')), findsNothing);
    });

    testWidgets('speler ziet de wegwijzer ook niet bij een volle agenda', (
      tester,
    ) async {
      await pumpImportApp(
        tester,
        membership: importTrainer(role: 'player'),
        agenda: importAgenda(empty: false, needsSchedule: true),
      );
      expect(find.byKey(_signpost), findsNothing);
    });

    testWidgets('demo-trainer: geen programmaknop', (tester) async {
      await pumpImportApp(
        tester,
        membership: importTrainer(demo: true),
        agenda: importAgenda(),
      );
      expect(find.byKey(_button), findsNothing);
      expect(find.byKey(const ValueKey('agenda-empty-schedule')), findsNothing);
    });

    testWidgets('trainer: knop opent de sheet', (tester) async {
      await pumpImportApp(
        tester,
        membership: importTrainer(),
        agenda: importAgenda(empty: false),
      );
      await tester.tap(find.byKey(_button));
      await tester.pumpAndSettle();
      expect(find.byKey(_sheet), findsOneWidget);
    });
  });

  group('lege agenda (trainer)', () {
    testWidgets('zonder aanbod: Programma erbij opent de sheet', (
      tester,
    ) async {
      await pumpImportApp(
        tester,
        membership: importTrainer(),
        agenda: importAgenda(),
      );
      expect(find.text('Nog niets gepland'), findsOneWidget);
      expect(
        find.text(
          'Zet je eerste wedstrijd of training erbij, of haal het hele '
          'programma in één keer binnen.',
        ),
        findsOneWidget,
      );
      await tester.tap(find.byKey(const ValueKey('agenda-empty-schedule')));
      await tester.pumpAndSettle();
      expect(find.byKey(_sheet), findsOneWidget);
    });

    testWidgets('met aanbod: Doe dat voor mij vraagt het meteen aan', (
      tester,
    ) async {
      final (_, http, _) = await pumpImportApp(
        tester,
        membership: importTrainer(),
        agenda: importAgenda(request: 'available'),
        setup: (http) => http.on(
          'POST /teams/3/schedule/request',
          201,
          ScheduleImportFixtures.requestResponse(),
        ),
      );
      expect(find.text('Wij zetten het programma erin'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('agenda-empty-request')));
      await tester.pumpAndSettle();

      expect(http.requestsTo('POST /teams/3/schedule/request'), hasLength(1));
      expect(find.text(ScheduleImportFixtures.requestMessage), findsOneWidget);
    });

    testWidgets('verzoek al open (409) komt als fouttoast', (tester) async {
      await pumpImportApp(
        tester,
        membership: importTrainer(),
        agenda: importAgenda(request: 'available'),
        setup: (http) => http.on('POST /teams/3/schedule/request', 409, {
          'message': ScheduleImportFixtures.conflictMessage,
        }),
      );
      await tester.tap(find.byKey(const ValueKey('agenda-empty-request')));
      await tester.pumpAndSettle();
      expect(find.text(ScheduleImportFixtures.conflictMessage), findsOneWidget);
    });

    testWidgets('verzoek loopt: stand en Zelf inplannen', (tester) async {
      final (container, _, _) = await pumpImportApp(
        tester,
        membership: importTrainer(),
        agenda: importAgenda(request: 'pending'),
      );
      expect(
        find.byKey(const ValueKey('agenda-schedule-pending')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('agenda-empty-request')), findsNothing);

      await tester.tap(find.byKey(const ValueKey('agenda-plan-self')));
      await tester.pumpAndSettle();
      expect(container.read(routerProvider).state.uri.path, AppRoutes.schedule);
    });
  });

  group('wegwijzer (trainer, needs_schedule, trainingen staan er)', () {
    testWidgets('zonder aanbod: Programma erbij opent de sheet', (
      tester,
    ) async {
      await pumpImportApp(
        tester,
        membership: importTrainer(),
        agenda: importAgenda(empty: false, needsSchedule: true),
      );
      expect(find.byKey(_signpost), findsOneWidget);
      expect(
        find.text('Je trainingen staan er, de wedstrijden nog niet'),
        findsOneWidget,
      );
      expect(find.text('Programma erbij'), findsOneWidget);
      await tester.tap(
        find.byKey(const ValueKey('agenda-schedule-signpost-button')),
      );
      await tester.pumpAndSettle();
      expect(find.byKey(_sheet), findsOneWidget);
    });

    testWidgets('mislukte agendalink: Link controleren', (tester) async {
      await pumpImportApp(
        tester,
        membership: importTrainer(),
        agenda: importAgenda(
          empty: false,
          needsSchedule: true,
          feed: {'url': 'https://x.test/a.ics', 'failed': true},
        ),
      );
      expect(find.text('Je agendalink gaf geen wedstrijden'), findsOneWidget);
      expect(find.text('Link controleren'), findsOneWidget);
    });

    testWidgets('feed-sport: Agendalink plakken', (tester) async {
      await pumpImportApp(
        tester,
        membership: importTrainer(),
        agenda: importAgenda(
          empty: false,
          needsSchedule: true,
          feed: {'url': null, 'failed': false},
        ),
      );
      expect(find.text('Agendalink plakken'), findsOneWidget);
    });

    testWidgets('met aanbod: Doe dat voor mij', (tester) async {
      final (_, http, _) = await pumpImportApp(
        tester,
        membership: importTrainer(),
        agenda: importAgenda(
          empty: false,
          needsSchedule: true,
          request: 'available',
        ),
        setup: (http) => http.on(
          'POST /teams/3/schedule/request',
          201,
          ScheduleImportFixtures.requestResponse(),
        ),
      );
      expect(find.byKey(const ValueKey('agenda-plan-self')), findsOneWidget);
      await tester.tap(
        find.byKey(const ValueKey('agenda-schedule-signpost-button')),
      );
      await tester.pumpAndSettle();
      expect(http.requestsTo('POST /teams/3/schedule/request'), hasLength(1));
    });

    testWidgets('niet zonder needs_schedule', (tester) async {
      await pumpImportApp(
        tester,
        membership: importTrainer(),
        agenda: importAgenda(empty: false),
      );
      expect(find.byKey(_signpost), findsNothing);
    });
  });
}
