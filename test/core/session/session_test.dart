import 'package:assistje/core/auth/auth_controller.dart';
import 'package:assistje/core/session/models/me.dart';
import 'package:assistje/core/session/models/team_membership.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:assistje/core/theme/team_color.dart';
import 'package:assistje/core/theme/theme_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/test_app.dart';

void main() {
  test('Me.fromJson leest het voorbeeld uit docs/api/v1/me.md', () {
    final me = Me.fromJson(
      ApiFixtures.meResponse()['data'] as Map<String, dynamic>,
    );

    expect(me.user.name, 'Sam de Vries');
    expect(me.user.profileMissing.avatar, isTrue);
    final membership = me.teams.single;
    expect(membership.team.slug, 'vogels-3');
    expect(membership.team.primaryColor, '#006837');
    expect(membership.team.logoUrl, endsWith('vogels.png'));
    expect(membership.role, TeamRole.player);
    expect(membership.can('fines'), isTrue);
    expect(membership.can('lineup'), isFalse);
    expect(membership.hasFeature('motm'), isTrue);
    expect(membership.hasFeature('onbekend'), isFalse);
    expect(membership.sport['label'], 'Voetbal');
    expect(membership.unreadNotificationsCount, 2);
  });

  test('onbekende rol valt terug op TeamRole.unknown', () {
    final json = ApiFixtures.vogelsMembership()..['role'] = 'coach';
    expect(TeamMembership.fromJson(json).role, TeamRole.unknown);
  });

  group('huidig team', () {
    late TestBackend backend;

    Future<ProviderContainer> start({Map<String, Object>? prefs}) async {
      backend = TestBackend(token: '12|abc', prefs: prefs);
      await backend.init();
      backend.http.on(
        'GET /me',
        200,
        ApiFixtures.meResponse(
          teams: [
            ApiFixtures.vogelsMembership(),
            ApiFixtures.zwaluwenMembership(),
          ],
        ),
      );
      final container = backend.container();
      addTearDown(container.dispose);
      container
        ..listen(teamColorSyncProvider, (_, _) {})
        ..read(authControllerProvider);
      await Future<void>.delayed(Duration.zero);
      await container.read(meProvider.future);
      await Future<void>.delayed(Duration.zero);
      return container;
    }

    test('zonder bewaard team: het eerste, met zijn kleur', () async {
      final container = await start();

      expect(container.read(currentMembershipProvider)?.team.id, 3);
      expect(container.read(teamColorProvider), '#006837');
    });

    test('bewaard team wordt hersteld en zet de kleur', () async {
      final container = await start(
        prefs: {CurrentTeamIdNotifier.storageKey: 9},
      );

      final current = container.read(currentMembershipProvider)!;
      expect(current.team.name, 'Zwaluwen VR1');
      expect(current.isTrainer, isTrue);
      expect(current.can('lineup'), isTrue);
      expect(current.onboardingOpen, isTrue);
      expect(container.read(teamColorProvider), '#1D4ED8');
    });

    test('bewaard team waar je geen lid meer van bent → eerste', () async {
      final container = await start(
        prefs: {CurrentTeamIdNotifier.storageKey: 999},
      );
      expect(container.read(currentMembershipProvider)?.team.id, 3);
    });

    test('teamwissel zet de teamkleur en bewaart de keuze', () async {
      final container = await start();

      await container.read(currentTeamIdProvider.notifier).select(9);

      expect(container.read(currentMembershipProvider)?.team.id, 9);
      expect(container.read(teamColorProvider), '#1D4ED8');
      expect(backend.prefs.getInt(CurrentTeamIdNotifier.storageKey), 9);
      // Geen extra roundtrip: /me is één keer opgehaald.
      expect(backend.http.requestsTo('GET /me'), hasLength(1));
    });

    test('uitloggen zet de standaardkleur terug', () async {
      final container = await start(
        prefs: {CurrentTeamIdNotifier.storageKey: 9},
      );
      backend.http.on('POST /auth/logout', 204);

      await container.read(authControllerProvider.notifier).logout();
      await container.read(meProvider.future);
      await Future<void>.delayed(Duration.zero);

      expect(container.read(currentMembershipProvider), isNull);
      expect(container.read(teamColorProvider), TeamColor.fallbackHex);
    });
  });
}
