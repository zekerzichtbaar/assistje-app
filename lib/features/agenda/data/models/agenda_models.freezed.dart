// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agenda_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceCounts {

 int get present; int get absent; int get nonplay; int get pending;
/// Create a copy of AttendanceCounts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceCountsCopyWith<AttendanceCounts> get copyWith => _$AttendanceCountsCopyWithImpl<AttendanceCounts>(this as AttendanceCounts, _$identity);

  /// Serializes this AttendanceCounts to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceCounts&&(identical(other.present, present) || other.present == present)&&(identical(other.absent, absent) || other.absent == absent)&&(identical(other.nonplay, nonplay) || other.nonplay == nonplay)&&(identical(other.pending, pending) || other.pending == pending));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,present,absent,nonplay,pending);

@override
String toString() {
  return 'AttendanceCounts(present: $present, absent: $absent, nonplay: $nonplay, pending: $pending)';
}


}

/// @nodoc
abstract mixin class $AttendanceCountsCopyWith<$Res>  {
  factory $AttendanceCountsCopyWith(AttendanceCounts value, $Res Function(AttendanceCounts) _then) = _$AttendanceCountsCopyWithImpl;
@useResult
$Res call({
 int present, int absent, int nonplay, int pending
});




}
/// @nodoc
class _$AttendanceCountsCopyWithImpl<$Res>
    implements $AttendanceCountsCopyWith<$Res> {
  _$AttendanceCountsCopyWithImpl(this._self, this._then);

  final AttendanceCounts _self;
  final $Res Function(AttendanceCounts) _then;

/// Create a copy of AttendanceCounts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? present = null,Object? absent = null,Object? nonplay = null,Object? pending = null,}) {
  return _then(_self.copyWith(
present: null == present ? _self.present : present // ignore: cast_nullable_to_non_nullable
as int,absent: null == absent ? _self.absent : absent // ignore: cast_nullable_to_non_nullable
as int,nonplay: null == nonplay ? _self.nonplay : nonplay // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceCounts].
extension AttendanceCountsPatterns on AttendanceCounts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceCounts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceCounts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceCounts value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceCounts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceCounts value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceCounts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int present,  int absent,  int nonplay,  int pending)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceCounts() when $default != null:
return $default(_that.present,_that.absent,_that.nonplay,_that.pending);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int present,  int absent,  int nonplay,  int pending)  $default,) {final _that = this;
switch (_that) {
case _AttendanceCounts():
return $default(_that.present,_that.absent,_that.nonplay,_that.pending);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int present,  int absent,  int nonplay,  int pending)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceCounts() when $default != null:
return $default(_that.present,_that.absent,_that.nonplay,_that.pending);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceCounts extends AttendanceCounts {
  const _AttendanceCounts({this.present = 0, this.absent = 0, this.nonplay = 0, this.pending = 0}): super._();
  factory _AttendanceCounts.fromJson(Map<String, dynamic> json) => _$AttendanceCountsFromJson(json);

@override@JsonKey() final  int present;
@override@JsonKey() final  int absent;
@override@JsonKey() final  int nonplay;
@override@JsonKey() final  int pending;

/// Create a copy of AttendanceCounts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceCountsCopyWith<_AttendanceCounts> get copyWith => __$AttendanceCountsCopyWithImpl<_AttendanceCounts>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceCountsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceCounts&&(identical(other.present, present) || other.present == present)&&(identical(other.absent, absent) || other.absent == absent)&&(identical(other.nonplay, nonplay) || other.nonplay == nonplay)&&(identical(other.pending, pending) || other.pending == pending));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,present,absent,nonplay,pending);

@override
String toString() {
  return 'AttendanceCounts(present: $present, absent: $absent, nonplay: $nonplay, pending: $pending)';
}


}

/// @nodoc
abstract mixin class _$AttendanceCountsCopyWith<$Res> implements $AttendanceCountsCopyWith<$Res> {
  factory _$AttendanceCountsCopyWith(_AttendanceCounts value, $Res Function(_AttendanceCounts) _then) = __$AttendanceCountsCopyWithImpl;
@override @useResult
$Res call({
 int present, int absent, int nonplay, int pending
});




}
/// @nodoc
class __$AttendanceCountsCopyWithImpl<$Res>
    implements _$AttendanceCountsCopyWith<$Res> {
  __$AttendanceCountsCopyWithImpl(this._self, this._then);

  final _AttendanceCounts _self;
  final $Res Function(_AttendanceCounts) _then;

/// Create a copy of AttendanceCounts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? present = null,Object? absent = null,Object? nonplay = null,Object? pending = null,}) {
  return _then(_AttendanceCounts(
present: null == present ? _self.present : present // ignore: cast_nullable_to_non_nullable
as int,absent: null == absent ? _self.absent : absent // ignore: cast_nullable_to_non_nullable
as int,nonplay: null == nonplay ? _self.nonplay : nonplay // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LiveState {

 bool get isLive; bool get running; DateTime? get startedAt; int get accumulatedSeconds; DateTime? get endedAt; int get period; List<int> get periodEnds;
/// Create a copy of LiveState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LiveStateCopyWith<LiveState> get copyWith => _$LiveStateCopyWithImpl<LiveState>(this as LiveState, _$identity);

  /// Serializes this LiveState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LiveState&&(identical(other.isLive, isLive) || other.isLive == isLive)&&(identical(other.running, running) || other.running == running)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.accumulatedSeconds, accumulatedSeconds) || other.accumulatedSeconds == accumulatedSeconds)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other.periodEnds, periodEnds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLive,running,startedAt,accumulatedSeconds,endedAt,period,const DeepCollectionEquality().hash(periodEnds));

@override
String toString() {
  return 'LiveState(isLive: $isLive, running: $running, startedAt: $startedAt, accumulatedSeconds: $accumulatedSeconds, endedAt: $endedAt, period: $period, periodEnds: $periodEnds)';
}


}

/// @nodoc
abstract mixin class $LiveStateCopyWith<$Res>  {
  factory $LiveStateCopyWith(LiveState value, $Res Function(LiveState) _then) = _$LiveStateCopyWithImpl;
@useResult
$Res call({
 bool isLive, bool running, DateTime? startedAt, int accumulatedSeconds, DateTime? endedAt, int period, List<int> periodEnds
});




}
/// @nodoc
class _$LiveStateCopyWithImpl<$Res>
    implements $LiveStateCopyWith<$Res> {
  _$LiveStateCopyWithImpl(this._self, this._then);

  final LiveState _self;
  final $Res Function(LiveState) _then;

/// Create a copy of LiveState
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


/// Adds pattern-matching-related methods to [LiveState].
extension LiveStatePatterns on LiveState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LiveState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LiveState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LiveState value)  $default,){
final _that = this;
switch (_that) {
case _LiveState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LiveState value)?  $default,){
final _that = this;
switch (_that) {
case _LiveState() when $default != null:
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
case _LiveState() when $default != null:
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
case _LiveState():
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
case _LiveState() when $default != null:
return $default(_that.isLive,_that.running,_that.startedAt,_that.accumulatedSeconds,_that.endedAt,_that.period,_that.periodEnds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LiveState extends LiveState {
  const _LiveState({this.isLive = false, this.running = false, this.startedAt, this.accumulatedSeconds = 0, this.endedAt, this.period = 1, final  List<int> periodEnds = const <int>[]}): _periodEnds = periodEnds,super._();
  factory _LiveState.fromJson(Map<String, dynamic> json) => _$LiveStateFromJson(json);

@override@JsonKey() final  bool isLive;
@override@JsonKey() final  bool running;
@override final  DateTime? startedAt;
@override@JsonKey() final  int accumulatedSeconds;
@override final  DateTime? endedAt;
@override@JsonKey() final  int period;
 final  List<int> _periodEnds;
@override@JsonKey() List<int> get periodEnds {
  if (_periodEnds is EqualUnmodifiableListView) return _periodEnds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_periodEnds);
}


/// Create a copy of LiveState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LiveStateCopyWith<_LiveState> get copyWith => __$LiveStateCopyWithImpl<_LiveState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LiveStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LiveState&&(identical(other.isLive, isLive) || other.isLive == isLive)&&(identical(other.running, running) || other.running == running)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.accumulatedSeconds, accumulatedSeconds) || other.accumulatedSeconds == accumulatedSeconds)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other._periodEnds, _periodEnds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isLive,running,startedAt,accumulatedSeconds,endedAt,period,const DeepCollectionEquality().hash(_periodEnds));

@override
String toString() {
  return 'LiveState(isLive: $isLive, running: $running, startedAt: $startedAt, accumulatedSeconds: $accumulatedSeconds, endedAt: $endedAt, period: $period, periodEnds: $periodEnds)';
}


}

/// @nodoc
abstract mixin class _$LiveStateCopyWith<$Res> implements $LiveStateCopyWith<$Res> {
  factory _$LiveStateCopyWith(_LiveState value, $Res Function(_LiveState) _then) = __$LiveStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLive, bool running, DateTime? startedAt, int accumulatedSeconds, DateTime? endedAt, int period, List<int> periodEnds
});




}
/// @nodoc
class __$LiveStateCopyWithImpl<$Res>
    implements _$LiveStateCopyWith<$Res> {
  __$LiveStateCopyWithImpl(this._self, this._then);

  final _LiveState _self;
  final $Res Function(_LiveState) _then;

/// Create a copy of LiveState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLive = null,Object? running = null,Object? startedAt = freezed,Object? accumulatedSeconds = null,Object? endedAt = freezed,Object? period = null,Object? periodEnds = null,}) {
  return _then(_LiveState(
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
mixin _$AgendaEvent {

 int get id;@JsonKey(unknownEnumValue: EventType.unknown) EventType get type; String get title; DateTime get startsAt; DateTime? get endsAt; DateTime? get meetAt; String? get venue; String? get homeTeam; String? get awayTeam;/// `league`, `cup`, `friendly` of `null`.
 String? get competition; int? get homeScore; int? get awayScore; DateTime? get cancelledAt;@JsonKey(unknownEnumValue: AttendanceStatus.pending) AttendanceStatus? get myStatus; AttendanceCounts get counts;/// Alleen spelers (zonder staf); `null` = gelijk aan [counts].
 AttendanceCounts? get playerCounts; AttendanceCounts get guestCounts; LiveState? get live; bool get inVacation;/// Mag ík hierop reageren? `null` = de pagina-brede `can_rsvp`.
 bool? get canRsvp;@JsonKey(unknownEnumValue: AttendanceStatus.pending) List<AttendanceStatus> get rsvpStatuses; bool get spectatorsCanRsvp; int get spectatorsPresent;
/// Create a copy of AgendaEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaEventCopyWith<AgendaEvent> get copyWith => _$AgendaEventCopyWithImpl<AgendaEvent>(this as AgendaEvent, _$identity);

  /// Serializes this AgendaEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.meetAt, meetAt) || other.meetAt == meetAt)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.competition, competition) || other.competition == competition)&&(identical(other.homeScore, homeScore) || other.homeScore == homeScore)&&(identical(other.awayScore, awayScore) || other.awayScore == awayScore)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.myStatus, myStatus) || other.myStatus == myStatus)&&(identical(other.counts, counts) || other.counts == counts)&&(identical(other.playerCounts, playerCounts) || other.playerCounts == playerCounts)&&(identical(other.guestCounts, guestCounts) || other.guestCounts == guestCounts)&&(identical(other.live, live) || other.live == live)&&(identical(other.inVacation, inVacation) || other.inVacation == inVacation)&&(identical(other.canRsvp, canRsvp) || other.canRsvp == canRsvp)&&const DeepCollectionEquality().equals(other.rsvpStatuses, rsvpStatuses)&&(identical(other.spectatorsCanRsvp, spectatorsCanRsvp) || other.spectatorsCanRsvp == spectatorsCanRsvp)&&(identical(other.spectatorsPresent, spectatorsPresent) || other.spectatorsPresent == spectatorsPresent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,type,title,startsAt,endsAt,meetAt,venue,homeTeam,awayTeam,competition,homeScore,awayScore,cancelledAt,myStatus,counts,playerCounts,guestCounts,live,inVacation,canRsvp,const DeepCollectionEquality().hash(rsvpStatuses),spectatorsCanRsvp,spectatorsPresent]);

@override
String toString() {
  return 'AgendaEvent(id: $id, type: $type, title: $title, startsAt: $startsAt, endsAt: $endsAt, meetAt: $meetAt, venue: $venue, homeTeam: $homeTeam, awayTeam: $awayTeam, competition: $competition, homeScore: $homeScore, awayScore: $awayScore, cancelledAt: $cancelledAt, myStatus: $myStatus, counts: $counts, playerCounts: $playerCounts, guestCounts: $guestCounts, live: $live, inVacation: $inVacation, canRsvp: $canRsvp, rsvpStatuses: $rsvpStatuses, spectatorsCanRsvp: $spectatorsCanRsvp, spectatorsPresent: $spectatorsPresent)';
}


}

/// @nodoc
abstract mixin class $AgendaEventCopyWith<$Res>  {
  factory $AgendaEventCopyWith(AgendaEvent value, $Res Function(AgendaEvent) _then) = _$AgendaEventCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(unknownEnumValue: EventType.unknown) EventType type, String title, DateTime startsAt, DateTime? endsAt, DateTime? meetAt, String? venue, String? homeTeam, String? awayTeam, String? competition, int? homeScore, int? awayScore, DateTime? cancelledAt,@JsonKey(unknownEnumValue: AttendanceStatus.pending) AttendanceStatus? myStatus, AttendanceCounts counts, AttendanceCounts? playerCounts, AttendanceCounts guestCounts, LiveState? live, bool inVacation, bool? canRsvp,@JsonKey(unknownEnumValue: AttendanceStatus.pending) List<AttendanceStatus> rsvpStatuses, bool spectatorsCanRsvp, int spectatorsPresent
});


$AttendanceCountsCopyWith<$Res> get counts;$AttendanceCountsCopyWith<$Res>? get playerCounts;$AttendanceCountsCopyWith<$Res> get guestCounts;$LiveStateCopyWith<$Res>? get live;

}
/// @nodoc
class _$AgendaEventCopyWithImpl<$Res>
    implements $AgendaEventCopyWith<$Res> {
  _$AgendaEventCopyWithImpl(this._self, this._then);

  final AgendaEvent _self;
  final $Res Function(AgendaEvent) _then;

/// Create a copy of AgendaEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? startsAt = null,Object? endsAt = freezed,Object? meetAt = freezed,Object? venue = freezed,Object? homeTeam = freezed,Object? awayTeam = freezed,Object? competition = freezed,Object? homeScore = freezed,Object? awayScore = freezed,Object? cancelledAt = freezed,Object? myStatus = freezed,Object? counts = null,Object? playerCounts = freezed,Object? guestCounts = null,Object? live = freezed,Object? inVacation = null,Object? canRsvp = freezed,Object? rsvpStatuses = null,Object? spectatorsCanRsvp = null,Object? spectatorsPresent = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,meetAt: freezed == meetAt ? _self.meetAt : meetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,homeTeam: freezed == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String?,awayTeam: freezed == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String?,competition: freezed == competition ? _self.competition : competition // ignore: cast_nullable_to_non_nullable
as String?,homeScore: freezed == homeScore ? _self.homeScore : homeScore // ignore: cast_nullable_to_non_nullable
as int?,awayScore: freezed == awayScore ? _self.awayScore : awayScore // ignore: cast_nullable_to_non_nullable
as int?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,myStatus: freezed == myStatus ? _self.myStatus : myStatus // ignore: cast_nullable_to_non_nullable
as AttendanceStatus?,counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as AttendanceCounts,playerCounts: freezed == playerCounts ? _self.playerCounts : playerCounts // ignore: cast_nullable_to_non_nullable
as AttendanceCounts?,guestCounts: null == guestCounts ? _self.guestCounts : guestCounts // ignore: cast_nullable_to_non_nullable
as AttendanceCounts,live: freezed == live ? _self.live : live // ignore: cast_nullable_to_non_nullable
as LiveState?,inVacation: null == inVacation ? _self.inVacation : inVacation // ignore: cast_nullable_to_non_nullable
as bool,canRsvp: freezed == canRsvp ? _self.canRsvp : canRsvp // ignore: cast_nullable_to_non_nullable
as bool?,rsvpStatuses: null == rsvpStatuses ? _self.rsvpStatuses : rsvpStatuses // ignore: cast_nullable_to_non_nullable
as List<AttendanceStatus>,spectatorsCanRsvp: null == spectatorsCanRsvp ? _self.spectatorsCanRsvp : spectatorsCanRsvp // ignore: cast_nullable_to_non_nullable
as bool,spectatorsPresent: null == spectatorsPresent ? _self.spectatorsPresent : spectatorsPresent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of AgendaEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCountsCopyWith<$Res> get counts {
  
  return $AttendanceCountsCopyWith<$Res>(_self.counts, (value) {
    return _then(_self.copyWith(counts: value));
  });
}/// Create a copy of AgendaEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCountsCopyWith<$Res>? get playerCounts {
    if (_self.playerCounts == null) {
    return null;
  }

  return $AttendanceCountsCopyWith<$Res>(_self.playerCounts!, (value) {
    return _then(_self.copyWith(playerCounts: value));
  });
}/// Create a copy of AgendaEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCountsCopyWith<$Res> get guestCounts {
  
  return $AttendanceCountsCopyWith<$Res>(_self.guestCounts, (value) {
    return _then(_self.copyWith(guestCounts: value));
  });
}/// Create a copy of AgendaEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveStateCopyWith<$Res>? get live {
    if (_self.live == null) {
    return null;
  }

  return $LiveStateCopyWith<$Res>(_self.live!, (value) {
    return _then(_self.copyWith(live: value));
  });
}
}


