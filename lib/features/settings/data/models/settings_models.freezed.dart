// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SettingsTeam {

@JsonKey(fromJson: _int) int get id; String get name; String get primaryColor; String? get logoUrl;@JsonKey(fromJson: _bool) bool get logoFills; String? get formation;
/// Create a copy of SettingsTeam
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsTeamCopyWith<SettingsTeam> get copyWith => _$SettingsTeamCopyWithImpl<SettingsTeam>(this as SettingsTeam, _$identity);

  /// Serializes this SettingsTeam to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsTeam&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.primaryColor, primaryColor) || other.primaryColor == primaryColor)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.logoFills, logoFills) || other.logoFills == logoFills)&&(identical(other.formation, formation) || other.formation == formation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,primaryColor,logoUrl,logoFills,formation);

@override
String toString() {
  return 'SettingsTeam(id: $id, name: $name, primaryColor: $primaryColor, logoUrl: $logoUrl, logoFills: $logoFills, formation: $formation)';
}


}

/// @nodoc
abstract mixin class $SettingsTeamCopyWith<$Res>  {
  factory $SettingsTeamCopyWith(SettingsTeam value, $Res Function(SettingsTeam) _then) = _$SettingsTeamCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _int) int id, String name, String primaryColor, String? logoUrl,@JsonKey(fromJson: _bool) bool logoFills, String? formation
});




}
/// @nodoc
class _$SettingsTeamCopyWithImpl<$Res>
    implements $SettingsTeamCopyWith<$Res> {
  _$SettingsTeamCopyWithImpl(this._self, this._then);

  final SettingsTeam _self;
  final $Res Function(SettingsTeam) _then;

/// Create a copy of SettingsTeam
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? primaryColor = null,Object? logoUrl = freezed,Object? logoFills = null,Object? formation = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,primaryColor: null == primaryColor ? _self.primaryColor : primaryColor // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,logoFills: null == logoFills ? _self.logoFills : logoFills // ignore: cast_nullable_to_non_nullable
as bool,formation: freezed == formation ? _self.formation : formation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsTeam].
extension SettingsTeamPatterns on SettingsTeam {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsTeam value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsTeam() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsTeam value)  $default,){
final _that = this;
switch (_that) {
case _SettingsTeam():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsTeam value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsTeam() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _int)  int id,  String name,  String primaryColor,  String? logoUrl, @JsonKey(fromJson: _bool)  bool logoFills,  String? formation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsTeam() when $default != null:
return $default(_that.id,_that.name,_that.primaryColor,_that.logoUrl,_that.logoFills,_that.formation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _int)  int id,  String name,  String primaryColor,  String? logoUrl, @JsonKey(fromJson: _bool)  bool logoFills,  String? formation)  $default,) {final _that = this;
switch (_that) {
case _SettingsTeam():
return $default(_that.id,_that.name,_that.primaryColor,_that.logoUrl,_that.logoFills,_that.formation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _int)  int id,  String name,  String primaryColor,  String? logoUrl, @JsonKey(fromJson: _bool)  bool logoFills,  String? formation)?  $default,) {final _that = this;
switch (_that) {
case _SettingsTeam() when $default != null:
return $default(_that.id,_that.name,_that.primaryColor,_that.logoUrl,_that.logoFills,_that.formation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettingsTeam implements SettingsTeam {
  const _SettingsTeam({@JsonKey(fromJson: _int) this.id = 0, this.name = '', this.primaryColor = '#006837', this.logoUrl, @JsonKey(fromJson: _bool) this.logoFills = false, this.formation});
  factory _SettingsTeam.fromJson(Map<String, dynamic> json) => _$SettingsTeamFromJson(json);

@override@JsonKey(fromJson: _int) final  int id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String primaryColor;
@override final  String? logoUrl;
@override@JsonKey(fromJson: _bool) final  bool logoFills;
@override final  String? formation;

/// Create a copy of SettingsTeam
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsTeamCopyWith<_SettingsTeam> get copyWith => __$SettingsTeamCopyWithImpl<_SettingsTeam>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsTeamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsTeam&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.primaryColor, primaryColor) || other.primaryColor == primaryColor)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.logoFills, logoFills) || other.logoFills == logoFills)&&(identical(other.formation, formation) || other.formation == formation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,primaryColor,logoUrl,logoFills,formation);

@override
String toString() {
  return 'SettingsTeam(id: $id, name: $name, primaryColor: $primaryColor, logoUrl: $logoUrl, logoFills: $logoFills, formation: $formation)';
}


}

