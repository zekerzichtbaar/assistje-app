import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/players/application/player_detail_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';
import '../team/roster_fixtures.dart';

const _detail = 'GET /teams/3/players/14';
const PlayerKey _key = (teamId: 3, playerId: 14);

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  setUp(() async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    container = backend.container();
    addTearDown(container.dispose);
  });

  test('laadt het detail van de speler', () async {
    backend.http.on(_detail, 200, RosterFixtures.playerDetail());
    container.listen(playerDetailControllerProvider(_key), (_, _) {});

    final detail = await container.read(
      playerDetailControllerProvider(_key).future,
    );

    expect(detail.player.name, 'Sam de Vries');
  });

  test('404 als AsyncError; refresh houdt data bij een fout', () async {
    backend.http.on(_detail, 404, {'message': 'Niet gevonden.'});
    container.listen(playerDetailControllerProvider(_key), (_, _) {});
    await expectLater(
      container.read(playerDetailControllerProvider(_key).future),
      throwsA(isA<NotFoundException>()),
    );

    final notifier = container.read(
      playerDetailControllerProvider(_key).notifier,
    );
    backend.http.on(_detail, 200, RosterFixtures.managedPlayerDetail());
    expect(await notifier.refresh(), isNull);
    expect(
      container
          .read(playerDetailControllerProvider(_key))
          .requireValue
          .canManage,
      isTrue,
    );

    backend.http.on(_detail, 500, {'message': 'Kapot.'});
    expect(await notifier.refresh(), isA<ApiException>());
    expect(
      container
          .read(playerDetailControllerProvider(_key))
          .requireValue
          .canManage,
      isTrue,
    );
  });
}
