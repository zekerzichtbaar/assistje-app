// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_teams_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingTeamsEvent _$TrainingTeamsEventFromJson(Map<String, dynamic> json) =>
    _TrainingTeamsEvent(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String? ?? '',
      startsAt: json['starts_at'] == null
          ? null
          : DateTime.parse(json['starts_at'] as String),
    );

Map<String, dynamic> _$TrainingTeamsEventToJson(_TrainingTeamsEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'starts_at': instance.startsAt?.toIso8601String(),
    };

_TrainingTeamPlayer _$TrainingTeamPlayerFromJson(Map<String, dynamic> json) =>
    _TrainingTeamPlayer(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      side: json['side'] as String?,
      position: json['position'] as String?,
      strength: (json['strength'] as num?)?.toInt(),
      derived: (json['derived'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TrainingTeamPlayerToJson(_TrainingTeamPlayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'side': instance.side,
      'position': instance.position,
      'strength': instance.strength,
      'derived': instance.derived,
    };

_TrainingTeamsBoard _$TrainingTeamsBoardFromJson(Map<String, dynamic> json) =>
    _TrainingTeamsBoard(
      mayAssign: json['may_assign'] as bool? ?? false,
      tracksPoints: json['tracks_points'] as bool? ?? false,
      tracksTeams: json['tracks_teams'] as bool? ?? false,
      basis:
          $enumDecodeNullable(
            _$TrainingBasisEnumMap,
            json['basis'],
            unknownValue: TrainingBasis.strength,
          ) ??
          TrainingBasis.strength,
      scores: json['scores'] == null
          ? const <String, int>{}
          : _scoresFromJson(json['scores']),
      players:
          (json['players'] as List<dynamic>?)
              ?.map(
                (e) => TrainingTeamPlayer.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <TrainingTeamPlayer>[],
    );

Map<String, dynamic> _$TrainingTeamsBoardToJson(_TrainingTeamsBoard instance) =>
    <String, dynamic>{
      'may_assign': instance.mayAssign,
      'tracks_points': instance.tracksPoints,
      'tracks_teams': instance.tracksTeams,
      'basis': _$TrainingBasisEnumMap[instance.basis]!,
      'scores': instance.scores,
      'players': instance.players.map((e) => e.toJson()).toList(),
    };

const _$TrainingBasisEnumMap = {
  TrainingBasis.strength: 'strength',
  TrainingBasis.points: 'points',
  TrainingBasis.random: 'random',
};

_ScoringRow _$ScoringRowFromJson(Map<String, dynamic> json) => _ScoringRow(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String? ?? '',
  shirtNumber: (json['shirt_number'] as num?)?.toInt(),
  avatarUrl: json['avatar_url'] as String?,
  scored: (json['scored'] as num?)?.toInt(),
  points: (json['points'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ScoringRowToJson(_ScoringRow instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shirt_number': instance.shirtNumber,
      'avatar_url': instance.avatarUrl,
      'scored': instance.scored,
      'points': instance.points,
    };

_ScoringOption _$ScoringOptionFromJson(Map<String, dynamic> json) =>
    _ScoringOption(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      shirtNumber: (json['shirt_number'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ScoringOptionToJson(_ScoringOption instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shirt_number': instance.shirtNumber,
    };

_TrainingTeams _$TrainingTeamsFromJson(Map<String, dynamic> json) =>
    _TrainingTeams(
      event: TrainingTeamsEvent.fromJson(json['event'] as Map<String, dynamic>),
      sides:
          (json['sides'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      maxTeams: (json['max_teams'] as num?)?.toInt() ?? 2,
      teams: json['teams'] == null
          ? const TrainingTeamsBoard()
          : TrainingTeamsBoard.fromJson(json['teams'] as Map<String, dynamic>),
      scoring:
          (json['scoring'] as List<dynamic>?)
              ?.map((e) => ScoringRow.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ScoringRow>[],
      scoringAvailable:
          (json['scoring_available'] as List<dynamic>?)
              ?.map((e) => ScoringOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ScoringOption>[],
    );

Map<String, dynamic> _$TrainingTeamsToJson(_TrainingTeams instance) =>
    <String, dynamic>{
      'event': instance.event.toJson(),
      'sides': instance.sides,
      'max_teams': instance.maxTeams,
      'teams': instance.teams.toJson(),
      'scoring': instance.scoring.map((e) => e.toJson()).toList(),
      'scoring_available': instance.scoringAvailable
          .map((e) => e.toJson())
          .toList(),
    };
