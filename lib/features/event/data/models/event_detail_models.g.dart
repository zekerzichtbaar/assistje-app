// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_detail_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SportlinkInfo _$SportlinkInfoFromJson(Map<String, dynamic> json) =>
    _SportlinkInfo(
      field: json['field'] as String?,
      dressingRoom: json['dressing_room'] as String?,
      referee: json['referee'] as String?,
    );

Map<String, dynamic> _$SportlinkInfoToJson(_SportlinkInfo instance) =>
    <String, dynamic>{
      'field': instance.field,
      'dressing_room': instance.dressingRoom,
      'referee': instance.referee,
    };

_EventPlayer _$EventPlayerFromJson(Map<String, dynamic> json) => _EventPlayer(
  id: (json['id'] as num).toInt(),
  kind:
      $enumDecodeNullable(
        _$EventPlayerKindEnumMap,
        json['kind'],
        unknownValue: EventPlayerKind.unknown,
      ) ??
      EventPlayerKind.player,
  rowKey: json['row_key'] as String?,
  name: json['name'] as String? ?? '',
  avatarUrl: json['avatar_url'] as String?,
  shirtNumber: (json['shirt_number'] as num?)?.toInt(),
  isGuest: json['is_guest'] as bool? ?? false,
  isInjured: json['is_injured'] as bool? ?? false,
  isOnVacation: json['is_on_vacation'] as bool? ?? false,
  status:
      $enumDecodeNullable(
        _$AttendanceStatusEnumMap,
        json['status'],
        unknownValue: AttendanceStatus.pending,
      ) ??
      AttendanceStatus.pending,
  reason: json['reason'] as String?,
  isMe: json['is_me'] as bool? ?? false,
  isCaptain: json['is_captain'] as bool? ?? false,
  isKeeper: json['is_keeper'] as bool? ?? false,
);

Map<String, dynamic> _$EventPlayerToJson(_EventPlayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': _$EventPlayerKindEnumMap[instance.kind]!,
      'row_key': instance.rowKey,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'shirt_number': instance.shirtNumber,
      'is_guest': instance.isGuest,
      'is_injured': instance.isInjured,
      'is_on_vacation': instance.isOnVacation,
      'status': _$AttendanceStatusEnumMap[instance.status]!,
      'reason': instance.reason,
      'is_me': instance.isMe,
      'is_captain': instance.isCaptain,
      'is_keeper': instance.isKeeper,
    };

const _$EventPlayerKindEnumMap = {
  EventPlayerKind.player: 'player',
  EventPlayerKind.staff: 'staff',
  EventPlayerKind.guest: 'guest',
  EventPlayerKind.spectator: 'spectator',
  EventPlayerKind.unknown: 'unknown',
};

const _$AttendanceStatusEnumMap = {
  AttendanceStatus.present: 'present',
  AttendanceStatus.absent: 'absent',
  AttendanceStatus.nonplay: 'nonplay',
  AttendanceStatus.pending: 'pending',
};

