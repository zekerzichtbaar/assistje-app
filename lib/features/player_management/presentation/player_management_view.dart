import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/session/models/team_membership.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../event/presentation/widgets/event_section_card.dart';
import '../../team/application/sport_info.dart';
import '../application/player_management_controller.dart';
import '../application/player_sections.dart';
import '../data/csv_file_picker.dart';
import '../data/models/player_management_models.dart';
import 'widgets/add_person_sheet.dart';
import 'widgets/person_tiles.dart';
import 'widgets/player_edit_sheet.dart';
import 'widgets/player_manage_sheet.dart';
import 'widgets/pm_ui.dart';

/// Spelersbeheer voor de trainer (`Trainer/Players/Index.tsx`): de spelers
/// per linie, trainers, gasten en toeschouwers; toevoegen (speler, trainer,
/// toeschouwer), per speler het beheer (bewerken, rol, aanvoerder,
/// bevoegdheden, uitnodigen, verwijderen) en een kaart naar de teamlink.
/// Trekken = verversen.
class PlayerManagementView extends ConsumerStatefulWidget {
  const PlayerManagementView({super.key, required this.title});

  final String title;

  @override
  ConsumerState<PlayerManagementView> createState() =>
      _PlayerManagementViewState();
}

class _PlayerManagementViewState extends ConsumerState<PlayerManagementView> {
  /// Is het scherm al eens in beeld geweest? Onder een spelerpagina
  /// (`/players/7`, bv. via een deeplink) staat het verborgen en hoeft het
  /// overzicht nog niet geladen te worden.
  bool _activated = false;

  AppLocalizations get _l10n => AppLocalizations.of(context);

