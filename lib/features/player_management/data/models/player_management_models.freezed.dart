// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_management_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ManagedPlayer {

 int get id; int? get userId; int? get shirtNumber; String get name; String? get position; bool get isGuest; bool get isInjured; bool get isOnVacation; String? get fromTeam; String? get email; String? get avatarUrl; bool get isTrainer; bool get isCaptain;@JsonKey(unknownEnumValue: InviteStatus.unknown) InviteStatus get inviteStatus;@JsonKey(unknownEnumValue: PushStatus.unknown) PushStatus get pushStatus; int? get strength;/// `YYYY-MM-DD`, of `null`.
 String? get birthdate; List<String> get abilities;
/// Create a copy of ManagedPlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManagedPlayerCopyWith<ManagedPlayer> get copyWith => _$ManagedPlayerCopyWithImpl<ManagedPlayer>(this as ManagedPlayer, _$identity);

  /// Serializes this ManagedPlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManagedPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.isInjured, isInjured) || other.isInjured == isInjured)&&(identical(other.isOnVacation, isOnVacation) || other.isOnVacation == isOnVacation)&&(identical(other.fromTeam, fromTeam) || other.fromTeam == fromTeam)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isTrainer, isTrainer) || other.isTrainer == isTrainer)&&(identical(other.isCaptain, isCaptain) || other.isCaptain == isCaptain)&&(identical(other.inviteStatus, inviteStatus) || other.inviteStatus == inviteStatus)&&(identical(other.pushStatus, pushStatus) || other.pushStatus == pushStatus)&&(identical(other.strength, strength) || other.strength == strength)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&const DeepCollectionEquality().equals(other.abilities, abilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,shirtNumber,name,position,isGuest,isInjured,isOnVacation,fromTeam,email,avatarUrl,isTrainer,isCaptain,inviteStatus,pushStatus,strength,birthdate,const DeepCollectionEquality().hash(abilities));

@override
String toString() {
  return 'ManagedPlayer(id: $id, userId: $userId, shirtNumber: $shirtNumber, name: $name, position: $position, isGuest: $isGuest, isInjured: $isInjured, isOnVacation: $isOnVacation, fromTeam: $fromTeam, email: $email, avatarUrl: $avatarUrl, isTrainer: $isTrainer, isCaptain: $isCaptain, inviteStatus: $inviteStatus, pushStatus: $pushStatus, strength: $strength, birthdate: $birthdate, abilities: $abilities)';
}


}

