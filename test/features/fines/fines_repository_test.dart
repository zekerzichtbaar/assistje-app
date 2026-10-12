import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/fines/data/fines_repository.dart';
import 'package:assistje/features/fines/data/models/fines_models.dart';
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

  group('lezen', () {
    test('overzicht uit het voorbeeld in docs/api/v1/fines.md', () async {
      http.on('GET /teams/3/fines', 200, FinesFixtures.overview());

      final overview = await repository.fetchOverview(3);

      expect(http.requests.single.options.uri.queryParameters, isEmpty);
      expect(overview.period.id, 7);
      expect(overview.period.name, 'Q4 2026');
      expect(overview.period.startsOn, DateTime(2026, 10));
      expect(overview.period.isClosed, isFalse);
      expect(overview.periods.map((p) => p.id), [7, 6]);
      expect(overview.periods.last.isClosed, isTrue);

      final sam = overview.rows.first;
      expect(sam.key, 'p17');
      expect(sam.playerId, 17);
      expect(sam.shirtNumber, 9);
      expect(sam.totalCents, 750);
      expect(sam.openCents, 250);
      expect(sam.count, 2);
      expect(sam.isStaffOnly, isFalse);
      final ronald = overview.rows.last;
      expect(ronald.isStaff, isTrue);
      expect(ronald.userId, 4);
      expect(ronald.isStaffOnly, isTrue);

      expect(overview.fineTypes.first.trigger, 'missed_rsvp_match');
      expect(overview.fineTypes.last.defaultCents, 100);
      expect(overview.staffInFines, isTrue);
      expect(overview.totals, const FineTotals(openCents: 250, allCents: 750));
      expect(overview.pot.balanceCents, 3750);
      expect(overview.pot.openCents, 250);
      expect(overview.pot.lines.map((l) => l.kind), [
        PotLineKind.fines,
        PotLineKind.entry,
        PotLineKind.settlement,
      ]);
      final entry = overview.pot.lines[1];
      expect(entry.id, 12);
      expect(entry.amountCents, -1250);
      expect(entry.occurredOn, DateTime(2026, 10, 4));
      expect(entry.isEditable, isTrue);
      expect(overview.pot.lines.first.isEditable, isFalse);
      expect(overview.canManage, isFalse);
      expect(overview.countingRows.map((r) => r.key), ['p17', 'u4']);
    });

    test('periode als ?period=, onbekende kind/status vallen terug', () async {
      http.on(
        'GET /teams/3/fines',
        200,
        FinesFixtures.overview({
          'staff_in_fines': false,
          'fine_types': [
            {...FinesFixtures.fineTypes().first, 'archived': true},
            FinesFixtures.fineTypes().last,
          ],
          'pot': {
            'balance_cents': 0,
            'open_cents': 0,
            'lines': [
              {
                'key': 'x-1',
                'kind': 'refund',
                'id': null,
                'amount_cents': 1,
                'description': 'Nieuw',
                'occurred_on': '2026-10-01',
                'created_by': null,
              },
            ],
          },
        }),
      );

      final overview = await repository.fetchOverview(3, periodId: 6);

      expect(http.requests.single.options.uri.queryParameters, {'period': '6'});
      expect(overview.pot.lines.single.kind, PotLineKind.unknown);
      expect(overview.activeFineTypes.map((t) => t.id), [35]);
      // Staf telt niet mee als het team geen staf beboet.
      expect(overview.countingRows.map((r) => r.key), ['p17']);
    });

    test('speler en staf', () async {
      http
        ..on('GET /teams/3/fines/players/17', 200, FinesFixtures.player())
        ..on('GET /teams/3/fines/staff/4', 200, FinesFixtures.staff());

      final player = await repository.fetchPlayer(3, 17, periodId: 7);
      expect(http.requests.last.options.uri.queryParameters, {'period': '7'});
      expect(player.person.id, 17);
      expect(player.person.shirtNumber, 9);
      final fine = player.fines.single;
      expect(fine.id, 501);
      expect(fine.type, 31);
      expect(fine.typeLabel, 'Te laat');
      expect(fine.status, FineStatus.open);
      expect(fine.event?.title, 'Vogels 3 - Arnhemia 2');
      expect(fine.createdBy, 'Coach Ronald');
      expect(player.totals.openCents, 250);
      expect(player.canManage, isFalse);

      final staff = await repository.fetchStaff(3, 4);
      expect(http.requests.last.options.uri.queryParameters, isEmpty);
      expect(staff.person.name, 'Coach Ronald');
      expect(staff.fines, isEmpty);
      expect(staff.canManage, isTrue);
    });

    test('403 voor een toeschouwer, 404 als de feature uit staat', () async {
      http.on('GET /teams/3/fines', 403, {'message': 'Geen toegang.'});
      await expectLater(
        repository.fetchOverview(3),
        throwsA(
          isA<ForbiddenException>().having(
            (e) => e.message,
            'message',
            'Geen toegang.',
          ),
        ),
      );
      http.on('GET /teams/3/fines', 404, {'message': 'Not found.'});
      await expectLater(
        repository.fetchOverview(3),
        throwsA(isA<NotFoundException>()),
      );
    });
  });

  group('boetes schrijven', () {
    test(
      'POST met een selectie: lijsten, type, bedrag, omschrijving',
      () async {
        http.on('POST /teams/3/fines', 201, FinesFixtures.recorded());

        final fines = await repository.recordFines(
          3,
          targets: const FineTargets(playerIds: [17, 18]),
          typeId: 35,
          amountCents: 100,
          description: 'Tas vergeten',
        );

        expect(http.requests.single.body, {
          'player_ids': [17, 18],
          'type': 35,
          'amount_cents': 100,
          'description': 'Tas vergeten',
        });
        expect(fines.map((f) => f.id), [502, 503]);
        expect(fines.first.status, FineStatus.open);
      },
    );

    test('vormen: één speler, één staflid, hele team', () {
      expect(const FineTargets(playerIds: [17]).toJson(), {'player_id': 17});
      expect(const FineTargets(userIds: [4]).toJson(), {'user_id': 4});
      expect(const FineTargets(playerIds: [17], userIds: [4]).toJson(), {
        'player_ids': [17],
        'user_ids': [4],
      });
      expect(const FineTargets.everyone().toJson(), {'everyone': true});
      expect(const FineTargets().isEmpty, isTrue);
    });

    test('POST zonder bedrag/omschrijving laat ze weg', () async {
      http.on('POST /teams/3/fines', 201, FinesFixtures.recorded());
      await repository.recordFines(
        3,
        targets: const FineTargets.everyone(),
        typeId: 31,
      );
      expect(http.requests.single.body, {'everyone': true, 'type': 31});
    });

    test('422 met alleen message (selectieregel)', () async {
      http.on('POST /teams/3/fines', 422, {
        'message': 'Kies een speler, of deel de boete aan het hele team uit.',
      });
      await expectLater(
        repository.recordFines(3, targets: const FineTargets(), typeId: 35),
        throwsA(
          isA<ValidationException>()
              .having((e) => e.errors, 'errors', isEmpty)
              .having(
                (e) => e.message,
                'message',
                'Kies een speler, of deel de boete aan het hele team uit.',
              ),
        ),
      );
    });

    test('422 met veldfouten', () async {
      http.on('POST /teams/3/fines', 422, {
        'message': 'Het bedrag is te hoog.',
        'errors': {
          'amount_cents': ['Het bedrag is te hoog.'],
        },
      });
      await expectLater(
        repository.recordFines(
          3,
          targets: const FineTargets(playerIds: [17]),
          typeId: 35,
          amountCents: 999999,
        ),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.fieldError('amount_cents'),
            'amount_cents',
            'Het bedrag is te hoog.',
          ),
        ),
      );
    });

    test('403 als je geen penningmeester bent', () async {
      http.on('POST /teams/3/fines', 403, {'message': 'Geen toegang.'});
      await expectLater(
        repository.recordFines(
          3,
          targets: const FineTargets(playerIds: [17]),
          typeId: 35,
        ),
        throwsA(isA<ForbiddenException>()),
      );
    });

    test('PATCH status, bedrag, omschrijving wissen', () async {
      http.on('PATCH /teams/3/fines/501', 200, FinesFixtures.updated());

      final fine = await repository.updateFine(3, 501, status: FineStatus.paid);
      expect(http.requests.last.body, {'status': 'paid'});
      expect(fine.status, FineStatus.paid);
      expect(fine.paidAt, DateTime.parse('2026-10-12T09:01:12+02:00'));

      await repository.updateFine(
        3,
        501,
        amountCents: 300,
        clearDescription: true,
      );
      expect(http.requests.last.body, {
        'amount_cents': 300,
        'description': null,
      });

      await repository.updateFine(3, 501, description: 'Te laat (15 min)');
      expect(http.requests.last.body, {'description': 'Te laat (15 min)'});
    });

    test('PATCH 403 en DELETE 204', () async {
      http
        ..on('PATCH /teams/3/fines/501', 403, {'message': 'Geen toegang.'})
        ..on('DELETE /teams/3/fines/501', 204);
      await expectLater(
        repository.updateFine(3, 501, status: FineStatus.waived),
        throwsA(isA<ForbiddenException>()),
      );
      await repository.deleteFine(3, 501);
      expect(http.requestsTo('DELETE /teams/3/fines/501'), hasLength(1));
    });

    test('DELETE 404 van een ander team', () async {
      http.on('DELETE /teams/3/fines/999', 404, {'message': 'Not found.'});
      await expectLater(
        repository.deleteFine(3, 999),
        throwsA(isA<NotFoundException>()),
      );
    });
  });

  group('pot', () {
    final draft = PotEntryDraft(
      amountCents: -1250,
      description: 'Krat bier',
      occurredOn: DateTime(2026, 10, 4),
    );

    test('POST, PATCH en DELETE van een boeking', () async {
      http
        ..on('POST /teams/3/fine-pot', 201, FinesFixtures.potEntryResponse())
        ..on(
          'PATCH /teams/3/fine-pot/12',
          200,
          FinesFixtures.potEntryResponse(amount: -1500),
        )
        ..on('DELETE /teams/3/fine-pot/12', 204);

      final created = await repository.createPotEntry(3, draft);
      expect(http.requests.last.body, {
        'amount_cents': -1250,
        'description': 'Krat bier',
        'occurred_on': '2026-10-04',
      });
      expect(created.id, 12);
      expect(created.kind, PotLineKind.entry);

      final updated = await repository.updatePotEntry(3, 12, draft);
      expect(http.requests.last.method, 'PATCH');
      expect(updated.amountCents, -1500);

      await repository.deletePotEntry(3, 12);
      expect(http.requestsTo('DELETE /teams/3/fine-pot/12'), hasLength(1));
    });

    test('422 veldfout op amount_cents en 403', () async {
      http.on('POST /teams/3/fine-pot', 422, {
        'message': 'Het bedrag mag niet 0 zijn.',
        'errors': {
          'amount_cents': ['Het bedrag mag niet 0 zijn.'],
        },
      });
      await expectLater(
        repository.createPotEntry(3, draft),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.fieldError('amount_cents'),
            'field',
            'Het bedrag mag niet 0 zijn.',
          ),
        ),
      );
      http.on('PATCH /teams/3/fine-pot/12', 403, {'message': 'Demo.'});
      await expectLater(
        repository.updatePotEntry(3, 12, draft),
        throwsA(isA<ForbiddenException>()),
      );
      http.on('DELETE /teams/3/fine-pot/12', 403, {'message': 'Demo.'});
      await expectLater(
        repository.deletePotEntry(3, 12),
        throwsA(isA<ForbiddenException>()),
      );
    });

    test('datum zonder tijd', () {
      expect(
        PotEntryDraft.dateOnly(DateTime(2026, 1, 5, 23, 59)),
        '2026-01-05',
      );
    });
  });
}
