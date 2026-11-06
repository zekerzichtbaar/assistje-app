import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../agenda/data/models/agenda_models.dart';
import 'event_section_card.dart';

/// De opkomst (`ResponsesCard` in de PWA): een balk per antwoord, de
/// legenda met tellers en hoeveel er gereageerd hebben.
///
/// De breuk ("x/y gereageerd") gaat over iedereen die moet reageren, staf
/// inbegrepen ([counts]). De balk en de legenda tellen alleen spelers
/// ([playerCounts]): staf is geen speler. Gasten hoeven niet te reageren en
/// staan buiten de breuk, maar spelen wél mee: die tellen op in 'Aanwezig',
/// met een chipje erbij. Bij een activiteit telt ook de aanwezige staf mee
/// ([staffPresent]) — bij een teamuitje gaat het om wie er komt, niet om wie
/// er kan spelen.
class EventResponsesCard extends StatelessWidget {
  const EventResponsesCard({
    super.key,
    required this.counts,
    this.playerCounts,
    this.guestsPresent = 0,
    this.staffPresent = 0,
    this.footer,
  });

  final AttendanceCounts counts;

  /// Alleen de spelers; zonder valt de balk terug op [counts].
  final AttendanceCounts? playerCounts;
  final int guestsPresent;

  /// Aanwezige staf die bij 'Aanwezig' opgeteld wordt (alleen bij een
  /// activiteit; de pagina geeft anders 0 mee).
  final int staffPresent;
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
    final heads = playerCounts ?? counts;
    final headsTotal = heads.total;
    final extraPresent = guestsPresent + staffPresent;
    final dark = Theme.of(context).brightness == Brightness.dark;

    return EventSectionCard(
      key: const ValueKey('event-responses'),
      title: l10n.eventDetailResponsesTitle,
      // "12/16 gereageerd" met het aantal vet; voorgelezen als
      // "12 van 16 gereageerd".
      trailing: Semantics(
        key: const ValueKey('event-responded'),
        label: l10n.eventDetailResponded(counts.responded, total),
        excludeSemantics: true,
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${counts.responded}',
                style: TextStyle(fontWeight: FontWeight.w700, color: t.ink),
              ),
              TextSpan(text: l10n.eventDetailRespondedOf(total)),
            ],
          ),
          style: TextStyle(
            fontSize: 13,
            color: t.muted,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Losse, afgeronde segmenten met een kier ertussen.
            SizedBox(
              height: 10,
              child: headsTotal == 0
                  ? _Segment(color: t.line)
                  : Row(
                      // Segmenten zonder inhoud: zonder stretch krijgen ze
                      // hoogte 0 en is de balk onzichtbaar.
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 3,
                      children: [
                        for (final s in order)
                          if (heads[s] > 0)
                            Expanded(
                              flex: heads[s],
                              child: _Segment(
                                color: eventStatusStyle(context, s).bar,
                              ),
                            ),
                      ],
                    ),
            ),
            const SizedBox(height: 12),
            // Alleen antwoorden die voorkomen staan in de legenda. 'Aanwezig'
            // staat er altijd: daar worden ook gasten en staf geteld.
            Wrap(
              spacing: 16,
              runSpacing: 6,
              children: [
                for (final s in order)
                  if (s == AttendanceStatus.present || heads[s] > 0)
                    _Legend(
                      key: ValueKey('event-count-${s.name}'),
                      color: eventStatusStyle(context, s).bar,
                      label: eventStatusLabel(l10n, s),
                      count: s == AttendanceStatus.present
                          ? heads[s] + extraPresent
                          : heads[s],
                      chips: [
                        if (s == AttendanceStatus.present && staffPresent > 0)
                          _Chip(
                            key: const ValueKey('event-count-staff-chip'),
                            label: l10n.eventDetailStaffPresent(staffPresent),
                            background: dark
                                ? StatusColors.indigo500.withValues(alpha: 0.2)
                                : StatusColors.indigo100,
                            foreground: dark
                                ? StatusColors.indigo300
                                : StatusColors.indigo700,
                          ),
                        if (s == AttendanceStatus.present && guestsPresent > 0)
                          _Chip(
                            key: const ValueKey('event-count-guests-chip'),
                            label: l10n.eventDetailGuestsPresent(guestsPresent),
                            background: dark
                                ? StatusColors.amber500.withValues(alpha: 0.2)
                                : StatusColors.amber100,
                            foreground: dark
                                ? StatusColors.amber300
                                : StatusColors.amber800,
                          ),
                      ],
                    ),
              ],
            ),
            if (footer != null) ...[const SizedBox(height: 12), footer!],
          ],
        ),
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: ShapeDecoration(color: color, shape: const StadiumBorder()),
  );
}

class _Legend extends StatelessWidget {
  const _Legend({
    super.key,
    required this.color,
    required this.label,
    required this.count,
    this.chips = const [],
  });

  final Color color;
  final String label;
  final int count;
  final List<Widget> chips;

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
        Text(label, style: TextStyle(fontSize: 15, color: t.inkSoft)),
        const SizedBox(width: 6),
        Text(
          '$count',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: t.ink,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
        for (final c in chips) ...[const SizedBox(width: 6), c],
      ],
    );
  }
}

/// Chipje achter het aanwezig-getal ("2 staf", "1 gast").
class _Chip extends StatelessWidget {
  const _Chip({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: background,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: foreground,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ),
    );
  }
}
