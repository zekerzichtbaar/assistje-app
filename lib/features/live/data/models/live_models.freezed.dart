// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'live_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LiveClock {

 bool get isLive; bool get running; DateTime? get startedAt; int get accumulatedSeconds; DateTime? get endedAt; int get period;/// Minuten waarop de delen eindigen (`[45, 90]`); leeg bij een sport die
/// niet op tijd speelt.
 List<int> get periodEnds;
/// Create a copy of LiveClock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveClockCopyWith<LiveClock> get copyWith => _$LiveClockCopyWithImpl<LiveClock>(this as LiveClock, _$identity);

  /// Serializes this LiveClock to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveClock&&(identical(other.isLive, isLive) || other.isLive == isLive)&&(identical(other.running, running) || other.running == running)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.accumulatedSeconds, accumulatedSeconds) || other.accumulatedSeconds == accumulatedSeconds)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other.periodEnds, periodEnds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLive,running,startedAt,accumulatedSeconds,endedAt,period,const DeepCollectionEquality().hash(periodEnds));

@override
String toString() {
  return 'LiveClock(isLive: $isLive, running: $running, startedAt: $startedAt, accumulatedSeconds: $accumulatedSeconds, endedAt: $endedAt, period: $period, periodEnds: $periodEnds)';
}


}

