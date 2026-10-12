// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stats_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SeasonOption {

 int get id; String get label; bool get isActive;
/// Create a copy of SeasonOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeasonOptionCopyWith<SeasonOption> get copyWith => _$SeasonOptionCopyWithImpl<SeasonOption>(this as SeasonOption, _$identity);

  /// Serializes this SeasonOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeasonOption&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,isActive);

@override
String toString() {
  return 'SeasonOption(id: $id, label: $label, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $SeasonOptionCopyWith<$Res>  {
  factory $SeasonOptionCopyWith(SeasonOption value, $Res Function(SeasonOption) _then) = _$SeasonOptionCopyWithImpl;
@useResult
$Res call({
 int id, String label, bool isActive
});




}
/// @nodoc
class _$SeasonOptionCopyWithImpl<$Res>
    implements $SeasonOptionCopyWith<$Res> {
  _$SeasonOptionCopyWithImpl(this._self, this._then);

  final SeasonOption _self;
  final $Res Function(SeasonOption) _then;

/// Create a copy of SeasonOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SeasonOption].
extension SeasonOptionPatterns on SeasonOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeasonOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeasonOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeasonOption value)  $default,){
final _that = this;
switch (_that) {
case _SeasonOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeasonOption value)?  $default,){
final _that = this;
switch (_that) {
case _SeasonOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String label,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeasonOption() when $default != null:
return $default(_that.id,_that.label,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String label,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _SeasonOption():
return $default(_that.id,_that.label,_that.isActive);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String label,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _SeasonOption() when $default != null:
return $default(_that.id,_that.label,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeasonOption implements SeasonOption {
  const _SeasonOption({required this.id, this.label = '', this.isActive = false});
  factory _SeasonOption.fromJson(Map<String, dynamic> json) => _$SeasonOptionFromJson(json);

@override final  int id;
@override@JsonKey() final  String label;
@override@JsonKey() final  bool isActive;

/// Create a copy of SeasonOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeasonOptionCopyWith<_SeasonOption> get copyWith => __$SeasonOptionCopyWithImpl<_SeasonOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeasonOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeasonOption&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,isActive);

@override
String toString() {
  return 'SeasonOption(id: $id, label: $label, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$SeasonOptionCopyWith<$Res> implements $SeasonOptionCopyWith<$Res> {
  factory _$SeasonOptionCopyWith(_SeasonOption value, $Res Function(_SeasonOption) _then) = __$SeasonOptionCopyWithImpl;
@override @useResult
$Res call({
 int id, String label, bool isActive
});




}
/// @nodoc
class __$SeasonOptionCopyWithImpl<$Res>
    implements _$SeasonOptionCopyWith<$Res> {
  __$SeasonOptionCopyWithImpl(this._self, this._then);

  final _SeasonOption _self;
  final $Res Function(_SeasonOption) _then;

/// Create a copy of SeasonOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? isActive = null,}) {
  return _then(_SeasonOption(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$StatsTitle {

 String get key; String get icon; String get label;
/// Create a copy of StatsTitle
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatsTitleCopyWith<StatsTitle> get copyWith => _$StatsTitleCopyWithImpl<StatsTitle>(this as StatsTitle, _$identity);

  /// Serializes this StatsTitle to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatsTitle&&(identical(other.key, key) || other.key == key)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,icon,label);

@override
String toString() {
  return 'StatsTitle(key: $key, icon: $icon, label: $label)';
}


}

/// @nodoc
abstract mixin class $StatsTitleCopyWith<$Res>  {
  factory $StatsTitleCopyWith(StatsTitle value, $Res Function(StatsTitle) _then) = _$StatsTitleCopyWithImpl;
@useResult
$Res call({
 String key, String icon, String label
});




}
/// @nodoc
class _$StatsTitleCopyWithImpl<$Res>
    implements $StatsTitleCopyWith<$Res> {
  _$StatsTitleCopyWithImpl(this._self, this._then);

  final StatsTitle _self;
  final $Res Function(StatsTitle) _then;

/// Create a copy of StatsTitle
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


/// Adds pattern-matching-related methods to [StatsTitle].
extension StatsTitlePatterns on StatsTitle {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatsTitle value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatsTitle() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatsTitle value)  $default,){
final _that = this;
switch (_that) {
case _StatsTitle():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatsTitle value)?  $default,){
final _that = this;
switch (_that) {
case _StatsTitle() when $default != null:
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
case _StatsTitle() when $default != null:
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
case _StatsTitle():
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
case _StatsTitle() when $default != null:
return $default(_that.key,_that.icon,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatsTitle implements StatsTitle {
  const _StatsTitle({this.key = '', this.icon = '', this.label = ''});
  factory _StatsTitle.fromJson(Map<String, dynamic> json) => _$StatsTitleFromJson(json);

@override@JsonKey() final  String key;
@override@JsonKey() final  String icon;
@override@JsonKey() final  String label;

/// Create a copy of StatsTitle
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatsTitleCopyWith<_StatsTitle> get copyWith => __$StatsTitleCopyWithImpl<_StatsTitle>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatsTitleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatsTitle&&(identical(other.key, key) || other.key == key)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,icon,label);

@override
String toString() {
  return 'StatsTitle(key: $key, icon: $icon, label: $label)';
}


}

/// @nodoc
abstract mixin class _$StatsTitleCopyWith<$Res> implements $StatsTitleCopyWith<$Res> {
  factory _$StatsTitleCopyWith(_StatsTitle value, $Res Function(_StatsTitle) _then) = __$StatsTitleCopyWithImpl;
@override @useResult
$Res call({
 String key, String icon, String label
});




}
/// @nodoc
class __$StatsTitleCopyWithImpl<$Res>
    implements _$StatsTitleCopyWith<$Res> {
  __$StatsTitleCopyWithImpl(this._self, this._then);

  final _StatsTitle _self;
  final $Res Function(_StatsTitle) _then;

/// Create a copy of StatsTitle
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? icon = null,Object? label = null,}) {
  return _then(_StatsTitle(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$StatsRow {

@asInt int get playerId; String get name;@asIntOrNull int? get shirtNumber; String? get position; String? get avatarUrl;@asDouble double get attendanceRate;@asDouble double get attendanceMatchRate;@asDouble double get attendanceTrainingRate;@asInt int get minutes;@asInt int get goals;@asInt int get assists;@asInt int get yellow;@asInt int get red;@asInt int get matchesPlayed;@asInt int get flagMinutes;@asInt int get flagShifts; List<StatsTitle> get titles;@asInt int get trainingPoints;
/// Create a copy of StatsRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatsRowCopyWith<StatsRow> get copyWith => _$StatsRowCopyWithImpl<StatsRow>(this as StatsRow, _$identity);

  /// Serializes this StatsRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatsRow&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.position, position) || other.position == position)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.attendanceRate, attendanceRate) || other.attendanceRate == attendanceRate)&&(identical(other.attendanceMatchRate, attendanceMatchRate) || other.attendanceMatchRate == attendanceMatchRate)&&(identical(other.attendanceTrainingRate, attendanceTrainingRate) || other.attendanceTrainingRate == attendanceTrainingRate)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.goals, goals) || other.goals == goals)&&(identical(other.assists, assists) || other.assists == assists)&&(identical(other.yellow, yellow) || other.yellow == yellow)&&(identical(other.red, red) || other.red == red)&&(identical(other.matchesPlayed, matchesPlayed) || other.matchesPlayed == matchesPlayed)&&(identical(other.flagMinutes, flagMinutes) || other.flagMinutes == flagMinutes)&&(identical(other.flagShifts, flagShifts) || other.flagShifts == flagShifts)&&const DeepCollectionEquality().equals(other.titles, titles)&&(identical(other.trainingPoints, trainingPoints) || other.trainingPoints == trainingPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,name,shirtNumber,position,avatarUrl,attendanceRate,attendanceMatchRate,attendanceTrainingRate,minutes,goals,assists,yellow,red,matchesPlayed,flagMinutes,flagShifts,const DeepCollectionEquality().hash(titles),trainingPoints);

@override
String toString() {
  return 'StatsRow(playerId: $playerId, name: $name, shirtNumber: $shirtNumber, position: $position, avatarUrl: $avatarUrl, attendanceRate: $attendanceRate, attendanceMatchRate: $attendanceMatchRate, attendanceTrainingRate: $attendanceTrainingRate, minutes: $minutes, goals: $goals, assists: $assists, yellow: $yellow, red: $red, matchesPlayed: $matchesPlayed, flagMinutes: $flagMinutes, flagShifts: $flagShifts, titles: $titles, trainingPoints: $trainingPoints)';
}


}

/// @nodoc
abstract mixin class $StatsRowCopyWith<$Res>  {
  factory $StatsRowCopyWith(StatsRow value, $Res Function(StatsRow) _then) = _$StatsRowCopyWithImpl;
@useResult
$Res call({
@asInt int playerId, String name,@asIntOrNull int? shirtNumber, String? position, String? avatarUrl,@asDouble double attendanceRate,@asDouble double attendanceMatchRate,@asDouble double attendanceTrainingRate,@asInt int minutes,@asInt int goals,@asInt int assists,@asInt int yellow,@asInt int red,@asInt int matchesPlayed,@asInt int flagMinutes,@asInt int flagShifts, List<StatsTitle> titles,@asInt int trainingPoints
});




}
/// @nodoc
class _$StatsRowCopyWithImpl<$Res>
    implements $StatsRowCopyWith<$Res> {
  _$StatsRowCopyWithImpl(this._self, this._then);

  final StatsRow _self;
  final $Res Function(StatsRow) _then;

/// Create a copy of StatsRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? name = null,Object? shirtNumber = freezed,Object? position = freezed,Object? avatarUrl = freezed,Object? attendanceRate = null,Object? attendanceMatchRate = null,Object? attendanceTrainingRate = null,Object? minutes = null,Object? goals = null,Object? assists = null,Object? yellow = null,Object? red = null,Object? matchesPlayed = null,Object? flagMinutes = null,Object? flagShifts = null,Object? titles = null,Object? trainingPoints = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,attendanceRate: null == attendanceRate ? _self.attendanceRate : attendanceRate // ignore: cast_nullable_to_non_nullable
as double,attendanceMatchRate: null == attendanceMatchRate ? _self.attendanceMatchRate : attendanceMatchRate // ignore: cast_nullable_to_non_nullable
as double,attendanceTrainingRate: null == attendanceTrainingRate ? _self.attendanceTrainingRate : attendanceTrainingRate // ignore: cast_nullable_to_non_nullable
as double,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as int,assists: null == assists ? _self.assists : assists // ignore: cast_nullable_to_non_nullable
as int,yellow: null == yellow ? _self.yellow : yellow // ignore: cast_nullable_to_non_nullable
as int,red: null == red ? _self.red : red // ignore: cast_nullable_to_non_nullable
as int,matchesPlayed: null == matchesPlayed ? _self.matchesPlayed : matchesPlayed // ignore: cast_nullable_to_non_nullable
as int,flagMinutes: null == flagMinutes ? _self.flagMinutes : flagMinutes // ignore: cast_nullable_to_non_nullable
as int,flagShifts: null == flagShifts ? _self.flagShifts : flagShifts // ignore: cast_nullable_to_non_nullable
as int,titles: null == titles ? _self.titles : titles // ignore: cast_nullable_to_non_nullable
as List<StatsTitle>,trainingPoints: null == trainingPoints ? _self.trainingPoints : trainingPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StatsRow].
extension StatsRowPatterns on StatsRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatsRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatsRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatsRow value)  $default,){
final _that = this;
switch (_that) {
case _StatsRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatsRow value)?  $default,){
final _that = this;
switch (_that) {
case _StatsRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@asInt  int playerId,  String name, @asIntOrNull  int? shirtNumber,  String? position,  String? avatarUrl, @asDouble  double attendanceRate, @asDouble  double attendanceMatchRate, @asDouble  double attendanceTrainingRate, @asInt  int minutes, @asInt  int goals, @asInt  int assists, @asInt  int yellow, @asInt  int red, @asInt  int matchesPlayed, @asInt  int flagMinutes, @asInt  int flagShifts,  List<StatsTitle> titles, @asInt  int trainingPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatsRow() when $default != null:
return $default(_that.playerId,_that.name,_that.shirtNumber,_that.position,_that.avatarUrl,_that.attendanceRate,_that.attendanceMatchRate,_that.attendanceTrainingRate,_that.minutes,_that.goals,_that.assists,_that.yellow,_that.red,_that.matchesPlayed,_that.flagMinutes,_that.flagShifts,_that.titles,_that.trainingPoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@asInt  int playerId,  String name, @asIntOrNull  int? shirtNumber,  String? position,  String? avatarUrl, @asDouble  double attendanceRate, @asDouble  double attendanceMatchRate, @asDouble  double attendanceTrainingRate, @asInt  int minutes, @asInt  int goals, @asInt  int assists, @asInt  int yellow, @asInt  int red, @asInt  int matchesPlayed, @asInt  int flagMinutes, @asInt  int flagShifts,  List<StatsTitle> titles, @asInt  int trainingPoints)  $default,) {final _that = this;
switch (_that) {
case _StatsRow():
return $default(_that.playerId,_that.name,_that.shirtNumber,_that.position,_that.avatarUrl,_that.attendanceRate,_that.attendanceMatchRate,_that.attendanceTrainingRate,_that.minutes,_that.goals,_that.assists,_that.yellow,_that.red,_that.matchesPlayed,_that.flagMinutes,_that.flagShifts,_that.titles,_that.trainingPoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@asInt  int playerId,  String name, @asIntOrNull  int? shirtNumber,  String? position,  String? avatarUrl, @asDouble  double attendanceRate, @asDouble  double attendanceMatchRate, @asDouble  double attendanceTrainingRate, @asInt  int minutes, @asInt  int goals, @asInt  int assists, @asInt  int yellow, @asInt  int red, @asInt  int matchesPlayed, @asInt  int flagMinutes, @asInt  int flagShifts,  List<StatsTitle> titles, @asInt  int trainingPoints)?  $default,) {final _that = this;
switch (_that) {
case _StatsRow() when $default != null:
return $default(_that.playerId,_that.name,_that.shirtNumber,_that.position,_that.avatarUrl,_that.attendanceRate,_that.attendanceMatchRate,_that.attendanceTrainingRate,_that.minutes,_that.goals,_that.assists,_that.yellow,_that.red,_that.matchesPlayed,_that.flagMinutes,_that.flagShifts,_that.titles,_that.trainingPoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatsRow implements StatsRow {
  const _StatsRow({@asInt required this.playerId, this.name = '', @asIntOrNull this.shirtNumber, this.position, this.avatarUrl, @asDouble this.attendanceRate = 0, @asDouble this.attendanceMatchRate = 0, @asDouble this.attendanceTrainingRate = 0, @asInt this.minutes = 0, @asInt this.goals = 0, @asInt this.assists = 0, @asInt this.yellow = 0, @asInt this.red = 0, @asInt this.matchesPlayed = 0, @asInt this.flagMinutes = 0, @asInt this.flagShifts = 0, final  List<StatsTitle> titles = const <StatsTitle>[], @asInt this.trainingPoints = 0}): _titles = titles;
  factory _StatsRow.fromJson(Map<String, dynamic> json) => _$StatsRowFromJson(json);

@override@asInt final  int playerId;
@override@JsonKey() final  String name;
@override@asIntOrNull final  int? shirtNumber;
@override final  String? position;
@override final  String? avatarUrl;
@override@asDouble final  double attendanceRate;
@override@asDouble final  double attendanceMatchRate;
@override@asDouble final  double attendanceTrainingRate;
@override@asInt final  int minutes;
@override@asInt final  int goals;
@override@asInt final  int assists;
@override@asInt final  int yellow;
@override@asInt final  int red;
@override@asInt final  int matchesPlayed;
@override@asInt final  int flagMinutes;
@override@asInt final  int flagShifts;
 final  List<StatsTitle> _titles;
@override@JsonKey() List<StatsTitle> get titles {
  if (_titles is EqualUnmodifiableListView) return _titles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_titles);
}

@override@asInt final  int trainingPoints;

/// Create a copy of StatsRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatsRowCopyWith<_StatsRow> get copyWith => __$StatsRowCopyWithImpl<_StatsRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatsRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatsRow&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.position, position) || other.position == position)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.attendanceRate, attendanceRate) || other.attendanceRate == attendanceRate)&&(identical(other.attendanceMatchRate, attendanceMatchRate) || other.attendanceMatchRate == attendanceMatchRate)&&(identical(other.attendanceTrainingRate, attendanceTrainingRate) || other.attendanceTrainingRate == attendanceTrainingRate)&&(identical(other.minutes, minutes) || other.minutes == minutes)&&(identical(other.goals, goals) || other.goals == goals)&&(identical(other.assists, assists) || other.assists == assists)&&(identical(other.yellow, yellow) || other.yellow == yellow)&&(identical(other.red, red) || other.red == red)&&(identical(other.matchesPlayed, matchesPlayed) || other.matchesPlayed == matchesPlayed)&&(identical(other.flagMinutes, flagMinutes) || other.flagMinutes == flagMinutes)&&(identical(other.flagShifts, flagShifts) || other.flagShifts == flagShifts)&&const DeepCollectionEquality().equals(other._titles, _titles)&&(identical(other.trainingPoints, trainingPoints) || other.trainingPoints == trainingPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,name,shirtNumber,position,avatarUrl,attendanceRate,attendanceMatchRate,attendanceTrainingRate,minutes,goals,assists,yellow,red,matchesPlayed,flagMinutes,flagShifts,const DeepCollectionEquality().hash(_titles),trainingPoints);

@override
String toString() {
  return 'StatsRow(playerId: $playerId, name: $name, shirtNumber: $shirtNumber, position: $position, avatarUrl: $avatarUrl, attendanceRate: $attendanceRate, attendanceMatchRate: $attendanceMatchRate, attendanceTrainingRate: $attendanceTrainingRate, minutes: $minutes, goals: $goals, assists: $assists, yellow: $yellow, red: $red, matchesPlayed: $matchesPlayed, flagMinutes: $flagMinutes, flagShifts: $flagShifts, titles: $titles, trainingPoints: $trainingPoints)';
}


}

/// @nodoc
abstract mixin class _$StatsRowCopyWith<$Res> implements $StatsRowCopyWith<$Res> {
  factory _$StatsRowCopyWith(_StatsRow value, $Res Function(_StatsRow) _then) = __$StatsRowCopyWithImpl;
@override @useResult
$Res call({
@asInt int playerId, String name,@asIntOrNull int? shirtNumber, String? position, String? avatarUrl,@asDouble double attendanceRate,@asDouble double attendanceMatchRate,@asDouble double attendanceTrainingRate,@asInt int minutes,@asInt int goals,@asInt int assists,@asInt int yellow,@asInt int red,@asInt int matchesPlayed,@asInt int flagMinutes,@asInt int flagShifts, List<StatsTitle> titles,@asInt int trainingPoints
});




}
/// @nodoc
class __$StatsRowCopyWithImpl<$Res>
    implements _$StatsRowCopyWith<$Res> {
  __$StatsRowCopyWithImpl(this._self, this._then);

  final _StatsRow _self;
  final $Res Function(_StatsRow) _then;

/// Create a copy of StatsRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? name = null,Object? shirtNumber = freezed,Object? position = freezed,Object? avatarUrl = freezed,Object? attendanceRate = null,Object? attendanceMatchRate = null,Object? attendanceTrainingRate = null,Object? minutes = null,Object? goals = null,Object? assists = null,Object? yellow = null,Object? red = null,Object? matchesPlayed = null,Object? flagMinutes = null,Object? flagShifts = null,Object? titles = null,Object? trainingPoints = null,}) {
  return _then(_StatsRow(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,attendanceRate: null == attendanceRate ? _self.attendanceRate : attendanceRate // ignore: cast_nullable_to_non_nullable
as double,attendanceMatchRate: null == attendanceMatchRate ? _self.attendanceMatchRate : attendanceMatchRate // ignore: cast_nullable_to_non_nullable
as double,attendanceTrainingRate: null == attendanceTrainingRate ? _self.attendanceTrainingRate : attendanceTrainingRate // ignore: cast_nullable_to_non_nullable
as double,minutes: null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as int,assists: null == assists ? _self.assists : assists // ignore: cast_nullable_to_non_nullable
as int,yellow: null == yellow ? _self.yellow : yellow // ignore: cast_nullable_to_non_nullable
as int,red: null == red ? _self.red : red // ignore: cast_nullable_to_non_nullable
as int,matchesPlayed: null == matchesPlayed ? _self.matchesPlayed : matchesPlayed // ignore: cast_nullable_to_non_nullable
as int,flagMinutes: null == flagMinutes ? _self.flagMinutes : flagMinutes // ignore: cast_nullable_to_non_nullable
as int,flagShifts: null == flagShifts ? _self.flagShifts : flagShifts // ignore: cast_nullable_to_non_nullable
as int,titles: null == titles ? _self._titles : titles // ignore: cast_nullable_to_non_nullable
as List<StatsTitle>,trainingPoints: null == trainingPoints ? _self.trainingPoints : trainingPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TeamStats {

/// `season`, `5` of `10` (wat de server werkelijk gebruikte).
@asStringOrNull String? get window;@asIntOrNull int? get seasonId; List<SeasonOption> get seasons;@asIntOrNull int? get myPlayerId; List<StatsRow> get rows;
/// Create a copy of TeamStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamStatsCopyWith<TeamStats> get copyWith => _$TeamStatsCopyWithImpl<TeamStats>(this as TeamStats, _$identity);

  /// Serializes this TeamStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamStats&&(identical(other.window, window) || other.window == window)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&const DeepCollectionEquality().equals(other.seasons, seasons)&&(identical(other.myPlayerId, myPlayerId) || other.myPlayerId == myPlayerId)&&const DeepCollectionEquality().equals(other.rows, rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,window,seasonId,const DeepCollectionEquality().hash(seasons),myPlayerId,const DeepCollectionEquality().hash(rows));

@override
String toString() {
  return 'TeamStats(window: $window, seasonId: $seasonId, seasons: $seasons, myPlayerId: $myPlayerId, rows: $rows)';
}


}

/// @nodoc
abstract mixin class $TeamStatsCopyWith<$Res>  {
  factory $TeamStatsCopyWith(TeamStats value, $Res Function(TeamStats) _then) = _$TeamStatsCopyWithImpl;
@useResult
$Res call({
@asStringOrNull String? window,@asIntOrNull int? seasonId, List<SeasonOption> seasons,@asIntOrNull int? myPlayerId, List<StatsRow> rows
});




}
/// @nodoc
class _$TeamStatsCopyWithImpl<$Res>
    implements $TeamStatsCopyWith<$Res> {
  _$TeamStatsCopyWithImpl(this._self, this._then);

  final TeamStats _self;
  final $Res Function(TeamStats) _then;

/// Create a copy of TeamStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? window = freezed,Object? seasonId = freezed,Object? seasons = null,Object? myPlayerId = freezed,Object? rows = null,}) {
  return _then(_self.copyWith(
window: freezed == window ? _self.window : window // ignore: cast_nullable_to_non_nullable
as String?,seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as int?,seasons: null == seasons ? _self.seasons : seasons // ignore: cast_nullable_to_non_nullable
as List<SeasonOption>,myPlayerId: freezed == myPlayerId ? _self.myPlayerId : myPlayerId // ignore: cast_nullable_to_non_nullable
as int?,rows: null == rows ? _self.rows : rows // ignore: cast_nullable_to_non_nullable
as List<StatsRow>,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamStats].
extension TeamStatsPatterns on TeamStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamStats value)  $default,){
final _that = this;
switch (_that) {
case _TeamStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamStats value)?  $default,){
final _that = this;
switch (_that) {
case _TeamStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@asStringOrNull  String? window, @asIntOrNull  int? seasonId,  List<SeasonOption> seasons, @asIntOrNull  int? myPlayerId,  List<StatsRow> rows)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamStats() when $default != null:
return $default(_that.window,_that.seasonId,_that.seasons,_that.myPlayerId,_that.rows);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@asStringOrNull  String? window, @asIntOrNull  int? seasonId,  List<SeasonOption> seasons, @asIntOrNull  int? myPlayerId,  List<StatsRow> rows)  $default,) {final _that = this;
switch (_that) {
case _TeamStats():
return $default(_that.window,_that.seasonId,_that.seasons,_that.myPlayerId,_that.rows);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@asStringOrNull  String? window, @asIntOrNull  int? seasonId,  List<SeasonOption> seasons, @asIntOrNull  int? myPlayerId,  List<StatsRow> rows)?  $default,) {final _that = this;
switch (_that) {
case _TeamStats() when $default != null:
return $default(_that.window,_that.seasonId,_that.seasons,_that.myPlayerId,_that.rows);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamStats extends TeamStats {
  const _TeamStats({@asStringOrNull this.window, @asIntOrNull this.seasonId, final  List<SeasonOption> seasons = const <SeasonOption>[], @asIntOrNull this.myPlayerId, final  List<StatsRow> rows = const <StatsRow>[]}): _seasons = seasons,_rows = rows,super._();
  factory _TeamStats.fromJson(Map<String, dynamic> json) => _$TeamStatsFromJson(json);

/// `season`, `5` of `10` (wat de server werkelijk gebruikte).
@override@asStringOrNull final  String? window;
@override@asIntOrNull final  int? seasonId;
 final  List<SeasonOption> _seasons;
@override@JsonKey() List<SeasonOption> get seasons {
  if (_seasons is EqualUnmodifiableListView) return _seasons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_seasons);
}

@override@asIntOrNull final  int? myPlayerId;
 final  List<StatsRow> _rows;
@override@JsonKey() List<StatsRow> get rows {
  if (_rows is EqualUnmodifiableListView) return _rows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rows);
}


/// Create a copy of TeamStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamStatsCopyWith<_TeamStats> get copyWith => __$TeamStatsCopyWithImpl<_TeamStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamStats&&(identical(other.window, window) || other.window == window)&&(identical(other.seasonId, seasonId) || other.seasonId == seasonId)&&const DeepCollectionEquality().equals(other._seasons, _seasons)&&(identical(other.myPlayerId, myPlayerId) || other.myPlayerId == myPlayerId)&&const DeepCollectionEquality().equals(other._rows, _rows));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,window,seasonId,const DeepCollectionEquality().hash(_seasons),myPlayerId,const DeepCollectionEquality().hash(_rows));

@override
String toString() {
  return 'TeamStats(window: $window, seasonId: $seasonId, seasons: $seasons, myPlayerId: $myPlayerId, rows: $rows)';
}


}

/// @nodoc
abstract mixin class _$TeamStatsCopyWith<$Res> implements $TeamStatsCopyWith<$Res> {
  factory _$TeamStatsCopyWith(_TeamStats value, $Res Function(_TeamStats) _then) = __$TeamStatsCopyWithImpl;
@override @useResult
$Res call({
@asStringOrNull String? window,@asIntOrNull int? seasonId, List<SeasonOption> seasons,@asIntOrNull int? myPlayerId, List<StatsRow> rows
});




}
/// @nodoc
class __$TeamStatsCopyWithImpl<$Res>
    implements _$TeamStatsCopyWith<$Res> {
  __$TeamStatsCopyWithImpl(this._self, this._then);

  final _TeamStats _self;
  final $Res Function(_TeamStats) _then;

/// Create a copy of TeamStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? window = freezed,Object? seasonId = freezed,Object? seasons = null,Object? myPlayerId = freezed,Object? rows = null,}) {
  return _then(_TeamStats(
window: freezed == window ? _self.window : window // ignore: cast_nullable_to_non_nullable
as String?,seasonId: freezed == seasonId ? _self.seasonId : seasonId // ignore: cast_nullable_to_non_nullable
as int?,seasons: null == seasons ? _self._seasons : seasons // ignore: cast_nullable_to_non_nullable
as List<SeasonOption>,myPlayerId: freezed == myPlayerId ? _self.myPlayerId : myPlayerId // ignore: cast_nullable_to_non_nullable
as int?,rows: null == rows ? _self._rows : rows // ignore: cast_nullable_to_non_nullable
as List<StatsRow>,
  ));
}


}

// dart format on
