import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/auth/auth_controller.dart';
import '../../settings/application/settings_controller.dart';
import '../data/models/seasons_models.dart';
import '../data/seasons_repository.dart';

/// Wat het Seizoenen-scherm van één team nu weet.
class SeasonsState {
  const SeasonsState({required this.data, this.writesForbidden = false});

  final SeasonsData data;

  /// Een schrijvende actie gaf `403` (demo-team, of de rol is intussen
  /// ingetrokken): het scherm valt terug op alleen-lezen.
  final bool writesForbidden;

  SeasonsState copyWith({SeasonsData? data, bool? writesForbidden}) =>
      SeasonsState(
        data: data ?? this.data,
        writesForbidden: writesForbidden ?? this.writesForbidden,
      );
}

/// Uitkomst van een schrijvende actie: de fout, of `null` met de `meta`.
class SeasonsWrite {
  const SeasonsWrite.ok([this.meta = const SeasonsMeta()]) : error = null;
  const SeasonsWrite.failed(Object this.error) : meta = const SeasonsMeta();

  final Object? error;
  final SeasonsMeta meta;

  bool get ok => error == null;
}

/// Seizoenen en periodes van team [teamId] (PWA `Settings/SeasonTab.tsx`):
/// laden, verversen en alle trainer-acties.
///
/// Geen optimistische wijzigingen: elke actie wacht op de server en neemt
/// de volledige seizoensstaat uit het antwoord over. Daarna wordt de
/// Instellingen-controller van dit team ververst, want die toont een
/// alleen-lezen kopie onder `period`.
class SeasonsController extends AsyncNotifier<SeasonsState> {
  SeasonsController(this.teamId);

  final int teamId;

  SeasonsRepository get _repository => ref.read(seasonsRepositoryProvider);

  @override
  Future<SeasonsState> build() async {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een vers scherm.
    ref.watch(authControllerProvider);
    final data = await ref.watch(seasonsRepositoryProvider).fetch(teamId);
    return SeasonsState(data: data);
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

  // --- Seizoen -----------------------------------------------------------

  Future<SeasonsWrite> updateSeason(SeasonUpdate update) =>
      _write(() => _repository.updateSeason(teamId, update));

  Future<SeasonsWrite> closeSeason() =>
      _write(() => _repository.closeSeason(teamId));

  Future<SeasonsWrite> reopenSeason() =>
      _write(() => _repository.reopenSeason(teamId));

  // --- Periodes ----------------------------------------------------------

  Future<SeasonsWrite> setMode(PeriodMode mode) {
    if (state.value?.data.mode == mode) {
      return Future.value(const SeasonsWrite.ok());
    }
    return _write(() => _repository.setMode(teamId, mode));
  }

  Future<SeasonsWrite> generate({required int count, int? matchesPerPeriod}) =>
      _write(
        () => _repository.generate(
          teamId,
          count: count,
          matchesPerPeriod: matchesPerPeriod,
        ),
      );

  Future<SeasonsWrite> createPeriod(PeriodInput input) =>
      _write(() => _repository.createPeriod(teamId, input));

  Future<SeasonsWrite> updatePeriod(int periodId, PeriodInput input) =>
      _write(() => _repository.updatePeriod(teamId, periodId, input));

  Future<SeasonsWrite> deletePeriod(int periodId) =>
      _write(() => _repository.deletePeriod(teamId, periodId));

  Future<SeasonsWrite> closePeriod(int periodId) =>
      _write(() => _repository.closePeriod(teamId, periodId));

  Future<SeasonsWrite> reopenPeriod(int periodId) =>
      _write(() => _repository.reopenPeriod(teamId, periodId));

  // --- Hulpjes -----------------------------------------------------------

  Future<SeasonsWrite> _write(
    Future<SeasonsResponse> Function() request,
  ) async {
    final now = state.value;
    if (now == null) return const SeasonsWrite.failed(NotFoundException());
    if (now.writesForbidden) {
      return const SeasonsWrite.failed(ForbiddenException());
    }
    final SeasonsResponse response;
    try {
      response = await request();
    } on Object catch (error) {
      _noteForbidden(error);
      return SeasonsWrite.failed(error);
    }
    _setData(response.data);
    if (ref.mounted) ref.invalidate(settingsControllerProvider(teamId));
    return SeasonsWrite.ok(response.meta);
  }

  void _setData(SeasonsData data) {
    if (!ref.mounted) return;
    final current = state.value;
    state = AsyncData(
      current == null ? SeasonsState(data: data) : current.copyWith(data: data),
    );
  }

  void _noteForbidden(Object error) {
    if (error is! ForbiddenException || !ref.mounted) return;
    final current = state.value;
    if (current != null && !current.writesForbidden) {
      state = AsyncData(current.copyWith(writesForbidden: true));
    }
  }
}

/// De seizoensstaat per team-id; weg zodra het scherm dicht is. Geen
/// automatische retry: het scherm toont een fout met "Opnieuw proberen".
final seasonsControllerProvider = AsyncNotifierProvider.autoDispose
    .family<SeasonsController, SeasonsState, int>(
      SeasonsController.new,
      retry: (retryCount, error) => null,
    );
