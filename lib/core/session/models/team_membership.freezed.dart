// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team_membership.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TeamMembership {

 Team get team;@JsonKey(unknownEnumValue: TeamRole.unknown) TeamRole get role;/// `lineup`, `training_points`, `fines`.
 List<String> get abilities; Map<String, bool> get features;/// Volledig `SportProfile::toArray()`; typering volgt in een latere slice.
 Map<String, dynamic> get sport; bool get hasPoule; bool get onboardingOpen; int get unreadNotificationsCount;
/// Create a copy of TeamMembership
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamMembershipCopyWith<TeamMembership> get copyWith => _$TeamMembershipCopyWithImpl<TeamMembership>(this as TeamMembership, _$identity);

  /// Serializes this TeamMembership to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamMembership&&(identical(other.team, team) || other.team == team)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other.abilities, abilities)&&const DeepCollectionEquality().equals(other.features, features)&&const DeepCollectionEquality().equals(other.sport, sport)&&(identical(other.hasPoule, hasPoule) || other.hasPoule == hasPoule)&&(identical(other.onboardingOpen, onboardingOpen) || other.onboardingOpen == onboardingOpen)&&(identical(other.unreadNotificationsCount, unreadNotificationsCount) || other.unreadNotificationsCount == unreadNotificationsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,role,const DeepCollectionEquality().hash(abilities),const DeepCollectionEquality().hash(features),const DeepCollectionEquality().hash(sport),hasPoule,onboardingOpen,unreadNotificationsCount);

@override
String toString() {
  return 'TeamMembership(team: $team, role: $role, abilities: $abilities, features: $features, sport: $sport, hasPoule: $hasPoule, onboardingOpen: $onboardingOpen, unreadNotificationsCount: $unreadNotificationsCount)';
}


}

