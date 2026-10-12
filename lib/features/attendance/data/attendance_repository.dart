import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import '../../agenda/data/models/agenda_models.dart';
import 'models/attendance_models.dart';

/// De aanwezigheidslijst van de trainer en de gastspelers (vogels3
/// `docs/api/v1/attendance.md` en `guests.md`). Alles alleen voor de trainer
/// (anders `403`); een event of speler van een ander team `404`; afgelast
/// `403` bij wijzigen; veldfouten `422`.
class AttendanceRepository {
  const AttendanceRepository(this._api);

  final ApiClient _api;

  String _event(int teamId, int eventId) => '/teams/$teamId/events/$eventId';

  /// `GET …/attendance`: alle spelers (gasten achteraan) en de staf.
  Future<EventAttendance> fetch(int teamId, int eventId) async {
    final body = await _api.get('${_event(teamId, eventId)}/attendance');
    return EventAttendance.fromJson(_data(body));
  }

  /// Zet de aanwezigheid van [row] namens hem: een speler (ook gast) via
  /// `…/attendance/{player}`, een staflid via `…/attendance/staff/{user}`.
  /// Geeft de status terug die de server bewaarde.
  Future<AttendanceStatus> setOnBehalf(
    int teamId,
    int eventId,
    AttendanceRow row,
    AttendanceStatus status,
  ) async {
    final path = row.isStaff
        ? '${_event(teamId, eventId)}/attendance/staff/${row.userId}'
        : '${_event(teamId, eventId)}/attendance/${row.playerId}';
    final body = await _api.patch(path, data: {'status': status.name});
    final saved = _data(body)['status'];
    return AttendanceStatus.values.firstWhere(
      (s) => s.name == saved,
      orElse: () => status,
    );
  }

  /// `GET …/guests/options`: gasten van het team die nog niet bij dit event
  /// staan, op naam.
  Future<List<GuestOption>> guestOptions(int teamId, int eventId) async {
    final body = await _api.get('${_event(teamId, eventId)}/guests/options');
    return _options(body);
  }

  /// Een bestaande gast toevoegen (staat meteen op aanwezig).
  Future<GuestPlayer> addExistingGuest(int teamId, int eventId, int playerId) =>
      _addGuest(teamId, eventId, {'existing_player_id': playerId});

  /// Een nieuwe gast aanmaken en toevoegen.
  Future<GuestPlayer> createGuest(int teamId, int eventId, NewGuest guest) =>
      _addGuest(teamId, eventId, guest.toJson());

  Future<GuestPlayer> _addGuest(
    int teamId,
    int eventId,
    Map<String, Object?> data,
  ) async {
    final body = await _api.post(
      '${_event(teamId, eventId)}/guests',
      data: data,
    );
    return GuestPlayer.fromJson(_data(body));
  }

  /// De gast van dit event halen (de gast zelf blijft bestaan). Geeft de
  /// bijgewerkte keuzelijst terug.
  Future<List<GuestOption>> removeGuest(
    int teamId,
    int eventId,
    int playerId,
  ) async {
    final body = await _api.delete(
      '${_event(teamId, eventId)}/guests/$playerId',
    );
    return _options(body);
  }

  static List<GuestOption> _options(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! List) return const [];
    return [
      for (final row in data)
        if (row is Map<String, dynamic>) GuestOption.fromJson(row),
    ];
  }

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final attendanceRepositoryProvider = Provider<AttendanceRepository>(
  (ref) => AttendanceRepository(ref.watch(apiClientProvider)),
);
