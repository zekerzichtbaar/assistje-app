// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lineup_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LineupPlayer {

 int get id; int? get shirtNumber; String get name;/// Positiecode van de speler (`ST`, `K`); de volledige naam staat in het
/// sportprofiel (`positions`). Leeg bij gasten zonder positie.
 String get position; bool get isGuest;/// Bij een gast: het team waar hij vandaan komt.
 String? get fromTeam; String? get avatarUrl;
/// Create a copy of LineupPlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineupPlayerCopyWith<LineupPlayer> get copyWith => _$LineupPlayerCopyWithImpl<LineupPlayer>(this as LineupPlayer, _$identity);

  /// Serializes this LineupPlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineupPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.fromTeam, fromTeam) || other.fromTeam == fromTeam)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shirtNumber,name,position,isGuest,fromTeam,avatarUrl);

@override
String toString() {
  return 'LineupPlayer(id: $id, shirtNumber: $shirtNumber, name: $name, position: $position, isGuest: $isGuest, fromTeam: $fromTeam, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $LineupPlayerCopyWith<$Res>  {
  factory $LineupPlayerCopyWith(LineupPlayer value, $Res Function(LineupPlayer) _then) = _$LineupPlayerCopyWithImpl;
@useResult
$Res call({
 int id, int? shirtNumber, String name, String position, bool isGuest, String? fromTeam, String? avatarUrl
});




}
/// @nodoc
class _$LineupPlayerCopyWithImpl<$Res>
    implements $LineupPlayerCopyWith<$Res> {
  _$LineupPlayerCopyWithImpl(this._self, this._then);

  final LineupPlayer _self;
  final $Res Function(LineupPlayer) _then;

/// Create a copy of LineupPlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shirtNumber = freezed,Object? name = null,Object? position = null,Object? isGuest = null,Object? fromTeam = freezed,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,fromTeam: freezed == fromTeam ? _self.fromTeam : fromTeam // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LineupPlayer].
extension LineupPlayerPatterns on LineupPlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LineupPlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LineupPlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LineupPlayer value)  $default,){
final _that = this;
switch (_that) {
case _LineupPlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LineupPlayer value)?  $default,){
final _that = this;
switch (_that) {
case _LineupPlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? shirtNumber,  String name,  String position,  bool isGuest,  String? fromTeam,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LineupPlayer() when $default != null:
return $default(_that.id,_that.shirtNumber,_that.name,_that.position,_that.isGuest,_that.fromTeam,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? shirtNumber,  String name,  String position,  bool isGuest,  String? fromTeam,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _LineupPlayer():
return $default(_that.id,_that.shirtNumber,_that.name,_that.position,_that.isGuest,_that.fromTeam,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? shirtNumber,  String name,  String position,  bool isGuest,  String? fromTeam,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _LineupPlayer() when $default != null:
return $default(_that.id,_that.shirtNumber,_that.name,_that.position,_that.isGuest,_that.fromTeam,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LineupPlayer implements LineupPlayer {
  const _LineupPlayer({required this.id, this.shirtNumber, this.name = '', this.position = '', this.isGuest = false, this.fromTeam, this.avatarUrl});
  factory _LineupPlayer.fromJson(Map<String, dynamic> json) => _$LineupPlayerFromJson(json);

@override final  int id;
@override final  int? shirtNumber;
@override@JsonKey() final  String name;
/// Positiecode van de speler (`ST`, `K`); de volledige naam staat in het
/// sportprofiel (`positions`). Leeg bij gasten zonder positie.
@override@JsonKey() final  String position;
@override@JsonKey() final  bool isGuest;
/// Bij een gast: het team waar hij vandaan komt.
@override final  String? fromTeam;
@override final  String? avatarUrl;

/// Create a copy of LineupPlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LineupPlayerCopyWith<_LineupPlayer> get copyWith => __$LineupPlayerCopyWithImpl<_LineupPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LineupPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LineupPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.fromTeam, fromTeam) || other.fromTeam == fromTeam)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shirtNumber,name,position,isGuest,fromTeam,avatarUrl);

@override
String toString() {
  return 'LineupPlayer(id: $id, shirtNumber: $shirtNumber, name: $name, position: $position, isGuest: $isGuest, fromTeam: $fromTeam, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$LineupPlayerCopyWith<$Res> implements $LineupPlayerCopyWith<$Res> {
  factory _$LineupPlayerCopyWith(_LineupPlayer value, $Res Function(_LineupPlayer) _then) = __$LineupPlayerCopyWithImpl;
@override @useResult
$Res call({
 int id, int? shirtNumber, String name, String position, bool isGuest, String? fromTeam, String? avatarUrl
});




}
/// @nodoc
class __$LineupPlayerCopyWithImpl<$Res>
    implements _$LineupPlayerCopyWith<$Res> {
  __$LineupPlayerCopyWithImpl(this._self, this._then);

  final _LineupPlayer _self;
  final $Res Function(_LineupPlayer) _then;

/// Create a copy of LineupPlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shirtNumber = freezed,Object? name = null,Object? position = null,Object? isGuest = null,Object? fromTeam = freezed,Object? avatarUrl = freezed,}) {
  return _then(_LineupPlayer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,fromTeam: freezed == fromTeam ? _self.fromTeam : fromTeam // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LineupSlot {

 int get id; String get slotCode; LineupPlayer get player;
/// Create a copy of LineupSlot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineupSlotCopyWith<LineupSlot> get copyWith => _$LineupSlotCopyWithImpl<LineupSlot>(this as LineupSlot, _$identity);

  /// Serializes this LineupSlot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineupSlot&&(identical(other.id, id) || other.id == id)&&(identical(other.slotCode, slotCode) || other.slotCode == slotCode)&&(identical(other.player, player) || other.player == player));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,slotCode,player);

@override
String toString() {
  return 'LineupSlot(id: $id, slotCode: $slotCode, player: $player)';
}


}

/// @nodoc
abstract mixin class $LineupSlotCopyWith<$Res>  {
  factory $LineupSlotCopyWith(LineupSlot value, $Res Function(LineupSlot) _then) = _$LineupSlotCopyWithImpl;
@useResult
$Res call({
 int id, String slotCode, LineupPlayer player
});


$LineupPlayerCopyWith<$Res> get player;

}
/// @nodoc
class _$LineupSlotCopyWithImpl<$Res>
    implements $LineupSlotCopyWith<$Res> {
  _$LineupSlotCopyWithImpl(this._self, this._then);

  final LineupSlot _self;
  final $Res Function(LineupSlot) _then;

/// Create a copy of LineupSlot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? slotCode = null,Object? player = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,slotCode: null == slotCode ? _self.slotCode : slotCode // ignore: cast_nullable_to_non_nullable
as String,player: null == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as LineupPlayer,
  ));
}
/// Create a copy of LineupSlot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LineupPlayerCopyWith<$Res> get player {
  
  return $LineupPlayerCopyWith<$Res>(_self.player, (value) {
    return _then(_self.copyWith(player: value));
  });
}
}


/// Adds pattern-matching-related methods to [LineupSlot].
extension LineupSlotPatterns on LineupSlot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LineupSlot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LineupSlot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LineupSlot value)  $default,){
final _that = this;
switch (_that) {
case _LineupSlot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LineupSlot value)?  $default,){
final _that = this;
switch (_that) {
case _LineupSlot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String slotCode,  LineupPlayer player)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LineupSlot() when $default != null:
return $default(_that.id,_that.slotCode,_that.player);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String slotCode,  LineupPlayer player)  $default,) {final _that = this;
switch (_that) {
case _LineupSlot():
return $default(_that.id,_that.slotCode,_that.player);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String slotCode,  LineupPlayer player)?  $default,) {final _that = this;
switch (_that) {
case _LineupSlot() when $default != null:
return $default(_that.id,_that.slotCode,_that.player);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LineupSlot implements LineupSlot {
  const _LineupSlot({this.id = 0, required this.slotCode, required this.player});
  factory _LineupSlot.fromJson(Map<String, dynamic> json) => _$LineupSlotFromJson(json);

@override@JsonKey() final  int id;
@override final  String slotCode;
@override final  LineupPlayer player;

/// Create a copy of LineupSlot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LineupSlotCopyWith<_LineupSlot> get copyWith => __$LineupSlotCopyWithImpl<_LineupSlot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LineupSlotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LineupSlot&&(identical(other.id, id) || other.id == id)&&(identical(other.slotCode, slotCode) || other.slotCode == slotCode)&&(identical(other.player, player) || other.player == player));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,slotCode,player);

@override
String toString() {
  return 'LineupSlot(id: $id, slotCode: $slotCode, player: $player)';
}


}

/// @nodoc
abstract mixin class _$LineupSlotCopyWith<$Res> implements $LineupSlotCopyWith<$Res> {
  factory _$LineupSlotCopyWith(_LineupSlot value, $Res Function(_LineupSlot) _then) = __$LineupSlotCopyWithImpl;
@override @useResult
$Res call({
 int id, String slotCode, LineupPlayer player
});


@override $LineupPlayerCopyWith<$Res> get player;

}
/// @nodoc
class __$LineupSlotCopyWithImpl<$Res>
    implements _$LineupSlotCopyWith<$Res> {
  __$LineupSlotCopyWithImpl(this._self, this._then);

  final _LineupSlot _self;
  final $Res Function(_LineupSlot) _then;

/// Create a copy of LineupSlot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? slotCode = null,Object? player = null,}) {
  return _then(_LineupSlot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,slotCode: null == slotCode ? _self.slotCode : slotCode // ignore: cast_nullable_to_non_nullable
as String,player: null == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as LineupPlayer,
  ));
}

/// Create a copy of LineupSlot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LineupPlayerCopyWith<$Res> get player {
  
  return $LineupPlayerCopyWith<$Res>(_self.player, (value) {
    return _then(_self.copyWith(player: value));
  });
}
}


