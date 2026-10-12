// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceEvent _$AttendanceEventFromJson(Map<String, dynamic> json) =>
    _AttendanceEvent(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String? ?? '',
      title: json['title'] as String? ?? '',
      startsAt: json['starts_at'] == null
          ? null
          : DateTime.parse(json['starts_at'] as String),
      cancelledAt: json['cancelled_at'] == null
          ? null
          : DateTime.parse(json['cancelled_at'] as String),
      canEdit: json['can_edit'] as bool? ?? false,
    );

Map<String, dynamic> _$AttendanceEventToJson(_AttendanceEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'starts_at': instance.startsAt?.toIso8601String(),
      'cancelled_at': instance.cancelledAt?.toIso8601String(),
      'can_edit': instance.canEdit,
    };

_AttendanceRow _$AttendanceRowFromJson(Map<String, dynamic> json) =>
    _AttendanceRow(
      kind:
          $enumDecodeNullable(
            _$AttendanceRowKindEnumMap,
            json['kind'],
            unknownValue: AttendanceRowKind.unknown,
          ) ??
          AttendanceRowKind.player,
      playerId: (json['player_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      shirtNumber: (json['shirt_number'] as num?)?.toInt(),
      name: json['name'] as String? ?? '',
      position: json['position'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      isGuest: json['is_guest'] as bool? ?? false,
      status:
          $enumDecodeNullable(
            _$AttendanceStatusEnumMap,
            json['status'],
            unknownValue: AttendanceStatus.pending,
          ) ??
          AttendanceStatus.pending,
      vacationNote: json['vacation_note'] as String?,
      standingAbsent: json['standing_absent'] as bool? ?? false,
    );

Map<String, dynamic> _$AttendanceRowToJson(_AttendanceRow instance) =>
    <String, dynamic>{
      'kind': _$AttendanceRowKindEnumMap[instance.kind]!,
      'player_id': instance.playerId,
      'user_id': instance.userId,
      'shirt_number': instance.shirtNumber,
      'name': instance.name,
      'position': instance.position,
      'avatar_url': instance.avatarUrl,
      'is_guest': instance.isGuest,
      'status': _$AttendanceStatusEnumMap[instance.status]!,
      'vacation_note': instance.vacationNote,
      'standing_absent': instance.standingAbsent,
    };

const _$AttendanceRowKindEnumMap = {
  AttendanceRowKind.player: 'player',
  AttendanceRowKind.staff: 'staff',
  AttendanceRowKind.unknown: 'unknown',
};

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.present: 'present',
  AttendanceStatus.absent: 'absent',
  AttendanceStatus.nonplay: 'nonplay',
  AttendanceStatus.pending: 'pending',
};

_EventAttendance _$EventAttendanceFromJson(Map<String, dynamic> json) =>
    _EventAttendance(
      event: AttendanceEvent.fromJson(json['event'] as Map<String, dynamic>),
      rows:
          (json['rows'] as List<dynamic>?)
              ?.map((e) => AttendanceRow.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AttendanceRow>[],
    );

Map<String, dynamic> _$EventAttendanceToJson(_EventAttendance instance) =>
    <String, dynamic>{
      'event': instance.event.toJson(),
      'rows': instance.rows.map((e) => e.toJson()).toList(),
    };

_GuestOption _$GuestOptionFromJson(Map<String, dynamic> json) => _GuestOption(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  shirtNumber: (json['shirt_number'] as num?)?.toInt(),
  position: json['position'] as String?,
);

Map<String, dynamic> _$GuestOptionToJson(_GuestOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shirt_number': instance.shirtNumber,
      'position': instance.position,
    };

_GuestPlayer _$GuestPlayerFromJson(Map<String, dynamic> json) => _GuestPlayer(
  id: (json['id'] as num).toInt(),
  shirtNumber: (json['shirt_number'] as num?)?.toInt(),
  name: json['name'] as String? ?? '',
  position: json['position'] as String?,
  isGuest: json['is_guest'] as bool? ?? true,
  fromTeam: json['from_team'] as String?,
);

Map<String, dynamic> _$GuestPlayerToJson(_GuestPlayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shirt_number': instance.shirtNumber,
      'name': instance.name,
      'position': instance.position,
      'is_guest': instance.isGuest,
      'from_team': instance.fromTeam,
    };
