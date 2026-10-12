import 'package:freezed_annotation/freezed_annotation.dart';

part 'team.freezed.dart';
part 'team.g.dart';

/// Een team (whitelist uit `TeamResource`).
@freezed
abstract class Team with _$Team {
  const factory Team({
    required int id,
    required String name,
    required String slug,
    required String sport,
    String? logoUrl,
    @Default(false) bool logoFills,

    /// Teamkleur als hex (`#006837`); `null` = standaardkleur.
    String? primaryColor,
    String? url,
    @Default(false) bool isDemo,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}
