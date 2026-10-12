import 'package:freezed_annotation/freezed_annotation.dart';

import 'team_membership.dart';
import 'user.dart';

part 'me.freezed.dart';
part 'me.g.dart';

/// De bootstrap uit `GET /me`: gebruiker plus al zijn teams (op naam gesorteerd).
@freezed
abstract class Me with _$Me {
  const factory Me({
    required User user,
    @Default(<TeamMembership>[]) List<TeamMembership> teams,
  }) = _Me;

  factory Me.fromJson(Map<String, dynamic> json) => _$MeFromJson(json);
}
