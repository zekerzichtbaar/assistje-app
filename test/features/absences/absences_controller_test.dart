import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/absences/application/absences_controller.dart';
import 'package:assistje/features/profile/application/profile_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import '../profile/profile_fixtures.dart';
import 'absences_fixtures.dart';

const _profile = 'GET /teams/3/profile';

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<AbsencesController> start(
    void Function(FakeHttpAdapter http) setup,
  ) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(absencesControllerProvider(3), (_, _) {});
    await container.read(absencesControllerProvider(3).future);
    return container.read(absencesControllerProvider(3).notifier);
  }

  AbsencesState current() =>
      container.read(absencesControllerProvider(3)).requireValue;

  int profileCalls() => backend.http.requestsTo(_profile).length;

  /// Wacht tot het opnieuw ophalen van het profiel klaar is.
  Future<void> settle() async {
    await container.read(profileControllerProvider(3).future);
    await container.read(absencesControllerProvider(3).future);
  }

  test('leest vakanties en vaste dagen uit het profiel', () async {
    await start((http) => http.on(_profile, 200, ProfileFixtures.profile()));
    expect(current().hasPlayer, isTrue);
    expect(current().canUseVacations, isTrue);
    expect(current().vacations.single.id, 5);
    expect(current().weekdayChoices, [2, 4]);
    expect(current().standingDay(2)?.id, 1);
    expect(current().standingDay(4), isNull);
  });

  test(
    'zondag als 0 telt als 7; staande dag buiten de keuzes blijft',
    () async {
      await start(
        (http) => http.on(
          _profile,
          200,
          ProfileFixtures.profile(
            standingAbsences: {
              'days': [
                {'id': 8, 'weekday': 0},
              ],
              'choices': [2, 4],
            },
          ),
        ),
      );
      expect(current().weekdayChoices, [2, 4, 7]);
      expect(current().standingDay(7)?.id, 8);
    },
  );

  test(
    'vakantie toevoegen: in de lijst (gesorteerd) en profiel opnieuw',
    () async {
      var vacations = <Map<String, dynamic>>[
        {
          'id': 5,
          'starts_on': '2026-12-20',
          'ends_on': '2027-01-03',
          'note': 'Wintersport',
        },
      ];
      final controller = await start((http) {
        http.routes[_profile] = (_) =>
            FakeResponse(200, ProfileFixtures.profile(vacations: vacations));
        http.routes['POST /teams/3/vacations'] = (_) {
          vacations = [
            ...vacations,
            (AbsencesFixtures.vacation()['data'] as Map<String, dynamic>),
          ];
          return FakeResponse(201, AbsencesFixtures.vacation());
        };
      });
      final before = profileCalls();

      final error = await controller.addVacation(
        startsOn: '2026-10-20',
        endsOn: '2026-10-27',
        note: 'Wintersport',
      );
      expect(error, isNull);
      expect(current().vacations.map((v) => v.id), [412, 5]);
      await settle();
      expect(profileCalls(), before + 1);
      expect(current().vacations.map((v) => v.id), [412, 5]);
    },
  );

  test('vakantie toevoegen faalt: fout terug, lijst ongewijzigd', () async {
    final controller = await start((http) {
      http
        ..on(_profile, 200, ProfileFixtures.profile())
        ..on('POST /teams/3/vacations', 422, AbsencesFixtures.noPlayer);
    });
    final before = profileCalls();
    final error = await controller.addVacation(
      startsOn: '2026-10-20',
      endsOn: '2026-10-27',
    );
    expect(error, isA<ValidationException>());
    expect(current().vacations.single.id, 5);
    expect(profileCalls(), before);
  });

  test('vakantie weghalen', () async {
    final controller = await start((http) {
      http
        ..on(_profile, 200, ProfileFixtures.profile())
        ..on('DELETE /teams/3/vacations/5', 204);
    });
    expect(await controller.removeVacation(5), isNull);
    expect(current().vacations, isEmpty);
  });

  test('vaste dag aan en uit', () async {
    final controller = await start((http) {
      http
        ..on(_profile, 200, ProfileFixtures.profile())
        ..on(
          'POST /teams/3/standing-absences',
          201,
          AbsencesFixtures.standingDay(id: 20, weekday: 4),
        )
        ..on('DELETE /teams/3/standing-absences/1', 204);
    });

    final on = await controller.toggleStandingDay(4);
    expect(on, (on: true, error: null));
    expect(current().standingDay(4)?.id, 20);
    expect(
      backend.http.requestsTo('POST /teams/3/standing-absences').single.body,
      {'weekday': 4},
    );
    await settle();

    // Het profiel (de nep-API) kent dinsdag nog: weghalen.
    final off = await controller.toggleStandingDay(2);
    expect(off, (on: false, error: null));
    expect(current().standingDay(2), isNull);
    expect(
      backend.http.requestsTo('DELETE /teams/3/standing-absences/1'),
      hasLength(1),
    );
  });

  test('vaste dag faalt: fout terug, stand blijft', () async {
    final controller = await start((http) {
      http
        ..on(_profile, 200, ProfileFixtures.profile())
        ..on('POST /teams/3/standing-absences', 403, {
          'message': ProfileFixtures.demoMessage,
        });
    });
    final result = await controller.toggleStandingDay(4);
    expect(result.on, isFalse);
    expect(result.error, isA<ForbiddenException>());
    expect(current().standingDay(4), isNull);
  });
}
