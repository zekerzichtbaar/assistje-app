// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_detail_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerProfile {

 int get id; String get name; int? get shirtNumber; String? get position; bool get isGuest; bool get isInjured; bool get isOnVacation;/// Naam van het team waar een gast vandaan komt.
 String? get fromTeam; String? get avatarUrl; bool get hasAccount;/// Alleen gevuld voor een trainer (`can_manage`).
 String? get email; DateTime? get invitedAt; bool get inviteAccepted; bool get isTrainer; List<String> get abilities; bool get isSelf; bool get isCaptain;
/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerProfileCopyWith<PlayerProfile> get copyWith => _$PlayerProfileCopyWithImpl<PlayerProfile>(this as PlayerProfile, _$identity);

  /// Serializes this PlayerProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.position, position) || other.position == position)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.isInjured, isInjured) || other.isInjured == isInjured)&&(identical(other.isOnVacation, isOnVacation) || other.isOnVacation == isOnVacation)&&(identical(other.fromTeam, fromTeam) || other.fromTeam == fromTeam)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.hasAccount, hasAccount) || other.hasAccount == hasAccount)&&(identical(other.email, email) || other.email == email)&&(identical(other.invitedAt, invitedAt) || other.invitedAt == invitedAt)&&(identical(other.inviteAccepted, inviteAccepted) || other.inviteAccepted == inviteAccepted)&&(identical(other.isTrainer, isTrainer) || other.isTrainer == isTrainer)&&const DeepCollectionEquality().equals(other.abilities, abilities)&&(identical(other.isSelf, isSelf) || other.isSelf == isSelf)&&(identical(other.isCaptain, isCaptain) || other.isCaptain == isCaptain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber,position,isGuest,isInjured,isOnVacation,fromTeam,avatarUrl,hasAccount,email,invitedAt,inviteAccepted,isTrainer,const DeepCollectionEquality().hash(abilities),isSelf,isCaptain);

@override
String toString() {
  return 'PlayerProfile(id: $id, name: $name, shirtNumber: $shirtNumber, position: $position, isGuest: $isGuest, isInjured: $isInjured, isOnVacation: $isOnVacation, fromTeam: $fromTeam, avatarUrl: $avatarUrl, hasAccount: $hasAccount, email: $email, invitedAt: $invitedAt, inviteAccepted: $inviteAccepted, isTrainer: $isTrainer, abilities: $abilities, isSelf: $isSelf, isCaptain: $isCaptain)';
}


}

/// @nodoc
abstract mixin class $PlayerProfileCopyWith<$Res>  {
  factory $PlayerProfileCopyWith(PlayerProfile value, $Res Function(PlayerProfile) _then) = _$PlayerProfileCopyWithImpl;
@useResult
$Res call({
 int id, String name, int? shirtNumber, String? position, bool isGuest, bool isInjured, bool isOnVacation, String? fromTeam, String? avatarUrl, bool hasAccount, String? email, DateTime? invitedAt, bool inviteAccepted, bool isTrainer, List<String> abilities, bool isSelf, bool isCaptain
});




}
/// @nodoc
class _$PlayerProfileCopyWithImpl<$Res>
    implements $PlayerProfileCopyWith<$Res> {
  _$PlayerProfileCopyWithImpl(this._self, this._then);

  final PlayerProfile _self;
  final $Res Function(PlayerProfile) _then;

/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,Object? position = freezed,Object? isGuest = null,Object? isInjured = null,Object? isOnVacation = null,Object? fromTeam = freezed,Object? avatarUrl = freezed,Object? hasAccount = null,Object? email = freezed,Object? invitedAt = freezed,Object? inviteAccepted = null,Object? isTrainer = null,Object? abilities = null,Object? isSelf = null,Object? isCaptain = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,isInjured: null == isInjured ? _self.isInjured : isInjured // ignore: cast_nullable_to_non_nullable
as bool,isOnVacation: null == isOnVacation ? _self.isOnVacation : isOnVacation // ignore: cast_nullable_to_non_nullable
as bool,fromTeam: freezed == fromTeam ? _self.fromTeam : fromTeam // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,hasAccount: null == hasAccount ? _self.hasAccount : hasAccount // ignore: cast_nullable_to_non_nullable
as bool,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,invitedAt: freezed == invitedAt ? _self.invitedAt : invitedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,inviteAccepted: null == inviteAccepted ? _self.inviteAccepted : inviteAccepted // ignore: cast_nullable_to_non_nullable
as bool,isTrainer: null == isTrainer ? _self.isTrainer : isTrainer // ignore: cast_nullable_to_non_nullable
as bool,abilities: null == abilities ? _self.abilities : abilities // ignore: cast_nullable_to_non_nullable
as List<String>,isSelf: null == isSelf ? _self.isSelf : isSelf // ignore: cast_nullable_to_non_nullable
as bool,isCaptain: null == isCaptain ? _self.isCaptain : isCaptain // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerProfile].
extension PlayerProfilePatterns on PlayerProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerProfile value)  $default,){
final _that = this;
switch (_that) {
case _PlayerProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerProfile value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int? shirtNumber,  String? position,  bool isGuest,  bool isInjured,  bool isOnVacation,  String? fromTeam,  String? avatarUrl,  bool hasAccount,  String? email,  DateTime? invitedAt,  bool inviteAccepted,  bool isTrainer,  List<String> abilities,  bool isSelf,  bool isCaptain)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber,_that.position,_that.isGuest,_that.isInjured,_that.isOnVacation,_that.fromTeam,_that.avatarUrl,_that.hasAccount,_that.email,_that.invitedAt,_that.inviteAccepted,_that.isTrainer,_that.abilities,_that.isSelf,_that.isCaptain);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int? shirtNumber,  String? position,  bool isGuest,  bool isInjured,  bool isOnVacation,  String? fromTeam,  String? avatarUrl,  bool hasAccount,  String? email,  DateTime? invitedAt,  bool inviteAccepted,  bool isTrainer,  List<String> abilities,  bool isSelf,  bool isCaptain)  $default,) {final _that = this;
switch (_that) {
case _PlayerProfile():
return $default(_that.id,_that.name,_that.shirtNumber,_that.position,_that.isGuest,_that.isInjured,_that.isOnVacation,_that.fromTeam,_that.avatarUrl,_that.hasAccount,_that.email,_that.invitedAt,_that.inviteAccepted,_that.isTrainer,_that.abilities,_that.isSelf,_that.isCaptain);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int? shirtNumber,  String? position,  bool isGuest,  bool isInjured,  bool isOnVacation,  String? fromTeam,  String? avatarUrl,  bool hasAccount,  String? email,  DateTime? invitedAt,  bool inviteAccepted,  bool isTrainer,  List<String> abilities,  bool isSelf,  bool isCaptain)?  $default,) {final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber,_that.position,_that.isGuest,_that.isInjured,_that.isOnVacation,_that.fromTeam,_that.avatarUrl,_that.hasAccount,_that.email,_that.invitedAt,_that.inviteAccepted,_that.isTrainer,_that.abilities,_that.isSelf,_that.isCaptain);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerProfile implements PlayerProfile {
  const _PlayerProfile({required this.id, this.name = '', this.shirtNumber, this.position, this.isGuest = false, this.isInjured = false, this.isOnVacation = false, this.fromTeam, this.avatarUrl, this.hasAccount = false, this.email, this.invitedAt, this.inviteAccepted = false, this.isTrainer = false, final  List<String> abilities = const <String>[], this.isSelf = false, this.isCaptain = false}): _abilities = abilities;
  factory _PlayerProfile.fromJson(Map<String, dynamic> json) => _$PlayerProfileFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  int? shirtNumber;
@override final  String? position;
@override@JsonKey() final  bool isGuest;
@override@JsonKey() final  bool isInjured;
@override@JsonKey() final  bool isOnVacation;
/// Naam van het team waar een gast vandaan komt.
@override final  String? fromTeam;
@override final  String? avatarUrl;
@override@JsonKey() final  bool hasAccount;
/// Alleen gevuld voor een trainer (`can_manage`).
@override final  String? email;
@override final  DateTime? invitedAt;
@override@JsonKey() final  bool inviteAccepted;
@override@JsonKey() final  bool isTrainer;
 final  List<String> _abilities;
@override@JsonKey() List<String> get abilities {
  if (_abilities is EqualUnmodifiableListView) return _abilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_abilities);
}

