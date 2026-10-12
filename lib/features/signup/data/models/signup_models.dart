import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_models.freezed.dart';
part 'signup_models.g.dart';

/// Hoe een sport een ploeg aanduidt (vogels3 `SportProfile::designation()`):
/// "Welk elftal?" bij voetbal, "Welk team?" bij volleybal.
@freezed
abstract class SignupDesignation with _$SignupDesignation {
  const factory SignupDesignation({
    @Default('team') String word,
    @Default('Welk team?') String question,
    @Default('') String hint,
    @Default('') String example,
  }) = _SignupDesignation;

  factory SignupDesignation.fromJson(Map<String, dynamic> json) =>
      _$SignupDesignationFromJson(json);
}

/// Waar het programma van een sport vandaan komt
/// (`SportProfile::federationImport()`). [method] `feed` → vraag optioneel om
/// `schedule_feed_url`; `paste` of iets anders → geen programmastap.
@freezed
abstract class SignupFederationImport with _$SignupFederationImport {
  const factory SignupFederationImport({
    String? method,
    @Default('') String name,
    @Default('') String hint,
    @Default('') String example,
  }) = _SignupFederationImport;

  const SignupFederationImport._();

  factory SignupFederationImport.fromJson(Map<String, dynamic> json) =>
      _$SignupFederationImportFromJson(json);

  bool get isFeed => method == 'feed';
}

/// Een sport die de app kent (`sports[]`).
@freezed
abstract class SignupSport with _$SignupSport {
  const factory SignupSport({
    required String value,
    @Default('') String label,
    @Default(SignupDesignation()) SignupDesignation designation,
    SignupFederationImport? federationImport,
  }) = _SignupSport;

  const SignupSport._();

  factory SignupSport.fromJson(Map<String, dynamic> json) =>
      _$SignupSportFromJson(json);

  /// Heeft deze sport een programmastap (agenda-feed)?
  bool get hasFeed => federationImport?.isFeed ?? false;
}

/// De grenzen van het formulier (`limits`).
@freezed
abstract class SignupLimits with _$SignupLimits {
  const factory SignupLimits({
    @Default(1) int trainingsMin,
    @Default(7) int trainingsMax,
    @Default(2048) int logoMaxKb,
    @Default(<String>['image/png', 'image/jpeg', 'image/svg+xml'])
    List<String> logoMimetypes,
    @Default(2) int clubSearchMinChars,
  }) = _SignupLimits;

  factory SignupLimits.fromJson(Map<String, dynamic> json) =>
      _$SignupLimitsFromJson(json);
}

/// `GET /signup`: wat het aanmeldscherm vooraf moet weten. [sport] is de
/// sport uit de deeplink (`?sport=`), of `null` = begin bij de keuze.
@freezed
abstract class SignupOptions with _$SignupOptions {
  const factory SignupOptions({
    @Default(<SignupSport>[]) List<SignupSport> sports,
    String? sport,
    @Default(SignupLimits()) SignupLimits limits,
  }) = _SignupOptions;

  const SignupOptions._();

  factory SignupOptions.fromJson(Map<String, dynamic> json) =>
      _$SignupOptionsFromJson(json);

  SignupSport? sportFor(String? value) {
    for (final option in sports) {
      if (option.value == value) return option;
    }
    return null;
  }
}

/// Een club uit de keuzelijst (`GET /signup/clubs`).
@freezed
abstract class SignupClub with _$SignupClub {
  const factory SignupClub({
    required int id,
    @Default('') String name,
    String? place,
    String? logoUrl,
  }) = _SignupClub;

  factory SignupClub.fromJson(Map<String, dynamic> json) =>
      _$SignupClubFromJson(json);
}

/// De treffers van een clubzoekopdracht; [more] = hoeveel er buiten de
/// lijst vallen ("typ verder").
@freezed
abstract class SignupClubResults with _$SignupClubResults {
  const factory SignupClubResults({
    @Default(<SignupClub>[]) List<SignupClub> clubs,
    @Default(0) int more,
  }) = _SignupClubResults;
}

/// Een (nieuwe of bestaande) omgeving: `team` in `existing` en `202`.
@freezed
abstract class SignupTeam with _$SignupTeam {
  const factory SignupTeam({
    required int id,
    @Default('') String name,
    @Default('') String slug,
    String? sport,
    @Default('') String url,
  }) = _SignupTeam;

  factory SignupTeam.fromJson(Map<String, dynamic> json) =>
      _$SignupTeamFromJson(json);
}

/// `202` van `POST /signup`: er ging een mail heen, nooit een token.
/// [already] = dit adres was al trainer van deze omgeving; er is geen
/// tweede gemaakt en [team] is de bestaande.
@freezed
abstract class SignupSent with _$SignupSent {
  const factory SignupSent({
    @Default('') String email,
    @Default(false) bool already,
    required SignupTeam team,
  }) = _SignupSent;

  factory SignupSent.fromJson(Map<String, dynamic> json) =>
      _$SignupSentFromJson(json);
}

/// `202` van `POST /signup/other-sport`: een aanvraag, geen omgeving.
@freezed
abstract class SignupRequested with _$SignupRequested {
  const factory SignupRequested({
    @Default('') String sport,
    @Default('') String email,
  }) = _SignupRequested;

  factory SignupRequested.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestedFromJson(json);
}

/// Een trainingsmoment: ISO-weekdag (1 = maandag) plus `HH:MM`-tijden en
/// optioneel het veld.
@freezed
abstract class SignupTraining with _$SignupTraining {
  const factory SignupTraining({
    required int weekday,
    @Default('19:30') String startsAt,
    @Default('21:00') String endsAt,
    @Default('') String venue,
  }) = _SignupTraining;

  const SignupTraining._();

  factory SignupTraining.fromJson(Map<String, dynamic> json) =>
      _$SignupTrainingFromJson(json);

  /// Eindigt vóór (of op) de begintijd. `HH:MM` vergelijkt als tekst goed.
  bool get isBackwards =>
      startsAt.isNotEmpty &&
      endsAt.isNotEmpty &&
      endsAt.compareTo(startsAt) <= 0;
}
