import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../data/duties_repository.dart';
import '../data/models/duty_overview_models.dart';

/// Het dienstenoverzicht (`/diensten`) van team [teamId] voor elk teamlid:
/// laden en verversen. Alleen lezen.
class DutyOverviewController extends AsyncNotifier<DutyOverview> {
  DutyOverviewController(this.teamId);

  final int teamId;

  @override
  Future<DutyOverview> build() {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een vers overzicht.
    ref.watch(authControllerProvider);
    return ref.watch(dutiesRepositoryProvider).fetchOverview(teamId);
  }

  /// Opnieuw laden. Met data in beeld blijft die staan bij een fout; de
  /// fout komt terug (of `null` als het lukte).
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
      final overview = await ref
          .read(dutiesRepositoryProvider)
          .fetchOverview(teamId);
      if (ref.mounted) state = AsyncData(overview);
      return null;
    } on Object catch (error) {
      return error;
    }
  }
}

/// Het dienstenoverzicht per team-id. Geen automatische retry: het scherm
/// toont een fout met "Opnieuw proberen".
final dutyOverviewControllerProvider =
    AsyncNotifierProvider.family<DutyOverviewController, DutyOverview, int>(
      DutyOverviewController.new,
      retry: (retryCount, error) => null,
    );
