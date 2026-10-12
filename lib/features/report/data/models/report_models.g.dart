// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReportEvent _$ReportEventFromJson(Map<String, dynamic> json) => _ReportEvent(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String? ?? '',
  startsAt: json['starts_at'] as String?,
  homeTeam: json['home_team'] as String?,
  awayTeam: json['away_team'] as String?,
  weAreHome: json['we_are_home'] as bool? ?? true,
);

Map<String, dynamic> _$ReportEventToJson(_ReportEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'starts_at': instance.startsAt,
      'home_team': instance.homeTeam,
      'away_team': instance.awayTeam,
      'we_are_home': instance.weAreHome,
    };

_ReportPlayer _$ReportPlayerFromJson(Map<String, dynamic> json) =>
    _ReportPlayer(
      id: (json['id'] as num).toInt(),
      shirtNumber: (json['shirt_number'] as num?)?.toInt(),
      name: json['name'] as String? ?? '',
      position: json['position'] as String? ?? '',
      isGuest: json['is_guest'] as bool? ?? false,
    );

Map<String, dynamic> _$ReportPlayerToJson(_ReportPlayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shirt_number': instance.shirtNumber,
      'name': instance.name,
      'position': instance.position,
      'is_guest': instance.isGuest,
    };

_ReportLineupRow _$ReportLineupRowFromJson(Map<String, dynamic> json) =>
    _ReportLineupRow(
      slotCode: json['slot_code'] as String? ?? '',
      player: ReportPlayer.fromJson(json['player'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportLineupRowToJson(_ReportLineupRow instance) =>
    <String, dynamic>{
      'slot_code': instance.slotCode,
      'player': instance.player.toJson(),
    };

_ReportSet _$ReportSetFromJson(Map<String, dynamic> json) => _ReportSet(
  setNumber: (json['set_number'] as num?)?.toInt() ?? 0,
  homePoints: (json['home_points'] as num?)?.toInt() ?? 0,
  awayPoints: (json['away_points'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ReportSetToJson(_ReportSet instance) =>
    <String, dynamic>{
      'set_number': instance.setNumber,
      'home_points': instance.homePoints,
      'away_points': instance.awayPoints,
    };

_MatchReport _$MatchReportFromJson(Map<String, dynamic> json) => _MatchReport(
  event: ReportEvent.fromJson(json['event'] as Map<String, dynamic>),
  scoreModel: json['score_model'] as String? ?? 'goals',
  homeScore: (json['home_score'] as num?)?.toInt(),
  awayScore: (json['away_score'] as num?)?.toInt(),
  maxSets: (json['max_sets'] as num?)?.toInt(),
  sets:
      (json['sets'] as List<dynamic>?)
          ?.map((e) => ReportSet.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ReportSet>[],
  statsMode: json['stats_mode'] as String? ?? '',
  statColumns:
      (json['stat_columns'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  canImport: json['can_import'] as bool? ?? false,
  lineup:
      (json['lineup'] as List<dynamic>?)
          ?.map((e) => ReportLineupRow.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ReportLineupRow>[],
  bench:
      (json['bench'] as List<dynamic>?)
          ?.map((e) => ReportPlayer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ReportPlayer>[],
  playerStats:
      (json['player_stats'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const <Map<String, dynamic>>[],
);

Map<String, dynamic> _$MatchReportToJson(_MatchReport instance) =>
    <String, dynamic>{
      'event': instance.event.toJson(),
      'score_model': instance.scoreModel,
      'home_score': instance.homeScore,
      'away_score': instance.awayScore,
      'max_sets': instance.maxSets,
      'sets': instance.sets.map((e) => e.toJson()).toList(),
      'stats_mode': instance.statsMode,
      'stat_columns': instance.statColumns,
      'can_import': instance.canImport,
      'lineup': instance.lineup.map((e) => e.toJson()).toList(),
      'bench': instance.bench.map((e) => e.toJson()).toList(),
      'player_stats': instance.playerStats,
    };

_ScoutSet _$ScoutSetFromJson(Map<String, dynamic> json) => _ScoutSet(
  home: (json['home'] as num?)?.toInt() ?? 0,
  away: (json['away'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ScoutSetToJson(_ScoutSet instance) => <String, dynamic>{
  'home': instance.home,
  'away': instance.away,
};

_ScoutRow _$ScoutRowFromJson(Map<String, dynamic> json) => _ScoutRow(
  shirtNumber: (json['shirt_number'] as num?)?.toInt(),
  name: json['name'] as String? ?? '',
  stats: json['stats'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  playerId: (json['player_id'] as num?)?.toInt(),
  matchedOn: json['matched_on'] as String?,
);

Map<String, dynamic> _$ScoutRowToJson(_ScoutRow instance) => <String, dynamic>{
  'shirt_number': instance.shirtNumber,
  'name': instance.name,
  'stats': instance.stats,
  'player_id': instance.playerId,
  'matched_on': instance.matchedOn,
};

_ScoutTeam _$ScoutTeamFromJson(Map<String, dynamic> json) => _ScoutTeam(
  name: json['name'] as String? ?? '',
  players:
      (json['players'] as List<dynamic>?)
          ?.map((e) => ScoutRow.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ScoutRow>[],
);

Map<String, dynamic> _$ScoutTeamToJson(_ScoutTeam instance) =>
    <String, dynamic>{
      'name': instance.name,
      'players': instance.players.map((e) => e.toJson()).toList(),
    };

_ScoutRosterEntry _$ScoutRosterEntryFromJson(Map<String, dynamic> json) =>
    _ScoutRosterEntry(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      shirtNumber: (json['shirt_number'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ScoutRosterEntryToJson(_ScoutRosterEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shirt_number': instance.shirtNumber,
    };

_ScoutPreview _$ScoutPreviewFromJson(Map<String, dynamic> json) =>
    _ScoutPreview(
      sets:
          (json['sets'] as List<dynamic>?)
              ?.map((e) => ScoutSet.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ScoutSet>[],
      teams:
          (json['teams'] as List<dynamic>?)
              ?.map((e) => ScoutTeam.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ScoutTeam>[],
      ourTeamIndex: (json['our_team_index'] as num?)?.toInt(),
      roster:
          (json['roster'] as List<dynamic>?)
              ?.map((e) => ScoutRosterEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ScoutRosterEntry>[],
    );

Map<String, dynamic> _$ScoutPreviewToJson(_ScoutPreview instance) =>
    <String, dynamic>{
      'sets': instance.sets.map((e) => e.toJson()).toList(),
      'teams': instance.teams.map((e) => e.toJson()).toList(),
      'our_team_index': instance.ourTeamIndex,
      'roster': instance.roster.map((e) => e.toJson()).toList(),
    };

_FlagCandidate _$FlagCandidateFromJson(Map<String, dynamic> json) =>
    _FlagCandidate(
      key: json['key'] as String,
      playerId: (json['player_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      name: json['name'] as String? ?? '',
      guest: json['guest'] as bool? ?? false,
      staff: json['staff'] as bool? ?? false,
    );

Map<String, dynamic> _$FlagCandidateToJson(_FlagCandidate instance) =>
    <String, dynamic>{
      'key': instance.key,
      'player_id': instance.playerId,
      'user_id': instance.userId,
      'name': instance.name,
      'guest': instance.guest,
      'staff': instance.staff,
    };

_FlagDutyEdit _$FlagDutyEditFromJson(Map<String, dynamic> json) =>
    _FlagDutyEdit(
      shifts:
          (json['shifts'] as List<dynamic>?)
              ?.map((e) => FlagShift.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FlagShift>[],
      names:
          (json['names'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      mine: json['mine'] as bool? ?? false,
      matchMinutes: (json['match_minutes'] as num?)?.toInt() ?? 90,
      pool:
          (json['pool'] as List<dynamic>?)
              ?.map((e) => FlagCandidate.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FlagCandidate>[],
    );

Map<String, dynamic> _$FlagDutyEditToJson(_FlagDutyEdit instance) =>
    <String, dynamic>{
      'shifts': instance.shifts.map((e) => e.toJson()).toList(),
      'names': instance.names,
      'mine': instance.mine,
      'match_minutes': instance.matchMinutes,
      'pool': instance.pool.map((e) => e.toJson()).toList(),
    };
