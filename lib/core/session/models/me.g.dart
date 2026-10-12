// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'me.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Me _$MeFromJson(Map<String, dynamic> json) => _Me(
  user: User.fromJson(json['user'] as Map<String, dynamic>),
  teams:
      (json['teams'] as List<dynamic>?)
          ?.map((e) => TeamMembership.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TeamMembership>[],
);

Map<String, dynamic> _$MeToJson(_Me instance) => <String, dynamic>{
  'user': instance.user.toJson(),
  'teams': instance.teams.map((e) => e.toJson()).toList(),
};
