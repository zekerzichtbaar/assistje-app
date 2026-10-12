import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_detail_models.freezed.dart';
part 'player_detail_models.g.dart';

/// Het spelersprofiel (`player` van `GET teams/{team}/players/{player}`).
@freezed
abstract class PlayerProfile with _$PlayerProfile {
  const factory PlayerProfile({
    required int id,
    @Default('') String name,
    int? shirtNumber,
    String? position,
    @Default(false) bool isGuest,
    @Default(false) bool isInjured,
    @Default(false) bool isOnVacation,

    /// Naam van het team waar een gast vandaan komt.
    String? fromTeam,
    String? avatarUrl,
    @Default(false) bool hasAccount,

    /// Alleen gevuld voor een trainer (`can_manage`).
    String? email,
    DateTime? invitedAt,
    @Default(false) bool inviteAccepted,
    @Default(false) bool isTrainer,
    @Default(<String>[]) List<String> abilities,
    @Default(false) bool isSelf,
    @Default(false) bool isCaptain,
  }) = _PlayerProfile;

  factory PlayerProfile.fromJson(Map<String, dynamic> json) =>
      _$PlayerProfileFromJson(json);
}

/// Persoonlijke statistieken over één periode (`personal_stats.season` /
/// `.career`). De sleutels volgen `PersonalStatsService::compute()`; de
/// sport-specifieke (punten, aces, blocks, trainingspunten) zijn optioneel.
@freezed
abstract class PersonalStats with _$PersonalStats {
  const factory PersonalStats({
    @Default(0) int matchesPlayed,
    @Default(0) int wins,
    @Default(0) int draws,
    @Default(0) int losses,
    @Default(0) double winPct,
    @Default(0) int goals,
    @Default(0) int assists,
    @Default(0) int green,
    @Default(0) int yellow,
    @Default(0) int red,
    @Default(0) int cleanSheets,
    @Default(0) int motm,
    @Default(0) double attendanceMatchRate,
    @Default(0) double attendanceTrainingRate,
    int? trainingPoints,
    int? points,
    int? aces,
    int? blocks,
  }) = _PersonalStats;

  factory PersonalStats.fromJson(Map<String, dynamic> json) =>
      _$PersonalStatsFromJson(json);
}

/// Statistieken van het lopende seizoen en de hele carrière.
@freezed
abstract class PersonalStatsSet with _$PersonalStatsSet {
  const factory PersonalStatsSet({
    @Default(PersonalStats()) PersonalStats season,
    @Default(PersonalStats()) PersonalStats career,
  }) = _PersonalStatsSet;

  factory PersonalStatsSet.fromJson(Map<String, dynamic> json) =>
      _$PersonalStatsSetFromJson(json);
}

/// Hoe vaak de speler een dienstsoort deed (`duties[]`).
@freezed
abstract class DutyCount with _$DutyCount {
  const factory DutyCount({
    @Default('') String slug,
    @Default('') String name,
    @Default(0) int count,
  }) = _DutyCount;

  factory DutyCount.fromJson(Map<String, dynamic> json) =>
      _$DutyCountFromJson(json);
}

/// Een badge (`achievements[]`); [icon] is een emoji.
@freezed
abstract class Achievement with _$Achievement {
  const factory Achievement({
    @Default('') String key,
    @Default('') String icon,
    @Default('') String label,
    String? detail,
    @Default(1) int count,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
}

/// Een lopende of komende vakantie (`vacations[]`, alleen voor trainers).
@freezed
abstract class PlayerVacation with _$PlayerVacation {
  const factory PlayerVacation({
    required int id,
    required DateTime startsOn,
    required DateTime endsOn,
    String? note,
  }) = _PlayerVacation;

  factory PlayerVacation.fromJson(Map<String, dynamic> json) =>
      _$PlayerVacationFromJson(json);
}

/// Een vaste afwezige weekdag (`standing_absences.days[]`).
@freezed
abstract class StandingAbsenceDay with _$StandingAbsenceDay {
  const factory StandingAbsenceDay({
    required int id,

    /// 0 = zondag … 6 = zaterdag.
    required int weekday,
  }) = _StandingAbsenceDay;

  factory StandingAbsenceDay.fromJson(Map<String, dynamic> json) =>
      _$StandingAbsenceDayFromJson(json);
}

/// Vaste afwezige dagen en de weekdagen waarop het team traint.
@freezed
abstract class StandingAbsences with _$StandingAbsences {
  const factory StandingAbsences({
    @Default(<StandingAbsenceDay>[]) List<StandingAbsenceDay> days,
    @Default(<int>[]) List<int> choices,
  }) = _StandingAbsences;

  const StandingAbsences._();

  factory StandingAbsences.fromJson(Map<String, dynamic> json) =>
      _$StandingAbsencesFromJson(json);

  bool isAbsentOn(int weekday) => days.any((d) => d.weekday == weekday);
}

/// Alles van `GET teams/{team}/players/{player}`.
@freezed
abstract class PlayerDetail with _$PlayerDetail {
  const factory PlayerDetail({
    required PlayerProfile player,

    /// Kijkt een trainer van dit team? Alleen dan zijn de beheervelden gevuld.
    @Default(false) bool canManage,
    @Default(<PlayerVacation>[]) List<PlayerVacation> vacations,
    StandingAbsences? standingAbsences,
    PersonalStatsSet? personalStats,
    @Default(<DutyCount>[]) List<DutyCount> duties,
    @Default(<Achievement>[]) List<Achievement> achievements,
  }) = _PlayerDetail;

  factory PlayerDetail.fromJson(Map<String, dynamic> json) =>
      _$PlayerDetailFromJson(json);
}
