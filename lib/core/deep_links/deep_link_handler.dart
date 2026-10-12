import 'dart:async';
import 'dart:io' show Platform;

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_exception.dart';
import '../auth/auth_controller.dart';
import '../router/app_router.dart';
import '../router/app_routes.dart';
import '../session/models/me.dart';
import '../session/session_providers.dart';
import 'deep_link_mapper.dart';

/// Bron van binnenkomende links. De stream levert óók de link waarmee de app
/// koud gestart is (app_links ≥ 6: "initial link and further").
abstract interface class DeepLinkSource {
  Stream<Uri> get links;
}

/// [DeepLinkSource] op `app_links` (Universal Links / App Links).
class AppLinksSource implements DeepLinkSource {
  const AppLinksSource();

  @override
  Stream<Uri> get links {
    // Geen platformkanaal in web of `flutter test` (anders faalt elke
    // widgettest die de app opbouwt op een MissingPluginException).
    if (kIsWeb || Platform.environment.containsKey('FLUTTER_TEST')) {
      return const Stream<Uri>.empty();
    }
    return AppLinks().uriLinkStream;
  }
}

final deepLinkSourceProvider = Provider<DeepLinkSource>(
  (ref) => const AppLinksSource(),
);

/// Navigeert naar een `AppRoutes`-locatie. Test-naad; standaard
/// `routerProvider.go`.
final deepLinkNavigatorProvider = Provider<void Function(String location)>(
  (ref) =>
      (location) => ref.read(routerProvider).go(location),
);

/// Zet een link om in de juiste schermwissel:
///
/// - [OpenRoute]: wacht tot de inlogstatus bekend is en `/me` geladen is,
///   wisselt zo nodig eerst van team (id, of slug → id via `/me`), en gaat dan
///   naar de route. Niet ingelogd (of `/me` faalt) → de route wordt onthouden
///   en na het inloggen alsnog geopend.
/// - [MagicLogin]: niet ingelogd → `signInWithToken`; lukt dat niet (link
///   verlopen/gebruikt) → loginscherm. Al ingelogd → link negeren, alleen het
///   team van het subdomein openen.
/// - [OpenPublicRoute]: altijd openen (teamlink, uitnodiging); een onthouden
///   route vervalt.
/// - [Unsupported]: ingelogd → [Unsupported.fallback]; anders niets.
///
/// Links worden één voor één afgehandeld, in volgorde van binnenkomst.
class DeepLinkHandler {
  DeepLinkHandler(this._ref);

  final Ref _ref;
  Future<void> _queue = Future<void>.value();
  OpenRoute? _pending;

  /// De onthouden route voor na het inloggen (voor tests).
  @visibleForTesting
  OpenRoute? get pending => _pending;

  /// Een Universal/App Link (of een ander webadres).
  Future<void> handleUri(Uri uri) => handle(DeepLinkMapper.map(uri));

  /// Een tik op een push (`data` van FCM: `url`, `team_id`, `team_slug`).
  Future<void> handlePushData(Map<String, String> data) =>
      handle(DeepLinkMapper.fromPushData(data));

  Future<void> handle(DeepLinkTarget target) {
    final next = _queue.then((_) => _handle(target)).catchError((Object _) {});
    _queue = next;
    return next;
  }

  /// Opent de onthouden route, als die er is (na inloggen / `/me` geladen).
  Future<void> replayPending() {
    final target = _pending;
    if (target == null) return _queue;
    _pending = null;
    return handle(target);
  }

  Future<void> _handle(DeepLinkTarget target) async {
    switch (target) {
      case OpenRoute():
        await _open(target);
      case MagicLogin():
        await _magic(target);
      case OpenPublicRoute():
        // De nieuwste link wint: een onthouden route zou na het meedoen
        // (inloggen) over het teamscherm heen springen.
        _pending = null;
        await _settledStatus();
        _navigate(target.location);
      case Unsupported():
        if (await _settledStatus() == AuthStatus.signedIn) {
          _navigate(Unsupported.fallback);
        }
    }
  }

  Future<void> _open(OpenRoute target) async {
    if (await _settledStatus() != AuthStatus.signedIn) {
      _pending = target;
      return;
    }
    final me = await _me();
    if (me == null) {
      _pending = target;
      return;
    }
    final teamId = _resolveTeam(me, target);
    if (teamId != null && teamId != _ref.read(currentTeamIdProvider)) {
      await _ref.read(currentTeamIdProvider.notifier).select(teamId);
    }
    _navigate(target.location);
  }

  Future<void> _magic(MagicLogin target) async {
    final teamRoute = target.teamSlug == null
        ? null
        : OpenRoute(AppRoutes.home, teamSlug: target.teamSlug);

    if (await _settledStatus() == AuthStatus.signedIn) {
      if (teamRoute != null) await _open(teamRoute);
      return;
    }

    // Na het inloggen het team van de link openen (tenzij er al een
    // specifiekere route klaarstaat).
    final hadPending = _pending != null;
    _pending ??= teamRoute;
    try {
      await _ref
          .read(authControllerProvider.notifier)
          .signInWithToken(target.token);
    } on ApiException {
      if (!hadPending) _pending = null;
      _navigate(AppRoutes.login);
    }
  }

  /// Het team-id bij de link: [OpenRoute.teamId] als de gebruiker daar lid
  /// van is, anders de slug; `null` = niet wisselen.
  int? _resolveTeam(Me me, OpenRoute target) {
    for (final membership in me.teams) {
      if (target.teamId != null && membership.team.id == target.teamId) {
        return target.teamId;
      }
    }
    for (final membership in me.teams) {
      if (target.teamSlug != null && membership.team.slug == target.teamSlug) {
        return membership.team.id;
      }
    }
    return null;
  }

  Future<Me?> _me() async {
    try {
      return await _ref.read(meProvider.future);
    } on Object {
      return null;
    }
  }

  /// De inlogstatus zodra die niet meer [AuthStatus.unknown] is.
  Future<AuthStatus> _settledStatus() async {
    final current = _ref.read(authControllerProvider);
    if (current != AuthStatus.unknown) return current;
    final completer = Completer<AuthStatus>();
    final subscription = _ref.listen<AuthStatus>(authControllerProvider, (
      _,
      next,
    ) {
      if (next != AuthStatus.unknown && !completer.isCompleted) {
        completer.complete(next);
      }
    });
    try {
      return await completer.future;
    } finally {
      subscription.close();
    }
  }

  void _navigate(String location) =>
      _ref.read(deepLinkNavigatorProvider)(location);
}

/// De actieve [DeepLinkHandler]: luistert naar [deepLinkSourceProvider] en
/// speelt een onthouden route af zodra `/me` (na inloggen) geladen is.
/// `AssistjeApp` houdt deze provider actief; een push-client roept
/// [DeepLinkHandler.handlePushData] aan.
final deepLinkHandlerProvider = Provider<DeepLinkHandler>((ref) {
  final handler = DeepLinkHandler(ref);
  ref.listen<AsyncValue<Me?>>(meProvider, (_, next) {
    if (next.value != null && handler.pending != null) {
      unawaited(handler.replayPending());
    }
  });
  final subscription = ref
      .read(deepLinkSourceProvider)
      .links
      .listen((uri) => unawaited(handler.handleUri(uri)), onError: (_) {});
  ref.onDispose(subscription.cancel);
  return handler;
});
