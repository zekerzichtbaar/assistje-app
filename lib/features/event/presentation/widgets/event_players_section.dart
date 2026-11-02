import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../agenda/data/models/agenda_models.dart';
import '../../data/models/event_detail_models.dart';
import 'event_responses_card.dart';
import 'event_section_card.dart';

/// De lijst per groep, zoals op de eventpagina: spelers per antwoord, dan
/// staf, gasten en toeschouwers (elk in een eigen kaart). Lege groepen
/// vallen weg.
///
/// Een gast die meedoet staat onder 'Aanwezig', met het label gast erachter —
/// anders stond er 14 in de lijst en 15 in de reacties erboven. Het blok
/// Gasten houdt alleen de gasten die de trainer nog moet aanvinken, en dat is
/// alleen zijn zaak.
List<Widget> buildEventPlayerGroups(
  BuildContext context,
  List<EventPlayer> players, {
  required bool isTrainer,
}) {
  final l10n = AppLocalizations.of(context);
  final dark = Theme.of(context).brightness == Brightness.dark;
  final groups = <Widget>[];

  for (final status in EventResponsesCard.order) {
    final group = [
      for (final p in players)
        if (p.status == status &&
            (p.kind == EventPlayerKind.player ||
                (p.kind == EventPlayerKind.guest &&
                    status == AttendanceStatus.present)))
          p,
    ];
    if (group.isEmpty) continue;
    final style = eventStatusStyle(context, status);
    groups.add(
      EventSectionCard(
        key: ValueKey('event-group-${status.name}'),
        title: eventStatusLabel(l10n, status),
        trailing: CountPill(
          label: '${group.length}',
          background: style.softBackground,
          foreground: style.softForeground,
        ),
        child: _Rows(players: group),
      ),
    );
  }

  final staff = [
    for (final p in players)
      if (p.kind == EventPlayerKind.staff) p,
  ];
  if (staff.isNotEmpty) {
    final present = staff
        .where((p) => p.status == AttendanceStatus.present)
        .length;
    groups.add(
      EventSectionCard(
        key: const ValueKey('event-group-staff'),
        title: l10n.eventDetailStaff,
        trailing: CountPill(
          label: '$present/${staff.length}',
          background: dark ? const Color(0x336366F1) : const Color(0xFFE0E7FF),
          foreground: dark ? const Color(0xFFA5B4FC) : const Color(0xFF4338CA),
        ),
        child: _Rows(players: staff, showStatus: true),
      ),
    );
  }

  // Wie meedoet staat al onder Aanwezig; hier de rest, alleen voor de
  // trainer. Het getal is dus gewoon hoeveel er nog openstaan.
  final guests = [
    for (final p in players)
      if (p.kind == EventPlayerKind.guest &&
          p.status != AttendanceStatus.present)
        p,
  ];
  if (isTrainer && guests.isNotEmpty) {
    groups.add(
      EventSectionCard(
        key: const ValueKey('event-group-guests'),
        title: l10n.eventDetailGuests,
        trailing: CountPill(
          label: '${guests.length}',
          background: dark ? const Color(0x33F59E0B) : StatusColors.amber100,
          foreground: dark ? StatusColors.amber300 : StatusColors.amber800,
        ),
        child: _Rows(players: guests, showStatus: true),
      ),
    );
  }

  final spectators = [
    for (final p in players)
      if (p.kind == EventPlayerKind.spectator) p,
  ];
  if (spectators.isNotEmpty) {
    groups.add(
      EventSectionCard(
        key: const ValueKey('event-group-spectators'),
        title: l10n.eventDetailSpectators,
        trailing: CountPill(
          label: '${spectators.length}',
          background: dark ? const Color(0x338B5CF6) : const Color(0xFFEDE9FE),
          foreground: dark ? const Color(0xFFA78BFA) : const Color(0xFF6D28D9),
        ),
        child: _Rows(players: spectators),
      ),
    );
  }
  return groups;
}

class _Rows extends StatelessWidget {
  const _Rows({required this.players, this.showStatus = false});

  final List<EventPlayer> players;
  final bool showStatus;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Column(
      children: [
        for (var i = 0; i < players.length; i++) ...[
          if (i > 0) Divider(height: 1, color: t.lineSoft),
          EventPlayerRow(player: players[i], showStatus: showStatus),
        ],
      ],
    );
  }
}

/// "08 okt 2026, 19:02" (als `toLocaleString('nl-NL', …)` in de PWA).
String eventChangedAt(DateTime at) {
  final local = at.toLocal();
  final month = DateFormat.MMM('nl').format(local).replaceAll('.', '');
  final day = local.day.toString().padLeft(2, '0');
  return '$day $month ${local.year}, ${DateFormat.Hm('nl').format(local)}';
}

/// Eén persoon in de lijst: rugnummer, avatar, naam met badges, reden. Een
/// tik klapt uit wanneer en door wie het antwoord het laatst wijzigde.
class EventPlayerRow extends StatefulWidget {
  const EventPlayerRow({
    super.key,
    required this.player,
    this.showStatus = false,
  });

