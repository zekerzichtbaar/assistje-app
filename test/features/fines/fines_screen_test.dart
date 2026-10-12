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
import 'fines_fixtures.dart';

const _overview = 'GET /teams/3/fines';
const _player17 = 'GET /teams/3/fines/players/17';

final Map<String, dynamic> _player = ApiFixtures.membership(
  features: {'fines': true},
);
final Map<String, dynamic> _treasurer = ApiFixtures.membership(
  abilities: ['fines'],
  features: {'fines': true},
);

/// Start ingelogd als [membership], zet het overzicht klaar en opent
/// `/fines`.
Future<(ProviderContainer, FakeHttpAdapter)> _open(
  WidgetTester tester, {
  required Map<String, dynamic> membership,
  Map<String, dynamic>? overview,
  void Function(FakeHttpAdapter http)? setup,
}) async {
  final (container, backend) = await pumpSignedIn(
    tester,
    teams: [membership],
    setup: (http) {
      http.on(_overview, 200, overview ?? FinesFixtures.overview());
      setup?.call(http);
    },
  );
  unawaited(container.read(routerProvider).push(AppRoutes.fines));
  await pumpUntilFound(tester, find.byKey(const ValueKey('fines-screen')));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

String _text(WidgetTester tester, String key) =>
    (tester.widget<Text>(find.byKey(ValueKey(key))).data ?? '').replaceAll(
      ' ',
      ' ',
    );

void main() {
  testWidgets('speler: pot, totalen, personen en potregels; geen acties', (
    tester,
  ) async {
    await _open(
      tester,
      membership: _player,
      setup: (http) => http.on(_player17, 200, FinesFixtures.player()),
    );

    expect(find.text('Boetepot'), findsOneWidget);
    expect(_text(tester, 'fines-balance'), '€ 37,50');
    expect(_text(tester, 'fines-open'), '€ 2,50');
    expect(_text(tester, 'fines-period-totals'), '€ 7,50 totaal · € 2,50 open');
    expect(find.byKey(const ValueKey('fines-row-p17')), findsOneWidget);
    expect(find.byKey(const ValueKey('fines-row-u4')), findsOneWidget);
    expect(find.text('2 boetes'), findsOneWidget);
    expect(find.text('Geen boetes · Staf'), findsOneWidget);
    expect(find.byKey(const ValueKey('pot-line-entry-12')), findsOneWidget);
    expect(find.text('Krat bier'), findsOneWidget);
    expect(find.byKey(const ValueKey('fines-period-6')), findsOneWidget);
    expect(find.text('Q3 2026 (afgesloten)'), findsOneWidget);

    // Geen schrijfacties voor een gewone speler.
    expect(find.byKey(const ValueKey('fines-give')), findsNothing);
    expect(find.byKey(const ValueKey('fines-add-pot')), findsNothing);

    // Potregel tikken doet niets.
    await _tap(tester, find.byKey(const ValueKey('pot-line-entry-12')));
    expect(find.byKey(const ValueKey('pot-form-save')), findsNothing);

    // Detail: de boetes van Sam, zonder bewerken.
    await _tap(tester, find.byKey(const ValueKey('fines-row-p17')));
    expect(find.byKey(const ValueKey('person-fines-sheet')), findsOneWidget);
    expect(find.byKey(const ValueKey('fine-501')), findsOneWidget);
    expect(find.text('Te laat'), findsOneWidget);
    expect(find.text('OPEN'), findsOneWidget);
    expect(find.byKey(const ValueKey('person-fines-give')), findsNothing);
    await _tap(tester, find.byKey(const ValueKey('fine-501')));
    expect(find.byKey(const ValueKey('fine-edit-save')), findsNothing);
  });

  testWidgets('leeg overzicht toont de lege staat', (tester) async {
    await _open(
      tester,
      membership: _player,
      overview: FinesFixtures.overview({
        'rows': <Object>[],
        'periods': [
          {'id': 7, 'name': 'Q4 2026', 'closed_at': null},
        ],
        'pot': {'balance_cents': 0, 'open_cents': 0, 'lines': <Object>[]},
      }),
    );

    expect(find.byKey(const ValueKey('fines-empty')), findsOneWidget);
    expect(find.text('Nog niemand in de boetepot'), findsOneWidget);
    expect(find.byKey(const ValueKey('fines-pot-empty')), findsOneWidget);
    // Eén periode: geen kiezer.
    expect(find.byKey(const ValueKey('fines-periods')), findsNothing);
  });

  testWidgets('fout met opnieuw proberen', (tester) async {
    final (_, http) = await _open(
      tester,
      membership: _player,
      setup: (http) => http.on(_overview, 500, {'message': 'Kapot'}),
    );

    expect(find.byKey(const ValueKey('fines-error')), findsOneWidget);
    expect(find.text('Boetepot laden mislukt'), findsOneWidget);
    expect(find.text('Kapot'), findsOneWidget);

    http.on(_overview, 200, FinesFixtures.overview());
    await _tap(tester, find.byKey(const ValueKey('fines-retry')));

    expect(find.byKey(const ValueKey('fines-error')), findsNothing);
    expect(find.byKey(const ValueKey('fines-row-p17')), findsOneWidget);
  });

  testWidgets('periode wisselen haalt ?period= op', (tester) async {
    final (_, http) = await _open(tester, membership: _player);

    http.on(
      _overview,
      200,
      FinesFixtures.overview({
        'period': {
          'id': 6,
          'name': 'Q3 2026',
          'closed_at': '2026-09-30T21:14:03+02:00',
        },
        'totals': {'open_cents': 0, 'all_cents': 1200},
      }),
    );
    await _tap(tester, find.byKey(const ValueKey('fines-period-6')));

    expect(http.requests.last.options.uri.queryParameters, {'period': '6'});
    expect(
      _text(tester, 'fines-period-totals'),
      '€ 12,00 totaal · € 0,00 open',
    );
  });

  group('penningmeester', () {
    testWidgets('boete uitdelen: kiezen, bedrag uit de soort, POST', (
      tester,
    ) async {
      final (_, http) = await _open(
        tester,
        membership: _treasurer,
        overview: FinesFixtures.treasurerOverview(),
        setup: (http) =>
            http.on('POST /teams/3/fines', 201, FinesFixtures.recorded()),
      );
      expect(find.byKey(const ValueKey('fines-add-pot')), findsOneWidget);

      await _tap(tester, find.byKey(const ValueKey('fines-give')));
      // Zonder keuze: meldingen, geen verzoek.
      await _tap(tester, find.byKey(const ValueKey('fine-form-submit')));
      expect(find.byKey(const ValueKey('fine-form-no-person')), findsOneWidget);
      expect(find.byKey(const ValueKey('fine-form-no-type')), findsOneWidget);
      expect(http.requestsTo('POST /teams/3/fines'), isEmpty);

      await _tap(tester, find.byKey(const ValueKey('fine-form-person-p17')));
      await _tap(tester, find.byKey(const ValueKey('fine-form-type-35')));
      final amount = tester.widget<TextField>(
        find.byKey(const ValueKey('fine-form-amount')),
      );
      expect(amount.controller!.text, '1,00');
      await tester.enterText(
        find.byKey(const ValueKey('fine-form-description')),
        'Tas vergeten',
      );
      await _tap(tester, find.byKey(const ValueKey('fine-form-submit')));

      expect(http.requestsTo('POST /teams/3/fines').single.body, {
        'player_id': 17,
        'type': 35,
        'amount_cents': 100,
        'description': 'Tas vergeten',
      });
      expect(find.byKey(const ValueKey('fine-form-submit')), findsNothing);
      expect(find.text('2 boetes uitgedeeld'), findsOneWidget);
      // Na schrijven opnieuw opgehaald.
      expect(http.requestsTo(_overview), hasLength(2));
    });

    testWidgets('422 van de server blijft in het formulier staan', (
      tester,
    ) async {
      await _open(
        tester,
        membership: _treasurer,
        overview: FinesFixtures.treasurerOverview(),
        setup: (http) => http.on('POST /teams/3/fines', 422, {
          'message': 'Periode is afgesloten.',
        }),
      );

      await _tap(tester, find.byKey(const ValueKey('fines-give')));
      await _tap(tester, find.byKey(const ValueKey('fine-form-everyone')));
      await _tap(tester, find.byKey(const ValueKey('fine-form-type-31')));
      await _tap(tester, find.byKey(const ValueKey('fine-form-submit')));

      expect(find.byKey(const ValueKey('fine-form-error')), findsOneWidget);
      expect(find.text('Periode is afgesloten.'), findsOneWidget);
      expect(find.byKey(const ValueKey('fine-form-submit')), findsOneWidget);
    });

    testWidgets('boete in het detail op betaald zetten en verwijderen', (
      tester,
    ) async {
      final (_, http) = await _open(
        tester,
        membership: _treasurer,
        overview: FinesFixtures.treasurerOverview(),
        setup: (http) => http
          ..on(_player17, 200, FinesFixtures.player(canManage: true))
          ..on('PATCH /teams/3/fines/501', 200, FinesFixtures.updated())
          ..on('DELETE /teams/3/fines/501', 204),
      );

      await _tap(tester, find.byKey(const ValueKey('fines-row-p17')));
      expect(find.byKey(const ValueKey('person-fines-give')), findsOneWidget);
      await _tap(tester, find.byKey(const ValueKey('fine-501')));
      await _tap(tester, find.text('Betaald'));
      await _tap(tester, find.byKey(const ValueKey('fine-edit-save')));

      expect(http.requestsTo('PATCH /teams/3/fines/501').single.body, {
        'amount_cents': 250,
        'description': null,
        'status': 'paid',
      });
      expect(find.byKey(const ValueKey('fine-edit-save')), findsNothing);
      // Detail is opnieuw opgehaald.
      expect(http.requestsTo(_player17), hasLength(2));

      await _tap(tester, find.byKey(const ValueKey('fine-501')));
      await _tap(tester, find.byKey(const ValueKey('fine-edit-delete')));
      // Eerst bevestigen; annuleren doet niets.
      await _tap(tester, find.byKey(const ValueKey('fines-delete-cancel')));
      expect(http.requestsTo('DELETE /teams/3/fines/501'), isEmpty);
      await _tap(tester, find.byKey(const ValueKey('fine-edit-delete')));
      await _tap(tester, find.byKey(const ValueKey('fines-delete-confirm')));
      expect(http.requestsTo('DELETE /teams/3/fines/501'), hasLength(1));
      expect(find.text('Verwijderd'), findsOneWidget);
    });

    testWidgets('potboeking toevoegen, bewerken en verwijderen', (
      tester,
    ) async {
      final (_, http) = await _open(
        tester,
        membership: _treasurer,
        overview: FinesFixtures.treasurerOverview(),
        setup: (http) => http
          ..on('POST /teams/3/fine-pot', 201, FinesFixtures.potEntryResponse())
          ..on(
            'PATCH /teams/3/fine-pot/12',
            200,
            FinesFixtures.potEntryResponse(),
          )
          ..on('DELETE /teams/3/fine-pot/12', 204),
      );

      await _tap(tester, find.byKey(const ValueKey('fines-add-pot')));
      // Leeg opslaan: meldingen, geen verzoek.
      await _tap(tester, find.byKey(const ValueKey('pot-form-save')));
      expect(find.text('Vul een omschrijving in.'), findsOneWidget);
      expect(http.requestsTo('POST /teams/3/fine-pot'), isEmpty);

      await _tap(tester, find.text('Eruit'));
      await tester.enterText(
        find.byKey(const ValueKey('pot-form-amount')),
        '12,50',
      );
      await tester.enterText(
        find.byKey(const ValueKey('pot-form-description')),
        'Krat bier',
      );
      await _tap(tester, find.byKey(const ValueKey('pot-form-save')));

      final body =
          http.requestsTo('POST /teams/3/fine-pot').single.body!
              as Map<String, dynamic>;
      expect(body['amount_cents'], -1250);
      expect(body['description'], 'Krat bier');
      expect(body['occurred_on'], matches(RegExp(r'^\d{4}-\d{2}-\d{2}$')));

      // Bestaande boeking: velden ingevuld, PATCH met dezelfde datum.
      await _tap(tester, find.byKey(const ValueKey('pot-line-entry-12')));
      final amount = tester.widget<TextField>(
        find.byKey(const ValueKey('pot-form-amount')),
      );
      expect(amount.controller!.text, '12,50');
      await _tap(tester, find.byKey(const ValueKey('pot-form-save')));
      expect(http.requestsTo('PATCH /teams/3/fine-pot/12').single.body, {
        'amount_cents': -1250,
        'description': 'Krat bier',
        'occurred_on': '2026-10-04',
      });

      await _tap(tester, find.byKey(const ValueKey('pot-line-entry-12')));
      await _tap(tester, find.byKey(const ValueKey('pot-form-delete')));
      await _tap(tester, find.byKey(const ValueKey('fines-delete-confirm')));
      expect(http.requestsTo('DELETE /teams/3/fine-pot/12'), hasLength(1));

      // Berekende regels zijn niet te bewerken.
      await _tap(tester, find.byKey(const ValueKey('pot-line-period-7')));
      expect(find.byKey(const ValueKey('pot-form-save')), findsNothing);
    });
  });
}
