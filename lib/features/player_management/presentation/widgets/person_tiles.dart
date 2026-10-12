import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/player_management_models.dart';
import 'pm_ui.dart';

/// Een klein label naast de naam (gast, admin, jij, …).
class PmBadge extends StatelessWidget {
  const PmBadge({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: foreground,
      ),
    ),
  );
}

/// Het meldingen-icoon rechts (`PushStatusIcon`); niets zonder account.
class PushStatusIcon extends StatelessWidget {
  const PushStatusIcon({super.key, required this.status});

  final PushStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final (IconData? icon, Color color, String label) = switch (status) {
      PushStatus.push => (
        PhosphorIconsFill.bell,
        StatusColors.emerald500,
        l10n.pmPushOn,
      ),
      PushStatus.installed => (
        PhosphorIconsFill.deviceMobile,
        StatusColors.amber500,
        l10n.pmPushInstalled,
      ),
      PushStatus.none => (PhosphorIconsBold.circle, t.muted, l10n.pmPushNone),
      PushStatus.na || PushStatus.unknown => (null, t.muted, ''),
    };
    if (icon == null) return const SizedBox.shrink();
    return Semantics(
      label: label,
      child: Tooltip(
        message: label,
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }
}

Widget _name(BuildContext context, String name, List<Widget> badges) {
  final t = AssistjeTokens.of(context);
  return Row(
    children: [
      Flexible(
        child: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: t.ink,
          ),
        ),
      ),
      for (final badge in badges) ...[const SizedBox(width: 6), badge],
    ],
  );
}

/// Eén speler in het beheeroverzicht (`PlayerItem`): rugnummer, avatar met
/// uitnodigingsstip, naam met badges, positie en het meldingen-icoon.
/// Tikken opent het beheer van die speler.
class ManagedPlayerTile extends StatelessWidget {
  const ManagedPlayerTile({
    super.key,
    required this.player,
    required this.positionLabel,
    required this.onTap,
  });

  final ManagedPlayer player;
  final String positionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final badges = <Widget>[
      if (player.isInjured)
        PmBadge(
          label: l10n.pmBadgeInjured,
          background: dark ? const Color(0x33EF4444) : StatusColors.red100,
          foreground: dark ? StatusColors.red400 : StatusColors.red700,
        )
      else if (player.isOnVacation)
        PmBadge(
          label: l10n.pmBadgeVacation,
          background: dark ? const Color(0x330EA5E9) : StatusColors.sky100,
          foreground: dark ? const Color(0xFF7DD3FC) : const Color(0xFF075985),
        ),
      if (player.isCaptain)
        PmBadge(
          key: ValueKey('pm-captain-${player.id}'),
          label: l10n.pmBadgeCaptain,
          background: t.primary.withValues(alpha: 0.15),
          foreground: t.ink,
        ),
      if (player.isTrainer)
        PmBadge(
          key: ValueKey('pm-admin-${player.id}'),
          label: l10n.pmBadgeAdmin,
          background: t.raised,
          foreground: t.inkSoft,
        ),
      if (player.isGuest)
        PmBadge(
          label: l10n.pmBadgeGuest,
          background: dark ? const Color(0x33F59E0B) : StatusColors.amber100,
          foreground: dark ? StatusColors.amber200 : StatusColors.amber900,
        ),
    ];
    return Semantics(
      button: true,
      child: InkWell(
        key: ValueKey('pm-player-${player.id}'),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: 22,
                child: Text(
                  player.shirtNumber?.toString() ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: t.muted,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Semantics(
                label: inviteStatusLabel(l10n, player.inviteStatus),
                child: AppAvatar(
                  name: player.name,
                  imageUrl: player.avatarUrl,
                  statusColor: inviteStatusColor(t, player.inviteStatus),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _name(context, player.name, badges),
                    if (positionLabel.isNotEmpty)
                      Text(
                        positionLabel,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: t.muted),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              PushStatusIcon(status: player.pushStatus),
              const SizedBox(width: 6),
              PhosphorIcon(
                PhosphorIconsBold.caretRight,
                size: 16,
                color: t.muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Een trainer zonder spelersprofiel, met prullenbak (niet bij jezelf).
class ManagedTrainerTile extends StatelessWidget {
  const ManagedTrainerTile({super.key, required this.trainer, this.onRemove});

  final ManagedTrainer trainer;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      key: ValueKey('pm-trainer-${trainer.id}'),
      padding: const EdgeInsets.fromLTRB(16, 10, 4, 10),
      child: Row(
        children: [
          const SizedBox(width: 32),
          AppAvatar(name: trainer.name, imageUrl: trainer.avatarUrl),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _name(context, trainer.name, [
                  if (trainer.isSelf)
                    PmBadge(
                      label: l10n.pmBadgeSelf,
                      background: dark
                          ? const Color(0x3310B981)
                          : StatusColors.emerald100,
                      foreground: dark
                          ? const Color(0xFF6EE7B7)
                          : const Color(0xFF065F46),
                    ),
                ]),
                if ((trainer.email ?? '').isNotEmpty)
                  Text(
                    trainer.email!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: t.muted),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          PushStatusIcon(status: trainer.pushStatus),
          if (onRemove != null)
            IconButton(
              key: ValueKey('pm-trainer-remove-${trainer.id}'),
              tooltip: l10n.pmRemoveTrainerLabel(trainer.name),
              onPressed: onRemove,
              icon: PhosphorIcon(
                PhosphorIconsBold.trash,
                size: 16,
                color: t.muted,
              ),
            )
          else
            const SizedBox(width: 12),
        ],
      ),
    );
  }
}

/// Een toeschouwer: opnieuw uitnodigen (zolang open) en weghalen.
class ManagedSpectatorTile extends StatelessWidget {
  const ManagedSpectatorTile({
    super.key,
    required this.spectator,
    this.onResend,
    this.onRemove,
  });

  final ManagedSpectator spectator;
  final VoidCallback? onResend;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final pending = spectator.inviteStatus == InviteStatus.pending;
    return Padding(
      key: ValueKey('pm-spectator-${spectator.id}'),
      padding: const EdgeInsets.fromLTRB(16, 10, 4, 10),
      child: Row(
        children: [
          const SizedBox(width: 32),
          Semantics(
            label: inviteStatusLabel(l10n, spectator.inviteStatus),
            child: AppAvatar(
              name: spectator.name,
              imageUrl: spectator.avatarUrl,
              statusColor: inviteStatusColor(t, spectator.inviteStatus),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _name(context, spectator.name, const []),
                Text(
                  pending ? l10n.pmInvitePending : (spectator.email ?? ''),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: t.muted),
                ),
              ],
            ),
          ),
          if (pending && onResend != null)
            IconButton(
              key: ValueKey('pm-spectator-resend-${spectator.id}'),
              tooltip: l10n.pmResendSpectatorLabel(spectator.name),
              onPressed: onResend,
              icon: PhosphorIcon(
                PhosphorIconsBold.bell,
                size: 16,
                color: t.muted,
              ),
            ),
          if (onRemove != null)
            IconButton(
              key: ValueKey('pm-spectator-remove-${spectator.id}'),
              tooltip: l10n.pmRemoveSpectatorLabel(spectator.name),
              onPressed: onRemove,
              icon: PhosphorIcon(
                PhosphorIconsBold.trash,
                size: 16,
                color: t.muted,
              ),
            )
          else
            const SizedBox(width: 12),
        ],
      ),
    );
  }
}
