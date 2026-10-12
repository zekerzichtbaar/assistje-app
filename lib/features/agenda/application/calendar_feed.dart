import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

/// Welke stukken van de agenda in de ICS-feed komen (`CalendarPicker` in
/// `Pages/Player/Agenda.tsx`).
class AgendaFeedSelection {
  const AgendaFeedSelection({
    this.matches = true,
    this.trainings = true,
    this.duties = const [],
    this.onlyMine = false,
  });

  final bool matches;
  final bool trainings;

  /// Slugs van de gekozen diensttypes, in volgorde van de agenda.
  final List<String> duties;

  /// Alleen events waar je bij bent (`mine=1`).
  final bool onlyMine;

  bool get nothingPicked => !matches && !trainings && duties.isEmpty;
}

/// De https-feed-URL met de gekozen onderdelen als query, of `null` als er
/// geen feed is of niets gekozen. [baseUrl] is `agenda_feed_url` uit de API
/// (absoluut, zonder query).
String? buildAgendaFeedUrl(String? baseUrl, AgendaFeedSelection selection) {
  if (baseUrl == null || baseUrl.isEmpty || selection.nothingPicked) {
    return null;
  }
  final params = <String>[
    if (selection.matches) 'matches=1',
    if (selection.trainings) 'trainings=1',
    if (selection.duties.isNotEmpty)
      'duties=${selection.duties.map(Uri.encodeQueryComponent).join(',')}',
    if (selection.onlyMine) 'mine=1',
  ];
  return '$baseUrl?${params.join('&')}';
}

/// De `webcal:`-variant: de agenda-app abonneert dan in plaats van één keer
/// te importeren, zodat nieuwe events er vanzelf bij komen.
String toWebcalUrl(String httpsUrl) =>
    httpsUrl.replaceFirst(RegExp('^https?:'), 'webcal:');

/// Opent een URL in een andere app (agenda); achter een provider zodat
/// widget-tests hem kunnen vervangen.
class ExternalUrlLauncher {
  const ExternalUrlLauncher();

  /// `true` als het systeem de URL heeft kunnen openen.
  Future<bool> open(Uri uri) =>
      launchUrl(uri, mode: LaunchMode.externalApplication);
}

final externalUrlLauncherProvider = Provider<ExternalUrlLauncher>(
  (ref) => const ExternalUrlLauncher(),
);
