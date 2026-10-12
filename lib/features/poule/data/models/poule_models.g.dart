// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poule_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PouleStanding _$PouleStandingFromJson(Map<String, dynamic> json) =>
    _PouleStanding(
      position: (json['position'] as num?)?.toInt() ?? 0,
      team: json['team'] as String? ?? '',
      logo: json['logo'] as String?,
      played: (json['played'] as num?)?.toInt() ?? 0,
      won: (json['won'] as num?)?.toInt() ?? 0,
      drawn: (json['drawn'] as num?)?.toInt() ?? 0,
      lost: (json['lost'] as num?)?.toInt() ?? 0,
      goalsFor: (json['goals_for'] as num?)?.toInt() ?? 0,
      goalsAgainst: (json['goals_against'] as num?)?.toInt() ?? 0,
      goalDiff: (json['goal_diff'] as num?)?.toInt() ?? 0,
      points: (json['points'] as num?)?.toInt() ?? 0,
      isOwn: json['is_own'] as bool? ?? false,
    );

Map<String, dynamic> _$PouleStandingToJson(_PouleStanding instance) =>
    <String, dynamic>{
      'position': instance.position,
      'team': instance.team,
      'logo': instance.logo,
      'played': instance.played,
      'won': instance.won,
      'drawn': instance.drawn,
      'lost': instance.lost,
      'goals_for': instance.goalsFor,
      'goals_against': instance.goalsAgainst,
      'goal_diff': instance.goalDiff,
      'points': instance.points,
      'is_own': instance.isOwn,
    };

_PouleMatch _$PouleMatchFromJson(Map<String, dynamic> json) => _PouleMatch(
  date: json['date'] as String?,
  time: json['time'] as String?,
  home: json['home'] as String? ?? '',
  away: json['away'] as String? ?? '',
  score: json['score'] as String?,
  status: json['status'] as String?,
  isOwn: json['is_own'] as bool? ?? false,
  homeIsOwn: json['home_is_own'] as bool? ?? false,
  awayIsOwn: json['away_is_own'] as bool? ?? false,
  homeLogo: json['home_logo'] as String?,
  awayLogo: json['away_logo'] as String?,
  eventId: (json['event_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$PouleMatchToJson(_PouleMatch instance) =>
    <String, dynamic>{
      'date': instance.date,
      'time': instance.time,
      'home': instance.home,
      'away': instance.away,
      'score': instance.score,
      'status': instance.status,
      'is_own': instance.isOwn,
      'home_is_own': instance.homeIsOwn,
      'away_is_own': instance.awayIsOwn,
      'home_logo': instance.homeLogo,
      'away_logo': instance.awayLogo,
      'event_id': instance.eventId,
    };

_PouleMatchDay _$PouleMatchDayFromJson(Map<String, dynamic> json) =>
    _PouleMatchDay(
      date: json['date'] as String?,
      matches:
          (json['matches'] as List<dynamic>?)
              ?.map((e) => PouleMatch.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PouleMatch>[],
    );

Map<String, dynamic> _$PouleMatchDayToJson(_PouleMatchDay instance) =>
    <String, dynamic>{
      'date': instance.date,
      'matches': instance.matches.map((e) => e.toJson()).toList(),
    };

_PouleResultsPush _$PouleResultsPushFromJson(Map<String, dynamic> json) =>
    _PouleResultsPush(
      enabled: json['enabled'] as bool? ?? false,
      canPush: json['can_push'] as bool? ?? false,
    );

Map<String, dynamic> _$PouleResultsPushToJson(_PouleResultsPush instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'can_push': instance.canPush,
    };

_Poule _$PouleFromJson(Map<String, dynamic> json) => _Poule(
  pouleLabel: json['poule_label'] as String?,
  competition: json['competition'] as String?,
  fetchedAt: json['fetched_at'] == null
      ? null
      : DateTime.parse(json['fetched_at'] as String),
  standing:
      (json['standing'] as List<dynamic>?)
          ?.map((e) => PouleStanding.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PouleStanding>[],
  results:
      (json['results'] as List<dynamic>?)
          ?.map((e) => PouleMatchDay.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PouleMatchDay>[],
  fixtures:
      (json['fixtures'] as List<dynamic>?)
          ?.map((e) => PouleMatchDay.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PouleMatchDay>[],
  resultsPush: json['results_push'] == null
      ? null
      : PouleResultsPush.fromJson(json['results_push'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PouleToJson(_Poule instance) => <String, dynamic>{
  'poule_label': instance.pouleLabel,
  'competition': instance.competition,
  'fetched_at': instance.fetchedAt?.toIso8601String(),
  'standing': instance.standing.map((e) => e.toJson()).toList(),
  'results': instance.results.map((e) => e.toJson()).toList(),
  'fixtures': instance.fixtures.map((e) => e.toJson()).toList(),
  'results_push': instance.resultsPush?.toJson(),
};
