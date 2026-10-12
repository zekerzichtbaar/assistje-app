import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:assistje/features/settings/application/settings_controller.dart';
import 'package:assistje/features/settings/data/models/settings_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'settings_fixtures.dart';

const _index = 'GET /teams/3/settings';

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<SettingsController> start([
    void Function(FakeHttpAdapter http)? setup,
  ]) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http
      ..on(_index, 200, SettingsFixtures.response())
      ..on(
        'GET /me',
        200,
        ApiFixtures.meResponse(teams: [SettingsFixtures.trainerMembership()]),
      );
    setup?.call(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(settingsControllerProvider(3), (_, _) {});
    await container.read(settingsControllerProvider(3).future);
    return container.read(settingsControllerProvider(3).notifier);
  }

  SettingsState current() =>
      container.read(settingsControllerProvider(3)).requireValue;

  test('laadt de instellingen', () async {
    await start();
    expect(current().data.team.name, 'Vogels 3');
    expect(current().writesForbidden, isFalse);
  });

  test('403 bij laden komt als AsyncError', () async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http.on(_index, 403, {'message': 'Nee.'});
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(settingsControllerProvider(3), (_, _) {});
    await expectLater(
      container.read(settingsControllerProvider(3).future),
      throwsA(isA<ForbiddenException>()),
    );
  });

  test('functie uit: optimistisch, daarna de stand van de server', () async {
    final controller = await start((http) {
      http.routes['PATCH /teams/3/settings/features/fines'] = (_) =>
          FakeResponse(
            200,
            SettingsFixtures.response(
              SettingsFixtures.settings(
                features: SettingsFixtures.features(fines: false),
              ),
            ),
          );
    });
    container.listen(meProvider, (_, _) {});
    await container.read(meProvider.future);
    final meCalls = backend.http.requestsTo('GET /me').length;

    final future = controller.setFeature('fines', enabled: false);
    expect(current().data.featureEnabled('fines'), isFalse);
    expect(await future, isNull);
    expect(current().data.featureEnabled('fines'), isFalse);
    expect(
      backend.http
          .requestsTo('PATCH /teams/3/settings/features/fines')
          .single
          .body,
      {'enabled': false},
    );
    // /me wordt ververst (menu en teamkleur).
    await container.read(meProvider.future);
    expect(backend.http.requestsTo('GET /me').length, meCalls + 1);
  });

  test('functie: bij een fout terug naar hoe het was', () async {
    final controller = await start((http) {
      http.on('PATCH /teams/3/settings/features/fines', 500, {
        'message': 'Kapot.',
      });
    });

    final error = await controller.setFeature('fines', enabled: false);

    expect(error, isA<ServerException>());
    expect(current().data.featureEnabled('fines'), isTrue);
    expect(current().writesForbidden, isFalse);
  });

  test('403 bij schrijven: terugdraaien en alleen-lezen', () async {
    final controller = await start((http) {
      http.on('PATCH /teams/3/settings/guests', 403, {'message': 'Demo.'});
    });

    final error = await controller.updateGuests(
      const GuestUpdate(attendance: GuestAttendance.all),
    );

    expect(error, isA<ForbiddenException>());
    expect(current().data.guests.attendance, GuestAttendance.training);
    expect(current().writesForbidden, isTrue);
    // Daarna gaat er niets meer naar de server.
    expect(await controller.setCarpoolHours(6), isA<ForbiddenException>());
    expect(
      backend.http.requestsTo('PATCH /teams/3/settings/carpool-hours'),
      isEmpty,
    );
  });

  test('gasten: alleen het gewijzigde veld draait terug', () async {
    final controller = await start((http) {
      http.on('PATCH /teams/3/settings/guests', 500, {'message': 'Kapot.'});
    });

    final future = controller.updateGuests(const GuestUpdate(inFines: true));
    expect(current().data.guests.inFines, isTrue);
    await future;
    expect(current().data.guests.inFines, isFalse);
    expect(current().data.guests.inStats, isTrue);
  });

  test('carpool-uren en trainingspunt zijn optimistisch', () async {
    final controller = await start((http) {
      http
        ..on(
          'PATCH /teams/3/settings/carpool-hours',
          200,
          SettingsFixtures.response(SettingsFixtures.settings(carpoolHours: 6)),
        )
        ..on(
          'PATCH /teams/3/settings/training-points',
          200,
          SettingsFixtures.response(
            SettingsFixtures.settings(attendancePoint: true, carpoolHours: 6),
          ),
        );
    });

    final hours = controller.setCarpoolHours(6);
    expect(current().data.carpool.reminderHours, 6);
    expect(await hours, isNull);

    final point = controller.setTrainingAttendancePoint(enabled: true);
    expect(current().data.trainingPoints.attendancePoint, isTrue);
    expect(await point, isNull);
    // Zelfde waarde: geen verzoek.
    expect(await controller.setCarpoolHours(6), isNull);
    expect(
      backend.http.requestsTo('PATCH /teams/3/settings/carpool-hours'),
      hasLength(1),
    );
  });

  test('diensttype aanmaken vervangt de stand door het antwoord', () async {
    final controller = await start((http) {
      http.on(
        'POST /teams/3/settings/duty-types',
        201,
        SettingsFixtures.response(
          SettingsFixtures.settings(
            dutyTypes: [
              SettingsFixtures.wash(),
              SettingsFixtures.canteen(),
              {...SettingsFixtures.canteen(), 'id': 31, 'name': 'Rijden'},
            ],
          ),
        ),
      );
    });

    expect(
      await controller.createDutyType(const DutyTypeInput(name: 'Rijden')),
      isNull,
    );
    expect(current().data.dutyTypes.map((d) => d.name), [
      'Wassen',
      'Kantine',
      'Rijden',
    ]);
  });

  test('422 bij een formulier laat de stand staan', () async {
    final controller = await start((http) {
      http.on('PATCH /teams/3/settings/team', 422, {
        'message': 'Ongeldig.',
        'errors': {
          'name': ['Vul een naam in.'],
        },
      });
    });

    final error = await controller.updateTeam(
      const TeamBranding(name: 'x', primaryColor: '#006837'),
    );

    expect(error, isA<ValidationException>());
    expect(current().data.team.name, 'Vogels 3');
    expect(current().writesForbidden, isFalse);
  });

  test('refresh houdt de data bij een fout', () async {
    final controller = await start();
    backend.http.on(_index, 500, {'message': 'Kapot.'});

    expect(await controller.refresh(), isA<ServerException>());
    expect(current().data.team.name, 'Vogels 3');
  });
}
