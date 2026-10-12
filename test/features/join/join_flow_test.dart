import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/core/auth/auth_controller.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:assistje/features/join/application/join_controller.dart';
import 'package:assistje/features/join/data/models/join_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/test_app.dart';
import 'join_fixtures.dart';

void main() {
  late TestBackend backend;

  /// `/me` na het meedoen: Zwaluwen (9) en Vogels 3 (3), Zwaluwen eerst.
  void serveMe() => backend.http.on(
    'GET /me',
    200,
    ApiFixtures.meResponse(
      teams: [ApiFixtures.zwaluwenMembership(), ApiFixtures.vogelsMembership()],
    ),
  );

  Future<ProviderContainer> start({
    String? token,
    Map<String, Object>? prefs,
  }) async {
    backend = TestBackend(token: token, prefs: prefs);
    await backend.init();
    serveMe();
    final container = backend.container();
    addTearDown(container.dispose);
    container
      ..listen(meProvider, (_, _) {})
      ..read(authControllerProvider);
    await pumpEventQueue();
    return container;
  }

  final link = JoinLink.fromJson(
    JoinFixtures.link()['data'] as Map<String, dynamic>,
  );

  test(
    'meedoen (200): token bewaard, ingelogd, team van de link gekozen',
    () async {
      final container = await start(prefs: {'current_team_id': 9});
      backend.http.on(
        'POST ${JoinFixtures.joinPath}',
        200,
        JoinFixtures.tokenResponse(),
      );

      final outcome = await container
          .read(joinFlowProvider)
          .join(JoinFixtures.token, link, role: JoinRole.player, playerId: 12);

      expect(outcome, isA<JoinSignedIn>());
      expect(container.read(authControllerProvider), AuthStatus.signedIn);
      expect(backend.tokens.token, '41|Zk2pQ');
      expect(container.read(currentTeamIdProvider), 3);
      expect(container.read(currentMembershipProvider)?.team.id, 3);
      expect(
        backend.http.requestsTo('GET /me').last.authorization,
        'Bearer 41|Zk2pQ',
      );
    },
  );

  test('meedoen (202): niets ingelogd, geen token', () async {
    final container = await start();
    backend.http.on(
      'POST ${JoinFixtures.joinPath}',
      202,
      JoinFixtures.confirmationSent(),
    );

    final outcome = await container
        .read(joinFlowProvider)
        .join(
          JoinFixtures.token,
          link,
          role: JoinRole.player,
          name: 'Jeroen',
          email: 'jeroen@example.com',
        );

    expect(outcome, isA<JoinConfirmationSent>());
    expect(container.read(authControllerProvider), AuthStatus.signedOut);
    expect(backend.tokens.token, isNull);
  });

  test(
    'meedoen (409 al lid): fout door, enterTeam wisselt naar het team',
    () async {
      final container = await start(
        token: '12|abc',
        prefs: {'current_team_id': 9},
      );
      backend.http.on(
        'POST ${JoinFixtures.joinPath}',
        409,
        JoinFixtures.alreadyMember(),
      );
      final flow = container.read(joinFlowProvider);

      await expectLater(
        flow.join(
          JoinFixtures.token,
          link,
          role: JoinRole.spectator,
          name: 'X',
        ),
        throwsA(isA<ConflictException>()),
      );
      expect(backend.tokens.token, '12|abc');

      await flow.enterTeam(3);
      expect(container.read(currentTeamIdProvider), 3);
    },
  );

  test('enterTeam voor een team zonder lidmaatschap wisselt niet', () async {
    final container = await start(
      token: '12|abc',
      prefs: {'current_team_id': 9},
    );

    await container.read(joinFlowProvider).enterTeam(77);

    expect(container.read(currentTeamIdProvider), 9);
  });

  test('bevestigen: keuze uit de maillink, ingelogd in dat team', () async {
    final container = await start(prefs: {'current_team_id': 9});
    backend.http.on(
      'POST ${JoinFixtures.confirmPath}',
      200,
      JoinFixtures.tokenResponse(token: '42|conf'),
    );
    final confirmation = JoinConfirmation.fromJson(
      JoinFixtures.confirmation(role: 'spectator', playerId: null)['data']
          as Map<String, dynamic>,
    );

    await container
        .read(joinFlowProvider)
        .confirm(JoinFixtures.token, JoinFixtures.login, confirmation);

    expect(
      backend.http.requestsTo('POST ${JoinFixtures.confirmPath}').single.body,
      {
        'role': 'spectator',
        'player_id': null,
        'name': null,
        'device_name': 'iPhone',
      },
    );
    expect(container.read(authControllerProvider), AuthStatus.signedIn);
    expect(backend.tokens.token, '42|conf');
    expect(container.read(currentTeamIdProvider), 3);
  });

  test('bevestigen terwijl ingelogd: nieuw token, /me opnieuw', () async {
    final container = await start(
      token: '12|oud',
      prefs: {'current_team_id': 9},
    );
    await container.read(meProvider.future);
    backend.http.on(
      'POST ${JoinFixtures.confirmPath}',
      200,
      JoinFixtures.tokenResponse(token: '42|conf'),
    );
    final confirmation = JoinConfirmation.fromJson(
      JoinFixtures.confirmation()['data'] as Map<String, dynamic>,
    );

    await container
        .read(joinFlowProvider)
        .confirm(JoinFixtures.token, JoinFixtures.login, confirmation);

    final meCalls = backend.http.requestsTo('GET /me');
    expect(meCalls.length, greaterThanOrEqualTo(2));
    expect(meCalls.last.authorization, 'Bearer 42|conf');
    expect(container.read(currentTeamIdProvider), 3);
  });

  test('uitnodiging accepteren: ingelogd, /me kiest het team', () async {
    final container = await start();
    backend.http.on(
      'POST ${JoinFixtures.invitePath}/accept',
      200,
      JoinFixtures.tokenResponse(token: '43|inv'),
    );

    await container.read(joinFlowProvider).acceptInvite(JoinFixtures.invite);

    expect(container.read(authControllerProvider), AuthStatus.signedIn);
    expect(backend.tokens.token, '43|inv');
    expect(container.read(meProvider).value?.teams, hasLength(2));
    expect(container.read(currentMembershipProvider)?.team.id, 9);
  });

  test('uitnodiging verlopen (410): blijft uitgelogd', () async {
    final container = await start();
    backend.http.on('POST ${JoinFixtures.invitePath}/accept', 410, {
      'message': JoinFixtures.inviteExpiredMessage,
    });

    await expectLater(
      container.read(joinFlowProvider).acceptInvite(JoinFixtures.invite),
      throwsA(isA<ApiException>().having((e) => e.statusCode, 's', 410)),
    );
    expect(container.read(authControllerProvider), AuthStatus.signedOut);
    expect(backend.tokens.token, isNull);
  });

  test(
    'providers laden link, bevestiging (met query) en uitnodiging',
    () async {
      final container = await start();
      backend.http
        ..on('GET ${JoinFixtures.joinPath}', 200, JoinFixtures.link())
        ..on(
          'GET ${JoinFixtures.confirmPath}',
          200,
          JoinFixtures.confirmation(),
        )
        ..on('GET ${JoinFixtures.invitePath}', 200, JoinFixtures.inviteInfo());

      final loaded = await container.read(
        joinLinkProvider(JoinFixtures.token).future,
      );
      expect(loaded.players, hasLength(2));

      final confirmation = await container.read(
        joinConfirmationProvider((
          token: JoinFixtures.token,
          login: JoinFixtures.login,
          query: 'role=player&player=12',
        )).future,
      );
      expect(confirmation.playerName, 'Jeroen Bakker');
      expect(
        backend.http
            .requestsTo('GET ${JoinFixtures.confirmPath}')
            .single
            .options
            .uri
            .queryParameters,
        {'role': 'player', 'player': '12'},
      );

      final info = await container.read(
        inviteInfoProvider(JoinFixtures.invite).future,
      );
      expect(info.name, 'Sam de Vries');
    },
  );
}
