import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/auth/auth_controller.dart';
import '../../agenda/application/agenda_controller.dart';
import '../../event/application/event_detail_controller.dart';
import '../data/models/training_teams_models.dart';
import '../data/training_teams_repository.dart';

/// Hoelang tikken op de uitslag-steppers wacht voor het naar de server gaat:
/// vijf keer tikken is één verzoek (zoals de PWA). In tests overschrijfbaar.
final trainingScoresDebounceProvider = Provider<Duration>(
  (ref) => const Duration(milliseconds: 500),
);

/// De partijvorm van één training: laden, verversen, indelen, ruilen,
/// verplaatsen, uitslag en punten, in- en uitsluiten, sterktes en de basis.
///
/// Optimistisch (met terugdraaien bij een fout): ruilen, verplaatsen, de
/// uitslag per ploeg, punten per speler, sterkte en basis. Indelen, wissen,
/// iedereen gelijk en in-/uitsluiten wachten op de server — die rekent de
/// nieuwe indeling of puntenlijst uit. Elke schrijfactie op de training geeft
/// het complete scherm terug; dat wordt meteen de nieuwe stand.
///
/// Acties geven de fout terug (of `null` als het lukte).
class TrainingTeamsController extends AsyncNotifier<TrainingTeams> {
  TrainingTeamsController(this.key);

  final EventKey key;

  int get teamId => key.teamId;
  int get eventId => key.eventId;

  late TrainingTeamsRepository _repository;

  Timer? _scoresTimer;
  Map<String, int?>? _pendingScores;
  Completer<Object?>? _scoresDone;

  /// De laatste uitslag die de server bevestigde (om naar terug te draaien).
  Map<String, int>? _confirmedScores;

  @override
  Future<TrainingTeams> build() {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een vers scherm.
    ref.watch(authControllerProvider);
    final repository = ref.watch(trainingTeamsRepositoryProvider);
    _repository = repository;
    ref.onDispose(() {
      // Wie het scherm sluit binnen de wachttijd verliest zijn tik niet.
      final timer = _scoresTimer;
      final pending = _pendingScores;
      if (timer != null && timer.isActive && pending != null) {
        timer.cancel();
        unawaited(
          repository
              .setScores(teamId, eventId, pending)
              .then<void>((_) {}, onError: (Object _) {}),
        );
      }
      final done = _scoresDone;
      if (done != null && !done.isCompleted) done.complete(null);
    });
    return repository.fetch(teamId, eventId);
  }

