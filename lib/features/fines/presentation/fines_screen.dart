import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/fines_controller.dart';
import '../application/money.dart';
import '../data/models/fines_models.dart';
import 'widgets/fine_form_sheet.dart';
import 'widgets/fine_types_sheet.dart';
import 'widgets/fines_ui.dart';
import 'widgets/period_name_sheet.dart';
import 'widgets/person_fines_sheet.dart';
import 'widgets/pot_entry_sheet.dart';

/// De Boetepot (`Pages/Fines` in de PWA): periodekiezer, de pot en wat er
/// open staat, één rij per persoon (tik = detail), en de potregels. De
/// penningmeester (`can_manage`) deelt boetes uit, bewerkt ze en boekt geld
/// in of uit de pot; anderen zien alleen. Via "Beheer" (ook alleen voor de
/// penningmeester) hernoemt hij de periode, begint hij een nieuwe en beheert
/// hij de boetesoorten; de lopende periode sluit hij af vanaf de kaart.
class FinesScreen extends ConsumerStatefulWidget {
  const FinesScreen({super.key});

  @override
  ConsumerState<FinesScreen> createState() => _FinesScreenState();
}

class _FinesScreenState extends ConsumerState<FinesScreen> {
  FinesController _controller(int teamId) =>
      ref.read(finesControllerProvider(teamId).notifier);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showFinesError(
        context,
        AppLocalizations.of(context).finesLoadError,
        error,
      );
    }
  }

  Future<void> _selectPeriod(int teamId, int periodId) async {
    unawaited(Haptics.selection());
    final error = await _controller(teamId).selectPeriod(periodId);
    if (error != null && mounted) {
      showFinesError(
        context,
        AppLocalizations.of(context).finesPeriodSwitchFailed,
        error,
      );
    }
  }

  Future<void> _giveFine(int teamId, FinesOverview overview) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    var count = 0;
    final done = await showFineFormSheet(
      context,
      people: overview.countingRows,
      types: overview.activeFineTypes,
      onSubmit: (draft) async {
        final result = await _controller(teamId).recordFines(
          targets: draft.targets,
          typeId: draft.typeId,
          amountCents: draft.amountCents,
          description: draft.description,
        );
        count = result.count;
        return result.error;
      },
    );
    if ((done ?? false) && mounted) {
      showFinesSuccess(context, l10n.finesRecorded(count));
    }
  }

  Future<void> _potEntry(int teamId, {PotLine? entry}) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final controller = _controller(teamId);
    final entryId = entry?.id;
    var deleted = false;
    final done = await showPotEntrySheet(
      context,
      entry: entry,
      onSave: (draft) => entryId == null
          ? controller.createPotEntry(draft)
          : controller.updatePotEntry(entryId, draft),
      onDelete: entryId == null
          ? null
          : () async {
              final error = await controller.deletePotEntry(entryId);
              deleted = error == null;
              return error;
            },
    );
    if ((done ?? false) && mounted) {
      showFinesSuccess(context, deleted ? l10n.finesDeleted : l10n.finesSaved);
    }
  }

  /// Het "Beheer"-menu (`optionsOpen` in de PWA).
  Future<void> _manage(int teamId, FinesOverview overview) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final choice = await showAppSheet<_ManageAction>(
      context: context,
      title: l10n.finesManage,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ManageTile(
            key: const ValueKey('fines-manage-types'),
            icon: PhosphorIconsDuotone.currencyEur,
            label: l10n.finesManageTypes,
            onTap: () => Navigator.of(context).pop(_ManageAction.types),
          ),
          _ManageTile(
            key: const ValueKey('fines-manage-rename'),
            icon: PhosphorIconsDuotone.pencilSimple,
            label: l10n.finesRenamePeriod,
            onTap: () => Navigator.of(context).pop(_ManageAction.rename),
          ),
          _ManageTile(
            key: const ValueKey('fines-manage-new-period'),
            icon: PhosphorIconsDuotone.calendarPlus,
            label: l10n.finesNewPeriod,
            onTap: () => Navigator.of(context).pop(_ManageAction.newPeriod),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
    if (choice == null || !mounted) return;
    switch (choice) {
      case _ManageAction.types:
        final saved = await showFineTypesSheet(context, teamId: teamId);
        if ((saved ?? false) && mounted) {
          showFinesSuccess(context, l10n.finesSaved);
        }
      case _ManageAction.rename:
        final period = overview.period;
        final saved = await showPeriodNameSheet(
          context,
          title: l10n.finesRenamePeriod,
          label: l10n.finesPeriodNameLabel,
          note: l10n.finesRenameNote,
          submitLabel: l10n.finesSave,
          initial: period.name,
          onSubmit: (name) => _controller(teamId).renamePeriod(period.id, name),
        );
        if ((saved ?? false) && mounted) {
          showFinesSuccess(context, l10n.finesSaved);
        }
      case _ManageAction.newPeriod:
        final created = await showPeriodNameSheet(
          context,
          title: l10n.finesNewPeriod,
          label: l10n.finesNewPeriodLabel,
          note: l10n.finesNewPeriodNote,
          submitLabel: l10n.finesNewPeriodSubmit,
          onSubmit: (name) => _controller(teamId).createPeriod(name),
        );
        if ((created ?? false) && mounted) {
          showFinesSuccess(context, l10n.finesPeriodCreated);
        }
    }
  }

  /// De getoonde (lopende) periode afsluiten, na bevestiging.
  Future<void> _closePeriod(int teamId, FinePeriod period) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmFinesAction(
      context,
      message: l10n.finesClosePeriodConfirm(period.name),
      confirmLabel: l10n.finesClosePeriod,
      destructive: true,
    );
    if (!ok || !mounted) return;
    final error = await _controller(teamId).closePeriod(period.id);
    if (!mounted) return;
    if (error == null) {
      showFinesSuccess(context, l10n.finesPeriodClosedToast);
    } else if (!finesShowForbidden(context, error)) {
      showFinesError(context, l10n.finesSaveFailed, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(finesControllerProvider(teamId));
    final state = async.value;

    final List<Widget> content;
    if (state != null) {
      content = _content(teamId, state);
    } else if (async.hasError) {
      content = [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('fines-error'),
            icon: PhosphorIconsDuotone.warningCircle,
            title: l10n.finesLoadError,
            description: finesErrorText(l10n, async.error),
            action: PrimaryButton(
              key: const ValueKey('fines-retry'),
              label: l10n.retry,
              onPressed: () => _refresh(teamId),
            ),
          ),
        ),
      ];
    } else {
      content = const [
        SliverToBoxAdapter(
          child: Column(
            key: ValueKey('fines-loading'),
            children: [
              Skeleton(height: 120, radius: AssistjeTokens.radius2xl),
              SizedBox(height: 12),
              SkeletonList(count: 4),
            ],
          ),
        ),
      ];
    }

    return Scaffold(
      key: const ValueKey('fines-screen'),
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
              child: Row(
                children: [
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(
                        l10n.navFines,
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
                  ),
                  if (state != null && state.overview.canManage)
                    SecondaryButton(
                      key: const ValueKey('fines-manage'),
                      label: l10n.finesManage,
                      icon: const Icon(PhosphorIconsBold.gearSix, size: 16),
                      onPressed: () => _manage(teamId, state.overview),
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

  List<Widget> _content(int teamId, FinesState state) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final overview = state.overview;
    final canManage = overview.canManage;

    return [
      if (overview.periods.length > 1)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SingleChildScrollView(
              key: const ValueKey('fines-periods'),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final period in overview.periods)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: AppPill(
                        key: ValueKey('fines-period-${period.id}'),
                        label: period.isClosed
                            ? l10n.finesPeriodClosed(period.name)
                            : period.name,
                        selected: period.id == overview.period.id,
                        onTap: state.switching
                            ? null
                            : () => _selectPeriod(teamId, period.id),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      SliverToBoxAdapter(
        child: _SummaryCard(
          overview: overview,
          onClosePeriod: canManage && !overview.period.isClosed
              ? () => _closePeriod(teamId, overview.period)
              : null,
        ),
      ),
      if (canManage)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    key: const ValueKey('fines-give'),
                    label: l10n.finesGiveFine,
                    expand: true,
                    icon: const Icon(PhosphorIconsBold.plus, size: 16),
                    onPressed: () => _giveFine(teamId, overview),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SecondaryButton(
                    key: const ValueKey('fines-add-pot'),
                    label: l10n.finesAddPotEntry,
                    expand: true,
                    onPressed: () => _potEntry(teamId),
                  ),
                ),
              ],
            ),
          ),
        ),
      SliverToBoxAdapter(
        child: FinesSectionTitle(l10n.finesPeopleTitle, color: t.muted),
      ),
      if (overview.rows.isEmpty)
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('fines-empty'),
            icon: PhosphorIconsDuotone.coins,
            title: l10n.finesEmptyTitle,
            description: l10n.finesEmptyDescription,
          ),
        )
      else
        SliverList.builder(
          itemCount: overview.rows.length,
          itemBuilder: (context, index) {
            final row = overview.rows[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: _PersonTile(
                row: row,
                onTap: () {
                  unawaited(Haptics.light());
                  unawaited(
                    showPersonFinesSheet(
                      context,
                      teamId: teamId,
                      row: row,
                      overview: overview,
                    ),
                  );
                },
              ),
            );
          },
        ),
      SliverToBoxAdapter(
        child: FinesSectionTitle(l10n.finesPotTitle, color: t.muted),
      ),
      SliverToBoxAdapter(
        child: _PotCard(
          pot: overview.pot,
          onEdit: canManage ? (line) => _potEntry(teamId, entry: line) : null,
        ),
      ),
    ];
  }
}

