import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/player_management_controller.dart';
import '../../data/models/player_management_models.dart';
import 'pm_ui.dart';

/// Wat de trainer in het beheer van één speler koos dat buiten de sheet
/// verder gaat.
enum PlayerManageResult { profile, edit, deleted }

/// Het beheer van één speler (het trainersdeel van `Trainer/PlayerDetail`):
/// spelerpagina, bewerken, verwijderen, vaste aanvoerder,
/// beheerders-rechten, losse bevoegdheden en de uitnodiging. De sheet volgt
/// de controller, dus schakelaars zie je meteen omgaan.
Future<PlayerManageResult?> showPlayerManageSheet(
  BuildContext context, {
  required int teamId,
  required int playerId,
  required bool readOnly,
  required Map<String, bool> features,
  required String positionLabel,
}) => showAppSheet<PlayerManageResult>(
  context: context,
  scrollable: true,
  builder: (context) => _PlayerManagePanel(
    teamId: teamId,
    playerId: playerId,
    readOnly: readOnly,
    features: features,
    positionLabel: positionLabel,
  ),
);

class _PlayerManagePanel extends ConsumerStatefulWidget {
  const _PlayerManagePanel({
    required this.teamId,
    required this.playerId,
    required this.readOnly,
    required this.features,
    required this.positionLabel,
  });

  final int teamId;
  final int playerId;
  final bool readOnly;
  final Map<String, bool> features;
  final String positionLabel;

  @override
  ConsumerState<_PlayerManagePanel> createState() => _PlayerManagePanelState();
}

class _PlayerManagePanelState extends ConsumerState<_PlayerManagePanel> {
  final _email = TextEditingController();
  bool _busy = false;
  String? _emailError;

  PlayerManagementController get _controller =>
      ref.read(playerManagementControllerProvider(widget.teamId).notifier);

  AppLocalizations get _l10n => AppLocalizations.of(context);

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _run(
    Future<Object?> Function() action, {
    String? success,
    String? failure,
  }) async {
    if (_busy) return;
    final l10n = _l10n;
    setState(() => _busy = true);
    final error = await action();
    if (!mounted) return;
    setState(() => _busy = false);
    if (error != null) {
      showPmError(context, failure ?? l10n.pmActionFailed, error);
    } else if (success != null) {
      showPmSuccess(context, success);
    } else {
      unawaited(Haptics.light());
    }
  }

  Future<void> _captain(ManagedPlayer player, bool value) =>
      _run(() => _controller.setCaptain(player.id, captain: value));

  Future<void> _trainer(ManagedPlayer player, bool value) async {
    final l10n = _l10n;
    final ok = await confirmPm(
      context,
      message: value
          ? l10n.pmTrainerGrantConfirm(player.name)
          : l10n.pmTrainerRevokeConfirm(player.name),
      destructive: !value,
    );
    if (!ok || !mounted) return;
    await _run(() => _controller.setTrainer(player.id, isTrainer: value));
  }

  Future<void> _ability(
    ManagedPlayer player,
    String ability,
    bool value,
  ) async {
    final l10n = _l10n;
    final label = abilityLabel(l10n, ability);
    final ok = await confirmPm(
      context,
      message: value
          ? l10n.pmAbilityGrantConfirm(player.name, label.toLowerCase())
          : l10n.pmAbilityRevokeConfirm(player.name, label),
      destructive: !value,
    );
    if (!ok || !mounted) return;
    await _run(
      () => _controller.setAbility(player.id, ability: ability, granted: value),
    );
  }

  Future<void> _invite(ManagedPlayer player) async {
    final l10n = _l10n;
    final email = _email.text.trim();
    if (!looksLikeEmail(email)) {
      setState(
        () => _emailError = email.isEmpty
            ? l10n.pmEmailRequired
            : l10n.pmEmailInvalid,
      );
      return;
    }
    setState(() => _emailError = null);
    if (_busy) return;
    setState(() => _busy = true);
    final error = await _controller.invitePlayer(player.id, email);
    if (!mounted) return;
    setState(() => _busy = false);
    if (error == null) {
      _email.clear();
      showPmSuccess(context, l10n.pmInviteSent);
      return;
    }
    final field = pmFieldError(error, 'email');
    if (field != null) {
      setState(() => _emailError = field);
    } else {
      showPmError(context, l10n.pmActionFailed, error);
    }
  }

