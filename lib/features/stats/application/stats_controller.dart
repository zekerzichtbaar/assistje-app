import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../data/models/stats_models.dart';
import '../data/stats_repository.dart';

/// Wat het statistiekenscherm van één team nu weet.
class StatsState {
  const StatsState({
    required this.stats,
    this.window = StatsWindow.season,
    this.selectedSeasonId,
    this.switching = false,
  });

  final TeamStats stats;
  final StatsWindow window;

  /// Het gekozen seizoen; `null` = het lopende (standaard van de server).
  final int? selectedSeasonId;

  /// Loopt er een wissel (venster/seizoen) bij de server?
  final bool switching;

  StatsState copyWith({TeamStats? stats, bool? switching}) => StatsState(
    stats: stats ?? this.stats,
    window: window,
    selectedSeasonId: selectedSeasonId,
    switching: switching ?? this.switching,
  );
}

/// De statistieken van team [teamId]: laden, verversen, venster en seizoen
/// kiezen. Acties geven de fout terug (of `null`), zodat het scherm hem kan
/// tonen; bij een fout blijft de vorige stand in beeld.
class StatsController extends AsyncNotifier<StatsState> {
  StatsController(this.teamId);

  final int teamId;

  StatsRepository get _repository => ref.read(statsRepositoryProvider);

  @override
  Future<StatsState> build() async {
    // Een andere gebruiker (uit- en weer inloggen) krijgt verse cijfers.
    ref.watch(authControllerProvider);
    final stats = await ref.watch(statsRepositoryProvider).fetchStats(teamId);
    return StatsState(stats: stats, window: StatsWindow.parse(stats.window));
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
      final stats = await _repository.fetchStats(
        teamId,
        window: current.window,
        seasonId: current.selectedSeasonId,
      );
      state = AsyncData((state.value ?? current).copyWith(stats: stats));
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// Naar venster [window] (seizoen of laatste 5/10).
  Future<Object?> selectWindow(StatsWindow window) {
    final current = state.value;
    if (current == null || current.window == window) {
      return Future.value();
    }
    return _switch(window, current.selectedSeasonId);
  }

  /// Naar seizoen [seasonId].
  Future<Object?> selectSeason(int seasonId) {
    final current = state.value;
    if (current == null || current.stats.seasonId == seasonId) {
      return Future.value();
    }
    return _switch(current.window, seasonId);
  }

  Future<Object?> _switch(StatsWindow window, int? seasonId) async {
    final current = state.value!;
    state = AsyncData(current.copyWith(switching: true));
    try {
      final stats = await _repository.fetchStats(
        teamId,
        window: window,
        seasonId: seasonId,
      );
      state = AsyncData(
        StatsState(stats: stats, window: window, selectedSeasonId: seasonId),
      );
      return null;
    } on Object catch (error) {
      state = AsyncData((state.value ?? current).copyWith(switching: false));
      return error;
    }
  }
}

/// De statistieken per team-id. Geen automatische retry: het scherm toont
/// een fout met "Opnieuw proberen".
final statsControllerProvider =
    AsyncNotifierProvider.family<StatsController, StatsState, int>(
      StatsController.new,
      retry: (retryCount, error) => null,
    );
