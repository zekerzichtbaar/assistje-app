import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/duties/application/duties_controller.dart';
import 'package:assistje/features/duties/data/duties_repository.dart';
import 'package:assistje/features/duties/data/models/duties_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'duties_fixtures.dart';

const _index = 'GET /teams/3/duties';

/// Antwoordt per `?type=`: `wassen` → groepen, anders het individuele type.
FakeResponse _byType(RecordedRequest r) => FakeResponse(
  200,
  r.options.uri.queryParameters['type'] == 'wassen'
      ? DutiesFixtures.groups()
      : DutiesFixtures.individual(),
);

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<DutiesController> start(
    void Function(FakeHttpAdapter http) setup,
  ) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(dutiesControllerProvider(3), (_, _) {});
    await container.read(dutiesControllerProvider(3).future);
    return container.read(dutiesControllerProvider(3).notifier);
  }

  DutiesOverview current() =>
      container.read(dutiesControllerProvider(3)).requireValue;

  List<RecordedRequest> indexCalls() => backend.http.requestsTo(_index);

  test('laadt het eerste type', () async {
    await start((http) => http.routes[_index] = _byType);
    expect(current().type, 'vlaggen');
    expect(indexCalls().last.options.uri.queryParameters, isEmpty);
  });

  test('403 en 404 komen als AsyncError', () async {
    for (final (status, matcher) in [
      (403, isA<ForbiddenException>()),
      (404, isA<NotFoundException>()),
    ]) {
      backend = TestBackend(token: '12|abc');
      await backend.init();
      backend.http.on(_index, status, {'message': 'Nee.'});
      container = backend.container();
      addTearDown(container.dispose);
      container.listen(dutiesControllerProvider(3), (_, _) {});
      await expectLater(
        container.read(dutiesControllerProvider(3).future),
        throwsA(matcher),
      );
    }
  });

  test(
    'van type wisselen haalt ?type= op en verversen blijft daarop',
    () async {
      final controller = await start((http) => http.routes[_index] = _byType);

      expect(await controller.selectType('wassen'), isNull);
      expect(current().type, 'wassen');
      expect(current().groups, hasLength(2));

      await controller.refresh();
      expect(indexCalls().last.options.uri.queryParameters, {'type': 'wassen'});
      expect(current().type, 'wassen');
    },
  );

  test('mislukte wissel laat het vorige type staan', () async {
    final controller = await start((http) => http.routes[_index] = _byType);
    backend.http.on(_index, 500, {'message': 'Kapot.'});

    expect(await controller.selectType('wassen'), isA<ServerException>());
    expect(current().type, 'vlaggen');
  });

  test('groep aanmaken stuurt het type mee en ververst', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, DutiesFixtures.groups())
        ..on('POST /teams/3/duties/groups', 201, DutiesFixtures.savedGroup());
    });

    final before = indexCalls().length;
    expect(await controller.createGroup('Groep C', ['p_17']), isNull);
    expect(backend.http.requestsTo('POST /teams/3/duties/groups').single.body, {
      'duty_type_id': 1,
      'name': 'Groep C',
      'member_keys': ['p_17'],
    });
    expect(indexCalls(), hasLength(before + 1));
  });

  test('groep omlaag schuiven stuurt de nieuwe volgorde', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, DutiesFixtures.groups())
        ..on('POST /teams/3/duties/groups/reorder', 204);
    });

    expect(await controller.moveGroup(7, 1), isNull);
    expect(
      backend.http
          .requestsTo('POST /teams/3/duties/groups/reorder')
          .single
          .body,
      {
        'ids': [8, 7],
      },
    );
    // Bovenste groep kan niet verder omhoog: geen verzoek.
    await controller.moveGroup(7, -1);
    expect(
      backend.http.requestsTo('POST /teams/3/duties/groups/reorder'),
      hasLength(1),
    );
  });

  test('een mislukte actie geeft de fout terug en ververst niet', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, DutiesFixtures.individual())
        ..on('POST /teams/3/duties/assignments', 422, {
          'message': 'Kies wie de dienst doet.',
          'errors': {
            'member_key': ['Kies wie de dienst doet.'],
          },
        });
    });

    final before = indexCalls().length;
    final error = await controller.storeAssignments(
      const DutyAssignmentDraft(
        dutyTypeId: 3,
        mode: 'individual',
        dates: [DutyDateRow(eventId: 812)],
      ),
    );
    expect(error, isA<ValidationException>());
    expect(indexCalls(), hasLength(before));
  });

  test('verdelen geeft de melding en ververst', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, DutiesFixtures.individual())
        ..on(
          'POST /teams/3/duties/auto-assign',
          200,
          DutiesFixtures.autoAssigned(),
        );
    });

    final before = indexCalls().length;
    final (error, message) = await controller.autoAssign();
    expect(error, isNull);
    expect(message, '2 wedstrijden ingedeeld.');
    expect(indexCalls(), hasLength(before + 1));
  });

  test('afvinken en verwijderen verversen', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, DutiesFixtures.individual())
        ..on(
          'POST /teams/3/duties/assignments/120/done',
          200,
          DutiesFixtures.savedAssignment(),
        )
        ..on('DELETE /teams/3/duties/assignments/120', 204);
    });

    final before = indexCalls().length;
    expect(await controller.toggleDone(120), isNull);
    expect(await controller.deleteAssignment(120), isNull);
    expect(indexCalls(), hasLength(before + 2));
  });
}
