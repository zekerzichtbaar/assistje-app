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
import 'savings_fixtures.dart';

const _list = 'GET /teams/3/savings';
const _pot3 = 'GET /teams/3/savings/3';
const _pot7 = 'GET /teams/3/savings/7';

final Map<String, dynamic> _player = ApiFixtures.membership(
  features: {'savings': true},
);
final Map<String, dynamic> _treasurer = ApiFixtures.membership(
  role: 'trainer',
  features: {'savings': true},
);

/// Start ingelogd als [membership], zet het overzicht klaar en opent
/// `/savings`.
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
      http.on(_list, 200, overview ?? SavingsFixtures.overview());
      setup?.call(http);
    },
  );
  unawaited(container.read(routerProvider).push(AppRoutes.savings));
  await pumpUntilFound(tester, find.byKey(const ValueKey('savings-screen')));
  await tester.pumpAndSettle();
  return (container, backend.http);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

String _norm(String text) => text.replaceAll('\u00A0', ' ');

String _text(WidgetTester tester, String key) {
  final widget = tester.widget<Text>(find.byKey(ValueKey(key)));
  return _norm(widget.data ?? widget.textSpan?.toPlainText() ?? '');
}

Map<String, dynamic> _overview7({bool canManage = true}) =>
    SavingsFixtures.overview(
      canManage: canManage,
      pots: [
        {
          'id': 7,
          'name': 'Eindfeest',
          'amount_cents': 2500,
          'goal_cents': null,
          'months': 1,
          'member_count': 2,
          'saved_cents': 5000,
        },
      ],
    );

