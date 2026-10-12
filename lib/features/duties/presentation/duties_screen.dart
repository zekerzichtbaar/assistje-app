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
import '../../agenda/presentation/widgets/duty_icons.dart';
import '../application/duties_controller.dart';
import '../data/models/duties_models.dart';
import 'widgets/duties_ui.dart';
import 'widgets/duty_assignment_sheet.dart';
import 'widgets/duty_group_sheet.dart';

/// Diensten (`Pages/Trainer/Duties/Index.tsx`), alleen voor de trainer:
/// typewisselaar, bij een groepsdienst de groepen (aanmaken, wijzigen,
/// volgorde) en de geplande beurten, bij een individuele dienst de beurten
/// per persoon, en de tellers van dit seizoen. Diensttypes zelf beheren
/// hoort bij de instellingen en zit niet in de API.
class DutiesScreen extends ConsumerStatefulWidget {
  const DutiesScreen({super.key});

  @override
  ConsumerState<DutiesScreen> createState() => _DutiesScreenState();
}

class _DutiesScreenState extends ConsumerState<DutiesScreen> {
  bool _switching = false;

  DutiesController _controller(int teamId) =>
      ref.read(dutiesControllerProvider(teamId).notifier);

  AppLocalizations get _l10n => AppLocalizations.of(context);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showDutiesError(context, _l10n.dutiesLoadError, error);
    }
  }

  Future<void> _switchType(int teamId, String slug) async {
    unawaited(Haptics.selection());
    setState(() => _switching = true);
    final error = await _controller(teamId).selectType(slug);
    if (!mounted) return;
    setState(() => _switching = false);
    if (error != null) showDutiesError(context, _l10n.dutiesLoadError, error);
  }

  /// Een losse actie (verplaatsen, afvinken, verwijderen, verdelen): bij een
  /// fout een toast met trilling.
  Future<bool> _act(Future<Object?> Function() action) async {
    final error = await action();
    if (!mounted) return false;
    if (error != null) {
      showDutiesError(context, _l10n.dutiesActionFailed, error);
      return false;
    }
    return true;
  }

  Future<void> _openGroup(
    int teamId,
    DutiesOverview overview, {
    DutyGroup? group,
  }) async {
    unawaited(Haptics.light());
    final l10n = _l10n;
    final controller = _controller(teamId);
    var deleted = false;
    final done = await showDutyGroupSheet(
      context,
      group: group,
      people: overview.allPeople,
      onSave: (name, keys) => group == null
          ? controller.createGroup(name, keys)
          : controller.updateGroup(group.id, name, keys),
      onDelete: group == null
          ? null
          : () async {
              final error = await controller.deleteGroup(group.id);
              deleted = error == null;
              return error;
            },
    );
    if ((done ?? false) && mounted) {
      showDutiesSuccess(
        context,
        deleted ? l10n.dutiesDeleted : l10n.dutiesSaved,
      );
    }
  }

  Future<void> _plan(int teamId, DutiesOverview overview) async {
    unawaited(Haptics.light());
    final l10n = _l10n;
    final done = await showDutyPlanSheet(
      context,
      overview: overview,
      onSave: _controller(teamId).storeAssignments,
    );
    if ((done ?? false) && mounted) {
      showDutiesSuccess(context, l10n.dutiesPlanned);
    }
  }

  Future<void> _edit(
    int teamId,
    DutiesOverview overview,
    DutyAssignment assignment,
  ) async {
    unawaited(Haptics.light());
    final l10n = _l10n;
    final done = await showDutyEditSheet(
      context,
      overview: overview,
      assignment: assignment,
      onSave: (changes) =>
          _controller(teamId).updateAssignment(assignment.id, changes),
    );
    if ((done ?? false) && mounted) {
      showDutiesSuccess(context, l10n.dutiesSaved);
    }
  }

  Future<void> _delete(int teamId, DutyAssignment assignment) async {
    final l10n = _l10n;
    if (!await confirmDuties(
      context,
      l10n.dutiesAssignmentDeleteConfirm(
        dutiesDateLabel(assignment.scheduledFor),
      ),
    )) {
      return;
    }
    if (await _act(() => _controller(teamId).deleteAssignment(assignment.id)) &&
        mounted) {
      showDutiesSuccess(context, l10n.dutiesDeleted);
    }
  }

  Future<void> _toggleDone(int teamId, DutyAssignment assignment) async {
    unawaited(Haptics.selection());
    await _act(() => _controller(teamId).toggleDone(assignment.id));
  }

  Future<void> _move(int teamId, DutyGroup group, int delta) async {
    unawaited(Haptics.selection());
    await _act(() => _controller(teamId).moveGroup(group.id, delta));
  }

  Future<void> _autoAssign(int teamId, DutiesOverview overview) async {
    final l10n = _l10n;
    if (!await confirmDuties(
      context,
      overview.isIndividual
          ? l10n.dutiesAutoAssignConfirmIndividual
          : l10n.dutiesAutoAssignConfirmGroups,
      confirmLabel: l10n.dutiesAutoAssignConfirm,
      destructive: false,
    )) {
      return;
    }
    final (error, message) = await _controller(teamId).autoAssign();
    if (!mounted) return;
    if (error != null) {
      showDutiesError(context, l10n.dutiesActionFailed, error);
    } else {
      showDutiesSuccess(context, message ?? l10n.dutiesPlanned);
    }
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = _l10n;
    final t = AssistjeTokens.of(context);
    final async = ref.watch(dutiesControllerProvider(teamId));
    final overview = async.value;

    final List<Widget> content;
    if (overview != null) {
      content = _content(teamId, overview);
    } else if (async.hasError) {
      content = [SliverToBoxAdapter(child: _errorState(teamId, async.error))];
    } else {
      content = const [
        SliverToBoxAdapter(
          child: Column(
            key: ValueKey('duties-loading'),
            children: [
              Skeleton(height: 36, radius: AssistjeTokens.radiusFull),
              SizedBox(height: 12),
              SkeletonList(count: 4),
            ],
          ),
        ),
      ];
    }

    return Scaffold(
      key: const ValueKey('duties-screen'),
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
                  l10n.navDuties,
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
          ...content,
        ],
      ),
    );
  }

  Widget _errorState(int teamId, Object? error) {
    final l10n = _l10n;
    return switch (error) {
      ForbiddenException() => EmptyState(
        key: const ValueKey('duties-forbidden'),
        icon: PhosphorIconsDuotone.lockSimple,
        title: l10n.dutiesForbiddenTitle,
        description: l10n.dutiesForbidden,
      ),
      NotFoundException() => EmptyState(
        key: const ValueKey('duties-not-found'),
        icon: PhosphorIconsDuotone.clipboardText,
        title: l10n.dutiesNotFoundTitle,
        description: l10n.dutiesNotFound,
        action: SecondaryButton(
          key: const ValueKey('duties-retry'),
          label: l10n.retry,
          onPressed: () => _refresh(teamId),
        ),
      ),
      _ => EmptyState(
        key: const ValueKey('duties-error'),
        icon: PhosphorIconsDuotone.warningCircle,
        title: l10n.dutiesLoadError,
        description: dutiesErrorText(l10n, error),
        action: PrimaryButton(
          key: const ValueKey('duties-retry'),
          label: l10n.retry,
          onPressed: () => _refresh(teamId),
        ),
      ),
    };
  }

  List<Widget> _content(int teamId, DutiesOverview overview) {
    final cards = overview.isIndividual
        ? _individualCards(teamId, overview)
        : _groupCards(teamId, overview);
    return [
      if (overview.dutyTypes.length > 1)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SingleChildScrollView(
              key: const ValueKey('duties-types'),
              scrollDirection: Axis.horizontal,
              child: AppTabPills<String>(
                darkTrack: true,
                selected: overview.type,
                onChanged: _switching
                    ? (_) {}
                    : (slug) => _switchType(teamId, slug),
                tabs: [
                  for (final type in overview.dutyTypes)
                    AppTabPill(
                      value: type.slug,
                      label: type.name,
                      icon: dutyIconFor(type.icon),
                    ),
                ],
              ),
            ),
          ),
        ),
      if (_switching)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: LinearProgressIndicator(
              key: ValueKey('duties-switching'),
              minHeight: 2,
            ),
          ),
        ),
      SliverList.separated(
        itemCount: cards.length,
        itemBuilder: (context, index) => cards[index],
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      ),
    ];
  }

  Widget _addButton({
    required String key,
    required String label,
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    final t = AssistjeTokens.of(context);
    return IconButton(
      key: ValueKey(key),
      tooltip: label,
      visualDensity: VisualDensity.compact,
      color: t.primary,
      disabledColor: t.line,
      icon: Icon(icon, size: 18),
      onPressed: onPressed,
    );
  }

  List<Widget> _groupCards(int teamId, DutiesOverview overview) {
    final l10n = _l10n;
    final t = AssistjeTokens.of(context);
    final groups = overview.groups;
    final hasGroups = groups.isNotEmpty;
    return [
      DutiesCard(
        key: const ValueKey('duties-groups'),
        title: l10n.dutiesGroupsTitle,
        count: groups.length,
        actions: [
          _addButton(
            key: 'duties-group-add',
            label: l10n.dutiesGroupAdd,
            icon: PhosphorIconsBold.plus,
            onPressed: () => _openGroup(teamId, overview),
          ),
        ],
        child: groups.isEmpty
            ? _quiet(l10n.dutiesGroupsEmpty, 'duties-groups-empty')
            : Column(
                children: [
                  for (final (index, group) in groups.indexed) ...[
                    if (index > 0)
                      Divider(
                        height: 1,
                        indent: 16,
                        endIndent: 16,
                        color: t.lineSoft,
                      ),
                    _GroupRow(
                      group: group,
                      onEdit: () => _openGroup(teamId, overview, group: group),
                      onUp: index == 0 ? null : () => _move(teamId, group, -1),
                      onDown: index == groups.length - 1
                          ? null
                          : () => _move(teamId, group, 1),
                    ),
                  ],
                ],
              ),
      ),
      DutiesCard(
        key: const ValueKey('duties-assignments'),
        title: overview.isMatchBound
            ? l10n.dutiesPlannedMatches
            : l10n.dutiesPlannedDates,
        count: overview.assignments.length,
        actions: [
          if (overview.isMatchBound)
            _addButton(
              key: 'duties-auto-assign',
              label: l10n.dutiesAutoAssign,
              icon: PhosphorIconsBold.shuffle,
              onPressed: hasGroups ? () => _autoAssign(teamId, overview) : null,
            ),
          _addButton(
            key: 'duties-plan',
            label: overview.isMatchBound
                ? l10n.dutiesAddMatches
                : l10n.dutiesAddDates,
            icon: PhosphorIconsBold.plus,
            onPressed: hasGroups ? () => _plan(teamId, overview) : null,
          ),
        ],
        child: _assignmentList(
          teamId,
          overview,
          l10n.dutiesAssignmentsEmptyGroups,
        ),
      ),
      if (hasGroups)
        _SeasonCounts(rows: [for (final g in groups) (g.name, g.count)]),
    ];
  }

  List<Widget> _individualCards(int teamId, DutiesOverview overview) {
    final l10n = _l10n;
    final t = AssistjeTokens.of(context);
    final hasPeople = overview.allPeople.isNotEmpty;
    return [
      DutiesCard(
        key: const ValueKey('duties-assignments'),
        title: l10n.dutiesPlannedTurns,
        count: overview.assignments.length,
        actions: [
          if (overview.isMatchBound)
            _addButton(
              key: 'duties-auto-assign',
              label: l10n.dutiesAutoAssign,
              icon: PhosphorIconsBold.shuffle,
              onPressed: hasPeople ? () => _autoAssign(teamId, overview) : null,
            ),
          _addButton(
            key: 'duties-plan',
            label: l10n.dutiesAddTurn,
            icon: PhosphorIconsBold.plus,
            onPressed: hasPeople ? () => _plan(teamId, overview) : null,
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Text(
                overview.isMatchBound
                    ? l10n.dutiesIndividualHintMatch
                    : l10n.dutiesIndividualHint,
                style: TextStyle(fontSize: 12, color: t.muted),
              ),
            ),
            _assignmentList(
              teamId,
              overview,
              l10n.dutiesAssignmentsEmptyIndividual,
            ),
          ],
        ),
      ),
      if (hasPeople)
        _SeasonCounts(
          rows: [for (final p in overview.allPeople) (p.name, p.count)],
        ),
    ];
  }

  Widget _assignmentList(
    int teamId,
    DutiesOverview overview,
    String emptyText,
  ) {
    final t = AssistjeTokens.of(context);
    final rows = overview.assignments;
    if (rows.isEmpty) return _quiet(emptyText, 'duties-assignments-empty');
    return Column(
      children: [
        for (final (index, a) in rows.indexed) ...[
          if (index > 0)
            Divider(height: 1, indent: 16, endIndent: 16, color: t.lineSoft),
          _AssignmentRow(
            assignment: a,
            overview: overview,
            onToggleDone: () => _toggleDone(teamId, a),
            onEdit: () => _edit(teamId, overview, a),
            onDelete: () => _delete(teamId, a),
          ),
        ],
      ],
    );
  }

  Widget _quiet(String text, String key) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
    child: Text(
      text,
      key: ValueKey(key),
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, color: AssistjeTokens.of(context).muted),
    ),
  );
}

