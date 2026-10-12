// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileAccount {

 int get id; String get name;/// Het bevestigde adres; `null` voor wie via de teamlink binnenkwam.
 String? get email;/// Geclaimd maar nog niet bevestigd (`EmailClaim`).
 String? get pendingEmail; String? get avatarUrl;/// Kale kalenderdag `YYYY-MM-DD` (de effectieve: die van je speler in dit
/// team, anders de jouwe).
 String? get birthdate;
/// Create a copy of ProfileAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileAccountCopyWith<ProfileAccount> get copyWith => _$ProfileAccountCopyWithImpl<ProfileAccount>(this as ProfileAccount, _$identity);

  /// Serializes this ProfileAccount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.pendingEmail, pendingEmail) || other.pendingEmail == pendingEmail)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,pendingEmail,avatarUrl,birthdate);

@override
String toString() {
  return 'ProfileAccount(id: $id, name: $name, email: $email, pendingEmail: $pendingEmail, avatarUrl: $avatarUrl, birthdate: $birthdate)';
}


}

/// @nodoc
abstract mixin class $ProfileAccountCopyWith<$Res>  {
  factory $ProfileAccountCopyWith(ProfileAccount value, $Res Function(ProfileAccount) _then) = _$ProfileAccountCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? email, String? pendingEmail, String? avatarUrl, String? birthdate
});




}
/// @nodoc
class _$ProfileAccountCopyWithImpl<$Res>
    implements $ProfileAccountCopyWith<$Res> {
  _$ProfileAccountCopyWithImpl(this._self, this._then);

  final ProfileAccount _self;
  final $Res Function(ProfileAccount) _then;

/// Create a copy of ProfileAccount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = freezed,Object? pendingEmail = freezed,Object? avatarUrl = freezed,Object? birthdate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,pendingEmail: freezed == pendingEmail ? _self.pendingEmail : pendingEmail // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileAccount].
extension ProfileAccountPatterns on ProfileAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileAccount value)  $default,){
final _that = this;
switch (_that) {
case _ProfileAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileAccount value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileAccount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? email,  String? pendingEmail,  String? avatarUrl,  String? birthdate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileAccount() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.pendingEmail,_that.avatarUrl,_that.birthdate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? email,  String? pendingEmail,  String? avatarUrl,  String? birthdate)  $default,) {final _that = this;
switch (_that) {
case _ProfileAccount():
return $default(_that.id,_that.name,_that.email,_that.pendingEmail,_that.avatarUrl,_that.birthdate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? email,  String? pendingEmail,  String? avatarUrl,  String? birthdate)?  $default,) {final _that = this;
switch (_that) {
case _ProfileAccount() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.pendingEmail,_that.avatarUrl,_that.birthdate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileAccount implements ProfileAccount {
  const _ProfileAccount({required this.id, this.name = '', this.email, this.pendingEmail, this.avatarUrl, this.birthdate});
  factory _ProfileAccount.fromJson(Map<String, dynamic> json) => _$ProfileAccountFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
/// Het bevestigde adres; `null` voor wie via de teamlink binnenkwam.
@override final  String? email;
/// Geclaimd maar nog niet bevestigd (`EmailClaim`).
@override final  String? pendingEmail;
@override final  String? avatarUrl;
/// Kale kalenderdag `YYYY-MM-DD` (de effectieve: die van je speler in dit
/// team, anders de jouwe).
@override final  String? birthdate;

/// Create a copy of ProfileAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileAccountCopyWith<_ProfileAccount> get copyWith => __$ProfileAccountCopyWithImpl<_ProfileAccount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileAccountToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileAccount&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.pendingEmail, pendingEmail) || other.pendingEmail == pendingEmail)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,pendingEmail,avatarUrl,birthdate);

@override
String toString() {
  return 'ProfileAccount(id: $id, name: $name, email: $email, pendingEmail: $pendingEmail, avatarUrl: $avatarUrl, birthdate: $birthdate)';
}


}

/// @nodoc
abstract mixin class _$ProfileAccountCopyWith<$Res> implements $ProfileAccountCopyWith<$Res> {
  factory _$ProfileAccountCopyWith(_ProfileAccount value, $Res Function(_ProfileAccount) _then) = __$ProfileAccountCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? email, String? pendingEmail, String? avatarUrl, String? birthdate
});




}
/// @nodoc
class __$ProfileAccountCopyWithImpl<$Res>
    implements _$ProfileAccountCopyWith<$Res> {
  __$ProfileAccountCopyWithImpl(this._self, this._then);

  final _ProfileAccount _self;
  final $Res Function(_ProfileAccount) _then;

/// Create a copy of ProfileAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = freezed,Object? pendingEmail = freezed,Object? avatarUrl = freezed,Object? birthdate = freezed,}) {
  return _then(_ProfileAccount(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,pendingEmail: freezed == pendingEmail ? _self.pendingEmail : pendingEmail // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$OwnPlayer {

 int get id; String get name; int? get shirtNumber;/// Positiecode uit het sportprofiel (`CM`, `ST`, …).
 String? get position; String? get birthdate; bool get isInjured;
/// Create a copy of OwnPlayer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnPlayerCopyWith<OwnPlayer> get copyWith => _$OwnPlayerCopyWithImpl<OwnPlayer>(this as OwnPlayer, _$identity);

  /// Serializes this OwnPlayer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.position, position) || other.position == position)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.isInjured, isInjured) || other.isInjured == isInjured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber,position,birthdate,isInjured);

@override
String toString() {
  return 'OwnPlayer(id: $id, name: $name, shirtNumber: $shirtNumber, position: $position, birthdate: $birthdate, isInjured: $isInjured)';
}


}

/// @nodoc
abstract mixin class $OwnPlayerCopyWith<$Res>  {
  factory $OwnPlayerCopyWith(OwnPlayer value, $Res Function(OwnPlayer) _then) = _$OwnPlayerCopyWithImpl;
@useResult
$Res call({
 int id, String name, int? shirtNumber, String? position, String? birthdate, bool isInjured
});




}
/// @nodoc
class _$OwnPlayerCopyWithImpl<$Res>
    implements $OwnPlayerCopyWith<$Res> {
  _$OwnPlayerCopyWithImpl(this._self, this._then);

  final OwnPlayer _self;
  final $Res Function(OwnPlayer) _then;

/// Create a copy of OwnPlayer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,Object? position = freezed,Object? birthdate = freezed,Object? isInjured = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as String?,isInjured: null == isInjured ? _self.isInjured : isInjured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [OwnPlayer].
extension OwnPlayerPatterns on OwnPlayer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnPlayer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnPlayer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnPlayer value)  $default,){
final _that = this;
switch (_that) {
case _OwnPlayer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnPlayer value)?  $default,){
final _that = this;
switch (_that) {
case _OwnPlayer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int? shirtNumber,  String? position,  String? birthdate,  bool isInjured)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnPlayer() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber,_that.position,_that.birthdate,_that.isInjured);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int? shirtNumber,  String? position,  String? birthdate,  bool isInjured)  $default,) {final _that = this;
switch (_that) {
case _OwnPlayer():
return $default(_that.id,_that.name,_that.shirtNumber,_that.position,_that.birthdate,_that.isInjured);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int? shirtNumber,  String? position,  String? birthdate,  bool isInjured)?  $default,) {final _that = this;
switch (_that) {
case _OwnPlayer() when $default != null:
return $default(_that.id,_that.name,_that.shirtNumber,_that.position,_that.birthdate,_that.isInjured);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OwnPlayer implements OwnPlayer {
  const _OwnPlayer({required this.id, this.name = '', this.shirtNumber, this.position, this.birthdate, this.isInjured = false});
  factory _OwnPlayer.fromJson(Map<String, dynamic> json) => _$OwnPlayerFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  int? shirtNumber;
/// Positiecode uit het sportprofiel (`CM`, `ST`, …).
@override final  String? position;
@override final  String? birthdate;
@override@JsonKey() final  bool isInjured;

/// Create a copy of OwnPlayer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnPlayerCopyWith<_OwnPlayer> get copyWith => __$OwnPlayerCopyWithImpl<_OwnPlayer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OwnPlayerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnPlayer&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.position, position) || other.position == position)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.isInjured, isInjured) || other.isInjured == isInjured));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,shirtNumber,position,birthdate,isInjured);

@override
String toString() {
  return 'OwnPlayer(id: $id, name: $name, shirtNumber: $shirtNumber, position: $position, birthdate: $birthdate, isInjured: $isInjured)';
}


}

/// @nodoc
abstract mixin class _$OwnPlayerCopyWith<$Res> implements $OwnPlayerCopyWith<$Res> {
  factory _$OwnPlayerCopyWith(_OwnPlayer value, $Res Function(_OwnPlayer) _then) = __$OwnPlayerCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int? shirtNumber, String? position, String? birthdate, bool isInjured
});




}
/// @nodoc
class __$OwnPlayerCopyWithImpl<$Res>
    implements _$OwnPlayerCopyWith<$Res> {
  __$OwnPlayerCopyWithImpl(this._self, this._then);

  final _OwnPlayer _self;
  final $Res Function(_OwnPlayer) _then;

/// Create a copy of OwnPlayer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? shirtNumber = freezed,Object? position = freezed,Object? birthdate = freezed,Object? isInjured = null,}) {
  return _then(_OwnPlayer(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as String?,isInjured: null == isInjured ? _self.isInjured : isInjured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ProfileVacation {

 int get id;/// Kale datums `YYYY-MM-DD`.
 String get startsOn; String get endsOn; String? get note;
/// Create a copy of ProfileVacation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileVacationCopyWith<ProfileVacation> get copyWith => _$ProfileVacationCopyWithImpl<ProfileVacation>(this as ProfileVacation, _$identity);

  /// Serializes this ProfileVacation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileVacation&&(identical(other.id, id) || other.id == id)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startsOn,endsOn,note);

@override
String toString() {
  return 'ProfileVacation(id: $id, startsOn: $startsOn, endsOn: $endsOn, note: $note)';
}


}

/// @nodoc
abstract mixin class $ProfileVacationCopyWith<$Res>  {
  factory $ProfileVacationCopyWith(ProfileVacation value, $Res Function(ProfileVacation) _then) = _$ProfileVacationCopyWithImpl;
@useResult
$Res call({
 int id, String startsOn, String endsOn, String? note
});




}
/// @nodoc
class _$ProfileVacationCopyWithImpl<$Res>
    implements $ProfileVacationCopyWith<$Res> {
  _$ProfileVacationCopyWithImpl(this._self, this._then);

  final ProfileVacation _self;
  final $Res Function(ProfileVacation) _then;

/// Create a copy of ProfileVacation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startsOn = null,Object? endsOn = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,startsOn: null == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as String,endsOn: null == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileVacation].
extension ProfileVacationPatterns on ProfileVacation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileVacation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileVacation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileVacation value)  $default,){
final _that = this;
switch (_that) {
case _ProfileVacation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileVacation value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileVacation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String startsOn,  String endsOn,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileVacation() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String startsOn,  String endsOn,  String? note)  $default,) {final _that = this;
switch (_that) {
case _ProfileVacation():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String startsOn,  String endsOn,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _ProfileVacation() when $default != null:
return $default(_that.id,_that.startsOn,_that.endsOn,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileVacation implements ProfileVacation {
  const _ProfileVacation({required this.id, required this.startsOn, required this.endsOn, this.note});
  factory _ProfileVacation.fromJson(Map<String, dynamic> json) => _$ProfileVacationFromJson(json);

@override final  int id;
/// Kale datums `YYYY-MM-DD`.
@override final  String startsOn;
@override final  String endsOn;
@override final  String? note;

/// Create a copy of ProfileVacation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileVacationCopyWith<_ProfileVacation> get copyWith => __$ProfileVacationCopyWithImpl<_ProfileVacation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileVacationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileVacation&&(identical(other.id, id) || other.id == id)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.endsOn, endsOn) || other.endsOn == endsOn)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startsOn,endsOn,note);

@override
String toString() {
  return 'ProfileVacation(id: $id, startsOn: $startsOn, endsOn: $endsOn, note: $note)';
}


}

/// @nodoc
abstract mixin class _$ProfileVacationCopyWith<$Res> implements $ProfileVacationCopyWith<$Res> {
  factory _$ProfileVacationCopyWith(_ProfileVacation value, $Res Function(_ProfileVacation) _then) = __$ProfileVacationCopyWithImpl;
@override @useResult
$Res call({
 int id, String startsOn, String endsOn, String? note
});




}
/// @nodoc
class __$ProfileVacationCopyWithImpl<$Res>
    implements _$ProfileVacationCopyWith<$Res> {
  __$ProfileVacationCopyWithImpl(this._self, this._then);

  final _ProfileVacation _self;
  final $Res Function(_ProfileVacation) _then;

/// Create a copy of ProfileVacation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startsOn = null,Object? endsOn = null,Object? note = freezed,}) {
  return _then(_ProfileVacation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,startsOn: null == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as String,endsOn: null == endsOn ? _self.endsOn : endsOn // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$StandingAbsenceDay {

 int get id;/// ISO-weekdag (1 = maandag … 7 = zondag; 0 telt ook als zondag).
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
/// ISO-weekdag (1 = maandag … 7 = zondag; 0 telt ook als zondag).
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
mixin _$Profile {

 ProfileAccount get user; OwnPlayer? get player; bool get canUseVacations; List<ProfileVacation> get vacations; StandingAbsences? get standingAbsences;
/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCopyWith<Profile> get copyWith => _$ProfileCopyWithImpl<Profile>(this as Profile, _$identity);

  /// Serializes this Profile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Profile&&(identical(other.user, user) || other.user == user)&&(identical(other.player, player) || other.player == player)&&(identical(other.canUseVacations, canUseVacations) || other.canUseVacations == canUseVacations)&&const DeepCollectionEquality().equals(other.vacations, vacations)&&(identical(other.standingAbsences, standingAbsences) || other.standingAbsences == standingAbsences));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,player,canUseVacations,const DeepCollectionEquality().hash(vacations),standingAbsences);

@override
String toString() {
  return 'Profile(user: $user, player: $player, canUseVacations: $canUseVacations, vacations: $vacations, standingAbsences: $standingAbsences)';
}


}

/// @nodoc
abstract mixin class $ProfileCopyWith<$Res>  {
  factory $ProfileCopyWith(Profile value, $Res Function(Profile) _then) = _$ProfileCopyWithImpl;
@useResult
$Res call({
 ProfileAccount user, OwnPlayer? player, bool canUseVacations, List<ProfileVacation> vacations, StandingAbsences? standingAbsences
});


$ProfileAccountCopyWith<$Res> get user;$OwnPlayerCopyWith<$Res>? get player;$StandingAbsencesCopyWith<$Res>? get standingAbsences;

}
/// @nodoc
class _$ProfileCopyWithImpl<$Res>
    implements $ProfileCopyWith<$Res> {
  _$ProfileCopyWithImpl(this._self, this._then);

  final Profile _self;
  final $Res Function(Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? player = freezed,Object? canUseVacations = null,Object? vacations = null,Object? standingAbsences = freezed,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ProfileAccount,player: freezed == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as OwnPlayer?,canUseVacations: null == canUseVacations ? _self.canUseVacations : canUseVacations // ignore: cast_nullable_to_non_nullable
as bool,vacations: null == vacations ? _self.vacations : vacations // ignore: cast_nullable_to_non_nullable
as List<ProfileVacation>,standingAbsences: freezed == standingAbsences ? _self.standingAbsences : standingAbsences // ignore: cast_nullable_to_non_nullable
as StandingAbsences?,
  ));
}
/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileAccountCopyWith<$Res> get user {
  
  return $ProfileAccountCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OwnPlayerCopyWith<$Res>? get player {
    if (_self.player == null) {
    return null;
  }

  return $OwnPlayerCopyWith<$Res>(_self.player!, (value) {
    return _then(_self.copyWith(player: value));
  });
}/// Create a copy of Profile
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
}
}


/// Adds pattern-matching-related methods to [Profile].
extension ProfilePatterns on Profile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Profile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Profile value)  $default,){
final _that = this;
switch (_that) {
case _Profile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Profile value)?  $default,){
final _that = this;
switch (_that) {
case _Profile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProfileAccount user,  OwnPlayer? player,  bool canUseVacations,  List<ProfileVacation> vacations,  StandingAbsences? standingAbsences)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.user,_that.player,_that.canUseVacations,_that.vacations,_that.standingAbsences);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProfileAccount user,  OwnPlayer? player,  bool canUseVacations,  List<ProfileVacation> vacations,  StandingAbsences? standingAbsences)  $default,) {final _that = this;
switch (_that) {
case _Profile():
return $default(_that.user,_that.player,_that.canUseVacations,_that.vacations,_that.standingAbsences);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProfileAccount user,  OwnPlayer? player,  bool canUseVacations,  List<ProfileVacation> vacations,  StandingAbsences? standingAbsences)?  $default,) {final _that = this;
switch (_that) {
case _Profile() when $default != null:
return $default(_that.user,_that.player,_that.canUseVacations,_that.vacations,_that.standingAbsences);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Profile implements Profile {
  const _Profile({required this.user, this.player, this.canUseVacations = false, final  List<ProfileVacation> vacations = const <ProfileVacation>[], this.standingAbsences}): _vacations = vacations;
  factory _Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

@override final  ProfileAccount user;
@override final  OwnPlayer? player;
@override@JsonKey() final  bool canUseVacations;
 final  List<ProfileVacation> _vacations;
@override@JsonKey() List<ProfileVacation> get vacations {
  if (_vacations is EqualUnmodifiableListView) return _vacations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vacations);
}

@override final  StandingAbsences? standingAbsences;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileCopyWith<_Profile> get copyWith => __$ProfileCopyWithImpl<_Profile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Profile&&(identical(other.user, user) || other.user == user)&&(identical(other.player, player) || other.player == player)&&(identical(other.canUseVacations, canUseVacations) || other.canUseVacations == canUseVacations)&&const DeepCollectionEquality().equals(other._vacations, _vacations)&&(identical(other.standingAbsences, standingAbsences) || other.standingAbsences == standingAbsences));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,player,canUseVacations,const DeepCollectionEquality().hash(_vacations),standingAbsences);

@override
String toString() {
  return 'Profile(user: $user, player: $player, canUseVacations: $canUseVacations, vacations: $vacations, standingAbsences: $standingAbsences)';
}


}

