// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_detail_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SportlinkInfo {

 String? get field; String? get dressingRoom; String? get referee;
/// Create a copy of SportlinkInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SportlinkInfoCopyWith<SportlinkInfo> get copyWith => _$SportlinkInfoCopyWithImpl<SportlinkInfo>(this as SportlinkInfo, _$identity);

  /// Serializes this SportlinkInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SportlinkInfo&&(identical(other.field, field) || other.field == field)&&(identical(other.dressingRoom, dressingRoom) || other.dressingRoom == dressingRoom)&&(identical(other.referee, referee) || other.referee == referee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field,dressingRoom,referee);

@override
String toString() {
  return 'SportlinkInfo(field: $field, dressingRoom: $dressingRoom, referee: $referee)';
}


}

/// @nodoc
abstract mixin class $SportlinkInfoCopyWith<$Res>  {
  factory $SportlinkInfoCopyWith(SportlinkInfo value, $Res Function(SportlinkInfo) _then) = _$SportlinkInfoCopyWithImpl;
@useResult
$Res call({
 String? field, String? dressingRoom, String? referee
});




}
/// @nodoc
class _$SportlinkInfoCopyWithImpl<$Res>
    implements $SportlinkInfoCopyWith<$Res> {
  _$SportlinkInfoCopyWithImpl(this._self, this._then);

  final SportlinkInfo _self;
  final $Res Function(SportlinkInfo) _then;

/// Create a copy of SportlinkInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? field = freezed,Object? dressingRoom = freezed,Object? referee = freezed,}) {
  return _then(_self.copyWith(
field: freezed == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String?,dressingRoom: freezed == dressingRoom ? _self.dressingRoom : dressingRoom // ignore: cast_nullable_to_non_nullable
as String?,referee: freezed == referee ? _self.referee : referee // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SportlinkInfo].
extension SportlinkInfoPatterns on SportlinkInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SportlinkInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SportlinkInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SportlinkInfo value)  $default,){
final _that = this;
switch (_that) {
case _SportlinkInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SportlinkInfo value)?  $default,){
final _that = this;
switch (_that) {
case _SportlinkInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? field,  String? dressingRoom,  String? referee)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SportlinkInfo() when $default != null:
return $default(_that.field,_that.dressingRoom,_that.referee);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? field,  String? dressingRoom,  String? referee)  $default,) {final _that = this;
switch (_that) {
case _SportlinkInfo():
return $default(_that.field,_that.dressingRoom,_that.referee);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? field,  String? dressingRoom,  String? referee)?  $default,) {final _that = this;
switch (_that) {
case _SportlinkInfo() when $default != null:
return $default(_that.field,_that.dressingRoom,_that.referee);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SportlinkInfo extends SportlinkInfo {
  const _SportlinkInfo({this.field, this.dressingRoom, this.referee}): super._();
  factory _SportlinkInfo.fromJson(Map<String, dynamic> json) => _$SportlinkInfoFromJson(json);

@override final  String? field;
@override final  String? dressingRoom;
@override final  String? referee;

/// Create a copy of SportlinkInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SportlinkInfoCopyWith<_SportlinkInfo> get copyWith => __$SportlinkInfoCopyWithImpl<_SportlinkInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SportlinkInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SportlinkInfo&&(identical(other.field, field) || other.field == field)&&(identical(other.dressingRoom, dressingRoom) || other.dressingRoom == dressingRoom)&&(identical(other.referee, referee) || other.referee == referee));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,field,dressingRoom,referee);

@override
String toString() {
  return 'SportlinkInfo(field: $field, dressingRoom: $dressingRoom, referee: $referee)';
}


}

/// @nodoc
abstract mixin class _$SportlinkInfoCopyWith<$Res> implements $SportlinkInfoCopyWith<$Res> {
  factory _$SportlinkInfoCopyWith(_SportlinkInfo value, $Res Function(_SportlinkInfo) _then) = __$SportlinkInfoCopyWithImpl;
@override @useResult
$Res call({
 String? field, String? dressingRoom, String? referee
});




}
/// @nodoc
class __$SportlinkInfoCopyWithImpl<$Res>
    implements _$SportlinkInfoCopyWith<$Res> {
  __$SportlinkInfoCopyWithImpl(this._self, this._then);

  final _SportlinkInfo _self;
  final $Res Function(_SportlinkInfo) _then;

/// Create a copy of SportlinkInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? field = freezed,Object? dressingRoom = freezed,Object? referee = freezed,}) {
  return _then(_SportlinkInfo(
field: freezed == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String?,dressingRoom: freezed == dressingRoom ? _self.dressingRoom : dressingRoom // ignore: cast_nullable_to_non_nullable
as String?,referee: freezed == referee ? _self.referee : referee // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EventPlayer {

 int get id;@JsonKey(unknownEnumValue: EventPlayerKind.unknown) EventPlayerKind get kind; String? get rowKey; String get name; String? get avatarUrl; int? get shirtNumber; bool get isGuest; bool get isInjured; bool get isOnVacation;@JsonKey(unknownEnumValue: AttendanceStatus.pending) AttendanceStatus get status; String? get reason; bool get isMe; bool get isCaptain; bool get isKeeper;
/// Create a copy of EventPlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventPlayerCopyWith<EventPlayer> get copyWith => _$EventPlayerCopyWithImpl<EventPlayer>(this as EventPlayer, _$identity);

  /// Serializes this EventPlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.rowKey, rowKey) || other.rowKey == rowKey)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.isInjured, isInjured) || other.isInjured == isInjured)&&(identical(other.isOnVacation, isOnVacation) || other.isOnVacation == isOnVacation)&&(identical(other.status, status) || other.status == status)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.isMe, isMe) || other.isMe == isMe)&&(identical(other.isCaptain, isCaptain) || other.isCaptain == isCaptain)&&(identical(other.isKeeper, isKeeper) || other.isKeeper == isKeeper));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,kind,rowKey,name,avatarUrl,shirtNumber,isGuest,isInjured,isOnVacation,status,reason,isMe,isCaptain,isKeeper);

@override
String toString() {
  return 'EventPlayer(id: $id, kind: $kind, rowKey: $rowKey, name: $name, avatarUrl: $avatarUrl, shirtNumber: $shirtNumber, isGuest: $isGuest, isInjured: $isInjured, isOnVacation: $isOnVacation, status: $status, reason: $reason, isMe: $isMe, isCaptain: $isCaptain, isKeeper: $isKeeper)';
}


}

/// @nodoc
abstract mixin class $EventPlayerCopyWith<$Res>  {
  factory $EventPlayerCopyWith(EventPlayer value, $Res Function(EventPlayer) _then) = _$EventPlayerCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(unknownEnumValue: EventPlayerKind.unknown) EventPlayerKind kind, String? rowKey, String name, String? avatarUrl, int? shirtNumber, bool isGuest, bool isInjured, bool isOnVacation,@JsonKey(unknownEnumValue: AttendanceStatus.pending) AttendanceStatus status, String? reason, bool isMe, bool isCaptain, bool isKeeper
});




}
/// @nodoc
class _$EventPlayerCopyWithImpl<$Res>
    implements $EventPlayerCopyWith<$Res> {
  _$EventPlayerCopyWithImpl(this._self, this._then);

  final EventPlayer _self;
  final $Res Function(EventPlayer) _then;

/// Create a copy of EventPlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = null,Object? rowKey = freezed,Object? name = null,Object? avatarUrl = freezed,Object? shirtNumber = freezed,Object? isGuest = null,Object? isInjured = null,Object? isOnVacation = null,Object? status = null,Object? reason = freezed,Object? isMe = null,Object? isCaptain = null,Object? isKeeper = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as EventPlayerKind,rowKey: freezed == rowKey ? _self.rowKey : rowKey // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,isInjured: null == isInjured ? _self.isInjured : isInjured // ignore: cast_nullable_to_non_nullable
as bool,isOnVacation: null == isOnVacation ? _self.isOnVacation : isOnVacation // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttendanceStatus,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,isMe: null == isMe ? _self.isMe : isMe // ignore: cast_nullable_to_non_nullable
as bool,isCaptain: null == isCaptain ? _self.isCaptain : isCaptain // ignore: cast_nullable_to_non_nullable
as bool,isKeeper: null == isKeeper ? _self.isKeeper : isKeeper // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [EventPlayer].
extension EventPlayerPatterns on EventPlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventPlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventPlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventPlayer value)  $default,){
final _that = this;
switch (_that) {
case _EventPlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventPlayer value)?  $default,){
final _that = this;
switch (_that) {
case _EventPlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(unknownEnumValue: EventPlayerKind.unknown)  EventPlayerKind kind,  String? rowKey,  String name,  String? avatarUrl,  int? shirtNumber,  bool isGuest,  bool isInjured,  bool isOnVacation, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  AttendanceStatus status,  String? reason,  bool isMe,  bool isCaptain,  bool isKeeper)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventPlayer() when $default != null:
return $default(_that.id,_that.kind,_that.rowKey,_that.name,_that.avatarUrl,_that.shirtNumber,_that.isGuest,_that.isInjured,_that.isOnVacation,_that.status,_that.reason,_that.isMe,_that.isCaptain,_that.isKeeper);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(unknownEnumValue: EventPlayerKind.unknown)  EventPlayerKind kind,  String? rowKey,  String name,  String? avatarUrl,  int? shirtNumber,  bool isGuest,  bool isInjured,  bool isOnVacation, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  AttendanceStatus status,  String? reason,  bool isMe,  bool isCaptain,  bool isKeeper)  $default,) {final _that = this;
switch (_that) {
case _EventPlayer():
return $default(_that.id,_that.kind,_that.rowKey,_that.name,_that.avatarUrl,_that.shirtNumber,_that.isGuest,_that.isInjured,_that.isOnVacation,_that.status,_that.reason,_that.isMe,_that.isCaptain,_that.isKeeper);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(unknownEnumValue: EventPlayerKind.unknown)  EventPlayerKind kind,  String? rowKey,  String name,  String? avatarUrl,  int? shirtNumber,  bool isGuest,  bool isInjured,  bool isOnVacation, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  AttendanceStatus status,  String? reason,  bool isMe,  bool isCaptain,  bool isKeeper)?  $default,) {final _that = this;
switch (_that) {
case _EventPlayer() when $default != null:
return $default(_that.id,_that.kind,_that.rowKey,_that.name,_that.avatarUrl,_that.shirtNumber,_that.isGuest,_that.isInjured,_that.isOnVacation,_that.status,_that.reason,_that.isMe,_that.isCaptain,_that.isKeeper);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventPlayer implements EventPlayer {
  const _EventPlayer({required this.id, @JsonKey(unknownEnumValue: EventPlayerKind.unknown) this.kind = EventPlayerKind.player, this.rowKey, this.name = '', this.avatarUrl, this.shirtNumber, this.isGuest = false, this.isInjured = false, this.isOnVacation = false, @JsonKey(unknownEnumValue: AttendanceStatus.pending) this.status = AttendanceStatus.pending, this.reason, this.isMe = false, this.isCaptain = false, this.isKeeper = false});
  factory _EventPlayer.fromJson(Map<String, dynamic> json) => _$EventPlayerFromJson(json);

@override final  int id;
@override@JsonKey(unknownEnumValue: EventPlayerKind.unknown) final  EventPlayerKind kind;
@override final  String? rowKey;
@override@JsonKey() final  String name;
@override final  String? avatarUrl;
@override final  int? shirtNumber;
@override@JsonKey() final  bool isGuest;
@override@JsonKey() final  bool isInjured;
@override@JsonKey() final  bool isOnVacation;
@override@JsonKey(unknownEnumValue: AttendanceStatus.pending) final  AttendanceStatus status;
@override final  String? reason;
@override@JsonKey() final  bool isMe;
@override@JsonKey() final  bool isCaptain;
@override@JsonKey() final  bool isKeeper;

/// Create a copy of EventPlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventPlayerCopyWith<_EventPlayer> get copyWith => __$EventPlayerCopyWithImpl<_EventPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.rowKey, rowKey) || other.rowKey == rowKey)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.isInjured, isInjured) || other.isInjured == isInjured)&&(identical(other.isOnVacation, isOnVacation) || other.isOnVacation == isOnVacation)&&(identical(other.status, status) || other.status == status)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.isMe, isMe) || other.isMe == isMe)&&(identical(other.isCaptain, isCaptain) || other.isCaptain == isCaptain)&&(identical(other.isKeeper, isKeeper) || other.isKeeper == isKeeper));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,kind,rowKey,name,avatarUrl,shirtNumber,isGuest,isInjured,isOnVacation,status,reason,isMe,isCaptain,isKeeper);

@override
String toString() {
  return 'EventPlayer(id: $id, kind: $kind, rowKey: $rowKey, name: $name, avatarUrl: $avatarUrl, shirtNumber: $shirtNumber, isGuest: $isGuest, isInjured: $isInjured, isOnVacation: $isOnVacation, status: $status, reason: $reason, isMe: $isMe, isCaptain: $isCaptain, isKeeper: $isKeeper)';
}


}

/// @nodoc
abstract mixin class _$EventPlayerCopyWith<$Res> implements $EventPlayerCopyWith<$Res> {
  factory _$EventPlayerCopyWith(_EventPlayer value, $Res Function(_EventPlayer) _then) = __$EventPlayerCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(unknownEnumValue: EventPlayerKind.unknown) EventPlayerKind kind, String? rowKey, String name, String? avatarUrl, int? shirtNumber, bool isGuest, bool isInjured, bool isOnVacation,@JsonKey(unknownEnumValue: AttendanceStatus.pending) AttendanceStatus status, String? reason, bool isMe, bool isCaptain, bool isKeeper
});




}
/// @nodoc
class __$EventPlayerCopyWithImpl<$Res>
    implements _$EventPlayerCopyWith<$Res> {
  __$EventPlayerCopyWithImpl(this._self, this._then);

  final _EventPlayer _self;
  final $Res Function(_EventPlayer) _then;

/// Create a copy of EventPlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = null,Object? rowKey = freezed,Object? name = null,Object? avatarUrl = freezed,Object? shirtNumber = freezed,Object? isGuest = null,Object? isInjured = null,Object? isOnVacation = null,Object? status = null,Object? reason = freezed,Object? isMe = null,Object? isCaptain = null,Object? isKeeper = null,}) {
  return _then(_EventPlayer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as EventPlayerKind,rowKey: freezed == rowKey ? _self.rowKey : rowKey // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,isInjured: null == isInjured ? _self.isInjured : isInjured // ignore: cast_nullable_to_non_nullable
as bool,isOnVacation: null == isOnVacation ? _self.isOnVacation : isOnVacation // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttendanceStatus,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,isMe: null == isMe ? _self.isMe : isMe // ignore: cast_nullable_to_non_nullable
as bool,isCaptain: null == isCaptain ? _self.isCaptain : isCaptain // ignore: cast_nullable_to_non_nullable
as bool,isKeeper: null == isKeeper ? _self.isKeeper : isKeeper // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$MotmCandidate {

 int get id; String get name; int? get shirtNumber; String? get avatarUrl;
/// Create a copy of MotmCandidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MotmCandidateCopyWith<MotmCandidate> get copyWith => _$MotmCandidateCopyWithImpl<MotmCandidate>(this as MotmCandidate, _$identity);

  /// Serializes this MotmCandidate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MotmCandidate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber,avatarUrl);

@override
String toString() {
  return 'MotmCandidate(id: $id, name: $name, shirtNumber: $shirtNumber, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $MotmCandidateCopyWith<$Res>  {
  factory $MotmCandidateCopyWith(MotmCandidate value, $Res Function(MotmCandidate) _then) = _$MotmCandidateCopyWithImpl;
@useResult
$Res call({
 int id, String name, int? shirtNumber, String? avatarUrl
});




}
/// @nodoc
class _$MotmCandidateCopyWithImpl<$Res>
    implements $MotmCandidateCopyWith<$Res> {
  _$MotmCandidateCopyWithImpl(this._self, this._then);

  final MotmCandidate _self;
  final $Res Function(MotmCandidate) _then;

/// Create a copy of MotmCandidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MotmCandidate].
extension MotmCandidatePatterns on MotmCandidate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MotmCandidate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MotmCandidate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MotmCandidate value)  $default,){
final _that = this;
switch (_that) {
case _MotmCandidate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MotmCandidate value)?  $default,){
final _that = this;
switch (_that) {
case _MotmCandidate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int? shirtNumber,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MotmCandidate() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int? shirtNumber,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _MotmCandidate():
return $default(_that.id,_that.name,_that.shirtNumber,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int? shirtNumber,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _MotmCandidate() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MotmCandidate implements MotmCandidate {
  const _MotmCandidate({required this.id, this.name = '', this.shirtNumber, this.avatarUrl});
  factory _MotmCandidate.fromJson(Map<String, dynamic> json) => _$MotmCandidateFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  int? shirtNumber;
@override final  String? avatarUrl;

/// Create a copy of MotmCandidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MotmCandidateCopyWith<_MotmCandidate> get copyWith => __$MotmCandidateCopyWithImpl<_MotmCandidate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MotmCandidateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MotmCandidate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber,avatarUrl);

@override
String toString() {
  return 'MotmCandidate(id: $id, name: $name, shirtNumber: $shirtNumber, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$MotmCandidateCopyWith<$Res> implements $MotmCandidateCopyWith<$Res> {
  factory _$MotmCandidateCopyWith(_MotmCandidate value, $Res Function(_MotmCandidate) _then) = __$MotmCandidateCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int? shirtNumber, String? avatarUrl
});




}
/// @nodoc
class __$MotmCandidateCopyWithImpl<$Res>
    implements _$MotmCandidateCopyWith<$Res> {
  __$MotmCandidateCopyWithImpl(this._self, this._then);

  final _MotmCandidate _self;
  final $Res Function(_MotmCandidate) _then;

/// Create a copy of MotmCandidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,Object? avatarUrl = freezed,}) {
  return _then(_MotmCandidate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$MotmTally {

 int get playerId; int get votes;
/// Create a copy of MotmTally
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MotmTallyCopyWith<MotmTally> get copyWith => _$MotmTallyCopyWithImpl<MotmTally>(this as MotmTally, _$identity);

  /// Serializes this MotmTally to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MotmTally&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.votes, votes) || other.votes == votes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,votes);

@override
String toString() {
  return 'MotmTally(playerId: $playerId, votes: $votes)';
}


}

/// @nodoc
abstract mixin class $MotmTallyCopyWith<$Res>  {
  factory $MotmTallyCopyWith(MotmTally value, $Res Function(MotmTally) _then) = _$MotmTallyCopyWithImpl;
@useResult
$Res call({
 int playerId, int votes
});




}
/// @nodoc
class _$MotmTallyCopyWithImpl<$Res>
    implements $MotmTallyCopyWith<$Res> {
  _$MotmTallyCopyWithImpl(this._self, this._then);

  final MotmTally _self;
  final $Res Function(MotmTally) _then;

/// Create a copy of MotmTally
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? votes = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int,votes: null == votes ? _self.votes : votes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MotmTally].
extension MotmTallyPatterns on MotmTally {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MotmTally value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MotmTally() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MotmTally value)  $default,){
final _that = this;
switch (_that) {
case _MotmTally():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MotmTally value)?  $default,){
final _that = this;
switch (_that) {
case _MotmTally() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int playerId,  int votes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MotmTally() when $default != null:
return $default(_that.playerId,_that.votes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int playerId,  int votes)  $default,) {final _that = this;
switch (_that) {
case _MotmTally():
return $default(_that.playerId,_that.votes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int playerId,  int votes)?  $default,) {final _that = this;
switch (_that) {
case _MotmTally() when $default != null:
return $default(_that.playerId,_that.votes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MotmTally implements MotmTally {
  const _MotmTally({required this.playerId, this.votes = 0});
  factory _MotmTally.fromJson(Map<String, dynamic> json) => _$MotmTallyFromJson(json);

@override final  int playerId;
@override@JsonKey() final  int votes;

/// Create a copy of MotmTally
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MotmTallyCopyWith<_MotmTally> get copyWith => __$MotmTallyCopyWithImpl<_MotmTally>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MotmTallyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MotmTally&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.votes, votes) || other.votes == votes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,votes);

@override
String toString() {
  return 'MotmTally(playerId: $playerId, votes: $votes)';
}


}

/// @nodoc
abstract mixin class _$MotmTallyCopyWith<$Res> implements $MotmTallyCopyWith<$Res> {
  factory _$MotmTallyCopyWith(_MotmTally value, $Res Function(_MotmTally) _then) = __$MotmTallyCopyWithImpl;
@override @useResult
$Res call({
 int playerId, int votes
});




}
/// @nodoc
class __$MotmTallyCopyWithImpl<$Res>
    implements _$MotmTallyCopyWith<$Res> {
  __$MotmTallyCopyWithImpl(this._self, this._then);

  final _MotmTally _self;
  final $Res Function(_MotmTally) _then;

/// Create a copy of MotmTally
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? votes = null,}) {
  return _then(_MotmTally(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int,votes: null == votes ? _self.votes : votes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MotmState {

 bool get isOpen; bool get opensAfter; DateTime? get closesAt; List<MotmCandidate> get eligible; List<MotmTally> get tally; int? get myVote; bool get canVote; int? get selfId;
/// Create a copy of MotmState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MotmStateCopyWith<MotmState> get copyWith => _$MotmStateCopyWithImpl<MotmState>(this as MotmState, _$identity);

  /// Serializes this MotmState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MotmState&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.opensAfter, opensAfter) || other.opensAfter == opensAfter)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt)&&const DeepCollectionEquality().equals(other.eligible, eligible)&&const DeepCollectionEquality().equals(other.tally, tally)&&(identical(other.myVote, myVote) || other.myVote == myVote)&&(identical(other.canVote, canVote) || other.canVote == canVote)&&(identical(other.selfId, selfId) || other.selfId == selfId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isOpen,opensAfter,closesAt,const DeepCollectionEquality().hash(eligible),const DeepCollectionEquality().hash(tally),myVote,canVote,selfId);

@override
String toString() {
  return 'MotmState(isOpen: $isOpen, opensAfter: $opensAfter, closesAt: $closesAt, eligible: $eligible, tally: $tally, myVote: $myVote, canVote: $canVote, selfId: $selfId)';
}


}

/// @nodoc
abstract mixin class $MotmStateCopyWith<$Res>  {
  factory $MotmStateCopyWith(MotmState value, $Res Function(MotmState) _then) = _$MotmStateCopyWithImpl;
@useResult
$Res call({
 bool isOpen, bool opensAfter, DateTime? closesAt, List<MotmCandidate> eligible, List<MotmTally> tally, int? myVote, bool canVote, int? selfId
});




}
/// @nodoc
class _$MotmStateCopyWithImpl<$Res>
    implements $MotmStateCopyWith<$Res> {
  _$MotmStateCopyWithImpl(this._self, this._then);

  final MotmState _self;
  final $Res Function(MotmState) _then;

/// Create a copy of MotmState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isOpen = null,Object? opensAfter = null,Object? closesAt = freezed,Object? eligible = null,Object? tally = null,Object? myVote = freezed,Object? canVote = null,Object? selfId = freezed,}) {
  return _then(_self.copyWith(
isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,opensAfter: null == opensAfter ? _self.opensAfter : opensAfter // ignore: cast_nullable_to_non_nullable
as bool,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,eligible: null == eligible ? _self.eligible : eligible // ignore: cast_nullable_to_non_nullable
as List<MotmCandidate>,tally: null == tally ? _self.tally : tally // ignore: cast_nullable_to_non_nullable
as List<MotmTally>,myVote: freezed == myVote ? _self.myVote : myVote // ignore: cast_nullable_to_non_nullable
as int?,canVote: null == canVote ? _self.canVote : canVote // ignore: cast_nullable_to_non_nullable
as bool,selfId: freezed == selfId ? _self.selfId : selfId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [MotmState].
extension MotmStatePatterns on MotmState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MotmState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MotmState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MotmState value)  $default,){
final _that = this;
switch (_that) {
case _MotmState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MotmState value)?  $default,){
final _that = this;
switch (_that) {
case _MotmState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isOpen,  bool opensAfter,  DateTime? closesAt,  List<MotmCandidate> eligible,  List<MotmTally> tally,  int? myVote,  bool canVote,  int? selfId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MotmState() when $default != null:
return $default(_that.isOpen,_that.opensAfter,_that.closesAt,_that.eligible,_that.tally,_that.myVote,_that.canVote,_that.selfId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isOpen,  bool opensAfter,  DateTime? closesAt,  List<MotmCandidate> eligible,  List<MotmTally> tally,  int? myVote,  bool canVote,  int? selfId)  $default,) {final _that = this;
switch (_that) {
case _MotmState():
return $default(_that.isOpen,_that.opensAfter,_that.closesAt,_that.eligible,_that.tally,_that.myVote,_that.canVote,_that.selfId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isOpen,  bool opensAfter,  DateTime? closesAt,  List<MotmCandidate> eligible,  List<MotmTally> tally,  int? myVote,  bool canVote,  int? selfId)?  $default,) {final _that = this;
switch (_that) {
case _MotmState() when $default != null:
return $default(_that.isOpen,_that.opensAfter,_that.closesAt,_that.eligible,_that.tally,_that.myVote,_that.canVote,_that.selfId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MotmState implements MotmState {
  const _MotmState({this.isOpen = false, this.opensAfter = false, this.closesAt, final  List<MotmCandidate> eligible = const <MotmCandidate>[], final  List<MotmTally> tally = const <MotmTally>[], this.myVote, this.canVote = true, this.selfId}): _eligible = eligible,_tally = tally;
  factory _MotmState.fromJson(Map<String, dynamic> json) => _$MotmStateFromJson(json);

@override@JsonKey() final  bool isOpen;
@override@JsonKey() final  bool opensAfter;
@override final  DateTime? closesAt;
 final  List<MotmCandidate> _eligible;
@override@JsonKey() List<MotmCandidate> get eligible {
  if (_eligible is EqualUnmodifiableListView) return _eligible;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_eligible);
}

 final  List<MotmTally> _tally;
@override@JsonKey() List<MotmTally> get tally {
  if (_tally is EqualUnmodifiableListView) return _tally;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tally);
}

@override final  int? myVote;
@override@JsonKey() final  bool canVote;
@override final  int? selfId;

/// Create a copy of MotmState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MotmStateCopyWith<_MotmState> get copyWith => __$MotmStateCopyWithImpl<_MotmState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MotmStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MotmState&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.opensAfter, opensAfter) || other.opensAfter == opensAfter)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt)&&const DeepCollectionEquality().equals(other._eligible, _eligible)&&const DeepCollectionEquality().equals(other._tally, _tally)&&(identical(other.myVote, myVote) || other.myVote == myVote)&&(identical(other.canVote, canVote) || other.canVote == canVote)&&(identical(other.selfId, selfId) || other.selfId == selfId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isOpen,opensAfter,closesAt,const DeepCollectionEquality().hash(_eligible),const DeepCollectionEquality().hash(_tally),myVote,canVote,selfId);

@override
String toString() {
  return 'MotmState(isOpen: $isOpen, opensAfter: $opensAfter, closesAt: $closesAt, eligible: $eligible, tally: $tally, myVote: $myVote, canVote: $canVote, selfId: $selfId)';
}


}

/// @nodoc
abstract mixin class _$MotmStateCopyWith<$Res> implements $MotmStateCopyWith<$Res> {
  factory _$MotmStateCopyWith(_MotmState value, $Res Function(_MotmState) _then) = __$MotmStateCopyWithImpl;
@override @useResult
$Res call({
 bool isOpen, bool opensAfter, DateTime? closesAt, List<MotmCandidate> eligible, List<MotmTally> tally, int? myVote, bool canVote, int? selfId
});




}
/// @nodoc
class __$MotmStateCopyWithImpl<$Res>
    implements _$MotmStateCopyWith<$Res> {
  __$MotmStateCopyWithImpl(this._self, this._then);

  final _MotmState _self;
  final $Res Function(_MotmState) _then;

/// Create a copy of MotmState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isOpen = null,Object? opensAfter = null,Object? closesAt = freezed,Object? eligible = null,Object? tally = null,Object? myVote = freezed,Object? canVote = null,Object? selfId = freezed,}) {
  return _then(_MotmState(
isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,opensAfter: null == opensAfter ? _self.opensAfter : opensAfter // ignore: cast_nullable_to_non_nullable
as bool,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,eligible: null == eligible ? _self._eligible : eligible // ignore: cast_nullable_to_non_nullable
as List<MotmCandidate>,tally: null == tally ? _self._tally : tally // ignore: cast_nullable_to_non_nullable
as List<MotmTally>,myVote: freezed == myVote ? _self.myVote : myVote // ignore: cast_nullable_to_non_nullable
as int?,canVote: null == canVote ? _self.canVote : canVote // ignore: cast_nullable_to_non_nullable
as bool,selfId: freezed == selfId ? _self.selfId : selfId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$MotmVoteResult {

 int get eventId; int? get myVote; bool get isOpen; DateTime? get closesAt;
/// Create a copy of MotmVoteResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MotmVoteResultCopyWith<MotmVoteResult> get copyWith => _$MotmVoteResultCopyWithImpl<MotmVoteResult>(this as MotmVoteResult, _$identity);

  /// Serializes this MotmVoteResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MotmVoteResult&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.myVote, myVote) || other.myVote == myVote)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,myVote,isOpen,closesAt);

@override
String toString() {
  return 'MotmVoteResult(eventId: $eventId, myVote: $myVote, isOpen: $isOpen, closesAt: $closesAt)';
}


}

/// @nodoc
abstract mixin class $MotmVoteResultCopyWith<$Res>  {
  factory $MotmVoteResultCopyWith(MotmVoteResult value, $Res Function(MotmVoteResult) _then) = _$MotmVoteResultCopyWithImpl;
@useResult
$Res call({
 int eventId, int? myVote, bool isOpen, DateTime? closesAt
});




}
/// @nodoc
class _$MotmVoteResultCopyWithImpl<$Res>
    implements $MotmVoteResultCopyWith<$Res> {
  _$MotmVoteResultCopyWithImpl(this._self, this._then);

  final MotmVoteResult _self;
  final $Res Function(MotmVoteResult) _then;

/// Create a copy of MotmVoteResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? myVote = freezed,Object? isOpen = null,Object? closesAt = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,myVote: freezed == myVote ? _self.myVote : myVote // ignore: cast_nullable_to_non_nullable
as int?,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MotmVoteResult].
extension MotmVoteResultPatterns on MotmVoteResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MotmVoteResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MotmVoteResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MotmVoteResult value)  $default,){
final _that = this;
switch (_that) {
case _MotmVoteResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MotmVoteResult value)?  $default,){
final _that = this;
switch (_that) {
case _MotmVoteResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int eventId,  int? myVote,  bool isOpen,  DateTime? closesAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MotmVoteResult() when $default != null:
return $default(_that.eventId,_that.myVote,_that.isOpen,_that.closesAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int eventId,  int? myVote,  bool isOpen,  DateTime? closesAt)  $default,) {final _that = this;
switch (_that) {
case _MotmVoteResult():
return $default(_that.eventId,_that.myVote,_that.isOpen,_that.closesAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int eventId,  int? myVote,  bool isOpen,  DateTime? closesAt)?  $default,) {final _that = this;
switch (_that) {
case _MotmVoteResult() when $default != null:
return $default(_that.eventId,_that.myVote,_that.isOpen,_that.closesAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MotmVoteResult implements MotmVoteResult {
  const _MotmVoteResult({required this.eventId, this.myVote, this.isOpen = false, this.closesAt});
  factory _MotmVoteResult.fromJson(Map<String, dynamic> json) => _$MotmVoteResultFromJson(json);

@override final  int eventId;
@override final  int? myVote;
@override@JsonKey() final  bool isOpen;
@override final  DateTime? closesAt;

/// Create a copy of MotmVoteResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MotmVoteResultCopyWith<_MotmVoteResult> get copyWith => __$MotmVoteResultCopyWithImpl<_MotmVoteResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MotmVoteResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MotmVoteResult&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.myVote, myVote) || other.myVote == myVote)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.closesAt, closesAt) || other.closesAt == closesAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,myVote,isOpen,closesAt);

@override
String toString() {
  return 'MotmVoteResult(eventId: $eventId, myVote: $myVote, isOpen: $isOpen, closesAt: $closesAt)';
}


}

/// @nodoc
abstract mixin class _$MotmVoteResultCopyWith<$Res> implements $MotmVoteResultCopyWith<$Res> {
  factory _$MotmVoteResultCopyWith(_MotmVoteResult value, $Res Function(_MotmVoteResult) _then) = __$MotmVoteResultCopyWithImpl;
@override @useResult
$Res call({
 int eventId, int? myVote, bool isOpen, DateTime? closesAt
});




}
/// @nodoc
class __$MotmVoteResultCopyWithImpl<$Res>
    implements _$MotmVoteResultCopyWith<$Res> {
  __$MotmVoteResultCopyWithImpl(this._self, this._then);

  final _MotmVoteResult _self;
  final $Res Function(_MotmVoteResult) _then;

/// Create a copy of MotmVoteResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? myVote = freezed,Object? isOpen = null,Object? closesAt = freezed,}) {
  return _then(_MotmVoteResult(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,myVote: freezed == myVote ? _self.myVote : myVote // ignore: cast_nullable_to_non_nullable
as int?,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,closesAt: freezed == closesAt ? _self.closesAt : closesAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CarpoolOffer {

 int get id; int? get userId; String get userName; String? get avatarUrl;@JsonKey(unknownEnumValue: CarpoolMode.direct) CarpoolMode get mode; int? get seats; bool get isSelf;
/// Create a copy of CarpoolOffer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarpoolOfferCopyWith<CarpoolOffer> get copyWith => _$CarpoolOfferCopyWithImpl<CarpoolOffer>(this as CarpoolOffer, _$identity);

  /// Serializes this CarpoolOffer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarpoolOffer&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.isSelf, isSelf) || other.isSelf == isSelf));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,avatarUrl,mode,seats,isSelf);

@override
String toString() {
  return 'CarpoolOffer(id: $id, userId: $userId, userName: $userName, avatarUrl: $avatarUrl, mode: $mode, seats: $seats, isSelf: $isSelf)';
}


}

/// @nodoc
abstract mixin class $CarpoolOfferCopyWith<$Res>  {
  factory $CarpoolOfferCopyWith(CarpoolOffer value, $Res Function(CarpoolOffer) _then) = _$CarpoolOfferCopyWithImpl;
@useResult
$Res call({
 int id, int? userId, String userName, String? avatarUrl,@JsonKey(unknownEnumValue: CarpoolMode.direct) CarpoolMode mode, int? seats, bool isSelf
});




}
/// @nodoc
class _$CarpoolOfferCopyWithImpl<$Res>
    implements $CarpoolOfferCopyWith<$Res> {
  _$CarpoolOfferCopyWithImpl(this._self, this._then);

  final CarpoolOffer _self;
  final $Res Function(CarpoolOffer) _then;

/// Create a copy of CarpoolOffer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = freezed,Object? userName = null,Object? avatarUrl = freezed,Object? mode = null,Object? seats = freezed,Object? isSelf = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as CarpoolMode,seats: freezed == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int?,isSelf: null == isSelf ? _self.isSelf : isSelf // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CarpoolOffer].
extension CarpoolOfferPatterns on CarpoolOffer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarpoolOffer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarpoolOffer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarpoolOffer value)  $default,){
final _that = this;
switch (_that) {
case _CarpoolOffer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarpoolOffer value)?  $default,){
final _that = this;
switch (_that) {
case _CarpoolOffer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? userId,  String userName,  String? avatarUrl, @JsonKey(unknownEnumValue: CarpoolMode.direct)  CarpoolMode mode,  int? seats,  bool isSelf)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarpoolOffer() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.avatarUrl,_that.mode,_that.seats,_that.isSelf);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? userId,  String userName,  String? avatarUrl, @JsonKey(unknownEnumValue: CarpoolMode.direct)  CarpoolMode mode,  int? seats,  bool isSelf)  $default,) {final _that = this;
switch (_that) {
case _CarpoolOffer():
return $default(_that.id,_that.userId,_that.userName,_that.avatarUrl,_that.mode,_that.seats,_that.isSelf);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? userId,  String userName,  String? avatarUrl, @JsonKey(unknownEnumValue: CarpoolMode.direct)  CarpoolMode mode,  int? seats,  bool isSelf)?  $default,) {final _that = this;
switch (_that) {
case _CarpoolOffer() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.avatarUrl,_that.mode,_that.seats,_that.isSelf);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CarpoolOffer implements CarpoolOffer {
  const _CarpoolOffer({required this.id, this.userId, this.userName = '', this.avatarUrl, @JsonKey(unknownEnumValue: CarpoolMode.direct) this.mode = CarpoolMode.direct, this.seats, this.isSelf = false});
  factory _CarpoolOffer.fromJson(Map<String, dynamic> json) => _$CarpoolOfferFromJson(json);

@override final  int id;
@override final  int? userId;
@override@JsonKey() final  String userName;
@override final  String? avatarUrl;
@override@JsonKey(unknownEnumValue: CarpoolMode.direct) final  CarpoolMode mode;
@override final  int? seats;
@override@JsonKey() final  bool isSelf;

/// Create a copy of CarpoolOffer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarpoolOfferCopyWith<_CarpoolOffer> get copyWith => __$CarpoolOfferCopyWithImpl<_CarpoolOffer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CarpoolOfferToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarpoolOffer&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.seats, seats) || other.seats == seats)&&(identical(other.isSelf, isSelf) || other.isSelf == isSelf));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,avatarUrl,mode,seats,isSelf);

@override
String toString() {
  return 'CarpoolOffer(id: $id, userId: $userId, userName: $userName, avatarUrl: $avatarUrl, mode: $mode, seats: $seats, isSelf: $isSelf)';
}


}

/// @nodoc
abstract mixin class _$CarpoolOfferCopyWith<$Res> implements $CarpoolOfferCopyWith<$Res> {
  factory _$CarpoolOfferCopyWith(_CarpoolOffer value, $Res Function(_CarpoolOffer) _then) = __$CarpoolOfferCopyWithImpl;
@override @useResult
$Res call({
 int id, int? userId, String userName, String? avatarUrl,@JsonKey(unknownEnumValue: CarpoolMode.direct) CarpoolMode mode, int? seats, bool isSelf
});




}
/// @nodoc
class __$CarpoolOfferCopyWithImpl<$Res>
    implements _$CarpoolOfferCopyWith<$Res> {
  __$CarpoolOfferCopyWithImpl(this._self, this._then);

  final _CarpoolOffer _self;
  final $Res Function(_CarpoolOffer) _then;

/// Create a copy of CarpoolOffer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = freezed,Object? userName = null,Object? avatarUrl = freezed,Object? mode = null,Object? seats = freezed,Object? isSelf = null,}) {
  return _then(_CarpoolOffer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as CarpoolMode,seats: freezed == seats ? _self.seats : seats // ignore: cast_nullable_to_non_nullable
as int?,isSelf: null == isSelf ? _self.isSelf : isSelf // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EventDutyOption {

 String get key; String get name; int? get id; String? get kind; List<String> get members;
/// Create a copy of EventDutyOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDutyOptionCopyWith<EventDutyOption> get copyWith => _$EventDutyOptionCopyWithImpl<EventDutyOption>(this as EventDutyOption, _$identity);

  /// Serializes this EventDutyOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDutyOption&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other.members, members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name,id,kind,const DeepCollectionEquality().hash(members));

@override
String toString() {
  return 'EventDutyOption(key: $key, name: $name, id: $id, kind: $kind, members: $members)';
}


}

/// @nodoc
abstract mixin class $EventDutyOptionCopyWith<$Res>  {
  factory $EventDutyOptionCopyWith(EventDutyOption value, $Res Function(EventDutyOption) _then) = _$EventDutyOptionCopyWithImpl;
@useResult
$Res call({
 String key, String name, int? id, String? kind, List<String> members
});




}
/// @nodoc
class _$EventDutyOptionCopyWithImpl<$Res>
    implements $EventDutyOptionCopyWith<$Res> {
  _$EventDutyOptionCopyWithImpl(this._self, this._then);

  final EventDutyOption _self;
  final $Res Function(EventDutyOption) _then;

/// Create a copy of EventDutyOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? name = null,Object? id = freezed,Object? kind = freezed,Object? members = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,kind: freezed == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String?,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [EventDutyOption].
extension EventDutyOptionPatterns on EventDutyOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventDutyOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventDutyOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventDutyOption value)  $default,){
final _that = this;
switch (_that) {
case _EventDutyOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventDutyOption value)?  $default,){
final _that = this;
switch (_that) {
case _EventDutyOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String name,  int? id,  String? kind,  List<String> members)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventDutyOption() when $default != null:
return $default(_that.key,_that.name,_that.id,_that.kind,_that.members);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String name,  int? id,  String? kind,  List<String> members)  $default,) {final _that = this;
switch (_that) {
case _EventDutyOption():
return $default(_that.key,_that.name,_that.id,_that.kind,_that.members);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String name,  int? id,  String? kind,  List<String> members)?  $default,) {final _that = this;
switch (_that) {
case _EventDutyOption() when $default != null:
return $default(_that.key,_that.name,_that.id,_that.kind,_that.members);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventDutyOption implements EventDutyOption {
  const _EventDutyOption({required this.key, this.name = '', this.id, this.kind, final  List<String> members = const <String>[]}): _members = members;
  factory _EventDutyOption.fromJson(Map<String, dynamic> json) => _$EventDutyOptionFromJson(json);

@override final  String key;
@override@JsonKey() final  String name;
@override final  int? id;
@override final  String? kind;
 final  List<String> _members;
@override@JsonKey() List<String> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}


/// Create a copy of EventDutyOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventDutyOptionCopyWith<_EventDutyOption> get copyWith => __$EventDutyOptionCopyWithImpl<_EventDutyOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventDutyOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDutyOption&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other._members, _members));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name,id,kind,const DeepCollectionEquality().hash(_members));

@override
String toString() {
  return 'EventDutyOption(key: $key, name: $name, id: $id, kind: $kind, members: $members)';
}


}

/// @nodoc
abstract mixin class _$EventDutyOptionCopyWith<$Res> implements $EventDutyOptionCopyWith<$Res> {
  factory _$EventDutyOptionCopyWith(_EventDutyOption value, $Res Function(_EventDutyOption) _then) = __$EventDutyOptionCopyWithImpl;
@override @useResult
$Res call({
 String key, String name, int? id, String? kind, List<String> members
});




}
/// @nodoc
class __$EventDutyOptionCopyWithImpl<$Res>
    implements _$EventDutyOptionCopyWith<$Res> {
  __$EventDutyOptionCopyWithImpl(this._self, this._then);

  final _EventDutyOption _self;
  final $Res Function(_EventDutyOption) _then;

/// Create a copy of EventDutyOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? name = null,Object? id = freezed,Object? kind = freezed,Object? members = null,}) {
  return _then(_EventDutyOption(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,kind: freezed == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String?,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$EventDuty {

 int get dutyTypeId; String get name; String? get icon;/// `individual`, `group` of `multi` (onbekend telt als persoon).
 String get mode; int? get assignmentId; String? get memberKey; List<String> get memberKeys; bool get assigneeAbsent; int? get dutyGroupId; String? get label; List<String> get memberNames; String? get notes; bool get done; bool get mine; List<EventDutyOption> get options;
/// Create a copy of EventDuty
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDutyCopyWith<EventDuty> get copyWith => _$EventDutyCopyWithImpl<EventDuty>(this as EventDuty, _$identity);

  /// Serializes this EventDuty to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDuty&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId)&&(identical(other.memberKey, memberKey) || other.memberKey == memberKey)&&const DeepCollectionEquality().equals(other.memberKeys, memberKeys)&&(identical(other.assigneeAbsent, assigneeAbsent) || other.assigneeAbsent == assigneeAbsent)&&(identical(other.dutyGroupId, dutyGroupId) || other.dutyGroupId == dutyGroupId)&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other.memberNames, memberNames)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.done, done) || other.done == done)&&(identical(other.mine, mine) || other.mine == mine)&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dutyTypeId,name,icon,mode,assignmentId,memberKey,const DeepCollectionEquality().hash(memberKeys),assigneeAbsent,dutyGroupId,label,const DeepCollectionEquality().hash(memberNames),notes,done,mine,const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'EventDuty(dutyTypeId: $dutyTypeId, name: $name, icon: $icon, mode: $mode, assignmentId: $assignmentId, memberKey: $memberKey, memberKeys: $memberKeys, assigneeAbsent: $assigneeAbsent, dutyGroupId: $dutyGroupId, label: $label, memberNames: $memberNames, notes: $notes, done: $done, mine: $mine, options: $options)';
}


}

/// @nodoc
abstract mixin class $EventDutyCopyWith<$Res>  {
  factory $EventDutyCopyWith(EventDuty value, $Res Function(EventDuty) _then) = _$EventDutyCopyWithImpl;
@useResult
$Res call({
 int dutyTypeId, String name, String? icon, String mode, int? assignmentId, String? memberKey, List<String> memberKeys, bool assigneeAbsent, int? dutyGroupId, String? label, List<String> memberNames, String? notes, bool done, bool mine, List<EventDutyOption> options
});




}
/// @nodoc
class _$EventDutyCopyWithImpl<$Res>
    implements $EventDutyCopyWith<$Res> {
  _$EventDutyCopyWithImpl(this._self, this._then);

  final EventDuty _self;
  final $Res Function(EventDuty) _then;

/// Create a copy of EventDuty
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dutyTypeId = null,Object? name = null,Object? icon = freezed,Object? mode = null,Object? assignmentId = freezed,Object? memberKey = freezed,Object? memberKeys = null,Object? assigneeAbsent = null,Object? dutyGroupId = freezed,Object? label = freezed,Object? memberNames = null,Object? notes = freezed,Object? done = null,Object? mine = null,Object? options = null,}) {
  return _then(_self.copyWith(
dutyTypeId: null == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,assignmentId: freezed == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as int?,memberKey: freezed == memberKey ? _self.memberKey : memberKey // ignore: cast_nullable_to_non_nullable
as String?,memberKeys: null == memberKeys ? _self.memberKeys : memberKeys // ignore: cast_nullable_to_non_nullable
as List<String>,assigneeAbsent: null == assigneeAbsent ? _self.assigneeAbsent : assigneeAbsent // ignore: cast_nullable_to_non_nullable
as bool,dutyGroupId: freezed == dutyGroupId ? _self.dutyGroupId : dutyGroupId // ignore: cast_nullable_to_non_nullable
as int?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,memberNames: null == memberNames ? _self.memberNames : memberNames // ignore: cast_nullable_to_non_nullable
as List<String>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<EventDutyOption>,
  ));
}

}


/// Adds pattern-matching-related methods to [EventDuty].
extension EventDutyPatterns on EventDuty {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventDuty value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventDuty() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventDuty value)  $default,){
final _that = this;
switch (_that) {
case _EventDuty():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventDuty value)?  $default,){
final _that = this;
switch (_that) {
case _EventDuty() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int dutyTypeId,  String name,  String? icon,  String mode,  int? assignmentId,  String? memberKey,  List<String> memberKeys,  bool assigneeAbsent,  int? dutyGroupId,  String? label,  List<String> memberNames,  String? notes,  bool done,  bool mine,  List<EventDutyOption> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventDuty() when $default != null:
return $default(_that.dutyTypeId,_that.name,_that.icon,_that.mode,_that.assignmentId,_that.memberKey,_that.memberKeys,_that.assigneeAbsent,_that.dutyGroupId,_that.label,_that.memberNames,_that.notes,_that.done,_that.mine,_that.options);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int dutyTypeId,  String name,  String? icon,  String mode,  int? assignmentId,  String? memberKey,  List<String> memberKeys,  bool assigneeAbsent,  int? dutyGroupId,  String? label,  List<String> memberNames,  String? notes,  bool done,  bool mine,  List<EventDutyOption> options)  $default,) {final _that = this;
switch (_that) {
case _EventDuty():
return $default(_that.dutyTypeId,_that.name,_that.icon,_that.mode,_that.assignmentId,_that.memberKey,_that.memberKeys,_that.assigneeAbsent,_that.dutyGroupId,_that.label,_that.memberNames,_that.notes,_that.done,_that.mine,_that.options);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int dutyTypeId,  String name,  String? icon,  String mode,  int? assignmentId,  String? memberKey,  List<String> memberKeys,  bool assigneeAbsent,  int? dutyGroupId,  String? label,  List<String> memberNames,  String? notes,  bool done,  bool mine,  List<EventDutyOption> options)?  $default,) {final _that = this;
switch (_that) {
case _EventDuty() when $default != null:
return $default(_that.dutyTypeId,_that.name,_that.icon,_that.mode,_that.assignmentId,_that.memberKey,_that.memberKeys,_that.assigneeAbsent,_that.dutyGroupId,_that.label,_that.memberNames,_that.notes,_that.done,_that.mine,_that.options);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventDuty extends EventDuty {
  const _EventDuty({required this.dutyTypeId, this.name = '', this.icon, this.mode = 'individual', this.assignmentId, this.memberKey, final  List<String> memberKeys = const <String>[], this.assigneeAbsent = false, this.dutyGroupId, this.label, final  List<String> memberNames = const <String>[], this.notes, this.done = false, this.mine = false, final  List<EventDutyOption> options = const <EventDutyOption>[]}): _memberKeys = memberKeys,_memberNames = memberNames,_options = options,super._();
  factory _EventDuty.fromJson(Map<String, dynamic> json) => _$EventDutyFromJson(json);

@override final  int dutyTypeId;
@override@JsonKey() final  String name;
@override final  String? icon;
/// `individual`, `group` of `multi` (onbekend telt als persoon).
@override@JsonKey() final  String mode;
@override final  int? assignmentId;
@override final  String? memberKey;
 final  List<String> _memberKeys;
@override@JsonKey() List<String> get memberKeys {
  if (_memberKeys is EqualUnmodifiableListView) return _memberKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberKeys);
}

@override@JsonKey() final  bool assigneeAbsent;
@override final  int? dutyGroupId;
@override final  String? label;
 final  List<String> _memberNames;
@override@JsonKey() List<String> get memberNames {
  if (_memberNames is EqualUnmodifiableListView) return _memberNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberNames);
}

@override final  String? notes;
@override@JsonKey() final  bool done;
@override@JsonKey() final  bool mine;
 final  List<EventDutyOption> _options;
@override@JsonKey() List<EventDutyOption> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of EventDuty
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventDutyCopyWith<_EventDuty> get copyWith => __$EventDutyCopyWithImpl<_EventDuty>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventDutyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDuty&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId)&&(identical(other.memberKey, memberKey) || other.memberKey == memberKey)&&const DeepCollectionEquality().equals(other._memberKeys, _memberKeys)&&(identical(other.assigneeAbsent, assigneeAbsent) || other.assigneeAbsent == assigneeAbsent)&&(identical(other.dutyGroupId, dutyGroupId) || other.dutyGroupId == dutyGroupId)&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other._memberNames, _memberNames)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.done, done) || other.done == done)&&(identical(other.mine, mine) || other.mine == mine)&&const DeepCollectionEquality().equals(other._options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dutyTypeId,name,icon,mode,assignmentId,memberKey,const DeepCollectionEquality().hash(_memberKeys),assigneeAbsent,dutyGroupId,label,const DeepCollectionEquality().hash(_memberNames),notes,done,mine,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'EventDuty(dutyTypeId: $dutyTypeId, name: $name, icon: $icon, mode: $mode, assignmentId: $assignmentId, memberKey: $memberKey, memberKeys: $memberKeys, assigneeAbsent: $assigneeAbsent, dutyGroupId: $dutyGroupId, label: $label, memberNames: $memberNames, notes: $notes, done: $done, mine: $mine, options: $options)';
}


}

/// @nodoc
abstract mixin class _$EventDutyCopyWith<$Res> implements $EventDutyCopyWith<$Res> {
  factory _$EventDutyCopyWith(_EventDuty value, $Res Function(_EventDuty) _then) = __$EventDutyCopyWithImpl;
@override @useResult
$Res call({
 int dutyTypeId, String name, String? icon, String mode, int? assignmentId, String? memberKey, List<String> memberKeys, bool assigneeAbsent, int? dutyGroupId, String? label, List<String> memberNames, String? notes, bool done, bool mine, List<EventDutyOption> options
});




}
/// @nodoc
class __$EventDutyCopyWithImpl<$Res>
    implements _$EventDutyCopyWith<$Res> {
  __$EventDutyCopyWithImpl(this._self, this._then);

  final _EventDuty _self;
  final $Res Function(_EventDuty) _then;

/// Create a copy of EventDuty
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dutyTypeId = null,Object? name = null,Object? icon = freezed,Object? mode = null,Object? assignmentId = freezed,Object? memberKey = freezed,Object? memberKeys = null,Object? assigneeAbsent = null,Object? dutyGroupId = freezed,Object? label = freezed,Object? memberNames = null,Object? notes = freezed,Object? done = null,Object? mine = null,Object? options = null,}) {
  return _then(_EventDuty(
dutyTypeId: null == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,assignmentId: freezed == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as int?,memberKey: freezed == memberKey ? _self.memberKey : memberKey // ignore: cast_nullable_to_non_nullable
as String?,memberKeys: null == memberKeys ? _self._memberKeys : memberKeys // ignore: cast_nullable_to_non_nullable
as List<String>,assigneeAbsent: null == assigneeAbsent ? _self.assigneeAbsent : assigneeAbsent // ignore: cast_nullable_to_non_nullable
as bool,dutyGroupId: freezed == dutyGroupId ? _self.dutyGroupId : dutyGroupId // ignore: cast_nullable_to_non_nullable
as int?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,memberNames: null == memberNames ? _self._memberNames : memberNames // ignore: cast_nullable_to_non_nullable
as List<String>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<EventDutyOption>,
  ));
}


}


/// @nodoc
mixin _$FlagShift {

 String? get key; int? get playerId; int? get userId; int get fromMinute;
/// Create a copy of FlagShift
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlagShiftCopyWith<FlagShift> get copyWith => _$FlagShiftCopyWithImpl<FlagShift>(this as FlagShift, _$identity);

  /// Serializes this FlagShift to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlagShift&&(identical(other.key, key) || other.key == key)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fromMinute, fromMinute) || other.fromMinute == fromMinute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,playerId,userId,fromMinute);

@override
String toString() {
  return 'FlagShift(key: $key, playerId: $playerId, userId: $userId, fromMinute: $fromMinute)';
}


}

/// @nodoc
abstract mixin class $FlagShiftCopyWith<$Res>  {
  factory $FlagShiftCopyWith(FlagShift value, $Res Function(FlagShift) _then) = _$FlagShiftCopyWithImpl;
@useResult
$Res call({
 String? key, int? playerId, int? userId, int fromMinute
});




}
/// @nodoc
class _$FlagShiftCopyWithImpl<$Res>
    implements $FlagShiftCopyWith<$Res> {
  _$FlagShiftCopyWithImpl(this._self, this._then);

  final FlagShift _self;
  final $Res Function(FlagShift) _then;

/// Create a copy of FlagShift
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = freezed,Object? playerId = freezed,Object? userId = freezed,Object? fromMinute = null,}) {
  return _then(_self.copyWith(
key: freezed == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String?,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,fromMinute: null == fromMinute ? _self.fromMinute : fromMinute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FlagShift].
extension FlagShiftPatterns on FlagShift {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlagShift value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlagShift() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlagShift value)  $default,){
final _that = this;
switch (_that) {
case _FlagShift():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlagShift value)?  $default,){
final _that = this;
switch (_that) {
case _FlagShift() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? key,  int? playerId,  int? userId,  int fromMinute)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlagShift() when $default != null:
return $default(_that.key,_that.playerId,_that.userId,_that.fromMinute);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? key,  int? playerId,  int? userId,  int fromMinute)  $default,) {final _that = this;
switch (_that) {
case _FlagShift():
return $default(_that.key,_that.playerId,_that.userId,_that.fromMinute);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? key,  int? playerId,  int? userId,  int fromMinute)?  $default,) {final _that = this;
switch (_that) {
case _FlagShift() when $default != null:
return $default(_that.key,_that.playerId,_that.userId,_that.fromMinute);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlagShift implements FlagShift {
  const _FlagShift({this.key, this.playerId, this.userId, this.fromMinute = 0});
  factory _FlagShift.fromJson(Map<String, dynamic> json) => _$FlagShiftFromJson(json);

@override final  String? key;
@override final  int? playerId;
@override final  int? userId;
@override@JsonKey() final  int fromMinute;

/// Create a copy of FlagShift
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlagShiftCopyWith<_FlagShift> get copyWith => __$FlagShiftCopyWithImpl<_FlagShift>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlagShiftToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlagShift&&(identical(other.key, key) || other.key == key)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.fromMinute, fromMinute) || other.fromMinute == fromMinute));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,playerId,userId,fromMinute);

@override
String toString() {
  return 'FlagShift(key: $key, playerId: $playerId, userId: $userId, fromMinute: $fromMinute)';
}


}

/// @nodoc
abstract mixin class _$FlagShiftCopyWith<$Res> implements $FlagShiftCopyWith<$Res> {
  factory _$FlagShiftCopyWith(_FlagShift value, $Res Function(_FlagShift) _then) = __$FlagShiftCopyWithImpl;
@override @useResult
$Res call({
 String? key, int? playerId, int? userId, int fromMinute
});




}
/// @nodoc
class __$FlagShiftCopyWithImpl<$Res>
    implements _$FlagShiftCopyWith<$Res> {
  __$FlagShiftCopyWithImpl(this._self, this._then);

  final _FlagShift _self;
  final $Res Function(_FlagShift) _then;

/// Create a copy of FlagShift
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = freezed,Object? playerId = freezed,Object? userId = freezed,Object? fromMinute = null,}) {
  return _then(_FlagShift(
key: freezed == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String?,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,fromMinute: null == fromMinute ? _self.fromMinute : fromMinute // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$FlagDuty {

 List<FlagShift> get shifts; List<String> get names; bool get mine; int? get matchMinutes;
/// Create a copy of FlagDuty
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlagDutyCopyWith<FlagDuty> get copyWith => _$FlagDutyCopyWithImpl<FlagDuty>(this as FlagDuty, _$identity);

  /// Serializes this FlagDuty to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlagDuty&&const DeepCollectionEquality().equals(other.shifts, shifts)&&const DeepCollectionEquality().equals(other.names, names)&&(identical(other.mine, mine) || other.mine == mine)&&(identical(other.matchMinutes, matchMinutes) || other.matchMinutes == matchMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(shifts),const DeepCollectionEquality().hash(names),mine,matchMinutes);

@override
String toString() {
  return 'FlagDuty(shifts: $shifts, names: $names, mine: $mine, matchMinutes: $matchMinutes)';
}


}

/// @nodoc
abstract mixin class $FlagDutyCopyWith<$Res>  {
  factory $FlagDutyCopyWith(FlagDuty value, $Res Function(FlagDuty) _then) = _$FlagDutyCopyWithImpl;
@useResult
$Res call({
 List<FlagShift> shifts, List<String> names, bool mine, int? matchMinutes
});




}
/// @nodoc
class _$FlagDutyCopyWithImpl<$Res>
    implements $FlagDutyCopyWith<$Res> {
  _$FlagDutyCopyWithImpl(this._self, this._then);

  final FlagDuty _self;
  final $Res Function(FlagDuty) _then;

/// Create a copy of FlagDuty
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? shifts = null,Object? names = null,Object? mine = null,Object? matchMinutes = freezed,}) {
  return _then(_self.copyWith(
shifts: null == shifts ? _self.shifts : shifts // ignore: cast_nullable_to_non_nullable
as List<FlagShift>,names: null == names ? _self.names : names // ignore: cast_nullable_to_non_nullable
as List<String>,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,matchMinutes: freezed == matchMinutes ? _self.matchMinutes : matchMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [FlagDuty].
extension FlagDutyPatterns on FlagDuty {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlagDuty value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlagDuty() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlagDuty value)  $default,){
final _that = this;
switch (_that) {
case _FlagDuty():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlagDuty value)?  $default,){
final _that = this;
switch (_that) {
case _FlagDuty() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<FlagShift> shifts,  List<String> names,  bool mine,  int? matchMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlagDuty() when $default != null:
return $default(_that.shifts,_that.names,_that.mine,_that.matchMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<FlagShift> shifts,  List<String> names,  bool mine,  int? matchMinutes)  $default,) {final _that = this;
switch (_that) {
case _FlagDuty():
return $default(_that.shifts,_that.names,_that.mine,_that.matchMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<FlagShift> shifts,  List<String> names,  bool mine,  int? matchMinutes)?  $default,) {final _that = this;
switch (_that) {
case _FlagDuty() when $default != null:
return $default(_that.shifts,_that.names,_that.mine,_that.matchMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlagDuty implements FlagDuty {
  const _FlagDuty({final  List<FlagShift> shifts = const <FlagShift>[], final  List<String> names = const <String>[], this.mine = false, this.matchMinutes}): _shifts = shifts,_names = names;
  factory _FlagDuty.fromJson(Map<String, dynamic> json) => _$FlagDutyFromJson(json);

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
@override final  int? matchMinutes;

/// Create a copy of FlagDuty
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlagDutyCopyWith<_FlagDuty> get copyWith => __$FlagDutyCopyWithImpl<_FlagDuty>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlagDutyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlagDuty&&const DeepCollectionEquality().equals(other._shifts, _shifts)&&const DeepCollectionEquality().equals(other._names, _names)&&(identical(other.mine, mine) || other.mine == mine)&&(identical(other.matchMinutes, matchMinutes) || other.matchMinutes == matchMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_shifts),const DeepCollectionEquality().hash(_names),mine,matchMinutes);

@override
String toString() {
  return 'FlagDuty(shifts: $shifts, names: $names, mine: $mine, matchMinutes: $matchMinutes)';
}


}

/// @nodoc
abstract mixin class _$FlagDutyCopyWith<$Res> implements $FlagDutyCopyWith<$Res> {
  factory _$FlagDutyCopyWith(_FlagDuty value, $Res Function(_FlagDuty) _then) = __$FlagDutyCopyWithImpl;
@override @useResult
$Res call({
 List<FlagShift> shifts, List<String> names, bool mine, int? matchMinutes
});




}
/// @nodoc
class __$FlagDutyCopyWithImpl<$Res>
    implements _$FlagDutyCopyWith<$Res> {
  __$FlagDutyCopyWithImpl(this._self, this._then);

  final _FlagDuty _self;
  final $Res Function(_FlagDuty) _then;

/// Create a copy of FlagDuty
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? shifts = null,Object? names = null,Object? mine = null,Object? matchMinutes = freezed,}) {
  return _then(_FlagDuty(
shifts: null == shifts ? _self._shifts : shifts // ignore: cast_nullable_to_non_nullable
as List<FlagShift>,names: null == names ? _self._names : names // ignore: cast_nullable_to_non_nullable
as List<String>,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,matchMinutes: freezed == matchMinutes ? _self.matchMinutes : matchMinutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$EventDetail {

 int get id;@JsonKey(unknownEnumValue: EventType.unknown) EventType get type; String get title; DateTime get startsAt; DateTime? get endsAt; DateTime? get meetAt; String? get venue; String? get notes; bool? get isHome;/// `league`, `cup`, `friendly` of `null`.
 String? get competition; String? get homeTeam; String? get awayTeam; int? get homeScore; int? get awayScore; DateTime? get cancelledAt; LiveState? get live;@JsonKey(unknownEnumValue: AttendanceStatus.pending) List<AttendanceStatus> get rsvpStatuses; SportlinkInfo? get sportlink;@JsonKey(unknownEnumValue: AttendanceStatus.pending) AttendanceStatus? get myStatus; String? get myReason; bool get canRsvp; bool get canChange; AttendanceCounts get counts; AttendanceCounts get playerCounts; List<EventPlayer> get players; bool get hasLineup; bool get lineupShared; MotmState? get motm; List<CarpoolOffer>? get carpoolOffers; bool get isTrainer; bool get canAssignTeams; List<EventDuty> get duties; FlagDuty? get flag;
/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventDetailCopyWith<EventDetail> get copyWith => _$EventDetailCopyWithImpl<EventDetail>(this as EventDetail, _$identity);

  /// Serializes this EventDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.meetAt, meetAt) || other.meetAt == meetAt)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isHome, isHome) || other.isHome == isHome)&&(identical(other.competition, competition) || other.competition == competition)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.homeScore, homeScore) || other.homeScore == homeScore)&&(identical(other.awayScore, awayScore) || other.awayScore == awayScore)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.live, live) || other.live == live)&&const DeepCollectionEquality().equals(other.rsvpStatuses, rsvpStatuses)&&(identical(other.sportlink, sportlink) || other.sportlink == sportlink)&&(identical(other.myStatus, myStatus) || other.myStatus == myStatus)&&(identical(other.myReason, myReason) || other.myReason == myReason)&&(identical(other.canRsvp, canRsvp) || other.canRsvp == canRsvp)&&(identical(other.canChange, canChange) || other.canChange == canChange)&&(identical(other.counts, counts) || other.counts == counts)&&(identical(other.playerCounts, playerCounts) || other.playerCounts == playerCounts)&&const DeepCollectionEquality().equals(other.players, players)&&(identical(other.hasLineup, hasLineup) || other.hasLineup == hasLineup)&&(identical(other.lineupShared, lineupShared) || other.lineupShared == lineupShared)&&(identical(other.motm, motm) || other.motm == motm)&&const DeepCollectionEquality().equals(other.carpoolOffers, carpoolOffers)&&(identical(other.isTrainer, isTrainer) || other.isTrainer == isTrainer)&&(identical(other.canAssignTeams, canAssignTeams) || other.canAssignTeams == canAssignTeams)&&const DeepCollectionEquality().equals(other.duties, duties)&&(identical(other.flag, flag) || other.flag == flag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,type,title,startsAt,endsAt,meetAt,venue,notes,isHome,competition,homeTeam,awayTeam,homeScore,awayScore,cancelledAt,live,const DeepCollectionEquality().hash(rsvpStatuses),sportlink,myStatus,myReason,canRsvp,canChange,counts,playerCounts,const DeepCollectionEquality().hash(players),hasLineup,lineupShared,motm,const DeepCollectionEquality().hash(carpoolOffers),isTrainer,canAssignTeams,const DeepCollectionEquality().hash(duties),flag]);

@override
String toString() {
  return 'EventDetail(id: $id, type: $type, title: $title, startsAt: $startsAt, endsAt: $endsAt, meetAt: $meetAt, venue: $venue, notes: $notes, isHome: $isHome, competition: $competition, homeTeam: $homeTeam, awayTeam: $awayTeam, homeScore: $homeScore, awayScore: $awayScore, cancelledAt: $cancelledAt, live: $live, rsvpStatuses: $rsvpStatuses, sportlink: $sportlink, myStatus: $myStatus, myReason: $myReason, canRsvp: $canRsvp, canChange: $canChange, counts: $counts, playerCounts: $playerCounts, players: $players, hasLineup: $hasLineup, lineupShared: $lineupShared, motm: $motm, carpoolOffers: $carpoolOffers, isTrainer: $isTrainer, canAssignTeams: $canAssignTeams, duties: $duties, flag: $flag)';
}


}

/// @nodoc
abstract mixin class $EventDetailCopyWith<$Res>  {
  factory $EventDetailCopyWith(EventDetail value, $Res Function(EventDetail) _then) = _$EventDetailCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(unknownEnumValue: EventType.unknown) EventType type, String title, DateTime startsAt, DateTime? endsAt, DateTime? meetAt, String? venue, String? notes, bool? isHome, String? competition, String? homeTeam, String? awayTeam, int? homeScore, int? awayScore, DateTime? cancelledAt, LiveState? live,@JsonKey(unknownEnumValue: AttendanceStatus.pending) List<AttendanceStatus> rsvpStatuses, SportlinkInfo? sportlink,@JsonKey(unknownEnumValue: AttendanceStatus.pending) AttendanceStatus? myStatus, String? myReason, bool canRsvp, bool canChange, AttendanceCounts counts, AttendanceCounts playerCounts, List<EventPlayer> players, bool hasLineup, bool lineupShared, MotmState? motm, List<CarpoolOffer>? carpoolOffers, bool isTrainer, bool canAssignTeams, List<EventDuty> duties, FlagDuty? flag
});


$LiveStateCopyWith<$Res>? get live;$SportlinkInfoCopyWith<$Res>? get sportlink;$AttendanceCountsCopyWith<$Res> get counts;$AttendanceCountsCopyWith<$Res> get playerCounts;$MotmStateCopyWith<$Res>? get motm;$FlagDutyCopyWith<$Res>? get flag;

}
/// @nodoc
class _$EventDetailCopyWithImpl<$Res>
    implements $EventDetailCopyWith<$Res> {
  _$EventDetailCopyWithImpl(this._self, this._then);

  final EventDetail _self;
  final $Res Function(EventDetail) _then;

/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? startsAt = null,Object? endsAt = freezed,Object? meetAt = freezed,Object? venue = freezed,Object? notes = freezed,Object? isHome = freezed,Object? competition = freezed,Object? homeTeam = freezed,Object? awayTeam = freezed,Object? homeScore = freezed,Object? awayScore = freezed,Object? cancelledAt = freezed,Object? live = freezed,Object? rsvpStatuses = null,Object? sportlink = freezed,Object? myStatus = freezed,Object? myReason = freezed,Object? canRsvp = null,Object? canChange = null,Object? counts = null,Object? playerCounts = null,Object? players = null,Object? hasLineup = null,Object? lineupShared = null,Object? motm = freezed,Object? carpoolOffers = freezed,Object? isTrainer = null,Object? canAssignTeams = null,Object? duties = null,Object? flag = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,meetAt: freezed == meetAt ? _self.meetAt : meetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isHome: freezed == isHome ? _self.isHome : isHome // ignore: cast_nullable_to_non_nullable
as bool?,competition: freezed == competition ? _self.competition : competition // ignore: cast_nullable_to_non_nullable
as String?,homeTeam: freezed == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String?,awayTeam: freezed == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String?,homeScore: freezed == homeScore ? _self.homeScore : homeScore // ignore: cast_nullable_to_non_nullable
as int?,awayScore: freezed == awayScore ? _self.awayScore : awayScore // ignore: cast_nullable_to_non_nullable
as int?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,live: freezed == live ? _self.live : live // ignore: cast_nullable_to_non_nullable
as LiveState?,rsvpStatuses: null == rsvpStatuses ? _self.rsvpStatuses : rsvpStatuses // ignore: cast_nullable_to_non_nullable
as List<AttendanceStatus>,sportlink: freezed == sportlink ? _self.sportlink : sportlink // ignore: cast_nullable_to_non_nullable
as SportlinkInfo?,myStatus: freezed == myStatus ? _self.myStatus : myStatus // ignore: cast_nullable_to_non_nullable
as AttendanceStatus?,myReason: freezed == myReason ? _self.myReason : myReason // ignore: cast_nullable_to_non_nullable
as String?,canRsvp: null == canRsvp ? _self.canRsvp : canRsvp // ignore: cast_nullable_to_non_nullable
as bool,canChange: null == canChange ? _self.canChange : canChange // ignore: cast_nullable_to_non_nullable
as bool,counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as AttendanceCounts,playerCounts: null == playerCounts ? _self.playerCounts : playerCounts // ignore: cast_nullable_to_non_nullable
as AttendanceCounts,players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<EventPlayer>,hasLineup: null == hasLineup ? _self.hasLineup : hasLineup // ignore: cast_nullable_to_non_nullable
as bool,lineupShared: null == lineupShared ? _self.lineupShared : lineupShared // ignore: cast_nullable_to_non_nullable
as bool,motm: freezed == motm ? _self.motm : motm // ignore: cast_nullable_to_non_nullable
as MotmState?,carpoolOffers: freezed == carpoolOffers ? _self.carpoolOffers : carpoolOffers // ignore: cast_nullable_to_non_nullable
as List<CarpoolOffer>?,isTrainer: null == isTrainer ? _self.isTrainer : isTrainer // ignore: cast_nullable_to_non_nullable
as bool,canAssignTeams: null == canAssignTeams ? _self.canAssignTeams : canAssignTeams // ignore: cast_nullable_to_non_nullable
as bool,duties: null == duties ? _self.duties : duties // ignore: cast_nullable_to_non_nullable
as List<EventDuty>,flag: freezed == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as FlagDuty?,
  ));
}
/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveStateCopyWith<$Res>? get live {
    if (_self.live == null) {
    return null;
  }

  return $LiveStateCopyWith<$Res>(_self.live!, (value) {
    return _then(_self.copyWith(live: value));
  });
}/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SportlinkInfoCopyWith<$Res>? get sportlink {
    if (_self.sportlink == null) {
    return null;
  }

  return $SportlinkInfoCopyWith<$Res>(_self.sportlink!, (value) {
    return _then(_self.copyWith(sportlink: value));
  });
}/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCountsCopyWith<$Res> get counts {
  
  return $AttendanceCountsCopyWith<$Res>(_self.counts, (value) {
    return _then(_self.copyWith(counts: value));
  });
}/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCountsCopyWith<$Res> get playerCounts {
  
  return $AttendanceCountsCopyWith<$Res>(_self.playerCounts, (value) {
    return _then(_self.copyWith(playerCounts: value));
  });
}/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MotmStateCopyWith<$Res>? get motm {
    if (_self.motm == null) {
    return null;
  }

  return $MotmStateCopyWith<$Res>(_self.motm!, (value) {
    return _then(_self.copyWith(motm: value));
  });
}/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FlagDutyCopyWith<$Res>? get flag {
    if (_self.flag == null) {
    return null;
  }

  return $FlagDutyCopyWith<$Res>(_self.flag!, (value) {
    return _then(_self.copyWith(flag: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventDetail].
extension EventDetailPatterns on EventDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventDetail value)  $default,){
final _that = this;
switch (_that) {
case _EventDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventDetail value)?  $default,){
final _that = this;
switch (_that) {
case _EventDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(unknownEnumValue: EventType.unknown)  EventType type,  String title,  DateTime startsAt,  DateTime? endsAt,  DateTime? meetAt,  String? venue,  String? notes,  bool? isHome,  String? competition,  String? homeTeam,  String? awayTeam,  int? homeScore,  int? awayScore,  DateTime? cancelledAt,  LiveState? live, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  List<AttendanceStatus> rsvpStatuses,  SportlinkInfo? sportlink, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  AttendanceStatus? myStatus,  String? myReason,  bool canRsvp,  bool canChange,  AttendanceCounts counts,  AttendanceCounts playerCounts,  List<EventPlayer> players,  bool hasLineup,  bool lineupShared,  MotmState? motm,  List<CarpoolOffer>? carpoolOffers,  bool isTrainer,  bool canAssignTeams,  List<EventDuty> duties,  FlagDuty? flag)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventDetail() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.endsAt,_that.meetAt,_that.venue,_that.notes,_that.isHome,_that.competition,_that.homeTeam,_that.awayTeam,_that.homeScore,_that.awayScore,_that.cancelledAt,_that.live,_that.rsvpStatuses,_that.sportlink,_that.myStatus,_that.myReason,_that.canRsvp,_that.canChange,_that.counts,_that.playerCounts,_that.players,_that.hasLineup,_that.lineupShared,_that.motm,_that.carpoolOffers,_that.isTrainer,_that.canAssignTeams,_that.duties,_that.flag);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(unknownEnumValue: EventType.unknown)  EventType type,  String title,  DateTime startsAt,  DateTime? endsAt,  DateTime? meetAt,  String? venue,  String? notes,  bool? isHome,  String? competition,  String? homeTeam,  String? awayTeam,  int? homeScore,  int? awayScore,  DateTime? cancelledAt,  LiveState? live, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  List<AttendanceStatus> rsvpStatuses,  SportlinkInfo? sportlink, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  AttendanceStatus? myStatus,  String? myReason,  bool canRsvp,  bool canChange,  AttendanceCounts counts,  AttendanceCounts playerCounts,  List<EventPlayer> players,  bool hasLineup,  bool lineupShared,  MotmState? motm,  List<CarpoolOffer>? carpoolOffers,  bool isTrainer,  bool canAssignTeams,  List<EventDuty> duties,  FlagDuty? flag)  $default,) {final _that = this;
switch (_that) {
case _EventDetail():
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.endsAt,_that.meetAt,_that.venue,_that.notes,_that.isHome,_that.competition,_that.homeTeam,_that.awayTeam,_that.homeScore,_that.awayScore,_that.cancelledAt,_that.live,_that.rsvpStatuses,_that.sportlink,_that.myStatus,_that.myReason,_that.canRsvp,_that.canChange,_that.counts,_that.playerCounts,_that.players,_that.hasLineup,_that.lineupShared,_that.motm,_that.carpoolOffers,_that.isTrainer,_that.canAssignTeams,_that.duties,_that.flag);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(unknownEnumValue: EventType.unknown)  EventType type,  String title,  DateTime startsAt,  DateTime? endsAt,  DateTime? meetAt,  String? venue,  String? notes,  bool? isHome,  String? competition,  String? homeTeam,  String? awayTeam,  int? homeScore,  int? awayScore,  DateTime? cancelledAt,  LiveState? live, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  List<AttendanceStatus> rsvpStatuses,  SportlinkInfo? sportlink, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  AttendanceStatus? myStatus,  String? myReason,  bool canRsvp,  bool canChange,  AttendanceCounts counts,  AttendanceCounts playerCounts,  List<EventPlayer> players,  bool hasLineup,  bool lineupShared,  MotmState? motm,  List<CarpoolOffer>? carpoolOffers,  bool isTrainer,  bool canAssignTeams,  List<EventDuty> duties,  FlagDuty? flag)?  $default,) {final _that = this;
switch (_that) {
case _EventDetail() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.endsAt,_that.meetAt,_that.venue,_that.notes,_that.isHome,_that.competition,_that.homeTeam,_that.awayTeam,_that.homeScore,_that.awayScore,_that.cancelledAt,_that.live,_that.rsvpStatuses,_that.sportlink,_that.myStatus,_that.myReason,_that.canRsvp,_that.canChange,_that.counts,_that.playerCounts,_that.players,_that.hasLineup,_that.lineupShared,_that.motm,_that.carpoolOffers,_that.isTrainer,_that.canAssignTeams,_that.duties,_that.flag);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventDetail extends EventDetail {
  const _EventDetail({required this.id, @JsonKey(unknownEnumValue: EventType.unknown) this.type = EventType.unknown, this.title = '', required this.startsAt, this.endsAt, this.meetAt, this.venue, this.notes, this.isHome, this.competition, this.homeTeam, this.awayTeam, this.homeScore, this.awayScore, this.cancelledAt, this.live, @JsonKey(unknownEnumValue: AttendanceStatus.pending) final  List<AttendanceStatus> rsvpStatuses = const <AttendanceStatus>[AttendanceStatus.present, AttendanceStatus.nonplay, AttendanceStatus.absent], this.sportlink, @JsonKey(unknownEnumValue: AttendanceStatus.pending) this.myStatus, this.myReason, this.canRsvp = false, this.canChange = false, this.counts = const AttendanceCounts(), this.playerCounts = const AttendanceCounts(), final  List<EventPlayer> players = const <EventPlayer>[], this.hasLineup = false, this.lineupShared = false, this.motm, final  List<CarpoolOffer>? carpoolOffers, this.isTrainer = false, this.canAssignTeams = false, final  List<EventDuty> duties = const <EventDuty>[], this.flag}): _rsvpStatuses = rsvpStatuses,_players = players,_carpoolOffers = carpoolOffers,_duties = duties,super._();
  factory _EventDetail.fromJson(Map<String, dynamic> json) => _$EventDetailFromJson(json);

@override final  int id;
@override@JsonKey(unknownEnumValue: EventType.unknown) final  EventType type;
@override@JsonKey() final  String title;
@override final  DateTime startsAt;
@override final  DateTime? endsAt;
@override final  DateTime? meetAt;
@override final  String? venue;
@override final  String? notes;
@override final  bool? isHome;
/// `league`, `cup`, `friendly` of `null`.
@override final  String? competition;
@override final  String? homeTeam;
@override final  String? awayTeam;
@override final  int? homeScore;
@override final  int? awayScore;
@override final  DateTime? cancelledAt;
@override final  LiveState? live;
 final  List<AttendanceStatus> _rsvpStatuses;
@override@JsonKey(unknownEnumValue: AttendanceStatus.pending) List<AttendanceStatus> get rsvpStatuses {
  if (_rsvpStatuses is EqualUnmodifiableListView) return _rsvpStatuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rsvpStatuses);
}

@override final  SportlinkInfo? sportlink;
@override@JsonKey(unknownEnumValue: AttendanceStatus.pending) final  AttendanceStatus? myStatus;
@override final  String? myReason;
@override@JsonKey() final  bool canRsvp;
@override@JsonKey() final  bool canChange;
@override@JsonKey() final  AttendanceCounts counts;
@override@JsonKey() final  AttendanceCounts playerCounts;
 final  List<EventPlayer> _players;
@override@JsonKey() List<EventPlayer> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}

@override@JsonKey() final  bool hasLineup;
@override@JsonKey() final  bool lineupShared;
@override final  MotmState? motm;
 final  List<CarpoolOffer>? _carpoolOffers;
@override List<CarpoolOffer>? get carpoolOffers {
  final value = _carpoolOffers;
  if (value == null) return null;
  if (_carpoolOffers is EqualUnmodifiableListView) return _carpoolOffers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey() final  bool isTrainer;
@override@JsonKey() final  bool canAssignTeams;
 final  List<EventDuty> _duties;
@override@JsonKey() List<EventDuty> get duties {
  if (_duties is EqualUnmodifiableListView) return _duties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_duties);
}

@override final  FlagDuty? flag;

/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventDetailCopyWith<_EventDetail> get copyWith => __$EventDetailCopyWithImpl<_EventDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.meetAt, meetAt) || other.meetAt == meetAt)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isHome, isHome) || other.isHome == isHome)&&(identical(other.competition, competition) || other.competition == competition)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.homeScore, homeScore) || other.homeScore == homeScore)&&(identical(other.awayScore, awayScore) || other.awayScore == awayScore)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.live, live) || other.live == live)&&const DeepCollectionEquality().equals(other._rsvpStatuses, _rsvpStatuses)&&(identical(other.sportlink, sportlink) || other.sportlink == sportlink)&&(identical(other.myStatus, myStatus) || other.myStatus == myStatus)&&(identical(other.myReason, myReason) || other.myReason == myReason)&&(identical(other.canRsvp, canRsvp) || other.canRsvp == canRsvp)&&(identical(other.canChange, canChange) || other.canChange == canChange)&&(identical(other.counts, counts) || other.counts == counts)&&(identical(other.playerCounts, playerCounts) || other.playerCounts == playerCounts)&&const DeepCollectionEquality().equals(other._players, _players)&&(identical(other.hasLineup, hasLineup) || other.hasLineup == hasLineup)&&(identical(other.lineupShared, lineupShared) || other.lineupShared == lineupShared)&&(identical(other.motm, motm) || other.motm == motm)&&const DeepCollectionEquality().equals(other._carpoolOffers, _carpoolOffers)&&(identical(other.isTrainer, isTrainer) || other.isTrainer == isTrainer)&&(identical(other.canAssignTeams, canAssignTeams) || other.canAssignTeams == canAssignTeams)&&const DeepCollectionEquality().equals(other._duties, _duties)&&(identical(other.flag, flag) || other.flag == flag));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,type,title,startsAt,endsAt,meetAt,venue,notes,isHome,competition,homeTeam,awayTeam,homeScore,awayScore,cancelledAt,live,const DeepCollectionEquality().hash(_rsvpStatuses),sportlink,myStatus,myReason,canRsvp,canChange,counts,playerCounts,const DeepCollectionEquality().hash(_players),hasLineup,lineupShared,motm,const DeepCollectionEquality().hash(_carpoolOffers),isTrainer,canAssignTeams,const DeepCollectionEquality().hash(_duties),flag]);

@override
String toString() {
  return 'EventDetail(id: $id, type: $type, title: $title, startsAt: $startsAt, endsAt: $endsAt, meetAt: $meetAt, venue: $venue, notes: $notes, isHome: $isHome, competition: $competition, homeTeam: $homeTeam, awayTeam: $awayTeam, homeScore: $homeScore, awayScore: $awayScore, cancelledAt: $cancelledAt, live: $live, rsvpStatuses: $rsvpStatuses, sportlink: $sportlink, myStatus: $myStatus, myReason: $myReason, canRsvp: $canRsvp, canChange: $canChange, counts: $counts, playerCounts: $playerCounts, players: $players, hasLineup: $hasLineup, lineupShared: $lineupShared, motm: $motm, carpoolOffers: $carpoolOffers, isTrainer: $isTrainer, canAssignTeams: $canAssignTeams, duties: $duties, flag: $flag)';
}


}

/// @nodoc
abstract mixin class _$EventDetailCopyWith<$Res> implements $EventDetailCopyWith<$Res> {
  factory _$EventDetailCopyWith(_EventDetail value, $Res Function(_EventDetail) _then) = __$EventDetailCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(unknownEnumValue: EventType.unknown) EventType type, String title, DateTime startsAt, DateTime? endsAt, DateTime? meetAt, String? venue, String? notes, bool? isHome, String? competition, String? homeTeam, String? awayTeam, int? homeScore, int? awayScore, DateTime? cancelledAt, LiveState? live,@JsonKey(unknownEnumValue: AttendanceStatus.pending) List<AttendanceStatus> rsvpStatuses, SportlinkInfo? sportlink,@JsonKey(unknownEnumValue: AttendanceStatus.pending) AttendanceStatus? myStatus, String? myReason, bool canRsvp, bool canChange, AttendanceCounts counts, AttendanceCounts playerCounts, List<EventPlayer> players, bool hasLineup, bool lineupShared, MotmState? motm, List<CarpoolOffer>? carpoolOffers, bool isTrainer, bool canAssignTeams, List<EventDuty> duties, FlagDuty? flag
});


