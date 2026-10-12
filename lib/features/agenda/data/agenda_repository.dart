import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/agenda_models.dart';

/// Eén geladen agenda: `data` + `meta`.
class AgendaPage {
  const AgendaPage({required this.data, required this.meta});

  final AgendaData data;
  final AgendaMeta meta;
}

/// `GET teams/{team}/agenda` en `PATCH teams/{team}/events/{event}/attendance`
/// (vogels3 `docs/api/v1/agenda.md`, `docs/api/v1/attendance.md`).
class AgendaRepository {
  const AgendaRepository(this._api);

  final ApiClient _api;

  /// Hoeveel events de server per tabblad in één venster stuurt
  /// (`AgendaQuery::PAGE_SIZE`).
  static const int pageSize = 30;

  /// De agenda met een venster van [limit] events per tabblad (`?limit=`,
  /// minimaal 30; zie Paginatie in `docs/api/v1.md`).
  Future<AgendaPage> fetch(int teamId, {int limit = pageSize}) async {
    final body = await _api.get(
      '/teams/$teamId/agenda',
      query: limit > pageSize ? {'limit': limit} : null,
    );
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    final meta = body['meta'];
    return AgendaPage(
      data: AgendaData.fromJson(data),
      meta: meta is Map<String, dynamic>
          ? AgendaMeta.fromJson(meta)
          : const AgendaMeta(),
    );
  }

  /// Je eigen aanwezigheid doorgeven. Gooit [ValidationException] met
  /// `errors.reason` als het team een reden verplicht.
  Future<AttendanceResult> setAttendance(
    int teamId,
    int eventId,
    AttendanceStatus status, {
    String? reason,
  }) async {
    final body = await _api.patch(
      '/teams/$teamId/events/$eventId/attendance',
      data: {'status': status.name, 'reason': ?reason},
    );
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return AttendanceResult.fromJson(data);
  }
}

final agendaRepositoryProvider = Provider<AgendaRepository>(
  (ref) => AgendaRepository(ref.watch(apiClientProvider)),
);
