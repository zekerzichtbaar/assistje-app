import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/training_teams_models.dart';

/// Partijvorm: ploegen en trainingspunten van één training (vogels3
/// `docs/api/v1/training-teams.md`). Alleen voor de trainer of een speler met
/// `training_points` (anders `403`); geen training, feature uit of ander team
/// `404`; veldfouten `422`.
///
/// Elke schrijfactie op de training geeft het complete scherm terug; sterkte
/// en basis alleen hun nieuwe waarde.
class TrainingTeamsRepository {
  const TrainingTeamsRepository(this._api);

  final ApiClient _api;

  String _teams(int teamId, int eventId) =>
      '/teams/$teamId/events/$eventId/teams';

  /// `GET …/teams`: het hele scherm.
  Future<TrainingTeams> fetch(int teamId, int eventId) async =>
      _screen(await _api.get(_teams(teamId, eventId)));

  /// `POST …/teams/draw`: de aanwezigen indelen in [teams] ploegen; zonder
  /// aantal opnieuw met evenveel ploegen als er nu staan.
  Future<TrainingTeams> draw(int teamId, int eventId, {int? teams}) async =>
      _screen(
        await _api.post(
          '${_teams(teamId, eventId)}/draw',
          data: {'teams': ?teams},
        ),
      );

  /// `DELETE …/teams`: iedereen op de bank (punten blijven staan).
  Future<TrainingTeams> clear(int teamId, int eventId) async =>
      _screen(await _api.delete(_teams(teamId, eventId)));

  /// `POST …/teams/swap`: twee spelers van plek ruilen.
  Future<TrainingTeams> swap(int teamId, int eventId, int a, int b) async =>
      _screen(
        await _api.post(
          '${_teams(teamId, eventId)}/swap',
          data: {'a': a, 'b': b},
        ),
      );

  /// `PATCH …/teams/{player}`: naar ploeg [side], of met `null` naar de bank.
  Future<TrainingTeams> move(
    int teamId,
    int eventId,
    int playerId,
    String? side,
  ) async => _screen(
    await _api.patch(
      '${_teams(teamId, eventId)}/$playerId',
      data: {'side': side},
    ),
  );

  /// `POST …/teams/points`: de uitslag per ploeg; ploegen die er niet in
  /// staan worden leeggemaakt.
  Future<TrainingTeams> setScores(
    int teamId,
    int eventId,
    Map<String, int?> points,
  ) async => _screen(
    await _api.post(
      '${_teams(teamId, eventId)}/points',
      data: {'points': points},
    ),
  );

  /// `POST …/teams/draw-points`: iedereen die meetelt op gelijkspel.
  Future<TrainingTeams> drawPoints(int teamId, int eventId) async =>
      _screen(await _api.post('${_teams(teamId, eventId)}/draw-points'));

  /// `PATCH …/teams/{player}/points`: wat één speler opleverde.
  Future<TrainingTeams> setPlayerPoints(
    int teamId,
    int eventId,
    int playerId,
    int points,
  ) async => _screen(
    await _api.patch(
      '${_teams(teamId, eventId)}/$playerId/points',
      data: {'points': points},
    ),
  );

  /// `POST …/teams/{player}/include`: terug in de puntenlijst (en op
  /// aanwezig als hij dat nog niet stond).
  Future<TrainingTeams> include(int teamId, int eventId, int playerId) async =>
      _screen(await _api.post('${_teams(teamId, eventId)}/$playerId/include'));

  /// `DELETE …/teams/{player}`: uit de punten (en uit volgende indelingen).
  Future<TrainingTeams> exclude(int teamId, int eventId, int playerId) async =>
      _screen(await _api.delete('${_teams(teamId, eventId)}/$playerId'));

  /// `PATCH /teams/{team}/players/{player}/strength`: 1–5 of `null`. Geeft de
  /// bewaarde waarde terug.
  Future<int?> setStrength(int teamId, int playerId, int? strength) async {
    final body = await _api.patch(
      '/teams/$teamId/players/$playerId/strength',
      data: {'strength': strength},
    );
    final saved = _data(body)['strength'];
    return saved is num ? saved.toInt() : null;
  }

  /// `PATCH /teams/{team}/training-basis`. Geeft de bewaarde basis terug.
  Future<TrainingBasis> setBasis(int teamId, TrainingBasis basis) async {
    final body = await _api.patch(
      '/teams/$teamId/training-basis',
      data: {'basis': basis.apiValue},
    );
    final saved = _data(body)['basis'];
    return TrainingBasis.values.firstWhere(
      (b) => b.apiValue == saved,
      orElse: () => basis,
    );
  }

  static TrainingTeams _screen(Map<String, dynamic> body) =>
      TrainingTeams.fromJson(_data(body));

  static Map<String, dynamic> _data(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data;
  }
}

final trainingTeamsRepositoryProvider = Provider<TrainingTeamsRepository>(
  (ref) => TrainingTeamsRepository(ref.watch(apiClientProvider)),
);