@override@JsonKey() final  bool isSelf;
@override@JsonKey() final  bool isCaptain;

/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerProfileCopyWith<_PlayerProfile> get copyWith => __$PlayerProfileCopyWithImpl<_PlayerProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.position, position) || other.position == position)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.isInjured, isInjured) || other.isInjured == isInjured)&&(identical(other.isOnVacation, isOnVacation) || other.isOnVacation == isOnVacation)&&(identical(other.fromTeam, fromTeam) || other.fromTeam == fromTeam)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.hasAccount, hasAccount) || other.hasAccount == hasAccount)&&(identical(other.email, email) || other.email == email)&&(identical(other.invitedAt, invitedAt) || other.invitedAt == invitedAt)&&(identical(other.inviteAccepted, inviteAccepted) || other.inviteAccepted == inviteAccepted)&&(identical(other.isTrainer, isTrainer) || other.isTrainer == isTrainer)&&const DeepCollectionEquality().equals(other._abilities, _abilities)&&(identical(other.isSelf, isSelf) || other.isSelf == isSelf)&&(identical(other.isCaptain, isCaptain) || other.isCaptain == isCaptain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber,position,isGuest,isInjured,isOnVacation,fromTeam,avatarUrl,hasAccount,email,invitedAt,inviteAccepted,isTrainer,const DeepCollectionEquality().hash(_abilities),isSelf,isCaptain);

@override
String toString() {
  return 'PlayerProfile(id: $id, name: $name, shirtNumber: $shirtNumber, position: $position, isGuest: $isGuest, isInjured: $isInjured, isOnVacation: $isOnVacation, fromTeam: $fromTeam, avatarUrl: $avatarUrl, hasAccount: $hasAccount, email: $email, invitedAt: $invitedAt, inviteAccepted: $inviteAccepted, isTrainer: $isTrainer, abilities: $abilities, isSelf: $isSelf, isCaptain: $isCaptain)';
}


}

