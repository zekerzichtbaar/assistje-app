import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/auth/auth_controller.dart';
import '../data/models/player_management_models.dart';
import '../data/player_management_repository.dart';
import 'player_management_controller.dart';

/// De teamlink van team [teamId] (`Trainer/TeamLink.tsx`): laden, een verse
/// link maken (de vorige werkt dan niet meer) en intrekken. Niet
/// optimistisch: het antwoord van de server is de nieuwe stand.
///
/// Na een wijziging wordt het spelersbeheer ververst (dat toont de link ook).
/// Acties geven de fout terug, of `null`.
class TeamLinkController extends AsyncNotifier<TeamLinkOverview> {
  TeamLinkController(this.teamId);

  final int teamId;

  PlayerManagementRepository get _repository =>
      ref.read(playerManagementRepositoryProvider);

  @override
  Future<TeamLinkOverview> build() {
    ref.watch(authControllerProvider);
    return ref.watch(playerManagementRepositoryProvider).fetchTeamLink(teamId);
  }

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
      final overview = await _repository.fetchTeamLink(teamId);
      if (ref.mounted) state = AsyncData(overview);
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// Een verse link (ook na verlopen of intrekken).
  Future<Object?> create() => _write(() => _repository.createTeamLink(teamId));

  /// De link dichtzetten, zonder vervanger.
  Future<Object?> revoke() => _write(() => _repository.revokeTeamLink(teamId));

  Future<Object?> _write(Future<TeamLinkOverview> Function() request) async {
    if (state.value == null) return const NotFoundException();
    try {
      final overview = await request();
      if (ref.mounted) {
        state = AsyncData(overview);
        ref.invalidate(playerManagementControllerProvider(teamId));
      }
      return null;
    } on Object catch (error) {
      return error;
    }
  }
}

/// De teamlink per team-id; weg zodra het scherm dicht is.
final teamLinkControllerProvider = AsyncNotifierProvider.autoDispose
    .family<TeamLinkController, TeamLinkOverview, int>(
      TeamLinkController.new,
      retry: (retryCount, error) => null,
    );
