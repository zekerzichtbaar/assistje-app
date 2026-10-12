import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// Eén vastgelegd verzoek.
class RecordedRequest {
  RecordedRequest(this.options, this.body);

  final RequestOptions options;
  final Object? body;

  String get method => options.method;
  String get path => options.uri.path;
  String? get authorization => options.headers['Authorization'] as String?;
}

/// Antwoord van een [FakeHttpAdapter]-handler.
class FakeResponse {
  const FakeResponse(this.statusCode, [this.body]);

  final int statusCode;
  final Object? body;
}

typedef FakeHandler = FakeResponse Function(RecordedRequest request);

/// Vervangt de HTTP-laag van dio: routes op `METHOD /pad` (pad zonder
/// `/api/v1`), alle verzoeken worden bewaard in [requests].
///
/// Een handler mag een [DioException] gooien (bv. verbindingsfout).
class FakeHttpAdapter implements HttpClientAdapter {
  FakeHttpAdapter([Map<String, FakeHandler>? routes]) : routes = routes ?? {};

  final Map<String, FakeHandler> routes;
  final List<RecordedRequest> requests = [];

  /// Kortweg een vast antwoord op `METHOD /pad`.
  void on(String route, int status, [Object? body]) =>
      routes[route] = (_) => FakeResponse(status, body);

  List<RecordedRequest> requestsTo(String route) => [
    for (final r in requests)
      if ('${r.method} ${_stripPrefix(r.path)}' == route) r,
  ];

  static String _stripPrefix(String path) =>
      path.startsWith('/api/v1') ? path.substring('/api/v1'.length) : path;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    Object? body;
    if (requestStream != null) {
      final bytes = await requestStream.expand((chunk) => chunk).toList();
      final text = utf8.decode(bytes);
      body = text.isEmpty ? null : jsonDecode(text);
    }
    final request = RecordedRequest(options, body);
    requests.add(request);

    final route = '${options.method} ${_stripPrefix(options.uri.path)}';
    final handler = routes[route];
    final response = handler == null
        ? const FakeResponse(404, {'message': 'Not found.'})
        : handler(request);

    final payload = response.body == null ? '' : jsonEncode(response.body);
    return ResponseBody.fromString(
      payload,
      response.statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
