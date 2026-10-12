// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agreements_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Agreement {

 int get id; String get category;/// Alleen in de schrijfrespons.
 String? get categoryLabel; String get title; String? get body; int? get sortOrder;
/// Create a copy of Agreement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgreementCopyWith<Agreement> get copyWith => _$AgreementCopyWithImpl<Agreement>(this as Agreement, _$identity);

  /// Serializes this Agreement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Agreement&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.categoryLabel, categoryLabel) || other.categoryLabel == categoryLabel)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,categoryLabel,title,body,sortOrder);

@override
String toString() {
  return 'Agreement(id: $id, category: $category, categoryLabel: $categoryLabel, title: $title, body: $body, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class $AgreementCopyWith<$Res>  {
  factory $AgreementCopyWith(Agreement value, $Res Function(Agreement) _then) = _$AgreementCopyWithImpl;
@useResult
$Res call({
 int id, String category, String? categoryLabel, String title, String? body, int? sortOrder
});




}
/// @nodoc
class _$AgreementCopyWithImpl<$Res>
    implements $AgreementCopyWith<$Res> {
  _$AgreementCopyWithImpl(this._self, this._then);

  final Agreement _self;
  final $Res Function(Agreement) _then;

/// Create a copy of Agreement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? category = null,Object? categoryLabel = freezed,Object? title = null,Object? body = freezed,Object? sortOrder = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: freezed == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [Agreement].
extension AgreementPatterns on Agreement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Agreement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Agreement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Agreement value)  $default,){
final _that = this;
switch (_that) {
case _Agreement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Agreement value)?  $default,){
final _that = this;
switch (_that) {
case _Agreement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String category,  String? categoryLabel,  String title,  String? body,  int? sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Agreement() when $default != null:
return $default(_that.id,_that.category,_that.categoryLabel,_that.title,_that.body,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String category,  String? categoryLabel,  String title,  String? body,  int? sortOrder)  $default,) {final _that = this;
switch (_that) {
case _Agreement():
return $default(_that.id,_that.category,_that.categoryLabel,_that.title,_that.body,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String category,  String? categoryLabel,  String title,  String? body,  int? sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _Agreement() when $default != null:
return $default(_that.id,_that.category,_that.categoryLabel,_that.title,_that.body,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Agreement implements Agreement {
  const _Agreement({required this.id, this.category = 'other', this.categoryLabel, this.title = '', this.body, this.sortOrder});
  factory _Agreement.fromJson(Map<String, dynamic> json) => _$AgreementFromJson(json);

@override final  int id;
@override@JsonKey() final  String category;
/// Alleen in de schrijfrespons.
@override final  String? categoryLabel;
@override@JsonKey() final  String title;
@override final  String? body;
@override final  int? sortOrder;

/// Create a copy of Agreement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgreementCopyWith<_Agreement> get copyWith => __$AgreementCopyWithImpl<_Agreement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgreementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Agreement&&(identical(other.id, id) || other.id == id)&&(identical(other.category, category) || other.category == category)&&(identical(other.categoryLabel, categoryLabel) || other.categoryLabel == categoryLabel)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,category,categoryLabel,title,body,sortOrder);

@override
String toString() {
  return 'Agreement(id: $id, category: $category, categoryLabel: $categoryLabel, title: $title, body: $body, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$AgreementCopyWith<$Res> implements $AgreementCopyWith<$Res> {
  factory _$AgreementCopyWith(_Agreement value, $Res Function(_Agreement) _then) = __$AgreementCopyWithImpl;
@override @useResult
$Res call({
 int id, String category, String? categoryLabel, String title, String? body, int? sortOrder
});




}
/// @nodoc
class __$AgreementCopyWithImpl<$Res>
    implements _$AgreementCopyWith<$Res> {
  __$AgreementCopyWithImpl(this._self, this._then);

  final _Agreement _self;
  final $Res Function(_Agreement) _then;

/// Create a copy of Agreement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? category = null,Object? categoryLabel = freezed,Object? title = null,Object? body = freezed,Object? sortOrder = freezed,}) {
  return _then(_Agreement(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,categoryLabel: freezed == categoryLabel ? _self.categoryLabel : categoryLabel // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: freezed == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$AgreementGroup {

 String get key; String get label; List<Agreement> get items;
/// Create a copy of AgreementGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgreementGroupCopyWith<AgreementGroup> get copyWith => _$AgreementGroupCopyWithImpl<AgreementGroup>(this as AgreementGroup, _$identity);

  /// Serializes this AgreementGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgreementGroup&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'AgreementGroup(key: $key, label: $label, items: $items)';
}


}

/// @nodoc
abstract mixin class $AgreementGroupCopyWith<$Res>  {
  factory $AgreementGroupCopyWith(AgreementGroup value, $Res Function(AgreementGroup) _then) = _$AgreementGroupCopyWithImpl;
@useResult
$Res call({
 String key, String label, List<Agreement> items
});




}
/// @nodoc
class _$AgreementGroupCopyWithImpl<$Res>
    implements $AgreementGroupCopyWith<$Res> {
  _$AgreementGroupCopyWithImpl(this._self, this._then);

  final AgreementGroup _self;
  final $Res Function(AgreementGroup) _then;

/// Create a copy of AgreementGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,Object? items = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Agreement>,
  ));
}

}


/// Adds pattern-matching-related methods to [AgreementGroup].
extension AgreementGroupPatterns on AgreementGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgreementGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgreementGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgreementGroup value)  $default,){
final _that = this;
switch (_that) {
case _AgreementGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgreementGroup value)?  $default,){
final _that = this;
switch (_that) {
case _AgreementGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String label,  List<Agreement> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgreementGroup() when $default != null:
return $default(_that.key,_that.label,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String label,  List<Agreement> items)  $default,) {final _that = this;
switch (_that) {
case _AgreementGroup():
return $default(_that.key,_that.label,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String label,  List<Agreement> items)?  $default,) {final _that = this;
switch (_that) {
case _AgreementGroup() when $default != null:
return $default(_that.key,_that.label,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AgreementGroup implements AgreementGroup {
  const _AgreementGroup({required this.key, this.label = '', final  List<Agreement> items = const <Agreement>[]}): _items = items;
  factory _AgreementGroup.fromJson(Map<String, dynamic> json) => _$AgreementGroupFromJson(json);

@override final  String key;
@override@JsonKey() final  String label;
 final  List<Agreement> _items;
@override@JsonKey() List<Agreement> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of AgreementGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgreementGroupCopyWith<_AgreementGroup> get copyWith => __$AgreementGroupCopyWithImpl<_AgreementGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgreementGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgreementGroup&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'AgreementGroup(key: $key, label: $label, items: $items)';
}


}

/// @nodoc
abstract mixin class _$AgreementGroupCopyWith<$Res> implements $AgreementGroupCopyWith<$Res> {
  factory _$AgreementGroupCopyWith(_AgreementGroup value, $Res Function(_AgreementGroup) _then) = __$AgreementGroupCopyWithImpl;
@override @useResult
$Res call({
 String key, String label, List<Agreement> items
});




}
/// @nodoc
class __$AgreementGroupCopyWithImpl<$Res>
    implements _$AgreementGroupCopyWith<$Res> {
  __$AgreementGroupCopyWithImpl(this._self, this._then);

  final _AgreementGroup _self;
  final $Res Function(_AgreementGroup) _then;

/// Create a copy of AgreementGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,Object? items = null,}) {
  return _then(_AgreementGroup(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Agreement>,
  ));
}


}


/// @nodoc
mixin _$AgreementCategory {

 String get key; String get label;
/// Create a copy of AgreementCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgreementCategoryCopyWith<AgreementCategory> get copyWith => _$AgreementCategoryCopyWithImpl<AgreementCategory>(this as AgreementCategory, _$identity);

  /// Serializes this AgreementCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgreementCategory&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label);

@override
String toString() {
  return 'AgreementCategory(key: $key, label: $label)';
}


}

/// @nodoc
abstract mixin class $AgreementCategoryCopyWith<$Res>  {
  factory $AgreementCategoryCopyWith(AgreementCategory value, $Res Function(AgreementCategory) _then) = _$AgreementCategoryCopyWithImpl;
@useResult
$Res call({
 String key, String label
});




}
/// @nodoc
class _$AgreementCategoryCopyWithImpl<$Res>
    implements $AgreementCategoryCopyWith<$Res> {
  _$AgreementCategoryCopyWithImpl(this._self, this._then);

  final AgreementCategory _self;
  final $Res Function(AgreementCategory) _then;

/// Create a copy of AgreementCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AgreementCategory].
extension AgreementCategoryPatterns on AgreementCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgreementCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgreementCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgreementCategory value)  $default,){
final _that = this;
switch (_that) {
case _AgreementCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgreementCategory value)?  $default,){
final _that = this;
switch (_that) {
case _AgreementCategory() when $default != null:
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
case _AgreementCategory() when $default != null:
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
case _AgreementCategory():
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
case _AgreementCategory() when $default != null:
return $default(_that.key,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AgreementCategory implements AgreementCategory {
  const _AgreementCategory({required this.key, this.label = ''});
  factory _AgreementCategory.fromJson(Map<String, dynamic> json) => _$AgreementCategoryFromJson(json);

@override final  String key;
@override@JsonKey() final  String label;

/// Create a copy of AgreementCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgreementCategoryCopyWith<_AgreementCategory> get copyWith => __$AgreementCategoryCopyWithImpl<_AgreementCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgreementCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgreementCategory&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label);

@override
String toString() {
  return 'AgreementCategory(key: $key, label: $label)';
}


}

/// @nodoc
abstract mixin class _$AgreementCategoryCopyWith<$Res> implements $AgreementCategoryCopyWith<$Res> {
  factory _$AgreementCategoryCopyWith(_AgreementCategory value, $Res Function(_AgreementCategory) _then) = __$AgreementCategoryCopyWithImpl;
@override @useResult
$Res call({
 String key, String label
});




}
/// @nodoc
class __$AgreementCategoryCopyWithImpl<$Res>
    implements _$AgreementCategoryCopyWith<$Res> {
  __$AgreementCategoryCopyWithImpl(this._self, this._then);

  final _AgreementCategory _self;
  final $Res Function(_AgreementCategory) _then;

/// Create a copy of AgreementCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,}) {
  return _then(_AgreementCategory(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AgreementsOverview {

 List<AgreementGroup> get groups; String? get intro; List<AgreementCategory> get categories; bool get canManage;
/// Create a copy of AgreementsOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgreementsOverviewCopyWith<AgreementsOverview> get copyWith => _$AgreementsOverviewCopyWithImpl<AgreementsOverview>(this as AgreementsOverview, _$identity);

  /// Serializes this AgreementsOverview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgreementsOverview&&const DeepCollectionEquality().equals(other.groups, groups)&&(identical(other.intro, intro) || other.intro == intro)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.canManage, canManage) || other.canManage == canManage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(groups),intro,const DeepCollectionEquality().hash(categories),canManage);

@override
String toString() {
  return 'AgreementsOverview(groups: $groups, intro: $intro, categories: $categories, canManage: $canManage)';
}


}

/// @nodoc
abstract mixin class $AgreementsOverviewCopyWith<$Res>  {
  factory $AgreementsOverviewCopyWith(AgreementsOverview value, $Res Function(AgreementsOverview) _then) = _$AgreementsOverviewCopyWithImpl;
@useResult
$Res call({
 List<AgreementGroup> groups, String? intro, List<AgreementCategory> categories, bool canManage
});




}
/// @nodoc
class _$AgreementsOverviewCopyWithImpl<$Res>
    implements $AgreementsOverviewCopyWith<$Res> {
  _$AgreementsOverviewCopyWithImpl(this._self, this._then);

  final AgreementsOverview _self;
  final $Res Function(AgreementsOverview) _then;

/// Create a copy of AgreementsOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groups = null,Object? intro = freezed,Object? categories = null,Object? canManage = null,}) {
  return _then(_self.copyWith(
groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<AgreementGroup>,intro: freezed == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<AgreementCategory>,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AgreementsOverview].
extension AgreementsOverviewPatterns on AgreementsOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgreementsOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgreementsOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgreementsOverview value)  $default,){
final _that = this;
switch (_that) {
case _AgreementsOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgreementsOverview value)?  $default,){
final _that = this;
switch (_that) {
case _AgreementsOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AgreementGroup> groups,  String? intro,  List<AgreementCategory> categories,  bool canManage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgreementsOverview() when $default != null:
return $default(_that.groups,_that.intro,_that.categories,_that.canManage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AgreementGroup> groups,  String? intro,  List<AgreementCategory> categories,  bool canManage)  $default,) {final _that = this;
switch (_that) {
case _AgreementsOverview():
return $default(_that.groups,_that.intro,_that.categories,_that.canManage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AgreementGroup> groups,  String? intro,  List<AgreementCategory> categories,  bool canManage)?  $default,) {final _that = this;
switch (_that) {
case _AgreementsOverview() when $default != null:
return $default(_that.groups,_that.intro,_that.categories,_that.canManage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AgreementsOverview extends AgreementsOverview {
  const _AgreementsOverview({final  List<AgreementGroup> groups = const <AgreementGroup>[], this.intro, final  List<AgreementCategory> categories = const <AgreementCategory>[], this.canManage = false}): _groups = groups,_categories = categories,super._();
  factory _AgreementsOverview.fromJson(Map<String, dynamic> json) => _$AgreementsOverviewFromJson(json);

 final  List<AgreementGroup> _groups;
@override@JsonKey() List<AgreementGroup> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}

@override final  String? intro;
 final  List<AgreementCategory> _categories;
@override@JsonKey() List<AgreementCategory> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  bool canManage;

/// Create a copy of AgreementsOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgreementsOverviewCopyWith<_AgreementsOverview> get copyWith => __$AgreementsOverviewCopyWithImpl<_AgreementsOverview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgreementsOverviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgreementsOverview&&const DeepCollectionEquality().equals(other._groups, _groups)&&(identical(other.intro, intro) || other.intro == intro)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.canManage, canManage) || other.canManage == canManage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_groups),intro,const DeepCollectionEquality().hash(_categories),canManage);

@override
String toString() {
  return 'AgreementsOverview(groups: $groups, intro: $intro, categories: $categories, canManage: $canManage)';
}


}

/// @nodoc
abstract mixin class _$AgreementsOverviewCopyWith<$Res> implements $AgreementsOverviewCopyWith<$Res> {
  factory _$AgreementsOverviewCopyWith(_AgreementsOverview value, $Res Function(_AgreementsOverview) _then) = __$AgreementsOverviewCopyWithImpl;
@override @useResult
$Res call({
 List<AgreementGroup> groups, String? intro, List<AgreementCategory> categories, bool canManage
});




}
/// @nodoc
class __$AgreementsOverviewCopyWithImpl<$Res>
    implements _$AgreementsOverviewCopyWith<$Res> {
  __$AgreementsOverviewCopyWithImpl(this._self, this._then);

  final _AgreementsOverview _self;
  final $Res Function(_AgreementsOverview) _then;

/// Create a copy of AgreementsOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? groups = null,Object? intro = freezed,Object? categories = null,Object? canManage = null,}) {
  return _then(_AgreementsOverview(
groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<AgreementGroup>,intro: freezed == intro ? _self.intro : intro // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<AgreementCategory>,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
