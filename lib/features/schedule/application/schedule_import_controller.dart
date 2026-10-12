import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_exception.dart';
import '../../agenda/application/agenda_controller.dart';
import '../data/models/schedule_import_models.dart';
import '../data/schedule_repository.dart';

/// Hoe een importactie afliep.
sealed class ScheduleImportOutcome {
  const ScheduleImportOutcome();
}

/// Gelukt: [message] is de statusmelding van het web. Bij een proefimport
/// ([dryRun]) is er niets opgeslagen en blijft de sheet open.
final class ScheduleImportDone extends ScheduleImportOutcome {
  const ScheduleImportDone(this.message, {this.dryRun = false, this.result});

  final String message;
  final bool dryRun;
  final ScheduleImportResult? result;
}

/// Geweigerd of mislukt. [message] is de tekst van de server (veldfout van
/// het web, of `message` bij `409`/`429`/`403`); `null` → de UI kiest een
/// algemene melding bij [error].
final class ScheduleImportFailed extends ScheduleImportOutcome {
  const ScheduleImportFailed(this.error, this.message);

  final Object error;
  final String? message;
}

/// De vier wegen van `ImportEventsSheet.tsx`: bestand, ophalen bij de bond,
/// "Doe dat voor mij" en de agendalink. Na een geslaagde (echte) actie wordt
/// de agenda ververst.
class ScheduleImportController {
  ScheduleImportController(this._ref);

  final Ref _ref;

  ScheduleRepository get _repo => _ref.read(scheduleRepositoryProvider);

  /// Een bestand uploaden; met [dryRun] alleen tellen.
  Future<ScheduleImportOutcome> importFile(
    int teamId,
    ScheduleFile file, {
    bool dryRun = false,
  }) => _run(teamId, 'file', () async {
    final result = await _repo.importFile(teamId, file, dryRun: dryRun);
    return ScheduleImportDone(
      result.message,
      dryRun: result.dryRun || dryRun,
      result: result,
    );
  }, refresh: !dryRun);

  /// Het programma bij de bond laten ophalen (gaat in de wachtrij).
  Future<ScheduleImportOutcome> fetch(int teamId) => _run(
    teamId,
    'schedule',
    () async =>
        ScheduleImportDone((await _repo.fetchFromFederation(teamId)).message),
  );

  /// "Doe dat voor mij".
  Future<ScheduleImportOutcome> request(int teamId) => _run(
    teamId,
    'schedule',
    () async => ScheduleImportDone((await _repo.requestByHand(teamId)).message),
  );

  /// De agendalink zetten en ophalen.
  Future<ScheduleImportOutcome> setFeed(int teamId, String url) => _run(
    teamId,
    'schedule_feed_url',
    () async =>
        ScheduleImportDone((await _repo.setFeed(teamId, url.trim())).message),
  );

  Future<ScheduleImportOutcome> _run(
    int teamId,
    String field,
    Future<ScheduleImportDone> Function() action, {
    bool refresh = true,
  }) async {
    try {
      final done = await action();
      if (refresh) _refreshAgenda(teamId);
      return done;
    } on NetworkException catch (e) {
      return ScheduleImportFailed(e, null);
    } on ApiException catch (e) {
      // Een link waar niets uit kwam is wél opgeslagen (met de fout in de
      // agenda); verversen laat dat zien.
      if (e is ValidationException && field == 'schedule_feed_url') {
        _refreshAgenda(teamId);
      }
      return ScheduleImportFailed(e, e.fieldError(field) ?? e.message);
    } on Object catch (e) {
      return ScheduleImportFailed(e, null);
    }
  }

  void _refreshAgenda(int teamId) {
    // Stil op de achtergrond: een mislukte verversing hoort niet bij de import.
    unawaited(
      _ref
          .read(agendaControllerProvider(teamId).notifier)
          .refresh()
          .then((_) {}),
    );
  }
}

final scheduleImportControllerProvider = Provider<ScheduleImportController>(
  ScheduleImportController.new,
);
