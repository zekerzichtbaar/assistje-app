import 'dart:convert';
import 'dart:typed_data';

import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/player_management/data/models/player_management_models.dart';
import 'package:assistje/features/player_management/data/player_management_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'multipart_http_adapter.dart';
import 'pm_fixtures.dart';

void main() {
  late FakeHttpAdapter http;
  late PlayerManagementRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = PlayerManagementRepository(
      ApiClient(
        buildApiDio(
          baseUrl: 'https://assistje.test/api/v1',
          readToken: () async => '12|abc',
          onUnauthorized: () {},
          adapter: http,
        ),
      ),
    );
  });

  Object? body(String route) => http.requestsTo(route).single.body;

  group('spelers', () {
    test('GET players: het hele overzicht uit de docs', () async {
      http.on('GET /teams/3/players', 200, PmFixtures.overview());

      final data = await repository.fetch(3);

      final linda = data.players.first;
      expect(linda.id, 12);
      expect(linda.userId, 40);
      expect(linda.hasAccount, isTrue);
      expect(linda.isCaptain, isTrue);
      expect(linda.inviteStatus, InviteStatus.accepted);
      expect(linda.pushStatus, PushStatus.push);
      expect(linda.strength, 4);
      expect(linda.birthdate, '2001-02-03');
      expect(linda.abilities, ['lineup']);
      expect(linda.hasAbility(PlayerAbility.lineup), isTrue);
      final kees = data.players[1];
      expect(kees.hasAccount, isFalse);
      expect(kees.inviteStatus, InviteStatus.none);
      expect(kees.pushStatus, PushStatus.na);
      expect(data.players.last.isGuest, isTrue);
      expect(data.trainers.first.isSelf, isTrue);
      expect(data.spectators.single.inviteStatus, InviteStatus.pending);
      expect(data.teamLink?.url, contains('/meedoen/'));
      expect(data.teamLink?.expiresAt, DateTime.utc(2027, 1, 8, 9));
      expect(data.teamLinkState, TeamLinkState.active);
    });

    test('onbekende standen vallen terug op unknown', () async {
      http.on(
        'GET /teams/3/players',
        200,
        PmFixtures.overview(
          players: [
            {
              ...PmFixtures.linda(),
              'invite_status': 'blocked',
              'push_status': 'smoke',
            },
          ],
          linkActive: false,
          linkState: 'paused',
        ),
      );

      final data = await repository.fetch(3);

      expect(data.players.single.inviteStatus, InviteStatus.unknown);
      expect(data.players.single.pushStatus, PushStatus.unknown);
      expect(data.teamLink, isNull);
      expect(data.teamLinkState, TeamLinkState.unknown);
    });

    test('POST players stuurt de nieuwe speler (met uitnodiging)', () async {
      http.on(
        'POST /teams/3/players',
        201,
        PmFixtures.data({
          ...PmFixtures.kees(inviteStatus: 'pending'),
          'id': 14,
          'name': 'Nina Nieuw',
        }),
      );

      final player = await repository.createPlayer(
        3,
        const NewPlayer(
          name: 'Nina Nieuw',
          shirtNumber: 12,
          position: 'CM',
          sendInvite: true,
          email: 'nina@example.com',
        ),
      );

      expect(player.id, 14);
      expect(player.inviteStatus, InviteStatus.pending);
      expect(body('POST /teams/3/players'), {
        'name': 'Nina Nieuw',
        'shirt_number': 12,
        'position': 'CM',
        'is_guest': false,
        'send_invite': true,
        'email': 'nina@example.com',
      });
    });

    test('POST players zonder uitnodiging laat e-mail weg', () async {
      http.on('POST /teams/3/players', 201, PmFixtures.data(PmFixtures.kees()));

      await repository.createPlayer(
        3,
        const NewPlayer(name: 'Kees', isGuest: true, email: 'x@y.nl'),
      );

      expect(body('POST /teams/3/players'), {
        'name': 'Kees',
        'is_guest': true,
        'send_invite': false,
      });
    });

    test('PATCH players/{player}: lege velden worden null', () async {
      http.on(
        'PATCH /teams/3/players/12',
        200,
        PmFixtures.data({...PmFixtures.linda(), 'name': 'Linda Langer'}),
      );

      final player = await repository.updatePlayer(
        3,
        12,
        const PlayerUpdate(name: 'Linda Langer', email: '', strength: 4),
      );

      expect(player.name, 'Linda Langer');
      expect(body('PATCH /teams/3/players/12'), {
        'name': 'Linda Langer',
        'shirt_number': null,
        'position': null,
        'birthdate': null,
        'email': null,
        'strength': 4,
      });
    });

    test('DELETE players/{player} (204)', () async {
      http.on('DELETE /teams/3/players/12', 204);

      await repository.deletePlayer(3, 12);

      expect(http.requestsTo('DELETE /teams/3/players/12'), hasLength(1));
    });

    test('PATCH role / captain / abilities', () async {
      http
        ..on(
          'PATCH /teams/3/players/12/role',
          200,
          PmFixtures.data(PmFixtures.linda(isTrainer: true)),
        )
        ..on(
          'PATCH /teams/3/players/12/captain',
          200,
          PmFixtures.data(PmFixtures.linda(isCaptain: false)),
        )
        ..on(
          'PATCH /teams/3/players/12/abilities',
          200,
          PmFixtures.data(PmFixtures.linda(abilities: ['lineup', 'fines'])),
        );

      expect(
        (await repository.setTrainer(3, 12, isTrainer: true)).isTrainer,
        isTrue,
      );
      expect(body('PATCH /teams/3/players/12/role'), {'is_trainer': true});

      expect(
        (await repository.setCaptain(3, 12, captain: false)).isCaptain,
        isFalse,
      );
      expect(body('PATCH /teams/3/players/12/captain'), {'captain': false});

      final withFines = await repository.setAbility(
        3,
        12,
        ability: PlayerAbility.fines,
        granted: true,
      );
      expect(withFines.abilities, ['lineup', 'fines']);
      expect(body('PATCH /teams/3/players/12/abilities'), {
        'ability': 'fines',
        'granted': true,
      });
    });

    test('POST invite en invite/resend', () async {
      final pending = PmFixtures.kees(
        inviteStatus: 'pending',
        email: 'kees@example.com',
      );
      http
        ..on('POST /teams/3/players/13/invite', 200, PmFixtures.data(pending))
        ..on(
          'POST /teams/3/players/13/invite/resend',
          200,
          PmFixtures.data(pending),
        );

      final invited = await repository.invitePlayer(
        3,
        13,
        email: 'kees@example.com',
      );
      expect(invited.inviteStatus, InviteStatus.pending);
      expect(invited.email, 'kees@example.com');
      expect(body('POST /teams/3/players/13/invite'), {
        'email': 'kees@example.com',
      });

      await repository.resendPlayerInvite(3, 13);
      expect(body('POST /teams/3/players/13/invite/resend'), isNull);
    });

    test('422 met errors per veld of alleen message', () async {
      http
        ..on('POST /teams/3/players', 422, {
          'message': 'Vul een naam in.',
          'errors': {
            'name': ['Vul een naam in.'],
          },
        })
        ..on('POST /teams/3/players/12/invite', 422, {
          'message': 'Speler heeft al een account.',
        });

      await expectLater(
        repository.createPlayer(3, const NewPlayer(name: '')),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.fieldError('name'),
            'name',
            'Vul een naam in.',
          ),
        ),
      );
      await expectLater(
        repository.invitePlayer(3, 12, email: 'a@b.nl'),
        throwsA(
          isA<ValidationException>()
              .having(
                (e) => e.message,
                'message',
                'Speler heeft al een account.',
              )
              .having((e) => e.errors, 'errors', isEmpty),
        ),
      );
    });

    test('403 (demo/geen trainer) komt als ForbiddenException', () async {
      http.on('DELETE /teams/3/players/12', 403, {'message': 'Demo.'});

      await expectLater(
        repository.deletePlayer(3, 12),
        throwsA(isA<ForbiddenException>()),
      );
    });

    test('een antwoord zonder data is een UnknownApiException', () async {
      http.on('GET /teams/3/players', 200, {'oops': true});

      await expectLater(
        repository.fetch(3),
        throwsA(isA<UnknownApiException>()),
      );
    });
  });

  group('trainers en toeschouwers', () {
    test('POST trainers (201) en DELETE trainers/{user} (204)', () async {
      http
        ..on('POST /teams/3/trainers', 201, PmFixtures.data(PmFixtures.anja()))
        ..on('DELETE /teams/3/trainers/60', 204);

      final anja = await repository.addTrainer(
        3,
        name: 'Anja Assistent',
        email: 'anja@example.com',
      );
      expect(anja.id, 60);
      expect(anja.isSelf, isFalse);
      expect(anja.pushStatus, PushStatus.none);
      expect(body('POST /teams/3/trainers'), {
        'name': 'Anja Assistent',
        'email': 'anja@example.com',
      });

      await repository.removeTrainer(3, 60);
      expect(http.requestsTo('DELETE /teams/3/trainers/60'), hasLength(1));
    });

    test('POST spectators, resend en DELETE', () async {
      http
        ..on('POST /teams/3/spectators', 201, PmFixtures.data(PmFixtures.opa()))
        ..on(
          'POST /teams/3/spectators/51/invite/resend',
          200,
          PmFixtures.data(PmFixtures.opa()),
        )
        ..on('DELETE /teams/3/spectators/51', 204);

      final opa = await repository.addSpectator(
        3,
        name: 'Opa Piet',
        email: 'opa@example.com',
      );
      expect(opa.inviteStatus, InviteStatus.pending);
      expect(body('POST /teams/3/spectators'), {
        'name': 'Opa Piet',
        'email': 'opa@example.com',
      });

      final resent = await repository.resendSpectatorInvite(3, 51);
      expect(resent.id, 51);

      await repository.removeSpectator(3, 51);
      expect(http.requestsTo('DELETE /teams/3/spectators/51'), hasLength(1));
    });
  });

  group('teamlink', () {
    test('GET teamlink', () async {
      http.on('GET /teams/3/teamlink', 200, PmFixtures.teamLink());

      final overview = await repository.fetchTeamLink(3);

      expect(overview.link?.url, 'https://vogels3.assistje.nl/meedoen/Xk3abc');
      expect(overview.linkState, TeamLinkState.active);
      expect(overview.expiresDays, 90);
      expect(overview.joined.map((j) => j.name), ['Linda Lid', 'Opa Piet']);
      expect(overview.joined.last.isSpectator, isTrue);
      expect(overview.joined.first.joinedAt, DateTime.utc(2026, 10, 9, 18, 15));
    });

    test('POST teamlink (201) en DELETE teamlink (200, revoked)', () async {
      http
        ..on('POST /teams/3/teamlink', 201, PmFixtures.teamLink())
        ..on(
          'DELETE /teams/3/teamlink',
          200,
          PmFixtures.teamLink(state: 'revoked'),
        );

      final created = await repository.createTeamLink(3);
      expect(created.linkState, TeamLinkState.active);
      expect(created.link, isNotNull);

      final revoked = await repository.revokeTeamLink(3);
      expect(revoked.link, isNull);
      expect(revoked.linkState, TeamLinkState.revoked);
    });

    test('verlopen link', () async {
      http.on(
        'GET /teams/3/teamlink',
        200,
        PmFixtures.teamLink(state: 'expired'),
      );

      final overview = await repository.fetchTeamLink(3);

      expect(overview.link, isNull);
      expect(overview.linkState, TeamLinkState.expired);
    });
  });

  group('CSV-import', () {
    late MultipartHttpAdapter raw;
    late PlayerManagementRepository importer;
    final file = (
      name: 'spelers.csv',
      bytes: Uint8List.fromList(utf8.encode('naam;positie\nAnna;MF\n')),
    );

    setUp(() {
      raw = MultipartHttpAdapter();
      importer = PlayerManagementRepository(
        ApiClient(
          buildApiDio(
            baseUrl: 'https://assistje.test/api/v1',
            readToken: () async => '12|abc',
            onUnauthorized: () {},
            adapter: raw,
          ),
        ),
      );
    });

    test('POST players/import (multipart): samenvatting uit de docs', () async {
      raw.on('POST /teams/3/players/import', 200, {
        'data': {
          'created': 2,
          'skipped': 1,
          'errors': ['Rij 4: naam ontbreekt'],
          'message':
              '2 speler(s) geïmporteerd, 1 overgeslagen: Rij 4: naam ontbreekt',
        },
      });

      final result = await importer.importPlayers(3, file, sendInvites: true);

      final request = raw.requestsTo('POST /teams/3/players/import').single;
      expect(
        request.options.headers[Headers.contentTypeHeader],
        startsWith('multipart/form-data'),
      );
      final body = raw.multipartBodies.single;
      expect(body, contains('name="file"; filename="spelers.csv"'));
      expect(body, contains('text/csv'));
      expect(body, contains('Anna;MF'));
      expect(body, contains('name="send_invites"\r\n\r\n1'));
      expect(result.created, 2);
      expect(result.skipped, 1);
      expect(result.errors, ['Rij 4: naam ontbreekt']);
      expect(result.message, startsWith('2 speler(s)'));
    });

    test('zonder uitnodigingen gaat send_invites=0 mee', () async {
      raw.on('POST /teams/3/players/import', 200, {
        'data': {'created': 1, 'skipped': 0, 'errors': <String>[]},
      });

      final result = await importer.importPlayers(3, file);

      expect(
        raw.multipartBodies.single,
        contains('name="send_invites"\r\n\r\n0'),
      );
      expect(result.created, 1);
      expect(result.errors, isEmpty);
      expect(result.message, isNull);
    });

    test('422: de fout op file komt als ValidationException', () async {
      raw.on('POST /teams/3/players/import', 422, {
        'message': 'Kolommen ontbreken: positie',
        'errors': {
          'file': ['Kolommen ontbreken: positie'],
        },
      });

      await expectLater(
        importer.importPlayers(3, file),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.fieldError('file'),
            'file',
            'Kolommen ontbreken: positie',
          ),
        ),
      );
    });
  });
}