@override $LiveStateCopyWith<$Res>? get live;@override $SportlinkInfoCopyWith<$Res>? get sportlink;@override $AttendanceCountsCopyWith<$Res> get counts;@override $AttendanceCountsCopyWith<$Res> get playerCounts;@override $MotmStateCopyWith<$Res>? get motm;@override $FlagDutyCopyWith<$Res>? get flag;

}
/// @nodoc
class __$EventDetailCopyWithImpl<$Res>
    implements _$EventDetailCopyWith<$Res> {
  __$EventDetailCopyWithImpl(this._self, this._then);

  final _EventDetail _self;
  final $Res Function(_EventDetail) _then;

/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? startsAt = null,Object? endsAt = freezed,Object? meetAt = freezed,Object? venue = freezed,Object? notes = freezed,Object? isHome = freezed,Object? competition = freezed,Object? homeTeam = freezed,Object? awayTeam = freezed,Object? homeScore = freezed,Object? awayScore = freezed,Object? cancelledAt = freezed,Object? live = freezed,Object? rsvpStatuses = null,Object? sportlink = freezed,Object? myStatus = freezed,Object? myReason = freezed,Object? canRsvp = null,Object? canChange = null,Object? counts = null,Object? playerCounts = null,Object? players = null,Object? hasLineup = null,Object? lineupShared = null,Object? motm = freezed,Object? carpoolOffers = freezed,Object? isTrainer = null,Object? canAssignTeams = null,Object? duties = null,Object? flag = freezed,}) {
  return _then(_EventDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,meetAt: freezed == meetAt ? _self.meetAt : meetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isHome: freezed == isHome ? _self.isHome : isHome // ignore: cast_nullable_to_non_nullable
as bool?,competition: freezed == competition ? _self.competition : competition // ignore: cast_nullable_to_non_nullable
as String?,homeTeam: freezed == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String?,awayTeam: freezed == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String?,homeScore: freezed == homeScore ? _self.homeScore : homeScore // ignore: cast_nullable_to_non_nullable
as int?,awayScore: freezed == awayScore ? _self.awayScore : awayScore // ignore: cast_nullable_to_non_nullable
as int?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,live: freezed == live ? _self.live : live // ignore: cast_nullable_to_non_nullable
as LiveState?,rsvpStatuses: null == rsvpStatuses ? _self._rsvpStatuses : rsvpStatuses // ignore: cast_nullable_to_non_nullable
as List<AttendanceStatus>,sportlink: freezed == sportlink ? _self.sportlink : sportlink // ignore: cast_nullable_to_non_nullable
as SportlinkInfo?,myStatus: freezed == myStatus ? _self.myStatus : myStatus // ignore: cast_nullable_to_non_nullable
as AttendanceStatus?,myReason: freezed == myReason ? _self.myReason : myReason // ignore: cast_nullable_to_non_nullable
as String?,canRsvp: null == canRsvp ? _self.canRsvp : canRsvp // ignore: cast_nullable_to_non_nullable
as bool,canChange: null == canChange ? _self.canChange : canChange // ignore: cast_nullable_to_non_nullable
as bool,counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as AttendanceCounts,playerCounts: null == playerCounts ? _self.playerCounts : playerCounts // ignore: cast_nullable_to_non_nullable
as AttendanceCounts,players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<EventPlayer>,hasLineup: null == hasLineup ? _self.hasLineup : hasLineup // ignore: cast_nullable_to_non_nullable
as bool,lineupShared: null == lineupShared ? _self.lineupShared : lineupShared // ignore: cast_nullable_to_non_nullable
as bool,motm: freezed == motm ? _self.motm : motm // ignore: cast_nullable_to_non_nullable
as MotmState?,carpoolOffers: freezed == carpoolOffers ? _self._carpoolOffers : carpoolOffers // ignore: cast_nullable_to_non_nullable
as List<CarpoolOffer>?,isTrainer: null == isTrainer ? _self.isTrainer : isTrainer // ignore: cast_nullable_to_non_nullable
as bool,canAssignTeams: null == canAssignTeams ? _self.canAssignTeams : canAssignTeams // ignore: cast_nullable_to_non_nullable
as bool,duties: null == duties ? _self._duties : duties // ignore: cast_nullable_to_non_nullable
as List<EventDuty>,flag: freezed == flag ? _self.flag : flag // ignore: cast_nullable_to_non_nullable
as FlagDuty?,
  ));
}

