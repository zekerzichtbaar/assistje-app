import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../team/application/sport_info.dart';
import '../../../team/presentation/widgets/roster_ui.dart';
import '../../data/models/player_detail_models.dart';

/// Welke statistieken in beeld zijn.
enum StatsScope { season, career }

/// Persoonlijke statistieken met een wissel seizoen/carrière: wedstrijden
/// en uitslagen, de stat-rijen van de sport en de aanwezigheid.
class PlayerStatsSection extends StatefulWidget {
  const PlayerStatsSection({
    super.key,
    required this.stats,
    required this.sport,
    this.showTrainingPoints = false,
  });

  final PersonalStatsSet stats;
  final SportInfo sport;

  /// Feature `training_points` aan?
  final bool showTrainingPoints;

  @override
  State<PlayerStatsSection> createState() => _PlayerStatsSectionState();
}

class _PlayerStatsSectionState extends State<PlayerStatsSection> {
  StatsScope _scope = StatsScope.season;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final data = _scope == StatsScope.season
        ? widget.stats.season
        : widget.stats.career;
    return Column(
      key: const ValueKey('player-stats'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppTabPills<StatsScope>(
          key: const ValueKey('player-stats-scope'),
          fullWidth: true,
          tabs: [
            AppTabPill(
              value: StatsScope.season,
              label: l10n.playerDetailSeason,
            ),
            AppTabPill(
              value: StatsScope.career,
              label: l10n.playerDetailCareer,
            ),
          ],
          selected: _scope,
          onChanged: (scope) {
            unawaited(Haptics.selection());
            setState(() => _scope = scope);
          },
        ),
        const SizedBox(height: 12),
        _ResultsCard(data: data),
        const SizedBox(height: 12),
        _StatRows(
          data: data,
          sport: widget.sport,
          showTrainingPoints: widget.showTrainingPoints,
        ),
        const SizedBox(height: 12),
        _AttendanceCard(data: data),
      ],
    );
  }
}

/// De bal van de sport (`field_variant`), waar het over scoren gaat.
IconData _scoreIcon(SportInfo sport) => switch (sport.fieldVariant) {
  'hockey' => PhosphorIconsDuotone.hockey,
  'volleyball' => PhosphorIconsDuotone.volleyball,
  'korfball' => PhosphorIconsDuotone.basketball,
  _ => PhosphorIconsDuotone.soccerBall,
};

String _number(num value) => NumberFormat('#,##0.#', 'nl').format(value);

/// Wedstrijden + gewonnen/gelijk/verloren.
class _ResultsCard extends StatelessWidget {
  const _ResultsCard({required this.data});

