import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/session/models/team_membership.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../team/application/sport_info.dart';
import '../application/profile_controller.dart';
import '../data/models/profile_models.dart';
import 'widgets/account_card.dart';
import 'widgets/app_settings.dart';
import 'widgets/delete_account_card.dart';
import 'widgets/player_sections.dart';
import 'widgets/profile_ui.dart';
import 'widgets/teams_card.dart';

/// De Mij-tab (`Pages/Profile/Edit` in de PWA, tab "Profiel"): je account
/// (foto, e-mail, naam, geboortedatum), blessure, vakanties en vaste
/// afwezigheid (alleen lezen), weergave, pushvoorkeuren, je spelersprofiel
/// in dit team, het team, je teams (verlaten), uitloggen en je account verwijderen.
///
/// Team, weergave, meldingen en uitloggen staan er ook als het profiel niet
/// laadt — uitloggen moet altijd kunnen.
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  ProfileController _controller(int teamId) =>
      ref.read(profileControllerProvider(teamId).notifier);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showProfileError(
        context,
        AppLocalizations.of(context).profileLoadError,
        error,
      );
    }
  }

  Future<void> _setInjured(int teamId, {required bool injured}) async {
    unawaited(injured ? Haptics.error() : Haptics.light());
    final error = await _controller(teamId).setInjured(injured: injured);
    if (error != null && mounted) {
      showProfileError(
        context,
        AppLocalizations.of(context).profileInjuryFailed,
        error,
      );
    }
  }

  Future<void> _activatePlayer(int teamId, SportInfo sport) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final done = await showAttachPlayerSheet(
      context,
      positions: sport.positions,
      onSubmit: (draft) => _controller(
        teamId,
      ).attachPlayer(position: draft.position, shirtNumber: draft.shirtNumber),
    );
    if ((done ?? false) && mounted) {
      showProfileSuccess(context, l10n.profilePlayerCreated);
    }
  }

  Future<void> _removePlayer(int teamId) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmProfileAction(
      context,
      question: l10n.profilePlayerRemoveConfirm,
      confirmLabel: l10n.profileDelete,
    );
    if (!ok || !mounted) return;
    final error = await _controller(teamId).detachPlayer();
    if (!mounted) return;
    if (error != null) {
      showProfileError(context, l10n.profileSaveFailed, error);
    } else {
      showProfileSuccess(context, l10n.profilePlayerRemoved);
    }
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final teamId = membership?.team.id;
    final async = teamId == null
        ? null
        : ref.watch(profileControllerProvider(teamId));
    final profile = async?.value;
    final multiTeam = (ref.watch(meProvider).value?.teams.length ?? 0) > 1;

    final List<Widget> cards;
    if (teamId != null && membership != null && profile != null) {
      cards = _profileCards(teamId, membership, profile, multiTeam: multiTeam);
    } else {
      cards = [
        if (async != null && async.hasError)
          AppCard(
            key: const ValueKey('profile-error'),
            child: Row(
              children: [
                const Icon(
                  PhosphorIconsDuotone.warningCircle,
                  color: StatusColors.red500,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.profileLoadError,
                    style: TextStyle(color: t.ink, fontWeight: FontWeight.w600),
                  ),
                ),
                SecondaryButton(
                  key: const ValueKey('profile-retry'),
                  label: l10n.retry,
                  onPressed: () => _refresh(teamId!),
                ),
              ],
            ),
          )
        else if (async != null)
          const Skeleton(
            key: ValueKey('profile-loading'),
            height: 220,
            radius: AssistjeTokens.radius2xl,
          ),
        const TeamCard(),
        if (multiTeam) const TeamsCard(),
        const LogoutButton(),
        const ThemeCard(),
        const NotificationsLinkCard(),
      ];
    }

    return Scaffold(
      key: const ValueKey('profile-screen'),
      backgroundColor: t.sunken,
      body: AppRefresh(
        onRefresh: () async {
          if (teamId != null) await _refresh(teamId);
        },
        padding: EdgeInsets.fromLTRB(
          12,
          ShellInsets.top(context),
          12,
          ShellInsets.bottom(context),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
              child: Semantics(
                header: true,
                child: Text(
                  l10n.navProfile,
                  // Zelfde key als de placeholder: de shell-tests lezen de
                  // schermtitel via `placeholder-title`.
                  key: const Key('placeholder-title'),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: t.ink,
                  ),
                ),
              ),
            ),
          ),
          // Een handvol kaarten: gewoon een kolom (alles gebouwd, zodat
          // formulierstaat niet verdwijnt bij wegscrollen).
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final (index, card) in cards.indexed) ...[
                  if (index > 0) const SizedBox(height: 12),
                  card,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _profileCards(
    int teamId,
    TeamMembership membership,
    Profile profile, {
    required bool multiTeam,
  }) {
    final player = profile.player;
    final standing = profile.standingAbsences;
    final sport = SportInfo.of(membership);
    return [
      AccountCard(teamId: teamId, account: profile.user),
      if (player != null && membership.hasFeature('injuries'))
        InjuryCard(
          injured: player.isInjured,
          onChanged: (value) => _setInjured(teamId, injured: value),
        ),
      if (profile.canUseVacations && membership.hasFeature('vacations'))
        VacationsCard(vacations: profile.vacations),
      if (standing != null &&
          standing.choices.isNotEmpty &&
          membership.hasFeature('standing_absences'))
        StandingAbsencesCard(absences: standing),
      const ThemeCard(),
      const NotificationsLinkCard(),
      if (!membership.isSpectator || player != null)
        PlayerProfileCard(
          player: player,
          positionLabel: sport.positionLabel,
          onActivate: () => _activatePlayer(teamId, sport),
          onRemove: () => _removePlayer(teamId),
        ),
      const TeamCard(),
      if (multiTeam) const TeamsCard(),
      const LogoutButton(),
      DeleteAccountCard(
        onDelete: (confirm) => _controller(teamId).deleteAccount(confirm),
      ),
    ];
  }
}
