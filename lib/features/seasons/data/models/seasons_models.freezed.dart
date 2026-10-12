// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'seasons_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Season {

@JsonKey(fromJson: _int) int get id; String get label;/// `YYYY-MM-DD`.
@JsonKey(fromJson: _stringOrNull) String? get startsOn;@JsonKey(fromJson: _stringOrNull) String? get endsOn;@JsonKey(fromJson: _bool) bool get isActive;/// Einddatum voorbij terwijl het seizoen nog actief staat.
@JsonKey(fromJson: _bool) bool get expired;@JsonKey(fromJson: _int) int get matchCount;
/// Create a copy of Season
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeasonCopyWith<Season> get copyWith => _$SeasonCopyWithImpl<Season>(this as Season, _$identity);

  /// Serializes this Season to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Season&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.expired, expired) || other.expired == expired)&&(identical(other.matchCount, matchCount) || other.matchCount == matchCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,startsOn,endsOn,isActive,expired,matchCount);

@override
String toString() {
  return 'Season(id: $id, label: $label, startsOn: $startsOn, endsOn: $endsOn, isActive: $isActive, expired: $expired, matchCount: $matchCount)';
}


}

/// @nodoc
abstract mixin class $SeasonCopyWith<$Res>  {
  factory $SeasonCopyWith(Season value, $Res Function(Season) _then) = _$SeasonCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _int) int id, String label,@JsonKey(fromJson: _stringOrNull) String? startsOn,@JsonKey(fromJson: _stringOrNull) String? endsOn,@JsonKey(fromJson: _bool) bool isActive,@JsonKey(fromJson: _bool) bool expired,@JsonKey(fromJson: _int) int matchCount
});




}
/// @nodoc
class _$SeasonCopyWithImpl<$Res>
    implements $SeasonCopyWith<$Res> {
  _$SeasonCopyWithImpl(this._self, this._then);

  final Season _self;
  final $Res Function(Season) _then;

/// Create a copy of Season
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? label = null,Object? startsOn = freezed,Object? endsOn = freezed,Object? isActive = null,Object? expired = null,Object? matchCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,startsOn: freezed == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as String?,endsOn: freezed == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,expired: null == expired ? _self.expired : expired // ignore: cast_nullable_to_non_nullable
as bool,matchCount: null == matchCount ? _self.matchCount : matchCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Season].
extension SeasonPatterns on Season {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Season value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Season() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Season value)  $default,){
final _that = this;
switch (_that) {
case _Season():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Season value)?  $default,){
final _that = this;
switch (_that) {
case _Season() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _int)  int id,  String label, @JsonKey(fromJson: _stringOrNull)  String? startsOn, @JsonKey(fromJson: _stringOrNull)  String? endsOn, @JsonKey(fromJson: _bool)  bool isActive, @JsonKey(fromJson: _bool)  bool expired, @JsonKey(fromJson: _int)  int matchCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Season() when $default != null:
return $default(_that.id,_that.label,_that.startsOn,_that.endsOn,_that.isActive,_that.expired,_that.matchCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _int)  int id,  String label, @JsonKey(fromJson: _stringOrNull)  String? startsOn, @JsonKey(fromJson: _stringOrNull)  String? endsOn, @JsonKey(fromJson: _bool)  bool isActive, @JsonKey(fromJson: _bool)  bool expired, @JsonKey(fromJson: _int)  int matchCount)  $default,) {final _that = this;
switch (_that) {
case _Season():
return $default(_that.id,_that.label,_that.startsOn,_that.endsOn,_that.isActive,_that.expired,_that.matchCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _int)  int id,  String label, @JsonKey(fromJson: _stringOrNull)  String? startsOn, @JsonKey(fromJson: _stringOrNull)  String? endsOn, @JsonKey(fromJson: _bool)  bool isActive, @JsonKey(fromJson: _bool)  bool expired, @JsonKey(fromJson: _int)  int matchCount)?  $default,) {final _that = this;
switch (_that) {
case _Season() when $default != null:
return $default(_that.id,_that.label,_that.startsOn,_that.endsOn,_that.isActive,_that.expired,_that.matchCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Season implements Season {
  const _Season({@JsonKey(fromJson: _int) this.id = 0, this.label = '', @JsonKey(fromJson: _stringOrNull) this.startsOn, @JsonKey(fromJson: _stringOrNull) this.endsOn, @JsonKey(fromJson: _bool) this.isActive = false, @JsonKey(fromJson: _bool) this.expired = false, @JsonKey(fromJson: _int) this.matchCount = 0});
  factory _Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

@override@JsonKey(fromJson: _int) final  int id;
@override@JsonKey() final  String label;
/// `YYYY-MM-DD`.
@override@JsonKey(fromJson: _stringOrNull) final  String? startsOn;
@override@JsonKey(fromJson: _stringOrNull) final  String? endsOn;
@override@JsonKey(fromJson: _bool) final  bool isActive;
/// Einddatum voorbij terwijl het seizoen nog actief staat.
@override@JsonKey(fromJson: _bool) final  bool expired;
@override@JsonKey(fromJson: _int) final  int matchCount;

/// Create a copy of Season
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeasonCopyWith<_Season> get copyWith => __$SeasonCopyWithImpl<_Season>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeasonToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Season&&(identical(other.id, id) || other.id == id)&&(identical(other.label, label) || other.label == label)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.expired, expired) || other.expired == expired)&&(identical(other.matchCount, matchCount) || other.matchCount == matchCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,label,startsOn,endsOn,isActive,expired,matchCount);

@override
String toString() {
  return 'Season(id: $id, label: $label, startsOn: $startsOn, endsOn: $endsOn, isActive: $isActive, expired: $expired, matchCount: $matchCount)';
}


}

/// @nodoc
abstract mixin class _$SeasonCopyWith<$Res> implements $SeasonCopyWith<$Res> {
  factory _$SeasonCopyWith(_Season value, $Res Function(_Season) _then) = __$SeasonCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _int) int id, String label,@JsonKey(fromJson: _stringOrNull) String? startsOn,@JsonKey(fromJson: _stringOrNull) String? endsOn,@JsonKey(fromJson: _bool) bool isActive,@JsonKey(fromJson: _bool) bool expired,@JsonKey(fromJson: _int) int matchCount
});




}
/// @nodoc
class __$SeasonCopyWithImpl<$Res>
    implements _$SeasonCopyWith<$Res> {
  __$SeasonCopyWithImpl(this._self, this._then);

  final _Season _self;
  final $Res Function(_Season) _then;

/// Create a copy of Season
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? label = null,Object? startsOn = freezed,Object? endsOn = freezed,Object? isActive = null,Object? expired = null,Object? matchCount = null,}) {
  return _then(_Season(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,startsOn: freezed == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as String?,endsOn: freezed == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,expired: null == expired ? _self.expired : expired // ignore: cast_nullable_to_non_nullable
as bool,matchCount: null == matchCount ? _self.matchCount : matchCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ClosedSeason {

 String get label;/// ISO-8601 met offset.
@JsonKey(fromJson: _stringOrNull) String? get closedAt;
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
 String label,@JsonKey(fromJson: _stringOrNull) String? closedAt
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
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label, @JsonKey(fromJson: _stringOrNull)  String? closedAt)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label, @JsonKey(fromJson: _stringOrNull)  String? closedAt)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label, @JsonKey(fromJson: _stringOrNull)  String? closedAt)?  $default,) {final _that = this;
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
  const _ClosedSeason({this.label = '', @JsonKey(fromJson: _stringOrNull) this.closedAt});
  factory _ClosedSeason.fromJson(Map<String, dynamic> json) => _$ClosedSeasonFromJson(json);

@override@JsonKey() final  String label;
/// ISO-8601 met offset.
@override@JsonKey(fromJson: _stringOrNull) final  String? closedAt;

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
 String label,@JsonKey(fromJson: _stringOrNull) String? closedAt
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
as String?,
  ));
}


}


