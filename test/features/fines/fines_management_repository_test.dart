import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/fines/data/fines_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'fines_fixtures.dart';

void main() {
  late FakeHttpAdapter http;
  late FinesRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = FinesRepository(
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

  group('periodes', () {
    test('nieuwe periode: POST fine-periods met name', () async {
      http.on(
        'POST /teams/3/fine-periods',
        201,
        FinesFixtures.periodResponse(),
      );

      final period = await repository.createPeriod(3, name: 'Voorjaar 2027');

      expect(http.requestsTo('POST /teams/3/fine-periods').single.body, {
        'name': 'Voorjaar 2027',
      });
      expect(period.id, 8);
      expect(period.name, 'Voorjaar 2027');
      expect(period.startsOn, DateTime(2026, 10, 11));
      expect(period.isClosed, isFalse);
    });

    test('hernoemen: PATCH fine-periods/{period}', () async {
      http.on(
        'PATCH /teams/3/fine-periods/7',
        200,
        FinesFixtures.periodResponse({'id': 7, 'name': 'Najaar 2026'}),
      );

      final period = await repository.renamePeriod(3, 7, name: 'Najaar 2026');

      expect(http.requestsTo('PATCH /teams/3/fine-periods/7').single.body, {
        'name': 'Najaar 2026',
      });
      expect(period.id, 7);
      expect(period.name, 'Najaar 2026');
    });

    test('afsluiten: afgesloten periode plus meta.active_period', () async {
      http.on(
        'POST /teams/3/fine-periods/7/close',
        200,
        FinesFixtures.closeResponse(),
      );

      final result = await repository.closePeriod(3, 7);

      expect(
        http.requestsTo('POST /teams/3/fine-periods/7/close'),
        hasLength(1),
      );
      expect(result.closed.id, 7);
      expect(result.closed.isClosed, isTrue);
      expect(result.closed.endsOn, DateTime(2026, 12, 31));
      expect(result.active?.id, 9);
      expect(result.active?.name, 'Q1 2027');
      expect(result.active?.isClosed, isFalse);
    });

    test('422 met veldfout op name', () async {
      http.on('POST /teams/3/fine-periods', 422, {
        'message': 'Vul een naam in.',
        'errors': {
          'name': ['Vul een naam in.'],
        },
      });

      await expectLater(
        repository.createPeriod(3, name: ''),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.fieldError('name'),
            'name',
            'Vul een naam in.',
          ),
        ),
      );
    });
  });

  group('bedragen en soorten', () {
    test('bedragen: PATCH fine-settings met amounts per id', () async {
      http.on(
        'PATCH /teams/3/fine-settings',
        200,
        FinesFixtures.settingsResponse(),
      );

      final types = await repository.updateFineSettings(3, {31: 300, 35: 100});

      expect(http.requestsTo('PATCH /teams/3/fine-settings').single.body, {
        'amounts': {'31': 300, '35': 100},
      });
      expect(types.map((t) => t.id), [31, 35]);
      expect(types.first.defaultCents, 300);
      expect(types.first.trigger, 'missed_rsvp_match');
    });

    test('soort toevoegen: POST fine-types', () async {
      http.on(
        'POST /teams/3/fine-types',
        201,
        FinesFixtures.fineTypeResponse(),
      );

      final type = await repository.createFineType(
        3,
        label: 'Douchen overgeslagen',
        amountCents: 500,
      );

      expect(http.requestsTo('POST /teams/3/fine-types').single.body, {
        'label': 'Douchen overgeslagen',
        'amount_cents': 500,
      });
      expect(type.id, 36);
      expect(type.defaultCents, 500);
      expect(type.trigger, isNull);
    });

    test('soort bijwerken: alleen meegegeven velden', () async {
      http
        ..on(
          'PATCH /teams/3/fine-types/35',
          200,
          FinesFixtures.fineTypeResponse(
            id: 35,
            label: 'Tas kwijt',
            cents: 150,
          ),
        )
        ..on(
          'PATCH /teams/3/fine-types/31',
          200,
          FinesFixtures.fineTypeResponse(id: 31, archived: true),
        );

      final renamed = await repository.updateFineType(
        3,
        35,
        label: 'Tas kwijt',
        amountCents: 150,
      );
      final off = await repository.updateFineType(3, 31, active: false);

      expect(http.requestsTo('PATCH /teams/3/fine-types/35').single.body, {
        'label': 'Tas kwijt',
        'amount_cents': 150,
      });
      expect(http.requestsTo('PATCH /teams/3/fine-types/31').single.body, {
        'active': false,
      });
      expect(renamed.label, 'Tas kwijt');
      expect(off.archived, isTrue);
    });

    test('soort weghalen: archived uit het antwoord', () async {
      http
        ..on('DELETE /teams/3/fine-types/36', 200, {
          'data': {'id': 36, 'archived': false},
        })
        ..on('DELETE /teams/3/fine-types/35', 200, {
          'data': {'id': 35, 'archived': true},
        });

      expect(await repository.deleteFineType(3, 36), isFalse);
      expect(await repository.deleteFineType(3, 35), isTrue);
    });

    test('automatische soort weghalen: 422 met alleen message', () async {
      http.on('DELETE /teams/3/fine-types/31', 422, {
        'message': 'Automatische boetes kun je alleen uitzetten.',
      });

      await expectLater(
        repository.deleteFineType(3, 31),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.message,
            'message',
            'Automatische boetes kun je alleen uitzetten.',
          ),
        ),
      );
    });

    test('geen penningmeester (of demoteam): 403', () async {
      http.on('PATCH /teams/3/fine-settings', 403, {
        'message': 'Geen toegang.',
      });

      await expectLater(
        repository.updateFineSettings(3, {31: 0}),
        throwsA(isA<ForbiddenException>()),
      );
    });
  });
}
