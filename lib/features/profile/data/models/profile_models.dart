import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_models.freezed.dart';
part 'profile_models.g.dart';

/// Het account-deel van de "Mij"-tab (`ProfileAccountResource` in vogels3):
/// wat je zelf invult. Accountniveau, niet per team.
@freezed
abstract class ProfileAccount with _$ProfileAccount {
  const factory ProfileAccount({
    required int id,
    @Default('') String name,

    /// Het bevestigde adres; `null` voor wie via de teamlink binnenkwam.
    String? email,

    /// Geclaimd maar nog niet bevestigd (`EmailClaim`).
    String? pendingEmail,
    String? avatarUrl,

    /// Kale kalenderdag `YYYY-MM-DD` (de effectieve: die van je speler in dit
    /// team, anders de jouwe).
    String? birthdate,
  }) = _ProfileAccount;

  factory ProfileAccount.fromJson(Map<String, dynamic> json) =>
      _$ProfileAccountFromJson(json);
}

/// Je eigen spelersprofiel in dit team (`player` in `GET …/profile`).
@freezed
abstract class OwnPlayer with _$OwnPlayer {
  const factory OwnPlayer({
    required int id,
    @Default('') String name,
    int? shirtNumber,

    /// Positiecode uit het sportprofiel (`CM`, `ST`, …).
    String? position,
    String? birthdate,
    @Default(false) bool isInjured,
  }) = _OwnPlayer;

  factory OwnPlayer.fromJson(Map<String, dynamic> json) =>
      _$OwnPlayerFromJson(json);
}

/// Eén vakantie (alleen lezen in de app).
@freezed
abstract class ProfileVacation with _$ProfileVacation {
  const factory ProfileVacation({
    required int id,

    /// Kale datums `YYYY-MM-DD`.
    required String startsOn,
    required String endsOn,
    String? note,
  }) = _ProfileVacation;

  factory ProfileVacation.fromJson(Map<String, dynamic> json) =>
      _$ProfileVacationFromJson(json);
}

/// Een vaste afwezige weekdag.
@freezed
abstract class StandingAbsenceDay with _$StandingAbsenceDay {
  const factory StandingAbsenceDay({
    required int id,

    /// ISO-weekdag (1 = maandag … 7 = zondag; 0 telt ook als zondag).
    required int weekday,
  }) = _StandingAbsenceDay;

  factory StandingAbsenceDay.fromJson(Map<String, dynamic> json) =>
      _$StandingAbsenceDayFromJson(json);
}

/// `standing_absences`: gekozen dagen plus de dagen waarop het team traint.
@freezed
abstract class StandingAbsences with _$StandingAbsences {
  const factory StandingAbsences({
    @Default(<StandingAbsenceDay>[]) List<StandingAbsenceDay> days,
    @Default(<int>[]) List<int> choices,
  }) = _StandingAbsences;

  const StandingAbsences._();

  factory StandingAbsences.fromJson(Map<String, dynamic> json) =>
      _$StandingAbsencesFromJson(json);

  /// Staat [weekday] als vaste afwezige dag?
  bool isAbsentOn(int weekday) => days.any((d) => d.weekday == weekday);
}

/// `GET teams/{team}/profile` (vogels3 `docs/api/v1/profile.md`).
///
/// `personal_stats`, `achievements` en `duties` laat de app (nog) liggen.
@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required ProfileAccount user,
    OwnPlayer? player,
    @Default(false) bool canUseVacations,
    @Default(<ProfileVacation>[]) List<ProfileVacation> vacations,
    StandingAbsences? standingAbsences,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
