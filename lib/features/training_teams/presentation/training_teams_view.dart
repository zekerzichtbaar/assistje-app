import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../event/application/event_detail_controller.dart';
import '../../team/application/sport_info.dart';
import '../application/training_teams_controller.dart';
import '../data/models/training_teams_models.dart';
import 'widgets/training_teams_cards.dart';
import 'widgets/training_teams_sheets.dart';
import 'widgets/training_teams_ui.dart';

/// De partijvorm van één training (`Pages/Trainer/Events/Teams.tsx`): ploegen
/// indelen, ruilen en verplaatsen, de uitslag per ploeg, de puntenlijst, en
/// sterktes/basis. Trekken = verversen.
class TrainingTeamsView extends ConsumerStatefulWidget {
  const TrainingTeamsView({super.key, required this.eventId});

  final int eventId;

  @override
  ConsumerState<TrainingTeamsView> createState() => _TrainingTeamsViewState();
}

class _TrainingTeamsViewState extends ConsumerState<TrainingTeamsView> {
  /// De opgelichte speler (eerste tik); de tweede tik ruilt of verplaatst.
  int? _picked;

  /// Een actie die op de server wacht (indelen, wissen, punten, …).
  bool _busy = false;

  EventKey _key(int teamId) => (teamId: teamId, eventId: widget.eventId);

  TrainingTeamsController _controller(int teamId) =>
      ref.read(trainingTeamsControllerProvider(_key(teamId)).notifier);

