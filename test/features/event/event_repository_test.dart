import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/agenda/data/models/agenda_models.dart';
import 'package:assistje/features/event/data/event_repository.dart';
import 'package:assistje/features/event/data/models/event_detail_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';
import 'event_fixtures.dart';

const _detail = 'GET /teams/3/events/412';
const _motm = '/teams/3/events/412/motm';
const _carpool = '/teams/3/events/412/carpool';

void main() {
  late TestBackend backend;
  late ProviderContainer container;
  late EventRepository repository;

  setUp(() async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    container = backend.container();
    repository = container.read(eventRepositoryProvider);
  });

  tearDown(() => container.dispose());

  group('fetch', () {
    test('leest het docs-voorbeeld', () async {
      backend.http.on(_detail, 200, EventFixtures.eventDetail());

      final e = await repository.fetch(3, 412);

      expect(backend.http.requestsTo(_detail), hasLength(1));
      expect(e.id, 412);
      expect(e.type, EventType.match);
      expect(e.isMatch, isTrue);
      expect(e.isHome, isFalse);
      expect(e.competition, 'league');
      expect(e.homeTeam, 'Arnhemia 2');
      expect(e.awayTeam, 'Vogels 3');
      expect(e.venue, 'Sportpark Arnhemia');
      expect(e.notes, 'Witte sokken mee.');
      expect(e.meetAt, DateTime.parse('2026-10-11T13:15:00+02:00'));
      expect(e.live?.periodEnds, [45, 90]);
      expect(e.rsvpStatuses, [
        AttendanceStatus.present,
        AttendanceStatus.nonplay,
        AttendanceStatus.absent,
      ]);
      expect(e.sportlink?.field, 'Veld 2');
      expect(e.sportlink?.dressingRoom, 'Kleedkamer 4');
      expect(e.sportlink?.referee, 'J. de Vries');
      expect(e.myStatus, AttendanceStatus.absent);
      expect(e.myReason, 'Ziek');
      expect(e.canRsvp, isTrue);
      expect(e.canChange, isTrue);
      expect(e.counts.present, 9);
      expect(e.counts.pending, 4);
      expect(e.playerCounts.present, 8);
      expect(e.players, hasLength(2));
      expect(e.players.first.kind, EventPlayerKind.player);
      expect(e.players.first.isKeeper, isTrue);
      expect(e.players.first.rowKey, 'p37');
      expect(e.players.last.kind, EventPlayerKind.staff);
      expect(e.motm?.opensAfter, isTrue);
      expect(e.motm?.selfId, 42);
      expect(e.motm?.eligible.single.name, 'Kees Jansen');
      expect(e.carpoolOffers?.single.mode, CarpoolMode.fromClub);
      expect(e.carpoolOffers?.single.seats, 3);
      expect(e.isTrainer, isFalse);
    });

    test('onbekende soorten en antwoorden breken niets', () async {
      final data = EventFixtures.eventDetailData();
      final players = [
        for (final p in data['players'] as List<dynamic>)
          {...p as Map<String, dynamic>, 'kind': 'robot', 'status': 'later'},
      ];
      backend.http.on(
        _detail,
        200,
        EventFixtures.eventDetail({
          'type': 'tournament',
          'players': players,
          'motm': null,
          'carpool_offers': null,
          'sportlink': null,
        }),
      );

      final e = await repository.fetch(3, 412);

      expect(e.type, EventType.unknown);
      expect(e.players.first.kind, EventPlayerKind.unknown);
      expect(e.players.first.status, AttendanceStatus.pending);
      expect(e.motm, isNull);
      expect(e.carpoolOffers, isNull);
      expect(e.sportlink, isNull);
    });

    test('403 en 404 worden getypeerde fouten', () async {
      backend.http.on(_detail, 403, {'message': 'Geen toegang.'});
      await expectLater(
        repository.fetch(3, 412),
        throwsA(isA<ForbiddenException>()),
      );

      backend.http.on(_detail, 404, {'message': 'Niet gevonden.'});
      await expectLater(
        repository.fetch(3, 412),
        throwsA(isA<NotFoundException>()),
      );
    });
  });

  group('motm', () {
    test('stemmen stuurt voted_player_id en leest het antwoord', () async {
      backend.http.on('POST $_motm', 200, EventFixtures.motmVote());

      final result = await repository.voteMotm(3, 412, 37);

      final request = backend.http.requestsTo('POST $_motm').single;
      expect(request.body, {'voted_player_id': 37});
      expect(result.eventId, 412);
      expect(result.myVote, 37);
      expect(result.isOpen, isTrue);
      expect(result.closesAt, DateTime.parse('2026-10-12T14:30:00+02:00'));
    });

    test('422 met alleen message', () async {
      backend.http.on('POST $_motm', 422, {'message': 'Stemmen is gesloten.'});

      await expectLater(
        repository.voteMotm(3, 412, 37),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.message,
            'message',
            'Stemmen is gesloten.',
          ),
        ),
      );
    });

    test('intrekken is een DELETE (204)', () async {
      backend.http.on('DELETE $_motm', 204);

      await repository.unvoteMotm(3, 412);

      expect(backend.http.requestsTo('DELETE $_motm'), hasLength(1));
    });
  });

  group('carpool', () {
    test('vanaf de club stuurt mode + seats', () async {
      backend.http.on('POST $_carpool', 201, EventFixtures.carpoolOffer());

      final offer = await repository.saveCarpool(
        3,
        412,
        mode: CarpoolMode.fromClub,
        seats: 3,
      );

      final request = backend.http.requestsTo('POST $_carpool').single;
      expect(request.body, {'mode': 'from_club', 'seats': 3});
      expect(offer.id, 88);
      expect(offer.userName, 'Ruud de Rijder');
      expect(offer.isSelf, isTrue);
      expect(offer.mode, CarpoolMode.fromClub);
    });

    test('rechtstreeks stuurt geen seats', () async {
      backend.http.on('POST $_carpool', 200, {
        'data': {
          ...EventFixtures.carpoolOffer()['data'] as Map<String, dynamic>,
          'mode': 'direct',
          'seats': null,
        },
      });

      final offer = await repository.saveCarpool(
        3,
        412,
        mode: CarpoolMode.direct,
        seats: 4,
      );

      final request = backend.http.requestsTo('POST $_carpool').single;
      expect(request.body, {'mode': 'direct'});
      expect(offer.mode, CarpoolMode.direct);
      expect(offer.seats, isNull);
    });

    test('422 met errors.event', () async {
      backend.http.on('POST $_carpool', 422, EventFixtures.carpoolError());

      await expectLater(
        repository.saveCarpool(3, 412, mode: CarpoolMode.direct),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.fieldError('event'),
            'errors.event',
            'Carpool is alleen voor uitwedstrijden.',
          ),
        ),
      );
    });

    test('weghalen is een DELETE (204)', () async {
      backend.http.on('DELETE $_carpool', 204);

      await repository.removeCarpool(3, 412);

      expect(backend.http.requestsTo('DELETE $_carpool'), hasLength(1));
    });
  });
}
