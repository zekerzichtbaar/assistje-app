import 'package:assistje/features/agenda/application/agenda_controller.dart';
import 'package:assistje/features/agenda/application/agenda_items.dart';
import 'package:assistje/features/agenda/data/models/agenda_models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';

AgendaEvent _event({
  int id = 412,
  String type = 'match',
  String? startsAt,
  String? myStatus = 'pending',
}) => AgendaEvent.fromJson(
  ApiFixtures.agendaEvent(
    id: id,
    type: type,
    startsAt: startsAt,
    myStatus: myStatus,
  ),
);

AgendaDuty _duty({
  int dutyId = 88,
  int? eventId = 412,
  bool matchBound = true,
  String date = '2099-10-11T00:00:00+02:00',
  List<String> names = const ['Sam de Vries'],
  String? group = 'Sam de Vries',
  String? startsAt,
}) => AgendaDuty.fromJson({
  ...ApiFixtures.agendaDuty(
    dutyId: dutyId,
    eventId: eventId,
    matchBound: matchBound,
    date: date,
    playerNames: names,
    groupName: group,
  ),
  'starts_at': startsAt,
});

void main() {
  group('buildAgendaItems', () {
    test('vouwt een wedstrijddienst onder zijn wedstrijd (op event_id)', () {
      final items = buildAgendaItems(events: [_event()], duties: [_duty()]);

      final item = items.single as AgendaEventItem;
      expect(item.dutyChips.single.label, 'Sam');
      expect(item.dutyChips.single.mine, isTrue);
      expect(item.dutyChips.single.icon, 't-shirt');
    });

    test('valt terug op de datum, en een groep toont de groepsnaam', () {
      final items = buildAgendaItems(
        events: [_event()],
        duties: [
          _duty(eventId: null, names: const ['A B', 'C D'], group: 'Groep 2'),
        ],
      );

      final item = items.single as AgendaEventItem;
      expect(item.dutyChips.single.label, 'Groep 2');
    });

    test('een groep zonder naam telt de personen', () {
      final items = buildAgendaItems(
        events: [_event()],
        duties: [
          _duty(names: const ['A B', 'C D', 'E F'], group: null),
        ],
      );
      final chip = (items.single as AgendaEventItem).dutyChips.single;
      expect(chip.label, isEmpty);
      expect(chip.peopleCount, 3);
    });

    test('een losse dienst blijft een eigen rij; sortering op tijd', () {
      final items = buildAgendaItems(
        events: [
          _event(id: 1, startsAt: '2099-10-12T20:28:00+02:00'),
          _event(id: 2, type: 'training', startsAt: '2099-10-10T19:00:00Z'),
        ],
        duties: [
          _duty(dutyId: 5, eventId: null, matchBound: false, startsAt: '16:00'),
        ],
        birthdays: [
          AgendaBirthday.fromJson({
            ...ApiFixtures.agendaBirthday(),
            'date': '2099-10-13',
          }),
        ],
      );

      expect(items.map((i) => i.key), ['e-2', 'd-duty-5', 'e-1', 'b-p17']);

      final past = buildAgendaItems(
        events: [
          _event(id: 1, startsAt: '2099-10-12T20:28:00+02:00'),
          _event(id: 2, startsAt: '2099-10-10T19:00:00Z'),
        ],
        duties: const [],
        descending: true,
      );
      expect(past.map((i) => i.key), ['e-1', 'e-2']);
    });

    test('een wedstrijddienst zonder wedstrijd blijft zichtbaar', () {
      final items = buildAgendaItems(
        events: [_event(type: 'training')],
        duties: [_duty(eventId: 999)],
      );
      expect(items.whereType<AgendaDutyItem>(), hasLength(1));
    });
  });

  group('RSVP', () {
    test('nogmaals tikken zet terug op openstaand', () {
      expect(
        nextRsvpStatus(AttendanceStatus.present, AttendanceStatus.present),
        AttendanceStatus.pending,
      );
      expect(
        nextRsvpStatus(AttendanceStatus.absent, AttendanceStatus.present),
        AttendanceStatus.absent,
      );
      expect(
        nextRsvpStatus(AttendanceStatus.present, null),
        AttendanceStatus.present,
      );
    });

    test('speler verschuift breuk én spelers-telling', () {
      final next = applyOwnRsvp(
        _event(),
        AttendanceStatus.present,
        const AgendaMe(),
      );
      expect(next.myStatus, AttendanceStatus.present);
      expect(next.counts.present, 10);
      expect(next.counts.pending, 4);
      expect(next.effectivePlayerCounts.present, 9);
      expect(next.effectivePlayerCounts.pending, 4);
      expect(next.guestCounts.present, 0);
    });

    test('gast verschuift alleen de gast-teller; staf alleen de breuk', () {
      final guest = applyOwnRsvp(
        _event(myStatus: null),
        AttendanceStatus.absent,
        const AgendaMe(isGuest: true),
      );
      expect(guest.counts.absent, 2);
      expect(guest.guestCounts.absent, 1);
      expect(guest.effectivePlayerCounts.absent, 2);

      final staff = applyOwnRsvp(
        _event(),
        AttendanceStatus.absent,
        const AgendaMe(isStaff: true),
      );
      expect(staff.counts.absent, 3);
      expect(staff.effectivePlayerCounts.absent, 2);

      final spectator = applyOwnRsvp(_event(), AttendanceStatus.present, null);
      expect(spectator.counts, _event().counts);
      expect(spectator.myStatus, AttendanceStatus.present);
    });

    test('tellers gaan nooit onder nul', () {
      const counts = AttendanceCounts();
      expect(
        counts.shift(AttendanceStatus.absent, AttendanceStatus.present),
        const AttendanceCounts(present: 1),
      );
    });
  });

  test('live-klok: binnen het deel 38\', erbuiten 45+3\'', () {
    final now = DateTime.utc(2099, 1, 1, 12);
    const live = LiveState(
      isLive: true,
      accumulatedSeconds: 38 * 60,
      periodEnds: [45, 90],
    );
    expect(live.clockLabel(now), "38'");
    expect(
      live.copyWith(accumulatedSeconds: 48 * 60 + 10).clockLabel(now),
      "45+3'",
    );
    final running = live.copyWith(
      running: true,
      accumulatedSeconds: 0,
      startedAt: now.subtract(const Duration(minutes: 12)),
    );
    expect(running.clockLabel(now), "12'");
  });
}
