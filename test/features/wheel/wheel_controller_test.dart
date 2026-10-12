import 'dart:math';

import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/wheel/application/wheel_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'wheel_fixtures.dart';

const _index = 'GET /teams/3/wheel';

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<WheelController> start([
    void Function(FakeHttpAdapter http)? setup,
  ]) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http.on(_index, 200, WheelFixtures.overview());
    setup?.call(backend.http);
    container = ProviderContainer(
      overrides: [
        ...backend.overrides,
        wheelRandomProvider.overrideWithValue(Random(7)),
      ],
      retry: (_, _) => null,
    );
    addTearDown(container.dispose);
    container.listen(wheelControllerProvider(3), (_, _) {});
    await container.read(wheelControllerProvider(3).future);
    return container.read(wheelControllerProvider(3).notifier);
  }

  WheelState current() =>
      container.read(wheelControllerProvider(3)).requireValue;

  test('vulknoppen: team, aanwezig (incl. staf), bank, wis', () async {
    final controller = await start();

    expect(current().teamKeys, ['p17', 'p18', 'p21']);
    // p99 bestaat niet (meer): valt weg.
    expect(current().presentKeys, ['p17', 'p18', 'u4']);
    expect(current().benchKeys, ['p21']);

    controller.fill(current().teamKeys);
    expect(current().candidates.map((c) => c.key), ['p17', 'p18', 'p21']);
    controller.toggle('p30');
    controller.toggle('p17');
    expect(current().candidates.map((c) => c.key), ['p18', 'p21', 'p30']);
    controller.fill(current().presentKeys);
    expect(current().selected, {'p17', 'p18', 'u4'});
    controller.fill(['p17', 'nope']);
    expect(current().selected, {'p17'});
    controller.clear();
    expect(current().candidates, isEmpty);
  });

  test('winnaar kiezen kan pas vanaf twee deelnemers', () async {
    final controller = await start();
    controller.toggle('p17');
    expect(controller.pickWinnerIndex(), isNull);
    controller.toggle('p18');
    final index = controller.pickWinnerIndex();
    expect(index, isNotNull);
    expect(index, inInclusiveRange(0, 1));
  });

  test('draai vastleggen onthoudt de draai en ververst', () async {
    final controller = await start((http) {
      http.on('POST /teams/3/wheel/spin', 201, {
        'data': WheelFixtures.spin(id: 32, eventId: null, winnerPlayerId: 17),
      });
    });
    controller.fill(['p17', 'p18']);
    backend.http.on(
      _index,
      200,
      WheelFixtures.overview(
        spins: [
          WheelFixtures.spin(id: 32, eventId: null),
          WheelFixtures.spin(),
        ],
      ),
    );

    final state = current();
    final result = await controller.recordSpin(
      winner: state.candidates.first,
      candidates: state.candidates,
    );

    expect(result.error, isNull);
    expect(result.spin?.id, 32);
    expect(current().lastSpinId, 32);
    expect(current().lastSpin?.eventId, isNull);
    expect(current().overview.recentSpins, hasLength(2));
    // De selectie blijft staan.
    expect(current().selected, {'p17', 'p18'});
  });

  test('mislukte draai geeft de fout terug', () async {
    final controller = await start((http) {
      http.on('POST /teams/3/wheel/spin', 422, {
        'message': 'Deze persoon hoort niet bij de staf van dit team.',
        'errors': {
          'winner_user_id': [
            'Deze persoon hoort niet bij de staf van dit team.',
          ],
        },
      });
    });
    controller.fill(['p17', 'u4']);
    final state = current();

    final result = await controller.recordSpin(
      winner: state.candidates.last,
      candidates: state.candidates,
    );

    expect(result.error, isA<ValidationException>());
    expect(current().lastSpinId, isNull);
  });

  test('de laatste draai verwijderen vergeet hem', () async {
    final controller = await start((http) {
      http
        ..on('POST /teams/3/wheel/spin', 201, {
          'data': WheelFixtures.spin(id: 32, eventId: null),
        })
        ..on('DELETE /teams/3/wheel/spin/32', 204);
    });
    controller.fill(['p17', 'p18']);
    final state = current();
    await controller.recordSpin(
      winner: state.candidates.first,
      candidates: state.candidates,
    );
    expect(current().lastSpinId, 32);

    expect(await controller.deleteSpin(32), isNull);
    expect(current().lastSpinId, isNull);
  });

  test('koppelen zonder wedstrijd: 422 terug', () async {
    final controller = await start((http) {
      http.on('POST /teams/3/wheel/spin/31/assign', 422, {
        'message': 'Geen aankomende wedstrijd binnen 7 dagen.',
        'errors': {
          'wheel': ['Geen aankomende wedstrijd binnen 7 dagen.'],
        },
      });
    });
    expect(await controller.assign(31), isA<ValidationException>());
  });
}