/// @nodoc
abstract mixin class _$SettingsTeamCopyWith<$Res> implements $SettingsTeamCopyWith<$Res> {
  factory _$SettingsTeamCopyWith(_SettingsTeam value, $Res Function(_SettingsTeam) _then) = __$SettingsTeamCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _int) int id, String name, String primaryColor, String? logoUrl,@JsonKey(fromJson: _bool) bool logoFills, String? formation
});




}
/// @nodoc
class __$SettingsTeamCopyWithImpl<$Res>
    implements _$SettingsTeamCopyWith<$Res> {
  __$SettingsTeamCopyWithImpl(this._self, this._then);

  final _SettingsTeam _self;
  final $Res Function(_SettingsTeam) _then;

/// Create a copy of SettingsTeam
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? primaryColor = null,Object? logoUrl = freezed,Object? logoFills = null,Object? formation = freezed,}) {
  return _then(_SettingsTeam(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,primaryColor: null == primaryColor ? _self.primaryColor : primaryColor // ignore: cast_nullable_to_non_nullable
as String,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,logoFills: null == logoFills ? _self.logoFills : logoFills // ignore: cast_nullable_to_non_nullable
as bool,formation: freezed == formation ? _self.formation : formation // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RsvpSettings {

@JsonKey(unknownEnumValue: RsvpMode.relative) RsvpMode get mode;@JsonKey(fromJson: _intOrNull) int? get matchHours;@JsonKey(fromJson: _intOrNull) int? get trainingHours;/// 1 = maandag … 7 = zondag.
@JsonKey(fromJson: _intOrNull) int? get weeklyDay;/// `HH:MM`.
 String? get weeklyTime;
/// Create a copy of RsvpSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RsvpSettingsCopyWith<RsvpSettings> get copyWith => _$RsvpSettingsCopyWithImpl<RsvpSettings>(this as RsvpSettings, _$identity);

  /// Serializes this RsvpSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RsvpSettings&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.matchHours, matchHours) || other.matchHours == matchHours)&&(identical(other.trainingHours, trainingHours) || other.trainingHours == trainingHours)&&(identical(other.weeklyDay, weeklyDay) || other.weeklyDay == weeklyDay)&&(identical(other.weeklyTime, weeklyTime) || other.weeklyTime == weeklyTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,matchHours,trainingHours,weeklyDay,weeklyTime);

@override
String toString() {
  return 'RsvpSettings(mode: $mode, matchHours: $matchHours, trainingHours: $trainingHours, weeklyDay: $weeklyDay, weeklyTime: $weeklyTime)';
}


}

/// @nodoc
abstract mixin class $RsvpSettingsCopyWith<$Res>  {
  factory $RsvpSettingsCopyWith(RsvpSettings value, $Res Function(RsvpSettings) _then) = _$RsvpSettingsCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: RsvpMode.relative) RsvpMode mode,@JsonKey(fromJson: _intOrNull) int? matchHours,@JsonKey(fromJson: _intOrNull) int? trainingHours,@JsonKey(fromJson: _intOrNull) int? weeklyDay, String? weeklyTime
});




}
/// @nodoc
class _$RsvpSettingsCopyWithImpl<$Res>
    implements $RsvpSettingsCopyWith<$Res> {
  _$RsvpSettingsCopyWithImpl(this._self, this._then);

  final RsvpSettings _self;
  final $Res Function(RsvpSettings) _then;

/// Create a copy of RsvpSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? matchHours = freezed,Object? trainingHours = freezed,Object? weeklyDay = freezed,Object? weeklyTime = freezed,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as RsvpMode,matchHours: freezed == matchHours ? _self.matchHours : matchHours // ignore: cast_nullable_to_non_nullable
as int?,trainingHours: freezed == trainingHours ? _self.trainingHours : trainingHours // ignore: cast_nullable_to_non_nullable
as int?,weeklyDay: freezed == weeklyDay ? _self.weeklyDay : weeklyDay // ignore: cast_nullable_to_non_nullable
as int?,weeklyTime: freezed == weeklyTime ? _self.weeklyTime : weeklyTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RsvpSettings].
extension RsvpSettingsPatterns on RsvpSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RsvpSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RsvpSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RsvpSettings value)  $default,){
final _that = this;
switch (_that) {
case _RsvpSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RsvpSettings value)?  $default,){
final _that = this;
switch (_that) {
case _RsvpSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: RsvpMode.relative)  RsvpMode mode, @JsonKey(fromJson: _intOrNull)  int? matchHours, @JsonKey(fromJson: _intOrNull)  int? trainingHours, @JsonKey(fromJson: _intOrNull)  int? weeklyDay,  String? weeklyTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RsvpSettings() when $default != null:
return $default(_that.mode,_that.matchHours,_that.trainingHours,_that.weeklyDay,_that.weeklyTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: RsvpMode.relative)  RsvpMode mode, @JsonKey(fromJson: _intOrNull)  int? matchHours, @JsonKey(fromJson: _intOrNull)  int? trainingHours, @JsonKey(fromJson: _intOrNull)  int? weeklyDay,  String? weeklyTime)  $default,) {final _that = this;
switch (_that) {
case _RsvpSettings():
return $default(_that.mode,_that.matchHours,_that.trainingHours,_that.weeklyDay,_that.weeklyTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: RsvpMode.relative)  RsvpMode mode, @JsonKey(fromJson: _intOrNull)  int? matchHours, @JsonKey(fromJson: _intOrNull)  int? trainingHours, @JsonKey(fromJson: _intOrNull)  int? weeklyDay,  String? weeklyTime)?  $default,) {final _that = this;
switch (_that) {
case _RsvpSettings() when $default != null:
return $default(_that.mode,_that.matchHours,_that.trainingHours,_that.weeklyDay,_that.weeklyTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RsvpSettings implements RsvpSettings {
  const _RsvpSettings({@JsonKey(unknownEnumValue: RsvpMode.relative) this.mode = RsvpMode.relative, @JsonKey(fromJson: _intOrNull) this.matchHours, @JsonKey(fromJson: _intOrNull) this.trainingHours, @JsonKey(fromJson: _intOrNull) this.weeklyDay, this.weeklyTime});
  factory _RsvpSettings.fromJson(Map<String, dynamic> json) => _$RsvpSettingsFromJson(json);

@override@JsonKey(unknownEnumValue: RsvpMode.relative) final  RsvpMode mode;
@override@JsonKey(fromJson: _intOrNull) final  int? matchHours;
@override@JsonKey(fromJson: _intOrNull) final  int? trainingHours;
/// 1 = maandag … 7 = zondag.
@override@JsonKey(fromJson: _intOrNull) final  int? weeklyDay;
/// `HH:MM`.
@override final  String? weeklyTime;

/// Create a copy of RsvpSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RsvpSettingsCopyWith<_RsvpSettings> get copyWith => __$RsvpSettingsCopyWithImpl<_RsvpSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RsvpSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RsvpSettings&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.matchHours, matchHours) || other.matchHours == matchHours)&&(identical(other.trainingHours, trainingHours) || other.trainingHours == trainingHours)&&(identical(other.weeklyDay, weeklyDay) || other.weeklyDay == weeklyDay)&&(identical(other.weeklyTime, weeklyTime) || other.weeklyTime == weeklyTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,matchHours,trainingHours,weeklyDay,weeklyTime);

@override
String toString() {
  return 'RsvpSettings(mode: $mode, matchHours: $matchHours, trainingHours: $trainingHours, weeklyDay: $weeklyDay, weeklyTime: $weeklyTime)';
}


}

/// @nodoc
abstract mixin class _$RsvpSettingsCopyWith<$Res> implements $RsvpSettingsCopyWith<$Res> {
  factory _$RsvpSettingsCopyWith(_RsvpSettings value, $Res Function(_RsvpSettings) _then) = __$RsvpSettingsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: RsvpMode.relative) RsvpMode mode,@JsonKey(fromJson: _intOrNull) int? matchHours,@JsonKey(fromJson: _intOrNull) int? trainingHours,@JsonKey(fromJson: _intOrNull) int? weeklyDay, String? weeklyTime
});




}
/// @nodoc
class __$RsvpSettingsCopyWithImpl<$Res>
    implements _$RsvpSettingsCopyWith<$Res> {
  __$RsvpSettingsCopyWithImpl(this._self, this._then);

  final _RsvpSettings _self;
  final $Res Function(_RsvpSettings) _then;

/// Create a copy of RsvpSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? matchHours = freezed,Object? trainingHours = freezed,Object? weeklyDay = freezed,Object? weeklyTime = freezed,}) {
  return _then(_RsvpSettings(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as RsvpMode,matchHours: freezed == matchHours ? _self.matchHours : matchHours // ignore: cast_nullable_to_non_nullable
as int?,trainingHours: freezed == trainingHours ? _self.trainingHours : trainingHours // ignore: cast_nullable_to_non_nullable
as int?,weeklyDay: freezed == weeklyDay ? _self.weeklyDay : weeklyDay // ignore: cast_nullable_to_non_nullable
as int?,weeklyTime: freezed == weeklyTime ? _self.weeklyTime : weeklyTime // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SettingsFeature {

 String get key; String get name; String? get description; String? get category;@JsonKey(fromJson: _bool) bool get enabled;
/// Create a copy of SettingsFeature
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsFeatureCopyWith<SettingsFeature> get copyWith => _$SettingsFeatureCopyWithImpl<SettingsFeature>(this as SettingsFeature, _$identity);

  /// Serializes this SettingsFeature to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsFeature&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name,description,category,enabled);

@override
String toString() {
  return 'SettingsFeature(key: $key, name: $name, description: $description, category: $category, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $SettingsFeatureCopyWith<$Res>  {
  factory $SettingsFeatureCopyWith(SettingsFeature value, $Res Function(SettingsFeature) _then) = _$SettingsFeatureCopyWithImpl;
@useResult
$Res call({
 String key, String name, String? description, String? category,@JsonKey(fromJson: _bool) bool enabled
});




}
/// @nodoc
class _$SettingsFeatureCopyWithImpl<$Res>
    implements $SettingsFeatureCopyWith<$Res> {
  _$SettingsFeatureCopyWithImpl(this._self, this._then);

  final SettingsFeature _self;
  final $Res Function(SettingsFeature) _then;

/// Create a copy of SettingsFeature
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? name = null,Object? description = freezed,Object? category = freezed,Object? enabled = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsFeature].
extension SettingsFeaturePatterns on SettingsFeature {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsFeature value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsFeature() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsFeature value)  $default,){
final _that = this;
switch (_that) {
case _SettingsFeature():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsFeature value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsFeature() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String name,  String? description,  String? category, @JsonKey(fromJson: _bool)  bool enabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsFeature() when $default != null:
return $default(_that.key,_that.name,_that.description,_that.category,_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String name,  String? description,  String? category, @JsonKey(fromJson: _bool)  bool enabled)  $default,) {final _that = this;
switch (_that) {
case _SettingsFeature():
return $default(_that.key,_that.name,_that.description,_that.category,_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String name,  String? description,  String? category, @JsonKey(fromJson: _bool)  bool enabled)?  $default,) {final _that = this;
switch (_that) {
case _SettingsFeature() when $default != null:
return $default(_that.key,_that.name,_that.description,_that.category,_that.enabled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettingsFeature implements SettingsFeature {
  const _SettingsFeature({required this.key, this.name = '', this.description, this.category, @JsonKey(fromJson: _bool) this.enabled = false});
  factory _SettingsFeature.fromJson(Map<String, dynamic> json) => _$SettingsFeatureFromJson(json);

@override final  String key;
@override@JsonKey() final  String name;
@override final  String? description;
@override final  String? category;
@override@JsonKey(fromJson: _bool) final  bool enabled;

/// Create a copy of SettingsFeature
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsFeatureCopyWith<_SettingsFeature> get copyWith => __$SettingsFeatureCopyWithImpl<_SettingsFeature>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsFeatureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsFeature&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name,description,category,enabled);

@override
String toString() {
  return 'SettingsFeature(key: $key, name: $name, description: $description, category: $category, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$SettingsFeatureCopyWith<$Res> implements $SettingsFeatureCopyWith<$Res> {
  factory _$SettingsFeatureCopyWith(_SettingsFeature value, $Res Function(_SettingsFeature) _then) = __$SettingsFeatureCopyWithImpl;
@override @useResult
$Res call({
 String key, String name, String? description, String? category,@JsonKey(fromJson: _bool) bool enabled
});




}
/// @nodoc
class __$SettingsFeatureCopyWithImpl<$Res>
    implements _$SettingsFeatureCopyWith<$Res> {
  __$SettingsFeatureCopyWithImpl(this._self, this._then);

  final _SettingsFeature _self;
  final $Res Function(_SettingsFeature) _then;

/// Create a copy of SettingsFeature
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? name = null,Object? description = freezed,Object? category = freezed,Object? enabled = null,}) {
  return _then(_SettingsFeature(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$DutyTypeSetting {

@JsonKey(fromJson: _int) int get id; String get name; String? get slug; String? get icon;@JsonKey(fromJson: _int) int get sortOrder;@JsonKey(unknownEnumValue: DutyMode.group) DutyMode get mode;@JsonKey(unknownEnumValue: DutyScope.free) DutyScope get scope;@JsonKey(fromJson: _bool) bool get autoRotate;@JsonKey(unknownEnumValue: DutyOnUnavailable.reassign) DutyOnUnavailable? get onUnavailable;@JsonKey(fromJson: _strings) List<String> get pool;@JsonKey(fromJson: _strings) List<String> get poolMembers;
/// Create a copy of DutyTypeSetting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyTypeSettingCopyWith<DutyTypeSetting> get copyWith => _$DutyTypeSettingCopyWithImpl<DutyTypeSetting>(this as DutyTypeSetting, _$identity);

  /// Serializes this DutyTypeSetting to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyTypeSetting&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.autoRotate, autoRotate) || other.autoRotate == autoRotate)&&(identical(other.onUnavailable, onUnavailable) || other.onUnavailable == onUnavailable)&&const DeepCollectionEquality().equals(other.pool, pool)&&const DeepCollectionEquality().equals(other.poolMembers, poolMembers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,icon,sortOrder,mode,scope,autoRotate,onUnavailable,const DeepCollectionEquality().hash(pool),const DeepCollectionEquality().hash(poolMembers));

@override
String toString() {
  return 'DutyTypeSetting(id: $id, name: $name, slug: $slug, icon: $icon, sortOrder: $sortOrder, mode: $mode, scope: $scope, autoRotate: $autoRotate, onUnavailable: $onUnavailable, pool: $pool, poolMembers: $poolMembers)';
}


}

/// @nodoc
abstract mixin class $DutyTypeSettingCopyWith<$Res>  {
  factory $DutyTypeSettingCopyWith(DutyTypeSetting value, $Res Function(DutyTypeSetting) _then) = _$DutyTypeSettingCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _int) int id, String name, String? slug, String? icon,@JsonKey(fromJson: _int) int sortOrder,@JsonKey(unknownEnumValue: DutyMode.group) DutyMode mode,@JsonKey(unknownEnumValue: DutyScope.free) DutyScope scope,@JsonKey(fromJson: _bool) bool autoRotate,@JsonKey(unknownEnumValue: DutyOnUnavailable.reassign) DutyOnUnavailable? onUnavailable,@JsonKey(fromJson: _strings) List<String> pool,@JsonKey(fromJson: _strings) List<String> poolMembers
});




}
/// @nodoc
class _$DutyTypeSettingCopyWithImpl<$Res>
    implements $DutyTypeSettingCopyWith<$Res> {
  _$DutyTypeSettingCopyWithImpl(this._self, this._then);

  final DutyTypeSetting _self;
  final $Res Function(DutyTypeSetting) _then;

/// Create a copy of DutyTypeSetting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = freezed,Object? icon = freezed,Object? sortOrder = null,Object? mode = null,Object? scope = null,Object? autoRotate = null,Object? onUnavailable = freezed,Object? pool = null,Object? poolMembers = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as DutyMode,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as DutyScope,autoRotate: null == autoRotate ? _self.autoRotate : autoRotate // ignore: cast_nullable_to_non_nullable
as bool,onUnavailable: freezed == onUnavailable ? _self.onUnavailable : onUnavailable // ignore: cast_nullable_to_non_nullable
as DutyOnUnavailable?,pool: null == pool ? _self.pool : pool // ignore: cast_nullable_to_non_nullable
as List<String>,poolMembers: null == poolMembers ? _self.poolMembers : poolMembers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [DutyTypeSetting].
extension DutyTypeSettingPatterns on DutyTypeSetting {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyTypeSetting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyTypeSetting() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyTypeSetting value)  $default,){
final _that = this;
switch (_that) {
case _DutyTypeSetting():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyTypeSetting value)?  $default,){
final _that = this;
switch (_that) {
case _DutyTypeSetting() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _int)  int id,  String name,  String? slug,  String? icon, @JsonKey(fromJson: _int)  int sortOrder, @JsonKey(unknownEnumValue: DutyMode.group)  DutyMode mode, @JsonKey(unknownEnumValue: DutyScope.free)  DutyScope scope, @JsonKey(fromJson: _bool)  bool autoRotate, @JsonKey(unknownEnumValue: DutyOnUnavailable.reassign)  DutyOnUnavailable? onUnavailable, @JsonKey(fromJson: _strings)  List<String> pool, @JsonKey(fromJson: _strings)  List<String> poolMembers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyTypeSetting() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.icon,_that.sortOrder,_that.mode,_that.scope,_that.autoRotate,_that.onUnavailable,_that.pool,_that.poolMembers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _int)  int id,  String name,  String? slug,  String? icon, @JsonKey(fromJson: _int)  int sortOrder, @JsonKey(unknownEnumValue: DutyMode.group)  DutyMode mode, @JsonKey(unknownEnumValue: DutyScope.free)  DutyScope scope, @JsonKey(fromJson: _bool)  bool autoRotate, @JsonKey(unknownEnumValue: DutyOnUnavailable.reassign)  DutyOnUnavailable? onUnavailable, @JsonKey(fromJson: _strings)  List<String> pool, @JsonKey(fromJson: _strings)  List<String> poolMembers)  $default,) {final _that = this;
switch (_that) {
case _DutyTypeSetting():
return $default(_that.id,_that.name,_that.slug,_that.icon,_that.sortOrder,_that.mode,_that.scope,_that.autoRotate,_that.onUnavailable,_that.pool,_that.poolMembers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _int)  int id,  String name,  String? slug,  String? icon, @JsonKey(fromJson: _int)  int sortOrder, @JsonKey(unknownEnumValue: DutyMode.group)  DutyMode mode, @JsonKey(unknownEnumValue: DutyScope.free)  DutyScope scope, @JsonKey(fromJson: _bool)  bool autoRotate, @JsonKey(unknownEnumValue: DutyOnUnavailable.reassign)  DutyOnUnavailable? onUnavailable, @JsonKey(fromJson: _strings)  List<String> pool, @JsonKey(fromJson: _strings)  List<String> poolMembers)?  $default,) {final _that = this;
switch (_that) {
case _DutyTypeSetting() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.icon,_that.sortOrder,_that.mode,_that.scope,_that.autoRotate,_that.onUnavailable,_that.pool,_that.poolMembers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyTypeSetting implements DutyTypeSetting {
  const _DutyTypeSetting({@JsonKey(fromJson: _int) required this.id, this.name = '', this.slug, this.icon, @JsonKey(fromJson: _int) this.sortOrder = 0, @JsonKey(unknownEnumValue: DutyMode.group) this.mode = DutyMode.group, @JsonKey(unknownEnumValue: DutyScope.free) this.scope = DutyScope.free, @JsonKey(fromJson: _bool) this.autoRotate = false, @JsonKey(unknownEnumValue: DutyOnUnavailable.reassign) this.onUnavailable, @JsonKey(fromJson: _strings) final  List<String> pool = const <String>[], @JsonKey(fromJson: _strings) final  List<String> poolMembers = const <String>[]}): _pool = pool,_poolMembers = poolMembers;
  factory _DutyTypeSetting.fromJson(Map<String, dynamic> json) => _$DutyTypeSettingFromJson(json);

@override@JsonKey(fromJson: _int) final  int id;
@override@JsonKey() final  String name;
@override final  String? slug;
@override final  String? icon;
@override@JsonKey(fromJson: _int) final  int sortOrder;
@override@JsonKey(unknownEnumValue: DutyMode.group) final  DutyMode mode;
@override@JsonKey(unknownEnumValue: DutyScope.free) final  DutyScope scope;
@override@JsonKey(fromJson: _bool) final  bool autoRotate;
@override@JsonKey(unknownEnumValue: DutyOnUnavailable.reassign) final  DutyOnUnavailable? onUnavailable;
 final  List<String> _pool;
@override@JsonKey(fromJson: _strings) List<String> get pool {
  if (_pool is EqualUnmodifiableListView) return _pool;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pool);
}

 final  List<String> _poolMembers;
@override@JsonKey(fromJson: _strings) List<String> get poolMembers {
  if (_poolMembers is EqualUnmodifiableListView) return _poolMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_poolMembers);
}


/// Create a copy of DutyTypeSetting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyTypeSettingCopyWith<_DutyTypeSetting> get copyWith => __$DutyTypeSettingCopyWithImpl<_DutyTypeSetting>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyTypeSettingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyTypeSetting&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.autoRotate, autoRotate) || other.autoRotate == autoRotate)&&(identical(other.onUnavailable, onUnavailable) || other.onUnavailable == onUnavailable)&&const DeepCollectionEquality().equals(other._pool, _pool)&&const DeepCollectionEquality().equals(other._poolMembers, _poolMembers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,icon,sortOrder,mode,scope,autoRotate,onUnavailable,const DeepCollectionEquality().hash(_pool),const DeepCollectionEquality().hash(_poolMembers));

@override
String toString() {
  return 'DutyTypeSetting(id: $id, name: $name, slug: $slug, icon: $icon, sortOrder: $sortOrder, mode: $mode, scope: $scope, autoRotate: $autoRotate, onUnavailable: $onUnavailable, pool: $pool, poolMembers: $poolMembers)';
}


}

/// @nodoc
abstract mixin class _$DutyTypeSettingCopyWith<$Res> implements $DutyTypeSettingCopyWith<$Res> {
  factory _$DutyTypeSettingCopyWith(_DutyTypeSetting value, $Res Function(_DutyTypeSetting) _then) = __$DutyTypeSettingCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _int) int id, String name, String? slug, String? icon,@JsonKey(fromJson: _int) int sortOrder,@JsonKey(unknownEnumValue: DutyMode.group) DutyMode mode,@JsonKey(unknownEnumValue: DutyScope.free) DutyScope scope,@JsonKey(fromJson: _bool) bool autoRotate,@JsonKey(unknownEnumValue: DutyOnUnavailable.reassign) DutyOnUnavailable? onUnavailable,@JsonKey(fromJson: _strings) List<String> pool,@JsonKey(fromJson: _strings) List<String> poolMembers
});




}
/// @nodoc
class __$DutyTypeSettingCopyWithImpl<$Res>
    implements _$DutyTypeSettingCopyWith<$Res> {
  __$DutyTypeSettingCopyWithImpl(this._self, this._then);

  final _DutyTypeSetting _self;
  final $Res Function(_DutyTypeSetting) _then;

/// Create a copy of DutyTypeSetting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = freezed,Object? icon = freezed,Object? sortOrder = null,Object? mode = null,Object? scope = null,Object? autoRotate = null,Object? onUnavailable = freezed,Object? pool = null,Object? poolMembers = null,}) {
  return _then(_DutyTypeSetting(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: freezed == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as DutyMode,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as DutyScope,autoRotate: null == autoRotate ? _self.autoRotate : autoRotate // ignore: cast_nullable_to_non_nullable
as bool,onUnavailable: freezed == onUnavailable ? _self.onUnavailable : onUnavailable // ignore: cast_nullable_to_non_nullable
as DutyOnUnavailable?,pool: null == pool ? _self._pool : pool // ignore: cast_nullable_to_non_nullable
as List<String>,poolMembers: null == poolMembers ? _self._poolMembers : poolMembers // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$DutyPerson {

 String get key; String get name;/// `player`, `staff`, `spectator` of `guest`.
 String get kind;
/// Create a copy of DutyPerson
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyPersonCopyWith<DutyPerson> get copyWith => _$DutyPersonCopyWithImpl<DutyPerson>(this as DutyPerson, _$identity);

  /// Serializes this DutyPerson to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyPerson&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name,kind);

@override
String toString() {
  return 'DutyPerson(key: $key, name: $name, kind: $kind)';
}


}

/// @nodoc
abstract mixin class $DutyPersonCopyWith<$Res>  {
  factory $DutyPersonCopyWith(DutyPerson value, $Res Function(DutyPerson) _then) = _$DutyPersonCopyWithImpl;
@useResult
$Res call({
 String key, String name, String kind
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
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? name = null,Object? kind = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String name,  String kind)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyPerson() when $default != null:
return $default(_that.key,_that.name,_that.kind);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String name,  String kind)  $default,) {final _that = this;
switch (_that) {
case _DutyPerson():
return $default(_that.key,_that.name,_that.kind);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String name,  String kind)?  $default,) {final _that = this;
switch (_that) {
case _DutyPerson() when $default != null:
return $default(_that.key,_that.name,_that.kind);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyPerson implements DutyPerson {
  const _DutyPerson({required this.key, this.name = '', this.kind = 'player'});
  factory _DutyPerson.fromJson(Map<String, dynamic> json) => _$DutyPersonFromJson(json);

@override final  String key;
@override@JsonKey() final  String name;
/// `player`, `staff`, `spectator` of `guest`.
@override@JsonKey() final  String kind;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyPerson&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name,kind);

@override
String toString() {
  return 'DutyPerson(key: $key, name: $name, kind: $kind)';
}


}

/// @nodoc
abstract mixin class _$DutyPersonCopyWith<$Res> implements $DutyPersonCopyWith<$Res> {
  factory _$DutyPersonCopyWith(_DutyPerson value, $Res Function(_DutyPerson) _then) = __$DutyPersonCopyWithImpl;
@override @useResult
$Res call({
 String key, String name, String kind
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
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? name = null,Object? kind = null,}) {
  return _then(_DutyPerson(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$IcalLinks {

 String? get eventsUrl; String? get trainingsUrl;
/// Create a copy of IcalLinks
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IcalLinksCopyWith<IcalLinks> get copyWith => _$IcalLinksCopyWithImpl<IcalLinks>(this as IcalLinks, _$identity);

  /// Serializes this IcalLinks to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IcalLinks&&(identical(other.eventsUrl, eventsUrl) || other.eventsUrl == eventsUrl)&&(identical(other.trainingsUrl, trainingsUrl) || other.trainingsUrl == trainingsUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventsUrl,trainingsUrl);

@override
String toString() {
  return 'IcalLinks(eventsUrl: $eventsUrl, trainingsUrl: $trainingsUrl)';
}


}

/// @nodoc
abstract mixin class $IcalLinksCopyWith<$Res>  {
  factory $IcalLinksCopyWith(IcalLinks value, $Res Function(IcalLinks) _then) = _$IcalLinksCopyWithImpl;
@useResult
$Res call({
 String? eventsUrl, String? trainingsUrl
});




}
/// @nodoc
class _$IcalLinksCopyWithImpl<$Res>
    implements $IcalLinksCopyWith<$Res> {
  _$IcalLinksCopyWithImpl(this._self, this._then);

  final IcalLinks _self;
  final $Res Function(IcalLinks) _then;

/// Create a copy of IcalLinks
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventsUrl = freezed,Object? trainingsUrl = freezed,}) {
  return _then(_self.copyWith(
eventsUrl: freezed == eventsUrl ? _self.eventsUrl : eventsUrl // ignore: cast_nullable_to_non_nullable
as String?,trainingsUrl: freezed == trainingsUrl ? _self.trainingsUrl : trainingsUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [IcalLinks].
extension IcalLinksPatterns on IcalLinks {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IcalLinks value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IcalLinks() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IcalLinks value)  $default,){
final _that = this;
switch (_that) {
case _IcalLinks():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IcalLinks value)?  $default,){
final _that = this;
switch (_that) {
case _IcalLinks() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? eventsUrl,  String? trainingsUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IcalLinks() when $default != null:
return $default(_that.eventsUrl,_that.trainingsUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? eventsUrl,  String? trainingsUrl)  $default,) {final _that = this;
switch (_that) {
case _IcalLinks():
return $default(_that.eventsUrl,_that.trainingsUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? eventsUrl,  String? trainingsUrl)?  $default,) {final _that = this;
switch (_that) {
case _IcalLinks() when $default != null:
return $default(_that.eventsUrl,_that.trainingsUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IcalLinks implements IcalLinks {
  const _IcalLinks({this.eventsUrl, this.trainingsUrl});
  factory _IcalLinks.fromJson(Map<String, dynamic> json) => _$IcalLinksFromJson(json);

@override final  String? eventsUrl;
@override final  String? trainingsUrl;

/// Create a copy of IcalLinks
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IcalLinksCopyWith<_IcalLinks> get copyWith => __$IcalLinksCopyWithImpl<_IcalLinks>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IcalLinksToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IcalLinks&&(identical(other.eventsUrl, eventsUrl) || other.eventsUrl == eventsUrl)&&(identical(other.trainingsUrl, trainingsUrl) || other.trainingsUrl == trainingsUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventsUrl,trainingsUrl);

@override
String toString() {
  return 'IcalLinks(eventsUrl: $eventsUrl, trainingsUrl: $trainingsUrl)';
}


}

/// @nodoc
abstract mixin class _$IcalLinksCopyWith<$Res> implements $IcalLinksCopyWith<$Res> {
  factory _$IcalLinksCopyWith(_IcalLinks value, $Res Function(_IcalLinks) _then) = __$IcalLinksCopyWithImpl;
@override @useResult
$Res call({
 String? eventsUrl, String? trainingsUrl
});




}
/// @nodoc
class __$IcalLinksCopyWithImpl<$Res>
    implements _$IcalLinksCopyWith<$Res> {
  __$IcalLinksCopyWithImpl(this._self, this._then);

  final _IcalLinks _self;
  final $Res Function(_IcalLinks) _then;

/// Create a copy of IcalLinks
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventsUrl = freezed,Object? trainingsUrl = freezed,}) {
  return _then(_IcalLinks(
eventsUrl: freezed == eventsUrl ? _self.eventsUrl : eventsUrl // ignore: cast_nullable_to_non_nullable
as String?,trainingsUrl: freezed == trainingsUrl ? _self.trainingsUrl : trainingsUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CarpoolSettings {

@JsonKey(fromJson: _int) int get reminderHours;
/// Create a copy of CarpoolSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CarpoolSettingsCopyWith<CarpoolSettings> get copyWith => _$CarpoolSettingsCopyWithImpl<CarpoolSettings>(this as CarpoolSettings, _$identity);

  /// Serializes this CarpoolSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CarpoolSettings&&(identical(other.reminderHours, reminderHours) || other.reminderHours == reminderHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reminderHours);

@override
String toString() {
  return 'CarpoolSettings(reminderHours: $reminderHours)';
}


}

/// @nodoc
abstract mixin class $CarpoolSettingsCopyWith<$Res>  {
  factory $CarpoolSettingsCopyWith(CarpoolSettings value, $Res Function(CarpoolSettings) _then) = _$CarpoolSettingsCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _int) int reminderHours
});




}
/// @nodoc
class _$CarpoolSettingsCopyWithImpl<$Res>
    implements $CarpoolSettingsCopyWith<$Res> {
  _$CarpoolSettingsCopyWithImpl(this._self, this._then);

  final CarpoolSettings _self;
  final $Res Function(CarpoolSettings) _then;

/// Create a copy of CarpoolSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reminderHours = null,}) {
  return _then(_self.copyWith(
reminderHours: null == reminderHours ? _self.reminderHours : reminderHours // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CarpoolSettings].
extension CarpoolSettingsPatterns on CarpoolSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CarpoolSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CarpoolSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CarpoolSettings value)  $default,){
final _that = this;
switch (_that) {
case _CarpoolSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CarpoolSettings value)?  $default,){
final _that = this;
switch (_that) {
case _CarpoolSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _int)  int reminderHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CarpoolSettings() when $default != null:
return $default(_that.reminderHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _int)  int reminderHours)  $default,) {final _that = this;
switch (_that) {
case _CarpoolSettings():
return $default(_that.reminderHours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _int)  int reminderHours)?  $default,) {final _that = this;
switch (_that) {
case _CarpoolSettings() when $default != null:
return $default(_that.reminderHours);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CarpoolSettings implements CarpoolSettings {
  const _CarpoolSettings({@JsonKey(fromJson: _int) this.reminderHours = 4});
  factory _CarpoolSettings.fromJson(Map<String, dynamic> json) => _$CarpoolSettingsFromJson(json);

@override@JsonKey(fromJson: _int) final  int reminderHours;

/// Create a copy of CarpoolSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CarpoolSettingsCopyWith<_CarpoolSettings> get copyWith => __$CarpoolSettingsCopyWithImpl<_CarpoolSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CarpoolSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CarpoolSettings&&(identical(other.reminderHours, reminderHours) || other.reminderHours == reminderHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,reminderHours);

@override
String toString() {
  return 'CarpoolSettings(reminderHours: $reminderHours)';
}


}

/// @nodoc
abstract mixin class _$CarpoolSettingsCopyWith<$Res> implements $CarpoolSettingsCopyWith<$Res> {
  factory _$CarpoolSettingsCopyWith(_CarpoolSettings value, $Res Function(_CarpoolSettings) _then) = __$CarpoolSettingsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _int) int reminderHours
});




}
/// @nodoc
class __$CarpoolSettingsCopyWithImpl<$Res>
    implements _$CarpoolSettingsCopyWith<$Res> {
  __$CarpoolSettingsCopyWithImpl(this._self, this._then);

  final _CarpoolSettings _self;
  final $Res Function(_CarpoolSettings) _then;

/// Create a copy of CarpoolSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reminderHours = null,}) {
  return _then(_CarpoolSettings(
reminderHours: null == reminderHours ? _self.reminderHours : reminderHours // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$GuestSettings {

@JsonKey(unknownEnumValue: GuestAttendance.none) GuestAttendance get attendance;@JsonKey(fromJson: _bool) bool get inFines;@JsonKey(fromJson: _bool) bool get inStats;@JsonKey(fromJson: _bool) bool get staffInFines;
/// Create a copy of GuestSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GuestSettingsCopyWith<GuestSettings> get copyWith => _$GuestSettingsCopyWithImpl<GuestSettings>(this as GuestSettings, _$identity);

  /// Serializes this GuestSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GuestSettings&&(identical(other.attendance, attendance) || other.attendance == attendance)&&(identical(other.inFines, inFines) || other.inFines == inFines)&&(identical(other.inStats, inStats) || other.inStats == inStats)&&(identical(other.staffInFines, staffInFines) || other.staffInFines == staffInFines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,attendance,inFines,inStats,staffInFines);

@override
String toString() {
  return 'GuestSettings(attendance: $attendance, inFines: $inFines, inStats: $inStats, staffInFines: $staffInFines)';
}


}

/// @nodoc
abstract mixin class $GuestSettingsCopyWith<$Res>  {
  factory $GuestSettingsCopyWith(GuestSettings value, $Res Function(GuestSettings) _then) = _$GuestSettingsCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: GuestAttendance.none) GuestAttendance attendance,@JsonKey(fromJson: _bool) bool inFines,@JsonKey(fromJson: _bool) bool inStats,@JsonKey(fromJson: _bool) bool staffInFines
});




}
/// @nodoc
class _$GuestSettingsCopyWithImpl<$Res>
    implements $GuestSettingsCopyWith<$Res> {
  _$GuestSettingsCopyWithImpl(this._self, this._then);

  final GuestSettings _self;
  final $Res Function(GuestSettings) _then;

/// Create a copy of GuestSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attendance = null,Object? inFines = null,Object? inStats = null,Object? staffInFines = null,}) {
  return _then(_self.copyWith(
attendance: null == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as GuestAttendance,inFines: null == inFines ? _self.inFines : inFines // ignore: cast_nullable_to_non_nullable
as bool,inStats: null == inStats ? _self.inStats : inStats // ignore: cast_nullable_to_non_nullable
as bool,staffInFines: null == staffInFines ? _self.staffInFines : staffInFines // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GuestSettings].
extension GuestSettingsPatterns on GuestSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GuestSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GuestSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GuestSettings value)  $default,){
final _that = this;
switch (_that) {
case _GuestSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GuestSettings value)?  $default,){
final _that = this;
switch (_that) {
case _GuestSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: GuestAttendance.none)  GuestAttendance attendance, @JsonKey(fromJson: _bool)  bool inFines, @JsonKey(fromJson: _bool)  bool inStats, @JsonKey(fromJson: _bool)  bool staffInFines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GuestSettings() when $default != null:
return $default(_that.attendance,_that.inFines,_that.inStats,_that.staffInFines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: GuestAttendance.none)  GuestAttendance attendance, @JsonKey(fromJson: _bool)  bool inFines, @JsonKey(fromJson: _bool)  bool inStats, @JsonKey(fromJson: _bool)  bool staffInFines)  $default,) {final _that = this;
switch (_that) {
case _GuestSettings():
return $default(_that.attendance,_that.inFines,_that.inStats,_that.staffInFines);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: GuestAttendance.none)  GuestAttendance attendance, @JsonKey(fromJson: _bool)  bool inFines, @JsonKey(fromJson: _bool)  bool inStats, @JsonKey(fromJson: _bool)  bool staffInFines)?  $default,) {final _that = this;
switch (_that) {
case _GuestSettings() when $default != null:
return $default(_that.attendance,_that.inFines,_that.inStats,_that.staffInFines);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GuestSettings implements GuestSettings {
  const _GuestSettings({@JsonKey(unknownEnumValue: GuestAttendance.none) this.attendance = GuestAttendance.none, @JsonKey(fromJson: _bool) this.inFines = false, @JsonKey(fromJson: _bool) this.inStats = false, @JsonKey(fromJson: _bool) this.staffInFines = false});
  factory _GuestSettings.fromJson(Map<String, dynamic> json) => _$GuestSettingsFromJson(json);

@override@JsonKey(unknownEnumValue: GuestAttendance.none) final  GuestAttendance attendance;
@override@JsonKey(fromJson: _bool) final  bool inFines;
@override@JsonKey(fromJson: _bool) final  bool inStats;
@override@JsonKey(fromJson: _bool) final  bool staffInFines;

/// Create a copy of GuestSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GuestSettingsCopyWith<_GuestSettings> get copyWith => __$GuestSettingsCopyWithImpl<_GuestSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GuestSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GuestSettings&&(identical(other.attendance, attendance) || other.attendance == attendance)&&(identical(other.inFines, inFines) || other.inFines == inFines)&&(identical(other.inStats, inStats) || other.inStats == inStats)&&(identical(other.staffInFines, staffInFines) || other.staffInFines == staffInFines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,attendance,inFines,inStats,staffInFines);

@override
String toString() {
  return 'GuestSettings(attendance: $attendance, inFines: $inFines, inStats: $inStats, staffInFines: $staffInFines)';
}


}

/// @nodoc
abstract mixin class _$GuestSettingsCopyWith<$Res> implements $GuestSettingsCopyWith<$Res> {
  factory _$GuestSettingsCopyWith(_GuestSettings value, $Res Function(_GuestSettings) _then) = __$GuestSettingsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: GuestAttendance.none) GuestAttendance attendance,@JsonKey(fromJson: _bool) bool inFines,@JsonKey(fromJson: _bool) bool inStats,@JsonKey(fromJson: _bool) bool staffInFines
});




}
/// @nodoc
class __$GuestSettingsCopyWithImpl<$Res>
    implements _$GuestSettingsCopyWith<$Res> {
  __$GuestSettingsCopyWithImpl(this._self, this._then);

  final _GuestSettings _self;
  final $Res Function(_GuestSettings) _then;

/// Create a copy of GuestSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attendance = null,Object? inFines = null,Object? inStats = null,Object? staffInFines = null,}) {
  return _then(_GuestSettings(
attendance: null == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as GuestAttendance,inFines: null == inFines ? _self.inFines : inFines // ignore: cast_nullable_to_non_nullable
as bool,inStats: null == inStats ? _self.inStats : inStats // ignore: cast_nullable_to_non_nullable
as bool,staffInFines: null == staffInFines ? _self.staffInFines : staffInFines // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TrainingPointsSettings {

@JsonKey(fromJson: _bool) bool get attendancePoint;
/// Create a copy of TrainingPointsSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingPointsSettingsCopyWith<TrainingPointsSettings> get copyWith => _$TrainingPointsSettingsCopyWithImpl<TrainingPointsSettings>(this as TrainingPointsSettings, _$identity);

  /// Serializes this TrainingPointsSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingPointsSettings&&(identical(other.attendancePoint, attendancePoint) || other.attendancePoint == attendancePoint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,attendancePoint);

@override
String toString() {
  return 'TrainingPointsSettings(attendancePoint: $attendancePoint)';
}


}

/// @nodoc
abstract mixin class $TrainingPointsSettingsCopyWith<$Res>  {
  factory $TrainingPointsSettingsCopyWith(TrainingPointsSettings value, $Res Function(TrainingPointsSettings) _then) = _$TrainingPointsSettingsCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _bool) bool attendancePoint
});




}
/// @nodoc
class _$TrainingPointsSettingsCopyWithImpl<$Res>
    implements $TrainingPointsSettingsCopyWith<$Res> {
  _$TrainingPointsSettingsCopyWithImpl(this._self, this._then);

  final TrainingPointsSettings _self;
  final $Res Function(TrainingPointsSettings) _then;

/// Create a copy of TrainingPointsSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attendancePoint = null,}) {
  return _then(_self.copyWith(
attendancePoint: null == attendancePoint ? _self.attendancePoint : attendancePoint // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingPointsSettings].
extension TrainingPointsSettingsPatterns on TrainingPointsSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingPointsSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingPointsSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingPointsSettings value)  $default,){
final _that = this;
switch (_that) {
case _TrainingPointsSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingPointsSettings value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingPointsSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _bool)  bool attendancePoint)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingPointsSettings() when $default != null:
return $default(_that.attendancePoint);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _bool)  bool attendancePoint)  $default,) {final _that = this;
switch (_that) {
case _TrainingPointsSettings():
return $default(_that.attendancePoint);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _bool)  bool attendancePoint)?  $default,) {final _that = this;
switch (_that) {
case _TrainingPointsSettings() when $default != null:
return $default(_that.attendancePoint);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingPointsSettings implements TrainingPointsSettings {
  const _TrainingPointsSettings({@JsonKey(fromJson: _bool) this.attendancePoint = false});
  factory _TrainingPointsSettings.fromJson(Map<String, dynamic> json) => _$TrainingPointsSettingsFromJson(json);

@override@JsonKey(fromJson: _bool) final  bool attendancePoint;

/// Create a copy of TrainingPointsSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingPointsSettingsCopyWith<_TrainingPointsSettings> get copyWith => __$TrainingPointsSettingsCopyWithImpl<_TrainingPointsSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingPointsSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingPointsSettings&&(identical(other.attendancePoint, attendancePoint) || other.attendancePoint == attendancePoint));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,attendancePoint);

@override
String toString() {
  return 'TrainingPointsSettings(attendancePoint: $attendancePoint)';
}


}

/// @nodoc
abstract mixin class _$TrainingPointsSettingsCopyWith<$Res> implements $TrainingPointsSettingsCopyWith<$Res> {
  factory _$TrainingPointsSettingsCopyWith(_TrainingPointsSettings value, $Res Function(_TrainingPointsSettings) _then) = __$TrainingPointsSettingsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _bool) bool attendancePoint
});




}
/// @nodoc
class __$TrainingPointsSettingsCopyWithImpl<$Res>
    implements _$TrainingPointsSettingsCopyWith<$Res> {
  __$TrainingPointsSettingsCopyWithImpl(this._self, this._then);

  final _TrainingPointsSettings _self;
  final $Res Function(_TrainingPointsSettings) _then;

/// Create a copy of TrainingPointsSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attendancePoint = null,}) {
  return _then(_TrainingPointsSettings(
attendancePoint: null == attendancePoint ? _self.attendancePoint : attendancePoint // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ClosedSeason {

 String get label; DateTime? get closedAt;
/// Create a copy of ClosedSeason
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClosedSeasonCopyWith<ClosedSeason> get copyWith => _$ClosedSeasonCopyWithImpl<ClosedSeason>(this as ClosedSeason, _$identity);

  /// Serializes this ClosedSeason to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClosedSeason&&(identical(other.label, label) || other.label == label)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,closedAt);

@override
String toString() {
  return 'ClosedSeason(label: $label, closedAt: $closedAt)';
}


}

/// @nodoc
abstract mixin class $ClosedSeasonCopyWith<$Res>  {
  factory $ClosedSeasonCopyWith(ClosedSeason value, $Res Function(ClosedSeason) _then) = _$ClosedSeasonCopyWithImpl;
@useResult
$Res call({
 String label, DateTime? closedAt
});




}
/// @nodoc
class _$ClosedSeasonCopyWithImpl<$Res>
    implements $ClosedSeasonCopyWith<$Res> {
  _$ClosedSeasonCopyWithImpl(this._self, this._then);

  final ClosedSeason _self;
  final $Res Function(ClosedSeason) _then;

/// Create a copy of ClosedSeason
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? closedAt = freezed,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClosedSeason].
extension ClosedSeasonPatterns on ClosedSeason {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClosedSeason value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClosedSeason() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClosedSeason value)  $default,){
final _that = this;
switch (_that) {
case _ClosedSeason():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClosedSeason value)?  $default,){
final _that = this;
switch (_that) {
case _ClosedSeason() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  DateTime? closedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClosedSeason() when $default != null:
return $default(_that.label,_that.closedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  DateTime? closedAt)  $default,) {final _that = this;
switch (_that) {
case _ClosedSeason():
return $default(_that.label,_that.closedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  DateTime? closedAt)?  $default,) {final _that = this;
switch (_that) {
case _ClosedSeason() when $default != null:
return $default(_that.label,_that.closedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ClosedSeason implements ClosedSeason {
  const _ClosedSeason({this.label = '', this.closedAt});
  factory _ClosedSeason.fromJson(Map<String, dynamic> json) => _$ClosedSeasonFromJson(json);

@override@JsonKey() final  String label;
@override final  DateTime? closedAt;

/// Create a copy of ClosedSeason
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClosedSeasonCopyWith<_ClosedSeason> get copyWith => __$ClosedSeasonCopyWithImpl<_ClosedSeason>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ClosedSeasonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClosedSeason&&(identical(other.label, label) || other.label == label)&&(identical(other.closedAt, closedAt) || other.closedAt == closedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,closedAt);

@override
String toString() {
  return 'ClosedSeason(label: $label, closedAt: $closedAt)';
}


}

/// @nodoc
abstract mixin class _$ClosedSeasonCopyWith<$Res> implements $ClosedSeasonCopyWith<$Res> {
  factory _$ClosedSeasonCopyWith(_ClosedSeason value, $Res Function(_ClosedSeason) _then) = __$ClosedSeasonCopyWithImpl;
@override @useResult
$Res call({
 String label, DateTime? closedAt
});




}
/// @nodoc
class __$ClosedSeasonCopyWithImpl<$Res>
    implements _$ClosedSeasonCopyWith<$Res> {
  __$ClosedSeasonCopyWithImpl(this._self, this._then);

  final _ClosedSeason _self;
  final $Res Function(_ClosedSeason) _then;

/// Create a copy of ClosedSeason
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? closedAt = freezed,}) {
  return _then(_ClosedSeason(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,closedAt: freezed == closedAt ? _self.closedAt : closedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PeriodRow {

@JsonKey(fromJson: _int) int get id; String get name; String? get startsOn; String? get endsOn;@JsonKey(fromJson: _intOrNull) int? get targetMatches;@JsonKey(fromJson: _bool) bool get isClosed;@JsonKey(fromJson: _int) int get playedMatches;@JsonKey(fromJson: _int) int get awardCount;
/// Create a copy of PeriodRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodRowCopyWith<PeriodRow> get copyWith => _$PeriodRowCopyWithImpl<PeriodRow>(this as PeriodRow, _$identity);

  /// Serializes this PeriodRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodRow&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.targetMatches, targetMatches) || other.targetMatches == targetMatches)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.playedMatches, playedMatches) || other.playedMatches == playedMatches)&&(identical(other.awardCount, awardCount) || other.awardCount == awardCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startsOn,endsOn,targetMatches,isClosed,playedMatches,awardCount);

@override
String toString() {
  return 'PeriodRow(id: $id, name: $name, startsOn: $startsOn, endsOn: $endsOn, targetMatches: $targetMatches, isClosed: $isClosed, playedMatches: $playedMatches, awardCount: $awardCount)';
}


}

/// @nodoc
abstract mixin class $PeriodRowCopyWith<$Res>  {
  factory $PeriodRowCopyWith(PeriodRow value, $Res Function(PeriodRow) _then) = _$PeriodRowCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _int) int id, String name, String? startsOn, String? endsOn,@JsonKey(fromJson: _intOrNull) int? targetMatches,@JsonKey(fromJson: _bool) bool isClosed,@JsonKey(fromJson: _int) int playedMatches,@JsonKey(fromJson: _int) int awardCount
});




}
/// @nodoc
class _$PeriodRowCopyWithImpl<$Res>
    implements $PeriodRowCopyWith<$Res> {
  _$PeriodRowCopyWithImpl(this._self, this._then);

  final PeriodRow _self;
  final $Res Function(PeriodRow) _then;

/// Create a copy of PeriodRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? startsOn = freezed,Object? endsOn = freezed,Object? targetMatches = freezed,Object? isClosed = null,Object? playedMatches = null,Object? awardCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startsOn: freezed == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as String?,endsOn: freezed == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as String?,targetMatches: freezed == targetMatches ? _self.targetMatches : targetMatches // ignore: cast_nullable_to_non_nullable
as int?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,playedMatches: null == playedMatches ? _self.playedMatches : playedMatches // ignore: cast_nullable_to_non_nullable
as int,awardCount: null == awardCount ? _self.awardCount : awardCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PeriodRow].
extension PeriodRowPatterns on PeriodRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodRow value)  $default,){
final _that = this;
switch (_that) {
case _PeriodRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodRow value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _int)  int id,  String name,  String? startsOn,  String? endsOn, @JsonKey(fromJson: _intOrNull)  int? targetMatches, @JsonKey(fromJson: _bool)  bool isClosed, @JsonKey(fromJson: _int)  int playedMatches, @JsonKey(fromJson: _int)  int awardCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodRow() when $default != null:
return $default(_that.id,_that.name,_that.startsOn,_that.endsOn,_that.targetMatches,_that.isClosed,_that.playedMatches,_that.awardCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _int)  int id,  String name,  String? startsOn,  String? endsOn, @JsonKey(fromJson: _intOrNull)  int? targetMatches, @JsonKey(fromJson: _bool)  bool isClosed, @JsonKey(fromJson: _int)  int playedMatches, @JsonKey(fromJson: _int)  int awardCount)  $default,) {final _that = this;
switch (_that) {
case _PeriodRow():
return $default(_that.id,_that.name,_that.startsOn,_that.endsOn,_that.targetMatches,_that.isClosed,_that.playedMatches,_that.awardCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _int)  int id,  String name,  String? startsOn,  String? endsOn, @JsonKey(fromJson: _intOrNull)  int? targetMatches, @JsonKey(fromJson: _bool)  bool isClosed, @JsonKey(fromJson: _int)  int playedMatches, @JsonKey(fromJson: _int)  int awardCount)?  $default,) {final _that = this;
switch (_that) {
case _PeriodRow() when $default != null:
return $default(_that.id,_that.name,_that.startsOn,_that.endsOn,_that.targetMatches,_that.isClosed,_that.playedMatches,_that.awardCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PeriodRow implements PeriodRow {
  const _PeriodRow({@JsonKey(fromJson: _int) required this.id, this.name = '', this.startsOn, this.endsOn, @JsonKey(fromJson: _intOrNull) this.targetMatches, @JsonKey(fromJson: _bool) this.isClosed = false, @JsonKey(fromJson: _int) this.playedMatches = 0, @JsonKey(fromJson: _int) this.awardCount = 0});
  factory _PeriodRow.fromJson(Map<String, dynamic> json) => _$PeriodRowFromJson(json);

@override@JsonKey(fromJson: _int) final  int id;
@override@JsonKey() final  String name;
@override final  String? startsOn;
@override final  String? endsOn;
@override@JsonKey(fromJson: _intOrNull) final  int? targetMatches;
@override@JsonKey(fromJson: _bool) final  bool isClosed;
@override@JsonKey(fromJson: _int) final  int playedMatches;
@override@JsonKey(fromJson: _int) final  int awardCount;

/// Create a copy of PeriodRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeriodRowCopyWith<_PeriodRow> get copyWith => __$PeriodRowCopyWithImpl<_PeriodRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PeriodRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodRow&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.targetMatches, targetMatches) || other.targetMatches == targetMatches)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.playedMatches, playedMatches) || other.playedMatches == playedMatches)&&(identical(other.awardCount, awardCount) || other.awardCount == awardCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startsOn,endsOn,targetMatches,isClosed,playedMatches,awardCount);

@override
String toString() {
  return 'PeriodRow(id: $id, name: $name, startsOn: $startsOn, endsOn: $endsOn, targetMatches: $targetMatches, isClosed: $isClosed, playedMatches: $playedMatches, awardCount: $awardCount)';
}


}

/// @nodoc
abstract mixin class _$PeriodRowCopyWith<$Res> implements $PeriodRowCopyWith<$Res> {
  factory _$PeriodRowCopyWith(_PeriodRow value, $Res Function(_PeriodRow) _then) = __$PeriodRowCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _int) int id, String name, String? startsOn, String? endsOn,@JsonKey(fromJson: _intOrNull) int? targetMatches,@JsonKey(fromJson: _bool) bool isClosed,@JsonKey(fromJson: _int) int playedMatches,@JsonKey(fromJson: _int) int awardCount
});




}
/// @nodoc
class __$PeriodRowCopyWithImpl<$Res>
    implements _$PeriodRowCopyWith<$Res> {
  __$PeriodRowCopyWithImpl(this._self, this._then);

  final _PeriodRow _self;
  final $Res Function(_PeriodRow) _then;

/// Create a copy of PeriodRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? startsOn = freezed,Object? endsOn = freezed,Object? targetMatches = freezed,Object? isClosed = null,Object? playedMatches = null,Object? awardCount = null,}) {
  return _then(_PeriodRow(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,startsOn: freezed == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as String?,endsOn: freezed == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as String?,targetMatches: freezed == targetMatches ? _self.targetMatches : targetMatches // ignore: cast_nullable_to_non_nullable
as int?,isClosed: null == isClosed ? _self.isClosed : isClosed // ignore: cast_nullable_to_non_nullable
as bool,playedMatches: null == playedMatches ? _self.playedMatches : playedMatches // ignore: cast_nullable_to_non_nullable
as int,awardCount: null == awardCount ? _self.awardCount : awardCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PeriodSettings {

/// `off`, `dates` of `matches`.
 String get mode; String? get seasonLabel; String? get seasonStartsOn; String? get seasonEndsOn;@JsonKey(fromJson: _bool) bool get seasonExpired;@JsonKey(fromJson: _int) int get seasonMatchCount; ClosedSeason? get closedSeason; List<PeriodRow> get periods;
/// Create a copy of PeriodSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodSettingsCopyWith<PeriodSettings> get copyWith => _$PeriodSettingsCopyWithImpl<PeriodSettings>(this as PeriodSettings, _$identity);

  /// Serializes this PeriodSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodSettings&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.seasonLabel, seasonLabel) || other.seasonLabel == seasonLabel)&&(identical(other.seasonStartsOn, seasonStartsOn) || other.seasonStartsOn == seasonStartsOn)&&(identical(other.seasonEndsOn, seasonEndsOn) || other.seasonEndsOn == seasonEndsOn)&&(identical(other.seasonExpired, seasonExpired) || other.seasonExpired == seasonExpired)&&(identical(other.seasonMatchCount, seasonMatchCount) || other.seasonMatchCount == seasonMatchCount)&&(identical(other.closedSeason, closedSeason) || other.closedSeason == closedSeason)&&const DeepCollectionEquality().equals(other.periods, periods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,seasonLabel,seasonStartsOn,seasonEndsOn,seasonExpired,seasonMatchCount,closedSeason,const DeepCollectionEquality().hash(periods));

@override
String toString() {
  return 'PeriodSettings(mode: $mode, seasonLabel: $seasonLabel, seasonStartsOn: $seasonStartsOn, seasonEndsOn: $seasonEndsOn, seasonExpired: $seasonExpired, seasonMatchCount: $seasonMatchCount, closedSeason: $closedSeason, periods: $periods)';
}


}

/// @nodoc
abstract mixin class $PeriodSettingsCopyWith<$Res>  {
  factory $PeriodSettingsCopyWith(PeriodSettings value, $Res Function(PeriodSettings) _then) = _$PeriodSettingsCopyWithImpl;
@useResult
$Res call({
 String mode, String? seasonLabel, String? seasonStartsOn, String? seasonEndsOn,@JsonKey(fromJson: _bool) bool seasonExpired,@JsonKey(fromJson: _int) int seasonMatchCount, ClosedSeason? closedSeason, List<PeriodRow> periods
});


$ClosedSeasonCopyWith<$Res>? get closedSeason;

}
/// @nodoc
class _$PeriodSettingsCopyWithImpl<$Res>
    implements $PeriodSettingsCopyWith<$Res> {
  _$PeriodSettingsCopyWithImpl(this._self, this._then);

  final PeriodSettings _self;
  final $Res Function(PeriodSettings) _then;

/// Create a copy of PeriodSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? seasonLabel = freezed,Object? seasonStartsOn = freezed,Object? seasonEndsOn = freezed,Object? seasonExpired = null,Object? seasonMatchCount = null,Object? closedSeason = freezed,Object? periods = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,seasonLabel: freezed == seasonLabel ? _self.seasonLabel : seasonLabel // ignore: cast_nullable_to_non_nullable
as String?,seasonStartsOn: freezed == seasonStartsOn ? _self.seasonStartsOn : seasonStartsOn // ignore: cast_nullable_to_non_nullable
as String?,seasonEndsOn: freezed == seasonEndsOn ? _self.seasonEndsOn : seasonEndsOn // ignore: cast_nullable_to_non_nullable
as String?,seasonExpired: null == seasonExpired ? _self.seasonExpired : seasonExpired // ignore: cast_nullable_to_non_nullable
as bool,seasonMatchCount: null == seasonMatchCount ? _self.seasonMatchCount : seasonMatchCount // ignore: cast_nullable_to_non_nullable
as int,closedSeason: freezed == closedSeason ? _self.closedSeason : closedSeason // ignore: cast_nullable_to_non_nullable
as ClosedSeason?,periods: null == periods ? _self.periods : periods // ignore: cast_nullable_to_non_nullable
as List<PeriodRow>,
  ));
}
/// Create a copy of PeriodSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClosedSeasonCopyWith<$Res>? get closedSeason {
    if (_self.closedSeason == null) {
    return null;
  }

  return $ClosedSeasonCopyWith<$Res>(_self.closedSeason!, (value) {
    return _then(_self.copyWith(closedSeason: value));
  });
}
}


/// Adds pattern-matching-related methods to [PeriodSettings].
extension PeriodSettingsPatterns on PeriodSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodSettings value)  $default,){
final _that = this;
switch (_that) {
case _PeriodSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodSettings value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String mode,  String? seasonLabel,  String? seasonStartsOn,  String? seasonEndsOn, @JsonKey(fromJson: _bool)  bool seasonExpired, @JsonKey(fromJson: _int)  int seasonMatchCount,  ClosedSeason? closedSeason,  List<PeriodRow> periods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodSettings() when $default != null:
return $default(_that.mode,_that.seasonLabel,_that.seasonStartsOn,_that.seasonEndsOn,_that.seasonExpired,_that.seasonMatchCount,_that.closedSeason,_that.periods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String mode,  String? seasonLabel,  String? seasonStartsOn,  String? seasonEndsOn, @JsonKey(fromJson: _bool)  bool seasonExpired, @JsonKey(fromJson: _int)  int seasonMatchCount,  ClosedSeason? closedSeason,  List<PeriodRow> periods)  $default,) {final _that = this;
switch (_that) {
case _PeriodSettings():
return $default(_that.mode,_that.seasonLabel,_that.seasonStartsOn,_that.seasonEndsOn,_that.seasonExpired,_that.seasonMatchCount,_that.closedSeason,_that.periods);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String mode,  String? seasonLabel,  String? seasonStartsOn,  String? seasonEndsOn, @JsonKey(fromJson: _bool)  bool seasonExpired, @JsonKey(fromJson: _int)  int seasonMatchCount,  ClosedSeason? closedSeason,  List<PeriodRow> periods)?  $default,) {final _that = this;
switch (_that) {
case _PeriodSettings() when $default != null:
return $default(_that.mode,_that.seasonLabel,_that.seasonStartsOn,_that.seasonEndsOn,_that.seasonExpired,_that.seasonMatchCount,_that.closedSeason,_that.periods);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PeriodSettings implements PeriodSettings {
  const _PeriodSettings({this.mode = 'off', this.seasonLabel, this.seasonStartsOn, this.seasonEndsOn, @JsonKey(fromJson: _bool) this.seasonExpired = false, @JsonKey(fromJson: _int) this.seasonMatchCount = 0, this.closedSeason, final  List<PeriodRow> periods = const <PeriodRow>[]}): _periods = periods;
  factory _PeriodSettings.fromJson(Map<String, dynamic> json) => _$PeriodSettingsFromJson(json);

/// `off`, `dates` of `matches`.
@override@JsonKey() final  String mode;
@override final  String? seasonLabel;
@override final  String? seasonStartsOn;
@override final  String? seasonEndsOn;
@override@JsonKey(fromJson: _bool) final  bool seasonExpired;
@override@JsonKey(fromJson: _int) final  int seasonMatchCount;
@override final  ClosedSeason? closedSeason;
 final  List<PeriodRow> _periods;
@override@JsonKey() List<PeriodRow> get periods {
  if (_periods is EqualUnmodifiableListView) return _periods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_periods);
}


/// Create a copy of PeriodSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeriodSettingsCopyWith<_PeriodSettings> get copyWith => __$PeriodSettingsCopyWithImpl<_PeriodSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PeriodSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodSettings&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.seasonLabel, seasonLabel) || other.seasonLabel == seasonLabel)&&(identical(other.seasonStartsOn, seasonStartsOn) || other.seasonStartsOn == seasonStartsOn)&&(identical(other.seasonEndsOn, seasonEndsOn) || other.seasonEndsOn == seasonEndsOn)&&(identical(other.seasonExpired, seasonExpired) || other.seasonExpired == seasonExpired)&&(identical(other.seasonMatchCount, seasonMatchCount) || other.seasonMatchCount == seasonMatchCount)&&(identical(other.closedSeason, closedSeason) || other.closedSeason == closedSeason)&&const DeepCollectionEquality().equals(other._periods, _periods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,seasonLabel,seasonStartsOn,seasonEndsOn,seasonExpired,seasonMatchCount,closedSeason,const DeepCollectionEquality().hash(_periods));

@override
String toString() {
  return 'PeriodSettings(mode: $mode, seasonLabel: $seasonLabel, seasonStartsOn: $seasonStartsOn, seasonEndsOn: $seasonEndsOn, seasonExpired: $seasonExpired, seasonMatchCount: $seasonMatchCount, closedSeason: $closedSeason, periods: $periods)';
}


}

/// @nodoc
abstract mixin class _$PeriodSettingsCopyWith<$Res> implements $PeriodSettingsCopyWith<$Res> {
  factory _$PeriodSettingsCopyWith(_PeriodSettings value, $Res Function(_PeriodSettings) _then) = __$PeriodSettingsCopyWithImpl;
@override @useResult
$Res call({
 String mode, String? seasonLabel, String? seasonStartsOn, String? seasonEndsOn,@JsonKey(fromJson: _bool) bool seasonExpired,@JsonKey(fromJson: _int) int seasonMatchCount, ClosedSeason? closedSeason, List<PeriodRow> periods
});


@override $ClosedSeasonCopyWith<$Res>? get closedSeason;

}
/// @nodoc
class __$PeriodSettingsCopyWithImpl<$Res>
    implements _$PeriodSettingsCopyWith<$Res> {
  __$PeriodSettingsCopyWithImpl(this._self, this._then);

  final _PeriodSettings _self;
  final $Res Function(_PeriodSettings) _then;

/// Create a copy of PeriodSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? seasonLabel = freezed,Object? seasonStartsOn = freezed,Object? seasonEndsOn = freezed,Object? seasonExpired = null,Object? seasonMatchCount = null,Object? closedSeason = freezed,Object? periods = null,}) {
  return _then(_PeriodSettings(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,seasonLabel: freezed == seasonLabel ? _self.seasonLabel : seasonLabel // ignore: cast_nullable_to_non_nullable
as String?,seasonStartsOn: freezed == seasonStartsOn ? _self.seasonStartsOn : seasonStartsOn // ignore: cast_nullable_to_non_nullable
as String?,seasonEndsOn: freezed == seasonEndsOn ? _self.seasonEndsOn : seasonEndsOn // ignore: cast_nullable_to_non_nullable
as String?,seasonExpired: null == seasonExpired ? _self.seasonExpired : seasonExpired // ignore: cast_nullable_to_non_nullable
as bool,seasonMatchCount: null == seasonMatchCount ? _self.seasonMatchCount : seasonMatchCount // ignore: cast_nullable_to_non_nullable
as int,closedSeason: freezed == closedSeason ? _self.closedSeason : closedSeason // ignore: cast_nullable_to_non_nullable
as ClosedSeason?,periods: null == periods ? _self._periods : periods // ignore: cast_nullable_to_non_nullable
as List<PeriodRow>,
  ));
}

/// Create a copy of PeriodSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClosedSeasonCopyWith<$Res>? get closedSeason {
    if (_self.closedSeason == null) {
    return null;
  }

  return $ClosedSeasonCopyWith<$Res>(_self.closedSeason!, (value) {
    return _then(_self.copyWith(closedSeason: value));
  });
}
}


/// @nodoc
mixin _$TeamSettings {

 SettingsTeam get team;@JsonKey(fromJson: _strings) List<String> get formations; RsvpSettings get rsvp; List<SettingsFeature> get features; List<DutyTypeSetting> get dutyTypes; List<DutyPerson> get dutyPeople; IcalLinks get ical; CarpoolSettings get carpool; GuestSettings get guests; TrainingPointsSettings get trainingPoints; PeriodSettings get period;
/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamSettingsCopyWith<TeamSettings> get copyWith => _$TeamSettingsCopyWithImpl<TeamSettings>(this as TeamSettings, _$identity);

  /// Serializes this TeamSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamSettings&&(identical(other.team, team) || other.team == team)&&const DeepCollectionEquality().equals(other.formations, formations)&&(identical(other.rsvp, rsvp) || other.rsvp == rsvp)&&const DeepCollectionEquality().equals(other.features, features)&&const DeepCollectionEquality().equals(other.dutyTypes, dutyTypes)&&const DeepCollectionEquality().equals(other.dutyPeople, dutyPeople)&&(identical(other.ical, ical) || other.ical == ical)&&(identical(other.carpool, carpool) || other.carpool == carpool)&&(identical(other.guests, guests) || other.guests == guests)&&(identical(other.trainingPoints, trainingPoints) || other.trainingPoints == trainingPoints)&&(identical(other.period, period) || other.period == period));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,const DeepCollectionEquality().hash(formations),rsvp,const DeepCollectionEquality().hash(features),const DeepCollectionEquality().hash(dutyTypes),const DeepCollectionEquality().hash(dutyPeople),ical,carpool,guests,trainingPoints,period);

@override
String toString() {
  return 'TeamSettings(team: $team, formations: $formations, rsvp: $rsvp, features: $features, dutyTypes: $dutyTypes, dutyPeople: $dutyPeople, ical: $ical, carpool: $carpool, guests: $guests, trainingPoints: $trainingPoints, period: $period)';
}


}

/// @nodoc
abstract mixin class $TeamSettingsCopyWith<$Res>  {
  factory $TeamSettingsCopyWith(TeamSettings value, $Res Function(TeamSettings) _then) = _$TeamSettingsCopyWithImpl;
@useResult
$Res call({
 SettingsTeam team,@JsonKey(fromJson: _strings) List<String> formations, RsvpSettings rsvp, List<SettingsFeature> features, List<DutyTypeSetting> dutyTypes, List<DutyPerson> dutyPeople, IcalLinks ical, CarpoolSettings carpool, GuestSettings guests, TrainingPointsSettings trainingPoints, PeriodSettings period
});


$SettingsTeamCopyWith<$Res> get team;$RsvpSettingsCopyWith<$Res> get rsvp;$IcalLinksCopyWith<$Res> get ical;$CarpoolSettingsCopyWith<$Res> get carpool;$GuestSettingsCopyWith<$Res> get guests;$TrainingPointsSettingsCopyWith<$Res> get trainingPoints;$PeriodSettingsCopyWith<$Res> get period;

}
/// @nodoc
class _$TeamSettingsCopyWithImpl<$Res>
    implements $TeamSettingsCopyWith<$Res> {
  _$TeamSettingsCopyWithImpl(this._self, this._then);

  final TeamSettings _self;
  final $Res Function(TeamSettings) _then;

/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? team = null,Object? formations = null,Object? rsvp = null,Object? features = null,Object? dutyTypes = null,Object? dutyPeople = null,Object? ical = null,Object? carpool = null,Object? guests = null,Object? trainingPoints = null,Object? period = null,}) {
  return _then(_self.copyWith(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as SettingsTeam,formations: null == formations ? _self.formations : formations // ignore: cast_nullable_to_non_nullable
as List<String>,rsvp: null == rsvp ? _self.rsvp : rsvp // ignore: cast_nullable_to_non_nullable
as RsvpSettings,features: null == features ? _self.features : features // ignore: cast_nullable_to_non_nullable
as List<SettingsFeature>,dutyTypes: null == dutyTypes ? _self.dutyTypes : dutyTypes // ignore: cast_nullable_to_non_nullable
as List<DutyTypeSetting>,dutyPeople: null == dutyPeople ? _self.dutyPeople : dutyPeople // ignore: cast_nullable_to_non_nullable
as List<DutyPerson>,ical: null == ical ? _self.ical : ical // ignore: cast_nullable_to_non_nullable
as IcalLinks,carpool: null == carpool ? _self.carpool : carpool // ignore: cast_nullable_to_non_nullable
as CarpoolSettings,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as GuestSettings,trainingPoints: null == trainingPoints ? _self.trainingPoints : trainingPoints // ignore: cast_nullable_to_non_nullable
as TrainingPointsSettings,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as PeriodSettings,
  ));
}
/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SettingsTeamCopyWith<$Res> get team {
  
  return $SettingsTeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RsvpSettingsCopyWith<$Res> get rsvp {
  
  return $RsvpSettingsCopyWith<$Res>(_self.rsvp, (value) {
    return _then(_self.copyWith(rsvp: value));
  });
}/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IcalLinksCopyWith<$Res> get ical {
  
  return $IcalLinksCopyWith<$Res>(_self.ical, (value) {
    return _then(_self.copyWith(ical: value));
  });
}/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CarpoolSettingsCopyWith<$Res> get carpool {
  
  return $CarpoolSettingsCopyWith<$Res>(_self.carpool, (value) {
    return _then(_self.copyWith(carpool: value));
  });
}/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuestSettingsCopyWith<$Res> get guests {
  
  return $GuestSettingsCopyWith<$Res>(_self.guests, (value) {
    return _then(_self.copyWith(guests: value));
  });
}/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrainingPointsSettingsCopyWith<$Res> get trainingPoints {
  
  return $TrainingPointsSettingsCopyWith<$Res>(_self.trainingPoints, (value) {
    return _then(_self.copyWith(trainingPoints: value));
  });
}/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeriodSettingsCopyWith<$Res> get period {
  
  return $PeriodSettingsCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}
}


/// Adds pattern-matching-related methods to [TeamSettings].
extension TeamSettingsPatterns on TeamSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamSettings value)  $default,){
final _that = this;
switch (_that) {
case _TeamSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamSettings value)?  $default,){
final _that = this;
switch (_that) {
case _TeamSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SettingsTeam team, @JsonKey(fromJson: _strings)  List<String> formations,  RsvpSettings rsvp,  List<SettingsFeature> features,  List<DutyTypeSetting> dutyTypes,  List<DutyPerson> dutyPeople,  IcalLinks ical,  CarpoolSettings carpool,  GuestSettings guests,  TrainingPointsSettings trainingPoints,  PeriodSettings period)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamSettings() when $default != null:
return $default(_that.team,_that.formations,_that.rsvp,_that.features,_that.dutyTypes,_that.dutyPeople,_that.ical,_that.carpool,_that.guests,_that.trainingPoints,_that.period);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SettingsTeam team, @JsonKey(fromJson: _strings)  List<String> formations,  RsvpSettings rsvp,  List<SettingsFeature> features,  List<DutyTypeSetting> dutyTypes,  List<DutyPerson> dutyPeople,  IcalLinks ical,  CarpoolSettings carpool,  GuestSettings guests,  TrainingPointsSettings trainingPoints,  PeriodSettings period)  $default,) {final _that = this;
switch (_that) {
case _TeamSettings():
return $default(_that.team,_that.formations,_that.rsvp,_that.features,_that.dutyTypes,_that.dutyPeople,_that.ical,_that.carpool,_that.guests,_that.trainingPoints,_that.period);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SettingsTeam team, @JsonKey(fromJson: _strings)  List<String> formations,  RsvpSettings rsvp,  List<SettingsFeature> features,  List<DutyTypeSetting> dutyTypes,  List<DutyPerson> dutyPeople,  IcalLinks ical,  CarpoolSettings carpool,  GuestSettings guests,  TrainingPointsSettings trainingPoints,  PeriodSettings period)?  $default,) {final _that = this;
switch (_that) {
case _TeamSettings() when $default != null:
return $default(_that.team,_that.formations,_that.rsvp,_that.features,_that.dutyTypes,_that.dutyPeople,_that.ical,_that.carpool,_that.guests,_that.trainingPoints,_that.period);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamSettings extends TeamSettings {
  const _TeamSettings({this.team = const SettingsTeam(), @JsonKey(fromJson: _strings) final  List<String> formations = const <String>[], this.rsvp = const RsvpSettings(), final  List<SettingsFeature> features = const <SettingsFeature>[], final  List<DutyTypeSetting> dutyTypes = const <DutyTypeSetting>[], final  List<DutyPerson> dutyPeople = const <DutyPerson>[], this.ical = const IcalLinks(), this.carpool = const CarpoolSettings(), this.guests = const GuestSettings(), this.trainingPoints = const TrainingPointsSettings(), this.period = const PeriodSettings()}): _formations = formations,_features = features,_dutyTypes = dutyTypes,_dutyPeople = dutyPeople,super._();
  factory _TeamSettings.fromJson(Map<String, dynamic> json) => _$TeamSettingsFromJson(json);

@override@JsonKey() final  SettingsTeam team;
 final  List<String> _formations;
@override@JsonKey(fromJson: _strings) List<String> get formations {
  if (_formations is EqualUnmodifiableListView) return _formations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_formations);
}

@override@JsonKey() final  RsvpSettings rsvp;
 final  List<SettingsFeature> _features;
@override@JsonKey() List<SettingsFeature> get features {
  if (_features is EqualUnmodifiableListView) return _features;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_features);
}

 final  List<DutyTypeSetting> _dutyTypes;
@override@JsonKey() List<DutyTypeSetting> get dutyTypes {
  if (_dutyTypes is EqualUnmodifiableListView) return _dutyTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dutyTypes);
}

 final  List<DutyPerson> _dutyPeople;
