import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../stats/presentation/widgets/stats_ui.dart';
import '../../data/models/hall_of_fame_models.dart';

/// Tik op een speler (alleen als er een `player_id` is).
typedef OpenPlayer = void Function(int playerId);

/// Een kaart met kop, voor een blok in de Hall of Fame.
class HofCard extends StatelessWidget {
  const HofCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.iconColor,
  });

  final String title;
  final IconData icon;
  final Color? iconColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
            child: Semantics(
              header: true,
              child: Row(
                children: [
                  Icon(icon, size: 16, color: iconColor ?? t.muted),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: t.ink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

/// Een ranglijst (`Podium` in de PWA): plek, avatar, naam en de waarde.
class HofPodium extends StatelessWidget {
  const HofPodium({
    super.key,
    required this.title,
    required this.icon,
    required this.rows,
    required this.valueOf,
    required this.unit,
    required this.onOpenPlayer,
    this.subvalueOf,
  });

  final String title;
  final IconData icon;
  final List<HofLeader> rows;
  final int Function(HofLeader row) valueOf;
  final String? Function(HofLeader row)? subvalueOf;
  final String unit;
  final OpenPlayer onOpenPlayer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return HofCard(
      title: title,
      icon: icon,
      iconColor: StatusColors.amber500,
      child: rows.isEmpty
          ? Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Text(
                l10n.hallOfFameLeaderboardEmpty,
                style: TextStyle(fontSize: 14, color: t.muted),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                children: [
                  for (var i = 0; i < rows.length; i++)
                    _PodiumRow(
                      key: ValueKey('hof-leader-${rows[i].playerId}'),
                      rank: i + 1,
                      row: rows[i],
                      value: valueOf(rows[i]),
                      unit: unit,
                      subvalue: subvalueOf?.call(rows[i]),
                      onTap: () => onOpenPlayer(rows[i].playerId),
                    ),
                ],
              ),
            ),
    );
  }
}

class _PodiumRow extends StatelessWidget {
  const _PodiumRow({
    super.key,
    required this.rank,
    required this.row,
    required this.value,
    required this.unit,
    required this.onTap,
    this.subvalue,
  });

  final int rank;
  final HofLeader row;
  final int value;
  final String unit;
  final String? subvalue;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final medal = podiumMedal(rank);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        child: Row(
          children: [
            SizedBox(
              width: 26,
              child: Text(
                medal ?? '$rank',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: medal != null ? 17 : 13,
                  fontWeight: FontWeight.w700,
                  color: t.muted,
                ),
              ),
            ),
            const SizedBox(width: 8),
            AppAvatar(name: row.name, imageUrl: row.avatarUrl, size: 32),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                row.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: rank == 1 ? FontWeight.w700 : FontWeight.w500,
                  color: t.ink,
                ),
              ),
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$value',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: t.ink,
                    ),
                  ),
                  TextSpan(
                    text: ' $unit',
                    style: TextStyle(fontSize: 12, color: t.muted),
                  ),
                  if (subvalue != null)
                    TextSpan(
                      text: ' $subvalue',
                      style: TextStyle(fontSize: 12, color: t.muted),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Een strook titels (`TitlesStrip`): per titel icoon, naam, houder(s) en
/// de waarde. Een gedeelde titel opent de lijst van houders.
class HofTitlesCard extends StatelessWidget {
  const HofTitlesCard({
    super.key,
    required this.heading,
    required this.icon,
    required this.titles,
    required this.onOpenPlayer,
    this.iconColor,
  });

  final String heading;
  final IconData icon;
  final Color? iconColor;
  final List<HofTitle> titles;
  final OpenPlayer onOpenPlayer;

  Future<void> _showHolders(BuildContext context, HofTitle title) async {
    unawaited(Haptics.light());
    await showAppSheet<void>(
      context: context,
      title: '${title.icon} ${title.label}'.trim(),
      scrollable: true,
      builder: (sheetContext) => Column(
        key: const ValueKey('hof-holders-sheet'),
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final holder in title.holders)
            ListTile(
              key: ValueKey('hof-holder-${holder.playerId}'),
              contentPadding: EdgeInsets.zero,
              leading: AppAvatar(
                name: holder.name,
                imageUrl: holder.avatarUrl,
                size: 32,
              ),
              title: Text(holder.name),
              onTap: holder.playerId == null
                  ? null
                  : () {
                      Navigator.of(sheetContext).pop();
                      onOpenPlayer(holder.playerId!);
                    },
            ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return HofCard(
      title: heading,
      icon: icon,
      iconColor: iconColor,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          children: [
            for (final title in titles)
              _TitleRow(
                key: ValueKey('hof-title-${title.group}-${title.key}'),
                title: title,
                onTap: title.isShared
                    ? () => _showHolders(context, title)
                    : title.holder?.playerId == null
                    ? null
                    : () => onOpenPlayer(title.holder!.playerId!),
              ),
          ],
        ),
      ),
    );
  }
}

class _TitleRow extends StatelessWidget {
  const _TitleRow({super.key, required this.title, this.onTap});

  final HofTitle title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final holder = title.holder;

    final String who;
    final Widget avatar;
    if (title.isShared) {
      who = l10n.hallOfFameShared(title.holders.length);
      avatar = _AvatarStack(people: title.holders);
    } else if (holder != null) {
      who = holder.name;
      avatar = AppAvatar(
        name: holder.name,
        imageUrl: holder.avatarUrl,
        size: 32,
      );
    } else {
      who = l10n.hallOfFameNoHolder;
      avatar = Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(color: t.raised, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Icon(PhosphorIconsDuotone.question, size: 16, color: t.muted),
      );
    }
    final value = [?title.value, ?title.caption].join(' ');

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: Text(
                title.icon,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.label,
                    style: TextStyle(fontSize: 12, color: t.muted),
                  ),
                  Text(
                    who,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: holder == null && !title.isShared
                          ? t.muted
                          : t.ink,
                    ),
                  ),
                ],
              ),
            ),
            if (value.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: t.inkSoft,
                ),
              ),
            ],
            const SizedBox(width: 10),
            avatar,
          ],
        ),
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack({required this.people});

  final List<HofPerson> people;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final shown = people.take(3).toList();
    return SizedBox(
      width: 32 + (shown.length - 1) * 18,
      height: 32,
      child: Stack(
        children: [
          for (var i = 0; i < shown.length; i++)
            Positioned(
              left: i * 18,
              child: AppAvatar(
                name: shown[i].name,
                imageUrl: shown[i].avatarUrl,
                size: 32,
                ring: t.surface,
              ),
            ),
        ],
      ),
    );
  }
}

