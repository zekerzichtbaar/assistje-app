import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../../event/application/event_detail_controller.dart';
import '../data/live_repository.dart';
import '../data/models/live_feed.dart';
import '../data/models/live_models.dart';

/// Welke wedstrijd: team + event.
typedef LiveKey = ({int teamId, int eventId});

/// Start een herhalende timer die elke [interval] [onTick] aanroept. Tests
/// zetten er een nep-versie in om polling zonder echte tijd te testen.
typedef LiveTicker = Timer Function(Duration interval, void Function() onTick);

/// Hoe vaak de live-stand ververst zolang de wedstrijd loopt (PWA: 12 s).
const Duration livePollInterval = Duration(seconds: 12);

/// De timer achter de polling; standaard [Timer.periodic].
final liveTickerProvider = Provider<LiveTicker>(
  (ref) =>
      (interval, onTick) => Timer.periodic(interval, (_) => onTick()),
);

/// De live-stand van één wedstrijd.
///
/// - Pollt elke [livePollInterval] zolang `event.live.is_live` en het scherm
///   actief is ([setActive]; de app op de achtergrond zet hem uit). Stopt
///   zodra de provider weg is (scherm dicht).
/// - Elke schrijfactie zet de live-stand uit het antwoord meteen neer (geen
///   extra GET). Een fout laat de vorige stand staan; de actie geeft de fout
///   terug (of `null` als het lukte) en het scherm toont een toast.
/// - Volgen en reageren zijn optimistisch en draaien terug bij een fout.
class LiveController extends AsyncNotifier<LiveMatch> {
  LiveController(this.key);

  final LiveKey key;

  Timer? _timer;
  bool _active = true;
  bool _polling = false;

  /// Lopende schrijfacties; een poll die tijdens een schrijfactie start of
  /// terugkomt, wordt weggegooid (hij kan ouder zijn dan het antwoord).
  int _writes = 0;
  int _writeSeq = 0;

  LiveRepository get _repository => ref.read(liveRepositoryProvider);

  int get _teamId => key.teamId;
  int get _eventId => key.eventId;

  /// Loopt de poll-timer nu?
  bool get isPolling => _timer != null;

  @override
  Future<LiveMatch> build() async {
    ref.watch(authControllerProvider);
    ref.onDispose(_stopTimer);
    final match = await ref
        .watch(liveRepositoryProvider)
        .fetch(_teamId, _eventId);
    _syncPolling(match);
    return match;
  }

  /// Het scherm is zichtbaar ([active]) of niet (app op de achtergrond,
  /// scherm weg). Terug zichtbaar tijdens een live wedstrijd: meteen
  /// verversen en weer pollen.
  void setActive(bool active) {
    if (_active == active) return;
    _active = active;
    if (!ref.mounted) {
      _stopTimer();
      return;
    }
    final match = state.value;
    _syncPolling(match);
    if (active && match != null && match.clock.isLive) unawaited(poll());
  }

  /// Eén poll: de verse stand, of bij een fout de vorige laten staan.
  Future<void> poll() async {
    if (_polling || _writes > 0) return;
    _polling = true;
    final seq = _writeSeq;
    try {
      final match = await _repository.fetch(_teamId, _eventId);
      if (seq == _writeSeq && _writes == 0) _apply(match);
    } on Object {
      // Stil: de volgende poll probeert het opnieuw.
    } finally {
      _polling = false;
    }
  }

  /// Opnieuw laden (trek-om-te-verversen of "Opnieuw proberen"); met data
  /// in beeld blijft die staan bij een fout.
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
      _apply(await _repository.fetch(_teamId, _eventId));
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  // ── Meeleven ────────────────────────────────────────────────────────────

  /// Live-pushes volgen of niet meer volgen (optimistisch).
  Future<Object?> toggleFollow() async {
    final current = state.value;
    if (current == null) return null;
    final follow = !current.followingLive;
    _set(current.copyWith(followingLive: follow));
    try {
      if (follow) {
        final following = await _repository.follow(_teamId, _eventId);
        final now = state.value;
        if (now != null) _set(now.copyWith(followingLive: following));
      } else {
        await _repository.unfollow(_teamId, _eventId);
      }
      return null;
    } on Object catch (error) {
      final now = state.value;
      if (now != null) _set(now.copyWith(followingLive: !follow));
      return error;
    }
  }

  /// Een duimpje [emoji] onder [itemKey] aan of uit (optimistisch); de
  /// verse telling van de server vervangt de lokale.
  Future<Object?> toggleReaction(String itemKey, String emoji) async {
    final current = state.value;
    if (current == null) return null;
    final before = current.reactions;
    _set(
      current.copyWith(
        reactions: applyReactionToggle(
          before,
          itemKey,
          emoji,
          current.reactionEmoji,
        ),
      ),
    );
    try {
      final reactions = await _repository.react(
        _teamId,
        _eventId,
        itemKey: itemKey,
        emoji: emoji,
      );
      final now = state.value;
      if (now != null) _set(now.copyWith(reactions: reactions));
      return null;
    } on Object catch (error) {
      final now = state.value;
      if (now != null) _set(now.copyWith(reactions: before));
      return error;
    }
  }

