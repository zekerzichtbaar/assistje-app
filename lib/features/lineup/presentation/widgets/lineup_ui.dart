import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/lineup_models.dart';

/// Amber van de C en de "opgepakt"-ring (amber-400).
const Color lineupAmber = StatusColors.amber400;

/// Donker amber voor tekst op wit (amber-600).
const Color lineupAmberText = StatusColors.amber600;

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is,
/// anders een algemene melding.
String lineupErrorText(AppLocalizations l10n, Object? error) => switch (error) {
  NetworkException() => l10n.errorNetwork,
  final ApiException e when e.message != null => e.message!,
  _ => l10n.errorGeneric,
};

/// Fouttoast (met trilling).
void showLineupError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: lineupErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Succestoast (met trilling).
void showLineupSuccess(BuildContext context, String title) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// "vrijdag 20:14": de dagnaam is genoeg, het gaat altijd over deze week.
String formatLineupShared(DateTime time) =>
    DateFormat('EEEE HH:mm', 'nl').format(time);

/// De volledige positienaam uit het sportprofiel (`positions`), anders de
/// code zelf. Zo zegt een volleybalteam "Libero" en een voetbalteam "Spits"
/// zonder dat de app de sport kent.
String positionName(Map<String, dynamic> sport, String code) {
  final positions = sport['positions'];
  if (positions is Map) {
    final name = positions[code];
    if (name is String && name.trim().isNotEmpty) return name;
  }
  return code;
}

/// De regel onder een spelersnaam op de bank: positie, of "Gast · JO19-2".
String lineupPlayerSubtitle(
  AppLocalizations l10n,
  Map<String, dynamic> sport,
  LineupPlayer player,
) {
  if (player.isGuest) {
    final from = player.fromTeam?.trim();
    return from == null || from.isEmpty
        ? l10n.lineupGuest
        : l10n.lineupGuestFrom(from);
  }
  return player.position.isEmpty ? '' : positionName(sport, player.position);
}

/// Rond rugnummer-label (linksboven op een kaart).
class ShirtBadge extends StatelessWidget {
  const ShirtBadge({super.key, required this.number, this.size = 20});

  final int number;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      border: Border.all(color: const Color(0xFF047857)),
    ),
    child: Text(
      '$number',
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: Color(0xFF111827),
        height: 1,
      ),
    ),
  );
}