/// @nodoc
mixin _$SeasonPeriod {

@JsonKey(fromJson: _int) int get id; String get name;@JsonKey(fromJson: _stringOrNull) String? get startsOn;/// `null` in de modus `matches` zolang de periode niet vol is.
@JsonKey(fromJson: _stringOrNull) String? get endsOn;@JsonKey(fromJson: _intOrNull) int? get targetMatches;@JsonKey(fromJson: _bool) bool get isClosed;@JsonKey(fromJson: _int) int get playedMatches;@JsonKey(fromJson: _int) int get awardCount;
/// Create a copy of SeasonPeriod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeasonPeriodCopyWith<SeasonPeriod> get copyWith => _$SeasonPeriodCopyWithImpl<SeasonPeriod>(this as SeasonPeriod, _$identity);

  /// Serializes this SeasonPeriod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeasonPeriod&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.targetMatches, targetMatches) || other.targetMatches == targetMatches)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.playedMatches, playedMatches) || other.playedMatches == playedMatches)&&(identical(other.awardCount, awardCount) || other.awardCount == awardCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startsOn,endsOn,targetMatches,isClosed,playedMatches,awardCount);

@override
String toString() {
  return 'SeasonPeriod(id: $id, name: $name, startsOn: $startsOn, endsOn: $endsOn, targetMatches: $targetMatches, isClosed: $isClosed, playedMatches: $playedMatches, awardCount: $awardCount)';
}


}

