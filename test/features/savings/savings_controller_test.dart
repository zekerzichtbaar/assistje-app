import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/savings/application/savings_controller.dart';
import 'package:assistje/features/savings/data/models/savings_models.dart';
import 'package:assistje/features/savings/data/savings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'savings_fixtures.dart';

const _list = 'GET /teams/3/savings';
const _pot7 = 'GET /teams/3/savings/7';
const SavingsPotRef _ref7 = (teamId: 3, potId: 7);

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<void> boot(void Function(FakeHttpAdapter http) setup) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
  }

  Future<SavingsListController> startList(
    void Function(FakeHttpAdapter http) setup,
  ) async {
    await boot(setup);
    container.listen(savingsListControllerProvider(3), (_, _) {});
    await container.read(savingsListControllerProvider(3).future);
    // Alleen de verzoeken ná het laden tellen.
    backend.http.requests.clear();
    return container.read(savingsListControllerProvider(3).notifier);
  }

  Future<SavingsPotController> startPot(
    void Function(FakeHttpAdapter http) setup,
  ) async {
    await boot(setup);
    container
      ..listen(savingsPotControllerProvider(_ref7), (_, _) {})
      ..listen(savingsListControllerProvider(3), (_, _) {});
    await container.read(savingsPotControllerProvider(_ref7).future);
    await container.read(savingsListControllerProvider(3).future);
    backend.http.requests.clear();
    return container.read(savingsPotControllerProvider(_ref7).notifier);
  }

  SavingsPotState pot() =>
      container.read(savingsPotControllerProvider(_ref7)).requireValue;

  group('overzicht', () {
    test('laadt de potten', () async {
      await startList(
        (http) => http.on(_list, 200, SavingsFixtures.overview()),
      );
      final overview = container
          .read(savingsListControllerProvider(3))
          .requireValue;
      expect(overview.pots.single.name, 'Trainingskamp');
    });

    test('403 (toeschouwer) komt als AsyncError', () async {
      await boot((http) => http.on(_list, 403, {'message': 'Geen toegang.'}));
      container.listen(savingsListControllerProvider(3), (_, _) {});
      await expectLater(
        container.read(savingsListControllerProvider(3).future),
        throwsA(isA<ForbiddenException>()),
      );
    });

    test('aanmaken: POST en daarna opnieuw ophalen', () async {
      final controller = await startList(
        (http) => http
          ..on(_list, 200, SavingsFixtures.overview(canManage: true))
          ..on('POST /teams/3/savings', 201, SavingsFixtures.pot9Response()),
      );

      final result = await controller.createPot(
        const SavingsPotDraft(
          name: 'Weekendje weg',
          scope: SavingsScope.all,
          amountCents: 1250,
          startMonth: '2026-11',
          months: 6,
        ),
      );

      expect(result.error, isNull);
      expect(result.pot!.id, 9);
      expect(backend.http.requestsTo(_list), hasLength(1));
    });

    test('aanmaken met 422 geeft de fout en haalt niet opnieuw op', () async {
      final controller = await startList(
        (http) => http
          ..on(_list, 200, SavingsFixtures.overview(canManage: true))
          ..on('POST /teams/3/savings', 422, {
            'message': 'Vul een naam in.',
            'errors': {
              'name': ['Vul een naam in.'],
            },
          }),
      );

      final result = await controller.createPot(
        const SavingsPotDraft(
          name: 'x',
          scope: SavingsScope.all,
          amountCents: 100,
          startMonth: '2026-11',
          months: 1,
        ),
      );

      expect(result.pot, isNull);
      expect(result.error, isA<ValidationException>());
      expect(backend.http.requestsTo(_list), isEmpty);
    });
  });

  group('pot', () {
    test('404 komt als AsyncError', () async {
      await boot((http) => http.on(_pot7, 404, {'message': 'Not found.'}));
      container.listen(savingsPotControllerProvider(_ref7), (_, _) {});
      await expectLater(
        container.read(savingsPotControllerProvider(_ref7).future),
        throwsA(isA<NotFoundException>()),
      );
    });

    test('cel aftikken neemt de serverstaat over zonder te herladen', () async {
      final controller = await startPot(
        (http) => http
          ..on(_list, 200, SavingsFixtures.overview())
          ..on(
            _pot7,
            200,
            SavingsFixtures.oneOffDetail(
              payments: [
                {'key': 'p21', 'ym': '2026-11', 'cents': 2500},
              ],
            ),
          )
          ..on(
            'POST /teams/3/savings/7/payments/toggle',
            200,
            SavingsFixtures.toggleResponse(cents: 2000),
          ),
      );
      expect(pot().detail.isPaid('p17', '2026-11'), isFalse);

      expect(await controller.togglePayment('p17', '2026-11'), isNull);

      expect(pot().detail.isPaid('p17', '2026-11'), isTrue);
      // Het bedrag van de server, niet van de pot.
      expect(pot().detail.paid['p17|2026-11'], 2000);
      expect(pot().pending, isEmpty);
      expect(backend.http.requestsTo(_pot7), isEmpty);
      // Het overzicht (saved_cents) is opnieuw opgehaald.
      await container.read(savingsListControllerProvider(3).future);
      expect(backend.http.requestsTo(_list), hasLength(1));

      backend.http.on(
        'POST /teams/3/savings/7/payments/toggle',
        200,
        SavingsFixtures.toggleResponse(paid: false, cents: null),
      );
      await controller.togglePayment('p17', '2026-11');
      expect(pot().detail.isPaid('p17', '2026-11'), isFalse);
    });

    test('mislukte toggle laat de cel staan en geeft de fout', () async {
      final controller = await startPot(
        (http) => http
          ..on(_list, 200, SavingsFixtures.overview())
          ..on(_pot7, 200, SavingsFixtures.oneOffDetail())
          ..on('POST /teams/3/savings/7/payments/toggle', 422, {
            'message': 'Onbekende deelnemer.',
          }),
      );

      final error = await controller.togglePayment('u4', '2026-11');

      expect(error, isA<ValidationException>());
      expect(pot().detail.isPaid('u4', '2026-11'), isFalse);
      expect(pot().pending, isEmpty);
    });

    test('terugbetalen, afrekenen en ongedaan maken herladen de pot', () async {
      final controller = await startPot(
        (http) => http
          ..on(_list, 200, SavingsFixtures.overview())
          ..on(_pot7, 200, SavingsFixtures.oneOffDetail())
          ..on('POST /teams/3/savings/7/payments/refund', 200, {
            'data': {'key': 'p21', 'refunded': true},
          })
          ..on(
            'PATCH /teams/3/savings/7/settle',
            200,
            SavingsFixtures.settledResponse(),
          )
          ..on(
            'DELETE /teams/3/savings/7/settle',
            200,
            SavingsFixtures.settledResponse(cost: null),
          ),
      );

      backend.http.on(_pot7, 200, SavingsFixtures.oneOffDetail(refunded: true));
      expect(await controller.setRefunded('p21', refunded: true), isNull);
      expect(pot().detail.participants[1].refunded, isTrue);
      expect(pot().detail.refundsOpen, 0);

      backend.http.on(
        _pot7,
        200,
        SavingsFixtures.oneOffDetail(
          actualCostCents: 6000,
          settledOn: '2026-10-01',
        ),
      );
      expect(await controller.settle(6000), isNull);
      expect(
        backend.http.requestsTo('PATCH /teams/3/savings/7/settle').single.body,
        {'actual_cost': 60},
      );
      expect(pot().detail.settleDiffCents, -1000);

      backend.http.on(_pot7, 200, SavingsFixtures.oneOffDetail());
      expect(await controller.unsettle(), isNull);
      expect(pot().detail.pot.isSettled, isFalse);
      expect(backend.http.requestsTo(_pot7), hasLength(3));
    });

    test('herinneren geeft aantal of fout', () async {
      final controller = await startPot(
        (http) => http
          ..on(_list, 200, SavingsFixtures.overview())
          ..on(_pot7, 200, SavingsFixtures.oneOffDetail())
          ..on('POST /teams/3/savings/7/remind', 200, {
            'data': {'sent': 2},
          }),
      );
      expect(await controller.remind(), (sent: 2, error: null));

      backend.http.on('POST /teams/3/savings/7/remind', 403, {
        'message': 'Dit is een demo-team.',
      });
      final failed = await controller.remind();
      expect(failed.error, isA<ForbiddenException>());
    });

    test('archiveren ververst het overzicht', () async {
      final controller = await startPot(
        (http) => http
          ..on(_list, 200, SavingsFixtures.overview())
          ..on(_pot7, 200, SavingsFixtures.oneOffDetail())
          ..on('DELETE /teams/3/savings/7', 204),
      );
      expect(await controller.archive(), isNull);
      await container.read(savingsListControllerProvider(3).future);
      expect(backend.http.requestsTo(_list), hasLength(1));
    });

    test('schrijffout (403 demo) komt terug, geen herladen', () async {
      final controller = await startPot(
        (http) => http
          ..on(_list, 200, SavingsFixtures.overview())
          ..on(_pot7, 200, SavingsFixtures.oneOffDetail())
          ..on('PATCH /teams/3/savings/7/settle', 403, {
            'message': 'Dit is een demo-team.',
          }),
      );
      expect(await controller.settle(100), isA<ForbiddenException>());
      expect(backend.http.requestsTo(_pot7), isEmpty);
    });
  });
}
