import 'dart:io';

import 'package:assistje/core/deep_links/deep_link_mapper.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter_test/flutter_test.dart';

/// Eén `data.url` die een vogels3-notificatie (app/Notifications) meestuurt.
typedef _Case = ({String notification, String? url, String expected});

/// Elke notificatie in vogels3 `app/Notifications/**` met het pad dat ze als
/// `data.url` (push) meegeeft, en de app-route waar een tik op uitkomt.
/// `{id}` staat voor een echt id (12). Console-meldingen (superadmin) komen
/// nooit in de app, maar staan er voor de volledigheid in: die vallen terug op
/// [Unsupported.fallback].
const List<_Case> _notificationCases = [
  // Vrij invulbare url van een beheerdersbericht (MessagesController,
  // nullable): elk app-pad, of niets.
  (notification: 'AdminMessageNotification', url: '/fines', expected: '/fines'),
  (notification: 'AdminMessageNotification', url: null, expected: '/agenda'),
  // `/players/{id}` (speler) of `/agenda` (staflid zonder spelersprofiel).
  (
    notification: 'BirthdayNotification',
    url: '/players/12',
    expected: '/players/12',
  ),
  (notification: 'BirthdayNotification', url: '/agenda', expected: '/agenda'),
  (
    notification: 'CarpoolReminderNotification',
    url: '/events/12#carpool',
    expected: '/events/12',
  ),
  (
    notification: 'DutyReminderNotification',
    url: '/agenda',
    expected: '/agenda',
  ),
  // `/events/{event_id}` of `/agenda` (taak zonder event).
  (
    notification: 'DutyReplacementNeededNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  (
    notification: 'DutyReplacementNeededNotification',
    url: '/agenda',
    expected: '/agenda',
  ),
  (
    notification: 'DutyUnavailableNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  (
    notification: 'DutyUnavailableNotification',
    url: '/agenda',
    expected: '/agenda',
  ),
  (
    notification: 'EventCreatedNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  (
    notification: 'EventUpdatedNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  // Console (superadmin): niet in de app.
  (
    notification: 'FeedbackReceivedNotification',
    url: '/admin/feedback',
    expected: '/agenda',
  ),
  (
    notification: 'FeedbackRepliedByReporterNotification',
    url: '/admin/feedback',
    expected: '/agenda',
  ),
  (
    notification: 'FeedbackRepliedNotification',
    url: '/feedback',
    expected: '/feedback',
  ),
  (
    notification: 'FeedbackResolvedNotification',
    url: '/feedback',
    expected: '/feedback',
  ),
  // Console: absolute url op de admin-host, of het pad zonder APP_DOMAIN.
  (
    notification: 'LeadReceivedNotification',
    url: 'https://admin.assistje.nl/admin/aanvragen',
    expected: '/agenda',
  ),
  (
    notification: 'LeadReceivedNotification',
    url: '/admin/aanvragen',
    expected: '/agenda',
  ),
  // Alleen mail (console), geen push-data: geen url.
  (
    notification: 'LeadReplyReceivedNotification',
    url: null,
    expected: '/agenda',
  ),
  (
    notification: 'LineupPublishedNotification',
    url: '/events/12/lineup',
    expected: '/events/12/lineup',
  ),
  (
    notification: 'LiveBreakNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  (
    notification: 'LiveClockReminderNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  (
    notification: 'LiveFinalNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  (
    notification: 'LiveGoalNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  (
    notification: 'LiveMomentNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  (
    notification: 'LiveRedCardNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  (
    notification: 'LiveStartedNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  (
    notification: 'MatchReportReminderNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  (
    notification: 'MotmResultNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  (
    notification: 'MotmVotingOpenNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  (
    notification: 'PeriodClosedNotification',
    url: '/hall-of-fame',
    expected: '/hall-of-fame',
  ),
  (
    notification: 'PlayerStatusNotification',
    url: '/players/12',
    expected: '/players/12',
  ),
  (notification: 'PouleResultsNotification', url: '/poule', expected: '/poule'),
  (
    notification: 'RsvpLateCancelNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  (
    notification: 'RsvpLateJoinNotification',
    url: '/events/12',
    expected: '/events/12',
  ),
  (notification: 'RsvpShameNotification', url: '/agenda', expected: '/agenda'),
  // Geen potdetail in de app: de spaarpotten-lijst.
  (
    notification: 'SavingsReminderNotification',
    url: '/savings/4',
    expected: '/savings',
  ),
  (
    notification: 'ScheduleReadyNotification',
    url: '/agenda',
    expected: '/agenda',
  ),
  (
    notification: 'SeasonClosedNotification',
    url: '/settings?tab=season',
    expected: '/settings?tab=season',
  ),
  (
    notification: 'SeasonEndingNotification',
    url: '/settings?tab=season',
    expected: '/settings?tab=season',
  ),
  // Console: absolute url naar het team in de console.
  (
    notification: 'TeamSignedUpNotification',
    url: 'https://admin.assistje.nl/admin/teams/5',
    expected: '/agenda',
  ),
  // `/agenda` voor een teamlid, de console-url voor een superadmin.
  (notification: 'TestPushNotification', url: '/agenda', expected: '/agenda'),
  (
    notification: 'TestPushNotification',
    url: 'https://admin.assistje.nl/admin',
    expected: '/agenda',
  ),
  (
    notification: 'TitleChangedNotification',
    url: '/hall-of-fame',
    expected: '/hall-of-fame',
  ),
];

/// Alle ingelogde routes uit [AppRoutes], hier los opgesomd zodat de test
/// niet op de lijst van de mapper zelf leunt.
const List<String> _appRoutes = [
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

bool _isAppRoute(String location) {
  final path = Uri.parse(location).path;
  return _appRoutes.any((template) {
    final pattern = template.replaceAllMapped(
      RegExp(r':\w+'),
      (_) => r'[1-9]\d*',
    );
    return RegExp('^$pattern\$').hasMatch(path);
  });
}

/// Waar de app na een tik heen gaat.
String _resolve(DeepLinkTarget target) => switch (target) {
  OpenRoute(:final location) => location,
  MagicLogin() => fail('onverwachte inloglink'),
  OpenPublicRoute() => fail('onverwacht publiek scherm'),
  Unsupported() => Unsupported.fallback,
};

void main() {
  group('elke notificatie uit vogels3 valt op een app-route', () {
    for (final c in _notificationCases) {
      test('${c.notification} ${c.url ?? '(geen url)'}', () {
        final target = DeepLinkMapper.fromPushData({
          'url': ?c.url,
          'team_id': '3',
          'team_slug': 'vogels-3',
        });
        final location = _resolve(target);
        expect(location, c.expected);
        expect(_isAppRoute(location), isTrue, reason: location);
        if (target is OpenRoute) {
          expect(target.teamId, 3);
          expect(target.teamSlug, 'vogels-3');
        }
      });
    }
  });

  test('de tabel dekt elke notificatieklasse in vogels3', () {
    final dir = Directory(
      '/Users/michaelvansetten/Sites/vogels3/app/Notifications',
    );
    if (!dir.existsSync()) {
      markTestSkipped('vogels3 niet aanwezig op dit toestel');
      return;
    }
    final classes = {
      for (final file in dir.listSync().whereType<File>())
        if (file.path.endsWith('Notification.php'))
          file.uri.pathSegments.last.replaceAll('.php', ''),
    };
    final covered = {for (final c in _notificationCases) c.notification};
    expect(classes.difference(covered), isEmpty);
    expect(classes.length, greaterThanOrEqualTo(38));
  });

  group('Universal/App Links', () {
    test('teamsubdomein levert de slug', () {
      expect(
        DeepLinkMapper.map(Uri.parse('https://vogels-3.assistje.nl/events/12')),
        const OpenRoute('/events/12', teamSlug: 'vogels-3'),
      );
    });

    test('demo-<sport> is een team, de algemene demo-host niet', () {
      expect(
        DeepLinkMapper.map(Uri.parse('https://demo-hockey.assistje.nl/agenda')),
        const OpenRoute('/agenda', teamSlug: 'demo-hockey'),
      );
      expect(
        DeepLinkMapper.map(Uri.parse('https://demo.assistje.nl/agenda')),
        const OpenRoute('/agenda'),
      );
    });

    test('gereserveerde subdomeinen en het kale domein: geen slug', () {
      for (final host in ['www.assistje.nl', 'login.assistje.nl']) {
        expect(
          DeepLinkMapper.map(Uri.parse('https://$host/agenda')),
          const OpenRoute('/agenda'),
        );
      }
      expect(
        DeepLinkMapper.map(Uri.parse('https://assistje.nl/events/3')),
        const OpenRoute('/events/3'),
      );
    });

    test('push-data gaat vóór het subdomein', () {
      expect(
        DeepLinkMapper.map(
          Uri.parse('https://vogels-3.assistje.nl/poule'),
          teamId: 9,
          teamSlug: 'zwaluwen-vr1',
        ),
        const OpenRoute('/poule', teamId: 9, teamSlug: 'zwaluwen-vr1'),
      );
    });

    test('inloglink → MagicLogin met de slug van het subdomein', () {
      final token = 'a' * 64;
      expect(
        DeepLinkMapper.map(
          Uri.parse('https://vogels-3.assistje.nl/magic/$token'),
        ),
        MagicLogin(token, teamSlug: 'vogels-3'),
      );
      expect(
        DeepLinkMapper.map(Uri.parse('https://login.assistje.nl/magic/$token')),
        MagicLogin(token),
      );
      expect(
        DeepLinkMapper.map(Uri.parse('/magic/$token/opnieuw')),
        isA<Unsupported>(),
      );
    });

    test('root → home', () {
      expect(
        DeepLinkMapper.map(Uri.parse('https://vogels-3.assistje.nl/')),
        const OpenRoute(AppRoutes.home, teamSlug: 'vogels-3'),
      );
    });

    test('alleen-web paden → Unsupported', () {
      for (final path in [
        '/admin/teams',
        '/live/abcdef',
        '/meedoen',
        '/meedoen/abcdef/iets',
        '/register/invite',
        '/register/abc',
        '/login',
        '/api/v1/me',
      ]) {
        expect(
          DeepLinkMapper.map(Uri.parse('https://vogels-3.assistje.nl$path')),
          isA<Unsupported>(),
          reason: path,
        );
      }
    });

    test('teamlink, bevestiglink en uitnodiging → publieke route', () {
      for (final host in [
        'https://vogels-3.assistje.nl',
        'https://assistje.nl',
        'https://www.assistje.nl',
        'https://demo-voetbal.assistje.nl',
      ]) {
        expect(
          DeepLinkMapper.map(Uri.parse('$host/meedoen/Xk3abc')),
          const OpenPublicRoute('/meedoen/Xk3abc'),
          reason: host,
        );
        expect(
          DeepLinkMapper.map(
            Uri.parse(
              '$host/meedoen/Xk3abc/bevestig/L0g1n?role=player&player=12#x',
            ),
          ),
          const OpenPublicRoute(
            '/meedoen/Xk3abc/bevestig/L0g1n?role=player&player=12',
          ),
          reason: host,
        );
        expect(
          DeepLinkMapper.map(Uri.parse('$host/register/invite/inv123')),
          const OpenPublicRoute('/register/invite/inv123'),
          reason: host,
        );
      }
      // Relatief pad (push) en een slash op het eind.
      expect(
        DeepLinkMapper.map(Uri.parse('/meedoen/Xk3abc/')),
        const OpenPublicRoute('/meedoen/Xk3abc'),
      );
      // De console en vreemde hosts blijven buiten.
      expect(
        DeepLinkMapper.map(Uri.parse('https://admin.assistje.nl/meedoen/abc')),
        isA<Unsupported>(),
      );
      expect(
        DeepLinkMapper.map(Uri.parse('https://example.com/meedoen/abc')),
        isA<Unsupported>(),
      );
    });

    test('/aanmelden (+ ?sport=) → publieke aanmeldroute', () {
      for (final host in [
        'https://assistje.nl',
        'https://www.assistje.nl',
        'https://vogels-3.assistje.nl',
      ]) {
        expect(
          DeepLinkMapper.map(Uri.parse('$host/aanmelden?sport=hockey')),
          const OpenPublicRoute('/aanmelden?sport=hockey'),
          reason: host,
        );
        expect(
          DeepLinkMapper.map(Uri.parse('$host/aanmelden')),
          const OpenPublicRoute('/aanmelden'),
          reason: host,
        );
      }
      // Andere query valt weg, lege sport ook; onderliggende paden
      // (`/aanmelden/*` in de AASA) landen op het aanmeldscherm.
      expect(
        DeepLinkMapper.map(
          Uri.parse('https://assistje.nl/aanmelden?sport=&utm_source=x#y'),
        ),
        const OpenPublicRoute('/aanmelden'),
      );
      expect(
        DeepLinkMapper.map(
          Uri.parse('https://assistje.nl/aanmelden/verstuurd'),
        ),
        const OpenPublicRoute('/aanmelden'),
      );
      expect(
        DeepLinkMapper.map(Uri.parse('/aanmelden?sport=Volleybal')),
        const OpenPublicRoute('/aanmelden?sport=Volleybal'),
      );
      expect(
        DeepLinkMapper.map(Uri.parse('https://admin.assistje.nl/aanmelden')),
        isA<Unsupported>(),
      );
      expect(
        DeepLinkMapper.map(Uri.parse('https://example.com/aanmelden')),
        isA<Unsupported>(),
      );
    });

    test('dichtstbijzijnde bovenliggende route', () {
      expect(
        DeepLinkMapper.map(Uri.parse('/agenda/2026-10')),
        const OpenRoute('/agenda'),
      );
      expect(
        DeepLinkMapper.map(Uri.parse('/notifications/5')),
        const OpenRoute('/notifications'),
      );
      expect(
        DeepLinkMapper.map(Uri.parse('/players/abc')),
        const OpenRoute('/players'),
      );
    });

    test('vreemde host, console-host of schema → Unsupported', () {
      for (final url in [
        'https://example.com/events/12',
        'https://assistje.nl.evil.com/events/12',
        'https://admin.assistje.nl/admin/teams/5',
        'mailto:sam@example.com',
        'assistje://events/12',
      ]) {
        expect(
          DeepLinkMapper.map(Uri.parse(url)),
          isA<Unsupported>(),
          reason: url,
        );
      }
    });

    test('push zonder url opent het team op home', () {
      expect(
        DeepLinkMapper.fromPushData({'team_id': '3'}),
        const OpenRoute(AppRoutes.home, teamId: 3),
      );
    });

    test('mapper en test kennen dezelfde routes', () {
      expect(DeepLinkMapper.routeTemplates.toSet(), _appRoutes.toSet());
      for (final route in DeepLinkMapper.routeTemplates) {
        final concrete = route.replaceAll(RegExp(r':\w+'), '7');
        expect(DeepLinkMapper.isAppRoute(concrete), isTrue, reason: route);
      }
    });
  });
}
