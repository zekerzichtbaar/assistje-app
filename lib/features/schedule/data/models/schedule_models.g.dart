// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScheduleChoice _$ScheduleChoiceFromJson(Map<String, dynamic> json) =>
    _ScheduleChoice(
      value: json['value'] as String,
      label: json['label'] as String? ?? '',
    );

Map<String, dynamic> _$ScheduleChoiceToJson(_ScheduleChoice instance) =>
    <String, dynamic>{'value': instance.value, 'label': instance.label};

_ScheduleDefaults _$ScheduleDefaultsFromJson(Map<String, dynamic> json) =>
    _ScheduleDefaults(
      type: json['type'] as String? ?? 'training',
      trainingStartTime: json['training_start_time'] as String? ?? '19:00',
      competition: json['competition'] as String? ?? 'league',
      isHome: json['is_home'] as bool? ?? true,
      durationMinutes: json['duration_minutes'] == null
          ? const <String, int>{}
          : _durationsFromJson(json['duration_minutes']),
    );

Map<String, dynamic> _$ScheduleDefaultsToJson(_ScheduleDefaults instance) =>
    <String, dynamic>{
      'type': instance.type,
      'training_start_time': instance.trainingStartTime,
      'competition': instance.competition,
      'is_home': instance.isHome,
      'duration_minutes': instance.durationMinutes,
    };

_ScheduleOptions _$ScheduleOptionsFromJson(Map<String, dynamic> json) =>
    _ScheduleOptions(
      teamName: json['team_name'] as String? ?? '',
      timezone: json['timezone'] as String? ?? 'Europe/Amsterdam',
      types:
          (json['types'] as List<dynamic>?)
              ?.map((e) => ScheduleChoice.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ScheduleChoice>[],
      competitions:
          (json['competitions'] as List<dynamic>?)
              ?.map((e) => ScheduleChoice.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ScheduleChoice>[],
      defaults: json['defaults'] == null
          ? const ScheduleDefaults()
          : ScheduleDefaults.fromJson(json['defaults'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScheduleOptionsToJson(_ScheduleOptions instance) =>
    <String, dynamic>{
      'team_name': instance.teamName,
      'timezone': instance.timezone,
      'types': instance.types.map((e) => e.toJson()).toList(),
      'competitions': instance.competitions.map((e) => e.toJson()).toList(),
      'defaults': instance.defaults.toJson(),
    };

_ScheduleEvent _$ScheduleEventFromJson(Map<String, dynamic> json) =>
    _ScheduleEvent(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? 'training',
      title: json['title'] as String? ?? '',
      startsAt: DateTime.parse(json['starts_at'] as String),
      endsAt: json['ends_at'] == null
          ? null
          : DateTime.parse(json['ends_at'] as String),
      meetAt: json['meet_at'] == null
          ? null
          : DateTime.parse(json['meet_at'] as String),
      venue: json['venue'] as String?,
      notes: json['notes'] as String?,
      isHome: json['is_home'] as bool?,
      competition: json['competition'] as String?,
      homeTeam: json['home_team'] as String?,
      awayTeam: json['away_team'] as String?,
      cancelledAt: json['cancelled_at'] == null
          ? null
          : DateTime.parse(json['cancelled_at'] as String),
      canCancel: json['can_cancel'] as bool? ?? false,
      spectatorsCanRsvp: json['spectators_can_rsvp'] as bool? ?? false,
    );

Map<String, dynamic> _$ScheduleEventToJson(_ScheduleEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'starts_at': instance.startsAt.toIso8601String(),
      'ends_at': instance.endsAt?.toIso8601String(),
      'meet_at': instance.meetAt?.toIso8601String(),
      'venue': instance.venue,
      'notes': instance.notes,
      'is_home': instance.isHome,
      'competition': instance.competition,
      'home_team': instance.homeTeam,
      'away_team': instance.awayTeam,
      'cancelled_at': instance.cancelledAt?.toIso8601String(),
      'can_cancel': instance.canCancel,
      'spectators_can_rsvp': instance.spectatorsCanRsvp,
    };
