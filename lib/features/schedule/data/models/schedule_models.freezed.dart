// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ScheduleChoice {

 String get value; String get label;
/// Create a copy of ScheduleChoice
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleChoiceCopyWith<ScheduleChoice> get copyWith => _$ScheduleChoiceCopyWithImpl<ScheduleChoice>(this as ScheduleChoice, _$identity);

  /// Serializes this ScheduleChoice to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleChoice&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,label);

@override
String toString() {
  return 'ScheduleChoice(value: $value, label: $label)';
}


}

/// @nodoc
abstract mixin class $ScheduleChoiceCopyWith<$Res>  {
  factory $ScheduleChoiceCopyWith(ScheduleChoice value, $Res Function(ScheduleChoice) _then) = _$ScheduleChoiceCopyWithImpl;
@useResult
$Res call({
 String value, String label
});




}
/// @nodoc
class _$ScheduleChoiceCopyWithImpl<$Res>
    implements $ScheduleChoiceCopyWith<$Res> {
  _$ScheduleChoiceCopyWithImpl(this._self, this._then);

  final ScheduleChoice _self;
  final $Res Function(ScheduleChoice) _then;

/// Create a copy of ScheduleChoice
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? label = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleChoice].
extension ScheduleChoicePatterns on ScheduleChoice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleChoice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleChoice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleChoice value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleChoice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleChoice value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleChoice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleChoice() when $default != null:
return $default(_that.value,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  String label)  $default,) {final _that = this;
switch (_that) {
case _ScheduleChoice():
return $default(_that.value,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  String label)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleChoice() when $default != null:
return $default(_that.value,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScheduleChoice implements ScheduleChoice {
  const _ScheduleChoice({required this.value, this.label = ''});
  factory _ScheduleChoice.fromJson(Map<String, dynamic> json) => _$ScheduleChoiceFromJson(json);

@override final  String value;
@override@JsonKey() final  String label;

/// Create a copy of ScheduleChoice
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleChoiceCopyWith<_ScheduleChoice> get copyWith => __$ScheduleChoiceCopyWithImpl<_ScheduleChoice>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduleChoiceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleChoice&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,label);

@override
String toString() {
  return 'ScheduleChoice(value: $value, label: $label)';
}


}

/// @nodoc
abstract mixin class _$ScheduleChoiceCopyWith<$Res> implements $ScheduleChoiceCopyWith<$Res> {
  factory _$ScheduleChoiceCopyWith(_ScheduleChoice value, $Res Function(_ScheduleChoice) _then) = __$ScheduleChoiceCopyWithImpl;
@override @useResult
$Res call({
 String value, String label
});




}
/// @nodoc
class __$ScheduleChoiceCopyWithImpl<$Res>
    implements _$ScheduleChoiceCopyWith<$Res> {
  __$ScheduleChoiceCopyWithImpl(this._self, this._then);

  final _ScheduleChoice _self;
  final $Res Function(_ScheduleChoice) _then;

/// Create a copy of ScheduleChoice
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? label = null,}) {
  return _then(_ScheduleChoice(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ScheduleDefaults {

 String get type;/// `HH:mm`, alleen voor een nieuwe training.
 String get trainingStartTime; String get competition; bool get isHome;@JsonKey(fromJson: _durationsFromJson) Map<String, int> get durationMinutes;
/// Create a copy of ScheduleDefaults
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleDefaultsCopyWith<ScheduleDefaults> get copyWith => _$ScheduleDefaultsCopyWithImpl<ScheduleDefaults>(this as ScheduleDefaults, _$identity);

  /// Serializes this ScheduleDefaults to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleDefaults&&(identical(other.type, type) || other.type == type)&&(identical(other.trainingStartTime, trainingStartTime) || other.trainingStartTime == trainingStartTime)&&(identical(other.competition, competition) || other.competition == competition)&&(identical(other.isHome, isHome) || other.isHome == isHome)&&const DeepCollectionEquality().equals(other.durationMinutes, durationMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,trainingStartTime,competition,isHome,const DeepCollectionEquality().hash(durationMinutes));

@override
String toString() {
  return 'ScheduleDefaults(type: $type, trainingStartTime: $trainingStartTime, competition: $competition, isHome: $isHome, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class $ScheduleDefaultsCopyWith<$Res>  {
  factory $ScheduleDefaultsCopyWith(ScheduleDefaults value, $Res Function(ScheduleDefaults) _then) = _$ScheduleDefaultsCopyWithImpl;
@useResult
$Res call({
 String type, String trainingStartTime, String competition, bool isHome,@JsonKey(fromJson: _durationsFromJson) Map<String, int> durationMinutes
});




}
/// @nodoc
class _$ScheduleDefaultsCopyWithImpl<$Res>
    implements $ScheduleDefaultsCopyWith<$Res> {
  _$ScheduleDefaultsCopyWithImpl(this._self, this._then);

  final ScheduleDefaults _self;
  final $Res Function(ScheduleDefaults) _then;

/// Create a copy of ScheduleDefaults
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? trainingStartTime = null,Object? competition = null,Object? isHome = null,Object? durationMinutes = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,trainingStartTime: null == trainingStartTime ? _self.trainingStartTime : trainingStartTime // ignore: cast_nullable_to_non_nullable
as String,competition: null == competition ? _self.competition : competition // ignore: cast_nullable_to_non_nullable
as String,isHome: null == isHome ? _self.isHome : isHome // ignore: cast_nullable_to_non_nullable
as bool,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleDefaults].
extension ScheduleDefaultsPatterns on ScheduleDefaults {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleDefaults value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleDefaults() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleDefaults value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleDefaults():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleDefaults value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleDefaults() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String trainingStartTime,  String competition,  bool isHome, @JsonKey(fromJson: _durationsFromJson)  Map<String, int> durationMinutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleDefaults() when $default != null:
return $default(_that.type,_that.trainingStartTime,_that.competition,_that.isHome,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String trainingStartTime,  String competition,  bool isHome, @JsonKey(fromJson: _durationsFromJson)  Map<String, int> durationMinutes)  $default,) {final _that = this;
switch (_that) {
case _ScheduleDefaults():
return $default(_that.type,_that.trainingStartTime,_that.competition,_that.isHome,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String trainingStartTime,  String competition,  bool isHome, @JsonKey(fromJson: _durationsFromJson)  Map<String, int> durationMinutes)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleDefaults() when $default != null:
return $default(_that.type,_that.trainingStartTime,_that.competition,_that.isHome,_that.durationMinutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScheduleDefaults implements ScheduleDefaults {
  const _ScheduleDefaults({this.type = 'training', this.trainingStartTime = '19:00', this.competition = 'league', this.isHome = true, @JsonKey(fromJson: _durationsFromJson) final  Map<String, int> durationMinutes = const <String, int>{}}): _durationMinutes = durationMinutes;
  factory _ScheduleDefaults.fromJson(Map<String, dynamic> json) => _$ScheduleDefaultsFromJson(json);

@override@JsonKey() final  String type;
/// `HH:mm`, alleen voor een nieuwe training.
@override@JsonKey() final  String trainingStartTime;
@override@JsonKey() final  String competition;
@override@JsonKey() final  bool isHome;
 final  Map<String, int> _durationMinutes;
@override@JsonKey(fromJson: _durationsFromJson) Map<String, int> get durationMinutes {
  if (_durationMinutes is EqualUnmodifiableMapView) return _durationMinutes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_durationMinutes);
}


/// Create a copy of ScheduleDefaults
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleDefaultsCopyWith<_ScheduleDefaults> get copyWith => __$ScheduleDefaultsCopyWithImpl<_ScheduleDefaults>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduleDefaultsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleDefaults&&(identical(other.type, type) || other.type == type)&&(identical(other.trainingStartTime, trainingStartTime) || other.trainingStartTime == trainingStartTime)&&(identical(other.competition, competition) || other.competition == competition)&&(identical(other.isHome, isHome) || other.isHome == isHome)&&const DeepCollectionEquality().equals(other._durationMinutes, _durationMinutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,trainingStartTime,competition,isHome,const DeepCollectionEquality().hash(_durationMinutes));

@override
String toString() {
  return 'ScheduleDefaults(type: $type, trainingStartTime: $trainingStartTime, competition: $competition, isHome: $isHome, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class _$ScheduleDefaultsCopyWith<$Res> implements $ScheduleDefaultsCopyWith<$Res> {
  factory _$ScheduleDefaultsCopyWith(_ScheduleDefaults value, $Res Function(_ScheduleDefaults) _then) = __$ScheduleDefaultsCopyWithImpl;
@override @useResult
$Res call({
 String type, String trainingStartTime, String competition, bool isHome,@JsonKey(fromJson: _durationsFromJson) Map<String, int> durationMinutes
});




}
/// @nodoc
class __$ScheduleDefaultsCopyWithImpl<$Res>
    implements _$ScheduleDefaultsCopyWith<$Res> {
  __$ScheduleDefaultsCopyWithImpl(this._self, this._then);

  final _ScheduleDefaults _self;
  final $Res Function(_ScheduleDefaults) _then;

/// Create a copy of ScheduleDefaults
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? trainingStartTime = null,Object? competition = null,Object? isHome = null,Object? durationMinutes = null,}) {
  return _then(_ScheduleDefaults(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,trainingStartTime: null == trainingStartTime ? _self.trainingStartTime : trainingStartTime // ignore: cast_nullable_to_non_nullable
as String,competition: null == competition ? _self.competition : competition // ignore: cast_nullable_to_non_nullable
as String,isHome: null == isHome ? _self.isHome : isHome // ignore: cast_nullable_to_non_nullable
as bool,durationMinutes: null == durationMinutes ? _self._durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}


/// @nodoc
mixin _$ScheduleOptions {

 String get teamName; String get timezone; List<ScheduleChoice> get types; List<ScheduleChoice> get competitions; ScheduleDefaults get defaults;
/// Create a copy of ScheduleOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleOptionsCopyWith<ScheduleOptions> get copyWith => _$ScheduleOptionsCopyWithImpl<ScheduleOptions>(this as ScheduleOptions, _$identity);

  /// Serializes this ScheduleOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleOptions&&(identical(other.teamName, teamName) || other.teamName == teamName)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&const DeepCollectionEquality().equals(other.types, types)&&const DeepCollectionEquality().equals(other.competitions, competitions)&&(identical(other.defaults, defaults) || other.defaults == defaults));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamName,timezone,const DeepCollectionEquality().hash(types),const DeepCollectionEquality().hash(competitions),defaults);

@override
String toString() {
  return 'ScheduleOptions(teamName: $teamName, timezone: $timezone, types: $types, competitions: $competitions, defaults: $defaults)';
}


}

/// @nodoc
abstract mixin class $ScheduleOptionsCopyWith<$Res>  {
  factory $ScheduleOptionsCopyWith(ScheduleOptions value, $Res Function(ScheduleOptions) _then) = _$ScheduleOptionsCopyWithImpl;
@useResult
$Res call({
 String teamName, String timezone, List<ScheduleChoice> types, List<ScheduleChoice> competitions, ScheduleDefaults defaults
});


$ScheduleDefaultsCopyWith<$Res> get defaults;

}
/// @nodoc
class _$ScheduleOptionsCopyWithImpl<$Res>
    implements $ScheduleOptionsCopyWith<$Res> {
  _$ScheduleOptionsCopyWithImpl(this._self, this._then);

  final ScheduleOptions _self;
  final $Res Function(ScheduleOptions) _then;

/// Create a copy of ScheduleOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teamName = null,Object? timezone = null,Object? types = null,Object? competitions = null,Object? defaults = null,}) {
  return _then(_self.copyWith(
teamName: null == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<ScheduleChoice>,competitions: null == competitions ? _self.competitions : competitions // ignore: cast_nullable_to_non_nullable
as List<ScheduleChoice>,defaults: null == defaults ? _self.defaults : defaults // ignore: cast_nullable_to_non_nullable
as ScheduleDefaults,
  ));
}
/// Create a copy of ScheduleOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScheduleDefaultsCopyWith<$Res> get defaults {
  
  return $ScheduleDefaultsCopyWith<$Res>(_self.defaults, (value) {
    return _then(_self.copyWith(defaults: value));
  });
}
}


/// Adds pattern-matching-related methods to [ScheduleOptions].
extension ScheduleOptionsPatterns on ScheduleOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleOptions value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleOptions value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String teamName,  String timezone,  List<ScheduleChoice> types,  List<ScheduleChoice> competitions,  ScheduleDefaults defaults)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleOptions() when $default != null:
return $default(_that.teamName,_that.timezone,_that.types,_that.competitions,_that.defaults);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String teamName,  String timezone,  List<ScheduleChoice> types,  List<ScheduleChoice> competitions,  ScheduleDefaults defaults)  $default,) {final _that = this;
switch (_that) {
case _ScheduleOptions():
return $default(_that.teamName,_that.timezone,_that.types,_that.competitions,_that.defaults);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String teamName,  String timezone,  List<ScheduleChoice> types,  List<ScheduleChoice> competitions,  ScheduleDefaults defaults)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleOptions() when $default != null:
return $default(_that.teamName,_that.timezone,_that.types,_that.competitions,_that.defaults);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScheduleOptions extends ScheduleOptions {
  const _ScheduleOptions({this.teamName = '', this.timezone = 'Europe/Amsterdam', final  List<ScheduleChoice> types = const <ScheduleChoice>[], final  List<ScheduleChoice> competitions = const <ScheduleChoice>[], this.defaults = const ScheduleDefaults()}): _types = types,_competitions = competitions,super._();
  factory _ScheduleOptions.fromJson(Map<String, dynamic> json) => _$ScheduleOptionsFromJson(json);

@override@JsonKey() final  String teamName;
@override@JsonKey() final  String timezone;
 final  List<ScheduleChoice> _types;
@override@JsonKey() List<ScheduleChoice> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}

 final  List<ScheduleChoice> _competitions;
@override@JsonKey() List<ScheduleChoice> get competitions {
  if (_competitions is EqualUnmodifiableListView) return _competitions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_competitions);
}

@override@JsonKey() final  ScheduleDefaults defaults;

/// Create a copy of ScheduleOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleOptionsCopyWith<_ScheduleOptions> get copyWith => __$ScheduleOptionsCopyWithImpl<_ScheduleOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduleOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleOptions&&(identical(other.teamName, teamName) || other.teamName == teamName)&&(identical(other.timezone, timezone) || other.timezone == timezone)&&const DeepCollectionEquality().equals(other._types, _types)&&const DeepCollectionEquality().equals(other._competitions, _competitions)&&(identical(other.defaults, defaults) || other.defaults == defaults));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamName,timezone,const DeepCollectionEquality().hash(_types),const DeepCollectionEquality().hash(_competitions),defaults);

@override
String toString() {
  return 'ScheduleOptions(teamName: $teamName, timezone: $timezone, types: $types, competitions: $competitions, defaults: $defaults)';
}


}

/// @nodoc
abstract mixin class _$ScheduleOptionsCopyWith<$Res> implements $ScheduleOptionsCopyWith<$Res> {
  factory _$ScheduleOptionsCopyWith(_ScheduleOptions value, $Res Function(_ScheduleOptions) _then) = __$ScheduleOptionsCopyWithImpl;
@override @useResult
$Res call({
 String teamName, String timezone, List<ScheduleChoice> types, List<ScheduleChoice> competitions, ScheduleDefaults defaults
});


@override $ScheduleDefaultsCopyWith<$Res> get defaults;

}
/// @nodoc
class __$ScheduleOptionsCopyWithImpl<$Res>
    implements _$ScheduleOptionsCopyWith<$Res> {
  __$ScheduleOptionsCopyWithImpl(this._self, this._then);

  final _ScheduleOptions _self;
  final $Res Function(_ScheduleOptions) _then;

/// Create a copy of ScheduleOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teamName = null,Object? timezone = null,Object? types = null,Object? competitions = null,Object? defaults = null,}) {
  return _then(_ScheduleOptions(
teamName: null == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String,timezone: null == timezone ? _self.timezone : timezone // ignore: cast_nullable_to_non_nullable
as String,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<ScheduleChoice>,competitions: null == competitions ? _self._competitions : competitions // ignore: cast_nullable_to_non_nullable
as List<ScheduleChoice>,defaults: null == defaults ? _self.defaults : defaults // ignore: cast_nullable_to_non_nullable
as ScheduleDefaults,
  ));
}

/// Create a copy of ScheduleOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScheduleDefaultsCopyWith<$Res> get defaults {
  
  return $ScheduleDefaultsCopyWith<$Res>(_self.defaults, (value) {
    return _then(_self.copyWith(defaults: value));
  });
}
}


/// @nodoc
mixin _$ScheduleEvent {

 int get id; String get type; String get title; DateTime get startsAt; DateTime? get endsAt; DateTime? get meetAt; String? get venue; String? get notes; bool? get isHome; String? get competition; String? get homeTeam; String? get awayTeam; DateTime? get cancelledAt; bool get canCancel; bool get spectatorsCanRsvp;
/// Create a copy of ScheduleEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleEventCopyWith<ScheduleEvent> get copyWith => _$ScheduleEventCopyWithImpl<ScheduleEvent>(this as ScheduleEvent, _$identity);

  /// Serializes this ScheduleEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.meetAt, meetAt) || other.meetAt == meetAt)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isHome, isHome) || other.isHome == isHome)&&(identical(other.competition, competition) || other.competition == competition)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.canCancel, canCancel) || other.canCancel == canCancel)&&(identical(other.spectatorsCanRsvp, spectatorsCanRsvp) || other.spectatorsCanRsvp == spectatorsCanRsvp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,startsAt,endsAt,meetAt,venue,notes,isHome,competition,homeTeam,awayTeam,cancelledAt,canCancel,spectatorsCanRsvp);

@override
String toString() {
  return 'ScheduleEvent(id: $id, type: $type, title: $title, startsAt: $startsAt, endsAt: $endsAt, meetAt: $meetAt, venue: $venue, notes: $notes, isHome: $isHome, competition: $competition, homeTeam: $homeTeam, awayTeam: $awayTeam, cancelledAt: $cancelledAt, canCancel: $canCancel, spectatorsCanRsvp: $spectatorsCanRsvp)';
}


}

/// @nodoc
abstract mixin class $ScheduleEventCopyWith<$Res>  {
  factory $ScheduleEventCopyWith(ScheduleEvent value, $Res Function(ScheduleEvent) _then) = _$ScheduleEventCopyWithImpl;
@useResult
$Res call({
 int id, String type, String title, DateTime startsAt, DateTime? endsAt, DateTime? meetAt, String? venue, String? notes, bool? isHome, String? competition, String? homeTeam, String? awayTeam, DateTime? cancelledAt, bool canCancel, bool spectatorsCanRsvp
});




}
/// @nodoc
class _$ScheduleEventCopyWithImpl<$Res>
    implements $ScheduleEventCopyWith<$Res> {
  _$ScheduleEventCopyWithImpl(this._self, this._then);

  final ScheduleEvent _self;
  final $Res Function(ScheduleEvent) _then;

/// Create a copy of ScheduleEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? startsAt = null,Object? endsAt = freezed,Object? meetAt = freezed,Object? venue = freezed,Object? notes = freezed,Object? isHome = freezed,Object? competition = freezed,Object? homeTeam = freezed,Object? awayTeam = freezed,Object? cancelledAt = freezed,Object? canCancel = null,Object? spectatorsCanRsvp = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,meetAt: freezed == meetAt ? _self.meetAt : meetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isHome: freezed == isHome ? _self.isHome : isHome // ignore: cast_nullable_to_non_nullable
as bool?,competition: freezed == competition ? _self.competition : competition // ignore: cast_nullable_to_non_nullable
as String?,homeTeam: freezed == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String?,awayTeam: freezed == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,canCancel: null == canCancel ? _self.canCancel : canCancel // ignore: cast_nullable_to_non_nullable
as bool,spectatorsCanRsvp: null == spectatorsCanRsvp ? _self.spectatorsCanRsvp : spectatorsCanRsvp // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleEvent].
extension ScheduleEventPatterns on ScheduleEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleEvent value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleEvent value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type,  String title,  DateTime startsAt,  DateTime? endsAt,  DateTime? meetAt,  String? venue,  String? notes,  bool? isHome,  String? competition,  String? homeTeam,  String? awayTeam,  DateTime? cancelledAt,  bool canCancel,  bool spectatorsCanRsvp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleEvent() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.endsAt,_that.meetAt,_that.venue,_that.notes,_that.isHome,_that.competition,_that.homeTeam,_that.awayTeam,_that.cancelledAt,_that.canCancel,_that.spectatorsCanRsvp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type,  String title,  DateTime startsAt,  DateTime? endsAt,  DateTime? meetAt,  String? venue,  String? notes,  bool? isHome,  String? competition,  String? homeTeam,  String? awayTeam,  DateTime? cancelledAt,  bool canCancel,  bool spectatorsCanRsvp)  $default,) {final _that = this;
switch (_that) {
case _ScheduleEvent():
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.endsAt,_that.meetAt,_that.venue,_that.notes,_that.isHome,_that.competition,_that.homeTeam,_that.awayTeam,_that.cancelledAt,_that.canCancel,_that.spectatorsCanRsvp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type,  String title,  DateTime startsAt,  DateTime? endsAt,  DateTime? meetAt,  String? venue,  String? notes,  bool? isHome,  String? competition,  String? homeTeam,  String? awayTeam,  DateTime? cancelledAt,  bool canCancel,  bool spectatorsCanRsvp)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleEvent() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.endsAt,_that.meetAt,_that.venue,_that.notes,_that.isHome,_that.competition,_that.homeTeam,_that.awayTeam,_that.cancelledAt,_that.canCancel,_that.spectatorsCanRsvp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ScheduleEvent extends ScheduleEvent {
  const _ScheduleEvent({required this.id, this.type = 'training', this.title = '', required this.startsAt, this.endsAt, this.meetAt, this.venue, this.notes, this.isHome, this.competition, this.homeTeam, this.awayTeam, this.cancelledAt, this.canCancel = false, this.spectatorsCanRsvp = false}): super._();
  factory _ScheduleEvent.fromJson(Map<String, dynamic> json) => _$ScheduleEventFromJson(json);

@override final  int id;
@override@JsonKey() final  String type;
@override@JsonKey() final  String title;
@override final  DateTime startsAt;
@override final  DateTime? endsAt;
@override final  DateTime? meetAt;
@override final  String? venue;
@override final  String? notes;
@override final  bool? isHome;
@override final  String? competition;
@override final  String? homeTeam;
@override final  String? awayTeam;
@override final  DateTime? cancelledAt;
@override@JsonKey() final  bool canCancel;
@override@JsonKey() final  bool spectatorsCanRsvp;

/// Create a copy of ScheduleEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleEventCopyWith<_ScheduleEvent> get copyWith => __$ScheduleEventCopyWithImpl<_ScheduleEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduleEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.meetAt, meetAt) || other.meetAt == meetAt)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.isHome, isHome) || other.isHome == isHome)&&(identical(other.competition, competition) || other.competition == competition)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.canCancel, canCancel) || other.canCancel == canCancel)&&(identical(other.spectatorsCanRsvp, spectatorsCanRsvp) || other.spectatorsCanRsvp == spectatorsCanRsvp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,startsAt,endsAt,meetAt,venue,notes,isHome,competition,homeTeam,awayTeam,cancelledAt,canCancel,spectatorsCanRsvp);

@override
String toString() {
  return 'ScheduleEvent(id: $id, type: $type, title: $title, startsAt: $startsAt, endsAt: $endsAt, meetAt: $meetAt, venue: $venue, notes: $notes, isHome: $isHome, competition: $competition, homeTeam: $homeTeam, awayTeam: $awayTeam, cancelledAt: $cancelledAt, canCancel: $canCancel, spectatorsCanRsvp: $spectatorsCanRsvp)';
}


}

/// @nodoc
abstract mixin class _$ScheduleEventCopyWith<$Res> implements $ScheduleEventCopyWith<$Res> {
  factory _$ScheduleEventCopyWith(_ScheduleEvent value, $Res Function(_ScheduleEvent) _then) = __$ScheduleEventCopyWithImpl;
@override @useResult
$Res call({
 int id, String type, String title, DateTime startsAt, DateTime? endsAt, DateTime? meetAt, String? venue, String? notes, bool? isHome, String? competition, String? homeTeam, String? awayTeam, DateTime? cancelledAt, bool canCancel, bool spectatorsCanRsvp
});




}
/// @nodoc
class __$ScheduleEventCopyWithImpl<$Res>
    implements _$ScheduleEventCopyWith<$Res> {
  __$ScheduleEventCopyWithImpl(this._self, this._then);

  final _ScheduleEvent _self;
  final $Res Function(_ScheduleEvent) _then;

/// Create a copy of ScheduleEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? startsAt = null,Object? endsAt = freezed,Object? meetAt = freezed,Object? venue = freezed,Object? notes = freezed,Object? isHome = freezed,Object? competition = freezed,Object? homeTeam = freezed,Object? awayTeam = freezed,Object? cancelledAt = freezed,Object? canCancel = null,Object? spectatorsCanRsvp = null,}) {
  return _then(_ScheduleEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,meetAt: freezed == meetAt ? _self.meetAt : meetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,isHome: freezed == isHome ? _self.isHome : isHome // ignore: cast_nullable_to_non_nullable
as bool?,competition: freezed == competition ? _self.competition : competition // ignore: cast_nullable_to_non_nullable
as String?,homeTeam: freezed == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String?,awayTeam: freezed == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,canCancel: null == canCancel ? _self.canCancel : canCancel // ignore: cast_nullable_to_non_nullable
as bool,spectatorsCanRsvp: null == spectatorsCanRsvp ? _self.spectatorsCanRsvp : spectatorsCanRsvp // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$ScheduleDraft {

 ScheduleType get type; DateTime get startsAt; DateTime? get endsAt; DateTime? get meetAt; String? get title; String? get venue; String? get notes; String? get homeTeam; String? get awayTeam; bool? get isHome; String? get competition; bool get spectatorsCanRsvp;/// Alleen bij aanmaken van een training: wekelijks t/m deze datum.
 DateTime? get recurUntil;/// Alleen bij wijzigen van een training: ook de volgende trainingen.
 bool get applyToFollowing;
/// Create a copy of ScheduleDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleDraftCopyWith<ScheduleDraft> get copyWith => _$ScheduleDraftCopyWithImpl<ScheduleDraft>(this as ScheduleDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScheduleDraft&&(identical(other.type, type) || other.type == type)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.meetAt, meetAt) || other.meetAt == meetAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.isHome, isHome) || other.isHome == isHome)&&(identical(other.competition, competition) || other.competition == competition)&&(identical(other.spectatorsCanRsvp, spectatorsCanRsvp) || other.spectatorsCanRsvp == spectatorsCanRsvp)&&(identical(other.recurUntil, recurUntil) || other.recurUntil == recurUntil)&&(identical(other.applyToFollowing, applyToFollowing) || other.applyToFollowing == applyToFollowing));
}


@override
int get hashCode => Object.hash(runtimeType,type,startsAt,endsAt,meetAt,title,venue,notes,homeTeam,awayTeam,isHome,competition,spectatorsCanRsvp,recurUntil,applyToFollowing);

@override
String toString() {
  return 'ScheduleDraft(type: $type, startsAt: $startsAt, endsAt: $endsAt, meetAt: $meetAt, title: $title, venue: $venue, notes: $notes, homeTeam: $homeTeam, awayTeam: $awayTeam, isHome: $isHome, competition: $competition, spectatorsCanRsvp: $spectatorsCanRsvp, recurUntil: $recurUntil, applyToFollowing: $applyToFollowing)';
}


}

/// @nodoc
abstract mixin class $ScheduleDraftCopyWith<$Res>  {
  factory $ScheduleDraftCopyWith(ScheduleDraft value, $Res Function(ScheduleDraft) _then) = _$ScheduleDraftCopyWithImpl;
@useResult
$Res call({
 ScheduleType type, DateTime startsAt, DateTime? endsAt, DateTime? meetAt, String? title, String? venue, String? notes, String? homeTeam, String? awayTeam, bool? isHome, String? competition, bool spectatorsCanRsvp, DateTime? recurUntil, bool applyToFollowing
});




}
/// @nodoc
class _$ScheduleDraftCopyWithImpl<$Res>
    implements $ScheduleDraftCopyWith<$Res> {
  _$ScheduleDraftCopyWithImpl(this._self, this._then);

  final ScheduleDraft _self;
  final $Res Function(ScheduleDraft) _then;

/// Create a copy of ScheduleDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? startsAt = null,Object? endsAt = freezed,Object? meetAt = freezed,Object? title = freezed,Object? venue = freezed,Object? notes = freezed,Object? homeTeam = freezed,Object? awayTeam = freezed,Object? isHome = freezed,Object? competition = freezed,Object? spectatorsCanRsvp = null,Object? recurUntil = freezed,Object? applyToFollowing = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ScheduleType,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,meetAt: freezed == meetAt ? _self.meetAt : meetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,homeTeam: freezed == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String?,awayTeam: freezed == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String?,isHome: freezed == isHome ? _self.isHome : isHome // ignore: cast_nullable_to_non_nullable
as bool?,competition: freezed == competition ? _self.competition : competition // ignore: cast_nullable_to_non_nullable
as String?,spectatorsCanRsvp: null == spectatorsCanRsvp ? _self.spectatorsCanRsvp : spectatorsCanRsvp // ignore: cast_nullable_to_non_nullable
as bool,recurUntil: freezed == recurUntil ? _self.recurUntil : recurUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,applyToFollowing: null == applyToFollowing ? _self.applyToFollowing : applyToFollowing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ScheduleDraft].
extension ScheduleDraftPatterns on ScheduleDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ScheduleDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ScheduleDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ScheduleDraft value)  $default,){
final _that = this;
switch (_that) {
case _ScheduleDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ScheduleDraft value)?  $default,){
final _that = this;
switch (_that) {
case _ScheduleDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ScheduleType type,  DateTime startsAt,  DateTime? endsAt,  DateTime? meetAt,  String? title,  String? venue,  String? notes,  String? homeTeam,  String? awayTeam,  bool? isHome,  String? competition,  bool spectatorsCanRsvp,  DateTime? recurUntil,  bool applyToFollowing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ScheduleDraft() when $default != null:
return $default(_that.type,_that.startsAt,_that.endsAt,_that.meetAt,_that.title,_that.venue,_that.notes,_that.homeTeam,_that.awayTeam,_that.isHome,_that.competition,_that.spectatorsCanRsvp,_that.recurUntil,_that.applyToFollowing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ScheduleType type,  DateTime startsAt,  DateTime? endsAt,  DateTime? meetAt,  String? title,  String? venue,  String? notes,  String? homeTeam,  String? awayTeam,  bool? isHome,  String? competition,  bool spectatorsCanRsvp,  DateTime? recurUntil,  bool applyToFollowing)  $default,) {final _that = this;
switch (_that) {
case _ScheduleDraft():
return $default(_that.type,_that.startsAt,_that.endsAt,_that.meetAt,_that.title,_that.venue,_that.notes,_that.homeTeam,_that.awayTeam,_that.isHome,_that.competition,_that.spectatorsCanRsvp,_that.recurUntil,_that.applyToFollowing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ScheduleType type,  DateTime startsAt,  DateTime? endsAt,  DateTime? meetAt,  String? title,  String? venue,  String? notes,  String? homeTeam,  String? awayTeam,  bool? isHome,  String? competition,  bool spectatorsCanRsvp,  DateTime? recurUntil,  bool applyToFollowing)?  $default,) {final _that = this;
switch (_that) {
case _ScheduleDraft() when $default != null:
return $default(_that.type,_that.startsAt,_that.endsAt,_that.meetAt,_that.title,_that.venue,_that.notes,_that.homeTeam,_that.awayTeam,_that.isHome,_that.competition,_that.spectatorsCanRsvp,_that.recurUntil,_that.applyToFollowing);case _:
  return null;

}
}

}

/// @nodoc


class _ScheduleDraft extends ScheduleDraft {
  const _ScheduleDraft({required this.type, required this.startsAt, this.endsAt, this.meetAt, this.title, this.venue, this.notes, this.homeTeam, this.awayTeam, this.isHome, this.competition, this.spectatorsCanRsvp = false, this.recurUntil, this.applyToFollowing = false}): super._();
  

@override final  ScheduleType type;
@override final  DateTime startsAt;
@override final  DateTime? endsAt;
@override final  DateTime? meetAt;
@override final  String? title;
@override final  String? venue;
@override final  String? notes;
@override final  String? homeTeam;
@override final  String? awayTeam;
@override final  bool? isHome;
@override final  String? competition;
@override@JsonKey() final  bool spectatorsCanRsvp;
/// Alleen bij aanmaken van een training: wekelijks t/m deze datum.
@override final  DateTime? recurUntil;
/// Alleen bij wijzigen van een training: ook de volgende trainingen.
@override@JsonKey() final  bool applyToFollowing;

/// Create a copy of ScheduleDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleDraftCopyWith<_ScheduleDraft> get copyWith => __$ScheduleDraftCopyWithImpl<_ScheduleDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ScheduleDraft&&(identical(other.type, type) || other.type == type)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.meetAt, meetAt) || other.meetAt == meetAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.isHome, isHome) || other.isHome == isHome)&&(identical(other.competition, competition) || other.competition == competition)&&(identical(other.spectatorsCanRsvp, spectatorsCanRsvp) || other.spectatorsCanRsvp == spectatorsCanRsvp)&&(identical(other.recurUntil, recurUntil) || other.recurUntil == recurUntil)&&(identical(other.applyToFollowing, applyToFollowing) || other.applyToFollowing == applyToFollowing));
}


@override
int get hashCode => Object.hash(runtimeType,type,startsAt,endsAt,meetAt,title,venue,notes,homeTeam,awayTeam,isHome,competition,spectatorsCanRsvp,recurUntil,applyToFollowing);

@override
String toString() {
  return 'ScheduleDraft(type: $type, startsAt: $startsAt, endsAt: $endsAt, meetAt: $meetAt, title: $title, venue: $venue, notes: $notes, homeTeam: $homeTeam, awayTeam: $awayTeam, isHome: $isHome, competition: $competition, spectatorsCanRsvp: $spectatorsCanRsvp, recurUntil: $recurUntil, applyToFollowing: $applyToFollowing)';
}


}