_MotmCandidate _$MotmCandidateFromJson(Map<String, dynamic> json) =>
    _MotmCandidate(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      shirtNumber: (json['shirt_number'] as num?)?.toInt(),
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$MotmCandidateToJson(_MotmCandidate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shirt_number': instance.shirtNumber,
      'avatar_url': instance.avatarUrl,
    };

_MotmTally _$MotmTallyFromJson(Map<String, dynamic> json) => _MotmTally(
  playerId: (json['player_id'] as num).toInt(),
  votes: (json['votes'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$MotmTallyToJson(_MotmTally instance) =>
    <String, dynamic>{'player_id': instance.playerId, 'votes': instance.votes};

_MotmState _$MotmStateFromJson(Map<String, dynamic> json) => _MotmState(
  isOpen: json['is_open'] as bool? ?? false,
  opensAfter: json['opens_after'] as bool? ?? false,
  closesAt: json['closes_at'] == null
      ? null
      : DateTime.parse(json['closes_at'] as String),
  eligible:
      (json['eligible'] as List<dynamic>?)
          ?.map((e) => MotmCandidate.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MotmCandidate>[],
  tally:
      (json['tally'] as List<dynamic>?)
          ?.map((e) => MotmTally.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <MotmTally>[],
  myVote: (json['my_vote'] as num?)?.toInt(),
  canVote: json['can_vote'] as bool? ?? true,
  selfId: (json['self_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$MotmStateToJson(_MotmState instance) =>
    <String, dynamic>{
      'is_open': instance.isOpen,
      'opens_after': instance.opensAfter,
      'closes_at': instance.closesAt?.toIso8601String(),
      'eligible': instance.eligible.map((e) => e.toJson()).toList(),
      'tally': instance.tally.map((e) => e.toJson()).toList(),
      'my_vote': instance.myVote,
      'can_vote': instance.canVote,
      'self_id': instance.selfId,
    };

_MotmVoteResult _$MotmVoteResultFromJson(Map<String, dynamic> json) =>
    _MotmVoteResult(
      eventId: (json['event_id'] as num).toInt(),
      myVote: (json['my_vote'] as num?)?.toInt(),
      isOpen: json['is_open'] as bool? ?? false,
      closesAt: json['closes_at'] == null
          ? null
          : DateTime.parse(json['closes_at'] as String),
    );

Map<String, dynamic> _$MotmVoteResultToJson(_MotmVoteResult instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'my_vote': instance.myVote,
      'is_open': instance.isOpen,
      'closes_at': instance.closesAt?.toIso8601String(),
    };

_CarpoolOffer _$CarpoolOfferFromJson(Map<String, dynamic> json) =>
    _CarpoolOffer(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      userName: json['user_name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      mode:
          $enumDecodeNullable(
            _$CarpoolModeEnumMap,
            json['mode'],
            unknownValue: CarpoolMode.direct,
          ) ??
          CarpoolMode.direct,
      seats: (json['seats'] as num?)?.toInt(),
      isSelf: json['is_self'] as bool? ?? false,
    );

Map<String, dynamic> _$CarpoolOfferToJson(_CarpoolOffer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'avatar_url': instance.avatarUrl,
      'mode': _$CarpoolModeEnumMap[instance.mode]!,
      'seats': instance.seats,
      'is_self': instance.isSelf,
    };

const _$CarpoolModeEnumMap = {
  CarpoolMode.fromClub: 'from_club',
  CarpoolMode.direct: 'direct',
};

_EventDutyOption _$EventDutyOptionFromJson(Map<String, dynamic> json) =>
    _EventDutyOption(
      key: json['key'] as String,
      name: json['name'] as String? ?? '',
      id: (json['id'] as num?)?.toInt(),
      kind: json['kind'] as String?,
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$EventDutyOptionToJson(_EventDutyOption instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'id': instance.id,
      'kind': instance.kind,
      'members': instance.members,
    };

_EventDuty _$EventDutyFromJson(Map<String, dynamic> json) => _EventDuty(
  dutyTypeId: (json['duty_type_id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  icon: json['icon'] as String?,
  mode: json['mode'] as String? ?? 'individual',
  assignmentId: (json['assignment_id'] as num?)?.toInt(),
  memberKey: json['member_key'] as String?,
  memberKeys:
      (json['member_keys'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  assigneeAbsent: json['assignee_absent'] as bool? ?? false,
  dutyGroupId: (json['duty_group_id'] as num?)?.toInt(),
  label: json['label'] as String?,
  memberNames:
      (json['member_names'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  notes: json['notes'] as String?,
  done: json['done'] as bool? ?? false,
  mine: json['mine'] as bool? ?? false,
  options:
      (json['options'] as List<dynamic>?)
          ?.map((e) => EventDutyOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <EventDutyOption>[],
);

Map<String, dynamic> _$EventDutyToJson(_EventDuty instance) =>
    <String, dynamic>{
      'duty_type_id': instance.dutyTypeId,
      'name': instance.name,
      'icon': instance.icon,
      'mode': instance.mode,
      'assignment_id': instance.assignmentId,
      'member_key': instance.memberKey,
      'member_keys': instance.memberKeys,
      'assignee_absent': instance.assigneeAbsent,
      'duty_group_id': instance.dutyGroupId,
      'label': instance.label,
      'member_names': instance.memberNames,
      'notes': instance.notes,
      'done': instance.done,
      'mine': instance.mine,
      'options': instance.options.map((e) => e.toJson()).toList(),
    };

_FlagShift _$FlagShiftFromJson(Map<String, dynamic> json) => _FlagShift(
  key: json['key'] as String?,
  playerId: (json['player_id'] as num?)?.toInt(),
  userId: (json['user_id'] as num?)?.toInt(),
  fromMinute: (json['from_minute'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$FlagShiftToJson(_FlagShift instance) =>
    <String, dynamic>{
      'key': instance.key,
      'player_id': instance.playerId,
      'user_id': instance.userId,
      'from_minute': instance.fromMinute,
    };

_FlagDuty _$FlagDutyFromJson(Map<String, dynamic> json) => _FlagDuty(
  shifts:
      (json['shifts'] as List<dynamic>?)
          ?.map((e) => FlagShift.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <FlagShift>[],
  names:
      (json['names'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  mine: json['mine'] as bool? ?? false,
  matchMinutes: (json['match_minutes'] as num?)?.toInt(),
);

Map<String, dynamic> _$FlagDutyToJson(_FlagDuty instance) => <String, dynamic>{
  'shifts': instance.shifts.map((e) => e.toJson()).toList(),
  'names': instance.names,
  'mine': instance.mine,
  'match_minutes': instance.matchMinutes,
};

_EventDetail _$EventDetailFromJson(Map<String, dynamic> json) => _EventDetail(
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
  notes: json['notes'] as String?,
  isHome: json['is_home'] as bool?,
  competition: json['competition'] as String?,
  homeTeam: json['home_team'] as String?,
  awayTeam: json['away_team'] as String?,
  homeScore: (json['home_score'] as num?)?.toInt(),
  awayScore: (json['away_score'] as num?)?.toInt(),
  cancelledAt: json['cancelled_at'] == null
      ? null
      : DateTime.parse(json['cancelled_at'] as String),
  live: json['live'] == null
      ? null
      : LiveState.fromJson(json['live'] as Map<String, dynamic>),
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
        AttendanceStatus.nonplay,
        AttendanceStatus.absent,
      ],
  sportlink: json['sportlink'] == null
      ? null
      : SportlinkInfo.fromJson(json['sportlink'] as Map<String, dynamic>),
  myStatus: $enumDecodeNullable(
    _$AttendanceStatusEnumMap,
    json['my_status'],
    unknownValue: AttendanceStatus.pending,
  ),
  myReason: json['my_reason'] as String?,
  canRsvp: json['can_rsvp'] as bool? ?? false,
  canChange: json['can_change'] as bool? ?? false,
  counts: json['counts'] == null
      ? const AttendanceCounts()
      : AttendanceCounts.fromJson(json['counts'] as Map<String, dynamic>),
  playerCounts: json['player_counts'] == null
      ? const AttendanceCounts()
      : AttendanceCounts.fromJson(
          json['player_counts'] as Map<String, dynamic>,
        ),
  players:
      (json['players'] as List<dynamic>?)
          ?.map((e) => EventPlayer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <EventPlayer>[],
  hasLineup: json['has_lineup'] as bool? ?? false,
  lineupShared: json['lineup_shared'] as bool? ?? false,
  motm: json['motm'] == null
      ? null
      : MotmState.fromJson(json['motm'] as Map<String, dynamic>),
  carpoolOffers: (json['carpool_offers'] as List<dynamic>?)
      ?.map((e) => CarpoolOffer.fromJson(e as Map<String, dynamic>))
      .toList(),
  isTrainer: json['is_trainer'] as bool? ?? false,
  canAssignTeams: json['can_assign_teams'] as bool? ?? false,
  duties:
      (json['duties'] as List<dynamic>?)
          ?.map((e) => EventDuty.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <EventDuty>[],
  flag: json['flag'] == null
      ? null
      : FlagDuty.fromJson(json['flag'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EventDetailToJson(_EventDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$EventTypeEnumMap[instance.type]!,
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
      'home_score': instance.homeScore,
      'away_score': instance.awayScore,
      'cancelled_at': instance.cancelledAt?.toIso8601String(),
      'live': instance.live?.toJson(),
      'rsvp_statuses': instance.rsvpStatuses
          .map((e) => _$AttendanceStatusEnumMap[e]!)
          .toList(),
      'sportlink': instance.sportlink?.toJson(),
      'my_status': _$AttendanceStatusEnumMap[instance.myStatus],
      'my_reason': instance.myReason,
      'can_rsvp': instance.canRsvp,
      'can_change': instance.canChange,
      'counts': instance.counts.toJson(),
      'player_counts': instance.playerCounts.toJson(),
      'players': instance.players.map((e) => e.toJson()).toList(),
      'has_lineup': instance.hasLineup,
      'lineup_shared': instance.lineupShared,
      'motm': instance.motm?.toJson(),
      'carpool_offers': instance.carpoolOffers?.map((e) => e.toJson()).toList(),
      'is_trainer': instance.isTrainer,
      'can_assign_teams': instance.canAssignTeams,
      'duties': instance.duties.map((e) => e.toJson()).toList(),
      'flag': instance.flag?.toJson(),
    };

const _$EventTypeEnumMap = {
  EventType.match: 'match',
  EventType.training: 'training',
  EventType.activity: 'activity',
  EventType.unknown: 'unknown',
};
