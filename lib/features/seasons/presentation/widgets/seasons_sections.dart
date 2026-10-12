import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../settings/presentation/widgets/settings_ui.dart';
import '../../data/models/seasons_models.dart';
import 'seasons_ui.dart';

/// "Lopend seizoen": label, grenzen, aantal wedstrijden, stand en de
/// waarschuwing als de einddatum voorbij is.
class CurrentSeasonCard extends StatelessWidget {
  const CurrentSeasonCard({
    super.key,
    required this.season,
    required this.onEdit,
  });

  final Season? season;

  /// `null` = alleen-lezen.
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final s = season;
    return SettingsSection(
      key: const ValueKey('seasons-current-card'),
      title: l10n.seasonsCurrentTitle,
      trailing: s != null && onEdit != null
          ? TextButton(
              key: const ValueKey('seasons-edit'),
              onPressed: onEdit,
              style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              child: Text(l10n.seasonsEdit),
            )
          : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: s == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.seasonsNone,
                    key: const ValueKey('seasons-none'),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: t.ink,
                    ),
                  ),
                  SettingsHint(l10n.seasonsNoneHint),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          s.label,
                          key: const ValueKey('seasons-label'),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: t.ink,
                          ),
                        ),
                      ),
                      if (s.expired)
                        AppPill(
                          key: const ValueKey('seasons-expired-pill'),
                          label: l10n.seasonsExpiredPill,
                          selected: true,
                          selectedColor: StatusColors.amber100,
                          selectedForeground: StatusColors.amber800,
                        )
                      else if (s.isActive)
                        AppPill(
                          key: const ValueKey('seasons-active-pill'),
                          label: l10n.seasonsActive,
                          selected: true,
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      l10n.seasonsRange(
                        formatSeasonDate(s.startsOn),
                        formatSeasonDate(s.endsOn),
                        s.matchCount,
                      ),
                      key: const ValueKey('seasons-range'),
                      style: TextStyle(fontSize: 13, color: t.muted),
                    ),
                  ),
                  if (s.expired) ...[
                    const SizedBox(height: 12),
                    SettingsNotice(
                      key: const ValueKey('seasons-expired'),
                      warning: true,
                      icon: PhosphorIconsDuotone.warning,
                      title: l10n.seasonsExpiredTitle,
                      text:
                          '${l10n.seasonsExpiredText(s.label)}\n\n'
                          '${l10n.seasonsExpiredHint}',
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}

/// "Badges per periode": de drie standen.
class PeriodModeCard extends StatelessWidget {
  const PeriodModeCard({
    super.key,
    required this.mode,
    required this.modes,
    required this.onChanged,
  });

  final PeriodMode mode;
  final List<PeriodMode> modes;

  /// `null` = alleen-lezen.
  final ValueChanged<PeriodMode>? onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    // Volgorde van de PWA: uit, op wedstrijden, op datum.
    const order = [PeriodMode.off, PeriodMode.matches, PeriodMode.dates];
    return SettingsSection(
      key: const ValueKey('seasons-mode-card'),
      title: l10n.seasonsModeTitle,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.seasonsModeIntro,
              style: TextStyle(fontSize: 14, color: t.inkSoft),
            ),
            for (final m in order)
              if (modes.contains(m)) ...[
                const SizedBox(height: 8),
                SettingsOptionTile(
                  key: ValueKey('seasons-mode-${m.name}'),
                  title: switch (m) {
                    PeriodMode.off => l10n.seasonsModeOff,
                    PeriodMode.matches => l10n.seasonsModeMatches,
                    PeriodMode.dates => l10n.seasonsModeDates,
                  },
                  description: switch (m) {
                    PeriodMode.off => l10n.seasonsModeOffHint,
                    PeriodMode.matches => l10n.seasonsModeMatchesHint,
                    PeriodMode.dates => l10n.seasonsModeDatesHint,
                  },
                  selected: mode == m,
                  onTap: onChanged == null ? null : () => onChanged!(m),
                ),
              ],
            if (mode == PeriodMode.matches) ...[
              const SizedBox(height: 12),
              SettingsNotice(text: l10n.seasonsModeMatchesNote),
            ],
          ],
        ),
      ),
    );
  }
}

