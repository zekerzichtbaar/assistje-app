import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../agenda/data/models/agenda_models.dart';
import '../../../event/presentation/widgets/event_section_card.dart';
import '../../data/models/attendance_models.dart';

/// Het label van een antwoord in het sheet ("Openstaand" i.p.v. "Open").
String attendanceStatusLabel(AppLocalizations l10n, AttendanceStatus status) =>
    status == AttendanceStatus.pending
    ? l10n.attendanceStatusPending
    : eventStatusLabel(l10n, status);

/// Kies het antwoord van [row] (namens hem). Geeft het gekozen antwoord
/// terug, of `null` als het sheet weggeveegd is. [options] zijn de
/// antwoorden die bij dit event horen.
Future<AttendanceStatus?> showAttendanceStatusSheet(
  BuildContext context, {
  required AttendanceRow row,
  required List<AttendanceStatus> options,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<AttendanceStatus>(
    context: context,
    title: l10n.attendanceSetTitle(row.name),
    builder: (context) => _StatusOptions(row: row, options: options),
  );
}

class _StatusOptions extends StatelessWidget {
  const _StatusOptions({required this.row, required this.options});

  final AttendanceRow row;
  final List<AttendanceStatus> options;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.attendanceSetHint,
          style: TextStyle(fontSize: 13, color: t.muted),
        ),
        const SizedBox(height: 12),
        for (final status in options) ...[
          _OptionButton(
            status: status,
            label: attendanceStatusLabel(l10n, status),
            selected: row.status == status,
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}

class _OptionButton extends StatelessWidget {
  const _OptionButton({
    required this.status,
    required this.label,
    required this.selected,
  });

  final AttendanceStatus status;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final style = eventStatusStyle(context, status);
    final background = selected
        ? (status == AttendanceStatus.pending ? t.inkSoft : style.solid)
        : t.raised;
    final foreground = selected
        ? (status == AttendanceStatus.pending ? t.surface : style.onSolid)
        : t.ink;
    return Semantics(
      selected: selected,
      button: true,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: ValueKey('attendance-set-${status.name}'),
          onTap: () {
            Haptics.selection();
            Navigator.of(context).pop(status);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: foreground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
