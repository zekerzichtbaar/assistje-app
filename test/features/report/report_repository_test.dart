import 'dart:convert';
import 'dart:typed_data';

import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/report/data/report_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';
import 'report_fixtures.dart';

/// Legt een multipart-verzoek ruw vast (de [FakeHttpAdapter] leest alleen
/// JSON).
class _RawAdapter implements HttpClientAdapter {
  RequestOptions? options;
  String body = '';

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    this.options = options;
    if (requestStream != null) {
      final bytes = await requestStream.expand((c) => c).toList();
      body = latin1.decode(bytes);
    }
    return ResponseBody.fromString(
      jsonEncode(ReportFixtures.scoutPreview()),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late TestBackend backend;
  late ProviderContainer container;
  late ReportRepository repository;

  setUp(() async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    container = backend.container();
    addTearDown(container.dispose);
    repository = container.read(reportRepositoryProvider);
  });

  test('GET report leest een setsport met blad', () async {
    backend.http.on(
      ReportFixtures.get,
      200,
      ReportFixtures.wrap(ReportFixtures.setsData()),
    );

    final report = await repository.fetch(3, 412);

    expect(backend.http.requests.single.method, 'GET');
    expect(report.usesSets, isTrue);
    expect(report.hasStatsSheet, isTrue);
    expect(report.canImport, isTrue);
    expect(report.maxSets, 5);
    expect(report.event.homeTeam, 'Halley DS1');
    expect(report.event.weAreHome, isFalse);
    expect(report.sets.map((s) => '${s.homePoints}-${s.awayPoints}'), [
      '25-21',
      '19-25',
      '22-25',
      '20-25',
    ]);
    expect(report.statColumns, ReportFixtures.volleyColumns);
    expect(report.players.map((p) => p.id), [37, 52]);
    expect(report.statsFor(37)['points'], 12);
    expect(report.statsFor(37)['attack_kills'], 0);
    expect(report.statsFor(52).values.every((v) => v == 0), isTrue);
  });

  test('GET report leest een doelpuntensport zonder blad', () async {
    backend.http.on(
      ReportFixtures.get,
      200,
      ReportFixtures.wrap(ReportFixtures.goalsData()),
    );

    final report = await repository.fetch(3, 412);

    expect(report.usesSets, isFalse);
    expect(report.hasStatsSheet, isFalse);
    expect(report.homeScore, 2);
    expect(report.maxSets, isNull);
  });

  test('PATCH report/score stuurt de stand (null = leeg)', () async {
    backend.http.on(
      ReportFixtures.score,
      200,
      ReportFixtures.wrap(ReportFixtures.goalsData(home: 3, away: null)),
    );

    final report = await repository.saveScore(3, 412, home: 3, away: null);

    final request = backend.http.requests.single;
    expect(request.method, 'PATCH');
    expect(request.path, '/api/v1/teams/3/events/412/report/score');
    expect(request.body, {'home_score': 3, 'away_score': null});
    expect(report.homeScore, 3);
    expect(report.awayScore, isNull);
  });

  test('PATCH report/sets stuurt alle sets', () async {
    backend.http.on(
      ReportFixtures.sets,
      200,
      ReportFixtures.wrap(
        ReportFixtures.setsData(
          home: 2,
          away: 0,
          sets: const [
            [25, 20],
            [25, 18],
          ],
        ),
      ),
    );

    final report = await repository.saveSets(3, 412, const [
      (home: 25, away: 20),
      (home: 25, away: 18),
      (home: 0, away: 0),
    ]);

    final request = backend.http.requests.single;
    expect(request.method, 'PATCH');
    expect(request.path, '/api/v1/teams/3/events/412/report/sets');
    expect(request.body, {
      'sets': [
        {'home_points': 25, 'away_points': 20},
        {'home_points': 25, 'away_points': 18},
        {'home_points': 0, 'away_points': 0},
      ],
    });
    expect(report.homeScore, 2);
    expect(report.sets, hasLength(2));
  });

  test('PATCH report/player-stats stuurt de rijen', () async {
    backend.http.on(
      ReportFixtures.stats,
      200,
      ReportFixtures.wrap(ReportFixtures.setsData()),
    );

    await repository.savePlayerStats(3, 412, const [
      {'player_id': 37, 'points': 12, 'aces': 2, 'blocks': 1},
    ]);

    final request = backend.http.requests.single;
    expect(request.method, 'PATCH');
    expect(request.path, '/api/v1/teams/3/events/412/report/player-stats');
    expect(request.body, {
      'stats': [
        {'player_id': 37, 'points': 12, 'aces': 2, 'blocks': 1},
      ],
    });
  });

