import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/lineup_models.dart';

/// Eén plek in een `PATCH lineup`-body.
typedef LineupAssignment = ({String slotCode, int playerId});

/// De opstelling-endpoints (vogels3 `docs/api/v1/lineup.md`). Elke actie geeft
/// de complete opstelling terug.
///
/// - `GET`: voor niet-bewerkers `403` zolang niet gedeeld; ander team `404`.
/// - `PATCH`/`publish`/`formation`: alleen met de lineup-bevoegdheid (`403`).
/// - `publish` zonder iemand op het veld: `422 {message}`; demo-team: `403`.
class LineupRepository {
  const LineupRepository(this._api);

  final ApiClient _api;

  static String _path(int teamId, int eventId) =>
      '/teams/$teamId/events/$eventId/lineup';

  Future<Lineup> fetch(int teamId, int eventId) async =>
      Lineup.fromJson(_data(await _api.get(_path(teamId, eventId))));

  /// Vervangt de hele opstelling. [captainPlayerId] gaat altijd mee: `null`
  /// betekent "geen C" (tenzij [keepCaptain], dan blijft de C zoals hij was).
  Future<Lineup> save(
    int teamId,
    int eventId, {
    required List<LineupAssignment> slots,
    int? captainPlayerId,
    bool keepCaptain = false,
  }) async {
    final body = await _api.patch(
      _path(teamId, eventId),
      data: {
        'slots': [
          for (final slot in slots)
            {'slot_code': slot.slotCode, 'player_id': slot.playerId},
        ],
        if (!keepCaptain) 'captain_player_id': captainPlayerId,
      },
    );
    return Lineup.fromJson(_data(body));
  }

  /// Deelt de opstelling met het team (push naar iedereen behalve jou).
  Future<Lineup> publish(int teamId, int eventId) async => Lineup.fromJson(
    _data(await _api.post('${_path(teamId, eventId)}/publish')),
  );

  /// Wisselt de formatie van het team (geldt voor alle wedstrijden).
  Future<Lineup> changeFormation(
    int teamId,
    int eventId,
    String formation,
  ) async {
    final body = await _api.patch(
      '${_path(teamId, eventId)}/formation',
      data: {'formation': formation},
    );
    return Lineup.fromJson(_data(body));
  }

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final lineupRepositoryProvider = Provider<LineupRepository>(
  (ref) => LineupRepository(ref.watch(apiClientProvider)),
);
