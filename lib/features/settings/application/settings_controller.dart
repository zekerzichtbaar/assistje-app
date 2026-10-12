import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/auth/auth_controller.dart';
import '../../../core/session/session_providers.dart';
import '../data/models/settings_models.dart';
import '../data/settings_repository.dart';

/// Wat het Instellingen-scherm van één team nu weet.
class SettingsState {
  const SettingsState({required this.data, this.writesForbidden = false});

  final TeamSettings data;

  /// Een schrijvende actie gaf `403` (demo-team, of de rol is intussen
  /// ingetrokken): het scherm valt terug op alleen-lezen.
  final bool writesForbidden;

  SettingsState copyWith({TeamSettings? data, bool? writesForbidden}) =>
      SettingsState(
        data: data ?? this.data,
        writesForbidden: writesForbidden ?? this.writesForbidden,
      );
}

/// De Instellingen van team [teamId] (`Settings/Index.tsx`): laden,
/// verversen en alle trainer-acties.
///
/// - Schakelaars en keuzerondjes die in de PWA meteen opslaan (functies,
///   gasten, trainingspunt, carpool-uren) zijn optimistisch en draaien hun
///   eigen wijziging terug bij een fout.
/// - Formulieren (team, deadlines, diensttypes), het logo en een nieuwe
///   agenda-link wachten op de server.
///
/// Elke schrijfactie geeft de volledige instellingen terug; die worden de
/// nieuwe stand — behalve terwijl er nog een nieuwere optimistische wijziging
/// onderweg is, zodat een snelle tweede tik niet even terugspringt.
///
/// Wijzigingen aan naam, kleur, logo of functies verversen `/me`, zodat de
/// teamkleur en het menu meteen meebewegen. Acties geven de fout terug, of
/// `null`.
class SettingsController extends AsyncNotifier<SettingsState> {
  SettingsController(this.teamId);

  final int teamId;

  /// Optimistische verzoeken die nog onderweg zijn.
  int _inFlight = 0;

  SettingsRepository get _repository => ref.read(settingsRepositoryProvider);

