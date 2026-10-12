// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SettingsTeam _$SettingsTeamFromJson(Map<String, dynamic> json) =>
    _SettingsTeam(
      id: json['id'] == null ? 0 : _int(json['id']),
      name: json['name'] as String? ?? '',
      primaryColor: json['primary_color'] as String? ?? '#006837',
      logoUrl: json['logo_url'] as String?,
      logoFills: json['logo_fills'] == null ? false : _bool(json['logo_fills']),
      formation: json['formation'] as String?,
    );

Map<String, dynamic> _$SettingsTeamToJson(_SettingsTeam instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'primary_color': instance.primaryColor,
      'logo_url': instance.logoUrl,
      'logo_fills': instance.logoFills,
      'formation': instance.formation,
    };

_RsvpSettings _$RsvpSettingsFromJson(Map<String, dynamic> json) =>
    _RsvpSettings(
      mode:
          $enumDecodeNullable(
            _$RsvpModeEnumMap,
            json['mode'],
            unknownValue: RsvpMode.relative,
          ) ??
          RsvpMode.relative,
      matchHours: _intOrNull(json['match_hours']),
      trainingHours: _intOrNull(json['training_hours']),
      weeklyDay: _intOrNull(json['weekly_day']),
      weeklyTime: json['weekly_time'] as String?,
    );

Map<String, dynamic> _$RsvpSettingsToJson(_RsvpSettings instance) =>
    <String, dynamic>{
      'mode': _$RsvpModeEnumMap[instance.mode]!,
      'match_hours': instance.matchHours,
      'training_hours': instance.trainingHours,
      'weekly_day': instance.weeklyDay,
      'weekly_time': instance.weeklyTime,
    };

const _$RsvpModeEnumMap = {
  RsvpMode.relative: 'relative',
  RsvpMode.weekly: 'weekly',
};

_SettingsFeature _$SettingsFeatureFromJson(Map<String, dynamic> json) =>
    _SettingsFeature(
      key: json['key'] as String,
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      category: json['category'] as String?,
      enabled: json['enabled'] == null ? false : _bool(json['enabled']),
    );

Map<String, dynamic> _$SettingsFeatureToJson(_SettingsFeature instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'enabled': instance.enabled,
    };

_DutyTypeSetting _$DutyTypeSettingFromJson(Map<String, dynamic> json) =>
    _DutyTypeSetting(
      id: _int(json['id']),
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String?,
      icon: json['icon'] as String?,
      sortOrder: json['sort_order'] == null ? 0 : _int(json['sort_order']),
      mode:
          $enumDecodeNullable(
            _$DutyModeEnumMap,
            json['mode'],
            unknownValue: DutyMode.group,
          ) ??
          DutyMode.group,
      scope:
          $enumDecodeNullable(
            _$DutyScopeEnumMap,
            json['scope'],
            unknownValue: DutyScope.free,
          ) ??
          DutyScope.free,
      autoRotate: json['auto_rotate'] == null
          ? false
          : _bool(json['auto_rotate']),
      onUnavailable: $enumDecodeNullable(
        _$DutyOnUnavailableEnumMap,
        json['on_unavailable'],
        unknownValue: DutyOnUnavailable.reassign,
      ),
      pool: json['pool'] == null ? const <String>[] : _strings(json['pool']),
      poolMembers: json['pool_members'] == null
          ? const <String>[]
          : _strings(json['pool_members']),
    );

Map<String, dynamic> _$DutyTypeSettingToJson(_DutyTypeSetting instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'icon': instance.icon,
      'sort_order': instance.sortOrder,
      'mode': _$DutyModeEnumMap[instance.mode]!,
      'scope': _$DutyScopeEnumMap[instance.scope]!,
      'auto_rotate': instance.autoRotate,
      'on_unavailable': _$DutyOnUnavailableEnumMap[instance.onUnavailable],
      'pool': instance.pool,
      'pool_members': instance.poolMembers,
    };

const _$DutyModeEnumMap = {
  DutyMode.group: 'group',
  DutyMode.individual: 'individual',
  DutyMode.multi: 'multi',
};

