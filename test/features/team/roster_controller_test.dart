import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/team/application/roster_controller.dart';
import 'package:assistje/features/team/data/models/roster_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'roster_fixtures.dart';

const _roster = 'GET /teams/3/team';

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<void> start(void Function(FakeHttpAdapter http) setup) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(rosterControllerProvider(3), (_, _) {});
  }

  RosterController controller() =>
      container.read(rosterControllerProvider(3).notifier);

  TeamRoster current() =>
      container.read(rosterControllerProvider(3)).requireValue;

  test('laadt de selectie van het team', () async {
    await start((http) => http.on(_roster, 200, RosterFixtures.roster()));
    await container.read(rosterControllerProvider(3).future);
    expect(current().players, hasLength(2));
    expect(current().coaches, hasLength(1));
  });

  test('laadfout komt als AsyncError; refresh herstelt', () async {
    await start((http) => http.on(_roster, 500, {'message': 'Kapot.'}));
    await expectLater(
      container.read(rosterControllerProvider(3).future),
      throwsA(isA<ApiException>()),
    );

    backend.http.on(_roster, 200, RosterFixtures.roster());
    final error = await controller().refresh();

    expect(error, isNull);
    expect(current().players.first.name, 'Sam de Vries');
  });

  test('refresh haalt opnieuw op en houdt data bij een fout', () async {
    await start((http) => http.on(_roster, 200, RosterFixtures.roster()));
    await container.read(rosterControllerProvider(3).future);

    final before = backend.http.requestsTo(_roster).length;
    backend.http.on(
      _roster,
      200,
      RosterFixtures.roster(players: [RosterFixtures.sam()], coaches: []),
    );
    expect(await controller().refresh(), isNull);
    expect(current().players, hasLength(1));
    expect(current().coaches, isEmpty);
    expect(backend.http.requestsTo(_roster), hasLength(before + 1));

    backend.http.on(_roster, 500, {'message': 'Kapot.'});
    final error = await controller().refresh();
    expect(error, isA<ApiException>());
    expect(current().players, hasLength(1));
  });
}
