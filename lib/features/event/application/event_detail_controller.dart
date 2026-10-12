import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/auth/auth_controller.dart';
import '../../agenda/application/agenda_controller.dart';
import '../../agenda/data/agenda_repository.dart';
import '../../agenda/data/models/agenda_models.dart';
import '../../duties/application/duties_controller.dart';
import '../../duties/data/duties_repository.dart';
import '../data/event_repository.dart';
import '../data/models/event_detail_models.dart';

/// Sleutel van één event-detail: team + event.
typedef EventKey = ({int teamId, int eventId});

/// De optimistische stand van [event] na jouw antwoord [status] (met
/// [reason] bij afwezig/kijken): je knop, je eigen rij en de tellers, zoals
/// de server het straks terugrekent. Een gast of toeschouwer telt niet mee
/// in de breuk; staf alleen in de breuk, niet bij de spelers.
EventDetail applyOwnRsvpToDetail(
  EventDetail event,
  AttendanceStatus status, {
  String? reason,
}) {
  final previous = event.myStatus;
  final me = event.me;
  final inFraction =
      me != null &&
      !me.isGuest &&
      (me.kind == EventPlayerKind.player || me.kind == EventPlayerKind.staff);
  final inPlayers = inFraction && me.kind == EventPlayerKind.player;
  final keptReason = status.needsReason ? reason : null;
  return event.copyWith(
    myStatus: status,
    myReason: keptReason,
    counts: inFraction ? event.counts.shift(previous, status) : event.counts,
    playerCounts: inPlayers
        ? event.playerCounts.shift(previous, status)
        : event.playerCounts,
    players: [
      for (final p in event.players)
        p.isMe ? p.copyWith(status: status, reason: keptReason) : p,
    ],
  );
}

/// Eén event-detail: laden, verversen, je eigen RSVP, MOTM-stem en carpool.
/// Schrijfacties werken optimistisch en draaien terug bij een fout.
class EventDetailController extends AsyncNotifier<EventDetail> {
  EventDetailController(this.key);

  final EventKey key;

  int get teamId => key.teamId;
  int get eventId => key.eventId;

  EventRepository get _repository => ref.read(eventRepositoryProvider);

  @override
  Future<EventDetail> build() async {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een vers detail.
    ref.watch(authControllerProvider);
    return ref.watch(eventRepositoryProvider).fetch(teamId, eventId);
  }

  /// Opnieuw laden. Met data in beeld blijft die staan bij een fout; de
  /// fout komt terug zodat het scherm hem kan melden.
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

  /// Wat er nu in beeld is; `null` als het scherm (en dus deze provider) al
  /// weg is.
  EventDetail? get _current => ref.mounted ? state.value : null;

  void _set(EventDetail event) {
    if (ref.mounted) state = AsyncData(event);
  }

  /// Je eigen antwoord na een tik op [option] (nogmaals op je eigen antwoord
  /// = terug naar openstaand).
  ///
  /// [askReasonFirst]: het team heeft `absence_reason` aan, dus bij afwezig
  /// of kijken eerst een reden vragen (zonder iets te versturen).
  Future<RsvpOutcome> rsvp(
    AttendanceStatus option, {
    String? reason,
    bool askReasonFirst = false,
  }) async {
    final before = state.value;
    if (before == null) return const RsvpFailed(NotFoundException());
    if (!before.canRsvp || !before.canChange || before.isCancelled) {
      return const RsvpFailed(ForbiddenException());
    }

    final status = nextRsvpStatus(option, before.myStatus);
    if (askReasonFirst && reason == null && status.needsReason) {
      return RsvpNeedsReason(option, status);
    }

    _set(applyOwnRsvpToDetail(before, status, reason: reason));
    try {
      await ref
          .read(agendaRepositoryProvider)
          .setAttendance(
            teamId,
            eventId,
            status,
            reason: status.needsReason ? reason : null,
          );
    } on ValidationException catch (error) {
      _set(before);
      final reasonError = error.fieldError('reason');
      if (reasonError != null && status.needsReason) {
        return RsvpNeedsReason(option, status, message: reasonError);
      }
      return RsvpFailed(error);
    } on Object catch (error) {
      _set(before);
      return RsvpFailed(error);
    }

    // De agenda laat dit antwoord ook meteen zien, en het detail haalt de
    // echte tellers op (stil: lukt dat niet, dan blijft de optimistische stand).
    if (ref.mounted) {
      ref.invalidate(agendaControllerProvider(teamId));
      unawaited(refresh());
    }
    return RsvpSaved(status);
  }

