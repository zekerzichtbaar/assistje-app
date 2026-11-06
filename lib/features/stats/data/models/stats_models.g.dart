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
  matchesPresent: json['matches_present'] == null
      ? 0
      : readInt(json['matches_present']),
  minutesPerMatch: json['minutes_per_match'] == null
      ? 0
      : readInt(json['minutes_per_match']),
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
  recentForm:
      (json['recent_form'] as List<dynamic>?)
          ?.map((e) => StatsFormEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <StatsFormEntry>[],
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
  'matches_present': instance.matchesPresent,
  'minutes_per_match': instance.minutesPerMatch,
  'flag_minutes': instance.flagMinutes,
  'flag_shifts': instance.flagShifts,
  'titles': instance.titles.map((e) => e.toJson()).toList(),
  'training_points': instance.trainingPoints,
  'recent_form': instance.recentForm.map((e) => e.toJson()).toList(),
};

_StatsFormEntry _$StatsFormEntryFromJson(Map<String, dynamic> json) =>
    _StatsFormEntry(
      eventId: readIntOrNull(json['event_id']),
      type: json['type'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
    );

Map<String, dynamic> _$StatsFormEntryToJson(_StatsFormEntry instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'type': instance.type,
      'status': instance.status,
    };

_StatsPeriod _$StatsPeriodFromJson(Map<String, dynamic> json) => _StatsPeriod(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  isClosed: json['is_closed'] as bool? ?? false,
);

Map<String, dynamic> _$StatsPeriodToJson(_StatsPeriod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_closed': instance.isClosed,
    };

_TeamStats _$TeamStatsFromJson(Map<String, dynamic> json) => _TeamStats(
  window: readStringOrNull(json['window']),
  periods:
      (json['periods'] as List<dynamic>?)
          ?.map((e) => StatsPeriod.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <StatsPeriod>[],
  periodId: readIntOrNull(json['period_id']),
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
      'periods': instance.periods.map((e) => e.toJson()).toList(),
      'period_id': instance.periodId,
      'season_id': instance.seasonId,
      'seasons': instance.seasons.map((e) => e.toJson()).toList(),
      'my_player_id': instance.myPlayerId,
      'rows': instance.rows.map((e) => e.toJson()).toList(),
    };