@override@JsonKey() List<DutyPerson> get dutyPeople {
  if (_dutyPeople is EqualUnmodifiableListView) return _dutyPeople;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dutyPeople);
}

@override@JsonKey() final  IcalLinks ical;
@override@JsonKey() final  CarpoolSettings carpool;
@override@JsonKey() final  GuestSettings guests;
@override@JsonKey() final  TrainingPointsSettings trainingPoints;
@override@JsonKey() final  PeriodSettings period;

/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamSettingsCopyWith<_TeamSettings> get copyWith => __$TeamSettingsCopyWithImpl<_TeamSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamSettings&&(identical(other.team, team) || other.team == team)&&const DeepCollectionEquality().equals(other._formations, _formations)&&(identical(other.rsvp, rsvp) || other.rsvp == rsvp)&&const DeepCollectionEquality().equals(other._features, _features)&&const DeepCollectionEquality().equals(other._dutyTypes, _dutyTypes)&&const DeepCollectionEquality().equals(other._dutyPeople, _dutyPeople)&&(identical(other.ical, ical) || other.ical == ical)&&(identical(other.carpool, carpool) || other.carpool == carpool)&&(identical(other.guests, guests) || other.guests == guests)&&(identical(other.trainingPoints, trainingPoints) || other.trainingPoints == trainingPoints)&&(identical(other.period, period) || other.period == period));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,team,const DeepCollectionEquality().hash(_formations),rsvp,const DeepCollectionEquality().hash(_features),const DeepCollectionEquality().hash(_dutyTypes),const DeepCollectionEquality().hash(_dutyPeople),ical,carpool,guests,trainingPoints,period);