/// @nodoc
abstract mixin class $LiveClockCopyWith<$Res>  {
  factory $LiveClockCopyWith(LiveClock value, $Res Function(LiveClock) _then) = _$LiveClockCopyWithImpl;
@useResult
$Res call({
 bool isLive, bool running, DateTime? startedAt, int accumulatedSeconds, DateTime? endedAt, int period, List<int> periodEnds
});




}
/// @nodoc
class _$LiveClockCopyWithImpl<$Res>
    implements $LiveClockCopyWith<$Res> {
  _$LiveClockCopyWithImpl(this._self, this._then);

  final LiveClock _self;
  final $Res Function(LiveClock) _then;

/// Create a copy of LiveClock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLive = null,Object? running = null,Object? startedAt = freezed,Object? accumulatedSeconds = null,Object? endedAt = freezed,Object? period = null,Object? periodEnds = null,}) {
  return _then(_self.copyWith(
isLive: null == isLive ? _self.isLive : isLive // ignore: cast_nullable_to_non_nullable
as bool,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,accumulatedSeconds: null == accumulatedSeconds ? _self.accumulatedSeconds : accumulatedSeconds // ignore: cast_nullable_to_non_nullable
as int,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as int,periodEnds: null == periodEnds ? _self.periodEnds : periodEnds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveClock].
extension LiveClockPatterns on LiveClock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveClock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveClock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveClock value)  $default,){
final _that = this;
switch (_that) {
case _LiveClock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveClock value)?  $default,){
final _that = this;
switch (_that) {
case _LiveClock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLive,  bool running,  DateTime? startedAt,  int accumulatedSeconds,  DateTime? endedAt,  int period,  List<int> periodEnds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveClock() when $default != null:
return $default(_that.isLive,_that.running,_that.startedAt,_that.accumulatedSeconds,_that.endedAt,_that.period,_that.periodEnds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLive,  bool running,  DateTime? startedAt,  int accumulatedSeconds,  DateTime? endedAt,  int period,  List<int> periodEnds)  $default,) {final _that = this;
switch (_that) {
case _LiveClock():
return $default(_that.isLive,_that.running,_that.startedAt,_that.accumulatedSeconds,_that.endedAt,_that.period,_that.periodEnds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLive,  bool running,  DateTime? startedAt,  int accumulatedSeconds,  DateTime? endedAt,  int period,  List<int> periodEnds)?  $default,) {final _that = this;
switch (_that) {
case _LiveClock() when $default != null:
return $default(_that.isLive,_that.running,_that.startedAt,_that.accumulatedSeconds,_that.endedAt,_that.period,_that.periodEnds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveClock extends LiveClock {
  const _LiveClock({this.isLive = false, this.running = false, this.startedAt, this.accumulatedSeconds = 0, this.endedAt, this.period = 1, final  List<int> periodEnds = const <int>[]}): _periodEnds = periodEnds,super._();
  factory _LiveClock.fromJson(Map<String, dynamic> json) => _$LiveClockFromJson(json);

@override@JsonKey() final  bool isLive;
@override@JsonKey() final  bool running;
@override final  DateTime? startedAt;
@override@JsonKey() final  int accumulatedSeconds;
@override final  DateTime? endedAt;
@override@JsonKey() final  int period;
/// Minuten waarop de delen eindigen (`[45, 90]`); leeg bij een sport die
/// niet op tijd speelt.
 final  List<int> _periodEnds;
/// Minuten waarop de delen eindigen (`[45, 90]`); leeg bij een sport die
/// niet op tijd speelt.
@override@JsonKey() List<int> get periodEnds {
  if (_periodEnds is EqualUnmodifiableListView) return _periodEnds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_periodEnds);
}


/// Create a copy of LiveClock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveClockCopyWith<_LiveClock> get copyWith => __$LiveClockCopyWithImpl<_LiveClock>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveClockToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveClock&&(identical(other.isLive, isLive) || other.isLive == isLive)&&(identical(other.running, running) || other.running == running)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.accumulatedSeconds, accumulatedSeconds) || other.accumulatedSeconds == accumulatedSeconds)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other._periodEnds, _periodEnds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLive,running,startedAt,accumulatedSeconds,endedAt,period,const DeepCollectionEquality().hash(_periodEnds));

@override
String toString() {
  return 'LiveClock(isLive: $isLive, running: $running, startedAt: $startedAt, accumulatedSeconds: $accumulatedSeconds, endedAt: $endedAt, period: $period, periodEnds: $periodEnds)';
}


}

/// @nodoc
abstract mixin class _$LiveClockCopyWith<$Res> implements $LiveClockCopyWith<$Res> {
  factory _$LiveClockCopyWith(_LiveClock value, $Res Function(_LiveClock) _then) = __$LiveClockCopyWithImpl;
@override @useResult
$Res call({
 bool isLive, bool running, DateTime? startedAt, int accumulatedSeconds, DateTime? endedAt, int period, List<int> periodEnds
});




}
/// @nodoc
class __$LiveClockCopyWithImpl<$Res>
    implements _$LiveClockCopyWith<$Res> {
  __$LiveClockCopyWithImpl(this._self, this._then);

  final _LiveClock _self;
  final $Res Function(_LiveClock) _then;

/// Create a copy of LiveClock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLive = null,Object? running = null,Object? startedAt = freezed,Object? accumulatedSeconds = null,Object? endedAt = freezed,Object? period = null,Object? periodEnds = null,}) {
  return _then(_LiveClock(
isLive: null == isLive ? _self.isLive : isLive // ignore: cast_nullable_to_non_nullable
as bool,running: null == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as bool,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,accumulatedSeconds: null == accumulatedSeconds ? _self.accumulatedSeconds : accumulatedSeconds // ignore: cast_nullable_to_non_nullable
as int,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as int,periodEnds: null == periodEnds ? _self._periodEnds : periodEnds // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}


/// @nodoc
mixin _$LiveSet {

 int get setNumber; int get homePoints; int get awayPoints;
/// Create a copy of LiveSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveSetCopyWith<LiveSet> get copyWith => _$LiveSetCopyWithImpl<LiveSet>(this as LiveSet, _$identity);

  /// Serializes this LiveSet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveSet&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.homePoints, homePoints) || other.homePoints == homePoints)&&(identical(other.awayPoints, awayPoints) || other.awayPoints == awayPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,setNumber,homePoints,awayPoints);

@override
String toString() {
  return 'LiveSet(setNumber: $setNumber, homePoints: $homePoints, awayPoints: $awayPoints)';
}


}

/// @nodoc
abstract mixin class $LiveSetCopyWith<$Res>  {
  factory $LiveSetCopyWith(LiveSet value, $Res Function(LiveSet) _then) = _$LiveSetCopyWithImpl;
@useResult
$Res call({
 int setNumber, int homePoints, int awayPoints
});




}
/// @nodoc
class _$LiveSetCopyWithImpl<$Res>
    implements $LiveSetCopyWith<$Res> {
  _$LiveSetCopyWithImpl(this._self, this._then);

  final LiveSet _self;
  final $Res Function(LiveSet) _then;

/// Create a copy of LiveSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? setNumber = null,Object? homePoints = null,Object? awayPoints = null,}) {
  return _then(_self.copyWith(
setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,homePoints: null == homePoints ? _self.homePoints : homePoints // ignore: cast_nullable_to_non_nullable
as int,awayPoints: null == awayPoints ? _self.awayPoints : awayPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveSet].
extension LiveSetPatterns on LiveSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveSet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveSet value)  $default,){
final _that = this;
switch (_that) {
case _LiveSet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveSet value)?  $default,){
final _that = this;
switch (_that) {
case _LiveSet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int setNumber,  int homePoints,  int awayPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveSet() when $default != null:
return $default(_that.setNumber,_that.homePoints,_that.awayPoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int setNumber,  int homePoints,  int awayPoints)  $default,) {final _that = this;
switch (_that) {
case _LiveSet():
return $default(_that.setNumber,_that.homePoints,_that.awayPoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int setNumber,  int homePoints,  int awayPoints)?  $default,) {final _that = this;
switch (_that) {
case _LiveSet() when $default != null:
return $default(_that.setNumber,_that.homePoints,_that.awayPoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveSet implements LiveSet {
  const _LiveSet({this.setNumber = 0, this.homePoints = 0, this.awayPoints = 0});
  factory _LiveSet.fromJson(Map<String, dynamic> json) => _$LiveSetFromJson(json);

@override@JsonKey() final  int setNumber;
@override@JsonKey() final  int homePoints;
@override@JsonKey() final  int awayPoints;

/// Create a copy of LiveSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveSetCopyWith<_LiveSet> get copyWith => __$LiveSetCopyWithImpl<_LiveSet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveSetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveSet&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber)&&(identical(other.homePoints, homePoints) || other.homePoints == homePoints)&&(identical(other.awayPoints, awayPoints) || other.awayPoints == awayPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,setNumber,homePoints,awayPoints);

@override
String toString() {
  return 'LiveSet(setNumber: $setNumber, homePoints: $homePoints, awayPoints: $awayPoints)';
}


}

/// @nodoc
abstract mixin class _$LiveSetCopyWith<$Res> implements $LiveSetCopyWith<$Res> {
  factory _$LiveSetCopyWith(_LiveSet value, $Res Function(_LiveSet) _then) = __$LiveSetCopyWithImpl;
@override @useResult
$Res call({
 int setNumber, int homePoints, int awayPoints
});




}
/// @nodoc
class __$LiveSetCopyWithImpl<$Res>
    implements _$LiveSetCopyWith<$Res> {
  __$LiveSetCopyWithImpl(this._self, this._then);

  final _LiveSet _self;
  final $Res Function(_LiveSet) _then;

/// Create a copy of LiveSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? setNumber = null,Object? homePoints = null,Object? awayPoints = null,}) {
  return _then(_LiveSet(
setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,homePoints: null == homePoints ? _self.homePoints : homePoints // ignore: cast_nullable_to_non_nullable
as int,awayPoints: null == awayPoints ? _self.awayPoints : awayPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LiveEvent {

 int get id; String get type; String get title; DateTime? get startsAt; String? get homeTeam; String? get awayTeam; int? get homeScore; int? get awayScore; bool get weAreHome; List<LiveSet> get sets; LiveClock get live; String? get shareUrl;
/// Create a copy of LiveEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveEventCopyWith<LiveEvent> get copyWith => _$LiveEventCopyWithImpl<LiveEvent>(this as LiveEvent, _$identity);

  /// Serializes this LiveEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.homeScore, homeScore) || other.homeScore == homeScore)&&(identical(other.awayScore, awayScore) || other.awayScore == awayScore)&&(identical(other.weAreHome, weAreHome) || other.weAreHome == weAreHome)&&const DeepCollectionEquality().equals(other.sets, sets)&&(identical(other.live, live) || other.live == live)&&(identical(other.shareUrl, shareUrl) || other.shareUrl == shareUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,startsAt,homeTeam,awayTeam,homeScore,awayScore,weAreHome,const DeepCollectionEquality().hash(sets),live,shareUrl);

@override
String toString() {
  return 'LiveEvent(id: $id, type: $type, title: $title, startsAt: $startsAt, homeTeam: $homeTeam, awayTeam: $awayTeam, homeScore: $homeScore, awayScore: $awayScore, weAreHome: $weAreHome, sets: $sets, live: $live, shareUrl: $shareUrl)';
}


}

/// @nodoc
abstract mixin class $LiveEventCopyWith<$Res>  {
  factory $LiveEventCopyWith(LiveEvent value, $Res Function(LiveEvent) _then) = _$LiveEventCopyWithImpl;
@useResult
$Res call({
 int id, String type, String title, DateTime? startsAt, String? homeTeam, String? awayTeam, int? homeScore, int? awayScore, bool weAreHome, List<LiveSet> sets, LiveClock live, String? shareUrl
});


$LiveClockCopyWith<$Res> get live;

}
/// @nodoc
class _$LiveEventCopyWithImpl<$Res>
    implements $LiveEventCopyWith<$Res> {
  _$LiveEventCopyWithImpl(this._self, this._then);

  final LiveEvent _self;
  final $Res Function(LiveEvent) _then;

/// Create a copy of LiveEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? startsAt = freezed,Object? homeTeam = freezed,Object? awayTeam = freezed,Object? homeScore = freezed,Object? awayScore = freezed,Object? weAreHome = null,Object? sets = null,Object? live = null,Object? shareUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,homeTeam: freezed == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String?,awayTeam: freezed == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String?,homeScore: freezed == homeScore ? _self.homeScore : homeScore // ignore: cast_nullable_to_non_nullable
as int?,awayScore: freezed == awayScore ? _self.awayScore : awayScore // ignore: cast_nullable_to_non_nullable
as int?,weAreHome: null == weAreHome ? _self.weAreHome : weAreHome // ignore: cast_nullable_to_non_nullable
as bool,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<LiveSet>,live: null == live ? _self.live : live // ignore: cast_nullable_to_non_nullable
as LiveClock,shareUrl: freezed == shareUrl ? _self.shareUrl : shareUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of LiveEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveClockCopyWith<$Res> get live {
  
  return $LiveClockCopyWith<$Res>(_self.live, (value) {
    return _then(_self.copyWith(live: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveEvent].
extension LiveEventPatterns on LiveEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveEvent value)  $default,){
final _that = this;
switch (_that) {
case _LiveEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveEvent value)?  $default,){
final _that = this;
switch (_that) {
case _LiveEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String type,  String title,  DateTime? startsAt,  String? homeTeam,  String? awayTeam,  int? homeScore,  int? awayScore,  bool weAreHome,  List<LiveSet> sets,  LiveClock live,  String? shareUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveEvent() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.homeTeam,_that.awayTeam,_that.homeScore,_that.awayScore,_that.weAreHome,_that.sets,_that.live,_that.shareUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String type,  String title,  DateTime? startsAt,  String? homeTeam,  String? awayTeam,  int? homeScore,  int? awayScore,  bool weAreHome,  List<LiveSet> sets,  LiveClock live,  String? shareUrl)  $default,) {final _that = this;
switch (_that) {
case _LiveEvent():
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.homeTeam,_that.awayTeam,_that.homeScore,_that.awayScore,_that.weAreHome,_that.sets,_that.live,_that.shareUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String type,  String title,  DateTime? startsAt,  String? homeTeam,  String? awayTeam,  int? homeScore,  int? awayScore,  bool weAreHome,  List<LiveSet> sets,  LiveClock live,  String? shareUrl)?  $default,) {final _that = this;
switch (_that) {
case _LiveEvent() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.homeTeam,_that.awayTeam,_that.homeScore,_that.awayScore,_that.weAreHome,_that.sets,_that.live,_that.shareUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveEvent implements LiveEvent {
  const _LiveEvent({required this.id, this.type = 'match', this.title = '', this.startsAt, this.homeTeam, this.awayTeam, this.homeScore, this.awayScore, this.weAreHome = true, final  List<LiveSet> sets = const <LiveSet>[], this.live = const LiveClock(), this.shareUrl}): _sets = sets;
  factory _LiveEvent.fromJson(Map<String, dynamic> json) => _$LiveEventFromJson(json);

@override final  int id;
@override@JsonKey() final  String type;
@override@JsonKey() final  String title;
@override final  DateTime? startsAt;
@override final  String? homeTeam;
@override final  String? awayTeam;
@override final  int? homeScore;
@override final  int? awayScore;
@override@JsonKey() final  bool weAreHome;
 final  List<LiveSet> _sets;
@override@JsonKey() List<LiveSet> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}

@override@JsonKey() final  LiveClock live;
@override final  String? shareUrl;

/// Create a copy of LiveEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveEventCopyWith<_LiveEvent> get copyWith => __$LiveEventCopyWithImpl<_LiveEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.homeScore, homeScore) || other.homeScore == homeScore)&&(identical(other.awayScore, awayScore) || other.awayScore == awayScore)&&(identical(other.weAreHome, weAreHome) || other.weAreHome == weAreHome)&&const DeepCollectionEquality().equals(other._sets, _sets)&&(identical(other.live, live) || other.live == live)&&(identical(other.shareUrl, shareUrl) || other.shareUrl == shareUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,startsAt,homeTeam,awayTeam,homeScore,awayScore,weAreHome,const DeepCollectionEquality().hash(_sets),live,shareUrl);

@override
String toString() {
  return 'LiveEvent(id: $id, type: $type, title: $title, startsAt: $startsAt, homeTeam: $homeTeam, awayTeam: $awayTeam, homeScore: $homeScore, awayScore: $awayScore, weAreHome: $weAreHome, sets: $sets, live: $live, shareUrl: $shareUrl)';
}


}

/// @nodoc
abstract mixin class _$LiveEventCopyWith<$Res> implements $LiveEventCopyWith<$Res> {
  factory _$LiveEventCopyWith(_LiveEvent value, $Res Function(_LiveEvent) _then) = __$LiveEventCopyWithImpl;
@override @useResult
$Res call({
 int id, String type, String title, DateTime? startsAt, String? homeTeam, String? awayTeam, int? homeScore, int? awayScore, bool weAreHome, List<LiveSet> sets, LiveClock live, String? shareUrl
});


@override $LiveClockCopyWith<$Res> get live;

}
/// @nodoc
class __$LiveEventCopyWithImpl<$Res>
    implements _$LiveEventCopyWith<$Res> {
  __$LiveEventCopyWithImpl(this._self, this._then);

  final _LiveEvent _self;
  final $Res Function(_LiveEvent) _then;

/// Create a copy of LiveEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? startsAt = freezed,Object? homeTeam = freezed,Object? awayTeam = freezed,Object? homeScore = freezed,Object? awayScore = freezed,Object? weAreHome = null,Object? sets = null,Object? live = null,Object? shareUrl = freezed,}) {
  return _then(_LiveEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,homeTeam: freezed == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String?,awayTeam: freezed == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String?,homeScore: freezed == homeScore ? _self.homeScore : homeScore // ignore: cast_nullable_to_non_nullable
as int?,awayScore: freezed == awayScore ? _self.awayScore : awayScore // ignore: cast_nullable_to_non_nullable
as int?,weAreHome: null == weAreHome ? _self.weAreHome : weAreHome // ignore: cast_nullable_to_non_nullable
as bool,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<LiveSet>,live: null == live ? _self.live : live // ignore: cast_nullable_to_non_nullable
as LiveClock,shareUrl: freezed == shareUrl ? _self.shareUrl : shareUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of LiveEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveClockCopyWith<$Res> get live {
  
  return $LiveClockCopyWith<$Res>(_self.live, (value) {
    return _then(_self.copyWith(live: value));
  });
}
}


/// @nodoc
mixin _$LivePeriods {

 int get count; String get label; String get plural; int? get minutes;
/// Create a copy of LivePeriods
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivePeriodsCopyWith<LivePeriods> get copyWith => _$LivePeriodsCopyWithImpl<LivePeriods>(this as LivePeriods, _$identity);

  /// Serializes this LivePeriods to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivePeriods&&(identical(other.count, count) || other.count == count)&&(identical(other.label, label) || other.label == label)&&(identical(other.plural, plural) || other.plural == plural)&&(identical(other.minutes, minutes) || other.minutes == minutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,label,plural,minutes);

@override
String toString() {
  return 'LivePeriods(count: $count, label: $label, plural: $plural, minutes: $minutes)';
}


}

/// @nodoc
abstract mixin class $LivePeriodsCopyWith<$Res>  {
  factory $LivePeriodsCopyWith(LivePeriods value, $Res Function(LivePeriods) _then) = _$LivePeriodsCopyWithImpl;
@useResult
$Res call({
 int count, String label, String plural, int? minutes
});




}
/// @nodoc
class _$LivePeriodsCopyWithImpl<$Res>
    implements $LivePeriodsCopyWith<$Res> {
  _$LivePeriodsCopyWithImpl(this._self, this._then);

  final LivePeriods _self;
  final $Res Function(LivePeriods) _then;

/// Create a copy of LivePeriods
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? label = null,Object? plural = null,Object? minutes = freezed,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,plural: null == plural ? _self.plural : plural // ignore: cast_nullable_to_non_nullable
as String,minutes: freezed == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [LivePeriods].
extension LivePeriodsPatterns on LivePeriods {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivePeriods value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivePeriods() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivePeriods value)  $default,){
final _that = this;
switch (_that) {
case _LivePeriods():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivePeriods value)?  $default,){
final _that = this;
switch (_that) {
case _LivePeriods() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  String label,  String plural,  int? minutes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivePeriods() when $default != null:
return $default(_that.count,_that.label,_that.plural,_that.minutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  String label,  String plural,  int? minutes)  $default,) {final _that = this;
switch (_that) {
case _LivePeriods():
return $default(_that.count,_that.label,_that.plural,_that.minutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  String label,  String plural,  int? minutes)?  $default,) {final _that = this;
switch (_that) {
case _LivePeriods() when $default != null:
return $default(_that.count,_that.label,_that.plural,_that.minutes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LivePeriods implements LivePeriods {
  const _LivePeriods({this.count = 1, this.label = '', this.plural = '', this.minutes});
  factory _LivePeriods.fromJson(Map<String, dynamic> json) => _$LivePeriodsFromJson(json);

@override@JsonKey() final  int count;
@override@JsonKey() final  String label;
@override@JsonKey() final  String plural;
@override final  int? minutes;

/// Create a copy of LivePeriods
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivePeriodsCopyWith<_LivePeriods> get copyWith => __$LivePeriodsCopyWithImpl<_LivePeriods>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LivePeriodsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivePeriods&&(identical(other.count, count) || other.count == count)&&(identical(other.label, label) || other.label == label)&&(identical(other.plural, plural) || other.plural == plural)&&(identical(other.minutes, minutes) || other.minutes == minutes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,label,plural,minutes);

@override
String toString() {
  return 'LivePeriods(count: $count, label: $label, plural: $plural, minutes: $minutes)';
}


}

/// @nodoc
abstract mixin class _$LivePeriodsCopyWith<$Res> implements $LivePeriodsCopyWith<$Res> {
  factory _$LivePeriodsCopyWith(_LivePeriods value, $Res Function(_LivePeriods) _then) = __$LivePeriodsCopyWithImpl;
@override @useResult
$Res call({
 int count, String label, String plural, int? minutes
});




}
/// @nodoc
class __$LivePeriodsCopyWithImpl<$Res>
    implements _$LivePeriodsCopyWith<$Res> {
  __$LivePeriodsCopyWithImpl(this._self, this._then);

  final _LivePeriods _self;
  final $Res Function(_LivePeriods) _then;

/// Create a copy of LivePeriods
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? label = null,Object? plural = null,Object? minutes = freezed,}) {
  return _then(_LivePeriods(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,plural: null == plural ? _self.plural : plural // ignore: cast_nullable_to_non_nullable
as String,minutes: freezed == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$LiveTypeOption {

 String get type; String get label;
/// Create a copy of LiveTypeOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveTypeOptionCopyWith<LiveTypeOption> get copyWith => _$LiveTypeOptionCopyWithImpl<LiveTypeOption>(this as LiveTypeOption, _$identity);

  /// Serializes this LiveTypeOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveTypeOption&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,label);

@override
String toString() {
  return 'LiveTypeOption(type: $type, label: $label)';
}


}

/// @nodoc
abstract mixin class $LiveTypeOptionCopyWith<$Res>  {
  factory $LiveTypeOptionCopyWith(LiveTypeOption value, $Res Function(LiveTypeOption) _then) = _$LiveTypeOptionCopyWithImpl;
@useResult
$Res call({
 String type, String label
});




}
/// @nodoc
class _$LiveTypeOptionCopyWithImpl<$Res>
    implements $LiveTypeOptionCopyWith<$Res> {
  _$LiveTypeOptionCopyWithImpl(this._self, this._then);

  final LiveTypeOption _self;
  final $Res Function(LiveTypeOption) _then;

/// Create a copy of LiveTypeOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? label = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveTypeOption].
extension LiveTypeOptionPatterns on LiveTypeOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveTypeOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveTypeOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveTypeOption value)  $default,){
final _that = this;
switch (_that) {
case _LiveTypeOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveTypeOption value)?  $default,){
final _that = this;
switch (_that) {
case _LiveTypeOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveTypeOption() when $default != null:
return $default(_that.type,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String label)  $default,) {final _that = this;
switch (_that) {
case _LiveTypeOption():
return $default(_that.type,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String label)?  $default,) {final _that = this;
switch (_that) {
case _LiveTypeOption() when $default != null:
return $default(_that.type,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveTypeOption implements LiveTypeOption {
  const _LiveTypeOption({required this.type, this.label = ''});
  factory _LiveTypeOption.fromJson(Map<String, dynamic> json) => _$LiveTypeOptionFromJson(json);

@override final  String type;
@override@JsonKey() final  String label;

/// Create a copy of LiveTypeOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveTypeOptionCopyWith<_LiveTypeOption> get copyWith => __$LiveTypeOptionCopyWithImpl<_LiveTypeOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveTypeOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveTypeOption&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,label);

@override
String toString() {
  return 'LiveTypeOption(type: $type, label: $label)';
}


}

/// @nodoc
abstract mixin class _$LiveTypeOptionCopyWith<$Res> implements $LiveTypeOptionCopyWith<$Res> {
  factory _$LiveTypeOptionCopyWith(_LiveTypeOption value, $Res Function(_LiveTypeOption) _then) = __$LiveTypeOptionCopyWithImpl;
@override @useResult
$Res call({
 String type, String label
});




}
/// @nodoc
class __$LiveTypeOptionCopyWithImpl<$Res>
    implements _$LiveTypeOptionCopyWith<$Res> {
  __$LiveTypeOptionCopyWithImpl(this._self, this._then);

  final _LiveTypeOption _self;
  final $Res Function(_LiveTypeOption) _then;

/// Create a copy of LiveTypeOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? label = null,}) {
  return _then(_LiveTypeOption(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LiveRules {

 String get scoreModel; bool get tracksScorers; LivePeriods? get periods; List<LiveTypeOption> get cardTypes; List<LiveTypeOption> get momentTypes;
/// Create a copy of LiveRules
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveRulesCopyWith<LiveRules> get copyWith => _$LiveRulesCopyWithImpl<LiveRules>(this as LiveRules, _$identity);

  /// Serializes this LiveRules to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveRules&&(identical(other.scoreModel, scoreModel) || other.scoreModel == scoreModel)&&(identical(other.tracksScorers, tracksScorers) || other.tracksScorers == tracksScorers)&&(identical(other.periods, periods) || other.periods == periods)&&const DeepCollectionEquality().equals(other.cardTypes, cardTypes)&&const DeepCollectionEquality().equals(other.momentTypes, momentTypes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scoreModel,tracksScorers,periods,const DeepCollectionEquality().hash(cardTypes),const DeepCollectionEquality().hash(momentTypes));

@override
String toString() {
  return 'LiveRules(scoreModel: $scoreModel, tracksScorers: $tracksScorers, periods: $periods, cardTypes: $cardTypes, momentTypes: $momentTypes)';
}


}

/// @nodoc
abstract mixin class $LiveRulesCopyWith<$Res>  {
  factory $LiveRulesCopyWith(LiveRules value, $Res Function(LiveRules) _then) = _$LiveRulesCopyWithImpl;
@useResult
$Res call({
 String scoreModel, bool tracksScorers, LivePeriods? periods, List<LiveTypeOption> cardTypes, List<LiveTypeOption> momentTypes
});


$LivePeriodsCopyWith<$Res>? get periods;

}
/// @nodoc
class _$LiveRulesCopyWithImpl<$Res>
    implements $LiveRulesCopyWith<$Res> {
  _$LiveRulesCopyWithImpl(this._self, this._then);

  final LiveRules _self;
  final $Res Function(LiveRules) _then;

/// Create a copy of LiveRules
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scoreModel = null,Object? tracksScorers = null,Object? periods = freezed,Object? cardTypes = null,Object? momentTypes = null,}) {
  return _then(_self.copyWith(
scoreModel: null == scoreModel ? _self.scoreModel : scoreModel // ignore: cast_nullable_to_non_nullable
as String,tracksScorers: null == tracksScorers ? _self.tracksScorers : tracksScorers // ignore: cast_nullable_to_non_nullable
as bool,periods: freezed == periods ? _self.periods : periods // ignore: cast_nullable_to_non_nullable
as LivePeriods?,cardTypes: null == cardTypes ? _self.cardTypes : cardTypes // ignore: cast_nullable_to_non_nullable
as List<LiveTypeOption>,momentTypes: null == momentTypes ? _self.momentTypes : momentTypes // ignore: cast_nullable_to_non_nullable
as List<LiveTypeOption>,
  ));
}
/// Create a copy of LiveRules
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivePeriodsCopyWith<$Res>? get periods {
    if (_self.periods == null) {
    return null;
  }

  return $LivePeriodsCopyWith<$Res>(_self.periods!, (value) {
    return _then(_self.copyWith(periods: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveRules].
extension LiveRulesPatterns on LiveRules {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveRules value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveRules() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveRules value)  $default,){
final _that = this;
switch (_that) {
case _LiveRules():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveRules value)?  $default,){
final _that = this;
switch (_that) {
case _LiveRules() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String scoreModel,  bool tracksScorers,  LivePeriods? periods,  List<LiveTypeOption> cardTypes,  List<LiveTypeOption> momentTypes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveRules() when $default != null:
return $default(_that.scoreModel,_that.tracksScorers,_that.periods,_that.cardTypes,_that.momentTypes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String scoreModel,  bool tracksScorers,  LivePeriods? periods,  List<LiveTypeOption> cardTypes,  List<LiveTypeOption> momentTypes)  $default,) {final _that = this;
switch (_that) {
case _LiveRules():
return $default(_that.scoreModel,_that.tracksScorers,_that.periods,_that.cardTypes,_that.momentTypes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String scoreModel,  bool tracksScorers,  LivePeriods? periods,  List<LiveTypeOption> cardTypes,  List<LiveTypeOption> momentTypes)?  $default,) {final _that = this;
switch (_that) {
case _LiveRules() when $default != null:
return $default(_that.scoreModel,_that.tracksScorers,_that.periods,_that.cardTypes,_that.momentTypes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveRules implements LiveRules {
  const _LiveRules({this.scoreModel = 'goals', this.tracksScorers = false, this.periods, final  List<LiveTypeOption> cardTypes = const <LiveTypeOption>[], final  List<LiveTypeOption> momentTypes = const <LiveTypeOption>[]}): _cardTypes = cardTypes,_momentTypes = momentTypes;
  factory _LiveRules.fromJson(Map<String, dynamic> json) => _$LiveRulesFromJson(json);

@override@JsonKey() final  String scoreModel;
@override@JsonKey() final  bool tracksScorers;
@override final  LivePeriods? periods;
 final  List<LiveTypeOption> _cardTypes;
@override@JsonKey() List<LiveTypeOption> get cardTypes {
  if (_cardTypes is EqualUnmodifiableListView) return _cardTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cardTypes);
}

 final  List<LiveTypeOption> _momentTypes;
@override@JsonKey() List<LiveTypeOption> get momentTypes {
  if (_momentTypes is EqualUnmodifiableListView) return _momentTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_momentTypes);
}


/// Create a copy of LiveRules
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveRulesCopyWith<_LiveRules> get copyWith => __$LiveRulesCopyWithImpl<_LiveRules>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveRulesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveRules&&(identical(other.scoreModel, scoreModel) || other.scoreModel == scoreModel)&&(identical(other.tracksScorers, tracksScorers) || other.tracksScorers == tracksScorers)&&(identical(other.periods, periods) || other.periods == periods)&&const DeepCollectionEquality().equals(other._cardTypes, _cardTypes)&&const DeepCollectionEquality().equals(other._momentTypes, _momentTypes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,scoreModel,tracksScorers,periods,const DeepCollectionEquality().hash(_cardTypes),const DeepCollectionEquality().hash(_momentTypes));

@override
String toString() {
  return 'LiveRules(scoreModel: $scoreModel, tracksScorers: $tracksScorers, periods: $periods, cardTypes: $cardTypes, momentTypes: $momentTypes)';
}


}

/// @nodoc
abstract mixin class _$LiveRulesCopyWith<$Res> implements $LiveRulesCopyWith<$Res> {
  factory _$LiveRulesCopyWith(_LiveRules value, $Res Function(_LiveRules) _then) = __$LiveRulesCopyWithImpl;
@override @useResult
$Res call({
 String scoreModel, bool tracksScorers, LivePeriods? periods, List<LiveTypeOption> cardTypes, List<LiveTypeOption> momentTypes
});


@override $LivePeriodsCopyWith<$Res>? get periods;

}
/// @nodoc
class __$LiveRulesCopyWithImpl<$Res>
    implements _$LiveRulesCopyWith<$Res> {
  __$LiveRulesCopyWithImpl(this._self, this._then);

  final _LiveRules _self;
  final $Res Function(_LiveRules) _then;

/// Create a copy of LiveRules
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scoreModel = null,Object? tracksScorers = null,Object? periods = freezed,Object? cardTypes = null,Object? momentTypes = null,}) {
  return _then(_LiveRules(
scoreModel: null == scoreModel ? _self.scoreModel : scoreModel // ignore: cast_nullable_to_non_nullable
as String,tracksScorers: null == tracksScorers ? _self.tracksScorers : tracksScorers // ignore: cast_nullable_to_non_nullable
as bool,periods: freezed == periods ? _self.periods : periods // ignore: cast_nullable_to_non_nullable
as LivePeriods?,cardTypes: null == cardTypes ? _self._cardTypes : cardTypes // ignore: cast_nullable_to_non_nullable
as List<LiveTypeOption>,momentTypes: null == momentTypes ? _self._momentTypes : momentTypes // ignore: cast_nullable_to_non_nullable
as List<LiveTypeOption>,
  ));
}

/// Create a copy of LiveRules
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivePeriodsCopyWith<$Res>? get periods {
    if (_self.periods == null) {
    return null;
  }

  return $LivePeriodsCopyWith<$Res>(_self.periods!, (value) {
    return _then(_self.copyWith(periods: value));
  });
}
}


/// @nodoc
mixin _$LiveGoal {

 int get id; String get itemKey; int get minute; String get type; bool get penalty; String? get scorer; String? get scorerAvatar; String? get assist; int get createdAt;
/// Create a copy of LiveGoal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveGoalCopyWith<LiveGoal> get copyWith => _$LiveGoalCopyWithImpl<LiveGoal>(this as LiveGoal, _$identity);

  /// Serializes this LiveGoal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveGoal&&(identical(other.id, id) || other.id == id)&&(identical(other.itemKey, itemKey) || other.itemKey == itemKey)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.type, type) || other.type == type)&&(identical(other.penalty, penalty) || other.penalty == penalty)&&(identical(other.scorer, scorer) || other.scorer == scorer)&&(identical(other.scorerAvatar, scorerAvatar) || other.scorerAvatar == scorerAvatar)&&(identical(other.assist, assist) || other.assist == assist)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemKey,minute,type,penalty,scorer,scorerAvatar,assist,createdAt);

@override
String toString() {
  return 'LiveGoal(id: $id, itemKey: $itemKey, minute: $minute, type: $type, penalty: $penalty, scorer: $scorer, scorerAvatar: $scorerAvatar, assist: $assist, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LiveGoalCopyWith<$Res>  {
  factory $LiveGoalCopyWith(LiveGoal value, $Res Function(LiveGoal) _then) = _$LiveGoalCopyWithImpl;
@useResult
$Res call({
 int id, String itemKey, int minute, String type, bool penalty, String? scorer, String? scorerAvatar, String? assist, int createdAt
});




}
/// @nodoc
class _$LiveGoalCopyWithImpl<$Res>
    implements $LiveGoalCopyWith<$Res> {
  _$LiveGoalCopyWithImpl(this._self, this._then);

  final LiveGoal _self;
  final $Res Function(LiveGoal) _then;

/// Create a copy of LiveGoal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? itemKey = null,Object? minute = null,Object? type = null,Object? penalty = null,Object? scorer = freezed,Object? scorerAvatar = freezed,Object? assist = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,itemKey: null == itemKey ? _self.itemKey : itemKey // ignore: cast_nullable_to_non_nullable
as String,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,penalty: null == penalty ? _self.penalty : penalty // ignore: cast_nullable_to_non_nullable
as bool,scorer: freezed == scorer ? _self.scorer : scorer // ignore: cast_nullable_to_non_nullable
as String?,scorerAvatar: freezed == scorerAvatar ? _self.scorerAvatar : scorerAvatar // ignore: cast_nullable_to_non_nullable
as String?,assist: freezed == assist ? _self.assist : assist // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveGoal].
extension LiveGoalPatterns on LiveGoal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveGoal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveGoal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveGoal value)  $default,){
final _that = this;
switch (_that) {
case _LiveGoal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveGoal value)?  $default,){
final _that = this;
switch (_that) {
case _LiveGoal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String itemKey,  int minute,  String type,  bool penalty,  String? scorer,  String? scorerAvatar,  String? assist,  int createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveGoal() when $default != null:
return $default(_that.id,_that.itemKey,_that.minute,_that.type,_that.penalty,_that.scorer,_that.scorerAvatar,_that.assist,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String itemKey,  int minute,  String type,  bool penalty,  String? scorer,  String? scorerAvatar,  String? assist,  int createdAt)  $default,) {final _that = this;
switch (_that) {
case _LiveGoal():
return $default(_that.id,_that.itemKey,_that.minute,_that.type,_that.penalty,_that.scorer,_that.scorerAvatar,_that.assist,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String itemKey,  int minute,  String type,  bool penalty,  String? scorer,  String? scorerAvatar,  String? assist,  int createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LiveGoal() when $default != null:
return $default(_that.id,_that.itemKey,_that.minute,_that.type,_that.penalty,_that.scorer,_that.scorerAvatar,_that.assist,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveGoal extends LiveGoal {
  const _LiveGoal({required this.id, required this.itemKey, this.minute = 0, this.type = 'goal', this.penalty = false, this.scorer, this.scorerAvatar, this.assist, this.createdAt = 0}): super._();
  factory _LiveGoal.fromJson(Map<String, dynamic> json) => _$LiveGoalFromJson(json);

@override final  int id;
@override final  String itemKey;
@override@JsonKey() final  int minute;
@override@JsonKey() final  String type;
@override@JsonKey() final  bool penalty;
@override final  String? scorer;
@override final  String? scorerAvatar;
@override final  String? assist;
@override@JsonKey() final  int createdAt;

/// Create a copy of LiveGoal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveGoalCopyWith<_LiveGoal> get copyWith => __$LiveGoalCopyWithImpl<_LiveGoal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveGoalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveGoal&&(identical(other.id, id) || other.id == id)&&(identical(other.itemKey, itemKey) || other.itemKey == itemKey)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.type, type) || other.type == type)&&(identical(other.penalty, penalty) || other.penalty == penalty)&&(identical(other.scorer, scorer) || other.scorer == scorer)&&(identical(other.scorerAvatar, scorerAvatar) || other.scorerAvatar == scorerAvatar)&&(identical(other.assist, assist) || other.assist == assist)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemKey,minute,type,penalty,scorer,scorerAvatar,assist,createdAt);

@override
String toString() {
  return 'LiveGoal(id: $id, itemKey: $itemKey, minute: $minute, type: $type, penalty: $penalty, scorer: $scorer, scorerAvatar: $scorerAvatar, assist: $assist, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LiveGoalCopyWith<$Res> implements $LiveGoalCopyWith<$Res> {
  factory _$LiveGoalCopyWith(_LiveGoal value, $Res Function(_LiveGoal) _then) = __$LiveGoalCopyWithImpl;
@override @useResult
$Res call({
 int id, String itemKey, int minute, String type, bool penalty, String? scorer, String? scorerAvatar, String? assist, int createdAt
});




}
/// @nodoc
class __$LiveGoalCopyWithImpl<$Res>
    implements _$LiveGoalCopyWith<$Res> {
  __$LiveGoalCopyWithImpl(this._self, this._then);

  final _LiveGoal _self;
  final $Res Function(_LiveGoal) _then;

/// Create a copy of LiveGoal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? itemKey = null,Object? minute = null,Object? type = null,Object? penalty = null,Object? scorer = freezed,Object? scorerAvatar = freezed,Object? assist = freezed,Object? createdAt = null,}) {
  return _then(_LiveGoal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,itemKey: null == itemKey ? _self.itemKey : itemKey // ignore: cast_nullable_to_non_nullable
as String,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,penalty: null == penalty ? _self.penalty : penalty // ignore: cast_nullable_to_non_nullable
as bool,scorer: freezed == scorer ? _self.scorer : scorer // ignore: cast_nullable_to_non_nullable
as String?,scorerAvatar: freezed == scorerAvatar ? _self.scorerAvatar : scorerAvatar // ignore: cast_nullable_to_non_nullable
as String?,assist: freezed == assist ? _self.assist : assist // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LiveSub {

 int get id; String get itemKey; int get minute; String? get on; String? get off; int get createdAt;
/// Create a copy of LiveSub
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveSubCopyWith<LiveSub> get copyWith => _$LiveSubCopyWithImpl<LiveSub>(this as LiveSub, _$identity);

  /// Serializes this LiveSub to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveSub&&(identical(other.id, id) || other.id == id)&&(identical(other.itemKey, itemKey) || other.itemKey == itemKey)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.on, on) || other.on == on)&&(identical(other.off, off) || other.off == off)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemKey,minute,on,off,createdAt);

@override
String toString() {
  return 'LiveSub(id: $id, itemKey: $itemKey, minute: $minute, on: $on, off: $off, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LiveSubCopyWith<$Res>  {
  factory $LiveSubCopyWith(LiveSub value, $Res Function(LiveSub) _then) = _$LiveSubCopyWithImpl;
@useResult
$Res call({
 int id, String itemKey, int minute, String? on, String? off, int createdAt
});




}
/// @nodoc
class _$LiveSubCopyWithImpl<$Res>
    implements $LiveSubCopyWith<$Res> {
  _$LiveSubCopyWithImpl(this._self, this._then);

  final LiveSub _self;
  final $Res Function(LiveSub) _then;

/// Create a copy of LiveSub
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? itemKey = null,Object? minute = null,Object? on = freezed,Object? off = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,itemKey: null == itemKey ? _self.itemKey : itemKey // ignore: cast_nullable_to_non_nullable
as String,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,on: freezed == on ? _self.on : on // ignore: cast_nullable_to_non_nullable
as String?,off: freezed == off ? _self.off : off // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveSub].
extension LiveSubPatterns on LiveSub {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveSub value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveSub() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveSub value)  $default,){
final _that = this;
switch (_that) {
case _LiveSub():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveSub value)?  $default,){
final _that = this;
switch (_that) {
case _LiveSub() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String itemKey,  int minute,  String? on,  String? off,  int createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveSub() when $default != null:
return $default(_that.id,_that.itemKey,_that.minute,_that.on,_that.off,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String itemKey,  int minute,  String? on,  String? off,  int createdAt)  $default,) {final _that = this;
switch (_that) {
case _LiveSub():
return $default(_that.id,_that.itemKey,_that.minute,_that.on,_that.off,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String itemKey,  int minute,  String? on,  String? off,  int createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LiveSub() when $default != null:
return $default(_that.id,_that.itemKey,_that.minute,_that.on,_that.off,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveSub implements LiveSub {
  const _LiveSub({required this.id, required this.itemKey, this.minute = 0, this.on, this.off, this.createdAt = 0});
  factory _LiveSub.fromJson(Map<String, dynamic> json) => _$LiveSubFromJson(json);

@override final  int id;
@override final  String itemKey;
@override@JsonKey() final  int minute;
@override final  String? on;
@override final  String? off;
@override@JsonKey() final  int createdAt;

/// Create a copy of LiveSub
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveSubCopyWith<_LiveSub> get copyWith => __$LiveSubCopyWithImpl<_LiveSub>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveSubToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveSub&&(identical(other.id, id) || other.id == id)&&(identical(other.itemKey, itemKey) || other.itemKey == itemKey)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.on, on) || other.on == on)&&(identical(other.off, off) || other.off == off)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemKey,minute,on,off,createdAt);

@override
String toString() {
  return 'LiveSub(id: $id, itemKey: $itemKey, minute: $minute, on: $on, off: $off, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LiveSubCopyWith<$Res> implements $LiveSubCopyWith<$Res> {
  factory _$LiveSubCopyWith(_LiveSub value, $Res Function(_LiveSub) _then) = __$LiveSubCopyWithImpl;
@override @useResult
$Res call({
 int id, String itemKey, int minute, String? on, String? off, int createdAt
});




}
/// @nodoc
class __$LiveSubCopyWithImpl<$Res>
    implements _$LiveSubCopyWith<$Res> {
  __$LiveSubCopyWithImpl(this._self, this._then);

  final _LiveSub _self;
  final $Res Function(_LiveSub) _then;

/// Create a copy of LiveSub
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? itemKey = null,Object? minute = null,Object? on = freezed,Object? off = freezed,Object? createdAt = null,}) {
  return _then(_LiveSub(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,itemKey: null == itemKey ? _self.itemKey : itemKey // ignore: cast_nullable_to_non_nullable
as String,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,on: freezed == on ? _self.on : on // ignore: cast_nullable_to_non_nullable
as String?,off: freezed == off ? _self.off : off // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LiveCard {

 int get id; String get itemKey; int get minute; String get type; String? get player; int get createdAt;
/// Create a copy of LiveCard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveCardCopyWith<LiveCard> get copyWith => _$LiveCardCopyWithImpl<LiveCard>(this as LiveCard, _$identity);

  /// Serializes this LiveCard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveCard&&(identical(other.id, id) || other.id == id)&&(identical(other.itemKey, itemKey) || other.itemKey == itemKey)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.type, type) || other.type == type)&&(identical(other.player, player) || other.player == player)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemKey,minute,type,player,createdAt);

@override
String toString() {
  return 'LiveCard(id: $id, itemKey: $itemKey, minute: $minute, type: $type, player: $player, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LiveCardCopyWith<$Res>  {
  factory $LiveCardCopyWith(LiveCard value, $Res Function(LiveCard) _then) = _$LiveCardCopyWithImpl;
@useResult
$Res call({
 int id, String itemKey, int minute, String type, String? player, int createdAt
});




}
/// @nodoc
class _$LiveCardCopyWithImpl<$Res>
    implements $LiveCardCopyWith<$Res> {
  _$LiveCardCopyWithImpl(this._self, this._then);

  final LiveCard _self;
  final $Res Function(LiveCard) _then;

/// Create a copy of LiveCard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? itemKey = null,Object? minute = null,Object? type = null,Object? player = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,itemKey: null == itemKey ? _self.itemKey : itemKey // ignore: cast_nullable_to_non_nullable
as String,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,player: freezed == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveCard].
extension LiveCardPatterns on LiveCard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveCard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveCard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveCard value)  $default,){
final _that = this;
switch (_that) {
case _LiveCard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveCard value)?  $default,){
final _that = this;
switch (_that) {
case _LiveCard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String itemKey,  int minute,  String type,  String? player,  int createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveCard() when $default != null:
return $default(_that.id,_that.itemKey,_that.minute,_that.type,_that.player,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String itemKey,  int minute,  String type,  String? player,  int createdAt)  $default,) {final _that = this;
switch (_that) {
case _LiveCard():
return $default(_that.id,_that.itemKey,_that.minute,_that.type,_that.player,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String itemKey,  int minute,  String type,  String? player,  int createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LiveCard() when $default != null:
return $default(_that.id,_that.itemKey,_that.minute,_that.type,_that.player,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveCard implements LiveCard {
  const _LiveCard({required this.id, required this.itemKey, this.minute = 0, this.type = '', this.player, this.createdAt = 0});
  factory _LiveCard.fromJson(Map<String, dynamic> json) => _$LiveCardFromJson(json);

@override final  int id;
@override final  String itemKey;
@override@JsonKey() final  int minute;
@override@JsonKey() final  String type;
@override final  String? player;
@override@JsonKey() final  int createdAt;

/// Create a copy of LiveCard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveCardCopyWith<_LiveCard> get copyWith => __$LiveCardCopyWithImpl<_LiveCard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveCardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveCard&&(identical(other.id, id) || other.id == id)&&(identical(other.itemKey, itemKey) || other.itemKey == itemKey)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.type, type) || other.type == type)&&(identical(other.player, player) || other.player == player)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemKey,minute,type,player,createdAt);

@override
String toString() {
  return 'LiveCard(id: $id, itemKey: $itemKey, minute: $minute, type: $type, player: $player, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LiveCardCopyWith<$Res> implements $LiveCardCopyWith<$Res> {
  factory _$LiveCardCopyWith(_LiveCard value, $Res Function(_LiveCard) _then) = __$LiveCardCopyWithImpl;
@override @useResult
$Res call({
 int id, String itemKey, int minute, String type, String? player, int createdAt
});




}
/// @nodoc
class __$LiveCardCopyWithImpl<$Res>
    implements _$LiveCardCopyWith<$Res> {
  __$LiveCardCopyWithImpl(this._self, this._then);

  final _LiveCard _self;
  final $Res Function(_LiveCard) _then;

/// Create a copy of LiveCard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? itemKey = null,Object? minute = null,Object? type = null,Object? player = freezed,Object? createdAt = null,}) {
  return _then(_LiveCard(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,itemKey: null == itemKey ? _self.itemKey : itemKey // ignore: cast_nullable_to_non_nullable
as String,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,player: freezed == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LiveMoment {

 int get id; String get itemKey; int get minute; String get type; String get label; String? get player; int get createdAt;
/// Create a copy of LiveMoment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMomentCopyWith<LiveMoment> get copyWith => _$LiveMomentCopyWithImpl<LiveMoment>(this as LiveMoment, _$identity);

  /// Serializes this LiveMoment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMoment&&(identical(other.id, id) || other.id == id)&&(identical(other.itemKey, itemKey) || other.itemKey == itemKey)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.player, player) || other.player == player)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemKey,minute,type,label,player,createdAt);

@override
String toString() {
  return 'LiveMoment(id: $id, itemKey: $itemKey, minute: $minute, type: $type, label: $label, player: $player, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LiveMomentCopyWith<$Res>  {
  factory $LiveMomentCopyWith(LiveMoment value, $Res Function(LiveMoment) _then) = _$LiveMomentCopyWithImpl;
@useResult
$Res call({
 int id, String itemKey, int minute, String type, String label, String? player, int createdAt
});




}
/// @nodoc
class _$LiveMomentCopyWithImpl<$Res>
    implements $LiveMomentCopyWith<$Res> {
  _$LiveMomentCopyWithImpl(this._self, this._then);

  final LiveMoment _self;
  final $Res Function(LiveMoment) _then;

/// Create a copy of LiveMoment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? itemKey = null,Object? minute = null,Object? type = null,Object? label = null,Object? player = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,itemKey: null == itemKey ? _self.itemKey : itemKey // ignore: cast_nullable_to_non_nullable
as String,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,player: freezed == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveMoment].
extension LiveMomentPatterns on LiveMoment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveMoment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveMoment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveMoment value)  $default,){
final _that = this;
switch (_that) {
case _LiveMoment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveMoment value)?  $default,){
final _that = this;
switch (_that) {
case _LiveMoment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String itemKey,  int minute,  String type,  String label,  String? player,  int createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveMoment() when $default != null:
return $default(_that.id,_that.itemKey,_that.minute,_that.type,_that.label,_that.player,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String itemKey,  int minute,  String type,  String label,  String? player,  int createdAt)  $default,) {final _that = this;
switch (_that) {
case _LiveMoment():
return $default(_that.id,_that.itemKey,_that.minute,_that.type,_that.label,_that.player,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String itemKey,  int minute,  String type,  String label,  String? player,  int createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LiveMoment() when $default != null:
return $default(_that.id,_that.itemKey,_that.minute,_that.type,_that.label,_that.player,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveMoment implements LiveMoment {
  const _LiveMoment({required this.id, required this.itemKey, this.minute = 0, this.type = '', this.label = '', this.player, this.createdAt = 0});
  factory _LiveMoment.fromJson(Map<String, dynamic> json) => _$LiveMomentFromJson(json);

@override final  int id;
@override final  String itemKey;
@override@JsonKey() final  int minute;
@override@JsonKey() final  String type;
@override@JsonKey() final  String label;
@override final  String? player;
@override@JsonKey() final  int createdAt;

/// Create a copy of LiveMoment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveMomentCopyWith<_LiveMoment> get copyWith => __$LiveMomentCopyWithImpl<_LiveMoment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveMomentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveMoment&&(identical(other.id, id) || other.id == id)&&(identical(other.itemKey, itemKey) || other.itemKey == itemKey)&&(identical(other.minute, minute) || other.minute == minute)&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.player, player) || other.player == player)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,itemKey,minute,type,label,player,createdAt);

@override
String toString() {
  return 'LiveMoment(id: $id, itemKey: $itemKey, minute: $minute, type: $type, label: $label, player: $player, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LiveMomentCopyWith<$Res> implements $LiveMomentCopyWith<$Res> {
  factory _$LiveMomentCopyWith(_LiveMoment value, $Res Function(_LiveMoment) _then) = __$LiveMomentCopyWithImpl;
@override @useResult
$Res call({
 int id, String itemKey, int minute, String type, String label, String? player, int createdAt
});




}
/// @nodoc
class __$LiveMomentCopyWithImpl<$Res>
    implements _$LiveMomentCopyWith<$Res> {
  __$LiveMomentCopyWithImpl(this._self, this._then);

  final _LiveMoment _self;
  final $Res Function(_LiveMoment) _then;

/// Create a copy of LiveMoment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? itemKey = null,Object? minute = null,Object? type = null,Object? label = null,Object? player = freezed,Object? createdAt = null,}) {
  return _then(_LiveMoment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,itemKey: null == itemKey ? _self.itemKey : itemKey // ignore: cast_nullable_to_non_nullable
as String,minute: null == minute ? _self.minute : minute // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,player: freezed == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LiveReaction {

 String get emoji; int get count; bool get mine;
/// Create a copy of LiveReaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveReactionCopyWith<LiveReaction> get copyWith => _$LiveReactionCopyWithImpl<LiveReaction>(this as LiveReaction, _$identity);

  /// Serializes this LiveReaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveReaction&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.count, count) || other.count == count)&&(identical(other.mine, mine) || other.mine == mine));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,emoji,count,mine);

@override
String toString() {
  return 'LiveReaction(emoji: $emoji, count: $count, mine: $mine)';
}


}

/// @nodoc
abstract mixin class $LiveReactionCopyWith<$Res>  {
  factory $LiveReactionCopyWith(LiveReaction value, $Res Function(LiveReaction) _then) = _$LiveReactionCopyWithImpl;
@useResult
$Res call({
 String emoji, int count, bool mine
});




}
/// @nodoc
class _$LiveReactionCopyWithImpl<$Res>
    implements $LiveReactionCopyWith<$Res> {
  _$LiveReactionCopyWithImpl(this._self, this._then);

  final LiveReaction _self;
  final $Res Function(LiveReaction) _then;

/// Create a copy of LiveReaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? emoji = null,Object? count = null,Object? mine = null,}) {
  return _then(_self.copyWith(
emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LiveReaction].
extension LiveReactionPatterns on LiveReaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveReaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveReaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveReaction value)  $default,){
final _that = this;
switch (_that) {
case _LiveReaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveReaction value)?  $default,){
final _that = this;
switch (_that) {
case _LiveReaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String emoji,  int count,  bool mine)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveReaction() when $default != null:
return $default(_that.emoji,_that.count,_that.mine);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String emoji,  int count,  bool mine)  $default,) {final _that = this;
switch (_that) {
case _LiveReaction():
return $default(_that.emoji,_that.count,_that.mine);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String emoji,  int count,  bool mine)?  $default,) {final _that = this;
switch (_that) {
case _LiveReaction() when $default != null:
return $default(_that.emoji,_that.count,_that.mine);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveReaction implements LiveReaction {
  const _LiveReaction({required this.emoji, this.count = 0, this.mine = false});
  factory _LiveReaction.fromJson(Map<String, dynamic> json) => _$LiveReactionFromJson(json);

@override final  String emoji;
@override@JsonKey() final  int count;
@override@JsonKey() final  bool mine;

/// Create a copy of LiveReaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveReactionCopyWith<_LiveReaction> get copyWith => __$LiveReactionCopyWithImpl<_LiveReaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveReactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveReaction&&(identical(other.emoji, emoji) || other.emoji == emoji)&&(identical(other.count, count) || other.count == count)&&(identical(other.mine, mine) || other.mine == mine));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,emoji,count,mine);

@override
String toString() {
  return 'LiveReaction(emoji: $emoji, count: $count, mine: $mine)';
}


}

/// @nodoc
abstract mixin class _$LiveReactionCopyWith<$Res> implements $LiveReactionCopyWith<$Res> {
  factory _$LiveReactionCopyWith(_LiveReaction value, $Res Function(_LiveReaction) _then) = __$LiveReactionCopyWithImpl;
@override @useResult
$Res call({
 String emoji, int count, bool mine
});




}
/// @nodoc
class __$LiveReactionCopyWithImpl<$Res>
    implements _$LiveReactionCopyWith<$Res> {
  __$LiveReactionCopyWithImpl(this._self, this._then);

  final _LiveReaction _self;
  final $Res Function(_LiveReaction) _then;

/// Create a copy of LiveReaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? emoji = null,Object? count = null,Object? mine = null,}) {
  return _then(_LiveReaction(
emoji: null == emoji ? _self.emoji : emoji // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$LivePickerPlayer {

 int get id; String get name; int? get shirtNumber; bool get onField;
/// Create a copy of LivePickerPlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivePickerPlayerCopyWith<LivePickerPlayer> get copyWith => _$LivePickerPlayerCopyWithImpl<LivePickerPlayer>(this as LivePickerPlayer, _$identity);

  /// Serializes this LivePickerPlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivePickerPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.onField, onField) || other.onField == onField));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber,onField);

@override
String toString() {
  return 'LivePickerPlayer(id: $id, name: $name, shirtNumber: $shirtNumber, onField: $onField)';
}


}

/// @nodoc
abstract mixin class $LivePickerPlayerCopyWith<$Res>  {
  factory $LivePickerPlayerCopyWith(LivePickerPlayer value, $Res Function(LivePickerPlayer) _then) = _$LivePickerPlayerCopyWithImpl;
@useResult
$Res call({
 int id, String name, int? shirtNumber, bool onField
});




}
/// @nodoc
class _$LivePickerPlayerCopyWithImpl<$Res>
    implements $LivePickerPlayerCopyWith<$Res> {
  _$LivePickerPlayerCopyWithImpl(this._self, this._then);

  final LivePickerPlayer _self;
  final $Res Function(LivePickerPlayer) _then;

/// Create a copy of LivePickerPlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,Object? onField = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,onField: null == onField ? _self.onField : onField // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LivePickerPlayer].
extension LivePickerPlayerPatterns on LivePickerPlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivePickerPlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivePickerPlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivePickerPlayer value)  $default,){
final _that = this;
switch (_that) {
case _LivePickerPlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivePickerPlayer value)?  $default,){
final _that = this;
switch (_that) {
case _LivePickerPlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int? shirtNumber,  bool onField)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivePickerPlayer() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber,_that.onField);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int? shirtNumber,  bool onField)  $default,) {final _that = this;
switch (_that) {
case _LivePickerPlayer():
return $default(_that.id,_that.name,_that.shirtNumber,_that.onField);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int? shirtNumber,  bool onField)?  $default,) {final _that = this;
switch (_that) {
case _LivePickerPlayer() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber,_that.onField);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LivePickerPlayer implements LivePickerPlayer {
  const _LivePickerPlayer({required this.id, this.name = '', this.shirtNumber, this.onField = false});
  factory _LivePickerPlayer.fromJson(Map<String, dynamic> json) => _$LivePickerPlayerFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  int? shirtNumber;
@override@JsonKey() final  bool onField;

/// Create a copy of LivePickerPlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivePickerPlayerCopyWith<_LivePickerPlayer> get copyWith => __$LivePickerPlayerCopyWithImpl<_LivePickerPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LivePickerPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivePickerPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.onField, onField) || other.onField == onField));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber,onField);

@override
String toString() {
  return 'LivePickerPlayer(id: $id, name: $name, shirtNumber: $shirtNumber, onField: $onField)';
}


}

/// @nodoc
abstract mixin class _$LivePickerPlayerCopyWith<$Res> implements $LivePickerPlayerCopyWith<$Res> {
  factory _$LivePickerPlayerCopyWith(_LivePickerPlayer value, $Res Function(_LivePickerPlayer) _then) = __$LivePickerPlayerCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int? shirtNumber, bool onField
});




}
/// @nodoc
class __$LivePickerPlayerCopyWithImpl<$Res>
    implements _$LivePickerPlayerCopyWith<$Res> {
  __$LivePickerPlayerCopyWithImpl(this._self, this._then);

  final _LivePickerPlayer _self;
  final $Res Function(_LivePickerPlayer) _then;

/// Create a copy of LivePickerPlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,Object? onField = null,}) {
  return _then(_LivePickerPlayer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,onField: null == onField ? _self.onField : onField // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$LivePickers {

 bool get hasLineup; List<LivePickerPlayer> get present; List<LivePickerPlayer> get allPlayers;
/// Create a copy of LivePickers
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LivePickersCopyWith<LivePickers> get copyWith => _$LivePickersCopyWithImpl<LivePickers>(this as LivePickers, _$identity);

  /// Serializes this LivePickers to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LivePickers&&(identical(other.hasLineup, hasLineup) || other.hasLineup == hasLineup)&&const DeepCollectionEquality().equals(other.present, present)&&const DeepCollectionEquality().equals(other.allPlayers, allPlayers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasLineup,const DeepCollectionEquality().hash(present),const DeepCollectionEquality().hash(allPlayers));

@override
String toString() {
  return 'LivePickers(hasLineup: $hasLineup, present: $present, allPlayers: $allPlayers)';
}


}

/// @nodoc
abstract mixin class $LivePickersCopyWith<$Res>  {
  factory $LivePickersCopyWith(LivePickers value, $Res Function(LivePickers) _then) = _$LivePickersCopyWithImpl;
@useResult
$Res call({
 bool hasLineup, List<LivePickerPlayer> present, List<LivePickerPlayer> allPlayers
});




}
/// @nodoc
class _$LivePickersCopyWithImpl<$Res>
    implements $LivePickersCopyWith<$Res> {
  _$LivePickersCopyWithImpl(this._self, this._then);

  final LivePickers _self;
  final $Res Function(LivePickers) _then;

/// Create a copy of LivePickers
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hasLineup = null,Object? present = null,Object? allPlayers = null,}) {
  return _then(_self.copyWith(
hasLineup: null == hasLineup ? _self.hasLineup : hasLineup // ignore: cast_nullable_to_non_nullable
as bool,present: null == present ? _self.present : present // ignore: cast_nullable_to_non_nullable
as List<LivePickerPlayer>,allPlayers: null == allPlayers ? _self.allPlayers : allPlayers // ignore: cast_nullable_to_non_nullable
as List<LivePickerPlayer>,
  ));
}

}


/// Adds pattern-matching-related methods to [LivePickers].
extension LivePickersPatterns on LivePickers {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LivePickers value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LivePickers() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LivePickers value)  $default,){
final _that = this;
switch (_that) {
case _LivePickers():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LivePickers value)?  $default,){
final _that = this;
switch (_that) {
case _LivePickers() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool hasLineup,  List<LivePickerPlayer> present,  List<LivePickerPlayer> allPlayers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LivePickers() when $default != null:
return $default(_that.hasLineup,_that.present,_that.allPlayers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool hasLineup,  List<LivePickerPlayer> present,  List<LivePickerPlayer> allPlayers)  $default,) {final _that = this;
switch (_that) {
case _LivePickers():
return $default(_that.hasLineup,_that.present,_that.allPlayers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool hasLineup,  List<LivePickerPlayer> present,  List<LivePickerPlayer> allPlayers)?  $default,) {final _that = this;
switch (_that) {
case _LivePickers() when $default != null:
return $default(_that.hasLineup,_that.present,_that.allPlayers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LivePickers extends LivePickers {
  const _LivePickers({this.hasLineup = false, final  List<LivePickerPlayer> present = const <LivePickerPlayer>[], final  List<LivePickerPlayer> allPlayers = const <LivePickerPlayer>[]}): _present = present,_allPlayers = allPlayers,super._();
  factory _LivePickers.fromJson(Map<String, dynamic> json) => _$LivePickersFromJson(json);

@override@JsonKey() final  bool hasLineup;
 final  List<LivePickerPlayer> _present;
@override@JsonKey() List<LivePickerPlayer> get present {
  if (_present is EqualUnmodifiableListView) return _present;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_present);
}

 final  List<LivePickerPlayer> _allPlayers;
@override@JsonKey() List<LivePickerPlayer> get allPlayers {
  if (_allPlayers is EqualUnmodifiableListView) return _allPlayers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allPlayers);
}


/// Create a copy of LivePickers
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LivePickersCopyWith<_LivePickers> get copyWith => __$LivePickersCopyWithImpl<_LivePickers>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LivePickersToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LivePickers&&(identical(other.hasLineup, hasLineup) || other.hasLineup == hasLineup)&&const DeepCollectionEquality().equals(other._present, _present)&&const DeepCollectionEquality().equals(other._allPlayers, _allPlayers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hasLineup,const DeepCollectionEquality().hash(_present),const DeepCollectionEquality().hash(_allPlayers));

@override
String toString() {
  return 'LivePickers(hasLineup: $hasLineup, present: $present, allPlayers: $allPlayers)';
}


}

/// @nodoc
abstract mixin class _$LivePickersCopyWith<$Res> implements $LivePickersCopyWith<$Res> {
  factory _$LivePickersCopyWith(_LivePickers value, $Res Function(_LivePickers) _then) = __$LivePickersCopyWithImpl;
@override @useResult
$Res call({
 bool hasLineup, List<LivePickerPlayer> present, List<LivePickerPlayer> allPlayers
});




}
/// @nodoc
class __$LivePickersCopyWithImpl<$Res>
    implements _$LivePickersCopyWith<$Res> {
  __$LivePickersCopyWithImpl(this._self, this._then);

  final _LivePickers _self;
  final $Res Function(_LivePickers) _then;

/// Create a copy of LivePickers
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hasLineup = null,Object? present = null,Object? allPlayers = null,}) {
  return _then(_LivePickers(
hasLineup: null == hasLineup ? _self.hasLineup : hasLineup // ignore: cast_nullable_to_non_nullable
as bool,present: null == present ? _self._present : present // ignore: cast_nullable_to_non_nullable
as List<LivePickerPlayer>,allPlayers: null == allPlayers ? _self._allPlayers : allPlayers // ignore: cast_nullable_to_non_nullable
as List<LivePickerPlayer>,
  ));
}


}


/// @nodoc
mixin _$LiveMatch {

 String get sport; LiveEvent get event; LiveRules get rules; List<LiveGoal> get goals; List<LiveSub> get subs; List<LiveCard> get cards; List<LiveMoment> get moments;@LiveReactionsConverter() Map<String, List<LiveReaction>> get reactions; bool get canReact; List<String> get reactionEmoji; int get liveViewers; bool get followingLive; bool get canManage; LivePickers? get pickers;
/// Create a copy of LiveMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveMatchCopyWith<LiveMatch> get copyWith => _$LiveMatchCopyWithImpl<LiveMatch>(this as LiveMatch, _$identity);

  /// Serializes this LiveMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveMatch&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.event, event) || other.event == event)&&(identical(other.rules, rules) || other.rules == rules)&&const DeepCollectionEquality().equals(other.goals, goals)&&const DeepCollectionEquality().equals(other.subs, subs)&&const DeepCollectionEquality().equals(other.cards, cards)&&const DeepCollectionEquality().equals(other.moments, moments)&&const DeepCollectionEquality().equals(other.reactions, reactions)&&(identical(other.canReact, canReact) || other.canReact == canReact)&&const DeepCollectionEquality().equals(other.reactionEmoji, reactionEmoji)&&(identical(other.liveViewers, liveViewers) || other.liveViewers == liveViewers)&&(identical(other.followingLive, followingLive) || other.followingLive == followingLive)&&(identical(other.canManage, canManage) || other.canManage == canManage)&&(identical(other.pickers, pickers) || other.pickers == pickers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sport,event,rules,const DeepCollectionEquality().hash(goals),const DeepCollectionEquality().hash(subs),const DeepCollectionEquality().hash(cards),const DeepCollectionEquality().hash(moments),const DeepCollectionEquality().hash(reactions),canReact,const DeepCollectionEquality().hash(reactionEmoji),liveViewers,followingLive,canManage,pickers);

@override
String toString() {
  return 'LiveMatch(sport: $sport, event: $event, rules: $rules, goals: $goals, subs: $subs, cards: $cards, moments: $moments, reactions: $reactions, canReact: $canReact, reactionEmoji: $reactionEmoji, liveViewers: $liveViewers, followingLive: $followingLive, canManage: $canManage, pickers: $pickers)';
}


}

/// @nodoc
abstract mixin class $LiveMatchCopyWith<$Res>  {
  factory $LiveMatchCopyWith(LiveMatch value, $Res Function(LiveMatch) _then) = _$LiveMatchCopyWithImpl;
@useResult
$Res call({
 String sport, LiveEvent event, LiveRules rules, List<LiveGoal> goals, List<LiveSub> subs, List<LiveCard> cards, List<LiveMoment> moments,@LiveReactionsConverter() Map<String, List<LiveReaction>> reactions, bool canReact, List<String> reactionEmoji, int liveViewers, bool followingLive, bool canManage, LivePickers? pickers
});


$LiveEventCopyWith<$Res> get event;$LiveRulesCopyWith<$Res> get rules;$LivePickersCopyWith<$Res>? get pickers;

}
/// @nodoc
class _$LiveMatchCopyWithImpl<$Res>
    implements $LiveMatchCopyWith<$Res> {
  _$LiveMatchCopyWithImpl(this._self, this._then);

  final LiveMatch _self;
  final $Res Function(LiveMatch) _then;

/// Create a copy of LiveMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sport = null,Object? event = null,Object? rules = null,Object? goals = null,Object? subs = null,Object? cards = null,Object? moments = null,Object? reactions = null,Object? canReact = null,Object? reactionEmoji = null,Object? liveViewers = null,Object? followingLive = null,Object? canManage = null,Object? pickers = freezed,}) {
  return _then(_self.copyWith(
sport: null == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as LiveEvent,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as LiveRules,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as List<LiveGoal>,subs: null == subs ? _self.subs : subs // ignore: cast_nullable_to_non_nullable
as List<LiveSub>,cards: null == cards ? _self.cards : cards // ignore: cast_nullable_to_non_nullable
as List<LiveCard>,moments: null == moments ? _self.moments : moments // ignore: cast_nullable_to_non_nullable
as List<LiveMoment>,reactions: null == reactions ? _self.reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<LiveReaction>>,canReact: null == canReact ? _self.canReact : canReact // ignore: cast_nullable_to_non_nullable
as bool,reactionEmoji: null == reactionEmoji ? _self.reactionEmoji : reactionEmoji // ignore: cast_nullable_to_non_nullable
as List<String>,liveViewers: null == liveViewers ? _self.liveViewers : liveViewers // ignore: cast_nullable_to_non_nullable
as int,followingLive: null == followingLive ? _self.followingLive : followingLive // ignore: cast_nullable_to_non_nullable
as bool,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,pickers: freezed == pickers ? _self.pickers : pickers // ignore: cast_nullable_to_non_nullable
as LivePickers?,
  ));
}
/// Create a copy of LiveMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveEventCopyWith<$Res> get event {
  
  return $LiveEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}/// Create a copy of LiveMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveRulesCopyWith<$Res> get rules {
  
  return $LiveRulesCopyWith<$Res>(_self.rules, (value) {
    return _then(_self.copyWith(rules: value));
  });
}/// Create a copy of LiveMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivePickersCopyWith<$Res>? get pickers {
    if (_self.pickers == null) {
    return null;
  }

  return $LivePickersCopyWith<$Res>(_self.pickers!, (value) {
    return _then(_self.copyWith(pickers: value));
  });
}
}


/// Adds pattern-matching-related methods to [LiveMatch].
extension LiveMatchPatterns on LiveMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveMatch value)  $default,){
final _that = this;
switch (_that) {
case _LiveMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveMatch value)?  $default,){
final _that = this;
switch (_that) {
case _LiveMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sport,  LiveEvent event,  LiveRules rules,  List<LiveGoal> goals,  List<LiveSub> subs,  List<LiveCard> cards,  List<LiveMoment> moments, @LiveReactionsConverter()  Map<String, List<LiveReaction>> reactions,  bool canReact,  List<String> reactionEmoji,  int liveViewers,  bool followingLive,  bool canManage,  LivePickers? pickers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LiveMatch() when $default != null:
return $default(_that.sport,_that.event,_that.rules,_that.goals,_that.subs,_that.cards,_that.moments,_that.reactions,_that.canReact,_that.reactionEmoji,_that.liveViewers,_that.followingLive,_that.canManage,_that.pickers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sport,  LiveEvent event,  LiveRules rules,  List<LiveGoal> goals,  List<LiveSub> subs,  List<LiveCard> cards,  List<LiveMoment> moments, @LiveReactionsConverter()  Map<String, List<LiveReaction>> reactions,  bool canReact,  List<String> reactionEmoji,  int liveViewers,  bool followingLive,  bool canManage,  LivePickers? pickers)  $default,) {final _that = this;
switch (_that) {
case _LiveMatch():
return $default(_that.sport,_that.event,_that.rules,_that.goals,_that.subs,_that.cards,_that.moments,_that.reactions,_that.canReact,_that.reactionEmoji,_that.liveViewers,_that.followingLive,_that.canManage,_that.pickers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sport,  LiveEvent event,  LiveRules rules,  List<LiveGoal> goals,  List<LiveSub> subs,  List<LiveCard> cards,  List<LiveMoment> moments, @LiveReactionsConverter()  Map<String, List<LiveReaction>> reactions,  bool canReact,  List<String> reactionEmoji,  int liveViewers,  bool followingLive,  bool canManage,  LivePickers? pickers)?  $default,) {final _that = this;
switch (_that) {
case _LiveMatch() when $default != null:
return $default(_that.sport,_that.event,_that.rules,_that.goals,_that.subs,_that.cards,_that.moments,_that.reactions,_that.canReact,_that.reactionEmoji,_that.liveViewers,_that.followingLive,_that.canManage,_that.pickers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveMatch extends LiveMatch {
  const _LiveMatch({this.sport = '', required this.event, this.rules = const LiveRules(), final  List<LiveGoal> goals = const <LiveGoal>[], final  List<LiveSub> subs = const <LiveSub>[], final  List<LiveCard> cards = const <LiveCard>[], final  List<LiveMoment> moments = const <LiveMoment>[], @LiveReactionsConverter() final  Map<String, List<LiveReaction>> reactions = const <String, List<LiveReaction>>{}, this.canReact = false, final  List<String> reactionEmoji = const <String>[], this.liveViewers = 0, this.followingLive = false, this.canManage = false, this.pickers}): _goals = goals,_subs = subs,_cards = cards,_moments = moments,_reactions = reactions,_reactionEmoji = reactionEmoji,super._();
  factory _LiveMatch.fromJson(Map<String, dynamic> json) => _$LiveMatchFromJson(json);

@override@JsonKey() final  String sport;
@override final  LiveEvent event;
@override@JsonKey() final  LiveRules rules;
 final  List<LiveGoal> _goals;
@override@JsonKey() List<LiveGoal> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

 final  List<LiveSub> _subs;
@override@JsonKey() List<LiveSub> get subs {
  if (_subs is EqualUnmodifiableListView) return _subs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subs);
}

 final  List<LiveCard> _cards;
@override@JsonKey() List<LiveCard> get cards {
  if (_cards is EqualUnmodifiableListView) return _cards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cards);
}

 final  List<LiveMoment> _moments;
@override@JsonKey() List<LiveMoment> get moments {
  if (_moments is EqualUnmodifiableListView) return _moments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moments);
}

 final  Map<String, List<LiveReaction>> _reactions;
@override@JsonKey()@LiveReactionsConverter() Map<String, List<LiveReaction>> get reactions {
  if (_reactions is EqualUnmodifiableMapView) return _reactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_reactions);
}

@override@JsonKey() final  bool canReact;
 final  List<String> _reactionEmoji;
@override@JsonKey() List<String> get reactionEmoji {
  if (_reactionEmoji is EqualUnmodifiableListView) return _reactionEmoji;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reactionEmoji);
}

@override@JsonKey() final  int liveViewers;
@override@JsonKey() final  bool followingLive;
@override@JsonKey() final  bool canManage;
@override final  LivePickers? pickers;

/// Create a copy of LiveMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveMatchCopyWith<_LiveMatch> get copyWith => __$LiveMatchCopyWithImpl<_LiveMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveMatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveMatch&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.event, event) || other.event == event)&&(identical(other.rules, rules) || other.rules == rules)&&const DeepCollectionEquality().equals(other._goals, _goals)&&const DeepCollectionEquality().equals(other._subs, _subs)&&const DeepCollectionEquality().equals(other._cards, _cards)&&const DeepCollectionEquality().equals(other._moments, _moments)&&const DeepCollectionEquality().equals(other._reactions, _reactions)&&(identical(other.canReact, canReact) || other.canReact == canReact)&&const DeepCollectionEquality().equals(other._reactionEmoji, _reactionEmoji)&&(identical(other.liveViewers, liveViewers) || other.liveViewers == liveViewers)&&(identical(other.followingLive, followingLive) || other.followingLive == followingLive)&&(identical(other.canManage, canManage) || other.canManage == canManage)&&(identical(other.pickers, pickers) || other.pickers == pickers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sport,event,rules,const DeepCollectionEquality().hash(_goals),const DeepCollectionEquality().hash(_subs),const DeepCollectionEquality().hash(_cards),const DeepCollectionEquality().hash(_moments),const DeepCollectionEquality().hash(_reactions),canReact,const DeepCollectionEquality().hash(_reactionEmoji),liveViewers,followingLive,canManage,pickers);

@override
String toString() {
  return 'LiveMatch(sport: $sport, event: $event, rules: $rules, goals: $goals, subs: $subs, cards: $cards, moments: $moments, reactions: $reactions, canReact: $canReact, reactionEmoji: $reactionEmoji, liveViewers: $liveViewers, followingLive: $followingLive, canManage: $canManage, pickers: $pickers)';
}


}

/// @nodoc
abstract mixin class _$LiveMatchCopyWith<$Res> implements $LiveMatchCopyWith<$Res> {
  factory _$LiveMatchCopyWith(_LiveMatch value, $Res Function(_LiveMatch) _then) = __$LiveMatchCopyWithImpl;
@override @useResult
$Res call({
 String sport, LiveEvent event, LiveRules rules, List<LiveGoal> goals, List<LiveSub> subs, List<LiveCard> cards, List<LiveMoment> moments,@LiveReactionsConverter() Map<String, List<LiveReaction>> reactions, bool canReact, List<String> reactionEmoji, int liveViewers, bool followingLive, bool canManage, LivePickers? pickers
});


@override $LiveEventCopyWith<$Res> get event;@override $LiveRulesCopyWith<$Res> get rules;@override $LivePickersCopyWith<$Res>? get pickers;

}
/// @nodoc
class __$LiveMatchCopyWithImpl<$Res>
    implements _$LiveMatchCopyWith<$Res> {
  __$LiveMatchCopyWithImpl(this._self, this._then);

  final _LiveMatch _self;
  final $Res Function(_LiveMatch) _then;

/// Create a copy of LiveMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sport = null,Object? event = null,Object? rules = null,Object? goals = null,Object? subs = null,Object? cards = null,Object? moments = null,Object? reactions = null,Object? canReact = null,Object? reactionEmoji = null,Object? liveViewers = null,Object? followingLive = null,Object? canManage = null,Object? pickers = freezed,}) {
  return _then(_LiveMatch(
sport: null == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as LiveEvent,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as LiveRules,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<LiveGoal>,subs: null == subs ? _self._subs : subs // ignore: cast_nullable_to_non_nullable
as List<LiveSub>,cards: null == cards ? _self._cards : cards // ignore: cast_nullable_to_non_nullable
as List<LiveCard>,moments: null == moments ? _self._moments : moments // ignore: cast_nullable_to_non_nullable
as List<LiveMoment>,reactions: null == reactions ? _self._reactions : reactions // ignore: cast_nullable_to_non_nullable
as Map<String, List<LiveReaction>>,canReact: null == canReact ? _self.canReact : canReact // ignore: cast_nullable_to_non_nullable
as bool,reactionEmoji: null == reactionEmoji ? _self._reactionEmoji : reactionEmoji // ignore: cast_nullable_to_non_nullable
as List<String>,liveViewers: null == liveViewers ? _self.liveViewers : liveViewers // ignore: cast_nullable_to_non_nullable
as int,followingLive: null == followingLive ? _self.followingLive : followingLive // ignore: cast_nullable_to_non_nullable
as bool,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,pickers: freezed == pickers ? _self.pickers : pickers // ignore: cast_nullable_to_non_nullable
as LivePickers?,
  ));
}

/// Create a copy of LiveMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveEventCopyWith<$Res> get event {
  
  return $LiveEventCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}/// Create a copy of LiveMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveRulesCopyWith<$Res> get rules {
  
  return $LiveRulesCopyWith<$Res>(_self.rules, (value) {
    return _then(_self.copyWith(rules: value));
  });
}/// Create a copy of LiveMatch
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LivePickersCopyWith<$Res>? get pickers {
    if (_self.pickers == null) {
    return null;
  }

  return $LivePickersCopyWith<$Res>(_self.pickers!, (value) {
    return _then(_self.copyWith(pickers: value));
  });
}
}

// dart format on
