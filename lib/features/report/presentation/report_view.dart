import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/report_controller.dart';
import '../data/models/report_models.dart';
import '../data/scout_file_picker.dart';
import 'widgets/flag_duty_sheet.dart';
import 'widgets/player_stats_sheet.dart';
import 'widgets/report_ui.dart';
import 'widgets/score_sheet.dart';
import 'widgets/scout_import_sheet.dart';

/// Het wedstrijdverslag van wedstrijd [eventId]: de uitslag (doelpunten of
/// setstanden, naar het scoremodel van de sport), het statistiekenblad per
/// speler (kolommen uit het verslag) met scoutimport, en de vlaggersdienst.
///
/// Alleen met de lineup-bevoegdheid; anders een 403-scherm.
class ReportView extends ConsumerWidget {
  const ReportView({super.key, required this.eventId});

  final int eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    if (!membership.can('lineup')) {
      return _ReportScaffold(child: _forbidden(l10n));
    }
    final key = (teamId: membership.team.id, eventId: eventId);
    final async = ref.watch(reportControllerProvider(key));
    final report = async.value;
    if (report != null) {
      return _ReportScaffold(
        subtitle: reportMatchLabel(
          report.event.title,
          report.event.homeTeam,
          report.event.awayTeam,
        ),
        onRefresh: () => _refresh(context, ref, key),
        child: _ReportBody(reportKey: key, report: report),
      );
    }
    if (async.hasError) {
      return _ReportScaffold(child: _error(context, ref, key, async.error));
    }
    return const _ReportScaffold(
      child: Column(
        key: ValueKey('report-loading'),
        children: [
          Skeleton(height: 120, radius: AssistjeTokens.radius2xl),
          SizedBox(height: 12),
          SkeletonList(count: 3),
        ],
      ),
    );
  }

  static Future<void> _refresh(
    BuildContext context,
    WidgetRef ref,
    ReportKey key,
  ) async {
    ref.invalidate(flagDutyControllerProvider(key));
    final error = await ref
        .read(reportControllerProvider(key).notifier)
        .refresh();
    if (error != null && context.mounted) {
      showReportError(
        context,
        AppLocalizations.of(context).reportLoadError,
        error,
      );
    }
  }

  static Widget _forbidden(AppLocalizations l10n) => EmptyState(
    key: const ValueKey('report-forbidden'),
    icon: PhosphorIconsDuotone.lockSimple,
    title: l10n.reportForbiddenTitle,
    description: l10n.reportForbiddenBody,
  );

  Widget _error(
    BuildContext context,
    WidgetRef ref,
    ReportKey key,
    Object? error,
  ) {
    final l10n = AppLocalizations.of(context);
    return switch (error) {
      ForbiddenException() => _forbidden(l10n),
      NotFoundException() => EmptyState(
        key: const ValueKey('report-not-found'),
        icon: PhosphorIconsDuotone.question,
        title: l10n.reportNotFoundTitle,
        description: l10n.reportNotFoundBody,
      ),
      _ => EmptyState(
        key: const ValueKey('report-error'),
        icon: PhosphorIconsDuotone.warningCircle,
        title: l10n.reportLoadError,
        description: reportErrorText(l10n, error),
        action: PrimaryButton(
          key: const ValueKey('report-retry'),
          label: l10n.retry,
          onPressed: () => _refresh(context, ref, key),
        ),
      ),
    };
  }
}

/// Het scherm rond de inhoud: titel onder de zwevende pills, scrollen, en
/// (met data) trekken om te verversen.
class _ReportScaffold extends StatelessWidget {
  const _ReportScaffold({required this.child, this.subtitle, this.onRefresh});

  final Widget child;
  final String? subtitle;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final l10n = AppLocalizations.of(context);
    final padding = EdgeInsets.fromLTRB(
      16,
      ShellInsets.top(context),
      16,
      ShellInsets.bottom(context),
    );
    final header = Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Semantics(
            header: true,
            // Zelfde key als de placeholder (de shell-tests lezen hem).
            child: Text(
              l10n.screenEventReport,
              key: const Key('placeholder-title'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: t.ink,
                height: 1.2,
              ),
            ),
          ),
          if ((subtitle ?? '').isNotEmpty)
            Text(
              subtitle!,
              key: const ValueKey('report-match'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: t.muted),
            ),
        ],
      ),
    );
    final refresh = onRefresh;
    return Scaffold(
      key: const ValueKey('report-screen'),
      backgroundColor: t.sunken,
      body: refresh == null
          ? ListView(padding: padding, children: [header, child])
          : AppRefresh(
              onRefresh: refresh,
              padding: padding,
              slivers: [
                SliverToBoxAdapter(child: header),
                SliverToBoxAdapter(child: child),
              ],
            ),
    );
  }
}

