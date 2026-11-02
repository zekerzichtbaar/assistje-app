// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duty_overview_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DutyOverviewRow _$DutyOverviewRowFromJson(Map<String, dynamic> json) =>
    _DutyOverviewRow(
      dutyId: (json['duty_id'] as num).toInt(),
      dutyTypeId: (json['duty_type_id'] as num?)?.toInt(),
      eventId: (json['event_id'] as num?)?.toInt(),
      matchBound: json['match_bound'] as bool? ?? false,
      date: json['date'] as String? ?? '',
      dutyType: json['duty_type'] as String?,
      title: json['title'] as String? ?? '',
      icon: json['icon'] as String?,
      groupName: json['group_name'] as String?,
      playerNames:
          (json['player_names'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      timeRange: json['time_range'] as String?,
      startsAt: json['starts_at'] as String?,
      endsAt: json['ends_at'] as String?,
      notes: json['notes'] as String?,
      done: json['done'] as bool? ?? false,
      mine: json['mine'] as bool? ?? false,
      eventLabel: json['event_label'] as String?,
    );

Map<String, dynamic> _$DutyOverviewRowToJson(_DutyOverviewRow instance) =>
    <String, dynamic>{
      'duty_id': instance.dutyId,
      'duty_type_id': instance.dutyTypeId,
      'event_id': instance.eventId,
      'match_bound': instance.matchBound,
      'date': instance.date,
      'duty_type': instance.dutyType,
      'title': instance.title,
      'icon': instance.icon,
      'group_name': instance.groupName,
      'player_names': instance.playerNames,
      'time_range': instance.timeRange,
      'starts_at': instance.startsAt,
      'ends_at': instance.endsAt,
      'notes': instance.notes,
      'done': instance.done,
      'mine': instance.mine,
      'event_label': instance.eventLabel,
    };

_DutyOverviewGroup _$DutyOverviewGroupFromJson(Map<String, dynamic> json) =>
    _DutyOverviewGroup(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      mine: json['mine'] as bool? ?? false,
    );

Map<String, dynamic> _$DutyOverviewGroupToJson(_DutyOverviewGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'members': instance.members,
      'mine': instance.mine,
    };

_DutyOverviewType _$DutyOverviewTypeFromJson(Map<String, dynamic> json) =>
    _DutyOverviewType(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String?,
      mode: json['mode'] as String? ?? 'individual',
      upcoming:
          (json['upcoming'] as List<dynamic>?)
              ?.map((e) => DutyOverviewRow.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DutyOverviewRow>[],
      upcomingTotal: (json['upcoming_total'] as num?)?.toInt() ?? 0,
      groups:
          (json['groups'] as List<dynamic>?)
              ?.map(
                (e) => DutyOverviewGroup.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <DutyOverviewGroup>[],
    );

Map<String, dynamic> _$DutyOverviewTypeToJson(_DutyOverviewType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'mode': instance.mode,
      'upcoming': instance.upcoming.map((e) => e.toJson()).toList(),
      'upcoming_total': instance.upcomingTotal,
      'groups': instance.groups.map((e) => e.toJson()).toList(),
    };

_DutyOverview _$DutyOverviewFromJson(Map<String, dynamic> json) =>
    _DutyOverview(
      mine:
          (json['mine'] as List<dynamic>?)
              ?.map((e) => DutyOverviewRow.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DutyOverviewRow>[],
      duties:
          (json['duties'] as List<dynamic>?)
              ?.map((e) => DutyOverviewType.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DutyOverviewType>[],
    );

Map<String, dynamic> _$DutyOverviewToJson(_DutyOverview instance) =>
    <String, dynamic>{
      'mine': instance.mine.map((e) => e.toJson()).toList(),
      'duties': instance.duties.map((e) => e.toJson()).toList(),
    };
