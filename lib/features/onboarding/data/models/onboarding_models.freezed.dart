// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingTeam {

 int get id; String get name; String? get onboardedAt; bool get needsOnboarding;
/// Create a copy of OnboardingTeam
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingTeamCopyWith<OnboardingTeam> get copyWith => _$OnboardingTeamCopyWithImpl<OnboardingTeam>(this as OnboardingTeam, _$identity);

  /// Serializes this OnboardingTeam to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingTeam&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.onboardedAt, onboardedAt) || other.onboardedAt == onboardedAt)&&(identical(other.needsOnboarding, needsOnboarding) || other.needsOnboarding == needsOnboarding));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,onboardedAt,needsOnboarding);

@override
String toString() {
  return 'OnboardingTeam(id: $id, name: $name, onboardedAt: $onboardedAt, needsOnboarding: $needsOnboarding)';
}


}

/// @nodoc
abstract mixin class $OnboardingTeamCopyWith<$Res>  {
  factory $OnboardingTeamCopyWith(OnboardingTeam value, $Res Function(OnboardingTeam) _then) = _$OnboardingTeamCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? onboardedAt, bool needsOnboarding
});




}
/// @nodoc
class _$OnboardingTeamCopyWithImpl<$Res>
    implements $OnboardingTeamCopyWith<$Res> {
  _$OnboardingTeamCopyWithImpl(this._self, this._then);

  final OnboardingTeam _self;
  final $Res Function(OnboardingTeam) _then;

/// Create a copy of OnboardingTeam
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? onboardedAt = freezed,Object? needsOnboarding = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,onboardedAt: freezed == onboardedAt ? _self.onboardedAt : onboardedAt // ignore: cast_nullable_to_non_nullable
as String?,needsOnboarding: null == needsOnboarding ? _self.needsOnboarding : needsOnboarding // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingTeam].
extension OnboardingTeamPatterns on OnboardingTeam {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingTeam value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingTeam() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingTeam value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingTeam():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingTeam value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingTeam() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? onboardedAt,  bool needsOnboarding)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingTeam() when $default != null:
return $default(_that.id,_that.name,_that.onboardedAt,_that.needsOnboarding);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? onboardedAt,  bool needsOnboarding)  $default,) {final _that = this;
switch (_that) {
case _OnboardingTeam():
return $default(_that.id,_that.name,_that.onboardedAt,_that.needsOnboarding);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? onboardedAt,  bool needsOnboarding)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingTeam() when $default != null:
return $default(_that.id,_that.name,_that.onboardedAt,_that.needsOnboarding);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingTeam implements OnboardingTeam {
  const _OnboardingTeam({required this.id, this.name = '', this.onboardedAt, this.needsOnboarding = true});
  factory _OnboardingTeam.fromJson(Map<String, dynamic> json) => _$OnboardingTeamFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  String? onboardedAt;
@override@JsonKey() final  bool needsOnboarding;

/// Create a copy of OnboardingTeam
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingTeamCopyWith<_OnboardingTeam> get copyWith => __$OnboardingTeamCopyWithImpl<_OnboardingTeam>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingTeamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingTeam&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.onboardedAt, onboardedAt) || other.onboardedAt == onboardedAt)&&(identical(other.needsOnboarding, needsOnboarding) || other.needsOnboarding == needsOnboarding));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,onboardedAt,needsOnboarding);

@override
String toString() {
  return 'OnboardingTeam(id: $id, name: $name, onboardedAt: $onboardedAt, needsOnboarding: $needsOnboarding)';
}


}

