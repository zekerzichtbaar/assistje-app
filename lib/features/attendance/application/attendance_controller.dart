import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/auth/auth_controller.dart';
import '../../agenda/application/agenda_controller.dart';
import '../../agenda/data/models/agenda_models.dart';
import '../../event/application/event_detail_controller.dart';
import '../data/attendance_repository.dart';
import '../data/models/attendance_models.dart';

/// De aanwezigheidslijst van één event voor de trainer: laden, verversen,
/// namens een speler/staflid een antwoord zetten en gasten toevoegen of
/// weghalen.
///
/// Een antwoord zetten is optimistisch en draait terug bij een fout; gasten
/// toevoegen/weghalen niet (daarna wordt de lijst opnieuw opgehaald). Na
/// elke gelukte wijziging worden het event-detail en de agenda ververst,
/// want hun tellers en lijsten kloppen dan niet meer.
///
/// Acties geven de fout terug (of `null` als het lukte).
class AttendanceController extends AsyncNotifier<EventAttendance> {
  AttendanceController(this.key);

  final EventKey key;

  int get teamId => key.teamId;
  int get eventId => key.eventId;

  AttendanceRepository get _repository =>
      ref.read(attendanceRepositoryProvider);

  @override
  Future<EventAttendance> build() {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een verse lijst.
    ref.watch(authControllerProvider);
    return ref.watch(attendanceRepositoryProvider).fetch(teamId, eventId);
  }

  /// Opnieuw laden. Met data in beeld blijft die staan bij een fout.
  Future<Object?> refresh() async {
    if (state.value == null) {
      ref.invalidateSelf();
      try {
        await future;
        return null;
      } on Object catch (error) {
        return error;
      }
    }
    try {
      _set(await _repository.fetch(teamId, eventId));
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  void _set(EventAttendance value) {
    if (ref.mounted) state = AsyncData(value);
  }

  /// Zet [row] op [status], namens hem.
  Future<Object?> setStatus(AttendanceRow row, AttendanceStatus status) async {
    final before = state.value;
    if (before == null) return const NotFoundException();
    if (!before.event.canEdit || !row.isEditable) {
      return const ForbiddenException();
    }
    if (row.status == status) return null;

    _set(before.withStatus(row, status));
    try {
      final saved = await _repository.setOnBehalf(teamId, eventId, row, status);
      final latest = ref.mounted ? state.value : null;
      if (latest != null && saved != status) {
        _set(latest.withStatus(row, saved));
      }
    } on Object catch (error) {
      final latest = ref.mounted ? state.value : null;
      if (latest != null) _set(latest.withStatus(row, row.status));
      return error;
    }
    _invalidateOthers();
    return null;
  }

  /// Een bestaande gast ([playerId]) bij dit event zetten.
  Future<Object?> addExistingGuest(int playerId) =>
      _write(() => _repository.addExistingGuest(teamId, eventId, playerId));

  /// Een nieuwe gast aanmaken en bij dit event zetten.
  Future<Object?> createGuest(NewGuest guest) =>
      _write(() => _repository.createGuest(teamId, eventId, guest));

  /// Gast [row] van dit event halen.
  Future<Object?> removeGuest(AttendanceRow row) {
    final playerId = row.playerId;
    if (!row.isGuest || playerId == null) {
      return Future.value(const ForbiddenException());
    }
    return _write(() => _repository.removeGuest(teamId, eventId, playerId));
  }

  Future<Object?> _write(Future<void> Function() request) async {
    try {
      await request();
    } on Object catch (error) {
      return error;
    }
    if (!ref.mounted) return null;
    ref.invalidate(guestOptionsProvider(key));
    _invalidateOthers();
    // Een fout bij het verversen telt niet als mislukte actie.
    await refresh();
    return null;
  }

  void _invalidateOthers() {
    if (!ref.mounted) return;
    ref
      ..invalidate(eventDetailControllerProvider(key))
      ..invalidate(agendaControllerProvider(teamId));
  }
}

/// De aanwezigheidslijst per `(teamId, eventId)`; weg zodra het scherm dicht
/// is. Geen automatische retry: het scherm toont een fout met "Opnieuw
/// proberen".
final attendanceControllerProvider = AsyncNotifierProvider.autoDispose
    .family<AttendanceController, EventAttendance, EventKey>(
      AttendanceController.new,
      retry: (retryCount, error) => null,
    );

/// De gasten van het team die nog niet bij dit event staan (voor de
/// gastenkiezer). Ververst na elke gastwijziging.
final guestOptionsProvider = FutureProvider.autoDispose
    .family<List<GuestOption>, EventKey>(
      (ref, key) => ref
          .watch(attendanceRepositoryProvider)
          .guestOptions(key.teamId, key.eventId),
      retry: (retryCount, error) => null,
    );
