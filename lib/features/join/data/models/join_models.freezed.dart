// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'join_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JoinPlayer {

 int get id; String get name; int? get shirtNumber;
/// Create a copy of JoinPlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinPlayerCopyWith<JoinPlayer> get copyWith => _$JoinPlayerCopyWithImpl<JoinPlayer>(this as JoinPlayer, _$identity);

  /// Serializes this JoinPlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber);

@override
String toString() {
  return 'JoinPlayer(id: $id, name: $name, shirtNumber: $shirtNumber)';
}


}

/// @nodoc
abstract mixin class $JoinPlayerCopyWith<$Res>  {
  factory $JoinPlayerCopyWith(JoinPlayer value, $Res Function(JoinPlayer) _then) = _$JoinPlayerCopyWithImpl;
@useResult
$Res call({
 int id, String name, int? shirtNumber
});




}
/// @nodoc
class _$JoinPlayerCopyWithImpl<$Res>
    implements $JoinPlayerCopyWith<$Res> {
  _$JoinPlayerCopyWithImpl(this._self, this._then);

  final JoinPlayer _self;
  final $Res Function(JoinPlayer) _then;

/// Create a copy of JoinPlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [JoinPlayer].
extension JoinPlayerPatterns on JoinPlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JoinPlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JoinPlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JoinPlayer value)  $default,){
final _that = this;
switch (_that) {
case _JoinPlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JoinPlayer value)?  $default,){
final _that = this;
switch (_that) {
case _JoinPlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int? shirtNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JoinPlayer() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int? shirtNumber)  $default,) {final _that = this;
switch (_that) {
case _JoinPlayer():
return $default(_that.id,_that.name,_that.shirtNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int? shirtNumber)?  $default,) {final _that = this;
switch (_that) {
case _JoinPlayer() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JoinPlayer implements JoinPlayer {
  const _JoinPlayer({required this.id, this.name = '', this.shirtNumber});
  factory _JoinPlayer.fromJson(Map<String, dynamic> json) => _$JoinPlayerFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  int? shirtNumber;

/// Create a copy of JoinPlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinPlayerCopyWith<_JoinPlayer> get copyWith => __$JoinPlayerCopyWithImpl<_JoinPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JoinPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber);

@override
String toString() {
  return 'JoinPlayer(id: $id, name: $name, shirtNumber: $shirtNumber)';
}


}

/// @nodoc
abstract mixin class _$JoinPlayerCopyWith<$Res> implements $JoinPlayerCopyWith<$Res> {
  factory _$JoinPlayerCopyWith(_JoinPlayer value, $Res Function(_JoinPlayer) _then) = __$JoinPlayerCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int? shirtNumber
});




}
/// @nodoc
class __$JoinPlayerCopyWithImpl<$Res>
    implements _$JoinPlayerCopyWith<$Res> {
  __$JoinPlayerCopyWithImpl(this._self, this._then);

  final _JoinPlayer _self;
  final $Res Function(_JoinPlayer) _then;

/// Create a copy of JoinPlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,}) {
  return _then(_JoinPlayer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$JoinLink {

 Team get team; String? get expiresAt;/// De ingelogde gebruiker is al lid: meteen naar het team.
 bool get alreadyMember; List<JoinPlayer> get players;
/// Create a copy of JoinLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinLinkCopyWith<JoinLink> get copyWith => _$JoinLinkCopyWithImpl<JoinLink>(this as JoinLink, _$identity);

  /// Serializes this JoinLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinLink&&(identical(other.team, team) || other.team == team)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.alreadyMember, alreadyMember) || other.alreadyMember == alreadyMember)&&const DeepCollectionEquality().equals(other.players, players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,expiresAt,alreadyMember,const DeepCollectionEquality().hash(players));

@override
String toString() {
  return 'JoinLink(team: $team, expiresAt: $expiresAt, alreadyMember: $alreadyMember, players: $players)';
}


}

/// @nodoc
abstract mixin class $JoinLinkCopyWith<$Res>  {
  factory $JoinLinkCopyWith(JoinLink value, $Res Function(JoinLink) _then) = _$JoinLinkCopyWithImpl;
@useResult
$Res call({
 Team team, String? expiresAt, bool alreadyMember, List<JoinPlayer> players
});


$TeamCopyWith<$Res> get team;

}
/// @nodoc
class _$JoinLinkCopyWithImpl<$Res>
    implements $JoinLinkCopyWith<$Res> {
  _$JoinLinkCopyWithImpl(this._self, this._then);

  final JoinLink _self;
  final $Res Function(JoinLink) _then;

/// Create a copy of JoinLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? team = null,Object? expiresAt = freezed,Object? alreadyMember = null,Object? players = null,}) {
  return _then(_self.copyWith(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as Team,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,alreadyMember: null == alreadyMember ? _self.alreadyMember : alreadyMember // ignore: cast_nullable_to_non_nullable
as bool,players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<JoinPlayer>,
  ));
}
/// Create a copy of JoinLink
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res> get team {
  
  return $TeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}
}


/// Adds pattern-matching-related methods to [JoinLink].
extension JoinLinkPatterns on JoinLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JoinLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JoinLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JoinLink value)  $default,){
final _that = this;
switch (_that) {
case _JoinLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JoinLink value)?  $default,){
final _that = this;
switch (_that) {
case _JoinLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Team team,  String? expiresAt,  bool alreadyMember,  List<JoinPlayer> players)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JoinLink() when $default != null:
return $default(_that.team,_that.expiresAt,_that.alreadyMember,_that.players);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Team team,  String? expiresAt,  bool alreadyMember,  List<JoinPlayer> players)  $default,) {final _that = this;
switch (_that) {
case _JoinLink():
return $default(_that.team,_that.expiresAt,_that.alreadyMember,_that.players);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Team team,  String? expiresAt,  bool alreadyMember,  List<JoinPlayer> players)?  $default,) {final _that = this;
switch (_that) {
case _JoinLink() when $default != null:
return $default(_that.team,_that.expiresAt,_that.alreadyMember,_that.players);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JoinLink implements JoinLink {
  const _JoinLink({required this.team, this.expiresAt, this.alreadyMember = false, final  List<JoinPlayer> players = const <JoinPlayer>[]}): _players = players;
  factory _JoinLink.fromJson(Map<String, dynamic> json) => _$JoinLinkFromJson(json);

@override final  Team team;
@override final  String? expiresAt;
/// De ingelogde gebruiker is al lid: meteen naar het team.
@override@JsonKey() final  bool alreadyMember;
 final  List<JoinPlayer> _players;
@override@JsonKey() List<JoinPlayer> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}


/// Create a copy of JoinLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinLinkCopyWith<_JoinLink> get copyWith => __$JoinLinkCopyWithImpl<_JoinLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JoinLinkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinLink&&(identical(other.team, team) || other.team == team)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.alreadyMember, alreadyMember) || other.alreadyMember == alreadyMember)&&const DeepCollectionEquality().equals(other._players, _players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,expiresAt,alreadyMember,const DeepCollectionEquality().hash(_players));

@override
String toString() {
  return 'JoinLink(team: $team, expiresAt: $expiresAt, alreadyMember: $alreadyMember, players: $players)';
}


}

/// @nodoc
abstract mixin class _$JoinLinkCopyWith<$Res> implements $JoinLinkCopyWith<$Res> {
  factory _$JoinLinkCopyWith(_JoinLink value, $Res Function(_JoinLink) _then) = __$JoinLinkCopyWithImpl;
@override @useResult
$Res call({
 Team team, String? expiresAt, bool alreadyMember, List<JoinPlayer> players
});


@override $TeamCopyWith<$Res> get team;

}
/// @nodoc
class __$JoinLinkCopyWithImpl<$Res>
    implements _$JoinLinkCopyWith<$Res> {
  __$JoinLinkCopyWithImpl(this._self, this._then);

  final _JoinLink _self;
  final $Res Function(_JoinLink) _then;

/// Create a copy of JoinLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? team = null,Object? expiresAt = freezed,Object? alreadyMember = null,Object? players = null,}) {
  return _then(_JoinLink(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as Team,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,alreadyMember: null == alreadyMember ? _self.alreadyMember : alreadyMember // ignore: cast_nullable_to_non_nullable
as bool,players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<JoinPlayer>,
  ));
}

/// Create a copy of JoinLink
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res> get team {
  
  return $TeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}
}


