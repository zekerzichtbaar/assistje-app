import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/auth/auth_controller.dart';
import '../data/agenda_repository.dart';
import '../data/models/agenda_models.dart';

/// Wat de agenda van één team op dit moment weet.
class AgendaState {
  const AgendaState({
    required this.data,
    required this.meta,
    this.limit = AgendaRepository.pageSize,
    this.loadingMore = false,
  });

  final AgendaData data;
  final AgendaMeta meta;

  /// Het venster dat de server nu per tabblad stuurt (`?limit=`).
  final int limit;

  /// Loopt er een ronde "Nog 30 tonen" bij de server?
  final bool loadingMore;

  AgendaState copyWith({
    AgendaData? data,
    AgendaMeta? meta,
    int? limit,
    bool? loadingMore,
  }) => AgendaState(
    data: data ?? this.data,
    meta: meta ?? this.meta,
    limit: limit ?? this.limit,
    loadingMore: loadingMore ?? this.loadingMore,
  );

  /// Hoeveel events er in totaal in Aankomend/Verleden staan.
  int get upcomingTotal => meta.upcomingTotal < data.upcoming.length
      ? data.upcoming.length
      : meta.upcomingTotal;
  int get pastTotal =>
      meta.pastTotal < data.past.length ? data.past.length : meta.pastTotal;
}

/// Uitkomst van een RSVP-tik.
sealed class RsvpOutcome {
  const RsvpOutcome();
}

/// Opgeslagen (de optimistische stand blijft staan).
final class RsvpSaved extends RsvpOutcome {
  const RsvpSaved(this.status);

  final AttendanceStatus status;
}

/// Er hoort eerst een reden bij (team-feature `absence_reason`, of de
/// server zei `422` met `errors.reason`). Vraag hem en probeer opnieuw met
/// [option] + reden.
final class RsvpNeedsReason extends RsvpOutcome {
  const RsvpNeedsReason(this.option, this.status, {this.message});

  /// De knop waarop getikt is.
  final AttendanceStatus option;

  /// Het antwoord dat het wordt (`absent` of `nonplay`).
  final AttendanceStatus status;
  final String? message;
}

/// Mislukt; de stand is teruggedraaid.
final class RsvpFailed extends RsvpOutcome {
  const RsvpFailed(this.error);

  final Object error;

  /// Laravels `message`, als die er was (bv. "De aanvang is geweest.").
  String? get message => switch (error) {
    final ApiException e => e.message,
    _ => null,
  };
}

/// Nogmaals op je eigen antwoord tikken haalt het weg: terug naar openstaand.
AttendanceStatus nextRsvpStatus(
  AttendanceStatus option,
  AttendanceStatus? current,
) => option == current ? AttendanceStatus.pending : option;

/// De optimistische stand van [event] na jouw antwoord [status], met de
/// tellers verschoven zoals de server het straks terugrekent (zie `Row` in
/// de PWA): een gast verschuift de gast-teller, een speler de breuk én de
/// spelers-telling, staf alleen de breuk, een toeschouwer (`me == null`)
/// niets.
AgendaEvent applyOwnRsvp(
  AgendaEvent event,
  AttendanceStatus status,
  AgendaMe? me,
) {
  final previous = event.myStatus;
  final isGuest = me?.isGuest ?? false;
  final isPlayer = me != null && !isGuest;
  return event.copyWith(
    myStatus: status,
    counts: isPlayer ? event.counts.shift(previous, status) : event.counts,
    playerCounts: isPlayer && !me.isStaff
        ? event.effectivePlayerCounts.shift(previous, status)
        : event.playerCounts,
    guestCounts: isGuest
        ? event.guestCounts.shift(previous, status)
        : event.guestCounts,
  );
}

/// De agenda van team [teamId]: laden, verversen, bijladen en je eigen RSVP
/// (optimistisch, met terugdraaien bij een fout).
class AgendaController extends AsyncNotifier<AgendaState> {
  AgendaController(this.teamId);

  final int teamId;

  AgendaRepository get _repository => ref.read(agendaRepositoryProvider);

