import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/agenda/data/models/agenda_models.dart';
import 'package:assistje/features/schedule/data/models/schedule_models.dart';
import 'package:assistje/features/schedule/data/schedule_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'schedule_fixtures.dart';

const _base = '/teams/3/schedule';

void main() {
  late FakeHttpAdapter http;
  late ScheduleRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = ScheduleRepository(
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

  final match = ScheduleDraft(
    type: ScheduleType.match,
    startsAt: DateTime(2099, 11, 14, 14),
    meetAt: DateTime(2099, 11, 14, 13, 15),
    isHome: true,
    homeTeam: 'Valleivogels 3',
    awayTeam: 'DVS 33',
    competition: 'league',
    venue: 'Sportpark De Groene Velden',
    title: 'genegeerd',
    recurUntil: DateTime(2099, 12, 19),
  );

  test('GET options', () async {
    http.on('GET $_base/options', 200, ScheduleFixtures.options());

    final o = await repository.options(3);

    expect(o.teamName, 'Valleivogels 3');
    expect(o.timezone, 'Europe/Amsterdam');
    expect(o.knownTypes, [
      ScheduleType.training,
      ScheduleType.match,
      ScheduleType.activity,
    ]);
    expect(o.typeLabel(ScheduleType.match), 'Wedstrijd');
    expect(o.competitions.map((c) => c.label), [
      'Competitie',
      'Beker',
      'Oefenwedstrijd',
    ]);
    expect(o.defaults.type, 'training');
    expect(o.defaults.trainingStartTime, '19:00');
    expect(o.defaults.isHome, isTrue);
    expect(o.defaults.durationMinutes, {
      'match': 105,
      'training': 90,
      'activity': 90,
    });
  });

  test('POST schedule: wedstrijd, body en event + meta', () async {
    http.on(
      'POST $_base',
      201,
      ScheduleFixtures.write(ScheduleFixtures.matchData(), {
        'created_ids': [512],
        'adopted_ids': <int>[],
      }),
    );

    final r = await repository.create(3, match);

    final body = http.requestsTo('POST $_base').single.body! as Map;
    expect(body['type'], 'match');
    expect(body['starts_at'], startsWith('2099-11-14T14:00:00'));
    expect(body['meet_at'], startsWith('2099-11-14T13:15:00'));
    expect(body['ends_at'], isNull);
    expect(body['home_team'], 'Valleivogels 3');
    expect(body['away_team'], 'DVS 33');
    expect(body['is_home'], isTrue);
    expect(body['competition'], 'league');
    expect(body['venue'], 'Sportpark De Groene Velden');
    // Bij een wedstrijd bouwt de server de titel; geen reeks.
    expect(body['title'], isNull);
    expect(body.containsKey('recur_until'), isFalse);
    expect(body.containsKey('apply_to_following'), isFalse);
    expect(body['spectators_can_rsvp'], isFalse);

    expect(r.event.id, 512);
    expect(r.event.type, EventType.match);
    expect(r.event.homeTeam, 'Valleivogels 3');
    expect(r.schedule.canCancel, isTrue);
    expect(r.createdIds, [512]);
    expect(r.adoptedIds, isEmpty);
    expect(r.seriesCount, 1);
  });

  test('POST schedule: reeks trainingen met recur_until', () async {
    http.on(
      'POST $_base',
      201,
      ScheduleFixtures.write(ScheduleFixtures.trainingData(), {
        'created_ids': [513, 514],
        'adopted_ids': [498],
      }),
    );

    final r = await repository.create(
      3,
      ScheduleDraft(
        type: ScheduleType.training,
        startsAt: DateTime(2099, 11, 12, 19, 30),
        title: '  Conditie ',
        venue: '',
        recurUntil: DateTime(2099, 12, 19),
        isHome: true,
        competition: 'league',
      ),
    );

    final body = http.requestsTo('POST $_base').single.body! as Map;
    expect(body['type'], 'training');
    expect(body['recur_until'], '2099-12-19');
    expect(body['title'], 'Conditie');
    expect(body['venue'], isNull);
    // Wedstrijdvelden blijven leeg bij een training.
    expect(body['is_home'], isNull);
    expect(body['competition'], isNull);
    expect(body['home_team'], isNull);
    expect(r.createdIds, [513, 514]);
    expect(r.adoptedIds, [498]);
    expect(r.seriesCount, 3);
  });

  test('PATCH schedule/{event}: apply_to_following en meta', () async {
    http.on(
      'PATCH $_base/498',
      200,
      ScheduleFixtures.write(ScheduleFixtures.trainingData(), {
        'following_updated': 6,
      }),
    );

    final r = await repository.update(
      3,
      498,
      ScheduleDraft(
        type: ScheduleType.training,
        startsAt: DateTime(2099, 11, 12, 19, 30),
        title: 'Conditie',
        venue: 'Veld 3',
        applyToFollowing: true,
        recurUntil: DateTime(2099, 12, 19),
      ),
    );

    final body = http.requestsTo('PATCH $_base/498').single.body! as Map;
    expect(body['apply_to_following'], isTrue);
    // recur_until telt niet bij wijzigen.
    expect(body.containsKey('recur_until'), isFalse);
    expect(r.event.title, 'Conditie');
    expect(r.followingUpdated, 6);
  });

  test('PATCH: apply_to_following alleen bij een training', () async {
    http.on(
      'PATCH $_base/512',
      200,
      ScheduleFixtures.write(ScheduleFixtures.matchData()),
    );

    await repository.update(3, 512, match.copyWith(applyToFollowing: true));

    final body = http.requestsTo('PATCH $_base/512').single.body! as Map;
    expect(body['apply_to_following'], isFalse);
  });

  test('DELETE schedule/{event} (204)', () async {
    http.on('DELETE $_base/498', 204);

    await repository.delete(3, 498);

    expect(http.requestsTo('DELETE $_base/498'), hasLength(1));
  });

  test('POST en DELETE schedule/{event}/cancel', () async {
    http
      ..on(
        'POST $_base/498/cancel',
        200,
        ScheduleFixtures.write(
          ScheduleFixtures.trainingData({
            'cancelled_at': '2099-11-10T09:12:44+01:00',
            'can_change': false,
          }),
        ),
      )
      ..on(
        'DELETE $_base/498/cancel',
        200,
        ScheduleFixtures.write(ScheduleFixtures.trainingData()),
      );

    final cancelled = await repository.cancel(3, 498);
    expect(cancelled.event.isCancelled, isTrue);
    expect(cancelled.schedule.isCancelled, isTrue);

    final back = await repository.uncancel(3, 498);
    expect(back.event.isCancelled, isFalse);
  });

  test('GET events/{event} als formuliervelden', () async {
    http.on(
      'GET /teams/3/events/498',
      200,
      ScheduleFixtures.write(
        ScheduleFixtures.trainingData({'spectators_can_rsvp': true}),
      ),
    );

    final e = await repository.fetchEvent(3, 498);

    expect(e.id, 498);
    expect(e.scheduleType, ScheduleType.training);
    expect(e.title, 'Conditie');
    expect(e.venue, 'Veld 3');
    expect(e.notes, 'Bidon mee');
    expect(e.canCancel, isTrue);
    expect(e.spectatorsCanRsvp, isTrue);
  });

  test('fouten: 403 (demo/bond), 404 en 422 met veldfouten', () async {
    http
      ..on('POST $_base/498/cancel', 403, {'message': 'Bondsevent.'})
      ..on('DELETE $_base/9', 404, {'message': 'Not found.'})
      ..on('POST $_base', 422, {
        'message': 'De tegenstander is verplicht.',
        'errors': {
          'away_team': ['De tegenstander is verplicht.'],
        },
      });

    await expectLater(
      repository.cancel(3, 498),
      throwsA(
        isA<ForbiddenException>().having(
          (e) => e.message,
          'message',
          'Bondsevent.',
        ),
      ),
    );
    await expectLater(
      repository.delete(3, 9),
      throwsA(isA<NotFoundException>()),
    );
    await expectLater(
      repository.create(3, match),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.fieldError('away_team'),
          'away_team',
          'De tegenstander is verplicht.',
        ),
      ),
    );
  });

  test('scheduleDateTime zet de offset van het toestel erbij', () {
    final value = DateTime(2099, 7, 1, 9, 5);
    final text = scheduleDateTime(value);
    expect(text, startsWith('2099-07-01T09:05:00'));
    expect(DateTime.parse(text).isAtSameMomentAs(value), isTrue);
    expect(scheduleDate(DateTime(2099, 1, 2, 23)), '2099-01-02');
  });
}
