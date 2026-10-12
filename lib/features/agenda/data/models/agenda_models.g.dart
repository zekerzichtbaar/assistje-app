// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agenda_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceCounts _$AttendanceCountsFromJson(Map<String, dynamic> json) =>
    _AttendanceCounts(
      present: (json['present'] as num?)?.toInt() ?? 0,
      absent: (json['absent'] as num?)?.toInt() ?? 0,
      nonplay: (json['nonplay'] as num?)?.toInt() ?? 0,
      pending: (json['pending'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AttendanceCountsToJson(_AttendanceCounts instance) =>
    <String, dynamic>{
      'present': instance.present,
      'absent': instance.absent,
      'nonplay': instance.nonplay,
      'pending': instance.pending,
    };

_LiveState _$LiveStateFromJson(Map<String, dynamic> json) => _LiveState(
  isLive: json['is_live'] as bool? ?? false,
  running: json['running'] as bool? ?? false,
  startedAt: json['started_at'] == null
      ? null
      : DateTime.parse(json['started_at'] as String),
  accumulatedSeconds: (json['accumulated_seconds'] as num?)?.toInt() ?? 0,
  endedAt: json['ended_at'] == null
      ? null
      : DateTime.parse(json['ended_at'] as String),
  period: (json['period'] as num?)?.toInt() ?? 1,
  periodEnds:
      (json['period_ends'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
);

Map<String, dynamic> _$LiveStateToJson(_LiveState instance) =>
    <String, dynamic>{
      'is_live': instance.isLive,
      'running': instance.running,
      'started_at': instance.startedAt?.toIso8601String(),
      'accumulated_seconds': instance.accumulatedSeconds,
      'ended_at': instance.endedAt?.toIso8601String(),
      'period': instance.period,
      'period_ends': instance.periodEnds,
    };

_AgendaEvent _$AgendaEventFromJson(Map<String, dynamic> json) => _AgendaEvent(
  id: (json['id'] as num).toInt(),
  type:
      $enumDecodeNullable(
        _$EventTypeEnumMap,
        json['type'],
        unknownValue: EventType.unknown,
      ) ??
      EventType.unknown,
  title: json['title'] as String? ?? '',
  startsAt: DateTime.parse(json['starts_at'] as String),
  endsAt: json['ends_at'] == null
      ? null
      : DateTime.parse(json['ends_at'] as String),
  meetAt: json['meet_at'] == null
      ? null
      : DateTime.parse(json['meet_at'] as String),
  venue: json['venue'] as String?,
  homeTeam: json['home_team'] as String?,
  awayTeam: json['away_team'] as String?,
  competition: json['competition'] as String?,
  homeScore: (json['home_score'] as num?)?.toInt(),
  awayScore: (json['away_score'] as num?)?.toInt(),
  cancelledAt: json['cancelled_at'] == null
      ? null
      : DateTime.parse(json['cancelled_at'] as String),
  myStatus: $enumDecodeNullable(
    _$AttendanceStatusEnumMap,
    json['my_status'],
    unknownValue: AttendanceStatus.pending,
  ),
  counts: json['counts'] == null
      ? const AttendanceCounts()
      : AttendanceCounts.fromJson(json['counts'] as Map<String, dynamic>),
  playerCounts: json['player_counts'] == null
      ? null
      : AttendanceCounts.fromJson(
          json['player_counts'] as Map<String, dynamic>,
        ),
  guestCounts: json['guest_counts'] == null
      ? const AttendanceCounts()
      : AttendanceCounts.fromJson(json['guest_counts'] as Map<String, dynamic>),
  live: json['live'] == null
      ? null
      : LiveState.fromJson(json['live'] as Map<String, dynamic>),
  inVacation: json['in_vacation'] as bool? ?? false,
  canRsvp: json['can_rsvp'] as bool?,
  rsvpStatuses:
      (json['rsvp_statuses'] as List<dynamic>?)
          ?.map(
            (e) => $enumDecode(
              _$AttendanceStatusEnumMap,
              e,
              unknownValue: AttendanceStatus.pending,
            ),
          )
          .toList() ??
      const <AttendanceStatus>[
        AttendanceStatus.present,
        AttendanceStatus.absent,
        AttendanceStatus.nonplay,
      ],
  spectatorsCanRsvp: json['spectators_can_rsvp'] as bool? ?? false,
  spectatorsPresent: (json['spectators_present'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AgendaEventToJson(_AgendaEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$EventTypeEnumMap[instance.type]!,
      'title': instance.title,
      'starts_at': instance.startsAt.toIso8601String(),
      'ends_at': instance.endsAt?.toIso8601String(),
      'meet_at': instance.meetAt?.toIso8601String(),
      'venue': instance.venue,
      'home_team': instance.homeTeam,
      'away_team': instance.awayTeam,
      'competition': instance.competition,
      'home_score': instance.homeScore,
      'away_score': instance.awayScore,
      'cancelled_at': instance.cancelledAt?.toIso8601String(),
      'my_status': _$AttendanceStatusEnumMap[instance.myStatus],
      'counts': instance.counts.toJson(),
      'player_counts': instance.playerCounts?.toJson(),
      'guest_counts': instance.guestCounts.toJson(),
      'live': instance.live?.toJson(),
      'in_vacation': instance.inVacation,
      'can_rsvp': instance.canRsvp,
      'rsvp_statuses': instance.rsvpStatuses
          .map((e) => _$AttendanceStatusEnumMap[e]!)
          .toList(),
      'spectators_can_rsvp': instance.spectatorsCanRsvp,
      'spectators_present': instance.spectatorsPresent,
    };

const _$EventTypeEnumMap = {
  EventType.match: 'match',
  EventType.training: 'training',
  EventType.activity: 'activity',
  EventType.unknown: 'unknown',
};

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.present: 'present',
  AttendanceStatus.absent: 'absent',
  AttendanceStatus.nonplay: 'nonplay',
  AttendanceStatus.pending: 'pending',
};

_AgendaDuty _$AgendaDutyFromJson(Map<String, dynamic> json) => _AgendaDuty(
  kind: json['kind'] as String? ?? 'duty',
  dutyId: (json['duty_id'] as num?)?.toInt(),
  washId: (json['wash_id'] as num?)?.toInt(),
  eventId: (json['event_id'] as num?)?.toInt(),
  matchBound: json['match_bound'] as bool? ?? false,
  date: json['date'] as String,
  dutyType: json['duty_type'] as String? ?? '',
  icon: json['icon'] as String?,
  title: json['title'] as String? ?? '',
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
);

Map<String, dynamic> _$AgendaDutyToJson(_AgendaDuty instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'duty_id': instance.dutyId,
      'wash_id': instance.washId,
      'event_id': instance.eventId,
      'match_bound': instance.matchBound,
      'date': instance.date,
      'duty_type': instance.dutyType,
      'icon': instance.icon,
      'title': instance.title,
      'group_name': instance.groupName,
      'player_names': instance.playerNames,
      'time_range': instance.timeRange,
      'starts_at': instance.startsAt,
      'ends_at': instance.endsAt,
      'notes': instance.notes,
      'done': instance.done,
      'mine': instance.mine,
    };

_AgendaBirthday _$AgendaBirthdayFromJson(Map<String, dynamic> json) =>
    _AgendaBirthday(
      key: json['key'] as String,
      playerId: (json['player_id'] as num?)?.toInt(),
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String?,
      date: json['date'] as String,
      turning: (json['turning'] as num?)?.toInt(),
      isToday: json['is_today'] as bool? ?? false,
    );

Map<String, dynamic> _$AgendaBirthdayToJson(_AgendaBirthday instance) =>
    <String, dynamic>{
      'key': instance.key,
      'player_id': instance.playerId,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'date': instance.date,
      'turning': instance.turning,
      'is_today': instance.isToday,
    };

_DutyTypeMeta _$DutyTypeMetaFromJson(Map<String, dynamic> json) =>
    _DutyTypeMeta(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$DutyTypeMetaToJson(_DutyTypeMeta instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'icon': instance.icon,
    };

_AgendaMe _$AgendaMeFromJson(Map<String, dynamic> json) => _AgendaMe(
  isGuest: json['is_guest'] as bool? ?? false,
  isStaff: json['is_staff'] as bool? ?? false,
  isInjured: json['is_injured'] as bool? ?? false,
  isOnVacation: json['is_on_vacation'] as bool? ?? false,
);

Map<String, dynamic> _$AgendaMeToJson(_AgendaMe instance) => <String, dynamic>{
  'is_guest': instance.isGuest,
  'is_staff': instance.isStaff,
  'is_injured': instance.isInjured,
  'is_on_vacation': instance.isOnVacation,
};

_AgendaData _$AgendaDataFromJson(Map<String, dynamic> json) => _AgendaData(
  canRsvp: json['can_rsvp'] as bool? ?? false,
  me: json['me'] == null
      ? null
      : AgendaMe.fromJson(json['me'] as Map<String, dynamic>),
  upcoming:
      (json['upcoming'] as List<dynamic>?)
          ?.map((e) => AgendaEvent.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AgendaEvent>[],
  past:
      (json['past'] as List<dynamic>?)
          ?.map((e) => AgendaEvent.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AgendaEvent>[],
  upcomingDuties:
      (json['upcoming_duties'] as List<dynamic>?)
          ?.map((e) => AgendaDuty.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AgendaDuty>[],
  pastDuties:
      (json['past_duties'] as List<dynamic>?)
          ?.map((e) => AgendaDuty.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AgendaDuty>[],
  myTasks:
      (json['my_tasks'] as List<dynamic>?)
          ?.map((e) => AgendaDuty.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AgendaDuty>[],
  birthdays:
      (json['birthdays'] as List<dynamic>?)
          ?.map((e) => AgendaBirthday.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <AgendaBirthday>[],
  dutyTypes:
      (json['duty_types'] as List<dynamic>?)
          ?.map((e) => DutyTypeMeta.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <DutyTypeMeta>[],
  hasMatches: json['has_matches'] as bool? ?? false,
  hasTrainings: json['has_trainings'] as bool? ?? false,
  agendaFeedUrl: json['agenda_feed_url'] as String?,
  needsSchedule: json['needs_schedule'] as bool? ?? false,
  canFetchSchedule: json['can_fetch_schedule'] as bool? ?? false,
  scheduleRequest: json['schedule_request'] as String?,
  scheduleFeed: json['schedule_feed'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$AgendaDataToJson(
  _AgendaData instance,
) => <String, dynamic>{
  'can_rsvp': instance.canRsvp,
  'me': instance.me?.toJson(),
  'upcoming': instance.upcoming.map((e) => e.toJson()).toList(),
  'past': instance.past.map((e) => e.toJson()).toList(),
  'upcoming_duties': instance.upcomingDuties.map((e) => e.toJson()).toList(),
  'past_duties': instance.pastDuties.map((e) => e.toJson()).toList(),
  'my_tasks': instance.myTasks.map((e) => e.toJson()).toList(),
  'birthdays': instance.birthdays.map((e) => e.toJson()).toList(),
  'duty_types': instance.dutyTypes.map((e) => e.toJson()).toList(),
  'has_matches': instance.hasMatches,
  'has_trainings': instance.hasTrainings,
  'agenda_feed_url': instance.agendaFeedUrl,
  'needs_schedule': instance.needsSchedule,
  'can_fetch_schedule': instance.canFetchSchedule,
  'schedule_request': instance.scheduleRequest,
  'schedule_feed': instance.scheduleFeed,
};

_AgendaMeta _$AgendaMetaFromJson(Map<String, dynamic> json) => _AgendaMeta(
  limit: (json['limit'] as num?)?.toInt() ?? 30,
  pageSize: (json['page_size'] as num?)?.toInt() ?? 30,
  upcomingTotal: (json['upcoming_total'] as num?)?.toInt() ?? 0,
  pastTotal: (json['past_total'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$AgendaMetaToJson(_AgendaMeta instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'page_size': instance.pageSize,
      'upcoming_total': instance.upcomingTotal,
      'past_total': instance.pastTotal,
    };

_AttendanceResult _$AttendanceResultFromJson(Map<String, dynamic> json) =>
    _AttendanceResult(
      eventId: (json['event_id'] as num).toInt(),
      playerId: (json['player_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      status: $enumDecode(
        _$AttendanceStatusEnumMap,
        json['status'],
        unknownValue: AttendanceStatus.pending,
      ),
      reason: json['reason'] as String?,
      respondedAt: json['responded_at'] == null
          ? null
          : DateTime.parse(json['responded_at'] as String),
      changedByUserId: (json['changed_by_user_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AttendanceResultToJson(_AttendanceResult instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'player_id': instance.playerId,
      'user_id': instance.userId,
      'status': _$AttendanceStatusEnumMap[instance.status]!,
      'reason': instance.reason,
      'responded_at': instance.respondedAt?.toIso8601String(),
      'changed_by_user_id': instance.changedByUserId,
    };
