import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../../../core/session/session_providers.dart';
import '../data/models/onboarding_models.dart';
import '../data/onboarding_repository.dart';

/// De onboarding-checklist van team [teamId].
///
/// Acties geven de fout terug (of `null` als het lukte), zodat het scherm hem
/// kan tonen.
class OnboardingController extends AsyncNotifier<Onboarding> {
  OnboardingController(this.teamId);

  final int teamId;

  OnboardingRepository get _repository =>
      ref.read(onboardingRepositoryProvider);

  @override
  Future<Onboarding> build() {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een verse lijst.
    ref.watch(authControllerProvider);
    return ref.watch(onboardingRepositoryProvider).fetch(teamId);
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
      state = AsyncData(await _repository.fetch(teamId));
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// Afronden ("Naar de app" / "Overslaan"). Daarna `/me` opnieuw ophalen:
  /// `onboarding_open` gaat uit en het menu-item verdwijnt.
  Future<Object?> complete() async {
    try {
      state = AsyncData(await _repository.complete(teamId));
    } on Object catch (error) {
      return error;
    }
    ref.invalidate(meProvider);
    return null;
  }
}

/// De checklist per team-id. Geen automatische retry: het scherm toont een
/// fout met "Opnieuw proberen".
final onboardingControllerProvider =
    AsyncNotifierProvider.family<OnboardingController, Onboarding, int>(
      OnboardingController.new,
      retry: (retryCount, error) => null,
    );
