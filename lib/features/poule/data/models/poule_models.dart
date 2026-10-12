import 'package:freezed_annotation/freezed_annotation.dart';

part 'poule_models.freezed.dart';
part 'poule_models.g.dart';

/// Eén regel van de stand (`standing[]`), in de volgorde van Sportlink.
@freezed
abstract class PouleStanding with _$PouleStanding {
  const factory PouleStanding({
    @Default(0) int position,
    @Default('') String team,

    /// Absolute URL of `null`.
    String? logo,
    @Default(0) int played,
    @Default(0) int won,
    @Default(0) int drawn,
    @Default(0) int lost,
    @Default(0) int goalsFor,
    @Default(0) int goalsAgainst,
    @Default(0) int goalDiff,
    @Default(0) int points,

    /// Onze eigen ploeg.
    @Default(false) bool isOwn,
  }) = _PouleStanding;

  factory PouleStanding.fromJson(Map<String, dynamic> json) =>
      _$PouleStandingFromJson(json);
}

/// Eén wedstrijd uit `results[].matches` of `fixtures[].matches`.
@freezed
abstract class PouleMatch with _$PouleMatch {
  const factory PouleMatch({
    /// Kale datum `YYYY-MM-DD` of `null`.
    String? date,

    /// `HH:MM` of `null`.
    String? time,
    @Default('') String home,
    @Default('') String away,

    /// `"3-1"` bij een uitgespeelde wedstrijd, anders `null` (dan [status]).
    String? score,
    String? status,
    @Default(false) bool isOwn,
    @Default(false) bool homeIsOwn,
    @Default(false) bool awayIsOwn,
    String? homeLogo,
    String? awayLogo,

    /// Het gekoppelde agenda-event bij onze eigen wedstrijden.
    int? eventId,
  }) = _PouleMatch;

  factory PouleMatch.fromJson(Map<String, dynamic> json) =>
      _$PouleMatchFromJson(json);
}

/// Wedstrijden van één speeldag.
@freezed
abstract class PouleMatchDay with _$PouleMatchDay {
  const factory PouleMatchDay({
    /// Kale datum `YYYY-MM-DD`, of `null` als Sportlink er geen gaf.
    String? date,
    @Default(<PouleMatch>[]) List<PouleMatch> matches,
  }) = _PouleMatchDay;

  factory PouleMatchDay.fromJson(Map<String, dynamic> json) =>
      _$PouleMatchDayFromJson(json);
}

/// `results_push`: wil je een push bij nieuwe uitslagen, en kan dat.
@freezed
abstract class PouleResultsPush with _$PouleResultsPush {
  const factory PouleResultsPush({
    @Default(false) bool enabled,
    @Default(false) bool canPush,
  }) = _PouleResultsPush;

  factory PouleResultsPush.fromJson(Map<String, dynamic> json) =>
      _$PouleResultsPushFromJson(json);
}

/// `GET teams/{team}/poule` (vogels3 `docs/api/v1/poule.md`).
@freezed
abstract class Poule with _$Poule {
  const factory Poule({
    String? pouleLabel,
    String? competition,

    /// Laatste Sportlink-sync; `null` = nog nooit (lijsten dan leeg).
    DateTime? fetchedAt,
    @Default(<PouleStanding>[]) List<PouleStanding> standing,

    /// Per speeldag, nieuwste eerst.
    @Default(<PouleMatchDay>[]) List<PouleMatchDay> results,

    /// Per speeldag, oudste eerst.
    @Default(<PouleMatchDay>[]) List<PouleMatchDay> fixtures,
    PouleResultsPush? resultsPush,
  }) = _Poule;

  const Poule._();

  factory Poule.fromJson(Map<String, dynamic> json) => _$PouleFromJson(json);

  /// Nog nooit gesynct.
  bool get neverSynced => fetchedAt == null;
}
