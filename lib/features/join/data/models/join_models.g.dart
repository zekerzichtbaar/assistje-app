// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JoinPlayer _$JoinPlayerFromJson(Map<String, dynamic> json) => _JoinPlayer(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  shirtNumber: (json['shirt_number'] as num?)?.toInt(),
);

Map<String, dynamic> _$JoinPlayerToJson(_JoinPlayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shirt_number': instance.shirtNumber,
    };

_JoinLink _$JoinLinkFromJson(Map<String, dynamic> json) => _JoinLink(
  team: Team.fromJson(json['team'] as Map<String, dynamic>),
  expiresAt: json['expires_at'] as String?,
  alreadyMember: json['already_member'] as bool? ?? false,
  players:
      (json['players'] as List<dynamic>?)
          ?.map((e) => JoinPlayer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <JoinPlayer>[],
);

Map<String, dynamic> _$JoinLinkToJson(_JoinLink instance) => <String, dynamic>{
  'team': instance.team.toJson(),
  'expires_at': instance.expiresAt,
  'already_member': instance.alreadyMember,
  'players': instance.players.map((e) => e.toJson()).toList(),
};

_JoinConfirmation _$JoinConfirmationFromJson(Map<String, dynamic> json) =>
    _JoinConfirmation(
      team: Team.fromJson(json['team'] as Map<String, dynamic>),
      valid: json['valid'] as bool? ?? false,
      userName: json['user_name'] as String?,
      role: json['role'] as String? ?? 'player',
      playerId: (json['player_id'] as num?)?.toInt(),
      playerName: json['player_name'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$JoinConfirmationToJson(_JoinConfirmation instance) =>
    <String, dynamic>{
      'team': instance.team.toJson(),
      'valid': instance.valid,
      'user_name': instance.userName,
      'role': instance.role,
      'player_id': instance.playerId,
      'player_name': instance.playerName,
      'name': instance.name,
    };

_InviteInfo _$InviteInfoFromJson(Map<String, dynamic> json) => _InviteInfo(
  name: json['name'] as String? ?? '',
  valid: json['valid'] as bool? ?? true,
);

Map<String, dynamic> _$InviteInfoToJson(_InviteInfo instance) =>
    <String, dynamic>{'name': instance.name, 'valid': instance.valid};
