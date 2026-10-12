import '../router/app_routes.dart';

/// Waar een binnenkomende link (push `data.url`, Universal Link, App Link)
/// heen moet.
sealed class DeepLinkTarget {
  const DeepLinkTarget();
}

/// Open een ingelogd scherm. [location] is altijd een `AppRoutes`-pad
/// (eventueel met query), [teamId]/[teamSlug] wijzen het team aan waar de
/// link bij hoort (eerst wisselen, dan navigeren).
final class OpenRoute extends DeepLinkTarget {
  const OpenRoute(this.location, {this.teamId, this.teamSlug});

  final String location;
  final int? teamId;
  final String? teamSlug;

  @override
  bool operator ==(Object other) =>
      other is OpenRoute &&
      other.location == location &&
      other.teamId == teamId &&
      other.teamSlug == teamSlug;

  @override
  int get hashCode => Object.hash(location, teamId, teamSlug);

  @override
  String toString() =>
      'OpenRoute($location, teamId: $teamId, teamSlug: $teamSlug)';
}

/// Een inloglink uit de mail (`/magic/{token}`): token inwisselen via
/// `POST /auth/exchange`. [teamSlug] komt van het subdomein van de link.
final class MagicLogin extends DeepLinkTarget {
  const MagicLogin(this.token, {this.teamSlug});

  final String token;
  final String? teamSlug;

  @override
  bool operator ==(Object other) =>
      other is MagicLogin && other.token == token && other.teamSlug == teamSlug;

  @override
  int get hashCode => Object.hash(token, teamSlug);

  @override
  String toString() => 'MagicLogin(…, teamSlug: $teamSlug)';
}

/// Een publiek scherm: meedoen via de teamlink (`/meedoen/{token}`), de
/// bevestiglink uit de mail (`/meedoen/{token}/bevestig/{login}`, query
/// blijft), een uitnodiging (`/register/invite/{token}`) of zelf een team
/// aanmelden (`/aanmelden`, `?sport=` blijft). Opent zowel uitgelogd als
/// ingelogd, zonder eerst van team te wisselen.
final class OpenPublicRoute extends DeepLinkTarget {
  const OpenPublicRoute(this.location);

  /// Een [AppRoutes.join]/[AppRoutes.joinConfirm]/[AppRoutes.invite]/
  /// [AppRoutes.signup]-pad.
  final String location;

  @override
  bool operator ==(Object other) =>
      other is OpenPublicRoute && other.location == location;

  @override
  int get hashCode => location.hashCode;

  @override
  String toString() => 'OpenPublicRoute(…)';
}

/// Iets wat de app niet kan tonen (console, publieke live-pagina, vreemde
/// host, …). De app opent dan [fallback].
final class Unsupported extends DeepLinkTarget {
  const Unsupported([this.reason = '']);

  final String reason;

  /// Waar de app heen gaat als de link niet te tonen is.
  static const String fallback = AppRoutes.home;

  @override
  bool operator ==(Object other) => other is Unsupported;

  @override
  int get hashCode => (Unsupported).hashCode;

  @override
  String toString() => 'Unsupported($reason)';
}

/// Vertaalt een webadres van de PWA (vogels3) naar een app-route.
///
/// De ingelogde app-paden zijn gelijk aan de webpaden, dus een pad valt in
/// principe 1-op-1 op een route. Regels:
///
/// - Alleen relatieve paden (push `data.url`) of `http(s)` op [domains] en hun
///   subdomeinen. Andere hosts/schema's → [Unsupported].
/// - Teamslug uit het subdomein, volgens vogels3 `TeamHostResolver`: het
///   eerste label van een host met ≥ 3 delen, behalve de gereserveerde namen
///   ([reservedSubdomains]). `admin.` is de console → altijd [Unsupported].
///   `demo-<sport>` is een echt (demo)team en levert dus wél een slug.
/// - `/magic/{token}` → [MagicLogin].
/// - `/meedoen/{token}`, `/meedoen/{token}/bevestig/{login}` (query blijft)
///   en `/register/invite/{token}` → [OpenPublicRoute].
/// - `/aanmelden` en alles eronder (`/aanmelden/verstuurd`, …) →
///   [OpenPublicRoute] naar [AppRoutes.signup]; alleen `?sport=` gaat mee.
/// - `/` of leeg → [AppRoutes.home].
/// - Precies een app-route → die route (query blijft, `#fragment` valt weg).
/// - Anders het dichtstbijzijnde bovenliggende app-pad (`/savings/4` →
///   `/savings`, `/events/12/carpool` → `/events/12`); de query valt dan weg.
/// - Niets gevonden (`/admin/…`, `/live/{token}`, `/login`, een kapotte
///   `/meedoen/…`) → [Unsupported].
///
/// Een expliciet [teamId]/[teamSlug] (push-data) gaat vóór het subdomein.
abstract final class DeepLinkMapper {
  /// Domeinen waarvan de app links aanneemt (AASA/assetlinks in vogels3).
  static const Set<String> domains = {'assistje.nl'};

  /// vogels3 `TeamHostResolver::RESERVED_SUBDOMAINS`: nooit een team.
  static const Set<String> reservedSubdomains = {
    'www',
    'mail',
    'api',
    'app',
    'admin',
    'login',
    'demo',
    'staging',
  };

  /// Subdomein van de superadmin-console (vogels3 `AdminHost`).
  static const String adminSubdomain = 'admin';

