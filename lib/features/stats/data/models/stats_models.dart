import 'package:freezed_annotation/freezed_annotation.dart';

import 'lenient_json.dart';

part 'stats_models.freezed.dart';
part 'stats_models.g.dart';

/// Een seizoen voor de seizoenskiezer (`seasons[]`, nieuwste eerst). Ook
/// gebruikt door de Hall of Fame.
@freezed
abstract class SeasonOption with _$SeasonOption {
  const factory SeasonOption({
    required int id,
    @Default('') String label,
    @Default(false) bool isActive,
  }) = _SeasonOption;

  factory SeasonOption.fromJson(Map<String, dynamic> json) =>
      _$SeasonOptionFromJson(json);
}

/// Een titel die een speler alleen heeft (`rows[].titles[]`).
@freezed
abstract class StatsTitle with _$StatsTitle {
  const factory StatsTitle({
    @Default('') String key,
    @Default('') String icon,
    @Default('') String label,
  }) = _StatsTitle;

  factory StatsTitle.fromJson(Map<String, dynamic> json) =>
      _$StatsTitleFromJson(json);
}

/// Eén speler in `GET teams/{team}/stats` (`rows[]`). Percentages 0–100.
@freezed
abstract class StatsRow with _$StatsRow {
  const factory StatsRow({
    @asInt required int playerId,
    @Default('') String name,
    @asIntOrNull int? shirtNumber,
    String? position,
    String? avatarUrl,
    @asDouble @Default(0) double attendanceRate,
    @asDouble @Default(0) double attendanceMatchRate,
    @asDouble @Default(0) double attendanceTrainingRate,
    @asInt @Default(0) int minutes,
    @asInt @Default(0) int goals,
    @asInt @Default(0) int assists,
    @asInt @Default(0) int yellow,
    @asInt @Default(0) int red,
    @asInt @Default(0) int matchesPlayed,

    /// Wedstrijden (met opstelling) waarbij de speler er was of speelde.
    @asInt @Default(0) int matchesPresent,

    /// `minutes / matches_present`, afgerond; `0` zonder aanwezige wedstrijd.
    @asInt @Default(0) int minutesPerMatch,
    @asInt @Default(0) int flagMinutes,
    @asInt @Default(0) int flagShifts,
    @Default(<StatsTitle>[]) List<StatsTitle> titles,
    @asInt @Default(0) int trainingPoints,

    /// Antwoord op de laatste 5 wedstrijden en trainingen, oud → nieuw.
    @Default(<StatsFormEntry>[]) List<StatsFormEntry> recentForm,
  }) = _StatsRow;

  factory StatsRow.fromJson(Map<String, dynamic> json) =>
      _$StatsRowFromJson(json);
}

/// Eén stipje van de recente vorm (`rows[].recent_form[]`).
@freezed
abstract class StatsFormEntry with _$StatsFormEntry {
  const factory StatsFormEntry({
    @asIntOrNull int? eventId,

    /// `match` of `training`.
    @Default('') String type,

    /// `present`, `absent`, `nonplay` of `pending`.
    @Default('pending') String status,
  }) = _StatsFormEntry;

  factory StatsFormEntry.fromJson(Map<String, dynamic> json) =>
      _$StatsFormEntryFromJson(json);
}

/// Een badge-periode van het seizoen (`periods[]`), als bij de Hall of Fame.
@freezed
abstract class StatsPeriod with _$StatsPeriod {
  const factory StatsPeriod({
    required int id,
    @Default('') String name,
    @Default(false) bool isClosed,
  }) = _StatsPeriod;

  factory StatsPeriod.fromJson(Map<String, dynamic> json) =>
      _$StatsPeriodFromJson(json);
}

/// `GET teams/{team}/stats`.
@freezed
abstract class TeamStats with _$TeamStats {
  const factory TeamStats({
    /// `season`, `5` of `10` (wat de server werkelijk gebruikte).
    @asStringOrNull String? window,

    /// De badge-periodes (leeg als het team ze uit heeft) en de gekozen.
    @Default(<StatsPeriod>[]) List<StatsPeriod> periods,
    @asIntOrNull int? periodId,
    @asIntOrNull int? seasonId,
    @Default(<SeasonOption>[]) List<SeasonOption> seasons,
    @asIntOrNull int? myPlayerId,
    @Default(<StatsRow>[]) List<StatsRow> rows,
  }) = _TeamStats;

  const TeamStats._();

  factory TeamStats.fromJson(Map<String, dynamic> json) =>
      _$TeamStatsFromJson(json);

  /// Het gekozen seizoen, als het in de lijst staat.
  SeasonOption? get season {
    for (final s in seasons) {
      if (s.id == seasonId) return s;
    }
    return null;
  }
}
