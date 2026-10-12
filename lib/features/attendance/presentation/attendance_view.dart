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
import '../../agenda/data/models/agenda_models.dart';
import '../../event/application/event_detail_controller.dart';
import '../../event/presentation/widgets/event_responses_card.dart';
import '../../event/presentation/widgets/event_section_card.dart';
import '../../team/application/sport_info.dart';
import '../application/attendance_controller.dart';
import '../data/models/attendance_models.dart';
import 'widgets/attendance_row_tile.dart';
import 'widgets/attendance_status_sheet.dart';
import 'widgets/attendance_ui.dart';
import 'widgets/guest_sheet.dart';

/// De aanwezigheid van één event voor de trainer
/// (`Pages/Trainer/Events/Attendance.tsx`): de opkomst, spelers per
/// antwoord, de staf en de gasten. Tik op iemand om namens hem een antwoord
/// te zetten; gasten toevoegen en weghalen. Trekken = verversen.
class AttendanceView extends ConsumerStatefulWidget {
  const AttendanceView({super.key, required this.eventId});

  final int eventId;

  @override
  ConsumerState<AttendanceView> createState() => _AttendanceViewState();
}

class _AttendanceViewState extends ConsumerState<AttendanceView> {
  EventKey _key(int teamId) => (teamId: teamId, eventId: widget.eventId);

  AttendanceController _controller(int teamId) =>
      ref.read(attendanceControllerProvider(_key(teamId)).notifier);

