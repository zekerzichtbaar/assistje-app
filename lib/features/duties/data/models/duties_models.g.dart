// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duties_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DutyTypeSummary _$DutyTypeSummaryFromJson(Map<String, dynamic> json) =>
    _DutyTypeSummary(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      icon: json['icon'] as String?,
      mode: json['mode'] as String? ?? 'individual',
      scope: json['scope'] as String? ?? 'free',
      autoRotate: json['auto_rotate'] as bool? ?? false,
    );

Map<String, dynamic> _$DutyTypeSummaryToJson(_DutyTypeSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'icon': instance.icon,
      'mode': instance.mode,
      'scope': instance.scope,
      'auto_rotate': instance.autoRotate,
    };

_DutyMember _$DutyMemberFromJson(Map<String, dynamic> json) => _DutyMember(
  key: json['key'] as String,
  name: json['name'] as String? ?? '',
);

Map<String, dynamic> _$DutyMemberToJson(_DutyMember instance) =>
    <String, dynamic>{'key': instance.key, 'name': instance.name};

_DutyGroup _$DutyGroupFromJson(Map<String, dynamic> json) => _DutyGroup(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  lastAssignedAt: json['last_assigned_at'] == null
      ? null
      : DateTime.parse(json['last_assigned_at'] as String),
  count: (json['count'] as num?)?.toInt() ?? 0,
  members:
      (json['members'] as List<dynamic>?)
          ?.map((e) => DutyMember.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DutyMember>[],
  dutyTypeId: (json['duty_type_id'] as num?)?.toInt(),
  sortOrder: (json['sort_order'] as num?)?.toInt(),
);

Map<String, dynamic> _$DutyGroupToJson(_DutyGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'last_assigned_at': instance.lastAssignedAt?.toIso8601String(),
      'count': instance.count,
      'members': instance.members.map((e) => e.toJson()).toList(),
      'duty_type_id': instance.dutyTypeId,
      'sort_order': instance.sortOrder,
    };

_DutyAssignment _$DutyAssignmentFromJson(Map<String, dynamic> json) =>
    _DutyAssignment(
      id: (json['id'] as num).toInt(),
      scheduledFor: json['scheduled_for'] as String? ?? '',
      startsAt: json['starts_at'] as String?,
      endsAt: json['ends_at'] as String?,
      notes: json['notes'] as String?,
      groupId: (json['group_id'] as num?)?.toInt(),
      groupName: json['group_name'] as String?,
      playerId: (json['player_id'] as num?)?.toInt(),
      memberKey: json['member_key'] as String?,
      playerName: json['player_name'] as String?,
      eventId: (json['event_id'] as num?)?.toInt(),
      eventLabel: json['event_label'] as String?,
      markedDoneAt: json['marked_done_at'] == null
          ? null
          : DateTime.parse(json['marked_done_at'] as String),
      dutyTypeId: (json['duty_type_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DutyAssignmentToJson(_DutyAssignment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'scheduled_for': instance.scheduledFor,
      'starts_at': instance.startsAt,
      'ends_at': instance.endsAt,
      'notes': instance.notes,
      'group_id': instance.groupId,
      'group_name': instance.groupName,
      'player_id': instance.playerId,
      'member_key': instance.memberKey,
      'player_name': instance.playerName,
      'event_id': instance.eventId,
      'event_label': instance.eventLabel,
      'marked_done_at': instance.markedDoneAt?.toIso8601String(),
      'duty_type_id': instance.dutyTypeId,
    };

_DutyPerson _$DutyPersonFromJson(Map<String, dynamic> json) => _DutyPerson(
  key: json['key'] as String,
  name: json['name'] as String? ?? '',
  kind: json['kind'] as String? ?? 'player',
  isTrainerOnly: json['is_trainer_only'] as bool? ?? false,
  count: (json['count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$DutyPersonToJson(_DutyPerson instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'kind': instance.kind,
      'is_trainer_only': instance.isTrainerOnly,
      'count': instance.count,
    };

_DutyMatch _$DutyMatchFromJson(Map<String, dynamic> json) => _DutyMatch(
  id: (json['id'] as num).toInt(),
  label: json['label'] as String? ?? '',
  date: json['date'] as String? ?? '',
  startsAt: json['starts_at'] == null
      ? null
      : DateTime.parse(json['starts_at'] as String),
);

Map<String, dynamic> _$DutyMatchToJson(_DutyMatch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'date': instance.date,
      'starts_at': instance.startsAt?.toIso8601String(),
    };

_DutiesOverview _$DutiesOverviewFromJson(Map<String, dynamic> json) =>
    _DutiesOverview(
      type: json['type'] as String? ?? '',
      dutyTypeId: (json['duty_type_id'] as num).toInt(),
      dutyTypeMode: json['duty_type_mode'] as String? ?? 'individual',
      dutyTypeScope: json['duty_type_scope'] as String? ?? 'free',
      dutyTypeAutoRotate: json['duty_type_auto_rotate'] as bool? ?? false,
      dutyTypePool:
          (json['duty_type_pool'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      dutyTypes:
          (json['duty_types'] as List<dynamic>?)
              ?.map((e) => DutyTypeSummary.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DutyTypeSummary>[],
      groups:
          (json['groups'] as List<dynamic>?)
              ?.map((e) => DutyGroup.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DutyGroup>[],
      assignments:
          (json['assignments'] as List<dynamic>?)
              ?.map((e) => DutyAssignment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DutyAssignment>[],
      allPeople:
          (json['all_people'] as List<dynamic>?)
              ?.map((e) => DutyPerson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DutyPerson>[],
      poolPeople:
          (json['pool_people'] as List<dynamic>?)
              ?.map((e) => DutyPerson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DutyPerson>[],
      matches:
          (json['matches'] as List<dynamic>?)
              ?.map((e) => DutyMatch.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DutyMatch>[],
    );

Map<String, dynamic> _$DutiesOverviewToJson(_DutiesOverview instance) =>
    <String, dynamic>{
      'type': instance.type,
      'duty_type_id': instance.dutyTypeId,
      'duty_type_mode': instance.dutyTypeMode,
      'duty_type_scope': instance.dutyTypeScope,
      'duty_type_auto_rotate': instance.dutyTypeAutoRotate,
      'duty_type_pool': instance.dutyTypePool,
      'duty_types': instance.dutyTypes.map((e) => e.toJson()).toList(),
      'groups': instance.groups.map((e) => e.toJson()).toList(),
      'assignments': instance.assignments.map((e) => e.toJson()).toList(),
      'all_people': instance.allPeople.map((e) => e.toJson()).toList(),
      'pool_people': instance.poolPeople.map((e) => e.toJson()).toList(),
      'matches': instance.matches.map((e) => e.toJson()).toList(),
    };
