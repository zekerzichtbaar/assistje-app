import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../team/presentation/widgets/roster_ui.dart';
import '../../data/models/player_detail_models.dart';

/// `9 okt 2026`.
String playerDate(DateTime date) => DateFormat('d MMM y', 'nl').format(date);

/// Volledige weekdagnaam voor [weekday] (0 = zondag … 6 = zaterdag).
String weekdayName(int weekday) =>
    // 1 januari 2023 was een zondag.
    DateFormat('EEEE', 'nl').format(DateTime(2023, 1, 1 + weekday % 7));

/// Beheervelden voor de trainer (`can_manage`): e-mail en accountstatus.
/// Alleen-lezen; bewerken kan voorlopig in de webapp.
class PlayerManageCard extends StatelessWidget {
  const PlayerManageCard({super.key, required this.player});

  final PlayerProfile player;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final invitedAt = player.invitedAt;
    final String account;
    if (player.inviteAccepted && player.hasAccount) {
      account = l10n.playerDetailInviteAccepted;
    } else if (invitedAt != null) {
      account = l10n.playerDetailInvitePending(playerDate(invitedAt.toLocal()));
    } else {
      account = l10n.playerDetailNotInvited;
    }
    final email = player.email;
    return RosterSectionCard(
      key: const ValueKey('player-manage'),
      title: l10n.playerDetailManageTitle,
      icon: PhosphorIconsDuotone.userGear,
      children: [
        _InfoRow(
          label: l10n.playerDetailEmail,
          value: email == null || email.isEmpty
              ? l10n.playerDetailNoEmail
              : email,
          valueKey: 'player-email',
        ),
        if (!player.isGuest)
          _InfoRow(
            label: l10n.playerDetailInvite,
            value: account,
            valueKey: 'player-invite',
          ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          child: Text(
            l10n.playerDetailReadOnlyHint,
            style: TextStyle(fontSize: 12, color: t.muted),
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.valueKey,
  });

  final String label;
  final String value;
  final String valueKey;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: t.muted)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              key: ValueKey(valueKey),
              textAlign: TextAlign.end,
              style: TextStyle(fontWeight: FontWeight.w500, color: t.ink),
            ),
          ),
        ],
      ),
    );
  }
}

/// Lopende en komende vakanties (alleen-lezen).
class PlayerVacationsCard extends StatelessWidget {
  const PlayerVacationsCard({super.key, required this.vacations});

  final List<PlayerVacation> vacations;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return RosterSectionCard(
      key: const ValueKey('player-vacations'),
      title: l10n.playerDetailVacationsTitle,
      icon: PhosphorIconsDuotone.island,
      iconColor: StatusColors.vacation,
      children: [
        if (vacations.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              l10n.playerDetailNoVacations,
              style: TextStyle(fontSize: 12, color: t.muted),
            ),
          )
        else
          for (final v in vacations)
            Padding(
              key: ValueKey('player-vacation-${v.id}'),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Text(
                    l10n.playerDetailVacationRange(
                      playerDate(v.startsOn),
                      playerDate(v.endsOn),
                    ),
                    style: TextStyle(fontWeight: FontWeight.w500, color: t.ink),
                  ),
                  if (v.note != null && v.note!.isNotEmpty) ...[
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        v.note!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: t.muted),
                      ),
                    ),
                  ],
                ],
              ),
            ),
      ],
    );
  }
}

/// Vaste afwezige weekdagen: de trainingsdagen als pillen, de afwezige
/// gemarkeerd. Alleen-lezen.
class PlayerStandingAbsencesCard extends StatelessWidget {
  const PlayerStandingAbsencesCard({
    super.key,
    required this.name,
    required this.absences,
  });

  final String name;
  final StandingAbsences absences;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return RosterSectionCard(
      key: const ValueKey('player-standing-absences'),
      title: l10n.playerDetailStandingAbsencesTitle,
      icon: PhosphorIconsDuotone.calendarX,
      iconColor: t.primary,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.playerDetailStandingAbsencesHint(name),
                style: TextStyle(fontSize: 12, color: t.muted),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final weekday in absences.choices)
                    AppPill(
                      key: ValueKey('player-absence-day-$weekday'),
                      label: weekdayName(weekday),
                      selected: absences.isAbsentOn(weekday),
                      selectedColor: StatusColors.red600,
                      selectedForeground: Colors.white,
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Badges (emoji + label, en hoe vaak).
class PlayerAchievementsCard extends StatelessWidget {
  const PlayerAchievementsCard({super.key, required this.achievements});

  final List<Achievement> achievements;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return RosterSectionCard(
      key: const ValueKey('player-achievements'),
      title: l10n.playerDetailAchievementsTitle,
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final a in achievements)
                Tooltip(
                  message: a.detail ?? a.label,
                  child: Container(
                    key: ValueKey('player-achievement-${a.key}'),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: t.raised,
                      borderRadius: BorderRadius.circular(
                        AssistjeTokens.radiusFull,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (a.icon.isNotEmpty) ...[
                          Text(a.icon, style: const TextStyle(fontSize: 14)),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          a.label,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: t.ink,
                          ),
                        ),
                        if (a.count > 1) ...[
                          const SizedBox(width: 6),
                          Text(
                            l10n.playerDetailTimes(a.count),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: t.muted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Hoe vaak de speler elke dienst deed.
class PlayerDutiesCard extends StatelessWidget {
  const PlayerDutiesCard({super.key, required this.duties});

  final List<DutyCount> duties;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return RosterSectionCard(
      key: const ValueKey('player-duties'),
      title: l10n.playerDetailDutiesTitle,
      children: [
        for (final d in duties)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(d.name, style: TextStyle(color: t.ink)),
                ),
                Text(
                  l10n.playerDetailTimes(d.count),
                  key: ValueKey('player-duty-${d.slug}'),
                  style: TextStyle(fontWeight: FontWeight.w700, color: t.ink),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// Laadweergave van het detail.
class PlayerDetailSkeleton extends StatelessWidget {
  const PlayerDetailSkeleton({super.key});

  @override
  Widget build(BuildContext context) => const Column(
    key: ValueKey('player-loading'),
    children: [
      AppCard(
        child: Row(
          children: [
            Skeleton.circle(size: 64),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton(height: 22, width: 160),
                  SizedBox(height: 8),
                  Skeleton(height: 14, width: 100),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 12),
      Skeleton(height: 36, radius: AssistjeTokens.radiusFull),
      SizedBox(height: 12),
      Skeleton(height: 96, radius: AssistjeTokens.radius2xl),
      SizedBox(height: 12),
      AppCard(padding: EdgeInsets.all(12), child: SkeletonList(count: 4)),
    ],
  );
}
