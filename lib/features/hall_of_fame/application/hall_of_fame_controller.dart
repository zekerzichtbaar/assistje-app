import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../data/hall_of_fame_repository.dart';
import '../data/models/hall_of_fame_models.dart';

/// Wat de Hall of Fame van één team nu weet.
class HallOfFameState {
  const HallOfFameState({
    required this.hallOfFame,
    this.selectedSeasonId,
    this.switching = false,
  });

  final HallOfFame hallOfFame;

  /// Het gekozen seizoen; `null` = het lopende (standaard van de server).
  final int? selectedSeasonId;

  /// De gekozen periode komt uit het antwoord (`period_id`, `null` = heel
  /// seizoen): een onbekende periode valt bij de server zo terug.
  int? get selectedPeriodId => hallOfFame.periodId;

  /// Loopt er een wissel (seizoen/periode) bij de server?
  final bool switching;

  HallOfFameState copyWith({HallOfFame? hallOfFame, bool? switching}) =>
      HallOfFameState(
        hallOfFame: hallOfFame ?? this.hallOfFame,
        selectedSeasonId: selectedSeasonId,
        switching: switching ?? this.switching,
      );
}

/// De Hall of Fame van team [teamId]: laden, verversen, seizoen en periode
/// kiezen. Acties geven de fout terug (of `null`); bij een fout blijft de
/// vorige stand in beeld.
class HallOfFameController extends AsyncNotifier<HallOfFameState> {
  HallOfFameController(this.teamId);

  final int teamId;

  HallOfFameRepository get _repository =>
      ref.read(hallOfFameRepositoryProvider);

  @override
  Future<HallOfFameState> build() async {
    ref.watch(authControllerProvider);
    final hallOfFame = await ref
        .watch(hallOfFameRepositoryProvider)
        .fetch(teamId);
    return HallOfFameState(hallOfFame: hallOfFame);
  }

  /// Opnieuw laden met de huidige keuzes.
  Future<Object?> refresh() async {
    final current = state.value;
    if (current == null) {
      ref.invalidateSelf();
      try {
        await future;
        return null;
      } on Object catch (error) {
        return error;
      }
    }
    try {
      final hallOfFame = await _repository.fetch(
        teamId,
        seasonId: current.selectedSeasonId,
        periodId: current.selectedPeriodId,
      );
      state = AsyncData(
        (state.value ?? current).copyWith(hallOfFame: hallOfFame),
      );
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// Naar seizoen [seasonId]; de periode gaat terug naar het hele seizoen
  /// (periodes horen bij één seizoen).
  Future<Object?> selectSeason(int seasonId) {
    final current = state.value;
    if (current == null || current.hallOfFame.seasonId == seasonId) {
      return Future.value();
    }
    return _switch(seasonId, null);
  }

  /// Naar periode [periodId]; `null` = het hele seizoen.
  Future<Object?> selectPeriod(int? periodId) {
    final current = state.value;
    if (current == null || current.selectedPeriodId == periodId) {
      return Future.value();
    }
    return _switch(current.selectedSeasonId, periodId);
  }

  Future<Object?> _switch(int? seasonId, int? periodId) async {
    final current = state.value!;
    state = AsyncData(current.copyWith(switching: true));
    try {
      final hallOfFame = await _repository.fetch(
        teamId,
        seasonId: seasonId,
        periodId: periodId,
      );
      state = AsyncData(
        HallOfFameState(hallOfFame: hallOfFame, selectedSeasonId: seasonId),
      );
      return null;
    } on Object catch (error) {
      state = AsyncData((state.value ?? current).copyWith(switching: false));
      return error;
    }
  }
}

/// De Hall of Fame per team-id. Geen automatische retry: het scherm toont
/// een fout met "Opnieuw proberen".
final hallOfFameControllerProvider =
    AsyncNotifierProvider.family<HallOfFameController, HallOfFameState, int>(
      HallOfFameController.new,
      retry: (retryCount, error) => null,
    );