  @override
  Future<SettingsState> build() async {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een vers scherm.
    ref.watch(authControllerProvider);
    final data = await ref.watch(settingsRepositoryProvider).fetch(teamId);
    return SettingsState(data: data);
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
      _setData(await _repository.fetch(teamId));
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  // --- Team --------------------------------------------------------------

  Future<Object?> updateTeam(TeamBranding branding) =>
      _write(() => _repository.updateTeam(teamId, branding), refreshMe: true);

  /// Nieuw logo als data-URI. De server haalt er ook de teamkleur uit.
  Future<Object?> uploadLogo(String dataUri) =>
      _write(() => _repository.uploadLogo(teamId, dataUri), refreshMe: true);

  Future<Object?> removeLogo() =>
      _write(() => _repository.removeLogo(teamId), refreshMe: true);

  /// Nieuwe agenda-links; de oude werken meteen niet meer.
  Future<Object?> rotateIcal() => _write(() => _repository.rotateIcal(teamId));

  // --- Deadlines ---------------------------------------------------------

  Future<Object?> updateRsvp(RsvpUpdate update) =>
      _write(() => _repository.updateRsvp(teamId, update));

  // --- Functies ----------------------------------------------------------

  /// Functie [key] aan of uit (optimistisch).
  Future<Object?> setFeature(String key, {required bool enabled}) {
    final now = state.value?.data;
    if (now == null) return Future.value(const NotFoundException());
    final before = now.featureEnabled(key);
    if (before == enabled) return Future.value();
    return _optimistic(
      apply: (s) => s.withFeature(key, enabled: enabled),
      restore: (s) => s.withFeature(key, enabled: before),
      request: () => _repository.setFeature(teamId, key, enabled: enabled),
      refreshMe: true,
    );
  }

  /// Carpool-herinnering op [hours] uur vooraf (1–48, optimistisch).
  Future<Object?> setCarpoolHours(int hours) {
    final now = state.value?.data;
    if (now == null) return Future.value(const NotFoundException());
    final before = now.carpool.reminderHours;
    if (before == hours) return Future.value();
    return _optimistic(
      apply: (s) =>
          s.copyWith(carpool: s.carpool.copyWith(reminderHours: hours)),
      restore: (s) =>
          s.copyWith(carpool: s.carpool.copyWith(reminderHours: before)),
      request: () => _repository.setCarpoolHours(teamId, hours),
    );
  }

  /// Gastspeler-instellingen wijzigen (optimistisch).
  Future<Object?> updateGuests(GuestUpdate update) {
    final now = state.value?.data;
    if (now == null) return Future.value(const NotFoundException());
    final before = now.guests;
    final restoreUpdate = GuestUpdate(
      attendance: update.attendance == null ? null : before.attendance,
      inFines: update.inFines == null ? null : before.inFines,
      inStats: update.inStats == null ? null : before.inStats,
      staffInFines: update.staffInFines == null ? null : before.staffInFines,
    );
    return _optimistic(
      apply: (s) => s.copyWith(guests: update.applyTo(s.guests)),
      restore: (s) => s.copyWith(guests: restoreUpdate.applyTo(s.guests)),
      request: () => _repository.updateGuests(teamId, update),
    );
  }

  /// "Punt voor aanwezigheid" aan of uit (optimistisch).
  Future<Object?> setTrainingAttendancePoint({required bool enabled}) {
    final now = state.value?.data;
    if (now == null) return Future.value(const NotFoundException());
    final before = now.trainingPoints.attendancePoint;
    if (before == enabled) return Future.value();
    return _optimistic(
      apply: (s) => s.copyWith(
        trainingPoints: s.trainingPoints.copyWith(attendancePoint: enabled),
      ),
      restore: (s) => s.copyWith(
        trainingPoints: s.trainingPoints.copyWith(attendancePoint: before),
      ),
      request: () =>
          _repository.setTrainingAttendancePoint(teamId, enabled: enabled),
    );
  }

  // --- Diensttypes -------------------------------------------------------

  Future<Object?> createDutyType(DutyTypeInput input) =>
      _write(() => _repository.createDutyType(teamId, input));

  Future<Object?> updateDutyType(int id, DutyTypeInput input) =>
      _write(() => _repository.updateDutyType(teamId, id, input));

  Future<Object?> deleteDutyType(int id) =>
      _write(() => _repository.deleteDutyType(teamId, id));

  // --- Hulpjes -----------------------------------------------------------

  Future<Object?> _optimistic({
    required TeamSettings Function(TeamSettings) apply,
    required TeamSettings Function(TeamSettings) restore,
    required Future<TeamSettings> Function() request,
    bool refreshMe = false,
  }) async {
    final now = state.value;
    if (now == null) return const NotFoundException();
    if (now.writesForbidden) return const ForbiddenException();
    _setData(apply(now.data));
    _inFlight++;
    try {
      final saved = await request();
      _inFlight--;
      if (_inFlight == 0) _setData(saved);
      if (refreshMe) _refreshMe();
      return null;
    } on Object catch (error) {
      _inFlight--;
      final latest = ref.mounted ? state.value?.data : null;
      if (latest != null) _setData(restore(latest));
      _noteForbidden(error);
      return error;
    }
  }

  Future<Object?> _write(
    Future<TeamSettings> Function() request, {
    bool refreshMe = false,
  }) async {
    final now = state.value;
    if (now == null) return const NotFoundException();
    if (now.writesForbidden) return const ForbiddenException();
    try {
      _setData(await request());
    } on Object catch (error) {
      _noteForbidden(error);
      return error;
    }
    if (refreshMe) _refreshMe();
    return null;
  }

  void _setData(TeamSettings data) {
    if (!ref.mounted) return;
    final current = state.value;
    state = AsyncData(
      current == null
          ? SettingsState(data: data)
          : current.copyWith(data: data),
    );
  }

  void _noteForbidden(Object error) {
    if (error is! ForbiddenException || !ref.mounted) return;
    final current = state.value;
    if (current != null && !current.writesForbidden) {
      state = AsyncData(current.copyWith(writesForbidden: true));
    }
  }

  /// Teamkleur, logo en functies leven ook in `/me` (menu, kleur).
  void _refreshMe() {
    if (ref.mounted) ref.invalidate(meProvider);
  }
}

/// De instellingen per team-id; weg zodra het scherm dicht is. Geen
/// automatische retry: het scherm toont een fout met "Opnieuw proberen".
final settingsControllerProvider = AsyncNotifierProvider.autoDispose
    .family<SettingsController, SettingsState, int>(
      SettingsController.new,
      retry: (retryCount, error) => null,
    );