const _$DutyScopeEnumMap = {DutyScope.free: 'free', DutyScope.match: 'match'};

const _$DutyOnUnavailableEnumMap = {
  DutyOnUnavailable.reassign: 'reassign',
  DutyOnUnavailable.notify: 'notify',
};

_DutyPerson _$DutyPersonFromJson(Map<String, dynamic> json) => _DutyPerson(
  key: json['key'] as String,
  name: json['name'] as String? ?? '',
  kind: json['kind'] as String? ?? 'player',
);

Map<String, dynamic> _$DutyPersonToJson(_DutyPerson instance) =>
    <String, dynamic>{
      'key': instance.key,
      'name': instance.name,
      'kind': instance.kind,
    };

_IcalLinks _$IcalLinksFromJson(Map<String, dynamic> json) => _IcalLinks(
  eventsUrl: json['events_url'] as String?,
  trainingsUrl: json['trainings_url'] as String?,
);

Map<String, dynamic> _$IcalLinksToJson(_IcalLinks instance) =>
    <String, dynamic>{
      'events_url': instance.eventsUrl,
      'trainings_url': instance.trainingsUrl,
    };

_CarpoolSettings _$CarpoolSettingsFromJson(Map<String, dynamic> json) =>
    _CarpoolSettings(
      reminderHours: json['reminder_hours'] == null
          ? 4
          : _int(json['reminder_hours']),
    );

Map<String, dynamic> _$CarpoolSettingsToJson(_CarpoolSettings instance) =>
    <String, dynamic>{'reminder_hours': instance.reminderHours};

_GuestSettings _$GuestSettingsFromJson(Map<String, dynamic> json) =>
    _GuestSettings(
      attendance:
          $enumDecodeNullable(
            _$GuestAttendanceEnumMap,
            json['attendance'],
            unknownValue: GuestAttendance.none,
          ) ??
          GuestAttendance.none,
      inFines: json['in_fines'] == null ? false : _bool(json['in_fines']),
      inStats: json['in_stats'] == null ? false : _bool(json['in_stats']),
      staffInFines: json['staff_in_fines'] == null
          ? false
          : _bool(json['staff_in_fines']),
    );

Map<String, dynamic> _$GuestSettingsToJson(_GuestSettings instance) =>
    <String, dynamic>{
      'attendance': _$GuestAttendanceEnumMap[instance.attendance]!,
      'in_fines': instance.inFines,
      'in_stats': instance.inStats,
      'staff_in_fines': instance.staffInFines,
    };

const _$GuestAttendanceEnumMap = {
  GuestAttendance.none: 'none',
  GuestAttendance.training: 'training',
  GuestAttendance.all: 'all',
};

_TrainingPointsSettings _$TrainingPointsSettingsFromJson(
  Map<String, dynamic> json,
) => _TrainingPointsSettings(
  attendancePoint: json['attendance_point'] == null
      ? false
      : _bool(json['attendance_point']),
);

Map<String, dynamic> _$TrainingPointsSettingsToJson(
  _TrainingPointsSettings instance,
) => <String, dynamic>{'attendance_point': instance.attendancePoint};

_ClosedSeason _$ClosedSeasonFromJson(Map<String, dynamic> json) =>
    _ClosedSeason(
      label: json['label'] as String? ?? '',
      closedAt: json['closed_at'] == null
          ? null
          : DateTime.parse(json['closed_at'] as String),
    );

Map<String, dynamic> _$ClosedSeasonToJson(_ClosedSeason instance) =>
    <String, dynamic>{
      'label': instance.label,
      'closed_at': instance.closedAt?.toIso8601String(),
    };

_PeriodRow _$PeriodRowFromJson(Map<String, dynamic> json) => _PeriodRow(
  id: _int(json['id']),
  name: json['name'] as String? ?? '',
  startsOn: json['starts_on'] as String?,
  endsOn: json['ends_on'] as String?,
  targetMatches: _intOrNull(json['target_matches']),
  isClosed: json['is_closed'] == null ? false : _bool(json['is_closed']),
  playedMatches: json['played_matches'] == null
      ? 0
      : _int(json['played_matches']),
  awardCount: json['award_count'] == null ? 0 : _int(json['award_count']),
);

