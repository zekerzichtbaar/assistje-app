import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../schedule/application/schedule_controller.dart';
import '../../../schedule/presentation/widgets/schedule_fields.dart';
import '../../application/event_detail_controller.dart';
import '../../data/models/event_detail_models.dart';

/// Het pad naar het formulier om [eventId] te bewerken.
String scheduleEditPath(int eventId) => '${AppRoutes.schedule}?event=$eventId';

/// De beheerknoppen van de trainer (kop van `EventDetail.tsx`): bewerken,
/// afgelasten of "gaat toch door" (alleen als het event niet van de bond
/// komt) en verwijderen, met bevestiging bij afgelasten en verwijderen.
///
/// Het scherm toont dit alleen voor een trainer van een niet-demoteam.
class EventTrainerActions extends ConsumerStatefulWidget {
  const EventTrainerActions({
    super.key,
    required this.eventKey,
    required this.event,
  });

  final EventKey eventKey;
  final EventDetail event;

  @override
  ConsumerState<EventTrainerActions> createState() =>
      _EventTrainerActionsState();
}

class _EventTrainerActionsState extends ConsumerState<EventTrainerActions> {
  bool _busy = false;

  int get _teamId => widget.eventKey.teamId;
  int get _eventId => widget.eventKey.eventId;

  void _edit() {
    unawaited(Haptics.light());
    unawaited(context.push(scheduleEditPath(_eventId)));
  }

  Future<void> _toggleCancel() async {
    final l10n = AppLocalizations.of(context);
    final cancelled = widget.event.isCancelled;
    final ok = await confirmSchedule(
      context,
      title: cancelled
          ? l10n.scheduleUncancelConfirmTitle
          : l10n.scheduleCancelConfirmTitle,
      message: cancelled
          ? l10n.scheduleUncancelConfirmBody
          : l10n.scheduleCancelConfirmBody,
      confirmLabel: cancelled
          ? l10n.scheduleUncancelConfirm
          : l10n.scheduleActionCancel,
      destructive: !cancelled,
    );
    if (!ok || !mounted) return;
    setState(() => _busy = true);
    final writer = ref.read(scheduleWriterProvider);
    final outcome = cancelled
        ? await writer.uncancel(_teamId, _eventId)
        : await writer.cancel(_teamId, _eventId);
    if (!mounted) return;
    setState(() => _busy = false);
    if (outcome.result != null) {
      showScheduleSuccess(
        context,
        cancelled ? l10n.scheduleUncancelled : l10n.scheduleCancelled,
      );
    } else {
      showScheduleError(
        context,
        cancelled ? l10n.scheduleUncancelFailed : l10n.scheduleCancelFailed,
        outcome.error,
      );
    }
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmSchedule(
      context,
      title: l10n.scheduleDeleteConfirmTitle,
      message: l10n.scheduleDeleteConfirmBody,
      confirmLabel: l10n.scheduleActionDelete,
      destructive: true,
    );
    if (!ok || !mounted) return;
    setState(() => _busy = true);
    final error = await ref
        .read(scheduleWriterProvider)
        .delete(_teamId, _eventId);
    if (!mounted) return;
    setState(() => _busy = false);
    if (error != null) {
      showScheduleError(context, l10n.scheduleDeleteFailed, error);
      return;
    }
    showScheduleSuccess(context, l10n.scheduleDeleted);
    context.go(AppRoutes.agenda);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cancelled = widget.event.isCancelled;
    // Of het event met de hand afgelast mag worden staat niet in het
    // event-detail-model; tot het bekend is blijft de knop weg.
    final canCancel =
        ref.watch(scheduleEventProvider(widget.eventKey)).value?.canCancel ??
        false;
    final enabled = !_busy;

    return Wrap(
      key: const ValueKey('event-trainer-actions'),
      spacing: 8,
      runSpacing: 8,
      children: [
        _TrainerPill(
          key: const ValueKey('event-trainer-edit'),
          label: l10n.scheduleActionEdit,
          icon: PhosphorIconsDuotone.notePencil,
          onTap: enabled ? _edit : null,
        ),
        if (canCancel)
          _TrainerPill(
            key: ValueKey(
              cancelled ? 'event-trainer-uncancel' : 'event-trainer-cancel',
            ),
            label: cancelled
                ? l10n.scheduleActionUncancel
                : l10n.scheduleActionCancel,
            icon: cancelled
                ? PhosphorIconsBold.arrowCounterClockwise
                : PhosphorIconsDuotone.calendarX,
            onTap: enabled ? _toggleCancel : null,
          ),
        _TrainerPill(
          key: const ValueKey('event-trainer-delete'),
          label: l10n.scheduleActionDelete,
          icon: PhosphorIconsDuotone.trash,
          destructive: true,
          onTap: enabled ? _delete : null,
        ),
      ],
    );
  }
}

class _TrainerPill extends StatelessWidget {
  const _TrainerPill({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.destructive = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final fg = destructive
        ? (dark ? const Color(0xFFF87171) : StatusColors.red600)
        : t.inkSoft;
    return Semantics(
      button: true,
      child: Material(
        color: t.surface,
        shape: StadiumBorder(side: BorderSide(color: t.surfaceHairline)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PhosphorIcon(icon, size: 16, color: fg),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: fg,
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
