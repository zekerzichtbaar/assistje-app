// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poule_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PouleStanding {

 int get position; String get team;/// Absolute URL of `null`.
 String? get logo; int get played; int get won; int get drawn; int get lost; int get goalsFor; int get goalsAgainst; int get goalDiff; int get points;/// Onze eigen ploeg.
 bool get isOwn;
/// Create a copy of PouleStanding
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PouleStandingCopyWith<PouleStanding> get copyWith => _$PouleStandingCopyWithImpl<PouleStanding>(this as PouleStanding, _$identity);

  /// Serializes this PouleStanding to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PouleStanding&&(identical(other.position, position) || other.position == position)&&(identical(other.team, team) || other.team == team)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.played, played) || other.played == played)&&(identical(other.won, won) || other.won == won)&&(identical(other.drawn, drawn) || other.drawn == drawn)&&(identical(other.lost, lost) || other.lost == lost)&&(identical(other.goalsFor, goalsFor) || other.goalsFor == goalsFor)&&(identical(other.goalsAgainst, goalsAgainst) || other.goalsAgainst == goalsAgainst)&&(identical(other.goalDiff, goalDiff) || other.goalDiff == goalDiff)&&(identical(other.points, points) || other.points == points)&&(identical(other.isOwn, isOwn) || other.isOwn == isOwn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,team,logo,played,won,drawn,lost,goalsFor,goalsAgainst,goalDiff,points,isOwn);

@override
String toString() {
  return 'PouleStanding(position: $position, team: $team, logo: $logo, played: $played, won: $won, drawn: $drawn, lost: $lost, goalsFor: $goalsFor, goalsAgainst: $goalsAgainst, goalDiff: $goalDiff, points: $points, isOwn: $isOwn)';
}


}

