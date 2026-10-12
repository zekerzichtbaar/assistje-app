import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_models.freezed.dart';
part 'settings_models.g.dart';

// Ruim lezen: de API stuurt booleans soms als 0/1 en getallen soms als
// string (rauwe kolommen uit de teamtabel).
bool _bool(Object? json) => switch (json) {
  final bool b => b,
  final num n => n != 0,
  final String s => s == '1' || s.toLowerCase() == 'true',
  _ => false,
};

int? _intOrNull(Object? json) => switch (json) {
  final num n => n.toInt(),
  final String s => int.tryParse(s),
  _ => null,
};

int _int(Object? json) => _intOrNull(json) ?? 0;

List<String> _strings(Object? json) => json is List
    ? [
        for (final v in json)
          if (v != null) '$v',
      ]
    : const [];

/// Soort beschikbaarheidsdeadline (`rsvp.mode`).
enum RsvpMode {
  relative,
  weekly;

  String get apiValue => name;
}

/// Hoe een dienst verdeeld wordt (`duty_types[].mode`).
enum DutyMode {
  group,
  individual,
  multi;

  String get apiValue => name;
}

/// Wanneer een dienst valt (`duty_types[].scope`).
enum DutyScope {
  free,
  match;

  String get apiValue => name;
}

/// Wat er gebeurt als de ingedeelde zich afmeldt.
enum DutyOnUnavailable {
  reassign,
  notify;

  String get apiValue => name;
}

/// Waar gastspelers aan meedoen (`guests.attendance`).
enum GuestAttendance {
  none,
  training,
  all;

  String get apiValue => name;
}

/// Groepen in `duty_types[].pool`.
abstract final class DutyPool {
  static const players = 'players';
  static const staff = 'staff';
  static const spectators = 'spectators';
  static const custom = 'custom';
  static const guests = 'guests';
}

/// Het team zelf (`data.team`).
@freezed
abstract class SettingsTeam with _$SettingsTeam {
  const factory SettingsTeam({
    @JsonKey(fromJson: _int) @Default(0) int id,
    @Default('') String name,
    @Default('#006837') String primaryColor,
    String? logoUrl,
    @JsonKey(fromJson: _bool) @Default(false) bool logoFills,
    String? formation,
  }) = _SettingsTeam;

  factory SettingsTeam.fromJson(Map<String, dynamic> json) =>
      _$SettingsTeamFromJson(json);
}

/// De beschikbaarheidsdeadline (`data.rsvp`).
@freezed
abstract class RsvpSettings with _$RsvpSettings {
  const factory RsvpSettings({
    @JsonKey(unknownEnumValue: RsvpMode.relative)
    @Default(RsvpMode.relative)
    RsvpMode mode,
    @JsonKey(fromJson: _intOrNull) int? matchHours,
    @JsonKey(fromJson: _intOrNull) int? trainingHours,

    /// 1 = maandag … 7 = zondag.
    @JsonKey(fromJson: _intOrNull) int? weeklyDay,

    /// `HH:MM`.
    String? weeklyTime,
  }) = _RsvpSettings;

  factory RsvpSettings.fromJson(Map<String, dynamic> json) =>
      _$RsvpSettingsFromJson(json);
}

/// Eén functie die aan of uit kan (`data.features[]`).
@freezed
abstract class SettingsFeature with _$SettingsFeature {
  const factory SettingsFeature({
    required String key,
    @Default('') String name,
    String? description,
    String? category,
    @JsonKey(fromJson: _bool) @Default(false) bool enabled,
  }) = _SettingsFeature;

  factory SettingsFeature.fromJson(Map<String, dynamic> json) =>
      _$SettingsFeatureFromJson(json);
}

/// Een diensttype (`data.duty_types[]`).
@freezed
abstract class DutyTypeSetting with _$DutyTypeSetting {
  const factory DutyTypeSetting({
    @JsonKey(fromJson: _int) required int id,
    @Default('') String name,
    String? slug,
    String? icon,
    @JsonKey(fromJson: _int) @Default(0) int sortOrder,
    @JsonKey(unknownEnumValue: DutyMode.group)
    @Default(DutyMode.group)
    DutyMode mode,
    @JsonKey(unknownEnumValue: DutyScope.free)
    @Default(DutyScope.free)
    DutyScope scope,
    @JsonKey(fromJson: _bool) @Default(false) bool autoRotate,
    @JsonKey(unknownEnumValue: DutyOnUnavailable.reassign)
    DutyOnUnavailable? onUnavailable,
    @JsonKey(fromJson: _strings) @Default(<String>[]) List<String> pool,
    @JsonKey(fromJson: _strings) @Default(<String>[]) List<String> poolMembers,
  }) = _DutyTypeSetting;

  factory DutyTypeSetting.fromJson(Map<String, dynamic> json) =>
      _$DutyTypeSettingFromJson(json);
}

/// Iemand die een dienst kan krijgen (`data.duty_people[]`): sleutel
/// `p_<speler>` of `u_<gebruiker>`.
@freezed
abstract class DutyPerson with _$DutyPerson {
  const factory DutyPerson({
    required String key,
    @Default('') String name,

    /// `player`, `staff`, `spectator` of `guest`.
    @Default('player') String kind,
  }) = _DutyPerson;

