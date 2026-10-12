import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_controller.dart';
import '../../event/application/event_detail_controller.dart';
import '../data/models/report_models.dart';
import '../data/report_repository.dart';

/// Welk verslag: team + wedstrijd.
typedef ReportKey = ({int teamId, int eventId});

/// Wat een scoutimport overneemt: per gekoppelde speler de cijfers, en
/// eventueel de setstanden (al thuis/uit zoals in het verslag).
typedef ScoutImport = ({Map<int, Map<String, int>> stats, List<SetScore> sets});

/// Het wedstrijdverslag van één wedstrijd.
///
/// Niet optimistisch: elke schrijfactie wacht op de server en neemt het
/// complete verslag uit het antwoord over. Mislukt het, dan blijft de stand
/// staan en krijgt de aanroeper de fout terug (`null` = gelukt).
///
/// Na een geslaagde stand-wijziging wordt het event-detail ververst (de
/// uitslag staat daar ook).
class ReportController extends AsyncNotifier<MatchReport> {
  ReportController(this.key);

  final ReportKey key;

  ReportRepository get _repository => ref.read(reportRepositoryProvider);

  @override
  Future<MatchReport> build() async {
    ref.watch(authControllerProvider);
    return ref.watch(reportRepositoryProvider).fetch(key.teamId, key.eventId);
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
    return _write(() => _repository.fetch(key.teamId, key.eventId));
  }

  /// De stand (doelpunten); `null` = leeg.
  Future<Object?> saveScore(int? home, int? away) => _write(
    () =>
        _repository.saveScore(key.teamId, key.eventId, home: home, away: away),
    touchesEvent: true,
  );

  /// Alle setstanden.
  Future<Object?> saveSets(List<SetScore> sets) => _write(
    () => _repository.saveSets(key.teamId, key.eventId, sets),
    touchesEvent: true,
  );

  /// De cijfers van één of meer spelers (per speler alle kolommen).
  Future<Object?> savePlayerStats(Map<int, Map<String, int>> stats) {
    final columns = state.value?.statColumns ?? const <String>[];
    return _write(
      () => _repository.savePlayerStats(
        key.teamId,
        key.eventId,
        statRows(columns, stats),
      ),
    );
  }

  /// Leest een scoutrapport (slaat niets op); gooit bij een fout.
  Future<ScoutPreview> previewScout({ScoutFile? file, String? text}) =>
      _repository.scoutPreview(key.teamId, key.eventId, file: file, text: text);

  /// Neemt een scoutimport over: eerst het blad, daarna de setstanden (op
  /// volgorde, zoals de PWA). Stopt bij de eerste fout.
  Future<Object?> applyScoutImport(ScoutImport import) async {
    if (import.stats.isNotEmpty) {
      final error = await savePlayerStats(import.stats);
      if (error != null) return error;
    }
    final report = state.value;
    if (import.sets.isNotEmpty && report != null && report.usesSets) {
      return saveSets(import.sets);
    }
    return null;
  }

  Future<Object?> _write(
    Future<MatchReport> Function() request, {
    bool touchesEvent = false,
  }) async {
    try {
      final report = await request();
      if (ref.mounted) state = AsyncData(report);
      if (touchesEvent && ref.mounted) {
        ref.invalidate(eventDetailControllerProvider(key));
      }
      return null;
    } on Object catch (error) {
      return error;
    }
  }
}

/// De `stats`-rijen voor `PATCH report/player-stats`: per speler elke kolom
/// uit [columns] (ontbrekend = 0), in vaste volgorde.
List<Map<String, int>> statRows(
  List<String> columns,
  Map<int, Map<String, int>> stats,
) => [
  for (final MapEntry(key: playerId, value: values) in stats.entries)
    {
      'player_id': playerId,
      for (final column in columns) column: values[column] ?? 0,
    },
];

/// Het verslag per `(teamId, eventId)`; weg zodra het scherm dicht is.
/// Geen automatische retry: het scherm toont een fout met "Opnieuw proberen".
final reportControllerProvider = AsyncNotifierProvider.autoDispose
    .family<ReportController, MatchReport, ReportKey>(
      ReportController.new,
      retry: (retryCount, error) => null,
    );

/// De vlaggersdienst van één wedstrijd (`null` = deze wedstrijd heeft er
/// geen). Niet optimistisch; na opslaan wordt het event-detail ververst.
class FlagDutyController extends AsyncNotifier<FlagDutyEdit?> {
  FlagDutyController(this.key);

  final ReportKey key;

  @override
  Future<FlagDutyEdit?> build() async {
    ref.watch(authControllerProvider);
    return ref
        .watch(reportRepositoryProvider)
        .fetchFlag(key.teamId, key.eventId);
  }

  /// Vervangt de beurten; geeft de fout terug (`null` = gelukt).
  Future<Object?> save(List<FlagShiftInput> shifts) async {
    try {
      final flag = await ref
          .read(reportRepositoryProvider)
          .saveFlag(key.teamId, key.eventId, shifts);
      if (!ref.mounted) return null;
      state = AsyncData(flag);
      ref.invalidate(eventDetailControllerProvider(key));
      return null;
    } on Object catch (error) {
      return error;
    }
  }
}

final flagDutyControllerProvider = AsyncNotifierProvider.autoDispose
    .family<FlagDutyController, FlagDutyEdit?, ReportKey>(
      FlagDutyController.new,
      retry: (retryCount, error) => null,
    );
