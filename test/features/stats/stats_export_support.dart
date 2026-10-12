import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../helpers/fake_http_adapter.dart';

/// De CSV uit `docs/api/v1/stats.md`, met BOM.
final Uint8List statsCsvBytes = Uint8List.fromList([
  0xEF,
  0xBB,
  0xBF,
  ...utf8.encode(
    '#,Naam,Positie,Aanw. wedstr. %,Aanw. training %,Wedstrijden,Minuten,'
    'Goals,Assists,Geel,Rood,Vlag min,Vlag beurten\n'
    '9,Sam,MF,100,80,4,320,2,1,0,0,45,1\n',
  ),
]);

/// Een binair antwoord op `GET …/stats/export`.
class CsvResponse {
  const CsvResponse(this.status, this.bytes, {this.disposition});

  final int status;
  final Uint8List bytes;
  final String? disposition;
}

/// [FakeHttpAdapter] die `GET /teams/{team}/stats/export` binair beantwoordt
/// (met `Content-Disposition`); al het andere gaat naar [inner].
class CsvAwareAdapter implements HttpClientAdapter {
  CsvAwareAdapter(this.inner);

  final FakeHttpAdapter inner;

  /// Antwoord per teamId; zonder antwoord valt het verzoek door naar [inner]
  /// (zo kun je een JSON-fout als `403` daar zetten).
  final Map<int, CsvResponse> csv = {};

  /// Alle export-verzoeken.
  final List<RequestOptions> exports = [];

  static final _route = RegExp(r'/teams/(\d+)/stats/export$');

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final match = _route.firstMatch(options.uri.path);
    if (options.method == 'GET' && match != null) {
      exports.add(options);
      final response = csv[int.parse(match.group(1)!)];
      if (response != null) {
        return ResponseBody.fromBytes(
          response.bytes,
          response.status,
          headers: {
            Headers.contentTypeHeader: ['text/csv; charset=utf-8'],
            if (response.disposition case final String d)
              'content-disposition': [d],
          },
        );
      }
    }
    return inner.fetch(options, requestStream, cancelFuture);
  }

  @override
  void close({bool force = false}) {}
}
