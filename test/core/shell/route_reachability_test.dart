import 'dart:async';

import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:assistje/core/shell/nav_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../features/event/event_fixtures.dart';
import '../../features/profile/profile_fixtures.dart';
import '../../helpers/api_fixtures.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';

/// Bereikbaarheid van elk ingelogd scherm vanuit de navigatie, per rol en
/// feature flag (DoD: "elk scherm bereikbaar vanuit de navigatie volgens rol
/// + feature flags").
///
/// Opbouw:
/// 1. de routematrix: elk pad onder de ingelogde shell heeft een ingang
///    (en een nieuwe route zonder rij in de matrix laat deze test falen);
/// 2. menu en tabbalk per rol × flags, tabel-gedreven, met doorklikken;
/// 3. de tweede laag: Mij-tab (pushvoorkeuren, vakanties, vaste dagen),
///    agenda ("+ Nieuw", event openen) en de knoppen op het event-detail.

// ── Rollen ─────────────────────────────────────────────────────────────────

enum _Role {
  trainer,
  speler,

  /// Een speler met de `fines`-ability.
  penningmeester,
  toeschouwer,
}

const _allRoles = {
  _Role.trainer,
  _Role.speler,
  _Role.penningmeester,
  _Role.toeschouwer,
};

/// Alle features die menu, profiel en event kennen.
const _allFeatures = <String, bool>{
  'stats': true,
  'fines': true,
  'savings': true,
  'wheel': true,
  'messages': true,
  'agreements': true,
  'vacations': true,
  'standing_absences': true,
  'injuries': true,
};

/// De menu-flags (feature-key → aan/uit) die in de menutabel voorkomen.
const _menuFlags = [
  'stats',
  'fines',
  'savings',
  'wheel',
  'messages',
  'agreements',
];

Map<String, dynamic> _member(
  _Role role, {
  Map<String, bool> features = const {},
  bool hasPoule = false,
  bool onboardingOpen = false,
  List<String>? abilities,
}) => ApiFixtures.membership(
  role: switch (role) {
    _Role.trainer => 'trainer',
    _Role.toeschouwer => 'spectator',
    _Role.speler || _Role.penningmeester => 'player',
  },
  abilities:
      abilities ??
      switch (role) {
        _Role.trainer => const ['lineup', 'training_points', 'fines'],
        _Role.penningmeester => const ['fines'],
        _Role.speler || _Role.toeschouwer => const [],
      },
  features: features,
  hasPoule: hasPoule,
  onboardingOpen: onboardingOpen,
);

// ── 1. Routematrix ─────────────────────────────────────────────────────────

