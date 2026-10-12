// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lineup_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LineupPlayer _$LineupPlayerFromJson(Map<String, dynamic> json) =>
    _LineupPlayer(
      id: (json['id'] as num).toInt(),
      shirtNumber: (json['shirt_number'] as num?)?.toInt(),
      name: json['name'] as String? ?? '',
      position: json['position'] as String? ?? '',
      isGuest: json['is_guest'] as bool? ?? false,
      fromTeam: json['from_team'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$LineupPlayerToJson(_LineupPlayer instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shirt_number': instance.shirtNumber,
      'name': instance.name,
      'position': instance.position,
      'is_guest': instance.isGuest,
      'from_team': instance.fromTeam,
      'avatar_url': instance.avatarUrl,
    };

_LineupSlot _$LineupSlotFromJson(Map<String, dynamic> json) => _LineupSlot(
  id: (json['id'] as num?)?.toInt() ?? 0,
  slotCode: json['slot_code'] as String,
  player: LineupPlayer.fromJson(json['player'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LineupSlotToJson(_LineupSlot instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slot_code': instance.slotCode,
      'player': instance.player.toJson(),
    };

_FormationSlot _$FormationSlotFromJson(Map<String, dynamic> json) =>
    _FormationSlot(
      code: json['code'] as String,
      x: (json['x'] as num?)?.toDouble() ?? 50,
      y: (json['y'] as num?)?.toDouble() ?? 50,
      label: json['label'] as String? ?? '',
    );

Map<String, dynamic> _$FormationSlotToJson(_FormationSlot instance) =>
    <String, dynamic>{
      'code': instance.code,
      'x': instance.x,
      'y': instance.y,
      'label': instance.label,
    };

_FormationOption _$FormationOptionFromJson(Map<String, dynamic> json) =>
    _FormationOption(
      key: json['key'] as String,
      label: json['label'] as String? ?? '',
    );

Map<String, dynamic> _$FormationOptionToJson(_FormationOption instance) =>
    <String, dynamic>{'key': instance.key, 'label': instance.label};

_LineupEvent _$LineupEventFromJson(Map<String, dynamic> json) => _LineupEvent(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String? ?? '',
  startsAt: json['starts_at'] as String?,
  homeTeam: json['home_team'] as String?,
  awayTeam: json['away_team'] as String?,
);

Map<String, dynamic> _$LineupEventToJson(_LineupEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'starts_at': instance.startsAt,
      'home_team': instance.homeTeam,
      'away_team': instance.awayTeam,
    };

_Lineup _$LineupFromJson(Map<String, dynamic> json) => _Lineup(
  sport: json['sport'] as String? ?? '',
  fieldVariant: json['field_variant'] as String? ?? '',
  event: LineupEvent.fromJson(json['event'] as Map<String, dynamic>),
  pool:
      (json['pool'] as List<dynamic>?)
          ?.map((e) => LineupPlayer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LineupPlayer>[],
  slots:
      (json['slots'] as List<dynamic>?)
          ?.map((e) => LineupSlot.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LineupSlot>[],
  formation: json['formation'] as String? ?? '',
  formationSlots:
      (json['formation_slots'] as List<dynamic>?)
          ?.map((e) => FormationSlot.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <FormationSlot>[],
  formations:
      (json['formations'] as List<dynamic>?)
          ?.map((e) => FormationOption.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <FormationOption>[],
  formationLabel: json['formation_label'] as String? ?? '',
  canEdit: json['can_edit'] as bool? ?? false,
  captainPlayerId: (json['captain_player_id'] as num?)?.toInt(),
  publishedAt: json['published_at'] as String?,
  changedSincePublish: json['changed_since_publish'] as bool? ?? false,
);

Map<String, dynamic> _$LineupToJson(_Lineup instance) => <String, dynamic>{
  'sport': instance.sport,
  'field_variant': instance.fieldVariant,
  'event': instance.event.toJson(),
  'pool': instance.pool.map((e) => e.toJson()).toList(),
  'slots': instance.slots.map((e) => e.toJson()).toList(),
  'formation': instance.formation,
  'formation_slots': instance.formationSlots.map((e) => e.toJson()).toList(),
  'formations': instance.formations.map((e) => e.toJson()).toList(),
  'formation_label': instance.formationLabel,
  'can_edit': instance.canEdit,
  'captain_player_id': instance.captainPlayerId,
  'published_at': instance.publishedAt,
  'changed_since_publish': instance.changedSincePublish,
};