  PlayerManagementController _controller(int teamId) =>
      ref.read(playerManagementControllerProvider(teamId).notifier);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showPmError(context, _l10n.pmLoadError, error);
    }
  }

  void _openTeamLink() => unawaited(context.push(AppRoutes.teamlink));

  Future<void> _add(int teamId, SportInfo sport) async {
    unawaited(Haptics.light());
    final l10n = _l10n;
    final controller = _controller(teamId);
    var openTeamLink = false;
    final kind = await showAddPersonSheet(
      context,
      positions: sport.positions,
      actions: AddPersonActions(
        createPlayer: controller.createPlayer,
        addTrainer: controller.addTrainer,
        addSpectator: controller.addSpectator,
        openTeamLink: () {
          openTeamLink = true;
          Navigator.of(context, rootNavigator: true).pop();
        },
        pickCsv: ref.read(csvFilePickerProvider).pickCsv,
        importCsv: controller.importPlayers,
      ),
    );
    if (!mounted) return;
    if (openTeamLink) {
      _openTeamLink();
      return;
    }
    final message = switch (kind) {
      AddPersonKind.player => l10n.pmPlayerAdded,
      AddPersonKind.trainer => l10n.pmTrainerAdded,
      AddPersonKind.spectator => l10n.pmSpectatorAdded,
      // De CSV-import toont zijn samenvatting in de sheet zelf.
      AddPersonKind.csv || null => null,
    };
    if (message != null) showPmSuccess(context, message);
  }

  Future<void> _openPlayer(
    TeamMembership membership,
    ManagedPlayer player,
    SportInfo sport, {
    required bool readOnly,
  }) async {
    unawaited(Haptics.light());
    final teamId = membership.team.id;
    final l10n = _l10n;
    final result = await showPlayerManageSheet(
      context,
      teamId: teamId,
      playerId: player.id,
      readOnly: readOnly,
      features: membership.features,
      positionLabel: sport.positionLabel(player.position) ?? '',
    );
    if (!mounted || result == null) return;
    switch (result) {
      case PlayerManageResult.profile:
        unawaited(context.push(AppRoutes.player(player.id)));
      case PlayerManageResult.deleted:
        showPmSuccess(context, l10n.pmPlayerDeleted);
      case PlayerManageResult.edit:
        final latest =
            ref
                .read(playerManagementControllerProvider(teamId))
                .value
                ?.player(player.id) ??
            player;
        final saved = await showPlayerEditSheet(
          context,
          player: latest,
          positions: sport.positions,
          onSave: (update) =>
              _controller(teamId).updatePlayer(player.id, update),
        );
        if ((saved ?? false) && mounted) showPmSuccess(context, l10n.pmSaved);
    }
  }

  Future<void> _removeTrainer(int teamId, ManagedTrainer trainer) async {
    final l10n = _l10n;
    if (!await confirmPm(
      context,
      message: l10n.pmRemoveTrainerConfirm(trainer.name),
      confirmLabel: l10n.pmRemove,
      destructive: true,
    )) {
      return;
    }
    final error = await _controller(teamId).removeTrainer(trainer.id);
    if (!mounted) return;
    if (error != null) {
      showPmError(context, l10n.pmActionFailed, error);
    } else {
      showPmSuccess(context, l10n.pmTrainerRemoved);
    }
  }

  Future<void> _removeSpectator(int teamId, ManagedSpectator spectator) async {
    final l10n = _l10n;
    if (!await confirmPm(
      context,
      message: l10n.pmRemoveSpectatorConfirm(spectator.name),
      confirmLabel: l10n.pmRemove,
      destructive: true,
    )) {
      return;
    }
    final error = await _controller(teamId).removeSpectator(spectator.id);
    if (!mounted) return;
    if (error != null) {
      showPmError(context, l10n.pmActionFailed, error);
    } else {
      showPmSuccess(context, l10n.pmSpectatorRemoved);
    }
  }

  Future<void> _resendSpectator(int teamId, ManagedSpectator spectator) async {
    final l10n = _l10n;
    final error = await _controller(teamId).resendSpectatorInvite(spectator.id);
    if (!mounted) return;
    if (error != null) {
      showPmError(context, l10n.pmActionFailed, error);
    } else {
      showPmSuccess(context, l10n.pmInviteResent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final t = AssistjeTokens.of(context);
    _activated = _activated || TickerMode.valuesOf(context).enabled;
    final async = _activated
        ? ref.watch(playerManagementControllerProvider(teamId))
        : const AsyncLoading<PlayerManagementState>();
    final state = async.value;
    final sport = SportInfo.of(membership);
    final readOnly =
        membership.team.isDemo || (state?.writesForbidden ?? false);

    final List<Widget> content;
    if (state != null) {
      content = _content(membership, state, sport, readOnly: readOnly);
    } else if (async.hasError) {
      content = [SliverToBoxAdapter(child: _errorState(teamId, async.error))];
    } else {
      content = const [
        SliverToBoxAdapter(
          child: Column(
            key: ValueKey('pm-loading'),
            children: [
              Skeleton(height: 72, radius: AssistjeTokens.radius2xl),
              SizedBox(height: 12),
              SkeletonList(count: 6),
            ],
          ),
        ),
      ];
    }

    return Scaffold(
      key: const ValueKey('players-screen'),
      backgroundColor: t.sunken,
      body: AppRefresh(
        onRefresh: () => _refresh(teamId),
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
              child: Row(
                children: [
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(
                        widget.title,
                        // Zelfde key als de placeholder: de shell-tests
                        // lezen de schermtitel via `placeholder-title`.
                        key: const Key('placeholder-title'),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: t.ink,
                        ),
                      ),
                    ),
                  ),
                  if (state != null && !readOnly)
                    PrimaryButton(
                      key: const ValueKey('pm-add'),
                      label: _l10n.pmAdd,
                      icon: const PhosphorIcon(
                        PhosphorIconsBold.plus,
                        size: 16,
                      ),
                      onPressed: () => _add(teamId, sport),
                    ),
                ],
              ),
            ),
          ),
          ...content,
        ],
      ),
    );
  }

  Widget _errorState(int teamId, Object? error) {
    final l10n = _l10n;
    return switch (error) {
      ForbiddenException() => EmptyState(
        key: const ValueKey('pm-forbidden'),
        icon: PhosphorIconsDuotone.lockSimple,
        title: l10n.pmForbiddenTitle,
        description: l10n.pmForbidden,
      ),
      _ => EmptyState(
        key: const ValueKey('pm-error'),
        icon: PhosphorIconsDuotone.warningCircle,
        title: l10n.pmLoadError,
        description: pmErrorText(l10n, error),
        action: PrimaryButton(
          key: const ValueKey('pm-retry'),
          label: l10n.retry,
          onPressed: () => _refresh(teamId),
        ),
      ),
    };
  }

  List<Widget> _content(
    TeamMembership membership,
    PlayerManagementState state,
    SportInfo sport, {
    required bool readOnly,
  }) {
    final l10n = _l10n;
    final t = AssistjeTokens.of(context);
    final teamId = membership.team.id;
    final data = state.data;
    final sections = PlayerSections.of(data, sport);
    final isEmpty = data.players.isEmpty && data.spectators.isEmpty;

    Widget playerTile(ManagedPlayer player) => ManagedPlayerTile(
      player: player,
      positionLabel: sport.positionLabel(player.position) ?? '',
      onTap: () => _openPlayer(membership, player, sport, readOnly: readOnly),
    );

    Widget rows(List<Widget> tiles) => Column(
      children: [
        for (var i = 0; i < tiles.length; i++) ...[
          if (i > 0) Divider(height: 1, color: t.lineSoft),
          tiles[i],
        ],
      ],
    );

    Widget count(int n) =>
        CountPill(label: '$n', background: t.raised, foreground: t.muted);

    final children = <Widget>[
      if (readOnly)
        PmNotice(
          key: const ValueKey('pm-read-only'),
          icon: PhosphorIconsDuotone.eye,
          text: membership.team.isDemo
              ? l10n.pmReadOnlyDemo
              : l10n.pmReadOnlyForbidden,
        ),
      if (isEmpty)
        EmptyState(
          key: const ValueKey('pm-empty'),
          icon: PhosphorIconsDuotone.users,
          title: l10n.pmEmptyTitle,
          description: l10n.pmEmptyDescription,
          action: readOnly
              ? null
              : PrimaryButton(
                  key: const ValueKey('pm-empty-invite'),
                  label: l10n.pmEmptyAction,
                  onPressed: _openTeamLink,
                ),
        ),
      _TeamLinkCard(
        link: data.teamLink,
        state: data.teamLinkState,
        onTap: _openTeamLink,
      ),
      if (sections.hasTrainers)
        EventSectionCard(
          key: const ValueKey('pm-section-trainers'),
          title: l10n.pmSectionTrainers,
          child: rows([
            for (final p in sections.trainerPlayers) playerTile(p),
            for (final trainer in sections.coaches)
              ManagedTrainerTile(
                trainer: trainer,
                onRemove: readOnly || trainer.isSelf
                    ? null
                    : () => _removeTrainer(teamId, trainer),
              ),
          ]),
        ),
      for (final section in sections.sections)
        EventSectionCard(
          key: ValueKey('pm-section-${section.key}'),
          title:
              section.label ??
              (section.key == 'guests'
                  ? l10n.pmSectionGuests
                  : l10n.pmSectionOther),
          trailing: count(section.players.length),
          child: rows([for (final p in section.players) playerTile(p)]),
        ),
      if (data.spectators.isNotEmpty)
        EventSectionCard(
          key: const ValueKey('pm-section-spectators'),
          title: l10n.pmSectionSpectators,
          trailing: count(data.spectators.length),
          child: rows([
            for (final spectator in data.spectators)
              ManagedSpectatorTile(
                spectator: spectator,
                onResend: readOnly
                    ? null
                    : () => _resendSpectator(teamId, spectator),
                onRemove: readOnly
                    ? null
                    : () => _removeSpectator(teamId, spectator),
              ),
          ]),
        ),
    ];

    return [
      SliverList.separated(
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      ),
    ];
  }
}

/// De kaart naar `/teamlink`, met de stand van de link.
class _TeamLinkCard extends StatelessWidget {
  const _TeamLinkCard({
    required this.link,
    required this.state,
    required this.onTap,
  });

  final TeamLink? link;
  final TeamLinkState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final text = link != null
        ? l10n.pmTeamlinkCardActive
        : state == TeamLinkState.revoked
        ? l10n.pmTeamlinkCardRevoked
        : l10n.pmTeamlinkCardExpired;
    return AppCard(
      key: const ValueKey('pm-teamlink-card'),
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: t.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: PhosphorIcon(
              link != null
                  ? PhosphorIconsDuotone.linkSimple
                  : PhosphorIconsDuotone.linkBreak,
              size: 22,
              color: t.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.pmTeamlinkCardTitle,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: t.ink,
                  ),
                ),
                Text(text, style: TextStyle(fontSize: 13, color: t.muted)),
              ],
            ),
          ),
          PhosphorIcon(PhosphorIconsBold.caretRight, size: 16, color: t.muted),
        ],
      ),
    );
  }
}
