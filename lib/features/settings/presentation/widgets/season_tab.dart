import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/settings_models.dart';
import 'settings_ui.dart';

/// `2026-08-01` → `1 aug.` (`DATE_FMT` in SeasonTab.tsx); `?` als leeg.
String formatSettingsDate(String? iso) {
  if (iso == null || iso.isEmpty) return '?';
  final date = DateTime.tryParse(iso);
  if (date == null) return iso;
  return DateFormat('d MMM', 'nl').format(date);
}

/// Seizoen en periodes, alleen-lezen: wijzigen gebeurt op `/seasons`
/// (de PWA-tab Seizoen).
class SettingsSeasonTab extends StatelessWidget {
  const SettingsSeasonTab({
    super.key,
    required this.period,
    required this.onOpenSeasons,
  });

  final PeriodSettings period;
  final VoidCallback onOpenSeasons;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final p = period;
    final label = p.seasonLabel;

    final modeText = switch (p.mode) {
      'off' => l10n.settingsPeriodModeOff,
      'dates' => l10n.settingsPeriodModeDates,
      'matches' => l10n.settingsPeriodModeMatches,
      _ => p.mode,
    };

    final cards = <Widget>[
      SettingsSection(
        key: const ValueKey('settings-season-card'),
        title: l10n.settingsSeasonCurrent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                label ?? l10n.settingsSeasonNone,
                key: const ValueKey('settings-season-label'),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: t.ink,
                ),
              ),
              if (label != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    l10n.settingsSeasonRange(
                      formatSettingsDate(p.seasonStartsOn),
                      formatSettingsDate(p.seasonEndsOn),
                      p.seasonMatchCount,
                    ),
                    style: TextStyle(fontSize: 13, color: t.muted),
                  ),
                ),
              if (p.seasonExpired) ...[
                const SizedBox(height: 12),
                SettingsNotice(
                  key: const ValueKey('settings-season-expired'),
                  warning: true,
                  icon: PhosphorIconsDuotone.warning,
                  title: l10n.settingsSeasonExpiredTitle,
                  text: l10n.settingsSeasonExpired(label ?? ''),
                ),
              ],
              if (p.closedSeason case final closed?) ...[
                const SizedBox(height: 8),
                SettingsHint(l10n.settingsSeasonClosed(closed.label)),
              ],
            ],
          ),
        ),
      ),
      SettingsSection(
        key: const ValueKey('settings-periods-card'),
        title: l10n.settingsPeriodsTitle,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Text(
                modeText,
                style: TextStyle(fontSize: 14, color: t.inkSoft),
              ),
            ),
            for (final row in p.periods) ...[
              Divider(height: 1, color: t.lineSoft),
              _PeriodTile(row: row),
            ],
          ],
        ),
      ),
      AppCard(
        key: const ValueKey('settings-open-seasons'),
        onTap: onOpenSeasons,
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: t.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: PhosphorIcon(
                PhosphorIconsDuotone.calendarDots,
                size: 22,
                color: t.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.settingsSeasonsManage,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: t.ink,
                    ),
                  ),
                  Text(
                    l10n.settingsSeasonsManageHint,
                    style: TextStyle(fontSize: 13, color: t.muted),
                  ),
                ],
              ),
            ),
            PhosphorIcon(
              PhosphorIconsBold.caretRight,
              size: 16,
              color: t.muted,
            ),
          ],
        ),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < cards.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          cards[i],
        ],
      ],
    );
  }
}

class _PeriodTile extends StatelessWidget {
  const _PeriodTile({required this.row});

  final PeriodRow row;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final range = row.endsOn == null
        ? l10n.settingsPeriodFrom(formatSettingsDate(row.startsOn))
        : '${formatSettingsDate(row.startsOn)} – '
              '${formatSettingsDate(row.endsOn)}';
    final played = row.targetMatches == null
        ? l10n.settingsPeriodPlayed(row.playedMatches)
        : l10n.settingsPeriodPlayedOf(row.playedMatches, row.targetMatches!);
    return Padding(
      key: ValueKey('settings-period-${row.id}'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: t.ink,
                  ),
                ),
                Text(
                  '$range · $played',
                  style: TextStyle(fontSize: 12, color: t.muted),
                ),
              ],
            ),
          ),
          if (row.isClosed)
            AppPill(label: l10n.settingsPeriodClosed)
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}