Map<String, dynamic> _$PeriodRowToJson(_PeriodRow instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'starts_on': instance.startsOn,
      'ends_on': instance.endsOn,
      'target_matches': instance.targetMatches,
      'is_closed': instance.isClosed,
      'played_matches': instance.playedMatches,
      'award_count': instance.awardCount,
    };

_PeriodSettings _$PeriodSettingsFromJson(Map<String, dynamic> json) =>
    _PeriodSettings(
      mode: json['mode'] as String? ?? 'off',
      seasonLabel: json['season_label'] as String?,
      seasonStartsOn: json['season_starts_on'] as String?,
      seasonEndsOn: json['season_ends_on'] as String?,
      seasonExpired: json['season_expired'] == null
          ? false
          : _bool(json['season_expired']),
      seasonMatchCount: json['season_match_count'] == null
          ? 0
          : _int(json['season_match_count']),
      closedSeason: json['closed_season'] == null
          ? null
          : ClosedSeason.fromJson(
              json['closed_season'] as Map<String, dynamic>,
            ),
      periods:
          (json['periods'] as List<dynamic>?)
              ?.map((e) => PeriodRow.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PeriodRow>[],
    );

Map<String, dynamic> _$PeriodSettingsToJson(_PeriodSettings instance) =>
    <String, dynamic>{
      'mode': instance.mode,
      'season_label': instance.seasonLabel,
      'season_starts_on': instance.seasonStartsOn,
      'season_ends_on': instance.seasonEndsOn,
      'season_expired': instance.seasonExpired,
      'season_match_count': instance.seasonMatchCount,
      'closed_season': instance.closedSeason?.toJson(),
      'periods': instance.periods.map((e) => e.toJson()).toList(),
    };

_TeamSettings _$TeamSettingsFromJson(Map<String, dynamic> json) =>
    _TeamSettings(
      team: json['team'] == null
          ? const SettingsTeam()
          : SettingsTeam.fromJson(json['team'] as Map<String, dynamic>),
      formations: json['formations'] == null
          ? const <String>[]
          : _strings(json['formations']),
      rsvp: json['rsvp'] == null
          ? const RsvpSettings()
          : RsvpSettings.fromJson(json['rsvp'] as Map<String, dynamic>),
      features:
          (json['features'] as List<dynamic>?)
              ?.map((e) => SettingsFeature.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SettingsFeature>[],
      dutyTypes:
          (json['duty_types'] as List<dynamic>?)
              ?.map((e) => DutyTypeSetting.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DutyTypeSetting>[],
      dutyPeople:
          (json['duty_people'] as List<dynamic>?)
              ?.map((e) => DutyPerson.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DutyPerson>[],
      ical: json['ical'] == null
          ? const IcalLinks()
          : IcalLinks.fromJson(json['ical'] as Map<String, dynamic>),
      carpool: json['carpool'] == null
          ? const CarpoolSettings()
          : CarpoolSettings.fromJson(json['carpool'] as Map<String, dynamic>),
      guests: json['guests'] == null
          ? const GuestSettings()
          : GuestSettings.fromJson(json['guests'] as Map<String, dynamic>),
      trainingPoints: json['training_points'] == null
          ? const TrainingPointsSettings()
          : TrainingPointsSettings.fromJson(
              json['training_points'] as Map<String, dynamic>,
            ),
      period: json['period'] == null
          ? const PeriodSettings()
          : PeriodSettings.fromJson(json['period'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamSettingsToJson(_TeamSettings instance) =>
    <String, dynamic>{
      'team': instance.team.toJson(),
      'formations': instance.formations,
      'rsvp': instance.rsvp.toJson(),
      'features': instance.features.map((e) => e.toJson()).toList(),
      'duty_types': instance.dutyTypes.map((e) => e.toJson()).toList(),
      'duty_people': instance.dutyPeople.map((e) => e.toJson()).toList(),
      'ical': instance.ical.toJson(),
      'carpool': instance.carpool.toJson(),
      'guests': instance.guests.toJson(),
      'training_points': instance.trainingPoints.toJson(),
      'period': instance.period.toJson(),
    };