/// "Verdeling" (modus `matches`): aantal blokken kiezen en een voorstel
/// laten maken.
class PeriodSplitCard extends StatelessWidget {
  const PeriodSplitCard({
    super.key,
    required this.season,
    required this.count,
    required this.onCount,
    required this.onGenerate,
    this.busy = false,
  });

  final Season? season;
  final int count;
  final ValueChanged<int> onCount;

  /// `null` = alleen-lezen.
  final VoidCallback? onGenerate;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final matches = season?.matchCount ?? 0;
    final perPeriod = matches > 0 ? (matches / count).ceil() : 0;
    return SettingsSection(
      key: const ValueKey('seasons-split-card'),
      title: l10n.seasonsSplitTitle,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              matches > 0
                  ? l10n.seasonsSplitText(
                      season?.label ?? '',
                      matches,
                      count,
                      perPeriod,
                    )
                  : l10n.seasonsSplitEmpty,
              key: const ValueKey('seasons-split-text'),
              style: TextStyle(fontSize: 14, color: t.inkSoft),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final n in const [2, 3, 4, 5])
                  AppPill(
                    key: ValueKey('seasons-count-$n'),
                    label: l10n.seasonsSplitCount(n),
                    selected: count == n,
                    onTap: onGenerate == null ? null : () => onCount(n),
                  ),
              ],
            ),
            if (onGenerate != null) ...[
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: PrimaryButton(
                  key: const ValueKey('seasons-generate'),
                  label: l10n.seasonsGenerate,
                  loading: busy,
                  onPressed: matches == 0 || busy ? null : onGenerate,
                ),
              ),
            ],
            SettingsHint(l10n.seasonsGenerateHint),
          ],
        ),
      ),
    );
  }
}

/// Acties op één periode.
enum PeriodAction { edit, close, reopen, delete }

/// "Periodes": de lijst, met per periode een menu en (op datum) een knop
/// om er een toe te voegen.
class PeriodsCard extends StatelessWidget {
  const PeriodsCard({
    super.key,
    required this.mode,
    required this.periods,
    required this.onAction,
    required this.onAdd,
  });

  final PeriodMode mode;
  final List<SeasonPeriod> periods;

