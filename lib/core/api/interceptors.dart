import 'package:dio/dio.dart';

/// Leest het opgeslagen token (of `null`).
typedef TokenReader = Future<String?> Function();

/// Zet `Authorization: Bearer …` op elk verzoek en meldt een 401.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.readToken, required this.onUnauthorized});

  final TokenReader readToken;

  /// Wordt aangeroepen bij elke 401 op een verzoek dat een token meestuurde.
  final void Function() onUnauthorized;

  static const String _sentTokenKey = 'assistje.sent_token';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await readToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      options.extra[_sentTokenKey] = true;
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401 &&
        err.requestOptions.extra[_sentTokenKey] == true) {
      onUnauthorized();
    }
    handler.next(err);
  }
}

/// Probeert een idempotente GET één keer opnieuw bij een verbindingsfout.
class RetryInterceptor extends Interceptor {
  RetryInterceptor(this._dio);

  final Dio _dio;

  static const String _retriedKey = 'assistje.retried';

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final retryable =
        err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout;

    if (!retryable ||
        options.method.toUpperCase() != 'GET' ||
        options.extra[_retriedKey] == true) {
      handler.next(err);
      return;
    }

    options.extra[_retriedKey] = true;
    try {
      handler.resolve(await _dio.fetch<Object?>(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }
}
