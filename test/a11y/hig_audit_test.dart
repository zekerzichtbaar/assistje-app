// HIG-/toegankelijkheidsaudit: elk hoofdscherm op iPhone SE en Pro Max,
// op standaard- en de grootste tekstgrootte (AX5), met iOS-gedrag.
//
// Per scherm:
// - geen layoutfouten (overlopende Row/Column) — ook niet bij AX5;
// - tikvlakken ≥ 44×44 pt (iOS) en een label op elk tikbaar element
//   (VoiceOver);
// - tekstcontrast ≥ 4.5:1 (alleen op standaardgrootte, licht thema).
//
// Schermafbeeldingen (met de echte fonts) komen in `$HIG_SHOTS_DIR` als die
// omgevingsvariabele gezet is:
//   HIG_SHOTS_DIR=/tmp/shots flutter test test/a11y/hig_audit_test.dart
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/agreements/agreements_fixtures.dart';
import '../features/attendance/attendance_fixtures.dart';
import '../features/duties/duties_fixtures.dart';
import '../features/event/event_fixtures.dart';
import '../features/feedback/feedback_fixtures.dart';
import '../features/fines/fines_fixtures.dart';
import '../features/hall_of_fame/hall_of_fame_fixtures.dart';
import '../features/lineup/lineup_fixtures.dart';
import '../features/live/live_fixtures.dart';
import '../features/messages/messages_fixtures.dart';
import '../features/notifications/notification_fixtures.dart';
import '../features/onboarding/onboarding_fixtures.dart';
import '../features/player_management/pm_fixtures.dart';
import '../features/poule/poule_fixtures.dart';
import '../features/profile/profile_fixtures.dart';
import '../features/savings/savings_fixtures.dart';
import '../features/schedule/schedule_fixtures.dart';
import '../features/seasons/seasons_fixtures.dart';
import '../features/settings/settings_fixtures.dart';
import '../features/stats/stats_fixtures.dart';
import '../features/team/roster_fixtures.dart';
import '../features/training_teams/training_teams_fixtures.dart';
import '../features/wheel/wheel_fixtures.dart';
import '../helpers/api_fixtures.dart';
import 'hig_harness.dart';

