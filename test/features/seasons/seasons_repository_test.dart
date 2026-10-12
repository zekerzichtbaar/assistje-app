import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/seasons/data/models/seasons_models.dart';
import 'package:assistje/features/seasons/data/seasons_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';
import 'seasons_fixtures.dart';

void main() {
  late TestBackend backend;
  late SeasonsRepository repository;

  setUp(() async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    final container = backend.container();
    addTearDown(container.dispose);
    repository = SeasonsRepository(container.read(apiClientProvider));
  });

  test('GET seasons leest de volledige staat', () async {
    backend.http.on('GET /teams/3/seasons', 200, SeasonsFixtures.response());

    final data = await repository.fetch(3);

    expect(data.mode, PeriodMode.matches);
    expect(data.modes, PeriodMode.values);
    expect(data.season!.label, '26/27');
    expect(data.season!.startsOn, '2026-07-01');
    expect(data.season!.endsOn, '2027-06-30');
    expect(data.season!.isActive, isTrue);
    expect(data.season!.expired, isFalse);
    expect(data.season!.matchCount, 22);
    expect(data.closedSeason!.label, '25/26');
    expect(data.closedSeason!.closedAt, '2026-07-03T09:12:00+02:00');
    expect(data.periods, hasLength(2));
    final closed = data.periods.first;
    expect(closed.id, 41);
    expect(closed.isClosed, isTrue);
    expect(closed.awardCount, 5);
    final open = data.periods.last;
    expect(open.endsOn, isNull);
    expect(open.targetMatches, 7);
    expect(open.playedMatches, 2);
    expect(data.hasOpenPeriods, isTrue);
    expect(backend.http.requests.single.authorization, 'Bearer 12|abc');
  });

  test(
    'ruim lezen: geen seizoen, 0/1-booleans, strings, onbekende modus',
    () async {
      backend.http.on('GET /teams/3/seasons', 200, {
        'data': {
          'mode': 'weird',
          'modes': ['dates', 'nope'],
          'season': null,
          'closed_season': null,
          'periods': [
            {
              'id': '9',
              'name': 'X',
              'starts_on': '2026-01-01',
              'ends_on': '',
              'target_matches': '6',
              'is_closed': 1,
              'played_matches': '3',
              'award_count': null,
            },
          ],
        },
      });

      final data = await repository.fetch(3);

      expect(data.mode, PeriodMode.off);
      expect(data.modes, [PeriodMode.dates]);
      expect(data.season, isNull);
      expect(data.closedSeason, isNull);
      final p = data.periods.single;
      expect(p.id, 9);
      expect(p.endsOn, isNull);
      expect(p.targetMatches, 6);
      expect(p.isClosed, isTrue);
      expect(p.playedMatches, 3);
      expect(p.awardCount, 0);
    },
  );

  test('PATCH seasons/current stuurt label en datums', () async {
    backend.http.on(
      'PATCH /teams/3/seasons/current',
      200,
      SeasonsFixtures.response(
        SeasonsFixtures.data(season: SeasonsFixtures.season(label: '27/28')),
      ),
    );

    final result = await repository.updateSeason(
      3,
      const SeasonUpdate(
        label: '27/28',
        startsOn: '2027-07-01',
        endsOn: '2028-06-30',
      ),
    );

    expect(result.data.season!.label, '27/28');
    expect(backend.http.requests.single.body, {
      'label': '27/28',
      'starts_on': '2027-07-01',
      'ends_on': '2028-06-30',
    });
  });

  test('POST seasons/close en seasons/reopen (meta.moved)', () async {
    backend.http
      ..on('POST /teams/3/seasons/close', 200, SeasonsFixtures.response())
      ..on(
        'POST /teams/3/seasons/reopen',
        200,
        SeasonsFixtures.response(null, {'moved': 3}),
      );

    final closed = await repository.closeSeason(3);
    final reopened = await repository.reopenSeason(3);

    expect(closed.data.season!.label, '26/27');
    expect(closed.meta.moved, isNull);
    expect(reopened.meta.moved, 3);
    expect(
      backend.http.requestsTo('POST /teams/3/seasons/close'),
      hasLength(1),
    );
    expect(
      backend.http.requestsTo('POST /teams/3/seasons/reopen'),
      hasLength(1),
    );
  });

  test('PATCH periods/mode stuurt badge_period_mode', () async {
    backend.http.on(
      'PATCH /teams/3/periods/mode',
      200,
      SeasonsFixtures.response(SeasonsFixtures.data(mode: 'dates')),
    );

    final result = await repository.setMode(3, PeriodMode.dates);

    expect(result.data.mode, PeriodMode.dates);
    expect(backend.http.requests.single.body, {'badge_period_mode': 'dates'});
  });

  test(
    'POST periods/generate: count en optioneel matches_per_period',
    () async {
      backend.http.on(
        'POST /teams/3/periods/generate',
        200,
        SeasonsFixtures.response(),
      );

      await repository.generate(3, count: 3);
      await repository.generate(3, count: 4, matchesPerPeriod: 6);

      final bodies = [
        for (final r in backend.http.requestsTo(
          'POST /teams/3/periods/generate',
        ))
          r.body,
      ];
      expect(bodies, [
        {'count': 3},
        {'count': 4, 'matches_per_period': 6},
      ]);
    },
  );

  test('POST periods (201) geeft meta.period_id', () async {
    backend.http.on(
      'POST /teams/3/periods',
      201,
      SeasonsFixtures.response(
        SeasonsFixtures.data(
          mode: 'dates',
          periods: [
            SeasonsFixtures.period(
              id: 43,
              name: 'Najaar',
              startsOn: '2026-08-01',
              endsOn: '2026-12-31',
              targetMatches: null,
            ),
          ],
        ),
        {'period_id': 43},
      ),
    );

    final result = await repository.createPeriod(
      3,
      const PeriodInput(
        name: 'Najaar',
        startsOn: '2026-08-01',
        endsOn: '2026-12-31',
      ),
    );

    expect(result.meta.periodId, 43);
    expect(result.data.periods.single.name, 'Najaar');
    expect(backend.http.requests.single.body, {
      'name': 'Najaar',
      'starts_on': '2026-08-01',
      'ends_on': '2026-12-31',
    });
  });

  test('PATCH periods/{period} stuurt ook null voor leegmaken', () async {
    backend.http.on(
      'PATCH /teams/3/periods/42',
      200,
      SeasonsFixtures.response(),
    );

    await repository.updatePeriod(
      3,
      42,
      const PeriodInput(
        name: 'Herfst',
        startsOn: '2026-10-27',
        targetMatches: 6,
        includeTarget: true,
      ),
    );

    expect(backend.http.requests.single.body, {
      'name': 'Herfst',
      'starts_on': '2026-10-27',
      'ends_on': null,
      'target_matches': 6,
    });
  });

  test('DELETE, close (meta.award_count) en reopen van een periode', () async {
    backend.http
      ..on('DELETE /teams/3/periods/42', 200, SeasonsFixtures.response())
      ..on(
        'POST /teams/3/periods/42/close',
        200,
        SeasonsFixtures.response(null, {'award_count': 5}),
      )
      ..on('POST /teams/3/periods/41/reopen', 200, SeasonsFixtures.response());

    await repository.deletePeriod(3, 42);
    final closed = await repository.closePeriod(3, 42);
    await repository.reopenPeriod(3, 41);

    expect(closed.meta.awardCount, 5);
    expect(
      [for (final r in backend.http.requests) '${r.method} ${r.path}'],
      [
        'DELETE /api/v1/teams/3/periods/42',
        'POST /api/v1/teams/3/periods/42/close',
        'POST /api/v1/teams/3/periods/41/reopen',
      ],
    );
  });

  test('403, 422 met veldfouten en 422 met alleen een melding', () async {
    backend.http
      ..on('GET /teams/3/seasons', 403, {'message': 'Geen toegang.'})
      ..on('POST /teams/3/periods', 422, {
        'message': 'De naam is verplicht.',
        'errors': {
          'name': ['De naam is verplicht.'],
        },
      })
      ..on('POST /teams/3/seasons/reopen', 422, {
        'message': 'Er is geen afgesloten seizoen.',
      });

    await expectLater(repository.fetch(3), throwsA(isA<ForbiddenException>()));
    await expectLater(
      repository.createPeriod(3, const PeriodInput(name: '')),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.fieldError('name'),
          'name',
          'De naam is verplicht.',
        ),
      ),
    );
    await expectLater(
      repository.reopenSeason(3),
      throwsA(
        isA<ValidationException>()
            .having((e) => e.errors, 'errors', isEmpty)
            .having(
              (e) => e.message,
              'message',
              'Er is geen afgesloten seizoen.',
            ),
      ),
    );
  });

  test('onverwacht antwoord zonder data', () async {
    backend.http.on('GET /teams/3/seasons', 200, {'oops': true});
    await expectLater(repository.fetch(3), throwsA(isA<UnknownApiException>()));
  });
}
