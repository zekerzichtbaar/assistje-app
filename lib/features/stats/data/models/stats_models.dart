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
    @asInt @Default(0) int flagMinutes,
    @asInt @Default(0) int flagShifts,
    @Default(<StatsTitle>[]) List<StatsTitle> titles,
    @asInt @Default(0) int trainingPoints,
  }) = _StatsRow;

  factory StatsRow.fromJson(Map<String, dynamic> json) =>
      _$StatsRowFromJson(json);
}

/// `GET teams/{team}/stats`.
@freezed
abstract class TeamStats with _$TeamStats {
  const factory TeamStats({
    /// `season`, `5` of `10` (wat de server werkelijk gebruikte).
    @asStringOrNull String? window,
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
