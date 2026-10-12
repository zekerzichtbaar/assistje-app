import 'dart:convert';
import 'dart:typed_data';

import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/schedule/data/models/schedule_import_models.dart';
import 'package:assistje/features/schedule/data/schedule_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'schedule_import_fixtures.dart';

const _base = '/teams/3/schedule';

ApiClient _client(HttpClientAdapter adapter) => ApiClient(
  buildApiDio(
    baseUrl: 'https://assistje.test/api/v1',
    readToken: () async => '12|abc',
    onUnauthorized: () {},
    adapter: adapter,
  ),
);

void main() {
  late FakeHttpAdapter http;
  late ScheduleRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = ScheduleRepository(_client(http));
  });

  group('import (multipart)', () {
    test('stuurt het bestand en dry_run, leest de telling', () async {
      final raw = RawMultipartAdapter()
        ..respond(200, ScheduleImportFixtures.importResponse(dryRun: true));
      final result = await ScheduleRepository(_client(raw)).importFile(3, (
        name: 'programma.ics',
        bytes: Uint8List.fromList(utf8.encode('BEGIN')),
      ), dryRun: true);

      expect(raw.options!.method, 'POST');
      expect(raw.options!.uri.path, '/api/v1$_base/import');
      expect(
        raw.options!.headers[Headers.contentTypeHeader],
        startsWith('multipart/form-data'),
      );
      expect(raw.body, contains('name="file"; filename="programma.ics"'));
      expect(raw.body, contains('text/calendar'));
      expect(raw.body, contains('BEGIN'));
      expect(raw.body, contains('name="dry_run"\r\n\r\n1'));

      expect(result.created, 12);
      expect(result.updated, 2);
      expect(result.skipped, 1);
      expect(result.duties, 0);
      expect(result.dryRun, isTrue);
      expect(result.messages, ['Rij 7: datum onleesbaar']);
      expect(result.message, startsWith('12 wedstrijden aangemaakt'));
    });

    test('echte import stuurt dry_run 0', () async {
      final raw = RawMultipartAdapter()
        ..respond(200, ScheduleImportFixtures.importResponse());
      await ScheduleRepository(_client(raw)).importFile(3, (
        name: 'export.xlsx',
        bytes: Uint8List.fromList([80, 75]),
      ));
      expect(raw.body, contains('name="dry_run"\r\n\r\n0'));
      expect(
        raw.body,
        contains('vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
      );
    });

    test('422 op file komt als ValidationException met veldfout', () async {
      final raw = RawMultipartAdapter()
        ..respond(422, {
          'message': 'Onbekend bestandsformaat. Gebruik .ics, .xlsx of .csv.',
          'errors': {
            'file': ['Onbekend bestandsformaat. Gebruik .ics, .xlsx of .csv.'],
          },
        });
      await expectLater(
        ScheduleRepository(
          _client(raw),
        ).importFile(3, (name: 'x.pdf', bytes: Uint8List(1))),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.fieldError('file'),
            'file',
            'Onbekend bestandsformaat. Gebruik .ics, .xlsx of .csv.',
          ),
        ),
      );
    });
  });

  test('mediatype per extensie', () {
    expect(scheduleFileMediaType('a.ICS').mimeType, 'text/calendar');
    expect(scheduleFileMediaType('a.csv').mimeType, 'text/csv');
    expect(scheduleFileMediaType('a.txt').mimeType, 'text/plain');
  });

  test('POST fetch (202) geeft de wachtrij-melding', () async {
    http.on('POST $_base/fetch', 202, ScheduleImportFixtures.fetchResponse());
    final result = await repository.fetchFromFederation(3);
    expect(result.status, 'queued');
    expect(result.message, ScheduleImportFixtures.fetchMessage);
    expect(http.requestsTo('POST $_base/fetch').single.body, isNull);
  });

  test('fetch 422 op schedule', () async {
    http.on('POST $_base/fetch', 422, {
      'message': 'Voor deze sport halen wij het programma niet zo op.',
      'errors': {
        'schedule': ['Voor deze sport halen wij het programma niet zo op.'],
      },
    });
    await expectLater(
      repository.fetchFromFederation(3),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.fieldError('schedule'),
          'schedule',
          'Voor deze sport halen wij het programma niet zo op.',
        ),
      ),
    );
  });

  test('POST request (201)', () async {
    http.on(
      'POST $_base/request',
      201,
      ScheduleImportFixtures.requestResponse(),
    );
    final result = await repository.requestByHand(3);
    expect(result.status, 'requested');
    expect(result.message, ScheduleImportFixtures.requestMessage);
  });

  test('request 409: verzoek staat al open', () async {
    http.on('POST $_base/request', 409, {
      'message': ScheduleImportFixtures.conflictMessage,
    });
    await expectLater(
      repository.requestByHand(3),
      throwsA(
        isA<ConflictException>().having(
          (e) => e.message,
          'message',
          ScheduleImportFixtures.conflictMessage,
        ),
      ),
    );
  });

  test('POST feed stuurt de link en leest de opgeslagen link', () async {
    http.on('POST $_base/feed', 200, ScheduleImportFixtures.feedResponse());
    final result = await repository.setFeed(3, ScheduleImportFixtures.feedUrl);
    expect(http.requestsTo('POST $_base/feed').single.body, {
      'schedule_feed_url': ScheduleImportFixtures.feedUrl,
    });
    expect(result.status, 'imported');
    expect(result.scheduleFeedUrl, ScheduleImportFixtures.feedUrl);
    expect(result.message, ScheduleImportFixtures.feedMessage);
  });

  test('feed 422 op schedule_feed_url', () async {
    http.on('POST $_base/feed', 422, {
      'message': 'Plak de hele link, die begint met https://.',
      'errors': {
        'schedule_feed_url': ['Plak de hele link, die begint met https://.'],
      },
    });
    await expectLater(
      repository.setFeed(3, 'nevobo'),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.fieldError('schedule_feed_url'),
          'schedule_feed_url',
          'Plak de hele link, die begint met https://.',
        ),
      ),
    );
  });

  test('429 komt als ThrottledException', () async {
    http.on('POST $_base/fetch', 429, {'message': 'Too Many Attempts.'});
    await expectLater(
      repository.fetchFromFederation(3),
      throwsA(isA<ThrottledException>()),
    );
  });

  group('modellen', () {
    test('FederationImport uit sport', () {
      final f = FederationImport.fromSport({
        'federation_import': {
          'method': 'paste',
          'name': 'voetbal.nl',
          'hint': 'Uit de URL',
          'example': 'T429576725',
        },
      })!;
      expect(f.name, 'voetbal.nl');
      expect(f.method, 'paste');
      expect(FederationImport.fromSport(const {}), isNull);
    });

    test('ScheduleFeedState en ScheduleRequestState', () {
      expect(ScheduleFeedState.fromJson(null), isNull);
      final feed = ScheduleFeedState.fromJson({'url': null, 'failed': true})!;
      expect(feed.url, isNull);
      expect(feed.failed, isTrue);
      expect(
        ScheduleRequestState.parse('pending'),
        ScheduleRequestState.pending,
      );
      expect(ScheduleRequestState.parse(null), isNull);
    });
  });
}
