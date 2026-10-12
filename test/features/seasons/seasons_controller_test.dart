import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/seasons/application/seasons_controller.dart';
import 'package:assistje/features/seasons/data/models/seasons_models.dart';
import 'package:assistje/features/settings/application/settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import '../settings/settings_fixtures.dart';
import 'seasons_fixtures.dart';

const _index = 'GET /teams/3/seasons';

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<SeasonsController> start([
    void Function(FakeHttpAdapter http)? setup,
  ]) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http
      ..on(_index, 200, SeasonsFixtures.response())
      ..on(
        'GET /me',
        200,
        ApiFixtures.meResponse(teams: [SeasonsFixtures.trainerMembership()]),
      );
    setup?.call(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(seasonsControllerProvider(3), (_, _) {});
    await container.read(seasonsControllerProvider(3).future);
    return container.read(seasonsControllerProvider(3).notifier);
  }

  SeasonsState current() =>
      container.read(seasonsControllerProvider(3)).requireValue;

  test('laadt de seizoensstaat', () async {
    await start();
    expect(current().data.season!.label, '26/27');
    expect(current().data.periods, hasLength(2));
    expect(current().writesForbidden, isFalse);
  });

  test('403 bij laden komt als AsyncError', () async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http.on(_index, 403, {'message': 'Nee.'});
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(seasonsControllerProvider(3), (_, _) {});
    await expectLater(
      container.read(seasonsControllerProvider(3).future),
      throwsA(isA<ForbiddenException>()),
    );
  });

  test('seizoen afsluiten: het antwoord wordt de nieuwe staat', () async {
    final controller = await start(
      (http) => http.on(
        'POST /teams/3/seasons/close',
        200,
        SeasonsFixtures.response(
          SeasonsFixtures.data(
            season: SeasonsFixtures.season(
              label: '27/28',
              startsOn: '2027-07-01',
              endsOn: '2028-06-30',
              matchCount: 0,
            ),
            closedSeason: {
              'label': '26/27',
              'closed_at': '2027-07-02T10:00:00+02:00',
            },
            periods: const [],
          ),
        ),
      ),
    );

    final result = await controller.closeSeason();

    expect(result.ok, isTrue);
    expect(current().data.season!.label, '27/28');
    expect(current().data.closedSeason!.label, '26/27');
    expect(current().data.periods, isEmpty);
  });

  test(
    'meta komt mee: heropenen (moved) en periode sluiten (titels)',
    () async {
      final controller = await start((http) {
        http
          ..on(
            'POST /teams/3/seasons/reopen',
            200,
            SeasonsFixtures.response(
              SeasonsFixtures.data(
                season: SeasonsFixtures.season(label: '25/26'),
                noClosedSeason: true,
              ),
              {'moved': 3},
            ),
          )
          ..on(
            'POST /teams/3/periods/42/close',
            200,
            SeasonsFixtures.response(
              SeasonsFixtures.data(
                periods: [SeasonsFixtures.period(isClosed: true, awards: 5)],
              ),
              {'award_count': 5},
            ),
          );
      });

      final reopened = await controller.reopenSeason();
      expect(reopened.meta.moved, 3);
      expect(current().data.season!.label, '25/26');
      expect(current().data.closedSeason, isNull);

      final closed = await controller.closePeriod(42);
      expect(closed.meta.awardCount, 5);
      expect(current().data.periods.single.isClosed, isTrue);
    },
  );

  test(
    'na een schrijfactie wordt de Instellingen-controller ververst',
    () async {
      final controller = await start((http) {
        http
          ..on('GET /teams/3/settings', 200, SettingsFixtures.response())
          ..on(
            'PATCH /teams/3/periods/mode',
            200,
            SeasonsFixtures.response(SeasonsFixtures.data(mode: 'dates')),
          );
      });
      container.listen(settingsControllerProvider(3), (_, _) {});
      await container.read(settingsControllerProvider(3).future);
      expect(backend.http.requestsTo('GET /teams/3/settings'), hasLength(1));

      final result = await controller.setMode(PeriodMode.dates);
      expect(result.ok, isTrue);
      expect(current().data.mode, PeriodMode.dates);

      await container.read(settingsControllerProvider(3).future);
      expect(backend.http.requestsTo('GET /teams/3/settings'), hasLength(2));
    },
  );

  test('dezelfde modus nog eens kiezen stuurt niets', () async {
    final controller = await start();
    final result = await controller.setMode(PeriodMode.matches);
    expect(result.ok, isTrue);
    expect(backend.http.requestsTo('PATCH /teams/3/periods/mode'), isEmpty);
  });

  test('422 laat de staat staan en geeft de fout terug', () async {
    final controller = await start(
      (http) => http.on('POST /teams/3/periods', 422, {
        'message': 'De naam is verplicht.',
        'errors': {
          'name': ['De naam is verplicht.'],
        },
      }),
    );
    final before = current().data;

    final result = await controller.createPeriod(
      const PeriodInput(name: '', startsOn: '2026-08-01', endsOn: '2026-12-31'),
    );

    expect(result.ok, isFalse);
    expect(result.error, isA<ValidationException>());
    expect(current().data, before);
    expect(current().writesForbidden, isFalse);
  });

  test(
    '403 op een schrijfactie: alleen-lezen, daarna niets meer versturen',
    () async {
      final controller = await start(
        (http) =>
            http.on('DELETE /teams/3/periods/42', 403, {'message': 'Demo.'}),
      );

      final first = await controller.deletePeriod(42);
      expect(first.error, isA<ForbiddenException>());
      expect(current().writesForbidden, isTrue);
      expect(current().data.periods, hasLength(2));

      final second = await controller.generate(count: 3);
      expect(second.error, isA<ForbiddenException>());
      expect(
        backend.http.requestsTo('POST /teams/3/periods/generate'),
        isEmpty,
      );
    },
  );

  test('verversen met data in beeld houdt die bij een fout', () async {
    final controller = await start();
    backend.http.on(_index, 500, {'message': 'Kapot.'});

    final error = await controller.refresh();

    expect(error, isA<ServerException>());
    expect(current().data.season!.label, '26/27');
  });
}
