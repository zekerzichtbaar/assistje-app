import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/event/application/event_detail_controller.dart';
import 'package:assistje/features/report/application/report_controller.dart';
import 'package:assistje/features/report/data/models/report_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'report_fixtures.dart';

const ReportKey _key = (teamId: 3, eventId: 412);

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<ReportController> start({
    Map<String, dynamic>? data,
    void Function(FakeHttpAdapter http)? setup,
  }) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http
      ..on(
        ReportFixtures.get,
        200,
        ReportFixtures.wrap(data ?? ReportFixtures.setsData()),
      )
      ..on(ReportFixtures.eventGet, 200, ReportFixtures.eventDetail());
    setup?.call(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(reportControllerProvider(_key), (_, _) {});
    await container.read(reportControllerProvider(_key).future);
    return container.read(reportControllerProvider(_key).notifier);
  }

  MatchReport current() =>
      container.read(reportControllerProvider(_key)).requireValue;

  int eventFetches() => backend.http.requestsTo(ReportFixtures.eventGet).length;

  test('laadt het verslag', () async {
    await start();
    expect(current().homeScore, 1);
    expect(current().players.map((p) => p.id), [37, 52]);
  });

  test('403 bij laden komt als AsyncError', () async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http.on(ReportFixtures.get, 403, {'message': 'Geen toegang.'});
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(reportControllerProvider(_key), (_, _) {});
    await expectLater(
      container.read(reportControllerProvider(_key).future),
      throwsA(isA<ForbiddenException>()),
    );
  });

  test(
    'saveScore neemt het teruggegeven verslag over en ververst het event',
    () async {
      final controller = await start(
        data: ReportFixtures.goalsData(),
        setup: (http) => http.on(
          ReportFixtures.score,
          200,
          ReportFixtures.wrap(ReportFixtures.goalsData(home: 4, away: 0)),
        ),
      );
      container.listen(eventDetailControllerProvider(_key), (_, _) {});
      await pumpEventQueue();
      final before = eventFetches();

      expect(await controller.saveScore(4, 0), isNull);

      expect(current().homeScore, 4);
      expect(current().awayScore, 0);
      await pumpEventQueue();
      expect(eventFetches(), before + 1);
    },
  );

  test('een mislukte write houdt de stand en geeft de fout terug', () async {
    final controller = await start(
      setup: (http) => http.on(ReportFixtures.sets, 422, {
        'message': 'Te veel sets.',
        'errors': {
          'sets': ['Te veel sets.'],
        },
      }),
    );
    final before = current();

    final error = await controller.saveSets(const [(home: 25, away: 20)]);

    expect(error, isA<ValidationException>());
    expect(current(), before);
  });

  test('saveSets neemt de server-uitslag over', () async {
    final controller = await start(
      setup: (http) => http.on(
        ReportFixtures.sets,
        200,
        ReportFixtures.wrap(
          ReportFixtures.setsData(
            away: 0,
            sets: const [
              [25, 10],
            ],
          ),
        ),
      ),
    );

    expect(await controller.saveSets(const [(home: 25, away: 10)]), isNull);

    expect(current().homeScore, 1);
    expect(current().sets.single.homePoints, 25);
  });

  test('savePlayerStats stuurt elke kolom (ontbrekend = 0)', () async {
    final controller = await start(
      setup: (http) => http.on(
        ReportFixtures.stats,
        200,
        ReportFixtures.wrap(
          ReportFixtures.setsData(
            playerStats: [
              {'player_id': 52, 'points': 7, 'aces': 0, 'blocks': 0},
            ],
          ),
        ),
      ),
    );

    expect(
      await controller.savePlayerStats({
        52: {'points': 7},
      }),
      isNull,
    );

    final body =
        backend.http.requestsTo(ReportFixtures.stats).single.body! as Map;
    final row = (body['stats'] as List).single as Map;
    expect(row['player_id'], 52);
    expect(row['points'], 7);
    expect(row.keys, hasLength(ReportFixtures.volleyColumns.length + 1));
    expect(row['attack_kills'], 0);
    expect(current().statsFor(52)['points'], 7);
  });

  test('applyScoutImport: eerst het blad, dan de sets', () async {
    final controller = await start(
      setup: (http) => http
        ..on(
          ReportFixtures.stats,
          200,
          ReportFixtures.wrap(ReportFixtures.setsData()),
        )
        ..on(
          ReportFixtures.sets,
          200,
          ReportFixtures.wrap(ReportFixtures.setsData(home: 0, away: 1)),
        ),
    );

    final error = await controller.applyScoutImport((
      stats: {
        37: {'points': 14},
      },
      sets: const [(home: 21, away: 25)],
    ));

    expect(error, isNull);
    final writes = [
      for (final r in backend.http.requests)
        if (r.method == 'PATCH') r.path.split('/').last,
    ];
    expect(writes, ['player-stats', 'sets']);
    expect(current().homeScore, 0);
  });

  test('applyScoutImport stopt bij een fout in het blad', () async {
    final controller = await start(
      setup: (http) => http.on(ReportFixtures.stats, 500, {'message': 'x'}),
    );

    final error = await controller.applyScoutImport((
      stats: {
        37: {'points': 14},
      },
      sets: const [(home: 21, away: 25)],
    ));

    expect(error, isA<ServerException>());
    expect(backend.http.requestsTo(ReportFixtures.sets), isEmpty);
  });

  group('vlaggersdienst', () {
    Future<FlagDutyController> startFlag() async {
      backend = TestBackend(token: '12|abc');
      await backend.init();
      backend.http
        ..on(
          ReportFixtures.eventGet,
          200,
          ReportFixtures.eventDetail(flag: ReportFixtures.flag()),
        )
        ..routes[ReportFixtures.flagPut] = ReportFixtures.echoFlag();
      container = backend.container();
      addTearDown(container.dispose);
      container.listen(flagDutyControllerProvider(_key), (_, _) {});
      await container.read(flagDutyControllerProvider(_key).future);
      return container.read(flagDutyControllerProvider(_key).notifier);
    }

    FlagDutyEdit? flag() =>
        container.read(flagDutyControllerProvider(_key)).value;

    test('save neemt het teruggegeven flag-veld over', () async {
      final controller = await startFlag();
      expect(flag()!.shifts, hasLength(2));

      final error = await controller.save(const [
        (playerId: 52, userId: null, fromMinute: 0),
      ]);

      expect(error, isNull);
      expect(flag()!.shifts.single.key, 'p52');
    });

    test('422 houdt de stand', () async {
      final controller = await startFlag();
      backend.http.on(ReportFixtures.flagPut, 422, {
        'message': 'Kies één vlagger per beurt.',
        'errors': {
          'shifts.0.player_id': ['Kies één vlagger per beurt.'],
        },
      });
      final before = flag();

      final error = await controller.save(const [
        (playerId: null, userId: null, fromMinute: 0),
      ]);

      expect(
        error,
        isA<ValidationException>().having(
          (e) => e.fieldError('shifts.0.player_id'),
          'field',
          'Kies één vlagger per beurt.',
        ),
      );
      expect(flag(), before);
    });
  });
}
