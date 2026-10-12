import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/stats/data/stats_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'stats_export_support.dart';

void main() {
  late FakeHttpAdapter http;
  late CsvAwareAdapter adapter;
  late StatsRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    adapter = CsvAwareAdapter(http);
    final dio = buildApiDio(
      baseUrl: 'https://assistje.test/api/v1',
      readToken: () async => '12|abc',
      onUnauthorized: () {},
      adapter: adapter,
    );
    repository = StatsRepository(
      ApiClient(dio),
      dio: dio,
      now: () => DateTime(2026, 3, 7, 23, 30),
    );
  });

  test('bytes (met BOM) en bestandsnaam uit Content-Disposition', () async {
    adapter.csv[3] = CsvResponse(
      200,
      statsCsvBytes,
      disposition: 'attachment; filename=stats-2026-10-11.csv',
    );

    final export = await repository.exportCsv(3);

    expect(export.bytes, statsCsvBytes);
    expect(export.bytes.take(3), [0xEF, 0xBB, 0xBF]);
    expect(export.filename, 'stats-2026-10-11.csv');
    final request = adapter.exports.single;
    expect(request.uri.path, '/api/v1/teams/3/stats/export');
    expect(request.uri.queryParameters, isEmpty);
    expect(request.headers['Accept'], 'text/csv');
    expect(request.headers['Authorization'], 'Bearer 12|abc');
  });

  test('venster en seizoen gaan mee als query', () async {
    adapter.csv[3] = CsvResponse(200, statsCsvBytes);

    await repository.exportCsv(3, window: StatsWindow.last5, seasonId: 4);

    expect(adapter.exports.single.uri.queryParameters, {
      'window': '5',
      'season': '4',
    });
  });

  test('zonder Content-Disposition: stats-<vandaag>.csv', () async {
    adapter.csv[3] = CsvResponse(200, statsCsvBytes);

    final export = await repository.exportCsv(3);

    expect(export.filename, 'stats-2026-03-07.csv');
  });

  test('403 (geen lid) wordt een ForbiddenException', () async {
    http.on('GET /teams/3/stats/export', 403, {'message': 'Geen toegang.'});

    await expectLater(
      repository.exportCsv(3),
      throwsA(
        isA<ForbiddenException>().having(
          (e) => e.message,
          'message',
          'Geen toegang.',
        ),
      ),
    );
  });

  test('404 (feature uit) wordt een NotFoundException', () async {
    await expectLater(
      repository.exportCsv(3),
      throwsA(isA<NotFoundException>()),
    );
  });

  group('filenameFromDisposition', () {
    test('met en zonder aanhalingstekens, nooit een pad', () {
      expect(
        StatsRepository.filenameFromDisposition(
          'attachment; filename="stats-2026-10-11.csv"',
        ),
        'stats-2026-10-11.csv',
      );
      expect(
        StatsRepository.filenameFromDisposition(
          'attachment; filename=../../etc/stats.csv',
        ),
        'stats.csv',
      );
      expect(StatsRepository.filenameFromDisposition('attachment'), isNull);
      expect(StatsRepository.filenameFromDisposition(null), isNull);
    });
  });
}
