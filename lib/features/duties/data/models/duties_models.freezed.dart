// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'duties_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DutyTypeSummary {

 int get id; String get name; String get slug; String? get icon;/// `individual`, `group` of `multi`.
 String get mode;/// `free` of `match`.
 String get scope; bool get autoRotate;
/// Create a copy of DutyTypeSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyTypeSummaryCopyWith<DutyTypeSummary> get copyWith => _$DutyTypeSummaryCopyWithImpl<DutyTypeSummary>(this as DutyTypeSummary, _$identity);

  /// Serializes this DutyTypeSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyTypeSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.autoRotate, autoRotate) || other.autoRotate == autoRotate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,icon,mode,scope,autoRotate);

@override
String toString() {
  return 'DutyTypeSummary(id: $id, name: $name, slug: $slug, icon: $icon, mode: $mode, scope: $scope, autoRotate: $autoRotate)';
}


}

/// @nodoc
abstract mixin class $DutyTypeSummaryCopyWith<$Res>  {
  factory $DutyTypeSummaryCopyWith(DutyTypeSummary value, $Res Function(DutyTypeSummary) _then) = _$DutyTypeSummaryCopyWithImpl;
@useResult
$Res call({
 int id, String name, String slug, String? icon, String mode, String scope, bool autoRotate
});




}
/// @nodoc
class _$DutyTypeSummaryCopyWithImpl<$Res>
    implements $DutyTypeSummaryCopyWith<$Res> {
  _$DutyTypeSummaryCopyWithImpl(this._self, this._then);

  final DutyTypeSummary _self;
  final $Res Function(DutyTypeSummary) _then;

/// Create a copy of DutyTypeSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? icon = freezed,Object? mode = null,Object? scope = null,Object? autoRotate = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String,autoRotate: null == autoRotate ? _self.autoRotate : autoRotate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DutyTypeSummary].
extension DutyTypeSummaryPatterns on DutyTypeSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyTypeSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyTypeSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyTypeSummary value)  $default,){
final _that = this;
switch (_that) {
case _DutyTypeSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyTypeSummary value)?  $default,){
final _that = this;
switch (_that) {
case _DutyTypeSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String? icon,  String mode,  String scope,  bool autoRotate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyTypeSummary() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.icon,_that.mode,_that.scope,_that.autoRotate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String? icon,  String mode,  String scope,  bool autoRotate)  $default,) {final _that = this;
switch (_that) {
case _DutyTypeSummary():
return $default(_that.id,_that.name,_that.slug,_that.icon,_that.mode,_that.scope,_that.autoRotate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String slug,  String? icon,  String mode,  String scope,  bool autoRotate)?  $default,) {final _that = this;
switch (_that) {
case _DutyTypeSummary() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.icon,_that.mode,_that.scope,_that.autoRotate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyTypeSummary implements DutyTypeSummary {
  const _DutyTypeSummary({required this.id, this.name = '', this.slug = '', this.icon, this.mode = 'individual', this.scope = 'free', this.autoRotate = false});
  factory _DutyTypeSummary.fromJson(Map<String, dynamic> json) => _$DutyTypeSummaryFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String slug;
@override final  String? icon;
/// `individual`, `group` of `multi`.
@override@JsonKey() final  String mode;
/// `free` of `match`.
@override@JsonKey() final  String scope;
@override@JsonKey() final  bool autoRotate;

/// Create a copy of DutyTypeSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyTypeSummaryCopyWith<_DutyTypeSummary> get copyWith => __$DutyTypeSummaryCopyWithImpl<_DutyTypeSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyTypeSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyTypeSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.autoRotate, autoRotate) || other.autoRotate == autoRotate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,icon,mode,scope,autoRotate);

@override
String toString() {
  return 'DutyTypeSummary(id: $id, name: $name, slug: $slug, icon: $icon, mode: $mode, scope: $scope, autoRotate: $autoRotate)';
}


}

/// @nodoc
abstract mixin class _$DutyTypeSummaryCopyWith<$Res> implements $DutyTypeSummaryCopyWith<$Res> {
  factory _$DutyTypeSummaryCopyWith(_DutyTypeSummary value, $Res Function(_DutyTypeSummary) _then) = __$DutyTypeSummaryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String slug, String? icon, String mode, String scope, bool autoRotate
});




}
/// @nodoc
class __$DutyTypeSummaryCopyWithImpl<$Res>
    implements _$DutyTypeSummaryCopyWith<$Res> {
  __$DutyTypeSummaryCopyWithImpl(this._self, this._then);

  final _DutyTypeSummary _self;
  final $Res Function(_DutyTypeSummary) _then;

/// Create a copy of DutyTypeSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? icon = freezed,Object? mode = null,Object? scope = null,Object? autoRotate = null,}) {
  return _then(_DutyTypeSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as String,autoRotate: null == autoRotate ? _self.autoRotate : autoRotate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$DutyMember {

 String get key; String get name;
/// Create a copy of DutyMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyMemberCopyWith<DutyMember> get copyWith => _$DutyMemberCopyWithImpl<DutyMember>(this as DutyMember, _$identity);

  /// Serializes this DutyMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyMember&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name);

@override
String toString() {
  return 'DutyMember(key: $key, name: $name)';
}


}

/// @nodoc
abstract mixin class $DutyMemberCopyWith<$Res>  {
  factory $DutyMemberCopyWith(DutyMember value, $Res Function(DutyMember) _then) = _$DutyMemberCopyWithImpl;
@useResult
$Res call({
 String key, String name
});




}
/// @nodoc
class _$DutyMemberCopyWithImpl<$Res>
    implements $DutyMemberCopyWith<$Res> {
  _$DutyMemberCopyWithImpl(this._self, this._then);

  final DutyMember _self;
  final $Res Function(DutyMember) _then;

/// Create a copy of DutyMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? name = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DutyMember].
extension DutyMemberPatterns on DutyMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyMember value)  $default,){
final _that = this;
switch (_that) {
case _DutyMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyMember value)?  $default,){
final _that = this;
switch (_that) {
case _DutyMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyMember() when $default != null:
return $default(_that.key,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String name)  $default,) {final _that = this;
switch (_that) {
case _DutyMember():
return $default(_that.key,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String name)?  $default,) {final _that = this;
switch (_that) {
case _DutyMember() when $default != null:
return $default(_that.key,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyMember implements DutyMember {
  const _DutyMember({required this.key, this.name = ''});
  factory _DutyMember.fromJson(Map<String, dynamic> json) => _$DutyMemberFromJson(json);

@override final  String key;
@override@JsonKey() final  String name;

/// Create a copy of DutyMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyMemberCopyWith<_DutyMember> get copyWith => __$DutyMemberCopyWithImpl<_DutyMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyMember&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name);

@override
String toString() {
  return 'DutyMember(key: $key, name: $name)';
}


}

/// @nodoc
abstract mixin class _$DutyMemberCopyWith<$Res> implements $DutyMemberCopyWith<$Res> {
  factory _$DutyMemberCopyWith(_DutyMember value, $Res Function(_DutyMember) _then) = __$DutyMemberCopyWithImpl;
@override @useResult
$Res call({
 String key, String name
});




}
/// @nodoc
class __$DutyMemberCopyWithImpl<$Res>
    implements _$DutyMemberCopyWith<$Res> {
  __$DutyMemberCopyWithImpl(this._self, this._then);

  final _DutyMember _self;
  final $Res Function(_DutyMember) _then;

/// Create a copy of DutyMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? name = null,}) {
  return _then(_DutyMember(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DutyGroup {

 int get id; String get name; DateTime? get lastAssignedAt; int get count; List<DutyMember> get members;/// Alleen in de schrijfrespons.
 int? get dutyTypeId; int? get sortOrder;
/// Create a copy of DutyGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyGroupCopyWith<DutyGroup> get copyWith => _$DutyGroupCopyWithImpl<DutyGroup>(this as DutyGroup, _$identity);

  /// Serializes this DutyGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.lastAssignedAt, lastAssignedAt) || other.lastAssignedAt == lastAssignedAt)&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,lastAssignedAt,count,const DeepCollectionEquality().hash(members),dutyTypeId,sortOrder);

@override
String toString() {
  return 'DutyGroup(id: $id, name: $name, lastAssignedAt: $lastAssignedAt, count: $count, members: $members, dutyTypeId: $dutyTypeId, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $DutyGroupCopyWith<$Res>  {
  factory $DutyGroupCopyWith(DutyGroup value, $Res Function(DutyGroup) _then) = _$DutyGroupCopyWithImpl;
@useResult
$Res call({
 int id, String name, DateTime? lastAssignedAt, int count, List<DutyMember> members, int? dutyTypeId, int? sortOrder
});




}
/// @nodoc
class _$DutyGroupCopyWithImpl<$Res>
    implements $DutyGroupCopyWith<$Res> {
  _$DutyGroupCopyWithImpl(this._self, this._then);

  final DutyGroup _self;
  final $Res Function(DutyGroup) _then;

/// Create a copy of DutyGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? lastAssignedAt = freezed,Object? count = null,Object? members = null,Object? dutyTypeId = freezed,Object? sortOrder = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lastAssignedAt: freezed == lastAssignedAt ? _self.lastAssignedAt : lastAssignedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<DutyMember>,dutyTypeId: freezed == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int?,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [DutyGroup].
extension DutyGroupPatterns on DutyGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyGroup value)  $default,){
final _that = this;
switch (_that) {
case _DutyGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyGroup value)?  $default,){
final _that = this;
switch (_that) {
case _DutyGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  DateTime? lastAssignedAt,  int count,  List<DutyMember> members,  int? dutyTypeId,  int? sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyGroup() when $default != null:
return $default(_that.id,_that.name,_that.lastAssignedAt,_that.count,_that.members,_that.dutyTypeId,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  DateTime? lastAssignedAt,  int count,  List<DutyMember> members,  int? dutyTypeId,  int? sortOrder)  $default,) {final _that = this;
switch (_that) {
case _DutyGroup():
return $default(_that.id,_that.name,_that.lastAssignedAt,_that.count,_that.members,_that.dutyTypeId,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  DateTime? lastAssignedAt,  int count,  List<DutyMember> members,  int? dutyTypeId,  int? sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _DutyGroup() when $default != null:
return $default(_that.id,_that.name,_that.lastAssignedAt,_that.count,_that.members,_that.dutyTypeId,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyGroup implements DutyGroup {
  const _DutyGroup({required this.id, this.name = '', this.lastAssignedAt, this.count = 0, final  List<DutyMember> members = const <DutyMember>[], this.dutyTypeId, this.sortOrder}): _members = members;
  factory _DutyGroup.fromJson(Map<String, dynamic> json) => _$DutyGroupFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  DateTime? lastAssignedAt;
@override@JsonKey() final  int count;
 final  List<DutyMember> _members;
@override@JsonKey() List<DutyMember> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

/// Alleen in de schrijfrespons.
@override final  int? dutyTypeId;
@override final  int? sortOrder;

/// Create a copy of DutyGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyGroupCopyWith<_DutyGroup> get copyWith => __$DutyGroupCopyWithImpl<_DutyGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.lastAssignedAt, lastAssignedAt) || other.lastAssignedAt == lastAssignedAt)&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,lastAssignedAt,count,const DeepCollectionEquality().hash(_members),dutyTypeId,sortOrder);

@override
String toString() {
  return 'DutyGroup(id: $id, name: $name, lastAssignedAt: $lastAssignedAt, count: $count, members: $members, dutyTypeId: $dutyTypeId, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$DutyGroupCopyWith<$Res> implements $DutyGroupCopyWith<$Res> {
  factory _$DutyGroupCopyWith(_DutyGroup value, $Res Function(_DutyGroup) _then) = __$DutyGroupCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, DateTime? lastAssignedAt, int count, List<DutyMember> members, int? dutyTypeId, int? sortOrder
});




}
/// @nodoc
class __$DutyGroupCopyWithImpl<$Res>
    implements _$DutyGroupCopyWith<$Res> {
  __$DutyGroupCopyWithImpl(this._self, this._then);

  final _DutyGroup _self;
  final $Res Function(_DutyGroup) _then;

/// Create a copy of DutyGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? lastAssignedAt = freezed,Object? count = null,Object? members = null,Object? dutyTypeId = freezed,Object? sortOrder = freezed,}) {
  return _then(_DutyGroup(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,lastAssignedAt: freezed == lastAssignedAt ? _self.lastAssignedAt : lastAssignedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<DutyMember>,dutyTypeId: freezed == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int?,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$DutyAssignment {

 int get id;/// `YYYY-MM-DD`.
 String get scheduledFor;/// `HH:MM` of `null`.
 String? get startsAt; String? get endsAt; String? get notes; int? get groupId; String? get groupName; int? get playerId; String? get memberKey; String? get playerName; int? get eventId; String? get eventLabel; DateTime? get markedDoneAt; int? get dutyTypeId;
/// Create a copy of DutyAssignment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyAssignmentCopyWith<DutyAssignment> get copyWith => _$DutyAssignmentCopyWithImpl<DutyAssignment>(this as DutyAssignment, _$identity);

  /// Serializes this DutyAssignment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyAssignment&&(identical(other.id, id) || other.id == id)&&(identical(other.scheduledFor, scheduledFor) || other.scheduledFor == scheduledFor)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.memberKey, memberKey) || other.memberKey == memberKey)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.eventLabel, eventLabel) || other.eventLabel == eventLabel)&&(identical(other.markedDoneAt, markedDoneAt) || other.markedDoneAt == markedDoneAt)&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,scheduledFor,startsAt,endsAt,notes,groupId,groupName,playerId,memberKey,playerName,eventId,eventLabel,markedDoneAt,dutyTypeId);

@override
String toString() {
  return 'DutyAssignment(id: $id, scheduledFor: $scheduledFor, startsAt: $startsAt, endsAt: $endsAt, notes: $notes, groupId: $groupId, groupName: $groupName, playerId: $playerId, memberKey: $memberKey, playerName: $playerName, eventId: $eventId, eventLabel: $eventLabel, markedDoneAt: $markedDoneAt, dutyTypeId: $dutyTypeId)';
}


}

/// @nodoc
abstract mixin class $DutyAssignmentCopyWith<$Res>  {
  factory $DutyAssignmentCopyWith(DutyAssignment value, $Res Function(DutyAssignment) _then) = _$DutyAssignmentCopyWithImpl;
@useResult
$Res call({
 int id, String scheduledFor, String? startsAt, String? endsAt, String? notes, int? groupId, String? groupName, int? playerId, String? memberKey, String? playerName, int? eventId, String? eventLabel, DateTime? markedDoneAt, int? dutyTypeId
});




}
/// @nodoc
class _$DutyAssignmentCopyWithImpl<$Res>
    implements $DutyAssignmentCopyWith<$Res> {
  _$DutyAssignmentCopyWithImpl(this._self, this._then);

  final DutyAssignment _self;
  final $Res Function(DutyAssignment) _then;

/// Create a copy of DutyAssignment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? scheduledFor = null,Object? startsAt = freezed,Object? endsAt = freezed,Object? notes = freezed,Object? groupId = freezed,Object? groupName = freezed,Object? playerId = freezed,Object? memberKey = freezed,Object? playerName = freezed,Object? eventId = freezed,Object? eventLabel = freezed,Object? markedDoneAt = freezed,Object? dutyTypeId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,scheduledFor: null == scheduledFor ? _self.scheduledFor : scheduledFor // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,memberKey: freezed == memberKey ? _self.memberKey : memberKey // ignore: cast_nullable_to_non_nullable
as String?,playerName: freezed == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,eventLabel: freezed == eventLabel ? _self.eventLabel : eventLabel // ignore: cast_nullable_to_non_nullable
as String?,markedDoneAt: freezed == markedDoneAt ? _self.markedDoneAt : markedDoneAt // ignore: cast_nullable_to_non_nullable
as DateTime?,dutyTypeId: freezed == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [DutyAssignment].
extension DutyAssignmentPatterns on DutyAssignment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyAssignment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyAssignment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyAssignment value)  $default,){
final _that = this;
switch (_that) {
case _DutyAssignment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyAssignment value)?  $default,){
final _that = this;
switch (_that) {
case _DutyAssignment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String scheduledFor,  String? startsAt,  String? endsAt,  String? notes,  int? groupId,  String? groupName,  int? playerId,  String? memberKey,  String? playerName,  int? eventId,  String? eventLabel,  DateTime? markedDoneAt,  int? dutyTypeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyAssignment() when $default != null:
return $default(_that.id,_that.scheduledFor,_that.startsAt,_that.endsAt,_that.notes,_that.groupId,_that.groupName,_that.playerId,_that.memberKey,_that.playerName,_that.eventId,_that.eventLabel,_that.markedDoneAt,_that.dutyTypeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String scheduledFor,  String? startsAt,  String? endsAt,  String? notes,  int? groupId,  String? groupName,  int? playerId,  String? memberKey,  String? playerName,  int? eventId,  String? eventLabel,  DateTime? markedDoneAt,  int? dutyTypeId)  $default,) {final _that = this;
switch (_that) {
case _DutyAssignment():
return $default(_that.id,_that.scheduledFor,_that.startsAt,_that.endsAt,_that.notes,_that.groupId,_that.groupName,_that.playerId,_that.memberKey,_that.playerName,_that.eventId,_that.eventLabel,_that.markedDoneAt,_that.dutyTypeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String scheduledFor,  String? startsAt,  String? endsAt,  String? notes,  int? groupId,  String? groupName,  int? playerId,  String? memberKey,  String? playerName,  int? eventId,  String? eventLabel,  DateTime? markedDoneAt,  int? dutyTypeId)?  $default,) {final _that = this;
switch (_that) {
case _DutyAssignment() when $default != null:
return $default(_that.id,_that.scheduledFor,_that.startsAt,_that.endsAt,_that.notes,_that.groupId,_that.groupName,_that.playerId,_that.memberKey,_that.playerName,_that.eventId,_that.eventLabel,_that.markedDoneAt,_that.dutyTypeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyAssignment extends DutyAssignment {
  const _DutyAssignment({required this.id, this.scheduledFor = '', this.startsAt, this.endsAt, this.notes, this.groupId, this.groupName, this.playerId, this.memberKey, this.playerName, this.eventId, this.eventLabel, this.markedDoneAt, this.dutyTypeId}): super._();
  factory _DutyAssignment.fromJson(Map<String, dynamic> json) => _$DutyAssignmentFromJson(json);

@override final  int id;
/// `YYYY-MM-DD`.
@override@JsonKey() final  String scheduledFor;
/// `HH:MM` of `null`.
@override final  String? startsAt;
@override final  String? endsAt;
@override final  String? notes;
@override final  int? groupId;
@override final  String? groupName;
@override final  int? playerId;
@override final  String? memberKey;
@override final  String? playerName;
@override final  int? eventId;
@override final  String? eventLabel;
@override final  DateTime? markedDoneAt;
@override final  int? dutyTypeId;

/// Create a copy of DutyAssignment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyAssignmentCopyWith<_DutyAssignment> get copyWith => __$DutyAssignmentCopyWithImpl<_DutyAssignment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyAssignmentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyAssignment&&(identical(other.id, id) || other.id == id)&&(identical(other.scheduledFor, scheduledFor) || other.scheduledFor == scheduledFor)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.memberKey, memberKey) || other.memberKey == memberKey)&&(identical(other.playerName, playerName) || other.playerName == playerName)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.eventLabel, eventLabel) || other.eventLabel == eventLabel)&&(identical(other.markedDoneAt, markedDoneAt) || other.markedDoneAt == markedDoneAt)&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,scheduledFor,startsAt,endsAt,notes,groupId,groupName,playerId,memberKey,playerName,eventId,eventLabel,markedDoneAt,dutyTypeId);

@override
String toString() {
  return 'DutyAssignment(id: $id, scheduledFor: $scheduledFor, startsAt: $startsAt, endsAt: $endsAt, notes: $notes, groupId: $groupId, groupName: $groupName, playerId: $playerId, memberKey: $memberKey, playerName: $playerName, eventId: $eventId, eventLabel: $eventLabel, markedDoneAt: $markedDoneAt, dutyTypeId: $dutyTypeId)';
}


}

/// @nodoc
abstract mixin class _$DutyAssignmentCopyWith<$Res> implements $DutyAssignmentCopyWith<$Res> {
  factory _$DutyAssignmentCopyWith(_DutyAssignment value, $Res Function(_DutyAssignment) _then) = __$DutyAssignmentCopyWithImpl;
@override @useResult
$Res call({
 int id, String scheduledFor, String? startsAt, String? endsAt, String? notes, int? groupId, String? groupName, int? playerId, String? memberKey, String? playerName, int? eventId, String? eventLabel, DateTime? markedDoneAt, int? dutyTypeId
});




}
/// @nodoc
class __$DutyAssignmentCopyWithImpl<$Res>
    implements _$DutyAssignmentCopyWith<$Res> {
  __$DutyAssignmentCopyWithImpl(this._self, this._then);

  final _DutyAssignment _self;
  final $Res Function(_DutyAssignment) _then;

/// Create a copy of DutyAssignment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? scheduledFor = null,Object? startsAt = freezed,Object? endsAt = freezed,Object? notes = freezed,Object? groupId = freezed,Object? groupName = freezed,Object? playerId = freezed,Object? memberKey = freezed,Object? playerName = freezed,Object? eventId = freezed,Object? eventLabel = freezed,Object? markedDoneAt = freezed,Object? dutyTypeId = freezed,}) {
  return _then(_DutyAssignment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,scheduledFor: null == scheduledFor ? _self.scheduledFor : scheduledFor // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as int?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,memberKey: freezed == memberKey ? _self.memberKey : memberKey // ignore: cast_nullable_to_non_nullable
as String?,playerName: freezed == playerName ? _self.playerName : playerName // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,eventLabel: freezed == eventLabel ? _self.eventLabel : eventLabel // ignore: cast_nullable_to_non_nullable
as String?,markedDoneAt: freezed == markedDoneAt ? _self.markedDoneAt : markedDoneAt // ignore: cast_nullable_to_non_nullable
as DateTime?,dutyTypeId: freezed == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$DutyPerson {

 String get key; String get name;/// `player`, `guest`, `staff` of `spectator`.
 String get kind; bool get isTrainerOnly; int get count;
/// Create a copy of DutyPerson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyPersonCopyWith<DutyPerson> get copyWith => _$DutyPersonCopyWithImpl<DutyPerson>(this as DutyPerson, _$identity);

  /// Serializes this DutyPerson to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyPerson&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.isTrainerOnly, isTrainerOnly) || other.isTrainerOnly == isTrainerOnly)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name,kind,isTrainerOnly,count);

@override
String toString() {
  return 'DutyPerson(key: $key, name: $name, kind: $kind, isTrainerOnly: $isTrainerOnly, count: $count)';
}


}

/// @nodoc
abstract mixin class $DutyPersonCopyWith<$Res>  {
  factory $DutyPersonCopyWith(DutyPerson value, $Res Function(DutyPerson) _then) = _$DutyPersonCopyWithImpl;
@useResult
$Res call({
 String key, String name, String kind, bool isTrainerOnly, int count
});




}
/// @nodoc
class _$DutyPersonCopyWithImpl<$Res>
    implements $DutyPersonCopyWith<$Res> {
  _$DutyPersonCopyWithImpl(this._self, this._then);

  final DutyPerson _self;
  final $Res Function(DutyPerson) _then;

/// Create a copy of DutyPerson
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? name = null,Object? kind = null,Object? isTrainerOnly = null,Object? count = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,isTrainerOnly: null == isTrainerOnly ? _self.isTrainerOnly : isTrainerOnly // ignore: cast_nullable_to_non_nullable
as bool,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DutyPerson].
extension DutyPersonPatterns on DutyPerson {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyPerson value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyPerson() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyPerson value)  $default,){
final _that = this;
switch (_that) {
case _DutyPerson():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyPerson value)?  $default,){
final _that = this;
switch (_that) {
case _DutyPerson() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String name,  String kind,  bool isTrainerOnly,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyPerson() when $default != null:
return $default(_that.key,_that.name,_that.kind,_that.isTrainerOnly,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String name,  String kind,  bool isTrainerOnly,  int count)  $default,) {final _that = this;
switch (_that) {
case _DutyPerson():
return $default(_that.key,_that.name,_that.kind,_that.isTrainerOnly,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String name,  String kind,  bool isTrainerOnly,  int count)?  $default,) {final _that = this;
switch (_that) {
case _DutyPerson() when $default != null:
return $default(_that.key,_that.name,_that.kind,_that.isTrainerOnly,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyPerson implements DutyPerson {
  const _DutyPerson({required this.key, this.name = '', this.kind = 'player', this.isTrainerOnly = false, this.count = 0});
  factory _DutyPerson.fromJson(Map<String, dynamic> json) => _$DutyPersonFromJson(json);

@override final  String key;
@override@JsonKey() final  String name;
/// `player`, `guest`, `staff` of `spectator`.
@override@JsonKey() final  String kind;
@override@JsonKey() final  bool isTrainerOnly;
@override@JsonKey() final  int count;

/// Create a copy of DutyPerson
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyPersonCopyWith<_DutyPerson> get copyWith => __$DutyPersonCopyWithImpl<_DutyPerson>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyPersonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyPerson&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.isTrainerOnly, isTrainerOnly) || other.isTrainerOnly == isTrainerOnly)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name,kind,isTrainerOnly,count);

@override
String toString() {
  return 'DutyPerson(key: $key, name: $name, kind: $kind, isTrainerOnly: $isTrainerOnly, count: $count)';
}


}

/// @nodoc
abstract mixin class _$DutyPersonCopyWith<$Res> implements $DutyPersonCopyWith<$Res> {
  factory _$DutyPersonCopyWith(_DutyPerson value, $Res Function(_DutyPerson) _then) = __$DutyPersonCopyWithImpl;
@override @useResult
$Res call({
 String key, String name, String kind, bool isTrainerOnly, int count
});




}
/// @nodoc
class __$DutyPersonCopyWithImpl<$Res>
    implements _$DutyPersonCopyWith<$Res> {
  __$DutyPersonCopyWithImpl(this._self, this._then);

  final _DutyPerson _self;
  final $Res Function(_DutyPerson) _then;

/// Create a copy of DutyPerson
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? name = null,Object? kind = null,Object? isTrainerOnly = null,Object? count = null,}) {
  return _then(_DutyPerson(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,isTrainerOnly: null == isTrainerOnly ? _self.isTrainerOnly : isTrainerOnly // ignore: cast_nullable_to_non_nullable
as bool,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DutyMatch {

 int get id; String get label;/// `YYYY-MM-DD`.
 String get date; DateTime? get startsAt;
/// Create a copy of DutyMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyMatchCopyWith<DutyMatch> get copyWith => _$DutyMatchCopyWithImpl<DutyMatch>(this as DutyMatch, _$identity);

  /// Serializes this DutyMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.date, date) || other.date == date)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,date,startsAt);

@override
String toString() {
  return 'DutyMatch(id: $id, label: $label, date: $date, startsAt: $startsAt)';
}


}

/// @nodoc
abstract mixin class $DutyMatchCopyWith<$Res>  {
  factory $DutyMatchCopyWith(DutyMatch value, $Res Function(DutyMatch) _then) = _$DutyMatchCopyWithImpl;
@useResult
$Res call({
 int id, String label, String date, DateTime? startsAt
});




}
/// @nodoc
class _$DutyMatchCopyWithImpl<$Res>
    implements $DutyMatchCopyWith<$Res> {
  _$DutyMatchCopyWithImpl(this._self, this._then);

  final DutyMatch _self;
  final $Res Function(DutyMatch) _then;

/// Create a copy of DutyMatch
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


/// Adds pattern-matching-related methods to [DutyMatch].
extension DutyMatchPatterns on DutyMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyMatch value)  $default,){
final _that = this;
switch (_that) {
case _DutyMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyMatch value)?  $default,){
final _that = this;
switch (_that) {
case _DutyMatch() when $default != null:
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
case _DutyMatch() when $default != null:
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
case _DutyMatch():
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
case _DutyMatch() when $default != null:
return $default(_that.id,_that.label,_that.date,_that.startsAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyMatch implements DutyMatch {
  const _DutyMatch({required this.id, this.label = '', this.date = '', this.startsAt});
  factory _DutyMatch.fromJson(Map<String, dynamic> json) => _$DutyMatchFromJson(json);

@override final  int id;
@override@JsonKey() final  String label;
/// `YYYY-MM-DD`.
@override@JsonKey() final  String date;
@override final  DateTime? startsAt;

/// Create a copy of DutyMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyMatchCopyWith<_DutyMatch> get copyWith => __$DutyMatchCopyWithImpl<_DutyMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyMatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.date, date) || other.date == date)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,date,startsAt);

@override
String toString() {
  return 'DutyMatch(id: $id, label: $label, date: $date, startsAt: $startsAt)';
}


}

/// @nodoc
abstract mixin class _$DutyMatchCopyWith<$Res> implements $DutyMatchCopyWith<$Res> {
  factory _$DutyMatchCopyWith(_DutyMatch value, $Res Function(_DutyMatch) _then) = __$DutyMatchCopyWithImpl;
@override @useResult
$Res call({
 int id, String label, String date, DateTime? startsAt
});




}
/// @nodoc
class __$DutyMatchCopyWithImpl<$Res>
    implements _$DutyMatchCopyWith<$Res> {
  __$DutyMatchCopyWithImpl(this._self, this._then);

  final _DutyMatch _self;
  final $Res Function(_DutyMatch) _then;

/// Create a copy of DutyMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? date = null,Object? startsAt = freezed,}) {
  return _then(_DutyMatch(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$DutiesOverview {

 String get type; int get dutyTypeId; String get dutyTypeMode; String get dutyTypeScope; bool get dutyTypeAutoRotate; List<String> get dutyTypePool; List<DutyTypeSummary> get dutyTypes; List<DutyGroup> get groups; List<DutyAssignment> get assignments; List<DutyPerson> get allPeople; List<DutyPerson> get poolPeople; List<DutyMatch> get matches;
/// Create a copy of DutiesOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutiesOverviewCopyWith<DutiesOverview> get copyWith => _$DutiesOverviewCopyWithImpl<DutiesOverview>(this as DutiesOverview, _$identity);

  /// Serializes this DutiesOverview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutiesOverview&&(identical(other.type, type) || other.type == type)&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId)&&(identical(other.dutyTypeMode, dutyTypeMode) || other.dutyTypeMode == dutyTypeMode)&&(identical(other.dutyTypeScope, dutyTypeScope) || other.dutyTypeScope == dutyTypeScope)&&(identical(other.dutyTypeAutoRotate, dutyTypeAutoRotate) || other.dutyTypeAutoRotate == dutyTypeAutoRotate)&&const DeepCollectionEquality().equals(other.dutyTypePool, dutyTypePool)&&const DeepCollectionEquality().equals(other.dutyTypes, dutyTypes)&&const DeepCollectionEquality().equals(other.groups, groups)&&const DeepCollectionEquality().equals(other.assignments, assignments)&&const DeepCollectionEquality().equals(other.allPeople, allPeople)&&const DeepCollectionEquality().equals(other.poolPeople, poolPeople)&&const DeepCollectionEquality().equals(other.matches, matches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,dutyTypeId,dutyTypeMode,dutyTypeScope,dutyTypeAutoRotate,const DeepCollectionEquality().hash(dutyTypePool),const DeepCollectionEquality().hash(dutyTypes),const DeepCollectionEquality().hash(groups),const DeepCollectionEquality().hash(assignments),const DeepCollectionEquality().hash(allPeople),const DeepCollectionEquality().hash(poolPeople),const DeepCollectionEquality().hash(matches));

@override
String toString() {
  return 'DutiesOverview(type: $type, dutyTypeId: $dutyTypeId, dutyTypeMode: $dutyTypeMode, dutyTypeScope: $dutyTypeScope, dutyTypeAutoRotate: $dutyTypeAutoRotate, dutyTypePool: $dutyTypePool, dutyTypes: $dutyTypes, groups: $groups, assignments: $assignments, allPeople: $allPeople, poolPeople: $poolPeople, matches: $matches)';
}


}

/// @nodoc
abstract mixin class $DutiesOverviewCopyWith<$Res>  {
  factory $DutiesOverviewCopyWith(DutiesOverview value, $Res Function(DutiesOverview) _then) = _$DutiesOverviewCopyWithImpl;
@useResult
$Res call({
 String type, int dutyTypeId, String dutyTypeMode, String dutyTypeScope, bool dutyTypeAutoRotate, List<String> dutyTypePool, List<DutyTypeSummary> dutyTypes, List<DutyGroup> groups, List<DutyAssignment> assignments, List<DutyPerson> allPeople, List<DutyPerson> poolPeople, List<DutyMatch> matches
});




}
/// @nodoc
class _$DutiesOverviewCopyWithImpl<$Res>
    implements $DutiesOverviewCopyWith<$Res> {
  _$DutiesOverviewCopyWithImpl(this._self, this._then);

  final DutiesOverview _self;
  final $Res Function(DutiesOverview) _then;

/// Create a copy of DutiesOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? dutyTypeId = null,Object? dutyTypeMode = null,Object? dutyTypeScope = null,Object? dutyTypeAutoRotate = null,Object? dutyTypePool = null,Object? dutyTypes = null,Object? groups = null,Object? assignments = null,Object? allPeople = null,Object? poolPeople = null,Object? matches = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,dutyTypeId: null == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int,dutyTypeMode: null == dutyTypeMode ? _self.dutyTypeMode : dutyTypeMode // ignore: cast_nullable_to_non_nullable
as String,dutyTypeScope: null == dutyTypeScope ? _self.dutyTypeScope : dutyTypeScope // ignore: cast_nullable_to_non_nullable
as String,dutyTypeAutoRotate: null == dutyTypeAutoRotate ? _self.dutyTypeAutoRotate : dutyTypeAutoRotate // ignore: cast_nullable_to_non_nullable
as bool,dutyTypePool: null == dutyTypePool ? _self.dutyTypePool : dutyTypePool // ignore: cast_nullable_to_non_nullable
as List<String>,dutyTypes: null == dutyTypes ? _self.dutyTypes : dutyTypes // ignore: cast_nullable_to_non_nullable
as List<DutyTypeSummary>,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<DutyGroup>,assignments: null == assignments ? _self.assignments : assignments // ignore: cast_nullable_to_non_nullable
as List<DutyAssignment>,allPeople: null == allPeople ? _self.allPeople : allPeople // ignore: cast_nullable_to_non_nullable
as List<DutyPerson>,poolPeople: null == poolPeople ? _self.poolPeople : poolPeople // ignore: cast_nullable_to_non_nullable
as List<DutyPerson>,matches: null == matches ? _self.matches : matches // ignore: cast_nullable_to_non_nullable
as List<DutyMatch>,
  ));
}

}


/// Adds pattern-matching-related methods to [DutiesOverview].
extension DutiesOverviewPatterns on DutiesOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutiesOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutiesOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutiesOverview value)  $default,){
final _that = this;
switch (_that) {
case _DutiesOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutiesOverview value)?  $default,){
final _that = this;
switch (_that) {
case _DutiesOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  int dutyTypeId,  String dutyTypeMode,  String dutyTypeScope,  bool dutyTypeAutoRotate,  List<String> dutyTypePool,  List<DutyTypeSummary> dutyTypes,  List<DutyGroup> groups,  List<DutyAssignment> assignments,  List<DutyPerson> allPeople,  List<DutyPerson> poolPeople,  List<DutyMatch> matches)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutiesOverview() when $default != null:
return $default(_that.type,_that.dutyTypeId,_that.dutyTypeMode,_that.dutyTypeScope,_that.dutyTypeAutoRotate,_that.dutyTypePool,_that.dutyTypes,_that.groups,_that.assignments,_that.allPeople,_that.poolPeople,_that.matches);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  int dutyTypeId,  String dutyTypeMode,  String dutyTypeScope,  bool dutyTypeAutoRotate,  List<String> dutyTypePool,  List<DutyTypeSummary> dutyTypes,  List<DutyGroup> groups,  List<DutyAssignment> assignments,  List<DutyPerson> allPeople,  List<DutyPerson> poolPeople,  List<DutyMatch> matches)  $default,) {final _that = this;
switch (_that) {
case _DutiesOverview():
return $default(_that.type,_that.dutyTypeId,_that.dutyTypeMode,_that.dutyTypeScope,_that.dutyTypeAutoRotate,_that.dutyTypePool,_that.dutyTypes,_that.groups,_that.assignments,_that.allPeople,_that.poolPeople,_that.matches);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  int dutyTypeId,  String dutyTypeMode,  String dutyTypeScope,  bool dutyTypeAutoRotate,  List<String> dutyTypePool,  List<DutyTypeSummary> dutyTypes,  List<DutyGroup> groups,  List<DutyAssignment> assignments,  List<DutyPerson> allPeople,  List<DutyPerson> poolPeople,  List<DutyMatch> matches)?  $default,) {final _that = this;
switch (_that) {
case _DutiesOverview() when $default != null:
return $default(_that.type,_that.dutyTypeId,_that.dutyTypeMode,_that.dutyTypeScope,_that.dutyTypeAutoRotate,_that.dutyTypePool,_that.dutyTypes,_that.groups,_that.assignments,_that.allPeople,_that.poolPeople,_that.matches);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutiesOverview extends DutiesOverview {
  const _DutiesOverview({this.type = '', required this.dutyTypeId, this.dutyTypeMode = 'individual', this.dutyTypeScope = 'free', this.dutyTypeAutoRotate = false, final  List<String> dutyTypePool = const <String>[], final  List<DutyTypeSummary> dutyTypes = const <DutyTypeSummary>[], final  List<DutyGroup> groups = const <DutyGroup>[], final  List<DutyAssignment> assignments = const <DutyAssignment>[], final  List<DutyPerson> allPeople = const <DutyPerson>[], final  List<DutyPerson> poolPeople = const <DutyPerson>[], final  List<DutyMatch> matches = const <DutyMatch>[]}): _dutyTypePool = dutyTypePool,_dutyTypes = dutyTypes,_groups = groups,_assignments = assignments,_allPeople = allPeople,_poolPeople = poolPeople,_matches = matches,super._();
  factory _DutiesOverview.fromJson(Map<String, dynamic> json) => _$DutiesOverviewFromJson(json);

@override@JsonKey() final  String type;
@override final  int dutyTypeId;
@override@JsonKey() final  String dutyTypeMode;
@override@JsonKey() final  String dutyTypeScope;
@override@JsonKey() final  bool dutyTypeAutoRotate;
 final  List<String> _dutyTypePool;
@override@JsonKey() List<String> get dutyTypePool {
  if (_dutyTypePool is EqualUnmodifiableListView) return _dutyTypePool;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dutyTypePool);
}

 final  List<DutyTypeSummary> _dutyTypes;
@override@JsonKey() List<DutyTypeSummary> get dutyTypes {
  if (_dutyTypes is EqualUnmodifiableListView) return _dutyTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dutyTypes);
}

 final  List<DutyGroup> _groups;
@override@JsonKey() List<DutyGroup> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}

 final  List<DutyAssignment> _assignments;
@override@JsonKey() List<DutyAssignment> get assignments {
  if (_assignments is EqualUnmodifiableListView) return _assignments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assignments);
}

 final  List<DutyPerson> _allPeople;
@override@JsonKey() List<DutyPerson> get allPeople {
  if (_allPeople is EqualUnmodifiableListView) return _allPeople;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allPeople);
}

 final  List<DutyPerson> _poolPeople;
@override@JsonKey() List<DutyPerson> get poolPeople {
  if (_poolPeople is EqualUnmodifiableListView) return _poolPeople;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_poolPeople);
}

 final  List<DutyMatch> _matches;
@override@JsonKey() List<DutyMatch> get matches {
  if (_matches is EqualUnmodifiableListView) return _matches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matches);
}


/// Create a copy of DutiesOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutiesOverviewCopyWith<_DutiesOverview> get copyWith => __$DutiesOverviewCopyWithImpl<_DutiesOverview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutiesOverviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutiesOverview&&(identical(other.type, type) || other.type == type)&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId)&&(identical(other.dutyTypeMode, dutyTypeMode) || other.dutyTypeMode == dutyTypeMode)&&(identical(other.dutyTypeScope, dutyTypeScope) || other.dutyTypeScope == dutyTypeScope)&&(identical(other.dutyTypeAutoRotate, dutyTypeAutoRotate) || other.dutyTypeAutoRotate == dutyTypeAutoRotate)&&const DeepCollectionEquality().equals(other._dutyTypePool, _dutyTypePool)&&const DeepCollectionEquality().equals(other._dutyTypes, _dutyTypes)&&const DeepCollectionEquality().equals(other._groups, _groups)&&const DeepCollectionEquality().equals(other._assignments, _assignments)&&const DeepCollectionEquality().equals(other._allPeople, _allPeople)&&const DeepCollectionEquality().equals(other._poolPeople, _poolPeople)&&const DeepCollectionEquality().equals(other._matches, _matches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,dutyTypeId,dutyTypeMode,dutyTypeScope,dutyTypeAutoRotate,const DeepCollectionEquality().hash(_dutyTypePool),const DeepCollectionEquality().hash(_dutyTypes),const DeepCollectionEquality().hash(_groups),const DeepCollectionEquality().hash(_assignments),const DeepCollectionEquality().hash(_allPeople),const DeepCollectionEquality().hash(_poolPeople),const DeepCollectionEquality().hash(_matches));

@override
String toString() {
  return 'DutiesOverview(type: $type, dutyTypeId: $dutyTypeId, dutyTypeMode: $dutyTypeMode, dutyTypeScope: $dutyTypeScope, dutyTypeAutoRotate: $dutyTypeAutoRotate, dutyTypePool: $dutyTypePool, dutyTypes: $dutyTypes, groups: $groups, assignments: $assignments, allPeople: $allPeople, poolPeople: $poolPeople, matches: $matches)';
}


}

/// @nodoc
abstract mixin class _$DutiesOverviewCopyWith<$Res> implements $DutiesOverviewCopyWith<$Res> {
  factory _$DutiesOverviewCopyWith(_DutiesOverview value, $Res Function(_DutiesOverview) _then) = __$DutiesOverviewCopyWithImpl;
@override @useResult
$Res call({
 String type, int dutyTypeId, String dutyTypeMode, String dutyTypeScope, bool dutyTypeAutoRotate, List<String> dutyTypePool, List<DutyTypeSummary> dutyTypes, List<DutyGroup> groups, List<DutyAssignment> assignments, List<DutyPerson> allPeople, List<DutyPerson> poolPeople, List<DutyMatch> matches
});




}
/// @nodoc
class __$DutiesOverviewCopyWithImpl<$Res>
    implements _$DutiesOverviewCopyWith<$Res> {
  __$DutiesOverviewCopyWithImpl(this._self, this._then);

  final _DutiesOverview _self;
  final $Res Function(_DutiesOverview) _then;

/// Create a copy of DutiesOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? dutyTypeId = null,Object? dutyTypeMode = null,Object? dutyTypeScope = null,Object? dutyTypeAutoRotate = null,Object? dutyTypePool = null,Object? dutyTypes = null,Object? groups = null,Object? assignments = null,Object? allPeople = null,Object? poolPeople = null,Object? matches = null,}) {
  return _then(_DutiesOverview(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,dutyTypeId: null == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int,dutyTypeMode: null == dutyTypeMode ? _self.dutyTypeMode : dutyTypeMode // ignore: cast_nullable_to_non_nullable
as String,dutyTypeScope: null == dutyTypeScope ? _self.dutyTypeScope : dutyTypeScope // ignore: cast_nullable_to_non_nullable
as String,dutyTypeAutoRotate: null == dutyTypeAutoRotate ? _self.dutyTypeAutoRotate : dutyTypeAutoRotate // ignore: cast_nullable_to_non_nullable
as bool,dutyTypePool: null == dutyTypePool ? _self._dutyTypePool : dutyTypePool // ignore: cast_nullable_to_non_nullable
as List<String>,dutyTypes: null == dutyTypes ? _self._dutyTypes : dutyTypes // ignore: cast_nullable_to_non_nullable
as List<DutyTypeSummary>,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<DutyGroup>,assignments: null == assignments ? _self._assignments : assignments // ignore: cast_nullable_to_non_nullable
as List<DutyAssignment>,allPeople: null == allPeople ? _self._allPeople : allPeople // ignore: cast_nullable_to_non_nullable
as List<DutyPerson>,poolPeople: null == poolPeople ? _self._poolPeople : poolPeople // ignore: cast_nullable_to_non_nullable
as List<DutyPerson>,matches: null == matches ? _self._matches : matches // ignore: cast_nullable_to_non_nullable
as List<DutyMatch>,
  ));
}


}

// dart format on
