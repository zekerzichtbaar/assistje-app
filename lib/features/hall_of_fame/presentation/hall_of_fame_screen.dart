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
import '../../stats/application/sport_stats_profile.dart';
import '../../stats/presentation/widgets/stats_ui.dart';
import '../application/hall_of_fame_controller.dart';
import '../data/models/hall_of_fame_models.dart';
import 'widgets/hall_of_fame_widgets.dart';

/// De tabs van de Ranking (`HallOfFame.tsx`).
enum HofTab { ranking, milestones, training }

/// De Ranking-tab (Hall of Fame): seizoenskiezer, en drie tabs —
/// Ranglijst (de ranglijsten die de sport kent), Mijlpalen (periodekiezer,
/// titels, erelijst, badges) en Trainen (trainingspunten, alleen als die aan
/// staan). Tikken op een speler opent de speler.
class HallOfFameScreen extends ConsumerStatefulWidget {
  const HallOfFameScreen({super.key});

  @override
  ConsumerState<HallOfFameScreen> createState() => _HallOfFameScreenState();
}

class _HallOfFameScreenState extends ConsumerState<HallOfFameScreen> {
  HofTab _tab = HofTab.ranking;

  HallOfFameController _controller(int teamId) =>
      ref.read(hallOfFameControllerProvider(teamId).notifier);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showStatsError(
        context,
        AppLocalizations.of(context).hallOfFameLoadError,
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

  void _openPlayer(int playerId) {
    unawaited(Haptics.light());
    unawaited(context.push(AppRoutes.player(playerId)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final membership = ref.watch(currentMembershipProvider);
    final teamId = membership?.team.id;

    final List<Widget> content;
    if (membership == null || teamId == null) {
      content = const [];
    } else {
      final async = ref.watch(hallOfFameControllerProvider(teamId));
      final state = async.value;
      if (state != null) {
        content = _content(
          teamId,
          state,
          SportStatsProfile.fromSport(membership.sport),
        );
      } else if (async.hasError) {
        content = [
          SliverToBoxAdapter(
            child: StatsErrorState(
              key: const ValueKey('hof-error'),
              retryKey: const ValueKey('hof-retry'),
              title: l10n.hallOfFameLoadError,
              error: async.error,
              onRetry: () => _refresh(teamId),
            ),
          ),
        ];
      } else {
        content = const [
          SliverToBoxAdapter(child: StatsLoading(key: ValueKey('hof-loading'))),
        ];
      }
    }

    return Scaffold(
      key: const ValueKey('hof-screen'),
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
          SliverToBoxAdapter(child: StatsScreenTitle(l10n.navHallOfFame)),
          ...content,
        ],
      ),
    );
  }

  List<Widget> _content(
    int teamId,
    HallOfFameState state,
    SportStatsProfile profile,
  ) {
    final l10n = AppLocalizations.of(context);
    final hof = state.hallOfFame;
    final tabs = [
      HofTab.ranking,
      HofTab.milestones,
      if (hof.trainingPointsEnabled) HofTab.training,
    ];
    final tab = tabs.contains(_tab) ? _tab : HofTab.ranking;

    final List<Widget> body = switch (tab) {
      HofTab.ranking => _ranking(hof, profile),
      HofTab.milestones => _milestones(teamId, state),
      HofTab.training => [
        HofPodium(
          key: const ValueKey('hof-training-points'),
          title: l10n.hallOfFameTrainingPoints,
          icon: PhosphorIconsDuotone.trophy,
          rows: hof.topTrainingPoints,
          valueOf: (r) => r.points,
          unit: l10n.hallOfFameTrainingPointsUnit,
          onOpenPlayer: _openPlayer,
        ),
      ],
    };

    return [
      if (hof.seasons.length > 1)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SeasonPickerButton(
              keyPrefix: 'hof',
              seasons: hof.seasons,
              selectedId: hof.seasonId,
              enabled: !state.switching,
              onSelected: (id) =>
                  _afterSwitch(_controller(teamId).selectSeason(id)),
            ),
          ),
        ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppTabPills<HofTab>(
            key: const ValueKey('hof-tabs'),
            fullWidth: true,
            darkTrack: true,
            selected: tab,
            onChanged: (next) {
              unawaited(Haptics.selection());
              setState(() => _tab = next);
            },
            tabs: [
              for (final option in tabs)
                AppTabPill(
                  value: option,
                  label: switch (option) {
                    HofTab.ranking => l10n.hallOfFameTabRanking,
                    HofTab.milestones => l10n.hallOfFameTabMilestones,
                    HofTab.training => l10n.hallOfFameTabTraining,
                  },
                ),
            ],
          ),
        ),
      ),
      if (state.switching)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: LinearProgressIndicator(
              key: ValueKey('hof-switching'),
              minHeight: 2,
            ),
          ),
        ),
      SliverList.separated(
        itemCount: body.length,
        itemBuilder: (context, index) => body[index],
        separatorBuilder: (context, index) => hofGap,
      ),
    ];
  }

  /// De ranglijsten die de sport kan vullen; `null` in de API = niet tonen.
  List<Widget> _ranking(HallOfFame hof, SportStatsProfile profile) {
    final l10n = AppLocalizations.of(context);
    final postMatch = hof.postMatchLeaderboards;
    final scorers = hof.topScorers;
    final assisters = hof.topAssisters;
    final flaggers = hof.topFlaggers;
    return [
      if (scorers != null)
        HofPodium(
          key: const ValueKey('hof-top-scorers'),
          title: l10n.hallOfFameTopScorers,
          icon: PhosphorIconsDuotone.soccerBall,
          rows: scorers,
          valueOf: (r) => r.goals,
          unit: hofTerm(profile.goalsTerm, l10n.statsSortGoals),
          onOpenPlayer: _openPlayer,
        ),
      if (assisters != null)
        HofPodium(
          key: const ValueKey('hof-top-assisters'),
          title: l10n.hallOfFameTopOf(
            hofTerm(profile.assistsTerm, l10n.statsSortAssists),
          ),
          icon: PhosphorIconsDuotone.target,
          rows: assisters,
          valueOf: (r) => r.assists,
          unit: hofTerm(profile.assistsTerm, l10n.statsSortAssists),
          onOpenPlayer: _openPlayer,
        ),
      if (postMatch != null) ...[
        HofPodium(
          key: const ValueKey('hof-points'),
          title: l10n.hallOfFamePoints,
          icon: PhosphorIconsDuotone.volleyball,
          rows: postMatch.points,
          valueOf: (r) => r.points,
          unit: l10n.hallOfFamePointsUnit,
          onOpenPlayer: _openPlayer,
        ),
        HofPodium(
          key: const ValueKey('hof-aces'),
          title: l10n.hallOfFameAces,
          icon: PhosphorIconsDuotone.target,
          rows: postMatch.aces,
          valueOf: (r) => r.aces,
          unit: l10n.hallOfFameAcesUnit,
          onOpenPlayer: _openPlayer,
        ),
        HofPodium(
          key: const ValueKey('hof-blocks'),
          title: l10n.hallOfFameBlocks,
          icon: PhosphorIconsDuotone.wall,
          rows: postMatch.blocks,
          valueOf: (r) => r.blocks,
          unit: l10n.hallOfFameBlocksUnit,
          onOpenPlayer: _openPlayer,
        ),
      ],
      if (flaggers != null)
        HofPodium(
          key: const ValueKey('hof-top-flaggers'),
          title: l10n.hallOfFameFlaggers,
          icon: PhosphorIconsDuotone.flag,
          rows: flaggers,
          valueOf: (r) => r.shifts,
          subvalueOf: (r) => l10n.hallOfFameFlagMinutes(r.minutes),
          unit: l10n.hallOfFameTimesUnit,
          onOpenPlayer: _openPlayer,
        ),
      HofPodium(
        key: const ValueKey('hof-top-motm'),
        title: l10n.hallOfFameMotm,
        icon: PhosphorIconsDuotone.medal,
        rows: hof.topMotm,
        valueOf: (r) => r.wins,
        unit: l10n.hallOfFameTimesUnit,
        onOpenPlayer: _openPlayer,
      ),
    ];
  }

  List<Widget> _milestones(int teamId, HallOfFameState state) {
    final l10n = AppLocalizations.of(context);
    final hof = state.hallOfFame;
    final period = hof.period;
    final seasonTitles = [
      for (final title in hof.titles)
        if (title.group != 'now') title,
    ];
    final nowTitles = [
      for (final title in hof.titles)
        if (title.group == 'now') title,
    ];

    return [
      if (hof.periods.isNotEmpty)
        SingleChildScrollView(
          key: const ValueKey('hof-periods'),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: AppPill(
                  key: const ValueKey('hof-period-all'),
                  label: l10n.hallOfFameWholeSeason,
                  selected: period == null,
                  onTap: state.switching
                      ? null
                      : () => _selectPeriod(teamId, null),
                ),
              ),
              for (final p in hof.periods)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: AppPill(
                    key: ValueKey('hof-period-${p.id}'),
                    label: p.isClosed
                        ? l10n.hallOfFamePeriodClosed(p.name)
                        : p.name,
                    selected: p.id == period?.id,
                    onTap: state.switching
                        ? null
                        : () => _selectPeriod(teamId, p.id),
                  ),
                ),
            ],
          ),
        ),
      if (seasonTitles.isNotEmpty)
        HofTitlesCard(
          key: const ValueKey('hof-titles'),
          heading: period == null
              ? l10n.hallOfFameTitles
              : l10n.hallOfFameTitlesPeriod(period.name),
          icon: PhosphorIconsDuotone.trophy,
          iconColor: StatusColors.amber500,
          titles: seasonTitles,
          onOpenPlayer: _openPlayer,
        ),
      // Rollende vensters horen bij geen periode: alleen in de
      // seizoensweergave (zoals de PWA).
      if (period == null && nowTitles.isNotEmpty)
        HofTitlesCard(
          key: const ValueKey('hof-titles-now'),
          heading: l10n.hallOfFameTitlesNow,
          icon: PhosphorIconsDuotone.fire,
          iconColor: StatusColors.orange500,
          titles: nowTitles,
          onOpenPlayer: _openPlayer,
        ),
      if (period == null && hof.periodAwards.isNotEmpty)
        HofAwardsCard(groups: hof.periodAwards, onOpenPlayer: _openPlayer),
      HofBadgesCard(
        players: hof.playersWithBadges,
        emptyText: period == null
            ? l10n.hallOfFameBadgesEmptySeason
            : l10n.hallOfFameBadgesEmptyPeriod(period.name),
        onOpenPlayer: _openPlayer,
      ),
    ];
  }

  void _selectPeriod(int teamId, int? periodId) {
    unawaited(Haptics.selection());
    unawaited(_afterSwitch(_controller(teamId).selectPeriod(periodId)));
  }
}