/// Elk ingelogd pad → waar je het vandaan opent (rol/flag) → welke test hier
/// (of elders) dat bewijst.
const _routeMatrix = <String, String>{
  AppRoutes.agenda: 'tab + menu, iedereen (menu/tab-tests hieronder)',
  AppRoutes.stats: 'tab (altijd) + menu [stats], iedereen',
  AppRoutes.hallOfFame: 'tab (altijd) + menu [stats], iedereen',
  AppRoutes.poule: 'tab + menu, alleen met poulekoppeling',
  AppRoutes.profile: 'tab + menu-onderkant (Profiel), iedereen',
  AppRoutes.notificationPreferences: 'Mij-tab → kaart pushvoorkeuren',
  AppRoutes.notifications: 'bel in de shell, iedereen',
  AppRoutes.onboarding: 'menu, trainer zolang de checklist openstaat',
  AppRoutes.team: 'menu, speler/toeschouwer (niet penningmeester/trainer)',
  AppRoutes.players: 'menu, trainer',
  // Spelerpagina: vanuit Team (roster), Spelers (beheer), Statistieken en
  // Ranking — bewezen in test/features/team/team_screen_test.dart,
  // test/features/player_management/players_screen_test.dart ('beheer
  // opent de spelerpagina') en test/features/stats/stats_screen_test.dart.
  AppRoutes.playerDetail: 'Team/Spelers/Statistieken/Ranking → speler',
  AppRoutes.duties: 'menu, trainer',
  AppRoutes.fines: 'menu [fines], niet voor toeschouwers',
  AppRoutes.savings: 'menu [savings], niet voor toeschouwers',
  AppRoutes.wheel: 'menu [wheel], iedereen',
  AppRoutes.messages: 'menu [messages], trainer',
  AppRoutes.agreements: 'menu [agreements], iedereen (ook vanuit Team)',
  AppRoutes.settings: 'menu, trainer',
  AppRoutes.feedback: 'menu, iedereen',
  AppRoutes.schedule: 'agenda "+ Nieuw" en event "Bewerken", trainer',
  // Seizoenen: Instellingen → tab Seizoen → "naar seizoenen" — bewezen in
  // test/features/settings/settings_screen_test.dart ('seizoen: alleen-lezen
  // en door naar /seasons'); Instellingen zelf is trainer-only (hieronder).
  AppRoutes.seasons: 'menu Instellingen → Seizoen, trainer',
  AppRoutes.vacations: 'Mij-tab → kaart vakanties [vacations]',
  AppRoutes.standingAbsences: 'Mij-tab → kaart vaste dagen [standing_absences]',
  // Teamlink: Spelers → kaart teamlink — bewezen in
  // test/features/player_management/players_screen_test.dart ('de
  // teamlink-kaart opent /teamlink'); Spelers is trainer-only (hieronder).
  AppRoutes.teamlink: 'menu Spelers → kaart teamlink, trainer',
  AppRoutes.eventDetail: 'agenda → event, iedereen',
  AppRoutes.eventAttendance: 'event → Aanwezigheid, trainer',
  AppRoutes.eventLineup: 'event → Opstelling, trainer/lineup of gedeeld',
  AppRoutes.eventLive: 'event → Live, wedstrijd live of afgelopen',
  AppRoutes.eventReport: 'event → Verslag, lineup + postmatch-sport',
  AppRoutes.eventTrainingTeams: 'event → Teams, training met can_assign',
};

/// Alle volledige paden onder de ingelogde [ShellRoute] (de deur-routes op
/// de root-navigator tellen niet mee).
Set<String> _signedInPaths(GoRouter router) {
  final paths = <String>{};
  void walk(List<RouteBase> routes, String parent) {
    for (final route in routes) {
      var base = parent;
      if (route is GoRoute) {
        base = route.path.startsWith('/')
            ? route.path
            : '${parent == '/' ? '' : parent}/${route.path}';
        paths.add(base);
      }
      walk(route.routes, base);
    }
  }

  for (final shell in router.configuration.routes.whereType<ShellRoute>()) {
    walk(shell.routes, '');
  }
  return paths;
}

// ── 2. Menu- en tabtabel ───────────────────────────────────────────────────

class _MenuRow {
  const _MenuRow(
    this.item,
    this.roles, {
    this.flag,
    this.poule = false,
    this.onboarding = false,
  });

  final NavItem item;
  final Set<_Role> roles;

  /// De feature flag die het item verbergt als hij uit staat.
  final String? flag;

  /// Alleen met een poulekoppeling (`has_poule`).
  final bool poule;

  /// Alleen zolang de checklist openstaat (`onboarding_open`).
  final bool onboarding;

  bool visibleFor(_Role role, _Scenario s) =>
      roles.contains(role) &&
      (flag == null || (s.features[flag] ?? false)) &&
      (!poule || s.hasPoule) &&
      (!onboarding || s.onboardingOpen);
}