/// @nodoc
abstract mixin class $SeasonPeriodCopyWith<$Res>  {
  factory $SeasonPeriodCopyWith(SeasonPeriod value, $Res Function(SeasonPeriod) _then) = _$SeasonPeriodCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _int) int id, String name,@JsonKey(fromJson: _stringOrNull) String? startsOn,@JsonKey(fromJson: _stringOrNull) String? endsOn,@JsonKey(fromJson: _intOrNull) int? targetMatches,@JsonKey(fromJson: _bool) bool isClosed,@JsonKey(fromJson: _int) int playedMatches,@JsonKey(fromJson: _int) int awardCount
});




}
/// @nodoc
class _$SeasonPeriodCopyWithImpl<$Res>
    implements $SeasonPeriodCopyWith<$Res> {
  _$SeasonPeriodCopyWithImpl(this._self, this._then);

  final SeasonPeriod _self;
  final $Res Function(SeasonPeriod) _then;

/// Create a copy of SeasonPeriod
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


/// Adds pattern-matching-related methods to [SeasonPeriod].
extension SeasonPeriodPatterns on SeasonPeriod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeasonPeriod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeasonPeriod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeasonPeriod value)  $default,){
final _that = this;
switch (_that) {
case _SeasonPeriod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeasonPeriod value)?  $default,){
final _that = this;
switch (_that) {
case _SeasonPeriod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _int)  int id,  String name, @JsonKey(fromJson: _stringOrNull)  String? startsOn, @JsonKey(fromJson: _stringOrNull)  String? endsOn, @JsonKey(fromJson: _intOrNull)  int? targetMatches, @JsonKey(fromJson: _bool)  bool isClosed, @JsonKey(fromJson: _int)  int playedMatches, @JsonKey(fromJson: _int)  int awardCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeasonPeriod() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _int)  int id,  String name, @JsonKey(fromJson: _stringOrNull)  String? startsOn, @JsonKey(fromJson: _stringOrNull)  String? endsOn, @JsonKey(fromJson: _intOrNull)  int? targetMatches, @JsonKey(fromJson: _bool)  bool isClosed, @JsonKey(fromJson: _int)  int playedMatches, @JsonKey(fromJson: _int)  int awardCount)  $default,) {final _that = this;
switch (_that) {
case _SeasonPeriod():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _int)  int id,  String name, @JsonKey(fromJson: _stringOrNull)  String? startsOn, @JsonKey(fromJson: _stringOrNull)  String? endsOn, @JsonKey(fromJson: _intOrNull)  int? targetMatches, @JsonKey(fromJson: _bool)  bool isClosed, @JsonKey(fromJson: _int)  int playedMatches, @JsonKey(fromJson: _int)  int awardCount)?  $default,) {final _that = this;
switch (_that) {
case _SeasonPeriod() when $default != null:
return $default(_that.id,_that.name,_that.startsOn,_that.endsOn,_that.targetMatches,_that.isClosed,_that.playedMatches,_that.awardCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeasonPeriod implements SeasonPeriod {
  const _SeasonPeriod({@JsonKey(fromJson: _int) required this.id, this.name = '', @JsonKey(fromJson: _stringOrNull) this.startsOn, @JsonKey(fromJson: _stringOrNull) this.endsOn, @JsonKey(fromJson: _intOrNull) this.targetMatches, @JsonKey(fromJson: _bool) this.isClosed = false, @JsonKey(fromJson: _int) this.playedMatches = 0, @JsonKey(fromJson: _int) this.awardCount = 0});
  factory _SeasonPeriod.fromJson(Map<String, dynamic> json) => _$SeasonPeriodFromJson(json);

@override@JsonKey(fromJson: _int) final  int id;
@override@JsonKey() final  String name;
@override@JsonKey(fromJson: _stringOrNull) final  String? startsOn;
/// `null` in de modus `matches` zolang de periode niet vol is.
@override@JsonKey(fromJson: _stringOrNull) final  String? endsOn;
@override@JsonKey(fromJson: _intOrNull) final  int? targetMatches;
@override@JsonKey(fromJson: _bool) final  bool isClosed;
@override@JsonKey(fromJson: _int) final  int playedMatches;
@override@JsonKey(fromJson: _int) final  int awardCount;

/// Create a copy of SeasonPeriod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeasonPeriodCopyWith<_SeasonPeriod> get copyWith => __$SeasonPeriodCopyWithImpl<_SeasonPeriod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeasonPeriodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeasonPeriod&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.targetMatches, targetMatches) || other.targetMatches == targetMatches)&&(identical(other.isClosed, isClosed) || other.isClosed == isClosed)&&(identical(other.playedMatches, playedMatches) || other.playedMatches == playedMatches)&&(identical(other.awardCount, awardCount) || other.awardCount == awardCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,startsOn,endsOn,targetMatches,isClosed,playedMatches,awardCount);

@override
String toString() {
  return 'SeasonPeriod(id: $id, name: $name, startsOn: $startsOn, endsOn: $endsOn, targetMatches: $targetMatches, isClosed: $isClosed, playedMatches: $playedMatches, awardCount: $awardCount)';
}


}

/// @nodoc
abstract mixin class _$SeasonPeriodCopyWith<$Res> implements $SeasonPeriodCopyWith<$Res> {
  factory _$SeasonPeriodCopyWith(_SeasonPeriod value, $Res Function(_SeasonPeriod) _then) = __$SeasonPeriodCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _int) int id, String name,@JsonKey(fromJson: _stringOrNull) String? startsOn,@JsonKey(fromJson: _stringOrNull) String? endsOn,@JsonKey(fromJson: _intOrNull) int? targetMatches,@JsonKey(fromJson: _bool) bool isClosed,@JsonKey(fromJson: _int) int playedMatches,@JsonKey(fromJson: _int) int awardCount
});




}
/// @nodoc
class __$SeasonPeriodCopyWithImpl<$Res>
    implements _$SeasonPeriodCopyWith<$Res> {
  __$SeasonPeriodCopyWithImpl(this._self, this._then);

  final _SeasonPeriod _self;
  final $Res Function(_SeasonPeriod) _then;

/// Create a copy of SeasonPeriod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? startsOn = freezed,Object? endsOn = freezed,Object? targetMatches = freezed,Object? isClosed = null,Object? playedMatches = null,Object? awardCount = null,}) {
  return _then(_SeasonPeriod(
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
mixin _$SeasonsData {

@JsonKey(unknownEnumValue: PeriodMode.off) PeriodMode get mode;@JsonKey(fromJson: _parseModes) List<PeriodMode> get modes; Season? get season; ClosedSeason? get closedSeason; List<SeasonPeriod> get periods;
/// Create a copy of SeasonsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SeasonsDataCopyWith<SeasonsData> get copyWith => _$SeasonsDataCopyWithImpl<SeasonsData>(this as SeasonsData, _$identity);

  /// Serializes this SeasonsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SeasonsData&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.modes, modes)&&(identical(other.season, season) || other.season == season)&&(identical(other.closedSeason, closedSeason) || other.closedSeason == closedSeason)&&const DeepCollectionEquality().equals(other.periods, periods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,const DeepCollectionEquality().hash(modes),season,closedSeason,const DeepCollectionEquality().hash(periods));

@override
String toString() {
  return 'SeasonsData(mode: $mode, modes: $modes, season: $season, closedSeason: $closedSeason, periods: $periods)';
}


}

/// @nodoc
abstract mixin class $SeasonsDataCopyWith<$Res>  {
  factory $SeasonsDataCopyWith(SeasonsData value, $Res Function(SeasonsData) _then) = _$SeasonsDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: PeriodMode.off) PeriodMode mode,@JsonKey(fromJson: _parseModes) List<PeriodMode> modes, Season? season, ClosedSeason? closedSeason, List<SeasonPeriod> periods
});


$SeasonCopyWith<$Res>? get season;$ClosedSeasonCopyWith<$Res>? get closedSeason;

}
/// @nodoc
class _$SeasonsDataCopyWithImpl<$Res>
    implements $SeasonsDataCopyWith<$Res> {
  _$SeasonsDataCopyWithImpl(this._self, this._then);

  final SeasonsData _self;
  final $Res Function(SeasonsData) _then;

/// Create a copy of SeasonsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? modes = null,Object? season = freezed,Object? closedSeason = freezed,Object? periods = null,}) {
  return _then(_self.copyWith(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as PeriodMode,modes: null == modes ? _self.modes : modes // ignore: cast_nullable_to_non_nullable
as List<PeriodMode>,season: freezed == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as Season?,closedSeason: freezed == closedSeason ? _self.closedSeason : closedSeason // ignore: cast_nullable_to_non_nullable
as ClosedSeason?,periods: null == periods ? _self.periods : periods // ignore: cast_nullable_to_non_nullable
as List<SeasonPeriod>,
  ));
}
/// Create a copy of SeasonsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeasonCopyWith<$Res>? get season {
    if (_self.season == null) {
    return null;
  }

  return $SeasonCopyWith<$Res>(_self.season!, (value) {
    return _then(_self.copyWith(season: value));
  });
}/// Create a copy of SeasonsData
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


