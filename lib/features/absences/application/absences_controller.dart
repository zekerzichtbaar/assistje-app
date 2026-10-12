import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile/application/profile_controller.dart';
import '../../profile/data/models/profile_models.dart';
import '../data/absences_repository.dart';

/// Wat de afwezigheidsschermen van één team nu weten (uit `GET profile`).
class AbsencesState {
  const AbsencesState({
    required this.hasPlayer,
    required this.canUseVacations,
    required this.vacations,
    this.standing,
  });

  factory AbsencesState.fromProfile(Profile profile) => AbsencesState(
    hasPlayer: profile.player != null,
    canUseVacations: profile.canUseVacations,
    vacations: sortVacations(profile.vacations),
    standing: profile.standingAbsences,
  );

  /// Een eigen spelersprofiel in dit team.
  final bool hasPlayer;
  final bool canUseVacations;

  /// Op begindatum, vroegste eerst.
  final List<ProfileVacation> vacations;

  /// `null` zonder spelersprofiel.
  final StandingAbsences? standing;

  AbsencesState copyWith({
    List<ProfileVacation>? vacations,
    StandingAbsences? standing,
  }) => AbsencesState(
    hasPlayer: hasPlayer,
    canUseVacations: canUseVacations,
    vacations: vacations == null ? this.vacations : sortVacations(vacations),
    standing: standing ?? this.standing,
  );

  /// De dagen om uit te kiezen: de trainingsdagen van het team plus wat er
  /// al als vaste dag staat (ook als het team daar niet meer traint), ISO
  /// en op volgorde (maandag eerst).
  List<int> get weekdayChoices {
    final standing = this.standing;
    if (standing == null) return const [];
    final days = {
      for (final day in standing.choices) AbsencesRepository.isoWeekday(day),
      for (final day in standing.days)
        AbsencesRepository.isoWeekday(day.weekday),
    }.toList()..sort();
    return days;
  }

  /// De vaste dag op ISO-weekdag [weekday], of `null`.
  StandingAbsenceDay? standingDay(int weekday) {
    final iso = AbsencesRepository.isoWeekday(weekday);
    for (final day in standing?.days ?? const <StandingAbsenceDay>[]) {
      if (AbsencesRepository.isoWeekday(day.weekday) == iso) return day;
    }
    return null;
  }

  static List<ProfileVacation> sortVacations(List<ProfileVacation> list) =>
      [...list]..sort((a, b) {
        final byStart = a.startsOn.compareTo(b.startsOn);
        return byStart != 0 ? byStart : a.endsOn.compareTo(b.endsOn);
      });
}

/// Vakanties en vaste dagen van team [teamId]. Leest mee met
/// [profileControllerProvider]; na elke gelukte schrijfactie komt het item
/// meteen in de lijst en wordt het profiel opnieuw opgehaald (zodat ook de
/// Mij-tab klopt).
///
/// Acties geven de fout terug (of `null` als het lukte), zodat het scherm
/// hem kan tonen.
class AbsencesController extends AsyncNotifier<AbsencesState> {
  AbsencesController(this.teamId);

  final int teamId;

  AbsencesRepository get _repository => ref.read(absencesRepositoryProvider);

  @override
  Future<AbsencesState> build() async {
    final profile = await ref.watch(profileControllerProvider(teamId).future);
    return AbsencesState.fromProfile(profile);
  }

  /// Het profiel opnieuw ophalen; met data in beeld blijft die staan bij een
  /// fout.
  Future<Object?> refresh() =>
      ref.read(profileControllerProvider(teamId).notifier).refresh();

  /// Een vakantie toevoegen (datums `YYYY-MM-DD`).
  Future<Object?> addVacation({
    required String startsOn,
    required String endsOn,
    String? note,
  }) async {
    try {
      final vacation = await _repository.addVacation(
        teamId,
        startsOn: startsOn,
        endsOn: endsOn,
        note: note,
      );
      _patch((s) => s.copyWith(vacations: [...s.vacations, vacation]));
    } on Object catch (error) {
      return error;
    }
    _syncProfile();
    return null;
  }

  /// Een vakantie weghalen.
  Future<Object?> removeVacation(int vacationId) async {
    try {
      await _repository.removeVacation(teamId, vacationId);
      _patch(
        (s) => s.copyWith(
          vacations: [
            for (final v in s.vacations)
              if (v.id != vacationId) v,
          ],
        ),
      );
    } on Object catch (error) {
      return error;
    }
    _syncProfile();
    return null;
  }

  /// Vaste afwezige dag [weekday] aan- of uitzetten (wat er nu staat bepaalt
  /// welke kant op). Geeft terug of de dag nu aan staat, of de fout.
  Future<({bool on, Object? error})> toggleStandingDay(int weekday) async {
    final current = state.value;
    final existing = current?.standingDay(weekday);
    try {
      if (existing != null) {
        await _repository.removeStandingAbsence(teamId, existing.id);
        _patchStanding(
          (s) => s.copyWith(
            days: [
              for (final d in s.days)
                if (d.id != existing.id) d,
            ],
          ),
        );
      } else {
        final day = await _repository.addStandingAbsence(teamId, weekday);
        _patchStanding(
          (s) => s.copyWith(
            days: [
              for (final d in s.days)
                if (d.id != day.id) d,
              day,
            ],
          ),
        );
      }
    } on Object catch (error) {
      return (on: existing != null, error: error);
    }
    _syncProfile();
    return (on: existing == null, error: null);
  }

  void _patch(AbsencesState Function(AbsencesState) update) {
    final current = state.value;
    if (current != null) state = AsyncData(update(current));
  }

  void _patchStanding(StandingAbsences Function(StandingAbsences) update) =>
      _patch((s) {
        final standing = s.standing ?? const StandingAbsences();
        return s.copyWith(standing: update(standing));
      });

  /// Profiel (en daarmee de Mij-tab en dit scherm) opnieuw ophalen.
  void _syncProfile() => ref.invalidate(profileControllerProvider(teamId));
}

/// De afwezigheid per team-id. Geen automatische retry: het scherm toont een
/// fout met "Opnieuw proberen".
final absencesControllerProvider =
    AsyncNotifierProvider.family<AbsencesController, AbsencesState, int>(
      AbsencesController.new,
      retry: (retryCount, error) => null,
    );
