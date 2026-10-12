import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/lineup/data/lineup_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';
import 'lineup_fixtures.dart';

void main() {
  late TestBackend backend;
  late ProviderContainer container;
  late LineupRepository repository;

  setUp(() async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    container = backend.container();
    addTearDown(container.dispose);
    repository = container.read(lineupRepositoryProvider);
  });

  test('haalt de opstelling op en leest alle velden', () async {
    backend.http.on(
      LineupFixtures.get,
      200,
      LineupFixtures.response(publishedAt: '2026-10-11T19:02:11+02:00'),
    );

    final lineup = await repository.fetch(3, 412);

    expect(lineup.fieldVariant, 'football');
    expect(lineup.event.title, 'VV Vogels 3 - SV Merel 2');
    expect(lineup.pool, hasLength(4));
    expect(lineup.pool[2].isGuest, isTrue);
    expect(lineup.pool[2].fromTeam, 'JO19-2');
    expect(lineup.slots.map((s) => s.slotCode), ['GK', 'ST']);
    expect(lineup.formation, '4-3-3');
    expect(lineup.formationLabel, '1-4-3-3');
    expect(lineup.formationSlots.first.x, 50.0);
    expect(lineup.formationSlots.first.y, 92.0);
    expect(lineup.formationSlots.first.label, 'K');
    expect(lineup.formations.map((f) => f.key), ['4-3-3', '4-4-2']);
    expect(lineup.canEdit, isTrue);
    expect(lineup.captainPlayerId, 37);
    expect(lineup.isShared, isTrue);
    expect(lineup.assignments['GK']?.name, 'Kees de Keeper');
    expect(lineup.assignments['LB'], isNull);
    expect(lineup.bench.map((p) => p.id), [52, 60]);
    expect(lineup.filled, 2);
  });

  test('slots uit een vorige formatie tellen niet mee op het veld', () async {
    backend.http.on(
      LineupFixtures.get,
      200,
      LineupFixtures.response(slots: const [('GK', 11), ('LS', 37)]),
    );
    final lineup = await repository.fetch(3, 412);
    expect(lineup.filled, 1);
    expect(lineup.bench.map((p) => p.id), contains(37));
  });

  test('opslaan stuurt alle plekken plus de C', () async {
    backend.http.on(LineupFixtures.patch, 200, LineupFixtures.response());

    await repository.save(
      3,
      412,
      slots: const [
        (slotCode: 'GK', playerId: 11),
        (slotCode: 'ST', playerId: 37),
      ],
      captainPlayerId: 37,
    );

    final request = backend.http.requestsTo(LineupFixtures.patch).single;
    expect(request.body, {
      'slots': [
        {'slot_code': 'GK', 'player_id': 11},
        {'slot_code': 'ST', 'player_id': 37},
      ],
      'captain_player_id': 37,
    });
  });

  test('null-C gaat expliciet mee; keepCaptain laat hem weg', () async {
    backend.http.on(LineupFixtures.patch, 200, LineupFixtures.response());

    await repository.save(3, 412, slots: const []);
    await repository.save(3, 412, slots: const [], keepCaptain: true);

    final requests = backend.http.requestsTo(LineupFixtures.patch);
    expect(requests[0].body, {'slots': <Object?>[], 'captain_player_id': null});
    expect(requests[1].body, {'slots': <Object?>[]});
  });

  test('delen post zonder body; 422 komt als ValidationException', () async {
    backend.http.on(LineupFixtures.publish, 422, {
      'message': 'Er staat nog niemand in de opstelling.',
    });

    await expectLater(
      repository.publish(3, 412),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.message,
          'message',
          'Er staat nog niemand in de opstelling.',
        ),
      ),
    );
    expect(backend.http.requestsTo(LineupFixtures.publish), hasLength(1));
  });

  test('formatie wisselen stuurt de key', () async {
    backend.http.on(
      LineupFixtures.formation,
      200,
      LineupFixtures.response(formation: '4-4-2'),
    );

    final lineup = await repository.changeFormation(3, 412, '4-4-2');

    expect(lineup.formation, '4-4-2');
    expect(backend.http.requestsTo(LineupFixtures.formation).single.body, {
      'formation': '4-4-2',
    });
  });

  test('403 (nog niet gedeeld) en 404 (ander team)', () async {
    backend.http.on(LineupFixtures.get, 403, {'message': 'Nog niet gedeeld.'});
    await expectLater(
      repository.fetch(3, 412),
      throwsA(isA<ForbiddenException>()),
    );

    backend.http.on(LineupFixtures.get, 404, {'message': 'Not found.'});
    await expectLater(
      repository.fetch(3, 412),
      throwsA(isA<NotFoundException>()),
    );
  });
}
