// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wheel_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WheelPlayer _$WheelPlayerFromJson(Map<String, dynamic> json) => _WheelPlayer(
  key: json['key'] as String,
  id: (json['id'] as num?)?.toInt(),
  userId: (json['user_id'] as num?)?.toInt(),
  name: json['name'] as String? ?? '',
  shirtNumber: (json['shirt_number'] as num?)?.toInt(),
  isGuest: json['is_guest'] as bool? ?? false,
  isStaff: json['is_staff'] as bool? ?? false,
  avatarUrl: json['avatar_url'] as String?,
);

Map<String, dynamic> _$WheelPlayerToJson(_WheelPlayer instance) =>
    <String, dynamic>{
      'key': instance.key,
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'shirt_number': instance.shirtNumber,
      'is_guest': instance.isGuest,
      'is_staff': instance.isStaff,
      'avatar_url': instance.avatarUrl,
    };

_WheelSpin _$WheelSpinFromJson(Map<String, dynamic> json) => _WheelSpin(
  id: (json['id'] as num).toInt(),
  winnerName: json['winner_name'] as String? ?? '',
  drawnAt: json['drawn_at'] == null
      ? null
      : DateTime.parse(json['drawn_at'] as String),
  drawnBy: json['drawn_by'] as String?,
  canDelete: json['can_delete'] as bool? ?? false,
  eventId: (json['event_id'] as num?)?.toInt(),
  winnerPlayerId: (json['winner_player_id'] as num?)?.toInt(),
  winnerUserId: (json['winner_user_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$WheelSpinToJson(_WheelSpin instance) =>
    <String, dynamic>{
      'id': instance.id,
      'winner_name': instance.winnerName,
      'drawn_at': instance.drawnAt?.toIso8601String(),
      'drawn_by': instance.drawnBy,
      'can_delete': instance.canDelete,
      'event_id': instance.eventId,
      'winner_player_id': instance.winnerPlayerId,
      'winner_user_id': instance.winnerUserId,
    };

_WheelMatch _$WheelMatchFromJson(Map<String, dynamic> json) => _WheelMatch(
  id: (json['id'] as num).toInt(),
  label: json['label'] as String? ?? '',
  date: json['date'] as String? ?? '',
  startsAt: json['starts_at'] == null
      ? null
      : DateTime.parse(json['starts_at'] as String),
);

Map<String, dynamic> _$WheelMatchToJson(_WheelMatch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'date': instance.date,
      'starts_at': instance.startsAt?.toIso8601String(),
    };

_WheelPreset _$WheelPresetFromJson(Map<String, dynamic> json) => _WheelPreset(
  label: json['label'] as String? ?? '',
  date: json['date'] as String? ?? '',
  presentIds:
      (json['present_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
  presentStaffIds:
      (json['present_staff_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
  benchIds:
      (json['bench_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
);

Map<String, dynamic> _$WheelPresetToJson(_WheelPreset instance) =>
    <String, dynamic>{
      'label': instance.label,
      'date': instance.date,
      'present_ids': instance.presentIds,
      'present_staff_ids': instance.presentStaffIds,
      'bench_ids': instance.benchIds,
    };

_WheelOverview _$WheelOverviewFromJson(Map<String, dynamic> json) =>
    _WheelOverview(
      players:
          (json['players'] as List<dynamic>?)
              ?.map((e) => WheelPlayer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <WheelPlayer>[],
      recentSpins:
          (json['recent_spins'] as List<dynamic>?)
              ?.map((e) => WheelSpin.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <WheelSpin>[],
      upcomingMatch: json['upcoming_match'] == null
          ? null
          : WheelMatch.fromJson(json['upcoming_match'] as Map<String, dynamic>),
      preset: json['preset'] == null
          ? null
          : WheelPreset.fromJson(json['preset'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WheelOverviewToJson(_WheelOverview instance) =>
    <String, dynamic>{
      'players': instance.players.map((e) => e.toJson()).toList(),
      'recent_spins': instance.recentSpins.map((e) => e.toJson()).toList(),
      'upcoming_match': instance.upcomingMatch?.toJson(),
      'preset': instance.preset?.toJson(),
    };
