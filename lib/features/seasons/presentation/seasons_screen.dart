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
import '../../settings/presentation/widgets/settings_ui.dart';
import '../application/seasons_controller.dart';
import '../data/models/seasons_models.dart';
import 'widgets/period_form_sheet.dart';
import 'widgets/season_form_sheet.dart';
import 'widgets/seasons_sections.dart';
import 'widgets/seasons_ui.dart';

/// Seizoenen & periodes (trainer, PWA-tab Seizoen in `/settings`): het
/// lopende seizoen bijstellen, afsluiten of een afsluiting terugdraaien, en
/// de badge-periodes beheren. Trekken = verversen.
///
/// Demo-team of een `403` op een schrijfactie: alleen-lezen. Een `403` bij
/// laden (geen trainer): een leeg scherm met uitleg.
class SeasonsScreen extends ConsumerStatefulWidget {
  const SeasonsScreen({super.key});

  @override
  ConsumerState<SeasonsScreen> createState() => _SeasonsScreenState();
}

class _SeasonsScreenState extends ConsumerState<SeasonsScreen> {
  /// Aantal blokken voor het voorstel (PWA-standaard 3).
  int _count = 3;
  bool _generating = false;
  bool _seasonBusy = false;

  AppLocalizations get _l10n => AppLocalizations.of(context);