/// De erelijst: per afgesloten periode de winnaars.
class HofAwardsCard extends StatelessWidget {
  const HofAwardsCard({
    super.key,
    required this.groups,
    required this.onOpenPlayer,
  });

  final List<PeriodAwardGroup> groups;
  final OpenPlayer onOpenPlayer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return HofCard(
      key: const ValueKey('hof-awards'),
      title: l10n.hallOfFameAwards,
      icon: PhosphorIconsDuotone.trophy,
      iconColor: StatusColors.amber500,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final group in groups) ...[
              const SizedBox(height: 8),
              Text(
                group.periodName.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: t.muted,
                ),
              ),
              for (final winner in group.winners)
                InkWell(
                  key: ValueKey(
                    'hof-award-${group.periodId}-${winner.titleKey}',
                  ),
                  onTap: winner.playerId == null
                      ? null
                      : () => onOpenPlayer(winner.playerId!),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Text(winner.icon),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            winner.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: t.ink,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            winner.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 13, color: t.muted),
                          ),
                        ),
                        if (winner.value != null)
                          Text(
                            winner.value!,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: t.muted,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Spelers met badges ("Behaalde prestaties").
class HofBadgesCard extends StatelessWidget {
  const HofBadgesCard({
    super.key,
    required this.players,
    required this.emptyText,
    required this.onOpenPlayer,
  });

  final List<BadgePlayer> players;
  final String emptyText;
  final OpenPlayer onOpenPlayer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return HofCard(
      key: const ValueKey('hof-badges'),
      title: l10n.hallOfFameBadges,
      icon: PhosphorIconsDuotone.sealCheck,
      iconColor: StatusColors.amber500,
      child: players.isEmpty
          ? Padding(
              key: const ValueKey('hof-badges-empty'),
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              child: Text(
                emptyText,
                style: TextStyle(fontSize: 14, color: t.muted),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                children: [
                  for (final player in players)
                    InkWell(
                      key: ValueKey('hof-badge-player-${player.playerId}'),
                      onTap: () => onOpenPlayer(player.playerId),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppAvatar(
                              name: player.name,
                              imageUrl: player.avatarUrl,
                              size: 32,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    player.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: t.ink,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Wrap(
                                    spacing: 4,
                                    runSpacing: 4,
                                    children: [
                                      for (final badge in player.badges)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: StatusColors.amber100
                                                .withValues(alpha: 0.7),
                                            borderRadius: BorderRadius.circular(
                                              AssistjeTokens.radiusFull,
                                            ),
                                          ),
                                          child: Text(
                                            '${badge.icon} ${badge.label}'
                                                .trim(),
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              color: StatusColors.amber900,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

/// Ruimte tussen blokken.
const hofGap = SizedBox(height: 12);

/// De sportterm (of [fallback]) in kleine letters, voor eenheden.
String hofTerm(String? term, String fallback) =>
    (term ?? fallback).toLowerCase();
