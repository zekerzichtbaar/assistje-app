import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../agenda/data/models/agenda_models.dart';
import '../../../agenda/presentation/widgets/event_card.dart' show LiveBadge;
import '../../data/models/event_detail_models.dart';

/// Woord op de typebadge (bij een beker-/oefenwedstrijd dát woord).
String eventDetailTypeLabel(AppLocalizations l10n, EventDetail event) {
  if (event.isMatch) {
    return switch (event.competition) {
      'cup' => l10n.competitionCup,
      'friendly' => l10n.competitionFriendly,
      'league' => l10n.eventDetailCompetitionLeague,
      _ => l10n.eventTypeMatch,
    };
  }
  return switch (event.type) {
    EventType.training => l10n.eventTypeTraining,
    EventType.activity => l10n.eventTypeActivity,
    _ => l10n.eventTypeMatch,
  };
}

/// De titel van het scherm: bij een wedstrijd "thuis - uit", anders de titel.
String eventDetailTitle(AppLocalizations l10n, EventDetail event) {
  if (event.isMatch && (event.homeTeam != null || event.awayTeam != null)) {
    return '${event.homeTeam ?? ''} - ${event.awayTeam ?? ''}';
  }
  final title = event.title.trim();
  return title.isEmpty ? eventDetailTypeLabel(l10n, event) : title;
}

/// "zaterdag 11 oktober 2026".
String eventDetailFullDate(DateTime date) =>
    DateFormat('EEEE d MMMM y', 'nl').format(date.toLocal());

/// De wedstrijdinfo-kaart (`Wedstrijdinfo` in de PWA): type, datum en tijden,
/// locatie, notities, afgelast en de bond-info. RSVP en knoppen komen eronder
/// als [children].
class EventInfoCard extends StatelessWidget {
  const EventInfoCard({
    super.key,
    required this.event,
    this.children = const [],
  });

  final EventDetail event;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final e = event;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final soft = TextStyle(fontSize: 14, color: t.inkSoft);
    final strong = TextStyle(
      fontWeight: FontWeight.w600,
      color: t.ink,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
    String time(DateTime d) => DateTile.timeLabel(d.toLocal());

    final hasScore = e.isMatch && (e.homeScore != null || e.awayScore != null);
    final sportlink = e.sportlink;

    final times = <InlineSpan>[
      if (e.meetAt != null) ...[
        TextSpan(text: '${l10n.eventDetailMeetAt} '),
        TextSpan(text: time(e.meetAt!), style: strong),
        TextSpan(
          text: '  ·  ',
          style: TextStyle(color: t.muted),
        ),
      ],
      TextSpan(text: '${l10n.eventDetailStartsAt} '),
      TextSpan(text: time(e.startsAt), style: strong),
      if (e.endsAt != null) ...[
        TextSpan(
          text: '  ·  ',
          style: TextStyle(color: t.muted),
        ),
        TextSpan(text: '${l10n.eventDetailEndsAt} '),
        TextSpan(text: time(e.endsAt!), style: strong),
      ],
    ];

    return AppCard(
      key: const ValueKey('event-info'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if (e.isLive && e.live != null)
                LiveBadge(live: e.live!)
              else
                _TypeBadge(event: e),
              if (e.isMatch && e.isHome != null)
                _Chip(
                  label: e.isHome!
                      ? l10n.eventDetailHome
                      : l10n.eventDetailAway,
                ),
              if (hasScore)
                Text(
                  '${e.homeScore ?? 0} - ${e.awayScore ?? 0}',
                  key: const ValueKey('event-score'),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: t.ink,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            eventDetailFullDate(e.startsAt),
            key: const ValueKey('event-date'),
            style: soft,
          ),
          const SizedBox(height: 4),
          Text.rich(
            TextSpan(children: times),
            key: const ValueKey('event-times'),
            style: soft,
          ),
          if (e.venue != null && e.venue!.trim().isNotEmpty) ...[
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: PhosphorIcon(
                    PhosphorIconsDuotone.mapPin,
                    size: 14,
                    color: t.muted,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    e.venue!,
                    key: const ValueKey('event-venue'),
                    style: TextStyle(fontSize: 14, color: t.ink),
                  ),
                ),
              ],
            ),
          ],
          if (e.isCancelled) ...[
            const SizedBox(height: 8),
            Text(
              l10n.eventDetailCancelled,
              key: const ValueKey('event-cancelled'),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: dark ? StatusColors.red400 : StatusColors.red700,
              ),
            ),
          ],
          if (e.notes != null && e.notes!.trim().isNotEmpty) ...[
            const SizedBox(height: 12),
            Divider(height: 1, color: t.lineSoft),
            const SizedBox(height: 12),
            Text(
              e.notes!,
              key: const ValueKey('event-notes'),
              style: TextStyle(fontSize: 14, color: t.ink),
            ),
          ],
          if (sportlink != null && !sportlink.isEmpty) ...[
            const SizedBox(height: 12),
            Divider(height: 1, color: t.lineSoft),
            const SizedBox(height: 12),
            _SportlinkRows(info: sportlink),
          ],
          for (final child in children) ...[
            const SizedBox(height: 12),
            Divider(height: 1, color: t.lineSoft),
            const SizedBox(height: 12),
            child,
          ],
        ],
      ),
    );
  }
}

class _SportlinkRows extends StatelessWidget {
  const _SportlinkRows({required this.info});

  final SportlinkInfo info;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final rows = <(String, String?)>[
      (l10n.eventDetailSportlinkField, info.field),
      (l10n.eventDetailSportlinkDressingRoom, info.dressingRoom),
      (l10n.eventDetailSportlinkReferee, info.referee),
    ];
    return Column(
      key: const ValueKey('event-sportlink'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final (label, value) in rows)
          if (value != null && value.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 96,
                    child: Text(
                      label,
                      style: TextStyle(fontSize: 14, color: t.muted),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 14, color: t.ink),
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}

class _TypeBadge extends StatelessWidget {
  const _TypeBadge({required this.event});

  final EventDetail event;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final match = event.isMatch;
    final icon = switch (event.type) {
      EventType.training => PhosphorIconsDuotone.strategy,
      EventType.activity => PhosphorIconsDuotone.confetti,
      _ => PhosphorIconsDuotone.trophy,
    };
    final fg = match ? t.primary : t.inkSoft;
    final bg = match
        ? Color.alphaBlend(t.primary.withValues(alpha: 0.12), t.surface)
        : t.sunken;
    return Container(
      key: const ValueKey('event-type-badge'),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PhosphorIcon(icon, size: 14, color: fg),
          const SizedBox(width: 6),
          Text(
            eventDetailTypeLabel(l10n, event).toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: t.sunken,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: t.inkSoft,
        ),
      ),
    );
  }
}