/// Adds pattern-matching-related methods to [AgendaEvent].
extension AgendaEventPatterns on AgendaEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgendaEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgendaEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgendaEvent value)  $default,){
final _that = this;
switch (_that) {
case _AgendaEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgendaEvent value)?  $default,){
final _that = this;
switch (_that) {
case _AgendaEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(unknownEnumValue: EventType.unknown)  EventType type,  String title,  DateTime startsAt,  DateTime? endsAt,  DateTime? meetAt,  String? venue,  String? homeTeam,  String? awayTeam,  String? competition,  int? homeScore,  int? awayScore,  DateTime? cancelledAt, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  AttendanceStatus? myStatus,  AttendanceCounts counts,  AttendanceCounts? playerCounts,  AttendanceCounts guestCounts,  LiveState? live,  bool inVacation,  bool? canRsvp, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  List<AttendanceStatus> rsvpStatuses,  bool spectatorsCanRsvp,  int spectatorsPresent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgendaEvent() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.endsAt,_that.meetAt,_that.venue,_that.homeTeam,_that.awayTeam,_that.competition,_that.homeScore,_that.awayScore,_that.cancelledAt,_that.myStatus,_that.counts,_that.playerCounts,_that.guestCounts,_that.live,_that.inVacation,_that.canRsvp,_that.rsvpStatuses,_that.spectatorsCanRsvp,_that.spectatorsPresent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(unknownEnumValue: EventType.unknown)  EventType type,  String title,  DateTime startsAt,  DateTime? endsAt,  DateTime? meetAt,  String? venue,  String? homeTeam,  String? awayTeam,  String? competition,  int? homeScore,  int? awayScore,  DateTime? cancelledAt, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  AttendanceStatus? myStatus,  AttendanceCounts counts,  AttendanceCounts? playerCounts,  AttendanceCounts guestCounts,  LiveState? live,  bool inVacation,  bool? canRsvp, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  List<AttendanceStatus> rsvpStatuses,  bool spectatorsCanRsvp,  int spectatorsPresent)  $default,) {final _that = this;
switch (_that) {
case _AgendaEvent():
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.endsAt,_that.meetAt,_that.venue,_that.homeTeam,_that.awayTeam,_that.competition,_that.homeScore,_that.awayScore,_that.cancelledAt,_that.myStatus,_that.counts,_that.playerCounts,_that.guestCounts,_that.live,_that.inVacation,_that.canRsvp,_that.rsvpStatuses,_that.spectatorsCanRsvp,_that.spectatorsPresent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(unknownEnumValue: EventType.unknown)  EventType type,  String title,  DateTime startsAt,  DateTime? endsAt,  DateTime? meetAt,  String? venue,  String? homeTeam,  String? awayTeam,  String? competition,  int? homeScore,  int? awayScore,  DateTime? cancelledAt, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  AttendanceStatus? myStatus,  AttendanceCounts counts,  AttendanceCounts? playerCounts,  AttendanceCounts guestCounts,  LiveState? live,  bool inVacation,  bool? canRsvp, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  List<AttendanceStatus> rsvpStatuses,  bool spectatorsCanRsvp,  int spectatorsPresent)?  $default,) {final _that = this;
switch (_that) {
case _AgendaEvent() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.startsAt,_that.endsAt,_that.meetAt,_that.venue,_that.homeTeam,_that.awayTeam,_that.competition,_that.homeScore,_that.awayScore,_that.cancelledAt,_that.myStatus,_that.counts,_that.playerCounts,_that.guestCounts,_that.live,_that.inVacation,_that.canRsvp,_that.rsvpStatuses,_that.spectatorsCanRsvp,_that.spectatorsPresent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AgendaEvent extends AgendaEvent {
  const _AgendaEvent({required this.id, @JsonKey(unknownEnumValue: EventType.unknown) this.type = EventType.unknown, this.title = '', required this.startsAt, this.endsAt, this.meetAt, this.venue, this.homeTeam, this.awayTeam, this.competition, this.homeScore, this.awayScore, this.cancelledAt, @JsonKey(unknownEnumValue: AttendanceStatus.pending) this.myStatus, this.counts = const AttendanceCounts(), this.playerCounts, this.guestCounts = const AttendanceCounts(), this.live, this.inVacation = false, this.canRsvp, @JsonKey(unknownEnumValue: AttendanceStatus.pending) final  List<AttendanceStatus> rsvpStatuses = const <AttendanceStatus>[AttendanceStatus.present, AttendanceStatus.absent, AttendanceStatus.nonplay], this.spectatorsCanRsvp = false, this.spectatorsPresent = 0}): _rsvpStatuses = rsvpStatuses,super._();
  factory _AgendaEvent.fromJson(Map<String, dynamic> json) => _$AgendaEventFromJson(json);

@override final  int id;
@override@JsonKey(unknownEnumValue: EventType.unknown) final  EventType type;
@override@JsonKey() final  String title;
@override final  DateTime startsAt;
@override final  DateTime? endsAt;
@override final  DateTime? meetAt;
@override final  String? venue;
@override final  String? homeTeam;
@override final  String? awayTeam;
/// `league`, `cup`, `friendly` of `null`.
@override final  String? competition;
@override final  int? homeScore;
@override final  int? awayScore;
@override final  DateTime? cancelledAt;
@override@JsonKey(unknownEnumValue: AttendanceStatus.pending) final  AttendanceStatus? myStatus;
@override@JsonKey() final  AttendanceCounts counts;
/// Alleen spelers (zonder staf); `null` = gelijk aan [counts].
@override final  AttendanceCounts? playerCounts;
@override@JsonKey() final  AttendanceCounts guestCounts;
@override final  LiveState? live;
@override@JsonKey() final  bool inVacation;
/// Mag ík hierop reageren? `null` = de pagina-brede `can_rsvp`.
@override final  bool? canRsvp;
 final  List<AttendanceStatus> _rsvpStatuses;
@override@JsonKey(unknownEnumValue: AttendanceStatus.pending) List<AttendanceStatus> get rsvpStatuses {
  if (_rsvpStatuses is EqualUnmodifiableListView) return _rsvpStatuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rsvpStatuses);
}

@override@JsonKey() final  bool spectatorsCanRsvp;
@override@JsonKey() final  int spectatorsPresent;

/// Create a copy of AgendaEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgendaEventCopyWith<_AgendaEvent> get copyWith => __$AgendaEventCopyWithImpl<_AgendaEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgendaEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgendaEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.meetAt, meetAt) || other.meetAt == meetAt)&&(identical(other.venue, venue) || other.venue == venue)&&(identical(other.homeTeam, homeTeam) || other.homeTeam == homeTeam)&&(identical(other.awayTeam, awayTeam) || other.awayTeam == awayTeam)&&(identical(other.competition, competition) || other.competition == competition)&&(identical(other.homeScore, homeScore) || other.homeScore == homeScore)&&(identical(other.awayScore, awayScore) || other.awayScore == awayScore)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.myStatus, myStatus) || other.myStatus == myStatus)&&(identical(other.counts, counts) || other.counts == counts)&&(identical(other.playerCounts, playerCounts) || other.playerCounts == playerCounts)&&(identical(other.guestCounts, guestCounts) || other.guestCounts == guestCounts)&&(identical(other.live, live) || other.live == live)&&(identical(other.inVacation, inVacation) || other.inVacation == inVacation)&&(identical(other.canRsvp, canRsvp) || other.canRsvp == canRsvp)&&const DeepCollectionEquality().equals(other._rsvpStatuses, _rsvpStatuses)&&(identical(other.spectatorsCanRsvp, spectatorsCanRsvp) || other.spectatorsCanRsvp == spectatorsCanRsvp)&&(identical(other.spectatorsPresent, spectatorsPresent) || other.spectatorsPresent == spectatorsPresent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,type,title,startsAt,endsAt,meetAt,venue,homeTeam,awayTeam,competition,homeScore,awayScore,cancelledAt,myStatus,counts,playerCounts,guestCounts,live,inVacation,canRsvp,const DeepCollectionEquality().hash(_rsvpStatuses),spectatorsCanRsvp,spectatorsPresent]);

@override
String toString() {
  return 'AgendaEvent(id: $id, type: $type, title: $title, startsAt: $startsAt, endsAt: $endsAt, meetAt: $meetAt, venue: $venue, homeTeam: $homeTeam, awayTeam: $awayTeam, competition: $competition, homeScore: $homeScore, awayScore: $awayScore, cancelledAt: $cancelledAt, myStatus: $myStatus, counts: $counts, playerCounts: $playerCounts, guestCounts: $guestCounts, live: $live, inVacation: $inVacation, canRsvp: $canRsvp, rsvpStatuses: $rsvpStatuses, spectatorsCanRsvp: $spectatorsCanRsvp, spectatorsPresent: $spectatorsPresent)';
}


}

/// @nodoc
abstract mixin class _$AgendaEventCopyWith<$Res> implements $AgendaEventCopyWith<$Res> {
  factory _$AgendaEventCopyWith(_AgendaEvent value, $Res Function(_AgendaEvent) _then) = __$AgendaEventCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(unknownEnumValue: EventType.unknown) EventType type, String title, DateTime startsAt, DateTime? endsAt, DateTime? meetAt, String? venue, String? homeTeam, String? awayTeam, String? competition, int? homeScore, int? awayScore, DateTime? cancelledAt,@JsonKey(unknownEnumValue: AttendanceStatus.pending) AttendanceStatus? myStatus, AttendanceCounts counts, AttendanceCounts? playerCounts, AttendanceCounts guestCounts, LiveState? live, bool inVacation, bool? canRsvp,@JsonKey(unknownEnumValue: AttendanceStatus.pending) List<AttendanceStatus> rsvpStatuses, bool spectatorsCanRsvp, int spectatorsPresent
});


