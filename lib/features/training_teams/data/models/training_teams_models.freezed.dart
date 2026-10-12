// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_teams_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingTeamsEvent {

 int get id; String get title; DateTime? get startsAt;
/// Create a copy of TrainingTeamsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingTeamsEventCopyWith<TrainingTeamsEvent> get copyWith => _$TrainingTeamsEventCopyWithImpl<TrainingTeamsEvent>(this as TrainingTeamsEvent, _$identity);

  /// Serializes this TrainingTeamsEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingTeamsEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt);

@override
String toString() {
  return 'TrainingTeamsEvent(id: $id, title: $title, startsAt: $startsAt)';
}


}

/// @nodoc
abstract mixin class $TrainingTeamsEventCopyWith<$Res>  {
  factory $TrainingTeamsEventCopyWith(TrainingTeamsEvent value, $Res Function(TrainingTeamsEvent) _then) = _$TrainingTeamsEventCopyWithImpl;
@useResult
$Res call({
 int id, String title, DateTime? startsAt
});




}
/// @nodoc
class _$TrainingTeamsEventCopyWithImpl<$Res>
    implements $TrainingTeamsEventCopyWith<$Res> {
  _$TrainingTeamsEventCopyWithImpl(this._self, this._then);

  final TrainingTeamsEvent _self;
  final $Res Function(TrainingTeamsEvent) _then;

/// Create a copy of TrainingTeamsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingTeamsEvent].
extension TrainingTeamsEventPatterns on TrainingTeamsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingTeamsEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingTeamsEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingTeamsEvent value)  $default,){
final _that = this;
switch (_that) {
case _TrainingTeamsEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingTeamsEvent value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingTeamsEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  DateTime? startsAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingTeamsEvent() when $default != null:
return $default(_that.id,_that.title,_that.startsAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  DateTime? startsAt)  $default,) {final _that = this;
switch (_that) {
case _TrainingTeamsEvent():
return $default(_that.id,_that.title,_that.startsAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  DateTime? startsAt)?  $default,) {final _that = this;
switch (_that) {
case _TrainingTeamsEvent() when $default != null:
return $default(_that.id,_that.title,_that.startsAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingTeamsEvent implements TrainingTeamsEvent {
  const _TrainingTeamsEvent({required this.id, this.title = '', this.startsAt});
  factory _TrainingTeamsEvent.fromJson(Map<String, dynamic> json) => _$TrainingTeamsEventFromJson(json);

@override final  int id;
@override@JsonKey() final  String title;
@override final  DateTime? startsAt;

/// Create a copy of TrainingTeamsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingTeamsEventCopyWith<_TrainingTeamsEvent> get copyWith => __$TrainingTeamsEventCopyWithImpl<_TrainingTeamsEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingTeamsEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingTeamsEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt);

@override
String toString() {
  return 'TrainingTeamsEvent(id: $id, title: $title, startsAt: $startsAt)';
}


}

/// @nodoc
abstract mixin class _$TrainingTeamsEventCopyWith<$Res> implements $TrainingTeamsEventCopyWith<$Res> {
  factory _$TrainingTeamsEventCopyWith(_TrainingTeamsEvent value, $Res Function(_TrainingTeamsEvent) _then) = __$TrainingTeamsEventCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, DateTime? startsAt
});




}
/// @nodoc
class __$TrainingTeamsEventCopyWithImpl<$Res>
    implements _$TrainingTeamsEventCopyWith<$Res> {
  __$TrainingTeamsEventCopyWithImpl(this._self, this._then);

  final _TrainingTeamsEvent _self;
  final $Res Function(_TrainingTeamsEvent) _then;

/// Create a copy of TrainingTeamsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,}) {
  return _then(_TrainingTeamsEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$TrainingTeamPlayer {

 int get id; String get name; String? get side;/// Positiecode uit het sportprofiel (label via `SportInfo`).
 String? get position;/// Ingestelde speelsterkte (1–5); alleen voor wie mag indelen.
 int? get strength;/// Afgeleid uit de historie (1–5, met decimalen); alleen voor wie mag
/// indelen en niet bij basis `random`.
 double? get derived;
/// Create a copy of TrainingTeamPlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingTeamPlayerCopyWith<TrainingTeamPlayer> get copyWith => _$TrainingTeamPlayerCopyWithImpl<TrainingTeamPlayer>(this as TrainingTeamPlayer, _$identity);

  /// Serializes this TrainingTeamPlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingTeamPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.side, side) || other.side == side)&&(identical(other.position, position) || other.position == position)&&(identical(other.strength, strength) || other.strength == strength)&&(identical(other.derived, derived) || other.derived == derived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,side,position,strength,derived);

@override
String toString() {
  return 'TrainingTeamPlayer(id: $id, name: $name, side: $side, position: $position, strength: $strength, derived: $derived)';
}


}

/// @nodoc
abstract mixin class $TrainingTeamPlayerCopyWith<$Res>  {
  factory $TrainingTeamPlayerCopyWith(TrainingTeamPlayer value, $Res Function(TrainingTeamPlayer) _then) = _$TrainingTeamPlayerCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? side, String? position, int? strength, double? derived
});




}
/// @nodoc
class _$TrainingTeamPlayerCopyWithImpl<$Res>
    implements $TrainingTeamPlayerCopyWith<$Res> {
  _$TrainingTeamPlayerCopyWithImpl(this._self, this._then);

  final TrainingTeamPlayer _self;
  final $Res Function(TrainingTeamPlayer) _then;

/// Create a copy of TrainingTeamPlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? side = freezed,Object? position = freezed,Object? strength = freezed,Object? derived = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,side: freezed == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,strength: freezed == strength ? _self.strength : strength // ignore: cast_nullable_to_non_nullable
as int?,derived: freezed == derived ? _self.derived : derived // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingTeamPlayer].
extension TrainingTeamPlayerPatterns on TrainingTeamPlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingTeamPlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingTeamPlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingTeamPlayer value)  $default,){
final _that = this;
switch (_that) {
case _TrainingTeamPlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingTeamPlayer value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingTeamPlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? side,  String? position,  int? strength,  double? derived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingTeamPlayer() when $default != null:
return $default(_that.id,_that.name,_that.side,_that.position,_that.strength,_that.derived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? side,  String? position,  int? strength,  double? derived)  $default,) {final _that = this;
switch (_that) {
case _TrainingTeamPlayer():
return $default(_that.id,_that.name,_that.side,_that.position,_that.strength,_that.derived);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? side,  String? position,  int? strength,  double? derived)?  $default,) {final _that = this;
switch (_that) {
case _TrainingTeamPlayer() when $default != null:
return $default(_that.id,_that.name,_that.side,_that.position,_that.strength,_that.derived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingTeamPlayer implements TrainingTeamPlayer {
  const _TrainingTeamPlayer({required this.id, this.name = '', this.side, this.position, this.strength, this.derived});
  factory _TrainingTeamPlayer.fromJson(Map<String, dynamic> json) => _$TrainingTeamPlayerFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  String? side;
/// Positiecode uit het sportprofiel (label via `SportInfo`).
@override final  String? position;
/// Ingestelde speelsterkte (1–5); alleen voor wie mag indelen.
@override final  int? strength;
/// Afgeleid uit de historie (1–5, met decimalen); alleen voor wie mag
/// indelen en niet bij basis `random`.
@override final  double? derived;

/// Create a copy of TrainingTeamPlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingTeamPlayerCopyWith<_TrainingTeamPlayer> get copyWith => __$TrainingTeamPlayerCopyWithImpl<_TrainingTeamPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingTeamPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingTeamPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.side, side) || other.side == side)&&(identical(other.position, position) || other.position == position)&&(identical(other.strength, strength) || other.strength == strength)&&(identical(other.derived, derived) || other.derived == derived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,side,position,strength,derived);

@override
String toString() {
  return 'TrainingTeamPlayer(id: $id, name: $name, side: $side, position: $position, strength: $strength, derived: $derived)';
}


}

/// @nodoc
abstract mixin class _$TrainingTeamPlayerCopyWith<$Res> implements $TrainingTeamPlayerCopyWith<$Res> {
  factory _$TrainingTeamPlayerCopyWith(_TrainingTeamPlayer value, $Res Function(_TrainingTeamPlayer) _then) = __$TrainingTeamPlayerCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? side, String? position, int? strength, double? derived
});




}
/// @nodoc
class __$TrainingTeamPlayerCopyWithImpl<$Res>
    implements _$TrainingTeamPlayerCopyWith<$Res> {
  __$TrainingTeamPlayerCopyWithImpl(this._self, this._then);

  final _TrainingTeamPlayer _self;
  final $Res Function(_TrainingTeamPlayer) _then;

/// Create a copy of TrainingTeamPlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? side = freezed,Object? position = freezed,Object? strength = freezed,Object? derived = freezed,}) {
  return _then(_TrainingTeamPlayer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,side: freezed == side ? _self.side : side // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,strength: freezed == strength ? _self.strength : strength // ignore: cast_nullable_to_non_nullable
as int?,derived: freezed == derived ? _self.derived : derived // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$TrainingTeamsBoard {

 bool get mayAssign; bool get tracksPoints; bool get tracksTeams;@JsonKey(unknownEnumValue: TrainingBasis.strength) TrainingBasis get basis;/// Uitslag per ploeg (`side` → punten). Leeg = nog niets ingevuld.
@JsonKey(fromJson: _scoresFromJson) Map<String, int> get scores; List<TrainingTeamPlayer> get players;
/// Create a copy of TrainingTeamsBoard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingTeamsBoardCopyWith<TrainingTeamsBoard> get copyWith => _$TrainingTeamsBoardCopyWithImpl<TrainingTeamsBoard>(this as TrainingTeamsBoard, _$identity);

  /// Serializes this TrainingTeamsBoard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingTeamsBoard&&(identical(other.mayAssign, mayAssign) || other.mayAssign == mayAssign)&&(identical(other.tracksPoints, tracksPoints) || other.tracksPoints == tracksPoints)&&(identical(other.tracksTeams, tracksTeams) || other.tracksTeams == tracksTeams)&&(identical(other.basis, basis) || other.basis == basis)&&const DeepCollectionEquality().equals(other.scores, scores)&&const DeepCollectionEquality().equals(other.players, players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mayAssign,tracksPoints,tracksTeams,basis,const DeepCollectionEquality().hash(scores),const DeepCollectionEquality().hash(players));

@override
String toString() {
  return 'TrainingTeamsBoard(mayAssign: $mayAssign, tracksPoints: $tracksPoints, tracksTeams: $tracksTeams, basis: $basis, scores: $scores, players: $players)';
}


}

/// @nodoc
abstract mixin class $TrainingTeamsBoardCopyWith<$Res>  {
  factory $TrainingTeamsBoardCopyWith(TrainingTeamsBoard value, $Res Function(TrainingTeamsBoard) _then) = _$TrainingTeamsBoardCopyWithImpl;
@useResult
$Res call({
 bool mayAssign, bool tracksPoints, bool tracksTeams,@JsonKey(unknownEnumValue: TrainingBasis.strength) TrainingBasis basis,@JsonKey(fromJson: _scoresFromJson) Map<String, int> scores, List<TrainingTeamPlayer> players
});




}
/// @nodoc
class _$TrainingTeamsBoardCopyWithImpl<$Res>
    implements $TrainingTeamsBoardCopyWith<$Res> {
  _$TrainingTeamsBoardCopyWithImpl(this._self, this._then);

  final TrainingTeamsBoard _self;
  final $Res Function(TrainingTeamsBoard) _then;

/// Create a copy of TrainingTeamsBoard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mayAssign = null,Object? tracksPoints = null,Object? tracksTeams = null,Object? basis = null,Object? scores = null,Object? players = null,}) {
  return _then(_self.copyWith(
mayAssign: null == mayAssign ? _self.mayAssign : mayAssign // ignore: cast_nullable_to_non_nullable
as bool,tracksPoints: null == tracksPoints ? _self.tracksPoints : tracksPoints // ignore: cast_nullable_to_non_nullable
as bool,tracksTeams: null == tracksTeams ? _self.tracksTeams : tracksTeams // ignore: cast_nullable_to_non_nullable
as bool,basis: null == basis ? _self.basis : basis // ignore: cast_nullable_to_non_nullable
as TrainingBasis,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as Map<String, int>,players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<TrainingTeamPlayer>,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingTeamsBoard].
extension TrainingTeamsBoardPatterns on TrainingTeamsBoard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingTeamsBoard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingTeamsBoard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingTeamsBoard value)  $default,){
final _that = this;
switch (_that) {
case _TrainingTeamsBoard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingTeamsBoard value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingTeamsBoard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool mayAssign,  bool tracksPoints,  bool tracksTeams, @JsonKey(unknownEnumValue: TrainingBasis.strength)  TrainingBasis basis, @JsonKey(fromJson: _scoresFromJson)  Map<String, int> scores,  List<TrainingTeamPlayer> players)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingTeamsBoard() when $default != null:
return $default(_that.mayAssign,_that.tracksPoints,_that.tracksTeams,_that.basis,_that.scores,_that.players);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool mayAssign,  bool tracksPoints,  bool tracksTeams, @JsonKey(unknownEnumValue: TrainingBasis.strength)  TrainingBasis basis, @JsonKey(fromJson: _scoresFromJson)  Map<String, int> scores,  List<TrainingTeamPlayer> players)  $default,) {final _that = this;
switch (_that) {
case _TrainingTeamsBoard():
return $default(_that.mayAssign,_that.tracksPoints,_that.tracksTeams,_that.basis,_that.scores,_that.players);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool mayAssign,  bool tracksPoints,  bool tracksTeams, @JsonKey(unknownEnumValue: TrainingBasis.strength)  TrainingBasis basis, @JsonKey(fromJson: _scoresFromJson)  Map<String, int> scores,  List<TrainingTeamPlayer> players)?  $default,) {final _that = this;
switch (_that) {
case _TrainingTeamsBoard() when $default != null:
return $default(_that.mayAssign,_that.tracksPoints,_that.tracksTeams,_that.basis,_that.scores,_that.players);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingTeamsBoard extends TrainingTeamsBoard {
  const _TrainingTeamsBoard({this.mayAssign = false, this.tracksPoints = false, this.tracksTeams = false, @JsonKey(unknownEnumValue: TrainingBasis.strength) this.basis = TrainingBasis.strength, @JsonKey(fromJson: _scoresFromJson) final  Map<String, int> scores = const <String, int>{}, final  List<TrainingTeamPlayer> players = const <TrainingTeamPlayer>[]}): _scores = scores,_players = players,super._();
  factory _TrainingTeamsBoard.fromJson(Map<String, dynamic> json) => _$TrainingTeamsBoardFromJson(json);

@override@JsonKey() final  bool mayAssign;
@override@JsonKey() final  bool tracksPoints;
@override@JsonKey() final  bool tracksTeams;
@override@JsonKey(unknownEnumValue: TrainingBasis.strength) final  TrainingBasis basis;
/// Uitslag per ploeg (`side` → punten). Leeg = nog niets ingevuld.
 final  Map<String, int> _scores;
/// Uitslag per ploeg (`side` → punten). Leeg = nog niets ingevuld.
@override@JsonKey(fromJson: _scoresFromJson) Map<String, int> get scores {
  if (_scores is EqualUnmodifiableMapView) return _scores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_scores);
}

 final  List<TrainingTeamPlayer> _players;
@override@JsonKey() List<TrainingTeamPlayer> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}


/// Create a copy of TrainingTeamsBoard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingTeamsBoardCopyWith<_TrainingTeamsBoard> get copyWith => __$TrainingTeamsBoardCopyWithImpl<_TrainingTeamsBoard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingTeamsBoardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingTeamsBoard&&(identical(other.mayAssign, mayAssign) || other.mayAssign == mayAssign)&&(identical(other.tracksPoints, tracksPoints) || other.tracksPoints == tracksPoints)&&(identical(other.tracksTeams, tracksTeams) || other.tracksTeams == tracksTeams)&&(identical(other.basis, basis) || other.basis == basis)&&const DeepCollectionEquality().equals(other._scores, _scores)&&const DeepCollectionEquality().equals(other._players, _players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mayAssign,tracksPoints,tracksTeams,basis,const DeepCollectionEquality().hash(_scores),const DeepCollectionEquality().hash(_players));

@override
String toString() {
  return 'TrainingTeamsBoard(mayAssign: $mayAssign, tracksPoints: $tracksPoints, tracksTeams: $tracksTeams, basis: $basis, scores: $scores, players: $players)';
}


}

/// @nodoc
abstract mixin class _$TrainingTeamsBoardCopyWith<$Res> implements $TrainingTeamsBoardCopyWith<$Res> {
  factory _$TrainingTeamsBoardCopyWith(_TrainingTeamsBoard value, $Res Function(_TrainingTeamsBoard) _then) = __$TrainingTeamsBoardCopyWithImpl;
@override @useResult
$Res call({
 bool mayAssign, bool tracksPoints, bool tracksTeams,@JsonKey(unknownEnumValue: TrainingBasis.strength) TrainingBasis basis,@JsonKey(fromJson: _scoresFromJson) Map<String, int> scores, List<TrainingTeamPlayer> players
});




}
/// @nodoc
class __$TrainingTeamsBoardCopyWithImpl<$Res>
    implements _$TrainingTeamsBoardCopyWith<$Res> {
  __$TrainingTeamsBoardCopyWithImpl(this._self, this._then);

  final _TrainingTeamsBoard _self;
  final $Res Function(_TrainingTeamsBoard) _then;

/// Create a copy of TrainingTeamsBoard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mayAssign = null,Object? tracksPoints = null,Object? tracksTeams = null,Object? basis = null,Object? scores = null,Object? players = null,}) {
  return _then(_TrainingTeamsBoard(
mayAssign: null == mayAssign ? _self.mayAssign : mayAssign // ignore: cast_nullable_to_non_nullable
as bool,tracksPoints: null == tracksPoints ? _self.tracksPoints : tracksPoints // ignore: cast_nullable_to_non_nullable
as bool,tracksTeams: null == tracksTeams ? _self.tracksTeams : tracksTeams // ignore: cast_nullable_to_non_nullable
as bool,basis: null == basis ? _self.basis : basis // ignore: cast_nullable_to_non_nullable
as TrainingBasis,scores: null == scores ? _self._scores : scores // ignore: cast_nullable_to_non_nullable
as Map<String, int>,players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<TrainingTeamPlayer>,
  ));
}


}


/// @nodoc
mixin _$ScoringRow {

 int get id; String get name; int? get shirtNumber; String? get avatarUrl;/// Wat de partijvorm opleverde; `null` = nog niets.
 int? get scored;/// Inclusief het aanwezigheidspunt als het team dat rekent.
 int get points;
/// Create a copy of ScoringRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoringRowCopyWith<ScoringRow> get copyWith => _$ScoringRowCopyWithImpl<ScoringRow>(this as ScoringRow, _$identity);

  /// Serializes this ScoringRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoringRow&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.scored, scored) || other.scored == scored)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber,avatarUrl,scored,points);

@override
String toString() {
  return 'ScoringRow(id: $id, name: $name, shirtNumber: $shirtNumber, avatarUrl: $avatarUrl, scored: $scored, points: $points)';
}


}

/// @nodoc
abstract mixin class $ScoringRowCopyWith<$Res>  {
  factory $ScoringRowCopyWith(ScoringRow value, $Res Function(ScoringRow) _then) = _$ScoringRowCopyWithImpl;
@useResult
$Res call({
 int id, String name, int? shirtNumber, String? avatarUrl, int? scored, int points
});




}
/// @nodoc
class _$ScoringRowCopyWithImpl<$Res>
    implements $ScoringRowCopyWith<$Res> {
  _$ScoringRowCopyWithImpl(this._self, this._then);

  final ScoringRow _self;
  final $Res Function(ScoringRow) _then;

/// Create a copy of ScoringRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,Object? avatarUrl = freezed,Object? scored = freezed,Object? points = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,scored: freezed == scored ? _self.scored : scored // ignore: cast_nullable_to_non_nullable
as int?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoringRow].
extension ScoringRowPatterns on ScoringRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoringRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoringRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoringRow value)  $default,){
final _that = this;
switch (_that) {
case _ScoringRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoringRow value)?  $default,){
final _that = this;
switch (_that) {
case _ScoringRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int? shirtNumber,  String? avatarUrl,  int? scored,  int points)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoringRow() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber,_that.avatarUrl,_that.scored,_that.points);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int? shirtNumber,  String? avatarUrl,  int? scored,  int points)  $default,) {final _that = this;
switch (_that) {
case _ScoringRow():
return $default(_that.id,_that.name,_that.shirtNumber,_that.avatarUrl,_that.scored,_that.points);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int? shirtNumber,  String? avatarUrl,  int? scored,  int points)?  $default,) {final _that = this;
switch (_that) {
case _ScoringRow() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber,_that.avatarUrl,_that.scored,_that.points);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoringRow implements ScoringRow {
  const _ScoringRow({required this.id, this.name = '', this.shirtNumber, this.avatarUrl, this.scored, this.points = 0});
  factory _ScoringRow.fromJson(Map<String, dynamic> json) => _$ScoringRowFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  int? shirtNumber;
@override final  String? avatarUrl;
/// Wat de partijvorm opleverde; `null` = nog niets.
@override final  int? scored;
/// Inclusief het aanwezigheidspunt als het team dat rekent.
@override@JsonKey() final  int points;

/// Create a copy of ScoringRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoringRowCopyWith<_ScoringRow> get copyWith => __$ScoringRowCopyWithImpl<_ScoringRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoringRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoringRow&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.scored, scored) || other.scored == scored)&&(identical(other.points, points) || other.points == points));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber,avatarUrl,scored,points);

@override
String toString() {
  return 'ScoringRow(id: $id, name: $name, shirtNumber: $shirtNumber, avatarUrl: $avatarUrl, scored: $scored, points: $points)';
}


}

/// @nodoc
abstract mixin class _$ScoringRowCopyWith<$Res> implements $ScoringRowCopyWith<$Res> {
  factory _$ScoringRowCopyWith(_ScoringRow value, $Res Function(_ScoringRow) _then) = __$ScoringRowCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int? shirtNumber, String? avatarUrl, int? scored, int points
});




}
/// @nodoc
class __$ScoringRowCopyWithImpl<$Res>
    implements _$ScoringRowCopyWith<$Res> {
  __$ScoringRowCopyWithImpl(this._self, this._then);

  final _ScoringRow _self;
  final $Res Function(_ScoringRow) _then;

/// Create a copy of ScoringRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,Object? avatarUrl = freezed,Object? scored = freezed,Object? points = null,}) {
  return _then(_ScoringRow(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,scored: freezed == scored ? _self.scored : scored // ignore: cast_nullable_to_non_nullable
as int?,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ScoringOption {

 int get id; String get name; int? get shirtNumber;
/// Create a copy of ScoringOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoringOptionCopyWith<ScoringOption> get copyWith => _$ScoringOptionCopyWithImpl<ScoringOption>(this as ScoringOption, _$identity);

  /// Serializes this ScoringOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoringOption&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber);

@override
String toString() {
  return 'ScoringOption(id: $id, name: $name, shirtNumber: $shirtNumber)';
}


}

/// @nodoc
abstract mixin class $ScoringOptionCopyWith<$Res>  {
  factory $ScoringOptionCopyWith(ScoringOption value, $Res Function(ScoringOption) _then) = _$ScoringOptionCopyWithImpl;
@useResult
$Res call({
 int id, String name, int? shirtNumber
});




}
/// @nodoc
class _$ScoringOptionCopyWithImpl<$Res>
    implements $ScoringOptionCopyWith<$Res> {
  _$ScoringOptionCopyWithImpl(this._self, this._then);

  final ScoringOption _self;
  final $Res Function(ScoringOption) _then;

/// Create a copy of ScoringOption
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


/// Adds pattern-matching-related methods to [ScoringOption].
extension ScoringOptionPatterns on ScoringOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoringOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoringOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoringOption value)  $default,){
final _that = this;
switch (_that) {
case _ScoringOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoringOption value)?  $default,){
final _that = this;
switch (_that) {
case _ScoringOption() when $default != null:
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
case _ScoringOption() when $default != null:
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
case _ScoringOption():
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
case _ScoringOption() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoringOption implements ScoringOption {
  const _ScoringOption({required this.id, this.name = '', this.shirtNumber});
  factory _ScoringOption.fromJson(Map<String, dynamic> json) => _$ScoringOptionFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  int? shirtNumber;

/// Create a copy of ScoringOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoringOptionCopyWith<_ScoringOption> get copyWith => __$ScoringOptionCopyWithImpl<_ScoringOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoringOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoringOption&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber);

@override
String toString() {
  return 'ScoringOption(id: $id, name: $name, shirtNumber: $shirtNumber)';
}


}

/// @nodoc
abstract mixin class _$ScoringOptionCopyWith<$Res> implements $ScoringOptionCopyWith<$Res> {
  factory _$ScoringOptionCopyWith(_ScoringOption value, $Res Function(_ScoringOption) _then) = __$ScoringOptionCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int? shirtNumber
});




}
/// @nodoc
class __$ScoringOptionCopyWithImpl<$Res>
    implements _$ScoringOptionCopyWith<$Res> {
  __$ScoringOptionCopyWithImpl(this._self, this._then);

  final _ScoringOption _self;
  final $Res Function(_ScoringOption) _then;

/// Create a copy of ScoringOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,}) {
  return _then(_ScoringOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$TrainingTeams {

 TrainingTeamsEvent get event;/// De mogelijke ploegcodes, in volgorde.
 List<String> get sides; int get maxTeams; TrainingTeamsBoard get teams; List<ScoringRow> get scoring; List<ScoringOption> get scoringAvailable;
/// Create a copy of TrainingTeams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingTeamsCopyWith<TrainingTeams> get copyWith => _$TrainingTeamsCopyWithImpl<TrainingTeams>(this as TrainingTeams, _$identity);

  /// Serializes this TrainingTeams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingTeams&&(identical(other.event, event) || other.event == event)&&const DeepCollectionEquality().equals(other.sides, sides)&&(identical(other.maxTeams, maxTeams) || other.maxTeams == maxTeams)&&(identical(other.teams, teams) || other.teams == teams)&&const DeepCollectionEquality().equals(other.scoring, scoring)&&const DeepCollectionEquality().equals(other.scoringAvailable, scoringAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,event,const DeepCollectionEquality().hash(sides),maxTeams,teams,const DeepCollectionEquality().hash(scoring),const DeepCollectionEquality().hash(scoringAvailable));

@override
String toString() {
  return 'TrainingTeams(event: $event, sides: $sides, maxTeams: $maxTeams, teams: $teams, scoring: $scoring, scoringAvailable: $scoringAvailable)';
}


}

/// @nodoc
abstract mixin class $TrainingTeamsCopyWith<$Res>  {
  factory $TrainingTeamsCopyWith(TrainingTeams value, $Res Function(TrainingTeams) _then) = _$TrainingTeamsCopyWithImpl;
@useResult
$Res call({
 TrainingTeamsEvent event, List<String> sides, int maxTeams, TrainingTeamsBoard teams, List<ScoringRow> scoring, List<ScoringOption> scoringAvailable
});


$TrainingTeamsEventCopyWith<$Res> get event;$TrainingTeamsBoardCopyWith<$Res> get teams;

}
/// @nodoc
class _$TrainingTeamsCopyWithImpl<$Res>
    implements $TrainingTeamsCopyWith<$Res> {
  _$TrainingTeamsCopyWithImpl(this._self, this._then);

  final TrainingTeams _self;
  final $Res Function(TrainingTeams) _then;

/// Create a copy of TrainingTeams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? event = null,Object? sides = null,Object? maxTeams = null,Object? teams = null,Object? scoring = null,Object? scoringAvailable = null,}) {
  return _then(_self.copyWith(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as TrainingTeamsEvent,sides: null == sides ? _self.sides : sides // ignore: cast_nullable_to_non_nullable
as List<String>,maxTeams: null == maxTeams ? _self.maxTeams : maxTeams // ignore: cast_nullable_to_non_nullable
as int,teams: null == teams ? _self.teams : teams // ignore: cast_nullable_to_non_nullable
as TrainingTeamsBoard,scoring: null == scoring ? _self.scoring : scoring // ignore: cast_nullable_to_non_nullable
as List<ScoringRow>,scoringAvailable: null == scoringAvailable ? _self.scoringAvailable : scoringAvailable // ignore: cast_nullable_to_non_nullable
as List<ScoringOption>,
  ));
}
/// Create a copy of TrainingTeams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrainingTeamsEventCopyWith<$Res> get event {
  
  return $TrainingTeamsEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}/// Create a copy of TrainingTeams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrainingTeamsBoardCopyWith<$Res> get teams {
  
  return $TrainingTeamsBoardCopyWith<$Res>(_self.teams, (value) {
    return _then(_self.copyWith(teams: value));
  });
}
}


/// Adds pattern-matching-related methods to [TrainingTeams].
extension TrainingTeamsPatterns on TrainingTeams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingTeams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingTeams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingTeams value)  $default,){
final _that = this;
switch (_that) {
case _TrainingTeams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingTeams value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingTeams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TrainingTeamsEvent event,  List<String> sides,  int maxTeams,  TrainingTeamsBoard teams,  List<ScoringRow> scoring,  List<ScoringOption> scoringAvailable)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingTeams() when $default != null:
return $default(_that.event,_that.sides,_that.maxTeams,_that.teams,_that.scoring,_that.scoringAvailable);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TrainingTeamsEvent event,  List<String> sides,  int maxTeams,  TrainingTeamsBoard teams,  List<ScoringRow> scoring,  List<ScoringOption> scoringAvailable)  $default,) {final _that = this;
switch (_that) {
case _TrainingTeams():
return $default(_that.event,_that.sides,_that.maxTeams,_that.teams,_that.scoring,_that.scoringAvailable);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TrainingTeamsEvent event,  List<String> sides,  int maxTeams,  TrainingTeamsBoard teams,  List<ScoringRow> scoring,  List<ScoringOption> scoringAvailable)?  $default,) {final _that = this;
switch (_that) {
case _TrainingTeams() when $default != null:
return $default(_that.event,_that.sides,_that.maxTeams,_that.teams,_that.scoring,_that.scoringAvailable);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingTeams extends TrainingTeams {
  const _TrainingTeams({required this.event, final  List<String> sides = const <String>[], this.maxTeams = 2, this.teams = const TrainingTeamsBoard(), final  List<ScoringRow> scoring = const <ScoringRow>[], final  List<ScoringOption> scoringAvailable = const <ScoringOption>[]}): _sides = sides,_scoring = scoring,_scoringAvailable = scoringAvailable,super._();
  factory _TrainingTeams.fromJson(Map<String, dynamic> json) => _$TrainingTeamsFromJson(json);

@override final  TrainingTeamsEvent event;
/// De mogelijke ploegcodes, in volgorde.
 final  List<String> _sides;
/// De mogelijke ploegcodes, in volgorde.
@override@JsonKey() List<String> get sides {
  if (_sides is EqualUnmodifiableListView) return _sides;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sides);
}

@override@JsonKey() final  int maxTeams;
@override@JsonKey() final  TrainingTeamsBoard teams;
 final  List<ScoringRow> _scoring;
@override@JsonKey() List<ScoringRow> get scoring {
  if (_scoring is EqualUnmodifiableListView) return _scoring;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scoring);
}

 final  List<ScoringOption> _scoringAvailable;
@override@JsonKey() List<ScoringOption> get scoringAvailable {
  if (_scoringAvailable is EqualUnmodifiableListView) return _scoringAvailable;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scoringAvailable);
}


