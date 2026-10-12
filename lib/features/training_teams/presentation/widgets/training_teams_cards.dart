import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/training_teams_models.dart';
import 'training_teams_ui.dart';

/// Nog geen indeling: uitleg plus "Teams indelen" en "Sterktes".
class TrainingDrawPrompt extends StatelessWidget {
  const TrainingDrawPrompt({
    super.key,
    required this.data,
    required this.onDraw,
    required this.onStrengths,
  });

  final TrainingTeams data;
  final VoidCallback? onDraw;
  final VoidCallback? onStrengths;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final present = data.teams.players.length;
    final mayAssign = data.teams.mayAssign;
    return AppCard(
      key: const ValueKey('training-draw-prompt'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
      child: Column(
        children: [
          PhosphorIcon(PhosphorIconsDuotone.shuffle, size: 32, color: t.muted),
          const SizedBox(height: 12),
          Text(
            !mayAssign
                ? l10n.trainingTeamsNotDrawnYet
                : present < 2
                ? l10n.trainingTeamsTooFew
                : l10n.trainingTeamsReadyToDraw(present),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: t.muted),
          ),
          if (mayAssign && present > 0) ...[
            const SizedBox(height: 16),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                if (present >= 2)
                  PrimaryButton(
                    key: const ValueKey('training-open-setup'),
                    label: l10n.trainingTeamsDraw,
                    icon: const PhosphorIcon(
                      PhosphorIconsBold.shuffle,
                      size: 16,
                    ),
                    onPressed: onDraw,
                  ),
                SoftButton(
                  key: const ValueKey('training-open-strengths'),
                  label: l10n.trainingTeamsStrengths,
                  icon: PhosphorIconsBold.slidersHorizontal,
                  onPressed: onStrengths,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// De indeling: ploegen in een raster, de bank eronder en de acties.
/// Tik-om-te-ruilen zoals de PWA: eerste tik licht iemand op, tweede tik
/// wijst aan met wie hij ruilt; een kop (of de bank) verplaatst hem zonder
/// tegenpartij.
class TrainingBoardCard extends StatelessWidget {
  const TrainingBoardCard({
    super.key,
    required this.data,
    required this.picked,
    required this.busy,
    required this.onTapPlayer,
    required this.onMoveTo,
    required this.onRedraw,
    required this.onStrengths,
    required this.onSetup,
    required this.onCopy,
    required this.onClear,
  });

  final TrainingTeams data;
  final int? picked;
  final bool busy;
  final ValueChanged<TrainingTeamPlayer> onTapPlayer;
  final ValueChanged<String?> onMoveTo;
  final VoidCallback onRedraw;
  final VoidCallback onStrengths;
  final VoidCallback onSetup;
  final VoidCallback onCopy;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final mayAssign = data.teams.mayAssign;
    final sides = data.usedSides;
    final bench = data.teams.bench;
    final canTap = mayAssign && !busy;

    Widget header({
      required Key key,
      required Color dot,
      required String label,
      required int count,
      required String? target,
    }) {
      final active = canTap && picked != null;
      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: key,
          onTap: active ? () => onMoveTo(target) : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    label.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: t.muted,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    fontFeatures: const [FontFeature.tabularFigures()],
                    color: t.muted,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget chip(TrainingTeamPlayer p, {required bool onBench}) {
      final selected = picked == p.id;
      return Semantics(
        button: true,
        selected: selected,
        child: Material(
          color: selected
              ? t.primary
              : (onBench ? t.raised : Colors.transparent),
          borderRadius: BorderRadius.circular(8),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            key: ValueKey('training-player-${p.id}'),
            onTap: canTap ? () => onTapPlayer(p) : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Text(
                p.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected
                      ? t.primaryContrast
                      : (onBench ? t.inkSoft : t.ink),
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget column(String side) {
      final style = SideStyle.of(data.sideNumber(side));
      final members = data.teams.playersOf(side);
      return Container(
        key: ValueKey('training-side-$side'),
        color: t.surface,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            header(
              key: ValueKey('training-side-header-$side'),
              dot: style.dot,
              label: sideLabel(l10n, data, side),
              count: members.length,
              target: side,
            ),
            const SizedBox(height: 6),
            for (final p in members) chip(p, onBench: false),
          ],
        ),
      );
    }

    // Twee kolommen naast elkaar, net als `grid-cols-2` in de PWA.
    final rows = <Widget>[];
    for (var i = 0; i < sides.length; i += 2) {
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: column(sides[i])),
              const SizedBox(width: 1),
              Expanded(
                child: i + 1 < sides.length
                    ? column(sides[i + 1])
                    : ColoredBox(color: t.surface),
              ),
            ],
          ),
        ),
      );
    }

    return TrainingCard(
      key: const ValueKey('training-board'),
      title: l10n.trainingTeamsLineup,
      icon: PhosphorIconsDuotone.shuffle,
      children: [
        if (mayAssign)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Text(
              picked == null
                  ? l10n.trainingTeamsPickHint
                  : l10n.trainingTeamsPickedHint,
              key: const ValueKey('training-pick-hint'),
              style: TextStyle(fontSize: 12, color: t.muted),
            ),
          ),
        ColoredBox(
          color: t.sunken,
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              children: [
                for (var i = 0; i < rows.length; i++) ...[
                  if (i > 0) const SizedBox(height: 1),
                  rows[i],
                ],
              ],
            ),
          ),
        ),
        Divider(height: 1, color: t.lineSoft),
        Padding(
          key: const ValueKey('training-bench'),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              header(
                key: const ValueKey('training-bench-header'),
                dot: t.line,
                label: l10n.trainingTeamsBench,
                count: bench.length,
                target: null,
              ),
              const SizedBox(height: 6),
              if (bench.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    picked == null
                        ? l10n.trainingTeamsBenchEmpty
                        : l10n.trainingTeamsBenchTarget,
                    style: TextStyle(fontSize: 12, color: t.muted),
                  ),
                )
              else
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [for (final p in bench) chip(p, onBench: true)],
                ),
            ],
          ),
        ),
        Divider(height: 1, color: t.lineSoft),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (mayAssign) ...[
                SoftButton(
                  key: const ValueKey('training-redraw'),
                  label: l10n.trainingTeamsRedraw,
                  icon: PhosphorIconsBold.arrowsClockwise,
                  onPressed: busy ? null : onRedraw,
                ),
                SoftButton(
                  key: const ValueKey('training-open-strengths'),
                  label: l10n.trainingTeamsStrengths,
                  icon: PhosphorIconsBold.slidersHorizontal,
                  onPressed: onStrengths,
                ),
                SoftButton(
                  key: const ValueKey('training-open-setup'),
                  label: l10n.trainingTeamsSetup,
                  icon: PhosphorIconsBold.scales,
                  onPressed: busy ? null : onSetup,
                ),
              ],
              SoftButton(
                key: const ValueKey('training-copy'),
                label: l10n.trainingTeamsCopy,
                icon: PhosphorIconsBold.copy,
                background: StatusColors.emerald500,
                foreground: Colors.white,
                onPressed: onCopy,
              ),
              if (mayAssign)
                TextButton(
                  key: const ValueKey('training-clear'),
                  onPressed: busy ? null : onClear,
                  style: TextButton.styleFrom(foregroundColor: t.muted),
                  child: Text(l10n.trainingTeamsClear),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// De uitslag per ploeg: snelknoppen ("Team 1 won", "Gelijkspel") en een
/// stepper per ploeg.
class TrainingResultCard extends StatelessWidget {
  const TrainingResultCard({
    super.key,
    required this.data,
    required this.onQuick,
    required this.onBump,
  });

  final TrainingTeams data;

  /// `null` = gelijkspel.
  final ValueChanged<String?> onQuick;
  final void Function(String side, int delta) onBump;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final sides = data.usedSides;
    final scores = data.teams.scores;
    final anyScored = sides.any(scores.containsKey);
    final dark = Theme.of(context).brightness == Brightness.dark;

    return TrainingCard(
      key: const ValueKey('training-result'),
      title: l10n.trainingTeamsResult,
      icon: PhosphorIconsDuotone.trophy,
      iconColor: StatusColors.amber500,
      titleTrailing: anyScored
          ? Text(
              '· ${l10n.trainingTeamsResultSaved}',
              key: const ValueKey('training-result-saved'),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: dark ? StatusColors.emerald400 : StatusColors.emerald600,
              ),
            )
          : null,
      children: [
        Divider(height: 1, color: t.lineSoft),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final side in sides)
                SoftButton(
                  key: ValueKey('training-won-$side'),
                  label: l10n.trainingTeamsWon(sideLabel(l10n, data, side)),
                  background: SideStyle.of(
                    data.sideNumber(side),
                  ).softOn(context),
                  foreground: SideStyle.of(
                    data.sideNumber(side),
                  ).textOn(context),
                  onPressed: () => onQuick(side),
                ),
              SoftButton(
                key: const ValueKey('training-won-draw'),
                label: l10n.trainingTeamsDrawResult,
                onPressed: () => onQuick(null),
              ),
            ],
          ),
        ),
        Divider(height: 1, color: t.lineSoft),
        for (final side in sides) ...[
          Padding(
            key: ValueKey('training-score-$side'),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: SideStyle.of(data.sideNumber(side)).dot,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    sideLabel(l10n, data, side),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: t.ink,
                    ),
                  ),
                ),
                StepButton(
                  key: ValueKey('training-score-$side-down'),
                  icon: PhosphorIconsBold.minus,
                  semanticLabel: l10n.trainingTeamsPointDown(
                    sideLabel(l10n, data, side),
                  ),
                  onPressed: (scores[side] ?? 0) == 0
                      ? null
                      : () => onBump(side, -1),
                ),
                SizedBox(
                  width: 32,
                  child: Text(
                    '${scores[side] ?? '–'}',
                    key: ValueKey('training-score-$side-value'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: t.ink,
                    ),
                  ),
                ),
                StepButton(
                  key: ValueKey('training-score-$side-up'),
                  icon: PhosphorIconsBold.plus,
                  semanticLabel: l10n.trainingTeamsPointUp(
                    sideLabel(l10n, data, side),
                  ),
                  onPressed: (scores[side] ?? 0) >= maxTeamPoints
                      ? null
                      : () => onBump(side, 1),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: t.lineSoft),
        ],
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          child: Text(
            l10n.trainingTeamsResultHint,
            style: TextStyle(fontSize: 12, color: t.muted),
          ),
        ),
      ],
    );
  }
}

