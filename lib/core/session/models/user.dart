import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// De ingelogde gebruiker, zoals `/me` en `/auth/exchange` hem teruggeven.
@freezed
abstract class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String? email,
    String? pendingEmail,
    String? avatarUrl,

    /// Kale kalenderdag `YYYY-MM-DD`; bewust een string (geen tijdzone).
    String? birthdate,
    @Default(false) bool isSuperAdmin,
    @Default(ProfileMissing()) ProfileMissing profileMissing,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

/// Welke profielvelden nog ontbreken (voor de "maak je profiel af"-nudges).
@freezed
abstract class ProfileMissing with _$ProfileMissing {
  const factory ProfileMissing({
    @Default(false) bool avatar,
    @Default(false) bool birthdate,
    @Default(false) bool email,
  }) = _ProfileMissing;

  factory ProfileMissing.fromJson(Map<String, dynamic> json) =>
      _$ProfileMissingFromJson(json);
}
