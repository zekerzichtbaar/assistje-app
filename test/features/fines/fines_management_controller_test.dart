import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/fines/application/fines_controller.dart';
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

  /// Het overzicht reageert op `?period=`: 6 is de afgesloten Q3.
  void periodAwareOverview(
    FakeHttpAdapter http, {
    Map<String, dynamic> current = const {},
  }) => http.routes[_overview] = (request) {
    final period = request.options.uri.queryParameters['period'];
    return FakeResponse(
      200,
      FinesFixtures.treasurerOverview(
        period == '6'
            ? {
                'period': {
                  'id': 6,
                  'name': 'Q3 2026',
                  'closed_at': '2026-09-30T21:14:03+02:00',
                },
              }
            : current,
      ),
    );
  };

  test('hernoemen haalt opnieuw op in de gekozen periode', () async {
    final controller = await start((http) {
      periodAwareOverview(http);
      http.on(
        'PATCH /teams/3/fine-periods/6',
        200,
        FinesFixtures.periodResponse({'id': 6, 'name': 'Zomer'}),
      );
    });
    await controller.selectPeriod(6);

    expect(await controller.renamePeriod(6, 'Zomer'), isNull);

    expect(
      backend.http.requests.last.options.uri.queryParameters['period'],
      '6',
    );
    expect(current().selectedPeriodId, 6);
  });

  test('nieuwe periode: daarna de lopende periode in beeld', () async {
    final controller = await start((http) {
      periodAwareOverview(http);
      http.on(
        'POST /teams/3/fine-periods',
        201,
        FinesFixtures.periodResponse(),
      );
    });
    await controller.selectPeriod(6);
    periodAwareOverview(
      backend.http,
      current: {'period': FinesFixtures.period8()},
    );
    final before = overviewCalls();

    expect(await controller.createPeriod('Voorjaar 2027'), isNull);

    expect(overviewCalls(), before + 1);
    expect(backend.http.requests.last.options.uri.queryParameters, isEmpty);
    expect(current().selectedPeriodId, isNull);
    expect(current().overview.period.id, 8);
  });

  test('afsluiten: POST close en de nieuwe lopende periode', () async {
    final controller = await start((http) {
      http
        ..on(_overview, 200, FinesFixtures.treasurerOverview())
        ..on(
          'POST /teams/3/fine-periods/7/close',
          200,
          FinesFixtures.closeResponse(),
        );
    });
    backend.http.on(
      _overview,
      200,
      FinesFixtures.treasurerOverview({
        'period': {'id': 9, 'name': 'Q1 2027', 'closed_at': null},
      }),
    );

    expect(await controller.closePeriod(7), isNull);
    expect(current().overview.period.id, 9);
  });

  test('bedragen, soorten toevoegen, bijwerken en weghalen', () async {
    final controller = await start((http) {
      http
        ..on(_overview, 200, FinesFixtures.treasurerOverview())
        ..on(
          'PATCH /teams/3/fine-settings',
          200,
          FinesFixtures.settingsResponse(),
        )
        ..on('POST /teams/3/fine-types', 201, FinesFixtures.fineTypeResponse())
        ..on(
          'PATCH /teams/3/fine-types/31',
          200,
          FinesFixtures.fineTypeResponse(id: 31, archived: true),
        )
        ..on('DELETE /teams/3/fine-types/35', 200, {
          'data': {'id': 35, 'archived': true},
        });
    });
    final before = overviewCalls();

    expect(await controller.updateFineSettings({31: 300, 35: 100}), isNull);
    expect(
      await controller.createFineType(label: 'Douchen', amountCents: 500),
      isNull,
    );
    expect(await controller.updateFineType(31, active: false), isNull);
    final deleted = await controller.deleteFineType(35);
    expect(deleted.error, isNull);
    expect(deleted.archived, isTrue);

    // Niet optimistisch: na elke write opnieuw opgehaald.
    expect(overviewCalls(), before + 4);
  });

  test('mislukte beheeractie: fout terug, geen refetch', () async {
    final controller = await start((http) {
      http
        ..on(_overview, 200, FinesFixtures.treasurerOverview())
        ..on('POST /teams/3/fine-periods/7/close', 403, {
          'message': 'Geen toegang.',
        })
        ..on('DELETE /teams/3/fine-types/31', 422, {
          'message': 'Automatische boetes kun je alleen uitzetten.',
        });
    });
    final before = overviewCalls();

    expect(await controller.closePeriod(7), isA<ForbiddenException>());
    final deleted = await controller.deleteFineType(31);
    expect(deleted.error, isA<ValidationException>());
    expect(deleted.archived, isFalse);
    expect(overviewCalls(), before);
    expect(current().overview.period.id, 7);
  });
}