/// @nodoc
abstract mixin class _$ProfileCopyWith<$Res> implements $ProfileCopyWith<$Res> {
  factory _$ProfileCopyWith(_Profile value, $Res Function(_Profile) _then) = __$ProfileCopyWithImpl;
@override @useResult
$Res call({
 ProfileAccount user, OwnPlayer? player, bool canUseVacations, List<ProfileVacation> vacations, StandingAbsences? standingAbsences
});


@override $ProfileAccountCopyWith<$Res> get user;@override $OwnPlayerCopyWith<$Res>? get player;@override $StandingAbsencesCopyWith<$Res>? get standingAbsences;

}
/// @nodoc
class __$ProfileCopyWithImpl<$Res>
    implements _$ProfileCopyWith<$Res> {
  __$ProfileCopyWithImpl(this._self, this._then);

  final _Profile _self;
  final $Res Function(_Profile) _then;

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? player = freezed,Object? canUseVacations = null,Object? vacations = null,Object? standingAbsences = freezed,}) {
  return _then(_Profile(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as ProfileAccount,player: freezed == player ? _self.player : player // ignore: cast_nullable_to_non_nullable
as OwnPlayer?,canUseVacations: null == canUseVacations ? _self.canUseVacations : canUseVacations // ignore: cast_nullable_to_non_nullable
as bool,vacations: null == vacations ? _self._vacations : vacations // ignore: cast_nullable_to_non_nullable
as List<ProfileVacation>,standingAbsences: freezed == standingAbsences ? _self.standingAbsences : standingAbsences // ignore: cast_nullable_to_non_nullable
as StandingAbsences?,
  ));
}

/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileAccountCopyWith<$Res> get user {
  
  return $ProfileAccountCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of Profile
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OwnPlayerCopyWith<$Res>? get player {
    if (_self.player == null) {
    return null;
  }

  return $OwnPlayerCopyWith<$Res>(_self.player!, (value) {
    return _then(_self.copyWith(player: value));
  });
}/// Create a copy of Profile
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
}
}

// dart format on
