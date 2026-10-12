// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LiveClock _$LiveClockFromJson(Map<String, dynamic> json) => _LiveClock(
  isLive: json['is_live'] as bool? ?? false,
  running: json['running'] as bool? ?? false,
  startedAt: json['started_at'] == null
      ? null
      : DateTime.parse(json['started_at'] as String),
  accumulatedSeconds: (json['accumulated_seconds'] as num?)?.toInt() ?? 0,
  endedAt: json['ended_at'] == null
      ? null
      : DateTime.parse(json['ended_at'] as String),
  period: (json['period'] as num?)?.toInt() ?? 1,
  periodEnds:
      (json['period_ends'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
);

Map<String, dynamic> _$LiveClockToJson(_LiveClock instance) =>
    <String, dynamic>{
      'is_live': instance.isLive,
      'running': instance.running,
      'started_at': instance.startedAt?.toIso8601String(),
      'accumulated_seconds': instance.accumulatedSeconds,
      'ended_at': instance.endedAt?.toIso8601String(),
      'period': instance.period,
      'period_ends': instance.periodEnds,
    };

_LiveSet _$LiveSetFromJson(Map<String, dynamic> json) => _LiveSet(
  setNumber: (json['set_number'] as num?)?.toInt() ?? 0,
  homePoints: (json['home_points'] as num?)?.toInt() ?? 0,
  awayPoints: (json['away_points'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$LiveSetToJson(_LiveSet instance) => <String, dynamic>{
  'set_number': instance.setNumber,
  'home_points': instance.homePoints,
  'away_points': instance.awayPoints,
};

_LiveEvent _$LiveEventFromJson(Map<String, dynamic> json) => _LiveEvent(
  id: (json['id'] as num).toInt(),
  type: json['type'] as String? ?? 'match',
  title: json['title'] as String? ?? '',
  startsAt: json['starts_at'] == null
      ? null
      : DateTime.parse(json['starts_at'] as String),
  homeTeam: json['home_team'] as String?,
  awayTeam: json['away_team'] as String?,
  homeScore: (json['home_score'] as num?)?.toInt(),
  awayScore: (json['away_score'] as num?)?.toInt(),
  weAreHome: json['we_are_home'] as bool? ?? true,
  sets:
      (json['sets'] as List<dynamic>?)
          ?.map((e) => LiveSet.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LiveSet>[],
  live: json['live'] == null
      ? const LiveClock()
      : LiveClock.fromJson(json['live'] as Map<String, dynamic>),
  shareUrl: json['share_url'] as String?,
);

Map<String, dynamic> _$LiveEventToJson(_LiveEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'starts_at': instance.startsAt?.toIso8601String(),
      'home_team': instance.homeTeam,
      'away_team': instance.awayTeam,
      'home_score': instance.homeScore,
      'away_score': instance.awayScore,
      'we_are_home': instance.weAreHome,
      'sets': instance.sets.map((e) => e.toJson()).toList(),
      'live': instance.live.toJson(),
      'share_url': instance.shareUrl,
    };

_LivePeriods _$LivePeriodsFromJson(Map<String, dynamic> json) => _LivePeriods(
  count: (json['count'] as num?)?.toInt() ?? 1,
  label: json['label'] as String? ?? '',
  plural: json['plural'] as String? ?? '',
  minutes: (json['minutes'] as num?)?.toInt(),
);

Map<String, dynamic> _$LivePeriodsToJson(_LivePeriods instance) =>
    <String, dynamic>{
      'count': instance.count,
      'label': instance.label,
      'plural': instance.plural,
      'minutes': instance.minutes,
    };

_LiveTypeOption _$LiveTypeOptionFromJson(Map<String, dynamic> json) =>
    _LiveTypeOption(
      type: json['type'] as String,
      label: json['label'] as String? ?? '',
    );

Map<String, dynamic> _$LiveTypeOptionToJson(_LiveTypeOption instance) =>
    <String, dynamic>{'type': instance.type, 'label': instance.label};

_LiveRules _$LiveRulesFromJson(Map<String, dynamic> json) => _LiveRules(
  scoreModel: json['score_model'] as String? ?? 'goals',
  tracksScorers: json['tracks_scorers'] as bool? ?? false,
  periods: json['periods'] == null
      ? null
      : LivePeriods.fromJson(json['periods'] as Map<String, dynamic>),
  cardTypes:
      (json['card_types'] as List<dynamic>?)
          ?.map((e) => LiveTypeOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LiveTypeOption>[],
  momentTypes:
      (json['moment_types'] as List<dynamic>?)
          ?.map((e) => LiveTypeOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LiveTypeOption>[],
);

Map<String, dynamic> _$LiveRulesToJson(_LiveRules instance) =>
    <String, dynamic>{
      'score_model': instance.scoreModel,
      'tracks_scorers': instance.tracksScorers,
      'periods': instance.periods?.toJson(),
      'card_types': instance.cardTypes.map((e) => e.toJson()).toList(),
      'moment_types': instance.momentTypes.map((e) => e.toJson()).toList(),
    };

_LiveGoal _$LiveGoalFromJson(Map<String, dynamic> json) => _LiveGoal(
  id: (json['id'] as num).toInt(),
  itemKey: json['item_key'] as String,
  minute: (json['minute'] as num?)?.toInt() ?? 0,
  type: json['type'] as String? ?? 'goal',
  penalty: json['penalty'] as bool? ?? false,
  scorer: json['scorer'] as String?,
  scorerAvatar: json['scorer_avatar'] as String?,
  assist: json['assist'] as String?,
  createdAt: (json['created_at'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$LiveGoalToJson(_LiveGoal instance) => <String, dynamic>{
  'id': instance.id,
  'item_key': instance.itemKey,
  'minute': instance.minute,
  'type': instance.type,
  'penalty': instance.penalty,
  'scorer': instance.scorer,
  'scorer_avatar': instance.scorerAvatar,
  'assist': instance.assist,
  'created_at': instance.createdAt,
};

_LiveSub _$LiveSubFromJson(Map<String, dynamic> json) => _LiveSub(
  id: (json['id'] as num).toInt(),
  itemKey: json['item_key'] as String,
  minute: (json['minute'] as num?)?.toInt() ?? 0,
  on: json['on'] as String?,
  off: json['off'] as String?,
  createdAt: (json['created_at'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$LiveSubToJson(_LiveSub instance) => <String, dynamic>{
  'id': instance.id,
  'item_key': instance.itemKey,
  'minute': instance.minute,
  'on': instance.on,
  'off': instance.off,
  'created_at': instance.createdAt,
};

_LiveCard _$LiveCardFromJson(Map<String, dynamic> json) => _LiveCard(
  id: (json['id'] as num).toInt(),
  itemKey: json['item_key'] as String,
  minute: (json['minute'] as num?)?.toInt() ?? 0,
  type: json['type'] as String? ?? '',
  player: json['player'] as String?,
  createdAt: (json['created_at'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$LiveCardToJson(_LiveCard instance) => <String, dynamic>{
  'id': instance.id,
  'item_key': instance.itemKey,
  'minute': instance.minute,
  'type': instance.type,
  'player': instance.player,
  'created_at': instance.createdAt,
};

_LiveMoment _$LiveMomentFromJson(Map<String, dynamic> json) => _LiveMoment(
  id: (json['id'] as num).toInt(),
  itemKey: json['item_key'] as String,
  minute: (json['minute'] as num?)?.toInt() ?? 0,
  type: json['type'] as String? ?? '',
  label: json['label'] as String? ?? '',
  player: json['player'] as String?,
  createdAt: (json['created_at'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$LiveMomentToJson(_LiveMoment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item_key': instance.itemKey,
      'minute': instance.minute,
      'type': instance.type,
      'label': instance.label,
      'player': instance.player,
      'created_at': instance.createdAt,
    };

_LiveReaction _$LiveReactionFromJson(Map<String, dynamic> json) =>
    _LiveReaction(
      emoji: json['emoji'] as String,
      count: (json['count'] as num?)?.toInt() ?? 0,
      mine: json['mine'] as bool? ?? false,
    );

Map<String, dynamic> _$LiveReactionToJson(_LiveReaction instance) =>
    <String, dynamic>{
      'emoji': instance.emoji,
      'count': instance.count,
      'mine': instance.mine,
    };

_LivePickerPlayer _$LivePickerPlayerFromJson(Map<String, dynamic> json) =>
    _LivePickerPlayer(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      shirtNumber: (json['shirt_number'] as num?)?.toInt(),
      onField: json['on_field'] as bool? ?? false,
    );

Map<String, dynamic> _$LivePickerPlayerToJson(_LivePickerPlayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shirt_number': instance.shirtNumber,
      'on_field': instance.onField,
    };

_LivePickers _$LivePickersFromJson(Map<String, dynamic> json) => _LivePickers(
  hasLineup: json['has_lineup'] as bool? ?? false,
  present:
      (json['present'] as List<dynamic>?)
          ?.map((e) => LivePickerPlayer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LivePickerPlayer>[],
  allPlayers:
      (json['all_players'] as List<dynamic>?)
          ?.map((e) => LivePickerPlayer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LivePickerPlayer>[],
);

Map<String, dynamic> _$LivePickersToJson(_LivePickers instance) =>
    <String, dynamic>{
      'has_lineup': instance.hasLineup,
      'present': instance.present.map((e) => e.toJson()).toList(),
      'all_players': instance.allPlayers.map((e) => e.toJson()).toList(),
    };

_LiveMatch _$LiveMatchFromJson(Map<String, dynamic> json) => _LiveMatch(
  sport: json['sport'] as String? ?? '',
  event: LiveEvent.fromJson(json['event'] as Map<String, dynamic>),
  rules: json['rules'] == null
      ? const LiveRules()
      : LiveRules.fromJson(json['rules'] as Map<String, dynamic>),
  goals:
      (json['goals'] as List<dynamic>?)
          ?.map((e) => LiveGoal.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LiveGoal>[],
  subs:
      (json['subs'] as List<dynamic>?)
          ?.map((e) => LiveSub.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LiveSub>[],
  cards:
      (json['cards'] as List<dynamic>?)
          ?.map((e) => LiveCard.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LiveCard>[],
  moments:
      (json['moments'] as List<dynamic>?)
          ?.map((e) => LiveMoment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LiveMoment>[],
  reactions: json['reactions'] == null
      ? const <String, List<LiveReaction>>{}
      : const LiveReactionsConverter().fromJson(json['reactions']),
  canReact: json['can_react'] as bool? ?? false,
  reactionEmoji:
      (json['reaction_emoji'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  liveViewers: (json['live_viewers'] as num?)?.toInt() ?? 0,
  followingLive: json['following_live'] as bool? ?? false,
  canManage: json['can_manage'] as bool? ?? false,
  pickers: json['pickers'] == null
      ? null
      : LivePickers.fromJson(json['pickers'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LiveMatchToJson(_LiveMatch instance) =>
    <String, dynamic>{
      'sport': instance.sport,
      'event': instance.event.toJson(),
      'rules': instance.rules.toJson(),
      'goals': instance.goals.map((e) => e.toJson()).toList(),
      'subs': instance.subs.map((e) => e.toJson()).toList(),
      'cards': instance.cards.map((e) => e.toJson()).toList(),
      'moments': instance.moments.map((e) => e.toJson()).toList(),
      'reactions': const LiveReactionsConverter().toJson(instance.reactions),
      'can_react': instance.canReact,
      'reaction_emoji': instance.reactionEmoji,
      'live_viewers': instance.liveViewers,
      'following_live': instance.followingLive,
      'can_manage': instance.canManage,
      'pickers': instance.pickers?.toJson(),
    };