final _screens = <AuditScreen>[
  AuditScreen(
    '/agenda',
    trainer: false,
    setup: (h) =>
        h.on('GET /teams/3/agenda', 200, ApiFixtures.agendaResponse()),
  ),
  AuditScreen(
    '/stats',
    setup: (h) => h.on('GET /teams/3/stats', 200, StatsFixtures.response()),
  ),
  AuditScreen(
    '/hall-of-fame',
    setup: (h) =>
        h.on('GET /teams/3/hall-of-fame', 200, HallOfFameFixtures.response()),
  ),
  AuditScreen(
    '/poule',
    setup: (h) => h.on('GET /teams/3/poule', 200, PouleFixtures.poule()),
  ),
  const AuditScreen('/more'),
  AuditScreen(
    '/profile',
    trainer: false,
    setup: (h) => h.on('GET /teams/3/profile', 200, ProfileFixtures.profile()),
  ),
  AuditScreen(
    '/notifications',
    setup: (h) =>
        h.on('GET /teams/3/notifications', 200, NotificationFixtures.page()),
  ),
  AuditScreen(
    '/events/412',
    setup: (h) => h.on(
      'GET /teams/3/events/412',
      200,
      EventFixtures.eventDetail({
        'starts_at': '2099-10-11T14:30:00+02:00',
        'is_trainer': true,
      }),
    ),
  ),
  // Activiteit met inleg (spaarpot) en uitklapbare spelersrijen.
  AuditScreen(
    '/events/413',
    label: 'activiteit-pot',
    setup: (h) => h.on(
      'GET /teams/3/events/413',
      200,
      EventFixtures.eventDetail({
        'id': 413,
        'type': 'activity',
        'starts_at': '2099-10-11T14:30:00+02:00',
        'savings_pot': {
          'id': 7,
          'name': 'Bowlen',
          'amount_cents': 1250,
          'one_off': true,
          'paid_count': 3,
          'participant_count': 8,
          'open_cents': 6250,
          'i_paid': false,
          'i_refund': false,
          'i_refunded': false,
        },
      }),
    ),
  ),
  AuditScreen(
    '/events/412/attendance',
    setup: (h) => h
      ..on('GET /teams/3/events/412', 200, EventFixtures.eventDetail())
      ..on(
        'GET /teams/3/events/412/attendance',
        200,
        AttendanceFixtures.attendance(),
      ),
  ),
  AuditScreen(
    '/events/412/lineup',
    setup: (h) => h
      ..on('GET /teams/3/events/412', 200, EventFixtures.eventDetail())
      ..on(LineupFixtures.get, 200, LineupFixtures.response()),
  ),
  AuditScreen(
    '/events/412/live',
    setup: (h) => h
      ..on('GET /teams/3/events/412', 200, EventFixtures.eventDetail())
      ..on(LiveFixtures.get, 200, LiveFixtures.response()),
  ),
  AuditScreen(
    '/events/512/teams',
    setup: (h) => h.on(
      'GET /teams/3/events/512/teams',
      200,
      TrainingTeamsFixtures.screen(),
    ),
  ),
  AuditScreen(
    '/team',
    trainer: false,
    setup: (h) => h.on('GET /teams/3/team', 200, RosterFixtures.roster()),
  ),
  AuditScreen(
    '/players',
    setup: (h) => h.on('GET /teams/3/players', 200, PmFixtures.overview()),
  ),
  AuditScreen(
    '/players/14',
    setup: (h) =>
        h.on('GET /teams/3/players/14', 200, RosterFixtures.playerDetail()),
  ),
  AuditScreen(
    '/duties',
    setup: (h) => h.on('GET /teams/3/duties', 200, DutiesFixtures.individual()),
  ),
  AuditScreen(
    '/duties',
    label: 'een-of-meer',
    setup: (h) => h.on('GET /teams/3/duties', 200, DutiesFixtures.multi()),
  ),
  AuditScreen(
    '/diensten',
    trainer: false,
    setup: (h) =>
        h.on('GET /teams/3/duty-overview', 200, DutiesFixtures.overview()),
  ),
  AuditScreen(
    '/fines',
    trainer: false,
    setup: (h) => h.on('GET /teams/3/fines', 200, FinesFixtures.overview()),
  ),
  AuditScreen(
    '/savings',
    setup: (h) => h.on('GET /teams/3/savings', 200, SavingsFixtures.overview()),
  ),
  // Spaarpot zonder bedrag (afvinklijst): overzicht met vinkjes en het
  // detail zonder geld en zonder afrekening.
  AuditScreen(
    '/savings',
    label: 'afvinklijst',
    setup: (h) => h
      ..on(
        'GET /teams/3/savings',
        200,
        SavingsFixtures.overview(
          canManage: true,
          pots: [SavingsFixtures.checklistRow()..['id'] = 12],
        ),
      )
      ..on('GET /teams/3/savings/12', 200, SavingsFixtures.checklistDetail()),
    open: (t) => auditTap(t, find.byKey(const ValueKey('savings-pot-12'))),
  ),
  // Het formulier met de schakelaar "Zonder bedrag" aan.
  AuditScreen(
    '/savings',
    label: 'afvinklijst-formulier',
    setup: (h) => h
      ..on(
        'GET /teams/3/savings',
        200,
        SavingsFixtures.overview(canManage: true),
      )
      ..on('GET /teams/3/savings/create', 200, SavingsFixtures.createOptions()),
    open: (t) async {
      await auditTap(t, find.byKey(const ValueKey('savings-new')));
      await auditTap(
        t,
        find.byKey(const ValueKey('savings-form-without-amount')),
      );
    },
  ),
  AuditScreen(
    '/wheel',
    setup: (h) => h.on('GET /teams/3/wheel', 200, WheelFixtures.overview()),
  ),
  AuditScreen(
    '/messages',
    setup: (h) =>
        h.on('GET /teams/3/messages', 200, MessagesFixtures.overview()),
  ),
  AuditScreen(
    '/agreements',
    setup: (h) =>
        h.on('GET /teams/3/agreements', 200, AgreementsFixtures.overview()),
  ),
  AuditScreen(
    '/settings',
    setup: (h) =>
        h.on('GET /teams/3/settings', 200, SettingsFixtures.response()),
  ),
  AuditScreen(
    '/feedback',
    setup: (h) => h.on('GET /teams/3/feedback', 200, FeedbackFixtures.list()),
  ),
  AuditScreen(
    '/schedule',
    setup: (h) =>
        h.on('GET /teams/3/schedule/options', 200, ScheduleFixtures.options()),
  ),
  AuditScreen(
    '/seasons',
    setup: (h) => h.on('GET /teams/3/seasons', 200, SeasonsFixtures.response()),
  ),
  AuditScreen(
    '/onboarding',
    setup: (h) =>
        h.on('GET /teams/3/onboarding', 200, OnboardingFixtures.checklist()),
  ),
  AuditScreen(
    '/teamlink',
    setup: (h) => h.on('GET /teams/3/teamlink', 200, PmFixtures.teamLink()),
  ),
];

void main() => registerAudit(_screens);
