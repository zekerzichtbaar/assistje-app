import 'package:assistje/features/agenda/application/agenda_controller.dart';
import 'package:assistje/features/agenda/data/models/agenda_models.dart';
import 'package:assistje/features/event/application/event_detail_controller.dart';
import 'package:assistje/features/event/data/models/event_detail_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'event_fixtures.dart';

const _detail = 'GET /teams/3/events/412';
const _rsvp = 'PATCH /teams/3/events/412/attendance';
const _agenda = 'GET /teams/3/agenda';
const EventKey _key = (teamId: 3, eventId: 412);

void main() {
  group('applyOwnRsvpToDetail', () {
    EventDetail detail({String kind = 'player', bool guest = false}) =>
        EventDetail.fromJson(
          EventFixtures.eventDetailData({
            'players': [
              {...EventFixtures.mePlayer(), 'kind': kind, 'is_guest': guest},
            ],
          }),
        );

    test('speler: knop, eigen rij, breuk en spelers-telling', () {
      final next = applyOwnRsvpToDetail(detail(), AttendanceStatus.present);
      expect(next.myStatus, AttendanceStatus.present);
      expect(next.myReason, isNull);
      expect(next.me?.status, AttendanceStatus.present);
      expect(next.me?.reason, isNull);
      expect(next.counts.present, 10);
      expect(next.counts.absent, 1);
      expect(next.playerCounts.present, 9);
      expect(next.playerCounts.absent, 1);
    });

    test('staf: alleen de breuk', () {
      final next = applyOwnRsvpToDetail(
        detail(kind: 'staff'),
        AttendanceStatus.present,
      );
      expect(next.counts.present, 10);
      expect(next.playerCounts.present, 8);
    });

    test('gast of toeschouwer: tellers blijven staan', () {
      for (final d in [detail(guest: true), detail(kind: 'spectator')]) {
        final next = applyOwnRsvpToDetail(d, AttendanceStatus.present);
        expect(next.counts, d.counts);
        expect(next.playerCounts, d.playerCounts);
        expect(next.me?.status, AttendanceStatus.present);
      }
    });

    test('reden blijft alleen bij afwezig/kijken', () {
      final next = applyOwnRsvpToDetail(
        detail(),
        AttendanceStatus.nonplay,
        reason: 'Knie',
      );
      expect(next.myReason, 'Knie');
      expect(next.me?.reason, 'Knie');
    });
  });

  group('EventDetailController', () {
    late TestBackend backend;
    late ProviderContainer container;

    Future<EventDetailController> start(
      void Function(FakeHttpAdapter http) setup,
    ) async {
      backend = TestBackend(token: '12|abc');
      await backend.init();
      backend.http.on(_agenda, 200, ApiFixtures.emptyAgendaResponse());
      setup(backend.http);
      container = backend.container();
      addTearDown(container.dispose);
      container.listen(eventDetailControllerProvider(_key), (_, _) {});
      await container.read(eventDetailControllerProvider(_key).future);
      return container.read(eventDetailControllerProvider(_key).notifier);
    }

    EventDetail current() =>
        container.read(eventDetailControllerProvider(_key)).requireValue;

    test('laadt en ververst', () async {
      await start((http) => http.on(_detail, 200, EventFixtures.eventDetail()));
      expect(current().id, 412);

      backend.http.on(
        _detail,
        200,
        EventFixtures.eventDetail({'notes': 'Nieuw'}),
      );
      final error = await container
          .read(eventDetailControllerProvider(_key).notifier)
          .refresh();
      expect(error, isNull);
      expect(current().notes, 'Nieuw');
    });

    test('verversen met een fout houdt de data en geeft de fout', () async {
      final controller = await start(
        (http) => http.on(_detail, 200, EventFixtures.eventDetail()),
      );
      backend.http.on(_detail, 500, {'message': 'Kapot'});

      final error = await controller.refresh();

      expect(error, isNotNull);
      expect(current().id, 412);
    });

    test('RSVP: PATCH, agenda ververst, detail opnieuw opgehaald', () async {
      var patched = false;
      final controller = await start((http) {
        http.routes[_detail] = (_) => FakeResponse(
          200,
          patched
              ? EventFixtures.withMe({'my_status': 'present'})
              : EventFixtures.withMe(),
        );
        http.routes[_rsvp] = (_) {
          patched = true;
          return FakeResponse(
            200,
            ApiFixtures.attendanceResponse(status: 'present', reason: null),
          );
        };
      });
      container.listen(agendaControllerProvider(3), (_, _) {});
      await container.read(agendaControllerProvider(3).future);
      expect(backend.http.requestsTo(_agenda), hasLength(1));

      final outcome = await controller.rsvp(AttendanceStatus.present);

      expect(outcome, isA<RsvpSaved>());
      expect(backend.http.requestsTo(_rsvp).single.body, {'status': 'present'});
      expect(current().myStatus, AttendanceStatus.present);
      await container.read(agendaControllerProvider(3).future);
      expect(backend.http.requestsTo(_agenda), hasLength(2));
      // Stil opnieuw opgehaald.
      await Future<void>.delayed(Duration.zero);
      expect(backend.http.requestsTo(_detail).length, greaterThanOrEqualTo(2));
    });

    test('nogmaals je eigen antwoord = terug naar openstaand', () async {
      final controller = await start((http) {
        http
          ..on(_detail, 200, EventFixtures.withMe())
          ..on(
            _rsvp,
            200,
            ApiFixtures.attendanceResponse(status: 'pending', reason: null),
          );
      });

      await controller.rsvp(AttendanceStatus.absent);

      expect(backend.http.requestsTo(_rsvp).single.body, {'status': 'pending'});
    });

    test('reden eerst vragen; daarna met reden versturen', () async {
      final controller = await start((http) {
        http
          ..on(_detail, 200, EventFixtures.withMe({'my_status': 'present'}))
          ..on(_rsvp, 200, ApiFixtures.attendanceResponse());
      });

      final first = await controller.rsvp(
        AttendanceStatus.absent,
        askReasonFirst: true,
      );
      expect(first, isA<RsvpNeedsReason>());
      expect(backend.http.requestsTo(_rsvp), isEmpty);

      final second = await controller.rsvp(
        AttendanceStatus.absent,
        reason: 'Ziek',
        askReasonFirst: true,
      );
      expect(second, isA<RsvpSaved>());
      expect(backend.http.requestsTo(_rsvp).single.body, {
        'status': 'absent',
        'reason': 'Ziek',
      });
    });

    test('422 op reason: terugdraaien en om reden vragen', () async {
      final controller = await start((http) {
        http
          ..on(_detail, 200, EventFixtures.withMe({'my_status': 'present'}))
          ..on(_rsvp, 422, {
            'message': 'Geef een reden op.',
            'errors': {
              'reason': ['Geef een reden op.'],
            },
          });
      });

      final outcome = await controller.rsvp(AttendanceStatus.absent);

      expect(outcome, isA<RsvpNeedsReason>());
      expect((outcome as RsvpNeedsReason).message, 'Geef een reden op.');
      expect(current().myStatus, AttendanceStatus.present);
      expect(current().counts.present, 9);
    });

    test('can_change uit: niets versturen', () async {
      final controller = await start(
        (http) =>
            http.on(_detail, 200, EventFixtures.withMe({'can_change': false})),
      );

      final outcome = await controller.rsvp(AttendanceStatus.present);

      expect(outcome, isA<RsvpFailed>());
      expect(backend.http.requestsTo(_rsvp), isEmpty);
    });

    test('MOTM: stem optimistisch, terug bij een fout', () async {
      final controller = await start((http) {
        http
          ..on(
            _detail,
            200,
            EventFixtures.eventDetail({'motm': EventFixtures.openMotm()}),
          )
          ..on('POST /teams/3/events/412/motm', 200, EventFixtures.motmVote());
      });

      expect(await controller.voteMotm(37), isNull);
      expect(current().motm?.myVote, 37);

      backend.http.on('DELETE /teams/3/events/412/motm', 500, {
        'message': 'Kapot',
      });
      expect(await controller.unvoteMotm(), isNotNull);
      expect(current().motm?.myVote, 37);

      backend.http.on('DELETE /teams/3/events/412/motm', 204);
      expect(await controller.unvoteMotm(), isNull);
      expect(current().motm?.myVote, isNull);
    });

    test('carpool: aanmelden voegt toe, weghalen haalt weg', () async {
      final controller = await start((http) {
        http
          ..on(_detail, 200, EventFixtures.eventDetail())
          ..on(
            'POST /teams/3/events/412/carpool',
            201,
            EventFixtures.carpoolOffer(),
          )
          ..on('DELETE /teams/3/events/412/carpool', 204);
      });

      expect(
        await controller.saveCarpool(CarpoolMode.fromClub, seats: 3),
        isNull,
      );
      expect(current().carpoolOffers, hasLength(2));
      expect(current().carpoolOffers!.last.isSelf, isTrue);

      // Bijwerken vervangt je eigen regel.
      expect(
        await controller.saveCarpool(CarpoolMode.fromClub, seats: 3),
        isNull,
      );
      expect(current().carpoolOffers, hasLength(2));

      expect(await controller.removeCarpool(), isNull);
      expect(current().carpoolOffers, hasLength(1));
      expect(current().carpoolOffers!.single.isSelf, isFalse);
    });

    test('carpool: 422 geeft de fout terug, lijst ongewijzigd', () async {
      final controller = await start((http) {
        http
          ..on(_detail, 200, EventFixtures.eventDetail())
          ..on(
            'POST /teams/3/events/412/carpool',
            422,
            EventFixtures.carpoolError(),
          );
      });

      final error = await controller.saveCarpool(CarpoolMode.direct);

      expect(error, isNotNull);
      expect(current().carpoolOffers, hasLength(1));
    });
  });
}