/// @nodoc
abstract mixin class $TeamMembershipCopyWith<$Res>  {
  factory $TeamMembershipCopyWith(TeamMembership value, $Res Function(TeamMembership) _then) = _$TeamMembershipCopyWithImpl;
@useResult
$Res call({
 Team team,@JsonKey(unknownEnumValue: TeamRole.unknown) TeamRole role, List<String> abilities, Map<String, bool> features, Map<String, dynamic> sport, bool hasPoule, bool onboardingOpen, int unreadNotificationsCount
});


$TeamCopyWith<$Res> get team;

}
/// @nodoc
class _$TeamMembershipCopyWithImpl<$Res>
    implements $TeamMembershipCopyWith<$Res> {
  _$TeamMembershipCopyWithImpl(this._self, this._then);

  final TeamMembership _self;
  final $Res Function(TeamMembership) _then;

/// Create a copy of TeamMembership
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? team = null,Object? role = null,Object? abilities = null,Object? features = null,Object? sport = null,Object? hasPoule = null,Object? onboardingOpen = null,Object? unreadNotificationsCount = null,}) {
  return _then(_self.copyWith(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as Team,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as TeamRole,abilities: null == abilities ? _self.abilities : abilities // ignore: cast_nullable_to_non_nullable
as List<String>,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,sport: null == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,hasPoule: null == hasPoule ? _self.hasPoule : hasPoule // ignore: cast_nullable_to_non_nullable
as bool,onboardingOpen: null == onboardingOpen ? _self.onboardingOpen : onboardingOpen // ignore: cast_nullable_to_non_nullable
as bool,unreadNotificationsCount: null == unreadNotificationsCount ? _self.unreadNotificationsCount : unreadNotificationsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of TeamMembership
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res> get team {
  
  return $TeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}
}


/// Adds pattern-matching-related methods to [TeamMembership].
extension TeamMembershipPatterns on TeamMembership {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamMembership value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamMembership() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamMembership value)  $default,){
final _that = this;
switch (_that) {
case _TeamMembership():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamMembership value)?  $default,){
final _that = this;
switch (_that) {
case _TeamMembership() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Team team, @JsonKey(unknownEnumValue: TeamRole.unknown)  TeamRole role,  List<String> abilities,  Map<String, bool> features,  Map<String, dynamic> sport,  bool hasPoule,  bool onboardingOpen,  int unreadNotificationsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamMembership() when $default != null:
return $default(_that.team,_that.role,_that.abilities,_that.features,_that.sport,_that.hasPoule,_that.onboardingOpen,_that.unreadNotificationsCount);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Team team, @JsonKey(unknownEnumValue: TeamRole.unknown)  TeamRole role,  List<String> abilities,  Map<String, bool> features,  Map<String, dynamic> sport,  bool hasPoule,  bool onboardingOpen,  int unreadNotificationsCount)  $default,) {final _that = this;
switch (_that) {
case _TeamMembership():
return $default(_that.team,_that.role,_that.abilities,_that.features,_that.sport,_that.hasPoule,_that.onboardingOpen,_that.unreadNotificationsCount);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Team team, @JsonKey(unknownEnumValue: TeamRole.unknown)  TeamRole role,  List<String> abilities,  Map<String, bool> features,  Map<String, dynamic> sport,  bool hasPoule,  bool onboardingOpen,  int unreadNotificationsCount)?  $default,) {final _that = this;
switch (_that) {
case _TeamMembership() when $default != null:
return $default(_that.team,_that.role,_that.abilities,_that.features,_that.sport,_that.hasPoule,_that.onboardingOpen,_that.unreadNotificationsCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamMembership extends TeamMembership {
  const _TeamMembership({required this.team, @JsonKey(unknownEnumValue: TeamRole.unknown) this.role = TeamRole.player, final  List<String> abilities = const <String>[], final  Map<String, bool> features = const <String, bool>{}, final  Map<String, dynamic> sport = const <String, dynamic>{}, this.hasPoule = false, this.onboardingOpen = false, this.unreadNotificationsCount = 0}): _abilities = abilities,_features = features,_sport = sport,super._();
  factory _TeamMembership.fromJson(Map<String, dynamic> json) => _$TeamMembershipFromJson(json);

@override final  Team team;
@override@JsonKey(unknownEnumValue: TeamRole.unknown) final  TeamRole role;
/// `lineup`, `training_points`, `fines`.
 final  List<String> _abilities;
/// `lineup`, `training_points`, `fines`.
@override@JsonKey() List<String> get abilities {
  if (_abilities is EqualUnmodifiableListView) return _abilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_abilities);
}

 final  Map<String, bool> _features;
@override@JsonKey() Map<String, bool> get features {
  if (_features is EqualUnmodifiableMapView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_features);
}

/// Volledig `SportProfile::toArray()`; typering volgt in een latere slice.
 final  Map<String, dynamic> _sport;
/// Volledig `SportProfile::toArray()`; typering volgt in een latere slice.
@override@JsonKey() Map<String, dynamic> get sport {
  if (_sport is EqualUnmodifiableMapView) return _sport;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_sport);
}

@override@JsonKey() final  bool hasPoule;
@override@JsonKey() final  bool onboardingOpen;
@override@JsonKey() final  int unreadNotificationsCount;

/// Create a copy of TeamMembership
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamMembershipCopyWith<_TeamMembership> get copyWith => __$TeamMembershipCopyWithImpl<_TeamMembership>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamMembershipToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamMembership&&(identical(other.team, team) || other.team == team)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other._abilities, _abilities)&&const DeepCollectionEquality().equals(other._features, _features)&&const DeepCollectionEquality().equals(other._sport, _sport)&&(identical(other.hasPoule, hasPoule) || other.hasPoule == hasPoule)&&(identical(other.onboardingOpen, onboardingOpen) || other.onboardingOpen == onboardingOpen)&&(identical(other.unreadNotificationsCount, unreadNotificationsCount) || other.unreadNotificationsCount == unreadNotificationsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,role,const DeepCollectionEquality().hash(_abilities),const DeepCollectionEquality().hash(_features),const DeepCollectionEquality().hash(_sport),hasPoule,onboardingOpen,unreadNotificationsCount);

@override
String toString() {
  return 'TeamMembership(team: $team, role: $role, abilities: $abilities, features: $features, sport: $sport, hasPoule: $hasPoule, onboardingOpen: $onboardingOpen, unreadNotificationsCount: $unreadNotificationsCount)';
}


}

/// @nodoc
abstract mixin class _$TeamMembershipCopyWith<$Res> implements $TeamMembershipCopyWith<$Res> {
  factory _$TeamMembershipCopyWith(_TeamMembership value, $Res Function(_TeamMembership) _then) = __$TeamMembershipCopyWithImpl;
@override @useResult
$Res call({
 Team team,@JsonKey(unknownEnumValue: TeamRole.unknown) TeamRole role, List<String> abilities, Map<String, bool> features, Map<String, dynamic> sport, bool hasPoule, bool onboardingOpen, int unreadNotificationsCount
});


@override $TeamCopyWith<$Res> get team;

}
/// @nodoc
class __$TeamMembershipCopyWithImpl<$Res>
    implements _$TeamMembershipCopyWith<$Res> {
  __$TeamMembershipCopyWithImpl(this._self, this._then);

  final _TeamMembership _self;
  final $Res Function(_TeamMembership) _then;

/// Create a copy of TeamMembership
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? team = null,Object? role = null,Object? abilities = null,Object? features = null,Object? sport = null,Object? hasPoule = null,Object? onboardingOpen = null,Object? unreadNotificationsCount = null,}) {
  return _then(_TeamMembership(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as Team,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as TeamRole,abilities: null == abilities ? _self._abilities : abilities // ignore: cast_nullable_to_non_nullable
as List<String>,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,sport: null == sport ? _self._sport : sport // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,hasPoule: null == hasPoule ? _self.hasPoule : hasPoule // ignore: cast_nullable_to_non_nullable
as bool,onboardingOpen: null == onboardingOpen ? _self.onboardingOpen : onboardingOpen // ignore: cast_nullable_to_non_nullable
as bool,unreadNotificationsCount: null == unreadNotificationsCount ? _self.unreadNotificationsCount : unreadNotificationsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of TeamMembership
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res> get team {
  
  return $TeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}
}

// dart format on
