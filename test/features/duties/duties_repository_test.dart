import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/duties/data/duties_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'duties_fixtures.dart';

void main() {
  late FakeHttpAdapter http;
  late DutiesRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = DutiesRepository(
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

  test('leest het overzicht van een individueel wedstrijdtype', () async {
    http.on('GET /teams/3/duties', 200, DutiesFixtures.individual());

    final o = await repository.fetch(3);

    expect(http.requests.single.options.uri.queryParameters, isEmpty);
    expect(o.type, 'vlaggen');
    expect(o.dutyTypeId, 3);
    expect(o.isIndividual, isTrue);
    expect(o.isMatchBound, isTrue);
    expect(o.dutyTypeAutoRotate, isTrue);
    expect(o.dutyTypePool, ['players']);
    expect(o.dutyTypes.map((t) => t.slug), ['wassen', 'vlaggen']);
    expect(o.currentType?.name, 'Vlaggen');
    final a = o.assignments.single;
    expect(a.scheduledFor, '2026-10-12');
    expect(a.memberKey, 'p_17');
    expect(a.playerName, 'Sam de Vries');
    expect(a.eventLabel, 'Vogels 3 – Kraaien 1');
    expect(a.isDone, isFalse);
    expect(o.allPeople.map((p) => p.count), [2, 1]);
    // Minste beurten eerst; het voorstel is wie het minst deed.
    expect(o.peopleByCount.first.key, 'p_18');
    expect(o.suggestedMemberKey, 'p_18');
    expect(o.poolPeople.last.kind, 'staff');
    expect(o.matches.first.startsAt, isNotNull);
  });

  test('?type= kiest het type; groepen met leden', () async {
    http.on('GET /teams/3/duties', 200, DutiesFixtures.groups());

    final o = await repository.fetch(3, type: 'wassen');

    expect(http.requests.single.options.uri.queryParameters, {
      'type': 'wassen',
    });
    expect(o.isIndividual, isFalse);
    expect(o.isMatchBound, isFalse);
    expect(o.groups.map((g) => g.id), [7, 8]);
    expect(o.groups.first.members.map((m) => m.key), ['u_4', 'p_17']);
    expect(o.groups.first.lastAssignedAt, isNotNull);
    expect(o.assignments.single.groupName, 'Groep A');
    expect(o.assignments.single.startsAt, '19:00');
  });

  test('groepen: aanmaken, wijzigen, volgorde en verwijderen', () async {
    http
      ..on('POST /teams/3/duties/groups', 201, DutiesFixtures.savedGroup())
      ..on('PATCH /teams/3/duties/groups/7', 200, DutiesFixtures.savedGroup())
      ..on('POST /teams/3/duties/groups/reorder', 204)
      ..on('DELETE /teams/3/duties/groups/7', 204);

    final created = await repository.createGroup(
      3,
      dutyTypeId: 1,
      name: ' Groep A ',
      memberKeys: ['p_17', 'u_4'],
    );
    await repository.updateGroup(3, 7, name: 'Groep A (nieuw)');
    await repository.reorderGroups(3, [9, 7, 8]);
    await repository.deleteGroup(3, 7);

    expect(created.sortOrder, 3);
    expect(created.dutyTypeId, 1);
    expect(http.requests[0].body, {
      'duty_type_id': 1,
      'name': 'Groep A',
      'member_keys': ['p_17', 'u_4'],
    });
    expect(http.requests[1].body, {
      'name': 'Groep A (nieuw)',
      'member_keys': <String>[],
    });
    expect(http.requests[2].body, {
      'ids': [9, 7, 8],
    });
    expect(http.requests[3].method, 'DELETE');
  });

  test('beurten inplannen: individueel op wedstrijden', () async {
    http.on('POST /teams/3/duties/assignments', 201, DutiesFixtures.stored());

    final all = await repository.storeAssignments(
      3,
      const DutyAssignmentDraft(
        dutyTypeId: 3,
        mode: 'individual',
        memberKey: 'p_17',
        dates: [
          DutyDateRow(eventId: 812),
          DutyDateRow(eventId: 815, notes: '  '),
        ],
      ),
    );

    expect(http.requests.single.body, {
      'duty_type_id': 3,
      'mode': 'individual',
      'member_key': 'p_17',
      'dates': [
        {'event_id': 812},
        {'event_id': 815},
      ],
    });
    expect(all.single.id, 120);
  });

  test('beurten inplannen: vaste groep op datums met tijden', () async {
    http.on('POST /teams/3/duties/assignments', 201, DutiesFixtures.stored());

    await repository.storeAssignments(
      3,
      const DutyAssignmentDraft(
        dutyTypeId: 1,
        mode: 'single',
        groupId: 7,
        dates: [
          DutyDateRow(
            date: '2026-10-14',
            startsAt: '19:00',
            endsAt: '20:00',
            notes: ' Tas mee ',
          ),
        ],
      ),
    );

    expect(http.requests.single.body, {
      'duty_type_id': 1,
      'mode': 'single',
      'duty_group_id': 7,
      'dates': [
        {
          'date': '2026-10-14',
          'starts_at': '19:00',
          'ends_at': '20:00',
          'notes': 'Tas mee',
        },
      ],
    });
  });

  test('verdelen geeft de melding terug', () async {
    http.on(
      'POST /teams/3/duties/auto-assign',
      200,
      DutiesFixtures.autoAssigned(),
    );
    expect(await repository.autoAssign(3, 3), '2 wedstrijden ingedeeld.');
    expect(http.requests.single.body, {'duty_type_id': 3});
  });

  test('beurt wijzigen, afvinken en verwijderen', () async {
    http
      ..on(
        'PATCH /teams/3/duties/assignments/120',
        200,
        DutiesFixtures.savedAssignment(),
      )
      ..on(
        'POST /teams/3/duties/assignments/120/done',
        200,
        DutiesFixtures.savedAssignment(
          markedDoneAt: '2026-10-12T18:00:00+02:00',
        ),
      )
      ..on('DELETE /teams/3/duties/assignments/120', 204);

    final saved = await repository.updateAssignment(3, 120, {
      'member_key': 'p_18',
      'event_id': 812,
      'notes': 'Vlag meenemen',
    });
    final done = await repository.toggleDone(3, 120);
    await repository.deleteAssignment(3, 120);

    expect(saved.memberKey, 'p_18');
    expect(saved.notes, 'Vlag meenemen');
    expect(http.requests.first.body, {
      'member_key': 'p_18',
      'event_id': 812,
      'notes': 'Vlag meenemen',
    });
    expect(done.isDone, isTrue);
    expect(http.requests.last.method, 'DELETE');
  });

  test('dienst bij een wedstrijd: persoon, groep of vrijmaken', () async {
    http.on(
      'PATCH /teams/3/events/812/duties/3',
      200,
      DutiesFixtures.eventAssigned(),
    );
    http.on('PATCH /teams/3/events/812/duties/1', 200, {
      'data': {'message': 'ok', 'assignments': <Object>[]},
    });

    final rows = await repository.assignEventDuty(
      3,
      812,
      3,
      group: false,
      memberKey: 'p_17',
    );
    await repository.assignEventDuty(3, 812, 1, group: true, groupId: 7);
    await repository.assignEventDuty(3, 812, 1, group: true);

    expect(rows.single.memberKey, 'p_17');
    expect(http.requests[0].body, {'member_key': 'p_17'});
    expect(http.requests[1].body, {'duty_group_id': 7});
    expect(http.requests[2].body, {'duty_group_id': null});
  });

  test('422, 403 en 404 komen als ApiException', () async {
    http
      ..on('POST /teams/3/duties/assignments', 422, {
        'message': 'Kies wie de dienst doet.',
        'errors': {
          'member_key': ['Kies wie de dienst doet.'],
          'player_id': ['Kies wie de dienst doet.'],
        },
      })
      ..on('GET /teams/3/duties', 403, {'message': 'Geen toegang.'})
      ..on('DELETE /teams/3/duties/groups/99', 404, {'message': 'Not found.'});

    await expectLater(
      repository.storeAssignments(
        3,
        const DutyAssignmentDraft(
          dutyTypeId: 3,
          mode: 'individual',
          dates: [DutyDateRow(eventId: 812)],
        ),
      ),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.fieldError('member_key'),
          'member_key',
          'Kies wie de dienst doet.',
        ),
      ),
    );
    await expectLater(repository.fetch(3), throwsA(isA<ForbiddenException>()));
    await expectLater(
      repository.deleteGroup(3, 99),
      throwsA(isA<NotFoundException>()),
    );
  });
}
