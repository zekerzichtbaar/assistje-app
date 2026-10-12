import 'package:assistje/core/session/models/team_membership.dart';
import 'package:assistje/core/shell/nav_items.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/shell.dart';

/// Alle features aan die het menu kent.
const _allFeatures = {
  'stats': true,
  'fines': true,
  'savings': true,
  'wheel': true,
  'messages': true,
  'agreements': true,
};

void main() {
  group('widget: zichtbare tabs en menu per rol', () {
    Future<(List<String>, List<String>)> compose(
      WidgetTester tester,
      Map<String, dynamic> membership,
    ) async {
      await pumpSignedIn(tester, teams: [membership]);
      final tabs = visibleTabs(tester);
      await openMenu(tester);
      return (tabs, visibleMenuItems(tester));
    }

    testWidgets('trainer met alles aan, poule en open checklist', (
      tester,
    ) async {
      final (tabs, menu) = await compose(
        tester,
        ApiFixtures.membership(
          role: 'trainer',
          abilities: ['lineup', 'training_points', 'fines'],
          features: _allFeatures,
          hasPoule: true,
          onboardingOpen: true,
        ),
      );
      expect(tabs, [
        'tab-agenda',
        'tab-stats',
        'tab-hallOfFame',
        'tab-poule',
        'tab-profile',
      ]);
      expect(menu, [
        'menu-onboarding',
        'menu-agenda',
        'menu-players',
        'menu-duties',
        'menu-stats',
        'menu-hallOfFame',
        'menu-poule',
        'menu-fines',
        'menu-savings',
        'menu-wheel',
        'menu-messages',
        'menu-agreements',
        'menu-settings',
        'menu-feedback',
      ]);
    });

    testWidgets('trainer met standaardflags (savings/agreements uit)', (
      tester,
    ) async {
      final (tabs, menu) = await compose(
        tester,
        ApiFixtures.membership(
          role: 'trainer',
          features: {
            'stats': true,
            'fines': true,
            'wheel': true,
            'messages': true,
          },
        ),
      );
      expect(tabs, [
        'tab-agenda',
        'tab-stats',
        'tab-hallOfFame',
        'tab-profile',
      ]);
      expect(menu, [
        'menu-agenda',
        'menu-players',
        'menu-duties',
        'menu-stats',
        'menu-hallOfFame',
        'menu-fines',
        'menu-wheel',
        'menu-messages',
        'menu-settings',
        'menu-feedback',
      ]);
    });

    testWidgets('speler: Team, geen beheer, geen Berichten', (tester) async {
      final (tabs, menu) = await compose(
        tester,
        ApiFixtures.membership(features: _allFeatures),
      );
      expect(tabs, [
        'tab-agenda',
        'tab-stats',
        'tab-hallOfFame',
        'tab-profile',
      ]);
      expect(menu, [
        'menu-agenda',
        'menu-team',
        'menu-stats',
        'menu-hallOfFame',
        'menu-fines',
        'menu-savings',
        'menu-wheel',
        'menu-agreements',
        'menu-feedback',
      ]);
    });

    testWidgets('speler met fines-ability (penningmeester): geen Team', (
      tester,
    ) async {
      final (_, menu) = await compose(
        tester,
        ApiFixtures.membership(
          abilities: ['fines'],
          features: {'stats': true, 'fines': true, 'wheel': true},
        ),
      );
      expect(menu, [
        'menu-agenda',
        'menu-stats',
        'menu-hallOfFame',
        'menu-fines',
        'menu-wheel',
        'menu-feedback',
      ]);
    });

    testWidgets('toeschouwer: geen boetepot/spaarpot', (tester) async {
      final (tabs, menu) = await compose(
        tester,
        ApiFixtures.membership(
          role: 'spectator',
          features: _allFeatures,
          hasPoule: true,
        ),
      );
      expect(tabs, [
        'tab-agenda',
        'tab-stats',
        'tab-hallOfFame',
        'tab-poule',
        'tab-profile',
      ]);
      expect(menu, [
        'menu-agenda',
        'menu-team',
        'menu-stats',
        'menu-hallOfFame',
        'menu-poule',
        'menu-wheel',
        'menu-agreements',
        'menu-feedback',
      ]);
    });

    testWidgets('flags: wheel uit, savings aan, stats uit, geen poule', (
      tester,
    ) async {
      final (tabs, menu) = await compose(
        tester,
        ApiFixtures.membership(
          features: {'wheel': false, 'savings': true, 'stats': false},
        ),
      );
      // De tabbalk filtert niet op stats (als BottomNav.tsx).
      expect(tabs, [
        'tab-agenda',
        'tab-stats',
        'tab-hallOfFame',
        'tab-profile',
      ]);
      expect(menu, [
        'menu-agenda',
        'menu-team',
        'menu-savings',
        'menu-feedback',
      ]);
    });
  });

  group('pure functies', () {
    TeamMembership m(Map<String, dynamic> json) =>
        TeamMembership.fromJson(json);

    test('onbekende rol valt terug op het spelersmenu', () {
      final unknown = m(ApiFixtures.membership(role: 'coach'));
      expect(unknown.role, TeamRole.unknown);
      expect(buildMenuItems(unknown), [
        NavItem.agenda,
        NavItem.team,
        NavItem.feedback,
      ]);
    });

    test('canVisit volgt de middleware van de PWA', () {
      final player = m(ApiFixtures.membership(features: {'fines': true}));
      final spectator = m(
        ApiFixtures.membership(role: 'spectator', features: _allFeatures),
      );
      final trainer = m(
        ApiFixtures.membership(role: 'trainer', features: {'messages': true}),
      );

      expect(canVisit(player, '/agenda'), isTrue);
      expect(canVisit(player, '/events/12'), isTrue);
      expect(canVisit(player, '/events/12/lineup'), isTrue);
      expect(canVisit(player, '/events/12/attendance'), isFalse);
      expect(canVisit(player, '/events/12/report'), isFalse);
      expect(canVisit(player, '/fines'), isTrue);
      expect(canVisit(player, '/wheel'), isFalse);
      expect(canVisit(player, '/poule'), isFalse);
      expect(canVisit(player, '/players'), isFalse);
      expect(canVisit(player, '/players/4'), isTrue);
      expect(canVisit(player, '/settings'), isFalse);
      expect(canVisit(player, '/messages'), isFalse);
      expect(canVisit(spectator, '/fines'), isFalse);
      expect(canVisit(spectator, '/savings'), isFalse);
      expect(canVisit(trainer, '/messages'), isTrue);
      expect(canVisit(trainer, '/players'), isTrue);
      expect(canVisit(trainer, '/events/1/report'), isTrue);
      expect(canVisit(trainer, '/fines'), isFalse);
      expect(navGuardRedirect(player, '/settings'), '/agenda');
      expect(navGuardRedirect(player, '/agenda'), isNull);
      expect(navGuardRedirect(null, '/settings'), isNull);
    });

    test('parentPath', () {
      final player = m(ApiFixtures.membership());
      final trainer = m(ApiFixtures.membership(role: 'trainer'));
      expect(parentPath(player, '/events/5/lineup'), '/events/5');
      expect(parentPath(player, '/events/5'), '/agenda');
      expect(parentPath(player, '/players/4'), '/team');
      expect(parentPath(trainer, '/players/4'), '/players');
      expect(parentPath(player, '/profile/notifications'), '/profile');
      expect(parentPath(player, '/fines'), '/agenda');
    });
  });
}
