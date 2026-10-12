import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/agenda_items.dart';
import '../../data/models/agenda_models.dart';
import 'duty_icons.dart';

/// Labels voor de RSVP-knoppen.
String rsvpLabel(AppLocalizations l10n, AttendanceStatus status) =>
    switch (status) {
      AttendanceStatus.present => l10n.rsvpPresent,
      AttendanceStatus.absent => l10n.rsvpAbsent,
      AttendanceStatus.nonplay => l10n.rsvpNonplay,
      AttendanceStatus.pending => '',
    };

/// Het woord op de typebadge (bij een beker-/oefenwedstrijd dát woord).
String eventTypeLabel(AppLocalizations l10n, AgendaEvent event) {
  if (event.isMatch) {
    return switch (event.competition) {
      'cup' => l10n.competitionCup,
      'friendly' => l10n.competitionFriendly,
      _ => l10n.eventTypeMatch,
    };
  }
  return switch (event.type) {
    EventType.training => l10n.eventTypeTraining,
    EventType.activity => l10n.eventTypeActivity,
    _ => l10n.eventTypeMatch,
  };
}

/// Eén event in de agenda: datum, badge, teams/titel, diensten en de
/// RSVP-knoppen met tellers (`Row` in de PWA). Tik op de kaart opent het
/// event.
class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
    required this.onRsvp,
    this.dutyChips = const [],
    this.showRsvp = true,
    this.canRsvpFallback = false,
    this.meInjured = false,
    this.now,
  });

  final AgendaEvent event;
  final List<DutyChip> dutyChips;
  final VoidCallback onTap;
  final ValueChanged<AttendanceStatus> onRsvp;

  /// `false` in Verleden: de knoppen tonen alleen de stand.
  final bool showRsvp;

  /// De pagina-brede `can_rsvp`, als het event het zelf niet zegt.
  final bool canRsvpFallback;

  /// Geblesseerd (feature `injuries` aan én `me.is_injured`).
  final bool meInjured;

  /// Voor tests; anders `DateTime.now()`.
  final DateTime? now;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final e = event;
    final start = e.startsAt.toLocal();
    final clock = now ?? DateTime.now();
    final canRsvp = e.canRsvp ?? canRsvpFallback;
    final live = e.live;
    final counts = e.counts;
    final playerCounts = e.effectivePlayerCounts;
    final guestCounts = e.guestCounts;

    // Een activiteit biedt geen 'kijken' aan; staat er toch een kijken
    // geteld, dan blijft die (niet klikbare) knop zichtbaar.
    final options = e.rsvpStatuses
        .where((s) => s != AttendanceStatus.pending)
        .toList();
    final shown =
        !options.contains(AttendanceStatus.nonplay) &&
            counts.nonplay + guestCounts.nonplay > 0
        ? [...options, AttendanceStatus.nonplay]
        : options;
    // Vanaf de aanvang (of zodra het live loopt) staat je aanwezigheid vast.
    final locked = !start.isAfter(clock) || e.isLive;

    final showTitle =
        !e.isMatch &&
        e.title.trim().isNotEmpty &&
        e.title.trim().toLowerCase() != eventTypeLabel(l10n, e).toLowerCase();
    final hasScore = e.isLive || e.homeScore != null || e.awayScore != null;
    final showNotice =
        !e.isCancelled &&
        showRsvp &&
        canRsvp &&
        ((meInjured && e.type != EventType.activity) || e.inVacation);

    final header = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DateTile(date: start, showTime: true, now: clock),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (!(e.isMatch && e.isLive))
                    EventTypeBadge(event: e)
                  else if (live != null)
                    LiveBadge(live: live),
                  const Spacer(),
                  if (!e.isCancelled && counts.total > 0)
                    RespondedRing(
                      responded: counts.responded,
                      total: counts.total,
                    ),
                ],
              ),
              if (e.isMatch && (e.homeTeam != null || e.awayTeam != null))
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${e.homeTeam ?? ''} - ${e.awayTeam ?? ''}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.2,
                            fontWeight: FontWeight.w600,
                            color: t.ink,
                          ),
                        ),
                      ),
                      if (hasScore) ...[
                        const SizedBox(width: 8),
                        _ScorePill(event: e),
                      ],
                    ],
                  ),
                ),
              if (showTitle)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    e.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.2,
                      fontWeight: FontWeight.w600,
                      color: t.ink,
                    ),
                  ),
                ),
              if (e.meetAt != null)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: '${l10n.agendaMeetAt} '),
                        TextSpan(
                          text: DateTile.timeLabel(e.meetAt!.toLocal()),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: t.ink,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                    style: TextStyle(fontSize: 13, color: t.muted),
                  ),
                ),
              if (e.isMatch && dutyChips.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 4,
                    children: [
                      for (final chip in dutyChips) _DutyChipView(chip: chip),
                    ],
                  ),
                ),
              if (e.venue != null && !e.isMatch)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
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
                      Flexible(
                        child: Text(
                          e.venue!,
                          style: TextStyle(fontSize: 13, color: t.muted),
                        ),
                      ),
                    ],
                  ),
                ),
              if (e.isCancelled)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    l10n.agendaCancelled,
                    key: ValueKey('event-${e.id}-cancelled'),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? StatusColors.red400
                          : StatusColors.red700,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );

    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          button: true,
          label: l10n.agendaOpenEvent(
            eventTypeLabel(l10n, e).toLowerCase(),
            '${DateTile.weekdayLabel(start)} ${start.day} ${DateTile.monthLabel(start)}',
          ),
          child: header,
        ),
        if (showNotice)
          Container(
            margin: const EdgeInsets.only(top: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: t.raised,
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
            ),
            child: Row(
              children: [
                PhosphorIcon(
                  meInjured && e.type != EventType.activity
                      ? PhosphorIconsDuotone.ambulance
                      : PhosphorIconsDuotone.island,
                  size: 14,
                  color: meInjured && e.type != EventType.activity
                      ? StatusColors.red500
                      : StatusColors.sky500,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    meInjured && e.type != EventType.activity
                        ? l10n.agendaInjuredNotice
                        : l10n.agendaVacationNotice,
                    style: TextStyle(fontSize: 12, color: t.inkSoft),
                  ),
                ),
              ],
            ),
          ),
        if (!e.isCancelled && shown.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                for (var i = 0; i < shown.length; i++) ...[
                  if (i > 0) const SizedBox(width: 8),
                  Expanded(
                    child: RsvpButton(
                      key: ValueKey('rsvp-${e.id}-${shown[i].name}'),
                      label: rsvpLabel(l10n, shown[i]),
                      status: shown[i],
                      selected: e.myStatus == shown[i],
                      count: playerCounts[shown[i]] + guestCounts[shown[i]],
                      onTap:
                          showRsvp &&
                              canRsvp &&
                              !locked &&
                              options.contains(shown[i])
                          ? () => onRsvp(shown[i])
                          : null,
                    ),
                  ),
                ],
              ],
            ),
          ),
        if (!e.isCancelled && e.spectatorsCanRsvp)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                const PhosphorIcon(
                  PhosphorIconsDuotone.binoculars,
                  size: 14,
                  color: StatusColors.sky500,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    e.spectatorsPresent > 0
                        ? l10n.agendaSpectatorsComing(e.spectatorsPresent)
                        : l10n.agendaSpectatorsCanRsvp,
                    style: TextStyle(fontSize: 13, color: t.muted),
                  ),
                ),
              ],
            ),
          ),
      ],
    );

    return Opacity(
      opacity: e.isCancelled ? 0.5 : 1,
      child: AppCard(key: ValueKey('event-${e.id}'), onTap: onTap, child: body),
    );
  }
}