class _GroupRow extends StatelessWidget {
  const _GroupRow({
    required this.group,
    required this.onEdit,
    this.onUp,
    this.onDown,
  });

  final DutyGroup group;
  final VoidCallback onEdit;
  final VoidCallback? onUp;
  final VoidCallback? onDown;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return InkWell(
      key: ValueKey('duties-group-${group.id}'),
      onTap: onEdit,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 4, 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: t.ink,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    group.members.isEmpty
                        ? l10n.dutiesGroupNoMembers
                        : group.members.map((m) => m.name).join(', '),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: t.muted),
                  ),
                ],
              ),
            ),
            IconButton(
              key: ValueKey('duties-group-${group.id}-up'),
              tooltip: l10n.dutiesGroupMoveUp,
              visualDensity: VisualDensity.compact,
              color: t.muted,
              disabledColor: t.lineSoft,
              icon: const Icon(PhosphorIconsBold.caretUp, size: 16),
              onPressed: onUp,
            ),
            IconButton(
              key: ValueKey('duties-group-${group.id}-down'),
              tooltip: l10n.dutiesGroupMoveDown,
              visualDensity: VisualDensity.compact,
              color: t.muted,
              disabledColor: t.lineSoft,
              icon: const Icon(PhosphorIconsBold.caretDown, size: 16),
              onPressed: onDown,
            ),
          ],
        ),
      ),
    );
  }
}