  /// `null` = alleen-lezen.
  final void Function(SeasonPeriod period, PeriodAction action)? onAction;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return SettingsSection(
      key: const ValueKey('seasons-periods-card'),
      title: l10n.seasonsPeriodsTitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (periods.isEmpty)
            Padding(
              key: const ValueKey('seasons-periods-empty'),
              padding: const EdgeInsets.all(16),
              child: Text(
                mode == PeriodMode.matches
                    ? l10n.seasonsPeriodsEmptyMatches
                    : l10n.seasonsPeriodsEmptyDates,
                style: TextStyle(fontSize: 14, color: t.muted),
              ),
            ),
          for (var i = 0; i < periods.length; i++) ...[
            if (i > 0) Divider(height: 1, color: t.lineSoft),
            _PeriodTile(period: periods[i], onAction: onAction),
          ],
          if (mode == PeriodMode.dates && onAdd != null) ...[
            Divider(height: 1, color: t.lineSoft),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  key: const ValueKey('seasons-period-add'),
                  onPressed: onAdd,
                  icon: const PhosphorIcon(PhosphorIconsBold.plus, size: 16),
                  label: Text(l10n.seasonsPeriodAdd),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PeriodTile extends StatelessWidget {
  const _PeriodTile({required this.period, required this.onAction});

  final SeasonPeriod period;
  final void Function(SeasonPeriod period, PeriodAction action)? onAction;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final p = period;
    final end = p.endsOn == null
        ? l10n.seasonsPeriodOpenEnd
        : formatSeasonDate(p.endsOn);
    final parts = [
      '${formatSeasonDate(p.startsOn)} – $end',
      if (p.targetMatches case final target? when target > 0)
        l10n.seasonsPeriodTarget(target),
      if (p.isClosed)
        l10n.seasonsPeriodAwards(p.awardCount)
      else
        l10n.seasonsPeriodPlayed(p.playedMatches),
    ];
    final actions = p.isClosed
        ? const [PeriodAction.reopen]
        : const [PeriodAction.edit, PeriodAction.close, PeriodAction.delete];

    String label(PeriodAction a) => switch (a) {
      PeriodAction.edit => l10n.seasonsPeriodEdit,
      PeriodAction.close => l10n.seasonsPeriodClose,
      PeriodAction.reopen => l10n.seasonsPeriodReopen,
      PeriodAction.delete => l10n.seasonsPeriodDelete,
    };

    return InkWell(
      key: ValueKey('seasons-period-${p.id}'),
      onTap: onAction == null || p.isClosed
          ? null
          : () => onAction!(p, PeriodAction.edit),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 4, 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          p.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: t.ink,
                          ),
                        ),
                      ),
                      if (p.isClosed) ...[
                        const SizedBox(width: 8),
                        AppPill(
                          key: ValueKey('seasons-period-closed-${p.id}'),
                          label: l10n.seasonsPeriodClosedPill,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    parts.join(' · '),
                    style: TextStyle(fontSize: 12, color: t.muted),
                  ),
                ],
              ),
            ),
            if (onAction != null)
              PopupMenuButton<PeriodAction>(
                key: ValueKey('seasons-period-menu-${p.id}'),
                tooltip: l10n.seasonsPeriodActions(p.name),
                icon: PhosphorIcon(
                  PhosphorIconsBold.dotsThreeVertical,
                  size: 20,
                  color: t.muted,
                ),
                onSelected: (a) => onAction!(p, a),
                itemBuilder: (context) => [
                  for (final a in actions)
                    PopupMenuItem(
                      key: ValueKey('seasons-period-${a.name}-${p.id}'),
                      value: a,
                      child: Text(
                        label(a),
                        style: a == PeriodAction.delete
                            ? const TextStyle(color: StatusColors.red600)
                            : null,
                      ),
                    ),
                ],
              )
            else
              const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

/// "Seizoen afsluiten": afsluiten, en het laatst gesloten seizoen weer
/// openen.
class SeasonAdminCard extends StatelessWidget {
  const SeasonAdminCard({
    super.key,
    required this.season,
    required this.closedSeason,
    required this.onClose,
    required this.onReopen,
    this.busy = false,
  });

  final Season? season;
  final ClosedSeason? closedSeason;

  /// `null` = alleen-lezen.
  final VoidCallback? onClose;
  final VoidCallback? onReopen;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final closed = closedSeason;
    return SettingsSection(
      key: const ValueKey('seasons-admin-card'),
      title: l10n.seasonsAdminTitle,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.seasonsAdminText,
              style: TextStyle(fontSize: 14, color: t.inkSoft),
            ),
            if (onClose != null && season != null) ...[
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: AppButtonBase(
                  key: const ValueKey('seasons-close'),
                  label: l10n.seasonsCloseButton,
                  background: t.ink,
                  foreground: t.surface,
                  loading: busy,
                  onPressed: busy ? null : onClose,
                ),
              ),
            ],
            if (closed != null) ...[
              const SizedBox(height: 16),
              Divider(height: 1, color: t.lineSoft),
              const SizedBox(height: 16),
              Text(
                l10n.seasonsLastClosed(closed.label),
                key: const ValueKey('seasons-last-closed'),
                style: TextStyle(fontSize: 14, color: t.inkSoft),
              ),
              if (onReopen != null) ...[
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SecondaryButton(
                    key: const ValueKey('seasons-reopen'),
                    label: l10n.seasonsReopenButton(closed.label),
                    onPressed: busy ? null : onReopen,
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
