import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../event/application/event_detail_controller.dart';
import '../../../team/application/sport_info.dart';
import '../../application/training_teams_controller.dart';
import '../../data/models/training_teams_models.dart';
import 'training_teams_ui.dart';

/// "Teams indelen": hoeveel ploegen en waarop verdeeld. Geeft het gekozen
/// aantal terug als er op "Indelen" getikt is (anders `null`). De basis is een
/// teaminstelling en wordt meteen bewaard.
Future<int?> showTrainingSetupSheet(
  BuildContext context, {
  required EventKey eventKey,
  required int initialCount,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<int>(
    context: context,
    title: l10n.trainingTeamsSetupTitle,
    scrollable: true,
    builder: (context) =>
        _SetupSheet(eventKey: eventKey, initialCount: initialCount),
  );
}

class _SetupSheet extends ConsumerStatefulWidget {
  const _SetupSheet({required this.eventKey, required this.initialCount});

  final EventKey eventKey;
  final int initialCount;

  @override
  ConsumerState<_SetupSheet> createState() => _SetupSheetState();
}

class _SetupSheetState extends ConsumerState<_SetupSheet> {
  late int _count = widget.initialCount;

  Future<void> _setBasis(TrainingBasis basis) async {
    unawaited(Haptics.selection());
    final error = await ref
        .read(trainingTeamsControllerProvider(widget.eventKey).notifier)
        .setBasis(basis);
    if (error != null && mounted) showTrainingTeamsError(context, error);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final data = ref
        .watch(trainingTeamsControllerProvider(widget.eventKey))
        .value;
    if (data == null) return const SizedBox.shrink();
    final present = data.teams.players.length;
    final maxTeams = data.maxTeams < 2 ? 2 : data.maxTeams;
    // Zonder trainingspunten verdeelt "klassement" op trouw komen: weg.
    final bases = [
      for (final b in TrainingBasis.values)
        if (b != TrainingBasis.points || data.teams.tracksPoints) b,
    ];
    final perMin = present ~/ _count;
    final perMax = (present / _count).ceil();

    return Column(
      key: const ValueKey('training-setup-sheet'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.trainingTeamsTeamCount,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: t.inkSoft,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            for (var n = 2; n <= maxTeams; n++) ...[
              if (n > 2) const SizedBox(width: 8),
              Expanded(
                child: _CountButton(
                  key: ValueKey('training-setup-count-$n'),
                  label: '$n',
                  selected: _count == n,
                  onTap: n > present ? null : () => setState(() => _count = n),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 6),
        Text(
          l10n.trainingTeamsPerTeam(present, perMin, perMax),
          key: const ValueKey('training-setup-per-team'),
          style: TextStyle(fontSize: 12, color: t.muted),
        ),
        if (bases.length > 1) ...[
          const SizedBox(height: 20),
          Text(
            l10n.trainingTeamsBasis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: t.inkSoft,
            ),
          ),
          const SizedBox(height: 4),
          for (final basis in bases)
            _BasisTile(
              key: ValueKey('training-basis-${basis.name}'),
              basis: basis,
              selected: data.teams.basis == basis,
              onTap: () => _setBasis(basis),
            ),
        ],
        const SizedBox(height: 20),
        PrimaryButton(
          key: const ValueKey('training-setup-draw'),
          label: l10n.trainingTeamsDoDraw,
          expand: true,
          onPressed: () => Navigator.of(context).pop(_count),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _CountButton extends StatelessWidget {
  const _CountButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Semantics(
      selected: selected,
      button: true,
      child: Opacity(
        opacity: onTap == null ? 0.3 : 1,
        child: Material(
          color: selected ? t.primary : t.sunken,
          borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              height: 44,
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: selected ? t.primaryContrast : t.inkSoft,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BasisTile extends StatelessWidget {
  const _BasisTile({
    super.key,
    required this.basis,
    required this.selected,
    required this.onTap,
  });

  final TrainingBasis basis;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final (label, hint) = basisCopy(l10n, basis);
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Semantics(
        selected: selected,
        button: true,
        child: Material(
          color: selected ? t.sunken : Colors.transparent,
          borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: t.ink,
                          ),
                        ),
                      ),
                      if (selected) ...[
                        const SizedBox(width: 8),
                        const PhosphorIcon(
                          PhosphorIconsBold.check,
                          key: ValueKey('training-basis-check'),
                          size: 15,
                          color: StatusColors.emerald600,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    hint,
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.35,
                      color: t.muted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// De sterktecijfers (1–5), alleen voor wie indeelt. Leeg laten mag: dan
/// rekent de indeling met de historie (grijs ernaast).
Future<void> showTrainingStrengthSheet(
  BuildContext context, {
  required EventKey eventKey,
  required SportInfo sport,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<void>(
    context: context,
    title: l10n.trainingTeamsStrengthsTitle,
    scrollable: true,
    builder: (context) => _StrengthSheet(eventKey: eventKey, sport: sport),
  );
}

class _StrengthSheet extends ConsumerWidget {
  const _StrengthSheet({required this.eventKey, required this.sport});

  final EventKey eventKey;
  final SportInfo sport;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final data = ref.watch(trainingTeamsControllerProvider(eventKey)).value;
    if (data == null) return const SizedBox.shrink();
    final tracksPoints = data.teams.tracksPoints;

    Future<void> set(TrainingTeamPlayer p, int n) async {
      unawaited(Haptics.light());
      final error = await ref
          .read(trainingTeamsControllerProvider(eventKey).notifier)
          .setStrength(p.id, p.strength == n ? null : n);
      if (error != null && context.mounted) {
        showTrainingTeamsError(context, error);
      }
    }

    return Column(
      key: const ValueKey('training-strength-sheet'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          tracksPoints
              ? l10n.trainingTeamsStrengthsHintPoints
              : l10n.trainingTeamsStrengthsHint,
          style: TextStyle(fontSize: 14, color: t.muted),
        ),
        const SizedBox(height: 12),
        for (final p in data.teams.players)
          Padding(
            key: ValueKey('training-strength-${p.id}'),
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: t.ink,
                        ),
                      ),
                      if (_subtitle(l10n, p, tracksPoints) case final sub?)
                        Text(
                          sub,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: t.muted),
                        ),
                    ],
                  ),
                ),
                for (var n = 1; n <= 5; n++) ...[
                  const SizedBox(width: 4),
                  _StrengthButton(
                    key: ValueKey('training-strength-${p.id}-$n'),
                    value: n,
                    selected: p.strength == n,
                    semanticLabel: l10n.trainingTeamsStrengthValue(n, p.name),
                    onTap: () => set(p, n),
                  ),
                ],
              ],
            ),
          ),
        const SizedBox(height: 12),
      ],
    );
  }

  String? _subtitle(
    AppLocalizations l10n,
    TrainingTeamPlayer p,
    bool tracksPoints,
  ) {
    final parts = <String>[
      ?sport.positionLabel(p.position),
      if (tracksPoints && p.strength == null && p.derived != null)
        l10n.trainingTeamsDerived(_formatDerived(p.derived!)),
    ];
    return parts.isEmpty ? null : parts.join(' · ');
  }

  static String _formatDerived(double value) {
    final rounded = (value * 10).round() / 10;
    final text = rounded == rounded.roundToDouble()
        ? rounded.toInt().toString()
        : rounded.toStringAsFixed(1);
    return text.replaceAll('.', ',');
  }
}

class _StrengthButton extends StatelessWidget {
  const _StrengthButton({
    super.key,
    required this.value,
    required this.selected,
    required this.semanticLabel,
    required this.onTap,
  });

  final int value;
  final bool selected;
  final String semanticLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Semantics(
      button: true,
      selected: selected,
      label: semanticLabel,
      excludeSemantics: true,
      child: Material(
        color: selected ? t.primary : t.sunken,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 32,
            height: 32,
            child: Center(
              child: Text(
                '$value',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: selected ? t.primaryContrast : t.muted,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