  /// Stem op [playerId]. Geeft de fout terug als het mislukt.
  Future<Object?> voteMotm(int playerId) => _motm(playerId);

  /// Je stem intrekken. Geeft de fout terug als het mislukt.
  Future<Object?> unvoteMotm() => _motm(null);

  Future<Object?> _motm(int? playerId) async {
    final before = state.value;
    final motm = before?.motm;
    if (before == null || motm == null) return const NotFoundException();
    _set(before.copyWith(motm: motm.copyWith(myVote: playerId)));
    try {
      if (playerId == null) {
        await _repository.unvoteMotm(teamId, eventId);
      } else {
        final result = await _repository.voteMotm(teamId, eventId, playerId);
        final latest = _current ?? before;
        _set(
          latest.copyWith(
            motm: (latest.motm ?? motm).copyWith(
              myVote: result.myVote,
              isOpen: result.isOpen,
              closesAt: result.closesAt,
            ),
          ),
        );
      }
      return null;
    } on Object catch (error) {
      final latest = _current ?? before;
      _set(
        latest.copyWith(
          motm: (latest.motm ?? motm).copyWith(myVote: motm.myVote),
        ),
      );
      return error;
    }
  }

  /// Trainer: dienst [row] bij deze wedstrijd toewijzen aan optie [key]
  /// (`p_12`/`u_3` of `g_4`), of vrijmaken met `null`. Bij `multi` zet elke
  /// aanroep één persoon aan óf uit. Niet optimistisch: na succes wordt het
  /// detail stil opnieuw opgehaald. Geeft de fout terug als het mislukt.
  Future<Object?> assignDuty(EventDuty row, String? key) async {
    try {
      await ref
          .read(dutiesRepositoryProvider)
          .assignEventDuty(
            teamId,
            eventId,
            row.dutyTypeId,
            group: row.isGroup,
            memberKey: row.isGroup ? null : key,
            groupId: row.isGroup && key != null
                ? int.tryParse(key.replaceFirst('g_', ''))
                : null,
          );
    } on Object catch (error) {
      return error;
    }
    if (ref.mounted) {
      // Het dienstenoverzicht van de trainer klopt nu ook niet meer.
      ref.invalidate(dutiesControllerProvider(teamId));
      await refresh();
    }
    return null;
  }

  /// Aanmelden om te rijden (of je aanmelding bijwerken).
  Future<Object?> saveCarpool(CarpoolMode mode, {int? seats}) async {
    try {
      final offer = await _repository.saveCarpool(
        teamId,
        eventId,
        mode: mode,
        seats: seats,
      );
      final latest = _current;
      if (latest != null) {
        final offers = latest.carpoolOffers ?? const <CarpoolOffer>[];
        final mine = offer.copyWith(isSelf: true);
        final exists = offers.any((o) => o.isSelf || o.id == offer.id);
        _set(
          latest.copyWith(
            carpoolOffers: exists
                ? [
                    for (final o in offers)
                      o.isSelf || o.id == offer.id ? mine : o,
                  ]
                : [...offers, mine],
          ),
        );
      }
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// Je rit-aanmelding weghalen.
  Future<Object?> removeCarpool() async {
    final before = state.value;
    if (before == null) return const NotFoundException();
    final offers = before.carpoolOffers;
    if (offers != null) {
      _set(
        before.copyWith(
          carpoolOffers: [
            for (final o in offers)
              if (!o.isSelf) o,
          ],
        ),
      );
    }
    try {
      await _repository.removeCarpool(teamId, eventId);
      return null;
    } on Object catch (error) {
      final latest = _current ?? before;
      _set(latest.copyWith(carpoolOffers: offers));
      return error;
    }
  }
}

/// Het event-detail per `(teamId, eventId)`; weg zodra het scherm dicht is,
/// zodat je bij terugkomen verse data ziet. Geen automatische retry: het
/// scherm toont een fout met "Opnieuw proberen".
final eventDetailControllerProvider = AsyncNotifierProvider.autoDispose
    .family<EventDetailController, EventDetail, EventKey>(
      EventDetailController.new,
      retry: (retryCount, error) => null,
    );