  SeasonsController _controller(int teamId) =>
      ref.read(seasonsControllerProvider(teamId).notifier);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showSeasonsError(context, error, title: _l10n.seasonsLoadError);
    }
  }

  // --- Seizoen -----------------------------------------------------------

  Future<void> _editSeason(int teamId, Season season) async {
    unawaited(Haptics.light());
    final l10n = _l10n;
    final controller = _controller(teamId);
    final saved = await showSeasonFormSheet(
      context,
      season: season,
      onSubmit: (update) async => (await controller.updateSeason(update)).error,
    );
    if ((saved ?? false) && mounted) {
      showSeasonsSuccess(context, l10n.seasonsSaved);
    }
  }

  Future<void> _closeSeason(int teamId) async {
    final l10n = _l10n;
    if (!await confirmSeasons(
      context,
      message: l10n.seasonsCloseConfirm,
      confirmLabel: l10n.seasonsCloseButton,
      destructive: true,
    )) {
      return;
    }
    setState(() => _seasonBusy = true);
    final result = await _controller(teamId).closeSeason();
    if (!mounted) return;
    setState(() => _seasonBusy = false);
    if (!result.ok) {
      showSeasonsError(context, result.error);
      return;
    }
    final next = ref
        .read(seasonsControllerProvider(teamId))
        .value
        ?.data
        .season
        ?.label;
    showSeasonsSuccess(
      context,
      l10n.seasonsClosed,
      message: next == null ? null : l10n.seasonsClosedNext(next),
    );
  }

  Future<void> _reopenSeason(int teamId, ClosedSeason closed) async {
    final l10n = _l10n;
    if (!await confirmSeasons(
      context,
      message: l10n.seasonsReopenConfirm(closed.label),
      confirmLabel: l10n.seasonsPeriodReopen,
      destructive: true,
    )) {
      return;
    }
    setState(() => _seasonBusy = true);
    final result = await _controller(teamId).reopenSeason();
    if (!mounted) return;
    setState(() => _seasonBusy = false);
    if (!result.ok) {
      showSeasonsError(context, result.error);
      return;
    }
    final moved = result.meta.moved;
    showSeasonsSuccess(
      context,
      l10n.seasonsReopened(closed.label),
      message: moved == null ? null : l10n.seasonsReopenedMoved(moved),
    );
  }

  // --- Periodes ----------------------------------------------------------

  Future<void> _setMode(int teamId, PeriodMode mode) async {
    unawaited(Haptics.selection());
    final result = await _controller(teamId).setMode(mode);
    if (!result.ok && mounted) showSeasonsError(context, result.error);
  }

  Future<void> _generate(int teamId, SeasonsData data) async {
    final l10n = _l10n;
    if (data.hasOpenPeriods &&
        !await confirmSeasons(
          context,
          message: l10n.seasonsGenerateConfirm,
          confirmLabel: l10n.seasonsGenerate,
        )) {
      return;
    }
    setState(() => _generating = true);
    final result = await _controller(teamId).generate(count: _count);
    if (!mounted) return;
    setState(() => _generating = false);
    if (result.ok) {
      showSeasonsSuccess(context, l10n.seasonsGenerated);
    } else {
      showSeasonsError(context, result.error);
    }
  }

  /// Nieuwe periode: begint de dag na de laatste periode (of op de start
  /// van het seizoen) en loopt tot het einde van het seizoen.
  (DateTime?, DateTime?) _newPeriodDates(SeasonsData data) {
    DateTime? from;
    for (final p in data.periods) {
      final end = parseSeasonDate(p.endsOn);
      if (end != null && (from == null || !end.isBefore(from))) {
        from = end.add(const Duration(days: 1));
      }
    }
    from ??= parseSeasonDate(data.season?.startsOn);
    var to = parseSeasonDate(data.season?.endsOn);
    if (from != null && to != null && !to.isAfter(from)) to = null;
    return (from, to);
  }

  Future<void> _openPeriod(
    int teamId,
    SeasonsData data,
    SeasonPeriod? period,
  ) async {
    unawaited(Haptics.light());
    final l10n = _l10n;
    final controller = _controller(teamId);
    final (from, to) = _newPeriodDates(data);
    final saved = await showPeriodFormSheet(
      context,
      period: period,
      mode: data.mode,
      defaultFrom: from,
      defaultTo: to,
      onSubmit: (input) async =>
          (period == null
                  ? await controller.createPeriod(input)
                  : await controller.updatePeriod(period.id, input))
              .error,
    );
    if ((saved ?? false) && mounted) {
      showSeasonsSuccess(
        context,
        period == null ? l10n.seasonsPeriodAdded : l10n.seasonsSaved,
      );
    }
  }

  Future<void> _periodAction(
    int teamId,
    SeasonsData data,
    SeasonPeriod period,
    PeriodAction action,
  ) async {
    final l10n = _l10n;
    if (action == PeriodAction.edit) {
      return _openPeriod(teamId, data, period);
    }
    final (message, confirmLabel, destructive) = switch (action) {
      PeriodAction.close => (
        l10n.seasonsPeriodCloseConfirm(period.name),
        l10n.seasonsPeriodClose,
        false,
      ),
      PeriodAction.reopen => (
        l10n.seasonsPeriodReopenConfirm(period.name),
        l10n.seasonsPeriodReopen,
        true,
      ),
      _ => (
        l10n.seasonsPeriodDeleteConfirm(period.name),
        l10n.seasonsPeriodDelete,
        true,
      ),
    };
    if (!await confirmSeasons(
      context,
      message: message,
      confirmLabel: confirmLabel,
      destructive: destructive,
    )) {
      return;
    }
    final controller = _controller(teamId);
    final result = await switch (action) {
      PeriodAction.close => controller.closePeriod(period.id),
      PeriodAction.reopen => controller.reopenPeriod(period.id),
      _ => controller.deletePeriod(period.id),
    };
    if (!mounted) return;
    if (!result.ok) {
      showSeasonsError(context, result.error);
      return;
    }
    switch (action) {
      case PeriodAction.close:
        final awards = result.meta.awardCount;
        showSeasonsSuccess(
          context,
          l10n.seasonsPeriodClosed(period.name),
          message: awards == null
              ? null
              : l10n.seasonsPeriodClosedAwards(awards),
        );
      case PeriodAction.reopen:
        showSeasonsSuccess(context, l10n.seasonsPeriodReopened(period.name));
      case PeriodAction.delete:
      case PeriodAction.edit:
        showSeasonsSuccess(context, l10n.seasonsPeriodDeleted);
    }
  }

  // --- Opbouw ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final t = AssistjeTokens.of(context);
    final l10n = _l10n;
    final async = ref.watch(seasonsControllerProvider(teamId));
    final state = async.value;
    final readOnly =
        membership.team.isDemo || (state?.writesForbidden ?? false);

    final List<Widget> content;
    if (state != null) {
      content = [
        if (readOnly) ...[
          SettingsNotice(
            key: const ValueKey('seasons-read-only'),
            icon: PhosphorIconsDuotone.eye,
            text: membership.team.isDemo
                ? l10n.seasonsReadOnlyDemo
                : l10n.seasonsReadOnlyForbidden,
          ),
          const SizedBox(height: 12),
        ],
        ..._cards(teamId, state.data, readOnly),
      ];
    } else if (async.hasError) {
      content = [_errorState(teamId, async.error)];
    } else {
      content = const [
        Column(
          key: ValueKey('seasons-loading'),
          children: [
            Skeleton(height: 96, radius: AssistjeTokens.radius2xl),
            SizedBox(height: 12),
            SkeletonList(),
          ],
        ),
      ];
    }

    return Scaffold(
      key: const ValueKey('seasons-screen'),
      backgroundColor: t.sunken,
      body: AppRefresh(
        onRefresh: () => _refresh(teamId),
        padding: EdgeInsets.fromLTRB(
          12,
          ShellInsets.top(context),
          12,
          ShellInsets.bottom(context),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
              child: Semantics(
                header: true,
                child: Text(
                  l10n.screenSeasons,
                  // Zelfde key als de placeholder: de shell-tests lezen de
                  // schermtitel via `placeholder-title`.
                  key: const Key('placeholder-title'),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: t.ink,
                  ),
                ),
              ),
            ),
          ),
          SliverList.list(children: content),
        ],
      ),
    );
  }

  List<Widget> _cards(int teamId, SeasonsData data, bool readOnly) {
    final season = data.season;
    final closed = data.closedSeason;
    final cards = <Widget>[
      CurrentSeasonCard(
        season: season,
        onEdit: readOnly || season == null
            ? null
            : () => _editSeason(teamId, season),
      ),
      PeriodModeCard(
        mode: data.mode,
        modes: data.modes,
        onChanged: readOnly ? null : (mode) => _setMode(teamId, mode),
      ),
      if (data.mode == PeriodMode.matches)
        PeriodSplitCard(
          season: season,
          count: _count,
          busy: _generating,
          onCount: (n) {
            unawaited(Haptics.selection());
            setState(() => _count = n);
          },
          onGenerate: readOnly ? null : () => _generate(teamId, data),
        ),
      if (data.mode != PeriodMode.off)
        PeriodsCard(
          mode: data.mode,
          periods: data.periods,
          onAction: readOnly
              ? null
              : (period, action) => _periodAction(teamId, data, period, action),
          onAdd: readOnly ? null : () => _openPeriod(teamId, data, null),
        ),
      SeasonAdminCard(
        season: season,
        closedSeason: closed,
        busy: _seasonBusy,
        onClose: readOnly ? null : () => _closeSeason(teamId),
        onReopen: readOnly || closed == null
            ? null
            : () => _reopenSeason(teamId, closed),
      ),
    ];
    return [
      for (var i = 0; i < cards.length; i++) ...[
        if (i > 0) const SizedBox(height: 12),
        cards[i],
      ],
    ];
  }

  Widget _errorState(int teamId, Object? error) {
    final l10n = _l10n;
    return switch (error) {
      ForbiddenException() => EmptyState(
        key: const ValueKey('seasons-forbidden'),
        icon: PhosphorIconsDuotone.lockSimple,
        title: l10n.seasonsForbiddenTitle,
        description: l10n.seasonsForbidden,
      ),
      _ => EmptyState(
        key: const ValueKey('seasons-error'),
        icon: PhosphorIconsDuotone.warningCircle,
        title: l10n.seasonsLoadError,
        description: seasonsErrorText(l10n, error),
        action: PrimaryButton(
          key: const ValueKey('seasons-retry'),
          label: l10n.retry,
          onPressed: () => _refresh(teamId),
        ),
      ),
    };
  }
}
