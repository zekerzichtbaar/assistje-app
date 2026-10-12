import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/agenda/data/agenda_repository.dart';
import 'package:assistje/features/agenda/data/models/agenda_models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';

void main() {
  late FakeHttpAdapter http;
  late AgendaRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = AgendaRepository(
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

  test('leest het voorbeeld uit docs/api/v1/agenda.md', () async {
    http.on(
      'GET /teams/3/agenda',
      200,
      ApiFixtures.agendaResponse(
        upcoming: [ApiFixtures.agendaEvent(year: 2026)],
        upcomingDuties: [
          ApiFixtures.agendaDuty(date: '2026-10-11T00:00:00+02:00'),
        ],
        upcomingTotal: 14,
        pastTotal: 22,
      ),
    );

    final page = await repository.fetch(3);

    // Standaardvenster: geen ?limit= nodig.
    expect(http.requests.single.options.uri.queryParameters, isEmpty);
    final data = page.data;
    expect(data.canRsvp, isTrue);
    expect(data.me, const AgendaMe());
    final event = data.upcoming.single;
    expect(event.id, 412);
    expect(event.type, EventType.match);
    expect(event.startsAt, DateTime.parse('2026-10-11T14:30:00+02:00'));
    expect(event.meetAt, DateTime.parse('2026-10-11T13:45:00+02:00'));
    expect(event.homeTeam, 'Vogels 3');
    expect(event.awayTeam, 'Arnhemia 2');
    expect(event.myStatus, AttendanceStatus.pending);
    expect(
      event.counts,
      const AttendanceCounts(present: 9, absent: 2, pending: 5),
    );
    expect(event.playerCounts?.present, 8);
    expect(event.guestCounts, const AttendanceCounts());
    expect(event.live?.isLive, isFalse);
    expect(event.live?.periodEnds, [45, 90]);
    expect(event.rsvpStatuses, [
      AttendanceStatus.present,
      AttendanceStatus.absent,
      AttendanceStatus.nonplay,
    ]);
    expect(event.canRsvp, isTrue);

    final duty = data.upcomingDuties.single;
    expect(duty.key, 'duty-88');
    expect(duty.eventId, 412);
    expect(duty.matchBound, isTrue);
    expect(duty.icon, 't-shirt');
    expect(duty.playerNames, ['Sam de Vries']);
    expect(duty.mine, isTrue);
    expect(duty.dayKey, '2026-10-11');

    final birthday = data.birthdays.single;
    expect(birthday.name, 'Joris');
    expect(birthday.turning, 24);
    expect(birthday.isToday, isFalse);

    expect(data.dutyTypes.single.slug, 'canteen');
    expect(data.agendaFeedUrl, contains('agenda.ics'));
    expect(page.meta.upcomingTotal, 14);
    expect(page.meta.pastTotal, 22);
    expect(page.meta.pageSize, 30);
  });

  test('onbekende types en statussen breken het parsen niet', () {
    final event = AgendaEvent.fromJson({
      ...ApiFixtures.agendaEvent(),
      'type': 'tournament',
      'my_status': 'maybe',
      'live': null,
      'player_counts': null,
    });
    expect(event.type, EventType.unknown);
    expect(event.myStatus, AttendanceStatus.pending);
    expect(event.live, isNull);
    expect(event.effectivePlayerCounts, event.counts);
  });

  test('een groter venster gaat als ?limit= mee', () async {
    http.on('GET /teams/3/agenda', 200, ApiFixtures.agendaResponse(limit: 60));

    final page = await repository.fetch(3, limit: 60);

    expect(http.requests.single.options.uri.queryParameters, {'limit': '60'});
    expect(page.meta.limit, 60);
  });

  test('PATCH attendance stuurt status en reden', () async {
    http.on(
      'PATCH /teams/3/events/412/attendance',
      200,
      ApiFixtures.attendanceResponse(),
    );

    final result = await repository.setAttendance(
      3,
      412,
      AttendanceStatus.absent,
      reason: 'Ziek',
    );

    expect(http.requests.single.body, {'status': 'absent', 'reason': 'Ziek'});
    expect(result.eventId, 412);
    expect(result.status, AttendanceStatus.absent);
    expect(result.reason, 'Ziek');
    expect(result.playerId, 37);
    expect(result.changedByUserId, 51);
  });

  test('zonder reden gaat er geen reason-veld mee', () async {
    http.on(
      'PATCH /teams/3/events/412/attendance',
      200,
      ApiFixtures.attendanceResponse(status: 'present', reason: null),
    );

    await repository.setAttendance(3, 412, AttendanceStatus.present);

    expect(http.requests.single.body, {'status': 'present'});
  });

  test('422 met errors.reason en 403 komen als ApiException', () async {
    http
      ..on('PATCH /teams/3/events/412/attendance', 422, {
        'message': 'Geef een reden op.',
        'errors': {
          'reason': ['Geef een reden op.'],
        },
      })
      ..on('PATCH /teams/3/events/413/attendance', 403, {
        'message': 'De aanvang is geweest. Aanwezigheid staat vast.',
      });

    await expectLater(
      repository.setAttendance(3, 412, AttendanceStatus.absent),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.fieldError('reason'),
          'reason',
          'Geef een reden op.',
        ),
      ),
    );
    await expectLater(
      repository.setAttendance(3, 413, AttendanceStatus.present),
      throwsA(
        isA<ForbiddenException>().having(
          (e) => e.message,
          'message',
          'De aanvang is geweest. Aanwezigheid staat vast.',
        ),
      ),
    );
  });
}
