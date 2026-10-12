import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/agenda/data/models/agenda_models.dart';
import 'package:assistje/features/attendance/application/attendance_controller.dart';
import 'package:assistje/features/attendance/data/models/attendance_models.dart';
import 'package:assistje/features/event/application/event_detail_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'attendance_fixtures.dart';

const _base = '/teams/3/events/412';
const _index = 'GET $_base/attendance';
const EventKey _key = (teamId: 3, eventId: 412);

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<AttendanceController> start(
    void Function(FakeHttpAdapter http) setup,
  ) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(attendanceControllerProvider(_key), (_, _) {});
    await container.read(attendanceControllerProvider(_key).future);
    return container.read(attendanceControllerProvider(_key).notifier);
  }

  EventAttendance current() =>
      container.read(attendanceControllerProvider(_key)).requireValue;

  AttendanceRow row(String key) =>
      current().rows.firstWhere((r) => r.key == key);

  test('laadt de lijst', () async {
    await start(
      (http) => http.on(_index, 200, AttendanceFixtures.attendance()),
    );
    expect(current().rows, hasLength(5));
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
      container.listen(attendanceControllerProvider(_key), (_, _) {});
      await expectLater(
        container.read(attendanceControllerProvider(_key).future),
        throwsA(matcher),
      );
    }
  });

  test('speler zetten is optimistisch en blijft staan', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, AttendanceFixtures.attendance())
        ..on(
          'PATCH $_base/attendance/43',
          200,
          AttendanceFixtures.saved(playerId: 43, status: 'absent'),
        );
    });

    final future = controller.setStatus(
      row('player-43'),
      AttendanceStatus.absent,
    );
    expect(row('player-43').status, AttendanceStatus.absent);
    expect(await future, isNull);
    expect(row('player-43').status, AttendanceStatus.absent);
    expect(current().counts.absent, 2);
    expect(backend.http.requestsTo('PATCH $_base/attendance/43').single.body, {
      'status': 'absent',
    });
  });

  test('staf zetten gaat naar …/staff/{user}', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, AttendanceFixtures.attendance())
        ..on(
          'PATCH $_base/attendance/staff/51',
          200,
          AttendanceFixtures.saved(playerId: null, userId: 51),
        );
    });

    expect(
      await controller.setStatus(row('staff-51'), AttendanceStatus.present),
      isNull,
    );
    expect(row('staff-51').status, AttendanceStatus.present);
  });

  test('fout bij zetten draait terug en geeft de fout', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, AttendanceFixtures.attendance())
        ..on('PATCH $_base/attendance/37', 403, {
          'message': 'Afgelast. Aanwezigheid staat vast.',
        });
    });

    final error = await controller.setStatus(
      row('player-37'),
      AttendanceStatus.absent,
    );
    expect(error, isA<ForbiddenException>());
    expect(row('player-37').status, AttendanceStatus.present);
  });

  test('niet te wijzigen (can_edit false) stuurt niets', () async {
    final controller = await start(
      (http) => http.on(
        _index,
        200,
        AttendanceFixtures.attendance(
          canEdit: false,
          cancelledAt: '2026-10-12T10:00:00+02:00',
        ),
      ),
    );

    final error = await controller.setStatus(
      row('player-37'),
      AttendanceStatus.absent,
    );
    expect(error, isA<ForbiddenException>());
    expect(backend.http.requests.where((r) => r.method == 'PATCH'), isEmpty);
  });

  test('gast toevoegen ververst lijst en opties', () async {
    var added = false;
    final controller = await start((http) {
      http.routes[_index] = (_) => FakeResponse(
        200,
        AttendanceFixtures.attendance(
          rows: [
            AttendanceFixtures.row(playerId: 37, name: 'Kees'),
            if (added)
              AttendanceFixtures.row(
                playerId: 89,
                name: 'Gijs Gast',
                isGuest: true,
                status: 'present',
              ),
          ],
        ),
      );
      http.routes['POST $_base/guests'] = (_) {
        added = true;
        return FakeResponse(201, AttendanceFixtures.guest());
      };
      http.on('GET $_base/guests/options', 200, AttendanceFixtures.options());
    });
    container.listen(guestOptionsProvider(_key), (_, _) {});
    await container.read(guestOptionsProvider(_key).future);
    final loads = backend.http.requestsTo(_index).length;
    final optionLoads = backend.http
        .requestsTo('GET $_base/guests/options')
        .length;

    expect(await controller.addExistingGuest(89), isNull);
    expect(current().guests.single.name, 'Gijs Gast');
    expect(backend.http.requestsTo(_index), hasLength(loads + 1));
    await container.read(guestOptionsProvider(_key).future);
    expect(
      backend.http.requestsTo('GET $_base/guests/options'),
      hasLength(optionLoads + 1),
    );
  });

  test('nieuwe gast: 422 komt terug zonder te verversen', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, AttendanceFixtures.attendance())
        ..on('POST $_base/guests', 422, {
          'message': 'Ongeldig.',
          'errors': {
            'name': ['De naam is verplicht.'],
          },
        });
    });

    final loads = backend.http.requestsTo(_index).length;
    final error = await controller.createGuest(const NewGuest(name: 'x'));
    expect(error, isA<ValidationException>());
    expect(backend.http.requestsTo(_index), hasLength(loads));
  });

  test('gast weghalen: DELETE en verversen; geen gast → fout', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, AttendanceFixtures.attendance())
        ..on('DELETE $_base/guests/88', 200, AttendanceFixtures.options());
    });

    final loads = backend.http.requestsTo(_index).length;
    expect(await controller.removeGuest(row('player-88')), isNull);
    expect(backend.http.requestsTo('DELETE $_base/guests/88'), hasLength(1));
    expect(backend.http.requestsTo(_index), hasLength(loads + 1));

    expect(
      await controller.removeGuest(row('player-37')),
      isA<ForbiddenException>(),
    );
  });
}
