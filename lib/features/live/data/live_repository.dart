import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/live_models.dart';

/// De live-endpoints (vogels3 `docs/api/v1/live.md`): de live-stand, volgen,
/// reageren, de klok (8 acties) en de tijdlijn (10 acties).
///
/// Elke schrijfactie op klok en tijdlijn geeft de verse live-stand terug (in
/// dezelfde vorm als `GET …/live`), dus de app hoeft daarna niet te pollen.
/// Aanmaken antwoordt `201` met `meta.created_id`; dat id heeft de app niet
/// nodig (de tijdlijn staat al in het antwoord).
class LiveRepository {
  const LiveRepository(this._api);

  final ApiClient _api;

  static String _event(int teamId, int eventId) =>
      '/teams/$teamId/events/$eventId';

  static String _live(int teamId, int eventId) =>
      '${_event(teamId, eventId)}/live';

  /// `GET …/live`: klok, stand, tijdlijn, reacties en meekijkers.
  Future<LiveMatch> fetch(int teamId, int eventId) async =>
      _match(await _api.get(_live(teamId, eventId)));

  // ── Meeleven ────────────────────────────────────────────────────────────

  /// Live-pushes volgen; geeft `following_live` terug.
  Future<bool> follow(int teamId, int eventId) async {
    final body = await _api.post('${_live(teamId, eventId)}/follow');
    final data = body['data'];
    if (data is Map<String, dynamic>) {
      final following = data['following_live'];
      if (following is bool) return following;
    }
    return true;
  }

  /// Niet meer volgen (`204`).
  Future<void> unfollow(int teamId, int eventId) async {
    await _api.delete('${_live(teamId, eventId)}/follow');
  }

  /// Zet een duimpje aan of uit; geeft de verse telling van de hele
  /// wedstrijd terug.
  Future<Map<String, List<LiveReaction>>> react(
    int teamId,
    int eventId, {
    required String itemKey,
    required String emoji,
  }) async {
    final body = await _api.post(
      '${_live(teamId, eventId)}/reactions',
      data: {'item_key': itemKey, 'emoji': emoji},
    );
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return const LiveReactionsConverter().fromJson(data['reactions']);
  }

  // ── Klok ────────────────────────────────────────────────────────────────

  /// Aftrap; [minute] (0–120) als de klok te laat aanging.
  Future<LiveMatch> start(int teamId, int eventId, {int? minute}) =>
      _clock(teamId, eventId, 'start', {'minute': ?minute});

  /// Rust of onderbreking; [minute] zet de rust op een eerdere minuut,
  /// [trim] schuift wat daarna gelogd is terug.
  Future<LiveMatch> pause(
    int teamId,
    int eventId, {
    int? minute,
    bool trim = false,
  }) => _clock(teamId, eventId, 'pause', {
    'minute': ?minute,
    if (trim) 'trim': true,
  });

  /// Verder in hetzelfde speeldeel.
  Future<LiveMatch> resume(int teamId, int eventId) =>
      _clock(teamId, eventId, 'resume', null);

  /// Het volgende speeldeel aftrappen.
  Future<LiveMatch> next(
    int teamId,
    int eventId, {
    int? minute,
    bool trim = false,
  }) => _clock(teamId, eventId, 'next', {
    'minute': ?minute,
    if (trim) 'trim': true,
  });

  /// Eindfluit.
  Future<LiveMatch> stop(int teamId, int eventId) =>
      _clock(teamId, eventId, 'stop', null);

  /// Eindfluit terugdraaien (daarna op rust).
  Future<LiveMatch> reopen(int teamId, int eventId) =>
      _clock(teamId, eventId, 'reopen', null);

  /// Speelduur rechtzetten na de eindfluit (1–300 minuten).
  Future<LiveMatch> duration(int teamId, int eventId, int minutes) =>
      _clock(teamId, eventId, 'duration', {'minutes': minutes});

