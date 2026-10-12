import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_controller.dart';
import '../auth/token_store.dart';
import '../config/env.dart';
import 'api_exception.dart';
import 'interceptors.dart';

/// Bouwt de [Dio] voor de API: basis-URL, JSON-headers, bearer-token,
/// 401 → uitloggen en één retry voor GET's bij een verbindingsfout.
Dio buildApiDio({
  required String baseUrl,
  required TokenReader readToken,
  required void Function() onUnauthorized,
  HttpClientAdapter? adapter,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl.endsWith('/') ? baseUrl : '$baseUrl/',
      headers: {'Accept': 'application/json'},
      contentType: Headers.jsonContentType,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
  if (adapter != null) dio.httpClientAdapter = adapter;
  dio.interceptors.addAll([
    AuthInterceptor(readToken: readToken, onUnauthorized: onUnauthorized),
    RetryInterceptor(dio),
  ]);
  return dio;
}

/// De [Dio] van de app. Tests overschrijven hem (of [apiHttpAdapterProvider]).
final dioProvider = Provider<Dio>((ref) {
  return buildApiDio(
    baseUrl: Env.apiBaseUrl,
    readToken: () => ref.read(tokenStoreProvider).read(),
    // Lui gelezen: de auth-controller hangt zelf (via de repository) aan dio.
    onUnauthorized: () =>
        ref.read(authControllerProvider.notifier).handleUnauthorized(),
    adapter: ref.watch(apiHttpAdapterProvider),
  );
});

/// Optionele vervanging van de HTTP-laag (tests); `null` = de standaard.
final apiHttpAdapterProvider = Provider<HttpClientAdapter?>((ref) => null);

final apiClientProvider = Provider<ApiClient>(
  (ref) => ApiClient(ref.watch(dioProvider)),
);

/// Dunne laag over [Dio]: paden relatief aan `/api/v1`, antwoord als JSON-map,
/// fouten als [ApiException].
class ApiClient {
  const ApiClient(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
  }) => _send(() => _dio.get<Object?>(_relative(path), queryParameters: query));

  Future<Map<String, dynamic>> post(String path, {Object? data}) =>
      _send(() => _dio.post<Object?>(_relative(path), data: data));

  Future<Map<String, dynamic>> patch(String path, {Object? data}) =>
      _send(() => _dio.patch<Object?>(_relative(path), data: data));

  Future<Map<String, dynamic>> put(String path, {Object? data}) =>
      _send(() => _dio.put<Object?>(_relative(path), data: data));

  Future<Map<String, dynamic>> delete(String path, {Object? data}) =>
      _send(() => _dio.delete<Object?>(_relative(path), data: data));

  Future<Map<String, dynamic>> _send(
    Future<Response<Object?>> Function() request,
  ) async {
    try {
      final response = await request();
      final body = response.data;
      if (body is Map<String, dynamic>) return body;
      return const {};
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  /// `/me` → `me`, zodat de basis-URL (met `/api/v1`) behouden blijft.
  static String _relative(String path) =>
      path.startsWith('/') ? path.substring(1) : path;
}
