import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_controller.dart';
import '../session/models/me.dart';
import 'app_routes.dart';

/// De redirectregels als pure functie (los testbaar):
///
/// - publieke schermen (teamlink, uitnodiging: [AppRoutes.isPublic]) mogen
///   altijd — uitgelogd, ingelogd, zonder team en tijdens het opstarten;
/// - status onbekend, of ingelogd terwijl `/me` laadt of faalde → [AppRoutes.splash];
/// - uitgelogd → [AppRoutes.login] (de loginroutes zelf mogen);
/// - ingelogd zonder teams → [AppRoutes.noTeam];
/// - ingelogd met team, maar op een login-/start-/geen-teamscherm of op `/`
///   → [AppRoutes.home] (de Agenda-tab).
///
/// Geeft `null` als [location] goed is.
String? authRedirect({
  required AuthStatus status,
  required AsyncValue<Me?> me,
  required String location,
}) {
  final path = Uri.parse(location).path;
  if (AppRoutes.isPublic(path)) return null;
  final onLogin = path == AppRoutes.login || path == AppRoutes.loginCode;

  String? goTo(String target) => path == target ? null : target;

  switch (status) {
    case AuthStatus.unknown:
      return goTo(AppRoutes.splash);
    case AuthStatus.signedOut:
      return onLogin ? null : AppRoutes.login;
    case AuthStatus.signedIn:
      final data = me.value;
      if (data == null || (me.hasError && !me.isLoading)) {
        return goTo(AppRoutes.splash);
      }
      if (data.teams.isEmpty) return goTo(AppRoutes.noTeam);
      if (onLogin ||
          path == AppRoutes.splash ||
          path == AppRoutes.noTeam ||
          path == AppRoutes.root ||
          path.isEmpty) {
        return AppRoutes.home;
      }
      return null;
  }
}