  /// Verslag volledig wissen (onomkeerbaar).
  Future<LiveMatch> reset(int teamId, int eventId) =>
      _clock(teamId, eventId, 'reset', null);

  Future<LiveMatch> _clock(
    int teamId,
    int eventId,
    String action,
    Map<String, Object?>? body,
  ) async => _match(
    await _api.post(
      '${_live(teamId, eventId)}/$action',
      data: body == null || body.isEmpty ? null : body,
    ),
  );

  // ── Tijdlijn ────────────────────────────────────────────────────────────

  /// Een doelpunt (`goal`) of eigen doelpunt (`own_goal`).
  Future<LiveMatch> addGoal(
    int teamId,
    int eventId, {
    required int minute,
    required int playerId,
    bool ownGoal = false,
    int? assistPlayerId,
    bool penalty = false,
  }) async => _match(
    await _api.post(
      '${_event(teamId, eventId)}/goals',
      data: {
        'minute': minute,
        'type': ownGoal ? 'own_goal' : 'goal',
        'player_id': playerId,
        'assist_player_id': ownGoal ? null : assistPlayerId,
        'penalty': !ownGoal && penalty,
      },
    ),
  );

  /// Doelpunt (eigen, eigen doelpunt of tegendoelpunt) weg.
  Future<LiveMatch> deleteGoal(int teamId, int eventId, int goalId) async =>
      _match(await _api.delete('${_event(teamId, eventId)}/goals/$goalId'));

  /// Een tegendoelpunt zonder speler.
  Future<LiveMatch> addOpponentGoal(
    int teamId,
    int eventId, {
    required int minute,
  }) async => _match(
    await _api.post(
      '${_event(teamId, eventId)}/opponent-goal',
      data: {'minute': minute},
    ),
  );

  /// Het laatst toegevoegde tegendoelpunt weg.
  Future<LiveMatch> deleteLastOpponentGoal(int teamId, int eventId) async =>
      _match(await _api.delete('${_event(teamId, eventId)}/opponent-goal'));

  /// Een kaart van soort [type] (uit `rules.card_types`).
  Future<LiveMatch> addCard(
    int teamId,
    int eventId, {
    required int minute,
    required String type,
    required int playerId,
  }) async => _match(
    await _api.post(
      '${_event(teamId, eventId)}/cards',
      data: {'minute': minute, 'type': type, 'player_id': playerId},
    ),
  );

  Future<LiveMatch> deleteCard(int teamId, int eventId, int cardId) async =>
      _match(await _api.delete('${_event(teamId, eventId)}/cards/$cardId'));

  /// Een moment van soort [type] (uit `rules.moment_types`), speler optioneel.
  Future<LiveMatch> addMoment(
    int teamId,
    int eventId, {
    required int minute,
    required String type,
    int? playerId,
  }) async => _match(
    await _api.post(
      '${_event(teamId, eventId)}/moments',
      data: {'minute': minute, 'type': type, 'player_id': playerId},
    ),
  );

  Future<LiveMatch> deleteMoment(int teamId, int eventId, int momentId) async =>
      _match(await _api.delete('${_event(teamId, eventId)}/moments/$momentId'));

  /// Een wissel: [offPlayerId] eruit, [onPlayerId] erin.
  Future<LiveMatch> addSub(
    int teamId,
    int eventId, {
    required int minute,
    required int offPlayerId,
    required int onPlayerId,
  }) async => _match(
    await _api.post(
      '${_event(teamId, eventId)}/subs',
      data: {
        'minute': minute,
        'off_player_id': offPlayerId,
        'on_player_id': onPlayerId,
      },
    ),
  );

  Future<LiveMatch> deleteSub(int teamId, int eventId, int subId) async =>
      _match(await _api.delete('${_event(teamId, eventId)}/subs/$subId'));

  static LiveMatch _match(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return LiveMatch.fromJson(data);
  }
}

final liveRepositoryProvider = Provider<LiveRepository>(
  (ref) => LiveRepository(ref.watch(apiClientProvider)),
);
