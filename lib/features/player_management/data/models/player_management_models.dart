import 'package:freezed_annotation/freezed_annotation.dart';

part 'player_management_models.freezed.dart';
part 'player_management_models.g.dart';

/// Uitnodigingsstand van een speler of toeschouwer (`invite_status`).
enum InviteStatus {
  /// Geen account.
  none,

  /// Uitgenodigd, nog niet geaccepteerd.
  pending,

  /// Account in gebruik.
  accepted,

  /// Een stand die deze appversie nog niet kent.
  unknown,
}

/// App-adoptie (`push_status`, `App\Support\AppAdoption`).
enum PushStatus {
  /// Geen account.
  na,

  /// Account, nog geen app.
  none,

  /// App geïnstalleerd, meldingen uit.
  installed,

  /// Meldingen aan.
  push,

  /// Een stand die deze appversie nog niet kent.
  unknown,
}

/// Waarom de teamlink (niet) werkt (`team_link_state` / `link_state`).
enum TeamLinkState {
  active,
  expired,
  revoked,

  /// Een stand die deze appversie nog niet kent.
  unknown,
}

/// De losse bevoegdheden die een trainer per speler aan/uit zet.
abstract final class PlayerAbility {
  static const String lineup = 'lineup';
  static const String trainingPoints = 'training_points';
  static const String fines = 'fines';

  static const List<String> all = [lineup, trainingPoints, fines];
}

/// Eén speler in het beheeroverzicht (`players[]`), ook het antwoord van
/// elke schrijvende actie op één speler.
@freezed
abstract class ManagedPlayer with _$ManagedPlayer {
  const factory ManagedPlayer({
    required int id,
    int? userId,
    int? shirtNumber,
    @Default('') String name,
    String? position,
    @Default(false) bool isGuest,
    @Default(false) bool isInjured,
    @Default(false) bool isOnVacation,
    String? fromTeam,
    String? email,
    String? avatarUrl,
    @Default(false) bool isTrainer,
    @Default(false) bool isCaptain,
    @JsonKey(unknownEnumValue: InviteStatus.unknown)
    @Default(InviteStatus.none)
    InviteStatus inviteStatus,
    @JsonKey(unknownEnumValue: PushStatus.unknown)
    @Default(PushStatus.na)
    PushStatus pushStatus,
    int? strength,

    /// `YYYY-MM-DD`, of `null`.
    String? birthdate,
    @Default(<String>[]) List<String> abilities,
  }) = _ManagedPlayer;

  const ManagedPlayer._();

  factory ManagedPlayer.fromJson(Map<String, dynamic> json) =>
      _$ManagedPlayerFromJson(json);

  /// Heeft een account (rol en bevoegdheden kunnen alleen dan).
  bool get hasAccount => userId != null;

  bool hasAbility(String ability) => abilities.contains(ability);
}

/// Een trainer van het team (`trainers[]`).
@freezed
abstract class ManagedTrainer with _$ManagedTrainer {
  const factory ManagedTrainer({
    required int id,
    @Default('') String name,
    String? email,
    String? avatarUrl,
    @Default(false) bool isSelf,
    @JsonKey(unknownEnumValue: PushStatus.unknown)
    @Default(PushStatus.none)
    PushStatus pushStatus,
  }) = _ManagedTrainer;

  factory ManagedTrainer.fromJson(Map<String, dynamic> json) =>
      _$ManagedTrainerFromJson(json);
}

/// Een toeschouwer van het team (`spectators[]`).
@freezed
abstract class ManagedSpectator with _$ManagedSpectator {
  const factory ManagedSpectator({
    required int id,
    @Default('') String name,
    String? email,
    String? avatarUrl,
    @JsonKey(unknownEnumValue: InviteStatus.unknown)
    @Default(InviteStatus.pending)
    InviteStatus inviteStatus,
  }) = _ManagedSpectator;

  factory ManagedSpectator.fromJson(Map<String, dynamic> json) =>
      _$ManagedSpectatorFromJson(json);
}