  @override
  Future<AgendaState> build() async {
    // Een andere gebruiker (uit- en weer inloggen) krijgt een verse agenda.
    ref.watch(authControllerProvider);
    final page = await ref.watch(agendaRepositoryProvider).fetch(teamId);
    return AgendaState(data: page.data, meta: page.meta);
  }

  /// Opnieuw laden met het huidige venster. Met data in beeld blijft die
  /// staan bij een fout; de fout komt terug zodat het scherm hem kan melden.
  Future<Object?> refresh() async {
    final current = state.value;
    if (current == null) {
      ref.invalidateSelf();
      try {
        await future;
        return null;
      } on Object catch (error) {
        return error;
      }
    }
    try {
      final page = await _repository.fetch(teamId, limit: current.limit);
      final latest = state.value ?? current;
      state = AsyncData(latest.copyWith(data: page.data, meta: page.meta));
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// Vraagt de server om [AgendaRepository.pageSize] events meer per
  /// tabblad. Geeft de fout terug als het mislukt.
  Future<Object?> loadMore() async {
    final current = state.value;
    if (current == null || current.loadingMore) return null;
    final limit = current.limit + AgendaRepository.pageSize;
    state = AsyncData(current.copyWith(loadingMore: true));
    try {
      final page = await _repository.fetch(teamId, limit: limit);
      state = AsyncData(
        (state.value ?? current).copyWith(
          data: page.data,
          meta: page.meta,
          limit: limit,
          loadingMore: false,
        ),
      );
      return null;
    } on Object catch (error) {
      final latest = state.value;
      if (latest != null) {
        state = AsyncData(latest.copyWith(loadingMore: false));
      }
      return error;
    }
  }

  /// Je eigen antwoord op event [eventId] na een tik op [option].
  ///
  /// [askReasonFirst]: het team heeft `absence_reason` aan, dus bij afwezig
  /// of kijken eerst een reden vragen (zonder iets te versturen).
  Future<RsvpOutcome> rsvp(
    int eventId,
    AttendanceStatus option, {
    String? reason,
    bool askReasonFirst = false,
  }) async {
    final current = state.value;
    final before = current == null ? null : _find(current.data, eventId);
    if (current == null || before == null) {
      return const RsvpFailed(NotFoundException());
    }

    final status = nextRsvpStatus(option, before.myStatus);
    if (askReasonFirst && reason == null && status.needsReason) {
      return RsvpNeedsReason(option, status);
    }

    _replace(applyOwnRsvp(before, status, current.data.me));
    try {
      await _repository.setAttendance(
        teamId,
        eventId,
        status,
        reason: status.needsReason ? reason : null,
      );
      return RsvpSaved(status);
    } on ValidationException catch (error) {
      _replace(before);
      final reasonError = error.fieldError('reason');
      if (reasonError != null && status.needsReason) {
        return RsvpNeedsReason(option, status, message: reasonError);
      }
      return RsvpFailed(error);
    } on Object catch (error) {
      _replace(before);
      return RsvpFailed(error);
    }
  }

  static AgendaEvent? _find(AgendaData data, int eventId) {
    for (final e in data.upcoming) {
      if (e.id == eventId) return e;
    }
    for (final e in data.past) {
      if (e.id == eventId) return e;
    }
    return null;
  }

  void _replace(AgendaEvent event) {
    final current = state.value;
    if (current == null) return;
    List<AgendaEvent> swap(List<AgendaEvent> list) => [
      for (final e in list) e.id == event.id ? event : e,
    ];
    state = AsyncData(
      current.copyWith(
        data: current.data.copyWith(
          upcoming: swap(current.data.upcoming),
          past: swap(current.data.past),
        ),
      ),
    );
  }
}

/// De agenda per team-id. Geen automatische retry: het scherm toont een fout
/// met "Opnieuw proberen".
final agendaControllerProvider =
    AsyncNotifierProvider.family<AgendaController, AgendaState, int>(
      AgendaController.new,
      retry: (retryCount, error) => null,
    );
