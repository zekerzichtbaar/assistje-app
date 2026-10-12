// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_membership.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TeamMembership _$TeamMembershipFromJson(
  Map<String, dynamic> json,
) => _TeamMembership(
  team: Team.fromJson(json['team'] as Map<String, dynamic>),
  role:
      $enumDecodeNullable(
        _$TeamRoleEnumMap,
        json['role'],
        unknownValue: TeamRole.unknown,
      ) ??
      TeamRole.player,
  abilities:
      (json['abilities'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  features:
      (json['features'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ) ??
      const <String, bool>{},
  sport: json['sport'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  hasPoule: json['has_poule'] as bool? ?? false,
  onboardingOpen: json['onboarding_open'] as bool? ?? false,
  unreadNotificationsCount:
      (json['unread_notifications_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TeamMembershipToJson(_TeamMembership instance) =>
    <String, dynamic>{
      'team': instance.team.toJson(),
      'role': _$TeamRoleEnumMap[instance.role]!,
      'abilities': instance.abilities,
      'features': instance.features,
      'sport': instance.sport,
      'has_poule': instance.hasPoule,
      'onboarding_open': instance.onboardingOpen,
      'unread_notifications_count': instance.unreadNotificationsCount,
    };

const _$TeamRoleEnumMap = {
  TeamRole.trainer: 'trainer',
  TeamRole.player: 'player',
  TeamRole.spectator: 'spectator',
  TeamRole.unknown: 'unknown',
};
