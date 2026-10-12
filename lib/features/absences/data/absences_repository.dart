import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../../profile/data/models/profile_models.dart';

/// Afwezigheid doorgeven (vogels3 `docs/api/v1/absences.md`): vakanties en
/// vaste weekdagen, altijd voor jezelf. Lezen gaat via `GET profile`; deze
/// endpoints geven alleen het aangemaakte item terug (verwijderen `204`).
///
/// Fouten komen als [ApiException]: `404` feature uit (alleen bij
/// aanmaken) of van een ander team, `403` demo/geen recht, `422` validatie
/// of "Geen spelersprofiel gekoppeld." (alleen `message`).
class AbsencesRepository {
  const AbsencesRepository(this._api);

  final ApiClient _api;

  /// `POST teams/{team}/vacations`. Datums als kale `YYYY-MM-DD`.
  Future<ProfileVacation> addVacation(
    int teamId, {
    required String startsOn,
    required String endsOn,
    String? note,
  }) async {
    final trimmed = note?.trim();
    final body = await _api.post(
      '/teams/$teamId/vacations',
      data: {
        'starts_on': startsOn,
        'ends_on': endsOn,
        if (trimmed != null && trimmed.isNotEmpty) 'note': trimmed,
      },
    );
    return ProfileVacation.fromJson(_data(body));
  }

  /// `DELETE teams/{team}/vacations/{vacation}`.
  Future<void> removeVacation(int teamId, int vacationId) async {
    await _api.delete('/teams/$teamId/vacations/$vacationId');
  }

  /// `POST teams/{team}/standing-absences`. [weekday] is ISO (1 = maandag …
  /// 7 = zondag); een 0 (zondag in de oude telling) gaat als 7.
  Future<StandingAbsenceDay> addStandingAbsence(int teamId, int weekday) async {
    final body = await _api.post(
      '/teams/$teamId/standing-absences',
      data: {'weekday': isoWeekday(weekday)},
    );
    return StandingAbsenceDay.fromJson(_data(body));
  }

  /// `DELETE teams/{team}/standing-absences/{standingAbsence}`.
  Future<void> removeStandingAbsence(int teamId, int absenceId) async {
    await _api.delete('/teams/$teamId/standing-absences/$absenceId');
  }

  /// 0 (zondag) → 7; de rest blijft.
  static int isoWeekday(int weekday) => weekday == 0 ? 7 : weekday;

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final absencesRepositoryProvider = Provider<AbsencesRepository>(
  (ref) => AbsencesRepository(ref.watch(apiClientProvider)),
);
