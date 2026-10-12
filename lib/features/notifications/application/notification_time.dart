import 'package:intl/intl.dart';

import '../../../l10n/generated/app_localizations.dart';

/// Relatieve tijd van een melding, in het Nederlands: "zojuist",
/// "5 min geleden", "2 uur geleden", "gisteren", "3 dagen geleden" en
/// daarna de datum ("12 okt", met jaartal als het een ander jaar is).
///
/// Vergelijkt in lokale tijd. Datumnotatie vraagt de `nl`-datumdata
/// (geladen door de lokalisatie van de app, of `initializeDateFormatting`).
String notificationTimeLabel(
  AppLocalizations l10n,
  DateTime createdAt,
  DateTime now,
) {
  final at = createdAt.toLocal();
  final local = now.toLocal();
  final diff = local.difference(at);

  if (diff.inMinutes < 1) return l10n.notificationsTimeJustNow;
  if (diff.inMinutes < 60) return l10n.notificationsTimeMinutes(diff.inMinutes);

  final today = DateTime(local.year, local.month, local.day);
  final day = DateTime(at.year, at.month, at.day);
  // Kalenderdagen (zomertijd-veilig via UTC-datums).
  final days = DateTime.utc(
    today.year,
    today.month,
    today.day,
  ).difference(DateTime.utc(day.year, day.month, day.day)).inDays;

  if (days <= 0 || (diff.inHours < 6 && days == 1)) {
    return l10n.notificationsTimeHours(diff.inHours < 1 ? 1 : diff.inHours);
  }
  if (days == 1) return l10n.notificationsTimeYesterday;
  if (days < 7) return l10n.notificationsTimeDays(days);
  return at.year == local.year
      ? DateFormat('d MMM', 'nl').format(at)
      : DateFormat('d MMM y', 'nl').format(at);
}
