import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/sport_stats_profile.dart';
import '../../data/models/stats_models.dart';
import 'stats_ui.dart';

/// Een speler in de statistieken (`PlayerCard` in `TeamStats.tsx`): kop met
/// avatar, rugnummer, positie, titels en kaarten; aanwezigheidsbalken; en
/// alleen de tegels die de sport vult. Bij een gekozen sortering staat de
/// waarde daarvan rechts, met een medaille voor de top 3.
class StatsPlayerCard extends StatelessWidget {
  const StatsPlayerCard({
    super.key,
    required this.row,
    required this.profile,
    required this.sort,
    required this.rank,
    required this.isMe,
    required this.onTap,
  });

  final StatsRow row;
  final SportStatsProfile profile;
  final StatsSort sort;

  /// Plek in de huidige sortering (1-based).
  final int rank;
  final bool isMe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final ranked = sort != StatsSort.overview && sort != StatsSort.name;
    final medal = ranked ? podiumMedal(rank) : null;

    final tiles = <(String, String, String)>[
      if (profile.tracksScorers) ...[
        ('goals', '${row.goals}', profile.goalsTerm ?? l10n.statsSortGoals),
        (
          'assists',
          '${row.assists}',
          profile.assistsTerm ?? l10n.statsSortAssists,
        ),
      ],
      if (profile.tracksPlayingTime)
        ('minutes', '${row.minutes}', l10n.statsTileMinutes(row.matchesPlayed))
      else
        ('matches', '${row.matchesPlayed}', l10n.statsTileMatches),
      if (profile.supportsFlagDuty)
        (
          'flag',
          '${row.flagMinutes}',
          row.flagShifts > 0
              ? l10n.statsTileFlagShifts(row.flagShifts)
              : l10n.statsTileFlag,
        ),
    ];

    return AppCard(
      key: ValueKey('stats-row-${row.playerId}'),
      onTap: onTap,
      color: isMe
          ? Color.alphaBlend(t.primary.withValues(alpha: 0.08), t.surface)
          : null,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              AppAvatar(
                name: row.name,
                imageUrl: row.avatarUrl,
                ring: isMe ? t.primary : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Header(row: row, isMe: isMe, medal: medal),
              ),
              _Cards(row: row, profile: profile),
              if (ranked) ...[
                const SizedBox(width: 8),
                Text(
                  _metricText(l10n, row, sort),
                  key: ValueKey('stats-metric-${row.playerId}'),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: t.ink,
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _AttendanceBar(
                  icon: PhosphorIconsDuotone.trophy,
                  label: l10n.statsAttendanceMatch,
                  pct: row.attendanceMatchRate,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _AttendanceBar(
                  icon: PhosphorIconsDuotone.strategy,
                  label: l10n.statsAttendanceTraining,
                  pct: row.attendanceTrainingRate,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var i = 0; i < tiles.length; i++) ...[
                if (i > 0) Container(width: 1, height: 32, color: t.lineSoft),
                Expanded(
                  child: _KpiTile(
                    key: ValueKey('stats-tile-${tiles[i].$1}-${row.playerId}'),
                    value: tiles[i].$2,
                    label: tiles[i].$3,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  static String _metricText(
    AppLocalizations l10n,
    StatsRow row,
    StatsSort sort,
  ) {
    final value = statsMetric(row, sort) ?? 0;
    return switch (sort) {
      StatsSort.attendanceMatch ||
      StatsSort.attendanceTraining ||
      StatsSort.overview => l10n.statsValuePercent(value.round()),
      StatsSort.minutes ||
      StatsSort.flagMinutes => l10n.statsValueMinutes(value.round()),
      _ => '${value.round()}',
    };
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.row, required this.isMe, this.medal});

  final StatsRow row;
  final bool isMe;
  final String? medal;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final chip = BoxDecoration(
      color: t.raised,
      borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (medal != null) ...[
              Text(medal!, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 4),
            ],
            Flexible(
              child: Text(
                row.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: t.ink,
                ),
              ),
            ),
            if (row.shirtNumber != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                decoration: chip,
                child: Text(
                  '${row.shirtNumber}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: t.inkSoft,
                  ),
                ),
              ),
            ],
            if (isMe) ...[
              const SizedBox(width: 6),
              Container(
                key: const ValueKey('stats-me-badge'),
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                decoration: BoxDecoration(
                  color: t.primary,
                  borderRadius: BorderRadius.circular(
                    AssistjeTokens.radiusFull,
                  ),
                ),
                child: Text(
                  l10n.statsMe,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: t.primaryContrast,
                  ),
                ),
              ),
            ],
          ],
        ),
        if ((row.position ?? '').isNotEmpty || row.titles.isNotEmpty) ...[
          const SizedBox(height: 3),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if ((row.position ?? '').isNotEmpty)
                Text(
                  row.position!,
                  style: TextStyle(fontSize: 12, color: t.muted),
                ),
              for (final title in row.titles)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 1,
                  ),
                  decoration: chip,
                  child: Text(
                    '${title.icon} ${title.label}'.trim(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: t.inkSoft,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

/// Gele/rode kaarten, alleen als de sport ze kent en er een is.
class _Cards extends StatelessWidget {
  const _Cards({required this.row, required this.profile});

  final StatsRow row;
  final SportStatsProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    Widget card(Color color, int count, String label, Key key) => Semantics(
      label: label,
      excludeSemantics: true,
      child: Row(
        key: key,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 3),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: t.inkSoft,
            ),
          ),
        ],
      ),
    );

    final yellow = profile.showsYellow && row.yellow > 0;
    final red = profile.showsRed && row.red > 0;
    if (!yellow && !red) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (yellow)
            card(
              StatusColors.amber400,
              row.yellow,
              l10n.statsYellowCards(row.yellow),
              ValueKey('stats-yellow-${row.playerId}'),
            ),
          if (yellow && red) const SizedBox(width: 8),
          if (red)
            card(
              StatusColors.red500,
              row.red,
              l10n.statsRedCards(row.red),
              ValueKey('stats-red-${row.playerId}'),
            ),
        ],
      ),
    );
  }
}

class _AttendanceBar extends StatelessWidget {
  const _AttendanceBar({
    required this.icon,
    required this.label,
    required this.pct,
  });

  final IconData icon;
  final String label;
  final double pct;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final clamped = pct.clamp(0, 100) / 100;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: t.muted),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, color: t.muted),
              ),
            ),
            Text(
              l10n.statsValuePercent(pct.round()),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: t.inkSoft,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
          child: LinearProgressIndicator(
            value: clamped.toDouble(),
            minHeight: 6,
            backgroundColor: t.track,
            color: t.primary,
          ),
        ),
      ],
    );
  }
}

class _KpiTile extends StatelessWidget {
  const _KpiTile({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: t.ink,
          ),
        ),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 11, color: t.muted),
        ),
      ],
    );
  }
}
