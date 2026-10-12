// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  email: json['email'] as String?,
  pendingEmail: json['pending_email'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  birthdate: json['birthdate'] as String?,
  isSuperAdmin: json['is_super_admin'] as bool? ?? false,
  profileMissing: json['profile_missing'] == null
      ? const ProfileMissing()
      : ProfileMissing.fromJson(
          json['profile_missing'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'pending_email': instance.pendingEmail,
  'avatar_url': instance.avatarUrl,
  'birthdate': instance.birthdate,
  'is_super_admin': instance.isSuperAdmin,
  'profile_missing': instance.profileMissing.toJson(),
};

_ProfileMissing _$ProfileMissingFromJson(Map<String, dynamic> json) =>
    _ProfileMissing(
      avatar: json['avatar'] as bool? ?? false,
      birthdate: json['birthdate'] as bool? ?? false,
      email: json['email'] as bool? ?? false,
    );

Map<String, dynamic> _$ProfileMissingToJson(_ProfileMissing instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'birthdate': instance.birthdate,
      'email': instance.email,
    };