@override
String toString() {
  return 'TeamSettings(team: $team, formations: $formations, rsvp: $rsvp, features: $features, dutyTypes: $dutyTypes, dutyPeople: $dutyPeople, ical: $ical, carpool: $carpool, guests: $guests, trainingPoints: $trainingPoints, period: $period)';
}


}

/// @nodoc
abstract mixin class _$TeamSettingsCopyWith<$Res> implements $TeamSettingsCopyWith<$Res> {
  factory _$TeamSettingsCopyWith(_TeamSettings value, $Res Function(_TeamSettings) _then) = __$TeamSettingsCopyWithImpl;
@override @useResult
$Res call({
 SettingsTeam team,@JsonKey(fromJson: _strings) List<String> formations, RsvpSettings rsvp, List<SettingsFeature> features, List<DutyTypeSetting> dutyTypes, List<DutyPerson> dutyPeople, IcalLinks ical, CarpoolSettings carpool, GuestSettings guests, TrainingPointsSettings trainingPoints, PeriodSettings period
});


@override $SettingsTeamCopyWith<$Res> get team;@override $RsvpSettingsCopyWith<$Res> get rsvp;@override $IcalLinksCopyWith<$Res> get ical;@override $CarpoolSettingsCopyWith<$Res> get carpool;@override $GuestSettingsCopyWith<$Res> get guests;@override $TrainingPointsSettingsCopyWith<$Res> get trainingPoints;@override $PeriodSettingsCopyWith<$Res> get period;

}
/// @nodoc
class __$TeamSettingsCopyWithImpl<$Res>
    implements _$TeamSettingsCopyWith<$Res> {
  __$TeamSettingsCopyWithImpl(this._self, this._then);

  final _TeamSettings _self;
  final $Res Function(_TeamSettings) _then;

/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? team = null,Object? formations = null,Object? rsvp = null,Object? features = null,Object? dutyTypes = null,Object? dutyPeople = null,Object? ical = null,Object? carpool = null,Object? guests = null,Object? trainingPoints = null,Object? period = null,}) {
  return _then(_TeamSettings(
team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as SettingsTeam,formations: null == formations ? _self._formations : formations // ignore: cast_nullable_to_non_nullable
as List<String>,rsvp: null == rsvp ? _self.rsvp : rsvp // ignore: cast_nullable_to_non_nullable
as RsvpSettings,features: null == features ? _self._features : features // ignore: cast_nullable_to_non_nullable
as List<SettingsFeature>,dutyTypes: null == dutyTypes ? _self._dutyTypes : dutyTypes // ignore: cast_nullable_to_non_nullable
as List<DutyTypeSetting>,dutyPeople: null == dutyPeople ? _self._dutyPeople : dutyPeople // ignore: cast_nullable_to_non_nullable
as List<DutyPerson>,ical: null == ical ? _self.ical : ical // ignore: cast_nullable_to_non_nullable
as IcalLinks,carpool: null == carpool ? _self.carpool : carpool // ignore: cast_nullable_to_non_nullable
as CarpoolSettings,guests: null == guests ? _self.guests : guests // ignore: cast_nullable_to_non_nullable
as GuestSettings,trainingPoints: null == trainingPoints ? _self.trainingPoints : trainingPoints // ignore: cast_nullable_to_non_nullable
as TrainingPointsSettings,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as PeriodSettings,
  ));
}