  factory DutyPerson.fromJson(Map<String, dynamic> json) =>
      _$DutyPersonFromJson(json);
}

/// De agenda-feeds als absolute abonnements-URL's (`data.ical`).
@freezed
abstract class IcalLinks with _$IcalLinks {
  const factory IcalLinks({String? eventsUrl, String? trainingsUrl}) =
      _IcalLinks;

  factory IcalLinks.fromJson(Map<String, dynamic> json) =>
      _$IcalLinksFromJson(json);
}

/// Carpool-herinnering (`data.carpool`).
@freezed
abstract class CarpoolSettings with _$CarpoolSettings {
  const factory CarpoolSettings({
    @JsonKey(fromJson: _int) @Default(4) int reminderHours,
  }) = _CarpoolSettings;

  factory CarpoolSettings.fromJson(Map<String, dynamic> json) =>
      _$CarpoolSettingsFromJson(json);
}

/// Gastspelers (`data.guests`).
@freezed
abstract class GuestSettings with _$GuestSettings {
  const factory GuestSettings({
    @JsonKey(unknownEnumValue: GuestAttendance.none)
    @Default(GuestAttendance.none)
    GuestAttendance attendance,
    @JsonKey(fromJson: _bool) @Default(false) bool inFines,
    @JsonKey(fromJson: _bool) @Default(false) bool inStats,
    @JsonKey(fromJson: _bool) @Default(false) bool staffInFines,
  }) = _GuestSettings;

  factory GuestSettings.fromJson(Map<String, dynamic> json) =>
      _$GuestSettingsFromJson(json);
}

/// Trainingspunten (`data.training_points`).
@freezed
abstract class TrainingPointsSettings with _$TrainingPointsSettings {
  const factory TrainingPointsSettings({
    @JsonKey(fromJson: _bool) @Default(false) bool attendancePoint,
  }) = _TrainingPointsSettings;

  factory TrainingPointsSettings.fromJson(Map<String, dynamic> json) =>
      _$TrainingPointsSettingsFromJson(json);
}

/// Het vorige, afgesloten seizoen.
@freezed
abstract class ClosedSeason with _$ClosedSeason {
  const factory ClosedSeason({@Default('') String label, DateTime? closedAt}) =
      _ClosedSeason;

  factory ClosedSeason.fromJson(Map<String, dynamic> json) =>
      _$ClosedSeasonFromJson(json);
}

/// Eén periode (`period.periods[]`).
@freezed
abstract class PeriodRow with _$PeriodRow {
  const factory PeriodRow({
    @JsonKey(fromJson: _int) required int id,
    @Default('') String name,
    String? startsOn,
    String? endsOn,
    @JsonKey(fromJson: _intOrNull) int? targetMatches,
    @JsonKey(fromJson: _bool) @Default(false) bool isClosed,
    @JsonKey(fromJson: _int) @Default(0) int playedMatches,
    @JsonKey(fromJson: _int) @Default(0) int awardCount,
  }) = _PeriodRow;

  factory PeriodRow.fromJson(Map<String, dynamic> json) =>
      _$PeriodRowFromJson(json);
}

/// Seizoen en periodes, alleen-lezen (`data.period`).
@freezed
abstract class PeriodSettings with _$PeriodSettings {
  const factory PeriodSettings({
    /// `off`, `dates` of `matches`.
    @Default('off') String mode,
    String? seasonLabel,
    String? seasonStartsOn,
    String? seasonEndsOn,
    @JsonKey(fromJson: _bool) @Default(false) bool seasonExpired,
    @JsonKey(fromJson: _int) @Default(0) int seasonMatchCount,
    ClosedSeason? closedSeason,
    @Default(<PeriodRow>[]) List<PeriodRow> periods,
  }) = _PeriodSettings;

  factory PeriodSettings.fromJson(Map<String, dynamic> json) =>
      _$PeriodSettingsFromJson(json);
}

/// Alle instellingen van één team (`GET teams/{team}/settings`). Elke
/// schrijvende actie geeft dezelfde vorm terug.
@freezed
abstract class TeamSettings with _$TeamSettings {
  const TeamSettings._();

  const factory TeamSettings({
    @Default(SettingsTeam()) SettingsTeam team,
    @JsonKey(fromJson: _strings) @Default(<String>[]) List<String> formations,
    @Default(RsvpSettings()) RsvpSettings rsvp,
    @Default(<SettingsFeature>[]) List<SettingsFeature> features,
    @Default(<DutyTypeSetting>[]) List<DutyTypeSetting> dutyTypes,
    @Default(<DutyPerson>[]) List<DutyPerson> dutyPeople,
    @Default(IcalLinks()) IcalLinks ical,
    @Default(CarpoolSettings()) CarpoolSettings carpool,
    @Default(GuestSettings()) GuestSettings guests,
    @Default(TrainingPointsSettings()) TrainingPointsSettings trainingPoints,
    @Default(PeriodSettings()) PeriodSettings period,
  }) = _TeamSettings;