/// Eén RSVP-knop met teller: gekleurd als hij gekozen is.
class RsvpButton extends StatelessWidget {
  const RsvpButton({
    super.key,
    required this.label,
    required this.status,
    required this.selected,
    required this.count,
    required this.onTap,
  });

  final String label;
  final AttendanceStatus status;
  final bool selected;
  final int count;

  /// `null` = niet klikbaar (alleen de stand).
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final style = AttendanceStatusStyle.of(
      context,
      AttendanceTone.fromApi(status.name),
    );
    final bg = selected ? style.solid : t.sunken;
    final fg = selected ? style.onSolid : t.inkSoft;
    return Semantics(
      button: true,
      selected: selected,
      enabled: onTap != null,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AssistjeTokens.radiusLg),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: fg,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: selected
                      ? t.surface.withValues(alpha: 0.25)
                      : t.surface,
                  borderRadius: BorderRadius.circular(
                    AssistjeTokens.radiusFull,
                  ),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: selected ? style.onSolid : t.inkSoft,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Typebadge: wedstrijd in teamkleur, training/activiteit grijs.
class EventTypeBadge extends StatelessWidget {
  const EventTypeBadge({super.key, required this.event});

  final AgendaEvent event;

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
    return _Badge(
      icon: icon,
      label: eventTypeLabel(l10n, event).toUpperCase(),
      background: bg,
      foreground: fg,
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    required this.icon,
    required this.label,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PhosphorIcon(icon, size: 14, color: foreground),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.4,
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}

/// Groene live-badge met lopende wedstrijdklok (`Live · 38'`).
class LiveBadge extends StatefulWidget {
  const LiveBadge({super.key, required this.live});

