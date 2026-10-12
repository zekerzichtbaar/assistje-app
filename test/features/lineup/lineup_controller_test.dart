import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/event/application/event_detail_controller.dart';
import 'package:assistje/features/lineup/application/lineup_controller.dart';
import 'package:assistje/features/lineup/data/models/lineup_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'lineup_fixtures.dart';

const LineupKey _key = (teamId: 3, eventId: 412);

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<void> boot(void Function(FakeHttpAdapter http) setup) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(lineupControllerProvider(_key), (_, _) {});
  }

  Future<LineupController> start({
    Map<String, dynamic>? lineup,
    void Function(FakeHttpAdapter http)? setup,
  }) async {
    await boot((http) {
      http
        ..on(LineupFixtures.get, 200, lineup ?? LineupFixtures.response())
        ..routes[LineupFixtures.patch] = LineupFixtures.echoSave();
      setup?.call(http);
    });
    await container.read(lineupControllerProvider(_key).future);
    return container.read(lineupControllerProvider(_key).notifier);
  }

  Lineup current() =>
      container.read(lineupControllerProvider(_key)).requireValue;

  Map<String, int?> onField() => {
    for (final entry in current().assignments.entries)
      if (entry.value != null) entry.key: entry.value!.id,
  };

  Object? lastPatch() =>
      backend.http.requestsTo(LineupFixtures.patch).last.body;

  test('laadt de opstelling', () async {
    await start();
    expect(onField(), {'GK': 11, 'ST': 37});
    expect(current().bench.map((p) => p.id), [52, 60]);
  });

  test('403 bij laden komt als AsyncError', () async {
    await boot((http) => http.on(LineupFixtures.get, 403, {'message': 'x'}));
    await expectLater(
      container.read(lineupControllerProvider(_key).future),
      throwsA(isA<ForbiddenException>()),
    );
  });

  test(
    'bankspeler neerzetten is meteen zichtbaar en wordt opgeslagen',
    () async {
      final controller = await start();

      final done = controller.place('CB', 60);
      // Optimistisch: vóór het antwoord staat hij er al.
      expect(onField(), {'GK': 11, 'CB': 60, 'ST': 37});
      expect(await done, isNull);

      expect(lastPatch(), {
        'slots': [
          {'slot_code': 'GK', 'player_id': 11},
          {'slot_code': 'CB', 'player_id': 60},
          {'slot_code': 'ST', 'player_id': 37},
        ],
        'captain_player_id': 37,
      });
      expect(onField(), {'GK': 11, 'CB': 60, 'ST': 37});
    },
  );

  test('van positie naar bezette positie: de twee ruilen', () async {
    final controller = await start();
    await controller.place('ST', 11);
    expect(onField(), {'GK': 37, 'ST': 11});
  });

  test(
    'van de bank naar bezette positie: de zittende gaat naar de bank',
    () async {
      final controller = await start();
      await controller.place('ST', 52);
      expect(onField(), {'GK': 11, 'ST': 52});
      expect(current().bench.map((p) => p.id), containsAll([37, 60]));
      // De C stond op 37: die ging van het veld, dus de C ook.
      expect(current().captainPlayerId, isNull);
      expect((lastPatch()! as Map)['captain_player_id'], isNull);
    },
  );

  test('van het veld halen', () async {
    final controller = await start();
    await controller.remove('GK');
    expect(onField(), {'ST': 37});
  });

  test('C geven en afnemen', () async {
    final controller = await start();
    await controller.toggleCaptain(11);
    expect(current().captainPlayerId, 11);
    expect((lastPatch()! as Map)['captain_player_id'], 11);

    await controller.toggleCaptain(11);
    expect(current().captainPlayerId, isNull);
  });

  test('het serverantwoord wint (vaste aanvoerder krijgt de C)', () async {
    final controller = await start(
      setup: (http) => http.on(
        LineupFixtures.patch,
        200,
        LineupFixtures.response(
          slots: const [('GK', 11), ('ST', 37), ('CB', 60)],
          captain: 60,
        ),
      ),
    );
    await controller.place('CB', 60);
    expect(current().captainPlayerId, 60);
  });

  test('opslaan mislukt: terug naar de laatste bevestigde stand', () async {
    final controller = await start(
      setup: (http) =>
          http.on(LineupFixtures.patch, 500, {'message': 'Kapot.'}),
    );

    final error = await controller.place('CB', 60);

    expect(error, isA<ServerException>());
    expect(onField(), {'GK': 11, 'ST': 37});
  });

  test('snelle drops gaan op volgorde naar de server', () async {
    final controller = await start();
    final first = controller.place('CB', 60);
    final second = controller.place('LB', 52);
    expect(await first, isNull);
    expect(await second, isNull);

    final bodies = backend.http.requestsTo(LineupFixtures.patch);
    expect(bodies, hasLength(2));
    expect(
      ((bodies.last.body! as Map)['slots'] as List).map(
        (s) => (s as Map)['slot_code'],
      ),
      ['GK', 'LB', 'CB', 'ST'],
    );
    expect(onField(), {'GK': 11, 'LB': 52, 'CB': 60, 'ST': 37});
  });

  test('gedeelde opstelling wijzigen: lokaal meteen "aangepast"', () async {
    final controller = await start(
      lineup: LineupFixtures.response(publishedAt: '2026-10-11T19:02:11Z'),
      setup: (http) => http.routes[LineupFixtures.patch] =
          LineupFixtures.echoSave(publishedAt: '2026-10-11T19:02:11Z'),
    );
    final done = controller.place('CB', 60);
    expect(current().changedSincePublish, isTrue);
    await done;
    expect(current().changedSincePublish, isTrue);
  });

  test('alles van het veld: delen is ingetrokken', () async {
    final controller = await start(
      lineup: LineupFixtures.response(
        slots: const [('GK', 11)],
        captain: null,
        publishedAt: '2026-10-11T19:02:11Z',
      ),
    );
    final done = controller.remove('GK');
    expect(current().isShared, isFalse);
    await done;
    expect(current().isShared, isFalse);
  });

  test('formatie wisselen neemt de nieuwe posities over', () async {
    final controller = await start(
      setup: (http) => http.on(
        LineupFixtures.formation,
        200,
        LineupFixtures.response(formation: '4-4-2'),
      ),
    );
    expect(await controller.changeFormation('4-4-2'), isNull);
    expect(current().formation, '4-4-2');
    expect(current().formationSlots.map((s) => s.code), [
      'GK',
      'CB',
      'LS',
      'RS',
    ]);
    // Zelfde formatie: geen verzoek.
    await controller.changeFormation('4-4-2');
    expect(backend.http.requestsTo(LineupFixtures.formation), hasLength(1));
  });

  test('delen zet published_at en ververst het event-detail', () async {
    final controller = await start(
      setup: (http) => http
        ..on(
          LineupFixtures.publish,
          200,
          LineupFixtures.response(publishedAt: '2026-10-11T19:02:11Z'),
        )
        ..on('GET /teams/3/events/412', 200, {'data': <String, dynamic>{}}),
    );
    int detailCalls() =>
        backend.http.requestsTo('GET /teams/3/events/412').length;
    Future<void> loadDetail() => container
        .read(eventDetailControllerProvider(_key).future)
        .then((_) {}, onError: (Object _) {});
    container.listen(eventDetailControllerProvider(_key), (_, _) {});
    await loadDetail();
    final before = detailCalls();

    expect(await controller.publish(), isNull);
    expect(current().isShared, isTrue);
    await loadDetail();
    expect(detailCalls(), before + 1);
  });

  test('leeg delen: 422 met boodschap, stand ongewijzigd', () async {
    final controller = await start(
      setup: (http) => http.on(LineupFixtures.publish, 422, {
        'message': 'Er staat nog niemand in de opstelling.',
      }),
    );
    final error = await controller.publish();
    expect(
      error,
      isA<ValidationException>().having(
        (e) => e.message,
        'message',
        'Er staat nog niemand in de opstelling.',
      ),
    );
    expect(current().isShared, isFalse);
  });

  test('assignPlayer: zelfde plek is een no-op', () {
    const player = LineupPlayer(id: 1, name: 'A');
    final next = assignPlayer({'GK': player, 'ST': null}, 'GK', player);
    expect(next, {'GK': player, 'ST': null});
  });
}
