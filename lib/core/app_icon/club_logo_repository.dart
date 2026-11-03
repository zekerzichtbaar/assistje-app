import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../api/api_exception.dart';

/// Clublogo's voor de snelkoppeling op het beginscherm (Android).
///
/// De lijst komt uit `GET /app-icons` (publiek, vogels3
/// `docs/api/v1/app-icons.md`): dezelfde bron als de iOS-iconen van
/// `tool/app_icons.dart`. Hij wordt één keer per sessie opgehaald (de route
/// heeft `throttle:10,1`).
class ClubLogoRepository {
  ClubLogoRepository(this._api, this._files);

  final ApiClient _api;

  /// Zonder bearer-token: de logo's staan publiek op `/storage`.
  final Dio _files;
  Map<int, String>? _logos;

  /// Het logo van club [clubId], of `null` zonder (bruikbaar) logo of als de
  /// lijst niet op te halen is. Een SVG-logo telt niet: Android (en
  /// `Image.network`) kan dat niet tekenen.
  Future<String?> logoUrl(int clubId) async {
    try {
      final logos = _logos ??= await _fetch();
      return logos[clubId];
    } on ApiException {
      return null;
    }
  }

  Future<Map<int, String>> _fetch() async {
    final body = await _api.get('/app-icons');
    return {
      for (final club
          in (body['data'] as List? ?? const []).cast<Map<String, dynamic>>())
        if (club['club_id'] case final int id)
          if (club['logo_url'] case final String url when isRaster(url))
            id: url,
    };
  }

  /// Download het logo (PNG/JPEG/WebP); fouten als [ApiException].
  Future<Uint8List> download(String url) async {
    try {
      final response = await _files.get<List<int>>(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      return Uint8List.fromList(response.data ?? const []);
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  @visibleForTesting
  static bool isRaster(String url) =>
      !Uri.parse(url).path.toLowerCase().endsWith('.svg');
}

final clubLogoRepositoryProvider = Provider<ClubLogoRepository>((ref) {
  final files = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
  final adapter = ref.watch(apiHttpAdapterProvider);
  if (adapter != null) files.httpClientAdapter = adapter;
  return ClubLogoRepository(ref.watch(apiClientProvider), files);
});