class _ReportBody extends ConsumerWidget {
  const _ReportBody({required this.reportKey, required this.report});

  final ReportKey reportKey;
  final MatchReport report;

  ReportController _controller(WidgetRef ref) =>
      ref.read(reportControllerProvider(reportKey).notifier);

  Future<void> _editScore(BuildContext context, WidgetRef ref) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final saved = await showScoreSheet(
      context,
      report: report,
      onSaveScore: (home, away) => _controller(ref).saveScore(home, away),
      onSaveSets: (sets) => _controller(ref).saveSets(sets),
    );
    if ((saved ?? false) && context.mounted) {
      showReportSuccess(context, l10n.reportSaved);
    }
  }

  Future<void> _editStats(
    BuildContext context,
    WidgetRef ref,
    ReportPlayer player,
  ) async {
    unawaited(Haptics.selection());
    final l10n = AppLocalizations.of(context);
    final saved = await showPlayerStatsSheet(
      context,
      playerName: player.name,
      columns: report.statColumns,
      values: report.statsFor(player.id),
      onSave: (values) => _controller(ref).savePlayerStats({player.id: values}),
    );
    if ((saved ?? false) && context.mounted) {
      showReportSuccess(context, l10n.reportSaved);
    }
  }

  Future<void> _import(BuildContext context, WidgetRef ref) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final controller = _controller(ref);
    final picker = ref.read(scoutFilePickerProvider);
    final saved = await showScoutImportSheet(
      context,
      report: report,
      pickPdf: picker.pickPdf,
      onRead: controller.previewScout,
      onApply: controller.applyScoutImport,
    );
    if ((saved ?? false) && context.mounted) {
      showReportSuccess(context, l10n.reportScoutApplied);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _ScoreCard(report: report, onEdit: () => _editScore(context, ref)),
        _FlagSection(reportKey: reportKey),
        const SizedBox(height: 12),
        if (report.hasStatsSheet)
          _StatsCard(
            report: report,
            onEdit: (player) => _editStats(context, ref, player),
            onImport: report.canImport ? () => _import(context, ref) : null,
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              l10n.reportTimelineNote,
              key: const ValueKey('report-timeline-note'),
              style: TextStyle(fontSize: 13, color: t.muted),
            ),
          ),
      ],
    );
  }
}

/// De uitslag: thuis – uit, met setstanden bij een sets-sport.
class _ScoreCard extends StatelessWidget {
  const _ScoreCard({required this.report, required this.onEdit});

  final MatchReport report;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final event = report.event;
    final hasScore = report.homeScore != null || report.awayScore != null;
    final team = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: t.ink,
    );
    final sets = [...report.sets]
      ..sort((a, b) => a.setNumber.compareTo(b.setNumber));

    return AppCard(
      key: const ValueKey('report-score-card'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReportLabel(l10n.reportScoreTitle),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Text(
                  event.homeTeam ?? l10n.reportHome,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: team,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  hasScore
                      ? '${report.homeScore ?? 0} - ${report.awayScore ?? 0}'
                      : '– - –',
                  key: const ValueKey('report-score'),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: hasScore ? t.ink : t.muted,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  event.awayTeam ?? l10n.reportAway,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: team,
                ),
              ),
            ],
          ),
          if (report.usesSets && sets.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              key: const ValueKey('report-sets'),
              alignment: WrapAlignment.center,
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final set in sets)
                  AppPill(
                    label: l10n.reportSetScore(set.homePoints, set.awayPoints),
                  ),
              ],
            ),
          ],
          if (!hasScore) ...[
            const SizedBox(height: 8),
            Text(
              l10n.reportNoScore,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: t.muted),
            ),
          ],
          const SizedBox(height: 16),
          SecondaryButton(
            key: const ValueKey('report-edit-score'),
            label: report.usesSets ? l10n.reportEditSets : l10n.reportEditScore,
            icon: const Icon(PhosphorIconsBold.pencilSimple, size: 16),
            expand: true,
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }
}

/// De vlaggersdienst (alleen als deze wedstrijd er een heeft).
class _FlagSection extends ConsumerWidget {
  const _FlagSection({required this.reportKey});

  final ReportKey reportKey;

