// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReportEvent {

 int get id; String get title; String? get startsAt; String? get homeTeam; String? get awayTeam;/// Spelen wij thuis? Bepaalt of thuis/uit van een scoutrapport om moeten.
 bool get weAreHome;
/// Create a copy of ReportEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportEventCopyWith<ReportEvent> get copyWith => _$ReportEventCopyWithImpl<ReportEvent>(this as ReportEvent, _$identity);

  /// Serializes this ReportEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.weAreHome, weAreHome) || other.weAreHome == weAreHome));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt,homeTeam,awayTeam,weAreHome);

@override
String toString() {
  return 'ReportEvent(id: $id, title: $title, startsAt: $startsAt, homeTeam: $homeTeam, awayTeam: $awayTeam, weAreHome: $weAreHome)';
}


}

/// @nodoc
abstract mixin class $ReportEventCopyWith<$Res>  {
  factory $ReportEventCopyWith(ReportEvent value, $Res Function(ReportEvent) _then) = _$ReportEventCopyWithImpl;
@useResult
$Res call({
 int id, String title, String? startsAt, String? homeTeam, String? awayTeam, bool weAreHome
});




}
/// @nodoc
class _$ReportEventCopyWithImpl<$Res>
    implements $ReportEventCopyWith<$Res> {
  _$ReportEventCopyWithImpl(this._self, this._then);

  final ReportEvent _self;
  final $Res Function(ReportEvent) _then;

/// Create a copy of ReportEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,Object? homeTeam = freezed,Object? awayTeam = freezed,Object? weAreHome = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String?,homeTeam: freezed == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String?,awayTeam: freezed == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String?,weAreHome: null == weAreHome ? _self.weAreHome : weAreHome // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportEvent].
extension ReportEventPatterns on ReportEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportEvent value)  $default,){
final _that = this;
switch (_that) {
case _ReportEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportEvent value)?  $default,){
final _that = this;
switch (_that) {
case _ReportEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String? startsAt,  String? homeTeam,  String? awayTeam,  bool weAreHome)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportEvent() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.homeTeam,_that.awayTeam,_that.weAreHome);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String? startsAt,  String? homeTeam,  String? awayTeam,  bool weAreHome)  $default,) {final _that = this;
switch (_that) {
case _ReportEvent():
return $default(_that.id,_that.title,_that.startsAt,_that.homeTeam,_that.awayTeam,_that.weAreHome);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String? startsAt,  String? homeTeam,  String? awayTeam,  bool weAreHome)?  $default,) {final _that = this;
switch (_that) {
case _ReportEvent() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.homeTeam,_that.awayTeam,_that.weAreHome);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportEvent implements ReportEvent {
  const _ReportEvent({required this.id, this.title = '', this.startsAt, this.homeTeam, this.awayTeam, this.weAreHome = true});
  factory _ReportEvent.fromJson(Map<String, dynamic> json) => _$ReportEventFromJson(json);

@override final  int id;
@override@JsonKey() final  String title;
@override final  String? startsAt;
@override final  String? homeTeam;
@override final  String? awayTeam;
/// Spelen wij thuis? Bepaalt of thuis/uit van een scoutrapport om moeten.
@override@JsonKey() final  bool weAreHome;

/// Create a copy of ReportEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportEventCopyWith<_ReportEvent> get copyWith => __$ReportEventCopyWithImpl<_ReportEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.weAreHome, weAreHome) || other.weAreHome == weAreHome));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt,homeTeam,awayTeam,weAreHome);

@override
String toString() {
  return 'ReportEvent(id: $id, title: $title, startsAt: $startsAt, homeTeam: $homeTeam, awayTeam: $awayTeam, weAreHome: $weAreHome)';
}


}

/// @nodoc
abstract mixin class _$ReportEventCopyWith<$Res> implements $ReportEventCopyWith<$Res> {
  factory _$ReportEventCopyWith(_ReportEvent value, $Res Function(_ReportEvent) _then) = __$ReportEventCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String? startsAt, String? homeTeam, String? awayTeam, bool weAreHome
});




}
/// @nodoc
class __$ReportEventCopyWithImpl<$Res>
    implements _$ReportEventCopyWith<$Res> {
  __$ReportEventCopyWithImpl(this._self, this._then);

  final _ReportEvent _self;
  final $Res Function(_ReportEvent) _then;

/// Create a copy of ReportEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,Object? homeTeam = freezed,Object? awayTeam = freezed,Object? weAreHome = null,}) {
  return _then(_ReportEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String?,homeTeam: freezed == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String?,awayTeam: freezed == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String?,weAreHome: null == weAreHome ? _self.weAreHome : weAreHome // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ReportPlayer {

 int get id; int? get shirtNumber; String get name; String get position; bool get isGuest;
/// Create a copy of ReportPlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportPlayerCopyWith<ReportPlayer> get copyWith => _$ReportPlayerCopyWithImpl<ReportPlayer>(this as ReportPlayer, _$identity);

  /// Serializes this ReportPlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shirtNumber,name,position,isGuest);

@override
String toString() {
  return 'ReportPlayer(id: $id, shirtNumber: $shirtNumber, name: $name, position: $position, isGuest: $isGuest)';
}


}

/// @nodoc
abstract mixin class $ReportPlayerCopyWith<$Res>  {
  factory $ReportPlayerCopyWith(ReportPlayer value, $Res Function(ReportPlayer) _then) = _$ReportPlayerCopyWithImpl;
@useResult
$Res call({
 int id, int? shirtNumber, String name, String position, bool isGuest
});




}
/// @nodoc
class _$ReportPlayerCopyWithImpl<$Res>
    implements $ReportPlayerCopyWith<$Res> {
  _$ReportPlayerCopyWithImpl(this._self, this._then);

  final ReportPlayer _self;
  final $Res Function(ReportPlayer) _then;

/// Create a copy of ReportPlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shirtNumber = freezed,Object? name = null,Object? position = null,Object? isGuest = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportPlayer].
extension ReportPlayerPatterns on ReportPlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportPlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportPlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportPlayer value)  $default,){
final _that = this;
switch (_that) {
case _ReportPlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportPlayer value)?  $default,){
final _that = this;
switch (_that) {
case _ReportPlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? shirtNumber,  String name,  String position,  bool isGuest)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportPlayer() when $default != null:
return $default(_that.id,_that.shirtNumber,_that.name,_that.position,_that.isGuest);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? shirtNumber,  String name,  String position,  bool isGuest)  $default,) {final _that = this;
switch (_that) {
case _ReportPlayer():
return $default(_that.id,_that.shirtNumber,_that.name,_that.position,_that.isGuest);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? shirtNumber,  String name,  String position,  bool isGuest)?  $default,) {final _that = this;
switch (_that) {
case _ReportPlayer() when $default != null:
return $default(_that.id,_that.shirtNumber,_that.name,_that.position,_that.isGuest);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportPlayer implements ReportPlayer {
  const _ReportPlayer({required this.id, this.shirtNumber, this.name = '', this.position = '', this.isGuest = false});
  factory _ReportPlayer.fromJson(Map<String, dynamic> json) => _$ReportPlayerFromJson(json);

@override final  int id;
@override final  int? shirtNumber;
@override@JsonKey() final  String name;
@override@JsonKey() final  String position;
@override@JsonKey() final  bool isGuest;

/// Create a copy of ReportPlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportPlayerCopyWith<_ReportPlayer> get copyWith => __$ReportPlayerCopyWithImpl<_ReportPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shirtNumber,name,position,isGuest);

@override
String toString() {
  return 'ReportPlayer(id: $id, shirtNumber: $shirtNumber, name: $name, position: $position, isGuest: $isGuest)';
}


}

/// @nodoc
abstract mixin class _$ReportPlayerCopyWith<$Res> implements $ReportPlayerCopyWith<$Res> {
  factory _$ReportPlayerCopyWith(_ReportPlayer value, $Res Function(_ReportPlayer) _then) = __$ReportPlayerCopyWithImpl;
@override @useResult
$Res call({
 int id, int? shirtNumber, String name, String position, bool isGuest
});




}
/// @nodoc
class __$ReportPlayerCopyWithImpl<$Res>
    implements _$ReportPlayerCopyWith<$Res> {
  __$ReportPlayerCopyWithImpl(this._self, this._then);

  final _ReportPlayer _self;
  final $Res Function(_ReportPlayer) _then;

/// Create a copy of ReportPlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shirtNumber = freezed,Object? name = null,Object? position = null,Object? isGuest = null,}) {
  return _then(_ReportPlayer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ReportLineupRow {

 String get slotCode; ReportPlayer get player;
/// Create a copy of ReportLineupRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportLineupRowCopyWith<ReportLineupRow> get copyWith => _$ReportLineupRowCopyWithImpl<ReportLineupRow>(this as ReportLineupRow, _$identity);

  /// Serializes this ReportLineupRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportLineupRow&&(identical(other.slotCode, slotCode) || other.slotCode == slotCode)&&(identical(other.player, player) || other.player == player));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotCode,player);

@override
String toString() {
  return 'ReportLineupRow(slotCode: $slotCode, player: $player)';
}


}

/// @nodoc
abstract mixin class $ReportLineupRowCopyWith<$Res>  {
  factory $ReportLineupRowCopyWith(ReportLineupRow value, $Res Function(ReportLineupRow) _then) = _$ReportLineupRowCopyWithImpl;
@useResult
$Res call({
 String slotCode, ReportPlayer player
});


$ReportPlayerCopyWith<$Res> get player;

}
/// @nodoc
class _$ReportLineupRowCopyWithImpl<$Res>
    implements $ReportLineupRowCopyWith<$Res> {
  _$ReportLineupRowCopyWithImpl(this._self, this._then);

  final ReportLineupRow _self;
  final $Res Function(ReportLineupRow) _then;

/// Create a copy of ReportLineupRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slotCode = null,Object? player = null,}) {
  return _then(_self.copyWith(
slotCode: null == slotCode ? _self.slotCode : slotCode // ignore: cast_nullable_to_non_nullable
as String,player: null == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as ReportPlayer,
  ));
}
/// Create a copy of ReportLineupRow
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportPlayerCopyWith<$Res> get player {
  
  return $ReportPlayerCopyWith<$Res>(_self.player, (value) {
    return _then(_self.copyWith(player: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReportLineupRow].
extension ReportLineupRowPatterns on ReportLineupRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportLineupRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportLineupRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportLineupRow value)  $default,){
final _that = this;
switch (_that) {
case _ReportLineupRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportLineupRow value)?  $default,){
final _that = this;
switch (_that) {
case _ReportLineupRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slotCode,  ReportPlayer player)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportLineupRow() when $default != null:
return $default(_that.slotCode,_that.player);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slotCode,  ReportPlayer player)  $default,) {final _that = this;
switch (_that) {
case _ReportLineupRow():
return $default(_that.slotCode,_that.player);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slotCode,  ReportPlayer player)?  $default,) {final _that = this;
switch (_that) {
case _ReportLineupRow() when $default != null:
return $default(_that.slotCode,_that.player);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportLineupRow implements ReportLineupRow {
  const _ReportLineupRow({this.slotCode = '', required this.player});
  factory _ReportLineupRow.fromJson(Map<String, dynamic> json) => _$ReportLineupRowFromJson(json);

@override@JsonKey() final  String slotCode;
@override final  ReportPlayer player;

/// Create a copy of ReportLineupRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportLineupRowCopyWith<_ReportLineupRow> get copyWith => __$ReportLineupRowCopyWithImpl<_ReportLineupRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportLineupRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportLineupRow&&(identical(other.slotCode, slotCode) || other.slotCode == slotCode)&&(identical(other.player, player) || other.player == player));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slotCode,player);

@override
String toString() {
  return 'ReportLineupRow(slotCode: $slotCode, player: $player)';
}


}

/// @nodoc
abstract mixin class _$ReportLineupRowCopyWith<$Res> implements $ReportLineupRowCopyWith<$Res> {
  factory _$ReportLineupRowCopyWith(_ReportLineupRow value, $Res Function(_ReportLineupRow) _then) = __$ReportLineupRowCopyWithImpl;
@override @useResult
$Res call({
 String slotCode, ReportPlayer player
});


@override $ReportPlayerCopyWith<$Res> get player;

}
/// @nodoc
class __$ReportLineupRowCopyWithImpl<$Res>
    implements _$ReportLineupRowCopyWith<$Res> {
  __$ReportLineupRowCopyWithImpl(this._self, this._then);

  final _ReportLineupRow _self;
  final $Res Function(_ReportLineupRow) _then;

/// Create a copy of ReportLineupRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slotCode = null,Object? player = null,}) {
  return _then(_ReportLineupRow(
slotCode: null == slotCode ? _self.slotCode : slotCode // ignore: cast_nullable_to_non_nullable
as String,player: null == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as ReportPlayer,
  ));
}

/// Create a copy of ReportLineupRow
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportPlayerCopyWith<$Res> get player {
  
  return $ReportPlayerCopyWith<$Res>(_self.player, (value) {
    return _then(_self.copyWith(player: value));
  });
}
}


/// @nodoc
mixin _$ReportSet {

 int get setNumber; int get homePoints; int get awayPoints;
/// Create a copy of ReportSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportSetCopyWith<ReportSet> get copyWith => _$ReportSetCopyWithImpl<ReportSet>(this as ReportSet, _$identity);

  /// Serializes this ReportSet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportSet&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.homePoints, homePoints) || other.homePoints == homePoints)&&(identical(other.awayPoints, awayPoints) || other.awayPoints == awayPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,setNumber,homePoints,awayPoints);

@override
String toString() {
  return 'ReportSet(setNumber: $setNumber, homePoints: $homePoints, awayPoints: $awayPoints)';
}


}

/// @nodoc
abstract mixin class $ReportSetCopyWith<$Res>  {
  factory $ReportSetCopyWith(ReportSet value, $Res Function(ReportSet) _then) = _$ReportSetCopyWithImpl;
@useResult
$Res call({
 int setNumber, int homePoints, int awayPoints
});




}
/// @nodoc
class _$ReportSetCopyWithImpl<$Res>
    implements $ReportSetCopyWith<$Res> {
  _$ReportSetCopyWithImpl(this._self, this._then);

  final ReportSet _self;
  final $Res Function(ReportSet) _then;

/// Create a copy of ReportSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? setNumber = null,Object? homePoints = null,Object? awayPoints = null,}) {
  return _then(_self.copyWith(
setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,homePoints: null == homePoints ? _self.homePoints : homePoints // ignore: cast_nullable_to_non_nullable
as int,awayPoints: null == awayPoints ? _self.awayPoints : awayPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportSet].
extension ReportSetPatterns on ReportSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportSet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportSet value)  $default,){
final _that = this;
switch (_that) {
case _ReportSet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportSet value)?  $default,){
final _that = this;
switch (_that) {
case _ReportSet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int setNumber,  int homePoints,  int awayPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportSet() when $default != null:
return $default(_that.setNumber,_that.homePoints,_that.awayPoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int setNumber,  int homePoints,  int awayPoints)  $default,) {final _that = this;
switch (_that) {
case _ReportSet():
return $default(_that.setNumber,_that.homePoints,_that.awayPoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int setNumber,  int homePoints,  int awayPoints)?  $default,) {final _that = this;
switch (_that) {
case _ReportSet() when $default != null:
return $default(_that.setNumber,_that.homePoints,_that.awayPoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReportSet implements ReportSet {
  const _ReportSet({this.setNumber = 0, this.homePoints = 0, this.awayPoints = 0});
  factory _ReportSet.fromJson(Map<String, dynamic> json) => _$ReportSetFromJson(json);

@override@JsonKey() final  int setNumber;
@override@JsonKey() final  int homePoints;
@override@JsonKey() final  int awayPoints;

/// Create a copy of ReportSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportSetCopyWith<_ReportSet> get copyWith => __$ReportSetCopyWithImpl<_ReportSet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReportSetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportSet&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.homePoints, homePoints) || other.homePoints == homePoints)&&(identical(other.awayPoints, awayPoints) || other.awayPoints == awayPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,setNumber,homePoints,awayPoints);

@override
String toString() {
  return 'ReportSet(setNumber: $setNumber, homePoints: $homePoints, awayPoints: $awayPoints)';
}


}

/// @nodoc
abstract mixin class _$ReportSetCopyWith<$Res> implements $ReportSetCopyWith<$Res> {
  factory _$ReportSetCopyWith(_ReportSet value, $Res Function(_ReportSet) _then) = __$ReportSetCopyWithImpl;
@override @useResult
$Res call({
 int setNumber, int homePoints, int awayPoints
});




}
/// @nodoc
class __$ReportSetCopyWithImpl<$Res>
    implements _$ReportSetCopyWith<$Res> {
  __$ReportSetCopyWithImpl(this._self, this._then);

  final _ReportSet _self;
  final $Res Function(_ReportSet) _then;

/// Create a copy of ReportSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? setNumber = null,Object? homePoints = null,Object? awayPoints = null,}) {
  return _then(_ReportSet(
setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,homePoints: null == homePoints ? _self.homePoints : homePoints // ignore: cast_nullable_to_non_nullable
as int,awayPoints: null == awayPoints ? _self.awayPoints : awayPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MatchReport {

 ReportEvent get event;/// `goals` (stand via `report/score`) of `sets` (via `report/sets`).
 String get scoreModel; int? get homeScore; int? get awayScore; int? get maxSets; List<ReportSet> get sets;/// `postmatch` = statistiekenblad na afloop; anders geen blad.
 String get statsMode; List<String> get statColumns; bool get canImport; List<ReportLineupRow> get lineup; List<ReportPlayer> get bench;/// Ruwe regels: `player_id` plus één sleutel per kolom.
 List<Map<String, dynamic>> get playerStats;
/// Create a copy of MatchReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchReportCopyWith<MatchReport> get copyWith => _$MatchReportCopyWithImpl<MatchReport>(this as MatchReport, _$identity);

  /// Serializes this MatchReport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchReport&&(identical(other.event, event) || other.event == event)&&(identical(other.scoreModel, scoreModel) || other.scoreModel == scoreModel)&&(identical(other.homeScore, homeScore) || other.homeScore == homeScore)&&(identical(other.awayScore, awayScore) || other.awayScore == awayScore)&&(identical(other.maxSets, maxSets) || other.maxSets == maxSets)&&const DeepCollectionEquality().equals(other.sets, sets)&&(identical(other.statsMode, statsMode) || other.statsMode == statsMode)&&const DeepCollectionEquality().equals(other.statColumns, statColumns)&&(identical(other.canImport, canImport) || other.canImport == canImport)&&const DeepCollectionEquality().equals(other.lineup, lineup)&&const DeepCollectionEquality().equals(other.bench, bench)&&const DeepCollectionEquality().equals(other.playerStats, playerStats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,event,scoreModel,homeScore,awayScore,maxSets,const DeepCollectionEquality().hash(sets),statsMode,const DeepCollectionEquality().hash(statColumns),canImport,const DeepCollectionEquality().hash(lineup),const DeepCollectionEquality().hash(bench),const DeepCollectionEquality().hash(playerStats));

@override
String toString() {
  return 'MatchReport(event: $event, scoreModel: $scoreModel, homeScore: $homeScore, awayScore: $awayScore, maxSets: $maxSets, sets: $sets, statsMode: $statsMode, statColumns: $statColumns, canImport: $canImport, lineup: $lineup, bench: $bench, playerStats: $playerStats)';
}


}

/// @nodoc
abstract mixin class $MatchReportCopyWith<$Res>  {
  factory $MatchReportCopyWith(MatchReport value, $Res Function(MatchReport) _then) = _$MatchReportCopyWithImpl;
@useResult
$Res call({
 ReportEvent event, String scoreModel, int? homeScore, int? awayScore, int? maxSets, List<ReportSet> sets, String statsMode, List<String> statColumns, bool canImport, List<ReportLineupRow> lineup, List<ReportPlayer> bench, List<Map<String, dynamic>> playerStats
});


$ReportEventCopyWith<$Res> get event;

}
/// @nodoc
class _$MatchReportCopyWithImpl<$Res>
    implements $MatchReportCopyWith<$Res> {
  _$MatchReportCopyWithImpl(this._self, this._then);

  final MatchReport _self;
  final $Res Function(MatchReport) _then;

/// Create a copy of MatchReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? event = null,Object? scoreModel = null,Object? homeScore = freezed,Object? awayScore = freezed,Object? maxSets = freezed,Object? sets = null,Object? statsMode = null,Object? statColumns = null,Object? canImport = null,Object? lineup = null,Object? bench = null,Object? playerStats = null,}) {
  return _then(_self.copyWith(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as ReportEvent,scoreModel: null == scoreModel ? _self.scoreModel : scoreModel // ignore: cast_nullable_to_non_nullable
as String,homeScore: freezed == homeScore ? _self.homeScore : homeScore // ignore: cast_nullable_to_non_nullable
as int?,awayScore: freezed == awayScore ? _self.awayScore : awayScore // ignore: cast_nullable_to_non_nullable
as int?,maxSets: freezed == maxSets ? _self.maxSets : maxSets // ignore: cast_nullable_to_non_nullable
as int?,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<ReportSet>,statsMode: null == statsMode ? _self.statsMode : statsMode // ignore: cast_nullable_to_non_nullable
as String,statColumns: null == statColumns ? _self.statColumns : statColumns // ignore: cast_nullable_to_non_nullable
as List<String>,canImport: null == canImport ? _self.canImport : canImport // ignore: cast_nullable_to_non_nullable
as bool,lineup: null == lineup ? _self.lineup : lineup // ignore: cast_nullable_to_non_nullable
as List<ReportLineupRow>,bench: null == bench ? _self.bench : bench // ignore: cast_nullable_to_non_nullable
as List<ReportPlayer>,playerStats: null == playerStats ? _self.playerStats : playerStats // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}
/// Create a copy of MatchReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportEventCopyWith<$Res> get event {
  
  return $ReportEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// Adds pattern-matching-related methods to [MatchReport].
extension MatchReportPatterns on MatchReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchReport value)  $default,){
final _that = this;
switch (_that) {
case _MatchReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchReport value)?  $default,){
final _that = this;
switch (_that) {
case _MatchReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReportEvent event,  String scoreModel,  int? homeScore,  int? awayScore,  int? maxSets,  List<ReportSet> sets,  String statsMode,  List<String> statColumns,  bool canImport,  List<ReportLineupRow> lineup,  List<ReportPlayer> bench,  List<Map<String, dynamic>> playerStats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchReport() when $default != null:
return $default(_that.event,_that.scoreModel,_that.homeScore,_that.awayScore,_that.maxSets,_that.sets,_that.statsMode,_that.statColumns,_that.canImport,_that.lineup,_that.bench,_that.playerStats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReportEvent event,  String scoreModel,  int? homeScore,  int? awayScore,  int? maxSets,  List<ReportSet> sets,  String statsMode,  List<String> statColumns,  bool canImport,  List<ReportLineupRow> lineup,  List<ReportPlayer> bench,  List<Map<String, dynamic>> playerStats)  $default,) {final _that = this;
switch (_that) {
case _MatchReport():
return $default(_that.event,_that.scoreModel,_that.homeScore,_that.awayScore,_that.maxSets,_that.sets,_that.statsMode,_that.statColumns,_that.canImport,_that.lineup,_that.bench,_that.playerStats);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReportEvent event,  String scoreModel,  int? homeScore,  int? awayScore,  int? maxSets,  List<ReportSet> sets,  String statsMode,  List<String> statColumns,  bool canImport,  List<ReportLineupRow> lineup,  List<ReportPlayer> bench,  List<Map<String, dynamic>> playerStats)?  $default,) {final _that = this;
switch (_that) {
case _MatchReport() when $default != null:
return $default(_that.event,_that.scoreModel,_that.homeScore,_that.awayScore,_that.maxSets,_that.sets,_that.statsMode,_that.statColumns,_that.canImport,_that.lineup,_that.bench,_that.playerStats);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchReport extends MatchReport {
  const _MatchReport({required this.event, this.scoreModel = 'goals', this.homeScore, this.awayScore, this.maxSets, final  List<ReportSet> sets = const <ReportSet>[], this.statsMode = '', final  List<String> statColumns = const <String>[], this.canImport = false, final  List<ReportLineupRow> lineup = const <ReportLineupRow>[], final  List<ReportPlayer> bench = const <ReportPlayer>[], final  List<Map<String, dynamic>> playerStats = const <Map<String, dynamic>>[]}): _sets = sets,_statColumns = statColumns,_lineup = lineup,_bench = bench,_playerStats = playerStats,super._();
  factory _MatchReport.fromJson(Map<String, dynamic> json) => _$MatchReportFromJson(json);

@override final  ReportEvent event;
/// `goals` (stand via `report/score`) of `sets` (via `report/sets`).
@override@JsonKey() final  String scoreModel;
@override final  int? homeScore;
@override final  int? awayScore;
@override final  int? maxSets;
 final  List<ReportSet> _sets;
@override@JsonKey() List<ReportSet> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}

/// `postmatch` = statistiekenblad na afloop; anders geen blad.
@override@JsonKey() final  String statsMode;
 final  List<String> _statColumns;
@override@JsonKey() List<String> get statColumns {
  if (_statColumns is EqualUnmodifiableListView) return _statColumns;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_statColumns);
}

@override@JsonKey() final  bool canImport;
 final  List<ReportLineupRow> _lineup;
@override@JsonKey() List<ReportLineupRow> get lineup {
  if (_lineup is EqualUnmodifiableListView) return _lineup;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lineup);
}

 final  List<ReportPlayer> _bench;
@override@JsonKey() List<ReportPlayer> get bench {
  if (_bench is EqualUnmodifiableListView) return _bench;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bench);
}

/// Ruwe regels: `player_id` plus één sleutel per kolom.
 final  List<Map<String, dynamic>> _playerStats;
/// Ruwe regels: `player_id` plus één sleutel per kolom.
@override@JsonKey() List<Map<String, dynamic>> get playerStats {
  if (_playerStats is EqualUnmodifiableListView) return _playerStats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_playerStats);
}


/// Create a copy of MatchReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchReportCopyWith<_MatchReport> get copyWith => __$MatchReportCopyWithImpl<_MatchReport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchReportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchReport&&(identical(other.event, event) || other.event == event)&&(identical(other.scoreModel, scoreModel) || other.scoreModel == scoreModel)&&(identical(other.homeScore, homeScore) || other.homeScore == homeScore)&&(identical(other.awayScore, awayScore) || other.awayScore == awayScore)&&(identical(other.maxSets, maxSets) || other.maxSets == maxSets)&&const DeepCollectionEquality().equals(other._sets, _sets)&&(identical(other.statsMode, statsMode) || other.statsMode == statsMode)&&const DeepCollectionEquality().equals(other._statColumns, _statColumns)&&(identical(other.canImport, canImport) || other.canImport == canImport)&&const DeepCollectionEquality().equals(other._lineup, _lineup)&&const DeepCollectionEquality().equals(other._bench, _bench)&&const DeepCollectionEquality().equals(other._playerStats, _playerStats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,event,scoreModel,homeScore,awayScore,maxSets,const DeepCollectionEquality().hash(_sets),statsMode,const DeepCollectionEquality().hash(_statColumns),canImport,const DeepCollectionEquality().hash(_lineup),const DeepCollectionEquality().hash(_bench),const DeepCollectionEquality().hash(_playerStats));

@override
String toString() {
  return 'MatchReport(event: $event, scoreModel: $scoreModel, homeScore: $homeScore, awayScore: $awayScore, maxSets: $maxSets, sets: $sets, statsMode: $statsMode, statColumns: $statColumns, canImport: $canImport, lineup: $lineup, bench: $bench, playerStats: $playerStats)';
}


}

/// @nodoc
abstract mixin class _$MatchReportCopyWith<$Res> implements $MatchReportCopyWith<$Res> {
  factory _$MatchReportCopyWith(_MatchReport value, $Res Function(_MatchReport) _then) = __$MatchReportCopyWithImpl;
@override @useResult
$Res call({
 ReportEvent event, String scoreModel, int? homeScore, int? awayScore, int? maxSets, List<ReportSet> sets, String statsMode, List<String> statColumns, bool canImport, List<ReportLineupRow> lineup, List<ReportPlayer> bench, List<Map<String, dynamic>> playerStats
});


@override $ReportEventCopyWith<$Res> get event;

}
/// @nodoc
class __$MatchReportCopyWithImpl<$Res>
    implements _$MatchReportCopyWith<$Res> {
  __$MatchReportCopyWithImpl(this._self, this._then);

  final _MatchReport _self;
  final $Res Function(_MatchReport) _then;

/// Create a copy of MatchReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? event = null,Object? scoreModel = null,Object? homeScore = freezed,Object? awayScore = freezed,Object? maxSets = freezed,Object? sets = null,Object? statsMode = null,Object? statColumns = null,Object? canImport = null,Object? lineup = null,Object? bench = null,Object? playerStats = null,}) {
  return _then(_MatchReport(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as ReportEvent,scoreModel: null == scoreModel ? _self.scoreModel : scoreModel // ignore: cast_nullable_to_non_nullable
as String,homeScore: freezed == homeScore ? _self.homeScore : homeScore // ignore: cast_nullable_to_non_nullable
as int?,awayScore: freezed == awayScore ? _self.awayScore : awayScore // ignore: cast_nullable_to_non_nullable
as int?,maxSets: freezed == maxSets ? _self.maxSets : maxSets // ignore: cast_nullable_to_non_nullable
as int?,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<ReportSet>,statsMode: null == statsMode ? _self.statsMode : statsMode // ignore: cast_nullable_to_non_nullable
as String,statColumns: null == statColumns ? _self._statColumns : statColumns // ignore: cast_nullable_to_non_nullable
as List<String>,canImport: null == canImport ? _self.canImport : canImport // ignore: cast_nullable_to_non_nullable
as bool,lineup: null == lineup ? _self._lineup : lineup // ignore: cast_nullable_to_non_nullable
as List<ReportLineupRow>,bench: null == bench ? _self._bench : bench // ignore: cast_nullable_to_non_nullable
as List<ReportPlayer>,playerStats: null == playerStats ? _self._playerStats : playerStats // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,
  ));
}

/// Create a copy of MatchReport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReportEventCopyWith<$Res> get event {
  
  return $ReportEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// @nodoc
mixin _$ScoutSet {

 int get home; int get away;
/// Create a copy of ScoutSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoutSetCopyWith<ScoutSet> get copyWith => _$ScoutSetCopyWithImpl<ScoutSet>(this as ScoutSet, _$identity);

  /// Serializes this ScoutSet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoutSet&&(identical(other.home, home) || other.home == home)&&(identical(other.away, away) || other.away == away));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,home,away);

@override
String toString() {
  return 'ScoutSet(home: $home, away: $away)';
}


}

/// @nodoc
abstract mixin class $ScoutSetCopyWith<$Res>  {
  factory $ScoutSetCopyWith(ScoutSet value, $Res Function(ScoutSet) _then) = _$ScoutSetCopyWithImpl;
@useResult
$Res call({
 int home, int away
});




}
/// @nodoc
class _$ScoutSetCopyWithImpl<$Res>
    implements $ScoutSetCopyWith<$Res> {
  _$ScoutSetCopyWithImpl(this._self, this._then);

  final ScoutSet _self;
  final $Res Function(ScoutSet) _then;

/// Create a copy of ScoutSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? home = null,Object? away = null,}) {
  return _then(_self.copyWith(
home: null == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as int,away: null == away ? _self.away : away // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoutSet].
extension ScoutSetPatterns on ScoutSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoutSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoutSet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoutSet value)  $default,){
final _that = this;
switch (_that) {
case _ScoutSet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoutSet value)?  $default,){
final _that = this;
switch (_that) {
case _ScoutSet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int home,  int away)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoutSet() when $default != null:
return $default(_that.home,_that.away);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int home,  int away)  $default,) {final _that = this;
switch (_that) {
case _ScoutSet():
return $default(_that.home,_that.away);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int home,  int away)?  $default,) {final _that = this;
switch (_that) {
case _ScoutSet() when $default != null:
return $default(_that.home,_that.away);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoutSet implements ScoutSet {
  const _ScoutSet({this.home = 0, this.away = 0});
  factory _ScoutSet.fromJson(Map<String, dynamic> json) => _$ScoutSetFromJson(json);

@override@JsonKey() final  int home;
@override@JsonKey() final  int away;

/// Create a copy of ScoutSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoutSetCopyWith<_ScoutSet> get copyWith => __$ScoutSetCopyWithImpl<_ScoutSet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoutSetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoutSet&&(identical(other.home, home) || other.home == home)&&(identical(other.away, away) || other.away == away));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,home,away);

@override
String toString() {
  return 'ScoutSet(home: $home, away: $away)';
}


}

/// @nodoc
abstract mixin class _$ScoutSetCopyWith<$Res> implements $ScoutSetCopyWith<$Res> {
  factory _$ScoutSetCopyWith(_ScoutSet value, $Res Function(_ScoutSet) _then) = __$ScoutSetCopyWithImpl;
@override @useResult
$Res call({
 int home, int away
});




}
/// @nodoc
class __$ScoutSetCopyWithImpl<$Res>
    implements _$ScoutSetCopyWith<$Res> {
  __$ScoutSetCopyWithImpl(this._self, this._then);

  final _ScoutSet _self;
  final $Res Function(_ScoutSet) _then;

/// Create a copy of ScoutSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? home = null,Object? away = null,}) {
  return _then(_ScoutSet(
home: null == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as int,away: null == away ? _self.away : away // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ScoutRow {

 int? get shirtNumber; String get name; Map<String, dynamic> get stats;/// De gekoppelde speler, of `null`.
 int? get playerId;/// `shirt_number`, `name` of `null`.
 String? get matchedOn;
/// Create a copy of ScoutRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoutRowCopyWith<ScoutRow> get copyWith => _$ScoutRowCopyWithImpl<ScoutRow>(this as ScoutRow, _$identity);

  /// Serializes this ScoutRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoutRow&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.stats, stats)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.matchedOn, matchedOn) || other.matchedOn == matchedOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shirtNumber,name,const DeepCollectionEquality().hash(stats),playerId,matchedOn);

@override
String toString() {
  return 'ScoutRow(shirtNumber: $shirtNumber, name: $name, stats: $stats, playerId: $playerId, matchedOn: $matchedOn)';
}


}

/// @nodoc
abstract mixin class $ScoutRowCopyWith<$Res>  {
  factory $ScoutRowCopyWith(ScoutRow value, $Res Function(ScoutRow) _then) = _$ScoutRowCopyWithImpl;
@useResult
$Res call({
 int? shirtNumber, String name, Map<String, dynamic> stats, int? playerId, String? matchedOn
});




}
/// @nodoc
class _$ScoutRowCopyWithImpl<$Res>
    implements $ScoutRowCopyWith<$Res> {
  _$ScoutRowCopyWithImpl(this._self, this._then);

  final ScoutRow _self;
  final $Res Function(ScoutRow) _then;

/// Create a copy of ScoutRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shirtNumber = freezed,Object? name = null,Object? stats = null,Object? playerId = freezed,Object? matchedOn = freezed,}) {
  return _then(_self.copyWith(
shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,matchedOn: freezed == matchedOn ? _self.matchedOn : matchedOn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoutRow].
extension ScoutRowPatterns on ScoutRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoutRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoutRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoutRow value)  $default,){
final _that = this;
switch (_that) {
case _ScoutRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoutRow value)?  $default,){
final _that = this;
switch (_that) {
case _ScoutRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? shirtNumber,  String name,  Map<String, dynamic> stats,  int? playerId,  String? matchedOn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoutRow() when $default != null:
return $default(_that.shirtNumber,_that.name,_that.stats,_that.playerId,_that.matchedOn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? shirtNumber,  String name,  Map<String, dynamic> stats,  int? playerId,  String? matchedOn)  $default,) {final _that = this;
switch (_that) {
case _ScoutRow():
return $default(_that.shirtNumber,_that.name,_that.stats,_that.playerId,_that.matchedOn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? shirtNumber,  String name,  Map<String, dynamic> stats,  int? playerId,  String? matchedOn)?  $default,) {final _that = this;
switch (_that) {
case _ScoutRow() when $default != null:
return $default(_that.shirtNumber,_that.name,_that.stats,_that.playerId,_that.matchedOn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoutRow extends ScoutRow {
  const _ScoutRow({this.shirtNumber, this.name = '', final  Map<String, dynamic> stats = const <String, dynamic>{}, this.playerId, this.matchedOn}): _stats = stats,super._();
  factory _ScoutRow.fromJson(Map<String, dynamic> json) => _$ScoutRowFromJson(json);

@override final  int? shirtNumber;
@override@JsonKey() final  String name;
 final  Map<String, dynamic> _stats;
@override@JsonKey() Map<String, dynamic> get stats {
  if (_stats is EqualUnmodifiableMapView) return _stats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_stats);
}

/// De gekoppelde speler, of `null`.
@override final  int? playerId;
/// `shirt_number`, `name` of `null`.
@override final  String? matchedOn;

/// Create a copy of ScoutRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoutRowCopyWith<_ScoutRow> get copyWith => __$ScoutRowCopyWithImpl<_ScoutRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoutRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoutRow&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._stats, _stats)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.matchedOn, matchedOn) || other.matchedOn == matchedOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,shirtNumber,name,const DeepCollectionEquality().hash(_stats),playerId,matchedOn);

@override
String toString() {
  return 'ScoutRow(shirtNumber: $shirtNumber, name: $name, stats: $stats, playerId: $playerId, matchedOn: $matchedOn)';
}


}

/// @nodoc
abstract mixin class _$ScoutRowCopyWith<$Res> implements $ScoutRowCopyWith<$Res> {
  factory _$ScoutRowCopyWith(_ScoutRow value, $Res Function(_ScoutRow) _then) = __$ScoutRowCopyWithImpl;
@override @useResult
$Res call({
 int? shirtNumber, String name, Map<String, dynamic> stats, int? playerId, String? matchedOn
});




}
/// @nodoc
class __$ScoutRowCopyWithImpl<$Res>
    implements _$ScoutRowCopyWith<$Res> {
  __$ScoutRowCopyWithImpl(this._self, this._then);

  final _ScoutRow _self;
  final $Res Function(_ScoutRow) _then;

/// Create a copy of ScoutRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shirtNumber = freezed,Object? name = null,Object? stats = null,Object? playerId = freezed,Object? matchedOn = freezed,}) {
  return _then(_ScoutRow(
shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,stats: null == stats ? _self._stats : stats // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,matchedOn: freezed == matchedOn ? _self.matchedOn : matchedOn // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ScoutTeam {

 String get name; List<ScoutRow> get players;
/// Create a copy of ScoutTeam
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoutTeamCopyWith<ScoutTeam> get copyWith => _$ScoutTeamCopyWithImpl<ScoutTeam>(this as ScoutTeam, _$identity);

  /// Serializes this ScoutTeam to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoutTeam&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.players, players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(players));

@override
String toString() {
  return 'ScoutTeam(name: $name, players: $players)';
}


}

/// @nodoc
abstract mixin class $ScoutTeamCopyWith<$Res>  {
  factory $ScoutTeamCopyWith(ScoutTeam value, $Res Function(ScoutTeam) _then) = _$ScoutTeamCopyWithImpl;
@useResult
$Res call({
 String name, List<ScoutRow> players
});




}
/// @nodoc
class _$ScoutTeamCopyWithImpl<$Res>
    implements $ScoutTeamCopyWith<$Res> {
  _$ScoutTeamCopyWithImpl(this._self, this._then);

  final ScoutTeam _self;
  final $Res Function(ScoutTeam) _then;

/// Create a copy of ScoutTeam
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? players = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<ScoutRow>,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoutTeam].
extension ScoutTeamPatterns on ScoutTeam {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoutTeam value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoutTeam() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoutTeam value)  $default,){
final _that = this;
switch (_that) {
case _ScoutTeam():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoutTeam value)?  $default,){
final _that = this;
switch (_that) {
case _ScoutTeam() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  List<ScoutRow> players)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoutTeam() when $default != null:
return $default(_that.name,_that.players);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  List<ScoutRow> players)  $default,) {final _that = this;
switch (_that) {
case _ScoutTeam():
return $default(_that.name,_that.players);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  List<ScoutRow> players)?  $default,) {final _that = this;
switch (_that) {
case _ScoutTeam() when $default != null:
return $default(_that.name,_that.players);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoutTeam implements ScoutTeam {
  const _ScoutTeam({this.name = '', final  List<ScoutRow> players = const <ScoutRow>[]}): _players = players;
  factory _ScoutTeam.fromJson(Map<String, dynamic> json) => _$ScoutTeamFromJson(json);

@override@JsonKey() final  String name;
 final  List<ScoutRow> _players;
@override@JsonKey() List<ScoutRow> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}


/// Create a copy of ScoutTeam
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoutTeamCopyWith<_ScoutTeam> get copyWith => __$ScoutTeamCopyWithImpl<_ScoutTeam>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoutTeamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoutTeam&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._players, _players));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_players));

@override
String toString() {
  return 'ScoutTeam(name: $name, players: $players)';
}


}

/// @nodoc
abstract mixin class _$ScoutTeamCopyWith<$Res> implements $ScoutTeamCopyWith<$Res> {
  factory _$ScoutTeamCopyWith(_ScoutTeam value, $Res Function(_ScoutTeam) _then) = __$ScoutTeamCopyWithImpl;
@override @useResult
$Res call({
 String name, List<ScoutRow> players
});




}
/// @nodoc
class __$ScoutTeamCopyWithImpl<$Res>
    implements _$ScoutTeamCopyWith<$Res> {
  __$ScoutTeamCopyWithImpl(this._self, this._then);

  final _ScoutTeam _self;
  final $Res Function(_ScoutTeam) _then;

/// Create a copy of ScoutTeam
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? players = null,}) {
  return _then(_ScoutTeam(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<ScoutRow>,
  ));
}


}


/// @nodoc
mixin _$ScoutRosterEntry {

 int get id; String get name; int? get shirtNumber;
/// Create a copy of ScoutRosterEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoutRosterEntryCopyWith<ScoutRosterEntry> get copyWith => _$ScoutRosterEntryCopyWithImpl<ScoutRosterEntry>(this as ScoutRosterEntry, _$identity);

  /// Serializes this ScoutRosterEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoutRosterEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber);

@override
String toString() {
  return 'ScoutRosterEntry(id: $id, name: $name, shirtNumber: $shirtNumber)';
}


}

/// @nodoc
abstract mixin class $ScoutRosterEntryCopyWith<$Res>  {
  factory $ScoutRosterEntryCopyWith(ScoutRosterEntry value, $Res Function(ScoutRosterEntry) _then) = _$ScoutRosterEntryCopyWithImpl;
@useResult
$Res call({
 int id, String name, int? shirtNumber
});




}
/// @nodoc
class _$ScoutRosterEntryCopyWithImpl<$Res>
    implements $ScoutRosterEntryCopyWith<$Res> {
  _$ScoutRosterEntryCopyWithImpl(this._self, this._then);

  final ScoutRosterEntry _self;
  final $Res Function(ScoutRosterEntry) _then;

/// Create a copy of ScoutRosterEntry
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


/// Adds pattern-matching-related methods to [ScoutRosterEntry].
extension ScoutRosterEntryPatterns on ScoutRosterEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoutRosterEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoutRosterEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoutRosterEntry value)  $default,){
final _that = this;
switch (_that) {
case _ScoutRosterEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoutRosterEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ScoutRosterEntry() when $default != null:
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
case _ScoutRosterEntry() when $default != null:
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
case _ScoutRosterEntry():
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
case _ScoutRosterEntry() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoutRosterEntry implements ScoutRosterEntry {
  const _ScoutRosterEntry({required this.id, this.name = '', this.shirtNumber});
  factory _ScoutRosterEntry.fromJson(Map<String, dynamic> json) => _$ScoutRosterEntryFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  int? shirtNumber;

/// Create a copy of ScoutRosterEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoutRosterEntryCopyWith<_ScoutRosterEntry> get copyWith => __$ScoutRosterEntryCopyWithImpl<_ScoutRosterEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoutRosterEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoutRosterEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber);

@override
String toString() {
  return 'ScoutRosterEntry(id: $id, name: $name, shirtNumber: $shirtNumber)';
}


}

/// @nodoc
abstract mixin class _$ScoutRosterEntryCopyWith<$Res> implements $ScoutRosterEntryCopyWith<$Res> {
  factory _$ScoutRosterEntryCopyWith(_ScoutRosterEntry value, $Res Function(_ScoutRosterEntry) _then) = __$ScoutRosterEntryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int? shirtNumber
});




}
/// @nodoc
class __$ScoutRosterEntryCopyWithImpl<$Res>
    implements _$ScoutRosterEntryCopyWith<$Res> {
  __$ScoutRosterEntryCopyWithImpl(this._self, this._then);

  final _ScoutRosterEntry _self;
  final $Res Function(_ScoutRosterEntry) _then;

/// Create a copy of ScoutRosterEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,}) {
  return _then(_ScoutRosterEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$ScoutPreview {

 List<ScoutSet> get sets; List<ScoutTeam> get teams; int? get ourTeamIndex; List<ScoutRosterEntry> get roster;
/// Create a copy of ScoutPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScoutPreviewCopyWith<ScoutPreview> get copyWith => _$ScoutPreviewCopyWithImpl<ScoutPreview>(this as ScoutPreview, _$identity);

  /// Serializes this ScoutPreview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScoutPreview&&const DeepCollectionEquality().equals(other.sets, sets)&&const DeepCollectionEquality().equals(other.teams, teams)&&(identical(other.ourTeamIndex, ourTeamIndex) || other.ourTeamIndex == ourTeamIndex)&&const DeepCollectionEquality().equals(other.roster, roster));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sets),const DeepCollectionEquality().hash(teams),ourTeamIndex,const DeepCollectionEquality().hash(roster));

@override
String toString() {
  return 'ScoutPreview(sets: $sets, teams: $teams, ourTeamIndex: $ourTeamIndex, roster: $roster)';
}


}

/// @nodoc
abstract mixin class $ScoutPreviewCopyWith<$Res>  {
  factory $ScoutPreviewCopyWith(ScoutPreview value, $Res Function(ScoutPreview) _then) = _$ScoutPreviewCopyWithImpl;
@useResult
$Res call({
 List<ScoutSet> sets, List<ScoutTeam> teams, int? ourTeamIndex, List<ScoutRosterEntry> roster
});




}
/// @nodoc
class _$ScoutPreviewCopyWithImpl<$Res>
    implements $ScoutPreviewCopyWith<$Res> {
  _$ScoutPreviewCopyWithImpl(this._self, this._then);

  final ScoutPreview _self;
  final $Res Function(ScoutPreview) _then;

/// Create a copy of ScoutPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sets = null,Object? teams = null,Object? ourTeamIndex = freezed,Object? roster = null,}) {
  return _then(_self.copyWith(
sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<ScoutSet>,teams: null == teams ? _self.teams : teams // ignore: cast_nullable_to_non_nullable
as List<ScoutTeam>,ourTeamIndex: freezed == ourTeamIndex ? _self.ourTeamIndex : ourTeamIndex // ignore: cast_nullable_to_non_nullable
as int?,roster: null == roster ? _self.roster : roster // ignore: cast_nullable_to_non_nullable
as List<ScoutRosterEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [ScoutPreview].
extension ScoutPreviewPatterns on ScoutPreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScoutPreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScoutPreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScoutPreview value)  $default,){
final _that = this;
switch (_that) {
case _ScoutPreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScoutPreview value)?  $default,){
final _that = this;
switch (_that) {
case _ScoutPreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ScoutSet> sets,  List<ScoutTeam> teams,  int? ourTeamIndex,  List<ScoutRosterEntry> roster)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScoutPreview() when $default != null:
return $default(_that.sets,_that.teams,_that.ourTeamIndex,_that.roster);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ScoutSet> sets,  List<ScoutTeam> teams,  int? ourTeamIndex,  List<ScoutRosterEntry> roster)  $default,) {final _that = this;
switch (_that) {
case _ScoutPreview():
return $default(_that.sets,_that.teams,_that.ourTeamIndex,_that.roster);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ScoutSet> sets,  List<ScoutTeam> teams,  int? ourTeamIndex,  List<ScoutRosterEntry> roster)?  $default,) {final _that = this;
switch (_that) {
case _ScoutPreview() when $default != null:
return $default(_that.sets,_that.teams,_that.ourTeamIndex,_that.roster);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScoutPreview implements ScoutPreview {
  const _ScoutPreview({final  List<ScoutSet> sets = const <ScoutSet>[], final  List<ScoutTeam> teams = const <ScoutTeam>[], this.ourTeamIndex, final  List<ScoutRosterEntry> roster = const <ScoutRosterEntry>[]}): _sets = sets,_teams = teams,_roster = roster;
  factory _ScoutPreview.fromJson(Map<String, dynamic> json) => _$ScoutPreviewFromJson(json);

 final  List<ScoutSet> _sets;
@override@JsonKey() List<ScoutSet> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}

 final  List<ScoutTeam> _teams;
@override@JsonKey() List<ScoutTeam> get teams {
  if (_teams is EqualUnmodifiableListView) return _teams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teams);
}

@override final  int? ourTeamIndex;
 final  List<ScoutRosterEntry> _roster;
@override@JsonKey() List<ScoutRosterEntry> get roster {
  if (_roster is EqualUnmodifiableListView) return _roster;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roster);
}


/// Create a copy of ScoutPreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScoutPreviewCopyWith<_ScoutPreview> get copyWith => __$ScoutPreviewCopyWithImpl<_ScoutPreview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScoutPreviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScoutPreview&&const DeepCollectionEquality().equals(other._sets, _sets)&&const DeepCollectionEquality().equals(other._teams, _teams)&&(identical(other.ourTeamIndex, ourTeamIndex) || other.ourTeamIndex == ourTeamIndex)&&const DeepCollectionEquality().equals(other._roster, _roster));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sets),const DeepCollectionEquality().hash(_teams),ourTeamIndex,const DeepCollectionEquality().hash(_roster));

@override
String toString() {
  return 'ScoutPreview(sets: $sets, teams: $teams, ourTeamIndex: $ourTeamIndex, roster: $roster)';
}


}

/// @nodoc
abstract mixin class _$ScoutPreviewCopyWith<$Res> implements $ScoutPreviewCopyWith<$Res> {
  factory _$ScoutPreviewCopyWith(_ScoutPreview value, $Res Function(_ScoutPreview) _then) = __$ScoutPreviewCopyWithImpl;
@override @useResult
$Res call({
 List<ScoutSet> sets, List<ScoutTeam> teams, int? ourTeamIndex, List<ScoutRosterEntry> roster
});




}
/// @nodoc
class __$ScoutPreviewCopyWithImpl<$Res>
    implements _$ScoutPreviewCopyWith<$Res> {
  __$ScoutPreviewCopyWithImpl(this._self, this._then);

  final _ScoutPreview _self;
  final $Res Function(_ScoutPreview) _then;

/// Create a copy of ScoutPreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sets = null,Object? teams = null,Object? ourTeamIndex = freezed,Object? roster = null,}) {
  return _then(_ScoutPreview(
sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<ScoutSet>,teams: null == teams ? _self._teams : teams // ignore: cast_nullable_to_non_nullable
as List<ScoutTeam>,ourTeamIndex: freezed == ourTeamIndex ? _self.ourTeamIndex : ourTeamIndex // ignore: cast_nullable_to_non_nullable
as int?,roster: null == roster ? _self._roster : roster // ignore: cast_nullable_to_non_nullable
as List<ScoutRosterEntry>,
  ));
}


}


/// @nodoc
mixin _$FlagCandidate {

 String get key; int? get playerId; int? get userId; String get name; bool get guest; bool get staff;
/// Create a copy of FlagCandidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlagCandidateCopyWith<FlagCandidate> get copyWith => _$FlagCandidateCopyWithImpl<FlagCandidate>(this as FlagCandidate, _$identity);

  /// Serializes this FlagCandidate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlagCandidate&&(identical(other.key, key) || other.key == key)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.guest, guest) || other.guest == guest)&&(identical(other.staff, staff) || other.staff == staff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,playerId,userId,name,guest,staff);

@override
String toString() {
  return 'FlagCandidate(key: $key, playerId: $playerId, userId: $userId, name: $name, guest: $guest, staff: $staff)';
}


}

/// @nodoc
abstract mixin class $FlagCandidateCopyWith<$Res>  {
  factory $FlagCandidateCopyWith(FlagCandidate value, $Res Function(FlagCandidate) _then) = _$FlagCandidateCopyWithImpl;
@useResult
$Res call({
 String key, int? playerId, int? userId, String name, bool guest, bool staff
});




}
/// @nodoc
class _$FlagCandidateCopyWithImpl<$Res>
    implements $FlagCandidateCopyWith<$Res> {
  _$FlagCandidateCopyWithImpl(this._self, this._then);

  final FlagCandidate _self;
  final $Res Function(FlagCandidate) _then;

/// Create a copy of FlagCandidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? playerId = freezed,Object? userId = freezed,Object? name = null,Object? guest = null,Object? staff = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,guest: null == guest ? _self.guest : guest // ignore: cast_nullable_to_non_nullable
as bool,staff: null == staff ? _self.staff : staff // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FlagCandidate].
extension FlagCandidatePatterns on FlagCandidate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlagCandidate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlagCandidate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlagCandidate value)  $default,){
final _that = this;
switch (_that) {
case _FlagCandidate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlagCandidate value)?  $default,){
final _that = this;
switch (_that) {
case _FlagCandidate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  int? playerId,  int? userId,  String name,  bool guest,  bool staff)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlagCandidate() when $default != null:
return $default(_that.key,_that.playerId,_that.userId,_that.name,_that.guest,_that.staff);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  int? playerId,  int? userId,  String name,  bool guest,  bool staff)  $default,) {final _that = this;
switch (_that) {
case _FlagCandidate():
return $default(_that.key,_that.playerId,_that.userId,_that.name,_that.guest,_that.staff);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  int? playerId,  int? userId,  String name,  bool guest,  bool staff)?  $default,) {final _that = this;
switch (_that) {
case _FlagCandidate() when $default != null:
return $default(_that.key,_that.playerId,_that.userId,_that.name,_that.guest,_that.staff);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlagCandidate implements FlagCandidate {
  const _FlagCandidate({required this.key, this.playerId, this.userId, this.name = '', this.guest = false, this.staff = false});
  factory _FlagCandidate.fromJson(Map<String, dynamic> json) => _$FlagCandidateFromJson(json);

@override final  String key;
@override final  int? playerId;
@override final  int? userId;
@override@JsonKey() final  String name;
@override@JsonKey() final  bool guest;
@override@JsonKey() final  bool staff;

/// Create a copy of FlagCandidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlagCandidateCopyWith<_FlagCandidate> get copyWith => __$FlagCandidateCopyWithImpl<_FlagCandidate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlagCandidateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlagCandidate&&(identical(other.key, key) || other.key == key)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.guest, guest) || other.guest == guest)&&(identical(other.staff, staff) || other.staff == staff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,playerId,userId,name,guest,staff);

@override
String toString() {
  return 'FlagCandidate(key: $key, playerId: $playerId, userId: $userId, name: $name, guest: $guest, staff: $staff)';
}


}

/// @nodoc
abstract mixin class _$FlagCandidateCopyWith<$Res> implements $FlagCandidateCopyWith<$Res> {
  factory _$FlagCandidateCopyWith(_FlagCandidate value, $Res Function(_FlagCandidate) _then) = __$FlagCandidateCopyWithImpl;
@override @useResult
$Res call({
 String key, int? playerId, int? userId, String name, bool guest, bool staff
});




}
/// @nodoc
class __$FlagCandidateCopyWithImpl<$Res>
    implements _$FlagCandidateCopyWith<$Res> {
  __$FlagCandidateCopyWithImpl(this._self, this._then);

  final _FlagCandidate _self;
  final $Res Function(_FlagCandidate) _then;

/// Create a copy of FlagCandidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? playerId = freezed,Object? userId = freezed,Object? name = null,Object? guest = null,Object? staff = null,}) {
  return _then(_FlagCandidate(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,guest: null == guest ? _self.guest : guest // ignore: cast_nullable_to_non_nullable
as bool,staff: null == staff ? _self.staff : staff // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$FlagDutyEdit {

 List<FlagShift> get shifts; List<String> get names; bool get mine; int get matchMinutes; List<FlagCandidate> get pool;
/// Create a copy of FlagDutyEdit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlagDutyEditCopyWith<FlagDutyEdit> get copyWith => _$FlagDutyEditCopyWithImpl<FlagDutyEdit>(this as FlagDutyEdit, _$identity);

  /// Serializes this FlagDutyEdit to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlagDutyEdit&&const DeepCollectionEquality().equals(other.shifts, shifts)&&const DeepCollectionEquality().equals(other.names, names)&&(identical(other.mine, mine) || other.mine == mine)&&(identical(other.matchMinutes, matchMinutes) || other.matchMinutes == matchMinutes)&&const DeepCollectionEquality().equals(other.pool, pool));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(shifts),const DeepCollectionEquality().hash(names),mine,matchMinutes,const DeepCollectionEquality().hash(pool));

@override
String toString() {
  return 'FlagDutyEdit(shifts: $shifts, names: $names, mine: $mine, matchMinutes: $matchMinutes, pool: $pool)';
}


}

/// @nodoc
abstract mixin class $FlagDutyEditCopyWith<$Res>  {
  factory $FlagDutyEditCopyWith(FlagDutyEdit value, $Res Function(FlagDutyEdit) _then) = _$FlagDutyEditCopyWithImpl;
@useResult
$Res call({
 List<FlagShift> shifts, List<String> names, bool mine, int matchMinutes, List<FlagCandidate> pool
});




}
/// @nodoc
class _$FlagDutyEditCopyWithImpl<$Res>
    implements $FlagDutyEditCopyWith<$Res> {
  _$FlagDutyEditCopyWithImpl(this._self, this._then);

  final FlagDutyEdit _self;
  final $Res Function(FlagDutyEdit) _then;

/// Create a copy of FlagDutyEdit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shifts = null,Object? names = null,Object? mine = null,Object? matchMinutes = null,Object? pool = null,}) {
  return _then(_self.copyWith(
shifts: null == shifts ? _self.shifts : shifts // ignore: cast_nullable_to_non_nullable
as List<FlagShift>,names: null == names ? _self.names : names // ignore: cast_nullable_to_non_nullable
as List<String>,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,matchMinutes: null == matchMinutes ? _self.matchMinutes : matchMinutes // ignore: cast_nullable_to_non_nullable
as int,pool: null == pool ? _self.pool : pool // ignore: cast_nullable_to_non_nullable
as List<FlagCandidate>,
  ));
}

}


/// Adds pattern-matching-related methods to [FlagDutyEdit].
extension FlagDutyEditPatterns on FlagDutyEdit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlagDutyEdit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlagDutyEdit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlagDutyEdit value)  $default,){
final _that = this;
switch (_that) {
case _FlagDutyEdit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlagDutyEdit value)?  $default,){
final _that = this;
switch (_that) {
case _FlagDutyEdit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FlagShift> shifts,  List<String> names,  bool mine,  int matchMinutes,  List<FlagCandidate> pool)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlagDutyEdit() when $default != null:
return $default(_that.shifts,_that.names,_that.mine,_that.matchMinutes,_that.pool);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FlagShift> shifts,  List<String> names,  bool mine,  int matchMinutes,  List<FlagCandidate> pool)  $default,) {final _that = this;
switch (_that) {
case _FlagDutyEdit():
return $default(_that.shifts,_that.names,_that.mine,_that.matchMinutes,_that.pool);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FlagShift> shifts,  List<String> names,  bool mine,  int matchMinutes,  List<FlagCandidate> pool)?  $default,) {final _that = this;
switch (_that) {
case _FlagDutyEdit() when $default != null:
return $default(_that.shifts,_that.names,_that.mine,_that.matchMinutes,_that.pool);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlagDutyEdit extends FlagDutyEdit {
  const _FlagDutyEdit({final  List<FlagShift> shifts = const <FlagShift>[], final  List<String> names = const <String>[], this.mine = false, this.matchMinutes = 90, final  List<FlagCandidate> pool = const <FlagCandidate>[]}): _shifts = shifts,_names = names,_pool = pool,super._();
  factory _FlagDutyEdit.fromJson(Map<String, dynamic> json) => _$FlagDutyEditFromJson(json);

 final  List<FlagShift> _shifts;
@override@JsonKey() List<FlagShift> get shifts {
  if (_shifts is EqualUnmodifiableListView) return _shifts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shifts);
}

 final  List<String> _names;
@override@JsonKey() List<String> get names {
  if (_names is EqualUnmodifiableListView) return _names;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_names);
}

@override@JsonKey() final  bool mine;
@override@JsonKey() final  int matchMinutes;
 final  List<FlagCandidate> _pool;
@override@JsonKey() List<FlagCandidate> get pool {
  if (_pool is EqualUnmodifiableListView) return _pool;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pool);
}


/// Create a copy of FlagDutyEdit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlagDutyEditCopyWith<_FlagDutyEdit> get copyWith => __$FlagDutyEditCopyWithImpl<_FlagDutyEdit>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlagDutyEditToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlagDutyEdit&&const DeepCollectionEquality().equals(other._shifts, _shifts)&&const DeepCollectionEquality().equals(other._names, _names)&&(identical(other.mine, mine) || other.mine == mine)&&(identical(other.matchMinutes, matchMinutes) || other.matchMinutes == matchMinutes)&&const DeepCollectionEquality().equals(other._pool, _pool));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_shifts),const DeepCollectionEquality().hash(_names),mine,matchMinutes,const DeepCollectionEquality().hash(_pool));

@override
String toString() {
  return 'FlagDutyEdit(shifts: $shifts, names: $names, mine: $mine, matchMinutes: $matchMinutes, pool: $pool)';
}


}

/// @nodoc
abstract mixin class _$FlagDutyEditCopyWith<$Res> implements $FlagDutyEditCopyWith<$Res> {
  factory _$FlagDutyEditCopyWith(_FlagDutyEdit value, $Res Function(_FlagDutyEdit) _then) = __$FlagDutyEditCopyWithImpl;
@override @useResult
$Res call({
 List<FlagShift> shifts, List<String> names, bool mine, int matchMinutes, List<FlagCandidate> pool
});




}
/// @nodoc
class __$FlagDutyEditCopyWithImpl<$Res>
    implements _$FlagDutyEditCopyWith<$Res> {
  __$FlagDutyEditCopyWithImpl(this._self, this._then);

  final _FlagDutyEdit _self;
  final $Res Function(_FlagDutyEdit) _then;

/// Create a copy of FlagDutyEdit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shifts = null,Object? names = null,Object? mine = null,Object? matchMinutes = null,Object? pool = null,}) {
  return _then(_FlagDutyEdit(
shifts: null == shifts ? _self._shifts : shifts // ignore: cast_nullable_to_non_nullable
as List<FlagShift>,names: null == names ? _self._names : names // ignore: cast_nullable_to_non_nullable
as List<String>,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,matchMinutes: null == matchMinutes ? _self.matchMinutes : matchMinutes // ignore: cast_nullable_to_non_nullable
as int,pool: null == pool ? _self._pool : pool // ignore: cast_nullable_to_non_nullable
as List<FlagCandidate>,
  ));
}


}

// dart format on