@override $AttendanceCountsCopyWith<$Res> get counts;@override $AttendanceCountsCopyWith<$Res>? get playerCounts;@override $AttendanceCountsCopyWith<$Res> get guestCounts;@override $LiveStateCopyWith<$Res>? get live;

}
/// @nodoc
class __$AgendaEventCopyWithImpl<$Res>
    implements _$AgendaEventCopyWith<$Res> {
  __$AgendaEventCopyWithImpl(this._self, this._then);

  final _AgendaEvent _self;
  final $Res Function(_AgendaEvent) _then;

/// Create a copy of AgendaEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? startsAt = null,Object? endsAt = freezed,Object? meetAt = freezed,Object? venue = freezed,Object? homeTeam = freezed,Object? awayTeam = freezed,Object? competition = freezed,Object? homeScore = freezed,Object? awayScore = freezed,Object? cancelledAt = freezed,Object? myStatus = freezed,Object? counts = null,Object? playerCounts = freezed,Object? guestCounts = null,Object? live = freezed,Object? inVacation = null,Object? canRsvp = freezed,Object? rsvpStatuses = null,Object? spectatorsCanRsvp = null,Object? spectatorsPresent = null,}) {
  return _then(_AgendaEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,meetAt: freezed == meetAt ? _self.meetAt : meetAt // ignore: cast_nullable_to_non_nullable
as DateTime?,venue: freezed == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String?,homeTeam: freezed == homeTeam ? _self.homeTeam : homeTeam // ignore: cast_nullable_to_non_nullable
as String?,awayTeam: freezed == awayTeam ? _self.awayTeam : awayTeam // ignore: cast_nullable_to_non_nullable
as String?,competition: freezed == competition ? _self.competition : competition // ignore: cast_nullable_to_non_nullable
as String?,homeScore: freezed == homeScore ? _self.homeScore : homeScore // ignore: cast_nullable_to_non_nullable
as int?,awayScore: freezed == awayScore ? _self.awayScore : awayScore // ignore: cast_nullable_to_non_nullable
as int?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,myStatus: freezed == myStatus ? _self.myStatus : myStatus // ignore: cast_nullable_to_non_nullable
as AttendanceStatus?,counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as AttendanceCounts,playerCounts: freezed == playerCounts ? _self.playerCounts : playerCounts // ignore: cast_nullable_to_non_nullable
as AttendanceCounts?,guestCounts: null == guestCounts ? _self.guestCounts : guestCounts // ignore: cast_nullable_to_non_nullable
as AttendanceCounts,live: freezed == live ? _self.live : live // ignore: cast_nullable_to_non_nullable
as LiveState?,inVacation: null == inVacation ? _self.inVacation : inVacation // ignore: cast_nullable_to_non_nullable
as bool,canRsvp: freezed == canRsvp ? _self.canRsvp : canRsvp // ignore: cast_nullable_to_non_nullable
as bool?,rsvpStatuses: null == rsvpStatuses ? _self._rsvpStatuses : rsvpStatuses // ignore: cast_nullable_to_non_nullable
as List<AttendanceStatus>,spectatorsCanRsvp: null == spectatorsCanRsvp ? _self.spectatorsCanRsvp : spectatorsCanRsvp // ignore: cast_nullable_to_non_nullable
as bool,spectatorsPresent: null == spectatorsPresent ? _self.spectatorsPresent : spectatorsPresent // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of AgendaEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCountsCopyWith<$Res> get counts {
  
  return $AttendanceCountsCopyWith<$Res>(_self.counts, (value) {
    return _then(_self.copyWith(counts: value));
  });
}/// Create a copy of AgendaEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCountsCopyWith<$Res>? get playerCounts {
    if (_self.playerCounts == null) {
    return null;
  }

  return $AttendanceCountsCopyWith<$Res>(_self.playerCounts!, (value) {
    return _then(_self.copyWith(playerCounts: value));
  });
}/// Create a copy of AgendaEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttendanceCountsCopyWith<$Res> get guestCounts {
  
  return $AttendanceCountsCopyWith<$Res>(_self.guestCounts, (value) {
    return _then(_self.copyWith(guestCounts: value));
  });
}/// Create a copy of AgendaEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LiveStateCopyWith<$Res>? get live {
    if (_self.live == null) {
    return null;
  }

  return $LiveStateCopyWith<$Res>(_self.live!, (value) {
    return _then(_self.copyWith(live: value));
  });
}
}


/// @nodoc
mixin _$AgendaDuty {

 String get kind; int? get dutyId; int? get washId; int? get eventId; bool get matchBound;/// Kalenderdatum (ISO, met tijdzone); alleen de dag telt.
 String get date; String get dutyType; String? get icon; String get title; String? get groupName; List<String> get playerNames; String? get timeRange;/// Tijd als tekst (`16:00`), niet als moment.
 String? get startsAt; String? get endsAt; String? get notes; bool get done; bool get mine;
/// Create a copy of AgendaDuty
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaDutyCopyWith<AgendaDuty> get copyWith => _$AgendaDutyCopyWithImpl<AgendaDuty>(this as AgendaDuty, _$identity);

  /// Serializes this AgendaDuty to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaDuty&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.dutyId, dutyId) || other.dutyId == dutyId)&&(identical(other.washId, washId) || other.washId == washId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.matchBound, matchBound) || other.matchBound == matchBound)&&(identical(other.date, date) || other.date == date)&&(identical(other.dutyType, dutyType) || other.dutyType == dutyType)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.title, title) || other.title == title)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&const DeepCollectionEquality().equals(other.playerNames, playerNames)&&(identical(other.timeRange, timeRange) || other.timeRange == timeRange)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.done, done) || other.done == done)&&(identical(other.mine, mine) || other.mine == mine));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,dutyId,washId,eventId,matchBound,date,dutyType,icon,title,groupName,const DeepCollectionEquality().hash(playerNames),timeRange,startsAt,endsAt,notes,done,mine);

@override
String toString() {
  return 'AgendaDuty(kind: $kind, dutyId: $dutyId, washId: $washId, eventId: $eventId, matchBound: $matchBound, date: $date, dutyType: $dutyType, icon: $icon, title: $title, groupName: $groupName, playerNames: $playerNames, timeRange: $timeRange, startsAt: $startsAt, endsAt: $endsAt, notes: $notes, done: $done, mine: $mine)';
}


}

