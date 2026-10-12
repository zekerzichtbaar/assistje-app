import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/absences/presentation/standing_absences_screen.dart';
import '../../features/absences/presentation/vacations_screen.dart';
import '../../features/agenda/presentation/agenda_screen.dart';
import '../../features/agreements/presentation/agreements_screen.dart';
import '../../features/auth/presentation/login_code_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/duties/presentation/duties_screen.dart';
import '../../features/event/presentation/event_attendance_screen.dart';
import '../../features/event/presentation/event_detail_screen.dart';
import '../../features/event/presentation/event_lineup_screen.dart';
import '../../features/event/presentation/event_live_screen.dart';
import '../../features/event/presentation/event_report_screen.dart';
import '../../features/event/presentation/event_training_teams_screen.dart';
import '../../features/feedback/presentation/feedback_screen.dart';
import '../../features/fines/presentation/fines_screen.dart';
import '../../features/hall_of_fame/presentation/hall_of_fame_screen.dart';
import '../../features/home/presentation/no_team_screen.dart';
import '../../features/home/presentation/profile_tab_screen.dart';
import '../../features/join/presentation/invite_screen.dart';
import '../../features/join/presentation/join_confirm_screen.dart';
import '../../features/join/presentation/join_screen.dart';
import '../../features/messages/presentation/messages_screen.dart';
import '../../features/notifications/presentation/notification_preferences_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/players/presentation/player_detail_screen.dart';
import '../../features/players/presentation/players_screen.dart';
import '../../features/poule/presentation/poule_screen.dart';
import '../../features/savings/presentation/savings_screen.dart';
import '../../features/schedule/presentation/schedule_screen.dart';
import '../../features/seasons/presentation/seasons_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/signup/presentation/signup_screen.dart';
import '../../features/stats/presentation/stats_screen.dart';
import '../../features/team/presentation/team_screen.dart';
import '../../features/teamlink/presentation/teamlink_screen.dart';
import '../../features/wheel/presentation/wheel_screen.dart';
import '../auth/auth_controller.dart';
import '../session/session_providers.dart';
import '../shell/app_shell.dart';
import '../shell/nav_items.dart';
import '../shell/tab_shell.dart';
import 'app_routes.dart';
import 'auth_redirect.dart';

/// Een numerieke padparameter (`:eventId`, `:playerId`), of `null` als die
/// geen geheel getal is.
int? _intParam(GoRouterState state, String name) =>
    int.tryParse(state.pathParameters[name] ?? '');

/// Route-redirect voor een pad met een numeriek id: een kapot id (bv. een
/// oude of handgetypte link) gaat naar [AppRoutes.home] in plaats van een
/// scherm met een ongeldig id te bouwen.
String? _requireIntParam(GoRouterState state, String name) =>
    _intParam(state, name) == null ? AppRoutes.home : null;

