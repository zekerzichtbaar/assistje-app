import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/fines/application/fines_controller.dart';
import 'package:assistje/features/fines/data/fines_repository.dart';
import 'package:assistje/features/fines/data/models/fines_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'fines_fixtures.dart';

const _overview = 'GET /teams/3/fines';

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<FinesController> start(
    void Function(FakeHttpAdapter http) setup,
  ) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(finesControllerProvider(3), (_, _) {});
    await container.read(finesControllerProvider(3).future);
    return container.read(finesControllerProvider(3).notifier);
  }

  FinesState current() =>
      container.read(finesControllerProvider(3)).requireValue;

  int overviewCalls() => backend.http.requestsTo(_overview).length;

  test('laadt de lopende periode', () async {
    await start((http) => http.on(_overview, 200, FinesFixtures.overview()));
    expect(current().overview.period.id, 7);
    expect(current().selectedPeriodId, isNull);
    expect(current().isCurrentPeriod, isTrue);
  });

  test('laadfout komt als AsyncError', () async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http.on(_overview, 403, {'message': 'Geen toegang.'});
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(finesControllerProvider(3), (_, _) {});
    await expectLater(
      container.read(finesControllerProvider(3).future),
      throwsA(isA<ForbiddenException>()),
    );
  });

  test('periode wisselen vraagt ?period= en onthoudt hem', () async {
    final controller = await start(
      (http) => http.routes[_overview] = (request) {
        final period = request.options.uri.queryParameters['period'];
        return FakeResponse(
          200,
          FinesFixtures.overview(
            period == '6'
                ? {
                    'period': {
                      'id': 6,
                      'name': 'Q3 2026',
                      'closed_at': '2026-09-30T21:14:03+02:00',
                    },
                  }
                : const {},
          ),
        );
      },
    );

    expect(await controller.selectPeriod(6), isNull);
    expect(current().overview.period.id, 6);
    expect(current().selectedPeriodId, 6);
    expect(current().isCurrentPeriod, isFalse);

    // Verversen blijft in de gekozen periode.
    await controller.refresh();
    expect(
      backend.http.requests.last.options.uri.queryParameters['period'],
      '6',
    );
  });

  test('periodewissel mislukt: vorige periode blijft staan', () async {
    final controller = await start(
      (http) => http.on(_overview, 200, FinesFixtures.overview()),
    );
    backend.http.on(_overview, 500, {'message': 'Kapot'});

    final error = await controller.selectPeriod(6);

    expect(error, isA<ServerException>());
    expect(current().overview.period.id, 7);
    expect(current().switching, isFalse);
  });

  test('boete uitdelen: POST en daarna opnieuw ophalen', () async {
    final controller = await start((http) {
      http
        ..on(_overview, 200, FinesFixtures.treasurerOverview())
        ..on('POST /teams/3/fines', 201, FinesFixtures.recorded());
    });
    final before = overviewCalls();
    backend.http.on(
      _overview,
      200,
      FinesFixtures.treasurerOverview({
        'totals': {'open_cents': 450, 'all_cents': 950},
      }),
    );

    final result = await controller.recordFines(
      targets: const FineTargets(playerIds: [17, 18]),
      typeId: 35,
      amountCents: 100,
    );

    expect(result.error, isNull);
    expect(result.count, 2);
    expect(overviewCalls(), before + 1);
    expect(current().overview.totals.allCents, 950);
  });

  test('mislukte write: fout terug, geen refetch, data blijft', () async {
    final controller = await start((http) {
      http
        ..on(_overview, 200, FinesFixtures.treasurerOverview())
        ..on('POST /teams/3/fines', 422, {'message': 'Periode is afgesloten.'})
        ..on('DELETE /teams/3/fines/501', 403, {'message': 'Geen toegang.'});
    });
    final before = overviewCalls();

    final result = await controller.recordFines(
      targets: const FineTargets.everyone(),
      typeId: 35,
    );
    expect(
      result.error,
      isA<ValidationException>().having(
        (e) => e.message,
        'message',
        'Periode is afgesloten.',
      ),
    );
    expect(await controller.deleteFine(501), isA<ForbiddenException>());
    expect(overviewCalls(), before);
    expect(current().overview.canManage, isTrue);
  });

  test('boete bijwerken en verwijderen, potboekingen', () async {
    final controller = await start((http) {
      http
        ..on(_overview, 200, FinesFixtures.treasurerOverview())
        ..on('PATCH /teams/3/fines/501', 200, FinesFixtures.updated())
        ..on('DELETE /teams/3/fines/501', 204)
        ..on('POST /teams/3/fine-pot', 201, FinesFixtures.potEntryResponse())
        ..on(
          'PATCH /teams/3/fine-pot/12',
          200,
          FinesFixtures.potEntryResponse(),
        )
        ..on('DELETE /teams/3/fine-pot/12', 204);
    });
    final before = overviewCalls();
    final draft = PotEntryDraft(
      amountCents: 500,
      description: 'Statiegeld',
      occurredOn: DateTime(2026, 10, 9),
    );

    expect(await controller.updateFine(501, status: FineStatus.paid), isNull);
    expect(await controller.deleteFine(501), isNull);
    expect(await controller.createPotEntry(draft), isNull);
    expect(await controller.updatePotEntry(12, draft), isNull);
    expect(await controller.deletePotEntry(12), isNull);

    expect(overviewCalls(), before + 5);
  });

  test('persoonsdetail: speler of staf, met periode', () async {
    await start((http) {
      http
        ..on(_overview, 200, FinesFixtures.overview())
        ..on('GET /teams/3/fines/players/17', 200, FinesFixtures.player())
        ..on('GET /teams/3/fines/staff/4', 200, FinesFixtures.staff());
    });

    final player = await container.read(
      personFinesProvider((
        teamId: 3,
        id: 17,
        staff: false,
        periodId: 7,
      )).future,
    );
    expect(player.fines.single.id, 501);
    expect(
      backend.http.requests.last.options.uri.queryParameters['period'],
      '7',
    );

    final staff = await container.read(
      personFinesProvider((
        teamId: 3,
        id: 4,
        staff: true,
        periodId: null,
      )).future,
    );
    expect(staff.person.name, 'Coach Ronald');
  });
}
