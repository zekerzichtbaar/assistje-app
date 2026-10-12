import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/wheel/data/models/wheel_models.dart';
import 'package:assistje/features/wheel/data/wheel_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'wheel_fixtures.dart';

void main() {
  late FakeHttpAdapter http;
  late WheelRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = WheelRepository(
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

  test('leest spelers, draaien, wedstrijd en preset', () async {
    http.on('GET /teams/3/wheel', 200, WheelFixtures.overview());

    final overview = await repository.fetch(3);

    expect(overview.players.map((p) => p.key), [
      'p17',
      'p18',
      'p21',
      'p30',
      'u4',
    ]);
    final ronald = overview.players.last;
    expect(ronald.id, isNull);
    expect(ronald.userId, 4);
    expect(ronald.isStaff, isTrue);
    expect(ronald.isRoster, isFalse);
    expect(overview.players[3].isGuest, isTrue);
    final spin = overview.recentSpins.single;
    expect(spin.id, 31);
    expect(spin.drawnAt, DateTime.utc(2026, 10, 10, 9, 2, 44));
    expect(spin.canDelete, isTrue);
    expect(spin.eventId, 812);
    expect(overview.upcomingMatch?.label, 'Vogels 3 - Kraaien 1');
    expect(overview.upcomingMatch?.date, '12 okt');
    expect(overview.preset?.presentStaffIds, [4]);
    expect(overview.preset?.benchIds, [21]);
  });

  test('draai vastleggen: speler-winnaar en kandidaten', () async {
    http.on('POST /teams/3/wheel/spin', 201, {
      'data': WheelFixtures.spin(id: 32, eventId: null, winnerPlayerId: 17),
    });
    const sam = WheelPlayer(key: 'p17', id: 17, name: 'Sam');
    const kim = WheelPlayer(key: 'p18', id: 18, name: 'Kim');
    const ronald = WheelPlayer(key: 'u4', userId: 4, isStaff: true);

    final spin = await repository.recordSpin(
      3,
      winner: sam,
      candidates: const [sam, kim, ronald],
    );

    expect(http.requests.single.body, {
      'winner_player_id': 17,
      'candidate_player_ids': [17, 18],
      'candidate_user_ids': [4],
    });
    expect(spin.id, 32);
    expect(spin.winnerPlayerId, 17);
    expect(spin.eventId, isNull);
  });

  test('draai vastleggen: staf-winnaar stuurt winner_user_id', () async {
    http.on('POST /teams/3/wheel/spin', 201, {
      'data': WheelFixtures.spin(id: 33, eventId: null, winnerUserId: 4),
    });
    const sam = WheelPlayer(key: 'p17', id: 17);
    const ronald = WheelPlayer(key: 'u4', userId: 4, isStaff: true);

    await repository.recordSpin(
      3,
      winner: ronald,
      candidates: const [sam, ronald],
    );

    expect(http.requests.single.body, {
      'winner_user_id': 4,
      'candidate_player_ids': [17],
      'candidate_user_ids': [4],
    });
  });

  test('koppelen, ontkoppelen en verwijderen', () async {
    http
      ..on('POST /teams/3/wheel/spin/31/assign', 200, {
        'data': WheelFixtures.spin(),
      })
      ..on('DELETE /teams/3/wheel/spin/31/assign', 200, {
        'data': WheelFixtures.spin(eventId: null),
      })
      ..on('DELETE /teams/3/wheel/spin/31', 204);

    expect((await repository.assign(3, 31)).eventId, 812);
    expect((await repository.unassign(3, 31)).eventId, isNull);
    await repository.deleteSpin(3, 31);
    expect(http.requests.map((r) => r.method), ['POST', 'DELETE', 'DELETE']);
  });

  test('geen wedstrijd: 422 met errors.wheel', () async {
    http.on('POST /teams/3/wheel/spin/31/assign', 422, {
      'message': 'Geen aankomende wedstrijd binnen 7 dagen.',
      'errors': {
        'wheel': ['Geen aankomende wedstrijd binnen 7 dagen.'],
      },
    });

    await expectLater(
      repository.assign(3, 31),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.fieldError('wheel'),
          'wheel',
          'Geen aankomende wedstrijd binnen 7 dagen.',
        ),
      ),
    );
  });
}
