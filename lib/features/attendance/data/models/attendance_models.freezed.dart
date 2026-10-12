// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceEvent {

 int get id;/// `match`, `training` of `activity` (ruw, zodat een onbekend type niet
/// breekt).
 String get type; String get title; DateTime? get startsAt; DateTime? get cancelledAt; bool get canEdit;
/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceEventCopyWith<AttendanceEvent> get copyWith => _$AttendanceEventCopyWithImpl<AttendanceEvent>(this as AttendanceEvent, _$identity);

  /// Serializes this AttendanceEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.canEdit, canEdit) || other.canEdit == canEdit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,startsAt,cancelledAt,canEdit);

@override
String toString() {
  return 'AttendanceEvent(id: $id, type: $type, title: $title, startsAt: $startsAt, cancelledAt: $cancelledAt, canEdit: $canEdit)';
}


}

/// @nodoc
abstract mixin class $AttendanceEventCopyWith<$Res>  {
  factory $AttendanceEventCopyWith(AttendanceEvent value, $Res Function(AttendanceEvent) _then) = _$AttendanceEventCopyWithImpl;
@useResult
$Res call({
 int id, String type, String title, DateTime? startsAt, DateTime? cancelledAt, bool canEdit
});




}
/// @nodoc
class _$AttendanceEventCopyWithImpl<$Res>
    implements $AttendanceEventCopyWith<$Res> {
  _$AttendanceEventCopyWithImpl(this._self, this._then);

  final AttendanceEvent _self;
  final $Res Function(AttendanceEvent) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? startsAt = freezed,Object? cancelledAt = freezed,Object? canEdit = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,canEdit: null == canEdit ? _self.canEdit : canEdit // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceEvent].
extension AttendanceEventPatterns on AttendanceEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceEvent value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceEvent value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type,  String title,  DateTime? startsAt,  DateTime? cancelledAt,  bool canEdit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceEvent() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.cancelledAt,_that.canEdit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type,  String title,  DateTime? startsAt,  DateTime? cancelledAt,  bool canEdit)  $default,) {final _that = this;
switch (_that) {
case _AttendanceEvent():
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.cancelledAt,_that.canEdit);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type,  String title,  DateTime? startsAt,  DateTime? cancelledAt,  bool canEdit)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceEvent() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.cancelledAt,_that.canEdit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceEvent extends AttendanceEvent {
  const _AttendanceEvent({required this.id, this.type = '', this.title = '', this.startsAt, this.cancelledAt, this.canEdit = false}): super._();
  factory _AttendanceEvent.fromJson(Map<String, dynamic> json) => _$AttendanceEventFromJson(json);

@override final  int id;
/// `match`, `training` of `activity` (ruw, zodat een onbekend type niet
/// breekt).
@override@JsonKey() final  String type;
@override@JsonKey() final  String title;
@override final  DateTime? startsAt;
@override final  DateTime? cancelledAt;
@override@JsonKey() final  bool canEdit;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceEventCopyWith<_AttendanceEvent> get copyWith => __$AttendanceEventCopyWithImpl<_AttendanceEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.canEdit, canEdit) || other.canEdit == canEdit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,startsAt,cancelledAt,canEdit);

@override
String toString() {
  return 'AttendanceEvent(id: $id, type: $type, title: $title, startsAt: $startsAt, cancelledAt: $cancelledAt, canEdit: $canEdit)';
}


}

