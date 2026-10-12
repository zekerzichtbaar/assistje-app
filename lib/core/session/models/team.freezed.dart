// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Team {

 int get id; String get name; String get slug; String get sport; String? get logoUrl; bool get logoFills;/// Teamkleur als hex (`#006837`); `null` = standaardkleur.
 String? get primaryColor; String? get url; bool get isDemo;
/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamCopyWith<Team> get copyWith => _$TeamCopyWithImpl<Team>(this as Team, _$identity);

  /// Serializes this Team to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Team&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.logoFills, logoFills) || other.logoFills == logoFills)&&(identical(other.primaryColor, primaryColor) || other.primaryColor == primaryColor)&&(identical(other.url, url) || other.url == url)&&(identical(other.isDemo, isDemo) || other.isDemo == isDemo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,sport,logoUrl,logoFills,primaryColor,url,isDemo);

@override
String toString() {
  return 'Team(id: $id, name: $name, slug: $slug, sport: $sport, logoUrl: $logoUrl, logoFills: $logoFills, primaryColor: $primaryColor, url: $url, isDemo: $isDemo)';
}


}

/// @nodoc
abstract mixin class $TeamCopyWith<$Res>  {
  factory $TeamCopyWith(Team value, $Res Function(Team) _then) = _$TeamCopyWithImpl;
@useResult
$Res call({
 int id, String name, String slug, String sport, String? logoUrl, bool logoFills, String? primaryColor, String? url, bool isDemo
});




}
/// @nodoc
class _$TeamCopyWithImpl<$Res>
    implements $TeamCopyWith<$Res> {
  _$TeamCopyWithImpl(this._self, this._then);

  final Team _self;
  final $Res Function(Team) _then;

/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? sport = null,Object? logoUrl = freezed,Object? logoFills = null,Object? primaryColor = freezed,Object? url = freezed,Object? isDemo = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,sport: null == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,logoFills: null == logoFills ? _self.logoFills : logoFills // ignore: cast_nullable_to_non_nullable
as bool,primaryColor: freezed == primaryColor ? _self.primaryColor : primaryColor // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,isDemo: null == isDemo ? _self.isDemo : isDemo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Team].
extension TeamPatterns on Team {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Team value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Team() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Team value)  $default,){
final _that = this;
switch (_that) {
case _Team():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Team value)?  $default,){
final _that = this;
switch (_that) {
case _Team() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String sport,  String? logoUrl,  bool logoFills,  String? primaryColor,  String? url,  bool isDemo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Team() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.sport,_that.logoUrl,_that.logoFills,_that.primaryColor,_that.url,_that.isDemo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String sport,  String? logoUrl,  bool logoFills,  String? primaryColor,  String? url,  bool isDemo)  $default,) {final _that = this;
switch (_that) {
case _Team():
return $default(_that.id,_that.name,_that.slug,_that.sport,_that.logoUrl,_that.logoFills,_that.primaryColor,_that.url,_that.isDemo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String slug,  String sport,  String? logoUrl,  bool logoFills,  String? primaryColor,  String? url,  bool isDemo)?  $default,) {final _that = this;
switch (_that) {
case _Team() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.sport,_that.logoUrl,_that.logoFills,_that.primaryColor,_that.url,_that.isDemo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Team implements Team {
  const _Team({required this.id, required this.name, required this.slug, required this.sport, this.logoUrl, this.logoFills = false, this.primaryColor, this.url, this.isDemo = false});
  factory _Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

@override final  int id;
@override final  String name;
@override final  String slug;
@override final  String sport;
@override final  String? logoUrl;
@override@JsonKey() final  bool logoFills;
/// Teamkleur als hex (`#006837`); `null` = standaardkleur.
@override final  String? primaryColor;
@override final  String? url;
@override@JsonKey() final  bool isDemo;

/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamCopyWith<_Team> get copyWith => __$TeamCopyWithImpl<_Team>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Team&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.logoFills, logoFills) || other.logoFills == logoFills)&&(identical(other.primaryColor, primaryColor) || other.primaryColor == primaryColor)&&(identical(other.url, url) || other.url == url)&&(identical(other.isDemo, isDemo) || other.isDemo == isDemo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,sport,logoUrl,logoFills,primaryColor,url,isDemo);

@override
String toString() {
  return 'Team(id: $id, name: $name, slug: $slug, sport: $sport, logoUrl: $logoUrl, logoFills: $logoFills, primaryColor: $primaryColor, url: $url, isDemo: $isDemo)';
}


}

/// @nodoc
abstract mixin class _$TeamCopyWith<$Res> implements $TeamCopyWith<$Res> {
  factory _$TeamCopyWith(_Team value, $Res Function(_Team) _then) = __$TeamCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String slug, String sport, String? logoUrl, bool logoFills, String? primaryColor, String? url, bool isDemo
});




}
/// @nodoc
class __$TeamCopyWithImpl<$Res>
    implements _$TeamCopyWith<$Res> {
  __$TeamCopyWithImpl(this._self, this._then);

  final _Team _self;
  final $Res Function(_Team) _then;

/// Create a copy of Team
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? sport = null,Object? logoUrl = freezed,Object? logoFills = null,Object? primaryColor = freezed,Object? url = freezed,Object? isDemo = null,}) {
  return _then(_Team(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,sport: null == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,logoFills: null == logoFills ? _self.logoFills : logoFills // ignore: cast_nullable_to_non_nullable
as bool,primaryColor: freezed == primaryColor ? _self.primaryColor : primaryColor // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,isDemo: null == isDemo ? _self.isDemo : isDemo // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