  factory TeamSettings.fromJson(Map<String, dynamic> json) =>
      _$TeamSettingsFromJson(json);

  /// Staat functie [key] aan? Onbekend = uit.
  bool featureEnabled(String key) {
    for (final f in features) {
      if (f.key == key) return f.enabled;
    }
    return false;
  }

  /// Een kopie met functie [key] op [enabled].
  TeamSettings withFeature(String key, {required bool enabled}) => copyWith(
    features: [
      for (final f in features) f.key == key ? f.copyWith(enabled: enabled) : f,
    ],
  );
}

/// Wat het formulier "Team" opslaat (`PATCH settings/team`).
class TeamBranding {
  const TeamBranding({
    required this.name,
    required this.primaryColor,
    this.formation,
    this.logoFills,
  });

  final String name;

  /// `#RRGGBB`.
  final String primaryColor;
  final String? formation;
  final bool? logoFills;

  Map<String, dynamic> toJson() => {
    'name': name,
    'primary_color': primaryColor,
    'formation': ?formation,
    'logo_fills': ?logoFills,
  };
}

/// Wat het formulier "Deadlines" opslaat (`PATCH settings/rsvp`).
class RsvpUpdate {
  const RsvpUpdate.relative({
    required int this.matchHours,
    required int this.trainingHours,
  }) : mode = RsvpMode.relative,
       weeklyDay = null,
       weeklyTime = null;

  const RsvpUpdate.weekly({
    required int this.weeklyDay,
    required String this.weeklyTime,
  }) : mode = RsvpMode.weekly,
       matchHours = null,
       trainingHours = null;

  final RsvpMode mode;
  final int? matchHours;
  final int? trainingHours;
  final int? weeklyDay;
  final String? weeklyTime;

  Map<String, dynamic> toJson() => switch (mode) {
    RsvpMode.relative => {
      'rsvp_deadline_mode': 'relative',
      'rsvp_deadline_match_hours': matchHours,
      'rsvp_deadline_training_hours': trainingHours,
    },
    RsvpMode.weekly => {
      'rsvp_deadline_mode': 'weekly',
      'rsvp_weekly_day': weeklyDay,
      'rsvp_weekly_time': weeklyTime,
    },
  };
}

/// Wijziging van de gastspeler-instellingen; alleen wat niet `null` is gaat
/// mee (`PATCH settings/guests`).
class GuestUpdate {
  const GuestUpdate({
    this.attendance,
    this.inFines,
    this.inStats,
    this.staffInFines,
  });

  final GuestAttendance? attendance;
  final bool? inFines;
  final bool? inStats;
  final bool? staffInFines;

  Map<String, dynamic> toJson() => {
    'guest_attendance': ?attendance?.apiValue,
    'guest_in_fines': ?inFines,
    'guest_in_stats': ?inStats,
    'staff_in_fines': ?staffInFines,
  };

  /// [current] met deze wijziging erop (voor de optimistische weergave).
  GuestSettings applyTo(GuestSettings current) => current.copyWith(
    attendance: attendance ?? current.attendance,
    inFines: inFines ?? current.inFines,
    inStats: inStats ?? current.inStats,
    staffInFines: staffInFines ?? current.staffInFines,
  );
}

/// Een nieuw of gewijzigd diensttype (`POST`/`PATCH settings/duty-types`).
class DutyTypeInput {
  const DutyTypeInput({
    required this.name,
    this.icon,
    this.mode = DutyMode.group,
    this.scope = DutyScope.free,
    this.autoRotate = false,
    this.onUnavailable = DutyOnUnavailable.reassign,
    this.pool = const [DutyPool.players],
    this.poolMembers = const [],
  });

  /// Het formulier voor een bestaand type.
  factory DutyTypeInput.from(DutyTypeSetting type) => DutyTypeInput(
    name: type.name,
    icon: type.icon,
    mode: type.mode,
    scope: type.scope,
    autoRotate: type.autoRotate,
    onUnavailable: type.onUnavailable ?? DutyOnUnavailable.reassign,
    pool: type.pool.isEmpty ? const [DutyPool.players] : type.pool,
    poolMembers: type.poolMembers,
  );

  final String name;
  final String? icon;
  final DutyMode mode;
  final DutyScope scope;
  final bool autoRotate;
  final DutyOnUnavailable onUnavailable;
  final List<String> pool;
  final List<String> poolMembers;

  /// Alleen individueel + bij een wedstrijd kent rotatie en "zelf iemand
  /// aanwijzen" (de server dwingt hetzelfde af).
  bool get rotates => mode == DutyMode.individual && scope == DutyScope.match;

  Map<String, dynamic> toJson() => {
    'name': name.trim(),
    'icon': (icon == null || icon!.isEmpty) ? null : icon,
    'mode': mode.apiValue,
    'scope': scope.apiValue,
    'auto_rotate': rotates && autoRotate,
    'on_unavailable': rotates
        ? onUnavailable.apiValue
        : DutyOnUnavailable.notify.apiValue,
    'pool': pool,
    'pool_members': poolMembers,
  };
}
