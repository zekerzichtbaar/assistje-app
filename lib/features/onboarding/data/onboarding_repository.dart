import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/onboarding_models.dart';

/// De checklist van een nog niet ingericht team (vogels3
/// `docs/api/v1/onboarding.md`). Alleen voor de trainer: anders `403`; op
/// een demo-team geeft afronden `403`.
class OnboardingRepository {
  const OnboardingRepository(this._api);

  final ApiClient _api;

  static String _base(int teamId) => '/teams/$teamId/onboarding';

  /// `GET onboarding`.
  Future<Onboarding> fetch(int teamId) async =>
      _parse(await _api.get(_base(teamId)));

  /// `POST onboarding/complete` ("Naar de app"): zet `onboarded_at`.
  Future<Onboarding> complete(int teamId) async =>
      _parse(await _api.post('${_base(teamId)}/complete'));

  static Onboarding _parse(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return Onboarding.fromJson(data);
  }
}

final onboardingRepositoryProvider = Provider<OnboardingRepository>(
  (ref) => OnboardingRepository(ref.watch(apiClientProvider)),
);