  final EventPlayer player;
  final bool showStatus;

  @override
  State<EventPlayerRow> createState() => _EventPlayerRowState();
}

class _EventPlayerRowState extends State<EventPlayerRow> {
  bool _open = false;

  String _changedText(AppLocalizations l10n) {
    final p = widget.player;
    final at = p.respondedAt;
    if (at == null) return l10n.eventDetailLastChanged('—');
    final by = p.changedBy;
    if (by == null) return l10n.eventDetailLastChanged(eventChangedAt(at));
    final who = by.self
        ? l10n.eventDetailChangedBySelf(by.name.split(' ').first)
        : by.name;
    return l10n.eventDetailLastChangedBy(eventChangedAt(at), who);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final p = widget.player;
    final showStatus = widget.showStatus;
    final personal = p.kind == EventPlayerKind.player;
    final injured = personal && p.isInjured;
    final style = eventStatusStyle(context, p.status);
    final dark = Theme.of(context).brightness == Brightness.dark;

    final badges = <Widget>[
      if (p.isCaptain)
        Semantics(
          label: l10n.eventDetailCaptain,
          excludeSemantics: true,
          child: Container(
            width: 16,
            height: 16,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: StatusColors.amber400,
              shape: BoxShape.circle,
            ),
            child: const Text(
              'C',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111827),
              ),
            ),
          ),
        ),
      if (p.isKeeper)
        _Badge(
          label: l10n.eventDetailKeeperBadge,
          tone: AttendanceTone.present,
        ),
      if (injured)
        _Badge(label: l10n.eventDetailInjuredBadge, tone: AttendanceTone.injury)
      else if (p.isOnVacation && personal)
        _Badge(
          label: l10n.eventDetailVacationBadge,
          tone: AttendanceTone.vacation,
        ),
      if (p.isGuest || p.kind == EventPlayerKind.guest)
        _Badge(
          key: ValueKey('event-player-guest-badge-${p.rowKey ?? p.id}'),
          label: l10n.eventDetailGuestBadge,
          tone: AttendanceTone.watch,
          // Amber zoals het gastenblok; amber-900/-200 haalt AA in licht en
          // donker.
          background: dark ? const Color(0x33F59E0B) : StatusColors.amber100,
          foreground: dark ? StatusColors.amber200 : StatusColors.amber900,
        ),
      if (p.kind == EventPlayerKind.spectator)
        _Badge(
          label: l10n.eventDetailSpectatorBadge,
          tone: AttendanceTone.vacation,
        ),
    ];

    final rowKey = p.rowKey ?? '${p.kind.name}-${p.id}';
    final row = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 22,
            child: Text(
              p.shirtNumber?.toString() ?? '',
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
          AppAvatar(name: p.name, imageUrl: p.avatarUrl),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        p.isMe ? l10n.eventDetailYou : p.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: t.ink,
                        ),
                      ),
                    ),
                    for (final b in badges) ...[const SizedBox(width: 6), b],
                  ],
                ),
                if (p.reason != null && p.reason!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      p.reason!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: t.muted),
                    ),
                  ),
              ],
            ),
          ),
          if (showStatus) ...[
            const SizedBox(width: 8),
            CountPill(
              label: eventStatusLabel(l10n, p.status),
              background: style.softBackground,
              foreground: style.softForeground,
            ),
          ],
          const SizedBox(width: 8),
          AnimatedRotation(
            turns: _open ? 0.5 : 0,
            duration: MediaQuery.disableAnimationsOf(context)
                ? Duration.zero
                : const Duration(milliseconds: 200),
            child: Icon(PhosphorIconsBold.caretDown, size: 14, color: t.muted),
          ),
        ],
      ),
    );

    return Column(
      key: ValueKey('event-player-$rowKey'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Semantics(
          expanded: _open,
          child: InkWell(
            key: ValueKey('event-player-toggle-$rowKey'),
            onTap: () => setState(() => _open = !_open),
            child: row,
          ),
        ),
        AnimatedSize(
          duration: MediaQuery.disableAnimationsOf(context)
              ? Duration.zero
              : const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          alignment: Alignment.topCenter,
          child: _open
              ? Container(
                  key: ValueKey('event-player-detail-$rowKey'),
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: t.lineSoft)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Text(
                    _changedText(l10n),
                    style: TextStyle(fontSize: 14, color: t.inkSoft),
                  ),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({
    super.key,
    required this.label,
    required this.tone,
    this.background,
    this.foreground,
  });

  final String label;
  final AttendanceTone tone;

  /// Eigen kleuren in plaats van die van [tone].
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final style = AttendanceStatusStyle.of(context, tone);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
      decoration: BoxDecoration(
        color: background ?? style.softBackground,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusSm + 2),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: foreground ?? style.softForeground,
        ),
      ),
    );
  }
}