  Future<void> _delete(ManagedPlayer player) async {
    final l10n = _l10n;
    final ok = await confirmPm(
      context,
      title: l10n.pmDeleteTitle(player.name),
      message: l10n.pmDeleteMessage,
      confirmLabel: l10n.pmDelete,
      destructive: true,
    );
    if (!ok || !mounted) return;
    setState(() => _busy = true);
    final error = await _controller.deletePlayer(player.id);
    if (!mounted) return;
    setState(() => _busy = false);
    if (error != null) {
      showPmError(context, l10n.pmActionFailed, error);
      return;
    }
    Navigator.of(context).pop(PlayerManageResult.deleted);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = _l10n;
    final t = AssistjeTokens.of(context);
    final state = ref
        .watch(playerManagementControllerProvider(widget.teamId))
        .value;
    final player = state?.player(widget.playerId);
    if (player == null) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: SkeletonList(count: 3),
      );
    }
    final readOnly = widget.readOnly || (state?.writesForbidden ?? false);
    final selfId = [
      for (final trainer in state!.data.trainers)
        if (trainer.isSelf) trainer.id,
    ].firstOrNull;
    final isSelf = selfId != null && player.userId == selfId;
    final enabled = !readOnly && !_busy;
    final abilities = [
      for (final ability in PlayerAbility.all)
        if (abilityFeature(ability) case final feature
            when feature == null || widget.features[feature] != false)
          ability,
    ];

    return Column(
      key: ValueKey('pm-manage-${player.id}'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            AppAvatar(name: player.name, imageUrl: player.avatarUrl, size: 56),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: t.ink,
                    ),
                  ),
                  Text(
                    [
                      if (player.shirtNumber != null) '#${player.shirtNumber}',
                      if (widget.positionLabel.isNotEmpty) widget.positionLabel,
                      inviteStatusLabel(l10n, player.inviteStatus),
                    ].join(' · '),
                    style: TextStyle(fontSize: 13, color: t.muted),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            SecondaryButton(
              key: const ValueKey('pm-manage-profile'),
              label: l10n.pmViewProfile,
              icon: const PhosphorIcon(PhosphorIconsDuotone.user, size: 16),
              onPressed: () =>
                  Navigator.of(context).pop(PlayerManageResult.profile),
            ),
            if (!readOnly) ...[
              SecondaryButton(
                key: const ValueKey('pm-manage-edit'),
                label: l10n.pmEdit,
                icon: const PhosphorIcon(
                  PhosphorIconsDuotone.notePencil,
                  size: 16,
                ),
                onPressed: _busy
                    ? null
                    : () => Navigator.of(context).pop(PlayerManageResult.edit),
              ),
              SecondaryButton(
                key: const ValueKey('pm-manage-delete'),
                label: l10n.pmDelete,
                icon: const PhosphorIcon(
                  PhosphorIconsDuotone.trash,
                  size: 16,
                  color: StatusColors.red600,
                ),
                onPressed: _busy ? null : () => _delete(player),
              ),
            ],
          ],
        ),
        if (!readOnly) ..._inviteSection(player, l10n, t),
        if (!player.isGuest) ...[
          const SizedBox(height: 16),
          PmToggleRow(
            key: const ValueKey('pm-toggle-captain'),
            title: l10n.pmCaptain,
            subtitle: l10n.pmCaptainHint,
            value: player.isCaptain,
            onChanged: enabled ? (v) => _captain(player, v) : null,
          ),
          const SizedBox(height: 10),
          if (!player.hasAccount)
            PmNotice(
              key: const ValueKey('pm-trainer-no-account'),
              text: l10n.pmTrainerRoleNoAccount,
            )
          else
            PmToggleRow(
              key: const ValueKey('pm-toggle-trainer'),
              title: l10n.pmTrainerRole,
              subtitle: l10n.pmTrainerRoleHint,
              value: player.isTrainer,
              onChanged: enabled && !(isSelf && player.isTrainer)
                  ? (v) => _trainer(player, v)
                  : null,
            ),
          if (player.hasAccount &&
              !player.isTrainer &&
              abilities.isNotEmpty) ...[
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.only(left: 4, bottom: 6),
              child: Text(
                l10n.pmAbilitiesHeader.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                  color: t.muted,
                ),
              ),
            ),
            for (final ability in abilities) ...[
              PmToggleRow(
                key: ValueKey('pm-toggle-ability-$ability'),
                title: abilityLabel(l10n, ability),
                subtitle: abilityHint(l10n, ability),
                value: player.hasAbility(ability),
                onChanged: enabled ? (v) => _ability(player, ability, v) : null,
              ),
              const SizedBox(height: 8),
            ],
          ],
        ],
      ],
    );
  }

  List<Widget> _inviteSection(
    ManagedPlayer player,
    AppLocalizations l10n,
    AssistjeTokens t,
  ) {
    switch (player.inviteStatus) {
      case InviteStatus.accepted:
      case InviteStatus.unknown:
        return const [];
      case InviteStatus.pending:
        final dark = Theme.of(context).brightness == Brightness.dark;
        return [
          const SizedBox(height: 16),
          Container(
            key: const ValueKey('pm-invite-pending'),
            padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
            decoration: BoxDecoration(
              color: dark ? const Color(0x26F59E0B) : StatusColors.amber50,
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
            ),
            child: Row(
              children: [
                PhosphorIcon(
                  PhosphorIconsDuotone.envelopeSimple,
                  size: 20,
                  color: dark ? StatusColors.amber400 : StatusColors.amber700,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.pmInvitePendingTitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: dark
                              ? StatusColors.amber200
                              : StatusColors.amber900,
                        ),
                      ),
                      if ((player.email ?? '').isNotEmpty)
                        Text(
                          l10n.pmInvitePendingTo(player.email!),
                          style: TextStyle(fontSize: 12, color: t.muted),
                        ),
                    ],
                  ),
                ),
                TextButton(
                  key: const ValueKey('pm-invite-resend'),
                  onPressed: _busy
                      ? null
                      : () => _run(
                          () => _controller.resendPlayerInvite(player.id),
                          success: l10n.pmInviteResent,
                        ),
                  child: Text(l10n.pmInviteResend),
                ),
              ],
            ),
          ),
        ];
      case InviteStatus.none:
        return [
          const SizedBox(height: 16),
          Container(
            key: const ValueKey('pm-invite-form'),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: t.raised,
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.pmInviteTitle,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: t.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.pmInviteHint(player.name),
                  style: TextStyle(fontSize: 12, color: t.inkSoft),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        key: const ValueKey('pm-invite-email'),
                        controller: _email,
                        enabled: !_busy,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: l10n.pmFieldEmail,
                          errorText: _emailError,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    PrimaryButton(
                      key: const ValueKey('pm-invite-send'),
                      label: l10n.pmInviteSend,
                      loading: _busy,
                      onPressed: _busy ? null : () => _invite(player),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ];
    }
  }
}