/// @nodoc
abstract mixin class $ManagedPlayerCopyWith<$Res>  {
  factory $ManagedPlayerCopyWith(ManagedPlayer value, $Res Function(ManagedPlayer) _then) = _$ManagedPlayerCopyWithImpl;
@useResult
$Res call({
 int id, int? userId, int? shirtNumber, String name, String? position, bool isGuest, bool isInjured, bool isOnVacation, String? fromTeam, String? email, String? avatarUrl, bool isTrainer, bool isCaptain,@JsonKey(unknownEnumValue: InviteStatus.unknown) InviteStatus inviteStatus,@JsonKey(unknownEnumValue: PushStatus.unknown) PushStatus pushStatus, int? strength, String? birthdate, List<String> abilities
});




}
/// @nodoc
class _$ManagedPlayerCopyWithImpl<$Res>
    implements $ManagedPlayerCopyWith<$Res> {
  _$ManagedPlayerCopyWithImpl(this._self, this._then);

  final ManagedPlayer _self;
  final $Res Function(ManagedPlayer) _then;

/// Create a copy of ManagedPlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = freezed,Object? shirtNumber = freezed,Object? name = null,Object? position = freezed,Object? isGuest = null,Object? isInjured = null,Object? isOnVacation = null,Object? fromTeam = freezed,Object? email = freezed,Object? avatarUrl = freezed,Object? isTrainer = null,Object? isCaptain = null,Object? inviteStatus = null,Object? pushStatus = null,Object? strength = freezed,Object? birthdate = freezed,Object? abilities = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,isInjured: null == isInjured ? _self.isInjured : isInjured // ignore: cast_nullable_to_non_nullable
as bool,isOnVacation: null == isOnVacation ? _self.isOnVacation : isOnVacation // ignore: cast_nullable_to_non_nullable
as bool,fromTeam: freezed == fromTeam ? _self.fromTeam : fromTeam // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isTrainer: null == isTrainer ? _self.isTrainer : isTrainer // ignore: cast_nullable_to_non_nullable
as bool,isCaptain: null == isCaptain ? _self.isCaptain : isCaptain // ignore: cast_nullable_to_non_nullable
as bool,inviteStatus: null == inviteStatus ? _self.inviteStatus : inviteStatus // ignore: cast_nullable_to_non_nullable
as InviteStatus,pushStatus: null == pushStatus ? _self.pushStatus : pushStatus // ignore: cast_nullable_to_non_nullable
as PushStatus,strength: freezed == strength ? _self.strength : strength // ignore: cast_nullable_to_non_nullable
as int?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as String?,abilities: null == abilities ? _self.abilities : abilities // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ManagedPlayer].
extension ManagedPlayerPatterns on ManagedPlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ManagedPlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ManagedPlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ManagedPlayer value)  $default,){
final _that = this;
switch (_that) {
case _ManagedPlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ManagedPlayer value)?  $default,){
final _that = this;
switch (_that) {
case _ManagedPlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int? userId,  int? shirtNumber,  String name,  String? position,  bool isGuest,  bool isInjured,  bool isOnVacation,  String? fromTeam,  String? email,  String? avatarUrl,  bool isTrainer,  bool isCaptain, @JsonKey(unknownEnumValue: InviteStatus.unknown)  InviteStatus inviteStatus, @JsonKey(unknownEnumValue: PushStatus.unknown)  PushStatus pushStatus,  int? strength,  String? birthdate,  List<String> abilities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ManagedPlayer() when $default != null:
return $default(_that.id,_that.userId,_that.shirtNumber,_that.name,_that.position,_that.isGuest,_that.isInjured,_that.isOnVacation,_that.fromTeam,_that.email,_that.avatarUrl,_that.isTrainer,_that.isCaptain,_that.inviteStatus,_that.pushStatus,_that.strength,_that.birthdate,_that.abilities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int? userId,  int? shirtNumber,  String name,  String? position,  bool isGuest,  bool isInjured,  bool isOnVacation,  String? fromTeam,  String? email,  String? avatarUrl,  bool isTrainer,  bool isCaptain, @JsonKey(unknownEnumValue: InviteStatus.unknown)  InviteStatus inviteStatus, @JsonKey(unknownEnumValue: PushStatus.unknown)  PushStatus pushStatus,  int? strength,  String? birthdate,  List<String> abilities)  $default,) {final _that = this;
switch (_that) {
case _ManagedPlayer():
return $default(_that.id,_that.userId,_that.shirtNumber,_that.name,_that.position,_that.isGuest,_that.isInjured,_that.isOnVacation,_that.fromTeam,_that.email,_that.avatarUrl,_that.isTrainer,_that.isCaptain,_that.inviteStatus,_that.pushStatus,_that.strength,_that.birthdate,_that.abilities);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int? userId,  int? shirtNumber,  String name,  String? position,  bool isGuest,  bool isInjured,  bool isOnVacation,  String? fromTeam,  String? email,  String? avatarUrl,  bool isTrainer,  bool isCaptain, @JsonKey(unknownEnumValue: InviteStatus.unknown)  InviteStatus inviteStatus, @JsonKey(unknownEnumValue: PushStatus.unknown)  PushStatus pushStatus,  int? strength,  String? birthdate,  List<String> abilities)?  $default,) {final _that = this;
switch (_that) {
case _ManagedPlayer() when $default != null:
return $default(_that.id,_that.userId,_that.shirtNumber,_that.name,_that.position,_that.isGuest,_that.isInjured,_that.isOnVacation,_that.fromTeam,_that.email,_that.avatarUrl,_that.isTrainer,_that.isCaptain,_that.inviteStatus,_that.pushStatus,_that.strength,_that.birthdate,_that.abilities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ManagedPlayer extends ManagedPlayer {
  const _ManagedPlayer({required this.id, this.userId, this.shirtNumber, this.name = '', this.position, this.isGuest = false, this.isInjured = false, this.isOnVacation = false, this.fromTeam, this.email, this.avatarUrl, this.isTrainer = false, this.isCaptain = false, @JsonKey(unknownEnumValue: InviteStatus.unknown) this.inviteStatus = InviteStatus.none, @JsonKey(unknownEnumValue: PushStatus.unknown) this.pushStatus = PushStatus.na, this.strength, this.birthdate, final  List<String> abilities = const <String>[]}): _abilities = abilities,super._();
  factory _ManagedPlayer.fromJson(Map<String, dynamic> json) => _$ManagedPlayerFromJson(json);

@override final  int id;
@override final  int? userId;
@override final  int? shirtNumber;
@override@JsonKey() final  String name;
@override final  String? position;
@override@JsonKey() final  bool isGuest;
@override@JsonKey() final  bool isInjured;
@override@JsonKey() final  bool isOnVacation;
@override final  String? fromTeam;
@override final  String? email;
@override final  String? avatarUrl;
@override@JsonKey() final  bool isTrainer;
@override@JsonKey() final  bool isCaptain;
@override@JsonKey(unknownEnumValue: InviteStatus.unknown) final  InviteStatus inviteStatus;
@override@JsonKey(unknownEnumValue: PushStatus.unknown) final  PushStatus pushStatus;
@override final  int? strength;
/// `YYYY-MM-DD`, of `null`.
@override final  String? birthdate;
 final  List<String> _abilities;
@override@JsonKey() List<String> get abilities {
  if (_abilities is EqualUnmodifiableListView) return _abilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_abilities);
}


/// Create a copy of ManagedPlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManagedPlayerCopyWith<_ManagedPlayer> get copyWith => __$ManagedPlayerCopyWithImpl<_ManagedPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ManagedPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManagedPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.name, name) || other.name == name)&&(identical(other.position, position) || other.position == position)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest)&&(identical(other.isInjured, isInjured) || other.isInjured == isInjured)&&(identical(other.isOnVacation, isOnVacation) || other.isOnVacation == isOnVacation)&&(identical(other.fromTeam, fromTeam) || other.fromTeam == fromTeam)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isTrainer, isTrainer) || other.isTrainer == isTrainer)&&(identical(other.isCaptain, isCaptain) || other.isCaptain == isCaptain)&&(identical(other.inviteStatus, inviteStatus) || other.inviteStatus == inviteStatus)&&(identical(other.pushStatus, pushStatus) || other.pushStatus == pushStatus)&&(identical(other.strength, strength) || other.strength == strength)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&const DeepCollectionEquality().equals(other._abilities, _abilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,shirtNumber,name,position,isGuest,isInjured,isOnVacation,fromTeam,email,avatarUrl,isTrainer,isCaptain,inviteStatus,pushStatus,strength,birthdate,const DeepCollectionEquality().hash(_abilities));

@override
String toString() {
  return 'ManagedPlayer(id: $id, userId: $userId, shirtNumber: $shirtNumber, name: $name, position: $position, isGuest: $isGuest, isInjured: $isInjured, isOnVacation: $isOnVacation, fromTeam: $fromTeam, email: $email, avatarUrl: $avatarUrl, isTrainer: $isTrainer, isCaptain: $isCaptain, inviteStatus: $inviteStatus, pushStatus: $pushStatus, strength: $strength, birthdate: $birthdate, abilities: $abilities)';
}


}

/// @nodoc
abstract mixin class _$ManagedPlayerCopyWith<$Res> implements $ManagedPlayerCopyWith<$Res> {
  factory _$ManagedPlayerCopyWith(_ManagedPlayer value, $Res Function(_ManagedPlayer) _then) = __$ManagedPlayerCopyWithImpl;
@override @useResult
$Res call({
 int id, int? userId, int? shirtNumber, String name, String? position, bool isGuest, bool isInjured, bool isOnVacation, String? fromTeam, String? email, String? avatarUrl, bool isTrainer, bool isCaptain,@JsonKey(unknownEnumValue: InviteStatus.unknown) InviteStatus inviteStatus,@JsonKey(unknownEnumValue: PushStatus.unknown) PushStatus pushStatus, int? strength, String? birthdate, List<String> abilities
});




}
/// @nodoc
class __$ManagedPlayerCopyWithImpl<$Res>
    implements _$ManagedPlayerCopyWith<$Res> {
  __$ManagedPlayerCopyWithImpl(this._self, this._then);

  final _ManagedPlayer _self;
  final $Res Function(_ManagedPlayer) _then;

/// Create a copy of ManagedPlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = freezed,Object? shirtNumber = freezed,Object? name = null,Object? position = freezed,Object? isGuest = null,Object? isInjured = null,Object? isOnVacation = null,Object? fromTeam = freezed,Object? email = freezed,Object? avatarUrl = freezed,Object? isTrainer = null,Object? isCaptain = null,Object? inviteStatus = null,Object? pushStatus = null,Object? strength = freezed,Object? birthdate = freezed,Object? abilities = null,}) {
  return _then(_ManagedPlayer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int?,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,isInjured: null == isInjured ? _self.isInjured : isInjured // ignore: cast_nullable_to_non_nullable
as bool,isOnVacation: null == isOnVacation ? _self.isOnVacation : isOnVacation // ignore: cast_nullable_to_non_nullable
as bool,fromTeam: freezed == fromTeam ? _self.fromTeam : fromTeam // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isTrainer: null == isTrainer ? _self.isTrainer : isTrainer // ignore: cast_nullable_to_non_nullable
as bool,isCaptain: null == isCaptain ? _self.isCaptain : isCaptain // ignore: cast_nullable_to_non_nullable
as bool,inviteStatus: null == inviteStatus ? _self.inviteStatus : inviteStatus // ignore: cast_nullable_to_non_nullable
as InviteStatus,pushStatus: null == pushStatus ? _self.pushStatus : pushStatus // ignore: cast_nullable_to_non_nullable
as PushStatus,strength: freezed == strength ? _self.strength : strength // ignore: cast_nullable_to_non_nullable
as int?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as String?,abilities: null == abilities ? _self._abilities : abilities // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ManagedTrainer {

 int get id; String get name; String? get email; String? get avatarUrl; bool get isSelf;@JsonKey(unknownEnumValue: PushStatus.unknown) PushStatus get pushStatus;
/// Create a copy of ManagedTrainer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManagedTrainerCopyWith<ManagedTrainer> get copyWith => _$ManagedTrainerCopyWithImpl<ManagedTrainer>(this as ManagedTrainer, _$identity);

  /// Serializes this ManagedTrainer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManagedTrainer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isSelf, isSelf) || other.isSelf == isSelf)&&(identical(other.pushStatus, pushStatus) || other.pushStatus == pushStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,avatarUrl,isSelf,pushStatus);

@override
String toString() {
  return 'ManagedTrainer(id: $id, name: $name, email: $email, avatarUrl: $avatarUrl, isSelf: $isSelf, pushStatus: $pushStatus)';
}


}

/// @nodoc
abstract mixin class $ManagedTrainerCopyWith<$Res>  {
  factory $ManagedTrainerCopyWith(ManagedTrainer value, $Res Function(ManagedTrainer) _then) = _$ManagedTrainerCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? email, String? avatarUrl, bool isSelf,@JsonKey(unknownEnumValue: PushStatus.unknown) PushStatus pushStatus
});




}
/// @nodoc
class _$ManagedTrainerCopyWithImpl<$Res>
    implements $ManagedTrainerCopyWith<$Res> {
  _$ManagedTrainerCopyWithImpl(this._self, this._then);

  final ManagedTrainer _self;
  final $Res Function(ManagedTrainer) _then;

/// Create a copy of ManagedTrainer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = freezed,Object? avatarUrl = freezed,Object? isSelf = null,Object? pushStatus = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isSelf: null == isSelf ? _self.isSelf : isSelf // ignore: cast_nullable_to_non_nullable
as bool,pushStatus: null == pushStatus ? _self.pushStatus : pushStatus // ignore: cast_nullable_to_non_nullable
as PushStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [ManagedTrainer].
extension ManagedTrainerPatterns on ManagedTrainer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ManagedTrainer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ManagedTrainer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ManagedTrainer value)  $default,){
final _that = this;
switch (_that) {
case _ManagedTrainer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ManagedTrainer value)?  $default,){
final _that = this;
switch (_that) {
case _ManagedTrainer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? email,  String? avatarUrl,  bool isSelf, @JsonKey(unknownEnumValue: PushStatus.unknown)  PushStatus pushStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ManagedTrainer() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.avatarUrl,_that.isSelf,_that.pushStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? email,  String? avatarUrl,  bool isSelf, @JsonKey(unknownEnumValue: PushStatus.unknown)  PushStatus pushStatus)  $default,) {final _that = this;
switch (_that) {
case _ManagedTrainer():
return $default(_that.id,_that.name,_that.email,_that.avatarUrl,_that.isSelf,_that.pushStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? email,  String? avatarUrl,  bool isSelf, @JsonKey(unknownEnumValue: PushStatus.unknown)  PushStatus pushStatus)?  $default,) {final _that = this;
switch (_that) {
case _ManagedTrainer() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.avatarUrl,_that.isSelf,_that.pushStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ManagedTrainer implements ManagedTrainer {
  const _ManagedTrainer({required this.id, this.name = '', this.email, this.avatarUrl, this.isSelf = false, @JsonKey(unknownEnumValue: PushStatus.unknown) this.pushStatus = PushStatus.none});
  factory _ManagedTrainer.fromJson(Map<String, dynamic> json) => _$ManagedTrainerFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  String? email;
@override final  String? avatarUrl;
@override@JsonKey() final  bool isSelf;
@override@JsonKey(unknownEnumValue: PushStatus.unknown) final  PushStatus pushStatus;

/// Create a copy of ManagedTrainer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManagedTrainerCopyWith<_ManagedTrainer> get copyWith => __$ManagedTrainerCopyWithImpl<_ManagedTrainer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ManagedTrainerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManagedTrainer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.isSelf, isSelf) || other.isSelf == isSelf)&&(identical(other.pushStatus, pushStatus) || other.pushStatus == pushStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,avatarUrl,isSelf,pushStatus);

@override
String toString() {
  return 'ManagedTrainer(id: $id, name: $name, email: $email, avatarUrl: $avatarUrl, isSelf: $isSelf, pushStatus: $pushStatus)';
}


}

/// @nodoc
abstract mixin class _$ManagedTrainerCopyWith<$Res> implements $ManagedTrainerCopyWith<$Res> {
  factory _$ManagedTrainerCopyWith(_ManagedTrainer value, $Res Function(_ManagedTrainer) _then) = __$ManagedTrainerCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? email, String? avatarUrl, bool isSelf,@JsonKey(unknownEnumValue: PushStatus.unknown) PushStatus pushStatus
});




}
/// @nodoc
class __$ManagedTrainerCopyWithImpl<$Res>
    implements _$ManagedTrainerCopyWith<$Res> {
  __$ManagedTrainerCopyWithImpl(this._self, this._then);

  final _ManagedTrainer _self;
  final $Res Function(_ManagedTrainer) _then;

/// Create a copy of ManagedTrainer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = freezed,Object? avatarUrl = freezed,Object? isSelf = null,Object? pushStatus = null,}) {
  return _then(_ManagedTrainer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,isSelf: null == isSelf ? _self.isSelf : isSelf // ignore: cast_nullable_to_non_nullable
as bool,pushStatus: null == pushStatus ? _self.pushStatus : pushStatus // ignore: cast_nullable_to_non_nullable
as PushStatus,
  ));
}


}