  final LiveState live;

  @override
  State<LiveBadge> createState() => _LiveBadgeState();
}

class _LiveBadgeState extends State<LiveBadge> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _sync();
  }

  @override
  void didUpdateWidget(LiveBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sync();
  }

  void _sync() {
    if (widget.live.running) {
      _ticker ??= Timer.periodic(
        const Duration(seconds: 1),
        (_) => setState(() {}),
      );
    } else {
      _ticker?.cancel();
      _ticker = null;
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      key: const ValueKey('live-badge'),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: StatusColors.emerald500,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Color(0xFFFFFFFF),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            l10n
                .agendaLive(widget.live.clockLabel(DateTime.now()))
                .toUpperCase(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScorePill extends StatelessWidget {
  const _ScorePill({required this.event});

  final AgendaEvent event;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final live = event.isLive;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: live
            ? (dark
                  ? StatusColors.emerald500.withValues(alpha: 0.15)
                  : StatusColors.emerald50)
            : t.sunken,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusMd),
      ),
      child: Text(
        '${event.homeScore ?? 0} - ${event.awayScore ?? 0}',
        style: TextStyle(
          fontSize: live ? 13 : 12,
          fontWeight: FontWeight.w700,
          fontFeatures: const [FontFeature.tabularFigures()],
          color: live
              ? (dark ? StatusColors.emerald400 : StatusColors.emerald700)
              : t.inkSoft,
        ),
      ),
    );
  }
}

class _DutyChipView extends StatelessWidget {
  const _DutyChipView({required this.chip});

  final DutyChip chip;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final color = chip.mine
        ? (dark ? StatusColors.emerald400 : StatusColors.emerald700)
        : t.muted;
    final label = chip.label.isNotEmpty
        ? chip.label
        : l10n.agendaDutyPeople(chip.peopleCount);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        PhosphorIcon(
          dutyIconFor(chip.icon, chip.dutyType),
          size: 14,
          color: color,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: chip.mine ? FontWeight.w500 : FontWeight.w400,
            color: color,
          ),
        ),
      ],
    );
  }
}

/// Reactie-indicator: `9/16` plus een ringetje dat zich groen vult.
class RespondedRing extends StatelessWidget {
  const RespondedRing({
    super.key,
    required this.responded,
    required this.total,
  });

  final int responded;
  final int total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return Semantics(
      label: l10n.agendaResponded(responded, total),
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$responded/$total',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: t.muted,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(width: 6),
          SizedBox.square(
            dimension: 22,
            child: CustomPaint(
              painter: _RingPainter(
                fraction: total > 0 ? responded / total : 0,
                track: t.line,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.fraction, required this.track});

  final double fraction;
  final Color track;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    const radius = 8.0;
    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = track;
    canvas.drawCircle(center, radius, base);
    if (fraction <= 0) return;
    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..color = StatusColors.emerald500;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * fraction.clamp(0, 1),
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.fraction != fraction || old.track != track;
}