class _AssignmentRow extends StatelessWidget {
  const _AssignmentRow({
    required this.assignment,
    required this.overview,
    required this.onToggleDone,
    required this.onEdit,
    required this.onDelete,
  });

  final DutyAssignment assignment;
  final DutiesOverview overview;
  final VoidCallback onToggleDone;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final a = assignment;
    final who = overview.isIndividual
        ? (a.playerName ?? l10n.dutiesNoPerson)
        : a.groupName;
    final time = a.startsAt == null
        ? null
        : [
            dutiesTimeLabel(a.startsAt!),
            if (a.endsAt != null) dutiesTimeLabel(a.endsAt!),
          ].join(' – ');
    final detail = [
      if (overview.isMatchBound) dutiesDateLabel(a.scheduledFor),
      ?who,
      ?time,
      if ((a.notes ?? '').trim().isNotEmpty) a.notes!,
    ].join(' · ');
    final primary = overview.isMatchBound
        ? (a.eventLabel ?? l10n.dutiesNoMatchLinked)
        : dutiesDateLabel(a.scheduledFor);

    return Padding(
      key: ValueKey('duties-assignment-${a.id}'),
      padding: const EdgeInsets.fromLTRB(16, 8, 4, 8),
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
                        primary,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: t.ink,
                        ),
                      ),
                    ),
                    if (a.isDone) ...[
                      const SizedBox(width: 6),
                      const Icon(
                        PhosphorIconsBold.check,
                        size: 12,
                        color: StatusColors.emerald600,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        l10n.dutiesDone,
                        style: TextStyle(fontSize: 11, color: t.muted),
                      ),
                    ],
                  ],
                ),
                if (detail.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    detail,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: t.muted),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            key: ValueKey('duties-assignment-${a.id}-done'),
            tooltip: a.isDone ? l10n.dutiesMarkUndone : l10n.dutiesMarkDone,
            visualDensity: VisualDensity.compact,
            color: a.isDone ? StatusColors.emerald600 : t.muted,
            icon: Icon(
              a.isDone
                  ? PhosphorIconsFill.checkCircle
                  : PhosphorIconsBold.checkCircle,
              size: 18,
            ),
            onPressed: onToggleDone,
          ),
          IconButton(
            key: ValueKey('duties-assignment-${a.id}-edit'),
            tooltip: l10n.dutiesEdit,
            visualDensity: VisualDensity.compact,
            color: t.muted,
            icon: const Icon(PhosphorIconsBold.pencilSimple, size: 18),
            onPressed: onEdit,
          ),
          IconButton(
            key: ValueKey('duties-assignment-${a.id}-delete'),
            tooltip: l10n.dutiesDelete,
            visualDensity: VisualDensity.compact,
            color: StatusColors.red500,
            icon: const Icon(PhosphorIconsBold.trash, size: 18),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

/// "Beurten dit seizoen": naam en aantal.
class _SeasonCounts extends StatelessWidget {
  const _SeasonCounts({required this.rows});

  final List<(String, int)> rows;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return DutiesCard(
      key: const ValueKey('duties-season-counts'),
      title: l10n.dutiesSeasonCounts,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
        child: Column(
          children: [
            for (final (name, count) in rows)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14, color: t.inkSoft),
                      ),
                    ),
                    Text(
                      '$count',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: t.ink,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
