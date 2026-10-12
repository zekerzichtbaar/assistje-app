import 'package:freezed_annotation/freezed_annotation.dart';

part 'roster_models.freezed.dart';
part 'roster_models.g.dart';

/// Eén speler in de selectie (`players[]` van `GET teams/{team}/team`).
@freezed
abstract class RosterPlayer with _$RosterPlayer {
  const factory RosterPlayer({
    required int id,
    int? shirtNumber,
    @Default('') String name,

    /// Positiecode van de sport van het team (vrije tekst, mag leeg zijn).
    String? position,
    String? avatarUrl,
    @Default(false) bool isGuest,
    @Default(false) bool isInjured,
    @Default(false) bool isOnVacation,
  }) = _RosterPlayer;

  factory RosterPlayer.fromJson(Map<String, dynamic> json) =>
      _$RosterPlayerFromJson(json);
}

/// Een trainer zonder spelersprofiel (`coaches[]`). [id] is een user-id.
@freezed
abstract class RosterCoach with _$RosterCoach {
  const factory RosterCoach({
    required int id,
    @Default('') String name,
    String? avatarUrl,
    @Default(false) bool isOnVacation,
  }) = _RosterCoach;

  factory RosterCoach.fromJson(Map<String, dynamic> json) =>
      _$RosterCoachFromJson(json);
}

/// De hele selectie van een team.
@freezed
abstract class TeamRoster with _$TeamRoster {
  const factory TeamRoster({
    @Default(<RosterPlayer>[]) List<RosterPlayer> players,
    @Default(<RosterCoach>[]) List<RosterCoach> coaches,
  }) = _TeamRoster;

  const TeamRoster._();

  factory TeamRoster.fromJson(Map<String, dynamic> json) =>
      _$TeamRosterFromJson(json);

  bool get isEmpty => players.isEmpty && coaches.isEmpty;
}
