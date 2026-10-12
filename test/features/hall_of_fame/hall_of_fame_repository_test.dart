import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/hall_of_fame/data/hall_of_fame_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'hall_of_fame_fixtures.dart';

const _hof = 'GET /teams/3/hall-of-fame';

void main() {
  late FakeHttpAdapter http;
  late HallOfFameRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = HallOfFameRepository(
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

  test('voorbeeld uit docs/api/v1/stats.md', () async {
    http.on(_hof, 200, HallOfFameFixtures.response());

    final hof = await repository.fetch(3);

    expect(http.requests.single.options.uri.queryParameters, isEmpty);
    expect(hof.seasonId, 4);
    expect(hof.season?.label, '2026/2027');
    expect(hof.periodId, isNull);
    expect(hof.period, isNull);
    final period = hof.periods.single;
    expect(period.id, 2);
    expect(period.name, 'Blok 1');
    expect(period.startsOn, DateTime(2026, 8, 15));
    expect(period.isClosed, isFalse);
    expect(hof.periodAwards, isEmpty);

    final title = hof.titles.single;
    expect(title.key, 'top_scorer');
    expect(title.group, 'season');
    expect(title.holder?.playerId, 14);
    expect(title.holder?.name, 'Sam de Vries');
    expect(title.holders, isEmpty);
    expect(title.isShared, isFalse);
    expect(title.value, '3');
    expect(title.caption, 'goals');

    expect(hof.topScorers!.single.goals, 3);
    expect(hof.topAssisters, isEmpty);
    expect(hof.topFlaggers!.single.shifts, 2);
    expect(hof.topFlaggers!.single.minutes, 90);
    expect(hof.topFlaggers!.single.avatarUrl, isNull);
    expect(hof.postMatchLeaderboards, isNull);
    expect(hof.topMotm.single.wins, 2);
    final badges = hof.playersWithBadges.single;
    expect(badges.shirtNumber, 7);
    expect(badges.badges.single.label, 'Hattrick hero');
    expect(hof.trainingPointsEnabled, isFalse);
    expect(hof.topTrainingPoints, isEmpty);
  });

  test('seizoen en periode gaan als ?season= en ?period= mee', () async {
    http.on(_hof, 200, HallOfFameFixtures.response());

    await repository.fetch(3, seasonId: 3, periodId: 2);

    expect(http.requests.single.options.uri.queryParameters, {
      'season': '3',
      'period': '2',
    });
  });

  test('null-ranglijsten blijven null; post-match lenient', () async {
    http.on(_hof, 200, {'data': HallOfFameFixtures.volleyball()});

    final hof = await repository.fetch(3);

    expect(hof.topScorers, isNull);
    expect(hof.topAssisters, isNull);
    expect(hof.topFlaggers, isNull);
    final postMatch = hof.postMatchLeaderboards!;
    expect(postMatch.points.single.points, 41);
    expect(postMatch.aces, isEmpty);
    expect(postMatch.blocks.single.blocks, 7);
  });

  test('erelijst, gedeelde titel en waarde als getal', () async {
    http.on(_hof, 200, {'data': HallOfFameFixtures.rich()});

    final hof = await repository.fetch(3);

    final group = hof.periodAwards.single;
    expect(group.periodId, 1);
    expect(group.periodName, 'Blok 0');
    expect(group.winners.single.value, '5');
    expect(group.winners.single.playerId, 22);
    final shared = hof.titles.last;
    expect(shared.group, 'now');
    expect(shared.isShared, isTrue);
    expect(shared.holders.map((h) => h.playerId), [14, 22]);
    expect(hof.periods.last.endsOn, isNull);
  });

  test('404 (feature uit) komt als NotFoundException', () async {
    http.on(_hof, 404, {'message': 'Not Found'});

    await expectLater(repository.fetch(3), throwsA(isA<NotFoundException>()));
  });
}
