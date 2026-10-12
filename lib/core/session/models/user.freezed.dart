// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

 int get id; String get name; String? get email; String? get pendingEmail; String? get avatarUrl;/// Kale kalenderdag `YYYY-MM-DD`; bewust een string (geen tijdzone).
 String? get birthdate; bool get isSuperAdmin; ProfileMissing get profileMissing;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.pendingEmail, pendingEmail) || other.pendingEmail == pendingEmail)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.isSuperAdmin, isSuperAdmin) || other.isSuperAdmin == isSuperAdmin)&&(identical(other.profileMissing, profileMissing) || other.profileMissing == profileMissing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,pendingEmail,avatarUrl,birthdate,isSuperAdmin,profileMissing);

@override
String toString() {
  return 'User(id: $id, name: $name, email: $email, pendingEmail: $pendingEmail, avatarUrl: $avatarUrl, birthdate: $birthdate, isSuperAdmin: $isSuperAdmin, profileMissing: $profileMissing)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? email, String? pendingEmail, String? avatarUrl, String? birthdate, bool isSuperAdmin, ProfileMissing profileMissing
});


$ProfileMissingCopyWith<$Res> get profileMissing;

}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = freezed,Object? pendingEmail = freezed,Object? avatarUrl = freezed,Object? birthdate = freezed,Object? isSuperAdmin = null,Object? profileMissing = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,pendingEmail: freezed == pendingEmail ? _self.pendingEmail : pendingEmail // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as String?,isSuperAdmin: null == isSuperAdmin ? _self.isSuperAdmin : isSuperAdmin // ignore: cast_nullable_to_non_nullable
as bool,profileMissing: null == profileMissing ? _self.profileMissing : profileMissing // ignore: cast_nullable_to_non_nullable
as ProfileMissing,
  ));
}
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileMissingCopyWith<$Res> get profileMissing {
  
  return $ProfileMissingCopyWith<$Res>(_self.profileMissing, (value) {
    return _then(_self.copyWith(profileMissing: value));
  });
}
}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? email,  String? pendingEmail,  String? avatarUrl,  String? birthdate,  bool isSuperAdmin,  ProfileMissing profileMissing)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.pendingEmail,_that.avatarUrl,_that.birthdate,_that.isSuperAdmin,_that.profileMissing);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? email,  String? pendingEmail,  String? avatarUrl,  String? birthdate,  bool isSuperAdmin,  ProfileMissing profileMissing)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.id,_that.name,_that.email,_that.pendingEmail,_that.avatarUrl,_that.birthdate,_that.isSuperAdmin,_that.profileMissing);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? email,  String? pendingEmail,  String? avatarUrl,  String? birthdate,  bool isSuperAdmin,  ProfileMissing profileMissing)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.pendingEmail,_that.avatarUrl,_that.birthdate,_that.isSuperAdmin,_that.profileMissing);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User implements User {
  const _User({required this.id, required this.name, required this.email, this.pendingEmail, this.avatarUrl, this.birthdate, this.isSuperAdmin = false, this.profileMissing = const ProfileMissing()});
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? email;
@override final  String? pendingEmail;
@override final  String? avatarUrl;
/// Kale kalenderdag `YYYY-MM-DD`; bewust een string (geen tijdzone).
@override final  String? birthdate;
@override@JsonKey() final  bool isSuperAdmin;
@override@JsonKey() final  ProfileMissing profileMissing;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.pendingEmail, pendingEmail) || other.pendingEmail == pendingEmail)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.isSuperAdmin, isSuperAdmin) || other.isSuperAdmin == isSuperAdmin)&&(identical(other.profileMissing, profileMissing) || other.profileMissing == profileMissing));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,pendingEmail,avatarUrl,birthdate,isSuperAdmin,profileMissing);

@override
String toString() {
  return 'User(id: $id, name: $name, email: $email, pendingEmail: $pendingEmail, avatarUrl: $avatarUrl, birthdate: $birthdate, isSuperAdmin: $isSuperAdmin, profileMissing: $profileMissing)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? email, String? pendingEmail, String? avatarUrl, String? birthdate, bool isSuperAdmin, ProfileMissing profileMissing
});