/// Adds pattern-matching-related methods to [SeasonsData].
extension SeasonsDataPatterns on SeasonsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SeasonsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SeasonsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SeasonsData value)  $default,){
final _that = this;
switch (_that) {
case _SeasonsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SeasonsData value)?  $default,){
final _that = this;
switch (_that) {
case _SeasonsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: PeriodMode.off)  PeriodMode mode, @JsonKey(fromJson: _parseModes)  List<PeriodMode> modes,  Season? season,  ClosedSeason? closedSeason,  List<SeasonPeriod> periods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SeasonsData() when $default != null:
return $default(_that.mode,_that.modes,_that.season,_that.closedSeason,_that.periods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: PeriodMode.off)  PeriodMode mode, @JsonKey(fromJson: _parseModes)  List<PeriodMode> modes,  Season? season,  ClosedSeason? closedSeason,  List<SeasonPeriod> periods)  $default,) {final _that = this;
switch (_that) {
case _SeasonsData():
return $default(_that.mode,_that.modes,_that.season,_that.closedSeason,_that.periods);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: PeriodMode.off)  PeriodMode mode, @JsonKey(fromJson: _parseModes)  List<PeriodMode> modes,  Season? season,  ClosedSeason? closedSeason,  List<SeasonPeriod> periods)?  $default,) {final _that = this;
switch (_that) {
case _SeasonsData() when $default != null:
return $default(_that.mode,_that.modes,_that.season,_that.closedSeason,_that.periods);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SeasonsData extends SeasonsData {
  const _SeasonsData({@JsonKey(unknownEnumValue: PeriodMode.off) this.mode = PeriodMode.off, @JsonKey(fromJson: _parseModes) final  List<PeriodMode> modes = const [PeriodMode.off, PeriodMode.dates, PeriodMode.matches], this.season, this.closedSeason, final  List<SeasonPeriod> periods = const <SeasonPeriod>[]}): _modes = modes,_periods = periods,super._();
  factory _SeasonsData.fromJson(Map<String, dynamic> json) => _$SeasonsDataFromJson(json);

@override@JsonKey(unknownEnumValue: PeriodMode.off) final  PeriodMode mode;
 final  List<PeriodMode> _modes;
@override@JsonKey(fromJson: _parseModes) List<PeriodMode> get modes {
  if (_modes is EqualUnmodifiableListView) return _modes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_modes);
}

@override final  Season? season;
@override final  ClosedSeason? closedSeason;
 final  List<SeasonPeriod> _periods;
@override@JsonKey() List<SeasonPeriod> get periods {
  if (_periods is EqualUnmodifiableListView) return _periods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_periods);
}


/// Create a copy of SeasonsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SeasonsDataCopyWith<_SeasonsData> get copyWith => __$SeasonsDataCopyWithImpl<_SeasonsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SeasonsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SeasonsData&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other._modes, _modes)&&(identical(other.season, season) || other.season == season)&&(identical(other.closedSeason, closedSeason) || other.closedSeason == closedSeason)&&const DeepCollectionEquality().equals(other._periods, _periods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,mode,const DeepCollectionEquality().hash(_modes),season,closedSeason,const DeepCollectionEquality().hash(_periods));

@override
String toString() {
  return 'SeasonsData(mode: $mode, modes: $modes, season: $season, closedSeason: $closedSeason, periods: $periods)';
}


}

