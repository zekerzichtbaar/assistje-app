import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../../agenda/application/agenda_controller.dart';
import '../../event/application/event_detail_controller.dart';
import '../data/models/schedule_models.dart';
import '../data/schedule_repository.dart';

/// Uitkomst van een schrijfactie: het resultaat, of de fout.
typedef ScheduleOutcome = ({ScheduleWriteResult? result, Object? error});

/// Alle schrijfacties op de agenda van de trainer, plus het verversen van
/// wat ervan afhangt: de agenda van het team, het event-detail en de
/// formuliervelden van dat event.
class ScheduleWriter {
  const ScheduleWriter(this._ref);

  final Ref _ref;

  ScheduleRepository get _repository => _ref.read(scheduleRepositoryProvider);

  /// Een event (of wekelijkse reeks) aanmaken.
  Future<ScheduleOutcome> create(int teamId, ScheduleDraft draft) =>
      _run(teamId, null, () => _repository.create(teamId, draft));

  /// Een event wijzigen.
  Future<ScheduleOutcome> update(
    int teamId,
    int eventId,
    ScheduleDraft draft,
  ) => _run(teamId, eventId, () => _repository.update(teamId, eventId, draft));

  /// Afgelasten.
  Future<ScheduleOutcome> cancel(int teamId, int eventId) =>
      _run(teamId, eventId, () => _repository.cancel(teamId, eventId));

  /// Afgelasting intrekken.
  Future<ScheduleOutcome> uncancel(int teamId, int eventId) =>
      _run(teamId, eventId, () => _repository.uncancel(teamId, eventId));

  /// Verwijderen. Geeft de fout terug, of `null`. Het detail wordt bewust
  /// niet ververst (dat zou een 404 geven); het scherm gaat terug naar de
  /// agenda.
  Future<Object?> delete(int teamId, int eventId) async {
    try {
      await _repository.delete(teamId, eventId);
    } on Object catch (error) {
      return error;
    }
    _ref.invalidate(agendaControllerProvider(teamId));
    return null;
  }

  Future<ScheduleOutcome> _run(
    int teamId,
    int? eventId,
    Future<ScheduleWriteResult> Function() request,
  ) async {
    final ScheduleWriteResult result;
    try {
      result = await request();
    } on Object catch (error) {
      return (result: null, error: error);
    }
    _ref.invalidate(agendaControllerProvider(teamId));
    if (eventId != null) {
      final EventKey key = (teamId: teamId, eventId: eventId);
      _ref
        ..invalidate(eventDetailControllerProvider(key))
        ..invalidate(scheduleEventProvider(key));
    }
    return (result: result, error: null);
  }
}

final scheduleWriterProvider = Provider<ScheduleWriter>(ScheduleWriter.new);

/// De formuliervelden van één event (bewerken; en of het met de hand
/// afgelast mag worden). Alleen voor de trainer opgehaald.
final scheduleEventProvider = FutureProvider.autoDispose
    .family<ScheduleEvent, EventKey>((ref, key) {
      ref.watch(authControllerProvider);
      return ref
          .watch(scheduleRepositoryProvider)
          .fetchEvent(key.teamId, key.eventId);
    }, retry: (retryCount, error) => null);

/// Sleutel van het formulier: team, en het event bij bewerken.
typedef ScheduleFormKey = ({int teamId, int? eventId});

/// Wat het formulier nodig heeft: de opties, en bij bewerken het event.
class ScheduleFormData {
  const ScheduleFormData({required this.options, this.event});

  final ScheduleOptions options;
  final ScheduleEvent? event;

  bool get isEdit => event != null;
}

/// Het event-formulier: laadt de opties (en het event bij bewerken) en
/// bewaart via [ScheduleWriter].
class ScheduleFormController extends AsyncNotifier<ScheduleFormData> {
  ScheduleFormController(this.key);

  final ScheduleFormKey key;

  @override
  Future<ScheduleFormData> build() async {
    ref.watch(authControllerProvider);
    final repository = ref.watch(scheduleRepositoryProvider);
    final eventId = key.eventId;
    final results = await Future.wait<Object>([
      repository.options(key.teamId),
      if (eventId != null) repository.fetchEvent(key.teamId, eventId),
    ]);
    return ScheduleFormData(
      options: results.first as ScheduleOptions,
      event: results.length > 1 ? results[1] as ScheduleEvent : null,
    );
  }

  /// Opnieuw laden na een fout.
  void retry() => ref.invalidateSelf();

  /// Aanmaken of (bij bewerken) wijzigen.
  Future<ScheduleOutcome> save(ScheduleDraft draft) {
    final writer = ref.read(scheduleWriterProvider);
    final eventId = state.value?.event?.id ?? key.eventId;
    return eventId == null
        ? writer.create(key.teamId, draft)
        : writer.update(key.teamId, eventId, draft);
  }
}

/// Het formulier per team en event; weg zodra het scherm dicht is.
final scheduleFormControllerProvider = AsyncNotifierProvider.autoDispose
    .family<ScheduleFormController, ScheduleFormData, ScheduleFormKey>(
      ScheduleFormController.new,
      retry: (retryCount, error) => null,
    );
