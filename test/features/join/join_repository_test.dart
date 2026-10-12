import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/join/data/join_repository.dart';
import 'package:assistje/features/join/data/models/join_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';
import 'join_fixtures.dart';

void main() {
  late TestBackend backend;
  late JoinRepository repository;

  setUp(() async {
    backend = TestBackend();
    await backend.init();
    final container = ProviderContainer(overrides: backend.overrides);
    addTearDown(container.dispose);
    repository = container.read(joinRepositoryProvider);
  });

  final join = 'POST ${JoinFixtures.joinPath}';
  final show = 'GET ${JoinFixtures.joinPath}';
  final confirmShow = 'GET ${JoinFixtures.confirmPath}';
  final confirm = 'POST ${JoinFixtures.confirmPath}';
  final invite = 'GET ${JoinFixtures.invitePath}';
  final accept = 'POST ${JoinFixtures.invitePath}/accept';

  group('GET join/{token}', () {
    test('team, already_member en claimbare spelers', () async {
      backend.http.on(show, 200, JoinFixtures.link());

      final link = await repository.fetchLink(JoinFixtures.token);

      expect(link.team.id, 3);
      expect(link.team.name, 'Vogels 3');
      expect(link.alreadyMember, isFalse);
      expect(link.expiresAt, '2026-11-09T20:15:00+01:00');
      expect(link.players, const [
        JoinPlayer(id: 12, name: 'Jeroen Bakker', shirtNumber: 7),
        JoinPlayer(id: 14, name: 'Linda de Lange'),
      ]);
    });

    test('404 onbekend en 410 verlopen met de webzin', () async {
      backend.http.on(show, 404, JoinFixtures.expired());
      await expectLater(
        repository.fetchLink(JoinFixtures.token),
        throwsA(
          isA<NotFoundException>().having(
            (e) => e.message,
            'message',
            JoinFixtures.expiredMessage,
          ),
        ),
      );

      backend.http.on(show, 410, JoinFixtures.expired());
      await expectLater(
        repository.fetchLink(JoinFixtures.token),
        throwsA(
          isA<ApiException>()
              .having((e) => e.statusCode, 'status', 410)
              .having((e) => e.message, 'message', JoinFixtures.expiredMessage),
        ),
      );
    });
  });

  group('POST join/{token}', () {
    test(
      'claim: player_id + claim_confirmed + device_name → 200 token',
      () async {
        backend.http.on(join, 200, JoinFixtures.tokenResponse());

        final outcome = await repository.join(
          JoinFixtures.token,
          role: JoinRole.player,
          playerId: 12,
          email: ' jeroen@example.com ',
        );

        expect(outcome, isA<JoinSignedIn>());
        expect((outcome as JoinSignedIn).token, '41|Zk2pQ');
        expect(backend.http.requestsTo(join).single.body, {
          'role': 'player',
          'player_id': 12,
          'claim_confirmed': true,
          'name': null,
          'email': 'jeroen@example.com',
          'device_name': 'iPhone',
        });
        // Het repository bewaart zelf geen token.
        expect(backend.tokens.token, isNull);
      },
    );

    test('toeschouwer met naam, zonder adres', () async {
      backend.http.on(join, 200, JoinFixtures.tokenResponse());

      await repository.join(
        JoinFixtures.token,
        role: JoinRole.spectator,
        playerId: 12,
        name: '  Oma Bakker ',
        email: '',
      );

      expect(backend.http.requestsTo(join).single.body, {
        'role': 'spectator',
        'player_id': null,
        'claim_confirmed': false,
        'name': 'Oma Bakker',
        'email': null,
        'device_name': 'iPhone',
      });
    });

    test('202 bestaand adres → confirmation_sent', () async {
      backend.http.on(join, 202, JoinFixtures.confirmationSent());

      final outcome = await repository.join(
        JoinFixtures.token,
        role: JoinRole.player,
        name: 'Jeroen',
        email: 'jeroen@example.com',
      );

      expect(outcome, isA<JoinConfirmationSent>());
      expect((outcome as JoinConfirmationSent).email, 'jeroen@example.com');
    });

    test('409 al lid, 403 demo, 422 validatie, 410 verlopen', () async {
      Future<void> expectStatus(
        int status,
        Map<String, dynamic> body,
        Matcher matcher,
      ) async {
        backend.http.on(join, status, body);
        await expectLater(
          repository.join(JoinFixtures.token, role: JoinRole.player, name: 'X'),
          throwsA(matcher),
        );
      }

      await expectStatus(
        409,
        JoinFixtures.alreadyMember(),
        isA<ConflictException>(),
      );
      await expectStatus(
        403,
        JoinFixtures.demoRefusal(),
        isA<ForbiddenException>(),
      );
      await expectStatus(
        422,
        JoinFixtures.validation(
          'claim_confirmed',
          'Bevestig dat jij dit bent.',
        ),
        isA<ValidationException>().having(
          (e) => e.fieldError('claim_confirmed'),
          'claim_confirmed',
          'Bevestig dat jij dit bent.',
        ),
      );
      await expectStatus(
        410,
        JoinFixtures.expired(),
        isA<ApiException>().having((e) => e.statusCode, 'status', 410),
      );
    });
  });

  group('join/{token}/confirm/{login}', () {
    test('GET geeft de query uit de maillink door', () async {
      backend.http.on(confirmShow, 200, JoinFixtures.confirmation());

      final confirmation = await repository.fetchConfirmation(
        JoinFixtures.token,
        JoinFixtures.login,
        query: const {'role': 'player', 'player': '12'},
      );

      expect(confirmation.valid, isTrue);
      expect(confirmation.userName, 'Jeroen Bakker');
      expect(confirmation.playerId, 12);
      expect(confirmation.team.id, 3);
      final request = backend.http.requestsTo(confirmShow).single;
      expect(request.options.uri.queryParameters, {
        'role': 'player',
        'player': '12',
      });
    });

    test('GET valid:false', () async {
      backend.http.on(
        confirmShow,
        200,
        JoinFixtures.confirmation(valid: false),
      );
      final confirmation = await repository.fetchConfirmation(
        JoinFixtures.token,
        JoinFixtures.login,
      );
      expect(confirmation.valid, isFalse);
      expect(confirmation.userName, isNull);
    });

    test('POST → token; 422 errors.login; 403 demo', () async {
      backend.http.on(confirm, 200, JoinFixtures.tokenResponse(token: '42|x'));
      expect(
        await repository.confirm(
          JoinFixtures.token,
          JoinFixtures.login,
          role: 'player',
          playerId: 12,
          name: '',
        ),
        '42|x',
      );
      expect(backend.http.requestsTo(confirm).single.body, {
        'role': 'player',
        'player_id': 12,
        'name': null,
        'device_name': 'iPhone',
      });

      backend.http.on(
        confirm,
        422,
        JoinFixtures.validation(
          'login',
          'Deze link is ongeldig of verlopen. Tik opnieuw op de teamlink.',
        ),
      );
      await expectLater(
        repository.confirm(
          JoinFixtures.token,
          JoinFixtures.login,
          role: 'player',
        ),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.fieldError('login'),
            'login',
            startsWith('Deze link is ongeldig'),
          ),
        ),
      );

      backend.http.on(confirm, 403, JoinFixtures.demoRefusal());
      await expectLater(
        repository.confirm(
          JoinFixtures.token,
          JoinFixtures.login,
          role: 'player',
        ),
        throwsA(isA<ForbiddenException>()),
      );
    });
  });

  group('invites/{token}', () {
    test('GET naam, POST accept → token met device_name', () async {
      backend.http
        ..on(invite, 200, JoinFixtures.inviteInfo())
        ..on(accept, 200, JoinFixtures.tokenResponse(token: '43|inv'));

      final info = await repository.fetchInvite(JoinFixtures.invite);
      expect(info, const InviteInfo(name: 'Sam de Vries'));

      expect(await repository.acceptInvite(JoinFixtures.invite), '43|inv');
      expect(backend.http.requestsTo(accept).single.body, {
        'device_name': 'iPhone',
      });
    });

    test('404 al gebruikt, 410 verlopen', () async {
      backend.http.on(invite, 404, {
        'message': JoinFixtures.inviteExpiredMessage,
      });
      await expectLater(
        repository.fetchInvite(JoinFixtures.invite),
        throwsA(isA<NotFoundException>()),
      );
      backend.http.on(accept, 410, {
        'message': JoinFixtures.inviteExpiredMessage,
      });
      await expectLater(
        repository.acceptInvite(JoinFixtures.invite),
        throwsA(isA<ApiException>().having((e) => e.statusCode, 's', 410)),
      );
    });

    test('onverwacht antwoord → UnknownApiException', () async {
      backend.http.on(accept, 200, {'data': <String, dynamic>{}});
      await expectLater(
        repository.acceptInvite(JoinFixtures.invite),
        throwsA(isA<UnknownApiException>()),
      );
    });
  });
}
