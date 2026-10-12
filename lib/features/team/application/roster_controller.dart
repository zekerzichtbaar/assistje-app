import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../data/models/roster_models.dart';
import '../data/team_repository.dart';

/// De selectie van team [teamId]: laden en verversen.
class RosterController extends AsyncNotifier<TeamRoster> {
  RosterController(this.teamId);

  final int teamId;

  @override
  Future<TeamRoster> build() async {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een verse lijst.
    ref.watch(authControllerProvider);
    return ref.watch(teamRepositoryProvider).fetchRoster(teamId);
  }

  /// Opnieuw laden. Met data in beeld blijft die staan bij een fout; de
  /// fout komt terug zodat het scherm hem kan melden.
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
      final roster = await ref.read(teamRepositoryProvider).fetchRoster(teamId);
      state = AsyncData(roster);
      return null;
    } on Object catch (error) {
      return error;
    }
  }
}

/// De selectie per team-id. Geen automatische retry: het scherm toont een
/// fout met "Opnieuw proberen".
final rosterControllerProvider =
    AsyncNotifierProvider.family<RosterController, TeamRoster, int>(
      RosterController.new,
      retry: (retryCount, error) => null,
    );
