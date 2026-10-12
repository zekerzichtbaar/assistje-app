import '../router/app_routes.dart';
import '../session/models/team_membership.dart';

/// Een bestemming in de tabbalk of het menu. Label en icoon staan in
/// `nav_presentation.dart`; hier alleen wát er is en waar het heen gaat.
enum NavItem {
  onboarding(AppRoutes.onboarding),
  agenda(AppRoutes.agenda),
  players(AppRoutes.players),
  team(AppRoutes.team),
  duties(AppRoutes.duties),
  stats(AppRoutes.stats),
  hallOfFame(AppRoutes.hallOfFame),
  poule(AppRoutes.poule),
  fines(AppRoutes.fines),
  savings(AppRoutes.savings),
  wheel(AppRoutes.wheel),
  messages(AppRoutes.messages),
  agreements(AppRoutes.agreements),
  settings(AppRoutes.settings),
  feedback(AppRoutes.feedback),
  profile(AppRoutes.profile);

  const NavItem(this.path);

  final String path;

  /// Of dit item een eigen tab heeft (dan wisselt het van tab i.p.v. te
  /// pushen).
  bool get isTab => AppRoutes.tabRoots.contains(path);
}

/// De tabbalk, als `BottomNav.tsx`: voor trainer, speler en toeschouwer gelijk
/// (Stats en Ranking staan er altijd), Poule alleen met een poulekoppeling.
List<NavItem> buildTabItems(TeamMembership m) => [
  NavItem.agenda,
  NavItem.stats,
  NavItem.hallOfFame,
  if (m.hasPoule) NavItem.poule,
  NavItem.profile,
];

/// Het hamburgermenu, een port van `getNavItems()` in `navItems.ts`.
///
/// - trainer: (Aan de slag zolang de checklist openstaat), Agenda, Spelers,
///   Diensten, [stats] Statistieken + Ranking, [poule] Poule, [fines] Boetepot,
///   [savings] Spaarpot, [wheel] Radje, [messages] Berichten,
///   [agreements] Afspraken, Instellingen, Feedback;
/// - speler/toeschouwer: Agenda, Team (niet voor de penningmeester),
///   [stats] Statistieken + Ranking, [poule] Poule, Boetepot en Spaarpot (niet
///   voor toeschouwers), Radje, Afspraken, Feedback.
List<NavItem> buildMenuItems(TeamMembership m) {
  final stats = m.hasFeature('stats');

  if (m.isTrainer) {
    return [
      if (m.onboardingOpen) NavItem.onboarding,
      NavItem.agenda,
      NavItem.players,
      NavItem.duties,
      if (stats) ...[NavItem.stats, NavItem.hallOfFame],
      if (m.hasPoule) NavItem.poule,
      if (m.hasFeature('fines')) NavItem.fines,
      if (m.hasFeature('savings')) NavItem.savings,
      if (m.hasFeature('wheel')) NavItem.wheel,
      if (m.hasFeature('messages')) NavItem.messages,
      if (m.hasFeature('agreements')) NavItem.agreements,
      NavItem.settings,
      NavItem.feedback,
    ];
  }

  final isTreasurer = m.can('fines');
  return [
    NavItem.agenda,
    if (!isTreasurer) NavItem.team,
    if (stats) ...[NavItem.stats, NavItem.hallOfFame],
    if (m.hasPoule) NavItem.poule,
    if (m.hasFeature('fines') && !m.isSpectator) NavItem.fines,
    if (m.hasFeature('savings') && !m.isSpectator) NavItem.savings,
    if (m.hasFeature('wheel')) NavItem.wheel,
    if (m.hasFeature('agreements')) NavItem.agreements,
    NavItem.feedback,
  ];
}

/// Of [m] het ingelogde pad [path] mag openen — de middleware van de PWA
/// (`trainer`, `not_spectator`, `feature:…`, `can:…`, poulecode) als pure
/// functie. Wat hier niet staat is voor elk lid.
bool canVisit(TeamMembership m, String path) {
  bool under(String prefix) => path == prefix || path.startsWith('$prefix/');
  bool ability(String key) => m.isTrainer || m.can(key);
  final segments = Uri.parse(path).pathSegments;
  final eventSub = segments.length == 3 && segments.first == 'events'
      ? segments[2]
      : null;

  if (under(AppRoutes.poule)) return m.hasPoule;
  if (path == AppRoutes.players) return m.isTrainer;
  if (under(AppRoutes.fines)) return m.hasFeature('fines') && !m.isSpectator;
  if (under(AppRoutes.savings)) {
    return m.hasFeature('savings') && !m.isSpectator;
  }
  if (under(AppRoutes.wheel)) return m.hasFeature('wheel');
  if (under(AppRoutes.messages)) {
    return m.isTrainer && m.hasFeature('messages');
  }
  if (under(AppRoutes.agreements)) return m.hasFeature('agreements');
  if (under(AppRoutes.settings) ||
      under(AppRoutes.onboarding) ||
      under(AppRoutes.schedule) ||
      under(AppRoutes.seasons) ||
      under(AppRoutes.teamlink)) {
    return m.isTrainer;
  }
  if (eventSub == 'attendance') return m.isTrainer;
  if (eventSub == 'report') return ability('lineup');
  if (eventSub == 'teams') return ability('training_points');
  return true;
}

/// Redirect voor een ingelogd pad dat [m] niet mag zien: terug naar de agenda
/// (bv. na een teamwissel vanaf de boetepot naar een team zonder boetes).
String? navGuardRedirect(TeamMembership? m, String location) {
  if (m == null) return null;
  final path = Uri.parse(location).path;
  return canVisit(m, path) ? null : AppRoutes.home;
}

/// De "ouder" van een pad, voor de terugknop als er niets te poppen valt
/// (bv. na een deep link).
String parentPath(TeamMembership? m, String path) {
  final segments = Uri.parse(path).pathSegments;
  if (segments.length >= 3 && segments.first == 'events') {
    return '/events/${segments[1]}';
  }
  if (segments.length == 2 && segments.first == 'players') {
    return m?.isTrainer ?? false ? AppRoutes.players : AppRoutes.team;
  }
  if (segments.length == 2 && segments.first == 'profile') {
    return AppRoutes.profile;
  }
  return AppRoutes.home;
}

/// Of [path] de wortel van een tab is (dan geen terugknop).
bool isTabRoot(String path) => AppRoutes.tabRoots.contains(path);
