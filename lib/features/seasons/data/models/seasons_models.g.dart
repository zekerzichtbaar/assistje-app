// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seasons_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Season _$SeasonFromJson(Map<String, dynamic> json) => _Season(
  id: json['id'] == null ? 0 : _int(json['id']),
  label: json['label'] as String? ?? '',
  startsOn: _stringOrNull(json['starts_on']),
  endsOn: _stringOrNull(json['ends_on']),
  isActive: json['is_active'] == null ? false : _bool(json['is_active']),
  expired: json['expired'] == null ? false : _bool(json['expired']),
  matchCount: json['match_count'] == null ? 0 : _int(json['match_count']),
);

Map<String, dynamic> _$SeasonToJson(_Season instance) => <String, dynamic>{
  'id': instance.id,
  'label': instance.label,
  'starts_on': instance.startsOn,
  'ends_on': instance.endsOn,
  'is_active': instance.isActive,
  'expired': instance.expired,
  'match_count': instance.matchCount,
};

_ClosedSeason _$ClosedSeasonFromJson(Map<String, dynamic> json) =>
    _ClosedSeason(
      label: json['label'] as String? ?? '',
      closedAt: _stringOrNull(json['closed_at']),
    );

Map<String, dynamic> _$ClosedSeasonToJson(_ClosedSeason instance) =>
    <String, dynamic>{'label': instance.label, 'closed_at': instance.closedAt};

_SeasonPeriod _$SeasonPeriodFromJson(Map<String, dynamic> json) =>
    _SeasonPeriod(
      id: _int(json['id']),
      name: json['name'] as String? ?? '',
      startsOn: _stringOrNull(json['starts_on']),
      endsOn: _stringOrNull(json['ends_on']),
      targetMatches: _intOrNull(json['target_matches']),
      isClosed: json['is_closed'] == null ? false : _bool(json['is_closed']),
      playedMatches: json['played_matches'] == null
          ? 0
          : _int(json['played_matches']),
      awardCount: json['award_count'] == null ? 0 : _int(json['award_count']),
    );

Map<String, dynamic> _$SeasonPeriodToJson(_SeasonPeriod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'starts_on': instance.startsOn,
      'ends_on': instance.endsOn,
      'target_matches': instance.targetMatches,
      'is_closed': instance.isClosed,
      'played_matches': instance.playedMatches,
      'award_count': instance.awardCount,
    };

_SeasonsData _$SeasonsDataFromJson(Map<String, dynamic> json) => _SeasonsData(
  mode:
      $enumDecodeNullable(
        _$PeriodModeEnumMap,
        json['mode'],
        unknownValue: PeriodMode.off,
      ) ??
      PeriodMode.off,
  modes: json['modes'] == null
      ? const [PeriodMode.off, PeriodMode.dates, PeriodMode.matches]
      : _parseModes(json['modes']),
  season: json['season'] == null
      ? null
      : Season.fromJson(json['season'] as Map<String, dynamic>),
  closedSeason: json['closed_season'] == null
      ? null
      : ClosedSeason.fromJson(json['closed_season'] as Map<String, dynamic>),
  periods:
      (json['periods'] as List<dynamic>?)
          ?.map((e) => SeasonPeriod.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SeasonPeriod>[],
);

Map<String, dynamic> _$SeasonsDataToJson(_SeasonsData instance) =>
    <String, dynamic>{
      'mode': _$PeriodModeEnumMap[instance.mode]!,
      'modes': instance.modes.map((e) => _$PeriodModeEnumMap[e]!).toList(),
      'season': instance.season?.toJson(),
      'closed_season': instance.closedSeason?.toJson(),
      'periods': instance.periods.map((e) => e.toJson()).toList(),
    };

const _$PeriodModeEnumMap = {
  PeriodMode.off: 'off',
  PeriodMode.dates: 'dates',
  PeriodMode.matches: 'matches',
};
