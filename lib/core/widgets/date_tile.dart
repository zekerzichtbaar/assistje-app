import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/assistje_tokens.dart';

/// Kalendertegel voor agenda-kaarten (`DateTile.tsx`): weekdagband, groot
/// dagcijfer, maand en — als [showTime] — een haarlijn plus de tijd.
///
/// Formatteert zelf in `nl` ("za", "okt", "19:30"); een punt achter de
/// afkorting wordt gestript. Vereist geïnitialiseerde `nl`-datumsymbolen
/// (gebeurt via `GlobalMaterialLocalizations` in de app; in tests
/// `initializeDateFormatting('nl')`).
///
/// Vandaag ziet er bewust hetzelfde uit als andere dagen: een gekleurde band
/// was te heftig op de kaart.
class DateTile extends StatelessWidget {
  const DateTile({super.key, required this.date, this.showTime = false});

  /// Lokale datum/tijd van het moment.
  final DateTime date;
  final bool showTime;

  static String _strip(String s) =>
      s.endsWith('.') ? s.substring(0, s.length - 1) : s;

  /// "za", "zo", … (zonder punt).
  static String weekdayLabel(DateTime d) =>
      _strip(DateFormat.E('nl').format(d));

  /// "jan", "okt", … (zonder punt).
  static String monthLabel(DateTime d) =>
      _strip(DateFormat.MMM('nl').format(d));

  /// "19:30".
  static String timeLabel(DateTime d) => DateFormat.Hm('nl').format(d);

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);

    return Container(
      width: 56,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusLg),
        border: Border.all(color: t.lineSoft),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            key: const ValueKey('date-tile-band'),
            color: t.raised,
            padding: const EdgeInsets.symmetric(vertical: 2),
            // Vaste breedte (een kalenderblaadje): bij grote tekst verkleinen
            // in plaats van afbreken.
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                weekdayLabel(date).toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  color: t.muted,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1,
                      fontWeight: FontWeight.w700,
                      color: t.ink,
                    ),
                  ),
                  Text(
                    monthLabel(date),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: t.muted,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showTime)
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: t.lineSoft)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    timeLabel(date),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: t.ink,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
