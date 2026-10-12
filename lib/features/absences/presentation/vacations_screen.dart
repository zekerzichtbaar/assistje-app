import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/session/session_providers.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../profile/data/models/profile_models.dart';
import '../application/absences_controller.dart';
import 'widgets/absences_ui.dart';
import 'widgets/vacation_form_sheet.dart';

/// Vakanties (`/vacations`): je geplande vakanties, toevoegen (van, tot en
/// met, notitie) en weghalen. Met de feature `vacations` uit kun je alleen
/// nog bestaande vakanties weghalen (zoals het web).
class VacationsScreen extends ConsumerStatefulWidget {
  const VacationsScreen({super.key});

  @override
  ConsumerState<VacationsScreen> createState() => _VacationsScreenState();
}

class _VacationsScreenState extends ConsumerState<VacationsScreen> {
  final Set<int> _removing = {};

  AbsencesController _controller(int teamId) =>
      ref.read(absencesControllerProvider(teamId).notifier);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showAbsencesError(
        context,
        AppLocalizations.of(context).absencesLoadError,
        error,
      );
    }
  }

  Future<void> _add(int teamId) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final done = await showVacationFormSheet(
      context,
      onSubmit: (draft) => _controller(teamId).addVacation(
        startsOn: draft.startsOn,
        endsOn: draft.endsOn,
        note: draft.note,
      ),
    );
    if ((done ?? false) && mounted) {
      showAbsencesSuccess(context, l10n.absencesVacationAdded);
    }
  }

  Future<void> _remove(int teamId, ProfileVacation vacation) async {
    final l10n = AppLocalizations.of(context);
    unawaited(Haptics.light());
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(l10n.absencesVacationRemoveConfirm),
        actions: [
          TextButton(
            key: const ValueKey('vacation-remove-cancel'),
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.absencesCancel),
          ),
          TextButton(
            key: const ValueKey('vacation-remove-confirm'),
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: StatusColors.red600),
            child: Text(l10n.absencesDelete),
          ),
        ],
      ),
    );
    if (!(ok ?? false) || !mounted) return;
    setState(() => _removing.add(vacation.id));
    final error = await _controller(teamId).removeVacation(vacation.id);
    if (!mounted) return;
    setState(() => _removing.remove(vacation.id));
    if (error != null) {
      showAbsencesError(context, l10n.absencesRemoveFailed, error);
    } else {
      showAbsencesSuccess(context, l10n.absencesVacationRemoved);
    }
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    final async = ref.watch(absencesControllerProvider(teamId));
    final state = async.value;
    final featureOn = membership.hasFeature('vacations');

    final List<Widget> slivers;
    if (state != null) {
      slivers = _content(teamId, state, featureOn: featureOn);
    } else if (async.hasError) {
      slivers = [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('vacations-error'),
            icon: PhosphorIconsDuotone.warningCircle,
            title: l10n.absencesLoadError,
            description: absencesErrorText(l10n, async.error),
            action: PrimaryButton(
              key: const ValueKey('vacations-retry'),
              label: l10n.retry,
              onPressed: () => _refresh(teamId),
            ),
          ),
        ),
      ];
    } else {
      slivers = const [
        SliverToBoxAdapter(
          child: AbsencesSkeleton(key: ValueKey('vacations-loading')),
        ),
      ];
    }

    return AbsencesScaffold(
      key: const ValueKey('vacations-screen'),
      title: l10n.screenVacations,
      intro: featureOn && (state?.canUseVacations ?? true)
          ? l10n.absencesVacationsIntro
          : null,
      onRefresh: () => _refresh(teamId),
      slivers: slivers,
    );
  }

  List<Widget> _content(
    int teamId,
    AbsencesState state, {
    required bool featureOn,
  }) {
    final l10n = AppLocalizations.of(context);
    final vacations = state.vacations;

    if (!featureOn && vacations.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('vacations-feature-off'),
            icon: PhosphorIconsDuotone.island,
            title: l10n.absencesVacationsFeatureOff,
          ),
        ),
      ];
    }
    if (featureOn && !state.canUseVacations && vacations.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('vacations-no-player'),
            icon: PhosphorIconsDuotone.userCircle,
            title: l10n.absencesNoPlayerTitle,
            description: l10n.absencesNoPlayerBody,
          ),
        ),
      ];
    }

    final canAdd = featureOn && state.canUseVacations;
    return [
      if (!featureOn)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              key: const ValueKey('vacations-feature-off-notice'),
              child: Text(
                '${l10n.absencesVacationsFeatureOff} '
                '${l10n.absencesVacationsFeatureOffBody}',
              ),
            ),
          ),
        ),
      if (vacations.isEmpty)
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('vacations-empty'),
            icon: PhosphorIconsDuotone.island,
            title: l10n.absencesVacationsEmpty,
          ),
        )
      else
        SliverList.separated(
          itemCount: vacations.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final vacation = vacations[index];
            return _VacationTile(
              vacation: vacation,
              removing: _removing.contains(vacation.id),
              onRemove: () => _remove(teamId, vacation),
            );
          },
        ),
      if (canAdd)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: PrimaryButton(
              key: const ValueKey('vacations-add'),
              label: l10n.absencesVacationAdd,
              icon: const Icon(PhosphorIconsBold.plus, size: 18),
              expand: true,
              onPressed: () => _add(teamId),
            ),
          ),
        ),
    ];
  }
}

class _VacationTile extends StatelessWidget {
  const _VacationTile({
    required this.vacation,
    required this.removing,
    required this.onRemove,
  });

  final ProfileVacation vacation;
  final bool removing;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final note = vacation.note?.trim();
    return AppCard(
      key: ValueKey('vacation-${vacation.id}'),
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
      child: Row(
        children: [
          Icon(PhosphorIconsDuotone.island, color: t.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.absencesVacationRange(
                    formatAbsenceDate(vacation.startsOn),
                    formatAbsenceDate(vacation.endsOn),
                  ),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: t.ink,
                  ),
                ),
                if (note != null && note.isNotEmpty)
                  Text(note, style: TextStyle(fontSize: 13, color: t.muted)),
              ],
            ),
          ),
          if (removing)
            const Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            IconButton(
              key: ValueKey('vacation-remove-${vacation.id}'),
              tooltip: l10n.absencesVacationRemoveLabel,
              onPressed: onRemove,
              icon: const Icon(
                PhosphorIconsRegular.trash,
                color: StatusColors.red600,
              ),
            ),
        ],
      ),
    );
  }
}