@override $ProfileMissingCopyWith<$Res> get profileMissing;

}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = freezed,Object? pendingEmail = freezed,Object? avatarUrl = freezed,Object? birthdate = freezed,Object? isSuperAdmin = null,Object? profileMissing = null,}) {
  return _then(_User(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,pendingEmail: freezed == pendingEmail ? _self.pendingEmail : pendingEmail // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as String?,isSuperAdmin: null == isSuperAdmin ? _self.isSuperAdmin : isSuperAdmin // ignore: cast_nullable_to_non_nullable
as bool,profileMissing: null == profileMissing ? _self.profileMissing : profileMissing // ignore: cast_nullable_to_non_nullable
as ProfileMissing,
  ));
}

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileMissingCopyWith<$Res> get profileMissing {
  
  return $ProfileMissingCopyWith<$Res>(_self.profileMissing, (value) {
    return _then(_self.copyWith(profileMissing: value));
  });
}
}


/// @nodoc
mixin _$ProfileMissing {

 bool get avatar; bool get birthdate; bool get email;
/// Create a copy of ProfileMissing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileMissingCopyWith<ProfileMissing> get copyWith => _$ProfileMissingCopyWithImpl<ProfileMissing>(this as ProfileMissing, _$identity);

  /// Serializes this ProfileMissing to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileMissing&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,avatar,birthdate,email);

@override
String toString() {
  return 'ProfileMissing(avatar: $avatar, birthdate: $birthdate, email: $email)';
}


}

/// @nodoc
abstract mixin class $ProfileMissingCopyWith<$Res>  {
  factory $ProfileMissingCopyWith(ProfileMissing value, $Res Function(ProfileMissing) _then) = _$ProfileMissingCopyWithImpl;
@useResult
$Res call({
 bool avatar, bool birthdate, bool email
});




}
/// @nodoc
class _$ProfileMissingCopyWithImpl<$Res>
    implements $ProfileMissingCopyWith<$Res> {
  _$ProfileMissingCopyWithImpl(this._self, this._then);

  final ProfileMissing _self;
  final $Res Function(ProfileMissing) _then;

/// Create a copy of ProfileMissing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? avatar = null,Object? birthdate = null,Object? email = null,}) {
  return _then(_self.copyWith(
avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as bool,birthdate: null == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as bool,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileMissing].
extension ProfileMissingPatterns on ProfileMissing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileMissing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileMissing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileMissing value)  $default,){
final _that = this;
switch (_that) {
case _ProfileMissing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileMissing value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileMissing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool avatar,  bool birthdate,  bool email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileMissing() when $default != null:
return $default(_that.avatar,_that.birthdate,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool avatar,  bool birthdate,  bool email)  $default,) {final _that = this;
switch (_that) {
case _ProfileMissing():
return $default(_that.avatar,_that.birthdate,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool avatar,  bool birthdate,  bool email)?  $default,) {final _that = this;
switch (_that) {
case _ProfileMissing() when $default != null:
return $default(_that.avatar,_that.birthdate,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileMissing implements ProfileMissing {
  const _ProfileMissing({this.avatar = false, this.birthdate = false, this.email = false});
  factory _ProfileMissing.fromJson(Map<String, dynamic> json) => _$ProfileMissingFromJson(json);

@override@JsonKey() final  bool avatar;
@override@JsonKey() final  bool birthdate;
@override@JsonKey() final  bool email;

/// Create a copy of ProfileMissing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileMissingCopyWith<_ProfileMissing> get copyWith => __$ProfileMissingCopyWithImpl<_ProfileMissing>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileMissingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileMissing&&(identical(other.avatar, avatar) || other.avatar == avatar)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,avatar,birthdate,email);

@override
String toString() {
  return 'ProfileMissing(avatar: $avatar, birthdate: $birthdate, email: $email)';
}


}

/// @nodoc
abstract mixin class _$ProfileMissingCopyWith<$Res> implements $ProfileMissingCopyWith<$Res> {
  factory _$ProfileMissingCopyWith(_ProfileMissing value, $Res Function(_ProfileMissing) _then) = __$ProfileMissingCopyWithImpl;
@override @useResult
$Res call({
 bool avatar, bool birthdate, bool email
});




}
/// @nodoc
class __$ProfileMissingCopyWithImpl<$Res>
    implements _$ProfileMissingCopyWith<$Res> {
  __$ProfileMissingCopyWithImpl(this._self, this._then);

  final _ProfileMissing _self;
  final $Res Function(_ProfileMissing) _then;

/// Create a copy of ProfileMissing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? avatar = null,Object? birthdate = null,Object? email = null,}) {
  return _then(_ProfileMissing(
avatar: null == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as bool,birthdate: null == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as bool,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
