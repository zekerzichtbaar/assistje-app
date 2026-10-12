import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../event/presentation/widgets/event_section_card.dart';
import '../../data/models/attendance_models.dart';

/// Eén persoon in de aanwezigheidslijst (`Trainer/Events/Attendance.tsx`):
/// rugnummer, avatar, naam met badges (gast, staf, vakantie, vaste dag),
/// positie en het huidige antwoord. Tikken opent het antwoord-sheet; bij
/// een gast staat er een prullenbak naast.
class AttendanceRowTile extends StatelessWidget {
  const AttendanceRowTile({
    super.key,
    required this.row,
    required this.positionLabel,
    this.onTap,
    this.onRemove,
  });

  final AttendanceRow row;

  /// Wat er onder de naam staat (positienaam uit het sportprofiel).
  final String positionLabel;
  final VoidCallback? onTap;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final style = eventStatusStyle(context, row.status);
    final vacation = row.vacationNote;

    final badges = <Widget>[
      if (row.isGuest)
        _Badge(
          label: l10n.attendanceGuestBadge,
          background: dark ? const Color(0x33F59E0B) : StatusColors.amber100,
          foreground: dark ? StatusColors.amber200 : StatusColors.amber900,
        ),
      if (row.isStaff)
        _Badge(
          label: l10n.attendanceStaffBadge,
          background: dark ? const Color(0x336366F1) : const Color(0xFFE0E7FF),
          foreground: dark ? const Color(0xFFC7D2FE) : const Color(0xFF312E81),
        ),
      if (vacation != null && vacation.isNotEmpty)
        _Badge(
          key: ValueKey('attendance-vacation-${row.key}'),
          label: vacation,
          icon: PhosphorIconsDuotone.island,
          background: dark ? const Color(0x330EA5E9) : StatusColors.sky100,
          foreground: dark ? const Color(0xFF7DD3FC) : const Color(0xFF075985),
        ),
      if (row.standingAbsent)
        _Badge(
          key: ValueKey('attendance-standing-${row.key}'),
          label: l10n.attendanceStandingBadge,
          icon: PhosphorIconsDuotone.calendarX,
          background: t.raised,
          foreground: t.inkSoft,
        ),
    ];

    return Semantics(
      button: onTap != null,
      child: InkWell(
        key: ValueKey('attendance-row-${row.key}'),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: 22,
                child: Text(
                  row.shirtNumber?.toString() ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: t.muted,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              AppAvatar(name: row.name, imageUrl: row.avatarUrl),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      row.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: t.ink,
                      ),
                    ),
                    if (badges.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: badges,
                        ),
                      ),
                    if (positionLabel.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          positionLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: t.muted),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              CountPill(
                key: ValueKey('attendance-status-${row.key}'),
                label: eventStatusLabel(l10n, row.status),
                background: style.softBackground,
                foreground: style.softForeground,
              ),
              if (onRemove != null)
                IconButton(
                  key: ValueKey('attendance-remove-${row.key}'),
                  tooltip: l10n.attendanceRemoveGuest,
                  onPressed: onRemove,
                  icon: PhosphorIcon(
                    PhosphorIconsDuotone.trash,
                    size: 18,
                    color: t.muted,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
    this.icon,
  });

  final String label;
  final Color background;
  final Color foreground;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusSm + 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            PhosphorIcon(icon!, size: 11, color: foreground),
            const SizedBox(width: 3),
          ],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
