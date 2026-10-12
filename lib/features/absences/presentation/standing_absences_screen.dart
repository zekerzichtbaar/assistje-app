import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/session/session_providers.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/absences_controller.dart';
import 'widgets/absences_ui.dart';

/// Vaste afwezigheid (`/standing-absences`): per trainingsdag van het team
/// een schakelaar "ik kan hier nooit". Alleen met de feature
/// `standing_absences` en een eigen spelersprofiel.
class StandingAbsencesScreen extends ConsumerStatefulWidget {
  const StandingAbsencesScreen({super.key});

  @override
  ConsumerState<StandingAbsencesScreen> createState() =>
      _StandingAbsencesScreenState();
}

class _StandingAbsencesScreenState
    extends ConsumerState<StandingAbsencesScreen> {
  final Set<int> _busy = {};

  Future<void> _refresh(int teamId) async {
    final error = await ref
        .read(absencesControllerProvider(teamId).notifier)
        .refresh();
    if (error != null && mounted) {
      showAbsencesError(
        context,
        AppLocalizations.of(context).absencesLoadError,
        error,
      );
    }
  }

  Future<void> _toggle(int teamId, int weekday) async {
    if (_busy.contains(weekday)) return;
    unawaited(Haptics.selection());
    final l10n = AppLocalizations.of(context);
    setState(() => _busy.add(weekday));
    final result = await ref
        .read(absencesControllerProvider(teamId).notifier)
        .toggleStandingDay(weekday);
    if (!mounted) return;
    setState(() => _busy.remove(weekday));
    if (result.error != null) {
      showAbsencesError(context, l10n.absencesSaveFailed, result.error);
      return;
    }
    final day = weekdayName(weekday);
    showAbsencesSuccess(
      context,
      result.on
          ? l10n.absencesStandingAdded(day)
          : l10n.absencesStandingRemoved(day),
    );
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    final featureOn = membership.hasFeature('standing_absences');

    final List<Widget> slivers;
    var showIntro = false;
    if (!featureOn) {
      slivers = [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('standing-feature-off'),
            icon: PhosphorIconsDuotone.calendarX,
            title: l10n.absencesStandingFeatureOff,
          ),
        ),
      ];
    } else {
      final async = ref.watch(absencesControllerProvider(teamId));
      final state = async.value;
      if (state != null) {
        showIntro = state.weekdayChoices.isNotEmpty;
        slivers = _content(teamId, state);
      } else if (async.hasError) {
        slivers = [
          SliverToBoxAdapter(
            child: EmptyState(
              key: const ValueKey('standing-error'),
              icon: PhosphorIconsDuotone.warningCircle,
              title: l10n.absencesLoadError,
              description: absencesErrorText(l10n, async.error),
              action: PrimaryButton(
                key: const ValueKey('standing-retry'),
                label: l10n.retry,
                onPressed: () => _refresh(teamId),
              ),
            ),
          ),
        ];
      } else {
        slivers = const [
          SliverToBoxAdapter(
            child: AbsencesSkeleton(key: ValueKey('standing-loading')),
          ),
        ];
      }
    }

    return AbsencesScaffold(
      key: const ValueKey('standing-screen'),
      title: l10n.screenStandingAbsences,
      intro: showIntro ? l10n.absencesStandingIntro : null,
      onRefresh: () => featureOn ? _refresh(teamId) : Future.value(),
      slivers: slivers,
    );
  }

  List<Widget> _content(int teamId, AbsencesState state) {
    final l10n = AppLocalizations.of(context);
    if (state.standing == null) {
      return [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('standing-no-player'),
            icon: PhosphorIconsDuotone.userCircle,
            title: l10n.absencesNoPlayerTitle,
            description: l10n.absencesNoPlayerBody,
          ),
        ),
      ];
    }
    final choices = state.weekdayChoices;
    if (choices.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('standing-no-choices'),
            icon: PhosphorIconsDuotone.calendarX,
            title: l10n.absencesStandingNoChoicesTitle,
            description: l10n.absencesStandingNoChoicesBody,
          ),
        ),
      ];
    }
    final t = AssistjeTokens.of(context);
    return [
      SliverToBoxAdapter(
        child: AppCard(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              for (final (index, weekday) in choices.indexed) ...[
                if (index > 0) Divider(height: 1, color: t.lineSoft),
                _DayRow(
                  weekday: weekday,
                  on: state.standingDay(weekday) != null,
                  busy: _busy.contains(weekday),
                  onToggle: () => _toggle(teamId, weekday),
                ),
              ],
            ],
          ),
        ),
      ),
    ];
  }
}

class _DayRow extends StatelessWidget {
  const _DayRow({
    required this.weekday,
    required this.on,
    required this.busy,
    required this.onToggle,
  });

  final int weekday;
  final bool on;
  final bool busy;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final name = weekdayName(weekday);
    return MergeSemantics(
      child: ListTile(
        key: ValueKey('standing-day-$weekday'),
        onTap: busy ? null : onToggle,
        title: Text(
          '${name[0].toUpperCase()}${name.substring(1)}',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: t.ink,
          ),
        ),
        subtitle: Text(
          on ? l10n.absencesStandingOn : l10n.absencesStandingOff,
          style: TextStyle(
            fontSize: 13,
            color: on ? StatusColors.red600 : t.muted,
          ),
        ),
        trailing: busy
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Switch.adaptive(
                key: ValueKey('standing-switch-$weekday'),
                value: on,
                activeTrackColor: StatusColors.red500,
                onChanged: (_) => onToggle(),
              ),
      ),
    );
  }
}
