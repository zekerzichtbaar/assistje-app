import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/agenda_items.dart';
import '../../data/models/agenda_models.dart';
import 'duty_icons.dart';

/// Een dienst als eigen rij (`BigDutyRow` in de PWA).
class DutyCard extends StatelessWidget {
  const DutyCard({super.key, required this.duty, this.onTap, this.now});

  final AgendaDuty duty;
  final VoidCallback? onTap;
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final d = duty;
    final players = d.playerNames;
    final group = d.groupName;
    final showGroup = group != null && group != players.join(', ');

    return AppCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateTile(date: parseDay(d.date), now: now),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
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
                            PhosphorIcon(
                              dutyIconFor(d.icon, d.dutyType),
                              size: 14,
                              color: t.inkSoft,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                (d.title.isEmpty
                                        ? l10n.agendaDutyFallback
                                        : d.title)
                                    .toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.4,
                                  color: t.inkSoft,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (showGroup) ...[
                      Text(
                        group,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: t.ink,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (d.mine)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: t.primary,
                          borderRadius: BorderRadius.circular(
                            AssistjeTokens.radiusFull,
                          ),
                        ),
                        child: Text(
                          l10n.agendaDutyYou,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: t.primaryContrast,
                          ),
                        ),
                      ),
                  ],
                ),
                if (d.startsAt != null || d.endsAt != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      [
                        if (d.startsAt != null)
                          l10n.agendaDutyStart(d.startsAt!),
                        if (d.endsAt != null) l10n.agendaDutyEnd(d.endsAt!),
                      ].join('  |  '),
                      style: TextStyle(fontSize: 14, color: t.inkSoft),
                    ),
                  ),
                if (players.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      players.map((n) => n.split(' ').first).join(', '),
                      style: TextStyle(fontSize: 14, color: t.muted),
                    ),
                  ),
                if (d.notes != null && d.notes!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      d.notes!,
                      style: TextStyle(fontSize: 14, color: t.muted),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