/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SettingsTeamCopyWith<$Res> get team {
  
  return $SettingsTeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RsvpSettingsCopyWith<$Res> get rsvp {
  
  return $RsvpSettingsCopyWith<$Res>(_self.rsvp, (value) {
    return _then(_self.copyWith(rsvp: value));
  });
}/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IcalLinksCopyWith<$Res> get ical {
  
  return $IcalLinksCopyWith<$Res>(_self.ical, (value) {
    return _then(_self.copyWith(ical: value));
  });
}/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CarpoolSettingsCopyWith<$Res> get carpool {
  
  return $CarpoolSettingsCopyWith<$Res>(_self.carpool, (value) {
    return _then(_self.copyWith(carpool: value));
  });
}/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GuestSettingsCopyWith<$Res> get guests {
  
  return $GuestSettingsCopyWith<$Res>(_self.guests, (value) {
    return _then(_self.copyWith(guests: value));
  });
}/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrainingPointsSettingsCopyWith<$Res> get trainingPoints {
  
  return $TrainingPointsSettingsCopyWith<$Res>(_self.trainingPoints, (value) {
    return _then(_self.copyWith(trainingPoints: value));
  });
}/// Create a copy of TeamSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PeriodSettingsCopyWith<$Res> get period {
  
  return $PeriodSettingsCopyWith<$Res>(_self.period, (value) {
    return _then(_self.copyWith(period: value));
  });
}
}

// dart format on
