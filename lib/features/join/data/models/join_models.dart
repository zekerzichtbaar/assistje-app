import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/session/models/team.dart';

part 'join_models.freezed.dart';
part 'join_models.g.dart';

/// Een naam uit de selectie die nog van niemand is (`players[]`).
@freezed
abstract class JoinPlayer with _$JoinPlayer {
  const factory JoinPlayer({
    required int id,
    @Default('') String name,
    int? shirtNumber,
  }) = _JoinPlayer;

  factory JoinPlayer.fromJson(Map<String, dynamic> json) =>
      _$JoinPlayerFromJson(json);
}

/// `GET /join/{token}`: het aanmeldscherm van de teamlink.
@freezed
abstract class JoinLink with _$JoinLink {
  const factory JoinLink({
    required Team team,
    String? expiresAt,

    /// De ingelogde gebruiker is al lid: meteen naar het team.
    @Default(false) bool alreadyMember,
    @Default(<JoinPlayer>[]) List<JoinPlayer> players,
  }) = _JoinLink;

  factory JoinLink.fromJson(Map<String, dynamic> json) =>
      _$JoinLinkFromJson(json);
}

/// `GET /join/{token}/confirm/{login}`: het bevestigscherm voor de link uit
/// `JoinConfirmMail`. [valid] `false` = inlogtoken onbekend of verlopen.
@freezed
abstract class JoinConfirmation with _$JoinConfirmation {
  const factory JoinConfirmation({
    required Team team,
    @Default(false) bool valid,
    String? userName,
    @Default('player') String role,
    int? playerId,
    String? playerName,
    String? name,
  }) = _JoinConfirmation;

  const JoinConfirmation._();

  factory JoinConfirmation.fromJson(Map<String, dynamic> json) =>
      _$JoinConfirmationFromJson(json);

  bool get isSpectator => role == JoinRole.spectator.name;
}

/// `GET /invites/{token}`: alleen de naam, voor de begroeting.
@freezed
abstract class InviteInfo with _$InviteInfo {
  const factory InviteInfo({
    @Default('') String name,
    @Default(true) bool valid,
  }) = _InviteInfo;

  factory InviteInfo.fromJson(Map<String, dynamic> json) =>
      _$InviteInfoFromJson(json);
}

/// Meedoen als speler of als toeschouwer.
enum JoinRole { player, spectator }

/// Afloop van `POST /join/{token}`.
sealed class JoinOutcome {
  const JoinOutcome();
}

/// `200`: nieuw account, meteen binnen met [token].
final class JoinSignedIn extends JoinOutcome {
  const JoinSignedIn(this.token);

  final String token;
}

/// `202`: het adres hoort al bij een account; er ging een bevestigingsmail
/// naar [email].
final class JoinConfirmationSent extends JoinOutcome {
  const JoinConfirmationSent(this.email);

  final String email;
}