/// @nodoc
abstract mixin class _$PlayerProfileCopyWith<$Res> implements $PlayerProfileCopyWith<$Res> {
  factory _$PlayerProfileCopyWith(_PlayerProfile value, $Res Function(_PlayerProfile) _then) = __$PlayerProfileCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int? shirtNumber, String? position, bool isGuest, bool isInjured, bool isOnVacation, String? fromTeam, String? avatarUrl, bool hasAccount, String? email, DateTime? invitedAt, bool inviteAccepted, bool isTrainer, List<String> abilities, bool isSelf, bool isCaptain
});




}
/// @nodoc
class __$PlayerProfileCopyWithImpl<$Res>
    implements _$PlayerProfileCopyWith<$Res> {
  __$PlayerProfileCopyWithImpl(this._self, this._then);

  final _PlayerProfile _self;
  final $Res Function(_PlayerProfile) _then;

/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,Object? position = freezed,Object? isGuest = null,Object? isInjured = null,Object? isOnVacation = null,Object? fromTeam = freezed,Object? avatarUrl = freezed,Object? hasAccount = null,Object? email = freezed,Object? invitedAt = freezed,Object? inviteAccepted = null,Object? isTrainer = null,Object? abilities = null,Object? isSelf = null,Object? isCaptain = null,}) {
  return _then(_PlayerProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,isInjured: null == isInjured ? _self.isInjured : isInjured // ignore: cast_nullable_to_non_nullable
as bool,isOnVacation: null == isOnVacation ? _self.isOnVacation : isOnVacation // ignore: cast_nullable_to_non_nullable
as bool,fromTeam: freezed == fromTeam ? _self.fromTeam : fromTeam // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,hasAccount: null == hasAccount ? _self.hasAccount : hasAccount // ignore: cast_nullable_to_non_nullable
as bool,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,invitedAt: freezed == invitedAt ? _self.invitedAt : invitedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,inviteAccepted: null == inviteAccepted ? _self.inviteAccepted : inviteAccepted // ignore: cast_nullable_to_non_nullable
as bool,isTrainer: null == isTrainer ? _self.isTrainer : isTrainer // ignore: cast_nullable_to_non_nullable
as bool,abilities: null == abilities ? _self._abilities : abilities // ignore: cast_nullable_to_non_nullable
as List<String>,isSelf: null == isSelf ? _self.isSelf : isSelf // ignore: cast_nullable_to_non_nullable
as bool,isCaptain: null == isCaptain ? _self.isCaptain : isCaptain // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$PersonalStats {

 int get matchesPlayed; int get wins; int get draws; int get losses; double get winPct; int get goals; int get assists; int get green; int get yellow; int get red; int get cleanSheets; int get motm; double get attendanceMatchRate; double get attendanceTrainingRate; int? get trainingPoints; int? get points; int? get aces; int? get blocks;
/// Create a copy of PersonalStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalStatsCopyWith<PersonalStats> get copyWith => _$PersonalStatsCopyWithImpl<PersonalStats>(this as PersonalStats, _$identity);

  /// Serializes this PersonalStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalStats&&(identical(other.matchesPlayed, matchesPlayed) || other.matchesPlayed == matchesPlayed)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.draws, draws) || other.draws == draws)&&(identical(other.losses, losses) || other.losses == losses)&&(identical(other.winPct, winPct) || other.winPct == winPct)&&(identical(other.goals, goals) || other.goals == goals)&&(identical(other.assists, assists) || other.assists == assists)&&(identical(other.green, green) || other.green == green)&&(identical(other.yellow, yellow) || other.yellow == yellow)&&(identical(other.red, red) || other.red == red)&&(identical(other.cleanSheets, cleanSheets) || other.cleanSheets == cleanSheets)&&(identical(other.motm, motm) || other.motm == motm)&&(identical(other.attendanceMatchRate, attendanceMatchRate) || other.attendanceMatchRate == attendanceMatchRate)&&(identical(other.attendanceTrainingRate, attendanceTrainingRate) || other.attendanceTrainingRate == attendanceTrainingRate)&&(identical(other.trainingPoints, trainingPoints) || other.trainingPoints == trainingPoints)&&(identical(other.points, points) || other.points == points)&&(identical(other.aces, aces) || other.aces == aces)&&(identical(other.blocks, blocks) || other.blocks == blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchesPlayed,wins,draws,losses,winPct,goals,assists,green,yellow,red,cleanSheets,motm,attendanceMatchRate,attendanceTrainingRate,trainingPoints,points,aces,blocks);

@override
String toString() {
  return 'PersonalStats(matchesPlayed: $matchesPlayed, wins: $wins, draws: $draws, losses: $losses, winPct: $winPct, goals: $goals, assists: $assists, green: $green, yellow: $yellow, red: $red, cleanSheets: $cleanSheets, motm: $motm, attendanceMatchRate: $attendanceMatchRate, attendanceTrainingRate: $attendanceTrainingRate, trainingPoints: $trainingPoints, points: $points, aces: $aces, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class $PersonalStatsCopyWith<$Res>  {
  factory $PersonalStatsCopyWith(PersonalStats value, $Res Function(PersonalStats) _then) = _$PersonalStatsCopyWithImpl;
@useResult
$Res call({
 int matchesPlayed, int wins, int draws, int losses, double winPct, int goals, int assists, int green, int yellow, int red, int cleanSheets, int motm, double attendanceMatchRate, double attendanceTrainingRate, int? trainingPoints, int? points, int? aces, int? blocks
});




}
/// @nodoc
class _$PersonalStatsCopyWithImpl<$Res>
    implements $PersonalStatsCopyWith<$Res> {
  _$PersonalStatsCopyWithImpl(this._self, this._then);

  final PersonalStats _self;
  final $Res Function(PersonalStats) _then;

/// Create a copy of PersonalStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? matchesPlayed = null,Object? wins = null,Object? draws = null,Object? losses = null,Object? winPct = null,Object? goals = null,Object? assists = null,Object? green = null,Object? yellow = null,Object? red = null,Object? cleanSheets = null,Object? motm = null,Object? attendanceMatchRate = null,Object? attendanceTrainingRate = null,Object? trainingPoints = freezed,Object? points = freezed,Object? aces = freezed,Object? blocks = freezed,}) {
  return _then(_self.copyWith(
matchesPlayed: null == matchesPlayed ? _self.matchesPlayed : matchesPlayed // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,winPct: null == winPct ? _self.winPct : winPct // ignore: cast_nullable_to_non_nullable
as double,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as int,assists: null == assists ? _self.assists : assists // ignore: cast_nullable_to_non_nullable
as int,green: null == green ? _self.green : green // ignore: cast_nullable_to_non_nullable
as int,yellow: null == yellow ? _self.yellow : yellow // ignore: cast_nullable_to_non_nullable
as int,red: null == red ? _self.red : red // ignore: cast_nullable_to_non_nullable
as int,cleanSheets: null == cleanSheets ? _self.cleanSheets : cleanSheets // ignore: cast_nullable_to_non_nullable
as int,motm: null == motm ? _self.motm : motm // ignore: cast_nullable_to_non_nullable
as int,attendanceMatchRate: null == attendanceMatchRate ? _self.attendanceMatchRate : attendanceMatchRate // ignore: cast_nullable_to_non_nullable
as double,attendanceTrainingRate: null == attendanceTrainingRate ? _self.attendanceTrainingRate : attendanceTrainingRate // ignore: cast_nullable_to_non_nullable
as double,trainingPoints: freezed == trainingPoints ? _self.trainingPoints : trainingPoints // ignore: cast_nullable_to_non_nullable
as int?,points: freezed == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int?,aces: freezed == aces ? _self.aces : aces // ignore: cast_nullable_to_non_nullable
as int?,blocks: freezed == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonalStats].
extension PersonalStatsPatterns on PersonalStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalStats value)  $default,){
final _that = this;
switch (_that) {
case _PersonalStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalStats value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int matchesPlayed,  int wins,  int draws,  int losses,  double winPct,  int goals,  int assists,  int green,  int yellow,  int red,  int cleanSheets,  int motm,  double attendanceMatchRate,  double attendanceTrainingRate,  int? trainingPoints,  int? points,  int? aces,  int? blocks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalStats() when $default != null:
return $default(_that.matchesPlayed,_that.wins,_that.draws,_that.losses,_that.winPct,_that.goals,_that.assists,_that.green,_that.yellow,_that.red,_that.cleanSheets,_that.motm,_that.attendanceMatchRate,_that.attendanceTrainingRate,_that.trainingPoints,_that.points,_that.aces,_that.blocks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int matchesPlayed,  int wins,  int draws,  int losses,  double winPct,  int goals,  int assists,  int green,  int yellow,  int red,  int cleanSheets,  int motm,  double attendanceMatchRate,  double attendanceTrainingRate,  int? trainingPoints,  int? points,  int? aces,  int? blocks)  $default,) {final _that = this;
switch (_that) {
case _PersonalStats():
return $default(_that.matchesPlayed,_that.wins,_that.draws,_that.losses,_that.winPct,_that.goals,_that.assists,_that.green,_that.yellow,_that.red,_that.cleanSheets,_that.motm,_that.attendanceMatchRate,_that.attendanceTrainingRate,_that.trainingPoints,_that.points,_that.aces,_that.blocks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int matchesPlayed,  int wins,  int draws,  int losses,  double winPct,  int goals,  int assists,  int green,  int yellow,  int red,  int cleanSheets,  int motm,  double attendanceMatchRate,  double attendanceTrainingRate,  int? trainingPoints,  int? points,  int? aces,  int? blocks)?  $default,) {final _that = this;
switch (_that) {
case _PersonalStats() when $default != null:
return $default(_that.matchesPlayed,_that.wins,_that.draws,_that.losses,_that.winPct,_that.goals,_that.assists,_that.green,_that.yellow,_that.red,_that.cleanSheets,_that.motm,_that.attendanceMatchRate,_that.attendanceTrainingRate,_that.trainingPoints,_that.points,_that.aces,_that.blocks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonalStats implements PersonalStats {
  const _PersonalStats({this.matchesPlayed = 0, this.wins = 0, this.draws = 0, this.losses = 0, this.winPct = 0, this.goals = 0, this.assists = 0, this.green = 0, this.yellow = 0, this.red = 0, this.cleanSheets = 0, this.motm = 0, this.attendanceMatchRate = 0, this.attendanceTrainingRate = 0, this.trainingPoints, this.points, this.aces, this.blocks});
  factory _PersonalStats.fromJson(Map<String, dynamic> json) => _$PersonalStatsFromJson(json);

@override@JsonKey() final  int matchesPlayed;
@override@JsonKey() final  int wins;
@override@JsonKey() final  int draws;
@override@JsonKey() final  int losses;
@override@JsonKey() final  double winPct;
@override@JsonKey() final  int goals;
@override@JsonKey() final  int assists;
@override@JsonKey() final  int green;
@override@JsonKey() final  int yellow;
@override@JsonKey() final  int red;
@override@JsonKey() final  int cleanSheets;
@override@JsonKey() final  int motm;
@override@JsonKey() final  double attendanceMatchRate;
@override@JsonKey() final  double attendanceTrainingRate;
@override final  int? trainingPoints;
@override final  int? points;
@override final  int? aces;
@override final  int? blocks;

/// Create a copy of PersonalStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalStatsCopyWith<_PersonalStats> get copyWith => __$PersonalStatsCopyWithImpl<_PersonalStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalStats&&(identical(other.matchesPlayed, matchesPlayed) || other.matchesPlayed == matchesPlayed)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.draws, draws) || other.draws == draws)&&(identical(other.losses, losses) || other.losses == losses)&&(identical(other.winPct, winPct) || other.winPct == winPct)&&(identical(other.goals, goals) || other.goals == goals)&&(identical(other.assists, assists) || other.assists == assists)&&(identical(other.green, green) || other.green == green)&&(identical(other.yellow, yellow) || other.yellow == yellow)&&(identical(other.red, red) || other.red == red)&&(identical(other.cleanSheets, cleanSheets) || other.cleanSheets == cleanSheets)&&(identical(other.motm, motm) || other.motm == motm)&&(identical(other.attendanceMatchRate, attendanceMatchRate) || other.attendanceMatchRate == attendanceMatchRate)&&(identical(other.attendanceTrainingRate, attendanceTrainingRate) || other.attendanceTrainingRate == attendanceTrainingRate)&&(identical(other.trainingPoints, trainingPoints) || other.trainingPoints == trainingPoints)&&(identical(other.points, points) || other.points == points)&&(identical(other.aces, aces) || other.aces == aces)&&(identical(other.blocks, blocks) || other.blocks == blocks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,matchesPlayed,wins,draws,losses,winPct,goals,assists,green,yellow,red,cleanSheets,motm,attendanceMatchRate,attendanceTrainingRate,trainingPoints,points,aces,blocks);

@override
String toString() {
  return 'PersonalStats(matchesPlayed: $matchesPlayed, wins: $wins, draws: $draws, losses: $losses, winPct: $winPct, goals: $goals, assists: $assists, green: $green, yellow: $yellow, red: $red, cleanSheets: $cleanSheets, motm: $motm, attendanceMatchRate: $attendanceMatchRate, attendanceTrainingRate: $attendanceTrainingRate, trainingPoints: $trainingPoints, points: $points, aces: $aces, blocks: $blocks)';
}


}

/// @nodoc
abstract mixin class _$PersonalStatsCopyWith<$Res> implements $PersonalStatsCopyWith<$Res> {
  factory _$PersonalStatsCopyWith(_PersonalStats value, $Res Function(_PersonalStats) _then) = __$PersonalStatsCopyWithImpl;
@override @useResult
$Res call({
 int matchesPlayed, int wins, int draws, int losses, double winPct, int goals, int assists, int green, int yellow, int red, int cleanSheets, int motm, double attendanceMatchRate, double attendanceTrainingRate, int? trainingPoints, int? points, int? aces, int? blocks
});




}
/// @nodoc
class __$PersonalStatsCopyWithImpl<$Res>
    implements _$PersonalStatsCopyWith<$Res> {
  __$PersonalStatsCopyWithImpl(this._self, this._then);

  final _PersonalStats _self;
  final $Res Function(_PersonalStats) _then;

/// Create a copy of PersonalStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? matchesPlayed = null,Object? wins = null,Object? draws = null,Object? losses = null,Object? winPct = null,Object? goals = null,Object? assists = null,Object? green = null,Object? yellow = null,Object? red = null,Object? cleanSheets = null,Object? motm = null,Object? attendanceMatchRate = null,Object? attendanceTrainingRate = null,Object? trainingPoints = freezed,Object? points = freezed,Object? aces = freezed,Object? blocks = freezed,}) {
  return _then(_PersonalStats(
matchesPlayed: null == matchesPlayed ? _self.matchesPlayed : matchesPlayed // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,draws: null == draws ? _self.draws : draws // ignore: cast_nullable_to_non_nullable
as int,losses: null == losses ? _self.losses : losses // ignore: cast_nullable_to_non_nullable
as int,winPct: null == winPct ? _self.winPct : winPct // ignore: cast_nullable_to_non_nullable
as double,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as int,assists: null == assists ? _self.assists : assists // ignore: cast_nullable_to_non_nullable
as int,green: null == green ? _self.green : green // ignore: cast_nullable_to_non_nullable
as int,yellow: null == yellow ? _self.yellow : yellow // ignore: cast_nullable_to_non_nullable
as int,red: null == red ? _self.red : red // ignore: cast_nullable_to_non_nullable
as int,cleanSheets: null == cleanSheets ? _self.cleanSheets : cleanSheets // ignore: cast_nullable_to_non_nullable
as int,motm: null == motm ? _self.motm : motm // ignore: cast_nullable_to_non_nullable
as int,attendanceMatchRate: null == attendanceMatchRate ? _self.attendanceMatchRate : attendanceMatchRate // ignore: cast_nullable_to_non_nullable
as double,attendanceTrainingRate: null == attendanceTrainingRate ? _self.attendanceTrainingRate : attendanceTrainingRate // ignore: cast_nullable_to_non_nullable
as double,trainingPoints: freezed == trainingPoints ? _self.trainingPoints : trainingPoints // ignore: cast_nullable_to_non_nullable
as int?,points: freezed == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int?,aces: freezed == aces ? _self.aces : aces // ignore: cast_nullable_to_non_nullable
as int?,blocks: freezed == blocks ? _self.blocks : blocks // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$PersonalStatsSet {

 PersonalStats get season; PersonalStats get career;
/// Create a copy of PersonalStatsSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalStatsSetCopyWith<PersonalStatsSet> get copyWith => _$PersonalStatsSetCopyWithImpl<PersonalStatsSet>(this as PersonalStatsSet, _$identity);

  /// Serializes this PersonalStatsSet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalStatsSet&&(identical(other.season, season) || other.season == season)&&(identical(other.career, career) || other.career == career));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,season,career);

@override
String toString() {
  return 'PersonalStatsSet(season: $season, career: $career)';
}


}

/// @nodoc
abstract mixin class $PersonalStatsSetCopyWith<$Res>  {
  factory $PersonalStatsSetCopyWith(PersonalStatsSet value, $Res Function(PersonalStatsSet) _then) = _$PersonalStatsSetCopyWithImpl;
@useResult
$Res call({
 PersonalStats season, PersonalStats career
});


$PersonalStatsCopyWith<$Res> get season;$PersonalStatsCopyWith<$Res> get career;

}
/// @nodoc
class _$PersonalStatsSetCopyWithImpl<$Res>
    implements $PersonalStatsSetCopyWith<$Res> {
  _$PersonalStatsSetCopyWithImpl(this._self, this._then);

  final PersonalStatsSet _self;
  final $Res Function(PersonalStatsSet) _then;

/// Create a copy of PersonalStatsSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? season = null,Object? career = null,}) {
  return _then(_self.copyWith(
season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as PersonalStats,career: null == career ? _self.career : career // ignore: cast_nullable_to_non_nullable
as PersonalStats,
  ));
}
/// Create a copy of PersonalStatsSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalStatsCopyWith<$Res> get season {
  
  return $PersonalStatsCopyWith<$Res>(_self.season, (value) {
    return _then(_self.copyWith(season: value));
  });
}/// Create a copy of PersonalStatsSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalStatsCopyWith<$Res> get career {
  
  return $PersonalStatsCopyWith<$Res>(_self.career, (value) {
    return _then(_self.copyWith(career: value));
  });
}
}


/// Adds pattern-matching-related methods to [PersonalStatsSet].
extension PersonalStatsSetPatterns on PersonalStatsSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalStatsSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalStatsSet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalStatsSet value)  $default,){
final _that = this;
switch (_that) {
case _PersonalStatsSet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalStatsSet value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalStatsSet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PersonalStats season,  PersonalStats career)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalStatsSet() when $default != null:
return $default(_that.season,_that.career);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PersonalStats season,  PersonalStats career)  $default,) {final _that = this;
switch (_that) {
case _PersonalStatsSet():
return $default(_that.season,_that.career);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PersonalStats season,  PersonalStats career)?  $default,) {final _that = this;
switch (_that) {
case _PersonalStatsSet() when $default != null:
return $default(_that.season,_that.career);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonalStatsSet implements PersonalStatsSet {
  const _PersonalStatsSet({this.season = const PersonalStats(), this.career = const PersonalStats()});
  factory _PersonalStatsSet.fromJson(Map<String, dynamic> json) => _$PersonalStatsSetFromJson(json);

@override@JsonKey() final  PersonalStats season;
@override@JsonKey() final  PersonalStats career;

/// Create a copy of PersonalStatsSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalStatsSetCopyWith<_PersonalStatsSet> get copyWith => __$PersonalStatsSetCopyWithImpl<_PersonalStatsSet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalStatsSetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalStatsSet&&(identical(other.season, season) || other.season == season)&&(identical(other.career, career) || other.career == career));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,season,career);

@override
String toString() {
  return 'PersonalStatsSet(season: $season, career: $career)';
}


}

/// @nodoc
abstract mixin class _$PersonalStatsSetCopyWith<$Res> implements $PersonalStatsSetCopyWith<$Res> {
  factory _$PersonalStatsSetCopyWith(_PersonalStatsSet value, $Res Function(_PersonalStatsSet) _then) = __$PersonalStatsSetCopyWithImpl;
@override @useResult
$Res call({
 PersonalStats season, PersonalStats career
});


@override $PersonalStatsCopyWith<$Res> get season;@override $PersonalStatsCopyWith<$Res> get career;

}
/// @nodoc
class __$PersonalStatsSetCopyWithImpl<$Res>
    implements _$PersonalStatsSetCopyWith<$Res> {
  __$PersonalStatsSetCopyWithImpl(this._self, this._then);

  final _PersonalStatsSet _self;
  final $Res Function(_PersonalStatsSet) _then;

/// Create a copy of PersonalStatsSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? season = null,Object? career = null,}) {
  return _then(_PersonalStatsSet(
season: null == season ? _self.season : season // ignore: cast_nullable_to_non_nullable
as PersonalStats,career: null == career ? _self.career : career // ignore: cast_nullable_to_non_nullable
as PersonalStats,
  ));
}

/// Create a copy of PersonalStatsSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalStatsCopyWith<$Res> get season {
  
  return $PersonalStatsCopyWith<$Res>(_self.season, (value) {
    return _then(_self.copyWith(season: value));
  });
}/// Create a copy of PersonalStatsSet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalStatsCopyWith<$Res> get career {
  
  return $PersonalStatsCopyWith<$Res>(_self.career, (value) {
    return _then(_self.copyWith(career: value));
  });
}
}


/// @nodoc
mixin _$DutyCount {

 String get slug; String get name; int get count;
/// Create a copy of DutyCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyCountCopyWith<DutyCount> get copyWith => _$DutyCountCopyWithImpl<DutyCount>(this as DutyCount, _$identity);

  /// Serializes this DutyCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyCount&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slug,name,count);

@override
String toString() {
  return 'DutyCount(slug: $slug, name: $name, count: $count)';
}


}

/// @nodoc
abstract mixin class $DutyCountCopyWith<$Res>  {
  factory $DutyCountCopyWith(DutyCount value, $Res Function(DutyCount) _then) = _$DutyCountCopyWithImpl;
@useResult
$Res call({
 String slug, String name, int count
});




}
/// @nodoc
class _$DutyCountCopyWithImpl<$Res>
    implements $DutyCountCopyWith<$Res> {
  _$DutyCountCopyWithImpl(this._self, this._then);

  final DutyCount _self;
  final $Res Function(DutyCount) _then;

/// Create a copy of DutyCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? name = null,Object? count = null,}) {
  return _then(_self.copyWith(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DutyCount].
extension DutyCountPatterns on DutyCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyCount value)  $default,){
final _that = this;
switch (_that) {
case _DutyCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyCount value)?  $default,){
final _that = this;
switch (_that) {
case _DutyCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slug,  String name,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyCount() when $default != null:
return $default(_that.slug,_that.name,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slug,  String name,  int count)  $default,) {final _that = this;
switch (_that) {
case _DutyCount():
return $default(_that.slug,_that.name,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slug,  String name,  int count)?  $default,) {final _that = this;
switch (_that) {
case _DutyCount() when $default != null:
return $default(_that.slug,_that.name,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyCount implements DutyCount {
  const _DutyCount({this.slug = '', this.name = '', this.count = 0});
  factory _DutyCount.fromJson(Map<String, dynamic> json) => _$DutyCountFromJson(json);

@override@JsonKey() final  String slug;
@override@JsonKey() final  String name;
@override@JsonKey() final  int count;

/// Create a copy of DutyCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyCountCopyWith<_DutyCount> get copyWith => __$DutyCountCopyWithImpl<_DutyCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyCountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyCount&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,slug,name,count);

@override
String toString() {
  return 'DutyCount(slug: $slug, name: $name, count: $count)';
}


}

/// @nodoc
abstract mixin class _$DutyCountCopyWith<$Res> implements $DutyCountCopyWith<$Res> {
  factory _$DutyCountCopyWith(_DutyCount value, $Res Function(_DutyCount) _then) = __$DutyCountCopyWithImpl;
@override @useResult
$Res call({
 String slug, String name, int count
});




}
/// @nodoc
class __$DutyCountCopyWithImpl<$Res>
    implements _$DutyCountCopyWith<$Res> {
  __$DutyCountCopyWithImpl(this._self, this._then);

  final _DutyCount _self;
  final $Res Function(_DutyCount) _then;

/// Create a copy of DutyCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? name = null,Object? count = null,}) {
  return _then(_DutyCount(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Achievement {

 String get key; String get icon; String get label; String? get detail; int get count;
/// Create a copy of Achievement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchievementCopyWith<Achievement> get copyWith => _$AchievementCopyWithImpl<Achievement>(this as Achievement, _$identity);

  /// Serializes this Achievement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Achievement&&(identical(other.key, key) || other.key == key)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.label, label) || other.label == label)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,icon,label,detail,count);

@override
String toString() {
  return 'Achievement(key: $key, icon: $icon, label: $label, detail: $detail, count: $count)';
}


}

/// @nodoc
abstract mixin class $AchievementCopyWith<$Res>  {
  factory $AchievementCopyWith(Achievement value, $Res Function(Achievement) _then) = _$AchievementCopyWithImpl;
@useResult
$Res call({
 String key, String icon, String label, String? detail, int count
});




}
/// @nodoc
class _$AchievementCopyWithImpl<$Res>
    implements $AchievementCopyWith<$Res> {
  _$AchievementCopyWithImpl(this._self, this._then);

  final Achievement _self;
  final $Res Function(Achievement) _then;

/// Create a copy of Achievement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? icon = null,Object? label = null,Object? detail = freezed,Object? count = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Achievement].
extension AchievementPatterns on Achievement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Achievement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Achievement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Achievement value)  $default,){
final _that = this;
switch (_that) {
case _Achievement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Achievement value)?  $default,){
final _that = this;
switch (_that) {
case _Achievement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String icon,  String label,  String? detail,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Achievement() when $default != null:
return $default(_that.key,_that.icon,_that.label,_that.detail,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String icon,  String label,  String? detail,  int count)  $default,) {final _that = this;
switch (_that) {
case _Achievement():
return $default(_that.key,_that.icon,_that.label,_that.detail,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String icon,  String label,  String? detail,  int count)?  $default,) {final _that = this;
switch (_that) {
case _Achievement() when $default != null:
return $default(_that.key,_that.icon,_that.label,_that.detail,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Achievement implements Achievement {
  const _Achievement({this.key = '', this.icon = '', this.label = '', this.detail, this.count = 1});
  factory _Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);

@override@JsonKey() final  String key;
@override@JsonKey() final  String icon;
@override@JsonKey() final  String label;
@override final  String? detail;
@override@JsonKey() final  int count;

/// Create a copy of Achievement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchievementCopyWith<_Achievement> get copyWith => __$AchievementCopyWithImpl<_Achievement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AchievementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Achievement&&(identical(other.key, key) || other.key == key)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.label, label) || other.label == label)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,icon,label,detail,count);

@override
String toString() {
  return 'Achievement(key: $key, icon: $icon, label: $label, detail: $detail, count: $count)';
}


}

/// @nodoc
abstract mixin class _$AchievementCopyWith<$Res> implements $AchievementCopyWith<$Res> {
  factory _$AchievementCopyWith(_Achievement value, $Res Function(_Achievement) _then) = __$AchievementCopyWithImpl;
@override @useResult
$Res call({
 String key, String icon, String label, String? detail, int count
});




}
/// @nodoc
class __$AchievementCopyWithImpl<$Res>
    implements _$AchievementCopyWith<$Res> {
  __$AchievementCopyWithImpl(this._self, this._then);

  final _Achievement _self;
  final $Res Function(_Achievement) _then;

/// Create a copy of Achievement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? icon = null,Object? label = null,Object? detail = freezed,Object? count = null,}) {
  return _then(_Achievement(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PlayerVacation {

 int get id; DateTime get startsOn; DateTime get endsOn; String? get note;
/// Create a copy of PlayerVacation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerVacationCopyWith<PlayerVacation> get copyWith => _$PlayerVacationCopyWithImpl<PlayerVacation>(this as PlayerVacation, _$identity);

  /// Serializes this PlayerVacation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerVacation&&(identical(other.id, id) || other.id == id)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startsOn,endsOn,note);

@override
String toString() {
  return 'PlayerVacation(id: $id, startsOn: $startsOn, endsOn: $endsOn, note: $note)';
}


}

/// @nodoc
abstract mixin class $PlayerVacationCopyWith<$Res>  {
  factory $PlayerVacationCopyWith(PlayerVacation value, $Res Function(PlayerVacation) _then) = _$PlayerVacationCopyWithImpl;
@useResult
$Res call({
 int id, DateTime startsOn, DateTime endsOn, String? note
});




}
/// @nodoc
class _$PlayerVacationCopyWithImpl<$Res>
    implements $PlayerVacationCopyWith<$Res> {
  _$PlayerVacationCopyWithImpl(this._self, this._then);

  final PlayerVacation _self;
  final $Res Function(PlayerVacation) _then;

/// Create a copy of PlayerVacation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startsOn = null,Object? endsOn = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,startsOn: null == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime,endsOn: null == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerVacation].
extension PlayerVacationPatterns on PlayerVacation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerVacation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerVacation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerVacation value)  $default,){
final _that = this;
switch (_that) {
case _PlayerVacation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerVacation value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerVacation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime startsOn,  DateTime endsOn,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerVacation() when $default != null:
return $default(_that.id,_that.startsOn,_that.endsOn,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime startsOn,  DateTime endsOn,  String? note)  $default,) {final _that = this;
switch (_that) {
case _PlayerVacation():
return $default(_that.id,_that.startsOn,_that.endsOn,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime startsOn,  DateTime endsOn,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _PlayerVacation() when $default != null:
return $default(_that.id,_that.startsOn,_that.endsOn,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerVacation implements PlayerVacation {
  const _PlayerVacation({required this.id, required this.startsOn, required this.endsOn, this.note});
  factory _PlayerVacation.fromJson(Map<String, dynamic> json) => _$PlayerVacationFromJson(json);

@override final  int id;
@override final  DateTime startsOn;
@override final  DateTime endsOn;
@override final  String? note;

/// Create a copy of PlayerVacation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerVacationCopyWith<_PlayerVacation> get copyWith => __$PlayerVacationCopyWithImpl<_PlayerVacation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerVacationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerVacation&&(identical(other.id, id) || other.id == id)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startsOn,endsOn,note);

@override
String toString() {
  return 'PlayerVacation(id: $id, startsOn: $startsOn, endsOn: $endsOn, note: $note)';
}


}

/// @nodoc
abstract mixin class _$PlayerVacationCopyWith<$Res> implements $PlayerVacationCopyWith<$Res> {
  factory _$PlayerVacationCopyWith(_PlayerVacation value, $Res Function(_PlayerVacation) _then) = __$PlayerVacationCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime startsOn, DateTime endsOn, String? note
});




}
/// @nodoc
class __$PlayerVacationCopyWithImpl<$Res>
    implements _$PlayerVacationCopyWith<$Res> {
  __$PlayerVacationCopyWithImpl(this._self, this._then);

  final _PlayerVacation _self;
  final $Res Function(_PlayerVacation) _then;

/// Create a copy of PlayerVacation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startsOn = null,Object? endsOn = null,Object? note = freezed,}) {
  return _then(_PlayerVacation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,startsOn: null == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime,endsOn: null == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as DateTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$StandingAbsenceDay {

 int get id;/// 0 = zondag … 6 = zaterdag.
 int get weekday;
/// Create a copy of StandingAbsenceDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StandingAbsenceDayCopyWith<StandingAbsenceDay> get copyWith => _$StandingAbsenceDayCopyWithImpl<StandingAbsenceDay>(this as StandingAbsenceDay, _$identity);

  /// Serializes this StandingAbsenceDay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StandingAbsenceDay&&(identical(other.id, id) || other.id == id)&&(identical(other.weekday, weekday) || other.weekday == weekday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weekday);

@override
String toString() {
  return 'StandingAbsenceDay(id: $id, weekday: $weekday)';
}


}

/// @nodoc
abstract mixin class $StandingAbsenceDayCopyWith<$Res>  {
  factory $StandingAbsenceDayCopyWith(StandingAbsenceDay value, $Res Function(StandingAbsenceDay) _then) = _$StandingAbsenceDayCopyWithImpl;
@useResult
$Res call({
 int id, int weekday
});




}
/// @nodoc
class _$StandingAbsenceDayCopyWithImpl<$Res>
    implements $StandingAbsenceDayCopyWith<$Res> {
  _$StandingAbsenceDayCopyWithImpl(this._self, this._then);

  final StandingAbsenceDay _self;
  final $Res Function(StandingAbsenceDay) _then;

/// Create a copy of StandingAbsenceDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? weekday = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StandingAbsenceDay].
extension StandingAbsenceDayPatterns on StandingAbsenceDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StandingAbsenceDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StandingAbsenceDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StandingAbsenceDay value)  $default,){
final _that = this;
switch (_that) {
case _StandingAbsenceDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StandingAbsenceDay value)?  $default,){
final _that = this;
switch (_that) {
case _StandingAbsenceDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int weekday)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StandingAbsenceDay() when $default != null:
return $default(_that.id,_that.weekday);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int weekday)  $default,) {final _that = this;
switch (_that) {
case _StandingAbsenceDay():
return $default(_that.id,_that.weekday);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int weekday)?  $default,) {final _that = this;
switch (_that) {
case _StandingAbsenceDay() when $default != null:
return $default(_that.id,_that.weekday);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StandingAbsenceDay implements StandingAbsenceDay {
  const _StandingAbsenceDay({required this.id, required this.weekday});
  factory _StandingAbsenceDay.fromJson(Map<String, dynamic> json) => _$StandingAbsenceDayFromJson(json);

@override final  int id;
/// 0 = zondag … 6 = zaterdag.
@override final  int weekday;

/// Create a copy of StandingAbsenceDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StandingAbsenceDayCopyWith<_StandingAbsenceDay> get copyWith => __$StandingAbsenceDayCopyWithImpl<_StandingAbsenceDay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StandingAbsenceDayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StandingAbsenceDay&&(identical(other.id, id) || other.id == id)&&(identical(other.weekday, weekday) || other.weekday == weekday));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,weekday);

@override
String toString() {
  return 'StandingAbsenceDay(id: $id, weekday: $weekday)';
}


}

/// @nodoc
abstract mixin class _$StandingAbsenceDayCopyWith<$Res> implements $StandingAbsenceDayCopyWith<$Res> {
  factory _$StandingAbsenceDayCopyWith(_StandingAbsenceDay value, $Res Function(_StandingAbsenceDay) _then) = __$StandingAbsenceDayCopyWithImpl;
@override @useResult
$Res call({
 int id, int weekday
});




}
/// @nodoc
class __$StandingAbsenceDayCopyWithImpl<$Res>
    implements _$StandingAbsenceDayCopyWith<$Res> {
  __$StandingAbsenceDayCopyWithImpl(this._self, this._then);

  final _StandingAbsenceDay _self;
  final $Res Function(_StandingAbsenceDay) _then;

/// Create a copy of StandingAbsenceDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? weekday = null,}) {
  return _then(_StandingAbsenceDay(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$StandingAbsences {

 List<StandingAbsenceDay> get days; List<int> get choices;
/// Create a copy of StandingAbsences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StandingAbsencesCopyWith<StandingAbsences> get copyWith => _$StandingAbsencesCopyWithImpl<StandingAbsences>(this as StandingAbsences, _$identity);

  /// Serializes this StandingAbsences to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StandingAbsences&&const DeepCollectionEquality().equals(other.days, days)&&const DeepCollectionEquality().equals(other.choices, choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(days),const DeepCollectionEquality().hash(choices));

@override
String toString() {
  return 'StandingAbsences(days: $days, choices: $choices)';
}


}

/// @nodoc
abstract mixin class $StandingAbsencesCopyWith<$Res>  {
  factory $StandingAbsencesCopyWith(StandingAbsences value, $Res Function(StandingAbsences) _then) = _$StandingAbsencesCopyWithImpl;
@useResult
$Res call({
 List<StandingAbsenceDay> days, List<int> choices
});




}
/// @nodoc
class _$StandingAbsencesCopyWithImpl<$Res>
    implements $StandingAbsencesCopyWith<$Res> {
  _$StandingAbsencesCopyWithImpl(this._self, this._then);

  final StandingAbsences _self;
  final $Res Function(StandingAbsences) _then;

/// Create a copy of StandingAbsences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? days = null,Object? choices = null,}) {
  return _then(_self.copyWith(
days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<StandingAbsenceDay>,choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [StandingAbsences].
extension StandingAbsencesPatterns on StandingAbsences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StandingAbsences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StandingAbsences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StandingAbsences value)  $default,){
final _that = this;
switch (_that) {
case _StandingAbsences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StandingAbsences value)?  $default,){
final _that = this;
switch (_that) {
case _StandingAbsences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<StandingAbsenceDay> days,  List<int> choices)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StandingAbsences() when $default != null:
return $default(_that.days,_that.choices);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<StandingAbsenceDay> days,  List<int> choices)  $default,) {final _that = this;
switch (_that) {
case _StandingAbsences():
return $default(_that.days,_that.choices);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<StandingAbsenceDay> days,  List<int> choices)?  $default,) {final _that = this;
switch (_that) {
case _StandingAbsences() when $default != null:
return $default(_that.days,_that.choices);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StandingAbsences extends StandingAbsences {
  const _StandingAbsences({final  List<StandingAbsenceDay> days = const <StandingAbsenceDay>[], final  List<int> choices = const <int>[]}): _days = days,_choices = choices,super._();
  factory _StandingAbsences.fromJson(Map<String, dynamic> json) => _$StandingAbsencesFromJson(json);

 final  List<StandingAbsenceDay> _days;
@override@JsonKey() List<StandingAbsenceDay> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}

 final  List<int> _choices;
@override@JsonKey() List<int> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}


/// Create a copy of StandingAbsences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StandingAbsencesCopyWith<_StandingAbsences> get copyWith => __$StandingAbsencesCopyWithImpl<_StandingAbsences>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StandingAbsencesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StandingAbsences&&const DeepCollectionEquality().equals(other._days, _days)&&const DeepCollectionEquality().equals(other._choices, _choices));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_days),const DeepCollectionEquality().hash(_choices));

@override
String toString() {
  return 'StandingAbsences(days: $days, choices: $choices)';
}


}

/// @nodoc
abstract mixin class _$StandingAbsencesCopyWith<$Res> implements $StandingAbsencesCopyWith<$Res> {
  factory _$StandingAbsencesCopyWith(_StandingAbsences value, $Res Function(_StandingAbsences) _then) = __$StandingAbsencesCopyWithImpl;
@override @useResult
$Res call({
 List<StandingAbsenceDay> days, List<int> choices
});




}
/// @nodoc
class __$StandingAbsencesCopyWithImpl<$Res>
    implements _$StandingAbsencesCopyWith<$Res> {
  __$StandingAbsencesCopyWithImpl(this._self, this._then);

  final _StandingAbsences _self;
  final $Res Function(_StandingAbsences) _then;

/// Create a copy of StandingAbsences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? days = null,Object? choices = null,}) {
  return _then(_StandingAbsences(
days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<StandingAbsenceDay>,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}


/// @nodoc
mixin _$PlayerDetail {

 PlayerProfile get player;/// Kijkt een trainer van dit team? Alleen dan zijn de beheervelden gevuld.
 bool get canManage; List<PlayerVacation> get vacations; StandingAbsences? get standingAbsences; PersonalStatsSet? get personalStats; List<DutyCount> get duties; List<Achievement> get achievements;
/// Create a copy of PlayerDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerDetailCopyWith<PlayerDetail> get copyWith => _$PlayerDetailCopyWithImpl<PlayerDetail>(this as PlayerDetail, _$identity);

  /// Serializes this PlayerDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerDetail&&(identical(other.player, player) || other.player == player)&&(identical(other.canManage, canManage) || other.canManage == canManage)&&const DeepCollectionEquality().equals(other.vacations, vacations)&&(identical(other.standingAbsences, standingAbsences) || other.standingAbsences == standingAbsences)&&(identical(other.personalStats, personalStats) || other.personalStats == personalStats)&&const DeepCollectionEquality().equals(other.duties, duties)&&const DeepCollectionEquality().equals(other.achievements, achievements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,player,canManage,const DeepCollectionEquality().hash(vacations),standingAbsences,personalStats,const DeepCollectionEquality().hash(duties),const DeepCollectionEquality().hash(achievements));

@override
String toString() {
  return 'PlayerDetail(player: $player, canManage: $canManage, vacations: $vacations, standingAbsences: $standingAbsences, personalStats: $personalStats, duties: $duties, achievements: $achievements)';
}


}

/// @nodoc
abstract mixin class $PlayerDetailCopyWith<$Res>  {
  factory $PlayerDetailCopyWith(PlayerDetail value, $Res Function(PlayerDetail) _then) = _$PlayerDetailCopyWithImpl;
@useResult
$Res call({
 PlayerProfile player, bool canManage, List<PlayerVacation> vacations, StandingAbsences? standingAbsences, PersonalStatsSet? personalStats, List<DutyCount> duties, List<Achievement> achievements
});


$PlayerProfileCopyWith<$Res> get player;$StandingAbsencesCopyWith<$Res>? get standingAbsences;$PersonalStatsSetCopyWith<$Res>? get personalStats;

}
/// @nodoc
class _$PlayerDetailCopyWithImpl<$Res>
    implements $PlayerDetailCopyWith<$Res> {
  _$PlayerDetailCopyWithImpl(this._self, this._then);

  final PlayerDetail _self;
  final $Res Function(PlayerDetail) _then;

/// Create a copy of PlayerDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? player = null,Object? canManage = null,Object? vacations = null,Object? standingAbsences = freezed,Object? personalStats = freezed,Object? duties = null,Object? achievements = null,}) {
  return _then(_self.copyWith(
player: null == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as PlayerProfile,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,vacations: null == vacations ? _self.vacations : vacations // ignore: cast_nullable_to_non_nullable
as List<PlayerVacation>,standingAbsences: freezed == standingAbsences ? _self.standingAbsences : standingAbsences // ignore: cast_nullable_to_non_nullable
as StandingAbsences?,personalStats: freezed == personalStats ? _self.personalStats : personalStats // ignore: cast_nullable_to_non_nullable
as PersonalStatsSet?,duties: null == duties ? _self.duties : duties // ignore: cast_nullable_to_non_nullable
as List<DutyCount>,achievements: null == achievements ? _self.achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<Achievement>,
  ));
}
/// Create a copy of PlayerDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerProfileCopyWith<$Res> get player {
  
  return $PlayerProfileCopyWith<$Res>(_self.player, (value) {
    return _then(_self.copyWith(player: value));
  });
}/// Create a copy of PlayerDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StandingAbsencesCopyWith<$Res>? get standingAbsences {
    if (_self.standingAbsences == null) {
    return null;
  }

  return $StandingAbsencesCopyWith<$Res>(_self.standingAbsences!, (value) {
    return _then(_self.copyWith(standingAbsences: value));
  });
}/// Create a copy of PlayerDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalStatsSetCopyWith<$Res>? get personalStats {
    if (_self.personalStats == null) {
    return null;
  }

  return $PersonalStatsSetCopyWith<$Res>(_self.personalStats!, (value) {
    return _then(_self.copyWith(personalStats: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlayerDetail].
extension PlayerDetailPatterns on PlayerDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerDetail value)  $default,){
final _that = this;
switch (_that) {
case _PlayerDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerDetail value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlayerProfile player,  bool canManage,  List<PlayerVacation> vacations,  StandingAbsences? standingAbsences,  PersonalStatsSet? personalStats,  List<DutyCount> duties,  List<Achievement> achievements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerDetail() when $default != null:
return $default(_that.player,_that.canManage,_that.vacations,_that.standingAbsences,_that.personalStats,_that.duties,_that.achievements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlayerProfile player,  bool canManage,  List<PlayerVacation> vacations,  StandingAbsences? standingAbsences,  PersonalStatsSet? personalStats,  List<DutyCount> duties,  List<Achievement> achievements)  $default,) {final _that = this;
switch (_that) {
case _PlayerDetail():
return $default(_that.player,_that.canManage,_that.vacations,_that.standingAbsences,_that.personalStats,_that.duties,_that.achievements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlayerProfile player,  bool canManage,  List<PlayerVacation> vacations,  StandingAbsences? standingAbsences,  PersonalStatsSet? personalStats,  List<DutyCount> duties,  List<Achievement> achievements)?  $default,) {final _that = this;
switch (_that) {
case _PlayerDetail() when $default != null:
return $default(_that.player,_that.canManage,_that.vacations,_that.standingAbsences,_that.personalStats,_that.duties,_that.achievements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerDetail implements PlayerDetail {
  const _PlayerDetail({required this.player, this.canManage = false, final  List<PlayerVacation> vacations = const <PlayerVacation>[], this.standingAbsences, this.personalStats, final  List<DutyCount> duties = const <DutyCount>[], final  List<Achievement> achievements = const <Achievement>[]}): _vacations = vacations,_duties = duties,_achievements = achievements;
  factory _PlayerDetail.fromJson(Map<String, dynamic> json) => _$PlayerDetailFromJson(json);

@override final  PlayerProfile player;
/// Kijkt een trainer van dit team? Alleen dan zijn de beheervelden gevuld.
@override@JsonKey() final  bool canManage;
 final  List<PlayerVacation> _vacations;
@override@JsonKey() List<PlayerVacation> get vacations {
  if (_vacations is EqualUnmodifiableListView) return _vacations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vacations);
}

@override final  StandingAbsences? standingAbsences;
@override final  PersonalStatsSet? personalStats;
 final  List<DutyCount> _duties;
@override@JsonKey() List<DutyCount> get duties {
  if (_duties is EqualUnmodifiableListView) return _duties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_duties);
}

 final  List<Achievement> _achievements;
@override@JsonKey() List<Achievement> get achievements {
  if (_achievements is EqualUnmodifiableListView) return _achievements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_achievements);
}


/// Create a copy of PlayerDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerDetailCopyWith<_PlayerDetail> get copyWith => __$PlayerDetailCopyWithImpl<_PlayerDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerDetail&&(identical(other.player, player) || other.player == player)&&(identical(other.canManage, canManage) || other.canManage == canManage)&&const DeepCollectionEquality().equals(other._vacations, _vacations)&&(identical(other.standingAbsences, standingAbsences) || other.standingAbsences == standingAbsences)&&(identical(other.personalStats, personalStats) || other.personalStats == personalStats)&&const DeepCollectionEquality().equals(other._duties, _duties)&&const DeepCollectionEquality().equals(other._achievements, _achievements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,player,canManage,const DeepCollectionEquality().hash(_vacations),standingAbsences,personalStats,const DeepCollectionEquality().hash(_duties),const DeepCollectionEquality().hash(_achievements));

@override
String toString() {
  return 'PlayerDetail(player: $player, canManage: $canManage, vacations: $vacations, standingAbsences: $standingAbsences, personalStats: $personalStats, duties: $duties, achievements: $achievements)';
}


}

/// @nodoc
abstract mixin class _$PlayerDetailCopyWith<$Res> implements $PlayerDetailCopyWith<$Res> {
  factory _$PlayerDetailCopyWith(_PlayerDetail value, $Res Function(_PlayerDetail) _then) = __$PlayerDetailCopyWithImpl;
@override @useResult
$Res call({
 PlayerProfile player, bool canManage, List<PlayerVacation> vacations, StandingAbsences? standingAbsences, PersonalStatsSet? personalStats, List<DutyCount> duties, List<Achievement> achievements
});


@override $PlayerProfileCopyWith<$Res> get player;@override $StandingAbsencesCopyWith<$Res>? get standingAbsences;@override $PersonalStatsSetCopyWith<$Res>? get personalStats;

}
/// @nodoc
class __$PlayerDetailCopyWithImpl<$Res>
    implements _$PlayerDetailCopyWith<$Res> {
  __$PlayerDetailCopyWithImpl(this._self, this._then);

  final _PlayerDetail _self;
  final $Res Function(_PlayerDetail) _then;

/// Create a copy of PlayerDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? player = null,Object? canManage = null,Object? vacations = null,Object? standingAbsences = freezed,Object? personalStats = freezed,Object? duties = null,Object? achievements = null,}) {
  return _then(_PlayerDetail(
player: null == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as PlayerProfile,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,vacations: null == vacations ? _self._vacations : vacations // ignore: cast_nullable_to_non_nullable
as List<PlayerVacation>,standingAbsences: freezed == standingAbsences ? _self.standingAbsences : standingAbsences // ignore: cast_nullable_to_non_nullable
as StandingAbsences?,personalStats: freezed == personalStats ? _self.personalStats : personalStats // ignore: cast_nullable_to_non_nullable
as PersonalStatsSet?,duties: null == duties ? _self._duties : duties // ignore: cast_nullable_to_non_nullable
as List<DutyCount>,achievements: null == achievements ? _self._achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<Achievement>,
  ));
}

/// Create a copy of PlayerDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerProfileCopyWith<$Res> get player {
  
  return $PlayerProfileCopyWith<$Res>(_self.player, (value) {
    return _then(_self.copyWith(player: value));
  });
}/// Create a copy of PlayerDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StandingAbsencesCopyWith<$Res>? get standingAbsences {
    if (_self.standingAbsences == null) {
    return null;
  }

  return $StandingAbsencesCopyWith<$Res>(_self.standingAbsences!, (value) {
    return _then(_self.copyWith(standingAbsences: value));
  });
}/// Create a copy of PlayerDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalStatsSetCopyWith<$Res>? get personalStats {
    if (_self.personalStats == null) {
    return null;
  }

  return $PersonalStatsSetCopyWith<$Res>(_self.personalStats!, (value) {
    return _then(_self.copyWith(personalStats: value));
  });
}
}

// dart format on