/// Een bruikbare teamlink (`team_link` / `link`).
@freezed
abstract class TeamLink with _$TeamLink {
  const factory TeamLink({required String url, DateTime? expiresAt}) =
      _TeamLink;

  factory TeamLink.fromJson(Map<String, dynamic> json) =>
      _$TeamLinkFromJson(json);
}

/// `GET teams/{team}/players`: het hele beheeroverzicht.
@freezed
abstract class PlayerManagement with _$PlayerManagement {
  const factory PlayerManagement({
    @Default(<ManagedPlayer>[]) List<ManagedPlayer> players,
    @Default(<ManagedTrainer>[]) List<ManagedTrainer> trainers,
    @Default(<ManagedSpectator>[]) List<ManagedSpectator> spectators,
    TeamLink? teamLink,
    @JsonKey(unknownEnumValue: TeamLinkState.unknown)
    @Default(TeamLinkState.active)
    TeamLinkState teamLinkState,
  }) = _PlayerManagement;

  factory PlayerManagement.fromJson(Map<String, dynamic> json) =>
      _$PlayerManagementFromJson(json);
}

/// Iemand die via de teamlink binnenkwam (`joined[]`).
@freezed
abstract class TeamLinkJoin with _$TeamLinkJoin {
  const factory TeamLinkJoin({
    required int id,
    @Default('') String name,
    String? avatarUrl,

    /// `player` of `spectator`.
    @Default('player') String role,
    DateTime? joinedAt,
  }) = _TeamLinkJoin;

  const TeamLinkJoin._();

  factory TeamLinkJoin.fromJson(Map<String, dynamic> json) =>
      _$TeamLinkJoinFromJson(json);

  bool get isSpectator => role == 'spectator';
}

/// `GET/POST/DELETE teams/{team}/teamlink`.
@freezed
abstract class TeamLinkOverview with _$TeamLinkOverview {
  const factory TeamLinkOverview({
    TeamLink? link,
    @JsonKey(unknownEnumValue: TeamLinkState.unknown)
    @Default(TeamLinkState.active)
    TeamLinkState linkState,
    @Default(90) int expiresDays,
    @Default(<TeamLinkJoin>[]) List<TeamLinkJoin> joined,
  }) = _TeamLinkOverview;

  factory TeamLinkOverview.fromJson(Map<String, dynamic> json) =>
      _$TeamLinkOverviewFromJson(json);
}

/// Een nieuwe speler (`POST teams/{team}/players`).
class NewPlayer {
  const NewPlayer({
    required this.name,
    this.shirtNumber,
    this.position,
    this.isGuest = false,
    this.sendInvite = false,
    this.email,
  });

  final String name;
  final int? shirtNumber;
  final String? position;
  final bool isGuest;
  final bool sendInvite;
  final String? email;

  Map<String, Object?> toJson() => {
    'name': name,
    'shirt_number': ?shirtNumber,
    'position': ?position,
    'is_guest': isGuest,
    'send_invite': sendInvite,
    if (sendInvite && email != null && email!.isNotEmpty) 'email': email,
  };
}

/// De velden van het bewerkscherm (`PATCH teams/{team}/players/{player}`).
///
/// Rugnummer, positie, geboortedatum en e-mail worden altijd meegestuurd:
/// leeg zet ze op `null` (zoals de PWA). [strength] en [isGuest] alleen als
/// ze gezet zijn (weggelaten = ongemoeid).
class PlayerUpdate {
  const PlayerUpdate({
    required this.name,
    this.shirtNumber,
    this.position,
    this.birthdate,
    this.email,
    this.strength,
    this.isGuest,
  });

  final String name;
  final int? shirtNumber;
  final String? position;

  /// `YYYY-MM-DD`.
  final String? birthdate;
  final String? email;
  final int? strength;
  final bool? isGuest;

  Map<String, Object?> toJson() => {
    'name': name,
    'shirt_number': shirtNumber,
    'position': position,
    'birthdate': birthdate,
    'email': (email == null || email!.isEmpty) ? null : email,
    'strength': ?strength,
    'is_guest': ?isGuest,
  };
}
