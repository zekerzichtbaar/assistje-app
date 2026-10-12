import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/player_management/application/player_management_controller.dart';
import 'package:assistje/features/player_management/application/player_sections.dart';
import 'package:assistje/features/player_management/application/teamlink_controller.dart';
import 'package:assistje/features/player_management/data/models/player_management_models.dart';
import 'package:assistje/features/team/application/roster_controller.dart';
import 'package:assistje/features/team/application/sport_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import '../team/roster_fixtures.dart';
import 'pm_fixtures.dart';

const _index = 'GET /teams/3/players';
const _roster = 'GET /teams/3/team';

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<PlayerManagementController> start(
    void Function(FakeHttpAdapter http) setup,
  ) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http.on(_index, 200, PmFixtures.overview());
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(playerManagementControllerProvider(3), (_, _) {});
    await container.read(playerManagementControllerProvider(3).future);
    return container.read(playerManagementControllerProvider(3).notifier);
  }

  PlayerManagementState current() =>
      container.read(playerManagementControllerProvider(3)).requireValue;

  ManagedPlayer player(int id) => current().player(id)!;

  test('laadt het overzicht', () async {
    await start((_) {});
    expect(current().data.players, hasLength(3));
    expect(current().writesForbidden, isFalse);
  });

  test('403 bij laden komt als AsyncError', () async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http.on(_index, 403, {'message': 'Nee.'});
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(playerManagementControllerProvider(3), (_, _) {});
    await expectLater(
      container.read(playerManagementControllerProvider(3).future),
      throwsA(isA<ForbiddenException>()),
    );
  });

  test('aanvoerder: optimistisch, de vorige verliest hem', () async {
    final controller = await start((http) {
      http.routes['PATCH /teams/3/players/13/captain'] = (_) =>
          FakeResponse(200, PmFixtures.data(PmFixtures.kees(isCaptain: true)));
    });
    expect(player(12).isCaptain, isTrue);

    final future = controller.setCaptain(13, captain: true);
    // Meteen omgezet, vóór het antwoord.
    expect(player(13).isCaptain, isTrue);
    expect(player(12).isCaptain, isFalse);
    expect(await future, isNull);
    expect(player(13).isCaptain, isTrue);
    expect(player(12).isCaptain, isFalse);
    expect(
      backend.http.requestsTo('PATCH /teams/3/players/13/captain').single.body,
      {'captain': true},
    );
  });

  test('aanvoerder: bij een fout terug naar hoe het was', () async {
    final controller = await start((http) {
      http.on('PATCH /teams/3/players/31/captain', 422, {
        'message': 'Een gast kan geen vaste aanvoerder zijn.',
      });
    });

    final error = await controller.setCaptain(31, captain: true);

    expect(error, isA<ValidationException>());
    expect(player(31).isCaptain, isFalse);
    expect(player(12).isCaptain, isTrue);
  });

  test('bevoegdheid aan/uit is optimistisch met terugdraaien', () async {
    final controller = await start((http) {
      http.on(
        'PATCH /teams/3/players/12/abilities',
        200,
        PmFixtures.data(PmFixtures.linda(abilities: ['lineup', 'fines'])),
      );
    });

    expect(
      await controller.setAbility(12, ability: 'fines', granted: true),
      isNull,
    );
    expect(player(12).abilities, ['lineup', 'fines']);

    backend.http.on('PATCH /teams/3/players/12/abilities', 500);
    final error = await controller.setAbility(
      12,
      ability: 'lineup',
      granted: false,
    );
    expect(error, isA<ServerException>());
    expect(player(12).abilities, ['lineup', 'fines']);
  });

  test('rol: zet de rij en ververst het overzicht', () async {
    final controller = await start((http) {
      http.on(
        'PATCH /teams/3/players/12/role',
        200,
        PmFixtures.data(PmFixtures.linda(isTrainer: true)),
      );
    });
    final before = backend.http.requestsTo(_index).length;
    backend.http.on(
      _index,
      200,
      PmFixtures.overview(
        players: [PmFixtures.linda(isTrainer: true), PmFixtures.kees()],
      ),
    );

    expect(await controller.setTrainer(12, isTrainer: true), isNull);

    expect(player(12).isTrainer, isTrue);
    expect(backend.http.requestsTo(_index).length, before + 1);
  });

  test('403 bij schrijven: alleen-lezen en terugdraaien', () async {
    final controller = await start((http) {
      http.on('PATCH /teams/3/players/12/captain', 403, {'message': 'Demo.'});
    });

    final error = await controller.setCaptain(12, captain: false);

    expect(error, isA<ForbiddenException>());
    expect(player(12).isCaptain, isTrue);
    expect(current().writesForbidden, isTrue);
  });

  test(
    'speler toevoegen haalt het overzicht opnieuw en ververst /team',
    () async {
      final controller = await start((http) {
        http
          ..on('POST /teams/3/players', 201, PmFixtures.data(PmFixtures.kees()))
          ..on(_roster, 200, RosterFixtures.roster());
      });
      container.listen(rosterControllerProvider(3), (_, _) {});
      await container.read(rosterControllerProvider(3).future);
      final rosterBefore = backend.http.requestsTo(_roster).length;
      backend.http.on(
        _index,
        200,
        PmFixtures.overview(
          players: [
            PmFixtures.linda(),
            PmFixtures.kees(),
            PmFixtures.guest(),
            {...PmFixtures.kees(), 'id': 14, 'name': 'Nina Nieuw'},
          ],
        ),
      );

      expect(
        await controller.createPlayer(const NewPlayer(name: 'Nina Nieuw')),
        isNull,
      );

      expect(current().data.players.map((p) => p.id), contains(14));
      await container.read(rosterControllerProvider(3).future);
      expect(backend.http.requestsTo(_roster).length, rosterBefore + 1);
    },
  );

  test('toevoegen met 422 geeft de fout terug, niets ververst', () async {
    final controller = await start((http) {
      http.on('POST /teams/3/players', 422, {
        'message': 'Ongeldig.',
        'errors': {
          'email': ['Dit adres hoort al bij iemand in dit team.'],
        },
      });
    });
    final before = backend.http.requestsTo(_index).length;

    final error = await controller.createPlayer(
      const NewPlayer(name: 'X', sendInvite: true, email: 'linda@example.com'),
    );

    expect(
      (error! as ValidationException).fieldError('email'),
      'Dit adres hoort al bij iemand in dit team.',
    );
    expect(backend.http.requestsTo(_index).length, before);
  });

  test('bewerken en uitnodigen vervangen de rij', () async {
    final controller = await start((http) {
      http
        ..on(
          'PATCH /teams/3/players/12',
          200,
          PmFixtures.data({...PmFixtures.linda(), 'name': 'Linda Langer'}),
        )
        ..on(
          'POST /teams/3/players/13/invite',
          200,
          PmFixtures.data(
            PmFixtures.kees(inviteStatus: 'pending', email: 'k@e.nl'),
          ),
        )
        ..on(
          'POST /teams/3/players/13/invite/resend',
          200,
          PmFixtures.data(
            PmFixtures.kees(inviteStatus: 'pending', email: 'k@e.nl'),
          ),
        );
    });

    expect(
      await controller.updatePlayer(
        12,
        const PlayerUpdate(name: 'Linda Langer'),
      ),
      isNull,
    );
    expect(player(12).name, 'Linda Langer');

    expect(await controller.invitePlayer(13, 'k@e.nl'), isNull);
    expect(player(13).inviteStatus, InviteStatus.pending);
    expect(player(13).email, 'k@e.nl');

    expect(await controller.resendPlayerInvite(13), isNull);
  });

  test('verwijderen: speler, trainer en toeschouwer', () async {
    final controller = await start((http) {
      http
        ..on('DELETE /teams/3/players/13', 204)
        ..on('DELETE /teams/3/trainers/60', 204)
        ..on('DELETE /teams/3/spectators/51', 204);
    });
    backend.http.on(
      _index,
      200,
      PmFixtures.overview(
        players: [PmFixtures.linda(), PmFixtures.guest()],
        trainers: [PmFixtures.tom()],
        spectators: [],
      ),
    );

    expect(await controller.deletePlayer(13), isNull);
    expect(await controller.removeTrainer(60), isNull);
    expect(await controller.removeSpectator(51), isNull);

    expect(current().player(13), isNull);
    expect(current().data.trainers.map((t) => t.id), [3]);
    expect(current().data.spectators, isEmpty);
  });

  test(
    'trainer en toeschouwer toevoegen, toeschouwer opnieuw uitnodigen',
    () async {
      final controller = await start((http) {
        http
          ..on(
            'POST /teams/3/trainers',
            201,
            PmFixtures.data(PmFixtures.anja()),
          )
          ..on(
            'POST /teams/3/spectators',
            201,
            PmFixtures.data(PmFixtures.opa()),
          )
          ..on(
            'POST /teams/3/spectators/51/invite/resend',
            200,
            PmFixtures.data({...PmFixtures.opa(), 'name': 'Opa Piet Sr.'}),
          );
      });

      expect(
        await controller.addTrainer(name: 'Anja', email: 'anja@example.com'),
        isNull,
      );
      expect(
        await controller.addSpectator(name: 'Opa', email: 'opa@example.com'),
        isNull,
      );
      expect(await controller.resendSpectatorInvite(51), isNull);
      expect(current().data.spectators.single.name, 'Opa Piet Sr.');
    },
  );

  group('indeling', () {
    test('trainers, linies, Overig, Gasten', () {
      final data = PlayerManagement.fromJson(
        PmFixtures.overview(
              players: [
                PmFixtures.linda(),
                PmFixtures.kees(),
                PmFixtures.guest(),
                {...PmFixtures.kees(), 'id': 20, 'position': 'TR'},
                {
                  ...PmFixtures.kees(),
                  'id': 21,
                  'user_id': 3,
                  'position': 'ST',
                },
              ],
            )['data']
            as Map<String, dynamic>,
      );
      final sections = PlayerSections.of(
        data,
        SportInfo(RosterFixtures.footballSport()),
      );

      // Tom speelt ook (user_id 3) → geen coach-rij; Anja wel.
      expect(sections.coaches.map((t) => t.id), [60]);
      expect(sections.trainerPlayers.map((p) => p.id), [20]);
      expect(sections.sections.map((s) => s.key), [
        'group-mid',
        'group-att',
        'other',
        'guests',
      ]);
      expect(sections.sections.first.label, 'Middenvelders');
      expect(sections.sections[2].players.map((p) => p.id), [13]);
      // De gastkeeper staat bij Gasten, niet bij de keepers.
      expect(sections.sections.last.players.map((p) => p.id), [31]);
    });

    test('zonder sportlinies staat iedereen bij Overig', () {
      final data = PlayerManagement.fromJson(
        PmFixtures.overview()['data'] as Map<String, dynamic>,
      );
      final sections = PlayerSections.of(data, const SportInfo({}));
      expect(sections.sections.map((s) => s.key), ['other', 'guests']);
      expect(sections.sections.first.players.map((p) => p.id), [12, 13]);
    });
  });

  group('teamlink', () {
    Future<TeamLinkController> startLink(
      void Function(FakeHttpAdapter http) setup,
    ) async {
      backend = TestBackend(token: '12|abc');
      await backend.init();
      backend.http.on('GET /teams/3/teamlink', 200, PmFixtures.teamLink());
      setup(backend.http);
      container = backend.container();
      addTearDown(container.dispose);
      container.listen(teamLinkControllerProvider(3), (_, _) {});
      await container.read(teamLinkControllerProvider(3).future);
      return container.read(teamLinkControllerProvider(3).notifier);
    }

    TeamLinkOverview link() =>
        container.read(teamLinkControllerProvider(3)).requireValue;

    test('intrekken en een nieuwe maken', () async {
      final controller = await startLink((http) {
        http
          ..on(
            'DELETE /teams/3/teamlink',
            200,
            PmFixtures.teamLink(state: 'revoked'),
          )
          ..on('POST /teams/3/teamlink', 201, PmFixtures.teamLink());
      });
      expect(link().linkState, TeamLinkState.active);

      expect(await controller.revoke(), isNull);
      expect(link().link, isNull);
      expect(link().linkState, TeamLinkState.revoked);

      expect(await controller.create(), isNull);
      expect(link().link, isNotNull);
      expect(link().linkState, TeamLinkState.active);
    });

    test('een fout laat de link staan', () async {
      final controller = await startLink((http) {
        http.on('DELETE /teams/3/teamlink', 403, {'message': 'Demo.'});
      });

      expect(await controller.revoke(), isA<ForbiddenException>());
      expect(link().link, isNotNull);
    });

    test('een wijziging ververst het spelersbeheer', () async {
      final controller = await startLink((http) {
        http
          ..on(_index, 200, PmFixtures.overview())
          ..on(
            'DELETE /teams/3/teamlink',
            200,
            PmFixtures.teamLink(state: 'revoked'),
          );
      });
      container.listen(playerManagementControllerProvider(3), (_, _) {});
      await container.read(playerManagementControllerProvider(3).future);
      backend.http.on(_index, 200, PmFixtures.overview(linkActive: false));

      await controller.revoke();
      final data = await container.read(
        playerManagementControllerProvider(3).future,
      );

      expect(data.data.teamLink, isNull);
      expect(data.data.teamLinkState, TeamLinkState.revoked);
    });
  });
}
