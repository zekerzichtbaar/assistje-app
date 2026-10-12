import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/absences/data/absences_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'absences_fixtures.dart';

void main() {
  late FakeHttpAdapter http;
  late AbsencesRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = AbsencesRepository(
      ApiClient(
        buildApiDio(
          baseUrl: 'https://assistje.test/api/v1',
          readToken: () async => '12|abc',
          onUnauthorized: () {},
          adapter: http,
        ),
      ),
    );
  });

  group('vakanties', () {
    test('toevoegen stuurt datums en notitie; geeft het item', () async {
      http.on('POST /teams/3/vacations', 201, AbsencesFixtures.vacation());

      final vacation = await repository.addVacation(
        3,
        startsOn: '2026-10-20',
        endsOn: '2026-10-27',
        note: '  Wintersport ',
      );

      expect(http.requests.single.body, {
        'starts_on': '2026-10-20',
        'ends_on': '2026-10-27',
        'note': 'Wintersport',
      });
      expect(vacation.id, 412);
      expect(vacation.startsOn, '2026-10-20');
      expect(vacation.note, 'Wintersport');
    });

    test('lege notitie gaat niet mee', () async {
      http.on('POST /teams/3/vacations', 201, AbsencesFixtures.vacation());
      await repository.addVacation(
        3,
        startsOn: '2026-10-20',
        endsOn: '2026-10-27',
        note: ' ',
      );
      expect(http.requests.single.body, {
        'starts_on': '2026-10-20',
        'ends_on': '2026-10-27',
      });
    });

    test('422 met veldfout', () async {
      http.on(
        'POST /teams/3/vacations',
        422,
        AbsencesFixtures.validation('ends_on', 'Ends on moet na starts on.'),
      );
      await expectLater(
        repository.addVacation(3, startsOn: '2026-10-27', endsOn: '2026-10-20'),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.fieldError('ends_on'),
            'ends_on',
            'Ends on moet na starts on.',
          ),
        ),
      );
    });

    test('verwijderen', () async {
      http.on('DELETE /teams/3/vacations/412', 204);
      await repository.removeVacation(3, 412);
      expect(http.requestsTo('DELETE /teams/3/vacations/412'), hasLength(1));
    });
  });

  group('vaste dagen', () {
    test('toevoegen stuurt ISO-weekdag (0 → 7)', () async {
      http.on(
        'POST /teams/3/standing-absences',
        201,
        AbsencesFixtures.standingDay(weekday: 7),
      );
      final day = await repository.addStandingAbsence(3, 0);
      expect(http.requests.single.body, {'weekday': 7});
      expect(day.id, 19);
      expect(day.weekday, 7);
    });

    test('200 als de dag al stond', () async {
      http.on(
        'POST /teams/3/standing-absences',
        200,
        AbsencesFixtures.standingDay(),
      );
      final day = await repository.addStandingAbsence(3, 2);
      expect(day.weekday, 2);
    });

    test('verwijderen', () async {
      http.on('DELETE /teams/3/standing-absences/19', 204);
      await repository.removeStandingAbsence(3, 19);
      expect(
        http.requestsTo('DELETE /teams/3/standing-absences/19'),
        hasLength(1),
      );
    });

    test('feature uit → NotFoundException', () async {
      http.on('POST /teams/3/standing-absences', 404, {
        'message': 'Not found.',
      });
      await expectLater(
        repository.addStandingAbsence(3, 2),
        throwsA(isA<NotFoundException>()),
      );
    });
  });
}