  test('POST scout-preview met geplakte tekst (JSON)', () async {
    backend.http.on(ReportFixtures.scout, 200, ReportFixtures.scoutPreview());

    final preview = await repository.scoutPreview(3, 412, text: 'tabel');

    final request = backend.http.requests.single;
    expect(request.method, 'POST');
    expect(request.path, '/api/v1/teams/3/events/412/report/scout-preview');
    expect(request.body, {'text': 'tabel'});
    expect(preview.ourTeamIndex, 1);
    expect(preview.teams[1].players.first.playerId, 37);
    expect(preview.teams[1].players.first.stat('points'), 14);
    expect(preview.teams[1].players.first.stat('attack_kills'), 0);
    expect(preview.roster.map((r) => r.id), [37, 52]);
    expect(preview.sets.first.home, 25);
  });

  test('POST scout-preview met een PDF (multipart)', () async {
    final raw = _RawAdapter();
    final api = ApiClient(
      buildApiDio(
        baseUrl: 'https://assistje.test/api/v1',
        readToken: () async => '12|abc',
        onUnauthorized: () {},
        adapter: raw,
      ),
    );

    final preview = await ReportRepository(api).scoutPreview(
      3,
      412,
      file: (name: 'rapport.pdf', bytes: Uint8List.fromList([37, 80, 68, 70])),
    );

    expect(raw.options!.method, 'POST');
    expect(
      raw.options!.uri.path,
      '/api/v1/teams/3/events/412/report/scout-preview',
    );
    expect(
      raw.options!.headers[Headers.contentTypeHeader],
      startsWith('multipart/form-data'),
    );
    expect(raw.body, contains('name="report"; filename="rapport.pdf"'));
    expect(raw.body, contains('application/pdf'));
    expect(raw.body, contains('%PDF'));
    expect(preview.teams, hasLength(2));
  });

  test('scout-preview 422 komt als ValidationException met message', () async {
    backend.http.on(ReportFixtures.scout, 422, {
      'message': 'Kies een PDF of plak de tabel uit het rapport.',
    });

    await expectLater(
      repository.scoutPreview(3, 412, text: ''),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.message,
          'message',
          'Kies een PDF of plak de tabel uit het rapport.',
        ),
      ),
    );
  });

  test('flag uit het event-detail; null als er geen is', () async {
    backend.http.on(
      ReportFixtures.eventGet,
      200,
      ReportFixtures.eventDetail(flag: ReportFixtures.flag()),
    );
    final flag = await repository.fetchFlag(3, 412);
    expect(flag!.matchMinutes, 90);
    expect(flag.shifts.map((s) => s.key), ['p37', 'u8']);
    expect(flag.pool.map((c) => c.key), ['p37', 'u8', 'p52']);
    expect(flag.candidate('u8')!.staff, isTrue);

    backend.http.on(ReportFixtures.eventGet, 200, ReportFixtures.eventDetail());
    expect(await repository.fetchFlag(3, 412), isNull);
  });

  test('PUT flag stuurt player_id óf user_id plus minuut', () async {
    backend.http.routes[ReportFixtures.flagPut] = ReportFixtures.echoFlag();

    final flag = await repository.saveFlag(3, 412, const [
      (playerId: null, userId: 8, fromMinute: 60),
      (playerId: 37, userId: null, fromMinute: 0),
    ]);

    final request = backend.http.requests.single;
    expect(request.method, 'PUT');
    expect(request.path, '/api/v1/teams/3/events/412/flag');
    expect(request.body, {
      'shifts': [
        {'player_id': null, 'user_id': 8, 'from_minute': 60},
        {'player_id': 37, 'user_id': null, 'from_minute': 0},
      ],
    });
    expect(flag.shifts.map((s) => s.fromMinute), [0, 60]);
  });

  test('403 en 404 worden het eigen type', () async {
    backend.http.on(ReportFixtures.get, 403, {'message': 'Geen toegang.'});
    await expectLater(
      repository.fetch(3, 412),
      throwsA(isA<ForbiddenException>()),
    );
    backend.http.on(ReportFixtures.get, 404, {'message': 'Niet gevonden.'});
    await expectLater(
      repository.fetch(3, 412),
      throwsA(isA<NotFoundException>()),
    );
  });
}
