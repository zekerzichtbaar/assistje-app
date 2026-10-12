import 'dart:convert';
import 'dart:typed_data';

import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'schedule_import_fixtures.dart';

const _sheet = ValueKey('schedule-import-sheet');

Future<void> _openSheet(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('agenda-schedule-import')));
  await tester.pumpAndSettle();
  expect(find.byKey(_sheet), findsOneWidget);
}

Future<void> _tapInSheet(WidgetTester tester, String key) async {
  final finder = find.byKey(ValueKey(key));
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('zonder ophalen: uitleg, zelf inplannen, doorgeven, bestand', (
    tester,
  ) async {
    await pumpImportApp(
      tester,
      membership: importTrainer(),
      agenda: importAgenda(),
    );
    await _openSheet(tester);

    expect(find.text('Wedstrijdprogramma'), findsOneWidget);
    expect(
      find.text(
        'Het programma van voetbal.nl staat achter een inlog, dus automatisch '
        'ophalen lukt niet. Zo komt het er wél in:',
      ),
      findsOneWidget,
    );
    expect(find.byKey(const ValueKey('schedule-import-fetch')), findsNothing);
    expect(find.byKey(const ValueKey('schedule-import-feed')), findsNothing);
    expect(find.text('Zet ze zelf in de agenda'), findsOneWidget);
    // Geen aanvraag mogelijk → "stuur het ons op".
    expect(find.byKey(const ValueKey('schedule-import-send')), findsOneWidget);
    expect(find.text('Programma doorgeven'), findsOneWidget);
    expect(find.text('Achter je computer: een bestand'), findsOneWidget);
    expect(
      find.textContaining(
        'als je het programma bij voetbal.nl kunt downloaden',
        findRichText: true,
      ),
      findsOneWidget,
    );
    // Importeer staat uit tot er een bestand is.
    final submit = tester.widget<PrimaryButton>(
      find.byKey(const ValueKey('schedule-import-submit')),
    );
    expect(submit.onPressed, isNull);
  });

  testWidgets('Wedstrijd inplannen sluit de sheet en opent het formulier', (
    tester,
  ) async {
    final (container, _, _) = await pumpImportApp(
      tester,
      membership: importTrainer(),
      agenda: importAgenda(),
    );
    await _openSheet(tester);
    await _tapInSheet(tester, 'schedule-import-plan-button');

    expect(find.byKey(_sheet), findsNothing);
    expect(container.read(routerProvider).state.uri.path, AppRoutes.schedule);
  });

  testWidgets('Programma doorgeven gaat naar feedback', (tester) async {
    final (container, _, _) = await pumpImportApp(
      tester,
      membership: importTrainer(),
      agenda: importAgenda(),
      setup: (http) =>
          http.on('GET /teams/3/feedback', 200, {'data': <Object>[]}),
    );
    await _openSheet(tester);
    await _tapInSheet(tester, 'schedule-import-send-link');

    expect(find.byKey(_sheet), findsNothing);
    expect(container.read(routerProvider).state.uri.path, AppRoutes.feedback);
  });

  testWidgets('ophalen: bijwerken, melding, sheet dicht, agenda ververst', (
    tester,
  ) async {
    final (_, http, _) = await pumpImportApp(
      tester,
      membership: importTrainer(),
      agenda: importAgenda(canFetch: true),
      setup: (http) => http.on(
        'POST /teams/3/schedule/fetch',
        202,
        ScheduleImportFixtures.fetchResponse(),
      ),
    );
    await _openSheet(tester);
    expect(find.text('Wij halen het op'), findsOneWidget);
    expect(
      find.textContaining('We zetten het programma van voetbal.nl'),
      findsOneWidget,
    );
    final agendaCalls = http.requestsTo('GET /teams/3/agenda').length;

    await _tapInSheet(tester, 'schedule-import-fetch-button');

    expect(http.requestsTo('POST /teams/3/schedule/fetch'), hasLength(1));
    expect(find.byKey(_sheet), findsNothing);
    expect(find.text(ScheduleImportFixtures.fetchMessage), findsOneWidget);
    expect(
      http.requestsTo('GET /teams/3/agenda').length,
      greaterThan(agendaCalls),
    );
  });

  testWidgets('ophalen geweigerd: fout in de sheet', (tester) async {
    await pumpImportApp(
      tester,
      membership: importTrainer(),
      agenda: importAgenda(canFetch: true),
      setup: (http) => http.on('POST /teams/3/schedule/fetch', 422, {
        'message': 'Programma ophalen staat niet aan.',
        'errors': {
          'schedule': [
            'Programma ophalen staat niet aan. Vraag ons om het programma '
                'erbij te zetten.',
          ],
        },
      }),
    );
    await _openSheet(tester);
    await _tapInSheet(tester, 'schedule-import-fetch-button');

    expect(find.byKey(_sheet), findsOneWidget);
    expect(
      find.text(
        'Programma ophalen staat niet aan. Vraag ons om het programma erbij '
        'te zetten.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('Doe dat voor mij: verzoek, melding, sheet dicht', (
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
    await _openSheet(tester);
    expect(
      find.byKey(const ValueKey('schedule-import-request')),
      findsOneWidget,
    );
    await _tapInSheet(tester, 'schedule-import-request-button');

    expect(http.requestsTo('POST /teams/3/schedule/request'), hasLength(1));
    expect(find.byKey(_sheet), findsNothing);
    expect(find.text(ScheduleImportFixtures.requestMessage), findsOneWidget);
  });

  testWidgets('verzoek staat al open (409): melding in de sheet', (
    tester,
  ) async {
    await pumpImportApp(
      tester,
      membership: importTrainer(),
      agenda: importAgenda(request: 'available'),
      setup: (http) => http.on('POST /teams/3/schedule/request', 409, {
        'message': ScheduleImportFixtures.conflictMessage,
      }),
    );
    await _openSheet(tester);
    await _tapInSheet(tester, 'schedule-import-request-button');

    expect(find.byKey(_sheet), findsOneWidget);
    expect(find.text(ScheduleImportFixtures.conflictMessage), findsOneWidget);
  });

  testWidgets('verzoek loopt al: geen knop, wel de stand', (tester) async {
    await pumpImportApp(
      tester,
      membership: importTrainer(),
      agenda: importAgenda(request: 'pending'),
    );
    await _openSheet(tester);
    expect(
      find.byKey(const ValueKey('schedule-import-request-pending')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('schedule-import-request-button')),
      findsNothing,
    );
  });

  testWidgets('agendalink: mislukte link, nieuwe plakken, opslaan', (
    tester,
  ) async {
    const oldUrl = 'https://api.nevobo.nl/export/oud.ics';
    final (_, http, _) = await pumpImportApp(
      tester,
      membership: importTrainer(
        federation: {
          'method': 'feed',
          'name': 'volleybal.nl',
          'hint': 'Te vinden bij je team.',
          'example': 'https://api.nevobo.nl/export/team/CKL8Y9N/programma.ics',
        },
      ),
      agenda: importAgenda(feed: {'url': oldUrl, 'failed': true}),
      setup: (http) => http.on(
        'POST /teams/3/schedule/feed',
        200,
        ScheduleImportFixtures.feedResponse(),
      ),
    );
    await _openSheet(tester);

    expect(find.text('Je agendalink'), findsOneWidget);
    expect(
      find.text(
        'Eén link en het programma staat erin. Verzette wedstrijden schuiven '
        'daarna vanzelf mee. Te vinden bij je team.',
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('schedule-import-feed-failed')),
      findsOneWidget,
    );
    // Feed-sport zonder aanvraag: de doorgeef-tekst noemt de agendalink.
    expect(find.textContaining('Vind je de agendalink niet?'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('schedule-import-feed-url')),
      ScheduleImportFixtures.feedUrl,
    );
    await tester.pumpAndSettle();
    expect(
      find.byKey(const ValueKey('schedule-import-feed-failed')),
      findsNothing,
    );

    await _tapInSheet(tester, 'schedule-import-feed-button');

    expect(http.requestsTo('POST /teams/3/schedule/feed').single.body, {
      'schedule_feed_url': ScheduleImportFixtures.feedUrl,
    });
    expect(find.byKey(_sheet), findsNothing);
    expect(find.text(ScheduleImportFixtures.feedMessage), findsOneWidget);
  });

  testWidgets('agendalink geweigerd: veldfout onder het veld', (tester) async {
    await pumpImportApp(
      tester,
      membership: importTrainer(federation: null),
      agenda: importAgenda(feed: {'url': null, 'failed': false}),
      setup: (http) => http.on('POST /teams/3/schedule/feed', 422, {
        'message': 'Plak de hele link, die begint met https://.',
        'errors': {
          'schedule_feed_url': ['Plak de hele link, die begint met https://.'],
        },
      }),
    );
    await _openSheet(tester);
    expect(find.text('Plak de agendalink'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('schedule-import-feed-url')),
      'nevobo',
    );
    await tester.pumpAndSettle();
    await _tapInSheet(tester, 'schedule-import-feed-button');

    expect(find.byKey(_sheet), findsOneWidget);
    expect(
      find.text('Plak de hele link, die begint met https://.'),
      findsOneWidget,
    );
  });

  testWidgets('bestand: proefimport blijft open, daarna echt importeren', (
    tester,
  ) async {
    final picker = FakeScheduleFilePicker((
      name: 'programma.csv',
      bytes: Uint8List.fromList(utf8.encode('datum,tijd,wedstrijd')),
    ));
    final (_, _, raw) = await pumpImportApp(
      tester,
      membership: importTrainer(),
      agenda: importAgenda(),
      picker: picker,
    );
    await _openSheet(tester);

    await _tapInSheet(tester, 'schedule-import-pick');
    expect(picker.picks, 1);
    expect(find.text('programma.csv'), findsOneWidget);

    await _tapInSheet(tester, 'schedule-import-dry-run');
    raw.respond(200, ScheduleImportFixtures.importResponse(dryRun: true));
    await _tapInSheet(tester, 'schedule-import-submit');

    expect(raw.calls, 1);
    expect(raw.options!.uri.path, '/api/v1/teams/3/schedule/import');
    expect(raw.body, contains('filename="programma.csv"'));
    expect(raw.body, contains('name="dry_run"\r\n\r\n1'));
    expect(find.byKey(_sheet), findsOneWidget);
    expect(
      find.byKey(const ValueKey('schedule-import-dry-run-result')),
      findsOneWidget,
    );
    expect(find.text(ScheduleImportFixtures.importMessage), findsOneWidget);

    // Vinkje uit en echt importeren.
    await _tapInSheet(tester, 'schedule-import-dry-run');
    raw.respond(200, ScheduleImportFixtures.importResponse());
    await _tapInSheet(tester, 'schedule-import-submit');

    expect(raw.calls, 2);
    expect(raw.body, contains('name="dry_run"\r\n\r\n0'));
    expect(find.byKey(_sheet), findsNothing);
    expect(find.text(ScheduleImportFixtures.importMessage), findsOneWidget);
  });

  testWidgets('bestand geweigerd: veldfout in de sheet', (tester) async {
    final (_, _, raw) = await pumpImportApp(
      tester,
      membership: importTrainer(),
      agenda: importAgenda(),
      picker: FakeScheduleFilePicker((
        name: 'leeg.ics',
        bytes: Uint8List.fromList([1]),
      )),
    );
    raw.respond(422, {
      'message': 'Geen wedstrijden gevonden.',
      'errors': {
        'file': ['Geen wedstrijden gevonden.'],
      },
    });
    await _openSheet(tester);
    await _tapInSheet(tester, 'schedule-import-pick');
    await _tapInSheet(tester, 'schedule-import-submit');

    expect(find.byKey(_sheet), findsOneWidget);
    expect(find.text('Geen wedstrijden gevonden.'), findsOneWidget);
  });
}
