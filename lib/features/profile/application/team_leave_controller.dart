import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/session/session_providers.dart';
import '../data/profile_repository.dart';

/// Zelf uit een team stappen ("Verlaten" in Mijn teams).
///
/// Na een gelukte `DELETE` kiest hij, als je het actieve team verliet, een
/// ander team uit `/me` en haalt hij `/me` opnieuw op (het team verdwijnt uit
/// de lijst). Geeft de fout terug, of `null` als het lukte.
class TeamLeaveController {
  const TeamLeaveController(this._ref);

  final Ref _ref;

  Future<Object?> leave(int teamId) async {
    try {
      await _ref.read(profileRepositoryProvider).leaveTeam(teamId);
    } on Object catch (error) {
      return error;
    }
    final teams = _ref.read(meProvider).value?.teams ?? const [];
    final current = _ref.read(currentMembershipProvider);
    if (current == null || current.team.id == teamId) {
      for (final membership in teams) {
        if (membership.team.id != teamId) {
          await _ref
              .read(currentTeamIdProvider.notifier)
              .select(membership.team.id);
          break;
        }
      }
    }
    _ref.invalidate(meProvider);
    return null;
  }
}

final teamLeaveControllerProvider = Provider<TeamLeaveController>(
  TeamLeaveController.new,
);