/// @nodoc
abstract mixin class $AgendaDutyCopyWith<$Res>  {
  factory $AgendaDutyCopyWith(AgendaDuty value, $Res Function(AgendaDuty) _then) = _$AgendaDutyCopyWithImpl;
@useResult
$Res call({
 String kind, int? dutyId, int? washId, int? eventId, bool matchBound, String date, String dutyType, String? icon, String title, String? groupName, List<String> playerNames, String? timeRange, String? startsAt, String? endsAt, String? notes, bool done, bool mine
});




}
/// @nodoc
class _$AgendaDutyCopyWithImpl<$Res>
    implements $AgendaDutyCopyWith<$Res> {
  _$AgendaDutyCopyWithImpl(this._self, this._then);

  final AgendaDuty _self;
  final $Res Function(AgendaDuty) _then;

/// Create a copy of AgendaDuty
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? dutyId = freezed,Object? washId = freezed,Object? eventId = freezed,Object? matchBound = null,Object? date = null,Object? dutyType = null,Object? icon = freezed,Object? title = null,Object? groupName = freezed,Object? playerNames = null,Object? timeRange = freezed,Object? startsAt = freezed,Object? endsAt = freezed,Object? notes = freezed,Object? done = null,Object? mine = null,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,dutyId: freezed == dutyId ? _self.dutyId : dutyId // ignore: cast_nullable_to_non_nullable
as int?,washId: freezed == washId ? _self.washId : washId // ignore: cast_nullable_to_non_nullable
as int?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,matchBound: null == matchBound ? _self.matchBound : matchBound // ignore: cast_nullable_to_non_nullable
as bool,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dutyType: null == dutyType ? _self.dutyType : dutyType // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,playerNames: null == playerNames ? _self.playerNames : playerNames // ignore: cast_nullable_to_non_nullable
as List<String>,timeRange: freezed == timeRange ? _self.timeRange : timeRange // ignore: cast_nullable_to_non_nullable
as String?,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AgendaDuty].
extension AgendaDutyPatterns on AgendaDuty {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgendaDuty value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgendaDuty() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgendaDuty value)  $default,){
final _that = this;
switch (_that) {
case _AgendaDuty():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgendaDuty value)?  $default,){
final _that = this;
switch (_that) {
case _AgendaDuty() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String kind,  int? dutyId,  int? washId,  int? eventId,  bool matchBound,  String date,  String dutyType,  String? icon,  String title,  String? groupName,  List<String> playerNames,  String? timeRange,  String? startsAt,  String? endsAt,  String? notes,  bool done,  bool mine)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgendaDuty() when $default != null:
return $default(_that.kind,_that.dutyId,_that.washId,_that.eventId,_that.matchBound,_that.date,_that.dutyType,_that.icon,_that.title,_that.groupName,_that.playerNames,_that.timeRange,_that.startsAt,_that.endsAt,_that.notes,_that.done,_that.mine);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String kind,  int? dutyId,  int? washId,  int? eventId,  bool matchBound,  String date,  String dutyType,  String? icon,  String title,  String? groupName,  List<String> playerNames,  String? timeRange,  String? startsAt,  String? endsAt,  String? notes,  bool done,  bool mine)  $default,) {final _that = this;
switch (_that) {
case _AgendaDuty():
return $default(_that.kind,_that.dutyId,_that.washId,_that.eventId,_that.matchBound,_that.date,_that.dutyType,_that.icon,_that.title,_that.groupName,_that.playerNames,_that.timeRange,_that.startsAt,_that.endsAt,_that.notes,_that.done,_that.mine);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String kind,  int? dutyId,  int? washId,  int? eventId,  bool matchBound,  String date,  String dutyType,  String? icon,  String title,  String? groupName,  List<String> playerNames,  String? timeRange,  String? startsAt,  String? endsAt,  String? notes,  bool done,  bool mine)?  $default,) {final _that = this;
switch (_that) {
case _AgendaDuty() when $default != null:
return $default(_that.kind,_that.dutyId,_that.washId,_that.eventId,_that.matchBound,_that.date,_that.dutyType,_that.icon,_that.title,_that.groupName,_that.playerNames,_that.timeRange,_that.startsAt,_that.endsAt,_that.notes,_that.done,_that.mine);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AgendaDuty extends AgendaDuty {
  const _AgendaDuty({this.kind = 'duty', this.dutyId, this.washId, this.eventId, this.matchBound = false, required this.date, this.dutyType = '', this.icon, this.title = '', this.groupName, final  List<String> playerNames = const <String>[], this.timeRange, this.startsAt, this.endsAt, this.notes, this.done = false, this.mine = false}): _playerNames = playerNames,super._();
  factory _AgendaDuty.fromJson(Map<String, dynamic> json) => _$AgendaDutyFromJson(json);

@override@JsonKey() final  String kind;
@override final  int? dutyId;
@override final  int? washId;
@override final  int? eventId;
@override@JsonKey() final  bool matchBound;
/// Kalenderdatum (ISO, met tijdzone); alleen de dag telt.
@override final  String date;
@override@JsonKey() final  String dutyType;
@override final  String? icon;
@override@JsonKey() final  String title;
@override final  String? groupName;
 final  List<String> _playerNames;
@override@JsonKey() List<String> get playerNames {
  if (_playerNames is EqualUnmodifiableListView) return _playerNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_playerNames);
}

@override final  String? timeRange;
/// Tijd als tekst (`16:00`), niet als moment.
@override final  String? startsAt;
@override final  String? endsAt;
@override final  String? notes;
@override@JsonKey() final  bool done;
@override@JsonKey() final  bool mine;

/// Create a copy of AgendaDuty
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgendaDutyCopyWith<_AgendaDuty> get copyWith => __$AgendaDutyCopyWithImpl<_AgendaDuty>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgendaDutyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgendaDuty&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.dutyId, dutyId) || other.dutyId == dutyId)&&(identical(other.washId, washId) || other.washId == washId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.matchBound, matchBound) || other.matchBound == matchBound)&&(identical(other.date, date) || other.date == date)&&(identical(other.dutyType, dutyType) || other.dutyType == dutyType)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.title, title) || other.title == title)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&const DeepCollectionEquality().equals(other._playerNames, _playerNames)&&(identical(other.timeRange, timeRange) || other.timeRange == timeRange)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.done, done) || other.done == done)&&(identical(other.mine, mine) || other.mine == mine));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,kind,dutyId,washId,eventId,matchBound,date,dutyType,icon,title,groupName,const DeepCollectionEquality().hash(_playerNames),timeRange,startsAt,endsAt,notes,done,mine);

@override
String toString() {
  return 'AgendaDuty(kind: $kind, dutyId: $dutyId, washId: $washId, eventId: $eventId, matchBound: $matchBound, date: $date, dutyType: $dutyType, icon: $icon, title: $title, groupName: $groupName, playerNames: $playerNames, timeRange: $timeRange, startsAt: $startsAt, endsAt: $endsAt, notes: $notes, done: $done, mine: $mine)';
}


}

