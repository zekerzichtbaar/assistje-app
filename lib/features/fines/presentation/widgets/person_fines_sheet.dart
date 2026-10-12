import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/fines_controller.dart';
import '../../application/money.dart';
import '../../data/models/fines_models.dart';
import 'fine_edit_sheet.dart';
import 'fine_form_sheet.dart';
import 'fines_ui.dart';

/// De query voor het detail van [row] in de getoonde periode.
PersonFinesQuery personQueryFor(int teamId, FineRow row, int periodId) => (
  teamId: teamId,
  id: row.playerId ?? row.userId ?? 0,
  staff: row.playerId == null,
  periodId: periodId,
);

/// Het boetedetail van één persoon als sheet.
Future<void> showPersonFinesSheet(
  BuildContext context, {
  required int teamId,
  required FineRow row,
  required FinesOverview overview,
}) => showAppSheet<void>(
  context: context,
  title: row.name,
  scrollable: true,
  builder: (context) =>
      PersonFinesView(teamId: teamId, row: row, overview: overview),
);

/// Totalen en de boetes van één speler of staflid. De penningmeester kan
/// een boete bewerken of verwijderen, en deze persoon een boete geven.
class PersonFinesView extends ConsumerWidget {
  const PersonFinesView({
    super.key,
    required this.teamId,
    required this.row,
    required this.overview,
  });

  final int teamId;
  final FineRow row;
  final FinesOverview overview;

  PersonFinesQuery get _query =>
      personQueryFor(teamId, row, overview.period.id);

  FinesController _controller(WidgetRef ref) =>
      ref.read(finesControllerProvider(teamId).notifier);

  Future<void> _edit(BuildContext context, WidgetRef ref, Fine fine) async {
    final l10n = AppLocalizations.of(context);
    var deleted = false;
    final done = await showFineEditSheet(
      context,
      fine: fine,
      onSave: (edit) => _controller(ref).updateFine(
        fine.id,
        amountCents: edit.amountCents,
        description: edit.description,
        clearDescription: edit.description == null,
        status: edit.status,
      ),
      onDelete: () async {
        final error = await _controller(ref).deleteFine(fine.id);
        deleted = error == null;
        return error;
      },
    );
    if ((done ?? false) && context.mounted) {
      showFinesSuccess(context, deleted ? l10n.finesDeleted : l10n.finesSaved);
    }
  }

  Future<void> _give(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    var count = 0;
    final done = await showFineFormSheet(
      context,
      people: overview.countingRows,
      types: overview.activeFineTypes,
      preselectedKey: row.key,
      onSubmit: (draft) async {
        final result = await _controller(ref).recordFines(
          targets: draft.targets,
          typeId: draft.typeId,
          amountCents: draft.amountCents,
          description: draft.description,
        );
        count = result.count;
        return result.error;
      },
    );
    if ((done ?? false) && context.mounted) {
      showFinesSuccess(context, l10n.finesRecorded(count));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(personFinesProvider(_query));
    final data = async.value;

    if (data == null) {
      if (async.hasError) {
        return EmptyState(
          key: const ValueKey('person-fines-error'),
          icon: PhosphorIconsDuotone.warningCircle,
          title: l10n.finesPersonLoadError,
          description: finesErrorText(l10n, async.error),
          action: PrimaryButton(
            key: const ValueKey('person-fines-retry'),
            label: l10n.retry,
            onPressed: () => ref.invalidate(personFinesProvider(_query)),
          ),
        );
      }
      return const Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: SkeletonList(count: 3),
      );
    }

    final canManage = data.canManage;
    final canGive =
        canManage &&
        row.counting &&
        overview.countingRows.any((r) => r.key == row.key);

    return Column(
      key: const ValueKey('person-fines-sheet'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            AppAvatar(
              name: data.person.name,
              imageUrl: data.person.avatarUrl,
              size: 48,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.period.name,
                    style: TextStyle(fontSize: 13, color: t.muted),
                  ),
                  Text(
                    formatCents(data.totals.allCents),
                    key: const ValueKey('person-fines-total'),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: t.ink,
                    ),
                  ),
                  if (data.totals.openCents > 0)
                    Text(
                      l10n.finesOpenAmount(formatCents(data.totals.openCents)),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: StatusColors.red600,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        if (canGive) ...[
          const SizedBox(height: 12),
          PrimaryButton(
            key: const ValueKey('person-fines-give'),
            label: l10n.finesGiveFine,
            expand: true,
            onPressed: () => unawaited(_give(context, ref)),
          ),
        ],
        const SizedBox(height: 12),
        if (data.fines.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text(
              l10n.finesPersonEmpty,
              key: const ValueKey('person-fines-empty'),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: t.muted),
            ),
          ),
        for (final fine in data.fines)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: _FineTile(
              fine: fine,
              onTap: canManage
                  ? () => unawaited(_edit(context, ref, fine))
                  : null,
            ),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _FineTile extends StatelessWidget {
  const _FineTile({required this.fine, this.onTap});

  final Fine fine;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final meta = [
      if (fine.event != null) fine.event!.title,
      if (fine.event?.startsAt ?? fine.createdAt case final date?)
        finesDate(date),
      if (fine.createdBy != null) fine.createdBy!,
    ].join(' · ');
    return AppCard(
      key: ValueKey('fine-${fine.id}'),
      color: t.raised,
      padding: const EdgeInsets.all(14),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fine.typeLabel,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: t.ink,
                  ),
                ),
                if (fine.description case final description?
                    when description.isNotEmpty)
                  Text(
                    description,
                    style: TextStyle(fontSize: 14, color: t.inkSoft),
                  ),
                if (meta.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      meta,
                      style: TextStyle(fontSize: 12, color: t.muted),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatCents(fine.amountCents),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: t.ink,
                ),
              ),
              const SizedBox(height: 4),
              FineStatusBadge(status: fine.status),
            ],
          ),
        ],
      ),
    );
  }
}
