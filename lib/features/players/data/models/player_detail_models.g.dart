// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_detail_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerProfile _$PlayerProfileFromJson(Map<String, dynamic> json) =>
    _PlayerProfile(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      shirtNumber: (json['shirt_number'] as num?)?.toInt(),
      position: json['position'] as String?,
      isGuest: json['is_guest'] as bool? ?? false,
      isInjured: json['is_injured'] as bool? ?? false,
      isOnVacation: json['is_on_vacation'] as bool? ?? false,
      fromTeam: json['from_team'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      hasAccount: json['has_account'] as bool? ?? false,
      email: json['email'] as String?,
      invitedAt: json['invited_at'] == null
          ? null
          : DateTime.parse(json['invited_at'] as String),
      inviteAccepted: json['invite_accepted'] as bool? ?? false,
      isTrainer: json['is_trainer'] as bool? ?? false,
      abilities:
          (json['abilities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      isSelf: json['is_self'] as bool? ?? false,
      isCaptain: json['is_captain'] as bool? ?? false,
    );

Map<String, dynamic> _$PlayerProfileToJson(_PlayerProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shirt_number': instance.shirtNumber,
      'position': instance.position,
      'is_guest': instance.isGuest,
      'is_injured': instance.isInjured,
      'is_on_vacation': instance.isOnVacation,
      'from_team': instance.fromTeam,
      'avatar_url': instance.avatarUrl,
      'has_account': instance.hasAccount,
      'email': instance.email,
      'invited_at': instance.invitedAt?.toIso8601String(),
      'invite_accepted': instance.inviteAccepted,
      'is_trainer': instance.isTrainer,
      'abilities': instance.abilities,
      'is_self': instance.isSelf,
      'is_captain': instance.isCaptain,
    };

_PersonalStats _$PersonalStatsFromJson(Map<String, dynamic> json) =>
    _PersonalStats(
      matchesPlayed: (json['matches_played'] as num?)?.toInt() ?? 0,
      wins: (json['wins'] as num?)?.toInt() ?? 0,
      draws: (json['draws'] as num?)?.toInt() ?? 0,
      losses: (json['losses'] as num?)?.toInt() ?? 0,
      winPct: (json['win_pct'] as num?)?.toDouble() ?? 0,
      goals: (json['goals'] as num?)?.toInt() ?? 0,
      assists: (json['assists'] as num?)?.toInt() ?? 0,
      green: (json['green'] as num?)?.toInt() ?? 0,
      yellow: (json['yellow'] as num?)?.toInt() ?? 0,
      red: (json['red'] as num?)?.toInt() ?? 0,
      cleanSheets: (json['clean_sheets'] as num?)?.toInt() ?? 0,
      motm: (json['motm'] as num?)?.toInt() ?? 0,
      attendanceMatchRate:
          (json['attendance_match_rate'] as num?)?.toDouble() ?? 0,
      attendanceTrainingRate:
          (json['attendance_training_rate'] as num?)?.toDouble() ?? 0,
      trainingPoints: (json['training_points'] as num?)?.toInt(),
      points: (json['points'] as num?)?.toInt(),
      aces: (json['aces'] as num?)?.toInt(),
      blocks: (json['blocks'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PersonalStatsToJson(_PersonalStats instance) =>
    <String, dynamic>{
      'matches_played': instance.matchesPlayed,
      'wins': instance.wins,
      'draws': instance.draws,
      'losses': instance.losses,
      'win_pct': instance.winPct,
      'goals': instance.goals,
      'assists': instance.assists,
      'green': instance.green,
      'yellow': instance.yellow,
      'red': instance.red,
      'clean_sheets': instance.cleanSheets,
      'motm': instance.motm,
      'attendance_match_rate': instance.attendanceMatchRate,
      'attendance_training_rate': instance.attendanceTrainingRate,
      'training_points': instance.trainingPoints,
      'points': instance.points,
      'aces': instance.aces,
      'blocks': instance.blocks,
    };

_PersonalStatsSet _$PersonalStatsSetFromJson(Map<String, dynamic> json) =>
    _PersonalStatsSet(
      season: json['season'] == null
          ? const PersonalStats()
          : PersonalStats.fromJson(json['season'] as Map<String, dynamic>),
      career: json['career'] == null
          ? const PersonalStats()
          : PersonalStats.fromJson(json['career'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PersonalStatsSetToJson(_PersonalStatsSet instance) =>
    <String, dynamic>{
      'season': instance.season.toJson(),
      'career': instance.career.toJson(),
    };

_DutyCount _$DutyCountFromJson(Map<String, dynamic> json) => _DutyCount(
  slug: json['slug'] as String? ?? '',
  name: json['name'] as String? ?? '',
  count: (json['count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$DutyCountToJson(_DutyCount instance) =>
    <String, dynamic>{
      'slug': instance.slug,
      'name': instance.name,
      'count': instance.count,
    };

_Achievement _$AchievementFromJson(Map<String, dynamic> json) => _Achievement(
  key: json['key'] as String? ?? '',
  icon: json['icon'] as String? ?? '',
  label: json['label'] as String? ?? '',
  detail: json['detail'] as String?,
  count: (json['count'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$AchievementToJson(_Achievement instance) =>
    <String, dynamic>{
      'key': instance.key,
      'icon': instance.icon,
      'label': instance.label,
      'detail': instance.detail,
      'count': instance.count,
    };

_PlayerVacation _$PlayerVacationFromJson(Map<String, dynamic> json) =>
    _PlayerVacation(
      id: (json['id'] as num).toInt(),
      startsOn: DateTime.parse(json['starts_on'] as String),
      endsOn: DateTime.parse(json['ends_on'] as String),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$PlayerVacationToJson(_PlayerVacation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'starts_on': instance.startsOn.toIso8601String(),
      'ends_on': instance.endsOn.toIso8601String(),
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

_PlayerDetail _$PlayerDetailFromJson(Map<String, dynamic> json) =>
    _PlayerDetail(
      player: PlayerProfile.fromJson(json['player'] as Map<String, dynamic>),
      canManage: json['can_manage'] as bool? ?? false,
      vacations:
          (json['vacations'] as List<dynamic>?)
              ?.map((e) => PlayerVacation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PlayerVacation>[],
      standingAbsences: json['standing_absences'] == null
          ? null
          : StandingAbsences.fromJson(
              json['standing_absences'] as Map<String, dynamic>,
            ),
      personalStats: json['personal_stats'] == null
          ? null
          : PersonalStatsSet.fromJson(
              json['personal_stats'] as Map<String, dynamic>,
            ),
      duties:
          (json['duties'] as List<dynamic>?)
              ?.map((e) => DutyCount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DutyCount>[],
      achievements:
          (json['achievements'] as List<dynamic>?)
              ?.map((e) => Achievement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Achievement>[],
    );

Map<String, dynamic> _$PlayerDetailToJson(_PlayerDetail instance) =>
    <String, dynamic>{
      'player': instance.player.toJson(),
      'can_manage': instance.canManage,
      'vacations': instance.vacations.map((e) => e.toJson()).toList(),
      'standing_absences': instance.standingAbsences?.toJson(),
      'personal_stats': instance.personalStats?.toJson(),
      'duties': instance.duties.map((e) => e.toJson()).toList(),
      'achievements': instance.achievements.map((e) => e.toJson()).toList(),
    };
