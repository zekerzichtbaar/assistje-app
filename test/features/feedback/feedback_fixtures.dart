import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// De JSON-voorbeelden uit vogels3 `docs/api/v1/feedback.md`.
abstract final class FeedbackFixtures {
  static Map<String, dynamic> message({
    int id = 120,
    String direction = 'uit',
    String body = 'Welke telefoon heb je?',
    String createdAt = '2026-10-09T14:02:11+02:00',
  }) => {
    'id': id,
    'direction': direction,
    'body': body,
    'created_at': createdAt,
  };

  static Map<String, dynamic> item({
    int id = 88,
    String? kind = 'issue',
    String body = "De knop 'Aanwezig' doet niks op mijn telefoon",
    String status = 'in_progress',
    String? imageUrl = 'https://assistje.test/api/v1/teams/3/feedback/88/image',
    List<Map<String, dynamic>>? messages,
    String createdAt = '2026-10-09T13:45:00+02:00',
    String? resolvedAt,
  }) => {
    'id': id,
    'kind': kind,
    'body': body,
    'status': status,
    'image_url': imageUrl,
    'messages':
        messages ??
        [message(), message(id: 121, direction: 'in', body: 'Een Pixel 8.')],
    'created_at': createdAt,
    'resolved_at': resolvedAt,
  };

  /// Een opgelost idee zonder gesprek of afbeelding.
  static Map<String, dynamic> resolvedIdea() => item(
    id: 87,
    kind: 'idea',
    body: 'Donkere modus graag!',
    status: 'resolved',
    imageUrl: null,
    messages: const [],
    createdAt: '2026-10-01T10:00:00+02:00',
    resolvedAt: '2026-10-05T09:00:00+02:00',
  );

  static Map<String, dynamic> list({bool empty = false}) => {
    'data': empty ? <Object>[] : [item(), resolvedIdea()],
  };

  /// `POST feedback` → 201.
  static Map<String, dynamic> created({
    int id = 89,
    String body = 'Het rooster laadt niet',
    String? kind,
  }) => {
    'data': item(
      id: id,
      body: body,
      kind: kind,
      status: 'new',
      imageUrl: null,
      messages: const [],
      createdAt: '2026-10-10T09:00:00+02:00',
    ),
  };

  /// `POST feedback/88/responses` → 201.
  static Map<String, dynamic> responded(String body) => {
    'data': item(
      messages: [
        message(),
        message(id: 121, direction: 'in', body: 'Een Pixel 8.'),
        message(id: 122, direction: 'in', body: body),
      ],
    ),
  };
}

/// Legt een verzoek ruw vast (de gedeelde FakeHttpAdapter leest alleen
/// JSON) en antwoordt met [status] + [bytes] of [json].
class RawAdapter implements HttpClientAdapter {
  RawAdapter({this.status = 200, this.json, this.bytes, this.contentType});

  final int status;
  final Object? json;
  final List<int>? bytes;
  final String? contentType;

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
      final raw = await requestStream.expand((c) => c).toList();
      body = latin1.decode(raw);
    }
    final bytes = this.bytes;
    if (bytes != null) {
      return ResponseBody.fromBytes(
        bytes,
        status,
        headers: {
          Headers.contentTypeHeader: [contentType ?? 'image/png'],
        },
      );
    }
    return ResponseBody.fromString(
      json == null ? '' : jsonEncode(json),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
