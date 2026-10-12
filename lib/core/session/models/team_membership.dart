import 'package:freezed_annotation/freezed_annotation.dart';

import 'team.dart';

part 'team_membership.freezed.dart';
part 'team_membership.g.dart';

/// Rol in `team_user`.
enum TeamRole {
  trainer,
  player,
  spectator,

  /// Een rol die deze appversie nog niet kent.
  unknown,
}

/// Eén team uit `/me` plus alles wat de PWA per team als gedeelde props krijgt.
@freezed
abstract class TeamMembership with _$TeamMembership {
  const factory TeamMembership({
    required Team team,
    @JsonKey(unknownEnumValue: TeamRole.unknown)
    @Default(TeamRole.player)
    TeamRole role,

    /// `lineup`, `training_points`, `fines`.
    @Default(<String>[]) List<String> abilities,
    @Default(<String, bool>{}) Map<String, bool> features,

    /// Volledig `SportProfile::toArray()`; typering volgt in een latere slice.
    @Default(<String, dynamic>{}) Map<String, dynamic> sport,
    @Default(false) bool hasPoule,
    @Default(false) bool onboardingOpen,
    @Default(0) int unreadNotificationsCount,
  }) = _TeamMembership;

  const TeamMembership._();

  factory TeamMembership.fromJson(Map<String, dynamic> json) =>
      _$TeamMembershipFromJson(json);

  bool get isTrainer => role == TeamRole.trainer;
  bool get isSpectator => role == TeamRole.spectator;

  /// Of deze gebruiker [ability] heeft in dit team.
  bool can(String ability) => abilities.contains(ability);

  /// Of feature [key] aanstaat voor dit team.
  bool hasFeature(String key) => features[key] ?? false;
}
