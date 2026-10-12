import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/poule/application/poule_controller.dart';
import 'package:assistje/features/poule/data/poule_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'poule_fixtures.dart';

const _poule = 'GET /teams/3/poule';

void main() {
  late FakeHttpAdapter http;
  late PouleRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = PouleRepository(
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

  test('leest het voorbeeld uit docs/api/v1/poule.md', () async {
    http.on(_poule, 200, PouleFixtures.poule());

    final poule = await repository.fetch(3);

    expect(poule.pouleLabel, '2e klasse H');
    expect(poule.competition, 'Mannen zaterdag reserve');
    expect(poule.fetchedAt, DateTime.parse('2026-10-10T12:05:00Z'));
    expect(poule.neverSynced, isFalse);
    final own = poule.standing.first;
    expect(own.position, 1);
    expect(own.isOwn, isTrue);
    expect(own.goalsFor, 14);
    expect(own.goalDiff, 10);
    expect(own.logo, startsWith('https://'));
    expect(poule.standing.last.logo, isNull);
    final result = poule.results.single.matches.single;
    expect(result.score, '1-3');
    expect(result.awayIsOwn, isTrue);
    expect(result.homeIsOwn, isFalse);
    expect(result.eventId, 812);
    final fixture = poule.fixtures.single.matches.single;
    expect(fixture.score, isNull);
    expect(fixture.time, '12:00');
    expect(fixture.eventId, isNull);
    expect(poule.resultsPush?.canPush, isTrue);
  });

  test('nog nooit gesynct: fetched_at null en lege lijsten', () async {
    http.on(_poule, 200, PouleFixtures.neverSynced());
    final poule = await repository.fetch(3);
    expect(poule.neverSynced, isTrue);
    expect(poule.standing, isEmpty);
  });

  test('geen poulecode → NotFoundException', () async {
    http.on(_poule, 404, {'message': 'Not found.'});
    await expectLater(repository.fetch(3), throwsA(isA<NotFoundException>()));
  });

  group('controller', () {
    test('laadt en ververst; fout bij verversen houdt de data', () async {
      final backend = TestBackend(token: '12|abc');
      await backend.init();
      backend.http.on(_poule, 200, PouleFixtures.poule());
      final container = backend.container();
      addTearDown(container.dispose);
      container.listen(pouleControllerProvider(3), (_, _) {});

      final first = await container.read(pouleControllerProvider(3).future);
      expect(first.standing, hasLength(2));

      backend.http.on(_poule, 500, {'message': 'Kapot.'});
      final error = await container
          .read(pouleControllerProvider(3).notifier)
          .refresh();
      expect(error, isA<ServerException>());
      expect(
        container.read(pouleControllerProvider(3)).value?.standing,
        hasLength(2),
      );

      backend.http.on(_poule, 200, PouleFixtures.neverSynced());
      expect(
        await container.read(pouleControllerProvider(3).notifier).refresh(),
        isNull,
      );
      expect(
        container.read(pouleControllerProvider(3)).value?.neverSynced,
        isTrue,
      );
    });
  });
}
