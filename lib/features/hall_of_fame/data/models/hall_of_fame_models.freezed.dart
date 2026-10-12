// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hall_of_fame_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HofPeriod {

 int get id; String get name; DateTime? get startsOn; DateTime? get endsOn; bool get isClosed;
/// Create a copy of HofPeriod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HofPeriodCopyWith<HofPeriod> get copyWith => _$HofPeriodCopyWithImpl<HofPeriod>(this as HofPeriod, _$identity);

  /// Serializes this HofPeriod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HofPeriod&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startsOn,endsOn,isClosed);

@override
String toString() {
  return 'HofPeriod(id: $id, name: $name, startsOn: $startsOn, endsOn: $endsOn, isClosed: $isClosed)';
}


}

/// @nodoc
abstract mixin class $HofPeriodCopyWith<$Res>  {
  factory $HofPeriodCopyWith(HofPeriod value, $Res Function(HofPeriod) _then) = _$HofPeriodCopyWithImpl;
@useResult
$Res call({
 int id, String name, DateTime? startsOn, DateTime? endsOn, bool isClosed
});




}
/// @nodoc
class _$HofPeriodCopyWithImpl<$Res>
    implements $HofPeriodCopyWith<$Res> {
  _$HofPeriodCopyWithImpl(this._self, this._then);

  final HofPeriod _self;
  final $Res Function(HofPeriod) _then;

/// Create a copy of HofPeriod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? startsOn = freezed,Object? endsOn = freezed,Object? isClosed = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startsOn: freezed == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime?,endsOn: freezed == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as DateTime?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HofPeriod].
extension HofPeriodPatterns on HofPeriod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HofPeriod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HofPeriod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HofPeriod value)  $default,){
final _that = this;
switch (_that) {
case _HofPeriod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HofPeriod value)?  $default,){
final _that = this;
switch (_that) {
case _HofPeriod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  DateTime? startsOn,  DateTime? endsOn,  bool isClosed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HofPeriod() when $default != null:
return $default(_that.id,_that.name,_that.startsOn,_that.endsOn,_that.isClosed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  DateTime? startsOn,  DateTime? endsOn,  bool isClosed)  $default,) {final _that = this;
switch (_that) {
case _HofPeriod():
return $default(_that.id,_that.name,_that.startsOn,_that.endsOn,_that.isClosed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  DateTime? startsOn,  DateTime? endsOn,  bool isClosed)?  $default,) {final _that = this;
switch (_that) {
case _HofPeriod() when $default != null:
return $default(_that.id,_that.name,_that.startsOn,_that.endsOn,_that.isClosed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HofPeriod implements HofPeriod {
  const _HofPeriod({required this.id, this.name = '', this.startsOn, this.endsOn, this.isClosed = false});
  factory _HofPeriod.fromJson(Map<String, dynamic> json) => _$HofPeriodFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  DateTime? startsOn;
@override final  DateTime? endsOn;
@override@JsonKey() final  bool isClosed;

/// Create a copy of HofPeriod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HofPeriodCopyWith<_HofPeriod> get copyWith => __$HofPeriodCopyWithImpl<_HofPeriod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HofPeriodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HofPeriod&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startsOn,endsOn,isClosed);

@override
String toString() {
  return 'HofPeriod(id: $id, name: $name, startsOn: $startsOn, endsOn: $endsOn, isClosed: $isClosed)';
}


}

/// @nodoc
abstract mixin class _$HofPeriodCopyWith<$Res> implements $HofPeriodCopyWith<$Res> {
  factory _$HofPeriodCopyWith(_HofPeriod value, $Res Function(_HofPeriod) _then) = __$HofPeriodCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, DateTime? startsOn, DateTime? endsOn, bool isClosed
});




}
/// @nodoc
class __$HofPeriodCopyWithImpl<$Res>
    implements _$HofPeriodCopyWith<$Res> {
  __$HofPeriodCopyWithImpl(this._self, this._then);

  final _HofPeriod _self;
  final $Res Function(_HofPeriod) _then;

/// Create a copy of HofPeriod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? startsOn = freezed,Object? endsOn = freezed,Object? isClosed = null,}) {
  return _then(_HofPeriod(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startsOn: freezed == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime?,endsOn: freezed == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as DateTime?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$HofPerson {

@asIntOrNull int? get playerId; String get name; String? get avatarUrl;
/// Create a copy of HofPerson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HofPersonCopyWith<HofPerson> get copyWith => _$HofPersonCopyWithImpl<HofPerson>(this as HofPerson, _$identity);

  /// Serializes this HofPerson to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HofPerson&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,name,avatarUrl);

@override
String toString() {
  return 'HofPerson(playerId: $playerId, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $HofPersonCopyWith<$Res>  {
  factory $HofPersonCopyWith(HofPerson value, $Res Function(HofPerson) _then) = _$HofPersonCopyWithImpl;
@useResult
$Res call({
@asIntOrNull int? playerId, String name, String? avatarUrl
});




}
/// @nodoc
class _$HofPersonCopyWithImpl<$Res>
    implements $HofPersonCopyWith<$Res> {
  _$HofPersonCopyWithImpl(this._self, this._then);

  final HofPerson _self;
  final $Res Function(HofPerson) _then;

/// Create a copy of HofPerson
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = freezed,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HofPerson].
extension HofPersonPatterns on HofPerson {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HofPerson value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HofPerson() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HofPerson value)  $default,){
final _that = this;
switch (_that) {
case _HofPerson():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HofPerson value)?  $default,){
final _that = this;
switch (_that) {
case _HofPerson() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@asIntOrNull  int? playerId,  String name,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HofPerson() when $default != null:
return $default(_that.playerId,_that.name,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@asIntOrNull  int? playerId,  String name,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _HofPerson():
return $default(_that.playerId,_that.name,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@asIntOrNull  int? playerId,  String name,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _HofPerson() when $default != null:
return $default(_that.playerId,_that.name,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HofPerson implements HofPerson {
  const _HofPerson({@asIntOrNull this.playerId, this.name = '', this.avatarUrl});
  factory _HofPerson.fromJson(Map<String, dynamic> json) => _$HofPersonFromJson(json);

@override@asIntOrNull final  int? playerId;
@override@JsonKey() final  String name;
@override final  String? avatarUrl;

/// Create a copy of HofPerson
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HofPersonCopyWith<_HofPerson> get copyWith => __$HofPersonCopyWithImpl<_HofPerson>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HofPersonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HofPerson&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,name,avatarUrl);

@override
String toString() {
  return 'HofPerson(playerId: $playerId, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$HofPersonCopyWith<$Res> implements $HofPersonCopyWith<$Res> {
  factory _$HofPersonCopyWith(_HofPerson value, $Res Function(_HofPerson) _then) = __$HofPersonCopyWithImpl;
@override @useResult
$Res call({
@asIntOrNull int? playerId, String name, String? avatarUrl
});




}
/// @nodoc
class __$HofPersonCopyWithImpl<$Res>
    implements _$HofPersonCopyWith<$Res> {
  __$HofPersonCopyWithImpl(this._self, this._then);

  final _HofPerson _self;
  final $Res Function(_HofPerson) _then;

/// Create a copy of HofPerson
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = freezed,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_HofPerson(
playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$HofTitle {

 String get key; String get label; String get icon;/// `season` (seizoen/periode) of `now` (rollend venster).
 String get group; HofPerson? get holder; List<HofPerson> get holders;@asStringOrNull String? get value;@asStringOrNull String? get caption;
/// Create a copy of HofTitle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HofTitleCopyWith<HofTitle> get copyWith => _$HofTitleCopyWithImpl<HofTitle>(this as HofTitle, _$identity);

  /// Serializes this HofTitle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HofTitle&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.group, group) || other.group == group)&&(identical(other.holder, holder) || other.holder == holder)&&const DeepCollectionEquality().equals(other.holders, holders)&&(identical(other.value, value) || other.value == value)&&(identical(other.caption, caption) || other.caption == caption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label,icon,group,holder,const DeepCollectionEquality().hash(holders),value,caption);

@override
String toString() {
  return 'HofTitle(key: $key, label: $label, icon: $icon, group: $group, holder: $holder, holders: $holders, value: $value, caption: $caption)';
}


}

/// @nodoc
abstract mixin class $HofTitleCopyWith<$Res>  {
  factory $HofTitleCopyWith(HofTitle value, $Res Function(HofTitle) _then) = _$HofTitleCopyWithImpl;
@useResult
$Res call({
 String key, String label, String icon, String group, HofPerson? holder, List<HofPerson> holders,@asStringOrNull String? value,@asStringOrNull String? caption
});


$HofPersonCopyWith<$Res>? get holder;

}
/// @nodoc
class _$HofTitleCopyWithImpl<$Res>
    implements $HofTitleCopyWith<$Res> {
  _$HofTitleCopyWithImpl(this._self, this._then);

  final HofTitle _self;
  final $Res Function(HofTitle) _then;

/// Create a copy of HofTitle
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,Object? icon = null,Object? group = null,Object? holder = freezed,Object? holders = null,Object? value = freezed,Object? caption = freezed,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,holder: freezed == holder ? _self.holder : holder // ignore: cast_nullable_to_non_nullable
as HofPerson?,holders: null == holders ? _self.holders : holders // ignore: cast_nullable_to_non_nullable
as List<HofPerson>,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of HofTitle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HofPersonCopyWith<$Res>? get holder {
    if (_self.holder == null) {
    return null;
  }

  return $HofPersonCopyWith<$Res>(_self.holder!, (value) {
    return _then(_self.copyWith(holder: value));
  });
}
}


/// Adds pattern-matching-related methods to [HofTitle].
extension HofTitlePatterns on HofTitle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HofTitle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HofTitle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HofTitle value)  $default,){
final _that = this;
switch (_that) {
case _HofTitle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HofTitle value)?  $default,){
final _that = this;
switch (_that) {
case _HofTitle() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String label,  String icon,  String group,  HofPerson? holder,  List<HofPerson> holders, @asStringOrNull  String? value, @asStringOrNull  String? caption)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HofTitle() when $default != null:
return $default(_that.key,_that.label,_that.icon,_that.group,_that.holder,_that.holders,_that.value,_that.caption);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String label,  String icon,  String group,  HofPerson? holder,  List<HofPerson> holders, @asStringOrNull  String? value, @asStringOrNull  String? caption)  $default,) {final _that = this;
switch (_that) {
case _HofTitle():
return $default(_that.key,_that.label,_that.icon,_that.group,_that.holder,_that.holders,_that.value,_that.caption);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String label,  String icon,  String group,  HofPerson? holder,  List<HofPerson> holders, @asStringOrNull  String? value, @asStringOrNull  String? caption)?  $default,) {final _that = this;
switch (_that) {
case _HofTitle() when $default != null:
return $default(_that.key,_that.label,_that.icon,_that.group,_that.holder,_that.holders,_that.value,_that.caption);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HofTitle extends HofTitle {
  const _HofTitle({this.key = '', this.label = '', this.icon = '', this.group = 'season', this.holder, final  List<HofPerson> holders = const <HofPerson>[], @asStringOrNull this.value, @asStringOrNull this.caption}): _holders = holders,super._();
  factory _HofTitle.fromJson(Map<String, dynamic> json) => _$HofTitleFromJson(json);

@override@JsonKey() final  String key;
@override@JsonKey() final  String label;
@override@JsonKey() final  String icon;
/// `season` (seizoen/periode) of `now` (rollend venster).
@override@JsonKey() final  String group;
@override final  HofPerson? holder;
 final  List<HofPerson> _holders;
@override@JsonKey() List<HofPerson> get holders {
  if (_holders is EqualUnmodifiableListView) return _holders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_holders);
}

@override@asStringOrNull final  String? value;
@override@asStringOrNull final  String? caption;

/// Create a copy of HofTitle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HofTitleCopyWith<_HofTitle> get copyWith => __$HofTitleCopyWithImpl<_HofTitle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HofTitleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HofTitle&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.group, group) || other.group == group)&&(identical(other.holder, holder) || other.holder == holder)&&const DeepCollectionEquality().equals(other._holders, _holders)&&(identical(other.value, value) || other.value == value)&&(identical(other.caption, caption) || other.caption == caption));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label,icon,group,holder,const DeepCollectionEquality().hash(_holders),value,caption);

@override
String toString() {
  return 'HofTitle(key: $key, label: $label, icon: $icon, group: $group, holder: $holder, holders: $holders, value: $value, caption: $caption)';
}


}

/// @nodoc
abstract mixin class _$HofTitleCopyWith<$Res> implements $HofTitleCopyWith<$Res> {
  factory _$HofTitleCopyWith(_HofTitle value, $Res Function(_HofTitle) _then) = __$HofTitleCopyWithImpl;
@override @useResult
$Res call({
 String key, String label, String icon, String group, HofPerson? holder, List<HofPerson> holders,@asStringOrNull String? value,@asStringOrNull String? caption
});


@override $HofPersonCopyWith<$Res>? get holder;

}
/// @nodoc
class __$HofTitleCopyWithImpl<$Res>
    implements _$HofTitleCopyWith<$Res> {
  __$HofTitleCopyWithImpl(this._self, this._then);

  final _HofTitle _self;
  final $Res Function(_HofTitle) _then;

/// Create a copy of HofTitle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,Object? icon = null,Object? group = null,Object? holder = freezed,Object? holders = null,Object? value = freezed,Object? caption = freezed,}) {
  return _then(_HofTitle(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,group: null == group ? _self.group : group // ignore: cast_nullable_to_non_nullable
as String,holder: freezed == holder ? _self.holder : holder // ignore: cast_nullable_to_non_nullable
as HofPerson?,holders: null == holders ? _self._holders : holders // ignore: cast_nullable_to_non_nullable
as List<HofPerson>,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,caption: freezed == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of HofTitle
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HofPersonCopyWith<$Res>? get holder {
    if (_self.holder == null) {
    return null;
  }

  return $HofPersonCopyWith<$Res>(_self.holder!, (value) {
    return _then(_self.copyWith(holder: value));
  });
}
}


/// @nodoc
mixin _$PeriodAwardWinner {

 String get titleKey; String get label; String get icon;@asStringOrNull String? get value;@asIntOrNull int? get playerId; String get name; String? get avatarUrl;
/// Create a copy of PeriodAwardWinner
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodAwardWinnerCopyWith<PeriodAwardWinner> get copyWith => _$PeriodAwardWinnerCopyWithImpl<PeriodAwardWinner>(this as PeriodAwardWinner, _$identity);

  /// Serializes this PeriodAwardWinner to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodAwardWinner&&(identical(other.titleKey, titleKey) || other.titleKey == titleKey)&&(identical(other.label, label) || other.label == label)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.value, value) || other.value == value)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,titleKey,label,icon,value,playerId,name,avatarUrl);

@override
String toString() {
  return 'PeriodAwardWinner(titleKey: $titleKey, label: $label, icon: $icon, value: $value, playerId: $playerId, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class $PeriodAwardWinnerCopyWith<$Res>  {
  factory $PeriodAwardWinnerCopyWith(PeriodAwardWinner value, $Res Function(PeriodAwardWinner) _then) = _$PeriodAwardWinnerCopyWithImpl;
@useResult
$Res call({
 String titleKey, String label, String icon,@asStringOrNull String? value,@asIntOrNull int? playerId, String name, String? avatarUrl
});




}
/// @nodoc
class _$PeriodAwardWinnerCopyWithImpl<$Res>
    implements $PeriodAwardWinnerCopyWith<$Res> {
  _$PeriodAwardWinnerCopyWithImpl(this._self, this._then);

  final PeriodAwardWinner _self;
  final $Res Function(PeriodAwardWinner) _then;

/// Create a copy of PeriodAwardWinner
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? titleKey = null,Object? label = null,Object? icon = null,Object? value = freezed,Object? playerId = freezed,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_self.copyWith(
titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PeriodAwardWinner].
extension PeriodAwardWinnerPatterns on PeriodAwardWinner {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodAwardWinner value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodAwardWinner() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodAwardWinner value)  $default,){
final _that = this;
switch (_that) {
case _PeriodAwardWinner():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodAwardWinner value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodAwardWinner() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String titleKey,  String label,  String icon, @asStringOrNull  String? value, @asIntOrNull  int? playerId,  String name,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodAwardWinner() when $default != null:
return $default(_that.titleKey,_that.label,_that.icon,_that.value,_that.playerId,_that.name,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String titleKey,  String label,  String icon, @asStringOrNull  String? value, @asIntOrNull  int? playerId,  String name,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _PeriodAwardWinner():
return $default(_that.titleKey,_that.label,_that.icon,_that.value,_that.playerId,_that.name,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String titleKey,  String label,  String icon, @asStringOrNull  String? value, @asIntOrNull  int? playerId,  String name,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _PeriodAwardWinner() when $default != null:
return $default(_that.titleKey,_that.label,_that.icon,_that.value,_that.playerId,_that.name,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PeriodAwardWinner implements PeriodAwardWinner {
  const _PeriodAwardWinner({this.titleKey = '', this.label = '', this.icon = '', @asStringOrNull this.value, @asIntOrNull this.playerId, this.name = '', this.avatarUrl});
  factory _PeriodAwardWinner.fromJson(Map<String, dynamic> json) => _$PeriodAwardWinnerFromJson(json);

@override@JsonKey() final  String titleKey;
@override@JsonKey() final  String label;
@override@JsonKey() final  String icon;
@override@asStringOrNull final  String? value;
@override@asIntOrNull final  int? playerId;
@override@JsonKey() final  String name;
@override final  String? avatarUrl;

/// Create a copy of PeriodAwardWinner
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeriodAwardWinnerCopyWith<_PeriodAwardWinner> get copyWith => __$PeriodAwardWinnerCopyWithImpl<_PeriodAwardWinner>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PeriodAwardWinnerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodAwardWinner&&(identical(other.titleKey, titleKey) || other.titleKey == titleKey)&&(identical(other.label, label) || other.label == label)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.value, value) || other.value == value)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,titleKey,label,icon,value,playerId,name,avatarUrl);

@override
String toString() {
  return 'PeriodAwardWinner(titleKey: $titleKey, label: $label, icon: $icon, value: $value, playerId: $playerId, name: $name, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$PeriodAwardWinnerCopyWith<$Res> implements $PeriodAwardWinnerCopyWith<$Res> {
  factory _$PeriodAwardWinnerCopyWith(_PeriodAwardWinner value, $Res Function(_PeriodAwardWinner) _then) = __$PeriodAwardWinnerCopyWithImpl;
@override @useResult
$Res call({
 String titleKey, String label, String icon,@asStringOrNull String? value,@asIntOrNull int? playerId, String name, String? avatarUrl
});




}
/// @nodoc
class __$PeriodAwardWinnerCopyWithImpl<$Res>
    implements _$PeriodAwardWinnerCopyWith<$Res> {
  __$PeriodAwardWinnerCopyWithImpl(this._self, this._then);

  final _PeriodAwardWinner _self;
  final $Res Function(_PeriodAwardWinner) _then;

/// Create a copy of PeriodAwardWinner
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? titleKey = null,Object? label = null,Object? icon = null,Object? value = freezed,Object? playerId = freezed,Object? name = null,Object? avatarUrl = freezed,}) {
  return _then(_PeriodAwardWinner(
titleKey: null == titleKey ? _self.titleKey : titleKey // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,value: freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String?,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PeriodAwardGroup {

@asInt int get periodId; String get periodName; List<PeriodAwardWinner> get winners;
/// Create a copy of PeriodAwardGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodAwardGroupCopyWith<PeriodAwardGroup> get copyWith => _$PeriodAwardGroupCopyWithImpl<PeriodAwardGroup>(this as PeriodAwardGroup, _$identity);

  /// Serializes this PeriodAwardGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodAwardGroup&&(identical(other.periodId, periodId) || other.periodId == periodId)&&(identical(other.periodName, periodName) || other.periodName == periodName)&&const DeepCollectionEquality().equals(other.winners, winners));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,periodId,periodName,const DeepCollectionEquality().hash(winners));

@override
String toString() {
  return 'PeriodAwardGroup(periodId: $periodId, periodName: $periodName, winners: $winners)';
}


}

/// @nodoc
abstract mixin class $PeriodAwardGroupCopyWith<$Res>  {
  factory $PeriodAwardGroupCopyWith(PeriodAwardGroup value, $Res Function(PeriodAwardGroup) _then) = _$PeriodAwardGroupCopyWithImpl;
@useResult
$Res call({
@asInt int periodId, String periodName, List<PeriodAwardWinner> winners
});




}
/// @nodoc
class _$PeriodAwardGroupCopyWithImpl<$Res>
    implements $PeriodAwardGroupCopyWith<$Res> {
  _$PeriodAwardGroupCopyWithImpl(this._self, this._then);

  final PeriodAwardGroup _self;
  final $Res Function(PeriodAwardGroup) _then;

/// Create a copy of PeriodAwardGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? periodId = null,Object? periodName = null,Object? winners = null,}) {
  return _then(_self.copyWith(
periodId: null == periodId ? _self.periodId : periodId // ignore: cast_nullable_to_non_nullable
as int,periodName: null == periodName ? _self.periodName : periodName // ignore: cast_nullable_to_non_nullable
as String,winners: null == winners ? _self.winners : winners // ignore: cast_nullable_to_non_nullable
as List<PeriodAwardWinner>,
  ));
}

}


/// Adds pattern-matching-related methods to [PeriodAwardGroup].
extension PeriodAwardGroupPatterns on PeriodAwardGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodAwardGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodAwardGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodAwardGroup value)  $default,){
final _that = this;
switch (_that) {
case _PeriodAwardGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodAwardGroup value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodAwardGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@asInt  int periodId,  String periodName,  List<PeriodAwardWinner> winners)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodAwardGroup() when $default != null:
return $default(_that.periodId,_that.periodName,_that.winners);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@asInt  int periodId,  String periodName,  List<PeriodAwardWinner> winners)  $default,) {final _that = this;
switch (_that) {
case _PeriodAwardGroup():
return $default(_that.periodId,_that.periodName,_that.winners);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@asInt  int periodId,  String periodName,  List<PeriodAwardWinner> winners)?  $default,) {final _that = this;
switch (_that) {
case _PeriodAwardGroup() when $default != null:
return $default(_that.periodId,_that.periodName,_that.winners);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PeriodAwardGroup implements PeriodAwardGroup {
  const _PeriodAwardGroup({@asInt required this.periodId, this.periodName = '', final  List<PeriodAwardWinner> winners = const <PeriodAwardWinner>[]}): _winners = winners;
  factory _PeriodAwardGroup.fromJson(Map<String, dynamic> json) => _$PeriodAwardGroupFromJson(json);

@override@asInt final  int periodId;
@override@JsonKey() final  String periodName;
 final  List<PeriodAwardWinner> _winners;
@override@JsonKey() List<PeriodAwardWinner> get winners {
  if (_winners is EqualUnmodifiableListView) return _winners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_winners);
}


/// Create a copy of PeriodAwardGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeriodAwardGroupCopyWith<_PeriodAwardGroup> get copyWith => __$PeriodAwardGroupCopyWithImpl<_PeriodAwardGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PeriodAwardGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodAwardGroup&&(identical(other.periodId, periodId) || other.periodId == periodId)&&(identical(other.periodName, periodName) || other.periodName == periodName)&&const DeepCollectionEquality().equals(other._winners, _winners));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,periodId,periodName,const DeepCollectionEquality().hash(_winners));

@override
String toString() {
  return 'PeriodAwardGroup(periodId: $periodId, periodName: $periodName, winners: $winners)';
}


}

/// @nodoc
abstract mixin class _$PeriodAwardGroupCopyWith<$Res> implements $PeriodAwardGroupCopyWith<$Res> {
  factory _$PeriodAwardGroupCopyWith(_PeriodAwardGroup value, $Res Function(_PeriodAwardGroup) _then) = __$PeriodAwardGroupCopyWithImpl;
@override @useResult
$Res call({
@asInt int periodId, String periodName, List<PeriodAwardWinner> winners
});




}
/// @nodoc
class __$PeriodAwardGroupCopyWithImpl<$Res>
    implements _$PeriodAwardGroupCopyWith<$Res> {
  __$PeriodAwardGroupCopyWithImpl(this._self, this._then);

  final _PeriodAwardGroup _self;
  final $Res Function(_PeriodAwardGroup) _then;

/// Create a copy of PeriodAwardGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? periodId = null,Object? periodName = null,Object? winners = null,}) {
  return _then(_PeriodAwardGroup(
periodId: null == periodId ? _self.periodId : periodId // ignore: cast_nullable_to_non_nullable
as int,periodName: null == periodName ? _self.periodName : periodName // ignore: cast_nullable_to_non_nullable
as String,winners: null == winners ? _self._winners : winners // ignore: cast_nullable_to_non_nullable
as List<PeriodAwardWinner>,
  ));
}


}


/// @nodoc
mixin _$HofLeader {

@asInt int get playerId; String get name; String? get avatarUrl;@asInt int get goals;@asInt int get assists;@asInt int get minutes;@asInt int get shifts;@asInt int get wins;@asInt int get points;@asInt int get aces;@asInt int get blocks;
/// Create a copy of HofLeader
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HofLeaderCopyWith<HofLeader> get copyWith => _$HofLeaderCopyWithImpl<HofLeader>(this as HofLeader, _$identity);

  /// Serializes this HofLeader to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HofLeader&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.goals, goals) || other.goals == goals)&&(identical(other.assists, assists) || other.assists == assists)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.shifts, shifts) || other.shifts == shifts)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.points, points) || other.points == points)&&(identical(other.aces, aces) || other.aces == aces)&&(identical(other.blocks, blocks) || other.blocks == blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,name,avatarUrl,goals,assists,minutes,shifts,wins,points,aces,blocks);

@override
String toString() {
  return 'HofLeader(playerId: $playerId, name: $name, avatarUrl: $avatarUrl, goals: $goals, assists: $assists, minutes: $minutes, shifts: $shifts, wins: $wins, points: $points, aces: $aces, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class $HofLeaderCopyWith<$Res>  {
  factory $HofLeaderCopyWith(HofLeader value, $Res Function(HofLeader) _then) = _$HofLeaderCopyWithImpl;
@useResult
$Res call({
@asInt int playerId, String name, String? avatarUrl,@asInt int goals,@asInt int assists,@asInt int minutes,@asInt int shifts,@asInt int wins,@asInt int points,@asInt int aces,@asInt int blocks
});




}
/// @nodoc
class _$HofLeaderCopyWithImpl<$Res>
    implements $HofLeaderCopyWith<$Res> {
  _$HofLeaderCopyWithImpl(this._self, this._then);

  final HofLeader _self;
  final $Res Function(HofLeader) _then;

/// Create a copy of HofLeader
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? name = null,Object? avatarUrl = freezed,Object? goals = null,Object? assists = null,Object? minutes = null,Object? shifts = null,Object? wins = null,Object? points = null,Object? aces = null,Object? blocks = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as int,assists: null == assists ? _self.assists : assists // ignore: cast_nullable_to_non_nullable
as int,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,shifts: null == shifts ? _self.shifts : shifts // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,aces: null == aces ? _self.aces : aces // ignore: cast_nullable_to_non_nullable
as int,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HofLeader].
extension HofLeaderPatterns on HofLeader {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HofLeader value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HofLeader() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HofLeader value)  $default,){
final _that = this;
switch (_that) {
case _HofLeader():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HofLeader value)?  $default,){
final _that = this;
switch (_that) {
case _HofLeader() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@asInt  int playerId,  String name,  String? avatarUrl, @asInt  int goals, @asInt  int assists, @asInt  int minutes, @asInt  int shifts, @asInt  int wins, @asInt  int points, @asInt  int aces, @asInt  int blocks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HofLeader() when $default != null:
return $default(_that.playerId,_that.name,_that.avatarUrl,_that.goals,_that.assists,_that.minutes,_that.shifts,_that.wins,_that.points,_that.aces,_that.blocks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@asInt  int playerId,  String name,  String? avatarUrl, @asInt  int goals, @asInt  int assists, @asInt  int minutes, @asInt  int shifts, @asInt  int wins, @asInt  int points, @asInt  int aces, @asInt  int blocks)  $default,) {final _that = this;
switch (_that) {
case _HofLeader():
return $default(_that.playerId,_that.name,_that.avatarUrl,_that.goals,_that.assists,_that.minutes,_that.shifts,_that.wins,_that.points,_that.aces,_that.blocks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@asInt  int playerId,  String name,  String? avatarUrl, @asInt  int goals, @asInt  int assists, @asInt  int minutes, @asInt  int shifts, @asInt  int wins, @asInt  int points, @asInt  int aces, @asInt  int blocks)?  $default,) {final _that = this;
switch (_that) {
case _HofLeader() when $default != null:
return $default(_that.playerId,_that.name,_that.avatarUrl,_that.goals,_that.assists,_that.minutes,_that.shifts,_that.wins,_that.points,_that.aces,_that.blocks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HofLeader implements HofLeader {
  const _HofLeader({@asInt required this.playerId, this.name = '', this.avatarUrl, @asInt this.goals = 0, @asInt this.assists = 0, @asInt this.minutes = 0, @asInt this.shifts = 0, @asInt this.wins = 0, @asInt this.points = 0, @asInt this.aces = 0, @asInt this.blocks = 0});
  factory _HofLeader.fromJson(Map<String, dynamic> json) => _$HofLeaderFromJson(json);

@override@asInt final  int playerId;
@override@JsonKey() final  String name;
@override final  String? avatarUrl;
@override@asInt final  int goals;
@override@asInt final  int assists;
@override@asInt final  int minutes;
@override@asInt final  int shifts;
@override@asInt final  int wins;
@override@asInt final  int points;
@override@asInt final  int aces;
@override@asInt final  int blocks;

/// Create a copy of HofLeader
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HofLeaderCopyWith<_HofLeader> get copyWith => __$HofLeaderCopyWithImpl<_HofLeader>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HofLeaderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HofLeader&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.goals, goals) || other.goals == goals)&&(identical(other.assists, assists) || other.assists == assists)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.shifts, shifts) || other.shifts == shifts)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.points, points) || other.points == points)&&(identical(other.aces, aces) || other.aces == aces)&&(identical(other.blocks, blocks) || other.blocks == blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,name,avatarUrl,goals,assists,minutes,shifts,wins,points,aces,blocks);

@override
String toString() {
  return 'HofLeader(playerId: $playerId, name: $name, avatarUrl: $avatarUrl, goals: $goals, assists: $assists, minutes: $minutes, shifts: $shifts, wins: $wins, points: $points, aces: $aces, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class _$HofLeaderCopyWith<$Res> implements $HofLeaderCopyWith<$Res> {
  factory _$HofLeaderCopyWith(_HofLeader value, $Res Function(_HofLeader) _then) = __$HofLeaderCopyWithImpl;
@override @useResult
$Res call({
@asInt int playerId, String name, String? avatarUrl,@asInt int goals,@asInt int assists,@asInt int minutes,@asInt int shifts,@asInt int wins,@asInt int points,@asInt int aces,@asInt int blocks
});




}
/// @nodoc
class __$HofLeaderCopyWithImpl<$Res>
    implements _$HofLeaderCopyWith<$Res> {
  __$HofLeaderCopyWithImpl(this._self, this._then);

  final _HofLeader _self;
  final $Res Function(_HofLeader) _then;

/// Create a copy of HofLeader
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? name = null,Object? avatarUrl = freezed,Object? goals = null,Object? assists = null,Object? minutes = null,Object? shifts = null,Object? wins = null,Object? points = null,Object? aces = null,Object? blocks = null,}) {
  return _then(_HofLeader(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as int,assists: null == assists ? _self.assists : assists // ignore: cast_nullable_to_non_nullable
as int,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,shifts: null == shifts ? _self.shifts : shifts // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,aces: null == aces ? _self.aces : aces // ignore: cast_nullable_to_non_nullable
as int,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PostMatchLeaderboards {

 List<HofLeader> get points; List<HofLeader> get aces; List<HofLeader> get blocks;
/// Create a copy of PostMatchLeaderboards
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostMatchLeaderboardsCopyWith<PostMatchLeaderboards> get copyWith => _$PostMatchLeaderboardsCopyWithImpl<PostMatchLeaderboards>(this as PostMatchLeaderboards, _$identity);

  /// Serializes this PostMatchLeaderboards to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostMatchLeaderboards&&const DeepCollectionEquality().equals(other.points, points)&&const DeepCollectionEquality().equals(other.aces, aces)&&const DeepCollectionEquality().equals(other.blocks, blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(points),const DeepCollectionEquality().hash(aces),const DeepCollectionEquality().hash(blocks));

@override
String toString() {
  return 'PostMatchLeaderboards(points: $points, aces: $aces, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class $PostMatchLeaderboardsCopyWith<$Res>  {
  factory $PostMatchLeaderboardsCopyWith(PostMatchLeaderboards value, $Res Function(PostMatchLeaderboards) _then) = _$PostMatchLeaderboardsCopyWithImpl;
@useResult
$Res call({
 List<HofLeader> points, List<HofLeader> aces, List<HofLeader> blocks
});




}
/// @nodoc
class _$PostMatchLeaderboardsCopyWithImpl<$Res>
    implements $PostMatchLeaderboardsCopyWith<$Res> {
  _$PostMatchLeaderboardsCopyWithImpl(this._self, this._then);

  final PostMatchLeaderboards _self;
  final $Res Function(PostMatchLeaderboards) _then;

/// Create a copy of PostMatchLeaderboards
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? points = null,Object? aces = null,Object? blocks = null,}) {
  return _then(_self.copyWith(
points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<HofLeader>,aces: null == aces ? _self.aces : aces // ignore: cast_nullable_to_non_nullable
as List<HofLeader>,blocks: null == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<HofLeader>,
  ));
}

}


/// Adds pattern-matching-related methods to [PostMatchLeaderboards].
extension PostMatchLeaderboardsPatterns on PostMatchLeaderboards {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostMatchLeaderboards value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostMatchLeaderboards() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostMatchLeaderboards value)  $default,){
final _that = this;
switch (_that) {
case _PostMatchLeaderboards():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostMatchLeaderboards value)?  $default,){
final _that = this;
switch (_that) {
case _PostMatchLeaderboards() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HofLeader> points,  List<HofLeader> aces,  List<HofLeader> blocks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostMatchLeaderboards() when $default != null:
return $default(_that.points,_that.aces,_that.blocks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HofLeader> points,  List<HofLeader> aces,  List<HofLeader> blocks)  $default,) {final _that = this;
switch (_that) {
case _PostMatchLeaderboards():
return $default(_that.points,_that.aces,_that.blocks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HofLeader> points,  List<HofLeader> aces,  List<HofLeader> blocks)?  $default,) {final _that = this;
switch (_that) {
case _PostMatchLeaderboards() when $default != null:
return $default(_that.points,_that.aces,_that.blocks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostMatchLeaderboards implements PostMatchLeaderboards {
  const _PostMatchLeaderboards({final  List<HofLeader> points = const <HofLeader>[], final  List<HofLeader> aces = const <HofLeader>[], final  List<HofLeader> blocks = const <HofLeader>[]}): _points = points,_aces = aces,_blocks = blocks;
  factory _PostMatchLeaderboards.fromJson(Map<String, dynamic> json) => _$PostMatchLeaderboardsFromJson(json);

 final  List<HofLeader> _points;
@override@JsonKey() List<HofLeader> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

 final  List<HofLeader> _aces;
@override@JsonKey() List<HofLeader> get aces {
  if (_aces is EqualUnmodifiableListView) return _aces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_aces);
}

 final  List<HofLeader> _blocks;
@override@JsonKey() List<HofLeader> get blocks {
  if (_blocks is EqualUnmodifiableListView) return _blocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocks);
}


/// Create a copy of PostMatchLeaderboards
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostMatchLeaderboardsCopyWith<_PostMatchLeaderboards> get copyWith => __$PostMatchLeaderboardsCopyWithImpl<_PostMatchLeaderboards>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostMatchLeaderboardsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostMatchLeaderboards&&const DeepCollectionEquality().equals(other._points, _points)&&const DeepCollectionEquality().equals(other._aces, _aces)&&const DeepCollectionEquality().equals(other._blocks, _blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_points),const DeepCollectionEquality().hash(_aces),const DeepCollectionEquality().hash(_blocks));

@override
String toString() {
  return 'PostMatchLeaderboards(points: $points, aces: $aces, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class _$PostMatchLeaderboardsCopyWith<$Res> implements $PostMatchLeaderboardsCopyWith<$Res> {
  factory _$PostMatchLeaderboardsCopyWith(_PostMatchLeaderboards value, $Res Function(_PostMatchLeaderboards) _then) = __$PostMatchLeaderboardsCopyWithImpl;
@override @useResult
$Res call({
 List<HofLeader> points, List<HofLeader> aces, List<HofLeader> blocks
});




}
/// @nodoc
class __$PostMatchLeaderboardsCopyWithImpl<$Res>
    implements _$PostMatchLeaderboardsCopyWith<$Res> {
  __$PostMatchLeaderboardsCopyWithImpl(this._self, this._then);

  final _PostMatchLeaderboards _self;
  final $Res Function(_PostMatchLeaderboards) _then;

/// Create a copy of PostMatchLeaderboards
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? points = null,Object? aces = null,Object? blocks = null,}) {
  return _then(_PostMatchLeaderboards(
points: null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<HofLeader>,aces: null == aces ? _self._aces : aces // ignore: cast_nullable_to_non_nullable
as List<HofLeader>,blocks: null == blocks ? _self._blocks : blocks // ignore: cast_nullable_to_non_nullable
as List<HofLeader>,
  ));
}


}


/// @nodoc
mixin _$HofBadge {

 String get key; String get icon; String get label;
/// Create a copy of HofBadge
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HofBadgeCopyWith<HofBadge> get copyWith => _$HofBadgeCopyWithImpl<HofBadge>(this as HofBadge, _$identity);

  /// Serializes this HofBadge to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HofBadge&&(identical(other.key, key) || other.key == key)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,icon,label);

@override
String toString() {
  return 'HofBadge(key: $key, icon: $icon, label: $label)';
}


}

/// @nodoc
abstract mixin class $HofBadgeCopyWith<$Res>  {
  factory $HofBadgeCopyWith(HofBadge value, $Res Function(HofBadge) _then) = _$HofBadgeCopyWithImpl;
@useResult
$Res call({
 String key, String icon, String label
});




}
/// @nodoc
class _$HofBadgeCopyWithImpl<$Res>
    implements $HofBadgeCopyWith<$Res> {
  _$HofBadgeCopyWithImpl(this._self, this._then);

  final HofBadge _self;
  final $Res Function(HofBadge) _then;

/// Create a copy of HofBadge
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? icon = null,Object? label = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HofBadge].
extension HofBadgePatterns on HofBadge {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HofBadge value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HofBadge() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HofBadge value)  $default,){
final _that = this;
switch (_that) {
case _HofBadge():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HofBadge value)?  $default,){
final _that = this;
switch (_that) {
case _HofBadge() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String icon,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HofBadge() when $default != null:
return $default(_that.key,_that.icon,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String icon,  String label)  $default,) {final _that = this;
switch (_that) {
case _HofBadge():
return $default(_that.key,_that.icon,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String icon,  String label)?  $default,) {final _that = this;
switch (_that) {
case _HofBadge() when $default != null:
return $default(_that.key,_that.icon,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HofBadge implements HofBadge {
  const _HofBadge({this.key = '', this.icon = '', this.label = ''});
  factory _HofBadge.fromJson(Map<String, dynamic> json) => _$HofBadgeFromJson(json);

@override@JsonKey() final  String key;
@override@JsonKey() final  String icon;
@override@JsonKey() final  String label;

/// Create a copy of HofBadge
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HofBadgeCopyWith<_HofBadge> get copyWith => __$HofBadgeCopyWithImpl<_HofBadge>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HofBadgeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HofBadge&&(identical(other.key, key) || other.key == key)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,icon,label);

@override
String toString() {
  return 'HofBadge(key: $key, icon: $icon, label: $label)';
}


}

/// @nodoc
abstract mixin class _$HofBadgeCopyWith<$Res> implements $HofBadgeCopyWith<$Res> {
  factory _$HofBadgeCopyWith(_HofBadge value, $Res Function(_HofBadge) _then) = __$HofBadgeCopyWithImpl;
@override @useResult
$Res call({
 String key, String icon, String label
});




}
/// @nodoc
class __$HofBadgeCopyWithImpl<$Res>
    implements _$HofBadgeCopyWith<$Res> {
  __$HofBadgeCopyWithImpl(this._self, this._then);

  final _HofBadge _self;
  final $Res Function(_HofBadge) _then;

/// Create a copy of HofBadge
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? icon = null,Object? label = null,}) {
  return _then(_HofBadge(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$BadgePlayer {

@asInt int get playerId; String get name;@asIntOrNull int? get shirtNumber; String? get avatarUrl; List<HofBadge> get badges;
/// Create a copy of BadgePlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BadgePlayerCopyWith<BadgePlayer> get copyWith => _$BadgePlayerCopyWithImpl<BadgePlayer>(this as BadgePlayer, _$identity);

  /// Serializes this BadgePlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BadgePlayer&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&const DeepCollectionEquality().equals(other.badges, badges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,name,shirtNumber,avatarUrl,const DeepCollectionEquality().hash(badges));

@override
String toString() {
  return 'BadgePlayer(playerId: $playerId, name: $name, shirtNumber: $shirtNumber, avatarUrl: $avatarUrl, badges: $badges)';
}


}

/// @nodoc
abstract mixin class $BadgePlayerCopyWith<$Res>  {
  factory $BadgePlayerCopyWith(BadgePlayer value, $Res Function(BadgePlayer) _then) = _$BadgePlayerCopyWithImpl;
@useResult
$Res call({
@asInt int playerId, String name,@asIntOrNull int? shirtNumber, String? avatarUrl, List<HofBadge> badges
});




}
/// @nodoc
class _$BadgePlayerCopyWithImpl<$Res>
    implements $BadgePlayerCopyWith<$Res> {
  _$BadgePlayerCopyWithImpl(this._self, this._then);

  final BadgePlayer _self;
  final $Res Function(BadgePlayer) _then;

/// Create a copy of BadgePlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? name = null,Object? shirtNumber = freezed,Object? avatarUrl = freezed,Object? badges = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,badges: null == badges ? _self.badges : badges // ignore: cast_nullable_to_non_nullable
as List<HofBadge>,
  ));
}

}


/// Adds pattern-matching-related methods to [BadgePlayer].
extension BadgePlayerPatterns on BadgePlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BadgePlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BadgePlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BadgePlayer value)  $default,){
final _that = this;
switch (_that) {
case _BadgePlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BadgePlayer value)?  $default,){
final _that = this;
switch (_that) {
case _BadgePlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@asInt  int playerId,  String name, @asIntOrNull  int? shirtNumber,  String? avatarUrl,  List<HofBadge> badges)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BadgePlayer() when $default != null:
return $default(_that.playerId,_that.name,_that.shirtNumber,_that.avatarUrl,_that.badges);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@asInt  int playerId,  String name, @asIntOrNull  int? shirtNumber,  String? avatarUrl,  List<HofBadge> badges)  $default,) {final _that = this;
switch (_that) {
case _BadgePlayer():
return $default(_that.playerId,_that.name,_that.shirtNumber,_that.avatarUrl,_that.badges);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@asInt  int playerId,  String name, @asIntOrNull  int? shirtNumber,  String? avatarUrl,  List<HofBadge> badges)?  $default,) {final _that = this;
switch (_that) {
case _BadgePlayer() when $default != null:
return $default(_that.playerId,_that.name,_that.shirtNumber,_that.avatarUrl,_that.badges);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BadgePlayer implements BadgePlayer {
  const _BadgePlayer({@asInt required this.playerId, this.name = '', @asIntOrNull this.shirtNumber, this.avatarUrl, final  List<HofBadge> badges = const <HofBadge>[]}): _badges = badges;
  factory _BadgePlayer.fromJson(Map<String, dynamic> json) => _$BadgePlayerFromJson(json);

@override@asInt final  int playerId;
@override@JsonKey() final  String name;
@override@asIntOrNull final  int? shirtNumber;
@override final  String? avatarUrl;
 final  List<HofBadge> _badges;
@override@JsonKey() List<HofBadge> get badges {
  if (_badges is EqualUnmodifiableListView) return _badges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_badges);
}


/// Create a copy of BadgePlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BadgePlayerCopyWith<_BadgePlayer> get copyWith => __$BadgePlayerCopyWithImpl<_BadgePlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BadgePlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BadgePlayer&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&const DeepCollectionEquality().equals(other._badges, _badges));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,name,shirtNumber,avatarUrl,const DeepCollectionEquality().hash(_badges));

@override
String toString() {
  return 'BadgePlayer(playerId: $playerId, name: $name, shirtNumber: $shirtNumber, avatarUrl: $avatarUrl, badges: $badges)';
}


}

/// @nodoc
abstract mixin class _$BadgePlayerCopyWith<$Res> implements $BadgePlayerCopyWith<$Res> {
  factory _$BadgePlayerCopyWith(_BadgePlayer value, $Res Function(_BadgePlayer) _then) = __$BadgePlayerCopyWithImpl;
@override @useResult
$Res call({
@asInt int playerId, String name,@asIntOrNull int? shirtNumber, String? avatarUrl, List<HofBadge> badges
});




}
/// @nodoc
class __$BadgePlayerCopyWithImpl<$Res>
    implements _$BadgePlayerCopyWith<$Res> {
  __$BadgePlayerCopyWithImpl(this._self, this._then);

  final _BadgePlayer _self;
  final $Res Function(_BadgePlayer) _then;

/// Create a copy of BadgePlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? name = null,Object? shirtNumber = freezed,Object? avatarUrl = freezed,Object? badges = null,}) {
  return _then(_BadgePlayer(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,badges: null == badges ? _self._badges : badges // ignore: cast_nullable_to_non_nullable
as List<HofBadge>,
  ));
}


}


/// @nodoc
mixin _$HallOfFame {

@asIntOrNull int? get seasonId; List<SeasonOption> get seasons;@asIntOrNull int? get periodId; List<HofPeriod> get periods; List<PeriodAwardGroup> get periodAwards; List<HofTitle> get titles; List<HofLeader>? get topScorers; List<HofLeader>? get topAssisters; List<HofLeader>? get topFlaggers; PostMatchLeaderboards? get postMatchLeaderboards; List<HofLeader> get topMotm; List<BadgePlayer> get playersWithBadges; bool get trainingPointsEnabled; List<HofLeader> get topTrainingPoints;
/// Create a copy of HallOfFame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HallOfFameCopyWith<HallOfFame> get copyWith => _$HallOfFameCopyWithImpl<HallOfFame>(this as HallOfFame, _$identity);

  /// Serializes this HallOfFame to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HallOfFame&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&const DeepCollectionEquality().equals(other.seasons, seasons)&&(identical(other.periodId, periodId) || other.periodId == periodId)&&const DeepCollectionEquality().equals(other.periods, periods)&&const DeepCollectionEquality().equals(other.periodAwards, periodAwards)&&const DeepCollectionEquality().equals(other.titles, titles)&&const DeepCollectionEquality().equals(other.topScorers, topScorers)&&const DeepCollectionEquality().equals(other.topAssisters, topAssisters)&&const DeepCollectionEquality().equals(other.topFlaggers, topFlaggers)&&(identical(other.postMatchLeaderboards, postMatchLeaderboards) || other.postMatchLeaderboards == postMatchLeaderboards)&&const DeepCollectionEquality().equals(other.topMotm, topMotm)&&const DeepCollectionEquality().equals(other.playersWithBadges, playersWithBadges)&&(identical(other.trainingPointsEnabled, trainingPointsEnabled) || other.trainingPointsEnabled == trainingPointsEnabled)&&const DeepCollectionEquality().equals(other.topTrainingPoints, topTrainingPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seasonId,const DeepCollectionEquality().hash(seasons),periodId,const DeepCollectionEquality().hash(periods),const DeepCollectionEquality().hash(periodAwards),const DeepCollectionEquality().hash(titles),const DeepCollectionEquality().hash(topScorers),const DeepCollectionEquality().hash(topAssisters),const DeepCollectionEquality().hash(topFlaggers),postMatchLeaderboards,const DeepCollectionEquality().hash(topMotm),const DeepCollectionEquality().hash(playersWithBadges),trainingPointsEnabled,const DeepCollectionEquality().hash(topTrainingPoints));

@override
String toString() {
  return 'HallOfFame(seasonId: $seasonId, seasons: $seasons, periodId: $periodId, periods: $periods, periodAwards: $periodAwards, titles: $titles, topScorers: $topScorers, topAssisters: $topAssisters, topFlaggers: $topFlaggers, postMatchLeaderboards: $postMatchLeaderboards, topMotm: $topMotm, playersWithBadges: $playersWithBadges, trainingPointsEnabled: $trainingPointsEnabled, topTrainingPoints: $topTrainingPoints)';
}


}

/// @nodoc
abstract mixin class $HallOfFameCopyWith<$Res>  {
  factory $HallOfFameCopyWith(HallOfFame value, $Res Function(HallOfFame) _then) = _$HallOfFameCopyWithImpl;
@useResult
$Res call({
@asIntOrNull int? seasonId, List<SeasonOption> seasons,@asIntOrNull int? periodId, List<HofPeriod> periods, List<PeriodAwardGroup> periodAwards, List<HofTitle> titles, List<HofLeader>? topScorers, List<HofLeader>? topAssisters, List<HofLeader>? topFlaggers, PostMatchLeaderboards? postMatchLeaderboards, List<HofLeader> topMotm, List<BadgePlayer> playersWithBadges, bool trainingPointsEnabled, List<HofLeader> topTrainingPoints
});


$PostMatchLeaderboardsCopyWith<$Res>? get postMatchLeaderboards;

}
/// @nodoc
class _$HallOfFameCopyWithImpl<$Res>
    implements $HallOfFameCopyWith<$Res> {
  _$HallOfFameCopyWithImpl(this._self, this._then);

  final HallOfFame _self;
  final $Res Function(HallOfFame) _then;

/// Create a copy of HallOfFame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? seasonId = freezed,Object? seasons = null,Object? periodId = freezed,Object? periods = null,Object? periodAwards = null,Object? titles = null,Object? topScorers = freezed,Object? topAssisters = freezed,Object? topFlaggers = freezed,Object? postMatchLeaderboards = freezed,Object? topMotm = null,Object? playersWithBadges = null,Object? trainingPointsEnabled = null,Object? topTrainingPoints = null,}) {
  return _then(_self.copyWith(
seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as int?,seasons: null == seasons ? _self.seasons : seasons // ignore: cast_nullable_to_non_nullable
as List<SeasonOption>,periodId: freezed == periodId ? _self.periodId : periodId // ignore: cast_nullable_to_non_nullable
as int?,periods: null == periods ? _self.periods : periods // ignore: cast_nullable_to_non_nullable
as List<HofPeriod>,periodAwards: null == periodAwards ? _self.periodAwards : periodAwards // ignore: cast_nullable_to_non_nullable
as List<PeriodAwardGroup>,titles: null == titles ? _self.titles : titles // ignore: cast_nullable_to_non_nullable
as List<HofTitle>,topScorers: freezed == topScorers ? _self.topScorers : topScorers // ignore: cast_nullable_to_non_nullable
as List<HofLeader>?,topAssisters: freezed == topAssisters ? _self.topAssisters : topAssisters // ignore: cast_nullable_to_non_nullable
as List<HofLeader>?,topFlaggers: freezed == topFlaggers ? _self.topFlaggers : topFlaggers // ignore: cast_nullable_to_non_nullable
as List<HofLeader>?,postMatchLeaderboards: freezed == postMatchLeaderboards ? _self.postMatchLeaderboards : postMatchLeaderboards // ignore: cast_nullable_to_non_nullable
as PostMatchLeaderboards?,topMotm: null == topMotm ? _self.topMotm : topMotm // ignore: cast_nullable_to_non_nullable
as List<HofLeader>,playersWithBadges: null == playersWithBadges ? _self.playersWithBadges : playersWithBadges // ignore: cast_nullable_to_non_nullable
as List<BadgePlayer>,trainingPointsEnabled: null == trainingPointsEnabled ? _self.trainingPointsEnabled : trainingPointsEnabled // ignore: cast_nullable_to_non_nullable
as bool,topTrainingPoints: null == topTrainingPoints ? _self.topTrainingPoints : topTrainingPoints // ignore: cast_nullable_to_non_nullable
as List<HofLeader>,
  ));
}
/// Create a copy of HallOfFame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostMatchLeaderboardsCopyWith<$Res>? get postMatchLeaderboards {
    if (_self.postMatchLeaderboards == null) {
    return null;
  }

  return $PostMatchLeaderboardsCopyWith<$Res>(_self.postMatchLeaderboards!, (value) {
    return _then(_self.copyWith(postMatchLeaderboards: value));
  });
}
}


/// Adds pattern-matching-related methods to [HallOfFame].
extension HallOfFamePatterns on HallOfFame {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HallOfFame value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HallOfFame() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HallOfFame value)  $default,){
final _that = this;
switch (_that) {
case _HallOfFame():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HallOfFame value)?  $default,){
final _that = this;
switch (_that) {
case _HallOfFame() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@asIntOrNull  int? seasonId,  List<SeasonOption> seasons, @asIntOrNull  int? periodId,  List<HofPeriod> periods,  List<PeriodAwardGroup> periodAwards,  List<HofTitle> titles,  List<HofLeader>? topScorers,  List<HofLeader>? topAssisters,  List<HofLeader>? topFlaggers,  PostMatchLeaderboards? postMatchLeaderboards,  List<HofLeader> topMotm,  List<BadgePlayer> playersWithBadges,  bool trainingPointsEnabled,  List<HofLeader> topTrainingPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HallOfFame() when $default != null:
return $default(_that.seasonId,_that.seasons,_that.periodId,_that.periods,_that.periodAwards,_that.titles,_that.topScorers,_that.topAssisters,_that.topFlaggers,_that.postMatchLeaderboards,_that.topMotm,_that.playersWithBadges,_that.trainingPointsEnabled,_that.topTrainingPoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@asIntOrNull  int? seasonId,  List<SeasonOption> seasons, @asIntOrNull  int? periodId,  List<HofPeriod> periods,  List<PeriodAwardGroup> periodAwards,  List<HofTitle> titles,  List<HofLeader>? topScorers,  List<HofLeader>? topAssisters,  List<HofLeader>? topFlaggers,  PostMatchLeaderboards? postMatchLeaderboards,  List<HofLeader> topMotm,  List<BadgePlayer> playersWithBadges,  bool trainingPointsEnabled,  List<HofLeader> topTrainingPoints)  $default,) {final _that = this;
switch (_that) {
case _HallOfFame():
return $default(_that.seasonId,_that.seasons,_that.periodId,_that.periods,_that.periodAwards,_that.titles,_that.topScorers,_that.topAssisters,_that.topFlaggers,_that.postMatchLeaderboards,_that.topMotm,_that.playersWithBadges,_that.trainingPointsEnabled,_that.topTrainingPoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@asIntOrNull  int? seasonId,  List<SeasonOption> seasons, @asIntOrNull  int? periodId,  List<HofPeriod> periods,  List<PeriodAwardGroup> periodAwards,  List<HofTitle> titles,  List<HofLeader>? topScorers,  List<HofLeader>? topAssisters,  List<HofLeader>? topFlaggers,  PostMatchLeaderboards? postMatchLeaderboards,  List<HofLeader> topMotm,  List<BadgePlayer> playersWithBadges,  bool trainingPointsEnabled,  List<HofLeader> topTrainingPoints)?  $default,) {final _that = this;
switch (_that) {
case _HallOfFame() when $default != null:
return $default(_that.seasonId,_that.seasons,_that.periodId,_that.periods,_that.periodAwards,_that.titles,_that.topScorers,_that.topAssisters,_that.topFlaggers,_that.postMatchLeaderboards,_that.topMotm,_that.playersWithBadges,_that.trainingPointsEnabled,_that.topTrainingPoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HallOfFame extends HallOfFame {
  const _HallOfFame({@asIntOrNull this.seasonId, final  List<SeasonOption> seasons = const <SeasonOption>[], @asIntOrNull this.periodId, final  List<HofPeriod> periods = const <HofPeriod>[], final  List<PeriodAwardGroup> periodAwards = const <PeriodAwardGroup>[], final  List<HofTitle> titles = const <HofTitle>[], final  List<HofLeader>? topScorers, final  List<HofLeader>? topAssisters, final  List<HofLeader>? topFlaggers, this.postMatchLeaderboards, final  List<HofLeader> topMotm = const <HofLeader>[], final  List<BadgePlayer> playersWithBadges = const <BadgePlayer>[], this.trainingPointsEnabled = false, final  List<HofLeader> topTrainingPoints = const <HofLeader>[]}): _seasons = seasons,_periods = periods,_periodAwards = periodAwards,_titles = titles,_topScorers = topScorers,_topAssisters = topAssisters,_topFlaggers = topFlaggers,_topMotm = topMotm,_playersWithBadges = playersWithBadges,_topTrainingPoints = topTrainingPoints,super._();
  factory _HallOfFame.fromJson(Map<String, dynamic> json) => _$HallOfFameFromJson(json);

@override@asIntOrNull final  int? seasonId;
 final  List<SeasonOption> _seasons;
@override@JsonKey() List<SeasonOption> get seasons {
  if (_seasons is EqualUnmodifiableListView) return _seasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_seasons);
}

@override@asIntOrNull final  int? periodId;
 final  List<HofPeriod> _periods;
@override@JsonKey() List<HofPeriod> get periods {
  if (_periods is EqualUnmodifiableListView) return _periods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_periods);
}

 final  List<PeriodAwardGroup> _periodAwards;
@override@JsonKey() List<PeriodAwardGroup> get periodAwards {
  if (_periodAwards is EqualUnmodifiableListView) return _periodAwards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_periodAwards);
}

 final  List<HofTitle> _titles;
@override@JsonKey() List<HofTitle> get titles {
  if (_titles is EqualUnmodifiableListView) return _titles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_titles);
}

 final  List<HofLeader>? _topScorers;
@override List<HofLeader>? get topScorers {
  final value = _topScorers;
  if (value == null) return null;
  if (_topScorers is EqualUnmodifiableListView) return _topScorers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<HofLeader>? _topAssisters;
@override List<HofLeader>? get topAssisters {
  final value = _topAssisters;
  if (value == null) return null;
  if (_topAssisters is EqualUnmodifiableListView) return _topAssisters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<HofLeader>? _topFlaggers;
@override List<HofLeader>? get topFlaggers {
  final value = _topFlaggers;
  if (value == null) return null;
  if (_topFlaggers is EqualUnmodifiableListView) return _topFlaggers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  PostMatchLeaderboards? postMatchLeaderboards;
 final  List<HofLeader> _topMotm;
@override@JsonKey() List<HofLeader> get topMotm {
  if (_topMotm is EqualUnmodifiableListView) return _topMotm;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topMotm);
}

 final  List<BadgePlayer> _playersWithBadges;
@override@JsonKey() List<BadgePlayer> get playersWithBadges {
  if (_playersWithBadges is EqualUnmodifiableListView) return _playersWithBadges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_playersWithBadges);
}

@override@JsonKey() final  bool trainingPointsEnabled;
 final  List<HofLeader> _topTrainingPoints;
@override@JsonKey() List<HofLeader> get topTrainingPoints {
  if (_topTrainingPoints is EqualUnmodifiableListView) return _topTrainingPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topTrainingPoints);
}


/// Create a copy of HallOfFame
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HallOfFameCopyWith<_HallOfFame> get copyWith => __$HallOfFameCopyWithImpl<_HallOfFame>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HallOfFameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HallOfFame&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&const DeepCollectionEquality().equals(other._seasons, _seasons)&&(identical(other.periodId, periodId) || other.periodId == periodId)&&const DeepCollectionEquality().equals(other._periods, _periods)&&const DeepCollectionEquality().equals(other._periodAwards, _periodAwards)&&const DeepCollectionEquality().equals(other._titles, _titles)&&const DeepCollectionEquality().equals(other._topScorers, _topScorers)&&const DeepCollectionEquality().equals(other._topAssisters, _topAssisters)&&const DeepCollectionEquality().equals(other._topFlaggers, _topFlaggers)&&(identical(other.postMatchLeaderboards, postMatchLeaderboards) || other.postMatchLeaderboards == postMatchLeaderboards)&&const DeepCollectionEquality().equals(other._topMotm, _topMotm)&&const DeepCollectionEquality().equals(other._playersWithBadges, _playersWithBadges)&&(identical(other.trainingPointsEnabled, trainingPointsEnabled) || other.trainingPointsEnabled == trainingPointsEnabled)&&const DeepCollectionEquality().equals(other._topTrainingPoints, _topTrainingPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,seasonId,const DeepCollectionEquality().hash(_seasons),periodId,const DeepCollectionEquality().hash(_periods),const DeepCollectionEquality().hash(_periodAwards),const DeepCollectionEquality().hash(_titles),const DeepCollectionEquality().hash(_topScorers),const DeepCollectionEquality().hash(_topAssisters),const DeepCollectionEquality().hash(_topFlaggers),postMatchLeaderboards,const DeepCollectionEquality().hash(_topMotm),const DeepCollectionEquality().hash(_playersWithBadges),trainingPointsEnabled,const DeepCollectionEquality().hash(_topTrainingPoints));

@override
String toString() {
  return 'HallOfFame(seasonId: $seasonId, seasons: $seasons, periodId: $periodId, periods: $periods, periodAwards: $periodAwards, titles: $titles, topScorers: $topScorers, topAssisters: $topAssisters, topFlaggers: $topFlaggers, postMatchLeaderboards: $postMatchLeaderboards, topMotm: $topMotm, playersWithBadges: $playersWithBadges, trainingPointsEnabled: $trainingPointsEnabled, topTrainingPoints: $topTrainingPoints)';
}


}

/// @nodoc
abstract mixin class _$HallOfFameCopyWith<$Res> implements $HallOfFameCopyWith<$Res> {
  factory _$HallOfFameCopyWith(_HallOfFame value, $Res Function(_HallOfFame) _then) = __$HallOfFameCopyWithImpl;
@override @useResult
$Res call({
@asIntOrNull int? seasonId, List<SeasonOption> seasons,@asIntOrNull int? periodId, List<HofPeriod> periods, List<PeriodAwardGroup> periodAwards, List<HofTitle> titles, List<HofLeader>? topScorers, List<HofLeader>? topAssisters, List<HofLeader>? topFlaggers, PostMatchLeaderboards? postMatchLeaderboards, List<HofLeader> topMotm, List<BadgePlayer> playersWithBadges, bool trainingPointsEnabled, List<HofLeader> topTrainingPoints
});


@override $PostMatchLeaderboardsCopyWith<$Res>? get postMatchLeaderboards;

}
/// @nodoc
class __$HallOfFameCopyWithImpl<$Res>
    implements _$HallOfFameCopyWith<$Res> {
  __$HallOfFameCopyWithImpl(this._self, this._then);

  final _HallOfFame _self;
  final $Res Function(_HallOfFame) _then;

/// Create a copy of HallOfFame
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? seasonId = freezed,Object? seasons = null,Object? periodId = freezed,Object? periods = null,Object? periodAwards = null,Object? titles = null,Object? topScorers = freezed,Object? topAssisters = freezed,Object? topFlaggers = freezed,Object? postMatchLeaderboards = freezed,Object? topMotm = null,Object? playersWithBadges = null,Object? trainingPointsEnabled = null,Object? topTrainingPoints = null,}) {
  return _then(_HallOfFame(
seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as int?,seasons: null == seasons ? _self._seasons : seasons // ignore: cast_nullable_to_non_nullable
as List<SeasonOption>,periodId: freezed == periodId ? _self.periodId : periodId // ignore: cast_nullable_to_non_nullable
as int?,periods: null == periods ? _self._periods : periods // ignore: cast_nullable_to_non_nullable
as List<HofPeriod>,periodAwards: null == periodAwards ? _self._periodAwards : periodAwards // ignore: cast_nullable_to_non_nullable
as List<PeriodAwardGroup>,titles: null == titles ? _self._titles : titles // ignore: cast_nullable_to_non_nullable
as List<HofTitle>,topScorers: freezed == topScorers ? _self._topScorers : topScorers // ignore: cast_nullable_to_non_nullable
as List<HofLeader>?,topAssisters: freezed == topAssisters ? _self._topAssisters : topAssisters // ignore: cast_nullable_to_non_nullable
as List<HofLeader>?,topFlaggers: freezed == topFlaggers ? _self._topFlaggers : topFlaggers // ignore: cast_nullable_to_non_nullable
as List<HofLeader>?,postMatchLeaderboards: freezed == postMatchLeaderboards ? _self.postMatchLeaderboards : postMatchLeaderboards // ignore: cast_nullable_to_non_nullable
as PostMatchLeaderboards?,topMotm: null == topMotm ? _self._topMotm : topMotm // ignore: cast_nullable_to_non_nullable
as List<HofLeader>,playersWithBadges: null == playersWithBadges ? _self._playersWithBadges : playersWithBadges // ignore: cast_nullable_to_non_nullable
as List<BadgePlayer>,trainingPointsEnabled: null == trainingPointsEnabled ? _self.trainingPointsEnabled : trainingPointsEnabled // ignore: cast_nullable_to_non_nullable
as bool,topTrainingPoints: null == topTrainingPoints ? _self._topTrainingPoints : topTrainingPoints // ignore: cast_nullable_to_non_nullable
as List<HofLeader>,
  ));
}

/// Create a copy of HallOfFame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PostMatchLeaderboardsCopyWith<$Res>? get postMatchLeaderboards {
    if (_self.postMatchLeaderboards == null) {
    return null;
  }

  return $PostMatchLeaderboardsCopyWith<$Res>(_self.postMatchLeaderboards!, (value) {
    return _then(_self.copyWith(postMatchLeaderboards: value));
  });
}
}

// dart format on
