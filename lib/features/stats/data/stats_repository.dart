import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/stats_models.dart';

/// Welk venster de statistieken beslaan (`?window=`).
enum StatsWindow {
  /// Het hele seizoen (standaard; geen query).
  season('season'),

  /// De laatste 10 wedstrijden.
  last10('10'),

  /// De laatste 5 wedstrijden.
  last5('5');

  const StatsWindow(this.query);

  /// De waarde voor `?window=`.
  final String query;

  /// Wat de server terugmeldt; onbekend valt terug op [season] (net als de
  /// server zelf).
  static StatsWindow parse(String? value) => switch (value) {
    '10' => last10,
    '5' => last5,
    _ => season,
  };
}

/// Een gedownloade CSV-export: de bytes (UTF-8 met BOM) en de bestandsnaam.
class StatsCsvExport {
  const StatsCsvExport({required this.bytes, required this.filename});

  final Uint8List bytes;

  /// `stats-JJJJ-MM-DD.csv`.
  final String filename;
}

/// `GET teams/{team}/stats` en `GET teams/{team}/stats/export` (vogels3
/// `docs/api/v1/stats.md`). Fouten komen als [ApiException]; `404` = de
/// feature `stats` staat uit.
class StatsRepository {
  const StatsRepository(this._api, {Dio? dio, DateTime Function()? now})
    : _dio = dio,
      _now = now ?? DateTime.now;

  final ApiClient _api;

  /// De geauthenticeerde [Dio] van de app, voor de binaire CSV ([ApiClient]
  /// geeft alleen JSON-maps terug).
  final Dio? _dio;

  final DateTime Function() _now;

  Future<TeamStats> fetchStats(
    int teamId, {
    StatsWindow window = StatsWindow.season,
    int? seasonId,
  }) async {
    final query = <String, Object>{
      if (window != StatsWindow.season) 'window': window.query,
      'season': ?seasonId,
    };
    final body = await _api.get(
      '/teams/$teamId/stats',
      query: query.isEmpty ? null : query,
    );
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return TeamStats.fromJson(data);
  }

  /// `GET stats/export`: dezelfde CSV als de PWA, met dezelfde parameters als
  /// [fetchStats]. De bestandsnaam komt uit `Content-Disposition`; anders
  /// `stats-<vandaag>.csv`.
  Future<StatsCsvExport> exportCsv(
    int teamId, {
    StatsWindow window = StatsWindow.season,
    int? seasonId,
  }) async {
    final dio = _dio;
    if (dio == null) {
      throw StateError('StatsRepository.exportCsv heeft een Dio nodig.');
    }
    final query = <String, Object>{
      if (window != StatsWindow.season) 'window': window.query,
      'season': ?seasonId,
    };
    try {
      final response = await dio.get<List<int>>(
        'teams/$teamId/stats/export',
        queryParameters: query.isEmpty ? null : query,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'text/csv'},
        ),
      );
      final data = response.data ?? const <int>[];
      return StatsCsvExport(
        bytes: data is Uint8List ? data : Uint8List.fromList(data),
        filename:
            filenameFromDisposition(
              response.headers.value('content-disposition'),
            ) ??
            fallbackFilename(_now()),
      );
    } on DioException catch (error) {
      throw ApiException.fromDio(_withJsonBody(error));
    }
  }

  /// Bij `ResponseType.bytes` is ook een foutantwoord bytes; decodeer Laravels
  /// JSON zodat [ApiException.message] gevuld raakt.
  static DioException _withJsonBody(DioException error) {
    final response = error.response;
    final data = response?.data;
    if (response == null || data is! List<int>) return error;
    try {
      final decoded = jsonDecode(utf8.decode(data));
      return error.copyWith(
        response: Response<Object?>(
          requestOptions: response.requestOptions,
          data: decoded,
          statusCode: response.statusCode,
          headers: response.headers,
        ),
      );
    } on FormatException {
      return error;
    }
  }

  /// `stats-JJJJ-MM-DD.csv` voor [date].
  static String fallbackFilename(DateTime date) {
    String two(int n) => n.toString().padLeft(2, '0');
    return 'stats-${date.year}-${two(date.month)}-${two(date.day)}.csv';
  }

  /// De `filename` uit een `Content-Disposition`-header (met of zonder
  /// aanhalingstekens); alleen de bestandsnaam, nooit een pad.
  static String? filenameFromDisposition(String? header) {
    if (header == null) return null;
    final match = RegExp(
      r'filename\s*=\s*"?([^";]+)"?',
      caseSensitive: false,
    ).firstMatch(header);
    final raw = match?.group(1)?.trim();
    if (raw == null || raw.isEmpty) return null;
    final name = raw.split(RegExp(r'[\\/]')).last.trim();
    return name.isEmpty ? null : name;
  }
}

final statsRepositoryProvider = Provider<StatsRepository>(
  (ref) => StatsRepository(
    ref.watch(apiClientProvider),
    dio: ref.watch(dioProvider),
  ),
);