  /// Opnieuw laden. Met data in beeld blijft die staan bij een fout.
  Future<Object?> refresh() async {
    if (state.value == null) {
      ref.invalidateSelf();
      try {
        await future;
        return null;
      } on Object catch (error) {
        return error;
      }
    }
    try {
      _set(await _repository.fetch(teamId, eventId));
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  void _set(TrainingTeams value) {
    if (ref.mounted) state = AsyncData(value);
  }

  TrainingTeams? get _current => ref.mounted ? state.value : null;

  // --- Indeling ----------------------------------------------------------

  /// Deel de aanwezigen in [teams] ploegen in; zonder aantal opnieuw met
  /// evenveel als er nu staan.
  Future<Object?> draw({int? teams}) {
    final now = _current;
    if (now == null) return Future.value(const NotFoundException());
    if (!now.teams.mayAssign) return Future.value(const ForbiddenException());
    return _write(() => _repository.draw(teamId, eventId, teams: teams));
  }

  /// De indeling leeg (iedereen op de bank).
  Future<Object?> clear() {
    final now = _current;
    if (now == null) return Future.value(const NotFoundException());
    if (!now.teams.mayAssign) return Future.value(const ForbiddenException());
    return _write(() => _repository.clear(teamId, eventId));
  }

  /// Ruil [a] en [b] van plek (de bank telt als plek).
  Future<Object?> swap(int a, int b) {
    final now = _current;
    if (now == null) return Future.value(const NotFoundException());
    if (!now.teams.mayAssign) return Future.value(const ForbiddenException());
    if (a == b) return Future.value();
    return _optimistic(
      now.swapped(a, b),
      () => _repository.swap(teamId, eventId, a, b),
    );
  }

  /// Zet [playerId] in ploeg [side], of met `null` op de bank.
  Future<Object?> move(int playerId, String? side) {
    final now = _current;
    if (now == null) return Future.value(const NotFoundException());
    if (!now.teams.mayAssign) return Future.value(const ForbiddenException());
    if (now.teams.player(playerId)?.side == side) return Future.value();
    return _optimistic(
      now.moved(playerId, side),
      () => _repository.move(teamId, eventId, playerId, side),
    );
  }

  // --- Uitslag en punten -------------------------------------------------

  /// De uitslag per ploeg op [scores] zetten. Meteen in beeld; de server
  /// krijgt hem na [trainingScoresDebounceProvider] (een nieuwere aanroep
  /// binnen die tijd vervangt deze, en dan komt deze terug met `null`).
  Future<Object?> setScores(Map<String, int> scores) {
    final now = _current;
    if (now == null) return Future.value(const NotFoundException());
    if (!now.teams.tracksPoints) {
      return Future.value(const ForbiddenException());
    }
    _confirmedScores ??= now.teams.scores;
    _set(now.withScores(scores));

    _scoresTimer?.cancel();
    final previous = _scoresDone;
    if (previous != null && !previous.isCompleted) previous.complete(null);

    final done = Completer<Object?>();
    _scoresDone = done;
    final payload = <String, int?>{...scores};
    _pendingScores = payload;
    _scoresTimer = Timer(
      ref.read(trainingScoresDebounceProvider),
      () => unawaited(_flushScores(payload, done)),
    );
    return done.future;
  }

  Future<void> _flushScores(
    Map<String, int?> payload,
    Completer<Object?> done,
  ) async {
    _pendingScores = null;
    try {
      final saved = await _repository.setScores(teamId, eventId, payload);
      // Een nieuwere tik onderweg wint: die stand niet overschrijven.
      if (identical(_scoresDone, done)) {
        _confirmedScores = null;
        _set(saved);
      }
      if (!done.isCompleted) done.complete(null);
    } on Object catch (error) {
      if (identical(_scoresDone, done)) {
        final confirmed = _confirmedScores;
        final latest = _current;
        if (confirmed != null && latest != null) {
          _set(latest.withScores(confirmed));
        }
        _confirmedScores = null;
      }
      if (!done.isCompleted) done.complete(error);
    }
  }

  /// Eén tik voor het gewone geval: ploeg [winner] won (2 punten), de rest
  /// niet (0); met `null` gelijkspel (iedereen 1).
  Future<Object?> quickResult(String? winner) {
    final now = _current;
    if (now == null) return Future.value(const NotFoundException());
    return setScores({
      for (final side in now.usedSides)
        side: winner == null
            ? quickDrawPoints
            : (side == winner ? quickWinPoints : quickLossPoints),
    });
  }

  /// De uitslag van ploeg [side] met [delta] bijstellen (0–10).
  Future<Object?> bumpScore(String side, int delta) {
    final now = _current;
    if (now == null) return Future.value(const NotFoundException());
    final current = now.teams.scores[side] ?? 0;
    final next = (current + delta).clamp(0, maxTeamPoints);
    if (next == current && now.teams.scores.containsKey(side)) {
      return Future.value();
    }
    return setScores({...now.teams.scores, side: next});
  }

  /// Iedereen die meetelt op gelijkspel.
  Future<Object?> drawPoints() {
    final now = _current;
    if (now == null) return Future.value(const NotFoundException());
    if (!now.teams.tracksPoints) {
      return Future.value(const ForbiddenException());
    }
    return _write(() => _repository.drawPoints(teamId, eventId));
  }

  /// De partijpunten van [playerId] met [delta] bijstellen (0–10).
  Future<Object?> bumpPlayer(int playerId, int delta) {
    final now = _current;
    if (now == null) return Future.value(const NotFoundException());
    if (!now.teams.tracksPoints) {
      return Future.value(const ForbiddenException());
    }
    ScoringRow? row;
    for (final r in now.scoring) {
      if (r.id == playerId) row = r;
    }
    if (row == null) return Future.value(const NotFoundException());
    final current = row.scored ?? 0;
    final next = (current + delta).clamp(0, maxTeamPoints);
    if (next == current) return Future.value();
    return _optimistic(
      now.withPlayerScore(playerId, next),
      () => _repository.setPlayerPoints(teamId, eventId, playerId, next),
    );
  }

  /// [playerId] terug in de puntenlijst (wordt aanwezig als hij dat niet
  /// stond — daarom ververst ook het event).
  Future<Object?> include(int playerId) {
    final now = _current;
    if (now == null) return Future.value(const NotFoundException());
    if (!now.teams.tracksPoints) {
      return Future.value(const ForbiddenException());
    }
    return _write(
      () => _repository.include(teamId, eventId, playerId),
      attendanceChanged: true,
    );
  }

  /// [playerId] uit de punten halen.
  Future<Object?> exclude(int playerId) {
    final now = _current;
    if (now == null) return Future.value(const NotFoundException());
    if (!now.teams.tracksPoints) {
      return Future.value(const ForbiddenException());
    }
    return _write(() => _repository.exclude(teamId, eventId, playerId));
  }

  // --- Sterkte en basis --------------------------------------------------

  /// De speelsterkte van [playerId] op [strength] (1–5) of leeg.
  Future<Object?> setStrength(int playerId, int? strength) async {
    final now = _current;
    if (now == null) return const NotFoundException();
    if (!now.teams.mayAssign) return const ForbiddenException();
    final before = now.teams.player(playerId);
    if (before == null) return const NotFoundException();
    if (before.strength == strength) return null;
    _set(now.withStrength(playerId, strength));
    try {
      final saved = await _repository.setStrength(teamId, playerId, strength);
      final latest = _current;
      if (latest != null && saved != strength) {
        _set(latest.withStrength(playerId, saved));
      }
      return null;
    } on Object catch (error) {
      final latest = _current;
      if (latest != null) _set(latest.withStrength(playerId, before.strength));
      return error;
    }
  }

  /// Waarop de indeling stuurt (teaminstelling).
  Future<Object?> setBasis(TrainingBasis basis) async {
    final now = _current;
    if (now == null) return const NotFoundException();
    if (!now.teams.mayAssign) return const ForbiddenException();
    final before = now.teams.basis;
    if (before == basis) return null;
    _set(now.withBasis(basis));
    try {
      final saved = await _repository.setBasis(teamId, basis);
      final latest = _current;
      if (latest != null && saved != basis) _set(latest.withBasis(saved));
    } on Object catch (error) {
      final latest = _current;
      if (latest != null) _set(latest.withBasis(before));
      return error;
    }
    // `derived` hangt van de basis af (bij `random` leeg): opnieuw ophalen.
    await refresh();
    return null;
  }

  // --- Hulpjes -----------------------------------------------------------

  Future<Object?> _optimistic(
    TrainingTeams optimistic,
    Future<TrainingTeams> Function() request,
  ) async {
    final before = _current;
    _set(optimistic);
    try {
      _set(await request());
      return null;
    } on Object catch (error) {
      if (before != null) _set(before);
      return error;
    }
  }

  Future<Object?> _write(
    Future<TrainingTeams> Function() request, {
    bool attendanceChanged = false,
  }) async {
    try {
      _set(await request());
    } on Object catch (error) {
      return error;
    }
    if (attendanceChanged && ref.mounted) {
      ref
        ..invalidate(eventDetailControllerProvider(key))
        ..invalidate(agendaControllerProvider(teamId));
    }
    return null;
  }
}

/// De partijvorm per `(teamId, eventId)`; weg zodra het scherm dicht is. Geen
/// automatische retry: het scherm toont een fout met "Opnieuw proberen".
final trainingTeamsControllerProvider = AsyncNotifierProvider.autoDispose
    .family<TrainingTeamsController, TrainingTeams, EventKey>(
      TrainingTeamsController.new,
      retry: (retryCount, error) => null,
    );
