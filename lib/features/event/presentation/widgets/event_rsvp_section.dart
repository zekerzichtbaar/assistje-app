import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../agenda/data/models/agenda_models.dart';
import '../../../agenda/presentation/widgets/event_card.dart' show rsvpLabel;
import '../../data/models/event_detail_models.dart';
import 'event_section_card.dart';

/// Je eigen RSVP op de eventpagina: één knop per antwoord dat bij dit event
/// hoort. Vast (grijs, niet tikbaar) als `can_change` uit staat.
class EventRsvpSection extends StatelessWidget {
  const EventRsvpSection({
    super.key,
    required this.event,
    required this.onRsvp,
  });

  final EventDetail event;
  final ValueChanged<AttendanceStatus> onRsvp;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final options = event.rsvpStatuses
        .where((s) => s != AttendanceStatus.pending)
        .toList();
    final locked = !event.canChange;
    final reason = event.myReason;

    return Column(
      key: const ValueKey('event-rsvp'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            for (var i = 0; i < options.length; i++) ...[
              if (i > 0) const SizedBox(width: 8),
              Expanded(
                child: _RsvpChoice(
                  key: ValueKey('event-rsvp-${options[i].name}'),
                  label: rsvpLabel(l10n, options[i]),
                  status: options[i],
                  selected: event.myStatus == options[i],
                  onTap: locked ? null : () => onRsvp(options[i]),
                ),
              ),
            ],
          ],
        ),
        if (reason != null &&
            reason.isNotEmpty &&
            (event.myStatus?.needsReason ?? false))
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              l10n.eventDetailMyReason(reason),
              key: const ValueKey('event-my-reason'),
              style: TextStyle(fontSize: 13, color: t.muted),
            ),
          ),
        if (locked)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              l10n.eventDetailRsvpLocked,
              key: const ValueKey('event-rsvp-locked'),
              style: TextStyle(fontSize: 12, color: t.muted),
            ),
          ),
      ],
    );
  }
}

class _RsvpChoice extends StatelessWidget {
  const _RsvpChoice({
    super.key,
    required this.label,
    required this.status,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final AttendanceStatus status;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final style = eventStatusStyle(context, status);
    final bg = selected ? style.solid : t.sunken;
    final fg = selected ? style.onSolid : t.inkSoft;
    return Semantics(
      button: true,
      selected: selected,
      enabled: onTap != null,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Opacity(
          opacity: onTap == null ? 0.6 : 1,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: 40,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusLg),
            ),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: fg,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