/// Create a copy of TrainingTeams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingTeamsCopyWith<_TrainingTeams> get copyWith => __$TrainingTeamsCopyWithImpl<_TrainingTeams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingTeamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingTeams&&(identical(other.event, event) || other.event == event)&&const DeepCollectionEquality().equals(other._sides, _sides)&&(identical(other.maxTeams, maxTeams) || other.maxTeams == maxTeams)&&(identical(other.teams, teams) || other.teams == teams)&&const DeepCollectionEquality().equals(other._scoring, _scoring)&&const DeepCollectionEquality().equals(other._scoringAvailable, _scoringAvailable));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,event,const DeepCollectionEquality().hash(_sides),maxTeams,teams,const DeepCollectionEquality().hash(_scoring),const DeepCollectionEquality().hash(_scoringAvailable));

@override
String toString() {
  return 'TrainingTeams(event: $event, sides: $sides, maxTeams: $maxTeams, teams: $teams, scoring: $scoring, scoringAvailable: $scoringAvailable)';
}


}

/// @nodoc
abstract mixin class _$TrainingTeamsCopyWith<$Res> implements $TrainingTeamsCopyWith<$Res> {
  factory _$TrainingTeamsCopyWith(_TrainingTeams value, $Res Function(_TrainingTeams) _then) = __$TrainingTeamsCopyWithImpl;
@override @useResult
$Res call({
 TrainingTeamsEvent event, List<String> sides, int maxTeams, TrainingTeamsBoard teams, List<ScoringRow> scoring, List<ScoringOption> scoringAvailable
});


@override $TrainingTeamsEventCopyWith<$Res> get event;@override $TrainingTeamsBoardCopyWith<$Res> get teams;

}
/// @nodoc
class __$TrainingTeamsCopyWithImpl<$Res>
    implements _$TrainingTeamsCopyWith<$Res> {
  __$TrainingTeamsCopyWithImpl(this._self, this._then);

  final _TrainingTeams _self;
  final $Res Function(_TrainingTeams) _then;

/// Create a copy of TrainingTeams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? event = null,Object? sides = null,Object? maxTeams = null,Object? teams = null,Object? scoring = null,Object? scoringAvailable = null,}) {
  return _then(_TrainingTeams(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as TrainingTeamsEvent,sides: null == sides ? _self._sides : sides // ignore: cast_nullable_to_non_nullable
as List<String>,maxTeams: null == maxTeams ? _self.maxTeams : maxTeams // ignore: cast_nullable_to_non_nullable
as int,teams: null == teams ? _self.teams : teams // ignore: cast_nullable_to_non_nullable
as TrainingTeamsBoard,scoring: null == scoring ? _self._scoring : scoring // ignore: cast_nullable_to_non_nullable
as List<ScoringRow>,scoringAvailable: null == scoringAvailable ? _self._scoringAvailable : scoringAvailable // ignore: cast_nullable_to_non_nullable
as List<ScoringOption>,
  ));
}

/// Create a copy of TrainingTeams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrainingTeamsEventCopyWith<$Res> get event {
  
  return $TrainingTeamsEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}/// Create a copy of TrainingTeams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrainingTeamsBoardCopyWith<$Res> get teams {
  
  return $TrainingTeamsBoardCopyWith<$Res>(_self.teams, (value) {
    return _then(_self.copyWith(teams: value));
  });
}
}

// dart format on
