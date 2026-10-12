import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/agenda/data/models/agenda_models.dart';
import 'package:assistje/features/attendance/data/attendance_repository.dart';
import 'package:assistje/features/attendance/data/models/attendance_models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'attendance_fixtures.dart';

const _base = '/teams/3/events/412';

void main() {
  late FakeHttpAdapter http;
  late AttendanceRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = AttendanceRepository(
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

  test('leest de aanwezigheidslijst', () async {
    http.on('GET $_base/attendance', 200, AttendanceFixtures.attendance());

    final a = await repository.fetch(3, 412);

    expect(a.event.id, 412);
    expect(a.event.type, 'training');
    expect(a.event.canEdit, isTrue);
    expect(a.event.isCancelled, isFalse);
    expect(a.event.startsAt, isNotNull);
    expect(a.rows, hasLength(5));
    final kees = a.rows.first;
    expect(kees.kind, AttendanceRowKind.player);
    expect(kees.playerId, 37);
    expect(kees.shirtNumber, 1);
    expect(kees.status, AttendanceStatus.present);
    expect(kees.key, 'player-37');
    expect(a.rows[1].vacationNote, 'Zuid-Frankrijk');
    expect(a.rows[2].standingAbsent, isTrue);
    expect(a.staff.single.userId, 51);
    expect(a.staff.single.key, 'staff-51');
    expect(a.guests.single.name, 'Gerrit Gast');
    expect(a.players, hasLength(3));
    // De breuk zonder gasten, mét staf.
    expect(a.counts.present, 1);
    expect(a.counts.absent, 1);
    expect(a.counts.pending, 2);
    expect(a.guestsPresent, 1);
    expect(a.event.settableStatuses, [
      AttendanceStatus.present,
      AttendanceStatus.absent,
      AttendanceStatus.nonplay,
      AttendanceStatus.pending,
    ]);
  });

  test('activiteit: geen "kijken"; onbekende soort niet te wijzigen', () async {
    http.on(
      'GET $_base/attendance',
      200,
      AttendanceFixtures.attendance(
        type: 'activity',
        rows: [
          AttendanceFixtures.row(kind: 'coach', userId: 4, name: 'X'),
          AttendanceFixtures.row(name: 'Y', status: 'weird'),
        ],
      ),
    );

    final a = await repository.fetch(3, 412);

    expect(a.event.settableStatuses, isNot(contains(AttendanceStatus.nonplay)));
    expect(a.rows.first.kind, AttendanceRowKind.unknown);
    expect(a.rows.first.isEditable, isFalse);
    expect(a.rows.last.status, AttendanceStatus.pending);
    expect(a.rows.last.isEditable, isFalse); // geen player_id
  });

  test('403/404 worden getypte fouten', () async {
    http.on('GET $_base/attendance', 403, {'message': 'Nee.'});
    await expectLater(
      repository.fetch(3, 412),
      throwsA(isA<ForbiddenException>()),
    );
    http.on('GET $_base/attendance', 404, {'message': 'Weg.'});
    await expectLater(
      repository.fetch(3, 412),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('speler namens hem: PATCH …/attendance/{player}', () async {
    http.on(
      'PATCH $_base/attendance/42',
      200,
      AttendanceFixtures.saved(playerId: 42),
    );

    final status = await repository.setOnBehalf(
      3,
      412,
      const AttendanceRow(playerId: 42, name: 'Piet'),
      AttendanceStatus.present,
    );

    expect(status, AttendanceStatus.present);
    expect(http.requests.single.body, {'status': 'present'});
  });

  test('staf namens hem: PATCH …/attendance/staff/{user}', () async {
    http.on(
      'PATCH $_base/attendance/staff/51',
      200,
      AttendanceFixtures.saved(playerId: null, userId: 51, status: 'pending'),
    );

    final status = await repository.setOnBehalf(
      3,
      412,
      const AttendanceRow(kind: AttendanceRowKind.staff, userId: 51),
      AttendanceStatus.pending,
    );

    expect(status, AttendanceStatus.pending);
    expect(http.requests.single.body, {'status': 'pending'});
  });

  test('afgelast: 403 bij wijzigen', () async {
    http.on('PATCH $_base/attendance/42', 403, {
      'message': 'Afgelast. Aanwezigheid staat vast.',
    });
    await expectLater(
      repository.setOnBehalf(
        3,
        412,
        const AttendanceRow(playerId: 42),
        AttendanceStatus.absent,
      ),
      throwsA(
        isA<ForbiddenException>().having(
          (e) => e.message,
          'message',
          'Afgelast. Aanwezigheid staat vast.',
        ),
      ),
    );
  });

  test('gastopties lezen', () async {
    http.on('GET $_base/guests/options', 200, AttendanceFixtures.options());

    final options = await repository.guestOptions(3, 412);

    expect(options.single.id, 89);
    expect(options.single.shirtNumber, 31);
    expect(options.single.position, 'MF');
  });

  test('bestaande gast toevoegen: existing_player_id', () async {
    http.on('POST $_base/guests', 201, AttendanceFixtures.guest());

    final guest = await repository.addExistingGuest(3, 412, 89);

    expect(http.requests.single.body, {'existing_player_id': 89});
    expect(guest.id, 89);
    expect(guest.fromTeam, 'JO19-2');
    expect(guest.isGuest, isTrue);
  });

  test('nieuwe gast: naam, rugnummer, positie (leeg → null)', () async {
    http.on('POST $_base/guests', 201, AttendanceFixtures.guest(id: 90));

    await repository.createGuest(
      3,
      412,
      const NewGuest(name: '  Nina Nieuw ', shirtNumber: 44, position: 'MF'),
    );
    await repository.createGuest(
      3,
      412,
      const NewGuest(name: 'Zonder', position: ''),
    );

    expect(http.requests.first.body, {
      'name': 'Nina Nieuw',
      'shirt_number': 44,
      'position': 'MF',
    });
    expect(http.requests.last.body, {
      'name': 'Zonder',
      'shirt_number': null,
      'position': null,
    });
  });

  test('gast toevoegen 422 geeft de veldfout', () async {
    http.on('POST $_base/guests', 422, {
      'message': 'De naam is verplicht.',
      'errors': {
        'name': ['De naam is verplicht.'],
      },
    });
    await expectLater(
      repository.createGuest(3, 412, const NewGuest(name: '')),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.fieldError('name'),
          'name',
          'De naam is verplicht.',
        ),
      ),
    );
  });

  test('gast weghalen geeft de bijgewerkte opties', () async {
    http.on(
      'DELETE $_base/guests/88',
      200,
      AttendanceFixtures.options(
        list: [
          {
            'id': 88,
            'name': 'Gerrit Gast',
            'shirt_number': 30,
            'position': 'DF',
          },
        ],
      ),
    );

    final options = await repository.removeGuest(3, 412, 88);

    expect(options.single.id, 88);
    expect(http.requests.single.method, 'DELETE');
  });
}