  // ── Klok ────────────────────────────────────────────────────────────────

  Future<Object?> start({int minute = 0}) => _write(
    () => _repository.start(
      _teamId,
      _eventId,
      minute: minute > 0 ? minute : null,
    ),
  );

  Future<Object?> pause({int? minute, bool trim = false}) => _write(
    () => _repository.pause(_teamId, _eventId, minute: minute, trim: trim),
  );

  Future<Object?> resume() =>
      _write(() => _repository.resume(_teamId, _eventId));

  Future<Object?> nextPeriod({int? minute, bool trim = false}) => _write(
    () => _repository.next(_teamId, _eventId, minute: minute, trim: trim),
  );

  Future<Object?> stop() => _write(() => _repository.stop(_teamId, _eventId));

  Future<Object?> reopen() =>
      _write(() => _repository.reopen(_teamId, _eventId));

  Future<Object?> setDuration(int minutes) =>
      _write(() => _repository.duration(_teamId, _eventId, minutes));

  Future<Object?> reset() => _write(() => _repository.reset(_teamId, _eventId));

  // ── Tijdlijn ────────────────────────────────────────────────────────────

  Future<Object?> addGoal({
    required int minute,
    required int playerId,
    bool ownGoal = false,
    int? assistPlayerId,
    bool penalty = false,
  }) => _write(
    () => _repository.addGoal(
      _teamId,
      _eventId,
      minute: minute,
      playerId: playerId,
      ownGoal: ownGoal,
      assistPlayerId: assistPlayerId,
      penalty: penalty,
    ),
  );

  Future<Object?> addOpponentGoal({required int minute}) => _write(
    () => _repository.addOpponentGoal(_teamId, _eventId, minute: minute),
  );

  Future<Object?> deleteLastOpponentGoal() =>
      _write(() => _repository.deleteLastOpponentGoal(_teamId, _eventId));

  Future<Object?> addCard({
    required int minute,
    required String type,
    required int playerId,
  }) => _write(
    () => _repository.addCard(
      _teamId,
      _eventId,
      minute: minute,
      type: type,
      playerId: playerId,
    ),
  );

  Future<Object?> addMoment({
    required int minute,
    required String type,
    int? playerId,
  }) => _write(
    () => _repository.addMoment(
      _teamId,
      _eventId,
      minute: minute,
      type: type,
      playerId: playerId,
    ),
  );

  Future<Object?> addSub({
    required int minute,
    required int offPlayerId,
    required int onPlayerId,
  }) => _write(
    () => _repository.addSub(
      _teamId,
      _eventId,
      minute: minute,
      offPlayerId: offPlayerId,
      onPlayerId: onPlayerId,
    ),
  );

  /// Verwijdert regel [item] uit de tijdlijn (doelpunt, wissel, kaart of
  /// moment).
  Future<Object?> deleteItem(LiveFeedItem item) => _write(
    () => switch (item.kind) {
      LiveFeedKind.goal => _repository.deleteGoal(_teamId, _eventId, item.id),
      LiveFeedKind.sub => _repository.deleteSub(_teamId, _eventId, item.id),
      LiveFeedKind.card => _repository.deleteCard(_teamId, _eventId, item.id),
      LiveFeedKind.moment => _repository.deleteMoment(
        _teamId,
        _eventId,
        item.id,
      ),
    },
  );

  // ── Intern ──────────────────────────────────────────────────────────────

  Future<Object?> _write(Future<LiveMatch> Function() request) async {
    _writes++;
    _writeSeq++;
    try {
      _apply(await request());
      // Het event-detail toont stand en live-badge; ververs het als het open
      // staat.
      if (ref.mounted) ref.invalidate(eventDetailControllerProvider(key));
      return null;
    } on Object catch (error) {
      return error;
    } finally {
      _writes--;
    }
  }

  void _apply(LiveMatch match) {
    if (!ref.mounted) return;
    state = AsyncData(match);
    _syncPolling(match);
  }

  void _set(LiveMatch match) {
    if (!ref.mounted) return;
    state = AsyncData(match);
  }

  /// Timer aan zolang de wedstrijd live is en het scherm actief; anders uit.
  void _syncPolling(LiveMatch? match) {
    final shouldPoll = _active && match != null && match.clock.isLive;
    if (shouldPoll && _timer == null) {
      _timer = ref.read(liveTickerProvider)(livePollInterval, _tick);
    } else if (!shouldPoll) {
      _stopTimer();
    }
  }

  void _tick() {
    if (!ref.mounted) {
      _stopTimer();
      return;
    }
    unawaited(poll());
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}

/// De live-stand per `(teamId, eventId)`; weg (en polling uit) zodra het
/// scherm dicht is. Geen automatische retry: het scherm toont een fout met
/// "Opnieuw proberen".
final liveControllerProvider = AsyncNotifierProvider.autoDispose
    .family<LiveController, LiveMatch, LiveKey>(
      LiveController.new,
      retry: (retryCount, error) => null,
    );
