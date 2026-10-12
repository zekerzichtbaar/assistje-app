import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/roster_models.dart';
import 'roster_ui.dart';

/// Eén speler in de selectie: rugnummer, avatar, naam + markers, positie.
/// Tik = spelerdetail.
class RosterPlayerTile extends StatelessWidget {
  const RosterPlayerTile({
    super.key,
    required this.player,
    required this.positionLabel,
    required this.onTap,
  });

  final RosterPlayer player;

  /// De volledige positienaam uit de sport, of `null`.
  final String? positionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final l10n = AppLocalizations.of(context);
    final p = player;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        key: ValueKey('roster-player-${p.id}'),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: 22,
                child: Text(
                  p.shirtNumber?.toString() ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFeatures: const [FontFeature.tabularFigures()],
                    color: t.muted,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              AppAvatar(name: p.name, imageUrl: p.avatarUrl),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            p.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: t.ink,
                            ),
                          ),
                        ),
                        if (p.isInjured) ...[
                          const SizedBox(width: 6),
                          RosterBadge(
                            key: ValueKey('roster-injured-${p.id}'),
                            label: l10n.rosterInjuredBadge,
                            tone: AttendanceTone.injury,
                          ),
                        ] else if (p.isOnVacation) ...[
                          const SizedBox(width: 6),
                          RosterBadge(
                            key: ValueKey('roster-vacation-${p.id}'),
                            label: l10n.rosterVacationBadge,
                            tone: AttendanceTone.vacation,
                          ),
                        ],
                        if (p.isGuest) ...[
                          const SizedBox(width: 6),
                          RosterBadge.amber(label: l10n.rosterGuestBadge),
                        ],
                      ],
                    ),
                    if (positionLabel != null)
                      Text(
                        positionLabel!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: t.muted),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(PhosphorIconsBold.caretRight, size: 16, color: t.muted),
            ],
          ),
        ),
      ),
    );
  }
}

/// Een trainer zonder spelersprofiel (niet aantikbaar: geen player-id).
class RosterCoachTile extends StatelessWidget {
  const RosterCoachTile({super.key, required this.coach});

  final RosterCoach coach;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final l10n = AppLocalizations.of(context);
    return Padding(
      key: ValueKey('roster-coach-${coach.id}'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const SizedBox(width: 32),
          AppAvatar(name: coach.name, imageUrl: coach.avatarUrl),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        coach.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: t.ink,
                        ),
                      ),
                    ),
                    if (coach.isOnVacation) ...[
                      const SizedBox(width: 6),
                      RosterBadge(
                        label: l10n.rosterVacationBadge,
                        tone: AttendanceTone.vacation,
                      ),
                    ],
                  ],
                ),
                Text(
                  l10n.rosterCoachRole,
                  style: TextStyle(fontSize: 12, color: t.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Laadweergave: twee kaarten met rijen.
class RosterSkeleton extends StatelessWidget {
  const RosterSkeleton({super.key});

  @override
  Widget build(BuildContext context) => const Column(
    key: ValueKey('roster-loading'),
    children: [
      AppCard(padding: EdgeInsets.all(12), child: SkeletonList(count: 2)),
      SizedBox(height: 14),
      AppCard(padding: EdgeInsets.all(12), child: SkeletonList()),
    ],
  );
}