  final PersonalStats data;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final l10n = AppLocalizations.of(context);
    Widget cell(String key, String value, String label, Color color) =>
        Expanded(
          child: Column(
            children: [
              Text(
                value,
                key: ValueKey(key),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  fontFeatures: const [FontFeature.tabularFigures()],
                  color: color,
                ),
              ),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: t.muted),
              ),
            ],
          ),
        );
    return AppCard(
      key: const ValueKey('player-results'),
      child: Column(
        children: [
          Row(
            children: [
              cell(
                'stat-matches',
                '${data.matchesPlayed}',
                l10n.playerDetailMatchesPlayed,
                t.ink,
              ),
              cell(
                'stat-wins',
                '${data.wins}',
                l10n.playerDetailWins,
                StatusColors.emerald600,
              ),
              cell(
                'stat-draws',
                '${data.draws}',
                l10n.playerDetailDraws,
                t.muted,
              ),
              cell(
                'stat-losses',
                '${data.losses}',
                l10n.playerDetailLosses,
                StatusColors.red600,
              ),
            ],
          ),
          if (data.matchesPlayed > 0) ...[
            const SizedBox(height: 8),
            Text(
              l10n.playerDetailWinPct(_number(data.winPct)),
              key: const ValueKey('stat-win-pct'),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: t.inkSoft,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// De stat-lijst: scorers (als de sport ze bijhoudt), punten/aces/blocks
/// (sporten die ná afloop registreren), MOTM, trainingspunten en kaarten.
class _StatRows extends StatelessWidget {
  const _StatRows({
    required this.data,
    required this.sport,
    required this.showTrainingPoints,
  });

  final PersonalStats data;
  final SportInfo sport;
  final bool showTrainingPoints;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cards = sport.cardTypes;
    // Bekende kaartsoorten van de sport bepalen de rijen; weet de app ze
    // niet, dan alleen kaarten die echt gegeven zijn.
    bool hasCard(String value, int count) =>
        cards == null ? count > 0 : cards.contains(value);
    final points = data.points;
    final trainingPoints = data.trainingPoints;

    final rows = <Widget>[
      if (sport.tracksScorers) ...[
        _StatRow(
          statKey: 'goals',
          icon: _scoreIcon(sport),
          label: sport.term('goals') ?? l10n.playerDetailGoals,
          value: data.goals,
        ),
        _StatRow(
          statKey: 'assists',
          icon: PhosphorIconsDuotone.target,
          label: sport.term('assists') ?? l10n.playerDetailAssists,
          value: data.assists,
        ),
        _StatRow(
          statKey: 'clean-sheets',
          icon: PhosphorIconsDuotone.shieldCheck,
          label: l10n.playerDetailCleanSheets,
          value: data.cleanSheets,
        ),
      ],
      if (points != null) ...[
        _StatRow(
          statKey: 'points',
          icon: _scoreIcon(sport),
          label: l10n.playerDetailPoints,
          value: points,
        ),
        _StatRow(
          statKey: 'aces',
          icon: PhosphorIconsDuotone.target,
          label: l10n.playerDetailAces,
          value: data.aces ?? 0,
        ),
        _StatRow(
          statKey: 'blocks',
          icon: PhosphorIconsDuotone.shieldCheck,
          label: l10n.playerDetailBlocks,
          value: data.blocks ?? 0,
        ),
      ],
      _StatRow(
        statKey: 'motm',
        icon: PhosphorIconsDuotone.medal,
        label: l10n.playerDetailMotm,
        value: data.motm,
      ),
      if (showTrainingPoints && trainingPoints != null)
        _StatRow(
          statKey: 'training-points',
          icon: PhosphorIconsDuotone.trophy,
          label: l10n.playerDetailTrainingPoints,
          value: trainingPoints,
        ),
      if (hasCard('green', data.green))
        _StatRow(
          statKey: 'green',
          cardColor: StatusColors.emerald500,
          label: l10n.playerDetailGreenCards,
          value: data.green,
        ),
      if (hasCard('yellow', data.yellow))
        _StatRow(
          statKey: 'yellow',
          cardColor: StatusColors.amber500,
          label: l10n.playerDetailYellowCards,
          value: data.yellow,
        ),
      if (hasCard('red', data.red))
        _StatRow(
          statKey: 'red',
          cardColor: StatusColors.red500,
          label: l10n.playerDetailRedCards,
          value: data.red,
        ),
    ];
    final t = AssistjeTokens.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) Divider(height: 1, thickness: 1, color: t.lineSoft),
            rows[i],
          ],
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({
    required this.statKey,
    required this.label,
    required this.value,
    this.icon,
    this.cardColor,
  });

  final String statKey;
  final IconData? icon;
  final String label;
  final int value;

  /// Een kaart-rij: een gekleurd kaartje in plaats van een icoon.
  final Color? cardColor;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            width: 18,
            child: cardColor == null
                ? Icon(icon, size: 18, color: t.primary)
                : Center(
                    child: Container(
                      width: 11,
                      height: 15,
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: TextStyle(color: t.ink)),
          ),
          Text(
            '$value',
            key: ValueKey('stat-$statKey'),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFeatures: const [FontFeature.tabularFigures()],
              color: t.ink,
            ),
          ),
        ],
      ),
    );
  }
}

/// Aanwezigheid bij wedstrijden en trainingen, als ring.
class _AttendanceCard extends StatelessWidget {
  const _AttendanceCard({required this.data});

  final PersonalStats data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return RosterSectionCard(
      key: const ValueKey('player-attendance'),
      title: l10n.playerDetailAttendanceTitle,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _Ring(
                statKey: 'attendance-match',
                pct: data.attendanceMatchRate,
                label: l10n.playerDetailAttendanceMatches,
              ),
              _Ring(
                statKey: 'attendance-training',
                pct: data.attendanceTrainingRate,
                label: l10n.playerDetailAttendanceTraining,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Ring extends StatelessWidget {
  const _Ring({required this.statKey, required this.pct, required this.label});

  final String statKey;
  final double pct;
  final String label;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final rounded = pct.clamp(0, 100).round();
    return Column(
      children: [
        SizedBox(
          width: 76,
          height: 76,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: rounded / 100,
                strokeWidth: 7,
                strokeCap: StrokeCap.round,
                color: t.primary,
                backgroundColor: t.track,
              ),
              Center(
                child: Text(
                  '$rounded%',
                  key: ValueKey('stat-$statKey'),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: t.ink,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(fontSize: 12, color: t.muted)),
      ],
    );
  }
}