/// @nodoc
mixin _$ManagedSpectator {

 int get id; String get name; String? get email; String? get avatarUrl;@JsonKey(unknownEnumValue: InviteStatus.unknown) InviteStatus get inviteStatus;
/// Create a copy of ManagedSpectator
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ManagedSpectatorCopyWith<ManagedSpectator> get copyWith => _$ManagedSpectatorCopyWithImpl<ManagedSpectator>(this as ManagedSpectator, _$identity);

  /// Serializes this ManagedSpectator to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ManagedSpectator&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.inviteStatus, inviteStatus) || other.inviteStatus == inviteStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,avatarUrl,inviteStatus);

@override
String toString() {
  return 'ManagedSpectator(id: $id, name: $name, email: $email, avatarUrl: $avatarUrl, inviteStatus: $inviteStatus)';
}


}

/// @nodoc
abstract mixin class $ManagedSpectatorCopyWith<$Res>  {
  factory $ManagedSpectatorCopyWith(ManagedSpectator value, $Res Function(ManagedSpectator) _then) = _$ManagedSpectatorCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? email, String? avatarUrl,@JsonKey(unknownEnumValue: InviteStatus.unknown) InviteStatus inviteStatus
});




}
/// @nodoc
class _$ManagedSpectatorCopyWithImpl<$Res>
    implements $ManagedSpectatorCopyWith<$Res> {
  _$ManagedSpectatorCopyWithImpl(this._self, this._then);

  final ManagedSpectator _self;
  final $Res Function(ManagedSpectator) _then;

/// Create a copy of ManagedSpectator
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = freezed,Object? avatarUrl = freezed,Object? inviteStatus = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,inviteStatus: null == inviteStatus ? _self.inviteStatus : inviteStatus // ignore: cast_nullable_to_non_nullable
as InviteStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [ManagedSpectator].
extension ManagedSpectatorPatterns on ManagedSpectator {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ManagedSpectator value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ManagedSpectator() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ManagedSpectator value)  $default,){
final _that = this;
switch (_that) {
case _ManagedSpectator():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ManagedSpectator value)?  $default,){
final _that = this;
switch (_that) {
case _ManagedSpectator() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? email,  String? avatarUrl, @JsonKey(unknownEnumValue: InviteStatus.unknown)  InviteStatus inviteStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ManagedSpectator() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.avatarUrl,_that.inviteStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? email,  String? avatarUrl, @JsonKey(unknownEnumValue: InviteStatus.unknown)  InviteStatus inviteStatus)  $default,) {final _that = this;
switch (_that) {
case _ManagedSpectator():
return $default(_that.id,_that.name,_that.email,_that.avatarUrl,_that.inviteStatus);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? email,  String? avatarUrl, @JsonKey(unknownEnumValue: InviteStatus.unknown)  InviteStatus inviteStatus)?  $default,) {final _that = this;
switch (_that) {
case _ManagedSpectator() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.avatarUrl,_that.inviteStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ManagedSpectator implements ManagedSpectator {
  const _ManagedSpectator({required this.id, this.name = '', this.email, this.avatarUrl, @JsonKey(unknownEnumValue: InviteStatus.unknown) this.inviteStatus = InviteStatus.pending});
  factory _ManagedSpectator.fromJson(Map<String, dynamic> json) => _$ManagedSpectatorFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  String? email;
@override final  String? avatarUrl;
@override@JsonKey(unknownEnumValue: InviteStatus.unknown) final  InviteStatus inviteStatus;

/// Create a copy of ManagedSpectator
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ManagedSpectatorCopyWith<_ManagedSpectator> get copyWith => __$ManagedSpectatorCopyWithImpl<_ManagedSpectator>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ManagedSpectatorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ManagedSpectator&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.inviteStatus, inviteStatus) || other.inviteStatus == inviteStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,avatarUrl,inviteStatus);

@override
String toString() {
  return 'ManagedSpectator(id: $id, name: $name, email: $email, avatarUrl: $avatarUrl, inviteStatus: $inviteStatus)';
}


}