/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveStateCopyWith<$Res>? get live {
    if (_self.live == null) {
    return null;
  }

  return $LiveStateCopyWith<$Res>(_self.live!, (value) {
    return _then(_self.copyWith(live: value));
  });
}/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SportlinkInfoCopyWith<$Res>? get sportlink {
    if (_self.sportlink == null) {
    return null;
  }

  return $SportlinkInfoCopyWith<$Res>(_self.sportlink!, (value) {
    return _then(_self.copyWith(sportlink: value));
  });
}/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCountsCopyWith<$Res> get counts {
  
  return $AttendanceCountsCopyWith<$Res>(_self.counts, (value) {
    return _then(_self.copyWith(counts: value));
  });
}/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCountsCopyWith<$Res> get playerCounts {
  
  return $AttendanceCountsCopyWith<$Res>(_self.playerCounts, (value) {
    return _then(_self.copyWith(playerCounts: value));
  });
}/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MotmStateCopyWith<$Res>? get motm {
    if (_self.motm == null) {
    return null;
  }

  return $MotmStateCopyWith<$Res>(_self.motm!, (value) {
    return _then(_self.copyWith(motm: value));
  });
}/// Create a copy of EventDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FlagDutyCopyWith<$Res>? get flag {
    if (_self.flag == null) {
    return null;
  }

  return $FlagDutyCopyWith<$Res>(_self.flag!, (value) {
    return _then(_self.copyWith(flag: value));
  });
}
}

// dart format on
