import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../agenda/data/models/agenda_models.dart';
import 'event_section_card.dart';

/// De opkomst (`ResponsesCard` in de PWA): een balk per antwoord, de
/// legenda met tellers en hoeveel er gereageerd hebben.
class EventResponsesCard extends StatelessWidget {
  const EventResponsesCard({
    super.key,
    required this.counts,
    this.guestsPresent = 0,
    this.footer,
  });

  final AttendanceCounts counts;
  final int guestsPresent;
  final Widget? footer;

  static const List<AttendanceStatus> order = [
    AttendanceStatus.present,
    AttendanceStatus.absent,
    AttendanceStatus.nonplay,
    AttendanceStatus.pending,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final total = counts.total;

    return EventSectionCard(
      key: const ValueKey('event-responses'),
      title: l10n.eventDetailResponsesTitle,
      trailing: Text(
        l10n.eventDetailResponded(counts.responded, total),
        key: const ValueKey('event-responded'),
        style: TextStyle(fontSize: 12, color: t.muted),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
              child: SizedBox(
                height: 8,
                child: total == 0
                    ? ColoredBox(color: t.line)
                    : Row(
                        children: [
                          for (final s in order)
                            if (counts[s] > 0)
                              Expanded(
                                flex: counts[s],
                                child: ColoredBox(
                                  color: eventStatusStyle(context, s).bar,
                                ),
                              ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 14,
              runSpacing: 6,
              children: [
                for (final s in order)
                  _Legend(
                    key: ValueKey('event-count-${s.name}'),
                    color: eventStatusStyle(context, s).bar,
                    label: eventStatusLabel(l10n, s),
                    count: counts[s],
                  ),
              ],
            ),
            if (guestsPresent > 0)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  l10n.eventDetailGuestsPresent(guestsPresent),
                  style: const TextStyle(
                    fontSize: 12,
                    color: StatusColors.emerald600,
                  ),
                ),
              ),
            if (footer != null) ...[const SizedBox(height: 12), footer!],
          ],
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({
    super.key,
    required this.color,
    required this.label,
    required this.count,
  });

  final Color color;
  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 13, color: t.inkSoft)),
        const SizedBox(width: 4),
        Text(
          '$count',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: t.ink,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