/// @nodoc
abstract mixin class _$ManagedSpectatorCopyWith<$Res> implements $ManagedSpectatorCopyWith<$Res> {
  factory _$ManagedSpectatorCopyWith(_ManagedSpectator value, $Res Function(_ManagedSpectator) _then) = __$ManagedSpectatorCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? email, String? avatarUrl,@JsonKey(unknownEnumValue: InviteStatus.unknown) InviteStatus inviteStatus
});




}
/// @nodoc
class __$ManagedSpectatorCopyWithImpl<$Res>
    implements _$ManagedSpectatorCopyWith<$Res> {
  __$ManagedSpectatorCopyWithImpl(this._self, this._then);

  final _ManagedSpectator _self;
  final $Res Function(_ManagedSpectator) _then;

/// Create a copy of ManagedSpectator
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = freezed,Object? avatarUrl = freezed,Object? inviteStatus = null,}) {
  return _then(_ManagedSpectator(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,inviteStatus: null == inviteStatus ? _self.inviteStatus : inviteStatus // ignore: cast_nullable_to_non_nullable
as InviteStatus,
  ));
}


}


/// @nodoc
mixin _$TeamLink {

 String get url; DateTime? get expiresAt;
/// Create a copy of TeamLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamLinkCopyWith<TeamLink> get copyWith => _$TeamLinkCopyWithImpl<TeamLink>(this as TeamLink, _$identity);

  /// Serializes this TeamLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamLink&&(identical(other.url, url) || other.url == url)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,expiresAt);

@override
String toString() {
  return 'TeamLink(url: $url, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $TeamLinkCopyWith<$Res>  {
  factory $TeamLinkCopyWith(TeamLink value, $Res Function(TeamLink) _then) = _$TeamLinkCopyWithImpl;
@useResult
$Res call({
 String url, DateTime? expiresAt
});




}
/// @nodoc
class _$TeamLinkCopyWithImpl<$Res>
    implements $TeamLinkCopyWith<$Res> {
  _$TeamLinkCopyWithImpl(this._self, this._then);

  final TeamLink _self;
  final $Res Function(TeamLink) _then;

/// Create a copy of TeamLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamLink].
extension TeamLinkPatterns on TeamLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamLink value)  $default,){
final _that = this;
switch (_that) {
case _TeamLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamLink value)?  $default,){
final _that = this;
switch (_that) {
case _TeamLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String url,  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamLink() when $default != null:
return $default(_that.url,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String url,  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _TeamLink():
return $default(_that.url,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String url,  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _TeamLink() when $default != null:
return $default(_that.url,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamLink implements TeamLink {
  const _TeamLink({required this.url, this.expiresAt});
  factory _TeamLink.fromJson(Map<String, dynamic> json) => _$TeamLinkFromJson(json);

@override final  String url;
@override final  DateTime? expiresAt;

/// Create a copy of TeamLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamLinkCopyWith<_TeamLink> get copyWith => __$TeamLinkCopyWithImpl<_TeamLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamLinkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamLink&&(identical(other.url, url) || other.url == url)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,expiresAt);

@override
String toString() {
  return 'TeamLink(url: $url, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$TeamLinkCopyWith<$Res> implements $TeamLinkCopyWith<$Res> {
  factory _$TeamLinkCopyWith(_TeamLink value, $Res Function(_TeamLink) _then) = __$TeamLinkCopyWithImpl;
@override @useResult
$Res call({
 String url, DateTime? expiresAt
});




}
/// @nodoc
class __$TeamLinkCopyWithImpl<$Res>
    implements _$TeamLinkCopyWith<$Res> {
  __$TeamLinkCopyWithImpl(this._self, this._then);

  final _TeamLink _self;
  final $Res Function(_TeamLink) _then;

/// Create a copy of TeamLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? expiresAt = freezed,}) {
  return _then(_TeamLink(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PlayerManagement {

 List<ManagedPlayer> get players; List<ManagedTrainer> get trainers; List<ManagedSpectator> get spectators; TeamLink? get teamLink;@JsonKey(unknownEnumValue: TeamLinkState.unknown) TeamLinkState get teamLinkState;
/// Create a copy of PlayerManagement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerManagementCopyWith<PlayerManagement> get copyWith => _$PlayerManagementCopyWithImpl<PlayerManagement>(this as PlayerManagement, _$identity);

  /// Serializes this PlayerManagement to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerManagement&&const DeepCollectionEquality().equals(other.players, players)&&const DeepCollectionEquality().equals(other.trainers, trainers)&&const DeepCollectionEquality().equals(other.spectators, spectators)&&(identical(other.teamLink, teamLink) || other.teamLink == teamLink)&&(identical(other.teamLinkState, teamLinkState) || other.teamLinkState == teamLinkState));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(players),const DeepCollectionEquality().hash(trainers),const DeepCollectionEquality().hash(spectators),teamLink,teamLinkState);

@override
String toString() {
  return 'PlayerManagement(players: $players, trainers: $trainers, spectators: $spectators, teamLink: $teamLink, teamLinkState: $teamLinkState)';
}


}

/// @nodoc
abstract mixin class $PlayerManagementCopyWith<$Res>  {
  factory $PlayerManagementCopyWith(PlayerManagement value, $Res Function(PlayerManagement) _then) = _$PlayerManagementCopyWithImpl;
@useResult
$Res call({
 List<ManagedPlayer> players, List<ManagedTrainer> trainers, List<ManagedSpectator> spectators, TeamLink? teamLink,@JsonKey(unknownEnumValue: TeamLinkState.unknown) TeamLinkState teamLinkState
});


$TeamLinkCopyWith<$Res>? get teamLink;

}
/// @nodoc
class _$PlayerManagementCopyWithImpl<$Res>
    implements $PlayerManagementCopyWith<$Res> {
  _$PlayerManagementCopyWithImpl(this._self, this._then);

  final PlayerManagement _self;
  final $Res Function(PlayerManagement) _then;

/// Create a copy of PlayerManagement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? players = null,Object? trainers = null,Object? spectators = null,Object? teamLink = freezed,Object? teamLinkState = null,}) {
  return _then(_self.copyWith(
players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<ManagedPlayer>,trainers: null == trainers ? _self.trainers : trainers // ignore: cast_nullable_to_non_nullable
as List<ManagedTrainer>,spectators: null == spectators ? _self.spectators : spectators // ignore: cast_nullable_to_non_nullable
as List<ManagedSpectator>,teamLink: freezed == teamLink ? _self.teamLink : teamLink // ignore: cast_nullable_to_non_nullable
as TeamLink?,teamLinkState: null == teamLinkState ? _self.teamLinkState : teamLinkState // ignore: cast_nullable_to_non_nullable
as TeamLinkState,
  ));
}
/// Create a copy of PlayerManagement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamLinkCopyWith<$Res>? get teamLink {
    if (_self.teamLink == null) {
    return null;
  }

  return $TeamLinkCopyWith<$Res>(_self.teamLink!, (value) {
    return _then(_self.copyWith(teamLink: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlayerManagement].
extension PlayerManagementPatterns on PlayerManagement {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerManagement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerManagement() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerManagement value)  $default,){
final _that = this;
switch (_that) {
case _PlayerManagement():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerManagement value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerManagement() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ManagedPlayer> players,  List<ManagedTrainer> trainers,  List<ManagedSpectator> spectators,  TeamLink? teamLink, @JsonKey(unknownEnumValue: TeamLinkState.unknown)  TeamLinkState teamLinkState)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerManagement() when $default != null:
return $default(_that.players,_that.trainers,_that.spectators,_that.teamLink,_that.teamLinkState);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ManagedPlayer> players,  List<ManagedTrainer> trainers,  List<ManagedSpectator> spectators,  TeamLink? teamLink, @JsonKey(unknownEnumValue: TeamLinkState.unknown)  TeamLinkState teamLinkState)  $default,) {final _that = this;
switch (_that) {
case _PlayerManagement():
return $default(_that.players,_that.trainers,_that.spectators,_that.teamLink,_that.teamLinkState);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ManagedPlayer> players,  List<ManagedTrainer> trainers,  List<ManagedSpectator> spectators,  TeamLink? teamLink, @JsonKey(unknownEnumValue: TeamLinkState.unknown)  TeamLinkState teamLinkState)?  $default,) {final _that = this;
switch (_that) {
case _PlayerManagement() when $default != null:
return $default(_that.players,_that.trainers,_that.spectators,_that.teamLink,_that.teamLinkState);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerManagement implements PlayerManagement {
  const _PlayerManagement({final  List<ManagedPlayer> players = const <ManagedPlayer>[], final  List<ManagedTrainer> trainers = const <ManagedTrainer>[], final  List<ManagedSpectator> spectators = const <ManagedSpectator>[], this.teamLink, @JsonKey(unknownEnumValue: TeamLinkState.unknown) this.teamLinkState = TeamLinkState.active}): _players = players,_trainers = trainers,_spectators = spectators;
  factory _PlayerManagement.fromJson(Map<String, dynamic> json) => _$PlayerManagementFromJson(json);

 final  List<ManagedPlayer> _players;
@override@JsonKey() List<ManagedPlayer> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}

 final  List<ManagedTrainer> _trainers;
@override@JsonKey() List<ManagedTrainer> get trainers {
  if (_trainers is EqualUnmodifiableListView) return _trainers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trainers);
}

 final  List<ManagedSpectator> _spectators;
@override@JsonKey() List<ManagedSpectator> get spectators {
  if (_spectators is EqualUnmodifiableListView) return _spectators;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_spectators);
}

@override final  TeamLink? teamLink;
@override@JsonKey(unknownEnumValue: TeamLinkState.unknown) final  TeamLinkState teamLinkState;

/// Create a copy of PlayerManagement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerManagementCopyWith<_PlayerManagement> get copyWith => __$PlayerManagementCopyWithImpl<_PlayerManagement>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerManagementToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerManagement&&const DeepCollectionEquality().equals(other._players, _players)&&const DeepCollectionEquality().equals(other._trainers, _trainers)&&const DeepCollectionEquality().equals(other._spectators, _spectators)&&(identical(other.teamLink, teamLink) || other.teamLink == teamLink)&&(identical(other.teamLinkState, teamLinkState) || other.teamLinkState == teamLinkState));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_players),const DeepCollectionEquality().hash(_trainers),const DeepCollectionEquality().hash(_spectators),teamLink,teamLinkState);

@override
String toString() {
  return 'PlayerManagement(players: $players, trainers: $trainers, spectators: $spectators, teamLink: $teamLink, teamLinkState: $teamLinkState)';
}


}

/// @nodoc
abstract mixin class _$PlayerManagementCopyWith<$Res> implements $PlayerManagementCopyWith<$Res> {
  factory _$PlayerManagementCopyWith(_PlayerManagement value, $Res Function(_PlayerManagement) _then) = __$PlayerManagementCopyWithImpl;
@override @useResult
$Res call({
 List<ManagedPlayer> players, List<ManagedTrainer> trainers, List<ManagedSpectator> spectators, TeamLink? teamLink,@JsonKey(unknownEnumValue: TeamLinkState.unknown) TeamLinkState teamLinkState
});


@override $TeamLinkCopyWith<$Res>? get teamLink;

}
/// @nodoc
class __$PlayerManagementCopyWithImpl<$Res>
    implements _$PlayerManagementCopyWith<$Res> {
  __$PlayerManagementCopyWithImpl(this._self, this._then);

  final _PlayerManagement _self;
  final $Res Function(_PlayerManagement) _then;

/// Create a copy of PlayerManagement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? players = null,Object? trainers = null,Object? spectators = null,Object? teamLink = freezed,Object? teamLinkState = null,}) {
  return _then(_PlayerManagement(
players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<ManagedPlayer>,trainers: null == trainers ? _self._trainers : trainers // ignore: cast_nullable_to_non_nullable
as List<ManagedTrainer>,spectators: null == spectators ? _self._spectators : spectators // ignore: cast_nullable_to_non_nullable
as List<ManagedSpectator>,teamLink: freezed == teamLink ? _self.teamLink : teamLink // ignore: cast_nullable_to_non_nullable
as TeamLink?,teamLinkState: null == teamLinkState ? _self.teamLinkState : teamLinkState // ignore: cast_nullable_to_non_nullable
as TeamLinkState,
  ));
}

/// Create a copy of PlayerManagement
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamLinkCopyWith<$Res>? get teamLink {
    if (_self.teamLink == null) {
    return null;
  }

  return $TeamLinkCopyWith<$Res>(_self.teamLink!, (value) {
    return _then(_self.copyWith(teamLink: value));
  });
}
}


/// @nodoc
mixin _$TeamLinkJoin {

 int get id; String get name; String? get avatarUrl;/// `player` of `spectator`.
 String get role; DateTime? get joinedAt;
/// Create a copy of TeamLinkJoin
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamLinkJoinCopyWith<TeamLinkJoin> get copyWith => _$TeamLinkJoinCopyWithImpl<TeamLinkJoin>(this as TeamLinkJoin, _$identity);

  /// Serializes this TeamLinkJoin to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamLinkJoin&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.role, role) || other.role == role)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl,role,joinedAt);

@override
String toString() {
  return 'TeamLinkJoin(id: $id, name: $name, avatarUrl: $avatarUrl, role: $role, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class $TeamLinkJoinCopyWith<$Res>  {
  factory $TeamLinkJoinCopyWith(TeamLinkJoin value, $Res Function(TeamLinkJoin) _then) = _$TeamLinkJoinCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? avatarUrl, String role, DateTime? joinedAt
});




}
/// @nodoc
class _$TeamLinkJoinCopyWithImpl<$Res>
    implements $TeamLinkJoinCopyWith<$Res> {
  _$TeamLinkJoinCopyWithImpl(this._self, this._then);

  final TeamLinkJoin _self;
  final $Res Function(TeamLinkJoin) _then;

/// Create a copy of TeamLinkJoin
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,Object? role = null,Object? joinedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamLinkJoin].
extension TeamLinkJoinPatterns on TeamLinkJoin {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamLinkJoin value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamLinkJoin() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamLinkJoin value)  $default,){
final _that = this;
switch (_that) {
case _TeamLinkJoin():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamLinkJoin value)?  $default,){
final _that = this;
switch (_that) {
case _TeamLinkJoin() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? avatarUrl,  String role,  DateTime? joinedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamLinkJoin() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl,_that.role,_that.joinedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? avatarUrl,  String role,  DateTime? joinedAt)  $default,) {final _that = this;
switch (_that) {
case _TeamLinkJoin():
return $default(_that.id,_that.name,_that.avatarUrl,_that.role,_that.joinedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? avatarUrl,  String role,  DateTime? joinedAt)?  $default,) {final _that = this;
switch (_that) {
case _TeamLinkJoin() when $default != null:
return $default(_that.id,_that.name,_that.avatarUrl,_that.role,_that.joinedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamLinkJoin extends TeamLinkJoin {
  const _TeamLinkJoin({required this.id, this.name = '', this.avatarUrl, this.role = 'player', this.joinedAt}): super._();
  factory _TeamLinkJoin.fromJson(Map<String, dynamic> json) => _$TeamLinkJoinFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  String? avatarUrl;
/// `player` of `spectator`.
@override@JsonKey() final  String role;
@override final  DateTime? joinedAt;

/// Create a copy of TeamLinkJoin
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamLinkJoinCopyWith<_TeamLinkJoin> get copyWith => __$TeamLinkJoinCopyWithImpl<_TeamLinkJoin>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamLinkJoinToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamLinkJoin&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.role, role) || other.role == role)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,avatarUrl,role,joinedAt);

@override
String toString() {
  return 'TeamLinkJoin(id: $id, name: $name, avatarUrl: $avatarUrl, role: $role, joinedAt: $joinedAt)';
}


}

/// @nodoc
abstract mixin class _$TeamLinkJoinCopyWith<$Res> implements $TeamLinkJoinCopyWith<$Res> {
  factory _$TeamLinkJoinCopyWith(_TeamLinkJoin value, $Res Function(_TeamLinkJoin) _then) = __$TeamLinkJoinCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? avatarUrl, String role, DateTime? joinedAt
});




}
/// @nodoc
class __$TeamLinkJoinCopyWithImpl<$Res>
    implements _$TeamLinkJoinCopyWith<$Res> {
  __$TeamLinkJoinCopyWithImpl(this._self, this._then);

  final _TeamLinkJoin _self;
  final $Res Function(_TeamLinkJoin) _then;

/// Create a copy of TeamLinkJoin
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? avatarUrl = freezed,Object? role = null,Object? joinedAt = freezed,}) {
  return _then(_TeamLinkJoin(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$TeamLinkOverview {

 TeamLink? get link;@JsonKey(unknownEnumValue: TeamLinkState.unknown) TeamLinkState get linkState; int get expiresDays; List<TeamLinkJoin> get joined;
/// Create a copy of TeamLinkOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamLinkOverviewCopyWith<TeamLinkOverview> get copyWith => _$TeamLinkOverviewCopyWithImpl<TeamLinkOverview>(this as TeamLinkOverview, _$identity);

  /// Serializes this TeamLinkOverview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamLinkOverview&&(identical(other.link, link) || other.link == link)&&(identical(other.linkState, linkState) || other.linkState == linkState)&&(identical(other.expiresDays, expiresDays) || other.expiresDays == expiresDays)&&const DeepCollectionEquality().equals(other.joined, joined));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,link,linkState,expiresDays,const DeepCollectionEquality().hash(joined));

@override
String toString() {
  return 'TeamLinkOverview(link: $link, linkState: $linkState, expiresDays: $expiresDays, joined: $joined)';
}


}

/// @nodoc
abstract mixin class $TeamLinkOverviewCopyWith<$Res>  {
  factory $TeamLinkOverviewCopyWith(TeamLinkOverview value, $Res Function(TeamLinkOverview) _then) = _$TeamLinkOverviewCopyWithImpl;
@useResult
$Res call({
 TeamLink? link,@JsonKey(unknownEnumValue: TeamLinkState.unknown) TeamLinkState linkState, int expiresDays, List<TeamLinkJoin> joined
});


$TeamLinkCopyWith<$Res>? get link;

}
/// @nodoc
class _$TeamLinkOverviewCopyWithImpl<$Res>
    implements $TeamLinkOverviewCopyWith<$Res> {
  _$TeamLinkOverviewCopyWithImpl(this._self, this._then);

  final TeamLinkOverview _self;
  final $Res Function(TeamLinkOverview) _then;

/// Create a copy of TeamLinkOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? link = freezed,Object? linkState = null,Object? expiresDays = null,Object? joined = null,}) {
  return _then(_self.copyWith(
link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as TeamLink?,linkState: null == linkState ? _self.linkState : linkState // ignore: cast_nullable_to_non_nullable
as TeamLinkState,expiresDays: null == expiresDays ? _self.expiresDays : expiresDays // ignore: cast_nullable_to_non_nullable
as int,joined: null == joined ? _self.joined : joined // ignore: cast_nullable_to_non_nullable
as List<TeamLinkJoin>,
  ));
}
/// Create a copy of TeamLinkOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamLinkCopyWith<$Res>? get link {
    if (_self.link == null) {
    return null;
  }

  return $TeamLinkCopyWith<$Res>(_self.link!, (value) {
    return _then(_self.copyWith(link: value));
  });
}
}


/// Adds pattern-matching-related methods to [TeamLinkOverview].
extension TeamLinkOverviewPatterns on TeamLinkOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamLinkOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamLinkOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamLinkOverview value)  $default,){
final _that = this;
switch (_that) {
case _TeamLinkOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamLinkOverview value)?  $default,){
final _that = this;
switch (_that) {
case _TeamLinkOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TeamLink? link, @JsonKey(unknownEnumValue: TeamLinkState.unknown)  TeamLinkState linkState,  int expiresDays,  List<TeamLinkJoin> joined)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamLinkOverview() when $default != null:
return $default(_that.link,_that.linkState,_that.expiresDays,_that.joined);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TeamLink? link, @JsonKey(unknownEnumValue: TeamLinkState.unknown)  TeamLinkState linkState,  int expiresDays,  List<TeamLinkJoin> joined)  $default,) {final _that = this;
switch (_that) {
case _TeamLinkOverview():
return $default(_that.link,_that.linkState,_that.expiresDays,_that.joined);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TeamLink? link, @JsonKey(unknownEnumValue: TeamLinkState.unknown)  TeamLinkState linkState,  int expiresDays,  List<TeamLinkJoin> joined)?  $default,) {final _that = this;
switch (_that) {
case _TeamLinkOverview() when $default != null:
return $default(_that.link,_that.linkState,_that.expiresDays,_that.joined);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamLinkOverview implements TeamLinkOverview {
  const _TeamLinkOverview({this.link, @JsonKey(unknownEnumValue: TeamLinkState.unknown) this.linkState = TeamLinkState.active, this.expiresDays = 90, final  List<TeamLinkJoin> joined = const <TeamLinkJoin>[]}): _joined = joined;
  factory _TeamLinkOverview.fromJson(Map<String, dynamic> json) => _$TeamLinkOverviewFromJson(json);

@override final  TeamLink? link;
@override@JsonKey(unknownEnumValue: TeamLinkState.unknown) final  TeamLinkState linkState;
@override@JsonKey() final  int expiresDays;
 final  List<TeamLinkJoin> _joined;
@override@JsonKey() List<TeamLinkJoin> get joined {
  if (_joined is EqualUnmodifiableListView) return _joined;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_joined);
}


/// Create a copy of TeamLinkOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamLinkOverviewCopyWith<_TeamLinkOverview> get copyWith => __$TeamLinkOverviewCopyWithImpl<_TeamLinkOverview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamLinkOverviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamLinkOverview&&(identical(other.link, link) || other.link == link)&&(identical(other.linkState, linkState) || other.linkState == linkState)&&(identical(other.expiresDays, expiresDays) || other.expiresDays == expiresDays)&&const DeepCollectionEquality().equals(other._joined, _joined));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,link,linkState,expiresDays,const DeepCollectionEquality().hash(_joined));

@override
String toString() {
  return 'TeamLinkOverview(link: $link, linkState: $linkState, expiresDays: $expiresDays, joined: $joined)';
}


}

/// @nodoc
abstract mixin class _$TeamLinkOverviewCopyWith<$Res> implements $TeamLinkOverviewCopyWith<$Res> {
  factory _$TeamLinkOverviewCopyWith(_TeamLinkOverview value, $Res Function(_TeamLinkOverview) _then) = __$TeamLinkOverviewCopyWithImpl;
@override @useResult
$Res call({
 TeamLink? link,@JsonKey(unknownEnumValue: TeamLinkState.unknown) TeamLinkState linkState, int expiresDays, List<TeamLinkJoin> joined
});


@override $TeamLinkCopyWith<$Res>? get link;

}
/// @nodoc
class __$TeamLinkOverviewCopyWithImpl<$Res>
    implements _$TeamLinkOverviewCopyWith<$Res> {
  __$TeamLinkOverviewCopyWithImpl(this._self, this._then);

  final _TeamLinkOverview _self;
  final $Res Function(_TeamLinkOverview) _then;

/// Create a copy of TeamLinkOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? link = freezed,Object? linkState = null,Object? expiresDays = null,Object? joined = null,}) {
  return _then(_TeamLinkOverview(
link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as TeamLink?,linkState: null == linkState ? _self.linkState : linkState // ignore: cast_nullable_to_non_nullable
as TeamLinkState,expiresDays: null == expiresDays ? _self.expiresDays : expiresDays // ignore: cast_nullable_to_non_nullable
as int,joined: null == joined ? _self._joined : joined // ignore: cast_nullable_to_non_nullable
as List<TeamLinkJoin>,
  ));
}

/// Create a copy of TeamLinkOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeamLinkCopyWith<$Res>? get link {
    if (_self.link == null) {
    return null;
  }

  return $TeamLinkCopyWith<$Res>(_self.link!, (value) {
    return _then(_self.copyWith(link: value));
  });
}
}

// dart format on