/// Elk scherm hangt aan een eigen `XxxScreen` in `lib/features/<x>/`; een
/// feature-slice vervangt de body van dat scherm en raakt deze file niet.
/// De [GoRouter] van de app. Wordt één keer gebouwd; wijzigingen in auth,
/// `/me` en het actieve team laten hem via [GoRouter.refreshListenable]
/// opnieuw redirecten.
///
/// Opbouw: deur-routes op de root-navigator; daaronder één [ShellRoute]
/// ([AppShell]: pills + push-menu) met daarin de [StatefulShellRoute] voor de
/// tabs ([TabShell]) en alle schermen die over de tabs heen worden gepusht.
final routerProvider = Provider<GoRouter>((ref) {
  final refresh = ValueNotifier<int>(0);
  ref
    ..listen(authControllerProvider, (_, _) => refresh.value++)
    ..listen(meProvider, (_, _) => refresh.value++)
    ..listen(currentMembershipProvider, (_, _) => refresh.value++)
    ..onDispose(refresh.dispose);

  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      final location = state.uri.toString();
      return authRedirect(
            status: ref.read(authControllerProvider),
            me: ref.read(meProvider),
            location: location,
          ) ??
          navGuardRedirect(ref.read(currentMembershipProvider), location);
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splashName,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.loginName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.loginCode,
        name: AppRoutes.loginCodeName,
        builder: (context, state) =>
            LoginCodeScreen(email: state.uri.queryParameters['email'] ?? ''),
      ),
      GoRoute(
        path: AppRoutes.noTeam,
        name: AppRoutes.noTeamName,
        builder: (context, state) => const NoTeamScreen(),
      ),
      // Publiek (teamlink, uitnodiging, team aanmelden): buiten de tabshell,
      // in- én uitgelogd.
      GoRoute(
        path: AppRoutes.join,
        name: AppRoutes.joinName,
        builder: (context, state) =>
            JoinScreen(token: state.pathParameters['token']!),
      ),
      GoRoute(
        path: AppRoutes.joinConfirm,
        name: AppRoutes.joinConfirmName,
        builder: (context, state) => JoinConfirmScreen(
          token: state.pathParameters['token']!,
          login: state.pathParameters['login']!,
          query: state.uri.query,
        ),
      ),
      GoRoute(
        path: AppRoutes.invite,
        name: AppRoutes.inviteName,
        builder: (context, state) =>
            InviteScreen(token: state.pathParameters['token']!),
      ),
      GoRoute(
        path: AppRoutes.signup,
        name: AppRoutes.signupName,
        builder: (context, state) =>
            SignupScreen(sport: state.uri.queryParameters['sport']),
      ),
      GoRoute(
        path: AppRoutes.root,
        redirect: (context, state) => AppRoutes.home,
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(child: child),
        routes: [
          StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell) =>
                TabShell(navigationShell: navigationShell),
            // Volgorde = `tabBranches`.
            branches: [
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.agenda,
                    builder: (context, state) => const AgendaScreen(),
                  ),
                  GoRoute(
                    path: AppRoutes.eventDetail,
                    redirect: (context, state) =>
                        _requireIntParam(state, 'eventId'),
                    builder: (context, state) => EventDetailScreen(
                      eventId: _intParam(state, 'eventId')!,
                    ),
                    routes: [
                      GoRoute(
                        path: 'attendance',
                        builder: (context, state) => EventAttendanceScreen(
                          eventId: _intParam(state, 'eventId')!,
                        ),
                      ),
                      GoRoute(
                        path: 'lineup',
                        builder: (context, state) => EventLineupScreen(
                          eventId: _intParam(state, 'eventId')!,
                        ),
                      ),
                      GoRoute(
                        path: 'live',
                        builder: (context, state) => EventLiveScreen(
                          eventId: _intParam(state, 'eventId')!,
                        ),
                      ),
                      GoRoute(
                        path: 'report',
                        builder: (context, state) => EventReportScreen(
                          eventId: _intParam(state, 'eventId')!,
                        ),
                      ),
                      GoRoute(
                        path: 'teams',
                        builder: (context, state) => EventTrainingTeamsScreen(
                          eventId: _intParam(state, 'eventId')!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.stats,
                    builder: (context, state) => const StatsScreen(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.hallOfFame,
                    builder: (context, state) => const HallOfFameScreen(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.poule,
                    builder: (context, state) => const PouleScreen(),
                  ),
                ],
              ),
              StatefulShellBranch(
                routes: [
                  GoRoute(
                    path: AppRoutes.profile,
                    builder: (context, state) => const ProfileTabScreen(),
                    routes: [
                      GoRoute(
                        path: 'notifications',
                        builder: (context, state) =>
                            const NotificationPreferencesScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.notifications,
            builder: (context, state) => const NotificationsScreen(),
          ),
          GoRoute(
            path: AppRoutes.onboarding,
            builder: (context, state) => const OnboardingScreen(),
          ),
          GoRoute(
            path: AppRoutes.team,
            builder: (context, state) => const TeamScreen(),
          ),
          GoRoute(
            path: AppRoutes.players,
            builder: (context, state) => const PlayersScreen(),
            routes: [
              GoRoute(
                path: ':playerId',
                redirect: (context, state) =>
                    _requireIntParam(state, 'playerId'),
                builder: (context, state) =>
                    PlayerDetailScreen(playerId: _intParam(state, 'playerId')!),
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.duties,
            builder: (context, state) => const DutiesScreen(),
          ),
          GoRoute(
            path: AppRoutes.fines,
            builder: (context, state) => const FinesScreen(),
          ),
          GoRoute(
            path: AppRoutes.savings,
            builder: (context, state) => const SavingsScreen(),
          ),
          GoRoute(
            path: AppRoutes.wheel,
            builder: (context, state) => const WheelScreen(),
          ),
          GoRoute(
            path: AppRoutes.messages,
            builder: (context, state) => const MessagesScreen(),
          ),
          GoRoute(
            path: AppRoutes.agreements,
            builder: (context, state) => const AgreementsScreen(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: AppRoutes.feedback,
            builder: (context, state) => const FeedbackScreen(),
          ),
          GoRoute(
            path: AppRoutes.schedule,
            builder: (context, state) => const ScheduleScreen(),
          ),
          GoRoute(
            path: AppRoutes.seasons,
            builder: (context, state) => const SeasonsScreen(),
          ),
          GoRoute(
            path: AppRoutes.vacations,
            builder: (context, state) => const VacationsScreen(),
          ),
          GoRoute(
            path: AppRoutes.standingAbsences,
            builder: (context, state) => const StandingAbsencesScreen(),
          ),
          GoRoute(
            path: AppRoutes.teamlink,
            builder: (context, state) => const TeamlinkScreen(),
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
