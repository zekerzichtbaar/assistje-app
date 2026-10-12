// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fines_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FinePeriod {

 int get id; String get name; DateTime? get startsOn; DateTime? get endsOn; DateTime? get closedAt;
/// Create a copy of FinePeriod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinePeriodCopyWith<FinePeriod> get copyWith => _$FinePeriodCopyWithImpl<FinePeriod>(this as FinePeriod, _$identity);

  /// Serializes this FinePeriod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinePeriod&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startsOn,endsOn,closedAt);

@override
String toString() {
  return 'FinePeriod(id: $id, name: $name, startsOn: $startsOn, endsOn: $endsOn, closedAt: $closedAt)';
}


}

/// @nodoc
abstract mixin class $FinePeriodCopyWith<$Res>  {
  factory $FinePeriodCopyWith(FinePeriod value, $Res Function(FinePeriod) _then) = _$FinePeriodCopyWithImpl;
@useResult
$Res call({
 int id, String name, DateTime? startsOn, DateTime? endsOn, DateTime? closedAt
});




}
/// @nodoc
class _$FinePeriodCopyWithImpl<$Res>
    implements $FinePeriodCopyWith<$Res> {
  _$FinePeriodCopyWithImpl(this._self, this._then);

  final FinePeriod _self;
  final $Res Function(FinePeriod) _then;

/// Create a copy of FinePeriod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? startsOn = freezed,Object? endsOn = freezed,Object? closedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startsOn: freezed == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime?,endsOn: freezed == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FinePeriod].
extension FinePeriodPatterns on FinePeriod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinePeriod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinePeriod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinePeriod value)  $default,){
final _that = this;
switch (_that) {
case _FinePeriod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinePeriod value)?  $default,){
final _that = this;
switch (_that) {
case _FinePeriod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  DateTime? startsOn,  DateTime? endsOn,  DateTime? closedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinePeriod() when $default != null:
return $default(_that.id,_that.name,_that.startsOn,_that.endsOn,_that.closedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  DateTime? startsOn,  DateTime? endsOn,  DateTime? closedAt)  $default,) {final _that = this;
switch (_that) {
case _FinePeriod():
return $default(_that.id,_that.name,_that.startsOn,_that.endsOn,_that.closedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  DateTime? startsOn,  DateTime? endsOn,  DateTime? closedAt)?  $default,) {final _that = this;
switch (_that) {
case _FinePeriod() when $default != null:
return $default(_that.id,_that.name,_that.startsOn,_that.endsOn,_that.closedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FinePeriod extends FinePeriod {
  const _FinePeriod({required this.id, this.name = '', this.startsOn, this.endsOn, this.closedAt}): super._();
  factory _FinePeriod.fromJson(Map<String, dynamic> json) => _$FinePeriodFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  DateTime? startsOn;
@override final  DateTime? endsOn;
@override final  DateTime? closedAt;

/// Create a copy of FinePeriod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinePeriodCopyWith<_FinePeriod> get copyWith => __$FinePeriodCopyWithImpl<_FinePeriod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FinePeriodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinePeriod&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startsOn,endsOn,closedAt);

@override
String toString() {
  return 'FinePeriod(id: $id, name: $name, startsOn: $startsOn, endsOn: $endsOn, closedAt: $closedAt)';
}


}

/// @nodoc
abstract mixin class _$FinePeriodCopyWith<$Res> implements $FinePeriodCopyWith<$Res> {
  factory _$FinePeriodCopyWith(_FinePeriod value, $Res Function(_FinePeriod) _then) = __$FinePeriodCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, DateTime? startsOn, DateTime? endsOn, DateTime? closedAt
});




}
/// @nodoc
class __$FinePeriodCopyWithImpl<$Res>
    implements _$FinePeriodCopyWith<$Res> {
  __$FinePeriodCopyWithImpl(this._self, this._then);

  final _FinePeriod _self;
  final $Res Function(_FinePeriod) _then;

/// Create a copy of FinePeriod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? startsOn = freezed,Object? endsOn = freezed,Object? closedAt = freezed,}) {
  return _then(_FinePeriod(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startsOn: freezed == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime?,endsOn: freezed == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as DateTime?,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$FineRow {

/// `p<player_id>` of `u<user_id>`.
 String get key; int? get playerId; int? get userId; String get name; int? get shirtNumber; String? get avatarUrl; bool get isStaff;/// Telt mee voor nieuwe boetes.
 bool get counting; int get totalCents; int get openCents; int get count;
/// Create a copy of FineRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FineRowCopyWith<FineRow> get copyWith => _$FineRowCopyWithImpl<FineRow>(this as FineRow, _$identity);

  /// Serializes this FineRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FineRow&&(identical(other.key, key) || other.key == key)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isStaff, isStaff) || other.isStaff == isStaff)&&(identical(other.counting, counting) || other.counting == counting)&&(identical(other.totalCents, totalCents) || other.totalCents == totalCents)&&(identical(other.openCents, openCents) || other.openCents == openCents)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,playerId,userId,name,shirtNumber,avatarUrl,isStaff,counting,totalCents,openCents,count);

@override
String toString() {
  return 'FineRow(key: $key, playerId: $playerId, userId: $userId, name: $name, shirtNumber: $shirtNumber, avatarUrl: $avatarUrl, isStaff: $isStaff, counting: $counting, totalCents: $totalCents, openCents: $openCents, count: $count)';
}


}

/// @nodoc
abstract mixin class $FineRowCopyWith<$Res>  {
  factory $FineRowCopyWith(FineRow value, $Res Function(FineRow) _then) = _$FineRowCopyWithImpl;
@useResult
$Res call({
 String key, int? playerId, int? userId, String name, int? shirtNumber, String? avatarUrl, bool isStaff, bool counting, int totalCents, int openCents, int count
});




}
/// @nodoc
class _$FineRowCopyWithImpl<$Res>
    implements $FineRowCopyWith<$Res> {
  _$FineRowCopyWithImpl(this._self, this._then);

  final FineRow _self;
  final $Res Function(FineRow) _then;

/// Create a copy of FineRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? playerId = freezed,Object? userId = freezed,Object? name = null,Object? shirtNumber = freezed,Object? avatarUrl = freezed,Object? isStaff = null,Object? counting = null,Object? totalCents = null,Object? openCents = null,Object? count = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isStaff: null == isStaff ? _self.isStaff : isStaff // ignore: cast_nullable_to_non_nullable
as bool,counting: null == counting ? _self.counting : counting // ignore: cast_nullable_to_non_nullable
as bool,totalCents: null == totalCents ? _self.totalCents : totalCents // ignore: cast_nullable_to_non_nullable
as int,openCents: null == openCents ? _self.openCents : openCents // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FineRow].
extension FineRowPatterns on FineRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FineRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FineRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FineRow value)  $default,){
final _that = this;
switch (_that) {
case _FineRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FineRow value)?  $default,){
final _that = this;
switch (_that) {
case _FineRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  int? playerId,  int? userId,  String name,  int? shirtNumber,  String? avatarUrl,  bool isStaff,  bool counting,  int totalCents,  int openCents,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FineRow() when $default != null:
return $default(_that.key,_that.playerId,_that.userId,_that.name,_that.shirtNumber,_that.avatarUrl,_that.isStaff,_that.counting,_that.totalCents,_that.openCents,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  int? playerId,  int? userId,  String name,  int? shirtNumber,  String? avatarUrl,  bool isStaff,  bool counting,  int totalCents,  int openCents,  int count)  $default,) {final _that = this;
switch (_that) {
case _FineRow():
return $default(_that.key,_that.playerId,_that.userId,_that.name,_that.shirtNumber,_that.avatarUrl,_that.isStaff,_that.counting,_that.totalCents,_that.openCents,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  int? playerId,  int? userId,  String name,  int? shirtNumber,  String? avatarUrl,  bool isStaff,  bool counting,  int totalCents,  int openCents,  int count)?  $default,) {final _that = this;
switch (_that) {
case _FineRow() when $default != null:
return $default(_that.key,_that.playerId,_that.userId,_that.name,_that.shirtNumber,_that.avatarUrl,_that.isStaff,_that.counting,_that.totalCents,_that.openCents,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FineRow extends FineRow {
  const _FineRow({required this.key, this.playerId, this.userId, this.name = '', this.shirtNumber, this.avatarUrl, this.isStaff = false, this.counting = true, this.totalCents = 0, this.openCents = 0, this.count = 0}): super._();
  factory _FineRow.fromJson(Map<String, dynamic> json) => _$FineRowFromJson(json);

/// `p<player_id>` of `u<user_id>`.
@override final  String key;
@override final  int? playerId;
@override final  int? userId;
@override@JsonKey() final  String name;
@override final  int? shirtNumber;
@override final  String? avatarUrl;
@override@JsonKey() final  bool isStaff;
/// Telt mee voor nieuwe boetes.
@override@JsonKey() final  bool counting;
@override@JsonKey() final  int totalCents;
@override@JsonKey() final  int openCents;
@override@JsonKey() final  int count;

/// Create a copy of FineRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FineRowCopyWith<_FineRow> get copyWith => __$FineRowCopyWithImpl<_FineRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FineRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FineRow&&(identical(other.key, key) || other.key == key)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isStaff, isStaff) || other.isStaff == isStaff)&&(identical(other.counting, counting) || other.counting == counting)&&(identical(other.totalCents, totalCents) || other.totalCents == totalCents)&&(identical(other.openCents, openCents) || other.openCents == openCents)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,playerId,userId,name,shirtNumber,avatarUrl,isStaff,counting,totalCents,openCents,count);

@override
String toString() {
  return 'FineRow(key: $key, playerId: $playerId, userId: $userId, name: $name, shirtNumber: $shirtNumber, avatarUrl: $avatarUrl, isStaff: $isStaff, counting: $counting, totalCents: $totalCents, openCents: $openCents, count: $count)';
}


}

/// @nodoc
abstract mixin class _$FineRowCopyWith<$Res> implements $FineRowCopyWith<$Res> {
  factory _$FineRowCopyWith(_FineRow value, $Res Function(_FineRow) _then) = __$FineRowCopyWithImpl;
@override @useResult
$Res call({
 String key, int? playerId, int? userId, String name, int? shirtNumber, String? avatarUrl, bool isStaff, bool counting, int totalCents, int openCents, int count
});




}
/// @nodoc
class __$FineRowCopyWithImpl<$Res>
    implements _$FineRowCopyWith<$Res> {
  __$FineRowCopyWithImpl(this._self, this._then);

  final _FineRow _self;
  final $Res Function(_FineRow) _then;

/// Create a copy of FineRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? playerId = freezed,Object? userId = freezed,Object? name = null,Object? shirtNumber = freezed,Object? avatarUrl = freezed,Object? isStaff = null,Object? counting = null,Object? totalCents = null,Object? openCents = null,Object? count = null,}) {
  return _then(_FineRow(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isStaff: null == isStaff ? _self.isStaff : isStaff // ignore: cast_nullable_to_non_nullable
as bool,counting: null == counting ? _self.counting : counting // ignore: cast_nullable_to_non_nullable
as bool,totalCents: null == totalCents ? _self.totalCents : totalCents // ignore: cast_nullable_to_non_nullable
as int,openCents: null == openCents ? _self.openCents : openCents // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$FineType {

 int get id; String get label; int get defaultCents;/// `null` voor handmatige soorten.
 String? get trigger; String? get triggerLabel;/// Uitgezette automatische soort: niet tonen bij uitdelen.
 bool get archived;
/// Create a copy of FineType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FineTypeCopyWith<FineType> get copyWith => _$FineTypeCopyWithImpl<FineType>(this as FineType, _$identity);

  /// Serializes this FineType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FineType&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.defaultCents, defaultCents) || other.defaultCents == defaultCents)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.triggerLabel, triggerLabel) || other.triggerLabel == triggerLabel)&&(identical(other.archived, archived) || other.archived == archived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,defaultCents,trigger,triggerLabel,archived);

@override
String toString() {
  return 'FineType(id: $id, label: $label, defaultCents: $defaultCents, trigger: $trigger, triggerLabel: $triggerLabel, archived: $archived)';
}


}

/// @nodoc
abstract mixin class $FineTypeCopyWith<$Res>  {
  factory $FineTypeCopyWith(FineType value, $Res Function(FineType) _then) = _$FineTypeCopyWithImpl;
@useResult
$Res call({
 int id, String label, int defaultCents, String? trigger, String? triggerLabel, bool archived
});




}
/// @nodoc
class _$FineTypeCopyWithImpl<$Res>
    implements $FineTypeCopyWith<$Res> {
  _$FineTypeCopyWithImpl(this._self, this._then);

  final FineType _self;
  final $Res Function(FineType) _then;

/// Create a copy of FineType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? defaultCents = null,Object? trigger = freezed,Object? triggerLabel = freezed,Object? archived = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,defaultCents: null == defaultCents ? _self.defaultCents : defaultCents // ignore: cast_nullable_to_non_nullable
as int,trigger: freezed == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as String?,triggerLabel: freezed == triggerLabel ? _self.triggerLabel : triggerLabel // ignore: cast_nullable_to_non_nullable
as String?,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FineType].
extension FineTypePatterns on FineType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FineType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FineType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FineType value)  $default,){
final _that = this;
switch (_that) {
case _FineType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FineType value)?  $default,){
final _that = this;
switch (_that) {
case _FineType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String label,  int defaultCents,  String? trigger,  String? triggerLabel,  bool archived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FineType() when $default != null:
return $default(_that.id,_that.label,_that.defaultCents,_that.trigger,_that.triggerLabel,_that.archived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String label,  int defaultCents,  String? trigger,  String? triggerLabel,  bool archived)  $default,) {final _that = this;
switch (_that) {
case _FineType():
return $default(_that.id,_that.label,_that.defaultCents,_that.trigger,_that.triggerLabel,_that.archived);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String label,  int defaultCents,  String? trigger,  String? triggerLabel,  bool archived)?  $default,) {final _that = this;
switch (_that) {
case _FineType() when $default != null:
return $default(_that.id,_that.label,_that.defaultCents,_that.trigger,_that.triggerLabel,_that.archived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FineType implements FineType {
  const _FineType({required this.id, this.label = '', this.defaultCents = 0, this.trigger, this.triggerLabel, this.archived = false});
  factory _FineType.fromJson(Map<String, dynamic> json) => _$FineTypeFromJson(json);

@override final  int id;
@override@JsonKey() final  String label;
@override@JsonKey() final  int defaultCents;
/// `null` voor handmatige soorten.
@override final  String? trigger;
@override final  String? triggerLabel;
/// Uitgezette automatische soort: niet tonen bij uitdelen.
@override@JsonKey() final  bool archived;

/// Create a copy of FineType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FineTypeCopyWith<_FineType> get copyWith => __$FineTypeCopyWithImpl<_FineType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FineTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FineType&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.defaultCents, defaultCents) || other.defaultCents == defaultCents)&&(identical(other.trigger, trigger) || other.trigger == trigger)&&(identical(other.triggerLabel, triggerLabel) || other.triggerLabel == triggerLabel)&&(identical(other.archived, archived) || other.archived == archived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,defaultCents,trigger,triggerLabel,archived);

@override
String toString() {
  return 'FineType(id: $id, label: $label, defaultCents: $defaultCents, trigger: $trigger, triggerLabel: $triggerLabel, archived: $archived)';
}


}

/// @nodoc
abstract mixin class _$FineTypeCopyWith<$Res> implements $FineTypeCopyWith<$Res> {
  factory _$FineTypeCopyWith(_FineType value, $Res Function(_FineType) _then) = __$FineTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String label, int defaultCents, String? trigger, String? triggerLabel, bool archived
});




}
/// @nodoc
class __$FineTypeCopyWithImpl<$Res>
    implements _$FineTypeCopyWith<$Res> {
  __$FineTypeCopyWithImpl(this._self, this._then);

  final _FineType _self;
  final $Res Function(_FineType) _then;

/// Create a copy of FineType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? defaultCents = null,Object? trigger = freezed,Object? triggerLabel = freezed,Object? archived = null,}) {
  return _then(_FineType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,defaultCents: null == defaultCents ? _self.defaultCents : defaultCents // ignore: cast_nullable_to_non_nullable
as int,trigger: freezed == trigger ? _self.trigger : trigger // ignore: cast_nullable_to_non_nullable
as String?,triggerLabel: freezed == triggerLabel ? _self.triggerLabel : triggerLabel // ignore: cast_nullable_to_non_nullable
as String?,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$FineTotals {

 int get openCents; int get allCents;
/// Create a copy of FineTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FineTotalsCopyWith<FineTotals> get copyWith => _$FineTotalsCopyWithImpl<FineTotals>(this as FineTotals, _$identity);

  /// Serializes this FineTotals to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FineTotals&&(identical(other.openCents, openCents) || other.openCents == openCents)&&(identical(other.allCents, allCents) || other.allCents == allCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,openCents,allCents);

@override
String toString() {
  return 'FineTotals(openCents: $openCents, allCents: $allCents)';
}


}

/// @nodoc
abstract mixin class $FineTotalsCopyWith<$Res>  {
  factory $FineTotalsCopyWith(FineTotals value, $Res Function(FineTotals) _then) = _$FineTotalsCopyWithImpl;
@useResult
$Res call({
 int openCents, int allCents
});




}
/// @nodoc
class _$FineTotalsCopyWithImpl<$Res>
    implements $FineTotalsCopyWith<$Res> {
  _$FineTotalsCopyWithImpl(this._self, this._then);

  final FineTotals _self;
  final $Res Function(FineTotals) _then;

/// Create a copy of FineTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? openCents = null,Object? allCents = null,}) {
  return _then(_self.copyWith(
openCents: null == openCents ? _self.openCents : openCents // ignore: cast_nullable_to_non_nullable
as int,allCents: null == allCents ? _self.allCents : allCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FineTotals].
extension FineTotalsPatterns on FineTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FineTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FineTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FineTotals value)  $default,){
final _that = this;
switch (_that) {
case _FineTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FineTotals value)?  $default,){
final _that = this;
switch (_that) {
case _FineTotals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int openCents,  int allCents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FineTotals() when $default != null:
return $default(_that.openCents,_that.allCents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int openCents,  int allCents)  $default,) {final _that = this;
switch (_that) {
case _FineTotals():
return $default(_that.openCents,_that.allCents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int openCents,  int allCents)?  $default,) {final _that = this;
switch (_that) {
case _FineTotals() when $default != null:
return $default(_that.openCents,_that.allCents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FineTotals implements FineTotals {
  const _FineTotals({this.openCents = 0, this.allCents = 0});
  factory _FineTotals.fromJson(Map<String, dynamic> json) => _$FineTotalsFromJson(json);

@override@JsonKey() final  int openCents;
@override@JsonKey() final  int allCents;

/// Create a copy of FineTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FineTotalsCopyWith<_FineTotals> get copyWith => __$FineTotalsCopyWithImpl<_FineTotals>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FineTotalsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FineTotals&&(identical(other.openCents, openCents) || other.openCents == openCents)&&(identical(other.allCents, allCents) || other.allCents == allCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,openCents,allCents);

@override
String toString() {
  return 'FineTotals(openCents: $openCents, allCents: $allCents)';
}


}

/// @nodoc
abstract mixin class _$FineTotalsCopyWith<$Res> implements $FineTotalsCopyWith<$Res> {
  factory _$FineTotalsCopyWith(_FineTotals value, $Res Function(_FineTotals) _then) = __$FineTotalsCopyWithImpl;
@override @useResult
$Res call({
 int openCents, int allCents
});




}
/// @nodoc
class __$FineTotalsCopyWithImpl<$Res>
    implements _$FineTotalsCopyWith<$Res> {
  __$FineTotalsCopyWithImpl(this._self, this._then);

  final _FineTotals _self;
  final $Res Function(_FineTotals) _then;

/// Create a copy of FineTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? openCents = null,Object? allCents = null,}) {
  return _then(_FineTotals(
openCents: null == openCents ? _self.openCents : openCents // ignore: cast_nullable_to_non_nullable
as int,allCents: null == allCents ? _self.allCents : allCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PotLine {

 String get key;@JsonKey(unknownEnumValue: PotLineKind.unknown) PotLineKind get kind;/// Alleen bij [PotLineKind.entry].
 int? get id; int get amountCents; String get description; DateTime? get occurredOn; String? get createdBy;
/// Create a copy of PotLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PotLineCopyWith<PotLine> get copyWith => _$PotLineCopyWithImpl<PotLine>(this as PotLine, _$identity);

  /// Serializes this PotLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PotLine&&(identical(other.key, key) || other.key == key)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.id, id) || other.id == id)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.description, description) || other.description == description)&&(identical(other.occurredOn, occurredOn) || other.occurredOn == occurredOn)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,kind,id,amountCents,description,occurredOn,createdBy);

@override
String toString() {
  return 'PotLine(key: $key, kind: $kind, id: $id, amountCents: $amountCents, description: $description, occurredOn: $occurredOn, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class $PotLineCopyWith<$Res>  {
  factory $PotLineCopyWith(PotLine value, $Res Function(PotLine) _then) = _$PotLineCopyWithImpl;
@useResult
$Res call({
 String key,@JsonKey(unknownEnumValue: PotLineKind.unknown) PotLineKind kind, int? id, int amountCents, String description, DateTime? occurredOn, String? createdBy
});




}
/// @nodoc
class _$PotLineCopyWithImpl<$Res>
    implements $PotLineCopyWith<$Res> {
  _$PotLineCopyWithImpl(this._self, this._then);

  final PotLine _self;
  final $Res Function(PotLine) _then;

/// Create a copy of PotLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? kind = null,Object? id = freezed,Object? amountCents = null,Object? description = null,Object? occurredOn = freezed,Object? createdBy = freezed,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PotLineKind,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,occurredOn: freezed == occurredOn ? _self.occurredOn : occurredOn // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PotLine].
extension PotLinePatterns on PotLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PotLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PotLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PotLine value)  $default,){
final _that = this;
switch (_that) {
case _PotLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PotLine value)?  $default,){
final _that = this;
switch (_that) {
case _PotLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key, @JsonKey(unknownEnumValue: PotLineKind.unknown)  PotLineKind kind,  int? id,  int amountCents,  String description,  DateTime? occurredOn,  String? createdBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PotLine() when $default != null:
return $default(_that.key,_that.kind,_that.id,_that.amountCents,_that.description,_that.occurredOn,_that.createdBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key, @JsonKey(unknownEnumValue: PotLineKind.unknown)  PotLineKind kind,  int? id,  int amountCents,  String description,  DateTime? occurredOn,  String? createdBy)  $default,) {final _that = this;
switch (_that) {
case _PotLine():
return $default(_that.key,_that.kind,_that.id,_that.amountCents,_that.description,_that.occurredOn,_that.createdBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key, @JsonKey(unknownEnumValue: PotLineKind.unknown)  PotLineKind kind,  int? id,  int amountCents,  String description,  DateTime? occurredOn,  String? createdBy)?  $default,) {final _that = this;
switch (_that) {
case _PotLine() when $default != null:
return $default(_that.key,_that.kind,_that.id,_that.amountCents,_that.description,_that.occurredOn,_that.createdBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PotLine extends PotLine {
  const _PotLine({required this.key, @JsonKey(unknownEnumValue: PotLineKind.unknown) this.kind = PotLineKind.unknown, this.id, this.amountCents = 0, this.description = '', this.occurredOn, this.createdBy}): super._();
  factory _PotLine.fromJson(Map<String, dynamic> json) => _$PotLineFromJson(json);

@override final  String key;
@override@JsonKey(unknownEnumValue: PotLineKind.unknown) final  PotLineKind kind;
/// Alleen bij [PotLineKind.entry].
@override final  int? id;
@override@JsonKey() final  int amountCents;
@override@JsonKey() final  String description;
@override final  DateTime? occurredOn;
@override final  String? createdBy;

/// Create a copy of PotLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PotLineCopyWith<_PotLine> get copyWith => __$PotLineCopyWithImpl<_PotLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PotLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PotLine&&(identical(other.key, key) || other.key == key)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.id, id) || other.id == id)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.description, description) || other.description == description)&&(identical(other.occurredOn, occurredOn) || other.occurredOn == occurredOn)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,kind,id,amountCents,description,occurredOn,createdBy);

@override
String toString() {
  return 'PotLine(key: $key, kind: $kind, id: $id, amountCents: $amountCents, description: $description, occurredOn: $occurredOn, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class _$PotLineCopyWith<$Res> implements $PotLineCopyWith<$Res> {
  factory _$PotLineCopyWith(_PotLine value, $Res Function(_PotLine) _then) = __$PotLineCopyWithImpl;
@override @useResult
$Res call({
 String key,@JsonKey(unknownEnumValue: PotLineKind.unknown) PotLineKind kind, int? id, int amountCents, String description, DateTime? occurredOn, String? createdBy
});




}
/// @nodoc
class __$PotLineCopyWithImpl<$Res>
    implements _$PotLineCopyWith<$Res> {
  __$PotLineCopyWithImpl(this._self, this._then);

  final _PotLine _self;
  final $Res Function(_PotLine) _then;

/// Create a copy of PotLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? kind = null,Object? id = freezed,Object? amountCents = null,Object? description = null,Object? occurredOn = freezed,Object? createdBy = freezed,}) {
  return _then(_PotLine(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as PotLineKind,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,occurredOn: freezed == occurredOn ? _self.occurredOn : occurredOn // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$FinePot {

 int get balanceCents; int get openCents; List<PotLine> get lines;
/// Create a copy of FinePot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinePotCopyWith<FinePot> get copyWith => _$FinePotCopyWithImpl<FinePot>(this as FinePot, _$identity);

  /// Serializes this FinePot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinePot&&(identical(other.balanceCents, balanceCents) || other.balanceCents == balanceCents)&&(identical(other.openCents, openCents) || other.openCents == openCents)&&const DeepCollectionEquality().equals(other.lines, lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,balanceCents,openCents,const DeepCollectionEquality().hash(lines));

@override
String toString() {
  return 'FinePot(balanceCents: $balanceCents, openCents: $openCents, lines: $lines)';
}


}

/// @nodoc
abstract mixin class $FinePotCopyWith<$Res>  {
  factory $FinePotCopyWith(FinePot value, $Res Function(FinePot) _then) = _$FinePotCopyWithImpl;
@useResult
$Res call({
 int balanceCents, int openCents, List<PotLine> lines
});




}
/// @nodoc
class _$FinePotCopyWithImpl<$Res>
    implements $FinePotCopyWith<$Res> {
  _$FinePotCopyWithImpl(this._self, this._then);

  final FinePot _self;
  final $Res Function(FinePot) _then;

/// Create a copy of FinePot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balanceCents = null,Object? openCents = null,Object? lines = null,}) {
  return _then(_self.copyWith(
balanceCents: null == balanceCents ? _self.balanceCents : balanceCents // ignore: cast_nullable_to_non_nullable
as int,openCents: null == openCents ? _self.openCents : openCents // ignore: cast_nullable_to_non_nullable
as int,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<PotLine>,
  ));
}

}


/// Adds pattern-matching-related methods to [FinePot].
extension FinePotPatterns on FinePot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinePot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinePot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinePot value)  $default,){
final _that = this;
switch (_that) {
case _FinePot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinePot value)?  $default,){
final _that = this;
switch (_that) {
case _FinePot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int balanceCents,  int openCents,  List<PotLine> lines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinePot() when $default != null:
return $default(_that.balanceCents,_that.openCents,_that.lines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int balanceCents,  int openCents,  List<PotLine> lines)  $default,) {final _that = this;
switch (_that) {
case _FinePot():
return $default(_that.balanceCents,_that.openCents,_that.lines);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int balanceCents,  int openCents,  List<PotLine> lines)?  $default,) {final _that = this;
switch (_that) {
case _FinePot() when $default != null:
return $default(_that.balanceCents,_that.openCents,_that.lines);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FinePot implements FinePot {
  const _FinePot({this.balanceCents = 0, this.openCents = 0, final  List<PotLine> lines = const <PotLine>[]}): _lines = lines;
  factory _FinePot.fromJson(Map<String, dynamic> json) => _$FinePotFromJson(json);

@override@JsonKey() final  int balanceCents;
@override@JsonKey() final  int openCents;
 final  List<PotLine> _lines;
@override@JsonKey() List<PotLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}


/// Create a copy of FinePot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinePotCopyWith<_FinePot> get copyWith => __$FinePotCopyWithImpl<_FinePot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FinePotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinePot&&(identical(other.balanceCents, balanceCents) || other.balanceCents == balanceCents)&&(identical(other.openCents, openCents) || other.openCents == openCents)&&const DeepCollectionEquality().equals(other._lines, _lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,balanceCents,openCents,const DeepCollectionEquality().hash(_lines));

@override
String toString() {
  return 'FinePot(balanceCents: $balanceCents, openCents: $openCents, lines: $lines)';
}


}

/// @nodoc
abstract mixin class _$FinePotCopyWith<$Res> implements $FinePotCopyWith<$Res> {
  factory _$FinePotCopyWith(_FinePot value, $Res Function(_FinePot) _then) = __$FinePotCopyWithImpl;
@override @useResult
$Res call({
 int balanceCents, int openCents, List<PotLine> lines
});




}
/// @nodoc
class __$FinePotCopyWithImpl<$Res>
    implements _$FinePotCopyWith<$Res> {
  __$FinePotCopyWithImpl(this._self, this._then);

  final _FinePot _self;
  final $Res Function(_FinePot) _then;

/// Create a copy of FinePot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? balanceCents = null,Object? openCents = null,Object? lines = null,}) {
  return _then(_FinePot(
balanceCents: null == balanceCents ? _self.balanceCents : balanceCents // ignore: cast_nullable_to_non_nullable
as int,openCents: null == openCents ? _self.openCents : openCents // ignore: cast_nullable_to_non_nullable
as int,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<PotLine>,
  ));
}


}


/// @nodoc
mixin _$FinesOverview {

 FinePeriod get period; List<FinePeriod> get periods; List<FineRow> get rows; List<FineType> get fineTypes; bool get guestsInFines; bool get staffInFines; FineTotals get totals; FinePot get pot; bool get canManage;
/// Create a copy of FinesOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinesOverviewCopyWith<FinesOverview> get copyWith => _$FinesOverviewCopyWithImpl<FinesOverview>(this as FinesOverview, _$identity);

  /// Serializes this FinesOverview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinesOverview&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other.periods, periods)&&const DeepCollectionEquality().equals(other.rows, rows)&&const DeepCollectionEquality().equals(other.fineTypes, fineTypes)&&(identical(other.guestsInFines, guestsInFines) || other.guestsInFines == guestsInFines)&&(identical(other.staffInFines, staffInFines) || other.staffInFines == staffInFines)&&(identical(other.totals, totals) || other.totals == totals)&&(identical(other.pot, pot) || other.pot == pot)&&(identical(other.canManage, canManage) || other.canManage == canManage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,const DeepCollectionEquality().hash(periods),const DeepCollectionEquality().hash(rows),const DeepCollectionEquality().hash(fineTypes),guestsInFines,staffInFines,totals,pot,canManage);

@override
String toString() {
  return 'FinesOverview(period: $period, periods: $periods, rows: $rows, fineTypes: $fineTypes, guestsInFines: $guestsInFines, staffInFines: $staffInFines, totals: $totals, pot: $pot, canManage: $canManage)';
}


}

/// @nodoc
abstract mixin class $FinesOverviewCopyWith<$Res>  {
  factory $FinesOverviewCopyWith(FinesOverview value, $Res Function(FinesOverview) _then) = _$FinesOverviewCopyWithImpl;
@useResult
$Res call({
 FinePeriod period, List<FinePeriod> periods, List<FineRow> rows, List<FineType> fineTypes, bool guestsInFines, bool staffInFines, FineTotals totals, FinePot pot, bool canManage
});


$FinePeriodCopyWith<$Res> get period;$FineTotalsCopyWith<$Res> get totals;$FinePotCopyWith<$Res> get pot;

}
/// @nodoc
class _$FinesOverviewCopyWithImpl<$Res>
    implements $FinesOverviewCopyWith<$Res> {
  _$FinesOverviewCopyWithImpl(this._self, this._then);

  final FinesOverview _self;
  final $Res Function(FinesOverview) _then;

/// Create a copy of FinesOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? periods = null,Object? rows = null,Object? fineTypes = null,Object? guestsInFines = null,Object? staffInFines = null,Object? totals = null,Object? pot = null,Object? canManage = null,}) {
  return _then(_self.copyWith(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as FinePeriod,periods: null == periods ? _self.periods : periods // ignore: cast_nullable_to_non_nullable
as List<FinePeriod>,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as List<FineRow>,fineTypes: null == fineTypes ? _self.fineTypes : fineTypes // ignore: cast_nullable_to_non_nullable
as List<FineType>,guestsInFines: null == guestsInFines ? _self.guestsInFines : guestsInFines // ignore: cast_nullable_to_non_nullable
as bool,staffInFines: null == staffInFines ? _self.staffInFines : staffInFines // ignore: cast_nullable_to_non_nullable
as bool,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as FineTotals,pot: null == pot ? _self.pot : pot // ignore: cast_nullable_to_non_nullable
as FinePot,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of FinesOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinePeriodCopyWith<$Res> get period {
  
  return $FinePeriodCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}/// Create a copy of FinesOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FineTotalsCopyWith<$Res> get totals {
  
  return $FineTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}/// Create a copy of FinesOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinePotCopyWith<$Res> get pot {
  
  return $FinePotCopyWith<$Res>(_self.pot, (value) {
    return _then(_self.copyWith(pot: value));
  });
}
}


/// Adds pattern-matching-related methods to [FinesOverview].
extension FinesOverviewPatterns on FinesOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinesOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinesOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinesOverview value)  $default,){
final _that = this;
switch (_that) {
case _FinesOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinesOverview value)?  $default,){
final _that = this;
switch (_that) {
case _FinesOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FinePeriod period,  List<FinePeriod> periods,  List<FineRow> rows,  List<FineType> fineTypes,  bool guestsInFines,  bool staffInFines,  FineTotals totals,  FinePot pot,  bool canManage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinesOverview() when $default != null:
return $default(_that.period,_that.periods,_that.rows,_that.fineTypes,_that.guestsInFines,_that.staffInFines,_that.totals,_that.pot,_that.canManage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FinePeriod period,  List<FinePeriod> periods,  List<FineRow> rows,  List<FineType> fineTypes,  bool guestsInFines,  bool staffInFines,  FineTotals totals,  FinePot pot,  bool canManage)  $default,) {final _that = this;
switch (_that) {
case _FinesOverview():
return $default(_that.period,_that.periods,_that.rows,_that.fineTypes,_that.guestsInFines,_that.staffInFines,_that.totals,_that.pot,_that.canManage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FinePeriod period,  List<FinePeriod> periods,  List<FineRow> rows,  List<FineType> fineTypes,  bool guestsInFines,  bool staffInFines,  FineTotals totals,  FinePot pot,  bool canManage)?  $default,) {final _that = this;
switch (_that) {
case _FinesOverview() when $default != null:
return $default(_that.period,_that.periods,_that.rows,_that.fineTypes,_that.guestsInFines,_that.staffInFines,_that.totals,_that.pot,_that.canManage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FinesOverview extends FinesOverview {
  const _FinesOverview({required this.period, final  List<FinePeriod> periods = const <FinePeriod>[], final  List<FineRow> rows = const <FineRow>[], final  List<FineType> fineTypes = const <FineType>[], this.guestsInFines = false, this.staffInFines = false, this.totals = const FineTotals(), this.pot = const FinePot(), this.canManage = false}): _periods = periods,_rows = rows,_fineTypes = fineTypes,super._();
  factory _FinesOverview.fromJson(Map<String, dynamic> json) => _$FinesOverviewFromJson(json);

@override final  FinePeriod period;
 final  List<FinePeriod> _periods;
@override@JsonKey() List<FinePeriod> get periods {
  if (_periods is EqualUnmodifiableListView) return _periods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_periods);
}

 final  List<FineRow> _rows;
@override@JsonKey() List<FineRow> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}

 final  List<FineType> _fineTypes;
@override@JsonKey() List<FineType> get fineTypes {
  if (_fineTypes is EqualUnmodifiableListView) return _fineTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fineTypes);
}

@override@JsonKey() final  bool guestsInFines;
@override@JsonKey() final  bool staffInFines;
@override@JsonKey() final  FineTotals totals;
@override@JsonKey() final  FinePot pot;
@override@JsonKey() final  bool canManage;

/// Create a copy of FinesOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinesOverviewCopyWith<_FinesOverview> get copyWith => __$FinesOverviewCopyWithImpl<_FinesOverview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FinesOverviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinesOverview&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other._periods, _periods)&&const DeepCollectionEquality().equals(other._rows, _rows)&&const DeepCollectionEquality().equals(other._fineTypes, _fineTypes)&&(identical(other.guestsInFines, guestsInFines) || other.guestsInFines == guestsInFines)&&(identical(other.staffInFines, staffInFines) || other.staffInFines == staffInFines)&&(identical(other.totals, totals) || other.totals == totals)&&(identical(other.pot, pot) || other.pot == pot)&&(identical(other.canManage, canManage) || other.canManage == canManage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,const DeepCollectionEquality().hash(_periods),const DeepCollectionEquality().hash(_rows),const DeepCollectionEquality().hash(_fineTypes),guestsInFines,staffInFines,totals,pot,canManage);

@override
String toString() {
  return 'FinesOverview(period: $period, periods: $periods, rows: $rows, fineTypes: $fineTypes, guestsInFines: $guestsInFines, staffInFines: $staffInFines, totals: $totals, pot: $pot, canManage: $canManage)';
}


}

/// @nodoc
abstract mixin class _$FinesOverviewCopyWith<$Res> implements $FinesOverviewCopyWith<$Res> {
  factory _$FinesOverviewCopyWith(_FinesOverview value, $Res Function(_FinesOverview) _then) = __$FinesOverviewCopyWithImpl;
@override @useResult
$Res call({
 FinePeriod period, List<FinePeriod> periods, List<FineRow> rows, List<FineType> fineTypes, bool guestsInFines, bool staffInFines, FineTotals totals, FinePot pot, bool canManage
});


@override $FinePeriodCopyWith<$Res> get period;@override $FineTotalsCopyWith<$Res> get totals;@override $FinePotCopyWith<$Res> get pot;

}
/// @nodoc
class __$FinesOverviewCopyWithImpl<$Res>
    implements _$FinesOverviewCopyWith<$Res> {
  __$FinesOverviewCopyWithImpl(this._self, this._then);

  final _FinesOverview _self;
  final $Res Function(_FinesOverview) _then;

/// Create a copy of FinesOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? periods = null,Object? rows = null,Object? fineTypes = null,Object? guestsInFines = null,Object? staffInFines = null,Object? totals = null,Object? pot = null,Object? canManage = null,}) {
  return _then(_FinesOverview(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as FinePeriod,periods: null == periods ? _self._periods : periods // ignore: cast_nullable_to_non_nullable
as List<FinePeriod>,rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<FineRow>,fineTypes: null == fineTypes ? _self._fineTypes : fineTypes // ignore: cast_nullable_to_non_nullable
as List<FineType>,guestsInFines: null == guestsInFines ? _self.guestsInFines : guestsInFines // ignore: cast_nullable_to_non_nullable
as bool,staffInFines: null == staffInFines ? _self.staffInFines : staffInFines // ignore: cast_nullable_to_non_nullable
as bool,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as FineTotals,pot: null == pot ? _self.pot : pot // ignore: cast_nullable_to_non_nullable
as FinePot,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of FinesOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinePeriodCopyWith<$Res> get period {
  
  return $FinePeriodCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}/// Create a copy of FinesOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FineTotalsCopyWith<$Res> get totals {
  
  return $FineTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}/// Create a copy of FinesOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinePotCopyWith<$Res> get pot {
  
  return $FinePotCopyWith<$Res>(_self.pot, (value) {
    return _then(_self.copyWith(pot: value));
  });
}
}


/// @nodoc
mixin _$FineEvent {

 int get id; String get title; DateTime? get startsAt;
/// Create a copy of FineEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FineEventCopyWith<FineEvent> get copyWith => _$FineEventCopyWithImpl<FineEvent>(this as FineEvent, _$identity);

  /// Serializes this FineEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FineEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt);

@override
String toString() {
  return 'FineEvent(id: $id, title: $title, startsAt: $startsAt)';
}


}

/// @nodoc
abstract mixin class $FineEventCopyWith<$Res>  {
  factory $FineEventCopyWith(FineEvent value, $Res Function(FineEvent) _then) = _$FineEventCopyWithImpl;
@useResult
$Res call({
 int id, String title, DateTime? startsAt
});




}
/// @nodoc
class _$FineEventCopyWithImpl<$Res>
    implements $FineEventCopyWith<$Res> {
  _$FineEventCopyWithImpl(this._self, this._then);

  final FineEvent _self;
  final $Res Function(FineEvent) _then;

/// Create a copy of FineEvent
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


/// Adds pattern-matching-related methods to [FineEvent].
extension FineEventPatterns on FineEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FineEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FineEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FineEvent value)  $default,){
final _that = this;
switch (_that) {
case _FineEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FineEvent value)?  $default,){
final _that = this;
switch (_that) {
case _FineEvent() when $default != null:
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
case _FineEvent() when $default != null:
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
case _FineEvent():
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
case _FineEvent() when $default != null:
return $default(_that.id,_that.title,_that.startsAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FineEvent implements FineEvent {
  const _FineEvent({required this.id, this.title = '', this.startsAt});
  factory _FineEvent.fromJson(Map<String, dynamic> json) => _$FineEventFromJson(json);

@override final  int id;
@override@JsonKey() final  String title;
@override final  DateTime? startsAt;

/// Create a copy of FineEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FineEventCopyWith<_FineEvent> get copyWith => __$FineEventCopyWithImpl<_FineEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FineEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FineEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt);

@override
String toString() {
  return 'FineEvent(id: $id, title: $title, startsAt: $startsAt)';
}


}

/// @nodoc
abstract mixin class _$FineEventCopyWith<$Res> implements $FineEventCopyWith<$Res> {
  factory _$FineEventCopyWith(_FineEvent value, $Res Function(_FineEvent) _then) = __$FineEventCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, DateTime? startsAt
});




}
/// @nodoc
class __$FineEventCopyWithImpl<$Res>
    implements _$FineEventCopyWith<$Res> {
  __$FineEventCopyWithImpl(this._self, this._then);

  final _FineEvent _self;
  final $Res Function(_FineEvent) _then;

/// Create a copy of FineEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,}) {
  return _then(_FineEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$Fine {

 int get id;/// Id van de boetesoort (`null` = geen soort, "Overig").
 int? get type; String get typeLabel; int get amountCents; String? get description;@JsonKey(unknownEnumValue: FineStatus.unknown) FineStatus get status; DateTime? get paidAt; FineEvent? get event; DateTime? get createdAt; String? get createdBy;
/// Create a copy of Fine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FineCopyWith<Fine> get copyWith => _$FineCopyWithImpl<Fine>(this as Fine, _$identity);

  /// Serializes this Fine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Fine&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeLabel, typeLabel) || other.typeLabel == typeLabel)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.event, event) || other.event == event)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,typeLabel,amountCents,description,status,paidAt,event,createdAt,createdBy);

@override
String toString() {
  return 'Fine(id: $id, type: $type, typeLabel: $typeLabel, amountCents: $amountCents, description: $description, status: $status, paidAt: $paidAt, event: $event, createdAt: $createdAt, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class $FineCopyWith<$Res>  {
  factory $FineCopyWith(Fine value, $Res Function(Fine) _then) = _$FineCopyWithImpl;
@useResult
$Res call({
 int id, int? type, String typeLabel, int amountCents, String? description,@JsonKey(unknownEnumValue: FineStatus.unknown) FineStatus status, DateTime? paidAt, FineEvent? event, DateTime? createdAt, String? createdBy
});


$FineEventCopyWith<$Res>? get event;

}
/// @nodoc
class _$FineCopyWithImpl<$Res>
    implements $FineCopyWith<$Res> {
  _$FineCopyWithImpl(this._self, this._then);

  final Fine _self;
  final $Res Function(Fine) _then;

/// Create a copy of Fine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = freezed,Object? typeLabel = null,Object? amountCents = null,Object? description = freezed,Object? status = null,Object? paidAt = freezed,Object? event = freezed,Object? createdAt = freezed,Object? createdBy = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int?,typeLabel: null == typeLabel ? _self.typeLabel : typeLabel // ignore: cast_nullable_to_non_nullable
as String,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FineStatus,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as FineEvent?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Fine
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FineEventCopyWith<$Res>? get event {
    if (_self.event == null) {
    return null;
  }

  return $FineEventCopyWith<$Res>(_self.event!, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// Adds pattern-matching-related methods to [Fine].
extension FinePatterns on Fine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Fine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Fine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Fine value)  $default,){
final _that = this;
switch (_that) {
case _Fine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Fine value)?  $default,){
final _that = this;
switch (_that) {
case _Fine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? type,  String typeLabel,  int amountCents,  String? description, @JsonKey(unknownEnumValue: FineStatus.unknown)  FineStatus status,  DateTime? paidAt,  FineEvent? event,  DateTime? createdAt,  String? createdBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Fine() when $default != null:
return $default(_that.id,_that.type,_that.typeLabel,_that.amountCents,_that.description,_that.status,_that.paidAt,_that.event,_that.createdAt,_that.createdBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? type,  String typeLabel,  int amountCents,  String? description, @JsonKey(unknownEnumValue: FineStatus.unknown)  FineStatus status,  DateTime? paidAt,  FineEvent? event,  DateTime? createdAt,  String? createdBy)  $default,) {final _that = this;
switch (_that) {
case _Fine():
return $default(_that.id,_that.type,_that.typeLabel,_that.amountCents,_that.description,_that.status,_that.paidAt,_that.event,_that.createdAt,_that.createdBy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? type,  String typeLabel,  int amountCents,  String? description, @JsonKey(unknownEnumValue: FineStatus.unknown)  FineStatus status,  DateTime? paidAt,  FineEvent? event,  DateTime? createdAt,  String? createdBy)?  $default,) {final _that = this;
switch (_that) {
case _Fine() when $default != null:
return $default(_that.id,_that.type,_that.typeLabel,_that.amountCents,_that.description,_that.status,_that.paidAt,_that.event,_that.createdAt,_that.createdBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Fine implements Fine {
  const _Fine({required this.id, this.type, this.typeLabel = '', this.amountCents = 0, this.description, @JsonKey(unknownEnumValue: FineStatus.unknown) this.status = FineStatus.open, this.paidAt, this.event, this.createdAt, this.createdBy});
  factory _Fine.fromJson(Map<String, dynamic> json) => _$FineFromJson(json);

@override final  int id;
/// Id van de boetesoort (`null` = geen soort, "Overig").
@override final  int? type;
@override@JsonKey() final  String typeLabel;
@override@JsonKey() final  int amountCents;
@override final  String? description;
@override@JsonKey(unknownEnumValue: FineStatus.unknown) final  FineStatus status;
@override final  DateTime? paidAt;
@override final  FineEvent? event;
@override final  DateTime? createdAt;
@override final  String? createdBy;

/// Create a copy of Fine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FineCopyWith<_Fine> get copyWith => __$FineCopyWithImpl<_Fine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Fine&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.typeLabel, typeLabel) || other.typeLabel == typeLabel)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.event, event) || other.event == event)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,typeLabel,amountCents,description,status,paidAt,event,createdAt,createdBy);

@override
String toString() {
  return 'Fine(id: $id, type: $type, typeLabel: $typeLabel, amountCents: $amountCents, description: $description, status: $status, paidAt: $paidAt, event: $event, createdAt: $createdAt, createdBy: $createdBy)';
}


}

/// @nodoc
abstract mixin class _$FineCopyWith<$Res> implements $FineCopyWith<$Res> {
  factory _$FineCopyWith(_Fine value, $Res Function(_Fine) _then) = __$FineCopyWithImpl;
@override @useResult
$Res call({
 int id, int? type, String typeLabel, int amountCents, String? description,@JsonKey(unknownEnumValue: FineStatus.unknown) FineStatus status, DateTime? paidAt, FineEvent? event, DateTime? createdAt, String? createdBy
});


@override $FineEventCopyWith<$Res>? get event;

}
/// @nodoc
class __$FineCopyWithImpl<$Res>
    implements _$FineCopyWith<$Res> {
  __$FineCopyWithImpl(this._self, this._then);

  final _Fine _self;
  final $Res Function(_Fine) _then;

/// Create a copy of Fine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = freezed,Object? typeLabel = null,Object? amountCents = null,Object? description = freezed,Object? status = null,Object? paidAt = freezed,Object? event = freezed,Object? createdAt = freezed,Object? createdBy = freezed,}) {
  return _then(_Fine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as int?,typeLabel: null == typeLabel ? _self.typeLabel : typeLabel // ignore: cast_nullable_to_non_nullable
as String,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FineStatus,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as FineEvent?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Fine
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FineEventCopyWith<$Res>? get event {
    if (_self.event == null) {
    return null;
  }

  return $FineEventCopyWith<$Res>(_self.event!, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// @nodoc
mixin _$FinePerson {

 int get id; String get name; int? get shirtNumber; String? get avatarUrl;
/// Create a copy of FinePerson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinePersonCopyWith<FinePerson> get copyWith => _$FinePersonCopyWithImpl<FinePerson>(this as FinePerson, _$identity);

  /// Serializes this FinePerson to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinePerson&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber,avatarUrl);

@override
String toString() {
  return 'FinePerson(id: $id, name: $name, shirtNumber: $shirtNumber, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $FinePersonCopyWith<$Res>  {
  factory $FinePersonCopyWith(FinePerson value, $Res Function(FinePerson) _then) = _$FinePersonCopyWithImpl;
@useResult
$Res call({
 int id, String name, int? shirtNumber, String? avatarUrl
});




}
/// @nodoc
class _$FinePersonCopyWithImpl<$Res>
    implements $FinePersonCopyWith<$Res> {
  _$FinePersonCopyWithImpl(this._self, this._then);

  final FinePerson _self;
  final $Res Function(FinePerson) _then;

/// Create a copy of FinePerson
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


/// Adds pattern-matching-related methods to [FinePerson].
extension FinePersonPatterns on FinePerson {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinePerson value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinePerson() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinePerson value)  $default,){
final _that = this;
switch (_that) {
case _FinePerson():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinePerson value)?  $default,){
final _that = this;
switch (_that) {
case _FinePerson() when $default != null:
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
case _FinePerson() when $default != null:
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
case _FinePerson():
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
case _FinePerson() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FinePerson implements FinePerson {
  const _FinePerson({required this.id, this.name = '', this.shirtNumber, this.avatarUrl});
  factory _FinePerson.fromJson(Map<String, dynamic> json) => _$FinePersonFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  int? shirtNumber;
@override final  String? avatarUrl;

/// Create a copy of FinePerson
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinePersonCopyWith<_FinePerson> get copyWith => __$FinePersonCopyWithImpl<_FinePerson>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FinePersonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinePerson&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber,avatarUrl);

@override
String toString() {
  return 'FinePerson(id: $id, name: $name, shirtNumber: $shirtNumber, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$FinePersonCopyWith<$Res> implements $FinePersonCopyWith<$Res> {
  factory _$FinePersonCopyWith(_FinePerson value, $Res Function(_FinePerson) _then) = __$FinePersonCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int? shirtNumber, String? avatarUrl
});




}
/// @nodoc
class __$FinePersonCopyWithImpl<$Res>
    implements _$FinePersonCopyWith<$Res> {
  __$FinePersonCopyWithImpl(this._self, this._then);

  final _FinePerson _self;
  final $Res Function(_FinePerson) _then;

/// Create a copy of FinePerson
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,Object? avatarUrl = freezed,}) {
  return _then(_FinePerson(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PersonFines {

 FinePeriod get period;@JsonKey(name: 'player') FinePerson get person; List<Fine> get fines; FineTotals get totals; List<FineType> get fineTypes; bool get canManage;
/// Create a copy of PersonFines
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonFinesCopyWith<PersonFines> get copyWith => _$PersonFinesCopyWithImpl<PersonFines>(this as PersonFines, _$identity);

  /// Serializes this PersonFines to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonFines&&(identical(other.period, period) || other.period == period)&&(identical(other.person, person) || other.person == person)&&const DeepCollectionEquality().equals(other.fines, fines)&&(identical(other.totals, totals) || other.totals == totals)&&const DeepCollectionEquality().equals(other.fineTypes, fineTypes)&&(identical(other.canManage, canManage) || other.canManage == canManage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,person,const DeepCollectionEquality().hash(fines),totals,const DeepCollectionEquality().hash(fineTypes),canManage);

@override
String toString() {
  return 'PersonFines(period: $period, person: $person, fines: $fines, totals: $totals, fineTypes: $fineTypes, canManage: $canManage)';
}


}

/// @nodoc
abstract mixin class $PersonFinesCopyWith<$Res>  {
  factory $PersonFinesCopyWith(PersonFines value, $Res Function(PersonFines) _then) = _$PersonFinesCopyWithImpl;
@useResult
$Res call({
 FinePeriod period,@JsonKey(name: 'player') FinePerson person, List<Fine> fines, FineTotals totals, List<FineType> fineTypes, bool canManage
});


$FinePeriodCopyWith<$Res> get period;$FinePersonCopyWith<$Res> get person;$FineTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class _$PersonFinesCopyWithImpl<$Res>
    implements $PersonFinesCopyWith<$Res> {
  _$PersonFinesCopyWithImpl(this._self, this._then);

  final PersonFines _self;
  final $Res Function(PersonFines) _then;

/// Create a copy of PersonFines
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? person = null,Object? fines = null,Object? totals = null,Object? fineTypes = null,Object? canManage = null,}) {
  return _then(_self.copyWith(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as FinePeriod,person: null == person ? _self.person : person // ignore: cast_nullable_to_non_nullable
as FinePerson,fines: null == fines ? _self.fines : fines // ignore: cast_nullable_to_non_nullable
as List<Fine>,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as FineTotals,fineTypes: null == fineTypes ? _self.fineTypes : fineTypes // ignore: cast_nullable_to_non_nullable
as List<FineType>,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PersonFines
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinePeriodCopyWith<$Res> get period {
  
  return $FinePeriodCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}/// Create a copy of PersonFines
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinePersonCopyWith<$Res> get person {
  
  return $FinePersonCopyWith<$Res>(_self.person, (value) {
    return _then(_self.copyWith(person: value));
  });
}/// Create a copy of PersonFines
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FineTotalsCopyWith<$Res> get totals {
  
  return $FineTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}


/// Adds pattern-matching-related methods to [PersonFines].
extension PersonFinesPatterns on PersonFines {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonFines value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonFines() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonFines value)  $default,){
final _that = this;
switch (_that) {
case _PersonFines():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonFines value)?  $default,){
final _that = this;
switch (_that) {
case _PersonFines() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FinePeriod period, @JsonKey(name: 'player')  FinePerson person,  List<Fine> fines,  FineTotals totals,  List<FineType> fineTypes,  bool canManage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonFines() when $default != null:
return $default(_that.period,_that.person,_that.fines,_that.totals,_that.fineTypes,_that.canManage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FinePeriod period, @JsonKey(name: 'player')  FinePerson person,  List<Fine> fines,  FineTotals totals,  List<FineType> fineTypes,  bool canManage)  $default,) {final _that = this;
switch (_that) {
case _PersonFines():
return $default(_that.period,_that.person,_that.fines,_that.totals,_that.fineTypes,_that.canManage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FinePeriod period, @JsonKey(name: 'player')  FinePerson person,  List<Fine> fines,  FineTotals totals,  List<FineType> fineTypes,  bool canManage)?  $default,) {final _that = this;
switch (_that) {
case _PersonFines() when $default != null:
return $default(_that.period,_that.person,_that.fines,_that.totals,_that.fineTypes,_that.canManage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonFines implements PersonFines {
  const _PersonFines({required this.period, @JsonKey(name: 'player') required this.person, final  List<Fine> fines = const <Fine>[], this.totals = const FineTotals(), final  List<FineType> fineTypes = const <FineType>[], this.canManage = false}): _fines = fines,_fineTypes = fineTypes;
  factory _PersonFines.fromJson(Map<String, dynamic> json) => _$PersonFinesFromJson(json);

@override final  FinePeriod period;
@override@JsonKey(name: 'player') final  FinePerson person;
 final  List<Fine> _fines;
@override@JsonKey() List<Fine> get fines {
  if (_fines is EqualUnmodifiableListView) return _fines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fines);
}

@override@JsonKey() final  FineTotals totals;
 final  List<FineType> _fineTypes;
@override@JsonKey() List<FineType> get fineTypes {
  if (_fineTypes is EqualUnmodifiableListView) return _fineTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fineTypes);
}

@override@JsonKey() final  bool canManage;

/// Create a copy of PersonFines
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonFinesCopyWith<_PersonFines> get copyWith => __$PersonFinesCopyWithImpl<_PersonFines>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonFinesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonFines&&(identical(other.period, period) || other.period == period)&&(identical(other.person, person) || other.person == person)&&const DeepCollectionEquality().equals(other._fines, _fines)&&(identical(other.totals, totals) || other.totals == totals)&&const DeepCollectionEquality().equals(other._fineTypes, _fineTypes)&&(identical(other.canManage, canManage) || other.canManage == canManage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,period,person,const DeepCollectionEquality().hash(_fines),totals,const DeepCollectionEquality().hash(_fineTypes),canManage);

@override
String toString() {
  return 'PersonFines(period: $period, person: $person, fines: $fines, totals: $totals, fineTypes: $fineTypes, canManage: $canManage)';
}


}

/// @nodoc
abstract mixin class _$PersonFinesCopyWith<$Res> implements $PersonFinesCopyWith<$Res> {
  factory _$PersonFinesCopyWith(_PersonFines value, $Res Function(_PersonFines) _then) = __$PersonFinesCopyWithImpl;
@override @useResult
$Res call({
 FinePeriod period,@JsonKey(name: 'player') FinePerson person, List<Fine> fines, FineTotals totals, List<FineType> fineTypes, bool canManage
});


@override $FinePeriodCopyWith<$Res> get period;@override $FinePersonCopyWith<$Res> get person;@override $FineTotalsCopyWith<$Res> get totals;

}
/// @nodoc
class __$PersonFinesCopyWithImpl<$Res>
    implements _$PersonFinesCopyWith<$Res> {
  __$PersonFinesCopyWithImpl(this._self, this._then);

  final _PersonFines _self;
  final $Res Function(_PersonFines) _then;

/// Create a copy of PersonFines
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? person = null,Object? fines = null,Object? totals = null,Object? fineTypes = null,Object? canManage = null,}) {
  return _then(_PersonFines(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as FinePeriod,person: null == person ? _self.person : person // ignore: cast_nullable_to_non_nullable
as FinePerson,fines: null == fines ? _self._fines : fines // ignore: cast_nullable_to_non_nullable
as List<Fine>,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as FineTotals,fineTypes: null == fineTypes ? _self._fineTypes : fineTypes // ignore: cast_nullable_to_non_nullable
as List<FineType>,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PersonFines
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinePeriodCopyWith<$Res> get period {
  
  return $FinePeriodCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}/// Create a copy of PersonFines
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FinePersonCopyWith<$Res> get person {
  
  return $FinePersonCopyWith<$Res>(_self.person, (value) {
    return _then(_self.copyWith(person: value));
  });
}/// Create a copy of PersonFines
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FineTotalsCopyWith<$Res> get totals {
  
  return $FineTotalsCopyWith<$Res>(_self.totals, (value) {
    return _then(_self.copyWith(totals: value));
  });
}
}

// dart format on
