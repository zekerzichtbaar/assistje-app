import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../data/models/poule_models.dart';
import '../data/poule_repository.dart';

/// De poule van team [teamId]: laden en verversen.
class PouleController extends AsyncNotifier<Poule> {
  PouleController(this.teamId);

  final int teamId;

  @override
  Future<Poule> build() async {
    // Een andere gebruiker (uit- en weer inloggen) laadt opnieuw.
    ref.watch(authControllerProvider);
    return ref.watch(pouleRepositoryProvider).fetch(teamId);
  }

  /// Opnieuw laden. Met data in beeld blijft die staan bij een fout; geeft
  /// de fout terug (of `null`).
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
      state = AsyncData(await ref.read(pouleRepositoryProvider).fetch(teamId));
      return null;
    } on Object catch (error) {
      return error;
    }
  }
}

/// De poule per team-id. Geen automatische retry: het scherm toont een fout
/// met "Opnieuw proberen".
final pouleControllerProvider =
    AsyncNotifierProvider.family<PouleController, Poule, int>(
      PouleController.new,
      retry: (retryCount, error) => null,
    );