  Future<void> _edit(
    BuildContext context,
    WidgetRef ref,
    FlagDutyEdit flag,
  ) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final saved = await showFlagDutySheet(
      context,
      flag: flag,
      onSave: (shifts) =>
          ref.read(flagDutyControllerProvider(reportKey).notifier).save(shifts),
    );
    if ((saved ?? false) && context.mounted) {
      showReportSuccess(context, l10n.reportSaved);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(flagDutyControllerProvider(reportKey));
    final flag = async.value;

    if (flag == null) {
      if (!async.hasError) return const SizedBox.shrink();
      return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: AppCard(
          key: const ValueKey('report-flag-error'),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  l10n.reportFlagLoadError,
                  style: TextStyle(fontSize: 14, color: t.inkSoft),
                ),
              ),
              TextButton(
                onPressed: () =>
                    ref.invalidate(flagDutyControllerProvider(reportKey)),
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: AppCard(
        key: const ValueKey('report-flag-card'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ReportLabel(l10n.reportFlagTitle),
            const SizedBox(height: 8),
            if (flag.shifts.isEmpty)
              Text(
                l10n.reportFlagNone,
                style: TextStyle(fontSize: 14, color: t.muted),
              )
            else
              for (final (i, shift) in flag.shifts.indexed)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    l10n.reportFlagShift(
                      flag.candidate(shift.key)?.name ??
                          (i < flag.names.length ? flag.names[i] : '—'),
                      shift.fromMinute,
                    ),
                    style: TextStyle(fontSize: 14, color: t.ink),
                  ),
                ),
            const SizedBox(height: 12),
            SecondaryButton(
              key: const ValueKey('report-edit-flag'),
              label: l10n.reportFlagAssign,
              icon: const Icon(PhosphorIconsBold.flag, size: 16),
              expand: true,
              onPressed: () => _edit(context, ref, flag),
            ),
          ],
        ),
      ),
    );
  }
}

/// Het statistiekenblad: per speler de hoofdcijfers; tikken opent alle
/// kolommen.
class _StatsCard extends StatelessWidget {
  const _StatsCard({
    required this.report,
    required this.onEdit,
    required this.onImport,
  });

  final MatchReport report;
  final ValueChanged<ReportPlayer> onEdit;
  final VoidCallback? onImport;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final players = report.players;
    final headline = headlineStatColumns(report.statColumns);
    final small = TextStyle(fontSize: 12, color: t.muted);
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (report.lineup.isEmpty)
          Container(
            key: const ValueKey('report-no-lineup'),
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: dark ? const Color(0x26F59E0B) : StatusColors.amber50,
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusLg),
              border: Border.all(
                color: dark ? const Color(0x4DF59E0B) : StatusColors.amber200,
              ),
            ),
            child: Text(
              l10n.reportStatsNoLineup,
              style: TextStyle(
                fontSize: 14,
                color: dark ? StatusColors.amber300 : StatusColors.amber800,
              ),
            ),
          ),
        AppCard(
          key: const ValueKey('report-stats-card'),
          padding: EdgeInsets.zero,
          child: players.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    l10n.reportStatsEmpty,
                    key: const ValueKey('report-stats-empty'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: t.muted),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              l10n.reportStatsIntro,
                              style: TextStyle(fontSize: 14, color: t.inkSoft),
                            ),
                          ),
                          if (onImport != null)
                            TextButton(
                              key: const ValueKey('report-import'),
                              onPressed: onImport,
                              child: Text(l10n.reportStatsImport),
                            ),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: t.lineSoft),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                      child: Row(
                        children: [
                          Expanded(child: ReportLabel(l10n.reportStatsPlayer)),
                          for (final column in headline)
                            SizedBox(
                              width: 48,
                              child: Center(
                                key: ValueKey('report-col-$column'),
                                child: ReportLabel(statLabel(l10n, column)),
                              ),
                            ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                    for (final player in players)
                      _StatsRow(
                        player: player,
                        columns: headline,
                        values: report.statsFor(player.id),
                        onTap: () => onEdit(player),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                      child: Text(
                        '${l10n.reportStatsEditHint} ${l10n.reportStatsFootnote}',
                        style: small,
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({
    required this.player,
    required this.columns,
    required this.values,
    required this.onTap,
  });

  final ReportPlayer player;
  final List<String> columns;
  final Map<String, int> values;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return InkWell(
      key: ValueKey('report-player-${player.id}'),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                player.shirtNumber == null
                    ? player.name
                    : '${player.shirtNumber}. ${player.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: t.ink),
              ),
            ),
            for (final column in columns)
              SizedBox(
                width: 48,
                child: Text(
                  '${values[column] ?? 0}',
                  key: ValueKey('report-value-${player.id}-$column'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: (values[column] ?? 0) == 0 ? t.muted : t.ink,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            Icon(PhosphorIconsBold.caretRight, size: 14, color: t.muted),
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }
}
