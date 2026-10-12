import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/seasons_models.dart';

/// Seizoenen en badge-periodes van een team tegen de API (vogels3
/// `docs/api/v1/seasons.md`). Alleen voor de trainer (anders `403`);
/// demo-team: lezen mag, schrijven `403`; veldfouten en "kan nu niet" `422`.
///
/// Eén regel: elke schrijvende actie geeft de volledige seizoensstaat terug
/// (zelfde vorm als `GET seasons`), plus soms iets in `meta`.
class SeasonsRepository {
  const SeasonsRepository(this._api);

  final ApiClient _api;

  String _seasons(int teamId) => '/teams/$teamId/seasons';
  String _periods(int teamId) => '/teams/$teamId/periods';

  /// `GET seasons`.
  Future<SeasonsData> fetch(int teamId) async =>
      _parse(await _api.get(_seasons(teamId))).data;

  /// `PATCH seasons/current`: label en grenzen bijstellen.
  Future<SeasonsResponse> updateSeason(int teamId, SeasonUpdate update) async =>
      _parse(
        await _api.patch('${_seasons(teamId)}/current', data: update.toJson()),
      );

  /// `POST seasons/close`: afsluiten en de opvolger starten.
  Future<SeasonsResponse> closeSeason(int teamId) async =>
      _parse(await _api.post('${_seasons(teamId)}/close'));

  /// `POST seasons/reopen`: het laatst afgesloten seizoen terug (`meta.moved`).
  Future<SeasonsResponse> reopenSeason(int teamId) async =>
      _parse(await _api.post('${_seasons(teamId)}/reopen'));

  /// `PATCH periods/mode`.
  Future<SeasonsResponse> setMode(int teamId, PeriodMode mode) async => _parse(
    await _api.patch(
      '${_periods(teamId)}/mode',
      data: {'badge_period_mode': mode.apiValue},
    ),
  );

  /// `POST periods/generate`: [count] blokken (2–10), optioneel een vast
  /// aantal wedstrijden per blok (1–50).
  Future<SeasonsResponse> generate(
    int teamId, {
    required int count,
    int? matchesPerPeriod,
  }) async => _parse(
    await _api.post(
      '${_periods(teamId)}/generate',
      data: {'count': count, 'matches_per_period': ?matchesPerPeriod},
    ),
  );

  /// `POST periods` (`201`, `meta.period_id`).
  Future<SeasonsResponse> createPeriod(int teamId, PeriodInput input) async =>
      _parse(await _api.post(_periods(teamId), data: input.toJson()));

  /// `PATCH periods/{period}`.
  Future<SeasonsResponse> updatePeriod(
    int teamId,
    int periodId,
    PeriodInput input,
  ) async => _parse(
    await _api.patch('${_periods(teamId)}/$periodId', data: input.toJson()),
  );

  /// `DELETE periods/{period}`.
  Future<SeasonsResponse> deletePeriod(int teamId, int periodId) async =>
      _parse(await _api.delete('${_periods(teamId)}/$periodId'));

  /// `POST periods/{period}/close` (`meta.award_count`).
  Future<SeasonsResponse> closePeriod(int teamId, int periodId) async =>
      _parse(await _api.post('${_periods(teamId)}/$periodId/close'));

  /// `POST periods/{period}/reopen`: de titels worden ingetrokken.
  Future<SeasonsResponse> reopenPeriod(int teamId, int periodId) async =>
      _parse(await _api.post('${_periods(teamId)}/$periodId/reopen'));

  static SeasonsResponse _parse(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return SeasonsResponse(
      SeasonsData.fromJson(data),
      SeasonsMeta.fromJson(body['meta']),
    );
  }
}

final seasonsRepositoryProvider = Provider<SeasonsRepository>(
  (ref) => SeasonsRepository(ref.watch(apiClientProvider)),
);