/// @nodoc
abstract mixin class _$AgendaDutyCopyWith<$Res> implements $AgendaDutyCopyWith<$Res> {
  factory _$AgendaDutyCopyWith(_AgendaDuty value, $Res Function(_AgendaDuty) _then) = __$AgendaDutyCopyWithImpl;
@override @useResult
$Res call({
 String kind, int? dutyId, int? washId, int? eventId, bool matchBound, String date, String dutyType, String? icon, String title, String? groupName, List<String> playerNames, String? timeRange, String? startsAt, String? endsAt, String? notes, bool done, bool mine
});




}
/// @nodoc
class __$AgendaDutyCopyWithImpl<$Res>
    implements _$AgendaDutyCopyWith<$Res> {
  __$AgendaDutyCopyWithImpl(this._self, this._then);

  final _AgendaDuty _self;
  final $Res Function(_AgendaDuty) _then;

/// Create a copy of AgendaDuty
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? dutyId = freezed,Object? washId = freezed,Object? eventId = freezed,Object? matchBound = null,Object? date = null,Object? dutyType = null,Object? icon = freezed,Object? title = null,Object? groupName = freezed,Object? playerNames = null,Object? timeRange = freezed,Object? startsAt = freezed,Object? endsAt = freezed,Object? notes = freezed,Object? done = null,Object? mine = null,}) {
  return _then(_AgendaDuty(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String,dutyId: freezed == dutyId ? _self.dutyId : dutyId // ignore: cast_nullable_to_non_nullable
as int?,washId: freezed == washId ? _self.washId : washId // ignore: cast_nullable_to_non_nullable
as int?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,matchBound: null == matchBound ? _self.matchBound : matchBound // ignore: cast_nullable_to_non_nullable
as bool,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dutyType: null == dutyType ? _self.dutyType : dutyType // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,playerNames: null == playerNames ? _self._playerNames : playerNames // ignore: cast_nullable_to_non_nullable
as List<String>,timeRange: freezed == timeRange ? _self.timeRange : timeRange // ignore: cast_nullable_to_non_nullable
as String?,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AgendaBirthday {

 String get key; int? get playerId; String get name; String? get avatarUrl;/// `YYYY-MM-DD`.
 String get date; int? get turning; bool get isToday;
/// Create a copy of AgendaBirthday
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaBirthdayCopyWith<AgendaBirthday> get copyWith => _$AgendaBirthdayCopyWithImpl<AgendaBirthday>(this as AgendaBirthday, _$identity);

  /// Serializes this AgendaBirthday to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaBirthday&&(identical(other.key, key) || other.key == key)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.date, date) || other.date == date)&&(identical(other.turning, turning) || other.turning == turning)&&(identical(other.isToday, isToday) || other.isToday == isToday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,playerId,name,avatarUrl,date,turning,isToday);

@override
String toString() {
  return 'AgendaBirthday(key: $key, playerId: $playerId, name: $name, avatarUrl: $avatarUrl, date: $date, turning: $turning, isToday: $isToday)';
}


}

/// @nodoc
abstract mixin class $AgendaBirthdayCopyWith<$Res>  {
  factory $AgendaBirthdayCopyWith(AgendaBirthday value, $Res Function(AgendaBirthday) _then) = _$AgendaBirthdayCopyWithImpl;
@useResult
$Res call({
 String key, int? playerId, String name, String? avatarUrl, String date, int? turning, bool isToday
});




}
/// @nodoc
class _$AgendaBirthdayCopyWithImpl<$Res>
    implements $AgendaBirthdayCopyWith<$Res> {
  _$AgendaBirthdayCopyWithImpl(this._self, this._then);

  final AgendaBirthday _self;
  final $Res Function(AgendaBirthday) _then;

/// Create a copy of AgendaBirthday
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? playerId = freezed,Object? name = null,Object? avatarUrl = freezed,Object? date = null,Object? turning = freezed,Object? isToday = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,turning: freezed == turning ? _self.turning : turning // ignore: cast_nullable_to_non_nullable
as int?,isToday: null == isToday ? _self.isToday : isToday // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AgendaBirthday].
extension AgendaBirthdayPatterns on AgendaBirthday {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgendaBirthday value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgendaBirthday() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgendaBirthday value)  $default,){
final _that = this;
switch (_that) {
case _AgendaBirthday():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgendaBirthday value)?  $default,){
final _that = this;
switch (_that) {
case _AgendaBirthday() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  int? playerId,  String name,  String? avatarUrl,  String date,  int? turning,  bool isToday)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgendaBirthday() when $default != null:
return $default(_that.key,_that.playerId,_that.name,_that.avatarUrl,_that.date,_that.turning,_that.isToday);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  int? playerId,  String name,  String? avatarUrl,  String date,  int? turning,  bool isToday)  $default,) {final _that = this;
switch (_that) {
case _AgendaBirthday():
return $default(_that.key,_that.playerId,_that.name,_that.avatarUrl,_that.date,_that.turning,_that.isToday);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  int? playerId,  String name,  String? avatarUrl,  String date,  int? turning,  bool isToday)?  $default,) {final _that = this;
switch (_that) {
case _AgendaBirthday() when $default != null:
return $default(_that.key,_that.playerId,_that.name,_that.avatarUrl,_that.date,_that.turning,_that.isToday);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AgendaBirthday implements AgendaBirthday {
  const _AgendaBirthday({required this.key, this.playerId, required this.name, this.avatarUrl, required this.date, this.turning, this.isToday = false});
  factory _AgendaBirthday.fromJson(Map<String, dynamic> json) => _$AgendaBirthdayFromJson(json);

@override final  String key;
@override final  int? playerId;
@override final  String name;
@override final  String? avatarUrl;
/// `YYYY-MM-DD`.
@override final  String date;
@override final  int? turning;
@override@JsonKey() final  bool isToday;

/// Create a copy of AgendaBirthday
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgendaBirthdayCopyWith<_AgendaBirthday> get copyWith => __$AgendaBirthdayCopyWithImpl<_AgendaBirthday>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgendaBirthdayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgendaBirthday&&(identical(other.key, key) || other.key == key)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.date, date) || other.date == date)&&(identical(other.turning, turning) || other.turning == turning)&&(identical(other.isToday, isToday) || other.isToday == isToday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,playerId,name,avatarUrl,date,turning,isToday);

@override
String toString() {
  return 'AgendaBirthday(key: $key, playerId: $playerId, name: $name, avatarUrl: $avatarUrl, date: $date, turning: $turning, isToday: $isToday)';
}


}

/// @nodoc
abstract mixin class _$AgendaBirthdayCopyWith<$Res> implements $AgendaBirthdayCopyWith<$Res> {
  factory _$AgendaBirthdayCopyWith(_AgendaBirthday value, $Res Function(_AgendaBirthday) _then) = __$AgendaBirthdayCopyWithImpl;
@override @useResult
$Res call({
 String key, int? playerId, String name, String? avatarUrl, String date, int? turning, bool isToday
});




}
/// @nodoc
class __$AgendaBirthdayCopyWithImpl<$Res>
    implements _$AgendaBirthdayCopyWith<$Res> {
  __$AgendaBirthdayCopyWithImpl(this._self, this._then);

  final _AgendaBirthday _self;
  final $Res Function(_AgendaBirthday) _then;

/// Create a copy of AgendaBirthday
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? playerId = freezed,Object? name = null,Object? avatarUrl = freezed,Object? date = null,Object? turning = freezed,Object? isToday = null,}) {
  return _then(_AgendaBirthday(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,turning: freezed == turning ? _self.turning : turning // ignore: cast_nullable_to_non_nullable
as int?,isToday: null == isToday ? _self.isToday : isToday // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$DutyTypeMeta {

 int get id; String get name; String get slug; String? get icon;
/// Create a copy of DutyTypeMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyTypeMetaCopyWith<DutyTypeMeta> get copyWith => _$DutyTypeMetaCopyWithImpl<DutyTypeMeta>(this as DutyTypeMeta, _$identity);

  /// Serializes this DutyTypeMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyTypeMeta&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,icon);

@override
String toString() {
  return 'DutyTypeMeta(id: $id, name: $name, slug: $slug, icon: $icon)';
}


}

/// @nodoc
abstract mixin class $DutyTypeMetaCopyWith<$Res>  {
  factory $DutyTypeMetaCopyWith(DutyTypeMeta value, $Res Function(DutyTypeMeta) _then) = _$DutyTypeMetaCopyWithImpl;
@useResult
$Res call({
 int id, String name, String slug, String? icon
});




}
/// @nodoc
class _$DutyTypeMetaCopyWithImpl<$Res>
    implements $DutyTypeMetaCopyWith<$Res> {
  _$DutyTypeMetaCopyWithImpl(this._self, this._then);

  final DutyTypeMeta _self;
  final $Res Function(DutyTypeMeta) _then;

/// Create a copy of DutyTypeMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? icon = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DutyTypeMeta].
extension DutyTypeMetaPatterns on DutyTypeMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyTypeMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyTypeMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyTypeMeta value)  $default,){
final _that = this;
switch (_that) {
case _DutyTypeMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyTypeMeta value)?  $default,){
final _that = this;
switch (_that) {
case _DutyTypeMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String? icon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyTypeMeta() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.icon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String? icon)  $default,) {final _that = this;
switch (_that) {
case _DutyTypeMeta():
return $default(_that.id,_that.name,_that.slug,_that.icon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String slug,  String? icon)?  $default,) {final _that = this;
switch (_that) {
case _DutyTypeMeta() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.icon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyTypeMeta implements DutyTypeMeta {
  const _DutyTypeMeta({required this.id, required this.name, required this.slug, this.icon});
  factory _DutyTypeMeta.fromJson(Map<String, dynamic> json) => _$DutyTypeMetaFromJson(json);

@override final  int id;
@override final  String name;
@override final  String slug;
@override final  String? icon;

/// Create a copy of DutyTypeMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyTypeMetaCopyWith<_DutyTypeMeta> get copyWith => __$DutyTypeMetaCopyWithImpl<_DutyTypeMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyTypeMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyTypeMeta&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.icon, icon) || other.icon == icon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,icon);

@override
String toString() {
  return 'DutyTypeMeta(id: $id, name: $name, slug: $slug, icon: $icon)';
}


}

/// @nodoc
abstract mixin class _$DutyTypeMetaCopyWith<$Res> implements $DutyTypeMetaCopyWith<$Res> {
  factory _$DutyTypeMetaCopyWith(_DutyTypeMeta value, $Res Function(_DutyTypeMeta) _then) = __$DutyTypeMetaCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String slug, String? icon
});




}
/// @nodoc
class __$DutyTypeMetaCopyWithImpl<$Res>
    implements _$DutyTypeMetaCopyWith<$Res> {
  __$DutyTypeMetaCopyWithImpl(this._self, this._then);

  final _DutyTypeMeta _self;
  final $Res Function(_DutyTypeMeta) _then;

/// Create a copy of DutyTypeMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? icon = freezed,}) {
  return _then(_DutyTypeMeta(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AgendaMe {

 bool get isGuest; bool get isStaff; bool get isInjured; bool get isOnVacation;
/// Create a copy of AgendaMe
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaMeCopyWith<AgendaMe> get copyWith => _$AgendaMeCopyWithImpl<AgendaMe>(this as AgendaMe, _$identity);

  /// Serializes this AgendaMe to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaMe&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.isStaff, isStaff) || other.isStaff == isStaff)&&(identical(other.isInjured, isInjured) || other.isInjured == isInjured)&&(identical(other.isOnVacation, isOnVacation) || other.isOnVacation == isOnVacation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isGuest,isStaff,isInjured,isOnVacation);

@override
String toString() {
  return 'AgendaMe(isGuest: $isGuest, isStaff: $isStaff, isInjured: $isInjured, isOnVacation: $isOnVacation)';
}


}

/// @nodoc
abstract mixin class $AgendaMeCopyWith<$Res>  {
  factory $AgendaMeCopyWith(AgendaMe value, $Res Function(AgendaMe) _then) = _$AgendaMeCopyWithImpl;
@useResult
$Res call({
 bool isGuest, bool isStaff, bool isInjured, bool isOnVacation
});




}
/// @nodoc
class _$AgendaMeCopyWithImpl<$Res>
    implements $AgendaMeCopyWith<$Res> {
  _$AgendaMeCopyWithImpl(this._self, this._then);

  final AgendaMe _self;
  final $Res Function(AgendaMe) _then;

/// Create a copy of AgendaMe
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isGuest = null,Object? isStaff = null,Object? isInjured = null,Object? isOnVacation = null,}) {
  return _then(_self.copyWith(
isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,isStaff: null == isStaff ? _self.isStaff : isStaff // ignore: cast_nullable_to_non_nullable
as bool,isInjured: null == isInjured ? _self.isInjured : isInjured // ignore: cast_nullable_to_non_nullable
as bool,isOnVacation: null == isOnVacation ? _self.isOnVacation : isOnVacation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AgendaMe].
extension AgendaMePatterns on AgendaMe {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgendaMe value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgendaMe() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgendaMe value)  $default,){
final _that = this;
switch (_that) {
case _AgendaMe():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgendaMe value)?  $default,){
final _that = this;
switch (_that) {
case _AgendaMe() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isGuest,  bool isStaff,  bool isInjured,  bool isOnVacation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgendaMe() when $default != null:
return $default(_that.isGuest,_that.isStaff,_that.isInjured,_that.isOnVacation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isGuest,  bool isStaff,  bool isInjured,  bool isOnVacation)  $default,) {final _that = this;
switch (_that) {
case _AgendaMe():
return $default(_that.isGuest,_that.isStaff,_that.isInjured,_that.isOnVacation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isGuest,  bool isStaff,  bool isInjured,  bool isOnVacation)?  $default,) {final _that = this;
switch (_that) {
case _AgendaMe() when $default != null:
return $default(_that.isGuest,_that.isStaff,_that.isInjured,_that.isOnVacation);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AgendaMe implements AgendaMe {
  const _AgendaMe({this.isGuest = false, this.isStaff = false, this.isInjured = false, this.isOnVacation = false});
  factory _AgendaMe.fromJson(Map<String, dynamic> json) => _$AgendaMeFromJson(json);

@override@JsonKey() final  bool isGuest;
@override@JsonKey() final  bool isStaff;
@override@JsonKey() final  bool isInjured;
@override@JsonKey() final  bool isOnVacation;

/// Create a copy of AgendaMe
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgendaMeCopyWith<_AgendaMe> get copyWith => __$AgendaMeCopyWithImpl<_AgendaMe>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgendaMeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgendaMe&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.isStaff, isStaff) || other.isStaff == isStaff)&&(identical(other.isInjured, isInjured) || other.isInjured == isInjured)&&(identical(other.isOnVacation, isOnVacation) || other.isOnVacation == isOnVacation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isGuest,isStaff,isInjured,isOnVacation);

@override
String toString() {
  return 'AgendaMe(isGuest: $isGuest, isStaff: $isStaff, isInjured: $isInjured, isOnVacation: $isOnVacation)';
}


}

/// @nodoc
abstract mixin class _$AgendaMeCopyWith<$Res> implements $AgendaMeCopyWith<$Res> {
  factory _$AgendaMeCopyWith(_AgendaMe value, $Res Function(_AgendaMe) _then) = __$AgendaMeCopyWithImpl;
@override @useResult
$Res call({
 bool isGuest, bool isStaff, bool isInjured, bool isOnVacation
});




}
/// @nodoc
class __$AgendaMeCopyWithImpl<$Res>
    implements _$AgendaMeCopyWith<$Res> {
  __$AgendaMeCopyWithImpl(this._self, this._then);

  final _AgendaMe _self;
  final $Res Function(_AgendaMe) _then;

/// Create a copy of AgendaMe
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isGuest = null,Object? isStaff = null,Object? isInjured = null,Object? isOnVacation = null,}) {
  return _then(_AgendaMe(
isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,isStaff: null == isStaff ? _self.isStaff : isStaff // ignore: cast_nullable_to_non_nullable
as bool,isInjured: null == isInjured ? _self.isInjured : isInjured // ignore: cast_nullable_to_non_nullable
as bool,isOnVacation: null == isOnVacation ? _self.isOnVacation : isOnVacation // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AgendaData {

 bool get canRsvp; AgendaMe? get me; List<AgendaEvent> get upcoming; List<AgendaEvent> get past; List<AgendaDuty> get upcomingDuties; List<AgendaDuty> get pastDuties; List<AgendaDuty> get myTasks; List<AgendaBirthday> get birthdays; List<DutyTypeMeta> get dutyTypes; bool get hasMatches; bool get hasTrainings; String? get agendaFeedUrl; bool get needsSchedule; bool get canFetchSchedule;/// `available`, `pending` of `null` (trainerdingen).
 String? get scheduleRequest; Map<String, dynamic>? get scheduleFeed;
/// Create a copy of AgendaData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaDataCopyWith<AgendaData> get copyWith => _$AgendaDataCopyWithImpl<AgendaData>(this as AgendaData, _$identity);

  /// Serializes this AgendaData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaData&&(identical(other.canRsvp, canRsvp) || other.canRsvp == canRsvp)&&(identical(other.me, me) || other.me == me)&&const DeepCollectionEquality().equals(other.upcoming, upcoming)&&const DeepCollectionEquality().equals(other.past, past)&&const DeepCollectionEquality().equals(other.upcomingDuties, upcomingDuties)&&const DeepCollectionEquality().equals(other.pastDuties, pastDuties)&&const DeepCollectionEquality().equals(other.myTasks, myTasks)&&const DeepCollectionEquality().equals(other.birthdays, birthdays)&&const DeepCollectionEquality().equals(other.dutyTypes, dutyTypes)&&(identical(other.hasMatches, hasMatches) || other.hasMatches == hasMatches)&&(identical(other.hasTrainings, hasTrainings) || other.hasTrainings == hasTrainings)&&(identical(other.agendaFeedUrl, agendaFeedUrl) || other.agendaFeedUrl == agendaFeedUrl)&&(identical(other.needsSchedule, needsSchedule) || other.needsSchedule == needsSchedule)&&(identical(other.canFetchSchedule, canFetchSchedule) || other.canFetchSchedule == canFetchSchedule)&&(identical(other.scheduleRequest, scheduleRequest) || other.scheduleRequest == scheduleRequest)&&const DeepCollectionEquality().equals(other.scheduleFeed, scheduleFeed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,canRsvp,me,const DeepCollectionEquality().hash(upcoming),const DeepCollectionEquality().hash(past),const DeepCollectionEquality().hash(upcomingDuties),const DeepCollectionEquality().hash(pastDuties),const DeepCollectionEquality().hash(myTasks),const DeepCollectionEquality().hash(birthdays),const DeepCollectionEquality().hash(dutyTypes),hasMatches,hasTrainings,agendaFeedUrl,needsSchedule,canFetchSchedule,scheduleRequest,const DeepCollectionEquality().hash(scheduleFeed));

@override
String toString() {
  return 'AgendaData(canRsvp: $canRsvp, me: $me, upcoming: $upcoming, past: $past, upcomingDuties: $upcomingDuties, pastDuties: $pastDuties, myTasks: $myTasks, birthdays: $birthdays, dutyTypes: $dutyTypes, hasMatches: $hasMatches, hasTrainings: $hasTrainings, agendaFeedUrl: $agendaFeedUrl, needsSchedule: $needsSchedule, canFetchSchedule: $canFetchSchedule, scheduleRequest: $scheduleRequest, scheduleFeed: $scheduleFeed)';
}


}

/// @nodoc
abstract mixin class $AgendaDataCopyWith<$Res>  {
  factory $AgendaDataCopyWith(AgendaData value, $Res Function(AgendaData) _then) = _$AgendaDataCopyWithImpl;
@useResult
$Res call({
 bool canRsvp, AgendaMe? me, List<AgendaEvent> upcoming, List<AgendaEvent> past, List<AgendaDuty> upcomingDuties, List<AgendaDuty> pastDuties, List<AgendaDuty> myTasks, List<AgendaBirthday> birthdays, List<DutyTypeMeta> dutyTypes, bool hasMatches, bool hasTrainings, String? agendaFeedUrl, bool needsSchedule, bool canFetchSchedule, String? scheduleRequest, Map<String, dynamic>? scheduleFeed
});


$AgendaMeCopyWith<$Res>? get me;

}
/// @nodoc
class _$AgendaDataCopyWithImpl<$Res>
    implements $AgendaDataCopyWith<$Res> {
  _$AgendaDataCopyWithImpl(this._self, this._then);

  final AgendaData _self;
  final $Res Function(AgendaData) _then;

/// Create a copy of AgendaData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? canRsvp = null,Object? me = freezed,Object? upcoming = null,Object? past = null,Object? upcomingDuties = null,Object? pastDuties = null,Object? myTasks = null,Object? birthdays = null,Object? dutyTypes = null,Object? hasMatches = null,Object? hasTrainings = null,Object? agendaFeedUrl = freezed,Object? needsSchedule = null,Object? canFetchSchedule = null,Object? scheduleRequest = freezed,Object? scheduleFeed = freezed,}) {
  return _then(_self.copyWith(
canRsvp: null == canRsvp ? _self.canRsvp : canRsvp // ignore: cast_nullable_to_non_nullable
as bool,me: freezed == me ? _self.me : me // ignore: cast_nullable_to_non_nullable
as AgendaMe?,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<AgendaEvent>,past: null == past ? _self.past : past // ignore: cast_nullable_to_non_nullable
as List<AgendaEvent>,upcomingDuties: null == upcomingDuties ? _self.upcomingDuties : upcomingDuties // ignore: cast_nullable_to_non_nullable
as List<AgendaDuty>,pastDuties: null == pastDuties ? _self.pastDuties : pastDuties // ignore: cast_nullable_to_non_nullable
as List<AgendaDuty>,myTasks: null == myTasks ? _self.myTasks : myTasks // ignore: cast_nullable_to_non_nullable
as List<AgendaDuty>,birthdays: null == birthdays ? _self.birthdays : birthdays // ignore: cast_nullable_to_non_nullable
as List<AgendaBirthday>,dutyTypes: null == dutyTypes ? _self.dutyTypes : dutyTypes // ignore: cast_nullable_to_non_nullable
as List<DutyTypeMeta>,hasMatches: null == hasMatches ? _self.hasMatches : hasMatches // ignore: cast_nullable_to_non_nullable
as bool,hasTrainings: null == hasTrainings ? _self.hasTrainings : hasTrainings // ignore: cast_nullable_to_non_nullable
as bool,agendaFeedUrl: freezed == agendaFeedUrl ? _self.agendaFeedUrl : agendaFeedUrl // ignore: cast_nullable_to_non_nullable
as String?,needsSchedule: null == needsSchedule ? _self.needsSchedule : needsSchedule // ignore: cast_nullable_to_non_nullable
as bool,canFetchSchedule: null == canFetchSchedule ? _self.canFetchSchedule : canFetchSchedule // ignore: cast_nullable_to_non_nullable
as bool,scheduleRequest: freezed == scheduleRequest ? _self.scheduleRequest : scheduleRequest // ignore: cast_nullable_to_non_nullable
as String?,scheduleFeed: freezed == scheduleFeed ? _self.scheduleFeed : scheduleFeed // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}
/// Create a copy of AgendaData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AgendaMeCopyWith<$Res>? get me {
    if (_self.me == null) {
    return null;
  }

  return $AgendaMeCopyWith<$Res>(_self.me!, (value) {
    return _then(_self.copyWith(me: value));
  });
}
}


/// Adds pattern-matching-related methods to [AgendaData].
extension AgendaDataPatterns on AgendaData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgendaData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgendaData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgendaData value)  $default,){
final _that = this;
switch (_that) {
case _AgendaData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgendaData value)?  $default,){
final _that = this;
switch (_that) {
case _AgendaData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool canRsvp,  AgendaMe? me,  List<AgendaEvent> upcoming,  List<AgendaEvent> past,  List<AgendaDuty> upcomingDuties,  List<AgendaDuty> pastDuties,  List<AgendaDuty> myTasks,  List<AgendaBirthday> birthdays,  List<DutyTypeMeta> dutyTypes,  bool hasMatches,  bool hasTrainings,  String? agendaFeedUrl,  bool needsSchedule,  bool canFetchSchedule,  String? scheduleRequest,  Map<String, dynamic>? scheduleFeed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgendaData() when $default != null:
return $default(_that.canRsvp,_that.me,_that.upcoming,_that.past,_that.upcomingDuties,_that.pastDuties,_that.myTasks,_that.birthdays,_that.dutyTypes,_that.hasMatches,_that.hasTrainings,_that.agendaFeedUrl,_that.needsSchedule,_that.canFetchSchedule,_that.scheduleRequest,_that.scheduleFeed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool canRsvp,  AgendaMe? me,  List<AgendaEvent> upcoming,  List<AgendaEvent> past,  List<AgendaDuty> upcomingDuties,  List<AgendaDuty> pastDuties,  List<AgendaDuty> myTasks,  List<AgendaBirthday> birthdays,  List<DutyTypeMeta> dutyTypes,  bool hasMatches,  bool hasTrainings,  String? agendaFeedUrl,  bool needsSchedule,  bool canFetchSchedule,  String? scheduleRequest,  Map<String, dynamic>? scheduleFeed)  $default,) {final _that = this;
switch (_that) {
case _AgendaData():
return $default(_that.canRsvp,_that.me,_that.upcoming,_that.past,_that.upcomingDuties,_that.pastDuties,_that.myTasks,_that.birthdays,_that.dutyTypes,_that.hasMatches,_that.hasTrainings,_that.agendaFeedUrl,_that.needsSchedule,_that.canFetchSchedule,_that.scheduleRequest,_that.scheduleFeed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool canRsvp,  AgendaMe? me,  List<AgendaEvent> upcoming,  List<AgendaEvent> past,  List<AgendaDuty> upcomingDuties,  List<AgendaDuty> pastDuties,  List<AgendaDuty> myTasks,  List<AgendaBirthday> birthdays,  List<DutyTypeMeta> dutyTypes,  bool hasMatches,  bool hasTrainings,  String? agendaFeedUrl,  bool needsSchedule,  bool canFetchSchedule,  String? scheduleRequest,  Map<String, dynamic>? scheduleFeed)?  $default,) {final _that = this;
switch (_that) {
case _AgendaData() when $default != null:
return $default(_that.canRsvp,_that.me,_that.upcoming,_that.past,_that.upcomingDuties,_that.pastDuties,_that.myTasks,_that.birthdays,_that.dutyTypes,_that.hasMatches,_that.hasTrainings,_that.agendaFeedUrl,_that.needsSchedule,_that.canFetchSchedule,_that.scheduleRequest,_that.scheduleFeed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AgendaData implements AgendaData {
  const _AgendaData({this.canRsvp = false, this.me, final  List<AgendaEvent> upcoming = const <AgendaEvent>[], final  List<AgendaEvent> past = const <AgendaEvent>[], final  List<AgendaDuty> upcomingDuties = const <AgendaDuty>[], final  List<AgendaDuty> pastDuties = const <AgendaDuty>[], final  List<AgendaDuty> myTasks = const <AgendaDuty>[], final  List<AgendaBirthday> birthdays = const <AgendaBirthday>[], final  List<DutyTypeMeta> dutyTypes = const <DutyTypeMeta>[], this.hasMatches = false, this.hasTrainings = false, this.agendaFeedUrl, this.needsSchedule = false, this.canFetchSchedule = false, this.scheduleRequest, final  Map<String, dynamic>? scheduleFeed}): _upcoming = upcoming,_past = past,_upcomingDuties = upcomingDuties,_pastDuties = pastDuties,_myTasks = myTasks,_birthdays = birthdays,_dutyTypes = dutyTypes,_scheduleFeed = scheduleFeed;
  factory _AgendaData.fromJson(Map<String, dynamic> json) => _$AgendaDataFromJson(json);

@override@JsonKey() final  bool canRsvp;
@override final  AgendaMe? me;
 final  List<AgendaEvent> _upcoming;
@override@JsonKey() List<AgendaEvent> get upcoming {
  if (_upcoming is EqualUnmodifiableListView) return _upcoming;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcoming);
}

 final  List<AgendaEvent> _past;
@override@JsonKey() List<AgendaEvent> get past {
  if (_past is EqualUnmodifiableListView) return _past;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_past);
}

 final  List<AgendaDuty> _upcomingDuties;
@override@JsonKey() List<AgendaDuty> get upcomingDuties {
  if (_upcomingDuties is EqualUnmodifiableListView) return _upcomingDuties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcomingDuties);
}

 final  List<AgendaDuty> _pastDuties;
@override@JsonKey() List<AgendaDuty> get pastDuties {
  if (_pastDuties is EqualUnmodifiableListView) return _pastDuties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pastDuties);
}

 final  List<AgendaDuty> _myTasks;
@override@JsonKey() List<AgendaDuty> get myTasks {
  if (_myTasks is EqualUnmodifiableListView) return _myTasks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_myTasks);
}

 final  List<AgendaBirthday> _birthdays;
@override@JsonKey() List<AgendaBirthday> get birthdays {
  if (_birthdays is EqualUnmodifiableListView) return _birthdays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_birthdays);
}

 final  List<DutyTypeMeta> _dutyTypes;
@override@JsonKey() List<DutyTypeMeta> get dutyTypes {
  if (_dutyTypes is EqualUnmodifiableListView) return _dutyTypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dutyTypes);
}

@override@JsonKey() final  bool hasMatches;
@override@JsonKey() final  bool hasTrainings;
@override final  String? agendaFeedUrl;
@override@JsonKey() final  bool needsSchedule;
@override@JsonKey() final  bool canFetchSchedule;
/// `available`, `pending` of `null` (trainerdingen).
@override final  String? scheduleRequest;
 final  Map<String, dynamic>? _scheduleFeed;
@override Map<String, dynamic>? get scheduleFeed {
  final value = _scheduleFeed;
  if (value == null) return null;
  if (_scheduleFeed is EqualUnmodifiableMapView) return _scheduleFeed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of AgendaData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgendaDataCopyWith<_AgendaData> get copyWith => __$AgendaDataCopyWithImpl<_AgendaData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgendaDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgendaData&&(identical(other.canRsvp, canRsvp) || other.canRsvp == canRsvp)&&(identical(other.me, me) || other.me == me)&&const DeepCollectionEquality().equals(other._upcoming, _upcoming)&&const DeepCollectionEquality().equals(other._past, _past)&&const DeepCollectionEquality().equals(other._upcomingDuties, _upcomingDuties)&&const DeepCollectionEquality().equals(other._pastDuties, _pastDuties)&&const DeepCollectionEquality().equals(other._myTasks, _myTasks)&&const DeepCollectionEquality().equals(other._birthdays, _birthdays)&&const DeepCollectionEquality().equals(other._dutyTypes, _dutyTypes)&&(identical(other.hasMatches, hasMatches) || other.hasMatches == hasMatches)&&(identical(other.hasTrainings, hasTrainings) || other.hasTrainings == hasTrainings)&&(identical(other.agendaFeedUrl, agendaFeedUrl) || other.agendaFeedUrl == agendaFeedUrl)&&(identical(other.needsSchedule, needsSchedule) || other.needsSchedule == needsSchedule)&&(identical(other.canFetchSchedule, canFetchSchedule) || other.canFetchSchedule == canFetchSchedule)&&(identical(other.scheduleRequest, scheduleRequest) || other.scheduleRequest == scheduleRequest)&&const DeepCollectionEquality().equals(other._scheduleFeed, _scheduleFeed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,canRsvp,me,const DeepCollectionEquality().hash(_upcoming),const DeepCollectionEquality().hash(_past),const DeepCollectionEquality().hash(_upcomingDuties),const DeepCollectionEquality().hash(_pastDuties),const DeepCollectionEquality().hash(_myTasks),const DeepCollectionEquality().hash(_birthdays),const DeepCollectionEquality().hash(_dutyTypes),hasMatches,hasTrainings,agendaFeedUrl,needsSchedule,canFetchSchedule,scheduleRequest,const DeepCollectionEquality().hash(_scheduleFeed));

@override
String toString() {
  return 'AgendaData(canRsvp: $canRsvp, me: $me, upcoming: $upcoming, past: $past, upcomingDuties: $upcomingDuties, pastDuties: $pastDuties, myTasks: $myTasks, birthdays: $birthdays, dutyTypes: $dutyTypes, hasMatches: $hasMatches, hasTrainings: $hasTrainings, agendaFeedUrl: $agendaFeedUrl, needsSchedule: $needsSchedule, canFetchSchedule: $canFetchSchedule, scheduleRequest: $scheduleRequest, scheduleFeed: $scheduleFeed)';
}


}

/// @nodoc
abstract mixin class _$AgendaDataCopyWith<$Res> implements $AgendaDataCopyWith<$Res> {
  factory _$AgendaDataCopyWith(_AgendaData value, $Res Function(_AgendaData) _then) = __$AgendaDataCopyWithImpl;
@override @useResult
$Res call({
 bool canRsvp, AgendaMe? me, List<AgendaEvent> upcoming, List<AgendaEvent> past, List<AgendaDuty> upcomingDuties, List<AgendaDuty> pastDuties, List<AgendaDuty> myTasks, List<AgendaBirthday> birthdays, List<DutyTypeMeta> dutyTypes, bool hasMatches, bool hasTrainings, String? agendaFeedUrl, bool needsSchedule, bool canFetchSchedule, String? scheduleRequest, Map<String, dynamic>? scheduleFeed
});


@override $AgendaMeCopyWith<$Res>? get me;

}
/// @nodoc
class __$AgendaDataCopyWithImpl<$Res>
    implements _$AgendaDataCopyWith<$Res> {
  __$AgendaDataCopyWithImpl(this._self, this._then);

  final _AgendaData _self;
  final $Res Function(_AgendaData) _then;

/// Create a copy of AgendaData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? canRsvp = null,Object? me = freezed,Object? upcoming = null,Object? past = null,Object? upcomingDuties = null,Object? pastDuties = null,Object? myTasks = null,Object? birthdays = null,Object? dutyTypes = null,Object? hasMatches = null,Object? hasTrainings = null,Object? agendaFeedUrl = freezed,Object? needsSchedule = null,Object? canFetchSchedule = null,Object? scheduleRequest = freezed,Object? scheduleFeed = freezed,}) {
  return _then(_AgendaData(
canRsvp: null == canRsvp ? _self.canRsvp : canRsvp // ignore: cast_nullable_to_non_nullable
as bool,me: freezed == me ? _self.me : me // ignore: cast_nullable_to_non_nullable
as AgendaMe?,upcoming: null == upcoming ? _self._upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<AgendaEvent>,past: null == past ? _self._past : past // ignore: cast_nullable_to_non_nullable
as List<AgendaEvent>,upcomingDuties: null == upcomingDuties ? _self._upcomingDuties : upcomingDuties // ignore: cast_nullable_to_non_nullable
as List<AgendaDuty>,pastDuties: null == pastDuties ? _self._pastDuties : pastDuties // ignore: cast_nullable_to_non_nullable
as List<AgendaDuty>,myTasks: null == myTasks ? _self._myTasks : myTasks // ignore: cast_nullable_to_non_nullable
as List<AgendaDuty>,birthdays: null == birthdays ? _self._birthdays : birthdays // ignore: cast_nullable_to_non_nullable
as List<AgendaBirthday>,dutyTypes: null == dutyTypes ? _self._dutyTypes : dutyTypes // ignore: cast_nullable_to_non_nullable
as List<DutyTypeMeta>,hasMatches: null == hasMatches ? _self.hasMatches : hasMatches // ignore: cast_nullable_to_non_nullable
as bool,hasTrainings: null == hasTrainings ? _self.hasTrainings : hasTrainings // ignore: cast_nullable_to_non_nullable
as bool,agendaFeedUrl: freezed == agendaFeedUrl ? _self.agendaFeedUrl : agendaFeedUrl // ignore: cast_nullable_to_non_nullable
as String?,needsSchedule: null == needsSchedule ? _self.needsSchedule : needsSchedule // ignore: cast_nullable_to_non_nullable
as bool,canFetchSchedule: null == canFetchSchedule ? _self.canFetchSchedule : canFetchSchedule // ignore: cast_nullable_to_non_nullable
as bool,scheduleRequest: freezed == scheduleRequest ? _self.scheduleRequest : scheduleRequest // ignore: cast_nullable_to_non_nullable
as String?,scheduleFeed: freezed == scheduleFeed ? _self._scheduleFeed : scheduleFeed // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

/// Create a copy of AgendaData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AgendaMeCopyWith<$Res>? get me {
    if (_self.me == null) {
    return null;
  }

  return $AgendaMeCopyWith<$Res>(_self.me!, (value) {
    return _then(_self.copyWith(me: value));
  });
}
}


/// @nodoc
mixin _$AgendaMeta {

 int get limit; int get pageSize; int get upcomingTotal; int get pastTotal;
/// Create a copy of AgendaMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AgendaMetaCopyWith<AgendaMeta> get copyWith => _$AgendaMetaCopyWithImpl<AgendaMeta>(this as AgendaMeta, _$identity);

  /// Serializes this AgendaMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AgendaMeta&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.upcomingTotal, upcomingTotal) || other.upcomingTotal == upcomingTotal)&&(identical(other.pastTotal, pastTotal) || other.pastTotal == pastTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,limit,pageSize,upcomingTotal,pastTotal);

@override
String toString() {
  return 'AgendaMeta(limit: $limit, pageSize: $pageSize, upcomingTotal: $upcomingTotal, pastTotal: $pastTotal)';
}


}

/// @nodoc
abstract mixin class $AgendaMetaCopyWith<$Res>  {
  factory $AgendaMetaCopyWith(AgendaMeta value, $Res Function(AgendaMeta) _then) = _$AgendaMetaCopyWithImpl;
@useResult
$Res call({
 int limit, int pageSize, int upcomingTotal, int pastTotal
});




}
/// @nodoc
class _$AgendaMetaCopyWithImpl<$Res>
    implements $AgendaMetaCopyWith<$Res> {
  _$AgendaMetaCopyWithImpl(this._self, this._then);

  final AgendaMeta _self;
  final $Res Function(AgendaMeta) _then;

/// Create a copy of AgendaMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? limit = null,Object? pageSize = null,Object? upcomingTotal = null,Object? pastTotal = null,}) {
  return _then(_self.copyWith(
limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,upcomingTotal: null == upcomingTotal ? _self.upcomingTotal : upcomingTotal // ignore: cast_nullable_to_non_nullable
as int,pastTotal: null == pastTotal ? _self.pastTotal : pastTotal // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AgendaMeta].
extension AgendaMetaPatterns on AgendaMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AgendaMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AgendaMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AgendaMeta value)  $default,){
final _that = this;
switch (_that) {
case _AgendaMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AgendaMeta value)?  $default,){
final _that = this;
switch (_that) {
case _AgendaMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int limit,  int pageSize,  int upcomingTotal,  int pastTotal)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AgendaMeta() when $default != null:
return $default(_that.limit,_that.pageSize,_that.upcomingTotal,_that.pastTotal);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int limit,  int pageSize,  int upcomingTotal,  int pastTotal)  $default,) {final _that = this;
switch (_that) {
case _AgendaMeta():
return $default(_that.limit,_that.pageSize,_that.upcomingTotal,_that.pastTotal);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int limit,  int pageSize,  int upcomingTotal,  int pastTotal)?  $default,) {final _that = this;
switch (_that) {
case _AgendaMeta() when $default != null:
return $default(_that.limit,_that.pageSize,_that.upcomingTotal,_that.pastTotal);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AgendaMeta implements AgendaMeta {
  const _AgendaMeta({this.limit = 30, this.pageSize = 30, this.upcomingTotal = 0, this.pastTotal = 0});
  factory _AgendaMeta.fromJson(Map<String, dynamic> json) => _$AgendaMetaFromJson(json);

@override@JsonKey() final  int limit;
@override@JsonKey() final  int pageSize;
@override@JsonKey() final  int upcomingTotal;
@override@JsonKey() final  int pastTotal;

/// Create a copy of AgendaMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AgendaMetaCopyWith<_AgendaMeta> get copyWith => __$AgendaMetaCopyWithImpl<_AgendaMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AgendaMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AgendaMeta&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.upcomingTotal, upcomingTotal) || other.upcomingTotal == upcomingTotal)&&(identical(other.pastTotal, pastTotal) || other.pastTotal == pastTotal));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,limit,pageSize,upcomingTotal,pastTotal);

@override
String toString() {
  return 'AgendaMeta(limit: $limit, pageSize: $pageSize, upcomingTotal: $upcomingTotal, pastTotal: $pastTotal)';
}


}

/// @nodoc
abstract mixin class _$AgendaMetaCopyWith<$Res> implements $AgendaMetaCopyWith<$Res> {
  factory _$AgendaMetaCopyWith(_AgendaMeta value, $Res Function(_AgendaMeta) _then) = __$AgendaMetaCopyWithImpl;
@override @useResult
$Res call({
 int limit, int pageSize, int upcomingTotal, int pastTotal
});




}
/// @nodoc
class __$AgendaMetaCopyWithImpl<$Res>
    implements _$AgendaMetaCopyWith<$Res> {
  __$AgendaMetaCopyWithImpl(this._self, this._then);

  final _AgendaMeta _self;
  final $Res Function(_AgendaMeta) _then;

/// Create a copy of AgendaMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? limit = null,Object? pageSize = null,Object? upcomingTotal = null,Object? pastTotal = null,}) {
  return _then(_AgendaMeta(
limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,upcomingTotal: null == upcomingTotal ? _self.upcomingTotal : upcomingTotal // ignore: cast_nullable_to_non_nullable
as int,pastTotal: null == pastTotal ? _self.pastTotal : pastTotal // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AttendanceResult {

 int get eventId; int? get playerId; int? get userId;@JsonKey(unknownEnumValue: AttendanceStatus.pending) AttendanceStatus get status; String? get reason; DateTime? get respondedAt; int? get changedByUserId;
/// Create a copy of AttendanceResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceResultCopyWith<AttendanceResult> get copyWith => _$AttendanceResultCopyWithImpl<AttendanceResult>(this as AttendanceResult, _$identity);

  /// Serializes this AttendanceResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceResult&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.status, status) || other.status == status)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.changedByUserId, changedByUserId) || other.changedByUserId == changedByUserId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,playerId,userId,status,reason,respondedAt,changedByUserId);

@override
String toString() {
  return 'AttendanceResult(eventId: $eventId, playerId: $playerId, userId: $userId, status: $status, reason: $reason, respondedAt: $respondedAt, changedByUserId: $changedByUserId)';
}


}

/// @nodoc
abstract mixin class $AttendanceResultCopyWith<$Res>  {
  factory $AttendanceResultCopyWith(AttendanceResult value, $Res Function(AttendanceResult) _then) = _$AttendanceResultCopyWithImpl;
@useResult
$Res call({
 int eventId, int? playerId, int? userId,@JsonKey(unknownEnumValue: AttendanceStatus.pending) AttendanceStatus status, String? reason, DateTime? respondedAt, int? changedByUserId
});




}
/// @nodoc
class _$AttendanceResultCopyWithImpl<$Res>
    implements $AttendanceResultCopyWith<$Res> {
  _$AttendanceResultCopyWithImpl(this._self, this._then);

  final AttendanceResult _self;
  final $Res Function(AttendanceResult) _then;

/// Create a copy of AttendanceResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? eventId = null,Object? playerId = freezed,Object? userId = freezed,Object? status = null,Object? reason = freezed,Object? respondedAt = freezed,Object? changedByUserId = freezed,}) {
  return _then(_self.copyWith(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttendanceStatus,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,changedByUserId: freezed == changedByUserId ? _self.changedByUserId : changedByUserId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceResult].
extension AttendanceResultPatterns on AttendanceResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceResult value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceResult value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int eventId,  int? playerId,  int? userId, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  AttendanceStatus status,  String? reason,  DateTime? respondedAt,  int? changedByUserId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceResult() when $default != null:
return $default(_that.eventId,_that.playerId,_that.userId,_that.status,_that.reason,_that.respondedAt,_that.changedByUserId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int eventId,  int? playerId,  int? userId, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  AttendanceStatus status,  String? reason,  DateTime? respondedAt,  int? changedByUserId)  $default,) {final _that = this;
switch (_that) {
case _AttendanceResult():
return $default(_that.eventId,_that.playerId,_that.userId,_that.status,_that.reason,_that.respondedAt,_that.changedByUserId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int eventId,  int? playerId,  int? userId, @JsonKey(unknownEnumValue: AttendanceStatus.pending)  AttendanceStatus status,  String? reason,  DateTime? respondedAt,  int? changedByUserId)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceResult() when $default != null:
return $default(_that.eventId,_that.playerId,_that.userId,_that.status,_that.reason,_that.respondedAt,_that.changedByUserId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AttendanceResult implements AttendanceResult {
  const _AttendanceResult({required this.eventId, this.playerId, this.userId, @JsonKey(unknownEnumValue: AttendanceStatus.pending) required this.status, this.reason, this.respondedAt, this.changedByUserId});
  factory _AttendanceResult.fromJson(Map<String, dynamic> json) => _$AttendanceResultFromJson(json);

@override final  int eventId;
@override final  int? playerId;
@override final  int? userId;
@override@JsonKey(unknownEnumValue: AttendanceStatus.pending) final  AttendanceStatus status;
@override final  String? reason;
@override final  DateTime? respondedAt;
@override final  int? changedByUserId;

/// Create a copy of AttendanceResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceResultCopyWith<_AttendanceResult> get copyWith => __$AttendanceResultCopyWithImpl<_AttendanceResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttendanceResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceResult&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.status, status) || other.status == status)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.changedByUserId, changedByUserId) || other.changedByUserId == changedByUserId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,eventId,playerId,userId,status,reason,respondedAt,changedByUserId);

@override
String toString() {
  return 'AttendanceResult(eventId: $eventId, playerId: $playerId, userId: $userId, status: $status, reason: $reason, respondedAt: $respondedAt, changedByUserId: $changedByUserId)';
}


}

/// @nodoc
abstract mixin class _$AttendanceResultCopyWith<$Res> implements $AttendanceResultCopyWith<$Res> {
  factory _$AttendanceResultCopyWith(_AttendanceResult value, $Res Function(_AttendanceResult) _then) = __$AttendanceResultCopyWithImpl;
@override @useResult
$Res call({
 int eventId, int? playerId, int? userId,@JsonKey(unknownEnumValue: AttendanceStatus.pending) AttendanceStatus status, String? reason, DateTime? respondedAt, int? changedByUserId
});




}
/// @nodoc
class __$AttendanceResultCopyWithImpl<$Res>
    implements _$AttendanceResultCopyWith<$Res> {
  __$AttendanceResultCopyWithImpl(this._self, this._then);

  final _AttendanceResult _self;
  final $Res Function(_AttendanceResult) _then;

/// Create a copy of AttendanceResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? eventId = null,Object? playerId = freezed,Object? userId = freezed,Object? status = null,Object? reason = freezed,Object? respondedAt = freezed,Object? changedByUserId = freezed,}) {
  return _then(_AttendanceResult(
eventId: null == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AttendanceStatus,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,changedByUserId: freezed == changedByUserId ? _self.changedByUserId : changedByUserId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
