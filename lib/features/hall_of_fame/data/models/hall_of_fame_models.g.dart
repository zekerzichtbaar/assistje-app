// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hall_of_fame_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HofPeriod _$HofPeriodFromJson(Map<String, dynamic> json) => _HofPeriod(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  startsOn: json['starts_on'] == null
      ? null
      : DateTime.parse(json['starts_on'] as String),
  endsOn: json['ends_on'] == null
      ? null
      : DateTime.parse(json['ends_on'] as String),
  isClosed: json['is_closed'] as bool? ?? false,
);

Map<String, dynamic> _$HofPeriodToJson(_HofPeriod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'starts_on': instance.startsOn?.toIso8601String(),
      'ends_on': instance.endsOn?.toIso8601String(),
      'is_closed': instance.isClosed,
    };

_HofPerson _$HofPersonFromJson(Map<String, dynamic> json) => _HofPerson(
  playerId: readIntOrNull(json['player_id']),
  name: json['name'] as String? ?? '',
  avatarUrl: json['avatar_url'] as String?,
);

Map<String, dynamic> _$HofPersonToJson(_HofPerson instance) =>
    <String, dynamic>{
      'player_id': instance.playerId,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
    };

_HofTitle _$HofTitleFromJson(Map<String, dynamic> json) => _HofTitle(
  key: json['key'] as String? ?? '',
  label: json['label'] as String? ?? '',
  icon: json['icon'] as String? ?? '',
  group: json['group'] as String? ?? 'season',
  holder: json['holder'] == null
      ? null
      : HofPerson.fromJson(json['holder'] as Map<String, dynamic>),
  holders:
      (json['holders'] as List<dynamic>?)
          ?.map((e) => HofPerson.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HofPerson>[],
  value: readStringOrNull(json['value']),
  caption: readStringOrNull(json['caption']),
);

Map<String, dynamic> _$HofTitleToJson(_HofTitle instance) => <String, dynamic>{
  'key': instance.key,
  'label': instance.label,
  'icon': instance.icon,
  'group': instance.group,
  'holder': instance.holder?.toJson(),
  'holders': instance.holders.map((e) => e.toJson()).toList(),
  'value': instance.value,
  'caption': instance.caption,
};

_PeriodAwardWinner _$PeriodAwardWinnerFromJson(Map<String, dynamic> json) =>
    _PeriodAwardWinner(
      titleKey: json['title_key'] as String? ?? '',
      label: json['label'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      value: readStringOrNull(json['value']),
      playerId: readIntOrNull(json['player_id']),
      name: json['name'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$PeriodAwardWinnerToJson(_PeriodAwardWinner instance) =>
    <String, dynamic>{
      'title_key': instance.titleKey,
      'label': instance.label,
      'icon': instance.icon,
      'value': instance.value,
      'player_id': instance.playerId,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
    };

_PeriodAwardGroup _$PeriodAwardGroupFromJson(Map<String, dynamic> json) =>
    _PeriodAwardGroup(
      periodId: readInt(json['period_id']),
      periodName: json['period_name'] as String? ?? '',
      winners:
          (json['winners'] as List<dynamic>?)
              ?.map(
                (e) => PeriodAwardWinner.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <PeriodAwardWinner>[],
    );

Map<String, dynamic> _$PeriodAwardGroupToJson(_PeriodAwardGroup instance) =>
    <String, dynamic>{
      'period_id': instance.periodId,
      'period_name': instance.periodName,
      'winners': instance.winners.map((e) => e.toJson()).toList(),
    };

_HofLeader _$HofLeaderFromJson(Map<String, dynamic> json) => _HofLeader(
  playerId: readInt(json['player_id']),
  name: json['name'] as String? ?? '',
  avatarUrl: json['avatar_url'] as String?,
  goals: json['goals'] == null ? 0 : readInt(json['goals']),
  assists: json['assists'] == null ? 0 : readInt(json['assists']),
  minutes: json['minutes'] == null ? 0 : readInt(json['minutes']),
  shifts: json['shifts'] == null ? 0 : readInt(json['shifts']),
  wins: json['wins'] == null ? 0 : readInt(json['wins']),
  points: json['points'] == null ? 0 : readInt(json['points']),
  aces: json['aces'] == null ? 0 : readInt(json['aces']),
  blocks: json['blocks'] == null ? 0 : readInt(json['blocks']),
);

Map<String, dynamic> _$HofLeaderToJson(_HofLeader instance) =>
    <String, dynamic>{
      'player_id': instance.playerId,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'goals': instance.goals,
      'assists': instance.assists,
      'minutes': instance.minutes,
      'shifts': instance.shifts,
      'wins': instance.wins,
      'points': instance.points,
      'aces': instance.aces,
      'blocks': instance.blocks,
    };

_PostMatchLeaderboards _$PostMatchLeaderboardsFromJson(
  Map<String, dynamic> json,
) => _PostMatchLeaderboards(
  points:
      (json['points'] as List<dynamic>?)
          ?.map((e) => HofLeader.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HofLeader>[],
  aces:
      (json['aces'] as List<dynamic>?)
          ?.map((e) => HofLeader.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HofLeader>[],
  blocks:
      (json['blocks'] as List<dynamic>?)
          ?.map((e) => HofLeader.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HofLeader>[],
);

Map<String, dynamic> _$PostMatchLeaderboardsToJson(
  _PostMatchLeaderboards instance,
) => <String, dynamic>{
  'points': instance.points.map((e) => e.toJson()).toList(),
  'aces': instance.aces.map((e) => e.toJson()).toList(),
  'blocks': instance.blocks.map((e) => e.toJson()).toList(),
};

_HofBadge _$HofBadgeFromJson(Map<String, dynamic> json) => _HofBadge(
  key: json['key'] as String? ?? '',
  icon: json['icon'] as String? ?? '',
  label: json['label'] as String? ?? '',
);

Map<String, dynamic> _$HofBadgeToJson(_HofBadge instance) => <String, dynamic>{
  'key': instance.key,
  'icon': instance.icon,
  'label': instance.label,
};

_BadgePlayer _$BadgePlayerFromJson(Map<String, dynamic> json) => _BadgePlayer(
  playerId: readInt(json['player_id']),
  name: json['name'] as String? ?? '',
  shirtNumber: readIntOrNull(json['shirt_number']),
  avatarUrl: json['avatar_url'] as String?,
  badges:
      (json['badges'] as List<dynamic>?)
          ?.map((e) => HofBadge.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HofBadge>[],
);

Map<String, dynamic> _$BadgePlayerToJson(_BadgePlayer instance) =>
    <String, dynamic>{
      'player_id': instance.playerId,
      'name': instance.name,
      'shirt_number': instance.shirtNumber,
      'avatar_url': instance.avatarUrl,
      'badges': instance.badges.map((e) => e.toJson()).toList(),
    };

_HallOfFame _$HallOfFameFromJson(Map<String, dynamic> json) => _HallOfFame(
  seasonId: readIntOrNull(json['season_id']),
  seasons:
      (json['seasons'] as List<dynamic>?)
          ?.map((e) => SeasonOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <SeasonOption>[],
  periodId: readIntOrNull(json['period_id']),
  periods:
      (json['periods'] as List<dynamic>?)
          ?.map((e) => HofPeriod.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HofPeriod>[],
  periodAwards:
      (json['period_awards'] as List<dynamic>?)
          ?.map((e) => PeriodAwardGroup.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PeriodAwardGroup>[],
  titles:
      (json['titles'] as List<dynamic>?)
          ?.map((e) => HofTitle.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HofTitle>[],
  topScorers: (json['top_scorers'] as List<dynamic>?)
      ?.map((e) => HofLeader.fromJson(e as Map<String, dynamic>))
      .toList(),
  topAssisters: (json['top_assisters'] as List<dynamic>?)
      ?.map((e) => HofLeader.fromJson(e as Map<String, dynamic>))
      .toList(),
  topFlaggers: (json['top_flaggers'] as List<dynamic>?)
      ?.map((e) => HofLeader.fromJson(e as Map<String, dynamic>))
      .toList(),
  postMatchLeaderboards: json['post_match_leaderboards'] == null
      ? null
      : PostMatchLeaderboards.fromJson(
          json['post_match_leaderboards'] as Map<String, dynamic>,
        ),
  topMotm:
      (json['top_motm'] as List<dynamic>?)
          ?.map((e) => HofLeader.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HofLeader>[],
  playersWithBadges:
      (json['players_with_badges'] as List<dynamic>?)
          ?.map((e) => BadgePlayer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <BadgePlayer>[],
  trainingPointsEnabled: json['training_points_enabled'] as bool? ?? false,
  topTrainingPoints:
      (json['top_training_points'] as List<dynamic>?)
          ?.map((e) => HofLeader.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <HofLeader>[],
);

Map<String, dynamic> _$HallOfFameToJson(_HallOfFame instance) =>
    <String, dynamic>{
      'season_id': instance.seasonId,
      'seasons': instance.seasons.map((e) => e.toJson()).toList(),
      'period_id': instance.periodId,
      'periods': instance.periods.map((e) => e.toJson()).toList(),
      'period_awards': instance.periodAwards.map((e) => e.toJson()).toList(),
      'titles': instance.titles.map((e) => e.toJson()).toList(),
      'top_scorers': instance.topScorers?.map((e) => e.toJson()).toList(),
      'top_assisters': instance.topAssisters?.map((e) => e.toJson()).toList(),
      'top_flaggers': instance.topFlaggers?.map((e) => e.toJson()).toList(),
      'post_match_leaderboards': instance.postMatchLeaderboards?.toJson(),
      'top_motm': instance.topMotm.map((e) => e.toJson()).toList(),
      'players_with_badges': instance.playersWithBadges
          .map((e) => e.toJson())
          .toList(),
      'training_points_enabled': instance.trainingPointsEnabled,
      'top_training_points': instance.topTrainingPoints
          .map((e) => e.toJson())
          .toList(),
    };