/// Het menu in volgorde, met wie het ziet (`navItems.ts`).
const _menuTable = <_MenuRow>[
  // "Aan de slag": alleen de trainer, en alleen zolang de checklist open is.
  _MenuRow(NavItem.onboarding, {_Role.trainer}, onboarding: true),
  _MenuRow(NavItem.agenda, _allRoles),
  _MenuRow(NavItem.players, {_Role.trainer}),
  // Team: de trainer heeft Spelers; de penningmeester ziet (als in de PWA)
  // geen Team-item.
  _MenuRow(NavItem.team, {_Role.speler, _Role.toeschouwer}),
  _MenuRow(NavItem.duties, {_Role.trainer}),
  _MenuRow(NavItem.stats, _allRoles, flag: 'stats'),
  // Ranking hangt aan dezelfde `stats`-flag als Statistieken.
  _MenuRow(NavItem.hallOfFame, _allRoles, flag: 'stats'),
  _MenuRow(NavItem.poule, _allRoles, poule: true),
  // Boetepot en spaarpot: niet voor toeschouwers (`not_spectator`).
  _MenuRow(NavItem.fines, {
    _Role.trainer,
    _Role.speler,
    _Role.penningmeester,
  }, flag: 'fines'),
  _MenuRow(NavItem.savings, {
    _Role.trainer,
    _Role.speler,
    _Role.penningmeester,
  }, flag: 'savings'),
  _MenuRow(NavItem.wheel, _allRoles, flag: 'wheel'),
  // Berichten versturen is trainerwerk; spelers zien ze als melding.
  _MenuRow(NavItem.messages, {_Role.trainer}, flag: 'messages'),
  _MenuRow(NavItem.agreements, _allRoles, flag: 'agreements'),
  _MenuRow(NavItem.settings, {_Role.trainer}),
  _MenuRow(NavItem.feedback, _allRoles),
];

class _Scenario {
  const _Scenario(
    this.name, {
    required this.features,
    this.hasPoule = false,
    this.onboardingOpen = false,
  });

  final String name;
  final Map<String, bool> features;
  final bool hasPoule;
  final bool onboardingOpen;
}

const _scenarios = [
  _Scenario(
    'alles aan',
    features: _allFeatures,
    hasPoule: true,
    onboardingOpen: true,
  ),
  _Scenario('alles uit', features: {}),
];

List<String> _expectedMenu(_Role role, _Scenario s) => [
  for (final row in _menuTable)
    if (row.visibleFor(role, s)) 'menu-${row.item.name}',
];

/// De tabbalk is voor elke rol gelijk; alleen Poule hangt aan de koppeling,
/// en stats/ranking staan er altijd (als `BottomNav.tsx`).
List<String> _expectedTabs(_Scenario s) => [
  'tab-agenda',
  'tab-stats',
  'tab-hallOfFame',
  if (s.hasPoule) 'tab-poule',
  'tab-profile',
];

// ── Kleine helpers ─────────────────────────────────────────────────────────

String _path(ProviderContainer c) => c.read(routerProvider).state.uri.path;

