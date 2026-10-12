import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/hall_of_fame/application/hall_of_fame_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'hall_of_fame_fixtures.dart';

const _hof = 'GET /teams/3/hall-of-fame';

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  /// Antwoordt met het seizoen en de periode uit de query.
  FakeResponse echo(RecordedRequest request) {
    final query = request.options.uri.queryParameters;
    return FakeResponse(200, {
      'data': HallOfFameFixtures.rich({
        'season_id': int.tryParse(query['season'] ?? '') ?? 4,
        'period_id': int.tryParse(query['period'] ?? ''),
      }),
    });
  }

  Future<HallOfFameController> start(
    void Function(FakeHttpAdapter http) setup,
  ) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(hallOfFameControllerProvider(3), (_, _) {});
    await container.read(hallOfFameControllerProvider(3).future);
    return container.read(hallOfFameControllerProvider(3).notifier);
  }

  HallOfFameState current() =>
      container.read(hallOfFameControllerProvider(3)).requireValue;

  Map<String, String> lastQuery() =>
      backend.http.requestsTo(_hof).last.options.uri.queryParameters;

  test('laadt het lopende seizoen, heel seizoen', () async {
    await start((http) => http.routes[_hof] = echo);
    expect(current().hallOfFame.seasonId, 4);
    expect(current().selectedPeriodId, isNull);
    expect(lastQuery(), isEmpty);
  });

  test('periode kiezen, verversen, en terug naar heel seizoen', () async {
    final controller = await start((http) => http.routes[_hof] = echo);

    expect(await controller.selectPeriod(2), isNull);
    expect(current().selectedPeriodId, 2);
    expect(current().hallOfFame.period?.name, 'Blok 1');
    expect(lastQuery(), {'period': '2'});

    expect(await controller.refresh(), isNull);
    expect(lastQuery(), {'period': '2'});

    expect(await controller.selectPeriod(null), isNull);
    expect(current().selectedPeriodId, isNull);
    expect(lastQuery(), isEmpty);
  });

  test('ander seizoen zet de periode terug', () async {
    final controller = await start((http) => http.routes[_hof] = echo);
    await controller.selectPeriod(2);

    expect(await controller.selectSeason(3), isNull);

    expect(current().selectedSeasonId, 3);
    expect(current().selectedPeriodId, isNull);
    expect(lastQuery(), {'season': '3'});

    await controller.selectPeriod(1);
    expect(lastQuery(), {'season': '3', 'period': '1'});
  });

  test('fout bij wisselen: vorige stand blijft', () async {
    final controller = await start((http) => http.routes[_hof] = echo);
    backend.http.on(_hof, 500, {'message': 'Kapot'});

    final error = await controller.selectPeriod(2);

    expect(error, isA<ServerException>());
    expect(current().selectedPeriodId, isNull);
    expect(current().switching, isFalse);
  });

  test('laadfout komt als AsyncError', () async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http.on(_hof, 404, {'message': 'Not Found'});
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(hallOfFameControllerProvider(3), (_, _) {});
    await expectLater(
      container.read(hallOfFameControllerProvider(3).future),
      throwsA(isA<NotFoundException>()),
    );
  });
}