/// @nodoc
abstract mixin class $PouleStandingCopyWith<$Res>  {
  factory $PouleStandingCopyWith(PouleStanding value, $Res Function(PouleStanding) _then) = _$PouleStandingCopyWithImpl;
@useResult
$Res call({
 int position, String team, String? logo, int played, int won, int drawn, int lost, int goalsFor, int goalsAgainst, int goalDiff, int points, bool isOwn
});




}
/// @nodoc
class _$PouleStandingCopyWithImpl<$Res>
    implements $PouleStandingCopyWith<$Res> {
  _$PouleStandingCopyWithImpl(this._self, this._then);

  final PouleStanding _self;
  final $Res Function(PouleStanding) _then;

/// Create a copy of PouleStanding
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? position = null,Object? team = null,Object? logo = freezed,Object? played = null,Object? won = null,Object? drawn = null,Object? lost = null,Object? goalsFor = null,Object? goalsAgainst = null,Object? goalDiff = null,Object? points = null,Object? isOwn = null,}) {
  return _then(_self.copyWith(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as String,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,played: null == played ? _self.played : played // ignore: cast_nullable_to_non_nullable
as int,won: null == won ? _self.won : won // ignore: cast_nullable_to_non_nullable
as int,drawn: null == drawn ? _self.drawn : drawn // ignore: cast_nullable_to_non_nullable
as int,lost: null == lost ? _self.lost : lost // ignore: cast_nullable_to_non_nullable
as int,goalsFor: null == goalsFor ? _self.goalsFor : goalsFor // ignore: cast_nullable_to_non_nullable
as int,goalsAgainst: null == goalsAgainst ? _self.goalsAgainst : goalsAgainst // ignore: cast_nullable_to_non_nullable
as int,goalDiff: null == goalDiff ? _self.goalDiff : goalDiff // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,isOwn: null == isOwn ? _self.isOwn : isOwn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PouleStanding].
extension PouleStandingPatterns on PouleStanding {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PouleStanding value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PouleStanding() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PouleStanding value)  $default,){
final _that = this;
switch (_that) {
case _PouleStanding():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PouleStanding value)?  $default,){
final _that = this;
switch (_that) {
case _PouleStanding() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int position,  String team,  String? logo,  int played,  int won,  int drawn,  int lost,  int goalsFor,  int goalsAgainst,  int goalDiff,  int points,  bool isOwn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PouleStanding() when $default != null:
return $default(_that.position,_that.team,_that.logo,_that.played,_that.won,_that.drawn,_that.lost,_that.goalsFor,_that.goalsAgainst,_that.goalDiff,_that.points,_that.isOwn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int position,  String team,  String? logo,  int played,  int won,  int drawn,  int lost,  int goalsFor,  int goalsAgainst,  int goalDiff,  int points,  bool isOwn)  $default,) {final _that = this;
switch (_that) {
case _PouleStanding():
return $default(_that.position,_that.team,_that.logo,_that.played,_that.won,_that.drawn,_that.lost,_that.goalsFor,_that.goalsAgainst,_that.goalDiff,_that.points,_that.isOwn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int position,  String team,  String? logo,  int played,  int won,  int drawn,  int lost,  int goalsFor,  int goalsAgainst,  int goalDiff,  int points,  bool isOwn)?  $default,) {final _that = this;
switch (_that) {
case _PouleStanding() when $default != null:
return $default(_that.position,_that.team,_that.logo,_that.played,_that.won,_that.drawn,_that.lost,_that.goalsFor,_that.goalsAgainst,_that.goalDiff,_that.points,_that.isOwn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PouleStanding implements PouleStanding {
  const _PouleStanding({this.position = 0, this.team = '', this.logo, this.played = 0, this.won = 0, this.drawn = 0, this.lost = 0, this.goalsFor = 0, this.goalsAgainst = 0, this.goalDiff = 0, this.points = 0, this.isOwn = false});
  factory _PouleStanding.fromJson(Map<String, dynamic> json) => _$PouleStandingFromJson(json);

@override@JsonKey() final  int position;
@override@JsonKey() final  String team;
/// Absolute URL of `null`.
@override final  String? logo;
@override@JsonKey() final  int played;
@override@JsonKey() final  int won;
@override@JsonKey() final  int drawn;
@override@JsonKey() final  int lost;
@override@JsonKey() final  int goalsFor;
@override@JsonKey() final  int goalsAgainst;
@override@JsonKey() final  int goalDiff;
@override@JsonKey() final  int points;
/// Onze eigen ploeg.
@override@JsonKey() final  bool isOwn;

/// Create a copy of PouleStanding
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PouleStandingCopyWith<_PouleStanding> get copyWith => __$PouleStandingCopyWithImpl<_PouleStanding>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PouleStandingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PouleStanding&&(identical(other.position, position) || other.position == position)&&(identical(other.team, team) || other.team == team)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.played, played) || other.played == played)&&(identical(other.won, won) || other.won == won)&&(identical(other.drawn, drawn) || other.drawn == drawn)&&(identical(other.lost, lost) || other.lost == lost)&&(identical(other.goalsFor, goalsFor) || other.goalsFor == goalsFor)&&(identical(other.goalsAgainst, goalsAgainst) || other.goalsAgainst == goalsAgainst)&&(identical(other.goalDiff, goalDiff) || other.goalDiff == goalDiff)&&(identical(other.points, points) || other.points == points)&&(identical(other.isOwn, isOwn) || other.isOwn == isOwn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,team,logo,played,won,drawn,lost,goalsFor,goalsAgainst,goalDiff,points,isOwn);

@override
String toString() {
  return 'PouleStanding(position: $position, team: $team, logo: $logo, played: $played, won: $won, drawn: $drawn, lost: $lost, goalsFor: $goalsFor, goalsAgainst: $goalsAgainst, goalDiff: $goalDiff, points: $points, isOwn: $isOwn)';
}


}

/// @nodoc
abstract mixin class _$PouleStandingCopyWith<$Res> implements $PouleStandingCopyWith<$Res> {
  factory _$PouleStandingCopyWith(_PouleStanding value, $Res Function(_PouleStanding) _then) = __$PouleStandingCopyWithImpl;
@override @useResult
$Res call({
 int position, String team, String? logo, int played, int won, int drawn, int lost, int goalsFor, int goalsAgainst, int goalDiff, int points, bool isOwn
});




}
/// @nodoc
class __$PouleStandingCopyWithImpl<$Res>
    implements _$PouleStandingCopyWith<$Res> {
  __$PouleStandingCopyWithImpl(this._self, this._then);

  final _PouleStanding _self;
  final $Res Function(_PouleStanding) _then;

/// Create a copy of PouleStanding
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? position = null,Object? team = null,Object? logo = freezed,Object? played = null,Object? won = null,Object? drawn = null,Object? lost = null,Object? goalsFor = null,Object? goalsAgainst = null,Object? goalDiff = null,Object? points = null,Object? isOwn = null,}) {
  return _then(_PouleStanding(
position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as String,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,played: null == played ? _self.played : played // ignore: cast_nullable_to_non_nullable
as int,won: null == won ? _self.won : won // ignore: cast_nullable_to_non_nullable
as int,drawn: null == drawn ? _self.drawn : drawn // ignore: cast_nullable_to_non_nullable
as int,lost: null == lost ? _self.lost : lost // ignore: cast_nullable_to_non_nullable
as int,goalsFor: null == goalsFor ? _self.goalsFor : goalsFor // ignore: cast_nullable_to_non_nullable
as int,goalsAgainst: null == goalsAgainst ? _self.goalsAgainst : goalsAgainst // ignore: cast_nullable_to_non_nullable
as int,goalDiff: null == goalDiff ? _self.goalDiff : goalDiff // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,isOwn: null == isOwn ? _self.isOwn : isOwn // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PouleMatch {

/// Kale datum `YYYY-MM-DD` of `null`.
 String? get date;/// `HH:MM` of `null`.
 String? get time; String get home; String get away;/// `"3-1"` bij een uitgespeelde wedstrijd, anders `null` (dan [status]).
 String? get score; String? get status; bool get isOwn; bool get homeIsOwn; bool get awayIsOwn; String? get homeLogo; String? get awayLogo;/// Het gekoppelde agenda-event bij onze eigen wedstrijden.
 int? get eventId;
/// Create a copy of PouleMatch
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PouleMatchCopyWith<PouleMatch> get copyWith => _$PouleMatchCopyWithImpl<PouleMatch>(this as PouleMatch, _$identity);

  /// Serializes this PouleMatch to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PouleMatch&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.home, home) || other.home == home)&&(identical(other.away, away) || other.away == away)&&(identical(other.score, score) || other.score == score)&&(identical(other.status, status) || other.status == status)&&(identical(other.isOwn, isOwn) || other.isOwn == isOwn)&&(identical(other.homeIsOwn, homeIsOwn) || other.homeIsOwn == homeIsOwn)&&(identical(other.awayIsOwn, awayIsOwn) || other.awayIsOwn == awayIsOwn)&&(identical(other.homeLogo, homeLogo) || other.homeLogo == homeLogo)&&(identical(other.awayLogo, awayLogo) || other.awayLogo == awayLogo)&&(identical(other.eventId, eventId) || other.eventId == eventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,time,home,away,score,status,isOwn,homeIsOwn,awayIsOwn,homeLogo,awayLogo,eventId);

@override
String toString() {
  return 'PouleMatch(date: $date, time: $time, home: $home, away: $away, score: $score, status: $status, isOwn: $isOwn, homeIsOwn: $homeIsOwn, awayIsOwn: $awayIsOwn, homeLogo: $homeLogo, awayLogo: $awayLogo, eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class $PouleMatchCopyWith<$Res>  {
  factory $PouleMatchCopyWith(PouleMatch value, $Res Function(PouleMatch) _then) = _$PouleMatchCopyWithImpl;
@useResult
$Res call({
 String? date, String? time, String home, String away, String? score, String? status, bool isOwn, bool homeIsOwn, bool awayIsOwn, String? homeLogo, String? awayLogo, int? eventId
});




}
/// @nodoc
class _$PouleMatchCopyWithImpl<$Res>
    implements $PouleMatchCopyWith<$Res> {
  _$PouleMatchCopyWithImpl(this._self, this._then);

  final PouleMatch _self;
  final $Res Function(PouleMatch) _then;

/// Create a copy of PouleMatch
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? time = freezed,Object? home = null,Object? away = null,Object? score = freezed,Object? status = freezed,Object? isOwn = null,Object? homeIsOwn = null,Object? awayIsOwn = null,Object? homeLogo = freezed,Object? awayLogo = freezed,Object? eventId = freezed,}) {
  return _then(_self.copyWith(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,home: null == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as String,away: null == away ? _self.away : away // ignore: cast_nullable_to_non_nullable
as String,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,isOwn: null == isOwn ? _self.isOwn : isOwn // ignore: cast_nullable_to_non_nullable
as bool,homeIsOwn: null == homeIsOwn ? _self.homeIsOwn : homeIsOwn // ignore: cast_nullable_to_non_nullable
as bool,awayIsOwn: null == awayIsOwn ? _self.awayIsOwn : awayIsOwn // ignore: cast_nullable_to_non_nullable
as bool,homeLogo: freezed == homeLogo ? _self.homeLogo : homeLogo // ignore: cast_nullable_to_non_nullable
as String?,awayLogo: freezed == awayLogo ? _self.awayLogo : awayLogo // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PouleMatch].
extension PouleMatchPatterns on PouleMatch {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PouleMatch value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PouleMatch() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PouleMatch value)  $default,){
final _that = this;
switch (_that) {
case _PouleMatch():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PouleMatch value)?  $default,){
final _that = this;
switch (_that) {
case _PouleMatch() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? date,  String? time,  String home,  String away,  String? score,  String? status,  bool isOwn,  bool homeIsOwn,  bool awayIsOwn,  String? homeLogo,  String? awayLogo,  int? eventId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PouleMatch() when $default != null:
return $default(_that.date,_that.time,_that.home,_that.away,_that.score,_that.status,_that.isOwn,_that.homeIsOwn,_that.awayIsOwn,_that.homeLogo,_that.awayLogo,_that.eventId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? date,  String? time,  String home,  String away,  String? score,  String? status,  bool isOwn,  bool homeIsOwn,  bool awayIsOwn,  String? homeLogo,  String? awayLogo,  int? eventId)  $default,) {final _that = this;
switch (_that) {
case _PouleMatch():
return $default(_that.date,_that.time,_that.home,_that.away,_that.score,_that.status,_that.isOwn,_that.homeIsOwn,_that.awayIsOwn,_that.homeLogo,_that.awayLogo,_that.eventId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? date,  String? time,  String home,  String away,  String? score,  String? status,  bool isOwn,  bool homeIsOwn,  bool awayIsOwn,  String? homeLogo,  String? awayLogo,  int? eventId)?  $default,) {final _that = this;
switch (_that) {
case _PouleMatch() when $default != null:
return $default(_that.date,_that.time,_that.home,_that.away,_that.score,_that.status,_that.isOwn,_that.homeIsOwn,_that.awayIsOwn,_that.homeLogo,_that.awayLogo,_that.eventId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PouleMatch implements PouleMatch {
  const _PouleMatch({this.date, this.time, this.home = '', this.away = '', this.score, this.status, this.isOwn = false, this.homeIsOwn = false, this.awayIsOwn = false, this.homeLogo, this.awayLogo, this.eventId});
  factory _PouleMatch.fromJson(Map<String, dynamic> json) => _$PouleMatchFromJson(json);

/// Kale datum `YYYY-MM-DD` of `null`.
@override final  String? date;
/// `HH:MM` of `null`.
@override final  String? time;
@override@JsonKey() final  String home;
@override@JsonKey() final  String away;
/// `"3-1"` bij een uitgespeelde wedstrijd, anders `null` (dan [status]).
@override final  String? score;
@override final  String? status;
@override@JsonKey() final  bool isOwn;
@override@JsonKey() final  bool homeIsOwn;
@override@JsonKey() final  bool awayIsOwn;
@override final  String? homeLogo;
@override final  String? awayLogo;
/// Het gekoppelde agenda-event bij onze eigen wedstrijden.
@override final  int? eventId;

/// Create a copy of PouleMatch
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PouleMatchCopyWith<_PouleMatch> get copyWith => __$PouleMatchCopyWithImpl<_PouleMatch>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PouleMatchToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PouleMatch&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.home, home) || other.home == home)&&(identical(other.away, away) || other.away == away)&&(identical(other.score, score) || other.score == score)&&(identical(other.status, status) || other.status == status)&&(identical(other.isOwn, isOwn) || other.isOwn == isOwn)&&(identical(other.homeIsOwn, homeIsOwn) || other.homeIsOwn == homeIsOwn)&&(identical(other.awayIsOwn, awayIsOwn) || other.awayIsOwn == awayIsOwn)&&(identical(other.homeLogo, homeLogo) || other.homeLogo == homeLogo)&&(identical(other.awayLogo, awayLogo) || other.awayLogo == awayLogo)&&(identical(other.eventId, eventId) || other.eventId == eventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,time,home,away,score,status,isOwn,homeIsOwn,awayIsOwn,homeLogo,awayLogo,eventId);

@override
String toString() {
  return 'PouleMatch(date: $date, time: $time, home: $home, away: $away, score: $score, status: $status, isOwn: $isOwn, homeIsOwn: $homeIsOwn, awayIsOwn: $awayIsOwn, homeLogo: $homeLogo, awayLogo: $awayLogo, eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class _$PouleMatchCopyWith<$Res> implements $PouleMatchCopyWith<$Res> {
  factory _$PouleMatchCopyWith(_PouleMatch value, $Res Function(_PouleMatch) _then) = __$PouleMatchCopyWithImpl;
@override @useResult
$Res call({
 String? date, String? time, String home, String away, String? score, String? status, bool isOwn, bool homeIsOwn, bool awayIsOwn, String? homeLogo, String? awayLogo, int? eventId
});




}
/// @nodoc
class __$PouleMatchCopyWithImpl<$Res>
    implements _$PouleMatchCopyWith<$Res> {
  __$PouleMatchCopyWithImpl(this._self, this._then);

  final _PouleMatch _self;
  final $Res Function(_PouleMatch) _then;

/// Create a copy of PouleMatch
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? time = freezed,Object? home = null,Object? away = null,Object? score = freezed,Object? status = freezed,Object? isOwn = null,Object? homeIsOwn = null,Object? awayIsOwn = null,Object? homeLogo = freezed,Object? awayLogo = freezed,Object? eventId = freezed,}) {
  return _then(_PouleMatch(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,time: freezed == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String?,home: null == home ? _self.home : home // ignore: cast_nullable_to_non_nullable
as String,away: null == away ? _self.away : away // ignore: cast_nullable_to_non_nullable
as String,score: freezed == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,isOwn: null == isOwn ? _self.isOwn : isOwn // ignore: cast_nullable_to_non_nullable
as bool,homeIsOwn: null == homeIsOwn ? _self.homeIsOwn : homeIsOwn // ignore: cast_nullable_to_non_nullable
as bool,awayIsOwn: null == awayIsOwn ? _self.awayIsOwn : awayIsOwn // ignore: cast_nullable_to_non_nullable
as bool,homeLogo: freezed == homeLogo ? _self.homeLogo : homeLogo // ignore: cast_nullable_to_non_nullable
as String?,awayLogo: freezed == awayLogo ? _self.awayLogo : awayLogo // ignore: cast_nullable_to_non_nullable
as String?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$PouleMatchDay {

/// Kale datum `YYYY-MM-DD`, of `null` als Sportlink er geen gaf.
 String? get date; List<PouleMatch> get matches;
/// Create a copy of PouleMatchDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PouleMatchDayCopyWith<PouleMatchDay> get copyWith => _$PouleMatchDayCopyWithImpl<PouleMatchDay>(this as PouleMatchDay, _$identity);

  /// Serializes this PouleMatchDay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PouleMatchDay&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other.matches, matches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(matches));

@override
String toString() {
  return 'PouleMatchDay(date: $date, matches: $matches)';
}


}

/// @nodoc
abstract mixin class $PouleMatchDayCopyWith<$Res>  {
  factory $PouleMatchDayCopyWith(PouleMatchDay value, $Res Function(PouleMatchDay) _then) = _$PouleMatchDayCopyWithImpl;
@useResult
$Res call({
 String? date, List<PouleMatch> matches
});




}
/// @nodoc
class _$PouleMatchDayCopyWithImpl<$Res>
    implements $PouleMatchDayCopyWith<$Res> {
  _$PouleMatchDayCopyWithImpl(this._self, this._then);

  final PouleMatchDay _self;
  final $Res Function(PouleMatchDay) _then;

/// Create a copy of PouleMatchDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = freezed,Object? matches = null,}) {
  return _then(_self.copyWith(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,matches: null == matches ? _self.matches : matches // ignore: cast_nullable_to_non_nullable
as List<PouleMatch>,
  ));
}

}


/// Adds pattern-matching-related methods to [PouleMatchDay].
extension PouleMatchDayPatterns on PouleMatchDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PouleMatchDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PouleMatchDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PouleMatchDay value)  $default,){
final _that = this;
switch (_that) {
case _PouleMatchDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PouleMatchDay value)?  $default,){
final _that = this;
switch (_that) {
case _PouleMatchDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? date,  List<PouleMatch> matches)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PouleMatchDay() when $default != null:
return $default(_that.date,_that.matches);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? date,  List<PouleMatch> matches)  $default,) {final _that = this;
switch (_that) {
case _PouleMatchDay():
return $default(_that.date,_that.matches);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? date,  List<PouleMatch> matches)?  $default,) {final _that = this;
switch (_that) {
case _PouleMatchDay() when $default != null:
return $default(_that.date,_that.matches);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PouleMatchDay implements PouleMatchDay {
  const _PouleMatchDay({this.date, final  List<PouleMatch> matches = const <PouleMatch>[]}): _matches = matches;
  factory _PouleMatchDay.fromJson(Map<String, dynamic> json) => _$PouleMatchDayFromJson(json);

/// Kale datum `YYYY-MM-DD`, of `null` als Sportlink er geen gaf.
@override final  String? date;
 final  List<PouleMatch> _matches;
@override@JsonKey() List<PouleMatch> get matches {
  if (_matches is EqualUnmodifiableListView) return _matches;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matches);
}


/// Create a copy of PouleMatchDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PouleMatchDayCopyWith<_PouleMatchDay> get copyWith => __$PouleMatchDayCopyWithImpl<_PouleMatchDay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PouleMatchDayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PouleMatchDay&&(identical(other.date, date) || other.date == date)&&const DeepCollectionEquality().equals(other._matches, _matches));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,const DeepCollectionEquality().hash(_matches));

@override
String toString() {
  return 'PouleMatchDay(date: $date, matches: $matches)';
}


}

/// @nodoc
abstract mixin class _$PouleMatchDayCopyWith<$Res> implements $PouleMatchDayCopyWith<$Res> {
  factory _$PouleMatchDayCopyWith(_PouleMatchDay value, $Res Function(_PouleMatchDay) _then) = __$PouleMatchDayCopyWithImpl;
@override @useResult
$Res call({
 String? date, List<PouleMatch> matches
});




}
/// @nodoc
class __$PouleMatchDayCopyWithImpl<$Res>
    implements _$PouleMatchDayCopyWith<$Res> {
  __$PouleMatchDayCopyWithImpl(this._self, this._then);

  final _PouleMatchDay _self;
  final $Res Function(_PouleMatchDay) _then;

/// Create a copy of PouleMatchDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = freezed,Object? matches = null,}) {
  return _then(_PouleMatchDay(
date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String?,matches: null == matches ? _self._matches : matches // ignore: cast_nullable_to_non_nullable
as List<PouleMatch>,
  ));
}


}


/// @nodoc
mixin _$PouleResultsPush {

 bool get enabled; bool get canPush;
/// Create a copy of PouleResultsPush
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PouleResultsPushCopyWith<PouleResultsPush> get copyWith => _$PouleResultsPushCopyWithImpl<PouleResultsPush>(this as PouleResultsPush, _$identity);

  /// Serializes this PouleResultsPush to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PouleResultsPush&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.canPush, canPush) || other.canPush == canPush));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,canPush);

@override
String toString() {
  return 'PouleResultsPush(enabled: $enabled, canPush: $canPush)';
}


}

/// @nodoc
abstract mixin class $PouleResultsPushCopyWith<$Res>  {
  factory $PouleResultsPushCopyWith(PouleResultsPush value, $Res Function(PouleResultsPush) _then) = _$PouleResultsPushCopyWithImpl;
@useResult
$Res call({
 bool enabled, bool canPush
});




}
/// @nodoc
class _$PouleResultsPushCopyWithImpl<$Res>
    implements $PouleResultsPushCopyWith<$Res> {
  _$PouleResultsPushCopyWithImpl(this._self, this._then);

  final PouleResultsPush _self;
  final $Res Function(PouleResultsPush) _then;

/// Create a copy of PouleResultsPush
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? canPush = null,}) {
  return _then(_self.copyWith(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,canPush: null == canPush ? _self.canPush : canPush // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PouleResultsPush].
extension PouleResultsPushPatterns on PouleResultsPush {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PouleResultsPush value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PouleResultsPush() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PouleResultsPush value)  $default,){
final _that = this;
switch (_that) {
case _PouleResultsPush():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PouleResultsPush value)?  $default,){
final _that = this;
switch (_that) {
case _PouleResultsPush() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  bool canPush)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PouleResultsPush() when $default != null:
return $default(_that.enabled,_that.canPush);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  bool canPush)  $default,) {final _that = this;
switch (_that) {
case _PouleResultsPush():
return $default(_that.enabled,_that.canPush);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  bool canPush)?  $default,) {final _that = this;
switch (_that) {
case _PouleResultsPush() when $default != null:
return $default(_that.enabled,_that.canPush);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PouleResultsPush implements PouleResultsPush {
  const _PouleResultsPush({this.enabled = false, this.canPush = false});
  factory _PouleResultsPush.fromJson(Map<String, dynamic> json) => _$PouleResultsPushFromJson(json);

@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool canPush;

/// Create a copy of PouleResultsPush
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PouleResultsPushCopyWith<_PouleResultsPush> get copyWith => __$PouleResultsPushCopyWithImpl<_PouleResultsPush>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PouleResultsPushToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PouleResultsPush&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.canPush, canPush) || other.canPush == canPush));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enabled,canPush);

@override
String toString() {
  return 'PouleResultsPush(enabled: $enabled, canPush: $canPush)';
}


}

/// @nodoc
abstract mixin class _$PouleResultsPushCopyWith<$Res> implements $PouleResultsPushCopyWith<$Res> {
  factory _$PouleResultsPushCopyWith(_PouleResultsPush value, $Res Function(_PouleResultsPush) _then) = __$PouleResultsPushCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, bool canPush
});




}
/// @nodoc
class __$PouleResultsPushCopyWithImpl<$Res>
    implements _$PouleResultsPushCopyWith<$Res> {
  __$PouleResultsPushCopyWithImpl(this._self, this._then);

  final _PouleResultsPush _self;
  final $Res Function(_PouleResultsPush) _then;

/// Create a copy of PouleResultsPush
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? canPush = null,}) {
  return _then(_PouleResultsPush(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,canPush: null == canPush ? _self.canPush : canPush // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Poule {

 String? get pouleLabel; String? get competition;/// Laatste Sportlink-sync; `null` = nog nooit (lijsten dan leeg).
 DateTime? get fetchedAt; List<PouleStanding> get standing;/// Per speeldag, nieuwste eerst.
 List<PouleMatchDay> get results;/// Per speeldag, oudste eerst.
 List<PouleMatchDay> get fixtures; PouleResultsPush? get resultsPush;
/// Create a copy of Poule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PouleCopyWith<Poule> get copyWith => _$PouleCopyWithImpl<Poule>(this as Poule, _$identity);

  /// Serializes this Poule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Poule&&(identical(other.pouleLabel, pouleLabel) || other.pouleLabel == pouleLabel)&&(identical(other.competition, competition) || other.competition == competition)&&(identical(other.fetchedAt, fetchedAt) || other.fetchedAt == fetchedAt)&&const DeepCollectionEquality().equals(other.standing, standing)&&const DeepCollectionEquality().equals(other.results, results)&&const DeepCollectionEquality().equals(other.fixtures, fixtures)&&(identical(other.resultsPush, resultsPush) || other.resultsPush == resultsPush));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pouleLabel,competition,fetchedAt,const DeepCollectionEquality().hash(standing),const DeepCollectionEquality().hash(results),const DeepCollectionEquality().hash(fixtures),resultsPush);

@override
String toString() {
  return 'Poule(pouleLabel: $pouleLabel, competition: $competition, fetchedAt: $fetchedAt, standing: $standing, results: $results, fixtures: $fixtures, resultsPush: $resultsPush)';
}


}

/// @nodoc
abstract mixin class $PouleCopyWith<$Res>  {
  factory $PouleCopyWith(Poule value, $Res Function(Poule) _then) = _$PouleCopyWithImpl;
@useResult
$Res call({
 String? pouleLabel, String? competition, DateTime? fetchedAt, List<PouleStanding> standing, List<PouleMatchDay> results, List<PouleMatchDay> fixtures, PouleResultsPush? resultsPush
});


$PouleResultsPushCopyWith<$Res>? get resultsPush;

}
/// @nodoc
class _$PouleCopyWithImpl<$Res>
    implements $PouleCopyWith<$Res> {
  _$PouleCopyWithImpl(this._self, this._then);

  final Poule _self;
  final $Res Function(Poule) _then;

/// Create a copy of Poule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pouleLabel = freezed,Object? competition = freezed,Object? fetchedAt = freezed,Object? standing = null,Object? results = null,Object? fixtures = null,Object? resultsPush = freezed,}) {
  return _then(_self.copyWith(
pouleLabel: freezed == pouleLabel ? _self.pouleLabel : pouleLabel // ignore: cast_nullable_to_non_nullable
as String?,competition: freezed == competition ? _self.competition : competition // ignore: cast_nullable_to_non_nullable
as String?,fetchedAt: freezed == fetchedAt ? _self.fetchedAt : fetchedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,standing: null == standing ? _self.standing : standing // ignore: cast_nullable_to_non_nullable
as List<PouleStanding>,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<PouleMatchDay>,fixtures: null == fixtures ? _self.fixtures : fixtures // ignore: cast_nullable_to_non_nullable
as List<PouleMatchDay>,resultsPush: freezed == resultsPush ? _self.resultsPush : resultsPush // ignore: cast_nullable_to_non_nullable
as PouleResultsPush?,
  ));
}
/// Create a copy of Poule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PouleResultsPushCopyWith<$Res>? get resultsPush {
    if (_self.resultsPush == null) {
    return null;
  }

  return $PouleResultsPushCopyWith<$Res>(_self.resultsPush!, (value) {
    return _then(_self.copyWith(resultsPush: value));
  });
}
}


/// Adds pattern-matching-related methods to [Poule].
extension PoulePatterns on Poule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Poule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Poule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Poule value)  $default,){
final _that = this;
switch (_that) {
case _Poule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Poule value)?  $default,){
final _that = this;
switch (_that) {
case _Poule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? pouleLabel,  String? competition,  DateTime? fetchedAt,  List<PouleStanding> standing,  List<PouleMatchDay> results,  List<PouleMatchDay> fixtures,  PouleResultsPush? resultsPush)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Poule() when $default != null:
return $default(_that.pouleLabel,_that.competition,_that.fetchedAt,_that.standing,_that.results,_that.fixtures,_that.resultsPush);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? pouleLabel,  String? competition,  DateTime? fetchedAt,  List<PouleStanding> standing,  List<PouleMatchDay> results,  List<PouleMatchDay> fixtures,  PouleResultsPush? resultsPush)  $default,) {final _that = this;
switch (_that) {
case _Poule():
return $default(_that.pouleLabel,_that.competition,_that.fetchedAt,_that.standing,_that.results,_that.fixtures,_that.resultsPush);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? pouleLabel,  String? competition,  DateTime? fetchedAt,  List<PouleStanding> standing,  List<PouleMatchDay> results,  List<PouleMatchDay> fixtures,  PouleResultsPush? resultsPush)?  $default,) {final _that = this;
switch (_that) {
case _Poule() when $default != null:
return $default(_that.pouleLabel,_that.competition,_that.fetchedAt,_that.standing,_that.results,_that.fixtures,_that.resultsPush);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Poule extends Poule {
  const _Poule({this.pouleLabel, this.competition, this.fetchedAt, final  List<PouleStanding> standing = const <PouleStanding>[], final  List<PouleMatchDay> results = const <PouleMatchDay>[], final  List<PouleMatchDay> fixtures = const <PouleMatchDay>[], this.resultsPush}): _standing = standing,_results = results,_fixtures = fixtures,super._();
  factory _Poule.fromJson(Map<String, dynamic> json) => _$PouleFromJson(json);

@override final  String? pouleLabel;
@override final  String? competition;
/// Laatste Sportlink-sync; `null` = nog nooit (lijsten dan leeg).
@override final  DateTime? fetchedAt;
 final  List<PouleStanding> _standing;
@override@JsonKey() List<PouleStanding> get standing {
  if (_standing is EqualUnmodifiableListView) return _standing;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_standing);
}

/// Per speeldag, nieuwste eerst.
 final  List<PouleMatchDay> _results;
/// Per speeldag, nieuwste eerst.
@override@JsonKey() List<PouleMatchDay> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

/// Per speeldag, oudste eerst.
 final  List<PouleMatchDay> _fixtures;
/// Per speeldag, oudste eerst.
@override@JsonKey() List<PouleMatchDay> get fixtures {
  if (_fixtures is EqualUnmodifiableListView) return _fixtures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fixtures);
}

@override final  PouleResultsPush? resultsPush;

/// Create a copy of Poule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PouleCopyWith<_Poule> get copyWith => __$PouleCopyWithImpl<_Poule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PouleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Poule&&(identical(other.pouleLabel, pouleLabel) || other.pouleLabel == pouleLabel)&&(identical(other.competition, competition) || other.competition == competition)&&(identical(other.fetchedAt, fetchedAt) || other.fetchedAt == fetchedAt)&&const DeepCollectionEquality().equals(other._standing, _standing)&&const DeepCollectionEquality().equals(other._results, _results)&&const DeepCollectionEquality().equals(other._fixtures, _fixtures)&&(identical(other.resultsPush, resultsPush) || other.resultsPush == resultsPush));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pouleLabel,competition,fetchedAt,const DeepCollectionEquality().hash(_standing),const DeepCollectionEquality().hash(_results),const DeepCollectionEquality().hash(_fixtures),resultsPush);

@override
String toString() {
  return 'Poule(pouleLabel: $pouleLabel, competition: $competition, fetchedAt: $fetchedAt, standing: $standing, results: $results, fixtures: $fixtures, resultsPush: $resultsPush)';
}


}

/// @nodoc
abstract mixin class _$PouleCopyWith<$Res> implements $PouleCopyWith<$Res> {
  factory _$PouleCopyWith(_Poule value, $Res Function(_Poule) _then) = __$PouleCopyWithImpl;
@override @useResult
$Res call({
 String? pouleLabel, String? competition, DateTime? fetchedAt, List<PouleStanding> standing, List<PouleMatchDay> results, List<PouleMatchDay> fixtures, PouleResultsPush? resultsPush
});


@override $PouleResultsPushCopyWith<$Res>? get resultsPush;

}
/// @nodoc
class __$PouleCopyWithImpl<$Res>
    implements _$PouleCopyWith<$Res> {
  __$PouleCopyWithImpl(this._self, this._then);

  final _Poule _self;
  final $Res Function(_Poule) _then;

/// Create a copy of Poule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pouleLabel = freezed,Object? competition = freezed,Object? fetchedAt = freezed,Object? standing = null,Object? results = null,Object? fixtures = null,Object? resultsPush = freezed,}) {
  return _then(_Poule(
pouleLabel: freezed == pouleLabel ? _self.pouleLabel : pouleLabel // ignore: cast_nullable_to_non_nullable
as String?,competition: freezed == competition ? _self.competition : competition // ignore: cast_nullable_to_non_nullable
as String?,fetchedAt: freezed == fetchedAt ? _self.fetchedAt : fetchedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,standing: null == standing ? _self._standing : standing // ignore: cast_nullable_to_non_nullable
as List<PouleStanding>,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<PouleMatchDay>,fixtures: null == fixtures ? _self._fixtures : fixtures // ignore: cast_nullable_to_non_nullable
as List<PouleMatchDay>,resultsPush: freezed == resultsPush ? _self.resultsPush : resultsPush // ignore: cast_nullable_to_non_nullable
as PouleResultsPush?,
  ));
}

/// Create a copy of Poule
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PouleResultsPushCopyWith<$Res>? get resultsPush {
    if (_self.resultsPush == null) {
    return null;
  }

  return $PouleResultsPushCopyWith<$Res>(_self.resultsPush!, (value) {
    return _then(_self.copyWith(resultsPush: value));
  });
}
}

// dart format on