enum _ManageAction { types, rename, newPeriod }

class _ManageTile extends StatelessWidget {
  const _ManageTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: t.inkSoft),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: t.ink,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.overview, this.onClosePeriod});

  final FinesOverview overview;

  /// Alleen voor de penningmeester bij een lopende periode.
  final VoidCallback? onClosePeriod;

  FinePeriod get period => overview.period;

  /// `loopt sinds 1 okt 2026` of `1 jul 2026 t/m 30 sep 2026`.
  String? _periodLine(AppLocalizations l10n) {
    final starts = period.startsOn;
    if (starts == null) return null;
    final ends = period.endsOn;
    if (period.isClosed && ends != null) {
      return l10n.finesPeriodRange(finesDate(starts), finesDate(ends));
    }
    return l10n.finesPeriodRunningSince(finesDate(starts));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    Widget figure(String label, String value, Key key, {Color? color}) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 13, color: t.muted)),
            const SizedBox(height: 2),
            Text(
              value,
              key: key,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: color ?? t.ink,
              ),
            ),
          ],
        );

    return AppCard(
      key: const ValueKey('fines-summary'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: figure(
                  l10n.finesPotBalance,
                  formatCents(overview.pot.balanceCents),
                  const ValueKey('fines-balance'),
                  color: t.primary,
                ),
              ),
              Expanded(
                child: figure(
                  l10n.finesPotOpen,
                  formatCents(overview.pot.openCents),
                  const ValueKey('fines-open'),
                  color: overview.pot.openCents > 0
                      ? StatusColors.red600
                      : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(height: 1, color: t.lineSoft),
          const SizedBox(height: 12),
          Text(
            '${l10n.finesPeriodTotal} · ${overview.period.name}',
            style: TextStyle(fontSize: 13, color: t.muted),
          ),
          const SizedBox(height: 2),
          Text(
            l10n.finesPeriodTotalValue(
              formatCents(overview.totals.allCents),
              formatCents(overview.totals.openCents),
            ),
            key: const ValueKey('fines-period-totals'),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: t.inkSoft,
            ),
          ),
          if (_periodLine(l10n) case final line?) ...[
            const SizedBox(height: 2),
            Text(
              line,
              key: const ValueKey('fines-period-dates'),
              style: TextStyle(fontSize: 13, color: t.muted),
            ),
          ],
          if (period.isClosed || onClosePeriod != null) ...[
            const SizedBox(height: 10),
            if (period.isClosed)
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  key: const ValueKey('fines-period-closed'),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: t.raised,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    l10n.finesPeriodClosedBadge,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: t.inkSoft,
                    ),
                  ),
                ),
              )
            else
              Align(
                alignment: Alignment.centerLeft,
                child: SecondaryButton(
                  key: const ValueKey('fines-close-period'),
                  label: l10n.finesClosePeriod,
                  icon: const Icon(PhosphorIconsBold.lockSimple, size: 14),
                  onPressed: onClosePeriod,
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _PersonTile extends StatelessWidget {
  const _PersonTile({required this.row, required this.onTap});

  final FineRow row;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final subtitle = [
      l10n.finesCount(row.count),
      if (row.isStaff) l10n.finesStaff,
      if (!row.counting) l10n.finesNotCounting,
    ].join(' · ');

    return AppCard(
      key: ValueKey('fines-row-${row.key}'),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      onTap: onTap,
      child: Row(
        children: [
          AppAvatar(name: row.name, imageUrl: row.avatarUrl),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.shirtNumber == null
                      ? row.name
                      : '${row.name}  #${row.shirtNumber}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: row.counting ? t.ink : t.muted,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: t.muted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formatCents(row.totalCents),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: t.ink,
                ),
              ),
              if (row.openCents > 0)
                Text(
                  l10n.finesOpenAmount(formatCents(row.openCents)),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: StatusColors.red600,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PotCard extends StatelessWidget {
  const _PotCard({required this.pot, this.onEdit});

  final FinePot pot;

  /// Alleen voor de penningmeester: tik op een handmatige boeking.
  final void Function(PotLine line)? onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    if (pot.lines.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          l10n.finesPotEmpty,
          key: const ValueKey('fines-pot-empty'),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: t.muted),
        ),
      );
    }
    final onEdit = this.onEdit;
    return AppCard(
      key: const ValueKey('fines-pot'),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          for (final (index, line) in pot.lines.indexed) ...[
            if (index > 0)
              Divider(height: 1, indent: 16, endIndent: 16, color: t.lineSoft),
            InkWell(
              key: ValueKey('pot-line-${line.key}'),
              onTap: onEdit != null && line.isEditable
                  ? () => onEdit(line)
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            line.description,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: t.ink,
                            ),
                          ),
                          Text(
                            [
                              if (line.occurredOn case final date?)
                                finesDate(date),
                              if (line.createdBy case final by?)
                                l10n.finesPotBy(by),
                            ].join(' · '),
                            style: TextStyle(fontSize: 12, color: t.muted),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      formatSignedCents(line.amountCents),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: line.amountCents < 0
                            ? StatusColors.red600
                            : StatusColors.emerald600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
