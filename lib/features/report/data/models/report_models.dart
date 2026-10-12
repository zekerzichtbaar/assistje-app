import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../event/data/models/event_detail_models.dart' show FlagShift;

part 'report_models.freezed.dart';
part 'report_models.g.dart';

/// De wedstrijd waar het verslag bij hoort (`event`).
@freezed
abstract class ReportEvent with _$ReportEvent {
  const factory ReportEvent({
    required int id,
    @Default('') String title,
    String? startsAt,
    String? homeTeam,
    String? awayTeam,

    /// Spelen wij thuis? Bepaalt of thuis/uit van een scoutrapport om moeten.
    @Default(true) bool weAreHome,
  }) = _ReportEvent;

  factory ReportEvent.fromJson(Map<String, dynamic> json) =>
      _$ReportEventFromJson(json);
}

/// Een speler uit `lineup[].player` of `bench[]`.
@freezed
abstract class ReportPlayer with _$ReportPlayer {
  const factory ReportPlayer({
    required int id,
    int? shirtNumber,
    @Default('') String name,
    @Default('') String position,
    @Default(false) bool isGuest,
  }) = _ReportPlayer;

  factory ReportPlayer.fromJson(Map<String, dynamic> json) =>
      _$ReportPlayerFromJson(json);
}

/// Een plek in de opstelling (`lineup[]`).
@freezed
abstract class ReportLineupRow with _$ReportLineupRow {
  const factory ReportLineupRow({
    @Default('') String slotCode,
    required ReportPlayer player,
  }) = _ReportLineupRow;

  factory ReportLineupRow.fromJson(Map<String, dynamic> json) =>
      _$ReportLineupRowFromJson(json);
}

/// Een gespeelde set (`sets[]`).
@freezed
abstract class ReportSet with _$ReportSet {
  const factory ReportSet({
    @Default(0) int setNumber,
    @Default(0) int homePoints,
    @Default(0) int awayPoints,
  }) = _ReportSet;

  factory ReportSet.fromJson(Map<String, dynamic> json) =>
      _$ReportSetFromJson(json);
}

/// Het wedstrijdverslag (`GET …/report`). Het scoremodel en de kolommen van
/// het statistiekenblad komen uit het sportprofiel — de app kent de sport
/// niet.
@freezed
abstract class MatchReport with _$MatchReport {
  const factory MatchReport({
    required ReportEvent event,

    /// `goals` (stand via `report/score`) of `sets` (via `report/sets`).
    @Default('goals') String scoreModel,
    int? homeScore,
    int? awayScore,
    int? maxSets,
    @Default(<ReportSet>[]) List<ReportSet> sets,

    /// `postmatch` = statistiekenblad na afloop; anders geen blad.
    @Default('') String statsMode,
    @Default(<String>[]) List<String> statColumns,
    @Default(false) bool canImport,
    @Default(<ReportLineupRow>[]) List<ReportLineupRow> lineup,
    @Default(<ReportPlayer>[]) List<ReportPlayer> bench,

    /// Ruwe regels: `player_id` plus één sleutel per kolom.
    @Default(<Map<String, dynamic>>[]) List<Map<String, dynamic>> playerStats,
  }) = _MatchReport;

  const MatchReport._();

  factory MatchReport.fromJson(Map<String, dynamic> json) =>
      _$MatchReportFromJson(json);

  bool get usesSets => scoreModel == 'sets';

  /// Het statistiekenblad: alleen bij `postmatch` met kolommen.
  bool get hasStatsSheet => statsMode == 'postmatch' && statColumns.isNotEmpty;

  /// Wie op het blad staat: eerst de opstelling, dan de rest (zonder
  /// dubbelen), zoals de PWA.
  List<ReportPlayer> get players {
    final seen = <int>{};
    return [
      for (final row in lineup)
        if (seen.add(row.player.id)) row.player,
      for (final player in bench)
        if (seen.add(player.id)) player,
    ];
  }

  /// De cijfers van [playerId] per kolom (ontbrekend = 0).
  Map<String, int> statsFor(int playerId) {
    final row = playerStats.firstWhere(
      (r) => _asInt(r['player_id']) == playerId,
      orElse: () => const {},
    );
    return {for (final column in statColumns) column: _asInt(row[column])};
  }
}

