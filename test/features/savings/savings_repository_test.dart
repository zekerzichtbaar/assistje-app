import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/savings/data/models/savings_models.dart';
import 'package:assistje/features/savings/data/savings_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'savings_fixtures.dart';

void main() {
  late FakeHttpAdapter http;
  late SavingsRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = SavingsRepository(
      ApiClient(
        buildApiDio(
          baseUrl: 'https://assistje.test/api/v1',
          readToken: () async => '12|abc',
          onUnauthorized: () {},
          adapter: http,
        ),
      ),
    );
  });

  const draft = SavingsPotDraft(
    name: 'Weekendje weg',
    scope: SavingsScope.custom,
    amountCents: 1250,
    goalCents: 30000,
    startMonth: '2026-11',
    months: 6,
    members: ['p17', 'p21', 'u4'],
  );

  group('lezen', () {
    test('overzicht in centen', () async {
      http.on('GET /teams/3/savings', 200, SavingsFixtures.overview());

      final overview = await repository.fetchOverview(3);

      final pot = overview.pots.single;
      expect(pot.id, 3);
      expect(pot.name, 'Trainingskamp');
      expect(pot.amountCents, 4000);
      expect(pot.goalCents, 440000);
      expect(pot.months, 11);
      expect(pot.memberCount, 14);
      expect(pot.savedCents, 96000);
      expect(pot.isOneOff, isFalse);
      expect(pot.goalPercent, 22);
      expect(overview.canManage, isFalse);
    });

    test('pot met matrix uit het voorbeeld', () async {
      http.on('GET /teams/3/savings/7', 200, SavingsFixtures.oneOffDetail());

      final detail = await repository.fetchPot(3, 7);

      expect(detail.pot.scope, SavingsScope.event);
      expect(detail.pot.oneOff, isTrue);
      expect(detail.pot.startsOn, DateTime(2026, 11));
      expect(detail.pot.event!.id, 412);
      expect(detail.pot.event!.cancelled, isFalse);
      expect(detail.pot.isSettled, isFalse);
      expect(detail.finesEnabled, isTrue);
      expect(detail.periods, ['2026-11']);
      expect(detail.participants.map((p) => p.key), ['p17', 'p21', 'u4']);
      final joris = detail.participants[1];
      expect(joris.refund, isTrue);
      expect(joris.refundReason, SavingsRefundReason.absent);
      expect(detail.participants.last.isStaff, isTrue);
      expect(detail.payments.first.cents, 2500);
      expect(detail.canManage, isTrue);

      // Afgeleid: Joris telt niet mee (krijgt terug).
      expect(detail.savedCents, 5000);
      expect(detail.counting.map((p) => p.key), ['p17', 'u4']);
      expect(detail.countingPaid, 1);
      expect(detail.openCents, 2500);
      expect(detail.ringPercent, 50);
      expect(detail.targetCents, 5000);
      expect(detail.refundsOpen, 1);
      expect(detail.showsSettle, isTrue);
      expect(detail.canRemind, isTrue);
    });

    test('maandpot: rij- en kolomtotalen met het bedrag van toen', () async {
      http.on('GET /teams/3/savings/3', 200, SavingsFixtures.monthlyDetail());

      final detail = await repository.fetchPot(3, 3);

      expect(detail.pot.scope, SavingsScope.allStaff);
      expect(detail.rowCents('p17'), 7500);
      expect(detail.columnCents('2026-09'), 8000);
      expect(detail.columnCents('2026-11'), 0);
      expect(detail.savedCents, 11500);
      expect(detail.ringPercent, 48); // 11500 van 24000
      expect(detail.cellsTotal, 6);
      expect(detail.showsSettle, isFalse);
      expect(detail.canRemind, isFalse);
    });

    test('onbekende scope/kind/reden vallen terug', () async {
      final body = SavingsFixtures.oneOffDetail();
      final data = body['data'] as Map<String, dynamic>;
      (data['pot'] as Map<String, dynamic>)['scope'] = 'galaxy';
      final participants = data['participants'] as List<Object?>;
      (participants[1]! as Map<String, dynamic>)
        ..['kind'] = 'alien'
        ..['refund_reason'] = 'moved';
      http.on('GET /teams/3/savings/7', 200, body);

      final detail = await repository.fetchPot(3, 7);

      expect(detail.pot.scope, SavingsScope.unknown);
      expect(detail.participants[1].kind, SavingsParticipantKind.unknown);
      expect(detail.participants[1].refundReason, SavingsRefundReason.unknown);
    });

    test('create: keuzelijsten, ?event= zet een activiteit voor', () async {
      http.on(
        'GET /teams/3/savings/create',
        200,
        SavingsFixtures.createOptions(presetEventId: 412),
      );

      final options = await repository.fetchCreateOptions(3, eventId: 412);

      expect(http.requests.single.options.uri.queryParameters, {
        'event': '412',
      });
      expect(options.people.players.map((p) => p.key), ['p17', 'p30']);
      expect(options.people.hasGuests, isTrue);
      expect(options.people.staff.single.key, 'u4');
      expect(options.activities.single.id, 412);
      expect(options.presetEventId, 412);
      expect(options.pot, isNull);
    });

    test('edit: huidige waarden in euro\'s', () async {
      http.on(
        'GET /teams/3/savings/9/edit',
        200,
        SavingsFixtures.editOptions(),
      );

      final options = await repository.fetchEditOptions(3, 9);

      final pot = options.pot!;
      expect(pot.id, 9);
      expect(pot.scope, SavingsScope.custom);
      expect(pot.amount, 12.5);
      expect(pot.goal, 300);
      expect(pot.startMonth, '2026-11');
      expect(pot.months, 6);
      expect(pot.members, ['p17', 'p21', 'u4']);
      expect(pot.eventId, isNull);
      expect(options.people.hasGuests, isFalse);
    });
  });

  group('schrijven', () {
    test('aanmaken stuurt euro\'s, leest centen', () async {
      http.on('POST /teams/3/savings', 201, SavingsFixtures.pot9Response());

      final pot = await repository.createPot(3, draft);

      expect(http.requestsTo('POST /teams/3/savings').single.body, {
        'name': 'Weekendje weg',
        'scope': 'custom',
        'include_guests': false,
        'amount': 12.5,
        'goal': 300,
        'start_month': '2026-11',
        'months': 6,
        'members': ['p17', 'p21', 'u4'],
        'event_id': null,
      });
      expect(pot.id, 9);
      expect(pot.amountCents, 1250);
      expect(pot.goalCents, 30000);
    });

    test(
      'wijzigen: PATCH met het hele formulier; niet-custom leegt members',
      () async {
        http.on(
          'PATCH /teams/3/savings/9',
          200,
          SavingsFixtures.pot9Response(),
        );

        await repository.updatePot(
          3,
          9,
          const SavingsPotDraft(
            name: 'Weekendje Ardennen',
            scope: SavingsScope.allStaff,
            includeGuests: true,
            amountCents: 1599,
            startMonth: '2026-11',
            months: 6,
            members: ['p17'],
            eventId: 412,
          ),
        );

        expect(http.requestsTo('PATCH /teams/3/savings/9').single.body, {
          'name': 'Weekendje Ardennen',
          'scope': 'all_staff',
          'include_guests': true,
          'amount': 15.99,
          'goal': null,
          'start_month': '2026-11',
          'months': 6,
          'members': <String>[],
          'event_id': 412,
        });
      },
    );

    test('archiveren: DELETE 204', () async {
      http.on('DELETE /teams/3/savings/9', 204);
      await repository.archivePot(3, 9);
      expect(http.requestsTo('DELETE /teams/3/savings/9'), hasLength(1));
    });

    test('cel aftikken: key + period_ym, antwoord met cents/null', () async {
      http.on(
        'POST /teams/3/savings/7/payments/toggle',
        200,
        SavingsFixtures.toggleResponse(),
      );
      final on = await repository.togglePayment(
        3,
        7,
        key: 'p17',
        ym: '2026-11',
      );
      expect(
        http.requestsTo('POST /teams/3/savings/7/payments/toggle').single.body,
        {'key': 'p17', 'period_ym': '2026-11'},
      );
      expect(on.paid, isTrue);
      expect(on.cents, 2500);

      http.on(
        'POST /teams/3/savings/7/payments/toggle',
        200,
        SavingsFixtures.toggleResponse(paid: false, cents: null),
      );
      final off = await repository.togglePayment(
        3,
        7,
        key: 'p17',
        ym: '2026-11',
      );
      expect(off.paid, isFalse);
      expect(off.cents, isNull);
    });

    test('terugbetaald zetten', () async {
      http.on('POST /teams/3/savings/7/payments/refund', 200, {
        'data': {'key': 'p21', 'refunded': true},
      });
      final result = await repository.refundPayment(
        3,
        7,
        key: 'p21',
        refunded: true,
      );
      expect(
        http.requestsTo('POST /teams/3/savings/7/payments/refund').single.body,
        {'key': 'p21', 'refunded': true},
      );
      expect(result.refunded, isTrue);
    });

    test('herinneren geeft het aantal; 422 bij afgelast', () async {
      http.on('POST /teams/3/savings/7/remind', 200, {
        'data': {'sent': 3},
      });
      expect(await repository.remind(3, 7), 3);

      http.on('POST /teams/3/savings/7/remind', 422, {
        'message': 'De activiteit is afgelast; er valt niets meer te innen.',
      });
      await expectLater(
        repository.remind(3, 7),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.message,
            'message',
            startsWith('De activiteit is afgelast'),
          ),
        ),
      );
    });

    test('afrekenen in euro\'s, ongedaan maken', () async {
      http
        ..on(
          'PATCH /teams/3/savings/7/settle',
          200,
          SavingsFixtures.settledResponse(),
        )
        ..on(
          'DELETE /teams/3/savings/7/settle',
          200,
          SavingsFixtures.settledResponse(cost: null),
        );

      final settled = await repository.settle(
        3,
        7,
        actualCostCents: 41234,
        settledOn: DateTime(2026, 10),
      );
      expect(http.requestsTo('PATCH /teams/3/savings/7/settle').single.body, {
        'actual_cost': 412.34,
        'settled_on': '2026-10-01',
      });
      expect(settled.actualCostCents, 41234);
      expect(settled.settledOn, DateTime(2026, 10));
      expect(settled.isSettled, isTrue);

      final undone = await repository.unsettle(3, 7);
      expect(undone.isSettled, isFalse);
      expect(undone.actualCostCents, isNull);
    });
  });

  group('fouten', () {
    test('403 (toeschouwer/geen penningmeester/demo)', () async {
      http.on('POST /teams/3/savings', 403, {'message': 'Geen toegang.'});
      await expectLater(
        repository.createPot(3, draft),
        throwsA(isA<ForbiddenException>()),
      );
    });

    test('404 (feature uit / pot van ander team)', () async {
      http.on('GET /teams/3/savings/99', 404, {'message': 'Not found.'});
      await expectLater(
        repository.fetchPot(3, 99),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('422 met veldfouten', () async {
      http.on('POST /teams/3/savings', 422, {
        'message': 'Kies een activiteit.',
        'errors': {
          'event_id': ['Kies een activiteit.'],
        },
      });
      await expectLater(
        repository.createPot(3, draft),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.fieldError('event_id'),
            'event_id',
            'Kies een activiteit.',
          ),
        ),
      );
    });

    test('antwoord zonder data', () async {
      http.on('GET /teams/3/savings', 200, {'oops': true});
      await expectLater(
        repository.fetchOverview(3),
        throwsA(isA<UnknownApiException>()),
      );
    });
  });

  test('centsToEuros', () {
    expect(centsToEuros(4000), 40);
    expect(centsToEuros(1250), 12.5);
    expect(centsToEuros(1), 0.01);
  });
}