  /// Ingelogde app-routes waar een link op mag landen (geen deur-routes).
  static const List<String> routeTemplates = [
    AppRoutes.agenda,
    AppRoutes.stats,
    AppRoutes.hallOfFame,
    AppRoutes.poule,
    AppRoutes.profile,
    AppRoutes.eventDetail,
    AppRoutes.eventAttendance,
    AppRoutes.eventLineup,
    AppRoutes.eventLive,
    AppRoutes.eventReport,
    AppRoutes.eventTrainingTeams,
    AppRoutes.notificationPreferences,
    AppRoutes.notifications,
    AppRoutes.onboarding,
    AppRoutes.team,
    AppRoutes.players,
    AppRoutes.playerDetail,
    AppRoutes.duties,
    AppRoutes.fines,
    AppRoutes.savings,
    AppRoutes.wheel,
    AppRoutes.messages,
    AppRoutes.agreements,
    AppRoutes.settings,
    AppRoutes.feedback,
    AppRoutes.schedule,
    AppRoutes.seasons,
    AppRoutes.vacations,
    AppRoutes.standingAbsences,
    AppRoutes.teamlink,
  ];

  /// Push-data van FCM: `{url, team_id, team_slug}` (allemaal strings, zie
  /// vogels3 docs/api/v1/devices.md).
  static DeepLinkTarget fromPushData(Map<String, String> data) {
    final url = data['url'];
    final uri = url == null ? null : Uri.tryParse(url.trim());
    final teamId = int.tryParse(data['team_id'] ?? '');
    final slug = data['team_slug'];
    if (uri == null) {
      // Geen (leesbare) url: open wel het juiste team.
      return OpenRoute(
        AppRoutes.home,
        teamId: teamId,
        teamSlug: slug == null || slug.isEmpty ? null : slug,
      );
    }
    return map(uri, teamId: teamId, teamSlug: slug);
  }

  /// Zie de klassedocumentatie.
  static DeepLinkTarget map(
    Uri uri, {
    int? teamId,
    String? teamSlug,
    Set<String> domains = DeepLinkMapper.domains,
  }) {
    String? hostSlug;
    if (uri.hasScheme || uri.host.isNotEmpty) {
      if (uri.scheme != 'https' && uri.scheme != 'http') {
        return Unsupported('schema ${uri.scheme}');
      }
      final host = uri.host.toLowerCase();
      if (!domains.any((d) => host == d || host.endsWith('.$d'))) {
        return Unsupported('host $host');
      }
      final labels = host.split('.');
      if (labels.length >= 3) {
        final first = labels.first;
        if (first == adminSubdomain) return const Unsupported('console');
        if (!reservedSubdomains.contains(first)) hostSlug = first;
      }
    }

    final explicitSlug = teamSlug == null || teamSlug.isEmpty ? null : teamSlug;
    final slug = explicitSlug ?? hostSlug;
    final segments = [
      for (final s in uri.pathSegments)
        if (s.isNotEmpty) s,
    ];

    if (segments.isEmpty) {
      return OpenRoute(AppRoutes.home, teamId: teamId, teamSlug: slug);
    }

    if (segments.first == 'magic') {
      return segments.length == 2
          ? MagicLogin(segments[1], teamSlug: slug)
          : const Unsupported('magic');
    }

    if (segments.first == 'aanmelden') {
      final sport = uri.queryParameters['sport']?.trim();
      return OpenPublicRoute(AppRoutes.signupLink(sport: sport));
    }

    if (segments.first == 'meedoen' ||
        (segments.first == 'register' &&
            segments.length > 1 &&
            segments[1] == 'invite')) {
      return _public(segments, uri);
    }

    // Exact een app-route: query mee (bv. `/settings?tab=season`).
    if (_matches(segments)) {
      final path = '/${segments.join('/')}';
      final location = uri.hasQuery ? '$path?${uri.query}' : path;
      return OpenRoute(location, teamId: teamId, teamSlug: slug);
    }

    // Het dichtstbijzijnde bovenliggende app-pad.
    for (var length = segments.length - 1; length > 0; length--) {
      final parent = segments.sublist(0, length);
      if (_matches(parent)) {
        return OpenRoute(
          '/${parent.join('/')}',
          teamId: teamId,
          teamSlug: slug,
        );
      }
    }

    return Unsupported('pad ${uri.path}');
  }

  static DeepLinkTarget _public(List<String> segments, Uri uri) {
    if (!AppRoutes.isPublic('/${segments.join('/')}')) {
      return Unsupported('pad ${uri.path}');
    }
    if (segments.first == 'register') {
      return OpenPublicRoute(AppRoutes.inviteLink(segments[2]));
    }
    if (segments.length == 2) {
      return OpenPublicRoute(AppRoutes.joinLink(segments[1]));
    }
    return OpenPublicRoute(
      AppRoutes.joinConfirmLink(
        segments[1],
        segments[3],
        query: uri.queryParameters,
      ),
    );
  }

  /// Is [location] (pad, eventueel met query) een van [routeTemplates]?
  static bool isAppRoute(String location) {
    final segments = [
      for (final s in Uri.parse(location).pathSegments)
        if (s.isNotEmpty) s,
    ];
    return _matches(segments);
  }

  static bool _matches(List<String> segments) {
    for (final template in routeTemplates) {
      final parts = template.substring(1).split('/');
      if (parts.length != segments.length) continue;
      var ok = true;
      for (var i = 0; i < parts.length && ok; i++) {
        final part = parts[i];
        ok = part.startsWith(':')
            ? (int.tryParse(segments[i]) ?? 0) > 0
            : part == segments[i];
      }
      if (ok) return true;
    }
    return false;
  }
}
