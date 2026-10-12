// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'roster_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RosterPlayer {

 int get id; int? get shirtNumber; String get name;/// Positiecode van de sport van het team (vrije tekst, mag leeg zijn).
 String? get position; String? get avatarUrl; bool get isGuest; bool get isInjured; bool get isOnVacation;
/// Create a copy of RosterPlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RosterPlayerCopyWith<RosterPlayer> get copyWith => _$RosterPlayerCopyWithImpl<RosterPlayer>(this as RosterPlayer, _$identity);

  /// Serializes this RosterPlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RosterPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.isInjured, isInjured) || other.isInjured == isInjured)&&(identical(other.isOnVacation, isOnVacation) || other.isOnVacation == isOnVacation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shirtNumber,name,position,avatarUrl,isGuest,isInjured,isOnVacation);

@override
String toString() {
  return 'RosterPlayer(id: $id, shirtNumber: $shirtNumber, name: $name, position: $position, avatarUrl: $avatarUrl, isGuest: $isGuest, isInjured: $isInjured, isOnVacation: $isOnVacation)';
}


}

/// @nodoc
abstract mixin class $RosterPlayerCopyWith<$Res>  {
  factory $RosterPlayerCopyWith(RosterPlayer value, $Res Function(RosterPlayer) _then) = _$RosterPlayerCopyWithImpl;
@useResult
$Res call({
 int id, int? shirtNumber, String name, String? position, String? avatarUrl, bool isGuest, bool isInjured, bool isOnVacation
});




}
/// @nodoc
class _$RosterPlayerCopyWithImpl<$Res>
    implements $RosterPlayerCopyWith<$Res> {
  _$RosterPlayerCopyWithImpl(this._self, this._then);

  final RosterPlayer _self;
  final $Res Function(RosterPlayer) _then;

/// Create a copy of RosterPlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shirtNumber = freezed,Object? name = null,Object? position = freezed,Object? avatarUrl = freezed,Object? isGuest = null,Object? isInjured = null,Object? isOnVacation = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,isInjured: null == isInjured ? _self.isInjured : isInjured // ignore: cast_nullable_to_non_nullable
as bool,isOnVacation: null == isOnVacation ? _self.isOnVacation : isOnVacation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RosterPlayer].
extension RosterPlayerPatterns on RosterPlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RosterPlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RosterPlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RosterPlayer value)  $default,){
final _that = this;
switch (_that) {
case _RosterPlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RosterPlayer value)?  $default,){
final _that = this;
switch (_that) {
case _RosterPlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? shirtNumber,  String name,  String? position,  String? avatarUrl,  bool isGuest,  bool isInjured,  bool isOnVacation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RosterPlayer() when $default != null:
return $default(_that.id,_that.shirtNumber,_that.name,_that.position,_that.avatarUrl,_that.isGuest,_that.isInjured,_that.isOnVacation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? shirtNumber,  String name,  String? position,  String? avatarUrl,  bool isGuest,  bool isInjured,  bool isOnVacation)  $default,) {final _that = this;
switch (_that) {
case _RosterPlayer():
return $default(_that.id,_that.shirtNumber,_that.name,_that.position,_that.avatarUrl,_that.isGuest,_that.isInjured,_that.isOnVacation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? shirtNumber,  String name,  String? position,  String? avatarUrl,  bool isGuest,  bool isInjured,  bool isOnVacation)?  $default,) {final _that = this;
switch (_that) {
case _RosterPlayer() when $default != null:
return $default(_that.id,_that.shirtNumber,_that.name,_that.position,_that.avatarUrl,_that.isGuest,_that.isInjured,_that.isOnVacation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RosterPlayer implements RosterPlayer {
  const _RosterPlayer({required this.id, this.shirtNumber, this.name = '', this.position, this.avatarUrl, this.isGuest = false, this.isInjured = false, this.isOnVacation = false});
  factory _RosterPlayer.fromJson(Map<String, dynamic> json) => _$RosterPlayerFromJson(json);

@override final  int id;
@override final  int? shirtNumber;
@override@JsonKey() final  String name;
/// Positiecode van de sport van het team (vrije tekst, mag leeg zijn).
@override final  String? position;
@override final  String? avatarUrl;
@override@JsonKey() final  bool isGuest;
@override@JsonKey() final  bool isInjured;
@override@JsonKey() final  bool isOnVacation;

/// Create a copy of RosterPlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RosterPlayerCopyWith<_RosterPlayer> get copyWith => __$RosterPlayerCopyWithImpl<_RosterPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RosterPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RosterPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.isInjured, isInjured) || other.isInjured == isInjured)&&(identical(other.isOnVacation, isOnVacation) || other.isOnVacation == isOnVacation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shirtNumber,name,position,avatarUrl,isGuest,isInjured,isOnVacation);

@override
String toString() {
  return 'RosterPlayer(id: $id, shirtNumber: $shirtNumber, name: $name, position: $position, avatarUrl: $avatarUrl, isGuest: $isGuest, isInjured: $isInjured, isOnVacation: $isOnVacation)';
}


}

/// @nodoc
abstract mixin class _$RosterPlayerCopyWith<$Res> implements $RosterPlayerCopyWith<$Res> {
  factory _$RosterPlayerCopyWith(_RosterPlayer value, $Res Function(_RosterPlayer) _then) = __$RosterPlayerCopyWithImpl;
@override @useResult
$Res call({
 int id, int? shirtNumber, String name, String? position, String? avatarUrl, bool isGuest, bool isInjured, bool isOnVacation
});




}
/// @nodoc
class __$RosterPlayerCopyWithImpl<$Res>
    implements _$RosterPlayerCopyWith<$Res> {
  __$RosterPlayerCopyWithImpl(this._self, this._then);

  final _RosterPlayer _self;
  final $Res Function(_RosterPlayer) _then;

/// Create a copy of RosterPlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shirtNumber = freezed,Object? name = null,Object? position = freezed,Object? avatarUrl = freezed,Object? isGuest = null,Object? isInjured = null,Object? isOnVacation = null,}) {
  return _then(_RosterPlayer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,isInjured: null == isInjured ? _self.isInjured : isInjured // ignore: cast_nullable_to_non_nullable
as bool,isOnVacation: null == isOnVacation ? _self.isOnVacation : isOnVacation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$RosterCoach {

 int get id; String get name; String? get avatarUrl; bool get isOnVacation;
/// Create a copy of RosterCoach
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RosterCoachCopyWith<RosterCoach> get copyWith => _$RosterCoachCopyWithImpl<RosterCoach>(this as RosterCoach, _$identity);

  /// Serializes this RosterCoach to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RosterCoach&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isOnVacation, isOnVacation) || other.isOnVacation == isOnVacation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl,isOnVacation);

@override
String toString() {
  return 'RosterCoach(id: $id, name: $name, avatarUrl: $avatarUrl, isOnVacation: $isOnVacation)';
}


}

/// @nodoc
abstract mixin class $RosterCoachCopyWith<$Res>  {
  factory $RosterCoachCopyWith(RosterCoach value, $Res Function(RosterCoach) _then) = _$RosterCoachCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? avatarUrl, bool isOnVacation
});




}
/// @nodoc
class _$RosterCoachCopyWithImpl<$Res>
    implements $RosterCoachCopyWith<$Res> {
  _$RosterCoachCopyWithImpl(this._self, this._then);

  final RosterCoach _self;
  final $Res Function(RosterCoach) _then;

/// Create a copy of RosterCoach
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,Object? isOnVacation = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isOnVacation: null == isOnVacation ? _self.isOnVacation : isOnVacation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RosterCoach].
extension RosterCoachPatterns on RosterCoach {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RosterCoach value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RosterCoach() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RosterCoach value)  $default,){
final _that = this;
switch (_that) {
case _RosterCoach():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RosterCoach value)?  $default,){
final _that = this;
switch (_that) {
case _RosterCoach() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? avatarUrl,  bool isOnVacation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RosterCoach() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl,_that.isOnVacation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? avatarUrl,  bool isOnVacation)  $default,) {final _that = this;
switch (_that) {
case _RosterCoach():
return $default(_that.id,_that.name,_that.avatarUrl,_that.isOnVacation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? avatarUrl,  bool isOnVacation)?  $default,) {final _that = this;
switch (_that) {
case _RosterCoach() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl,_that.isOnVacation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RosterCoach implements RosterCoach {
  const _RosterCoach({required this.id, this.name = '', this.avatarUrl, this.isOnVacation = false});
  factory _RosterCoach.fromJson(Map<String, dynamic> json) => _$RosterCoachFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  String? avatarUrl;
@override@JsonKey() final  bool isOnVacation;

/// Create a copy of RosterCoach
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RosterCoachCopyWith<_RosterCoach> get copyWith => __$RosterCoachCopyWithImpl<_RosterCoach>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RosterCoachToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RosterCoach&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isOnVacation, isOnVacation) || other.isOnVacation == isOnVacation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl,isOnVacation);

@override
String toString() {
  return 'RosterCoach(id: $id, name: $name, avatarUrl: $avatarUrl, isOnVacation: $isOnVacation)';
}


}

/// @nodoc
abstract mixin class _$RosterCoachCopyWith<$Res> implements $RosterCoachCopyWith<$Res> {
  factory _$RosterCoachCopyWith(_RosterCoach value, $Res Function(_RosterCoach) _then) = __$RosterCoachCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? avatarUrl, bool isOnVacation
});




}
/// @nodoc
class __$RosterCoachCopyWithImpl<$Res>
    implements _$RosterCoachCopyWith<$Res> {
  __$RosterCoachCopyWithImpl(this._self, this._then);

  final _RosterCoach _self;
  final $Res Function(_RosterCoach) _then;

/// Create a copy of RosterCoach
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,Object? isOnVacation = null,}) {
  return _then(_RosterCoach(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isOnVacation: null == isOnVacation ? _self.isOnVacation : isOnVacation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TeamRoster {

 List<RosterPlayer> get players; List<RosterCoach> get coaches;
/// Create a copy of TeamRoster
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamRosterCopyWith<TeamRoster> get copyWith => _$TeamRosterCopyWithImpl<TeamRoster>(this as TeamRoster, _$identity);

  /// Serializes this TeamRoster to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamRoster&&const DeepCollectionEquality().equals(other.players, players)&&const DeepCollectionEquality().equals(other.coaches, coaches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(players),const DeepCollectionEquality().hash(coaches));

@override
String toString() {
  return 'TeamRoster(players: $players, coaches: $coaches)';
}


}

/// @nodoc
abstract mixin class $TeamRosterCopyWith<$Res>  {
  factory $TeamRosterCopyWith(TeamRoster value, $Res Function(TeamRoster) _then) = _$TeamRosterCopyWithImpl;
@useResult
$Res call({
 List<RosterPlayer> players, List<RosterCoach> coaches
});




}
/// @nodoc
class _$TeamRosterCopyWithImpl<$Res>
    implements $TeamRosterCopyWith<$Res> {
  _$TeamRosterCopyWithImpl(this._self, this._then);

  final TeamRoster _self;
  final $Res Function(TeamRoster) _then;

/// Create a copy of TeamRoster
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? players = null,Object? coaches = null,}) {
  return _then(_self.copyWith(
players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<RosterPlayer>,coaches: null == coaches ? _self.coaches : coaches // ignore: cast_nullable_to_non_nullable
as List<RosterCoach>,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamRoster].
extension TeamRosterPatterns on TeamRoster {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamRoster value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamRoster() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamRoster value)  $default,){
final _that = this;
switch (_that) {
case _TeamRoster():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamRoster value)?  $default,){
final _that = this;
switch (_that) {
case _TeamRoster() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RosterPlayer> players,  List<RosterCoach> coaches)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamRoster() when $default != null:
return $default(_that.players,_that.coaches);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RosterPlayer> players,  List<RosterCoach> coaches)  $default,) {final _that = this;
switch (_that) {
case _TeamRoster():
return $default(_that.players,_that.coaches);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RosterPlayer> players,  List<RosterCoach> coaches)?  $default,) {final _that = this;
switch (_that) {
case _TeamRoster() when $default != null:
return $default(_that.players,_that.coaches);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamRoster extends TeamRoster {
  const _TeamRoster({final  List<RosterPlayer> players = const <RosterPlayer>[], final  List<RosterCoach> coaches = const <RosterCoach>[]}): _players = players,_coaches = coaches,super._();
  factory _TeamRoster.fromJson(Map<String, dynamic> json) => _$TeamRosterFromJson(json);

 final  List<RosterPlayer> _players;
@override@JsonKey() List<RosterPlayer> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}

 final  List<RosterCoach> _coaches;
@override@JsonKey() List<RosterCoach> get coaches {
  if (_coaches is EqualUnmodifiableListView) return _coaches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_coaches);
}


/// Create a copy of TeamRoster
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamRosterCopyWith<_TeamRoster> get copyWith => __$TeamRosterCopyWithImpl<_TeamRoster>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamRosterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamRoster&&const DeepCollectionEquality().equals(other._players, _players)&&const DeepCollectionEquality().equals(other._coaches, _coaches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_players),const DeepCollectionEquality().hash(_coaches));

@override
String toString() {
  return 'TeamRoster(players: $players, coaches: $coaches)';
}


}

/// @nodoc
abstract mixin class _$TeamRosterCopyWith<$Res> implements $TeamRosterCopyWith<$Res> {
  factory _$TeamRosterCopyWith(_TeamRoster value, $Res Function(_TeamRoster) _then) = __$TeamRosterCopyWithImpl;
@override @useResult
$Res call({
 List<RosterPlayer> players, List<RosterCoach> coaches
});




}
/// @nodoc
class __$TeamRosterCopyWithImpl<$Res>
    implements _$TeamRosterCopyWith<$Res> {
  __$TeamRosterCopyWithImpl(this._self, this._then);

  final _TeamRoster _self;
  final $Res Function(_TeamRoster) _then;

/// Create a copy of TeamRoster
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? players = null,Object? coaches = null,}) {
  return _then(_TeamRoster(
players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<RosterPlayer>,coaches: null == coaches ? _self._coaches : coaches // ignore: cast_nullable_to_non_nullable
as List<RosterCoach>,
  ));
}


}

// dart format on