void main() {
  testWidgets('speler: potten, matrix alleen-lezen, geen acties', (
    tester,
  ) async {
    final (_, http) = await _open(
      tester,
      membership: _player,
      setup: (http) => http.on(_pot3, 200, SavingsFixtures.monthlyDetail()),
    );

    expect(find.text('Spaarpot'), findsOneWidget);
    expect(find.byKey(const ValueKey('savings-pot-3')), findsOneWidget);
    expect(find.text('Trainingskamp'), findsOneWidget);
    expect(_text(tester, 'savings-pot-3-meta'), '14 · € 40,00/mnd · 11 mnd');
    expect(_text(tester, 'savings-pot-3-saved'), '€ 960,00');
    expect(_text(tester, 'savings-pot-3-goal'), 'van € 4.400,00 · 22%');
    expect(find.byKey(const ValueKey('savings-new')), findsNothing);

    await _tap(tester, find.byKey(const ValueKey('savings-pot-3')));
    expect(find.byKey(const ValueKey('savings-pot-screen')), findsOneWidget);
    expect(_text(tester, 'savings-card-saved'), '€ 115,00');
    expect(_text(tester, 'savings-card-line'), '€ 40,00 p/m · 3 van 6 betaald');
    expect(_text(tester, 'savings-ring'), '48%');
    expect(_text(tester, 'savings-card-target'), '€ 240,00');
    expect(_text(tester, 'savings-card-when'), "sep '26 – nov '26");
    expect(find.byKey(const ValueKey('savings-grid')), findsOneWidget);
    expect(_text(tester, 'savings-row-total-p17'), '€ 75,00');
    expect(_text(tester, 'savings-col-total-2026-09'), '€ 80,00');
    expect(_text(tester, 'savings-grid-total'), '€ 115,00');
    expect(find.text('staf'), findsOneWidget);

    // Geen beheer: geen knoppen, en tikken op een vakje doet niets.
    expect(find.byKey(const ValueKey('savings-edit')), findsNothing);
    expect(find.byKey(const ValueKey('savings-archive')), findsNothing);
    expect(find.byKey(const ValueKey('savings-remind')), findsNothing);
    expect(find.byKey(const ValueKey('savings-settle')), findsNothing);
    await _tap(tester, find.byKey(const ValueKey('savings-cell-u4-2026-11')));
    expect(http.requestsTo('POST /teams/3/savings/3/payments/toggle'), isEmpty);
  });

  testWidgets('leeg overzicht voor een speler', (tester) async {
    await _open(
      tester,
      membership: _player,
      overview: SavingsFixtures.overview(pots: const []),
    );
    expect(find.byKey(const ValueKey('savings-empty')), findsOneWidget);
    expect(find.text('Er is nog geen spaarpot aangemaakt.'), findsOneWidget);
  });

  testWidgets('403 bij laden met opnieuw proberen', (tester) async {
    final (_, http) = await _open(
      tester,
      membership: _player,
      setup: (http) => http.on(_list, 403, {'message': 'Geen toegang.'}),
    );

    expect(find.byKey(const ValueKey('savings-error')), findsOneWidget);
    expect(find.text('Je hebt geen toegang tot de spaarpot.'), findsOneWidget);

    http.on(_list, 200, SavingsFixtures.overview());
    await _tap(tester, find.byKey(const ValueKey('savings-retry')));
    expect(find.byKey(const ValueKey('savings-pot-3')), findsOneWidget);
  });

  testWidgets('pot die niet (meer) bestaat: 404', (tester) async {
    await _open(
      tester,
      membership: _player,
      setup: (http) => http.on(_pot3, 404, {'message': 'Not found.'}),
    );

    await _tap(tester, find.byKey(const ValueKey('savings-pot-3')));
    expect(find.byKey(const ValueKey('savings-pot-error')), findsOneWidget);
    expect(find.text('Deze pot bestaat niet (meer).'), findsOneWidget);
  });

  group('penningmeester', () {
    testWidgets('eenmalig: aftikken, terugbetalen, herinneren, afrekenen', (
      tester,
    ) async {
      final (_, http) = await _open(
        tester,
        membership: _treasurer,
        overview: _overview7(),
        setup: (http) => http
          ..on(_pot7, 200, SavingsFixtures.oneOffDetail())
          ..on(
            'POST /teams/3/savings/7/payments/toggle',
            200,
            SavingsFixtures.toggleResponse(key: 'u4'),
          )
          ..on('POST /teams/3/savings/7/payments/refund', 200, {
            'data': {'key': 'p21', 'refunded': true},
          })
          ..on('POST /teams/3/savings/7/remind', 200, {
            'data': {'sent': 2},
          })
          ..on(
            'PATCH /teams/3/savings/7/settle',
            200,
            SavingsFixtures.settledResponse(),
          ),
      );
      expect(find.byKey(const ValueKey('savings-new')), findsOneWidget);
      expect(
        _text(tester, 'savings-pot-7-meta'),
        '2 · € 25,00 p.p. · eenmalig',
      );

      await _tap(tester, find.byKey(const ValueKey('savings-pot-7')));
      expect(find.byKey(const ValueKey('savings-edit')), findsOneWidget);
      expect(find.byKey(const ValueKey('savings-event')), findsOneWidget);
      expect(
        _text(tester, 'savings-card-line'),
        '€ 25,00 p.p. · 1 van 2 betaald',
      );
      expect(
        _text(tester, 'savings-oneoff-footer'),
        '1 van 2 betaald · € 25,00 open',
      );
      expect(
        _text(tester, 'savings-refund-label-p21'),
        'Afgemeld — krijgt terug',
      );

      // Aftikken: POST, de cel volgt de server.
      await _tap(tester, find.byKey(const ValueKey('savings-cell-u4-2026-11')));
      expect(
        http.requestsTo('POST /teams/3/savings/7/payments/toggle').single.body,
        {'key': 'u4', 'period_ym': '2026-11'},
      );
      expect(
        _text(tester, 'savings-oneoff-footer'),
        '2 van 2 betaald · € 0,00 open',
      );

      // Terugbetaald: POST en de pot wordt opnieuw opgehaald.
      http.on(_pot7, 200, SavingsFixtures.oneOffDetail(refunded: true));
      await _tap(tester, find.byKey(const ValueKey('savings-refund-p21')));
      expect(
        http.requestsTo('POST /teams/3/savings/7/payments/refund').single.body,
        {'key': 'p21', 'refunded': true},
      );
      expect(_text(tester, 'savings-refund-label-p21'), 'Terugbetaald');
      expect(find.text('Ongedaan maken'), findsOneWidget);

      // Herinneren: eerst bevestigen.
      await _tap(tester, find.byKey(const ValueKey('savings-remind')));
      await _tap(tester, find.byKey(const ValueKey('savings-confirm-ok')));
      expect(http.requestsTo('POST /teams/3/savings/7/remind'), hasLength(1));
      expect(
        find.text('Herinnering verstuurd naar 2 personen'),
        findsOneWidget,
      );

      // Afrekenen: kosten invullen, verschil zien, PATCH in euro's.
      await _tap(tester, find.byKey(const ValueKey('savings-settle-open')));
      await tester.enterText(
        find.byKey(const ValueKey('savings-settle-cost')),
        '60',
      );
      await tester.pump();
      expect(
        _text(tester, 'savings-settle-diff'),
        'Tekort: € 10,00. Gaat uit de teampot.',
      );
      http.on(
        _pot7,
        200,
        SavingsFixtures.oneOffDetail(
          refunded: true,
          actualCostCents: 6000,
          settledOn: '2026-10-01',
        ),
      );
      await _tap(tester, find.byKey(const ValueKey('savings-settle-submit')));
      expect(http.requestsTo('PATCH /teams/3/savings/7/settle').single.body, {
        'actual_cost': 60,
      });
      expect(find.byKey(const ValueKey('savings-settle-submit')), findsNothing);
      expect(
        _text(tester, 'savings-settle-summary'),
        'Kosten € 60,00 · tekort € 10,00 uit de teampot',
      );
      expect(find.byKey(const ValueKey('savings-settle-undo')), findsOneWidget);
    });

    testWidgets('herinneren bij een afgelaste activiteit: 422-toast', (
      tester,
    ) async {
      final (_, http) = await _open(
        tester,
        membership: _treasurer,
        overview: _overview7(),
        setup: (http) => http
          ..on(_pot7, 200, SavingsFixtures.oneOffDetail())
          ..on('POST /teams/3/savings/7/remind', 422, {
            'message':
                'De activiteit is afgelast; er valt niets meer te innen.',
          }),
      );
      await _tap(tester, find.byKey(const ValueKey('savings-pot-7')));
      await _tap(tester, find.byKey(const ValueKey('savings-remind')));
      await _tap(tester, find.byKey(const ValueKey('savings-confirm-ok')));
      expect(find.text('Herinnering sturen mislukt'), findsOneWidget);
      expect(
        find.text('De activiteit is afgelast; er valt niets meer te innen.'),
        findsOneWidget,
      );
      expect(http.requestsTo('POST /teams/3/savings/7/remind'), hasLength(1));
    });

    testWidgets('nieuwe pot: validatie, POST in euro\'s, daarna het detail', (
      tester,
    ) async {
      final (_, http) = await _open(
        tester,
        membership: _treasurer,
        overview: SavingsFixtures.overview(canManage: true),
        setup: (http) => http
          ..on(
            'GET /teams/3/savings/create',
            200,
            SavingsFixtures.createOptions(),
          )
          ..on('POST /teams/3/savings', 201, SavingsFixtures.pot9Response())
          ..on('GET /teams/3/savings/9', 200, {
            'data': {
              'pot': SavingsFixtures.pot9Response()['data'],
              'periods': ['2026-11'],
              'participants': <Object>[],
              'payments': <Object>[],
              'can_manage': true,
            },
          }),
      );

      await _tap(tester, find.byKey(const ValueKey('savings-new')));
      expect(find.byKey(const ValueKey('savings-form')), findsOneWidget);

      // Leeg: meldingen, geen verzoek.
      await _tap(tester, find.byKey(const ValueKey('savings-form-submit')));
      expect(find.text('Vul een naam in.'), findsOneWidget);
      expect(find.text('Vul een bedrag in.'), findsOneWidget);
      expect(http.requestsTo('POST /teams/3/savings'), isEmpty);

      await tester.enterText(
        find.byKey(const ValueKey('savings-form-name')),
        'Weekendje weg',
      );
      await tester.enterText(
        find.byKey(const ValueKey('savings-form-amount')),
        '12,50',
      );
      await tester.enterText(
        find.byKey(const ValueKey('savings-form-months')),
        '6',
      );
      await tester.enterText(
        find.byKey(const ValueKey('savings-form-goal')),
        '300',
      );
      await _tap(tester, find.text('Zelf kiezen'));
      await _tap(tester, find.byKey(const ValueKey('savings-form-member-p17')));
      await _tap(tester, find.byKey(const ValueKey('savings-form-member-u4')));
      await _tap(tester, find.byKey(const ValueKey('savings-form-submit')));

      final body =
          http.requestsTo('POST /teams/3/savings').single.body!
              as Map<String, dynamic>;
      expect(body['name'], 'Weekendje weg');
      expect(body['scope'], 'custom');
      expect(body['amount'], 12.5);
      expect(body['goal'], 300);
      expect(body['months'], 6);
      expect(body['members'], ['p17', 'u4']);
      expect(body['event_id'], isNull);
      expect(body['start_month'], matches(RegExp(r'^\d{4}-\d{2}$')));

      // Na aanmaken: het detail van de nieuwe pot, overzicht ververst.
      await pumpUntilFound(
        tester,
        find.byKey(const ValueKey('savings-no-participants')),
      );
      expect(http.requestsTo(_list), hasLength(2));
      expect(
        find.text('Nog geen deelnemers. Voeg ze toe via het potlood-icoon.'),
        findsOneWidget,
      );
    });

    testWidgets('422 van de server blijft in het formulier staan', (
      tester,
    ) async {
      await _open(
        tester,
        membership: _treasurer,
        overview: SavingsFixtures.overview(canManage: true),
        setup: (http) => http
          ..on(
            'GET /teams/3/savings/create',
            200,
            SavingsFixtures.createOptions(),
          )
          ..on('POST /teams/3/savings', 422, {
            'message': 'Het aantal maanden mag niet meer dan 60 zijn.',
            'errors': {
              'months': ['Het aantal maanden mag niet meer dan 60 zijn.'],
            },
          }),
      );

      await _tap(tester, find.byKey(const ValueKey('savings-new')));
      await tester.enterText(
        find.byKey(const ValueKey('savings-form-name')),
        'Trainingskamp',
      );
      await tester.enterText(
        find.byKey(const ValueKey('savings-form-amount')),
        '40',
      );
      await _tap(tester, find.byKey(const ValueKey('savings-form-submit')));

      expect(
        find.byKey(const ValueKey('savings-form-error-months')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('savings-form-submit')), findsOneWidget);
    });

    testWidgets('bewerken (PATCH) en archiveren (DELETE)', (tester) async {
      final (_, http) = await _open(
        tester,
        membership: _treasurer,
        overview: SavingsFixtures.overview(canManage: true),
        setup: (http) => http
          ..on(_pot3, 200, SavingsFixtures.monthlyDetail(canManage: true))
          ..on(
            'GET /teams/3/savings/3/edit',
            200,
            SavingsFixtures.editOptions(),
          )
          ..on('PATCH /teams/3/savings/3', 200, SavingsFixtures.pot9Response())
          ..on('DELETE /teams/3/savings/3', 204),
      );

      await _tap(tester, find.byKey(const ValueKey('savings-pot-3')));
      // Maandpot: vakje aftikken mag.
      expect(find.byKey(const ValueKey('savings-remind')), findsOneWidget);

      await _tap(tester, find.byKey(const ValueKey('savings-edit')));
      final name = tester.widget<TextField>(
        find.byKey(const ValueKey('savings-form-name')),
      );
      expect(name.controller!.text, 'Weekendje weg');
      final amount = tester.widget<TextField>(
        find.byKey(const ValueKey('savings-form-amount')),
      );
      expect(amount.controller!.text, '12,50');
      expect(_text(tester, 'savings-form-month-label'), 'november 2026');
      await _tap(tester, find.byKey(const ValueKey('savings-form-month-next')));
      await _tap(tester, find.byKey(const ValueKey('savings-form-submit')));

      expect(http.requestsTo('PATCH /teams/3/savings/3').single.body, {
        'name': 'Weekendje weg',
        'scope': 'custom',
        'include_guests': false,
        'amount': 12.5,
        'goal': 300,
        'start_month': '2026-12',
        'months': 6,
        'members': ['p17', 'p21', 'u4'],
        'event_id': null,
      });
      expect(find.text('Pot opgeslagen'), findsOneWidget);
      expect(http.requestsTo(_pot3), hasLength(2));

      await _tap(tester, find.byKey(const ValueKey('savings-archive')));
      // Annuleren doet niets.
      await _tap(tester, find.byKey(const ValueKey('savings-confirm-cancel')));
      expect(http.requestsTo('DELETE /teams/3/savings/3'), isEmpty);
      await _tap(tester, find.byKey(const ValueKey('savings-archive')));
      await _tap(tester, find.byKey(const ValueKey('savings-confirm-ok')));
      expect(http.requestsTo('DELETE /teams/3/savings/3'), hasLength(1));
      expect(find.byKey(const ValueKey('savings-pot-screen')), findsNothing);
      expect(find.text('Pot gearchiveerd'), findsOneWidget);
    });
  });
}