  AppLocalizations get _l10n => AppLocalizations.of(context);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showTrainingTeamsError(
        context,
        error,
        title: _l10n.trainingTeamsLoadError,
      );
    }
  }

  /// Een actie die wacht op de server: knoppen even uit, fout als toast.
  Future<Object?> _run(Future<Object?> Function() action) async {
    setState(() => _busy = true);
    final error = await action();
    if (!mounted) return error;
    setState(() => _busy = false);
    if (error != null) showTrainingTeamsError(context, error);
    return error;
  }

  /// Optimistische actie: geen wachtstand, alleen een toast bij een fout.
  Future<void> _quiet(Future<Object?> action) async {
    final error = await action;
    if (error != null && mounted) showTrainingTeamsError(context, error);
  }

  Future<void> _openSetup(int teamId, TrainingTeams data) async {
    unawaited(Haptics.light());
    final count = await showTrainingSetupSheet(
      context,
      eventKey: _key(teamId),
      initialCount: data.usedSides.length < 2 ? 2 : data.usedSides.length,
    );
    if (count == null || !mounted) return;
    await _draw(teamId, teams: count);
  }

  Future<void> _draw(int teamId, {int? teams}) async {
    unawaited(Haptics.success());
    setState(() => _picked = null);
    final l10n = _l10n;
    final error = await _run(() => _controller(teamId).draw(teams: teams));
    if (error == null && mounted) {
      showTrainingTeamsSuccess(context, l10n.trainingTeamsDrawn);
    }
  }

  Future<void> _clear(int teamId) async {
    final l10n = _l10n;
    if (!await confirmTrainingTeams(
      context,
      question: l10n.trainingTeamsClearConfirm,
      confirmLabel: l10n.trainingTeamsClear,
    )) {
      return;
    }
    if (!mounted) return;
    setState(() => _picked = null);
    await _run(() => _controller(teamId).clear());
  }

  void _openStrengths(int teamId, SportInfo sport) {
    unawaited(Haptics.light());
    unawaited(
      showTrainingStrengthSheet(context, eventKey: _key(teamId), sport: sport),
    );
  }

  void _tapPlayer(int teamId, TrainingTeams data, TrainingTeamPlayer p) {
    final picked = _picked;
    if (picked == null) {
      unawaited(Haptics.light());
      setState(() => _picked = p.id);
      return;
    }
    if (picked == p.id) {
      setState(() => _picked = null);
      return;
    }
    final other = data.teams.player(picked);
    // Zelfde ploeg (of allebei op de bank): niets te ruilen, de selectie
    // verspringt.
    if (other != null && other.side == p.side) {
      unawaited(Haptics.light());
      setState(() => _picked = p.id);
      return;
    }
    unawaited(Haptics.selection());
    setState(() => _picked = null);
    unawaited(_quiet(_controller(teamId).swap(picked, p.id)));
  }

  void _moveTo(int teamId, String? side) {
    final picked = _picked;
    if (picked == null) return;
    setState(() => _picked = null);
    unawaited(Haptics.selection());
    unawaited(_quiet(_controller(teamId).move(picked, side)));
  }

  Future<void> _copy(TrainingTeams data) async {
    final l10n = _l10n;
    final title = _eventLabel(data);
    final blocks = [
      for (final side in data.usedSides)
        [
          sideLabel(l10n, data, side),
          for (final p in data.teams.playersOf(side)) '· ${p.name}',
        ].join('\n'),
    ];
    await Clipboard.setData(
      ClipboardData(
        text:
            '${l10n.trainingTeamsCopyHeader(title)}\n\n${blocks.join('\n\n')}',
      ),
    );
    if (mounted) showTrainingTeamsSuccess(context, l10n.trainingTeamsCopied);
  }

  String _eventLabel(TrainingTeams data) {
    final startsAt = data.event.startsAt;
    if (startsAt == null) return data.event.title;
    final date = DateFormat('EEEE d MMMM', 'nl').format(startsAt.toLocal());
    return data.event.title.isEmpty ? date : '${data.event.title} · $date';
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = _l10n;
    final t = AssistjeTokens.of(context);
    final async = ref.watch(trainingTeamsControllerProvider(_key(teamId)));
    final data = async.value;
    final sport = SportInfo.of(membership);

    final List<Widget> content;
    if (data != null) {
      content = _content(teamId, data, sport);
    } else if (async.hasError) {
      content = [SliverToBoxAdapter(child: _errorState(teamId, async.error))];
    } else {
      content = const [
        SliverToBoxAdapter(
          child: Column(
            key: ValueKey('training-teams-loading'),
            children: [
              Skeleton(height: 220, radius: AssistjeTokens.radius2xl),
              SizedBox(height: 12),
              SkeletonList(count: 6),
            ],
          ),
        ),
      ];
    }

    return Scaffold(
      key: const ValueKey('training-teams-screen'),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(
                    header: true,
                    child: Text(
                      l10n.screenEventTrainingTeams,
                      // Zelfde key als de placeholder: de shell-tests lezen
                      // de schermtitel via `placeholder-title`.
                      key: const Key('placeholder-title'),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: t.ink,
                      ),
                    ),
                  ),
                  if (data != null)
                    Text(
                      _eventLabel(data),
                      key: const ValueKey('training-teams-event-title'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15, color: t.muted),
                    ),
                ],
              ),
            ),
          ),
          ...content,
        ],
      ),
    );
  }

  Widget _errorState(int teamId, Object? error) {
    final l10n = _l10n;
    return switch (error) {
      ForbiddenException() => EmptyState(
        key: const ValueKey('training-teams-forbidden'),
        icon: PhosphorIconsDuotone.lockSimple,
        title: l10n.trainingTeamsForbiddenTitle,
        description: l10n.trainingTeamsForbidden,
      ),
      NotFoundException() => EmptyState(
        key: const ValueKey('training-teams-not-found'),
        icon: PhosphorIconsDuotone.calendarX,
        title: l10n.trainingTeamsNotFoundTitle,
        description: l10n.trainingTeamsNotFound,
      ),
      _ => EmptyState(
        key: const ValueKey('training-teams-error'),
        icon: PhosphorIconsDuotone.warningCircle,
        title: l10n.trainingTeamsLoadError,
        description: trainingTeamsErrorText(l10n, error),
        action: PrimaryButton(
          key: const ValueKey('training-teams-retry'),
          label: l10n.retry,
          onPressed: () => _refresh(teamId),
        ),
      ),
    };
  }

  List<Widget> _content(int teamId, TrainingTeams data, SportInfo sport) {
    final controller = _controller(teamId);
    final board = data.teams;
    // Een speler die na een verversing niet meer meedoet, kan niet
    // opgelicht blijven.
    if (_picked != null && board.player(_picked!) == null) _picked = null;

    final children = <Widget>[
      if (board.tracksTeams)
        if (!board.hasTeams)
          TrainingDrawPrompt(
            data: data,
            onDraw: _busy ? null : () => _openSetup(teamId, data),
            onStrengths: () => _openStrengths(teamId, sport),
          )
        else ...[
          TrainingBoardCard(
            data: data,
            picked: _picked,
            busy: _busy,
            onTapPlayer: (p) => _tapPlayer(teamId, data, p),
            onMoveTo: (side) => _moveTo(teamId, side),
            onRedraw: () => _draw(teamId),
            onStrengths: () => _openStrengths(teamId, sport),
            onSetup: () => _openSetup(teamId, data),
            onCopy: () => _copy(data),
            onClear: () => _clear(teamId),
          ),
          if (board.tracksPoints)
            TrainingResultCard(
              data: data,
              onQuick: (winner) {
                unawaited(Haptics.selection());
                unawaited(_quiet(controller.quickResult(winner)));
              },
              onBump: (side, delta) {
                unawaited(Haptics.light());
                unawaited(_quiet(controller.bumpScore(side, delta)));
              },
            ),
        ],
      if (board.tracksPoints)
        TrainingScoringCard(
          data: data,
          busy: _busy,
          onDrawPoints: () {
            unawaited(Haptics.selection());
            unawaited(_run(controller.drawPoints));
          },
          onBumpPlayer: (row, delta) {
            unawaited(Haptics.light());
            unawaited(_quiet(controller.bumpPlayer(row.id, delta)));
          },
          onExclude: (row) => unawaited(_run(() => controller.exclude(row.id))),
          onInclude: (option) =>
              unawaited(_run(() => controller.include(option.id))),
        ),
    ];

    return [
      SliverList.separated(
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      ),
    ];
  }
}
