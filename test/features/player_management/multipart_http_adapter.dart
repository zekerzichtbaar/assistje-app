import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../helpers/fake_http_adapter.dart';

/// [FakeHttpAdapter] die ook multipart-verzoeken aankan: de ruwe body komt
/// in [multipartBodies] (latin1), het verzoek zelf wordt zonder body
/// vastgelegd en beantwoord zoals elke andere route.
class MultipartHttpAdapter extends FakeHttpAdapter {
  final List<String> multipartBodies = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final type = options.headers[Headers.contentTypeHeader]?.toString() ?? '';
    if (requestStream != null && type.startsWith('multipart/form-data')) {
      final bytes = await requestStream.expand((chunk) => chunk).toList();
      multipartBodies.add(latin1.decode(bytes));
      return super.fetch(options, null, cancelFuture);
    }
    return super.fetch(options, requestStream, cancelFuture);
  }
}
