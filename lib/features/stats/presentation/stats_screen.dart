import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/sport_stats_profile.dart';
import '../application/stats_controller.dart';
import '../application/stats_csv_sharer.dart';
import '../data/stats_repository.dart';
import 'widgets/stats_player_card.dart';
import 'widgets/stats_ui.dart';

/// De Statistieken-tab (`Trainer/TeamStats` in de PWA): venster (seizoen /
/// laatste 10 / laatste 5), seizoenskiezer, sorteren en één kaart per speler
/// met de kolommen die de sport van het team bijhoudt. Je eigen rij is
/// gemarkeerd; tikken opent de speler. "Exporteer" downloadt dezelfde CSV als
/// de PWA (`/stats/export`, voor elk teamlid) en geeft hem aan het deelmenu.
class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  StatsSort _sort = StatsSort.overview;
  bool _exporting = false;
  final _exportKey = GlobalKey();

  StatsController _controller(int teamId) =>
      ref.read(statsControllerProvider(teamId).notifier);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showStatsError(
        context,
        AppLocalizations.of(context).statsLoadError,
        error,
      );
    }
  }

  Future<void> _afterSwitch(Future<Object?> request) async {
    final error = await request;
    if (error != null && mounted) {
      showStatsError(
        context,
        AppLocalizations.of(context).statsSwitchFailed,
        error,
      );
    }
  }

  /// Downloadt de CSV voor het getoonde venster/seizoen en opent het
  /// deelmenu met `stats-JJJJ-MM-DD.csv`.
  Future<void> _export(int teamId, StatsState state) async {
    if (_exporting) return;
    final l10n = AppLocalizations.of(context);
    final sharer = ref.read(statsCsvSharerProvider);
    unawaited(Haptics.light());
    setState(() => _exporting = true);
    try {
      final export = await ref
          .read(statsRepositoryProvider)
          .exportCsv(
            teamId,
            window: state.window,
            seasonId: state.selectedSeasonId,
          );
      if (!mounted) return;
      await sharer.share(
        export.bytes,
        export.filename,
        origin: _exportOrigin(),
      );
    } on Object catch (error) {
      if (mounted) showStatsError(context, l10n.statsExportFailed, error);
    } finally {
      if (mounted) setState(() => _exporting = false);
    }
  }

  Rect? _exportOrigin() {
    final box = _exportKey.currentContext?.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return null;
    return box.localToGlobal(Offset.zero) & box.size;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final membership = ref.watch(currentMembershipProvider);
    final teamId = membership?.team.id;

    final List<Widget> content;
    Widget? exportButton;
    if (membership == null || teamId == null) {
      content = const [];
    } else {
      final async = ref.watch(statsControllerProvider(teamId));
      final state = async.value;
      if (state != null) {
        final profile = SportStatsProfile.fromSport(membership.sport);
        final sorts = availableSorts(
          profile,
          trainingPoints: membership.hasFeature('training_points'),
        );
        content = _content(teamId, state, profile, sorts);
        exportButton = Padding(
          key: const ValueKey('stats-export'),
          padding: const EdgeInsets.only(bottom: 12),
          child: SecondaryButton(
            key: _exportKey,
            label: l10n.statsExport,
            loading: _exporting,
            icon: const Icon(PhosphorIconsBold.downloadSimple, size: 16),
            onPressed: _exporting ? null : () => _export(teamId, state),
          ),
        );
      } else if (async.hasError) {
        content = [
          SliverToBoxAdapter(
            child: StatsErrorState(
              key: const ValueKey('stats-error'),
              retryKey: const ValueKey('stats-retry'),
              title: l10n.statsLoadError,
              error: async.error,
              onRetry: () => _refresh(teamId),
            ),
          ),
        ];
      } else {
        content = const [
          SliverToBoxAdapter(
            child: StatsLoading(key: ValueKey('stats-loading')),
          ),
        ];
      }
    }

    return Scaffold(
      key: const ValueKey('stats-screen'),
      backgroundColor: t.sunken,
      body: AppRefresh(
        onRefresh: teamId == null ? () async {} : () => _refresh(teamId),
        padding: EdgeInsets.fromLTRB(
          12,
          ShellInsets.top(context),
          12,
          ShellInsets.bottom(context),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: StatsScreenTitle(l10n.navStats)),
                ?exportButton,
              ],
            ),
          ),
          ...content,
        ],
      ),
    );
  }

  List<Widget> _content(
    int teamId,
    StatsState state,
    SportStatsProfile profile,
    List<StatsSort> sorts,
  ) {
    final l10n = AppLocalizations.of(context);
    final stats = state.stats;
    final sort = sorts.contains(_sort) ? _sort : StatsSort.overview;
    final rows = sortStatsRows(stats.rows, sort);

    return [
      if (stats.seasons.length > 1)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SeasonPickerButton(
              seasons: stats.seasons,
              selectedId: stats.seasonId,
              enabled: !state.switching,
              onSelected: (id) =>
                  _afterSwitch(_controller(teamId).selectSeason(id)),
            ),
          ),
        ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: AppTabPills<StatsWindow>(
            key: const ValueKey('stats-window'),
            fullWidth: true,
            darkTrack: true,
            selected: state.window,
            onChanged: state.switching
                ? (_) {}
                : (window) {
                    unawaited(Haptics.selection());
                    unawaited(
                      _afterSwitch(_controller(teamId).selectWindow(window)),
                    );
                  },
            tabs: [
              AppTabPill(
                value: StatsWindow.season,
                label: l10n.statsWindowSeason,
              ),
              AppTabPill(
                value: StatsWindow.last10,
                label: l10n.statsWindowLast10,
              ),
              AppTabPill(
                value: StatsWindow.last5,
                label: l10n.statsWindowLast5,
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SingleChildScrollView(
            key: const ValueKey('stats-sorts'),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final option in sorts)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: AppPill(
                      key: ValueKey('stats-sort-${option.name}'),
                      label: _sortLabel(l10n, profile, option),
                      selected: option == sort,
                      onTap: () {
                        unawaited(Haptics.selection());
                        setState(() => _sort = option);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      if (state.switching)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: LinearProgressIndicator(
              key: ValueKey('stats-switching'),
              minHeight: 2,
            ),
          ),
        ),
      if (rows.isEmpty)
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('stats-empty'),
            icon: PhosphorIconsDuotone.chartBar,
            title: l10n.statsEmptyTitle,
            description: l10n.statsEmptyDescription,
          ),
        )
      else
        SliverList.builder(
          itemCount: rows.length,
          itemBuilder: (context, index) {
            final row = rows[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: StatsPlayerCard(
                row: row,
                profile: profile,
                sort: sort,
                rank: index + 1,
                isMe: row.playerId == stats.myPlayerId,
                onTap: () {
                  unawaited(Haptics.light());
                  unawaited(context.push(AppRoutes.player(row.playerId)));
                },
              ),
            );
          },
        ),
    ];
  }

  static String _sortLabel(
    AppLocalizations l10n,
    SportStatsProfile profile,
    StatsSort sort,
  ) => switch (sort) {
    StatsSort.overview => l10n.statsSortOverview,
    StatsSort.attendanceMatch => l10n.statsSortAttendanceMatch,
    StatsSort.attendanceTraining => l10n.statsSortAttendanceTraining,
    StatsSort.matchesPlayed => l10n.statsSortMatches,
    StatsSort.minutes => l10n.statsSortMinutes,
    StatsSort.goals => profile.goalsTerm ?? l10n.statsSortGoals,
    StatsSort.assists => profile.assistsTerm ?? l10n.statsSortAssists,
    StatsSort.flagMinutes => l10n.statsSortFlagMinutes,
    StatsSort.flagShifts => l10n.statsSortFlagShifts,
    StatsSort.trainingPoints => l10n.statsSortTrainingPoints,
    StatsSort.name => l10n.statsSortName,
  };
}