/// @nodoc
abstract mixin class _$AttendanceEventCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory _$AttendanceEventCopyWith(_AttendanceEvent value, $Res Function(_AttendanceEvent) _then) = __$AttendanceEventCopyWithImpl;
@override @useResult
$Res call({
 int id, String type, String title, DateTime? startsAt, DateTime? cancelledAt, bool canEdit
});




}
/// @nodoc
class __$AttendanceEventCopyWithImpl<$Res>
    implements _$AttendanceEventCopyWith<$Res> {
  __$AttendanceEventCopyWithImpl(this._self, this._then);

  final _AttendanceEvent _self;
  final $Res Function(_AttendanceEvent) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? startsAt = freezed,Object? cancelledAt = freezed,Object? canEdit = null,}) {
  return _then(_AttendanceEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,canEdit: null == canEdit ? _self.canEdit : canEdit // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AttendanceRow {

@JsonKey(unknownEnumValue: AttendanceRowKind.unknown) AttendanceRowKind get kind; int? get playerId; int? get userId; int? get shirtNumber; String get name;/// Positiecode uit het sportprofiel (bij staf een label).
 String get position; String? get avatarUrl; bool get isGuest;@JsonKey(unknownEnumValue: AttendanceStatus.pending) AttendanceStatus get status; String? get vacationNote; bool get standingAbsent;
/// Create a copy of AttendanceRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceRowCopyWith<AttendanceRow> get copyWith => _$AttendanceRowCopyWithImpl<AttendanceRow>(this as AttendanceRow, _$identity);

  /// Serializes this AttendanceRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceRow&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.status, status) || other.status == status)&&(identical(other.vacationNote, vacationNote) || other.vacationNote == vacationNote)&&(identical(other.standingAbsent, standingAbsent) || other.standingAbsent == standingAbsent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,playerId,userId,shirtNumber,name,position,avatarUrl,isGuest,status,vacationNote,standingAbsent);

@override
String toString() {
  return 'AttendanceRow(kind: $kind, playerId: $playerId, userId: $userId, shirtNumber: $shirtNumber, name: $name, position: $position, avatarUrl: $avatarUrl, isGuest: $isGuest, status: $status, vacationNote: $vacationNote, standingAbsent: $standingAbsent)';
}


}

/// @nodoc
abstract mixin class $AttendanceRowCopyWith<$Res>  {
  factory $AttendanceRowCopyWith(AttendanceRow value, $Res Function(AttendanceRow) _then) = _$AttendanceRowCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: AttendanceRowKind.unknown) AttendanceRowKind kind, int? playerId, int? userId, int? shirtNumber, String name, String position, String? avatarUrl, bool isGuest,@JsonKey(unknownEnumValue: AttendanceStatus.pending) AttendanceStatus status, String? vacationNote, bool standingAbsent
});




}
/// @nodoc
class _$AttendanceRowCopyWithImpl<$Res>
    implements $AttendanceRowCopyWith<$Res> {
  _$AttendanceRowCopyWithImpl(this._self, this._then);

  final AttendanceRow _self;
  final $Res Function(AttendanceRow) _then;

/// Create a copy of AttendanceRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? playerId = freezed,Object? userId = freezed,Object? shirtNumber = freezed,Object? name = null,Object? position = null,Object? avatarUrl = freezed,Object? isGuest = null,Object? status = null,Object? vacationNote = freezed,Object? standingAbsent = null,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AttendanceRowKind,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttendanceStatus,vacationNote: freezed == vacationNote ? _self.vacationNote : vacationNote // ignore: cast_nullable_to_non_nullable
as String?,standingAbsent: null == standingAbsent ? _self.standingAbsent : standingAbsent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceRow].
extension AttendanceRowPatterns on AttendanceRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceRow value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceRow value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: AttendanceRowKind.unknown)  AttendanceRowKind kind,  int? playerId,  int? userId,  int? shirtNumber,  String name,  String position,  String? avatarUrl,  bool isGuest, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  AttendanceStatus status,  String? vacationNote,  bool standingAbsent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceRow() when $default != null:
return $default(_that.kind,_that.playerId,_that.userId,_that.shirtNumber,_that.name,_that.position,_that.avatarUrl,_that.isGuest,_that.status,_that.vacationNote,_that.standingAbsent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: AttendanceRowKind.unknown)  AttendanceRowKind kind,  int? playerId,  int? userId,  int? shirtNumber,  String name,  String position,  String? avatarUrl,  bool isGuest, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  AttendanceStatus status,  String? vacationNote,  bool standingAbsent)  $default,) {final _that = this;
switch (_that) {
case _AttendanceRow():
return $default(_that.kind,_that.playerId,_that.userId,_that.shirtNumber,_that.name,_that.position,_that.avatarUrl,_that.isGuest,_that.status,_that.vacationNote,_that.standingAbsent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: AttendanceRowKind.unknown)  AttendanceRowKind kind,  int? playerId,  int? userId,  int? shirtNumber,  String name,  String position,  String? avatarUrl,  bool isGuest, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  AttendanceStatus status,  String? vacationNote,  bool standingAbsent)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceRow() when $default != null:
return $default(_that.kind,_that.playerId,_that.userId,_that.shirtNumber,_that.name,_that.position,_that.avatarUrl,_that.isGuest,_that.status,_that.vacationNote,_that.standingAbsent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceRow extends AttendanceRow {
  const _AttendanceRow({@JsonKey(unknownEnumValue: AttendanceRowKind.unknown) this.kind = AttendanceRowKind.player, this.playerId, this.userId, this.shirtNumber, this.name = '', this.position = '', this.avatarUrl, this.isGuest = false, @JsonKey(unknownEnumValue: AttendanceStatus.pending) this.status = AttendanceStatus.pending, this.vacationNote, this.standingAbsent = false}): super._();
  factory _AttendanceRow.fromJson(Map<String, dynamic> json) => _$AttendanceRowFromJson(json);

@override@JsonKey(unknownEnumValue: AttendanceRowKind.unknown) final  AttendanceRowKind kind;
@override final  int? playerId;
@override final  int? userId;
@override final  int? shirtNumber;
@override@JsonKey() final  String name;
/// Positiecode uit het sportprofiel (bij staf een label).
@override@JsonKey() final  String position;
@override final  String? avatarUrl;
@override@JsonKey() final  bool isGuest;
@override@JsonKey(unknownEnumValue: AttendanceStatus.pending) final  AttendanceStatus status;
@override final  String? vacationNote;
@override@JsonKey() final  bool standingAbsent;

/// Create a copy of AttendanceRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceRowCopyWith<_AttendanceRow> get copyWith => __$AttendanceRowCopyWithImpl<_AttendanceRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceRow&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.status, status) || other.status == status)&&(identical(other.vacationNote, vacationNote) || other.vacationNote == vacationNote)&&(identical(other.standingAbsent, standingAbsent) || other.standingAbsent == standingAbsent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,playerId,userId,shirtNumber,name,position,avatarUrl,isGuest,status,vacationNote,standingAbsent);

@override
String toString() {
  return 'AttendanceRow(kind: $kind, playerId: $playerId, userId: $userId, shirtNumber: $shirtNumber, name: $name, position: $position, avatarUrl: $avatarUrl, isGuest: $isGuest, status: $status, vacationNote: $vacationNote, standingAbsent: $standingAbsent)';
}


}

/// @nodoc
abstract mixin class _$AttendanceRowCopyWith<$Res> implements $AttendanceRowCopyWith<$Res> {
  factory _$AttendanceRowCopyWith(_AttendanceRow value, $Res Function(_AttendanceRow) _then) = __$AttendanceRowCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: AttendanceRowKind.unknown) AttendanceRowKind kind, int? playerId, int? userId, int? shirtNumber, String name, String position, String? avatarUrl, bool isGuest,@JsonKey(unknownEnumValue: AttendanceStatus.pending) AttendanceStatus status, String? vacationNote, bool standingAbsent
});




}
/// @nodoc
class __$AttendanceRowCopyWithImpl<$Res>
    implements _$AttendanceRowCopyWith<$Res> {
  __$AttendanceRowCopyWithImpl(this._self, this._then);

  final _AttendanceRow _self;
  final $Res Function(_AttendanceRow) _then;

/// Create a copy of AttendanceRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? playerId = freezed,Object? userId = freezed,Object? shirtNumber = freezed,Object? name = null,Object? position = null,Object? avatarUrl = freezed,Object? isGuest = null,Object? status = null,Object? vacationNote = freezed,Object? standingAbsent = null,}) {
  return _then(_AttendanceRow(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as AttendanceRowKind,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttendanceStatus,vacationNote: freezed == vacationNote ? _self.vacationNote : vacationNote // ignore: cast_nullable_to_non_nullable
as String?,standingAbsent: null == standingAbsent ? _self.standingAbsent : standingAbsent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$EventAttendance {

 AttendanceEvent get event; List<AttendanceRow> get rows;
/// Create a copy of EventAttendance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventAttendanceCopyWith<EventAttendance> get copyWith => _$EventAttendanceCopyWithImpl<EventAttendance>(this as EventAttendance, _$identity);

  /// Serializes this EventAttendance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EventAttendance&&(identical(other.event, event) || other.event == event)&&const DeepCollectionEquality().equals(other.rows, rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,event,const DeepCollectionEquality().hash(rows));

@override
String toString() {
  return 'EventAttendance(event: $event, rows: $rows)';
}


}

/// @nodoc
abstract mixin class $EventAttendanceCopyWith<$Res>  {
  factory $EventAttendanceCopyWith(EventAttendance value, $Res Function(EventAttendance) _then) = _$EventAttendanceCopyWithImpl;
@useResult
$Res call({
 AttendanceEvent event, List<AttendanceRow> rows
});


$AttendanceEventCopyWith<$Res> get event;

}
/// @nodoc
class _$EventAttendanceCopyWithImpl<$Res>
    implements $EventAttendanceCopyWith<$Res> {
  _$EventAttendanceCopyWithImpl(this._self, this._then);

  final EventAttendance _self;
  final $Res Function(EventAttendance) _then;

/// Create a copy of EventAttendance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? event = null,Object? rows = null,}) {
  return _then(_self.copyWith(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as AttendanceEvent,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as List<AttendanceRow>,
  ));
}
/// Create a copy of EventAttendance
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceEventCopyWith<$Res> get event {
  
  return $AttendanceEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// Adds pattern-matching-related methods to [EventAttendance].
extension EventAttendancePatterns on EventAttendance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EventAttendance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EventAttendance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EventAttendance value)  $default,){
final _that = this;
switch (_that) {
case _EventAttendance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EventAttendance value)?  $default,){
final _that = this;
switch (_that) {
case _EventAttendance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AttendanceEvent event,  List<AttendanceRow> rows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EventAttendance() when $default != null:
return $default(_that.event,_that.rows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AttendanceEvent event,  List<AttendanceRow> rows)  $default,) {final _that = this;
switch (_that) {
case _EventAttendance():
return $default(_that.event,_that.rows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AttendanceEvent event,  List<AttendanceRow> rows)?  $default,) {final _that = this;
switch (_that) {
case _EventAttendance() when $default != null:
return $default(_that.event,_that.rows);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EventAttendance extends EventAttendance {
  const _EventAttendance({required this.event, final  List<AttendanceRow> rows = const <AttendanceRow>[]}): _rows = rows,super._();
  factory _EventAttendance.fromJson(Map<String, dynamic> json) => _$EventAttendanceFromJson(json);

@override final  AttendanceEvent event;
 final  List<AttendanceRow> _rows;
@override@JsonKey() List<AttendanceRow> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}


/// Create a copy of EventAttendance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventAttendanceCopyWith<_EventAttendance> get copyWith => __$EventAttendanceCopyWithImpl<_EventAttendance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventAttendanceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EventAttendance&&(identical(other.event, event) || other.event == event)&&const DeepCollectionEquality().equals(other._rows, _rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,event,const DeepCollectionEquality().hash(_rows));

@override
String toString() {
  return 'EventAttendance(event: $event, rows: $rows)';
}


}

/// @nodoc
abstract mixin class _$EventAttendanceCopyWith<$Res> implements $EventAttendanceCopyWith<$Res> {
  factory _$EventAttendanceCopyWith(_EventAttendance value, $Res Function(_EventAttendance) _then) = __$EventAttendanceCopyWithImpl;
@override @useResult
$Res call({
 AttendanceEvent event, List<AttendanceRow> rows
});


@override $AttendanceEventCopyWith<$Res> get event;

}
/// @nodoc
class __$EventAttendanceCopyWithImpl<$Res>
    implements _$EventAttendanceCopyWith<$Res> {
  __$EventAttendanceCopyWithImpl(this._self, this._then);

  final _EventAttendance _self;
  final $Res Function(_EventAttendance) _then;

/// Create a copy of EventAttendance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? event = null,Object? rows = null,}) {
  return _then(_EventAttendance(
event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as AttendanceEvent,rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<AttendanceRow>,
  ));
}

/// Create a copy of EventAttendance
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceEventCopyWith<$Res> get event {
  
  return $AttendanceEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// @nodoc
mixin _$GuestOption {

 int get id; String get name; int? get shirtNumber; String? get position;
/// Create a copy of GuestOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuestOptionCopyWith<GuestOption> get copyWith => _$GuestOptionCopyWithImpl<GuestOption>(this as GuestOption, _$identity);

  /// Serializes this GuestOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuestOption&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber,position);

@override
String toString() {
  return 'GuestOption(id: $id, name: $name, shirtNumber: $shirtNumber, position: $position)';
}


}

/// @nodoc
abstract mixin class $GuestOptionCopyWith<$Res>  {
  factory $GuestOptionCopyWith(GuestOption value, $Res Function(GuestOption) _then) = _$GuestOptionCopyWithImpl;
@useResult
$Res call({
 int id, String name, int? shirtNumber, String? position
});




}
/// @nodoc
class _$GuestOptionCopyWithImpl<$Res>
    implements $GuestOptionCopyWith<$Res> {
  _$GuestOptionCopyWithImpl(this._self, this._then);

  final GuestOption _self;
  final $Res Function(GuestOption) _then;

/// Create a copy of GuestOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,Object? position = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GuestOption].
extension GuestOptionPatterns on GuestOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GuestOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GuestOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GuestOption value)  $default,){
final _that = this;
switch (_that) {
case _GuestOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GuestOption value)?  $default,){
final _that = this;
switch (_that) {
case _GuestOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int? shirtNumber,  String? position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GuestOption() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int? shirtNumber,  String? position)  $default,) {final _that = this;
switch (_that) {
case _GuestOption():
return $default(_that.id,_that.name,_that.shirtNumber,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int? shirtNumber,  String? position)?  $default,) {final _that = this;
switch (_that) {
case _GuestOption() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GuestOption implements GuestOption {
  const _GuestOption({required this.id, this.name = '', this.shirtNumber, this.position});
  factory _GuestOption.fromJson(Map<String, dynamic> json) => _$GuestOptionFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  int? shirtNumber;
@override final  String? position;

/// Create a copy of GuestOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GuestOptionCopyWith<_GuestOption> get copyWith => __$GuestOptionCopyWithImpl<_GuestOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GuestOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GuestOption&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber,position);

@override
String toString() {
  return 'GuestOption(id: $id, name: $name, shirtNumber: $shirtNumber, position: $position)';
}


}

/// @nodoc
abstract mixin class _$GuestOptionCopyWith<$Res> implements $GuestOptionCopyWith<$Res> {
  factory _$GuestOptionCopyWith(_GuestOption value, $Res Function(_GuestOption) _then) = __$GuestOptionCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int? shirtNumber, String? position
});




}
/// @nodoc
class __$GuestOptionCopyWithImpl<$Res>
    implements _$GuestOptionCopyWith<$Res> {
  __$GuestOptionCopyWithImpl(this._self, this._then);

  final _GuestOption _self;
  final $Res Function(_GuestOption) _then;

/// Create a copy of GuestOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,Object? position = freezed,}) {
  return _then(_GuestOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GuestPlayer {

 int get id; int? get shirtNumber; String get name; String? get position; bool get isGuest; String? get fromTeam;
/// Create a copy of GuestPlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuestPlayerCopyWith<GuestPlayer> get copyWith => _$GuestPlayerCopyWithImpl<GuestPlayer>(this as GuestPlayer, _$identity);

  /// Serializes this GuestPlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuestPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.fromTeam, fromTeam) || other.fromTeam == fromTeam));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shirtNumber,name,position,isGuest,fromTeam);

@override
String toString() {
  return 'GuestPlayer(id: $id, shirtNumber: $shirtNumber, name: $name, position: $position, isGuest: $isGuest, fromTeam: $fromTeam)';
}


}

/// @nodoc
abstract mixin class $GuestPlayerCopyWith<$Res>  {
  factory $GuestPlayerCopyWith(GuestPlayer value, $Res Function(GuestPlayer) _then) = _$GuestPlayerCopyWithImpl;
@useResult
$Res call({
 int id, int? shirtNumber, String name, String? position, bool isGuest, String? fromTeam
});




}
/// @nodoc
class _$GuestPlayerCopyWithImpl<$Res>
    implements $GuestPlayerCopyWith<$Res> {
  _$GuestPlayerCopyWithImpl(this._self, this._then);

  final GuestPlayer _self;
  final $Res Function(GuestPlayer) _then;

/// Create a copy of GuestPlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? shirtNumber = freezed,Object? name = null,Object? position = freezed,Object? isGuest = null,Object? fromTeam = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,fromTeam: freezed == fromTeam ? _self.fromTeam : fromTeam // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GuestPlayer].
extension GuestPlayerPatterns on GuestPlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GuestPlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GuestPlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GuestPlayer value)  $default,){
final _that = this;
switch (_that) {
case _GuestPlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GuestPlayer value)?  $default,){
final _that = this;
switch (_that) {
case _GuestPlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? shirtNumber,  String name,  String? position,  bool isGuest,  String? fromTeam)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GuestPlayer() when $default != null:
return $default(_that.id,_that.shirtNumber,_that.name,_that.position,_that.isGuest,_that.fromTeam);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? shirtNumber,  String name,  String? position,  bool isGuest,  String? fromTeam)  $default,) {final _that = this;
switch (_that) {
case _GuestPlayer():
return $default(_that.id,_that.shirtNumber,_that.name,_that.position,_that.isGuest,_that.fromTeam);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? shirtNumber,  String name,  String? position,  bool isGuest,  String? fromTeam)?  $default,) {final _that = this;
switch (_that) {
case _GuestPlayer() when $default != null:
return $default(_that.id,_that.shirtNumber,_that.name,_that.position,_that.isGuest,_that.fromTeam);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GuestPlayer implements GuestPlayer {
  const _GuestPlayer({required this.id, this.shirtNumber, this.name = '', this.position, this.isGuest = true, this.fromTeam});
  factory _GuestPlayer.fromJson(Map<String, dynamic> json) => _$GuestPlayerFromJson(json);

@override final  int id;
@override final  int? shirtNumber;
@override@JsonKey() final  String name;
@override final  String? position;
@override@JsonKey() final  bool isGuest;
@override final  String? fromTeam;

/// Create a copy of GuestPlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GuestPlayerCopyWith<_GuestPlayer> get copyWith => __$GuestPlayerCopyWithImpl<_GuestPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GuestPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GuestPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.fromTeam, fromTeam) || other.fromTeam == fromTeam));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,shirtNumber,name,position,isGuest,fromTeam);

@override
String toString() {
  return 'GuestPlayer(id: $id, shirtNumber: $shirtNumber, name: $name, position: $position, isGuest: $isGuest, fromTeam: $fromTeam)';
}


}

/// @nodoc
abstract mixin class _$GuestPlayerCopyWith<$Res> implements $GuestPlayerCopyWith<$Res> {
  factory _$GuestPlayerCopyWith(_GuestPlayer value, $Res Function(_GuestPlayer) _then) = __$GuestPlayerCopyWithImpl;
@override @useResult
$Res call({
 int id, int? shirtNumber, String name, String? position, bool isGuest, String? fromTeam
});




}
/// @nodoc
class __$GuestPlayerCopyWithImpl<$Res>
    implements _$GuestPlayerCopyWith<$Res> {
  __$GuestPlayerCopyWithImpl(this._self, this._then);

  final _GuestPlayer _self;
  final $Res Function(_GuestPlayer) _then;

/// Create a copy of GuestPlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? shirtNumber = freezed,Object? name = null,Object? position = freezed,Object? isGuest = null,Object? fromTeam = freezed,}) {
  return _then(_GuestPlayer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,fromTeam: freezed == fromTeam ? _self.fromTeam : fromTeam // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
