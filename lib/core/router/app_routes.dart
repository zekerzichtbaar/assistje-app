/// Paden en namen van de routes. Gebruik altijd deze constanten, nooit losse
/// strings.
///
/// De ingelogde paden zijn gelijk aan de webpaden van de PWA (vogels3), zodat
/// een push-`data.url` later 1-op-1 op een route valt.
abstract final class AppRoutes {
  // ── Deur (niet ingelogd) ────────────────────────────────────────────────

  /// Opstarten: token lezen en `/me` laden (of een fout tonen).
  static const String splash = '/start';
  static const String splashName = 'splash';

  static const String login = '/login';
  static const String loginName = 'login';

  /// Code-invoer; het e-mailadres staat in de query (`?email=`).
  static const String loginCode = '/login/code';
  static const String loginCodeName = 'loginCode';

  /// Ingelogd, maar (nog) geen lid van een team.
  static const String noTeam = '/geen-team';
  static const String noTeamName = 'noTeam';

  // ── Publiek (in- én uitgelogd) ──────────────────────────────────────────
  // Zelfde paden als het web, zodat een Universal/App Link 1-op-1 landt.

  /// Meedoen via de teamlink uit de groepsapp.
  static const String join = '/meedoen/:token';
  static const String joinName = 'join';

  /// De bevestiglink uit `JoinConfirmMail` (bestaand account); de query
  /// (`role`, `player`, `name`) gaat ongewijzigd mee.
  static const String joinConfirm = '/meedoen/:token/bevestig/:login';
  static const String joinConfirmName = 'joinConfirm';

  /// Een uitnodiging van de trainer accepteren.
  static const String invite = '/register/invite/:token';
  static const String inviteName = 'invite';

  /// Zelf een nieuw team aanmelden (`?sport=` kiest de sport alvast).
  static const String signup = '/aanmelden';
  static const String signupName = 'signup';

  /// [signup] met de sport uit een link (sleutel of naam), of zonder.
  static String signupLink({String? sport}) => sport == null || sport.isEmpty
      ? signup
      : Uri(path: signup, queryParameters: {'sport': sport}).toString();

  static String joinLink(String token) =>
      '/${Uri(pathSegments: ['meedoen', token])}';

  static String joinConfirmLink(
    String token,
    String login, {
    Map<String, String>? query,
  }) =>
      '/${Uri(pathSegments: ['meedoen', token, 'bevestig', login], queryParameters: query == null || query.isEmpty ? null : query)}';

  static String inviteLink(String token) =>
      '/${Uri(pathSegments: ['register', 'invite', token])}';

  /// Is [path] een publiek scherm ([join], [joinConfirm], [invite],
  /// [signup])? Die mogen uitgelogd, ingelogd, zonder team en tijdens het
  /// opstarten.
  static bool isPublic(String path) {
    final segments = [
      for (final s in Uri.parse(path).pathSegments)
        if (s.isNotEmpty) s,
    ];
    if (segments.isEmpty) return false;
    if (segments.first == 'aanmelden') return segments.length == 1;
    if (segments.first == 'meedoen') {
      return segments.length == 2 ||
          (segments.length == 4 && segments[2] == 'bevestig');
    }
    return segments.length == 3 &&
        segments[0] == 'register' &&
        segments[1] == 'invite';
  }

  // ── Ingelogd ────────────────────────────────────────────────────────────

  /// `/` bestaat alleen als doorverwijzing naar [home] (net als in de PWA,
  /// waar `/` op de agenda uitkomt).
  static const String root = '/';

  /// Landingsplek na inloggen en na een teamwissel: de Agenda-tab.
  static const String home = agenda;

  // Tabs (vaste volgorde in de tabshell).
  static const String agenda = '/agenda';
  static const String stats = '/stats';
  static const String hallOfFame = '/hall-of-fame';
  static const String poule = '/poule';
  static const String profile = '/profile';

  // Onder de Agenda-tab.
  static const String eventDetail = '/events/:eventId';
  static const String eventAttendance = '/events/:eventId/attendance';
  static const String eventLineup = '/events/:eventId/lineup';
  static const String eventLive = '/events/:eventId/live';
  static const String eventReport = '/events/:eventId/report';
  static const String eventTrainingTeams = '/events/:eventId/teams';

  // Onder de Mij-tab.
  static const String notificationPreferences = '/profile/notifications';

  // Over de tabs heen (menu, bel, doorklikken).
  static const String notifications = '/notifications';
  static const String onboarding = '/onboarding';
  static const String team = '/team';
  static const String players = '/players';
  static const String playerDetail = '/players/:playerId';
  static const String duties = '/duties';
  static const String fines = '/fines';
  static const String savings = '/savings';
  static const String wheel = '/wheel';
  static const String messages = '/messages';
  static const String agreements = '/agreements';
  static const String settings = '/settings';
  static const String feedback = '/feedback';
  static const String schedule = '/schedule';
  static const String seasons = '/seasons';
  static const String vacations = '/vacations';
  static const String standingAbsences = '/standing-absences';
  static const String teamlink = '/teamlink';

  /// De paden waar een tab bij hoort (de wortel van elke tab).
  static const List<String> tabRoots = [
    agenda,
    stats,
    hallOfFame,
    poule,
    profile,
  ];

  static String event(int eventId) => '/events/$eventId';
  static String player(int playerId) => '/players/$playerId';
}
