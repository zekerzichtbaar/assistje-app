// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SeasonOption _$SeasonOptionFromJson(Map<String, dynamic> json) =>
    _SeasonOption(
      id: (json['id'] as num).toInt(),
      label: json['label'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? false,
    );

Map<String, dynamic> _$SeasonOptionToJson(_SeasonOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'is_active': instance.isActive,
    };

_StatsTitle _$StatsTitleFromJson(Map<String, dynamic> json) => _StatsTitle(
  key: json['key'] as String? ?? '',
  icon: json['icon'] as String? ?? '',
  label: json['label'] as String? ?? '',
);

Map<String, dynamic> _$StatsTitleToJson(_StatsTitle instance) =>
    <String, dynamic>{
      'key': instance.key,
      'icon': instance.icon,
      'label': instance.label,
    };

_StatsRow _$StatsRowFromJson(Map<String, dynamic> json) => _StatsRow(
  playerId: readInt(json['player_id']),
  name: json['name'] as String? ?? '',
  shirtNumber: readIntOrNull(json['shirt_number']),
  position: json['position'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  attendanceRate: json['attendance_rate'] == null
      ? 0
      : readDouble(json['attendance_rate']),
  attendanceMatchRate: json['attendance_match_rate'] == null
      ? 0
      : readDouble(json['attendance_match_rate']),
  attendanceTrainingRate: json['attendance_training_rate'] == null
      ? 0
      : readDouble(json['attendance_training_rate']),
  minutes: json['minutes'] == null ? 0 : readInt(json['minutes']),
  goals: json['goals'] == null ? 0 : readInt(json['goals']),
  assists: json['assists'] == null ? 0 : readInt(json['assists']),
  yellow: json['yellow'] == null ? 0 : readInt(json['yellow']),
  red: json['red'] == null ? 0 : readInt(json['red']),
  matchesPlayed: json['matches_played'] == null
      ? 0
      : readInt(json['matches_played']),
  flagMinutes: json['flag_minutes'] == null ? 0 : readInt(json['flag_minutes']),
  flagShifts: json['flag_shifts'] == null ? 0 : readInt(json['flag_shifts']),
  titles:
      (json['titles'] as List<dynamic>?)
          ?.map((e) => StatsTitle.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <StatsTitle>[],
  trainingPoints: json['training_points'] == null
      ? 0
      : readInt(json['training_points']),
);

Map<String, dynamic> _$StatsRowToJson(_StatsRow instance) => <String, dynamic>{
  'player_id': instance.playerId,
  'name': instance.name,
  'shirt_number': instance.shirtNumber,
  'position': instance.position,
  'avatar_url': instance.avatarUrl,
  'attendance_rate': instance.attendanceRate,
  'attendance_match_rate': instance.attendanceMatchRate,
  'attendance_training_rate': instance.attendanceTrainingRate,
  'minutes': instance.minutes,
  'goals': instance.goals,
  'assists': instance.assists,
  'yellow': instance.yellow,
  'red': instance.red,
  'matches_played': instance.matchesPlayed,
  'flag_minutes': instance.flagMinutes,
  'flag_shifts': instance.flagShifts,
  'titles': instance.titles.map((e) => e.toJson()).toList(),
  'training_points': instance.trainingPoints,
};

_TeamStats _$TeamStatsFromJson(Map<String, dynamic> json) => _TeamStats(
  window: readStringOrNull(json['window']),
  seasonId: readIntOrNull(json['season_id']),
  seasons:
      (json['seasons'] as List<dynamic>?)
          ?.map((e) => SeasonOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SeasonOption>[],
  myPlayerId: readIntOrNull(json['my_player_id']),
  rows:
      (json['rows'] as List<dynamic>?)
          ?.map((e) => StatsRow.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <StatsRow>[],
);

Map<String, dynamic> _$TeamStatsToJson(_TeamStats instance) =>
    <String, dynamic>{
      'window': instance.window,
      'season_id': instance.seasonId,
      'seasons': instance.seasons.map((e) => e.toJson()).toList(),
      'my_player_id': instance.myPlayerId,
      'rows': instance.rows.map((e) => e.toJson()).toList(),
    };