/// @nodoc
abstract mixin class _$SeasonsDataCopyWith<$Res> implements $SeasonsDataCopyWith<$Res> {
  factory _$SeasonsDataCopyWith(_SeasonsData value, $Res Function(_SeasonsData) _then) = __$SeasonsDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: PeriodMode.off) PeriodMode mode,@JsonKey(fromJson: _parseModes) List<PeriodMode> modes, Season? season, ClosedSeason? closedSeason, List<SeasonPeriod> periods
});


@override $SeasonCopyWith<$Res>? get season;@override $ClosedSeasonCopyWith<$Res>? get closedSeason;

}
/// @nodoc
class __$SeasonsDataCopyWithImpl<$Res>
    implements _$SeasonsDataCopyWith<$Res> {
  __$SeasonsDataCopyWithImpl(this._self, this._then);

  final _SeasonsData _self;
  final $Res Function(_SeasonsData) _then;

/// Create a copy of SeasonsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? modes = null,Object? season = freezed,Object? closedSeason = freezed,Object? periods = null,}) {
  return _then(_SeasonsData(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as PeriodMode,modes: null == modes ? _self._modes : modes // ignore: cast_nullable_to_non_nullable
as List<PeriodMode>,season: freezed == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as Season?,closedSeason: freezed == closedSeason ? _self.closedSeason : closedSeason // ignore: cast_nullable_to_non_nullable
as ClosedSeason?,periods: null == periods ? _self._periods : periods // ignore: cast_nullable_to_non_nullable
as List<SeasonPeriod>,
  ));
}

/// Create a copy of SeasonsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SeasonCopyWith<$Res>? get season {
    if (_self.season == null) {
    return null;
  }

  return $SeasonCopyWith<$Res>(_self.season!, (value) {
    return _then(_self.copyWith(season: value));
  });
}/// Create a copy of SeasonsData
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

// dart format on
