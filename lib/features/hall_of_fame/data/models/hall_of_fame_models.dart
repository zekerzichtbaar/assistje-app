import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../stats/data/models/lenient_json.dart';
import '../../../stats/data/models/stats_models.dart';

part 'hall_of_fame_models.freezed.dart';
part 'hall_of_fame_models.g.dart';

/// Een periode (blok) van het seizoen (`periods[]`).
@freezed
abstract class HofPeriod with _$HofPeriod {
  const factory HofPeriod({
    required int id,
    @Default('') String name,
    DateTime? startsOn,
    DateTime? endsOn,
    @Default(false) bool isClosed,
  }) = _HofPeriod;

  factory HofPeriod.fromJson(Map<String, dynamic> json) =>
      _$HofPeriodFromJson(json);
}

/// Een speler bij een titel (`holder`, `holders[]`).
@freezed
abstract class HofPerson with _$HofPerson {
  const factory HofPerson({
    @asIntOrNull int? playerId,
    @Default('') String name,
    String? avatarUrl,
  }) = _HofPerson;

  factory HofPerson.fromJson(Map<String, dynamic> json) =>
      _$HofPersonFromJson(json);
}

/// Een titel (`titles[]`). `holder` is de (eerste) winnaar; `holders` bevat
/// iedereen die gelijk staat (leeg bij één winnaar of een bevroren periode).
@freezed
abstract class HofTitle with _$HofTitle {
  const factory HofTitle({
    @Default('') String key,
    @Default('') String label,
    @Default('') String icon,

    /// `season` (seizoen/periode) of `now` (rollend venster).
    @Default('season') String group,
    HofPerson? holder,
    @Default(<HofPerson>[]) List<HofPerson> holders,
    @asStringOrNull String? value,
    @asStringOrNull String? caption,
  }) = _HofTitle;

  const HofTitle._();

  factory HofTitle.fromJson(Map<String, dynamic> json) =>
      _$HofTitleFromJson(json);

  /// Gedeelde titel: meer dan één speler staat gelijk.
  bool get isShared => holders.length > 1;
}

/// Eén winnaar in de erelijst (`period_awards[].winners[]`).
@freezed
abstract class PeriodAwardWinner with _$PeriodAwardWinner {
  const factory PeriodAwardWinner({
    @Default('') String titleKey,
    @Default('') String label,
    @Default('') String icon,
    @asStringOrNull String? value,
    @asIntOrNull int? playerId,
    @Default('') String name,
    String? avatarUrl,
  }) = _PeriodAwardWinner;

  factory PeriodAwardWinner.fromJson(Map<String, dynamic> json) =>
      _$PeriodAwardWinnerFromJson(json);
}

/// De bevroren winnaars van één afgesloten periode (`period_awards[]`).
@freezed
abstract class PeriodAwardGroup with _$PeriodAwardGroup {
  const factory PeriodAwardGroup({
    @asInt required int periodId,
    @Default('') String periodName,
    @Default(<PeriodAwardWinner>[]) List<PeriodAwardWinner> winners,
  }) = _PeriodAwardGroup;

  factory PeriodAwardGroup.fromJson(Map<String, dynamic> json) =>
      _$PeriodAwardGroupFromJson(json);
}

/// Eén rij in een ranglijst. Welke teller gevuld is hangt van de lijst af
/// (`goals`, `assists`, `minutes`+`shifts`, `wins`, `points`, `aces`,
/// `blocks`); de rest blijft 0.
@freezed
abstract class HofLeader with _$HofLeader {
  const factory HofLeader({
    @asInt required int playerId,
    @Default('') String name,
    String? avatarUrl,
    @asInt @Default(0) int goals,
    @asInt @Default(0) int assists,
    @asInt @Default(0) int minutes,
    @asInt @Default(0) int shifts,
    @asInt @Default(0) int wins,
    @asInt @Default(0) int points,
    @asInt @Default(0) int aces,
    @asInt @Default(0) int blocks,
  }) = _HofLeader;

  factory HofLeader.fromJson(Map<String, dynamic> json) =>
      _$HofLeaderFromJson(json);
}

/// Ranglijsten uit het statistiekenblad na afloop.
@freezed
abstract class PostMatchLeaderboards with _$PostMatchLeaderboards {
  const factory PostMatchLeaderboards({
    @Default(<HofLeader>[]) List<HofLeader> points,
    @Default(<HofLeader>[]) List<HofLeader> aces,
    @Default(<HofLeader>[]) List<HofLeader> blocks,
  }) = _PostMatchLeaderboards;

  factory PostMatchLeaderboards.fromJson(Map<String, dynamic> json) =>
      _$PostMatchLeaderboardsFromJson(json);
}

/// Een badge (`players_with_badges[].badges[]`).
@freezed
abstract class HofBadge with _$HofBadge {
  const factory HofBadge({
    @Default('') String key,
    @Default('') String icon,
    @Default('') String label,
  }) = _HofBadge;

  factory HofBadge.fromJson(Map<String, dynamic> json) =>
      _$HofBadgeFromJson(json);
}

/// Een speler met minstens één badge.
@freezed
abstract class BadgePlayer with _$BadgePlayer {
  const factory BadgePlayer({
    @asInt required int playerId,
    @Default('') String name,
    @asIntOrNull int? shirtNumber,
    String? avatarUrl,
    @Default(<HofBadge>[]) List<HofBadge> badges,
  }) = _BadgePlayer;

  factory BadgePlayer.fromJson(Map<String, dynamic> json) =>
      _$BadgePlayerFromJson(json);
}

/// `GET teams/{team}/hall-of-fame`. Een ranglijst die `null` is bestaat
/// niet voor deze sport; een lege lijst is "nog niemand".
@freezed
abstract class HallOfFame with _$HallOfFame {
  const factory HallOfFame({
    @asIntOrNull int? seasonId,
    @Default(<SeasonOption>[]) List<SeasonOption> seasons,
    @asIntOrNull int? periodId,
    @Default(<HofPeriod>[]) List<HofPeriod> periods,
    @Default(<PeriodAwardGroup>[]) List<PeriodAwardGroup> periodAwards,
    @Default(<HofTitle>[]) List<HofTitle> titles,
    List<HofLeader>? topScorers,
    List<HofLeader>? topAssisters,
    List<HofLeader>? topFlaggers,
    PostMatchLeaderboards? postMatchLeaderboards,
    @Default(<HofLeader>[]) List<HofLeader> topMotm,
    @Default(<BadgePlayer>[]) List<BadgePlayer> playersWithBadges,
    @Default(false) bool trainingPointsEnabled,
    @Default(<HofLeader>[]) List<HofLeader> topTrainingPoints,
  }) = _HallOfFame;

  const HallOfFame._();

  factory HallOfFame.fromJson(Map<String, dynamic> json) =>
      _$HallOfFameFromJson(json);

  /// De gekozen periode, of `null` (heel seizoen).
  HofPeriod? get period {
    for (final p in periods) {
      if (p.id == periodId) return p;
    }
    return null;
  }

  SeasonOption? get season {
    for (final s in seasons) {
      if (s.id == seasonId) return s;
    }
    return null;
  }
}
