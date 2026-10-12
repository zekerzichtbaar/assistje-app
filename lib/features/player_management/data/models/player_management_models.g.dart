// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_management_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ManagedPlayer _$ManagedPlayerFromJson(Map<String, dynamic> json) =>
    _ManagedPlayer(
      id: (json['id'] as num).toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      shirtNumber: (json['shirt_number'] as num?)?.toInt(),
      name: json['name'] as String? ?? '',
      position: json['position'] as String?,
      isGuest: json['is_guest'] as bool? ?? false,
      isInjured: json['is_injured'] as bool? ?? false,
      isOnVacation: json['is_on_vacation'] as bool? ?? false,
      fromTeam: json['from_team'] as String?,
      email: json['email'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      isTrainer: json['is_trainer'] as bool? ?? false,
      isCaptain: json['is_captain'] as bool? ?? false,
      inviteStatus:
          $enumDecodeNullable(
            _$InviteStatusEnumMap,
            json['invite_status'],
            unknownValue: InviteStatus.unknown,
          ) ??
          InviteStatus.none,
      pushStatus:
          $enumDecodeNullable(
            _$PushStatusEnumMap,
            json['push_status'],
            unknownValue: PushStatus.unknown,
          ) ??
          PushStatus.na,
      strength: (json['strength'] as num?)?.toInt(),
      birthdate: json['birthdate'] as String?,
      abilities:
          (json['abilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$ManagedPlayerToJson(_ManagedPlayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'shirt_number': instance.shirtNumber,
      'name': instance.name,
      'position': instance.position,
      'is_guest': instance.isGuest,
      'is_injured': instance.isInjured,
      'is_on_vacation': instance.isOnVacation,
      'from_team': instance.fromTeam,
      'email': instance.email,
      'avatar_url': instance.avatarUrl,
      'is_trainer': instance.isTrainer,
      'is_captain': instance.isCaptain,
      'invite_status': _$InviteStatusEnumMap[instance.inviteStatus]!,
      'push_status': _$PushStatusEnumMap[instance.pushStatus]!,
      'strength': instance.strength,
      'birthdate': instance.birthdate,
      'abilities': instance.abilities,
    };

const _$InviteStatusEnumMap = {
  InviteStatus.none: 'none',
  InviteStatus.pending: 'pending',
  InviteStatus.accepted: 'accepted',
  InviteStatus.unknown: 'unknown',
};

const _$PushStatusEnumMap = {
  PushStatus.na: 'na',
  PushStatus.none: 'none',
  PushStatus.installed: 'installed',
  PushStatus.push: 'push',
  PushStatus.unknown: 'unknown',
};

_ManagedTrainer _$ManagedTrainerFromJson(Map<String, dynamic> json) =>
    _ManagedTrainer(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      email: json['email'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      isSelf: json['is_self'] as bool? ?? false,
      pushStatus:
          $enumDecodeNullable(
            _$PushStatusEnumMap,
            json['push_status'],
            unknownValue: PushStatus.unknown,
          ) ??
          PushStatus.none,
    );

Map<String, dynamic> _$ManagedTrainerToJson(_ManagedTrainer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatar_url': instance.avatarUrl,
      'is_self': instance.isSelf,
      'push_status': _$PushStatusEnumMap[instance.pushStatus]!,
    };

_ManagedSpectator _$ManagedSpectatorFromJson(Map<String, dynamic> json) =>
    _ManagedSpectator(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      email: json['email'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      inviteStatus:
          $enumDecodeNullable(
            _$InviteStatusEnumMap,
            json['invite_status'],
            unknownValue: InviteStatus.unknown,
          ) ??
          InviteStatus.pending,
    );

Map<String, dynamic> _$ManagedSpectatorToJson(_ManagedSpectator instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'avatar_url': instance.avatarUrl,
      'invite_status': _$InviteStatusEnumMap[instance.inviteStatus]!,
    };

_TeamLink _$TeamLinkFromJson(Map<String, dynamic> json) => _TeamLink(
  url: json['url'] as String,
  expiresAt: json['expires_at'] == null
      ? null
      : DateTime.parse(json['expires_at'] as String),
);

Map<String, dynamic> _$TeamLinkToJson(_TeamLink instance) => <String, dynamic>{
  'url': instance.url,
  'expires_at': instance.expiresAt?.toIso8601String(),
};

_PlayerManagement _$PlayerManagementFromJson(Map<String, dynamic> json) =>
    _PlayerManagement(
      players:
          (json['players'] as List<dynamic>?)
              ?.map((e) => ManagedPlayer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ManagedPlayer>[],
      trainers:
          (json['trainers'] as List<dynamic>?)
              ?.map((e) => ManagedTrainer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ManagedTrainer>[],
      spectators:
          (json['spectators'] as List<dynamic>?)
              ?.map((e) => ManagedSpectator.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ManagedSpectator>[],
      teamLink: json['team_link'] == null
          ? null
          : TeamLink.fromJson(json['team_link'] as Map<String, dynamic>),
      teamLinkState:
          $enumDecodeNullable(
            _$TeamLinkStateEnumMap,
            json['team_link_state'],
            unknownValue: TeamLinkState.unknown,
          ) ??
          TeamLinkState.active,
    );

Map<String, dynamic> _$PlayerManagementToJson(_PlayerManagement instance) =>
    <String, dynamic>{
      'players': instance.players.map((e) => e.toJson()).toList(),
      'trainers': instance.trainers.map((e) => e.toJson()).toList(),
      'spectators': instance.spectators.map((e) => e.toJson()).toList(),
      'team_link': instance.teamLink?.toJson(),
      'team_link_state': _$TeamLinkStateEnumMap[instance.teamLinkState]!,
    };

const _$TeamLinkStateEnumMap = {
  TeamLinkState.active: 'active',
  TeamLinkState.expired: 'expired',
  TeamLinkState.revoked: 'revoked',
  TeamLinkState.unknown: 'unknown',
};

_TeamLinkJoin _$TeamLinkJoinFromJson(Map<String, dynamic> json) =>
    _TeamLinkJoin(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      role: json['role'] as String? ?? 'player',
      joinedAt: json['joined_at'] == null
          ? null
          : DateTime.parse(json['joined_at'] as String),
    );

Map<String, dynamic> _$TeamLinkJoinToJson(_TeamLinkJoin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'role': instance.role,
      'joined_at': instance.joinedAt?.toIso8601String(),
    };

_TeamLinkOverview _$TeamLinkOverviewFromJson(Map<String, dynamic> json) =>
    _TeamLinkOverview(
      link: json['link'] == null
          ? null
          : TeamLink.fromJson(json['link'] as Map<String, dynamic>),
      linkState:
          $enumDecodeNullable(
            _$TeamLinkStateEnumMap,
            json['link_state'],
            unknownValue: TeamLinkState.unknown,
          ) ??
          TeamLinkState.active,
      expiresDays: (json['expires_days'] as num?)?.toInt() ?? 90,
      joined:
          (json['joined'] as List<dynamic>?)
              ?.map((e) => TeamLinkJoin.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TeamLinkJoin>[],
    );

Map<String, dynamic> _$TeamLinkOverviewToJson(_TeamLinkOverview instance) =>
    <String, dynamic>{
      'link': instance.link?.toJson(),
      'link_state': _$TeamLinkStateEnumMap[instance.linkState]!,
      'expires_days': instance.expiresDays,
      'joined': instance.joined.map((e) => e.toJson()).toList(),
    };
