import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_controller.dart';
import '../theme/team_color.dart';
import '../theme/theme_providers.dart';
import 'me_repository.dart';
import 'models/me.dart';
import 'models/team_membership.dart';

/// De bootstrap uit `/me`; `null` zolang niemand is ingelogd. Laadt opnieuw
/// bij elke wissel van [authControllerProvider].
///
/// Geen automatische retry: een fout toont een scherm met "Opnieuw proberen".
final meProvider = FutureProvider<Me?>((ref) async {
  final status = ref.watch(authControllerProvider);
  if (status != AuthStatus.signedIn) return null;
  return ref.watch(meRepositoryProvider).fetch();
}, retry: (retryCount, error) => null);

/// Het gekozen team-id, bewaard in shared_preferences zodat de app na een
/// herstart bij hetzelfde team opent.
class CurrentTeamIdNotifier extends Notifier<int?> {
  static const String storageKey = 'current_team_id';

  @override
  int? build() => ref.read(sharedPreferencesProvider).getInt(storageKey);

  /// Wisselt van team (zonder roundtrip: alles staat al in `/me`).
  Future<void> select(int teamId) async {
    state = teamId;
    final teams = ref.read(meProvider).value?.teams ?? const [];
    for (final membership in teams) {
      if (membership.team.id == teamId) {
        ref
            .read(teamColorProvider.notifier)
            .set(membership.team.primaryColor ?? TeamColor.fallbackHex);
      }
    }
    await ref.read(sharedPreferencesProvider).setInt(storageKey, teamId);
  }
}

final currentTeamIdProvider = NotifierProvider<CurrentTeamIdNotifier, int?>(
  CurrentTeamIdNotifier.new,
);

/// Het actieve team: het bewaarde team als de gebruiker daar nog lid van is,
/// anders het eerste. `null` = (nog) geen `/me` of geen teams.
///
/// Rol, abilities en features voor de navigatie komen hier vandaan.
final currentMembershipProvider = Provider<TeamMembership?>((ref) {
  final teams = ref.watch(meProvider).value?.teams;
  if (teams == null || teams.isEmpty) return null;
  final selected = ref.watch(currentTeamIdProvider);
  for (final membership in teams) {
    if (membership.team.id == selected) return membership;
  }
  return teams.first;
});

/// Houdt [teamColorProvider] gelijk aan het actieve team (standaardkleur als
/// er geen team is). `AssistjeApp` houdt deze provider actief.
final teamColorSyncProvider = Provider<void>((ref) {
  ref.listen<TeamMembership?>(currentMembershipProvider, (previous, next) {
    final hex = next?.team.primaryColor ?? TeamColor.fallbackHex;
    if (ref.read(teamColorProvider) != hex) {
      ref.read(teamColorProvider.notifier).set(hex);
    }
  });
});
