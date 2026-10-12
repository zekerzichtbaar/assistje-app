import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/stats/application/stats_controller.dart';
import 'package:assistje/features/stats/data/stats_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'stats_fixtures.dart';

const _stats = 'GET /teams/3/stats';

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  /// Antwoordt met het venster en seizoen uit de query (zoals de server).
  FakeResponse echo(RecordedRequest request) {
    final query = request.options.uri.queryParameters;
    final season = int.tryParse(query['season'] ?? '') ?? 4;
    return FakeResponse(
      200,
      StatsFixtures.response({
        'window': query['window'] ?? 'season',
        'season_id': season,
      }),
    );
  }

  Future<StatsController> start(
    void Function(FakeHttpAdapter http) setup,
  ) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(statsControllerProvider(3), (_, _) {});
    await container.read(statsControllerProvider(3).future);
    return container.read(statsControllerProvider(3).notifier);
  }

  StatsState current() =>
      container.read(statsControllerProvider(3)).requireValue;

  Map<String, String> lastQuery() =>
      backend.http.requestsTo(_stats).last.options.uri.queryParameters;

  test('laadt het lopende seizoen', () async {
    await start((http) => http.routes[_stats] = echo);
    expect(current().window, StatsWindow.season);
    expect(current().selectedSeasonId, isNull);
    expect(current().stats.seasonId, 4);
    expect(lastQuery(), isEmpty);
  });

  test('venster en seizoen wisselen en blijven bij verversen', () async {
    final controller = await start((http) => http.routes[_stats] = echo);

    expect(await controller.selectWindow(StatsWindow.last5), isNull);
    expect(current().window, StatsWindow.last5);
    expect(lastQuery(), {'window': '5'});

    expect(await controller.selectSeason(3), isNull);
    expect(current().selectedSeasonId, 3);
    expect(current().stats.seasonId, 3);
    expect(lastQuery(), {'window': '5', 'season': '3'});

    expect(await controller.refresh(), isNull);
    expect(lastQuery(), {'window': '5', 'season': '3'});
    expect(current().switching, isFalse);
  });

  test('hetzelfde venster kiezen doet geen verzoek', () async {
    final controller = await start((http) => http.routes[_stats] = echo);
    final before = backend.http.requestsTo(_stats).length;
    await controller.selectWindow(StatsWindow.season);
    await controller.selectSeason(4);
    expect(backend.http.requestsTo(_stats), hasLength(before));
  });

  test('fout bij wisselen: vorige stand blijft, fout terug', () async {
    final controller = await start((http) => http.routes[_stats] = echo);
    backend.http.on(_stats, 500, {'message': 'Kapot'});

    final error = await controller.selectWindow(StatsWindow.last10);

    expect(error, isA<ServerException>());
    expect(current().window, StatsWindow.season);
    expect(current().switching, isFalse);
  });

  test('laadfout (feature uit) komt als AsyncError', () async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http.on(_stats, 404, {'message': 'Not Found'});
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(statsControllerProvider(3), (_, _) {});
    await expectLater(
      container.read(statsControllerProvider(3).future),
      throwsA(isA<NotFoundException>()),
    );
  });
}