  AppLocalizations get _l10n => AppLocalizations.of(context);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showAttendanceError(context, _l10n.attendanceLoadError, error);
    }
  }

  Future<void> _openRow(
    int teamId,
    EventAttendance attendance,
    AttendanceRow row,
  ) async {
    unawaited(Haptics.light());
    final status = await showAttendanceStatusSheet(
      context,
      row: row,
      options: attendance.event.settableStatuses,
    );
    if (status == null || !mounted || status == row.status) return;
    final l10n = _l10n;
    final error = await _controller(teamId).setStatus(row, status);
    if (!mounted) return;
    if (error != null) {
      showAttendanceError(context, l10n.attendanceSaveFailed, error);
    } else {
      unawaited(Haptics.success());
    }
  }

  Future<void> _addGuest(int teamId, Map<String, String> positions) async {
    unawaited(Haptics.light());
    final l10n = _l10n;
    final controller = _controller(teamId);
    final added = await showGuestSheet(
      context,
      eventKey: _key(teamId),
      positions: positions,
      onAddExisting: controller.addExistingGuest,
      onCreate: controller.createGuest,
    );
    if ((added ?? false) && mounted) {
      showAttendanceSuccess(context, l10n.attendanceGuestAdded);
    }
  }

  Future<void> _removeGuest(int teamId, AttendanceRow row) async {
    final l10n = _l10n;
    if (!await confirmAttendanceRemove(
      context,
      l10n.attendanceRemoveGuestConfirm(row.name),
    )) {
      return;
    }
    final error = await _controller(teamId).removeGuest(row);
    if (!mounted) return;
    if (error != null) {
      showAttendanceError(context, l10n.attendanceGuestFailed, error);
    } else {
      showAttendanceSuccess(context, l10n.attendanceGuestRemoved);
    }
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = _l10n;
    final t = AssistjeTokens.of(context);
    final async = ref.watch(attendanceControllerProvider(_key(teamId)));
    final attendance = async.value;
    final sport = SportInfo.of(membership);

    final List<Widget> content;
    if (attendance != null) {
      content = _content(teamId, attendance, sport);
    } else if (async.hasError) {
      content = [SliverToBoxAdapter(child: _errorState(teamId, async.error))];
    } else {
      content = const [
        SliverToBoxAdapter(
          child: Column(
            key: ValueKey('attendance-loading'),
            children: [
              Skeleton(height: 96, radius: AssistjeTokens.radius2xl),
              SizedBox(height: 12),
              SkeletonList(count: 6),
            ],
          ),
        ),
      ];
    }

    return Scaffold(
      key: const ValueKey('attendance-screen'),
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
                      l10n.screenEventAttendance,
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
                  if (attendance != null && attendance.event.title.isNotEmpty)
                    Text(
                      attendance.event.title,
                      key: const ValueKey('attendance-event-title'),
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
        key: const ValueKey('attendance-forbidden'),
        icon: PhosphorIconsDuotone.lockSimple,
        title: l10n.attendanceForbiddenTitle,
        description: l10n.attendanceForbidden,
      ),
      NotFoundException() => EmptyState(
        key: const ValueKey('attendance-not-found'),
        icon: PhosphorIconsDuotone.calendarX,
        title: l10n.attendanceNotFoundTitle,
        description: l10n.attendanceNotFound,
      ),
      _ => EmptyState(
        key: const ValueKey('attendance-error'),
        icon: PhosphorIconsDuotone.warningCircle,
        title: l10n.attendanceLoadError,
        description: attendanceErrorText(l10n, error),
        action: PrimaryButton(
          key: const ValueKey('attendance-retry'),
          label: l10n.retry,
          onPressed: () => _refresh(teamId),
        ),
      ),
    };
  }

  List<Widget> _content(
    int teamId,
    EventAttendance attendance,
    SportInfo sport,
  ) {
    final l10n = _l10n;
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final editable = attendance.event.canEdit && !attendance.event.isCancelled;

    Widget tile(AttendanceRow row) => AttendanceRowTile(
      row: row,
      positionLabel: row.isStaff
          ? row.position
          : sport.positionLabel(row.position) ?? '',
      onTap: editable && row.isEditable
          ? () => _openRow(teamId, attendance, row)
          : null,
      onRemove: editable && row.isGuest && row.playerId != null
          ? () => _removeGuest(teamId, row)
          : null,
    );

    Widget rows(List<AttendanceRow> list) => Column(
      children: [
        for (var i = 0; i < list.length; i++) ...[
          if (i > 0) Divider(height: 1, color: t.lineSoft),
          tile(list[i]),
        ],
      ],
    );

    final players = attendance.players;
    final staff = attendance.staff;
    final guests = attendance.guests;

    final children = <Widget>[
      if (!editable)
        Container(
          key: const ValueKey('attendance-locked'),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: dark
                ? StatusColors.red500.withValues(alpha: 0.1)
                : StatusColors.red50,
            borderRadius: BorderRadius.circular(AssistjeTokens.radius2xl),
          ),
          child: Text(
            attendance.event.isCancelled
                ? l10n.attendanceCancelledNotice
                : l10n.attendanceLockedNotice,
            style: TextStyle(
              fontSize: 14,
              color: dark ? const Color(0xFFFCA5A5) : const Color(0xFF991B1B),
            ),
          ),
        ),
      EventResponsesCard(
        counts: attendance.counts,
        guestsPresent: attendance.guestsPresent,
      ),
      if (editable && attendance.rows.isNotEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            l10n.attendanceTapHint,
            style: TextStyle(fontSize: 13, color: t.muted),
          ),
        ),
      for (final status in EventResponsesCard.order)
        if (players.where((r) => r.status == status).toList() case final group
            when group.isNotEmpty)
          EventSectionCard(
            key: ValueKey('attendance-group-${status.name}'),
            title: eventStatusLabel(l10n, status),
            trailing: CountPill(
              label: '${group.length}',
              background: eventStatusStyle(context, status).softBackground,
              foreground: eventStatusStyle(context, status).softForeground,
            ),
            child: rows(group),
          ),
      if (staff.isNotEmpty)
        EventSectionCard(
          key: const ValueKey('attendance-group-staff'),
          title: l10n.attendanceStaff,
          trailing: CountPill(
            label:
                '${staff.where((r) => r.status == AttendanceStatus.present).length}/${staff.length}',
            background: dark
                ? const Color(0x336366F1)
                : const Color(0xFFE0E7FF),
            foreground: dark
                ? const Color(0xFFA5B4FC)
                : const Color(0xFF4338CA),
          ),
          child: rows(staff),
        ),
      if (editable || guests.isNotEmpty)
        EventSectionCard(
          key: const ValueKey('attendance-group-guests'),
          title: l10n.attendanceGuests,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CountPill(
                label: '${attendance.guestsPresent}/${guests.length}',
                background: dark
                    ? const Color(0x33F59E0B)
                    : StatusColors.amber100,
                foreground: dark
                    ? StatusColors.amber300
                    : StatusColors.amber800,
              ),
              if (editable) ...[
                const SizedBox(width: 8),
                _AddGuestButton(
                  label: l10n.attendanceAddGuest,
                  onTap: () => _addGuest(teamId, sport.positions),
                ),
              ],
            ],
          ),
          child: guests.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    l10n.attendanceNoGuests,
                    key: const ValueKey('attendance-no-guests'),
                    style: TextStyle(fontSize: 14, color: t.muted),
                  ),
                )
              : rows(guests),
        ),
      if (attendance.rows.isEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Text(
            l10n.attendanceNoRows,
            key: const ValueKey('attendance-empty'),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: t.muted),
          ),
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

class _AddGuestButton extends StatelessWidget {
  const _AddGuestButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Semantics(
      button: true,
      child: Material(
        color: t.primary,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: const ValueKey('attendance-add-guest'),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PhosphorIcon(
                  PhosphorIconsBold.plus,
                  size: 12,
                  color: t.primaryContrast,
                ),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: t.primaryContrast,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
