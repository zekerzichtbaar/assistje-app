import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../../../core/session/session_providers.dart';
import '../data/join_repository.dart';
import '../data/models/join_models.dart';

/// Sleutel voor [joinConfirmationProvider]: de query als string, zodat twee
/// gelijke links dezelfde provider geven.
typedef JoinConfirmKey = ({String token, String login, String query});

/// `GET /join/{token}`. Geen automatische retry: het scherm toont de fout.
final joinLinkProvider = FutureProvider.autoDispose.family<JoinLink, String>(
  (ref, token) => ref.watch(joinRepositoryProvider).fetchLink(token),
  retry: (retryCount, error) => null,
);

/// `GET /join/{token}/confirm/{login}?{query}`.
final joinConfirmationProvider = FutureProvider.autoDispose
    .family<JoinConfirmation, JoinConfirmKey>(
      (ref, key) => ref
          .watch(joinRepositoryProvider)
          .fetchConfirmation(
            key.token,
            key.login,
            query: key.query.isEmpty
                ? const {}
                : Uri.splitQueryString(key.query),
          ),
      retry: (retryCount, error) => null,
    );

/// `GET /invites/{token}`.
final inviteInfoProvider = FutureProvider.autoDispose
    .family<InviteInfo, String>(
      (ref, token) => ref.watch(joinRepositoryProvider).fetchInvite(token),
      retry: (retryCount, error) => null,
    );

/// De acties van de publieke schermen. Elke actie die een token oplevert
/// eindigt ingelogd, met `/me` geladen en het team van de link gekozen; het
/// scherm gaat daarna naar `AppRoutes.home`.
///
/// Fouten (`ApiException`) gaan door naar het scherm.
class JoinFlow {
  JoinFlow(this._ref);

  final Ref _ref;

  JoinRepository get _repository => _ref.read(joinRepositoryProvider);

  /// `POST /join/{token}`. Bij [JoinSignedIn] is de gebruiker daarna
  /// ingelogd in het team van [link]; bij [JoinConfirmationSent] verandert
  /// er niets.
  Future<JoinOutcome> join(
    String token,
    JoinLink link, {
    required JoinRole role,
    int? playerId,
    String? name,
    String? email,
  }) async {
    final outcome = await _repository.join(
      token,
      role: role,
      playerId: playerId,
      name: name,
      email: email,
    );
    if (outcome is JoinSignedIn) {
      await _signIn(outcome.token, teamId: link.team.id);
    }
    return outcome;
  }

  /// `POST /join/{token}/confirm/{login}` met de keuze uit de maillink.
  Future<void> confirm(
    String token,
    String login,
    JoinConfirmation confirmation,
  ) async {
    final accessToken = await _repository.confirm(
      token,
      login,
      role: confirmation.role,
      playerId: confirmation.playerId,
      name: confirmation.name,
    );
    await _signIn(accessToken, teamId: confirmation.team.id);
  }

  /// `POST /invites/{token}/accept`. De uitnodiging noemt geen team: `/me`
  /// kiest het (bewaarde of eerste) team.
  Future<void> acceptInvite(String token) async {
    final accessToken = await _repository.acceptInvite(token);
    await _signIn(accessToken);
  }

  /// Al lid (`already_member` of `409`): alleen naar dat team wisselen.
  Future<void> enterTeam(int teamId) async {
    final me = await _ref.read(meProvider.future);
    if (me?.teams.any((m) => m.team.id == teamId) ?? false) {
      await _ref.read(currentTeamIdProvider.notifier).select(teamId);
    }
  }

  Future<void> _signIn(String accessToken, {int? teamId}) async {
    await _ref.read(authControllerProvider.notifier).adoptToken(accessToken);
    if (teamId == null) {
      await _ref.read(meProvider.future);
      return;
    }
    await enterTeam(teamId);
  }
}

final joinFlowProvider = Provider<JoinFlow>(JoinFlow.new);
