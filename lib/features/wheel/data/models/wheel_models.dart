import 'package:freezed_annotation/freezed_annotation.dart';

part 'wheel_models.freezed.dart';
part 'wheel_models.g.dart';

/// Iemand die op het rad kan (`players[]`): een speler (ook gasten) of
/// puur staf (trainer zonder spelersprofiel).
@freezed
abstract class WheelPlayer with _$WheelPlayer {
  const factory WheelPlayer({
    /// `p<player_id>` of `u<user_id>`.
    required String key,
    int? id,
    int? userId,
    @Default('') String name,
    int? shirtNumber,
    @Default(false) bool isGuest,
    @Default(false) bool isStaff,
    String? avatarUrl,
  }) = _WheelPlayer;

  const WheelPlayer._();

  factory WheelPlayer.fromJson(Map<String, dynamic> json) =>
      _$WheelPlayerFromJson(json);

  /// Hoort bij de vaste selectie (geen gast, geen pure staf).
  bool get isRoster => !isGuest && !isStaff;
}

/// Eén draai (`recent_spins[]` en de schrijfresponsen).
@freezed
abstract class WheelSpin with _$WheelSpin {
  const factory WheelSpin({
    required int id,
    @Default('') String winnerName,
    DateTime? drawnAt,
    String? drawnBy,

    /// Mag deze gebruiker hem verwijderen/koppelen/ontkoppelen.
    @Default(false) bool canDelete,

    /// De wedstrijd waar de winnaar als vlagger aan hangt.
    int? eventId,

    /// Alleen in de schrijfresponsen.
    int? winnerPlayerId,
    int? winnerUserId,
  }) = _WheelSpin;

  factory WheelSpin.fromJson(Map<String, dynamic> json) =>
      _$WheelSpinFromJson(json);
}

/// De eerstvolgende wedstrijd waar een winnaar aan kan (`upcoming_match`).
@freezed
abstract class WheelMatch with _$WheelMatch {
  const factory WheelMatch({
    required int id,
    @Default('') String label,

    /// Weergavelabel, bv. "12 okt".
    @Default('') String date,
    DateTime? startsAt,
  }) = _WheelMatch;

  factory WheelMatch.fromJson(Map<String, dynamic> json) =>
      _$WheelMatchFromJson(json);
}

/// De vulknoppen: wie er bij het eerstvolgende event is (`preset`).
@freezed
abstract class WheelPreset with _$WheelPreset {
  const factory WheelPreset({
    @Default('') String label,
    @Default('') String date,

    /// Speler-id's.
    @Default(<int>[]) List<int> presentIds,

    /// User-id's van pure staf.
    @Default(<int>[]) List<int> presentStaffIds,

    /// Aanwezig maar niet in de opstelling (speler-id's).
    @Default(<int>[]) List<int> benchIds,
  }) = _WheelPreset;

  factory WheelPreset.fromJson(Map<String, dynamic> json) =>
      _$WheelPresetFromJson(json);
}

/// `GET teams/{team}/wheel`.
@freezed
abstract class WheelOverview with _$WheelOverview {
  const factory WheelOverview({
    @Default(<WheelPlayer>[]) List<WheelPlayer> players,
    @Default(<WheelSpin>[]) List<WheelSpin> recentSpins,
    WheelMatch? upcomingMatch,
    WheelPreset? preset,
  }) = _WheelOverview;

  factory WheelOverview.fromJson(Map<String, dynamic> json) =>
      _$WheelOverviewFromJson(json);
}
