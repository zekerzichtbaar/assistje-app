import 'dart:async';

import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import 'fines_fixtures.dart';

const _overview = 'GET /teams/3/fines';

final Map<String, dynamic> _player = ApiFixtures.membership(
  features: {'fines': true},
);
final Map<String, dynamic> _treasurer = ApiFixtures.membership(
  abilities: ['fines'],
  features: {'fines': true},
);

Future<FakeHttpAdapter> _open(
  WidgetTester tester, {
  required Map<String, dynamic> membership,
  Map<String, dynamic>? overview,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [membership],
    setup: (http) {
      http.on(_overview, 200, overview ?? FinesFixtures.treasurerOverview());
      setup?.call(http);
    },
  );
  unawaited(container.read(routerProvider).push(AppRoutes.fines));
  await pumpUntilFound(tester, find.byKey(const ValueKey('fines-screen')));
  await tester.pumpAndSettle();
  return backend.http;
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _manage(WidgetTester tester, String action) async {
  await _tap(tester, find.byKey(const ValueKey('fines-manage')));
  await _tap(tester, find.byKey(ValueKey(action)));
}

void main() {
  testWidgets('speler ziet geen beheer en geen afsluiten', (tester) async {
    await _open(
      tester,
      membership: _player,
      overview: FinesFixtures.overview(),
    );

    expect(find.byKey(const ValueKey('fines-summary')), findsOneWidget);
    expect(find.byKey(const ValueKey('fines-manage')), findsNothing);
    expect(find.byKey(const ValueKey('fines-close-period')), findsNothing);
    final dates = tester.widget<Text>(
      find.byKey(const ValueKey('fines-period-dates')),
    );
    expect(dates.data, startsWith('loopt sinds 1 okt'));
  });

  group('penningmeester', () {
    testWidgets('periode afsluiten na bevestiging', (tester) async {
      final http = await _open(
        tester,
        membership: _treasurer,
        setup: (http) => http.on(
          'POST /teams/3/fine-periods/7/close',
          200,
          FinesFixtures.closeResponse(),
        ),
      );
      expect(find.byKey(const ValueKey('fines-manage')), findsOneWidget);

      await _tap(tester, find.byKey(const ValueKey('fines-close-period')));
      expect(find.textContaining('Periode "Q4 2026" afsluiten?'), findsOne);
      await _tap(tester, find.byKey(const ValueKey('fines-confirm-cancel')));
      expect(http.requestsTo('POST /teams/3/fine-periods/7/close'), isEmpty);

      http.on(
        _overview,
        200,
        FinesFixtures.treasurerOverview({
          'period': {
            'id': 9,
            'name': 'Q1 2027',
            'starts_on': '2027-01-01',
            'closed_at': null,
          },
        }),
      );
      await _tap(tester, find.byKey(const ValueKey('fines-close-period')));
      await _tap(tester, find.byKey(const ValueKey('fines-confirm-ok')));

      expect(
        http.requestsTo('POST /teams/3/fine-periods/7/close'),
        hasLength(1),
      );
      expect(find.text('Periode afgesloten'), findsOneWidget);
      expect(find.text('Deze periode · Q1 2027'), findsOneWidget);
    });

    testWidgets('nieuwe periode: leeg, 422 in de sheet, dan gelukt', (
      tester,
    ) async {
      final http = await _open(
        tester,
        membership: _treasurer,
        setup: (http) => http.on('POST /teams/3/fine-periods', 422, {
          'message': 'Die naam is te lang.',
          'errors': {
            'name': ['Die naam is te lang.'],
          },
        }),
      );

      await _manage(tester, 'fines-manage-new-period');
      await _tap(tester, find.byKey(const ValueKey('period-form-submit')));
      expect(find.text('Vul een naam in.'), findsOneWidget);
      expect(http.requestsTo('POST /teams/3/fine-periods'), isEmpty);

      await tester.enterText(
        find.byKey(const ValueKey('period-form-name')),
        'Voorjaar 2027',
      );
      await _tap(tester, find.byKey(const ValueKey('period-form-submit')));
      expect(find.text('Die naam is te lang.'), findsOneWidget);
      expect(find.byKey(const ValueKey('period-form-submit')), findsOneWidget);

      http
        ..on('POST /teams/3/fine-periods', 201, FinesFixtures.periodResponse())
        ..on(
          _overview,
          200,
          FinesFixtures.treasurerOverview({'period': FinesFixtures.period8()}),
        );
      await _tap(tester, find.byKey(const ValueKey('period-form-submit')));

      expect(http.requestsTo('POST /teams/3/fine-periods').last.body, {
        'name': 'Voorjaar 2027',
      });
      expect(find.byKey(const ValueKey('period-form-submit')), findsNothing);
      expect(find.text('Nieuwe periode gestart'), findsOneWidget);
      expect(find.text('Deze periode · Voorjaar 2027'), findsOneWidget);
    });

    testWidgets('periode hernoemen: voorgevuld, PATCH', (tester) async {
      final http = await _open(
        tester,
        membership: _treasurer,
        setup: (http) => http.on(
          'PATCH /teams/3/fine-periods/7',
          200,
          FinesFixtures.periodResponse({'id': 7, 'name': 'Najaar 2026'}),
        ),
      );

      await _manage(tester, 'fines-manage-rename');
      final field = tester.widget<TextField>(
        find.byKey(const ValueKey('period-form-name')),
      );
      expect(field.controller!.text, 'Q4 2026');
      await tester.enterText(
        find.byKey(const ValueKey('period-form-name')),
        'Najaar 2026',
      );
      await _tap(tester, find.byKey(const ValueKey('period-form-submit')));

      expect(http.requestsTo('PATCH /teams/3/fine-periods/7').single.body, {
        'name': 'Najaar 2026',
      });
      expect(find.text('Opgeslagen'), findsOneWidget);
    });

    testWidgets('boetes beheren: bedragen, aan/uit, toevoegen, weghalen', (
      tester,
    ) async {
      final http = await _open(
        tester,
        membership: _treasurer,
        setup: (http) => http
          ..on(
            'PATCH /teams/3/fine-settings',
            200,
            FinesFixtures.settingsResponse(),
          )
          ..on(
            'PATCH /teams/3/fine-types/31',
            200,
            FinesFixtures.fineTypeResponse(id: 31, archived: true),
          )
          ..on(
            'POST /teams/3/fine-types',
            201,
            FinesFixtures.fineTypeResponse(),
          )
          ..on('DELETE /teams/3/fine-types/35', 200, {
            'data': {'id': 35, 'archived': true},
          }),
      );

      await _manage(tester, 'fines-manage-types');
      expect(find.byKey(const ValueKey('fine-types-sheet')), findsOneWidget);
      expect(find.text('AUTOMATISCH'), findsOneWidget);
      expect(find.text('ZELF UITDELEN'), findsOneWidget);
      // Automatische soort: aan/uit, niet weghalen.
      expect(find.byKey(const ValueKey('fine-type-toggle-31')), findsOne);
      expect(find.byKey(const ValueKey('fine-type-delete-31')), findsNothing);
      expect(find.byKey(const ValueKey('fine-type-delete-35')), findsOne);

      // Aan/uit gaat meteen.
      await _tap(tester, find.byKey(const ValueKey('fine-type-toggle-31')));
      expect(http.requestsTo('PATCH /teams/3/fine-types/31').single.body, {
        'active': false,
      });

      // Toevoegen via een eigen sheet.
      await _tap(tester, find.byKey(const ValueKey('fine-types-add')));
      await tester.enterText(
        find.byKey(const ValueKey('fine-type-form-label')),
        'Douchen overgeslagen',
      );
      await _tap(tester, find.byKey(const ValueKey('fine-type-form-submit')));
      expect(http.requestsTo('POST /teams/3/fine-types').single.body, {
        'label': 'Douchen overgeslagen',
        'amount_cents': 500,
      });
      expect(find.byKey(const ValueKey('fine-type-form-submit')), findsNothing);

      // Weghalen met bevestiging.
      await _tap(tester, find.byKey(const ValueKey('fine-type-delete-35')));
      await _tap(tester, find.byKey(const ValueKey('fines-confirm-ok')));
      expect(http.requestsTo('DELETE /teams/3/fine-types/35'), hasLength(1));
      expect(find.text('Uit de lijst gehaald'), findsOneWidget);

      // Ongeldig bedrag: melding, geen verzoek.
      await tester.enterText(
        find.byKey(const ValueKey('fine-type-amount-35')),
        'veel',
      );
      await _tap(tester, find.byKey(const ValueKey('fine-types-save')));
      expect(find.byKey(const ValueKey('fine-types-invalid')), findsOneWidget);
      expect(http.requestsTo('PATCH /teams/3/fine-settings'), isEmpty);

      await tester.enterText(
        find.byKey(const ValueKey('fine-type-amount-35')),
        '1,50',
      );
      await _tap(tester, find.byKey(const ValueKey('fine-types-save')));
      expect(http.requestsTo('PATCH /teams/3/fine-settings').single.body, {
        'amounts': {'31': 250, '35': 150},
      });
      expect(find.byKey(const ValueKey('fine-types-sheet')), findsNothing);
      expect(find.text('Opgeslagen'), findsOneWidget);
    });

    testWidgets('403 bij opslaan: sheet dicht met alleen-lezen-melding', (
      tester,
    ) async {
      await _open(
        tester,
        membership: _treasurer,
        setup: (http) => http.on('PATCH /teams/3/fine-settings', 403, {
          'message': 'Geen toegang.',
        }),
      );

      await _manage(tester, 'fines-manage-types');
      await _tap(tester, find.byKey(const ValueKey('fine-types-save')));

      expect(find.byKey(const ValueKey('fine-types-sheet')), findsNothing);
      expect(
        find.text('Alleen de penningmeester kan dit aanpassen.'),
        findsOneWidget,
      );
    });
  });
}
