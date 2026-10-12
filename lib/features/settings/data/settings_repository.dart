import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/settings_models.dart';

/// De Instellingen van een team tegen de API (vogels3
/// `docs/api/v1/settings.md`). Alleen voor de trainer (anders `403`);
/// demo-team: lezen mag, schrijven `403`; veldfouten `422`.
///
/// Eén regel: elke schrijvende actie geeft de volledige instellingen terug
/// (zelfde vorm als `GET`), dus elke methode levert een [TeamSettings].
class SettingsRepository {
  const SettingsRepository(this._api);

  final ApiClient _api;

  String _settings(int teamId) => '/teams/$teamId/settings';

  /// `GET settings`.
  Future<TeamSettings> fetch(int teamId) async =>
      _parse(await _api.get(_settings(teamId)));

  /// `PATCH settings/team`: naam, kleur, opstelling, logo tot de rand.
  Future<TeamSettings> updateTeam(int teamId, TeamBranding branding) async =>
      _parse(
        await _api.patch('${_settings(teamId)}/team', data: branding.toJson()),
      );

  /// `POST settings/team/logo` met een data-URI (`logo_base64`).
  Future<TeamSettings> uploadLogo(int teamId, String dataUri) async => _parse(
    await _api.post(
      '${_settings(teamId)}/team/logo',
      data: {'logo_base64': dataUri},
    ),
  );

  /// `DELETE settings/team/logo`.
  Future<TeamSettings> removeLogo(int teamId) async =>
      _parse(await _api.delete('${_settings(teamId)}/team/logo'));

  /// `PATCH settings/rsvp`.
  Future<TeamSettings> updateRsvp(int teamId, RsvpUpdate update) async =>
      _parse(
        await _api.patch('${_settings(teamId)}/rsvp', data: update.toJson()),
      );

  /// `POST settings/ical/rotate`: nieuwe feed-URL's, de oude werken niet meer.
  Future<TeamSettings> rotateIcal(int teamId) async =>
      _parse(await _api.post('${_settings(teamId)}/ical/rotate'));

  /// `PATCH settings/features/{key}`.
  Future<TeamSettings> setFeature(
    int teamId,
    String key, {
    required bool enabled,
  }) async => _parse(
    await _api.patch(
      '${_settings(teamId)}/features/${Uri.encodeComponent(key)}',
      data: {'enabled': enabled},
    ),
  );

  /// `PATCH settings/carpool-hours` (1–48).
  Future<TeamSettings> setCarpoolHours(int teamId, int hours) async => _parse(
    await _api.patch(
      '${_settings(teamId)}/carpool-hours',
      data: {'hours': hours},
    ),
  );

  /// `PATCH settings/guests`: alleen wat in [update] staat.
  Future<TeamSettings> updateGuests(int teamId, GuestUpdate update) async =>
      _parse(
        await _api.patch('${_settings(teamId)}/guests', data: update.toJson()),
      );

  /// `PATCH settings/training-points`.
  Future<TeamSettings> setTrainingAttendancePoint(
    int teamId, {
    required bool enabled,
  }) async => _parse(
    await _api.patch(
      '${_settings(teamId)}/training-points',
      data: {'training_attendance_point': enabled},
    ),
  );

  /// `POST settings/duty-types` (`201`).
  Future<TeamSettings> createDutyType(int teamId, DutyTypeInput input) async =>
      _parse(
        await _api.post(
          '${_settings(teamId)}/duty-types',
          data: input.toJson(),
        ),
      );

  /// `PATCH settings/duty-types/{dutyType}`.
  Future<TeamSettings> updateDutyType(
    int teamId,
    int dutyTypeId,
    DutyTypeInput input,
  ) async => _parse(
    await _api.patch(
      '${_settings(teamId)}/duty-types/$dutyTypeId',
      data: input.toJson(),
    ),
  );

  /// `DELETE settings/duty-types/{dutyType}`.
  Future<TeamSettings> deleteDutyType(int teamId, int dutyTypeId) async =>
      _parse(await _api.delete('${_settings(teamId)}/duty-types/$dutyTypeId'));

  static TeamSettings _parse(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return TeamSettings.fromJson(data);
  }
}

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(apiClientProvider)),
);