/// @nodoc
mixin _$FormationSlot {

 String get code; double get x; double get y; String get label;
/// Create a copy of FormationSlot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormationSlotCopyWith<FormationSlot> get copyWith => _$FormationSlotCopyWithImpl<FormationSlot>(this as FormationSlot, _$identity);

  /// Serializes this FormationSlot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormationSlot&&(identical(other.code, code) || other.code == code)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,x,y,label);

@override
String toString() {
  return 'FormationSlot(code: $code, x: $x, y: $y, label: $label)';
}


}

/// @nodoc
abstract mixin class $FormationSlotCopyWith<$Res>  {
  factory $FormationSlotCopyWith(FormationSlot value, $Res Function(FormationSlot) _then) = _$FormationSlotCopyWithImpl;
@useResult
$Res call({
 String code, double x, double y, String label
});




}
/// @nodoc
class _$FormationSlotCopyWithImpl<$Res>
    implements $FormationSlotCopyWith<$Res> {
  _$FormationSlotCopyWithImpl(this._self, this._then);

  final FormationSlot _self;
  final $Res Function(FormationSlot) _then;

/// Create a copy of FormationSlot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? x = null,Object? y = null,Object? label = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FormationSlot].
extension FormationSlotPatterns on FormationSlot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormationSlot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormationSlot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormationSlot value)  $default,){
final _that = this;
switch (_that) {
case _FormationSlot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormationSlot value)?  $default,){
final _that = this;
switch (_that) {
case _FormationSlot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String code,  double x,  double y,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormationSlot() when $default != null:
return $default(_that.code,_that.x,_that.y,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String code,  double x,  double y,  String label)  $default,) {final _that = this;
switch (_that) {
case _FormationSlot():
return $default(_that.code,_that.x,_that.y,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String code,  double x,  double y,  String label)?  $default,) {final _that = this;
switch (_that) {
case _FormationSlot() when $default != null:
return $default(_that.code,_that.x,_that.y,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormationSlot implements FormationSlot {
  const _FormationSlot({required this.code, this.x = 50, this.y = 50, this.label = ''});
  factory _FormationSlot.fromJson(Map<String, dynamic> json) => _$FormationSlotFromJson(json);

@override final  String code;
@override@JsonKey() final  double x;
@override@JsonKey() final  double y;
@override@JsonKey() final  String label;

/// Create a copy of FormationSlot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormationSlotCopyWith<_FormationSlot> get copyWith => __$FormationSlotCopyWithImpl<_FormationSlot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormationSlotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormationSlot&&(identical(other.code, code) || other.code == code)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,x,y,label);

@override
String toString() {
  return 'FormationSlot(code: $code, x: $x, y: $y, label: $label)';
}


}

/// @nodoc
abstract mixin class _$FormationSlotCopyWith<$Res> implements $FormationSlotCopyWith<$Res> {
  factory _$FormationSlotCopyWith(_FormationSlot value, $Res Function(_FormationSlot) _then) = __$FormationSlotCopyWithImpl;
@override @useResult
$Res call({
 String code, double x, double y, String label
});




}
/// @nodoc
class __$FormationSlotCopyWithImpl<$Res>
    implements _$FormationSlotCopyWith<$Res> {
  __$FormationSlotCopyWithImpl(this._self, this._then);

  final _FormationSlot _self;
  final $Res Function(_FormationSlot) _then;

/// Create a copy of FormationSlot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? x = null,Object? y = null,Object? label = null,}) {
  return _then(_FormationSlot(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$FormationOption {

 String get key; String get label;
/// Create a copy of FormationOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormationOptionCopyWith<FormationOption> get copyWith => _$FormationOptionCopyWithImpl<FormationOption>(this as FormationOption, _$identity);

  /// Serializes this FormationOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormationOption&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label);

@override
String toString() {
  return 'FormationOption(key: $key, label: $label)';
}


}

/// @nodoc
abstract mixin class $FormationOptionCopyWith<$Res>  {
  factory $FormationOptionCopyWith(FormationOption value, $Res Function(FormationOption) _then) = _$FormationOptionCopyWithImpl;
@useResult
$Res call({
 String key, String label
});




}
/// @nodoc
class _$FormationOptionCopyWithImpl<$Res>
    implements $FormationOptionCopyWith<$Res> {
  _$FormationOptionCopyWithImpl(this._self, this._then);

  final FormationOption _self;
  final $Res Function(FormationOption) _then;

/// Create a copy of FormationOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FormationOption].
extension FormationOptionPatterns on FormationOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FormationOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FormationOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FormationOption value)  $default,){
final _that = this;
switch (_that) {
case _FormationOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FormationOption value)?  $default,){
final _that = this;
switch (_that) {
case _FormationOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FormationOption() when $default != null:
return $default(_that.key,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String label)  $default,) {final _that = this;
switch (_that) {
case _FormationOption():
return $default(_that.key,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String label)?  $default,) {final _that = this;
switch (_that) {
case _FormationOption() when $default != null:
return $default(_that.key,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FormationOption implements FormationOption {
  const _FormationOption({required this.key, this.label = ''});
  factory _FormationOption.fromJson(Map<String, dynamic> json) => _$FormationOptionFromJson(json);

@override final  String key;
@override@JsonKey() final  String label;

/// Create a copy of FormationOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormationOptionCopyWith<_FormationOption> get copyWith => __$FormationOptionCopyWithImpl<_FormationOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormationOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormationOption&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label);

@override
String toString() {
  return 'FormationOption(key: $key, label: $label)';
}


}

/// @nodoc
abstract mixin class _$FormationOptionCopyWith<$Res> implements $FormationOptionCopyWith<$Res> {
  factory _$FormationOptionCopyWith(_FormationOption value, $Res Function(_FormationOption) _then) = __$FormationOptionCopyWithImpl;
@override @useResult
$Res call({
 String key, String label
});




}
/// @nodoc
class __$FormationOptionCopyWithImpl<$Res>
    implements _$FormationOptionCopyWith<$Res> {
  __$FormationOptionCopyWithImpl(this._self, this._then);

  final _FormationOption _self;
  final $Res Function(_FormationOption) _then;

/// Create a copy of FormationOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,}) {
  return _then(_FormationOption(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LineupEvent {

 int get id; String get title; String? get startsAt; String? get homeTeam; String? get awayTeam;
/// Create a copy of LineupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineupEventCopyWith<LineupEvent> get copyWith => _$LineupEventCopyWithImpl<LineupEvent>(this as LineupEvent, _$identity);

  /// Serializes this LineupEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LineupEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt,homeTeam,awayTeam);

@override
String toString() {
  return 'LineupEvent(id: $id, title: $title, startsAt: $startsAt, homeTeam: $homeTeam, awayTeam: $awayTeam)';
}


}

/// @nodoc
abstract mixin class $LineupEventCopyWith<$Res>  {
  factory $LineupEventCopyWith(LineupEvent value, $Res Function(LineupEvent) _then) = _$LineupEventCopyWithImpl;
@useResult
$Res call({
 int id, String title, String? startsAt, String? homeTeam, String? awayTeam
});




}
/// @nodoc
class _$LineupEventCopyWithImpl<$Res>
    implements $LineupEventCopyWith<$Res> {
  _$LineupEventCopyWithImpl(this._self, this._then);

  final LineupEvent _self;
  final $Res Function(LineupEvent) _then;

/// Create a copy of LineupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,Object? homeTeam = freezed,Object? awayTeam = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String?,homeTeam: freezed == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String?,awayTeam: freezed == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LineupEvent].
extension LineupEventPatterns on LineupEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LineupEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LineupEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LineupEvent value)  $default,){
final _that = this;
switch (_that) {
case _LineupEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LineupEvent value)?  $default,){
final _that = this;
switch (_that) {
case _LineupEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String? startsAt,  String? homeTeam,  String? awayTeam)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LineupEvent() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.homeTeam,_that.awayTeam);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String? startsAt,  String? homeTeam,  String? awayTeam)  $default,) {final _that = this;
switch (_that) {
case _LineupEvent():
return $default(_that.id,_that.title,_that.startsAt,_that.homeTeam,_that.awayTeam);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String? startsAt,  String? homeTeam,  String? awayTeam)?  $default,) {final _that = this;
switch (_that) {
case _LineupEvent() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.homeTeam,_that.awayTeam);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LineupEvent implements LineupEvent {
  const _LineupEvent({required this.id, this.title = '', this.startsAt, this.homeTeam, this.awayTeam});
  factory _LineupEvent.fromJson(Map<String, dynamic> json) => _$LineupEventFromJson(json);

@override final  int id;
@override@JsonKey() final  String title;
@override final  String? startsAt;
@override final  String? homeTeam;
@override final  String? awayTeam;

/// Create a copy of LineupEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LineupEventCopyWith<_LineupEvent> get copyWith => __$LineupEventCopyWithImpl<_LineupEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LineupEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LineupEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt,homeTeam,awayTeam);

@override
String toString() {
  return 'LineupEvent(id: $id, title: $title, startsAt: $startsAt, homeTeam: $homeTeam, awayTeam: $awayTeam)';
}


}

/// @nodoc
abstract mixin class _$LineupEventCopyWith<$Res> implements $LineupEventCopyWith<$Res> {
  factory _$LineupEventCopyWith(_LineupEvent value, $Res Function(_LineupEvent) _then) = __$LineupEventCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String? startsAt, String? homeTeam, String? awayTeam
});




}
/// @nodoc
class __$LineupEventCopyWithImpl<$Res>
    implements _$LineupEventCopyWith<$Res> {
  __$LineupEventCopyWithImpl(this._self, this._then);

  final _LineupEvent _self;
  final $Res Function(_LineupEvent) _then;

/// Create a copy of LineupEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,Object? homeTeam = freezed,Object? awayTeam = freezed,}) {
  return _then(_LineupEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String?,homeTeam: freezed == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String?,awayTeam: freezed == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Lineup {

 String get sport;/// Welke veldtekening: de enige sportkeuze die de app zelf maakt.
 String get fieldVariant; LineupEvent get event; List<LineupPlayer> get pool; List<LineupSlot> get slots; String get formation; List<FormationSlot> get formationSlots; List<FormationOption> get formations; String get formationLabel; bool get canEdit; int? get captainPlayerId;/// ISO-tijdstip van delen; `null` = nog niet gedeeld.
 String? get publishedAt; bool get changedSincePublish;
/// Create a copy of Lineup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LineupCopyWith<Lineup> get copyWith => _$LineupCopyWithImpl<Lineup>(this as Lineup, _$identity);

  /// Serializes this Lineup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Lineup&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.fieldVariant, fieldVariant) || other.fieldVariant == fieldVariant)&&(identical(other.event, event) || other.event == event)&&const DeepCollectionEquality().equals(other.pool, pool)&&const DeepCollectionEquality().equals(other.slots, slots)&&(identical(other.formation, formation) || other.formation == formation)&&const DeepCollectionEquality().equals(other.formationSlots, formationSlots)&&const DeepCollectionEquality().equals(other.formations, formations)&&(identical(other.formationLabel, formationLabel) || other.formationLabel == formationLabel)&&(identical(other.canEdit, canEdit) || other.canEdit == canEdit)&&(identical(other.captainPlayerId, captainPlayerId) || other.captainPlayerId == captainPlayerId)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.changedSincePublish, changedSincePublish) || other.changedSincePublish == changedSincePublish));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sport,fieldVariant,event,const DeepCollectionEquality().hash(pool),const DeepCollectionEquality().hash(slots),formation,const DeepCollectionEquality().hash(formationSlots),const DeepCollectionEquality().hash(formations),formationLabel,canEdit,captainPlayerId,publishedAt,changedSincePublish);

@override
String toString() {
  return 'Lineup(sport: $sport, fieldVariant: $fieldVariant, event: $event, pool: $pool, slots: $slots, formation: $formation, formationSlots: $formationSlots, formations: $formations, formationLabel: $formationLabel, canEdit: $canEdit, captainPlayerId: $captainPlayerId, publishedAt: $publishedAt, changedSincePublish: $changedSincePublish)';
}


}

/// @nodoc
abstract mixin class $LineupCopyWith<$Res>  {
  factory $LineupCopyWith(Lineup value, $Res Function(Lineup) _then) = _$LineupCopyWithImpl;
@useResult
$Res call({
 String sport, String fieldVariant, LineupEvent event, List<LineupPlayer> pool, List<LineupSlot> slots, String formation, List<FormationSlot> formationSlots, List<FormationOption> formations, String formationLabel, bool canEdit, int? captainPlayerId, String? publishedAt, bool changedSincePublish
});


$LineupEventCopyWith<$Res> get event;

}
/// @nodoc
class _$LineupCopyWithImpl<$Res>
    implements $LineupCopyWith<$Res> {
  _$LineupCopyWithImpl(this._self, this._then);

  final Lineup _self;
  final $Res Function(Lineup) _then;

/// Create a copy of Lineup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sport = null,Object? fieldVariant = null,Object? event = null,Object? pool = null,Object? slots = null,Object? formation = null,Object? formationSlots = null,Object? formations = null,Object? formationLabel = null,Object? canEdit = null,Object? captainPlayerId = freezed,Object? publishedAt = freezed,Object? changedSincePublish = null,}) {
  return _then(_self.copyWith(
sport: null == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as String,fieldVariant: null == fieldVariant ? _self.fieldVariant : fieldVariant // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as LineupEvent,pool: null == pool ? _self.pool : pool // ignore: cast_nullable_to_non_nullable
as List<LineupPlayer>,slots: null == slots ? _self.slots : slots // ignore: cast_nullable_to_non_nullable
as List<LineupSlot>,formation: null == formation ? _self.formation : formation // ignore: cast_nullable_to_non_nullable
as String,formationSlots: null == formationSlots ? _self.formationSlots : formationSlots // ignore: cast_nullable_to_non_nullable
as List<FormationSlot>,formations: null == formations ? _self.formations : formations // ignore: cast_nullable_to_non_nullable
as List<FormationOption>,formationLabel: null == formationLabel ? _self.formationLabel : formationLabel // ignore: cast_nullable_to_non_nullable
as String,canEdit: null == canEdit ? _self.canEdit : canEdit // ignore: cast_nullable_to_non_nullable
as bool,captainPlayerId: freezed == captainPlayerId ? _self.captainPlayerId : captainPlayerId // ignore: cast_nullable_to_non_nullable
as int?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String?,changedSincePublish: null == changedSincePublish ? _self.changedSincePublish : changedSincePublish // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Lineup
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LineupEventCopyWith<$Res> get event {
  
  return $LineupEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// Adds pattern-matching-related methods to [Lineup].
extension LineupPatterns on Lineup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Lineup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Lineup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Lineup value)  $default,){
final _that = this;
switch (_that) {
case _Lineup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Lineup value)?  $default,){
final _that = this;
switch (_that) {
case _Lineup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sport,  String fieldVariant,  LineupEvent event,  List<LineupPlayer> pool,  List<LineupSlot> slots,  String formation,  List<FormationSlot> formationSlots,  List<FormationOption> formations,  String formationLabel,  bool canEdit,  int? captainPlayerId,  String? publishedAt,  bool changedSincePublish)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Lineup() when $default != null:
return $default(_that.sport,_that.fieldVariant,_that.event,_that.pool,_that.slots,_that.formation,_that.formationSlots,_that.formations,_that.formationLabel,_that.canEdit,_that.captainPlayerId,_that.publishedAt,_that.changedSincePublish);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sport,  String fieldVariant,  LineupEvent event,  List<LineupPlayer> pool,  List<LineupSlot> slots,  String formation,  List<FormationSlot> formationSlots,  List<FormationOption> formations,  String formationLabel,  bool canEdit,  int? captainPlayerId,  String? publishedAt,  bool changedSincePublish)  $default,) {final _that = this;
switch (_that) {
case _Lineup():
return $default(_that.sport,_that.fieldVariant,_that.event,_that.pool,_that.slots,_that.formation,_that.formationSlots,_that.formations,_that.formationLabel,_that.canEdit,_that.captainPlayerId,_that.publishedAt,_that.changedSincePublish);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sport,  String fieldVariant,  LineupEvent event,  List<LineupPlayer> pool,  List<LineupSlot> slots,  String formation,  List<FormationSlot> formationSlots,  List<FormationOption> formations,  String formationLabel,  bool canEdit,  int? captainPlayerId,  String? publishedAt,  bool changedSincePublish)?  $default,) {final _that = this;
switch (_that) {
case _Lineup() when $default != null:
return $default(_that.sport,_that.fieldVariant,_that.event,_that.pool,_that.slots,_that.formation,_that.formationSlots,_that.formations,_that.formationLabel,_that.canEdit,_that.captainPlayerId,_that.publishedAt,_that.changedSincePublish);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Lineup extends Lineup {
  const _Lineup({this.sport = '', this.fieldVariant = '', required this.event, final  List<LineupPlayer> pool = const <LineupPlayer>[], final  List<LineupSlot> slots = const <LineupSlot>[], this.formation = '', final  List<FormationSlot> formationSlots = const <FormationSlot>[], final  List<FormationOption> formations = const <FormationOption>[], this.formationLabel = '', this.canEdit = false, this.captainPlayerId, this.publishedAt, this.changedSincePublish = false}): _pool = pool,_slots = slots,_formationSlots = formationSlots,_formations = formations,super._();
  factory _Lineup.fromJson(Map<String, dynamic> json) => _$LineupFromJson(json);

@override@JsonKey() final  String sport;
/// Welke veldtekening: de enige sportkeuze die de app zelf maakt.
@override@JsonKey() final  String fieldVariant;
@override final  LineupEvent event;
 final  List<LineupPlayer> _pool;
@override@JsonKey() List<LineupPlayer> get pool {
  if (_pool is EqualUnmodifiableListView) return _pool;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pool);
}

 final  List<LineupSlot> _slots;
@override@JsonKey() List<LineupSlot> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}

@override@JsonKey() final  String formation;
 final  List<FormationSlot> _formationSlots;
@override@JsonKey() List<FormationSlot> get formationSlots {
  if (_formationSlots is EqualUnmodifiableListView) return _formationSlots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_formationSlots);
}

 final  List<FormationOption> _formations;
@override@JsonKey() List<FormationOption> get formations {
  if (_formations is EqualUnmodifiableListView) return _formations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_formations);
}

@override@JsonKey() final  String formationLabel;
@override@JsonKey() final  bool canEdit;
@override final  int? captainPlayerId;
/// ISO-tijdstip van delen; `null` = nog niet gedeeld.
@override final  String? publishedAt;
@override@JsonKey() final  bool changedSincePublish;

/// Create a copy of Lineup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LineupCopyWith<_Lineup> get copyWith => __$LineupCopyWithImpl<_Lineup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LineupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Lineup&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.fieldVariant, fieldVariant) || other.fieldVariant == fieldVariant)&&(identical(other.event, event) || other.event == event)&&const DeepCollectionEquality().equals(other._pool, _pool)&&const DeepCollectionEquality().equals(other._slots, _slots)&&(identical(other.formation, formation) || other.formation == formation)&&const DeepCollectionEquality().equals(other._formationSlots, _formationSlots)&&const DeepCollectionEquality().equals(other._formations, _formations)&&(identical(other.formationLabel, formationLabel) || other.formationLabel == formationLabel)&&(identical(other.canEdit, canEdit) || other.canEdit == canEdit)&&(identical(other.captainPlayerId, captainPlayerId) || other.captainPlayerId == captainPlayerId)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.changedSincePublish, changedSincePublish) || other.changedSincePublish == changedSincePublish));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sport,fieldVariant,event,const DeepCollectionEquality().hash(_pool),const DeepCollectionEquality().hash(_slots),formation,const DeepCollectionEquality().hash(_formationSlots),const DeepCollectionEquality().hash(_formations),formationLabel,canEdit,captainPlayerId,publishedAt,changedSincePublish);

@override
String toString() {
  return 'Lineup(sport: $sport, fieldVariant: $fieldVariant, event: $event, pool: $pool, slots: $slots, formation: $formation, formationSlots: $formationSlots, formations: $formations, formationLabel: $formationLabel, canEdit: $canEdit, captainPlayerId: $captainPlayerId, publishedAt: $publishedAt, changedSincePublish: $changedSincePublish)';
}


}

/// @nodoc
abstract mixin class _$LineupCopyWith<$Res> implements $LineupCopyWith<$Res> {
  factory _$LineupCopyWith(_Lineup value, $Res Function(_Lineup) _then) = __$LineupCopyWithImpl;
@override @useResult
$Res call({
 String sport, String fieldVariant, LineupEvent event, List<LineupPlayer> pool, List<LineupSlot> slots, String formation, List<FormationSlot> formationSlots, List<FormationOption> formations, String formationLabel, bool canEdit, int? captainPlayerId, String? publishedAt, bool changedSincePublish
});


@override $LineupEventCopyWith<$Res> get event;

}
/// @nodoc
class __$LineupCopyWithImpl<$Res>
    implements _$LineupCopyWith<$Res> {
  __$LineupCopyWithImpl(this._self, this._then);

  final _Lineup _self;
  final $Res Function(_Lineup) _then;

/// Create a copy of Lineup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sport = null,Object? fieldVariant = null,Object? event = null,Object? pool = null,Object? slots = null,Object? formation = null,Object? formationSlots = null,Object? formations = null,Object? formationLabel = null,Object? canEdit = null,Object? captainPlayerId = freezed,Object? publishedAt = freezed,Object? changedSincePublish = null,}) {
  return _then(_Lineup(
sport: null == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as String,fieldVariant: null == fieldVariant ? _self.fieldVariant : fieldVariant // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as LineupEvent,pool: null == pool ? _self._pool : pool // ignore: cast_nullable_to_non_nullable
as List<LineupPlayer>,slots: null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<LineupSlot>,formation: null == formation ? _self.formation : formation // ignore: cast_nullable_to_non_nullable
as String,formationSlots: null == formationSlots ? _self._formationSlots : formationSlots // ignore: cast_nullable_to_non_nullable
as List<FormationSlot>,formations: null == formations ? _self._formations : formations // ignore: cast_nullable_to_non_nullable
as List<FormationOption>,formationLabel: null == formationLabel ? _self.formationLabel : formationLabel // ignore: cast_nullable_to_non_nullable
as String,canEdit: null == canEdit ? _self.canEdit : canEdit // ignore: cast_nullable_to_non_nullable
as bool,captainPlayerId: freezed == captainPlayerId ? _self.captainPlayerId : captainPlayerId // ignore: cast_nullable_to_non_nullable
as int?,publishedAt: freezed == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String?,changedSincePublish: null == changedSincePublish ? _self.changedSincePublish : changedSincePublish // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Lineup
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LineupEventCopyWith<$Res> get event {
  
  return $LineupEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}

// dart format on
