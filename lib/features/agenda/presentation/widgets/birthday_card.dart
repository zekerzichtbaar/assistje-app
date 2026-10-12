import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/agenda_items.dart';
import '../../data/models/agenda_models.dart';

/// Een jarige in Aankomend (`BirthdayItem` in de PWA). Op de dag zelf in
/// amber, met één confettiregen bij het tonen.
class BirthdayCard extends StatefulWidget {
  const BirthdayCard({super.key, required this.birthday, this.now});

  final AgendaBirthday birthday;
  final DateTime? now;

  @override
  State<BirthdayCard> createState() => _BirthdayCardState();
}

class _BirthdayCardState extends State<BirthdayCard> {
  final _confetti = GlobalKey<ConfettiBurstState>();

  @override
  void initState() {
    super.initState();
    if (widget.birthday.isToday) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _confetti.currentState?.fire(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final b = widget.birthday;
    const amber100 = StatusColors.amber100;
    const amber300 = StatusColors.amber300;
    const amber400 = StatusColors.amber400;
    const amber500 = StatusColors.amber500;
    const amber700 = StatusColors.amber700;
    const amber800 = StatusColors.amber800;

    final badgeBg = b.isToday
        ? (dark ? amber500.withValues(alpha: 0.2) : amber100)
        : t.sunken;
    final badgeFg = b.isToday ? (dark ? amber300 : amber800) : t.inkSoft;
    final todayFg = dark ? amber400 : amber700;

    final turning = b.turning;
    final String? subtitle = turning != null
        ? (b.isToday
              ? l10n.agendaTurnsToday(turning)
              : l10n.agendaTurns(turning))
        : (b.isToday ? l10n.agendaBirthdayToday : null);

    final card = AppCard(
      key: ValueKey('birthday-${b.key}'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateTile(date: parseDay(b.date), now: widget.now),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(
                      AssistjeTokens.radiusFull,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PhosphorIcon(
                        PhosphorIconsDuotone.cake,
                        size: 14,
                        color: badgeFg,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        l10n.agendaBirthday.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.4,
                          color: badgeFg,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    AppAvatar(name: b.name, imageUrl: b.avatarUrl, size: 32),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            b.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: t.ink,
                            ),
                          ),
                          if (subtitle != null)
                            Text(
                              subtitle,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: b.isToday
                                    ? FontWeight.w500
                                    : FontWeight.w400,
                                color: b.isToday ? todayFg : t.muted,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (!b.isToday) return card;
    return ConfettiBurst(
      key: _confetti,
      alignment: Alignment.centerRight,
      numberOfParticles: 12,
      child: card,
    );
  }
}
