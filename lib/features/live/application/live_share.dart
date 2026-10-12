import '../../../l10n/generated/app_localizations.dart';
import '../data/models/live_models.dart';

/// Mag deze wedstrijd gedeeld worden? Net als de PWA (`EventDetail.tsx`):
/// er is een publieke link en de wedstrijd loopt of is afgelopen. Delen mag
/// iedereen, niet alleen de trainer.
bool canShareLive(LiveEvent event) =>
    event.shareUrl != null && (event.live.inPlay || event.live.isEnded);

/// Het deelbericht voor [event], als `lib/shareLiveMatch.ts` in de PWA: een
/// uitnodiging om mee te kijken zolang de wedstrijd loopt, de uitslag als hij
/// afgelopen is. [teamName] is de terugval als thuis- en uitteam ontbreken.
///
/// Zonder de voetbal-emoji van de PWA: het bericht is sportneutraal.
/// Geeft `null` als er niets te delen valt (zie [canShareLive]).
String? liveShareMessage(
  AppLocalizations l10n,
  LiveEvent event, {
  required String teamName,
}) {
  final url = event.shareUrl;
  if (url == null || !canShareLive(event)) return null;
  final home = event.homeTeam ?? '';
  final away = event.awayTeam ?? '';
  final who = home.isNotEmpty || away.isNotEmpty
      ? '$home - $away'.trim()
      : teamName;
  if (event.live.isEnded) {
    final score = '${event.homeScore ?? 0} - ${event.awayScore ?? 0}';
    return l10n.liveShareEndedMessage(who, score, url);
  }
  return l10n.liveShareLiveMessage(who, url);
}