/// De puntenlijst: iedereen gelijk, punten per speler bijstellen, uit de
/// punten halen, en wie niet meetelt terugzetten.
class TrainingScoringCard extends StatelessWidget {
  const TrainingScoringCard({
    super.key,
    required this.data,
    required this.busy,
    required this.onDrawPoints,
    required this.onBumpPlayer,
    required this.onExclude,
    required this.onInclude,
  });

  final TrainingTeams data;
  final bool busy;
  final VoidCallback onDrawPoints;
  final void Function(ScoringRow row, int delta) onBumpPlayer;
  final ValueChanged<ScoringRow> onExclude;
  final ValueChanged<ScoringOption> onInclude;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final scoring = data.scoring;
    final available = data.scoringAvailable;

    return TrainingCard(
      key: const ValueKey('training-scoring'),
      title: l10n.trainingTeamsPoints,
      icon: PhosphorIconsDuotone.chartBar,
      children: [
        if (scoring.isNotEmpty) ...[
          Divider(height: 1, color: t.lineSoft),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SoftButton(
                key: const ValueKey('training-draw-points'),
                label: l10n.trainingTeamsEveryoneDraw,
                icon: PhosphorIconsDuotone.handshake,
                onPressed: busy ? null : onDrawPoints,
              ),
            ),
          ),
        ],
        Divider(height: 1, color: t.lineSoft),
        if (scoring.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Text(
              l10n.trainingTeamsNobodyPresent,
              key: const ValueKey('training-scoring-empty'),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: t.muted),
            ),
          )
        else
          for (var i = 0; i < scoring.length; i++) ...[
            if (i > 0) Divider(height: 1, color: t.lineSoft),
            _ScoringTile(
              key: ValueKey('training-scoring-${scoring[i].id}'),
              row: scoring[i],
              busy: busy,
              onBump: (delta) => onBumpPlayer(scoring[i], delta),
              onExclude: () => onExclude(scoring[i]),
            ),
          ],
        if (available.isNotEmpty) ...[
          Divider(height: 1, color: t.lineSoft),
          Padding(
            key: const ValueKey('training-not-counted'),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.trainingTeamsNotCounted.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: t.muted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.trainingTeamsNotCountedHint,
                  style: TextStyle(fontSize: 12, color: t.muted),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: [
                    for (final option in available)
                      Material(
                        color: t.raised,
                        borderRadius: BorderRadius.circular(8),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          key: ValueKey('training-include-${option.id}'),
                          onTap: busy ? null : () => onInclude(option),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            child: Text(
                              option.name,
                              style: TextStyle(fontSize: 14, color: t.inkSoft),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _ScoringTile extends StatelessWidget {
  const _ScoringTile({
    super.key,
    required this.row,
    required this.busy,
    required this.onBump,
    required this.onExclude,
  });

  final ScoringRow row;
  final bool busy;
  final ValueChanged<int> onBump;
  final VoidCallback onExclude;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final scored = row.scored ?? 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          AppAvatar(name: row.name, imageUrl: row.avatarUrl, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: t.ink,
                  ),
                ),
                Text(
                  row.scored == null
                      ? l10n.trainingTeamsNoResultYet
                      : l10n.trainingTeamsScored(row.scored!),
                  style: TextStyle(fontSize: 11, color: t.muted),
                ),
              ],
            ),
          ),
          StepButton(
            key: ValueKey('training-scoring-${row.id}-down'),
            icon: PhosphorIconsBold.minus,
            semanticLabel: l10n.trainingTeamsPointDown(row.name),
            onPressed: busy || scored == 0 ? null : () => onBump(-1),
          ),
          SizedBox(
            width: 44,
            child: Text(
              l10n.trainingTeamsPointsShort(row.points),
              key: ValueKey('training-scoring-${row.id}-points'),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: t.ink,
              ),
            ),
          ),
          StepButton(
            key: ValueKey('training-scoring-${row.id}-up'),
            icon: PhosphorIconsBold.plus,
            semanticLabel: l10n.trainingTeamsPointUp(row.name),
            onPressed: busy || scored >= maxTeamPoints ? null : () => onBump(1),
          ),
          const SizedBox(width: 4),
          IconButton(
            key: ValueKey('training-exclude-${row.id}'),
            tooltip: l10n.trainingTeamsExclude(row.name),
            onPressed: busy ? null : onExclude,
            icon: PhosphorIcon(
              PhosphorIconsDuotone.trash,
              size: 18,
              color: t.muted,
            ),
          ),
        ],
      ),
    );
  }
}
