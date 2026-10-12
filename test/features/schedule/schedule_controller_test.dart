import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/agenda/application/agenda_controller.dart';
import 'package:assistje/features/event/application/event_detail_controller.dart';
import 'package:assistje/features/schedule/application/schedule_controller.dart';
import 'package:assistje/features/schedule/data/models/schedule_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'schedule_fixtures.dart';

const _base = '/teams/3/schedule';
const _agenda = 'GET /teams/3/agenda';
const _detail = 'GET /teams/3/events/498';
const EventKey _key = (teamId: 3, eventId: 498);

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<void> start(void Function(FakeHttpAdapter http) setup) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http
      ..on(_agenda, 200, ApiFixtures.emptyAgendaResponse())
      ..on('GET $_base/options', 200, ScheduleFixtures.options())
      ..on(
        _detail,
        200,
        ScheduleFixtures.write(ScheduleFixtures.trainingData()),
      );
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
  }

  final draft = ScheduleDraft(
    type: ScheduleType.training,
    startsAt: DateTime(2099, 11, 12, 19, 30),
  );

  /// Houdt agenda en detail actief en laadt ze één keer.
  Future<void> watchDependents() async {
    container
      ..listen(agendaControllerProvider(3), (_, _) {})
      ..listen(eventDetailControllerProvider(_key), (_, _) {})
      ..listen(scheduleEventProvider(_key), (_, _) {});
    await container.read(agendaControllerProvider(3).future);
    await container.read(eventDetailControllerProvider(_key).future);
    await container.read(scheduleEventProvider(_key).future);
  }

  test('formulier nieuw: alleen de opties', () async {
    await start((_) {});
    const ScheduleFormKey key = (teamId: 3, eventId: null);
    container.listen(scheduleFormControllerProvider(key), (_, _) {});

    final data = await container.read(
      scheduleFormControllerProvider(key).future,
    );

    expect(data.isEdit, isFalse);
    expect(data.options.teamName, 'Valleivogels 3');
    expect(backend.http.requestsTo(_detail), isEmpty);
  });

  test('formulier bewerken: opties en het event; opslaan = PATCH', () async {
    await start(
      (http) => http.on(
        'PATCH $_base/498',
        200,
        ScheduleFixtures.write(ScheduleFixtures.trainingData(), {
          'following_updated': 2,
        }),
      ),
    );
    const ScheduleFormKey key = (teamId: 3, eventId: 498);
    container.listen(scheduleFormControllerProvider(key), (_, _) {});
    final data = await container.read(
      scheduleFormControllerProvider(key).future,
    );
    expect(data.isEdit, isTrue);
    expect(data.event!.title, 'Conditie');

    final outcome = await container
        .read(scheduleFormControllerProvider(key).notifier)
        .save(draft);

    expect(outcome.error, isNull);
    expect(outcome.result!.followingUpdated, 2);
    expect(backend.http.requestsTo('PATCH $_base/498'), hasLength(1));
  });

  test('aanmaken ververst de agenda', () async {
    await start(
      (http) => http.on(
        'POST $_base',
        201,
        ScheduleFixtures.write(ScheduleFixtures.trainingData(), {
          'created_ids': [498],
          'adopted_ids': <int>[],
        }),
      ),
    );
    await watchDependents();
    final agendaBefore = backend.http.requestsTo(_agenda).length;

    final outcome = await container
        .read(scheduleWriterProvider)
        .create(3, draft);
    expect(outcome.result!.event.id, 498);

    await container.read(agendaControllerProvider(3).future);
    expect(backend.http.requestsTo(_agenda).length, agendaBefore + 1);
  });

  test('afgelasten ververst agenda, detail en formuliervelden', () async {
    await start(
      (http) => http.on(
        'POST $_base/498/cancel',
        200,
        ScheduleFixtures.write(
          ScheduleFixtures.trainingData({
            'cancelled_at': '2099-11-10T09:12:44+01:00',
          }),
        ),
      ),
    );
    await watchDependents();
    final agendaBefore = backend.http.requestsTo(_agenda).length;
    final detailsBefore = backend.http.requestsTo(_detail).length;

    final outcome = await container.read(scheduleWriterProvider).cancel(3, 498);
    expect(outcome.result!.event.isCancelled, isTrue);

    await container.read(agendaControllerProvider(3).future);
    await container.read(eventDetailControllerProvider(_key).future);
    await container.read(scheduleEventProvider(_key).future);
    expect(backend.http.requestsTo(_agenda).length, agendaBefore + 1);
    // Detail en formuliervelden halen allebei opnieuw op.
    expect(backend.http.requestsTo(_detail).length, detailsBefore + 2);
  });

  test('fout: niets ververst, de fout komt terug', () async {
    await start(
      (http) =>
          http.on('DELETE $_base/498/cancel', 403, {'message': 'Bondsevent.'}),
    );
    await watchDependents();
    final agendaBefore = backend.http.requestsTo(_agenda).length;

    final outcome = await container
        .read(scheduleWriterProvider)
        .uncancel(3, 498);

    expect(outcome.result, isNull);
    expect(outcome.error, isA<ForbiddenException>());
    await container.read(agendaControllerProvider(3).future);
    expect(backend.http.requestsTo(_agenda).length, agendaBefore);
  });

  test('verwijderen ververst de agenda maar niet het detail', () async {
    await start((http) => http.on('DELETE $_base/498', 204));
    await watchDependents();
    final agendaBefore = backend.http.requestsTo(_agenda).length;
    final detailsBefore = backend.http.requestsTo(_detail).length;

    final error = await container.read(scheduleWriterProvider).delete(3, 498);

    expect(error, isNull);
    await container.read(agendaControllerProvider(3).future);
    expect(backend.http.requestsTo(_agenda).length, agendaBefore + 1);
    expect(backend.http.requestsTo(_detail).length, detailsBefore);
  });
}
