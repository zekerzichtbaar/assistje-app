import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/settings/data/models/settings_models.dart';
import 'package:assistje/features/settings/data/settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'settings_fixtures.dart';

void main() {
  late FakeHttpAdapter http;
  late SettingsRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = SettingsRepository(
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

  Object? body(String route) => http.requestsTo(route).single.body;

  test('GET settings: alle onderdelen uit de docs', () async {
    http.on('GET /teams/3/settings', 200, SettingsFixtures.response());

    final s = await repository.fetch(3);

    expect(s.team.id, 3);
    expect(s.team.name, 'Vogels 3');
    expect(s.team.primaryColor, '#006837');
    expect(s.team.logoUrl, isNull);
    expect(s.team.formation, '4-3-3');
    expect(s.formations, ['4-3-3', '4-4-2', '3-5-2']);
    expect(s.rsvp.mode, RsvpMode.relative);
    expect(s.rsvp.matchHours, 24);
    expect(s.rsvp.trainingHours, 4);
    expect(s.rsvp.weeklyDay, isNull);
    expect(s.featureEnabled('fines'), isTrue);
    expect(s.featureEnabled('bestaat-niet'), isFalse);
    expect(s.features.first.description, 'Boetes bijhouden en innen.');
    final wash = s.dutyTypes.first;
    expect(wash.id, 12);
    expect(wash.mode, DutyMode.individual);
    expect(wash.scope, DutyScope.match);
    expect(wash.autoRotate, isTrue);
    expect(wash.onUnavailable, DutyOnUnavailable.reassign);
    expect(wash.pool, ['players']);
    expect(s.dutyPeople.last.kind, 'staff');
    expect(s.ical.eventsUrl, endsWith('/events.ics'));
    expect(s.ical.trainingsUrl, endsWith('/trainings.ics'));
    expect(s.carpool.reminderHours, 4);
    expect(s.guests.attendance, GuestAttendance.training);
    expect(s.guests.inStats, isTrue);
    expect(s.trainingPoints.attendancePoint, isFalse);
    expect(s.period.mode, 'dates');
    expect(s.period.seasonLabel, '2026/2027');
    expect(s.period.seasonMatchCount, 22);
    expect(s.period.closedSeason?.label, '2025/2026');
    expect(s.period.periods.single.targetMatches, 8);
    expect(s.period.periods.single.playedMatches, 3);
  });

  test('GET settings: ruim lezen (0/1, onbekende standen, nulls)', () async {
    http.on(
      'GET /teams/3/settings',
      200,
      SettingsFixtures.response(
        SettingsFixtures.settings(
          rsvp: {
            'mode': 'monthly',
            'match_hours': '12',
            'training_hours': null,
            'weekly_day': null,
            'weekly_time': null,
          },
          guests: {
            'attendance': 'everyone',
            'in_fines': 1,
            'in_stats': 0,
            'staff_in_fines': null,
          },
          dutyTypes: [
            {
              ...SettingsFixtures.wash(),
              'mode': 'rotating',
              'on_unavailable': null,
              'pool': null,
            },
          ],
        ),
      ),
    );

    final s = await repository.fetch(3);

    expect(s.rsvp.mode, RsvpMode.relative);
    expect(s.rsvp.matchHours, 12);
    expect(s.guests.attendance, GuestAttendance.none);
    expect(s.guests.inFines, isTrue);
    expect(s.guests.inStats, isFalse);
    expect(s.guests.staffInFines, isFalse);
    expect(s.dutyTypes.single.mode, DutyMode.group);
    expect(s.dutyTypes.single.onUnavailable, isNull);
    expect(s.dutyTypes.single.pool, isEmpty);
  });

  test('403 van GET komt als ForbiddenException', () async {
    http.on('GET /teams/3/settings', 403, {'message': 'Nee.'});
    await expectLater(repository.fetch(3), throwsA(isA<ForbiddenException>()));
  });

  test('PATCH settings/team stuurt naam, kleur, opstelling en rand', () async {
    http.on(
      'PATCH /teams/3/settings/team',
      200,
      SettingsFixtures.response(
        SettingsFixtures.settings(
          team: SettingsFixtures.team(formation: '4-4-2', logoFills: true),
        ),
      ),
    );

    final s = await repository.updateTeam(
      3,
      const TeamBranding(
        name: 'Vogels 3',
        primaryColor: '#006837',
        formation: '4-4-2',
        logoFills: true,
      ),
    );

    expect(body('PATCH /teams/3/settings/team'), {
      'name': 'Vogels 3',
      'primary_color': '#006837',
      'formation': '4-4-2',
      'logo_fills': true,
    });
    expect(s.team.formation, '4-4-2');
    expect(s.team.logoFills, isTrue);
  });

  test('PATCH settings/team: 422 komt met veldfouten', () async {
    http.on('PATCH /teams/3/settings/team', 422, {
      'message': 'Ongeldig.',
      'errors': {
        'primary_color': ['Kies een geldige kleur.'],
      },
    });

    await expectLater(
      repository.updateTeam(
        3,
        const TeamBranding(name: 'X', primaryColor: '#zzzzzz'),
      ),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.fieldError('primary_color'),
          'primary_color',
          'Kies een geldige kleur.',
        ),
      ),
    );
    // Zonder opstelling/rand gaan die velden niet mee.
    expect(body('PATCH /teams/3/settings/team'), {
      'name': 'X',
      'primary_color': '#zzzzzz',
    });
  });

  test('POST settings/team/logo stuurt de data-URI', () async {
    http.on(
      'POST /teams/3/settings/team/logo',
      200,
      SettingsFixtures.response(
        SettingsFixtures.settings(
          team: SettingsFixtures.team(
            color: '#C8102E',
            logoUrl: 'https://assistje.nl/storage/teams/3/logo-ab12cd34.png',
          ),
        ),
      ),
    );

    final s = await repository.uploadLogo(3, 'data:image/png;base64,iVBO');

    expect(body('POST /teams/3/settings/team/logo'), {
      'logo_base64': 'data:image/png;base64,iVBO',
    });
    expect(s.team.logoUrl, endsWith('logo-ab12cd34.png'));
    expect(s.team.primaryColor, '#C8102E');
  });

  test('DELETE settings/team/logo', () async {
    http.on(
      'DELETE /teams/3/settings/team/logo',
      200,
      SettingsFixtures.response(),
    );

    final s = await repository.removeLogo(3);

    expect(http.requestsTo('DELETE /teams/3/settings/team/logo'), hasLength(1));
    expect(s.team.logoUrl, isNull);
  });

  test('PATCH settings/rsvp: per event', () async {
    http.on('PATCH /teams/3/settings/rsvp', 200, SettingsFixtures.response());

    await repository.updateRsvp(
      3,
      const RsvpUpdate.relative(matchHours: 48, trainingHours: 6),
    );

    expect(body('PATCH /teams/3/settings/rsvp'), {
      'rsvp_deadline_mode': 'relative',
      'rsvp_deadline_match_hours': 48,
      'rsvp_deadline_training_hours': 6,
    });
  });

  test('PATCH settings/rsvp: wekelijks', () async {
    http.on(
      'PATCH /teams/3/settings/rsvp',
      200,
      SettingsFixtures.response(
        SettingsFixtures.settings(
          rsvp: {
            'mode': 'weekly',
            'match_hours': 24,
            'training_hours': 4,
            'weekly_day': 3,
            'weekly_time': '18:30',
          },
        ),
      ),
    );

    final s = await repository.updateRsvp(
      3,
      const RsvpUpdate.weekly(weeklyDay: 3, weeklyTime: '18:30'),
    );

    expect(body('PATCH /teams/3/settings/rsvp'), {
      'rsvp_deadline_mode': 'weekly',
      'rsvp_weekly_day': 3,
      'rsvp_weekly_time': '18:30',
    });
    expect(s.rsvp.mode, RsvpMode.weekly);
    expect(s.rsvp.weeklyTime, '18:30');
  });

  test('POST settings/ical/rotate zonder body', () async {
    http.on(
      'POST /teams/3/settings/ical/rotate',
      200,
      SettingsFixtures.response(
        SettingsFixtures.settings(
          ical: {
            'events_url': 'https://assistje.nl/calendar/XyZ48/events.ics',
            'trainings_url': 'https://assistje.nl/calendar/XyZ48/trainings.ics',
          },
        ),
      ),
    );

    final s = await repository.rotateIcal(3);

    expect(body('POST /teams/3/settings/ical/rotate'), isNull);
    expect(s.ical.eventsUrl, contains('XyZ48'));
  });

  test('PATCH settings/features/{key}', () async {
    http.on(
      'PATCH /teams/3/settings/features/fines',
      200,
      SettingsFixtures.response(
        SettingsFixtures.settings(
          features: SettingsFixtures.features(fines: false),
        ),
      ),
    );

    final s = await repository.setFeature(3, 'fines', enabled: false);

    expect(body('PATCH /teams/3/settings/features/fines'), {'enabled': false});
    expect(s.featureEnabled('fines'), isFalse);
  });

  test('PATCH settings/carpool-hours', () async {
    http.on(
      'PATCH /teams/3/settings/carpool-hours',
      200,
      SettingsFixtures.response(SettingsFixtures.settings(carpoolHours: 6)),
    );

    final s = await repository.setCarpoolHours(3, 6);

    expect(body('PATCH /teams/3/settings/carpool-hours'), {'hours': 6});
    expect(s.carpool.reminderHours, 6);
  });

  test('PATCH settings/guests stuurt alleen wat wijzigt', () async {
    http.on('PATCH /teams/3/settings/guests', 200, SettingsFixtures.response());

    await repository.updateGuests(
      3,
      const GuestUpdate(attendance: GuestAttendance.all, staffInFines: true),
    );

    expect(body('PATCH /teams/3/settings/guests'), {
      'guest_attendance': 'all',
      'staff_in_fines': true,
    });
  });

  test('PATCH settings/training-points', () async {
    http.on(
      'PATCH /teams/3/settings/training-points',
      200,
      SettingsFixtures.response(
        SettingsFixtures.settings(attendancePoint: true),
      ),
    );

    final s = await repository.setTrainingAttendancePoint(3, enabled: true);

    expect(body('PATCH /teams/3/settings/training-points'), {
      'training_attendance_point': true,
    });
    expect(s.trainingPoints.attendancePoint, isTrue);
  });

  test('POST settings/duty-types (201) met alle velden', () async {
    http.on(
      'POST /teams/3/settings/duty-types',
      201,
      SettingsFixtures.response(
        SettingsFixtures.settings(
          dutyTypes: [
            SettingsFixtures.wash(),
            {
              ...SettingsFixtures.wash(),
              'id': 31,
              'name': 'Rijden',
              'slug': 'rijden',
              'icon': 'Car',
              'pool': ['players', 'guests'],
            },
          ],
        ),
      ),
    );

    final s = await repository.createDutyType(
      3,
      const DutyTypeInput(
        name: ' Rijden ',
        icon: 'Car',
        mode: DutyMode.individual,
        scope: DutyScope.match,
        autoRotate: true,
        pool: ['players', 'guests'],
      ),
    );

    expect(body('POST /teams/3/settings/duty-types'), {
      'name': 'Rijden',
      'icon': 'Car',
      'mode': 'individual',
      'scope': 'match',
      'auto_rotate': true,
      'on_unavailable': 'reassign',
      'pool': ['players', 'guests'],
      'pool_members': <String>[],
    });
    expect(s.dutyTypes.last.id, 31);
  });

  test('DutyTypeInput: rotatie alleen bij individueel + wedstrijd', () {
    // Standaard: groepen, losse datums.
    const input = DutyTypeInput(name: 'Kantine', autoRotate: true);
    expect(input.toJson()['auto_rotate'], isFalse);
    expect(input.toJson()['on_unavailable'], 'notify');
    expect(input.toJson()['icon'], isNull);
  });

  test('PATCH settings/duty-types/{id}', () async {
    http.on(
      'PATCH /teams/3/settings/duty-types/12',
      200,
      SettingsFixtures.response(
        SettingsFixtures.settings(
          dutyTypes: [
            {...SettingsFixtures.wash(), 'name': 'Wasdienst'},
          ],
        ),
      ),
    );

    final s = await repository.updateDutyType(
      3,
      12,
      DutyTypeInput.from(
        DutyTypeSetting.fromJson(SettingsFixtures.wash()),
      ).copyWithName('Wasdienst'),
    );

    final sent = body('PATCH /teams/3/settings/duty-types/12')! as Map;
    expect(sent['name'], 'Wasdienst');
    expect(sent['mode'], 'individual');
    expect(sent['icon'], 'TShirt');
    expect(s.dutyTypes.single.name, 'Wasdienst');
  });

  test('DELETE settings/duty-types/{id}', () async {
    http.on(
      'DELETE /teams/3/settings/duty-types/13',
      200,
      SettingsFixtures.response(
        SettingsFixtures.settings(dutyTypes: [SettingsFixtures.wash()]),
      ),
    );

    final s = await repository.deleteDutyType(3, 13);

    expect(
      http.requestsTo('DELETE /teams/3/settings/duty-types/13'),
      hasLength(1),
    );
    expect(s.dutyTypes.map((d) => d.id), [12]);
  });

  test('een antwoord zonder data is een fout', () async {
    http.on('GET /teams/3/settings', 200, {'oops': true});
    await expectLater(repository.fetch(3), throwsA(isA<UnknownApiException>()));
  });
}

extension on DutyTypeInput {
  DutyTypeInput copyWithName(String name) => DutyTypeInput(
    name: name,
    icon: icon,
    mode: mode,
    scope: scope,
    autoRotate: autoRotate,
    onUnavailable: onUnavailable,
    pool: pool,
    poolMembers: poolMembers,
  );
}
