import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../../event/application/event_detail_controller.dart';
import '../data/lineup_repository.dart';
import '../data/models/lineup_models.dart';

/// Welke opstelling: team + wedstrijd.
typedef LineupKey = ({int teamId, int eventId});

/// De opstelling van één wedstrijd.
///
/// Slepen is optimistisch: het veld verandert meteen, daarna gaat de hele
/// opstelling met `PATCH` naar de server (na elke sleep, zoals de PWA). Lukt
/// dat, dan wint het serverantwoord (bv. de vaste aanvoerder die de C
/// krijgt); mislukt het, dan springt het veld terug naar de laatste stand die
/// de server bevestigde. Opslaan gaat op volgorde, zodat een snelle tweede
/// sleep nooit vóór de eerste bij de server aankomt.
///
/// Formatie wisselen en delen zijn niet optimistisch: het antwoord bepaalt
/// de nieuwe posities en het deelmoment.
///
/// Acties geven de fout terug (of `null` als het lukte).
class LineupController extends AsyncNotifier<Lineup> {
  LineupController(this.key);

  final LineupKey key;

  /// Laatste stand die de server bevestigde (terugval bij een fout).
  Lineup? _confirmed;

  /// Volgnummer van de laatste lokale wijziging.
  int _seq = 0;

  /// Staart van de opslagrij.
  Future<void> _tail = Future.value();

  /// Lopende opslagverzoeken.
  int _pending = 0;

  LineupRepository get _repository => ref.read(lineupRepositoryProvider);

  /// Loopt er nog een opslag?
  bool get isSaving => _pending > 0;

  @override
  Future<Lineup> build() async {
    ref.watch(authControllerProvider);
    final lineup = await ref
        .watch(lineupRepositoryProvider)
        .fetch(key.teamId, key.eventId);
    _confirmed = lineup;
    return lineup;
  }

  /// Opnieuw laden; met data in beeld blijft die staan bij een fout.
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
      _apply(await _repository.fetch(key.teamId, key.eventId));
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// Zet speler [playerId] op plek [slotCode]. Komt hij van een andere plek
  /// en stond daar al iemand, dan ruilen ze; komt hij van de bank, dan gaat
  /// de zittende speler naar de bank.
  Future<Object?> place(String slotCode, int playerId) {
    final current = state.value;
    if (current == null) return Future.value();
    final player = current.player(playerId);
    if (player == null) return Future.value();
    final next = assignPlayer(current.assignments, slotCode, player);
    return _save(current, next, current.captainPlayerId);
  }

  /// Haalt de speler op [slotCode] van het veld.
  Future<Object?> remove(String slotCode) {
    final current = state.value;
    if (current == null) return Future.value();
    final next = {...current.assignments};
    if (!next.containsKey(slotCode) || next[slotCode] == null) {
      return Future.value();
    }
    next[slotCode] = null;
    return _save(current, next, current.captainPlayerId);
  }

  /// Geeft de C aan [playerId], of neemt hem af als die hem al heeft.
  Future<Object?> toggleCaptain(int playerId) {
    final current = state.value;
    if (current == null) return Future.value();
    final captain = current.captainPlayerId == playerId ? null : playerId;
    return _save(current, current.assignments, captain);
  }

  /// Wisselt naar formatie [formation].
  Future<Object?> changeFormation(String formation) async {
    final current = state.value;
    if (current == null || current.formation == formation) return null;
    return _write(
      () => _repository.changeFormation(key.teamId, key.eventId, formation),
    );
  }

  /// Deelt de opstelling met het team.
  Future<Object?> publish() async {
    final error = await _write(
      () => _repository.publish(key.teamId, key.eventId),
    );
    if (error == null) {
      // Het event-detail toont of er een gedeelde opstelling is.
      ref.invalidate(eventDetailControllerProvider(key));
    }
    return error;
  }

  /// Wacht tot de opslagrij leeg is en voert dan [request] uit.
  Future<Object?> _write(Future<Lineup> Function() request) async {
    await _tail;
    try {
      _apply(await request());
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  Future<Object?> _save(
    Lineup current,
    Map<String, LineupPlayer?> assignments,
    int? captain,
  ) {
    final next = withAssignments(current, assignments, captain);
    final seq = ++_seq;
    state = AsyncData(next);
    _pending++;
    final payload = [
      for (final entry in assignments.entries)
        if (entry.value != null)
          (slotCode: entry.key, playerId: entry.value!.id),
    ];

    Future<Object?> send() async {
      try {
        final saved = await _repository.save(
          key.teamId,
          key.eventId,
          slots: payload,
          captainPlayerId: next.captainPlayerId,
        );
        _confirmed = saved;
        if (ref.mounted && seq == _seq) state = AsyncData(saved);
        return null;
      } on Object catch (error) {
        final fallback = _confirmed;
        if (ref.mounted && seq == _seq && fallback != null) {
          state = AsyncData(fallback);
        }
        return error;
      } finally {
        _pending--;
      }
    }

    final result = _tail.then((_) => send());
    _tail = result.then((_) {});
    return result;
  }

  void _apply(Lineup lineup) {
    if (!ref.mounted) return;
    _confirmed = lineup;
    _seq++;
    state = AsyncData(lineup);
  }
}

/// [assignments] met [player] op [slotCode]; zie [LineupController.place].
Map<String, LineupPlayer?> assignPlayer(
  Map<String, LineupPlayer?> assignments,
  String slotCode,
  LineupPlayer player,
) {
  final next = {...assignments};
  if (!next.containsKey(slotCode)) return next;
  String? from;
  for (final entry in next.entries) {
    if (entry.value?.id == player.id) from = entry.key;
  }
  if (from == slotCode) return next;
  final sitting = next[slotCode];
  if (from != null) next[from] = null;
  next[slotCode] = player;
  if (from != null && sitting != null) next[from] = sitting;
  return next;
}

/// De lokale stand na een wijziging: dezelfde regels als de server, zodat het
/// veld en de deelbalk meteen kloppen. Een C die van het veld gaat, gaat mee;
/// een leeg veld trekt het delen in; anders is een gedeelde opstelling nu
/// "aangepast na het delen".
Lineup withAssignments(
  Lineup current,
  Map<String, LineupPlayer?> assignments,
  int? captain,
) {
  final slots = [
    for (final entry in assignments.entries)
      if (entry.value != null)
        LineupSlot(slotCode: entry.key, player: entry.value!),
  ];
  final onField = slots.any((slot) => slot.player.id == captain);
  final empty = slots.isEmpty;
  return current.copyWith(
    slots: slots,
    captainPlayerId: onField ? captain : null,
    publishedAt: empty ? null : current.publishedAt,
    changedSincePublish: !empty && current.isShared,
  );
}

/// De opstelling per `(teamId, eventId)`; weg zodra het scherm dicht is.
/// Geen automatische retry: het scherm toont een fout met "Opnieuw proberen".
final lineupControllerProvider = AsyncNotifierProvider.autoDispose
    .family<LineupController, Lineup, LineupKey>(
      LineupController.new,
      retry: (retryCount, error) => null,
    );
