import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../data/models/player_detail_models.dart';
import '../data/player_detail_repository.dart';

/// Welke speler van welk team.
typedef PlayerKey = ({int teamId, int playerId});

/// Het detail van één speler: laden en verversen.
class PlayerDetailController extends AsyncNotifier<PlayerDetail> {
  PlayerDetailController(this.key);

  final PlayerKey key;

  @override
  Future<PlayerDetail> build() async {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een vers detail.
    ref.watch(authControllerProvider);
    return ref
        .watch(playerDetailRepositoryProvider)
        .fetch(key.teamId, key.playerId);
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
      final detail = await ref
          .read(playerDetailRepositoryProvider)
          .fetch(key.teamId, key.playerId);
      state = AsyncData(detail);
      return null;
    } on Object catch (error) {
      return error;
    }
  }
}

/// Het speler-detail per `(teamId, playerId)`; weg zodra het scherm dicht
/// is. Geen automatische retry: het scherm toont een fout met "Opnieuw
/// proberen".
final playerDetailControllerProvider = AsyncNotifierProvider.autoDispose
    .family<PlayerDetailController, PlayerDetail, PlayerKey>(
      PlayerDetailController.new,
      retry: (retryCount, error) => null,
    );
