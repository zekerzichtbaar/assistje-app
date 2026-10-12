// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roster_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RosterPlayer _$RosterPlayerFromJson(Map<String, dynamic> json) =>
    _RosterPlayer(
      id: (json['id'] as num).toInt(),
      shirtNumber: (json['shirt_number'] as num?)?.toInt(),
      name: json['name'] as String? ?? '',
      position: json['position'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      isGuest: json['is_guest'] as bool? ?? false,
      isInjured: json['is_injured'] as bool? ?? false,
      isOnVacation: json['is_on_vacation'] as bool? ?? false,
    );

Map<String, dynamic> _$RosterPlayerToJson(_RosterPlayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shirt_number': instance.shirtNumber,
      'name': instance.name,
      'position': instance.position,
      'avatar_url': instance.avatarUrl,
      'is_guest': instance.isGuest,
      'is_injured': instance.isInjured,
      'is_on_vacation': instance.isOnVacation,
    };

_RosterCoach _$RosterCoachFromJson(Map<String, dynamic> json) => _RosterCoach(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  avatarUrl: json['avatar_url'] as String?,
  isOnVacation: json['is_on_vacation'] as bool? ?? false,
);

Map<String, dynamic> _$RosterCoachToJson(_RosterCoach instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'is_on_vacation': instance.isOnVacation,
    };

_TeamRoster _$TeamRosterFromJson(Map<String, dynamic> json) => _TeamRoster(
  players:
      (json['players'] as List<dynamic>?)
          ?.map((e) => RosterPlayer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <RosterPlayer>[],
  coaches:
      (json['coaches'] as List<dynamic>?)
          ?.map((e) => RosterCoach.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <RosterCoach>[],
);

Map<String, dynamic> _$TeamRosterToJson(_TeamRoster instance) =>
    <String, dynamic>{
      'players': instance.players.map((e) => e.toJson()).toList(),
      'coaches': instance.coaches.map((e) => e.toJson()).toList(),
    };
