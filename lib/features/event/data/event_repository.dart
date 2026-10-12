import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/event_detail_models.dart';

/// Event-detail, MOTM-stem en carpool (vogels3 `docs/api/v1/events.md`,
/// `motm.md`, `carpool.md`). RSVP loopt via `AgendaRepository.setAttendance`.
class EventRepository {
  const EventRepository(this._api);

  final ApiClient _api;

  String _base(int teamId, int eventId) => '/teams/$teamId/events/$eventId';

  /// `GET teams/{team}/events/{event}`.
  Future<EventDetail> fetch(int teamId, int eventId) async {
    final body = await _api.get(_base(teamId, eventId));
    return EventDetail.fromJson(_data(body));
  }

  /// Je stem op [playerId] uitbrengen of omzetten.
  Future<MotmVoteResult> voteMotm(int teamId, int eventId, int playerId) async {
    final body = await _api.post(
      '${_base(teamId, eventId)}/motm',
      data: {'voted_player_id': playerId},
    );
    return MotmVoteResult.fromJson(_data(body));
  }

  /// Je stem intrekken (`204`, ook zonder stem).
  Future<void> unvoteMotm(int teamId, int eventId) =>
      _api.delete('${_base(teamId, eventId)}/motm');

  /// Aanmelden of bijwerken. [seats] gaat alleen mee bij [CarpoolMode.fromClub].
  Future<CarpoolOffer> saveCarpool(
    int teamId,
    int eventId, {
    required CarpoolMode mode,
    int? seats,
  }) async {
    final body = await _api.post(
      '${_base(teamId, eventId)}/carpool',
      data: {
        'mode': mode == CarpoolMode.fromClub ? 'from_club' : 'direct',
        if (mode == CarpoolMode.fromClub) 'seats': seats,
      },
    );
    return CarpoolOffer.fromJson(_data(body));
  }

  /// Je aanmelding weghalen (`204`, ook als je niet aangemeld was).
  Future<void> removeCarpool(int teamId, int eventId) =>
      _api.delete('${_base(teamId, eventId)}/carpool');

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final eventRepositoryProvider = Provider<EventRepository>(
  (ref) => EventRepository(ref.watch(apiClientProvider)),
);