/// Sleutels (`ValueKey<String>`) die met [prefix] beginnen.
List<String> _keys(String prefix) => [
  for (final element in find.byWidgetPredicate((w) {
    final key = w.key;
    return key is ValueKey<String> && key.value.startsWith(prefix);
  }).evaluate())
    (element.widget.key! as ValueKey<String>).value,
];

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  group('routematrix', () {
    testWidgets('elk ingelogd pad heeft een ingang in de matrix', (
      tester,
    ) async {
      final (container, _) = await pumpSignedIn(
        tester,
        teams: [_member(_Role.speler)],
      );
      expect(
        _signedInPaths(container.read(routerProvider)),
        unorderedEquals(_routeMatrix.keys),
        reason:
            'Een nieuw ingelogd scherm hoort een ingang in de navigatie te '
            'hebben: voeg het toe aan _routeMatrix en bewijs de ingang.',
      );
    });

    test('de menutabel dekt elk NavItem (Profiel zit onderin het menu)', () {
      expect({
        for (final row in _menuTable) row.item,
      }, NavItem.values.toSet()..remove(NavItem.profile));
    });
  });

  group('menu en tabbalk per rol', () {
    for (final scenario in _scenarios) {
      for (final role in _Role.values) {
        testWidgets('${role.name}, ${scenario.name}: menu en tabs', (
          tester,
        ) async {
          final (container, _) = await pumpSignedIn(
            tester,
            teams: [
              _member(
                role,
                features: scenario.features,
                hasPoule: scenario.hasPoule,
                onboardingOpen: scenario.onboardingOpen,
              ),
            ],
          );
          expect(visibleTabs(tester), _expectedTabs(scenario));
          await openMenu(tester);
          final menu = visibleMenuItems(tester);
          expect(menu, _expectedMenu(role, scenario));

          // Wat het menu toont, laat de route-guard ook door.
          final m = container.read(currentMembershipProvider)!;
          for (final row in _menuTable) {
            if (menu.contains('menu-${row.item.name}')) {
              expect(canVisit(m, row.item.path), isTrue, reason: row.item.name);
            }
          }
        });
      }
    }

    // Eén flag tegelijk uit: alleen het bijbehorende item verdwijnt, en de
    // guard sluit het pad af (behalve stats/ranking: die blijven als tab).
    for (final role in [_Role.trainer, _Role.speler]) {
      for (final flag in _menuFlags) {
        testWidgets('${role.name}: flag "$flag" uit verbergt alleen dat item', (
          tester,
        ) async {
          final scenario = _Scenario(
            '$flag uit',
            features: {..._allFeatures, flag: false},
          );
          final (container, _) = await pumpSignedIn(
            tester,
            teams: [_member(role, features: scenario.features)],
          );
          await openMenu(tester);
          expect(visibleMenuItems(tester), _expectedMenu(role, scenario));

          final m = container.read(currentMembershipProvider)!;
          for (final row in _menuTable.where((r) => r.flag == flag)) {
            expect(find.byKey(ValueKey('menu-${row.item.name}')), findsNothing);
            final viaTab = AppRoutes.tabRoots.contains(row.item.path);
            expect(
              canVisit(m, row.item.path),
              viaTab,
              reason: '${row.item.path} met $flag uit',
            );
          }
        });
      }
    }

    testWidgets('trainer: "Aan de slag" verdwijnt als de checklist dicht is', (
      tester,
    ) async {
      await pumpSignedIn(
        tester,
        teams: [_member(_Role.trainer, features: _allFeatures)],
      );
      await openMenu(tester);
      expect(find.byKey(const ValueKey('menu-onboarding')), findsNothing);
      expect(find.byKey(const ValueKey('menu-settings')), findsOneWidget);
    });
  });

  group('doorklikken vanuit menu, tabs, bel en Profiel', () {
    for (final role in _Role.values) {
      testWidgets('${role.name}: elk zichtbaar item opent zijn scherm', (
        tester,
      ) async {
        const scenario = _Scenario(
          'alles aan',
          features: _allFeatures,
          hasPoule: true,
          onboardingOpen: true,
        );
        final (container, _) = await pumpSignedIn(
          tester,
          teams: [
            _member(
              role,
              features: _allFeatures,
              hasPoule: true,
              onboardingOpen: true,
            ),
          ],
        );

        // Tabs.
        for (final tab in _expectedTabs(scenario)) {
          final item = NavItem.values.byName(tab.substring('tab-'.length));
          await tester.tap(find.byKey(ValueKey(tab)));
          await tester.pumpAndSettle();
          expect(_path(container), item.path, reason: tab);
        }

        // Menu-items (vanaf een tab én vanaf een gepusht scherm).
        for (final key in _expectedMenu(role, scenario)) {
          final item = NavItem.values.byName(key.substring('menu-'.length));
          await openMenu(tester);
          await tester.tap(find.byKey(ValueKey(key)));
          await tester.pumpAndSettle();
          expect(_path(container), item.path, reason: key);
        }

        // Profiel onderin het menu.
        await openMenu(tester);
        await tester.tap(find.byKey(const ValueKey('menu-profile')));
        await tester.pumpAndSettle();
        expect(_path(container), AppRoutes.profile);

        // De bel.
        await tester.tap(find.byKey(const Key('shell-bell')));
        await tester.pumpAndSettle();
        expect(_path(container), AppRoutes.notifications);
      });
    }
  });

  group('Mij-tab: pushvoorkeuren, vakanties, vaste dagen', () {
    Future<ProviderContainer> openProfile(
      WidgetTester tester,
      _Role role, {
      required Map<String, bool> features,
      bool withPlayer = true,
      bool canUseVacations = true,
    }) async {
      final (container, _) = await pumpSignedIn(
        tester,
        teams: [_member(role, features: features)],
        setup: (http) => http.on(
          'GET /teams/3/profile',
          200,
          ProfileFixtures.profile(
            withPlayer: withPlayer,
            canUseVacations: canUseVacations,
          ),
        ),
      );
      await tester.tap(find.byKey(const ValueKey('tab-profile')));
      await pumpUntilFound(
        tester,
        find.byKey(const ValueKey('profile-notifications')),
      );
      return container;
    }

    for (final role in _Role.values) {
      testWidgets('${role.name}: pushvoorkeuren openen vanaf de Mij-tab', (
        tester,
      ) async {
        final container = await openProfile(
          tester,
          role,
          features: _allFeatures,
          withPlayer: role != _Role.toeschouwer,
          canUseVacations: role != _Role.toeschouwer,
        );
        await _tap(tester, find.byKey(const ValueKey('profile-notifications')));
        expect(_path(container), AppRoutes.notificationPreferences);
      });
    }

    for (final role in [_Role.speler, _Role.trainer, _Role.penningmeester]) {
      testWidgets(
        '${role.name}: vakanties en vaste dagen met de flags aan, en open',
        (tester) async {
          final container = await openProfile(
            tester,
            role,
            features: _allFeatures,
          );
          await _tap(tester, find.byKey(const ValueKey('profile-vacations')));
          expect(_path(container), AppRoutes.vacations);

          await tester.tap(find.byKey(const Key('shell-back')));
          await tester.pumpAndSettle();
          expect(_path(container), AppRoutes.profile);
          await _tap(tester, find.byKey(const ValueKey('profile-standing')));
          expect(_path(container), AppRoutes.standingAbsences);
        },
      );
    }

    testWidgets('speler: vacations/standing_absences uit verbergt de kaarten', (
      tester,
    ) async {
      await openProfile(
        tester,
        _Role.speler,
        features: {
          ..._allFeatures,
          'vacations': false,
          'standing_absences': false,
        },
      );
      expect(find.byKey(const ValueKey('profile-vacations')), findsNothing);
      expect(find.byKey(const ValueKey('profile-standing')), findsNothing);
      expect(find.byKey(const ValueKey('profile-notifications')), findsOne);
    });

    testWidgets('toeschouwer zonder spelersprofiel: geen vakanties/vaste '
        'dagen', (tester) async {
      await openProfile(
        tester,
        _Role.toeschouwer,
        features: _allFeatures,
        withPlayer: false,
        canUseVacations: false,
      );
      expect(find.byKey(const ValueKey('profile-vacations')), findsNothing);
      expect(find.byKey(const ValueKey('profile-standing')), findsNothing);
    });
  });

  group('agenda: event openen en "+ Nieuw"', () {
    for (final role in _Role.values) {
      testWidgets('${role.name}: event openen; "+ Nieuw" alleen voor trainer', (
        tester,
      ) async {
        final (container, _) = await pumpSignedIn(
          tester,
          teams: [_member(role)],
          agenda: ApiFixtures.agendaResponse(
            upcomingDuties: const [],
            birthdays: const [],
          ),
          setup: (http) => http.on(
            'GET /teams/3/events/412',
            200,
            EventFixtures.eventDetail({
              'starts_at': '2099-10-11T14:30:00+02:00',
            }),
          ),
        );
        await pumpUntilFound(tester, find.byKey(const ValueKey('event-412')));

        final newEvent = find.byKey(const ValueKey('agenda-new-event'));
        if (role == _Role.trainer) {
          await _tap(tester, newEvent);
          expect(_path(container), AppRoutes.schedule);
          await tester.tap(find.byKey(const Key('shell-back')));
          await tester.pumpAndSettle();
        } else {
          expect(newEvent, findsNothing);
        }

        await _tap(tester, find.byKey(const ValueKey('event-412')));
        expect(_path(container), AppRoutes.event(412));
      });
    }

    testWidgets('demo-trainer: geen "+ Nieuw"', (tester) async {
      final demo = _member(_Role.trainer);
      (demo['team'] as Map<String, dynamic>)['is_demo'] = true;
      await pumpSignedIn(tester, teams: [demo]);
      expect(find.byKey(const ValueKey('agenda-new-event')), findsNothing);
    });
  });

  group('event-detail: knoppen naar de sub-schermen', () {
    const future = '2099-10-11T14:30:00+02:00';
    const past = '2020-10-11T14:30:00+02:00';

    Map<String, dynamic> live({bool isLive = false, String? endedAt}) => {
      'is_live': isLive,
      'running': isLive,
      'started_at': isLive || endedAt != null ? past : null,
      'accumulated_seconds': 0,
      'ended_at': endedAt,
      'period': 1,
      'period_ends': [45, 90],
    };

    /// Zet `match_stats_mode: postmatch` op de sport van [membership]: dan
    /// hoort er een verslag bij de wedstrijd.
    Map<String, dynamic> postmatch(Map<String, dynamic> membership) => {
      ...membership,
      'sport': {
        ...(membership['sport'] as Map<String, dynamic>),
        'match_stats_mode': 'postmatch',
      },
    };

    final cases = <_EventCase>[
      _EventCase(
        'wedstrijd, trainer: opstelling en aanwezigheid',
        _member(_Role.trainer),
        {'starts_at': future, 'is_trainer': true},
        expected: ['lineup', 'attendance'],
        tap: 'lineup',
        trainerActions: true,
      ),
      _EventCase(
        'wedstrijd, speler zonder gedeelde opstelling: geen knoppen',
        _member(_Role.speler),
        {'starts_at': future},
        expected: [],
      ),
      _EventCase(
        'wedstrijd, speler met gedeelde opstelling: alleen bekijken',
        _member(_Role.speler),
        {'starts_at': future, 'lineup_shared': true},
        expected: ['lineup'],
        tap: 'lineup',
      ),
      // Afgelopen wedstrijd in een postmatch-sport: live-terugblik,
      // opstelling, verslag en aanwezigheid.
      _EventCase(
        'afgelopen wedstrijd (postmatch), trainer: live en verslag erbij',
        postmatch(_member(_Role.trainer)),
        {
          'starts_at': past,
          'is_trainer': true,
          'live': live(endedAt: '2020-10-11T16:15:00+02:00'),
        },
        expected: ['live', 'lineup', 'report', 'attendance'],
        tap: 'report',
        trainerActions: true,
      ),
      // De `lineup`-ability (bv. aanvoerder) geeft opstelling + verslag.
      _EventCase(
        'wedstrijd (postmatch), speler met lineup-ability: verslag',
        postmatch(_member(_Role.speler, abilities: ['lineup'])),
        {'starts_at': past},
        expected: ['lineup', 'report'],
        tap: 'report',
      ),
      _EventCase(
        'wedstrijd (postmatch), penningmeester zonder lineup: geen verslag',
        postmatch(_member(_Role.penningmeester)),
        {'starts_at': past},
        expected: [],
      ),
      _EventCase(
        'live wedstrijd, toeschouwer: alleen Live',
        _member(_Role.toeschouwer),
        {
          'starts_at': past,
          'live': live(isLive: true),
          'my_status': null,
          'my_reason': null,
          'can_rsvp': false,
          'can_change': false,
        },
        expected: ['live'],
        tap: 'live',
      ),
      _EventCase(
        'training, trainer met teams indelen: aanwezigheid en teams',
        _member(_Role.trainer),
        {
          'type': 'training',
          'starts_at': future,
          'is_trainer': true,
          'can_assign_teams': true,
        },
        expected: ['attendance', 'teams'],
        tap: 'teams',
        trainerActions: true,
      ),
      // `training_points` (zonder trainer te zijn) mag teams indelen.
      _EventCase(
        'training, speler met training_points: teams',
        _member(_Role.speler, abilities: ['training_points']),
        {'type': 'training', 'starts_at': future, 'can_assign_teams': true},
        expected: ['teams'],
        tap: 'teams',
      ),
      _EventCase('training, speler: geen knoppen', _member(_Role.speler), {
        'type': 'training',
        'starts_at': future,
      }, expected: []),
      _EventCase(
        'activiteit, trainer: aanwezigheid',
        _member(_Role.trainer),
        {'type': 'activity', 'starts_at': future, 'is_trainer': true},
        expected: ['attendance'],
        tap: 'attendance',
        trainerActions: true,
      ),
      _EventCase(
        'afgelaste activiteit, trainer: geen aanwezigheid',
        _member(_Role.trainer),
        {
          'type': 'activity',
          'starts_at': future,
          'is_trainer': true,
          'cancelled_at': '2099-10-01T10:00:00+02:00',
        },
        expected: [],
        trainerActions: true,
      ),
      _EventCase(
        'activiteit, penningmeester: geen knoppen',
        _member(_Role.penningmeester),
        {'type': 'activity', 'starts_at': future},
        expected: [],
      ),
    ];

    for (final c in cases) {
      testWidgets(c.name, (tester) async {
        final (container, _) = await pumpSignedIn(
          tester,
          teams: [c.membership],
          setup: (http) => http.on(
            'GET /teams/3/events/412',
            200,
            EventFixtures.eventDetail(c.detail),
          ),
        );
        unawaited(container.read(routerProvider).push(AppRoutes.event(412)));
        await pumpUntilFound(
          tester,
          find.byKey(const ValueKey('event-detail-screen')),
        );

        expect(_keys('event-action-'), [
          for (final id in c.expected) 'event-action-$id',
        ]);

        // Bewerken (→ /schedule) staat er alleen voor de trainer.
        final edit = find.byKey(const ValueKey('event-trainer-edit'));
        expect(edit, c.trainerActions ? findsOneWidget : findsNothing);

        final tapId = c.tap;
        if (tapId != null) {
          final m = container.read(currentMembershipProvider)!;
          final target = '${AppRoutes.event(412)}/$tapId';
          // De knop leidt nooit naar een pad dat de guard tegenhoudt.
          expect(canVisit(m, target), isTrue);
          await _tap(tester, find.byKey(ValueKey('event-action-$tapId')));
          expect(_path(container), target);
        } else if (c.trainerActions) {
          await _tap(tester, edit);
          expect(_path(container), AppRoutes.schedule);
        }
      });
    }
  });
}

class _EventCase {
  const _EventCase(
    this.name,
    this.membership,
    this.detail, {
    required this.expected,
    this.tap,
    this.trainerActions = false,
  });

  final String name;
  final Map<String, dynamic> membership;

  /// Afwijkingen op het docs-voorbeeld van het event-detail.
  final Map<String, dynamic> detail;

  /// De knoppen (`event-action-<id>`) in volgorde.
  final List<String> expected;

  /// De knop om door te klikken (het pad wordt `/events/412/<tap>`).
  final String? tap;

  /// Of de beheerknoppen (bewerken/afgelasten/verwijderen) er staan.
  final bool trainerActions;
}
