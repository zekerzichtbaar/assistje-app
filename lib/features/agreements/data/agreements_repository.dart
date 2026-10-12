import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/agreements_models.dart';

/// De velden van een nieuwe of gewijzigde afspraak (alle drie altijd mee,
/// ook bij `PATCH`).
class AgreementDraft {
  const AgreementDraft({
    required this.category,
    required this.title,
    this.body,
  });

  final String category;
  final String title;

  /// Leeg of alleen spaties wordt `null` (de server doet hetzelfde).
  final String? body;

  Map<String, Object?> toJson() {
    final text = body?.trim();
    return {
      'category': category,
      'title': title.trim(),
      'body': text == null || text.isEmpty ? null : text,
    };
  }
}

/// De teamafspraken-endpoints (vogels3 `docs/api/v1/agreements.md`).
/// Lezen mag elk teamlid, schrijven alleen de trainer (anders 403); feature
/// uit of afspraak van een ander team geeft 404; veldfouten 422.
class AgreementsRepository {
  const AgreementsRepository(this._api);

  final ApiClient _api;

  Future<AgreementsOverview> fetch(int teamId) async {
    final body = await _api.get('/teams/$teamId/agreements');
    return AgreementsOverview.fromJson(_data(body));
  }

  Future<Agreement> create(int teamId, AgreementDraft draft) async {
    final body = await _api.post(
      '/teams/$teamId/agreements',
      data: draft.toJson(),
    );
    return Agreement.fromJson(_data(body));
  }

  Future<Agreement> update(
    int teamId,
    int agreementId,
    AgreementDraft draft,
  ) async {
    final body = await _api.patch(
      '/teams/$teamId/agreements/$agreementId',
      data: draft.toJson(),
    );
    return Agreement.fromJson(_data(body));
  }

  Future<void> delete(int teamId, int agreementId) =>
      _api.delete('/teams/$teamId/agreements/$agreementId');

  /// Zet de introtekst; leeg wist hem. Geeft de opgeslagen tekst terug.
  Future<String?> updateIntro(int teamId, String intro) async {
    final body = await _api.patch(
      '/teams/$teamId/agreements/intro',
      data: {'intro': intro.trim()},
    );
    final value = _data(body)['intro'];
    return value is String ? value : null;
  }

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final agreementsRepositoryProvider = Provider<AgreementsRepository>(
  (ref) => AgreementsRepository(ref.watch(apiClientProvider)),
);
