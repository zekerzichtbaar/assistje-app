import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'feedback_image_picker.dart';
import 'models/feedback_models.dart';

/// Een nieuwe melding.
class FeedbackDraft {
  const FeedbackDraft({required this.body, this.kind, this.image});

  final String body;

  /// `issue` of `idea`; `null` = zonder etiket.
  final FeedbackKind? kind;

  /// Optionele schermafbeelding; dan gaat het verzoek als multipart.
  final PickedFeedbackImage? image;

  String? get _kind => switch (kind) {
    FeedbackKind.issue => 'issue',
    FeedbackKind.idea => 'idea',
    _ => null,
  };

  /// JSON zonder afbeelding, anders `multipart/form-data` met veld `image`.
  Object toRequestData() {
    final fields = <String, Object>{'body': body.trim(), 'kind': ?_kind};
    final image = this.image;
    if (image == null) return fields;
    final [type, subtype] = image.mimeType.split('/');
    return FormData.fromMap({
      ...fields,
      'image': MultipartFile.fromBytes(
        image.bytes,
        filename: image.name,
        contentType: DioMediaType(type, subtype),
      ),
    });
  }
}

/// De feedback-endpoints (vogels3 `docs/api/v1/feedback.md`): voor elk
/// teamlid, ook toeschouwers. Schrijven is gethrottled (429) en geeft op een
/// demo-team 403; veldfouten 422.
class FeedbackRepository {
  const FeedbackRepository(this._api, this._dio);

  final ApiClient _api;

  /// De geauthenticeerde [Dio] van de app, voor de binaire afbeelding
  /// ([ApiClient] geeft alleen JSON-maps terug).
  final Dio _dio;

  static String _base(int teamId) => '/teams/$teamId/feedback';

  /// `GET feedback`: je laatste 50 meldingen, nieuwste eerst.
  Future<List<FeedbackItem>> fetch(int teamId) async {
    final body = await _api.get(_base(teamId));
    return parseFeedbackList(body['data']);
  }

  /// `POST feedback` (JSON, of multipart met een schermafbeelding).
  Future<FeedbackItem> submit(int teamId, FeedbackDraft draft) async {
    final body = await _api.post(_base(teamId), data: draft.toRequestData());
    return FeedbackItem.fromJson(_data(body));
  }

  /// `POST feedback/{id}/responses`: reageren op een antwoord.
  Future<FeedbackItem> respond(int teamId, int feedbackId, String text) async {
    final body = await _api.post(
      '${_base(teamId)}/$feedbackId/responses',
      data: {'body': text.trim()},
    );
    return FeedbackItem.fromJson(_data(body));
  }

  /// `GET feedback/{id}/image`: de bytes van de schermafbeelding, via de
  /// app-[Dio] zodat het bearer-token meegaat. [url] is de absolute
  /// `image_url` uit de melding.
  Future<Uint8List> image(String url) async {
    try {
      final response = await _dio.get<List<int>>(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'image/*'},
        ),
      );
      final data = response.data;
      if (data == null || data.isEmpty) {
        throw const NotFoundException(message: 'Geen afbeelding.');
      }
      return data is Uint8List ? data : Uint8List.fromList(data);
    } on DioException catch (error) {
      throw ApiException.fromDio(error);
    }
  }

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final feedbackRepositoryProvider = Provider<FeedbackRepository>(
  (ref) =>
      FeedbackRepository(ref.watch(apiClientProvider), ref.watch(dioProvider)),
);