/// @nodoc
mixin _$JoinConfirmation {

 Team get team; bool get valid; String? get userName; String get role; int? get playerId; String? get playerName; String? get name;
/// Create a copy of JoinConfirmation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinConfirmationCopyWith<JoinConfirmation> get copyWith => _$JoinConfirmationCopyWithImpl<JoinConfirmation>(this as JoinConfirmation, _$identity);

  /// Serializes this JoinConfirmation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinConfirmation&&(identical(other.team, team) || other.team == team)&&(identical(other.valid, valid) || other.valid == valid)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.role, role) || other.role == role)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,valid,userName,role,playerId,playerName,name);

@override
String toString() {
  return 'JoinConfirmation(team: $team, valid: $valid, userName: $userName, role: $role, playerId: $playerId, playerName: $playerName, name: $name)';
}


}

/// @nodoc
abstract mixin class $JoinConfirmationCopyWith<$Res>  {
  factory $JoinConfirmationCopyWith(JoinConfirmation value, $Res Function(JoinConfirmation) _then) = _$JoinConfirmationCopyWithImpl;
@useResult
$Res call({
 Team team, bool valid, String? userName, String role, int? playerId, String? playerName, String? name
});


$TeamCopyWith<$Res> get team;

}
/// @nodoc
class _$JoinConfirmationCopyWithImpl<$Res>
    implements $JoinConfirmationCopyWith<$Res> {
  _$JoinConfirmationCopyWithImpl(this._self, this._then);

  final JoinConfirmation _self;
  final $Res Function(JoinConfirmation) _then;

/// Create a copy of JoinConfirmation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? team = null,Object? valid = null,Object? userName = freezed,Object? role = null,Object? playerId = freezed,Object? playerName = freezed,Object? name = freezed,}) {
  return _then(_self.copyWith(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as Team,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,playerName: freezed == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of JoinConfirmation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res> get team {
  
  return $TeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}
}


/// Adds pattern-matching-related methods to [JoinConfirmation].
extension JoinConfirmationPatterns on JoinConfirmation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JoinConfirmation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JoinConfirmation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JoinConfirmation value)  $default,){
final _that = this;
switch (_that) {
case _JoinConfirmation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JoinConfirmation value)?  $default,){
final _that = this;
switch (_that) {
case _JoinConfirmation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Team team,  bool valid,  String? userName,  String role,  int? playerId,  String? playerName,  String? name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JoinConfirmation() when $default != null:
return $default(_that.team,_that.valid,_that.userName,_that.role,_that.playerId,_that.playerName,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Team team,  bool valid,  String? userName,  String role,  int? playerId,  String? playerName,  String? name)  $default,) {final _that = this;
switch (_that) {
case _JoinConfirmation():
return $default(_that.team,_that.valid,_that.userName,_that.role,_that.playerId,_that.playerName,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Team team,  bool valid,  String? userName,  String role,  int? playerId,  String? playerName,  String? name)?  $default,) {final _that = this;
switch (_that) {
case _JoinConfirmation() when $default != null:
return $default(_that.team,_that.valid,_that.userName,_that.role,_that.playerId,_that.playerName,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JoinConfirmation extends JoinConfirmation {
  const _JoinConfirmation({required this.team, this.valid = false, this.userName, this.role = 'player', this.playerId, this.playerName, this.name}): super._();
  factory _JoinConfirmation.fromJson(Map<String, dynamic> json) => _$JoinConfirmationFromJson(json);

@override final  Team team;
@override@JsonKey() final  bool valid;
@override final  String? userName;
@override@JsonKey() final  String role;
@override final  int? playerId;
@override final  String? playerName;
@override final  String? name;

/// Create a copy of JoinConfirmation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinConfirmationCopyWith<_JoinConfirmation> get copyWith => __$JoinConfirmationCopyWithImpl<_JoinConfirmation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JoinConfirmationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinConfirmation&&(identical(other.team, team) || other.team == team)&&(identical(other.valid, valid) || other.valid == valid)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.role, role) || other.role == role)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,valid,userName,role,playerId,playerName,name);

@override
String toString() {
  return 'JoinConfirmation(team: $team, valid: $valid, userName: $userName, role: $role, playerId: $playerId, playerName: $playerName, name: $name)';
}


}

/// @nodoc
abstract mixin class _$JoinConfirmationCopyWith<$Res> implements $JoinConfirmationCopyWith<$Res> {
  factory _$JoinConfirmationCopyWith(_JoinConfirmation value, $Res Function(_JoinConfirmation) _then) = __$JoinConfirmationCopyWithImpl;
@override @useResult
$Res call({
 Team team, bool valid, String? userName, String role, int? playerId, String? playerName, String? name
});


@override $TeamCopyWith<$Res> get team;

}
/// @nodoc
class __$JoinConfirmationCopyWithImpl<$Res>
    implements _$JoinConfirmationCopyWith<$Res> {
  __$JoinConfirmationCopyWithImpl(this._self, this._then);

  final _JoinConfirmation _self;
  final $Res Function(_JoinConfirmation) _then;

/// Create a copy of JoinConfirmation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? team = null,Object? valid = null,Object? userName = freezed,Object? role = null,Object? playerId = freezed,Object? playerName = freezed,Object? name = freezed,}) {
  return _then(_JoinConfirmation(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as Team,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,playerName: freezed == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of JoinConfirmation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamCopyWith<$Res> get team {
  
  return $TeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}
}


/// @nodoc
mixin _$InviteInfo {

 String get name; bool get valid;
/// Create a copy of InviteInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviteInfoCopyWith<InviteInfo> get copyWith => _$InviteInfoCopyWithImpl<InviteInfo>(this as InviteInfo, _$identity);

  /// Serializes this InviteInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviteInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.valid, valid) || other.valid == valid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,valid);

@override
String toString() {
  return 'InviteInfo(name: $name, valid: $valid)';
}


}

/// @nodoc
abstract mixin class $InviteInfoCopyWith<$Res>  {
  factory $InviteInfoCopyWith(InviteInfo value, $Res Function(InviteInfo) _then) = _$InviteInfoCopyWithImpl;
@useResult
$Res call({
 String name, bool valid
});




}
/// @nodoc
class _$InviteInfoCopyWithImpl<$Res>
    implements $InviteInfoCopyWith<$Res> {
  _$InviteInfoCopyWithImpl(this._self, this._then);

  final InviteInfo _self;
  final $Res Function(InviteInfo) _then;

/// Create a copy of InviteInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? valid = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [InviteInfo].
extension InviteInfoPatterns on InviteInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviteInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviteInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviteInfo value)  $default,){
final _that = this;
switch (_that) {
case _InviteInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviteInfo value)?  $default,){
final _that = this;
switch (_that) {
case _InviteInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  bool valid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviteInfo() when $default != null:
return $default(_that.name,_that.valid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  bool valid)  $default,) {final _that = this;
switch (_that) {
case _InviteInfo():
return $default(_that.name,_that.valid);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  bool valid)?  $default,) {final _that = this;
switch (_that) {
case _InviteInfo() when $default != null:
return $default(_that.name,_that.valid);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviteInfo implements InviteInfo {
  const _InviteInfo({this.name = '', this.valid = true});
  factory _InviteInfo.fromJson(Map<String, dynamic> json) => _$InviteInfoFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  bool valid;

/// Create a copy of InviteInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviteInfoCopyWith<_InviteInfo> get copyWith => __$InviteInfoCopyWithImpl<_InviteInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviteInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviteInfo&&(identical(other.name, name) || other.name == name)&&(identical(other.valid, valid) || other.valid == valid));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,valid);

@override
String toString() {
  return 'InviteInfo(name: $name, valid: $valid)';
}


}

/// @nodoc
abstract mixin class _$InviteInfoCopyWith<$Res> implements $InviteInfoCopyWith<$Res> {
  factory _$InviteInfoCopyWith(_InviteInfo value, $Res Function(_InviteInfo) _then) = __$InviteInfoCopyWithImpl;
@override @useResult
$Res call({
 String name, bool valid
});




}
/// @nodoc
class __$InviteInfoCopyWithImpl<$Res>
    implements _$InviteInfoCopyWith<$Res> {
  __$InviteInfoCopyWithImpl(this._self, this._then);

  final _InviteInfo _self;
  final $Res Function(_InviteInfo) _then;

/// Create a copy of InviteInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? valid = null,}) {
  return _then(_InviteInfo(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