/// Een gelezen set uit het scoutrapport (`sets[]`, thuis/uit van het
/// rapport).
@freezed
abstract class ScoutSet with _$ScoutSet {
  const factory ScoutSet({@Default(0) int home, @Default(0) int away}) =
      _ScoutSet;

  factory ScoutSet.fromJson(Map<String, dynamic> json) =>
      _$ScoutSetFromJson(json);
}

/// Een regel uit een ploeg van het scoutrapport.
@freezed
abstract class ScoutRow with _$ScoutRow {
  const factory ScoutRow({
    int? shirtNumber,
    @Default('') String name,
    @Default(<String, dynamic>{}) Map<String, dynamic> stats,

    /// De gekoppelde speler, of `null`.
    int? playerId,

    /// `shirt_number`, `name` of `null`.
    String? matchedOn,
  }) = _ScoutRow;

  const ScoutRow._();

  factory ScoutRow.fromJson(Map<String, dynamic> json) =>
      _$ScoutRowFromJson(json);

  int stat(String column) => _asInt(stats[column]);
}

/// Een ploeg uit het scoutrapport.
@freezed
abstract class ScoutTeam with _$ScoutTeam {
  const factory ScoutTeam({
    @Default('') String name,
    @Default(<ScoutRow>[]) List<ScoutRow> players,
  }) = _ScoutTeam;

  factory ScoutTeam.fromJson(Map<String, dynamic> json) =>
      _$ScoutTeamFromJson(json);
}

/// Iemand uit de selectie, om met de hand te koppelen.
@freezed
abstract class ScoutRosterEntry with _$ScoutRosterEntry {
  const factory ScoutRosterEntry({
    required int id,
    @Default('') String name,
    int? shirtNumber,
  }) = _ScoutRosterEntry;

  factory ScoutRosterEntry.fromJson(Map<String, dynamic> json) =>
      _$ScoutRosterEntryFromJson(json);
}

/// Wat `POST report/scout-preview` las. Slaat niets op.
@freezed
abstract class ScoutPreview with _$ScoutPreview {
  const factory ScoutPreview({
    @Default(<ScoutSet>[]) List<ScoutSet> sets,
    @Default(<ScoutTeam>[]) List<ScoutTeam> teams,
    int? ourTeamIndex,
    @Default(<ScoutRosterEntry>[]) List<ScoutRosterEntry> roster,
  }) = _ScoutPreview;

  factory ScoutPreview.fromJson(Map<String, dynamic> json) =>
      _$ScoutPreviewFromJson(json);
}

/// Wie er in de vlaggerskeuzelijst staat (`flag.pool[]`). Precies één van
/// [playerId]/[userId].
@freezed
abstract class FlagCandidate with _$FlagCandidate {
  const factory FlagCandidate({
    required String key,
    int? playerId,
    int? userId,
    @Default('') String name,
    @Default(false) bool guest,
    @Default(false) bool staff,
  }) = _FlagCandidate;

  factory FlagCandidate.fromJson(Map<String, dynamic> json) =>
      _$FlagCandidateFromJson(json);
}

/// De vlaggersdienst om te bewerken: het `flag`-veld van het event-detail,
/// mét de keuzelijst ([pool]) die het event-detailmodel niet bewaart.
@freezed
abstract class FlagDutyEdit with _$FlagDutyEdit {
  const factory FlagDutyEdit({
    @Default(<FlagShift>[]) List<FlagShift> shifts,
    @Default(<String>[]) List<String> names,
    @Default(false) bool mine,
    @Default(90) int matchMinutes,
    @Default(<FlagCandidate>[]) List<FlagCandidate> pool,
  }) = _FlagDutyEdit;

  const FlagDutyEdit._();

  factory FlagDutyEdit.fromJson(Map<String, dynamic> json) =>
      _$FlagDutyEditFromJson(json);

  FlagCandidate? candidate(String? key) {
    for (final c in pool) {
      if (c.key == key) return c;
    }
    return null;
  }
}

int _asInt(Object? value) => switch (value) {
  final int v => v,
  final num v => v.round(),
  final String v => int.tryParse(v) ?? 0,
  _ => 0,
};