/// @nodoc
abstract mixin class _$ScheduleDraftCopyWith<$Res> implements $ScheduleDraftCopyWith<$Res> {
  factory _$ScheduleDraftCopyWith(_ScheduleDraft value, $Res Function(_ScheduleDraft) _then) = __$ScheduleDraftCopyWithImpl;
@override @useResult
$Res call({
 ScheduleType type, DateTime startsAt, DateTime? endsAt, DateTime? meetAt, String? title, String? venue, String? notes, String? homeTeam, String? awayTeam, bool? isHome, String? competition, bool spectatorsCanRsvp, DateTime? recurUntil, bool applyToFollowing
});




}
/// @nodoc
class __$ScheduleDraftCopyWithImpl<$Res>
    implements _$ScheduleDraftCopyWith<$Res> {
  __$ScheduleDraftCopyWithImpl(this._self, this._then);

  final _ScheduleDraft _self;
  final $Res Function(_ScheduleDraft) _then;

/// Create a copy of ScheduleDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? startsAt = null,Object? endsAt = freezed,Object? meetAt = freezed,Object? title = freezed,Object? venue = freezed,Object? notes = freezed,Object? homeTeam = freezed,Object? awayTeam = freezed,Object? isHome = freezed,Object? competition = freezed,Object? spectatorsCanRsvp = null,Object? recurUntil = freezed,Object? applyToFollowing = null,}) {
  return _then(_ScheduleDraft(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ScheduleType,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,meetAt: freezed == meetAt ? _self.meetAt : meetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,homeTeam: freezed == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String?,awayTeam: freezed == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String?,isHome: freezed == isHome ? _self.isHome : isHome // ignore: cast_nullable_to_non_nullable
as bool?,competition: freezed == competition ? _self.competition : competition // ignore: cast_nullable_to_non_nullable
as String?,spectatorsCanRsvp: null == spectatorsCanRsvp ? _self.spectatorsCanRsvp : spectatorsCanRsvp // ignore: cast_nullable_to_non_nullable
as bool,recurUntil: freezed == recurUntil ? _self.recurUntil : recurUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,applyToFollowing: null == applyToFollowing ? _self.applyToFollowing : applyToFollowing // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