/// @nodoc
abstract mixin class _$OnboardingTeamCopyWith<$Res> implements $OnboardingTeamCopyWith<$Res> {
  factory _$OnboardingTeamCopyWith(_OnboardingTeam value, $Res Function(_OnboardingTeam) _then) = __$OnboardingTeamCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? onboardedAt, bool needsOnboarding
});




}
/// @nodoc
class __$OnboardingTeamCopyWithImpl<$Res>
    implements _$OnboardingTeamCopyWith<$Res> {
  __$OnboardingTeamCopyWithImpl(this._self, this._then);

  final _OnboardingTeam _self;
  final $Res Function(_OnboardingTeam) _then;

/// Create a copy of OnboardingTeam
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? onboardedAt = freezed,Object? needsOnboarding = null,}) {
  return _then(_OnboardingTeam(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,onboardedAt: freezed == onboardedAt ? _self.onboardedAt : onboardedAt // ignore: cast_nullable_to_non_nullable
as String?,needsOnboarding: null == needsOnboarding ? _self.needsOnboarding : needsOnboarding // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$OnboardingStep {

 String get key; String get title; String get text; String get href; String? get url; String get cta; bool get done;
/// Create a copy of OnboardingStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingStepCopyWith<OnboardingStep> get copyWith => _$OnboardingStepCopyWithImpl<OnboardingStep>(this as OnboardingStep, _$identity);

  /// Serializes this OnboardingStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingStep&&(identical(other.key, key) || other.key == key)&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.href, href) || other.href == href)&&(identical(other.url, url) || other.url == url)&&(identical(other.cta, cta) || other.cta == cta)&&(identical(other.done, done) || other.done == done));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,title,text,href,url,cta,done);

@override
String toString() {
  return 'OnboardingStep(key: $key, title: $title, text: $text, href: $href, url: $url, cta: $cta, done: $done)';
}


}

/// @nodoc
abstract mixin class $OnboardingStepCopyWith<$Res>  {
  factory $OnboardingStepCopyWith(OnboardingStep value, $Res Function(OnboardingStep) _then) = _$OnboardingStepCopyWithImpl;
@useResult
$Res call({
 String key, String title, String text, String href, String? url, String cta, bool done
});




}
/// @nodoc
class _$OnboardingStepCopyWithImpl<$Res>
    implements $OnboardingStepCopyWith<$Res> {
  _$OnboardingStepCopyWithImpl(this._self, this._then);

  final OnboardingStep _self;
  final $Res Function(OnboardingStep) _then;

/// Create a copy of OnboardingStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? title = null,Object? text = null,Object? href = null,Object? url = freezed,Object? cta = null,Object? done = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,href: null == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,cta: null == cta ? _self.cta : cta // ignore: cast_nullable_to_non_nullable
as String,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingStep].
extension OnboardingStepPatterns on OnboardingStep {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingStep() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingStep value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingStep():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingStep value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingStep() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String title,  String text,  String href,  String? url,  String cta,  bool done)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingStep() when $default != null:
return $default(_that.key,_that.title,_that.text,_that.href,_that.url,_that.cta,_that.done);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String title,  String text,  String href,  String? url,  String cta,  bool done)  $default,) {final _that = this;
switch (_that) {
case _OnboardingStep():
return $default(_that.key,_that.title,_that.text,_that.href,_that.url,_that.cta,_that.done);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String title,  String text,  String href,  String? url,  String cta,  bool done)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingStep() when $default != null:
return $default(_that.key,_that.title,_that.text,_that.href,_that.url,_that.cta,_that.done);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingStep implements OnboardingStep {
  const _OnboardingStep({required this.key, this.title = '', this.text = '', this.href = '/', this.url, this.cta = '', this.done = false});
  factory _OnboardingStep.fromJson(Map<String, dynamic> json) => _$OnboardingStepFromJson(json);

@override final  String key;
@override@JsonKey() final  String title;
@override@JsonKey() final  String text;
@override@JsonKey() final  String href;
@override final  String? url;
@override@JsonKey() final  String cta;
@override@JsonKey() final  bool done;

/// Create a copy of OnboardingStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingStepCopyWith<_OnboardingStep> get copyWith => __$OnboardingStepCopyWithImpl<_OnboardingStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingStepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingStep&&(identical(other.key, key) || other.key == key)&&(identical(other.title, title) || other.title == title)&&(identical(other.text, text) || other.text == text)&&(identical(other.href, href) || other.href == href)&&(identical(other.url, url) || other.url == url)&&(identical(other.cta, cta) || other.cta == cta)&&(identical(other.done, done) || other.done == done));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,title,text,href,url,cta,done);

@override
String toString() {
  return 'OnboardingStep(key: $key, title: $title, text: $text, href: $href, url: $url, cta: $cta, done: $done)';
}


}

/// @nodoc
abstract mixin class _$OnboardingStepCopyWith<$Res> implements $OnboardingStepCopyWith<$Res> {
  factory _$OnboardingStepCopyWith(_OnboardingStep value, $Res Function(_OnboardingStep) _then) = __$OnboardingStepCopyWithImpl;
@override @useResult
$Res call({
 String key, String title, String text, String href, String? url, String cta, bool done
});




}
/// @nodoc
class __$OnboardingStepCopyWithImpl<$Res>
    implements _$OnboardingStepCopyWith<$Res> {
  __$OnboardingStepCopyWithImpl(this._self, this._then);

  final _OnboardingStep _self;
  final $Res Function(_OnboardingStep) _then;

/// Create a copy of OnboardingStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? title = null,Object? text = null,Object? href = null,Object? url = freezed,Object? cta = null,Object? done = null,}) {
  return _then(_OnboardingStep(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,href: null == href ? _self.href : href // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,cta: null == cta ? _self.cta : cta // ignore: cast_nullable_to_non_nullable
as String,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$OnboardingNextMatch {

 int get id; String get title; String? get startsAt; int get responded; int get roster;
/// Create a copy of OnboardingNextMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingNextMatchCopyWith<OnboardingNextMatch> get copyWith => _$OnboardingNextMatchCopyWithImpl<OnboardingNextMatch>(this as OnboardingNextMatch, _$identity);

  /// Serializes this OnboardingNextMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingNextMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.responded, responded) || other.responded == responded)&&(identical(other.roster, roster) || other.roster == roster));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt,responded,roster);

@override
String toString() {
  return 'OnboardingNextMatch(id: $id, title: $title, startsAt: $startsAt, responded: $responded, roster: $roster)';
}


}

/// @nodoc
abstract mixin class $OnboardingNextMatchCopyWith<$Res>  {
  factory $OnboardingNextMatchCopyWith(OnboardingNextMatch value, $Res Function(OnboardingNextMatch) _then) = _$OnboardingNextMatchCopyWithImpl;
@useResult
$Res call({
 int id, String title, String? startsAt, int responded, int roster
});




}
/// @nodoc
class _$OnboardingNextMatchCopyWithImpl<$Res>
    implements $OnboardingNextMatchCopyWith<$Res> {
  _$OnboardingNextMatchCopyWithImpl(this._self, this._then);

  final OnboardingNextMatch _self;
  final $Res Function(OnboardingNextMatch) _then;

/// Create a copy of OnboardingNextMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,Object? responded = null,Object? roster = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String?,responded: null == responded ? _self.responded : responded // ignore: cast_nullable_to_non_nullable
as int,roster: null == roster ? _self.roster : roster // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingNextMatch].
extension OnboardingNextMatchPatterns on OnboardingNextMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingNextMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingNextMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingNextMatch value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingNextMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingNextMatch value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingNextMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String? startsAt,  int responded,  int roster)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingNextMatch() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.responded,_that.roster);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String? startsAt,  int responded,  int roster)  $default,) {final _that = this;
switch (_that) {
case _OnboardingNextMatch():
return $default(_that.id,_that.title,_that.startsAt,_that.responded,_that.roster);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String? startsAt,  int responded,  int roster)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingNextMatch() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.responded,_that.roster);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingNextMatch extends OnboardingNextMatch {
  const _OnboardingNextMatch({required this.id, this.title = '', this.startsAt, this.responded = 0, this.roster = 0}): super._();
  factory _OnboardingNextMatch.fromJson(Map<String, dynamic> json) => _$OnboardingNextMatchFromJson(json);

@override final  int id;
@override@JsonKey() final  String title;
@override final  String? startsAt;
@override@JsonKey() final  int responded;
@override@JsonKey() final  int roster;

/// Create a copy of OnboardingNextMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingNextMatchCopyWith<_OnboardingNextMatch> get copyWith => __$OnboardingNextMatchCopyWithImpl<_OnboardingNextMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingNextMatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingNextMatch&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.responded, responded) || other.responded == responded)&&(identical(other.roster, roster) || other.roster == roster));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt,responded,roster);

@override
String toString() {
  return 'OnboardingNextMatch(id: $id, title: $title, startsAt: $startsAt, responded: $responded, roster: $roster)';
}


}

/// @nodoc
abstract mixin class _$OnboardingNextMatchCopyWith<$Res> implements $OnboardingNextMatchCopyWith<$Res> {
  factory _$OnboardingNextMatchCopyWith(_OnboardingNextMatch value, $Res Function(_OnboardingNextMatch) _then) = __$OnboardingNextMatchCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String? startsAt, int responded, int roster
});




}
/// @nodoc
class __$OnboardingNextMatchCopyWithImpl<$Res>
    implements _$OnboardingNextMatchCopyWith<$Res> {
  __$OnboardingNextMatchCopyWithImpl(this._self, this._then);

  final _OnboardingNextMatch _self;
  final $Res Function(_OnboardingNextMatch) _then;

/// Create a copy of OnboardingNextMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,Object? responded = null,Object? roster = null,}) {
  return _then(_OnboardingNextMatch(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String?,responded: null == responded ? _self.responded : responded // ignore: cast_nullable_to_non_nullable
as int,roster: null == roster ? _self.roster : roster // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Onboarding {

 OnboardingTeam get team; List<OnboardingStep> get steps;@JsonKey(fromJson: ScheduleRequestState.parse, includeToJson: false) ScheduleRequestState get scheduleRequest; OnboardingNextMatch? get nextMatch;
/// Create a copy of Onboarding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingCopyWith<Onboarding> get copyWith => _$OnboardingCopyWithImpl<Onboarding>(this as Onboarding, _$identity);

  /// Serializes this Onboarding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Onboarding&&(identical(other.team, team) || other.team == team)&&const DeepCollectionEquality().equals(other.steps, steps)&&(identical(other.scheduleRequest, scheduleRequest) || other.scheduleRequest == scheduleRequest)&&(identical(other.nextMatch, nextMatch) || other.nextMatch == nextMatch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,const DeepCollectionEquality().hash(steps),scheduleRequest,nextMatch);

@override
String toString() {
  return 'Onboarding(team: $team, steps: $steps, scheduleRequest: $scheduleRequest, nextMatch: $nextMatch)';
}


}

/// @nodoc
abstract mixin class $OnboardingCopyWith<$Res>  {
  factory $OnboardingCopyWith(Onboarding value, $Res Function(Onboarding) _then) = _$OnboardingCopyWithImpl;
@useResult
$Res call({
 OnboardingTeam team, List<OnboardingStep> steps,@JsonKey(fromJson: ScheduleRequestState.parse, includeToJson: false) ScheduleRequestState scheduleRequest, OnboardingNextMatch? nextMatch
});


$OnboardingTeamCopyWith<$Res> get team;$OnboardingNextMatchCopyWith<$Res>? get nextMatch;

}
/// @nodoc
class _$OnboardingCopyWithImpl<$Res>
    implements $OnboardingCopyWith<$Res> {
  _$OnboardingCopyWithImpl(this._self, this._then);

  final Onboarding _self;
  final $Res Function(Onboarding) _then;

/// Create a copy of Onboarding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? team = null,Object? steps = null,Object? scheduleRequest = null,Object? nextMatch = freezed,}) {
  return _then(_self.copyWith(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as OnboardingTeam,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<OnboardingStep>,scheduleRequest: null == scheduleRequest ? _self.scheduleRequest : scheduleRequest // ignore: cast_nullable_to_non_nullable
as ScheduleRequestState,nextMatch: freezed == nextMatch ? _self.nextMatch : nextMatch // ignore: cast_nullable_to_non_nullable
as OnboardingNextMatch?,
  ));
}
/// Create a copy of Onboarding
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingTeamCopyWith<$Res> get team {
  
  return $OnboardingTeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}/// Create a copy of Onboarding
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingNextMatchCopyWith<$Res>? get nextMatch {
    if (_self.nextMatch == null) {
    return null;
  }

  return $OnboardingNextMatchCopyWith<$Res>(_self.nextMatch!, (value) {
    return _then(_self.copyWith(nextMatch: value));
  });
}
}


/// Adds pattern-matching-related methods to [Onboarding].
extension OnboardingPatterns on Onboarding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Onboarding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Onboarding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Onboarding value)  $default,){
final _that = this;
switch (_that) {
case _Onboarding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Onboarding value)?  $default,){
final _that = this;
switch (_that) {
case _Onboarding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OnboardingTeam team,  List<OnboardingStep> steps, @JsonKey(fromJson: ScheduleRequestState.parse, includeToJson: false)  ScheduleRequestState scheduleRequest,  OnboardingNextMatch? nextMatch)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Onboarding() when $default != null:
return $default(_that.team,_that.steps,_that.scheduleRequest,_that.nextMatch);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OnboardingTeam team,  List<OnboardingStep> steps, @JsonKey(fromJson: ScheduleRequestState.parse, includeToJson: false)  ScheduleRequestState scheduleRequest,  OnboardingNextMatch? nextMatch)  $default,) {final _that = this;
switch (_that) {
case _Onboarding():
return $default(_that.team,_that.steps,_that.scheduleRequest,_that.nextMatch);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OnboardingTeam team,  List<OnboardingStep> steps, @JsonKey(fromJson: ScheduleRequestState.parse, includeToJson: false)  ScheduleRequestState scheduleRequest,  OnboardingNextMatch? nextMatch)?  $default,) {final _that = this;
switch (_that) {
case _Onboarding() when $default != null:
return $default(_that.team,_that.steps,_that.scheduleRequest,_that.nextMatch);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Onboarding extends Onboarding {
  const _Onboarding({required this.team, final  List<OnboardingStep> steps = const <OnboardingStep>[], @JsonKey(fromJson: ScheduleRequestState.parse, includeToJson: false) this.scheduleRequest = ScheduleRequestState.none, this.nextMatch}): _steps = steps,super._();
  factory _Onboarding.fromJson(Map<String, dynamic> json) => _$OnboardingFromJson(json);

@override final  OnboardingTeam team;
 final  List<OnboardingStep> _steps;
@override@JsonKey() List<OnboardingStep> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}

@override@JsonKey(fromJson: ScheduleRequestState.parse, includeToJson: false) final  ScheduleRequestState scheduleRequest;
@override final  OnboardingNextMatch? nextMatch;

/// Create a copy of Onboarding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingCopyWith<_Onboarding> get copyWith => __$OnboardingCopyWithImpl<_Onboarding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Onboarding&&(identical(other.team, team) || other.team == team)&&const DeepCollectionEquality().equals(other._steps, _steps)&&(identical(other.scheduleRequest, scheduleRequest) || other.scheduleRequest == scheduleRequest)&&(identical(other.nextMatch, nextMatch) || other.nextMatch == nextMatch));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,const DeepCollectionEquality().hash(_steps),scheduleRequest,nextMatch);

@override
String toString() {
  return 'Onboarding(team: $team, steps: $steps, scheduleRequest: $scheduleRequest, nextMatch: $nextMatch)';
}


}

/// @nodoc
abstract mixin class _$OnboardingCopyWith<$Res> implements $OnboardingCopyWith<$Res> {
  factory _$OnboardingCopyWith(_Onboarding value, $Res Function(_Onboarding) _then) = __$OnboardingCopyWithImpl;
@override @useResult
$Res call({
 OnboardingTeam team, List<OnboardingStep> steps,@JsonKey(fromJson: ScheduleRequestState.parse, includeToJson: false) ScheduleRequestState scheduleRequest, OnboardingNextMatch? nextMatch
});


@override $OnboardingTeamCopyWith<$Res> get team;@override $OnboardingNextMatchCopyWith<$Res>? get nextMatch;

}
/// @nodoc
class __$OnboardingCopyWithImpl<$Res>
    implements _$OnboardingCopyWith<$Res> {
  __$OnboardingCopyWithImpl(this._self, this._then);

  final _Onboarding _self;
  final $Res Function(_Onboarding) _then;

/// Create a copy of Onboarding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? team = null,Object? steps = null,Object? scheduleRequest = null,Object? nextMatch = freezed,}) {
  return _then(_Onboarding(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as OnboardingTeam,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<OnboardingStep>,scheduleRequest: null == scheduleRequest ? _self.scheduleRequest : scheduleRequest // ignore: cast_nullable_to_non_nullable
as ScheduleRequestState,nextMatch: freezed == nextMatch ? _self.nextMatch : nextMatch // ignore: cast_nullable_to_non_nullable
as OnboardingNextMatch?,
  ));
}

/// Create a copy of Onboarding
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingTeamCopyWith<$Res> get team {
  
  return $OnboardingTeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}/// Create a copy of Onboarding
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingNextMatchCopyWith<$Res>? get nextMatch {
    if (_self.nextMatch == null) {
    return null;
  }

  return $OnboardingNextMatchCopyWith<$Res>(_self.nextMatch!, (value) {
    return _then(_self.copyWith(nextMatch: value));
  });
}
}

// dart format on
