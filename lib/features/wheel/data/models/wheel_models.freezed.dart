// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wheel_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WheelPlayer {

/// `p<player_id>` of `u<user_id>`.
 String get key; int? get id; int? get userId; String get name; int? get shirtNumber; bool get isGuest; bool get isStaff; String? get avatarUrl;
/// Create a copy of WheelPlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelPlayerCopyWith<WheelPlayer> get copyWith => _$WheelPlayerCopyWithImpl<WheelPlayer>(this as WheelPlayer, _$identity);

  /// Serializes this WheelPlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelPlayer&&(identical(other.key, key) || other.key == key)&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.isStaff, isStaff) || other.isStaff == isStaff)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,id,userId,name,shirtNumber,isGuest,isStaff,avatarUrl);

@override
String toString() {
  return 'WheelPlayer(key: $key, id: $id, userId: $userId, name: $name, shirtNumber: $shirtNumber, isGuest: $isGuest, isStaff: $isStaff, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $WheelPlayerCopyWith<$Res>  {
  factory $WheelPlayerCopyWith(WheelPlayer value, $Res Function(WheelPlayer) _then) = _$WheelPlayerCopyWithImpl;
@useResult
$Res call({
 String key, int? id, int? userId, String name, int? shirtNumber, bool isGuest, bool isStaff, String? avatarUrl
});




}
/// @nodoc
class _$WheelPlayerCopyWithImpl<$Res>
    implements $WheelPlayerCopyWith<$Res> {
  _$WheelPlayerCopyWithImpl(this._self, this._then);

  final WheelPlayer _self;
  final $Res Function(WheelPlayer) _then;

/// Create a copy of WheelPlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? id = freezed,Object? userId = freezed,Object? name = null,Object? shirtNumber = freezed,Object? isGuest = null,Object? isStaff = null,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,isStaff: null == isStaff ? _self.isStaff : isStaff // ignore: cast_nullable_to_non_nullable
as bool,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WheelPlayer].
extension WheelPlayerPatterns on WheelPlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WheelPlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WheelPlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WheelPlayer value)  $default,){
final _that = this;
switch (_that) {
case _WheelPlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WheelPlayer value)?  $default,){
final _that = this;
switch (_that) {
case _WheelPlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  int? id,  int? userId,  String name,  int? shirtNumber,  bool isGuest,  bool isStaff,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WheelPlayer() when $default != null:
return $default(_that.key,_that.id,_that.userId,_that.name,_that.shirtNumber,_that.isGuest,_that.isStaff,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  int? id,  int? userId,  String name,  int? shirtNumber,  bool isGuest,  bool isStaff,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _WheelPlayer():
return $default(_that.key,_that.id,_that.userId,_that.name,_that.shirtNumber,_that.isGuest,_that.isStaff,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  int? id,  int? userId,  String name,  int? shirtNumber,  bool isGuest,  bool isStaff,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _WheelPlayer() when $default != null:
return $default(_that.key,_that.id,_that.userId,_that.name,_that.shirtNumber,_that.isGuest,_that.isStaff,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WheelPlayer extends WheelPlayer {
  const _WheelPlayer({required this.key, this.id, this.userId, this.name = '', this.shirtNumber, this.isGuest = false, this.isStaff = false, this.avatarUrl}): super._();
  factory _WheelPlayer.fromJson(Map<String, dynamic> json) => _$WheelPlayerFromJson(json);

/// `p<player_id>` of `u<user_id>`.
@override final  String key;
@override final  int? id;
@override final  int? userId;
@override@JsonKey() final  String name;
@override final  int? shirtNumber;
@override@JsonKey() final  bool isGuest;
@override@JsonKey() final  bool isStaff;
@override final  String? avatarUrl;

/// Create a copy of WheelPlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WheelPlayerCopyWith<_WheelPlayer> get copyWith => __$WheelPlayerCopyWithImpl<_WheelPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WheelPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WheelPlayer&&(identical(other.key, key) || other.key == key)&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.isStaff, isStaff) || other.isStaff == isStaff)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,id,userId,name,shirtNumber,isGuest,isStaff,avatarUrl);

@override
String toString() {
  return 'WheelPlayer(key: $key, id: $id, userId: $userId, name: $name, shirtNumber: $shirtNumber, isGuest: $isGuest, isStaff: $isStaff, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$WheelPlayerCopyWith<$Res> implements $WheelPlayerCopyWith<$Res> {
  factory _$WheelPlayerCopyWith(_WheelPlayer value, $Res Function(_WheelPlayer) _then) = __$WheelPlayerCopyWithImpl;
@override @useResult
$Res call({
 String key, int? id, int? userId, String name, int? shirtNumber, bool isGuest, bool isStaff, String? avatarUrl
});




}
/// @nodoc
class __$WheelPlayerCopyWithImpl<$Res>
    implements _$WheelPlayerCopyWith<$Res> {
  __$WheelPlayerCopyWithImpl(this._self, this._then);

  final _WheelPlayer _self;
  final $Res Function(_WheelPlayer) _then;

/// Create a copy of WheelPlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? id = freezed,Object? userId = freezed,Object? name = null,Object? shirtNumber = freezed,Object? isGuest = null,Object? isStaff = null,Object? avatarUrl = freezed,}) {
  return _then(_WheelPlayer(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,isStaff: null == isStaff ? _self.isStaff : isStaff // ignore: cast_nullable_to_non_nullable
as bool,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$WheelSpin {

 int get id; String get winnerName; DateTime? get drawnAt; String? get drawnBy;/// Mag deze gebruiker hem verwijderen/koppelen/ontkoppelen.
 bool get canDelete;/// De wedstrijd waar de winnaar als vlagger aan hangt.
 int? get eventId;/// Alleen in de schrijfresponsen.
 int? get winnerPlayerId; int? get winnerUserId;
/// Create a copy of WheelSpin
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelSpinCopyWith<WheelSpin> get copyWith => _$WheelSpinCopyWithImpl<WheelSpin>(this as WheelSpin, _$identity);

  /// Serializes this WheelSpin to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelSpin&&(identical(other.id, id) || other.id == id)&&(identical(other.winnerName, winnerName) || other.winnerName == winnerName)&&(identical(other.drawnAt, drawnAt) || other.drawnAt == drawnAt)&&(identical(other.drawnBy, drawnBy) || other.drawnBy == drawnBy)&&(identical(other.canDelete, canDelete) || other.canDelete == canDelete)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.winnerPlayerId, winnerPlayerId) || other.winnerPlayerId == winnerPlayerId)&&(identical(other.winnerUserId, winnerUserId) || other.winnerUserId == winnerUserId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,winnerName,drawnAt,drawnBy,canDelete,eventId,winnerPlayerId,winnerUserId);

@override
String toString() {
  return 'WheelSpin(id: $id, winnerName: $winnerName, drawnAt: $drawnAt, drawnBy: $drawnBy, canDelete: $canDelete, eventId: $eventId, winnerPlayerId: $winnerPlayerId, winnerUserId: $winnerUserId)';
}


}

/// @nodoc
abstract mixin class $WheelSpinCopyWith<$Res>  {
  factory $WheelSpinCopyWith(WheelSpin value, $Res Function(WheelSpin) _then) = _$WheelSpinCopyWithImpl;
@useResult
$Res call({
 int id, String winnerName, DateTime? drawnAt, String? drawnBy, bool canDelete, int? eventId, int? winnerPlayerId, int? winnerUserId
});




}
/// @nodoc
class _$WheelSpinCopyWithImpl<$Res>
    implements $WheelSpinCopyWith<$Res> {
  _$WheelSpinCopyWithImpl(this._self, this._then);

  final WheelSpin _self;
  final $Res Function(WheelSpin) _then;

/// Create a copy of WheelSpin
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? winnerName = null,Object? drawnAt = freezed,Object? drawnBy = freezed,Object? canDelete = null,Object? eventId = freezed,Object? winnerPlayerId = freezed,Object? winnerUserId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,winnerName: null == winnerName ? _self.winnerName : winnerName // ignore: cast_nullable_to_non_nullable
as String,drawnAt: freezed == drawnAt ? _self.drawnAt : drawnAt // ignore: cast_nullable_to_non_nullable
as DateTime?,drawnBy: freezed == drawnBy ? _self.drawnBy : drawnBy // ignore: cast_nullable_to_non_nullable
as String?,canDelete: null == canDelete ? _self.canDelete : canDelete // ignore: cast_nullable_to_non_nullable
as bool,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,winnerPlayerId: freezed == winnerPlayerId ? _self.winnerPlayerId : winnerPlayerId // ignore: cast_nullable_to_non_nullable
as int?,winnerUserId: freezed == winnerUserId ? _self.winnerUserId : winnerUserId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [WheelSpin].
extension WheelSpinPatterns on WheelSpin {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WheelSpin value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WheelSpin() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WheelSpin value)  $default,){
final _that = this;
switch (_that) {
case _WheelSpin():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WheelSpin value)?  $default,){
final _that = this;
switch (_that) {
case _WheelSpin() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String winnerName,  DateTime? drawnAt,  String? drawnBy,  bool canDelete,  int? eventId,  int? winnerPlayerId,  int? winnerUserId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WheelSpin() when $default != null:
return $default(_that.id,_that.winnerName,_that.drawnAt,_that.drawnBy,_that.canDelete,_that.eventId,_that.winnerPlayerId,_that.winnerUserId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String winnerName,  DateTime? drawnAt,  String? drawnBy,  bool canDelete,  int? eventId,  int? winnerPlayerId,  int? winnerUserId)  $default,) {final _that = this;
switch (_that) {
case _WheelSpin():
return $default(_that.id,_that.winnerName,_that.drawnAt,_that.drawnBy,_that.canDelete,_that.eventId,_that.winnerPlayerId,_that.winnerUserId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String winnerName,  DateTime? drawnAt,  String? drawnBy,  bool canDelete,  int? eventId,  int? winnerPlayerId,  int? winnerUserId)?  $default,) {final _that = this;
switch (_that) {
case _WheelSpin() when $default != null:
return $default(_that.id,_that.winnerName,_that.drawnAt,_that.drawnBy,_that.canDelete,_that.eventId,_that.winnerPlayerId,_that.winnerUserId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WheelSpin implements WheelSpin {
  const _WheelSpin({required this.id, this.winnerName = '', this.drawnAt, this.drawnBy, this.canDelete = false, this.eventId, this.winnerPlayerId, this.winnerUserId});
  factory _WheelSpin.fromJson(Map<String, dynamic> json) => _$WheelSpinFromJson(json);

@override final  int id;
@override@JsonKey() final  String winnerName;
@override final  DateTime? drawnAt;
@override final  String? drawnBy;
/// Mag deze gebruiker hem verwijderen/koppelen/ontkoppelen.
@override@JsonKey() final  bool canDelete;
/// De wedstrijd waar de winnaar als vlagger aan hangt.
@override final  int? eventId;
/// Alleen in de schrijfresponsen.
@override final  int? winnerPlayerId;
@override final  int? winnerUserId;

/// Create a copy of WheelSpin
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WheelSpinCopyWith<_WheelSpin> get copyWith => __$WheelSpinCopyWithImpl<_WheelSpin>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WheelSpinToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WheelSpin&&(identical(other.id, id) || other.id == id)&&(identical(other.winnerName, winnerName) || other.winnerName == winnerName)&&(identical(other.drawnAt, drawnAt) || other.drawnAt == drawnAt)&&(identical(other.drawnBy, drawnBy) || other.drawnBy == drawnBy)&&(identical(other.canDelete, canDelete) || other.canDelete == canDelete)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.winnerPlayerId, winnerPlayerId) || other.winnerPlayerId == winnerPlayerId)&&(identical(other.winnerUserId, winnerUserId) || other.winnerUserId == winnerUserId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,winnerName,drawnAt,drawnBy,canDelete,eventId,winnerPlayerId,winnerUserId);

@override
String toString() {
  return 'WheelSpin(id: $id, winnerName: $winnerName, drawnAt: $drawnAt, drawnBy: $drawnBy, canDelete: $canDelete, eventId: $eventId, winnerPlayerId: $winnerPlayerId, winnerUserId: $winnerUserId)';
}


}

/// @nodoc
abstract mixin class _$WheelSpinCopyWith<$Res> implements $WheelSpinCopyWith<$Res> {
  factory _$WheelSpinCopyWith(_WheelSpin value, $Res Function(_WheelSpin) _then) = __$WheelSpinCopyWithImpl;
@override @useResult
$Res call({
 int id, String winnerName, DateTime? drawnAt, String? drawnBy, bool canDelete, int? eventId, int? winnerPlayerId, int? winnerUserId
});




}
/// @nodoc
class __$WheelSpinCopyWithImpl<$Res>
    implements _$WheelSpinCopyWith<$Res> {
  __$WheelSpinCopyWithImpl(this._self, this._then);

  final _WheelSpin _self;
  final $Res Function(_WheelSpin) _then;

/// Create a copy of WheelSpin
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? winnerName = null,Object? drawnAt = freezed,Object? drawnBy = freezed,Object? canDelete = null,Object? eventId = freezed,Object? winnerPlayerId = freezed,Object? winnerUserId = freezed,}) {
  return _then(_WheelSpin(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,winnerName: null == winnerName ? _self.winnerName : winnerName // ignore: cast_nullable_to_non_nullable
as String,drawnAt: freezed == drawnAt ? _self.drawnAt : drawnAt // ignore: cast_nullable_to_non_nullable
as DateTime?,drawnBy: freezed == drawnBy ? _self.drawnBy : drawnBy // ignore: cast_nullable_to_non_nullable
as String?,canDelete: null == canDelete ? _self.canDelete : canDelete // ignore: cast_nullable_to_non_nullable
as bool,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,winnerPlayerId: freezed == winnerPlayerId ? _self.winnerPlayerId : winnerPlayerId // ignore: cast_nullable_to_non_nullable
as int?,winnerUserId: freezed == winnerUserId ? _self.winnerUserId : winnerUserId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$WheelMatch {

 int get id; String get label;/// Weergavelabel, bv. "12 okt".
 String get date; DateTime? get startsAt;
/// Create a copy of WheelMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelMatchCopyWith<WheelMatch> get copyWith => _$WheelMatchCopyWithImpl<WheelMatch>(this as WheelMatch, _$identity);

  /// Serializes this WheelMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.date, date) || other.date == date)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,date,startsAt);

@override
String toString() {
  return 'WheelMatch(id: $id, label: $label, date: $date, startsAt: $startsAt)';
}


}

/// @nodoc
abstract mixin class $WheelMatchCopyWith<$Res>  {
  factory $WheelMatchCopyWith(WheelMatch value, $Res Function(WheelMatch) _then) = _$WheelMatchCopyWithImpl;
@useResult
$Res call({
 int id, String label, String date, DateTime? startsAt
});




}
/// @nodoc
class _$WheelMatchCopyWithImpl<$Res>
    implements $WheelMatchCopyWith<$Res> {
  _$WheelMatchCopyWithImpl(this._self, this._then);

  final WheelMatch _self;
  final $Res Function(WheelMatch) _then;

/// Create a copy of WheelMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? date = null,Object? startsAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [WheelMatch].
extension WheelMatchPatterns on WheelMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WheelMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WheelMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WheelMatch value)  $default,){
final _that = this;
switch (_that) {
case _WheelMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WheelMatch value)?  $default,){
final _that = this;
switch (_that) {
case _WheelMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String label,  String date,  DateTime? startsAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WheelMatch() when $default != null:
return $default(_that.id,_that.label,_that.date,_that.startsAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String label,  String date,  DateTime? startsAt)  $default,) {final _that = this;
switch (_that) {
case _WheelMatch():
return $default(_that.id,_that.label,_that.date,_that.startsAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String label,  String date,  DateTime? startsAt)?  $default,) {final _that = this;
switch (_that) {
case _WheelMatch() when $default != null:
return $default(_that.id,_that.label,_that.date,_that.startsAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WheelMatch implements WheelMatch {
  const _WheelMatch({required this.id, this.label = '', this.date = '', this.startsAt});
  factory _WheelMatch.fromJson(Map<String, dynamic> json) => _$WheelMatchFromJson(json);

@override final  int id;
@override@JsonKey() final  String label;
/// Weergavelabel, bv. "12 okt".
@override@JsonKey() final  String date;
@override final  DateTime? startsAt;

/// Create a copy of WheelMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WheelMatchCopyWith<_WheelMatch> get copyWith => __$WheelMatchCopyWithImpl<_WheelMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WheelMatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WheelMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.date, date) || other.date == date)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,date,startsAt);

@override
String toString() {
  return 'WheelMatch(id: $id, label: $label, date: $date, startsAt: $startsAt)';
}


}

/// @nodoc
abstract mixin class _$WheelMatchCopyWith<$Res> implements $WheelMatchCopyWith<$Res> {
  factory _$WheelMatchCopyWith(_WheelMatch value, $Res Function(_WheelMatch) _then) = __$WheelMatchCopyWithImpl;
@override @useResult
$Res call({
 int id, String label, String date, DateTime? startsAt
});




}
/// @nodoc
class __$WheelMatchCopyWithImpl<$Res>
    implements _$WheelMatchCopyWith<$Res> {
  __$WheelMatchCopyWithImpl(this._self, this._then);

  final _WheelMatch _self;
  final $Res Function(_WheelMatch) _then;

/// Create a copy of WheelMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? date = null,Object? startsAt = freezed,}) {
  return _then(_WheelMatch(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$WheelPreset {

 String get label; String get date;/// Speler-id's.
 List<int> get presentIds;/// User-id's van pure staf.
 List<int> get presentStaffIds;/// Aanwezig maar niet in de opstelling (speler-id's).
 List<int> get benchIds;
/// Create a copy of WheelPreset
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelPresetCopyWith<WheelPreset> get copyWith => _$WheelPresetCopyWithImpl<WheelPreset>(this as WheelPreset, _$identity);

  /// Serializes this WheelPreset to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelPreset&&(identical(other.label, label) || other.label == label)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.presentIds, presentIds)&&const DeepCollectionEquality().equals(other.presentStaffIds, presentStaffIds)&&const DeepCollectionEquality().equals(other.benchIds, benchIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,date,const DeepCollectionEquality().hash(presentIds),const DeepCollectionEquality().hash(presentStaffIds),const DeepCollectionEquality().hash(benchIds));

@override
String toString() {
  return 'WheelPreset(label: $label, date: $date, presentIds: $presentIds, presentStaffIds: $presentStaffIds, benchIds: $benchIds)';
}


}

/// @nodoc
abstract mixin class $WheelPresetCopyWith<$Res>  {
  factory $WheelPresetCopyWith(WheelPreset value, $Res Function(WheelPreset) _then) = _$WheelPresetCopyWithImpl;
@useResult
$Res call({
 String label, String date, List<int> presentIds, List<int> presentStaffIds, List<int> benchIds
});




}
/// @nodoc
class _$WheelPresetCopyWithImpl<$Res>
    implements $WheelPresetCopyWith<$Res> {
  _$WheelPresetCopyWithImpl(this._self, this._then);

  final WheelPreset _self;
  final $Res Function(WheelPreset) _then;

/// Create a copy of WheelPreset
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? date = null,Object? presentIds = null,Object? presentStaffIds = null,Object? benchIds = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,presentIds: null == presentIds ? _self.presentIds : presentIds // ignore: cast_nullable_to_non_nullable
as List<int>,presentStaffIds: null == presentStaffIds ? _self.presentStaffIds : presentStaffIds // ignore: cast_nullable_to_non_nullable
as List<int>,benchIds: null == benchIds ? _self.benchIds : benchIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [WheelPreset].
extension WheelPresetPatterns on WheelPreset {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WheelPreset value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WheelPreset() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WheelPreset value)  $default,){
final _that = this;
switch (_that) {
case _WheelPreset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WheelPreset value)?  $default,){
final _that = this;
switch (_that) {
case _WheelPreset() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  String date,  List<int> presentIds,  List<int> presentStaffIds,  List<int> benchIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WheelPreset() when $default != null:
return $default(_that.label,_that.date,_that.presentIds,_that.presentStaffIds,_that.benchIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  String date,  List<int> presentIds,  List<int> presentStaffIds,  List<int> benchIds)  $default,) {final _that = this;
switch (_that) {
case _WheelPreset():
return $default(_that.label,_that.date,_that.presentIds,_that.presentStaffIds,_that.benchIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  String date,  List<int> presentIds,  List<int> presentStaffIds,  List<int> benchIds)?  $default,) {final _that = this;
switch (_that) {
case _WheelPreset() when $default != null:
return $default(_that.label,_that.date,_that.presentIds,_that.presentStaffIds,_that.benchIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WheelPreset implements WheelPreset {
  const _WheelPreset({this.label = '', this.date = '', final  List<int> presentIds = const <int>[], final  List<int> presentStaffIds = const <int>[], final  List<int> benchIds = const <int>[]}): _presentIds = presentIds,_presentStaffIds = presentStaffIds,_benchIds = benchIds;
  factory _WheelPreset.fromJson(Map<String, dynamic> json) => _$WheelPresetFromJson(json);

@override@JsonKey() final  String label;
@override@JsonKey() final  String date;
/// Speler-id's.
 final  List<int> _presentIds;
/// Speler-id's.
@override@JsonKey() List<int> get presentIds {
  if (_presentIds is EqualUnmodifiableListView) return _presentIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_presentIds);
}

/// User-id's van pure staf.
 final  List<int> _presentStaffIds;
/// User-id's van pure staf.
@override@JsonKey() List<int> get presentStaffIds {
  if (_presentStaffIds is EqualUnmodifiableListView) return _presentStaffIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_presentStaffIds);
}

/// Aanwezig maar niet in de opstelling (speler-id's).
 final  List<int> _benchIds;
/// Aanwezig maar niet in de opstelling (speler-id's).
@override@JsonKey() List<int> get benchIds {
  if (_benchIds is EqualUnmodifiableListView) return _benchIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_benchIds);
}


/// Create a copy of WheelPreset
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WheelPresetCopyWith<_WheelPreset> get copyWith => __$WheelPresetCopyWithImpl<_WheelPreset>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WheelPresetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WheelPreset&&(identical(other.label, label) || other.label == label)&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._presentIds, _presentIds)&&const DeepCollectionEquality().equals(other._presentStaffIds, _presentStaffIds)&&const DeepCollectionEquality().equals(other._benchIds, _benchIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,date,const DeepCollectionEquality().hash(_presentIds),const DeepCollectionEquality().hash(_presentStaffIds),const DeepCollectionEquality().hash(_benchIds));

@override
String toString() {
  return 'WheelPreset(label: $label, date: $date, presentIds: $presentIds, presentStaffIds: $presentStaffIds, benchIds: $benchIds)';
}


}

/// @nodoc
abstract mixin class _$WheelPresetCopyWith<$Res> implements $WheelPresetCopyWith<$Res> {
  factory _$WheelPresetCopyWith(_WheelPreset value, $Res Function(_WheelPreset) _then) = __$WheelPresetCopyWithImpl;
@override @useResult
$Res call({
 String label, String date, List<int> presentIds, List<int> presentStaffIds, List<int> benchIds
});




}
/// @nodoc
class __$WheelPresetCopyWithImpl<$Res>
    implements _$WheelPresetCopyWith<$Res> {
  __$WheelPresetCopyWithImpl(this._self, this._then);

  final _WheelPreset _self;
  final $Res Function(_WheelPreset) _then;

/// Create a copy of WheelPreset
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? date = null,Object? presentIds = null,Object? presentStaffIds = null,Object? benchIds = null,}) {
  return _then(_WheelPreset(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,presentIds: null == presentIds ? _self._presentIds : presentIds // ignore: cast_nullable_to_non_nullable
as List<int>,presentStaffIds: null == presentStaffIds ? _self._presentStaffIds : presentStaffIds // ignore: cast_nullable_to_non_nullable
as List<int>,benchIds: null == benchIds ? _self._benchIds : benchIds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}


/// @nodoc
mixin _$WheelOverview {

 List<WheelPlayer> get players; List<WheelSpin> get recentSpins; WheelMatch? get upcomingMatch; WheelPreset? get preset;
/// Create a copy of WheelOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WheelOverviewCopyWith<WheelOverview> get copyWith => _$WheelOverviewCopyWithImpl<WheelOverview>(this as WheelOverview, _$identity);

  /// Serializes this WheelOverview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WheelOverview&&const DeepCollectionEquality().equals(other.players, players)&&const DeepCollectionEquality().equals(other.recentSpins, recentSpins)&&(identical(other.upcomingMatch, upcomingMatch) || other.upcomingMatch == upcomingMatch)&&(identical(other.preset, preset) || other.preset == preset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(players),const DeepCollectionEquality().hash(recentSpins),upcomingMatch,preset);

@override
String toString() {
  return 'WheelOverview(players: $players, recentSpins: $recentSpins, upcomingMatch: $upcomingMatch, preset: $preset)';
}


}

/// @nodoc
abstract mixin class $WheelOverviewCopyWith<$Res>  {
  factory $WheelOverviewCopyWith(WheelOverview value, $Res Function(WheelOverview) _then) = _$WheelOverviewCopyWithImpl;
@useResult
$Res call({
 List<WheelPlayer> players, List<WheelSpin> recentSpins, WheelMatch? upcomingMatch, WheelPreset? preset
});


$WheelMatchCopyWith<$Res>? get upcomingMatch;$WheelPresetCopyWith<$Res>? get preset;

}
/// @nodoc
class _$WheelOverviewCopyWithImpl<$Res>
    implements $WheelOverviewCopyWith<$Res> {
  _$WheelOverviewCopyWithImpl(this._self, this._then);

  final WheelOverview _self;
  final $Res Function(WheelOverview) _then;

/// Create a copy of WheelOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? players = null,Object? recentSpins = null,Object? upcomingMatch = freezed,Object? preset = freezed,}) {
  return _then(_self.copyWith(
players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<WheelPlayer>,recentSpins: null == recentSpins ? _self.recentSpins : recentSpins // ignore: cast_nullable_to_non_nullable
as List<WheelSpin>,upcomingMatch: freezed == upcomingMatch ? _self.upcomingMatch : upcomingMatch // ignore: cast_nullable_to_non_nullable
as WheelMatch?,preset: freezed == preset ? _self.preset : preset // ignore: cast_nullable_to_non_nullable
as WheelPreset?,
  ));
}
/// Create a copy of WheelOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WheelMatchCopyWith<$Res>? get upcomingMatch {
    if (_self.upcomingMatch == null) {
    return null;
  }

  return $WheelMatchCopyWith<$Res>(_self.upcomingMatch!, (value) {
    return _then(_self.copyWith(upcomingMatch: value));
  });
}/// Create a copy of WheelOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WheelPresetCopyWith<$Res>? get preset {
    if (_self.preset == null) {
    return null;
  }

  return $WheelPresetCopyWith<$Res>(_self.preset!, (value) {
    return _then(_self.copyWith(preset: value));
  });
}
}


/// Adds pattern-matching-related methods to [WheelOverview].
extension WheelOverviewPatterns on WheelOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WheelOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WheelOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WheelOverview value)  $default,){
final _that = this;
switch (_that) {
case _WheelOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WheelOverview value)?  $default,){
final _that = this;
switch (_that) {
case _WheelOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<WheelPlayer> players,  List<WheelSpin> recentSpins,  WheelMatch? upcomingMatch,  WheelPreset? preset)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WheelOverview() when $default != null:
return $default(_that.players,_that.recentSpins,_that.upcomingMatch,_that.preset);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<WheelPlayer> players,  List<WheelSpin> recentSpins,  WheelMatch? upcomingMatch,  WheelPreset? preset)  $default,) {final _that = this;
switch (_that) {
case _WheelOverview():
return $default(_that.players,_that.recentSpins,_that.upcomingMatch,_that.preset);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<WheelPlayer> players,  List<WheelSpin> recentSpins,  WheelMatch? upcomingMatch,  WheelPreset? preset)?  $default,) {final _that = this;
switch (_that) {
case _WheelOverview() when $default != null:
return $default(_that.players,_that.recentSpins,_that.upcomingMatch,_that.preset);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WheelOverview implements WheelOverview {
  const _WheelOverview({final  List<WheelPlayer> players = const <WheelPlayer>[], final  List<WheelSpin> recentSpins = const <WheelSpin>[], this.upcomingMatch, this.preset}): _players = players,_recentSpins = recentSpins;
  factory _WheelOverview.fromJson(Map<String, dynamic> json) => _$WheelOverviewFromJson(json);

 final  List<WheelPlayer> _players;
@override@JsonKey() List<WheelPlayer> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}

 final  List<WheelSpin> _recentSpins;
@override@JsonKey() List<WheelSpin> get recentSpins {
  if (_recentSpins is EqualUnmodifiableListView) return _recentSpins;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentSpins);
}

@override final  WheelMatch? upcomingMatch;
@override final  WheelPreset? preset;

/// Create a copy of WheelOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WheelOverviewCopyWith<_WheelOverview> get copyWith => __$WheelOverviewCopyWithImpl<_WheelOverview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WheelOverviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WheelOverview&&const DeepCollectionEquality().equals(other._players, _players)&&const DeepCollectionEquality().equals(other._recentSpins, _recentSpins)&&(identical(other.upcomingMatch, upcomingMatch) || other.upcomingMatch == upcomingMatch)&&(identical(other.preset, preset) || other.preset == preset));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_players),const DeepCollectionEquality().hash(_recentSpins),upcomingMatch,preset);

@override
String toString() {
  return 'WheelOverview(players: $players, recentSpins: $recentSpins, upcomingMatch: $upcomingMatch, preset: $preset)';
}


}

/// @nodoc
abstract mixin class _$WheelOverviewCopyWith<$Res> implements $WheelOverviewCopyWith<$Res> {
  factory _$WheelOverviewCopyWith(_WheelOverview value, $Res Function(_WheelOverview) _then) = __$WheelOverviewCopyWithImpl;
@override @useResult
$Res call({
 List<WheelPlayer> players, List<WheelSpin> recentSpins, WheelMatch? upcomingMatch, WheelPreset? preset
});


@override $WheelMatchCopyWith<$Res>? get upcomingMatch;@override $WheelPresetCopyWith<$Res>? get preset;

}
/// @nodoc
class __$WheelOverviewCopyWithImpl<$Res>
    implements _$WheelOverviewCopyWith<$Res> {
  __$WheelOverviewCopyWithImpl(this._self, this._then);

  final _WheelOverview _self;
  final $Res Function(_WheelOverview) _then;

/// Create a copy of WheelOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? players = null,Object? recentSpins = null,Object? upcomingMatch = freezed,Object? preset = freezed,}) {
  return _then(_WheelOverview(
players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<WheelPlayer>,recentSpins: null == recentSpins ? _self._recentSpins : recentSpins // ignore: cast_nullable_to_non_nullable
as List<WheelSpin>,upcomingMatch: freezed == upcomingMatch ? _self.upcomingMatch : upcomingMatch // ignore: cast_nullable_to_non_nullable
as WheelMatch?,preset: freezed == preset ? _self.preset : preset // ignore: cast_nullable_to_non_nullable
as WheelPreset?,
  ));
}

/// Create a copy of WheelOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WheelMatchCopyWith<$Res>? get upcomingMatch {
    if (_self.upcomingMatch == null) {
    return null;
  }

  return $WheelMatchCopyWith<$Res>(_self.upcomingMatch!, (value) {
    return _then(_self.copyWith(upcomingMatch: value));
  });
}/// Create a copy of WheelOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WheelPresetCopyWith<$Res>? get preset {
    if (_self.preset == null) {
    return null;
  }

  return $WheelPresetCopyWith<$Res>(_self.preset!, (value) {
    return _then(_self.copyWith(preset: value));
  });
}
}

// dart format on
