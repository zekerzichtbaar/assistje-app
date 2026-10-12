import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:assistje/features/profile/application/team_leave_controller.dart';
import 'package:assistje/features/profile/data/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/test_app.dart';

const _leave3 = 'DELETE /teams/3/membership';
const _leave9 = 'DELETE /teams/9/membership';

Map<String, dynamic> _twoTeams() => ApiFixtures.meResponse(
  teams: [
    ApiFixtures.membership(),
    ApiFixtures.membership(teamId: 9, name: 'Zwaluwen VR1'),
  ],
);

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<void> boot() async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http.on('GET /me', 200, _twoTeams());
    container = backend.container();
    addTearDown(container.dispose);
    container
      ..listen(meProvider, (_, _) {})
      ..listen(currentMembershipProvider, (_, _) {});
    await container.read(meProvider.future);
  }

  group('ProfileRepository.leaveTeam', () {
    test('204: DELETE teams/{team}/membership zonder body', () async {
      await boot();
      backend.http.on(_leave3, 204);
      final repository = ProfileRepository(container.read(apiClientProvider));
      await repository.leaveTeam(3);
      final request = backend.http.requestsTo(_leave3).single;
      expect(request.body, isNull);
      expect(request.authorization, 'Bearer 12|abc');
    });

    test('422 als het je enige team is', () async {
      await boot();
      backend.http.on(_leave3, 422, {'message': 'Dit is je enige team.'});
      final repository = ProfileRepository(container.read(apiClientProvider));
      await expectLater(
        repository.leaveTeam(3),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.message,
            'message',
            'Dit is je enige team.',
          ),
        ),
      );
    });
  });

  group('TeamLeaveController', () {
    test(
      'het actieve team verlaten kiest een ander team en ververst /me',
      () async {
        await boot();
        await container.read(currentTeamIdProvider.notifier).select(3);
        backend.http.on(_leave3, 204);
        final loads = backend.http.requestsTo('GET /me').length;
        // Na het verlaten staat alleen team 9 nog in /me.
        backend.http.on(
          'GET /me',
          200,
          ApiFixtures.meResponse(
            teams: [ApiFixtures.membership(teamId: 9, name: 'Zwaluwen VR1')],
          ),
        );

        final error = await container
            .read(teamLeaveControllerProvider)
            .leave(3);

        expect(error, isNull);
        expect(container.read(currentTeamIdProvider), 9);
        final me = await container.read(meProvider.future);
        expect(backend.http.requestsTo('GET /me').length, loads + 1);
        expect(me?.teams.map((m) => m.team.id), [9]);
        expect(container.read(currentMembershipProvider)?.team.id, 9);
      },
    );

    test('een ander team verlaten laat het actieve team staan', () async {
      await boot();
      await container.read(currentTeamIdProvider.notifier).select(3);
      backend.http.on(_leave9, 204);

      final error = await container.read(teamLeaveControllerProvider).leave(9);

      expect(error, isNull);
      expect(container.read(currentTeamIdProvider), 3);
    });

    test('422 geeft de fout terug en wisselt niets', () async {
      await boot();
      await container.read(currentTeamIdProvider.notifier).select(3);
      backend.http.on(_leave3, 422, {'message': 'Dit is je enige team.'});
      final loads = backend.http.requestsTo('GET /me').length;

      final error = await container.read(teamLeaveControllerProvider).leave(3);

      expect(error, isA<ValidationException>());
      expect(container.read(currentTeamIdProvider), 3);
      expect(backend.http.requestsTo('GET /me').length, loads);
    });
  });
}
