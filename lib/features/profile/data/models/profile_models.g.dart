// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileAccount _$ProfileAccountFromJson(Map<String, dynamic> json) =>
    _ProfileAccount(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      email: json['email'] as String?,
      pendingEmail: json['pending_email'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      birthdate: json['birthdate'] as String?,
    );

Map<String, dynamic> _$ProfileAccountToJson(_ProfileAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'pending_email': instance.pendingEmail,
      'avatar_url': instance.avatarUrl,
      'birthdate': instance.birthdate,
    };

_OwnPlayer _$OwnPlayerFromJson(Map<String, dynamic> json) => _OwnPlayer(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  shirtNumber: (json['shirt_number'] as num?)?.toInt(),
  position: json['position'] as String?,
  birthdate: json['birthdate'] as String?,
  isInjured: json['is_injured'] as bool? ?? false,
);

Map<String, dynamic> _$OwnPlayerToJson(_OwnPlayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shirt_number': instance.shirtNumber,
      'position': instance.position,
      'birthdate': instance.birthdate,
      'is_injured': instance.isInjured,
    };

_ProfileVacation _$ProfileVacationFromJson(Map<String, dynamic> json) =>
    _ProfileVacation(
      id: (json['id'] as num).toInt(),
      startsOn: json['starts_on'] as String,
      endsOn: json['ends_on'] as String,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$ProfileVacationToJson(_ProfileVacation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'starts_on': instance.startsOn,
      'ends_on': instance.endsOn,
      'note': instance.note,
    };

_StandingAbsenceDay _$StandingAbsenceDayFromJson(Map<String, dynamic> json) =>
    _StandingAbsenceDay(
      id: (json['id'] as num).toInt(),
      weekday: (json['weekday'] as num).toInt(),
    );

Map<String, dynamic> _$StandingAbsenceDayToJson(_StandingAbsenceDay instance) =>
    <String, dynamic>{'id': instance.id, 'weekday': instance.weekday};

_StandingAbsences _$StandingAbsencesFromJson(Map<String, dynamic> json) =>
    _StandingAbsences(
      days:
          (json['days'] as List<dynamic>?)
              ?.map(
                (e) => StandingAbsenceDay.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <StandingAbsenceDay>[],
      choices:
          (json['choices'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
    );

Map<String, dynamic> _$StandingAbsencesToJson(_StandingAbsences instance) =>
    <String, dynamic>{
      'days': instance.days.map((e) => e.toJson()).toList(),
      'choices': instance.choices,
    };

_Profile _$ProfileFromJson(Map<String, dynamic> json) => _Profile(
  user: ProfileAccount.fromJson(json['user'] as Map<String, dynamic>),
  player: json['player'] == null
      ? null
      : OwnPlayer.fromJson(json['player'] as Map<String, dynamic>),
  canUseVacations: json['can_use_vacations'] as bool? ?? false,
  vacations:
      (json['vacations'] as List<dynamic>?)
          ?.map((e) => ProfileVacation.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ProfileVacation>[],
  standingAbsences: json['standing_absences'] == null
      ? null
      : StandingAbsences.fromJson(
          json['standing_absences'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ProfileToJson(_Profile instance) => <String, dynamic>{
  'user': instance.user.toJson(),
  'player': instance.player?.toJson(),
  'can_use_vacations': instance.canUseVacations,
  'vacations': instance.vacations.map((e) => e.toJson()).toList(),
  'standing_absences': instance.standingAbsences?.toJson(),
};
