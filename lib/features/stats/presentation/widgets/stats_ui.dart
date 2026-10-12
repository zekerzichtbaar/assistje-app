import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/stats_models.dart';

/// Gedeelde stukjes voor de Statistieken- en Ranking-tab.

/// De tekst bij een mislukte aanroep. `404` betekent hier: de feature
/// `stats` staat uit voor dit team.
String statsErrorText(AppLocalizations l10n, Object? error) => switch (error) {
  NetworkException() => l10n.errorNetwork,
  NotFoundException() => l10n.statsDisabled,
  final ApiException e when e.message != null => e.message!,
  _ => l10n.errorGeneric,
};

/// Toont een fouttoast (met trilling).
void showStatsError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  unawaited(Haptics.error());
  showAppToast(
    context,
    title: title,
    message: statsErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// De schermtitel. Draagt `Key('placeholder-title')` in elke staat: de
/// shell-tests lezen de schermtitel daarmee.
class StatsScreenTitle extends StatelessWidget {
  const StatsScreenTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
      child: Semantics(
        header: true,
        child: Text(
          text,
          key: const Key('placeholder-title'),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: t.ink,
          ),
        ),
      ),
    );
  }
}

/// Een kop boven een blok.
class StatsSectionTitle extends StatelessWidget {
  const StatsSectionTitle(this.text, {super.key, this.icon, this.iconColor});

  final String text;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
      child: Semantics(
        header: true,
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: iconColor ?? t.muted),
              const SizedBox(width: 6),
            ],
            Expanded(
              child: Text(
                text.toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: t.muted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Laadstaat: een paar grijze kaarten.
class StatsLoading extends StatelessWidget {
  const StatsLoading({super.key});

  @override
  Widget build(BuildContext context) => const Column(
    children: [
      Skeleton(height: 40, radius: AssistjeTokens.radiusFull),
      SizedBox(height: 12),
      SkeletonList(),
    ],
  );
}

/// Foutstaat met "Opnieuw proberen".
class StatsErrorState extends StatelessWidget {
  const StatsErrorState({
    super.key,
    required this.title,
    required this.error,
    required this.onRetry,
    this.retryKey,
  });

  final String title;
  final Object? error;
  final VoidCallback onRetry;
  final Key? retryKey;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return EmptyState(
      icon: error is NotFoundException
          ? PhosphorIconsDuotone.chartBar
          : PhosphorIconsDuotone.warningCircle,
      title: title,
      description: statsErrorText(l10n, error),
      action: PrimaryButton(
        key: retryKey,
        label: l10n.retry,
        onPressed: onRetry,
      ),
    );
  }
}

/// Knop met het gekozen seizoen; opent een sheet om te wisselen. Alleen
/// tonen als er meer dan één seizoen is.
class SeasonPickerButton extends StatelessWidget {
  const SeasonPickerButton({
    super.key,
    required this.seasons,
    required this.selectedId,
    required this.onSelected,
    this.enabled = true,
    this.keyPrefix = 'stats',
  });

  final List<SeasonOption> seasons;
  final int? selectedId;
  final ValueChanged<int> onSelected;
  final bool enabled;

  /// Voorvoegsel van de widget-keys (`<prefix>-season-picker`,
  /// `<prefix>-season-<id>`).
  final String keyPrefix;

  String _label(AppLocalizations l10n, SeasonOption season) =>
      season.isActive ? season.label : l10n.statsSeasonClosed(season.label);

  Future<void> _open(BuildContext context) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final chosen = await showAppSheet<int>(
      context: context,
      title: l10n.statsSeasonPickerTitle,
      scrollable: true,
      builder: (sheetContext) {
        final t = AssistjeTokens.of(sheetContext);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final season in seasons)
              ListTile(
                key: ValueKey('$keyPrefix-season-${season.id}'),
                contentPadding: EdgeInsets.zero,
                title: Text(
                  _label(l10n, season),
                  style: TextStyle(
                    fontWeight: season.id == selectedId
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: t.ink,
                  ),
                ),
                trailing: season.id == selectedId
                    ? Icon(PhosphorIconsBold.check, color: t.primary, size: 18)
                    : null,
                onTap: () => Navigator.of(sheetContext).pop(season.id),
              ),
            const SizedBox(height: 12),
          ],
        );
      },
    );
    if (chosen != null && chosen != selectedId) onSelected(chosen);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    SeasonOption? selected;
    for (final s in seasons) {
      if (s.id == selectedId) selected = s;
    }
    final label = selected == null ? '' : _label(l10n, selected);
    return AppCard(
      key: ValueKey('$keyPrefix-season-picker'),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      onTap: enabled ? () => _open(context) : null,
      child: Row(
        children: [
          Icon(PhosphorIconsDuotone.calendarBlank, size: 18, color: t.muted),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              l10n.statsSeasonButton(label),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: t.ink,
              ),
            ),
          ),
          Icon(PhosphorIconsBold.caretDown, size: 14, color: t.muted),
        ],
      ),
    );
  }
}

/// Medaille voor plek 1–3, anders `null`.
String? podiumMedal(int rank) => switch (rank) {
  1 => '🥇',
  2 => '🥈',
  3 => '🥉',
  _ => null,
};
