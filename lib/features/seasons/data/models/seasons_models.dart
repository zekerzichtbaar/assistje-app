import 'package:freezed_annotation/freezed_annotation.dart';

part 'seasons_models.freezed.dart';
part 'seasons_models.g.dart';

// Ruim lezen: booleans soms als 0/1, getallen soms als string.
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

String? _stringOrNull(Object? json) => switch (json) {
  null => null,
  final String s when s.isEmpty => null,
  final Object o => '$o',
};

List<PeriodMode> _parseModes(Object? json) {
  if (json is! List) return PeriodMode.values;
  final modes = [for (final v in json) ?PeriodMode.tryParse('$v')];
  return modes.isEmpty ? PeriodMode.values : modes;
}

/// Hoe badges en titels per blok lopen (`mode`).
enum PeriodMode {
  /// Alles over het hele seizoen.
  off,

  /// De trainer knipt op datum.
  dates,

  /// Elke periode telt een vast aantal gespeelde wedstrijden.
  matches;

  String get apiValue => name;

  static PeriodMode? tryParse(String value) {
    for (final mode in values) {
      if (mode.name == value) return mode;
    }
    return null;
  }
}

/// Het lopende seizoen (`data.season`).
@freezed
abstract class Season with _$Season {
  const factory Season({
    @JsonKey(fromJson: _int) @Default(0) int id,
    @Default('') String label,

    /// `YYYY-MM-DD`.
    @JsonKey(fromJson: _stringOrNull) String? startsOn,
    @JsonKey(fromJson: _stringOrNull) String? endsOn,
    @JsonKey(fromJson: _bool) @Default(false) bool isActive,

    /// Einddatum voorbij terwijl het seizoen nog actief staat.
    @JsonKey(fromJson: _bool) @Default(false) bool expired,
    @JsonKey(fromJson: _int) @Default(0) int matchCount,
  }) = _Season;

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
}

/// Het laatst afgesloten seizoen (`data.closed_season`).
@freezed
abstract class ClosedSeason with _$ClosedSeason {
  const factory ClosedSeason({
    @Default('') String label,

    /// ISO-8601 met offset.
    @JsonKey(fromJson: _stringOrNull) String? closedAt,
  }) = _ClosedSeason;

  factory ClosedSeason.fromJson(Map<String, dynamic> json) =>
      _$ClosedSeasonFromJson(json);
}

/// Een badge-periode (`data.periods[]`).
@freezed
abstract class SeasonPeriod with _$SeasonPeriod {
  const factory SeasonPeriod({
    @JsonKey(fromJson: _int) required int id,
    @Default('') String name,
    @JsonKey(fromJson: _stringOrNull) String? startsOn,

    /// `null` in de modus `matches` zolang de periode niet vol is.
    @JsonKey(fromJson: _stringOrNull) String? endsOn,
    @JsonKey(fromJson: _intOrNull) int? targetMatches,
    @JsonKey(fromJson: _bool) @Default(false) bool isClosed,
    @JsonKey(fromJson: _int) @Default(0) int playedMatches,
    @JsonKey(fromJson: _int) @Default(0) int awardCount,
  }) = _SeasonPeriod;

  factory SeasonPeriod.fromJson(Map<String, dynamic> json) =>
      _$SeasonPeriodFromJson(json);
}

/// De volledige seizoensstaat (`GET seasons`, en het antwoord op elke
/// schrijvende actie).
@freezed
abstract class SeasonsData with _$SeasonsData {
  const factory SeasonsData({
    @JsonKey(unknownEnumValue: PeriodMode.off)
    @Default(PeriodMode.off)
    PeriodMode mode,
    @JsonKey(fromJson: _parseModes)
    @Default([PeriodMode.off, PeriodMode.dates, PeriodMode.matches])
    List<PeriodMode> modes,
    Season? season,
    ClosedSeason? closedSeason,
    @Default(<SeasonPeriod>[]) List<SeasonPeriod> periods,
  }) = _SeasonsData;

  const SeasonsData._();

  factory SeasonsData.fromJson(Map<String, dynamic> json) =>
      _$SeasonsDataFromJson(json);

  /// Zijn er periodes die een nieuw voorstel zou vervangen?
  bool get hasOpenPeriods => periods.any((p) => !p.isClosed);

  SeasonPeriod? periodById(int id) {
    for (final p in periods) {
      if (p.id == id) return p;
    }
    return null;
  }
}

/// Wat een schrijvende actie extra in `meta` meegeeft.
class SeasonsMeta {
  const SeasonsMeta({this.periodId, this.moved, this.awardCount});

  factory SeasonsMeta.fromJson(Object? json) {
    if (json is! Map) return const SeasonsMeta();
    return SeasonsMeta(
      periodId: _intOrNull(json['period_id']),
      moved: _intOrNull(json['moved']),
      awardCount: _intOrNull(json['award_count']),
    );
  }

  /// `POST periods`: de nieuwe periode.
  final int? periodId;

  /// `POST seasons/reopen`: aantal teruggezette rijen.
  final int? moved;

  /// `POST periods/{period}/close`: aantal uitgereikte titels.
  final int? awardCount;
}

/// Antwoord op een schrijvende actie: de nieuwe staat plus `meta`.
class SeasonsResponse {
  const SeasonsResponse(this.data, [this.meta = const SeasonsMeta()]);

  final SeasonsData data;
  final SeasonsMeta meta;
}

/// `PATCH seasons/current`.
class SeasonUpdate {
  const SeasonUpdate({
    required this.label,
    required this.startsOn,
    required this.endsOn,
  });

  final String label;
  final String startsOn;
  final String endsOn;

  Map<String, dynamic> toJson() => {
    'label': label,
    'starts_on': startsOn,
    'ends_on': endsOn,
  };
}

/// `POST periods` (nieuw) of `PATCH periods/{period}` (wijzigen).
///
/// Bij wijzigen gaat alleen mee wat gezet is; [includeEndsOn] en
/// [includeTarget] sturen ook een `null` mee (leegmaken).
class PeriodInput {
  const PeriodInput({
    required this.name,
    this.startsOn,
    this.endsOn,
    this.targetMatches,
    this.includeEndsOn = true,
    this.includeTarget = false,
  });

  final String name;
  final String? startsOn;
  final String? endsOn;
  final int? targetMatches;
  final bool includeEndsOn;
  final bool includeTarget;

  Map<String, dynamic> toJson() => {
    'name': name,
    if (startsOn != null) 'starts_on': startsOn,
    if (includeEndsOn) 'ends_on': endsOn,
    if (includeTarget) 'target_matches': targetMatches,
  };
}
