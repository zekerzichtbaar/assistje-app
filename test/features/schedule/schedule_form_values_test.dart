import 'package:assistje/features/schedule/application/schedule_form_values.dart';
import 'package:assistje/features/schedule/data/models/schedule_models.dart';
import 'package:flutter_test/flutter_test.dart';

import 'schedule_fixtures.dart';

void main() {
  final options = ScheduleOptions.fromJson(
    ScheduleFixtures.options()['data'] as Map<String, dynamic>,
  );

  test('nieuw: standaarden uit de opties (training om 19:00)', () {
    final v = ScheduleFormValues.initial(options);
    expect(v.type, ScheduleType.training);
    expect(v.start, (hour: 19, minute: 0));
    expect(v.date, isNull);
    expect(v.isHome, isTrue);
    expect(v.competition, 'league');
    expect(v.hasStart, isFalse);
    expect(v.toDraft(teamName: 'X', isEdit: false), isNull);
  });

  test('bewerken: waarden van het event (uitwedstrijd → tegenstander)', () {
    final event = ScheduleEvent.fromJson(
      ScheduleFixtures.matchData({
        'is_home': false,
        'home_team': 'DVS 33',
        'away_team': 'Valleivogels 3',
        'competition': null,
      }),
    );
    final v = ScheduleFormValues.initial(options, event: event);
    final local = event.startsAt.toLocal();
    expect(v.type, ScheduleType.match);
    expect(v.date, DateTime(local.year, local.month, local.day));
    expect(v.start, (hour: local.hour, minute: local.minute));
    expect(v.meet, isNotNull);
    expect(v.isHome, isFalse);
    expect(v.opponent, 'DVS 33');
    // Zonder soort: de standaard.
    expect(v.competition, 'league');
  });

  test('wedstrijd: thuis/uit bepaalt thuis- en uitploeg', () {
    final v = ScheduleFormValues(
      type: ScheduleType.match,
      date: DateTime(2099, 11, 14),
      start: (hour: 14, minute: 0),
      opponent: ' DVS 33 ',
      isHome: false,
      title: 'weg',
      recurring: true,
      recurUntil: DateTime(2099, 12, 2),
    );
    final d = v.toDraft(teamName: 'Valleivogels 3', isEdit: false)!;
    expect(d.homeTeam, 'DVS 33');
    expect(d.awayTeam, 'Valleivogels 3');
    expect(d.isHome, isFalse);
    expect(d.title, isNull);
    expect(d.recurUntil, isNull);
  });

  test('eindtijd vóór de start valt op de dag erna', () {
    final v = ScheduleFormValues(
      type: ScheduleType.activity,
      date: DateTime(2099, 6, 3),
      start: (hour: 22, minute: 0),
      end: (hour: 1, minute: 0),
      spectatorsCanRsvp: true,
    );
    final d = v.toDraft(teamName: 'X', isEdit: false)!;
    expect(d.startsAt, DateTime(2099, 6, 3, 22));
    expect(d.endsAt, DateTime(2099, 6, 4, 1));
    expect(d.spectatorsCanRsvp, isTrue);
    expect(d.homeTeam, isNull);
  });

  test('reeks alleen bij een nieuwe training met de schakelaar aan', () {
    final v = ScheduleFormValues(
      type: ScheduleType.training,
      date: DateTime(2099, 11, 12),
      start: (hour: 19, minute: 30),
      recurUntil: DateTime(2099, 12, 19),
    );
    expect(v.toDraft(teamName: 'X', isEdit: false)!.recurUntil, isNull);
    v.recurring = true;
    expect(
      v.toDraft(teamName: 'X', isEdit: false)!.recurUntil,
      DateTime(2099, 12, 19),
    );
    expect(v.toDraft(teamName: 'X', isEdit: true)!.recurUntil, isNull);
  });

  test('alle volgende alleen bij het bewerken van een training', () {
    final v = ScheduleFormValues(
      type: ScheduleType.training,
      date: DateTime(2099, 11, 12),
      start: (hour: 19, minute: 30),
      applyToFollowing: true,
    );
    expect(
      v
          .toDraft(
            teamName: 'X',
            isEdit: true,
            originalType: ScheduleType.training,
          )!
          .applyToFollowing,
      isTrue,
    );
    expect(
      v
          .toDraft(
            teamName: 'X',
            isEdit: true,
            originalType: ScheduleType.match,
          )!
          .applyToFollowing,
      isFalse,
    );
    expect(v.toDraft(teamName: 'X', isEdit: false)!.applyToFollowing, isFalse);
  });

  test('kloktijden lezen en schrijven', () {
    expect(parseClockTime('07:05'), (hour: 7, minute: 5));
    expect(parseClockTime('25:00'), isNull);
    expect(parseClockTime('x'), isNull);
    expect(formatClockTime((hour: 7, minute: 5)), '07:05');
  });
}
