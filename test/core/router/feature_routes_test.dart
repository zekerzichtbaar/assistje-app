import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/features/absences/presentation/standing_absences_screen.dart';
import 'package:assistje/features/absences/presentation/vacations_screen.dart';
import 'package:assistje/features/agreements/presentation/agreements_screen.dart';
import 'package:assistje/features/duties/presentation/duties_screen.dart';
import 'package:assistje/features/event/presentation/event_attendance_screen.dart';
import 'package:assistje/features/event/presentation/event_detail_screen.dart';
import 'package:assistje/features/event/presentation/event_lineup_screen.dart';
import 'package:assistje/features/event/presentation/event_live_screen.dart';
import 'package:assistje/features/event/presentation/event_report_screen.dart';
import 'package:assistje/features/event/presentation/event_training_teams_screen.dart';
import 'package:assistje/features/feedback/presentation/feedback_screen.dart';
import 'package:assistje/features/fines/presentation/fines_screen.dart';
import 'package:assistje/features/hall_of_fame/presentation/hall_of_fame_screen.dart';
import 'package:assistje/features/messages/presentation/messages_screen.dart';
import 'package:assistje/features/notifications/presentation/notification_preferences_screen.dart';
import 'package:assistje/features/notifications/presentation/notifications_screen.dart';
import 'package:assistje/features/onboarding/presentation/onboarding_screen.dart';
import 'package:assistje/features/players/presentation/player_detail_screen.dart';
import 'package:assistje/features/players/presentation/players_screen.dart';
import 'package:assistje/features/poule/presentation/poule_screen.dart';
import 'package:assistje/features/savings/presentation/savings_screen.dart';
import 'package:assistje/features/schedule/presentation/schedule_screen.dart';
import 'package:assistje/features/seasons/presentation/seasons_screen.dart';
import 'package:assistje/features/settings/presentation/settings_screen.dart';
import 'package:assistje/features/stats/presentation/stats_screen.dart';
import 'package:assistje/features/team/presentation/team_screen.dart';
import 'package:assistje/features/teamlink/presentation/teamlink_screen.dart';
import 'package:assistje/features/wheel/presentation/wheel_screen.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/shell.dart';

void main() {
  // Trainer met alle features: elke route is toegestaan door de nav-guard.
  final trainer = ApiFixtures.membership(
    role: 'trainer',
    features: {
      'stats': true,
      'fines': true,
      'savings': true,
      'wheel': true,
      'messages': true,
      'agreements': true,
    },
    hasPoule: true,
  );

  final routes = <String, Type>{
    '/events/12': EventDetailScreen,
    '/events/12/attendance': EventAttendanceScreen,
    '/events/12/lineup': EventLineupScreen,
    '/events/12/live': EventLiveScreen,
    '/events/12/report': EventReportScreen,
    '/events/12/teams': EventTrainingTeamsScreen,
    AppRoutes.stats: StatsScreen,
    AppRoutes.hallOfFame: HallOfFameScreen,
    AppRoutes.poule: PouleScreen,
    AppRoutes.notificationPreferences: NotificationPreferencesScreen,
    AppRoutes.notifications: NotificationsScreen,
    AppRoutes.onboarding: OnboardingScreen,
    AppRoutes.team: TeamScreen,
    AppRoutes.players: PlayersScreen,
    '/players/7': PlayerDetailScreen,
    AppRoutes.duties: DutiesScreen,
    AppRoutes.fines: FinesScreen,
    AppRoutes.savings: SavingsScreen,
    AppRoutes.wheel: WheelScreen,
    AppRoutes.messages: MessagesScreen,
    AppRoutes.agreements: AgreementsScreen,
    AppRoutes.settings: SettingsScreen,
    AppRoutes.feedback: FeedbackScreen,
    AppRoutes.schedule: ScheduleScreen,
    AppRoutes.seasons: SeasonsScreen,
    AppRoutes.vacations: VacationsScreen,
    AppRoutes.standingAbsences: StandingAbsencesScreen,
    AppRoutes.teamlink: TeamlinkScreen,
  };

  testWidgets('elke feature-route bouwt het eigen scherm van die feature', (
    tester,
  ) async {
    final (container, _) = await pumpSignedIn(tester, teams: [trainer]);
    final router = container.read(routerProvider);

    for (final MapEntry(key: path, value: type) in routes.entries) {
      router.go(path);
      await tester.pumpAndSettle();
      expect(router.state.uri.path, path);
      expect(find.byType(type), findsOneWidget, reason: path);
    }
  });

  testWidgets('padparameters komen als int bij het scherm', (tester) async {
    final (container, _) = await pumpSignedIn(tester, teams: [trainer]);
    final router = container.read(routerProvider);

    router.go(AppRoutes.event(42));
    await tester.pumpAndSettle();
    expect(
      tester.widget<EventDetailScreen>(find.byType(EventDetailScreen)).eventId,
      42,
    );

    router.go('/events/42/live');
    await tester.pumpAndSettle();
    expect(
      tester.widget<EventLiveScreen>(find.byType(EventLiveScreen)).eventId,
      42,
    );

    router.go(AppRoutes.player(7));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<PlayerDetailScreen>(find.byType(PlayerDetailScreen))
          .playerId,
      7,
    );
  });

  testWidgets('een niet-numeriek id stuurt naar home', (tester) async {
    final (container, _) = await pumpSignedIn(tester, teams: [trainer]);
    final router = container.read(routerProvider);

    for (final path in ['/events/abc', '/events/abc/live', '/players/x']) {
      router.go(path);
      await tester.pumpAndSettle();
      expect(router.state.uri.path, AppRoutes.home, reason: path);
    }
  });
}
