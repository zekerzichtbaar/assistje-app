// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignupDesignation {

 String get word; String get question; String get hint; String get example;
/// Create a copy of SignupDesignation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupDesignationCopyWith<SignupDesignation> get copyWith => _$SignupDesignationCopyWithImpl<SignupDesignation>(this as SignupDesignation, _$identity);

  /// Serializes this SignupDesignation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupDesignation&&(identical(other.word, word) || other.word == word)&&(identical(other.question, question) || other.question == question)&&(identical(other.hint, hint) || other.hint == hint)&&(identical(other.example, example) || other.example == example));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,word,question,hint,example);

@override
String toString() {
  return 'SignupDesignation(word: $word, question: $question, hint: $hint, example: $example)';
}


}

/// @nodoc
abstract mixin class $SignupDesignationCopyWith<$Res>  {
  factory $SignupDesignationCopyWith(SignupDesignation value, $Res Function(SignupDesignation) _then) = _$SignupDesignationCopyWithImpl;
@useResult
$Res call({
 String word, String question, String hint, String example
});




}
/// @nodoc
class _$SignupDesignationCopyWithImpl<$Res>
    implements $SignupDesignationCopyWith<$Res> {
  _$SignupDesignationCopyWithImpl(this._self, this._then);

  final SignupDesignation _self;
  final $Res Function(SignupDesignation) _then;

/// Create a copy of SignupDesignation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? word = null,Object? question = null,Object? hint = null,Object? example = null,}) {
  return _then(_self.copyWith(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,hint: null == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String,example: null == example ? _self.example : example // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SignupDesignation].
extension SignupDesignationPatterns on SignupDesignation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignupDesignation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignupDesignation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignupDesignation value)  $default,){
final _that = this;
switch (_that) {
case _SignupDesignation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignupDesignation value)?  $default,){
final _that = this;
switch (_that) {
case _SignupDesignation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String word,  String question,  String hint,  String example)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignupDesignation() when $default != null:
return $default(_that.word,_that.question,_that.hint,_that.example);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String word,  String question,  String hint,  String example)  $default,) {final _that = this;
switch (_that) {
case _SignupDesignation():
return $default(_that.word,_that.question,_that.hint,_that.example);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String word,  String question,  String hint,  String example)?  $default,) {final _that = this;
switch (_that) {
case _SignupDesignation() when $default != null:
return $default(_that.word,_that.question,_that.hint,_that.example);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignupDesignation implements SignupDesignation {
  const _SignupDesignation({this.word = 'team', this.question = 'Welk team?', this.hint = '', this.example = ''});
  factory _SignupDesignation.fromJson(Map<String, dynamic> json) => _$SignupDesignationFromJson(json);

@override@JsonKey() final  String word;
@override@JsonKey() final  String question;
@override@JsonKey() final  String hint;
@override@JsonKey() final  String example;

/// Create a copy of SignupDesignation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupDesignationCopyWith<_SignupDesignation> get copyWith => __$SignupDesignationCopyWithImpl<_SignupDesignation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignupDesignationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupDesignation&&(identical(other.word, word) || other.word == word)&&(identical(other.question, question) || other.question == question)&&(identical(other.hint, hint) || other.hint == hint)&&(identical(other.example, example) || other.example == example));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,word,question,hint,example);

@override
String toString() {
  return 'SignupDesignation(word: $word, question: $question, hint: $hint, example: $example)';
}


}

/// @nodoc
abstract mixin class _$SignupDesignationCopyWith<$Res> implements $SignupDesignationCopyWith<$Res> {
  factory _$SignupDesignationCopyWith(_SignupDesignation value, $Res Function(_SignupDesignation) _then) = __$SignupDesignationCopyWithImpl;
@override @useResult
$Res call({
 String word, String question, String hint, String example
});




}
/// @nodoc
class __$SignupDesignationCopyWithImpl<$Res>
    implements _$SignupDesignationCopyWith<$Res> {
  __$SignupDesignationCopyWithImpl(this._self, this._then);

  final _SignupDesignation _self;
  final $Res Function(_SignupDesignation) _then;

/// Create a copy of SignupDesignation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? word = null,Object? question = null,Object? hint = null,Object? example = null,}) {
  return _then(_SignupDesignation(
word: null == word ? _self.word : word // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,hint: null == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String,example: null == example ? _self.example : example // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SignupFederationImport {

 String? get method; String get name; String get hint; String get example;
/// Create a copy of SignupFederationImport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupFederationImportCopyWith<SignupFederationImport> get copyWith => _$SignupFederationImportCopyWithImpl<SignupFederationImport>(this as SignupFederationImport, _$identity);

  /// Serializes this SignupFederationImport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupFederationImport&&(identical(other.method, method) || other.method == method)&&(identical(other.name, name) || other.name == name)&&(identical(other.hint, hint) || other.hint == hint)&&(identical(other.example, example) || other.example == example));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,method,name,hint,example);

@override
String toString() {
  return 'SignupFederationImport(method: $method, name: $name, hint: $hint, example: $example)';
}


}

/// @nodoc
abstract mixin class $SignupFederationImportCopyWith<$Res>  {
  factory $SignupFederationImportCopyWith(SignupFederationImport value, $Res Function(SignupFederationImport) _then) = _$SignupFederationImportCopyWithImpl;
@useResult
$Res call({
 String? method, String name, String hint, String example
});




}
/// @nodoc
class _$SignupFederationImportCopyWithImpl<$Res>
    implements $SignupFederationImportCopyWith<$Res> {
  _$SignupFederationImportCopyWithImpl(this._self, this._then);

  final SignupFederationImport _self;
  final $Res Function(SignupFederationImport) _then;

/// Create a copy of SignupFederationImport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? method = freezed,Object? name = null,Object? hint = null,Object? example = null,}) {
  return _then(_self.copyWith(
method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hint: null == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String,example: null == example ? _self.example : example // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SignupFederationImport].
extension SignupFederationImportPatterns on SignupFederationImport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignupFederationImport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignupFederationImport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignupFederationImport value)  $default,){
final _that = this;
switch (_that) {
case _SignupFederationImport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignupFederationImport value)?  $default,){
final _that = this;
switch (_that) {
case _SignupFederationImport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? method,  String name,  String hint,  String example)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignupFederationImport() when $default != null:
return $default(_that.method,_that.name,_that.hint,_that.example);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? method,  String name,  String hint,  String example)  $default,) {final _that = this;
switch (_that) {
case _SignupFederationImport():
return $default(_that.method,_that.name,_that.hint,_that.example);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? method,  String name,  String hint,  String example)?  $default,) {final _that = this;
switch (_that) {
case _SignupFederationImport() when $default != null:
return $default(_that.method,_that.name,_that.hint,_that.example);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignupFederationImport extends SignupFederationImport {
  const _SignupFederationImport({this.method, this.name = '', this.hint = '', this.example = ''}): super._();
  factory _SignupFederationImport.fromJson(Map<String, dynamic> json) => _$SignupFederationImportFromJson(json);

@override final  String? method;
@override@JsonKey() final  String name;
@override@JsonKey() final  String hint;
@override@JsonKey() final  String example;

/// Create a copy of SignupFederationImport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupFederationImportCopyWith<_SignupFederationImport> get copyWith => __$SignupFederationImportCopyWithImpl<_SignupFederationImport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignupFederationImportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupFederationImport&&(identical(other.method, method) || other.method == method)&&(identical(other.name, name) || other.name == name)&&(identical(other.hint, hint) || other.hint == hint)&&(identical(other.example, example) || other.example == example));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,method,name,hint,example);

@override
String toString() {
  return 'SignupFederationImport(method: $method, name: $name, hint: $hint, example: $example)';
}


}

/// @nodoc
abstract mixin class _$SignupFederationImportCopyWith<$Res> implements $SignupFederationImportCopyWith<$Res> {
  factory _$SignupFederationImportCopyWith(_SignupFederationImport value, $Res Function(_SignupFederationImport) _then) = __$SignupFederationImportCopyWithImpl;
@override @useResult
$Res call({
 String? method, String name, String hint, String example
});




}
/// @nodoc
class __$SignupFederationImportCopyWithImpl<$Res>
    implements _$SignupFederationImportCopyWith<$Res> {
  __$SignupFederationImportCopyWithImpl(this._self, this._then);

  final _SignupFederationImport _self;
  final $Res Function(_SignupFederationImport) _then;

/// Create a copy of SignupFederationImport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? method = freezed,Object? name = null,Object? hint = null,Object? example = null,}) {
  return _then(_SignupFederationImport(
method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,hint: null == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String,example: null == example ? _self.example : example // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SignupSport {

 String get value; String get label; SignupDesignation get designation; SignupFederationImport? get federationImport;
/// Create a copy of SignupSport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupSportCopyWith<SignupSport> get copyWith => _$SignupSportCopyWithImpl<SignupSport>(this as SignupSport, _$identity);

  /// Serializes this SignupSport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupSport&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.federationImport, federationImport) || other.federationImport == federationImport));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,label,designation,federationImport);

@override
String toString() {
  return 'SignupSport(value: $value, label: $label, designation: $designation, federationImport: $federationImport)';
}


}

/// @nodoc
abstract mixin class $SignupSportCopyWith<$Res>  {
  factory $SignupSportCopyWith(SignupSport value, $Res Function(SignupSport) _then) = _$SignupSportCopyWithImpl;
@useResult
$Res call({
 String value, String label, SignupDesignation designation, SignupFederationImport? federationImport
});


$SignupDesignationCopyWith<$Res> get designation;$SignupFederationImportCopyWith<$Res>? get federationImport;

}
/// @nodoc
class _$SignupSportCopyWithImpl<$Res>
    implements $SignupSportCopyWith<$Res> {
  _$SignupSportCopyWithImpl(this._self, this._then);

  final SignupSport _self;
  final $Res Function(SignupSport) _then;

/// Create a copy of SignupSport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? label = null,Object? designation = null,Object? federationImport = freezed,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,designation: null == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as SignupDesignation,federationImport: freezed == federationImport ? _self.federationImport : federationImport // ignore: cast_nullable_to_non_nullable
as SignupFederationImport?,
  ));
}
/// Create a copy of SignupSport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignupDesignationCopyWith<$Res> get designation {
  
  return $SignupDesignationCopyWith<$Res>(_self.designation, (value) {
    return _then(_self.copyWith(designation: value));
  });
}/// Create a copy of SignupSport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignupFederationImportCopyWith<$Res>? get federationImport {
    if (_self.federationImport == null) {
    return null;
  }

  return $SignupFederationImportCopyWith<$Res>(_self.federationImport!, (value) {
    return _then(_self.copyWith(federationImport: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignupSport].
extension SignupSportPatterns on SignupSport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignupSport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignupSport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignupSport value)  $default,){
final _that = this;
switch (_that) {
case _SignupSport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignupSport value)?  $default,){
final _that = this;
switch (_that) {
case _SignupSport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  String label,  SignupDesignation designation,  SignupFederationImport? federationImport)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignupSport() when $default != null:
return $default(_that.value,_that.label,_that.designation,_that.federationImport);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  String label,  SignupDesignation designation,  SignupFederationImport? federationImport)  $default,) {final _that = this;
switch (_that) {
case _SignupSport():
return $default(_that.value,_that.label,_that.designation,_that.federationImport);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  String label,  SignupDesignation designation,  SignupFederationImport? federationImport)?  $default,) {final _that = this;
switch (_that) {
case _SignupSport() when $default != null:
return $default(_that.value,_that.label,_that.designation,_that.federationImport);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignupSport extends SignupSport {
  const _SignupSport({required this.value, this.label = '', this.designation = const SignupDesignation(), this.federationImport}): super._();
  factory _SignupSport.fromJson(Map<String, dynamic> json) => _$SignupSportFromJson(json);

@override final  String value;
@override@JsonKey() final  String label;
@override@JsonKey() final  SignupDesignation designation;
@override final  SignupFederationImport? federationImport;

/// Create a copy of SignupSport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupSportCopyWith<_SignupSport> get copyWith => __$SignupSportCopyWithImpl<_SignupSport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignupSportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupSport&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label)&&(identical(other.designation, designation) || other.designation == designation)&&(identical(other.federationImport, federationImport) || other.federationImport == federationImport));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,label,designation,federationImport);

@override
String toString() {
  return 'SignupSport(value: $value, label: $label, designation: $designation, federationImport: $federationImport)';
}


}

/// @nodoc
abstract mixin class _$SignupSportCopyWith<$Res> implements $SignupSportCopyWith<$Res> {
  factory _$SignupSportCopyWith(_SignupSport value, $Res Function(_SignupSport) _then) = __$SignupSportCopyWithImpl;
@override @useResult
$Res call({
 String value, String label, SignupDesignation designation, SignupFederationImport? federationImport
});


@override $SignupDesignationCopyWith<$Res> get designation;@override $SignupFederationImportCopyWith<$Res>? get federationImport;

}
/// @nodoc
class __$SignupSportCopyWithImpl<$Res>
    implements _$SignupSportCopyWith<$Res> {
  __$SignupSportCopyWithImpl(this._self, this._then);

  final _SignupSport _self;
  final $Res Function(_SignupSport) _then;

/// Create a copy of SignupSport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? label = null,Object? designation = null,Object? federationImport = freezed,}) {
  return _then(_SignupSport(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,designation: null == designation ? _self.designation : designation // ignore: cast_nullable_to_non_nullable
as SignupDesignation,federationImport: freezed == federationImport ? _self.federationImport : federationImport // ignore: cast_nullable_to_non_nullable
as SignupFederationImport?,
  ));
}

/// Create a copy of SignupSport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignupDesignationCopyWith<$Res> get designation {
  
  return $SignupDesignationCopyWith<$Res>(_self.designation, (value) {
    return _then(_self.copyWith(designation: value));
  });
}/// Create a copy of SignupSport
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignupFederationImportCopyWith<$Res>? get federationImport {
    if (_self.federationImport == null) {
    return null;
  }

  return $SignupFederationImportCopyWith<$Res>(_self.federationImport!, (value) {
    return _then(_self.copyWith(federationImport: value));
  });
}
}


/// @nodoc
mixin _$SignupLimits {

 int get trainingsMin; int get trainingsMax; int get logoMaxKb; List<String> get logoMimetypes; int get clubSearchMinChars;
/// Create a copy of SignupLimits
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupLimitsCopyWith<SignupLimits> get copyWith => _$SignupLimitsCopyWithImpl<SignupLimits>(this as SignupLimits, _$identity);

  /// Serializes this SignupLimits to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupLimits&&(identical(other.trainingsMin, trainingsMin) || other.trainingsMin == trainingsMin)&&(identical(other.trainingsMax, trainingsMax) || other.trainingsMax == trainingsMax)&&(identical(other.logoMaxKb, logoMaxKb) || other.logoMaxKb == logoMaxKb)&&const DeepCollectionEquality().equals(other.logoMimetypes, logoMimetypes)&&(identical(other.clubSearchMinChars, clubSearchMinChars) || other.clubSearchMinChars == clubSearchMinChars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,trainingsMin,trainingsMax,logoMaxKb,const DeepCollectionEquality().hash(logoMimetypes),clubSearchMinChars);

@override
String toString() {
  return 'SignupLimits(trainingsMin: $trainingsMin, trainingsMax: $trainingsMax, logoMaxKb: $logoMaxKb, logoMimetypes: $logoMimetypes, clubSearchMinChars: $clubSearchMinChars)';
}


}

/// @nodoc
abstract mixin class $SignupLimitsCopyWith<$Res>  {
  factory $SignupLimitsCopyWith(SignupLimits value, $Res Function(SignupLimits) _then) = _$SignupLimitsCopyWithImpl;
@useResult
$Res call({
 int trainingsMin, int trainingsMax, int logoMaxKb, List<String> logoMimetypes, int clubSearchMinChars
});




}
/// @nodoc
class _$SignupLimitsCopyWithImpl<$Res>
    implements $SignupLimitsCopyWith<$Res> {
  _$SignupLimitsCopyWithImpl(this._self, this._then);

  final SignupLimits _self;
  final $Res Function(SignupLimits) _then;

/// Create a copy of SignupLimits
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? trainingsMin = null,Object? trainingsMax = null,Object? logoMaxKb = null,Object? logoMimetypes = null,Object? clubSearchMinChars = null,}) {
  return _then(_self.copyWith(
trainingsMin: null == trainingsMin ? _self.trainingsMin : trainingsMin // ignore: cast_nullable_to_non_nullable
as int,trainingsMax: null == trainingsMax ? _self.trainingsMax : trainingsMax // ignore: cast_nullable_to_non_nullable
as int,logoMaxKb: null == logoMaxKb ? _self.logoMaxKb : logoMaxKb // ignore: cast_nullable_to_non_nullable
as int,logoMimetypes: null == logoMimetypes ? _self.logoMimetypes : logoMimetypes // ignore: cast_nullable_to_non_nullable
as List<String>,clubSearchMinChars: null == clubSearchMinChars ? _self.clubSearchMinChars : clubSearchMinChars // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SignupLimits].
extension SignupLimitsPatterns on SignupLimits {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignupLimits value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignupLimits() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignupLimits value)  $default,){
final _that = this;
switch (_that) {
case _SignupLimits():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignupLimits value)?  $default,){
final _that = this;
switch (_that) {
case _SignupLimits() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int trainingsMin,  int trainingsMax,  int logoMaxKb,  List<String> logoMimetypes,  int clubSearchMinChars)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignupLimits() when $default != null:
return $default(_that.trainingsMin,_that.trainingsMax,_that.logoMaxKb,_that.logoMimetypes,_that.clubSearchMinChars);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int trainingsMin,  int trainingsMax,  int logoMaxKb,  List<String> logoMimetypes,  int clubSearchMinChars)  $default,) {final _that = this;
switch (_that) {
case _SignupLimits():
return $default(_that.trainingsMin,_that.trainingsMax,_that.logoMaxKb,_that.logoMimetypes,_that.clubSearchMinChars);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int trainingsMin,  int trainingsMax,  int logoMaxKb,  List<String> logoMimetypes,  int clubSearchMinChars)?  $default,) {final _that = this;
switch (_that) {
case _SignupLimits() when $default != null:
return $default(_that.trainingsMin,_that.trainingsMax,_that.logoMaxKb,_that.logoMimetypes,_that.clubSearchMinChars);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignupLimits implements SignupLimits {
  const _SignupLimits({this.trainingsMin = 1, this.trainingsMax = 7, this.logoMaxKb = 2048, final  List<String> logoMimetypes = const <String>['image/png', 'image/jpeg', 'image/svg+xml'], this.clubSearchMinChars = 2}): _logoMimetypes = logoMimetypes;
  factory _SignupLimits.fromJson(Map<String, dynamic> json) => _$SignupLimitsFromJson(json);

@override@JsonKey() final  int trainingsMin;
@override@JsonKey() final  int trainingsMax;
@override@JsonKey() final  int logoMaxKb;
 final  List<String> _logoMimetypes;
@override@JsonKey() List<String> get logoMimetypes {
  if (_logoMimetypes is EqualUnmodifiableListView) return _logoMimetypes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logoMimetypes);
}

@override@JsonKey() final  int clubSearchMinChars;

/// Create a copy of SignupLimits
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupLimitsCopyWith<_SignupLimits> get copyWith => __$SignupLimitsCopyWithImpl<_SignupLimits>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignupLimitsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupLimits&&(identical(other.trainingsMin, trainingsMin) || other.trainingsMin == trainingsMin)&&(identical(other.trainingsMax, trainingsMax) || other.trainingsMax == trainingsMax)&&(identical(other.logoMaxKb, logoMaxKb) || other.logoMaxKb == logoMaxKb)&&const DeepCollectionEquality().equals(other._logoMimetypes, _logoMimetypes)&&(identical(other.clubSearchMinChars, clubSearchMinChars) || other.clubSearchMinChars == clubSearchMinChars));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,trainingsMin,trainingsMax,logoMaxKb,const DeepCollectionEquality().hash(_logoMimetypes),clubSearchMinChars);

@override
String toString() {
  return 'SignupLimits(trainingsMin: $trainingsMin, trainingsMax: $trainingsMax, logoMaxKb: $logoMaxKb, logoMimetypes: $logoMimetypes, clubSearchMinChars: $clubSearchMinChars)';
}


}

/// @nodoc
abstract mixin class _$SignupLimitsCopyWith<$Res> implements $SignupLimitsCopyWith<$Res> {
  factory _$SignupLimitsCopyWith(_SignupLimits value, $Res Function(_SignupLimits) _then) = __$SignupLimitsCopyWithImpl;
@override @useResult
$Res call({
 int trainingsMin, int trainingsMax, int logoMaxKb, List<String> logoMimetypes, int clubSearchMinChars
});




}
/// @nodoc
class __$SignupLimitsCopyWithImpl<$Res>
    implements _$SignupLimitsCopyWith<$Res> {
  __$SignupLimitsCopyWithImpl(this._self, this._then);

  final _SignupLimits _self;
  final $Res Function(_SignupLimits) _then;

/// Create a copy of SignupLimits
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? trainingsMin = null,Object? trainingsMax = null,Object? logoMaxKb = null,Object? logoMimetypes = null,Object? clubSearchMinChars = null,}) {
  return _then(_SignupLimits(
trainingsMin: null == trainingsMin ? _self.trainingsMin : trainingsMin // ignore: cast_nullable_to_non_nullable
as int,trainingsMax: null == trainingsMax ? _self.trainingsMax : trainingsMax // ignore: cast_nullable_to_non_nullable
as int,logoMaxKb: null == logoMaxKb ? _self.logoMaxKb : logoMaxKb // ignore: cast_nullable_to_non_nullable
as int,logoMimetypes: null == logoMimetypes ? _self._logoMimetypes : logoMimetypes // ignore: cast_nullable_to_non_nullable
as List<String>,clubSearchMinChars: null == clubSearchMinChars ? _self.clubSearchMinChars : clubSearchMinChars // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SignupOptions {

 List<SignupSport> get sports; String? get sport; SignupLimits get limits;
/// Create a copy of SignupOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupOptionsCopyWith<SignupOptions> get copyWith => _$SignupOptionsCopyWithImpl<SignupOptions>(this as SignupOptions, _$identity);

  /// Serializes this SignupOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupOptions&&const DeepCollectionEquality().equals(other.sports, sports)&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.limits, limits) || other.limits == limits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sports),sport,limits);

@override
String toString() {
  return 'SignupOptions(sports: $sports, sport: $sport, limits: $limits)';
}


}

/// @nodoc
abstract mixin class $SignupOptionsCopyWith<$Res>  {
  factory $SignupOptionsCopyWith(SignupOptions value, $Res Function(SignupOptions) _then) = _$SignupOptionsCopyWithImpl;
@useResult
$Res call({
 List<SignupSport> sports, String? sport, SignupLimits limits
});


$SignupLimitsCopyWith<$Res> get limits;

}
/// @nodoc
class _$SignupOptionsCopyWithImpl<$Res>
    implements $SignupOptionsCopyWith<$Res> {
  _$SignupOptionsCopyWithImpl(this._self, this._then);

  final SignupOptions _self;
  final $Res Function(SignupOptions) _then;

/// Create a copy of SignupOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sports = null,Object? sport = freezed,Object? limits = null,}) {
  return _then(_self.copyWith(
sports: null == sports ? _self.sports : sports // ignore: cast_nullable_to_non_nullable
as List<SignupSport>,sport: freezed == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as String?,limits: null == limits ? _self.limits : limits // ignore: cast_nullable_to_non_nullable
as SignupLimits,
  ));
}
/// Create a copy of SignupOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignupLimitsCopyWith<$Res> get limits {
  
  return $SignupLimitsCopyWith<$Res>(_self.limits, (value) {
    return _then(_self.copyWith(limits: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignupOptions].
extension SignupOptionsPatterns on SignupOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignupOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignupOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignupOptions value)  $default,){
final _that = this;
switch (_that) {
case _SignupOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignupOptions value)?  $default,){
final _that = this;
switch (_that) {
case _SignupOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SignupSport> sports,  String? sport,  SignupLimits limits)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignupOptions() when $default != null:
return $default(_that.sports,_that.sport,_that.limits);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SignupSport> sports,  String? sport,  SignupLimits limits)  $default,) {final _that = this;
switch (_that) {
case _SignupOptions():
return $default(_that.sports,_that.sport,_that.limits);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SignupSport> sports,  String? sport,  SignupLimits limits)?  $default,) {final _that = this;
switch (_that) {
case _SignupOptions() when $default != null:
return $default(_that.sports,_that.sport,_that.limits);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignupOptions extends SignupOptions {
  const _SignupOptions({final  List<SignupSport> sports = const <SignupSport>[], this.sport, this.limits = const SignupLimits()}): _sports = sports,super._();
  factory _SignupOptions.fromJson(Map<String, dynamic> json) => _$SignupOptionsFromJson(json);

 final  List<SignupSport> _sports;
@override@JsonKey() List<SignupSport> get sports {
  if (_sports is EqualUnmodifiableListView) return _sports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sports);
}

@override final  String? sport;
@override@JsonKey() final  SignupLimits limits;

/// Create a copy of SignupOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupOptionsCopyWith<_SignupOptions> get copyWith => __$SignupOptionsCopyWithImpl<_SignupOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignupOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupOptions&&const DeepCollectionEquality().equals(other._sports, _sports)&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.limits, limits) || other.limits == limits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sports),sport,limits);

@override
String toString() {
  return 'SignupOptions(sports: $sports, sport: $sport, limits: $limits)';
}


}

/// @nodoc
abstract mixin class _$SignupOptionsCopyWith<$Res> implements $SignupOptionsCopyWith<$Res> {
  factory _$SignupOptionsCopyWith(_SignupOptions value, $Res Function(_SignupOptions) _then) = __$SignupOptionsCopyWithImpl;
@override @useResult
$Res call({
 List<SignupSport> sports, String? sport, SignupLimits limits
});


@override $SignupLimitsCopyWith<$Res> get limits;

}
/// @nodoc
class __$SignupOptionsCopyWithImpl<$Res>
    implements _$SignupOptionsCopyWith<$Res> {
  __$SignupOptionsCopyWithImpl(this._self, this._then);

  final _SignupOptions _self;
  final $Res Function(_SignupOptions) _then;

/// Create a copy of SignupOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sports = null,Object? sport = freezed,Object? limits = null,}) {
  return _then(_SignupOptions(
sports: null == sports ? _self._sports : sports // ignore: cast_nullable_to_non_nullable
as List<SignupSport>,sport: freezed == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as String?,limits: null == limits ? _self.limits : limits // ignore: cast_nullable_to_non_nullable
as SignupLimits,
  ));
}

/// Create a copy of SignupOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignupLimitsCopyWith<$Res> get limits {
  
  return $SignupLimitsCopyWith<$Res>(_self.limits, (value) {
    return _then(_self.copyWith(limits: value));
  });
}
}


/// @nodoc
mixin _$SignupClub {

 int get id; String get name; String? get place; String? get logoUrl;
/// Create a copy of SignupClub
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupClubCopyWith<SignupClub> get copyWith => _$SignupClubCopyWithImpl<SignupClub>(this as SignupClub, _$identity);

  /// Serializes this SignupClub to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupClub&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.place, place) || other.place == place)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,place,logoUrl);

@override
String toString() {
  return 'SignupClub(id: $id, name: $name, place: $place, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class $SignupClubCopyWith<$Res>  {
  factory $SignupClubCopyWith(SignupClub value, $Res Function(SignupClub) _then) = _$SignupClubCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? place, String? logoUrl
});




}
/// @nodoc
class _$SignupClubCopyWithImpl<$Res>
    implements $SignupClubCopyWith<$Res> {
  _$SignupClubCopyWithImpl(this._self, this._then);

  final SignupClub _self;
  final $Res Function(SignupClub) _then;

/// Create a copy of SignupClub
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? place = freezed,Object? logoUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SignupClub].
extension SignupClubPatterns on SignupClub {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignupClub value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignupClub() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignupClub value)  $default,){
final _that = this;
switch (_that) {
case _SignupClub():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignupClub value)?  $default,){
final _that = this;
switch (_that) {
case _SignupClub() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? place,  String? logoUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignupClub() when $default != null:
return $default(_that.id,_that.name,_that.place,_that.logoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? place,  String? logoUrl)  $default,) {final _that = this;
switch (_that) {
case _SignupClub():
return $default(_that.id,_that.name,_that.place,_that.logoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? place,  String? logoUrl)?  $default,) {final _that = this;
switch (_that) {
case _SignupClub() when $default != null:
return $default(_that.id,_that.name,_that.place,_that.logoUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignupClub implements SignupClub {
  const _SignupClub({required this.id, this.name = '', this.place, this.logoUrl});
  factory _SignupClub.fromJson(Map<String, dynamic> json) => _$SignupClubFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  String? place;
@override final  String? logoUrl;

/// Create a copy of SignupClub
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupClubCopyWith<_SignupClub> get copyWith => __$SignupClubCopyWithImpl<_SignupClub>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignupClubToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupClub&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.place, place) || other.place == place)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,place,logoUrl);

@override
String toString() {
  return 'SignupClub(id: $id, name: $name, place: $place, logoUrl: $logoUrl)';
}


}

/// @nodoc
abstract mixin class _$SignupClubCopyWith<$Res> implements $SignupClubCopyWith<$Res> {
  factory _$SignupClubCopyWith(_SignupClub value, $Res Function(_SignupClub) _then) = __$SignupClubCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? place, String? logoUrl
});




}
/// @nodoc
class __$SignupClubCopyWithImpl<$Res>
    implements _$SignupClubCopyWith<$Res> {
  __$SignupClubCopyWithImpl(this._self, this._then);

  final _SignupClub _self;
  final $Res Function(_SignupClub) _then;

/// Create a copy of SignupClub
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? place = freezed,Object? logoUrl = freezed,}) {
  return _then(_SignupClub(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,place: freezed == place ? _self.place : place // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$SignupClubResults {

 List<SignupClub> get clubs; int get more;
/// Create a copy of SignupClubResults
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupClubResultsCopyWith<SignupClubResults> get copyWith => _$SignupClubResultsCopyWithImpl<SignupClubResults>(this as SignupClubResults, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupClubResults&&const DeepCollectionEquality().equals(other.clubs, clubs)&&(identical(other.more, more) || other.more == more));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(clubs),more);

@override
String toString() {
  return 'SignupClubResults(clubs: $clubs, more: $more)';
}


}

/// @nodoc
abstract mixin class $SignupClubResultsCopyWith<$Res>  {
  factory $SignupClubResultsCopyWith(SignupClubResults value, $Res Function(SignupClubResults) _then) = _$SignupClubResultsCopyWithImpl;
@useResult
$Res call({
 List<SignupClub> clubs, int more
});




}
/// @nodoc
class _$SignupClubResultsCopyWithImpl<$Res>
    implements $SignupClubResultsCopyWith<$Res> {
  _$SignupClubResultsCopyWithImpl(this._self, this._then);

  final SignupClubResults _self;
  final $Res Function(SignupClubResults) _then;

/// Create a copy of SignupClubResults
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clubs = null,Object? more = null,}) {
  return _then(_self.copyWith(
clubs: null == clubs ? _self.clubs : clubs // ignore: cast_nullable_to_non_nullable
as List<SignupClub>,more: null == more ? _self.more : more // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SignupClubResults].
extension SignupClubResultsPatterns on SignupClubResults {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignupClubResults value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignupClubResults() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignupClubResults value)  $default,){
final _that = this;
switch (_that) {
case _SignupClubResults():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignupClubResults value)?  $default,){
final _that = this;
switch (_that) {
case _SignupClubResults() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SignupClub> clubs,  int more)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignupClubResults() when $default != null:
return $default(_that.clubs,_that.more);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SignupClub> clubs,  int more)  $default,) {final _that = this;
switch (_that) {
case _SignupClubResults():
return $default(_that.clubs,_that.more);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SignupClub> clubs,  int more)?  $default,) {final _that = this;
switch (_that) {
case _SignupClubResults() when $default != null:
return $default(_that.clubs,_that.more);case _:
  return null;

}
}

}

/// @nodoc


class _SignupClubResults implements SignupClubResults {
  const _SignupClubResults({final  List<SignupClub> clubs = const <SignupClub>[], this.more = 0}): _clubs = clubs;
  

 final  List<SignupClub> _clubs;
@override@JsonKey() List<SignupClub> get clubs {
  if (_clubs is EqualUnmodifiableListView) return _clubs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_clubs);
}

@override@JsonKey() final  int more;

/// Create a copy of SignupClubResults
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupClubResultsCopyWith<_SignupClubResults> get copyWith => __$SignupClubResultsCopyWithImpl<_SignupClubResults>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupClubResults&&const DeepCollectionEquality().equals(other._clubs, _clubs)&&(identical(other.more, more) || other.more == more));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_clubs),more);

@override
String toString() {
  return 'SignupClubResults(clubs: $clubs, more: $more)';
}


}

/// @nodoc
abstract mixin class _$SignupClubResultsCopyWith<$Res> implements $SignupClubResultsCopyWith<$Res> {
  factory _$SignupClubResultsCopyWith(_SignupClubResults value, $Res Function(_SignupClubResults) _then) = __$SignupClubResultsCopyWithImpl;
@override @useResult
$Res call({
 List<SignupClub> clubs, int more
});




}
/// @nodoc
class __$SignupClubResultsCopyWithImpl<$Res>
    implements _$SignupClubResultsCopyWith<$Res> {
  __$SignupClubResultsCopyWithImpl(this._self, this._then);

  final _SignupClubResults _self;
  final $Res Function(_SignupClubResults) _then;

/// Create a copy of SignupClubResults
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clubs = null,Object? more = null,}) {
  return _then(_SignupClubResults(
clubs: null == clubs ? _self._clubs : clubs // ignore: cast_nullable_to_non_nullable
as List<SignupClub>,more: null == more ? _self.more : more // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SignupTeam {

 int get id; String get name; String get slug; String? get sport; String get url;
/// Create a copy of SignupTeam
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupTeamCopyWith<SignupTeam> get copyWith => _$SignupTeamCopyWithImpl<SignupTeam>(this as SignupTeam, _$identity);

  /// Serializes this SignupTeam to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupTeam&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,sport,url);

@override
String toString() {
  return 'SignupTeam(id: $id, name: $name, slug: $slug, sport: $sport, url: $url)';
}


}

/// @nodoc
abstract mixin class $SignupTeamCopyWith<$Res>  {
  factory $SignupTeamCopyWith(SignupTeam value, $Res Function(SignupTeam) _then) = _$SignupTeamCopyWithImpl;
@useResult
$Res call({
 int id, String name, String slug, String? sport, String url
});




}
/// @nodoc
class _$SignupTeamCopyWithImpl<$Res>
    implements $SignupTeamCopyWith<$Res> {
  _$SignupTeamCopyWithImpl(this._self, this._then);

  final SignupTeam _self;
  final $Res Function(SignupTeam) _then;

/// Create a copy of SignupTeam
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? sport = freezed,Object? url = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,sport: freezed == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SignupTeam].
extension SignupTeamPatterns on SignupTeam {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignupTeam value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignupTeam() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignupTeam value)  $default,){
final _that = this;
switch (_that) {
case _SignupTeam():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignupTeam value)?  $default,){
final _that = this;
switch (_that) {
case _SignupTeam() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String? sport,  String url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignupTeam() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.sport,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String slug,  String? sport,  String url)  $default,) {final _that = this;
switch (_that) {
case _SignupTeam():
return $default(_that.id,_that.name,_that.slug,_that.sport,_that.url);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String slug,  String? sport,  String url)?  $default,) {final _that = this;
switch (_that) {
case _SignupTeam() when $default != null:
return $default(_that.id,_that.name,_that.slug,_that.sport,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignupTeam implements SignupTeam {
  const _SignupTeam({required this.id, this.name = '', this.slug = '', this.sport, this.url = ''});
  factory _SignupTeam.fromJson(Map<String, dynamic> json) => _$SignupTeamFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override@JsonKey() final  String slug;
@override final  String? sport;
@override@JsonKey() final  String url;

/// Create a copy of SignupTeam
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupTeamCopyWith<_SignupTeam> get copyWith => __$SignupTeamCopyWithImpl<_SignupTeam>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignupTeamToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupTeam&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,slug,sport,url);

@override
String toString() {
  return 'SignupTeam(id: $id, name: $name, slug: $slug, sport: $sport, url: $url)';
}


}

/// @nodoc
abstract mixin class _$SignupTeamCopyWith<$Res> implements $SignupTeamCopyWith<$Res> {
  factory _$SignupTeamCopyWith(_SignupTeam value, $Res Function(_SignupTeam) _then) = __$SignupTeamCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String slug, String? sport, String url
});




}
/// @nodoc
class __$SignupTeamCopyWithImpl<$Res>
    implements _$SignupTeamCopyWith<$Res> {
  __$SignupTeamCopyWithImpl(this._self, this._then);

  final _SignupTeam _self;
  final $Res Function(_SignupTeam) _then;

/// Create a copy of SignupTeam
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? slug = null,Object? sport = freezed,Object? url = null,}) {
  return _then(_SignupTeam(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,sport: freezed == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SignupSent {

 String get email; bool get already; SignupTeam get team;
/// Create a copy of SignupSent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupSentCopyWith<SignupSent> get copyWith => _$SignupSentCopyWithImpl<SignupSent>(this as SignupSent, _$identity);

  /// Serializes this SignupSent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupSent&&(identical(other.email, email) || other.email == email)&&(identical(other.already, already) || other.already == already)&&(identical(other.team, team) || other.team == team));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,already,team);

@override
String toString() {
  return 'SignupSent(email: $email, already: $already, team: $team)';
}


}

/// @nodoc
abstract mixin class $SignupSentCopyWith<$Res>  {
  factory $SignupSentCopyWith(SignupSent value, $Res Function(SignupSent) _then) = _$SignupSentCopyWithImpl;
@useResult
$Res call({
 String email, bool already, SignupTeam team
});


$SignupTeamCopyWith<$Res> get team;

}
/// @nodoc
class _$SignupSentCopyWithImpl<$Res>
    implements $SignupSentCopyWith<$Res> {
  _$SignupSentCopyWithImpl(this._self, this._then);

  final SignupSent _self;
  final $Res Function(SignupSent) _then;

/// Create a copy of SignupSent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? already = null,Object? team = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,already: null == already ? _self.already : already // ignore: cast_nullable_to_non_nullable
as bool,team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as SignupTeam,
  ));
}
/// Create a copy of SignupSent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignupTeamCopyWith<$Res> get team {
  
  return $SignupTeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignupSent].
extension SignupSentPatterns on SignupSent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignupSent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignupSent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignupSent value)  $default,){
final _that = this;
switch (_that) {
case _SignupSent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignupSent value)?  $default,){
final _that = this;
switch (_that) {
case _SignupSent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  bool already,  SignupTeam team)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignupSent() when $default != null:
return $default(_that.email,_that.already,_that.team);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  bool already,  SignupTeam team)  $default,) {final _that = this;
switch (_that) {
case _SignupSent():
return $default(_that.email,_that.already,_that.team);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  bool already,  SignupTeam team)?  $default,) {final _that = this;
switch (_that) {
case _SignupSent() when $default != null:
return $default(_that.email,_that.already,_that.team);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignupSent implements SignupSent {
  const _SignupSent({this.email = '', this.already = false, required this.team});
  factory _SignupSent.fromJson(Map<String, dynamic> json) => _$SignupSentFromJson(json);

@override@JsonKey() final  String email;
@override@JsonKey() final  bool already;
@override final  SignupTeam team;

/// Create a copy of SignupSent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupSentCopyWith<_SignupSent> get copyWith => __$SignupSentCopyWithImpl<_SignupSent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignupSentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupSent&&(identical(other.email, email) || other.email == email)&&(identical(other.already, already) || other.already == already)&&(identical(other.team, team) || other.team == team));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,already,team);

@override
String toString() {
  return 'SignupSent(email: $email, already: $already, team: $team)';
}


}

/// @nodoc
abstract mixin class _$SignupSentCopyWith<$Res> implements $SignupSentCopyWith<$Res> {
  factory _$SignupSentCopyWith(_SignupSent value, $Res Function(_SignupSent) _then) = __$SignupSentCopyWithImpl;
@override @useResult
$Res call({
 String email, bool already, SignupTeam team
});


@override $SignupTeamCopyWith<$Res> get team;

}
/// @nodoc
class __$SignupSentCopyWithImpl<$Res>
    implements _$SignupSentCopyWith<$Res> {
  __$SignupSentCopyWithImpl(this._self, this._then);

  final _SignupSent _self;
  final $Res Function(_SignupSent) _then;

/// Create a copy of SignupSent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? already = null,Object? team = null,}) {
  return _then(_SignupSent(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,already: null == already ? _self.already : already // ignore: cast_nullable_to_non_nullable
as bool,team: null == team ? _self.team : team // ignore: cast_nullable_to_non_nullable
as SignupTeam,
  ));
}

/// Create a copy of SignupSent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SignupTeamCopyWith<$Res> get team {
  
  return $SignupTeamCopyWith<$Res>(_self.team, (value) {
    return _then(_self.copyWith(team: value));
  });
}
}


/// @nodoc
mixin _$SignupRequested {

 String get sport; String get email;
/// Create a copy of SignupRequested
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupRequestedCopyWith<SignupRequested> get copyWith => _$SignupRequestedCopyWithImpl<SignupRequested>(this as SignupRequested, _$identity);

  /// Serializes this SignupRequested to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupRequested&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sport,email);

@override
String toString() {
  return 'SignupRequested(sport: $sport, email: $email)';
}


}

/// @nodoc
abstract mixin class $SignupRequestedCopyWith<$Res>  {
  factory $SignupRequestedCopyWith(SignupRequested value, $Res Function(SignupRequested) _then) = _$SignupRequestedCopyWithImpl;
@useResult
$Res call({
 String sport, String email
});




}
/// @nodoc
class _$SignupRequestedCopyWithImpl<$Res>
    implements $SignupRequestedCopyWith<$Res> {
  _$SignupRequestedCopyWithImpl(this._self, this._then);

  final SignupRequested _self;
  final $Res Function(SignupRequested) _then;

/// Create a copy of SignupRequested
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sport = null,Object? email = null,}) {
  return _then(_self.copyWith(
sport: null == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SignupRequested].
extension SignupRequestedPatterns on SignupRequested {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignupRequested value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignupRequested() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignupRequested value)  $default,){
final _that = this;
switch (_that) {
case _SignupRequested():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignupRequested value)?  $default,){
final _that = this;
switch (_that) {
case _SignupRequested() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sport,  String email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignupRequested() when $default != null:
return $default(_that.sport,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sport,  String email)  $default,) {final _that = this;
switch (_that) {
case _SignupRequested():
return $default(_that.sport,_that.email);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sport,  String email)?  $default,) {final _that = this;
switch (_that) {
case _SignupRequested() when $default != null:
return $default(_that.sport,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignupRequested implements SignupRequested {
  const _SignupRequested({this.sport = '', this.email = ''});
  factory _SignupRequested.fromJson(Map<String, dynamic> json) => _$SignupRequestedFromJson(json);

@override@JsonKey() final  String sport;
@override@JsonKey() final  String email;

/// Create a copy of SignupRequested
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupRequestedCopyWith<_SignupRequested> get copyWith => __$SignupRequestedCopyWithImpl<_SignupRequested>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignupRequestedToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupRequested&&(identical(other.sport, sport) || other.sport == sport)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sport,email);

@override
String toString() {
  return 'SignupRequested(sport: $sport, email: $email)';
}


}

/// @nodoc
abstract mixin class _$SignupRequestedCopyWith<$Res> implements $SignupRequestedCopyWith<$Res> {
  factory _$SignupRequestedCopyWith(_SignupRequested value, $Res Function(_SignupRequested) _then) = __$SignupRequestedCopyWithImpl;
@override @useResult
$Res call({
 String sport, String email
});




}
/// @nodoc
class __$SignupRequestedCopyWithImpl<$Res>
    implements _$SignupRequestedCopyWith<$Res> {
  __$SignupRequestedCopyWithImpl(this._self, this._then);

  final _SignupRequested _self;
  final $Res Function(_SignupRequested) _then;

/// Create a copy of SignupRequested
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sport = null,Object? email = null,}) {
  return _then(_SignupRequested(
sport: null == sport ? _self.sport : sport // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SignupTraining {

 int get weekday; String get startsAt; String get endsAt; String get venue;
/// Create a copy of SignupTraining
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupTrainingCopyWith<SignupTraining> get copyWith => _$SignupTrainingCopyWithImpl<SignupTraining>(this as SignupTraining, _$identity);

  /// Serializes this SignupTraining to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupTraining&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.venue, venue) || other.venue == venue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekday,startsAt,endsAt,venue);

@override
String toString() {
  return 'SignupTraining(weekday: $weekday, startsAt: $startsAt, endsAt: $endsAt, venue: $venue)';
}


}

/// @nodoc
abstract mixin class $SignupTrainingCopyWith<$Res>  {
  factory $SignupTrainingCopyWith(SignupTraining value, $Res Function(SignupTraining) _then) = _$SignupTrainingCopyWithImpl;
@useResult
$Res call({
 int weekday, String startsAt, String endsAt, String venue
});




}
/// @nodoc
class _$SignupTrainingCopyWithImpl<$Res>
    implements $SignupTrainingCopyWith<$Res> {
  _$SignupTrainingCopyWithImpl(this._self, this._then);

  final SignupTraining _self;
  final $Res Function(SignupTraining) _then;

/// Create a copy of SignupTraining
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekday = null,Object? startsAt = null,Object? endsAt = null,Object? venue = null,}) {
  return _then(_self.copyWith(
weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SignupTraining].
extension SignupTrainingPatterns on SignupTraining {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignupTraining value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignupTraining() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignupTraining value)  $default,){
final _that = this;
switch (_that) {
case _SignupTraining():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignupTraining value)?  $default,){
final _that = this;
switch (_that) {
case _SignupTraining() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int weekday,  String startsAt,  String endsAt,  String venue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignupTraining() when $default != null:
return $default(_that.weekday,_that.startsAt,_that.endsAt,_that.venue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int weekday,  String startsAt,  String endsAt,  String venue)  $default,) {final _that = this;
switch (_that) {
case _SignupTraining():
return $default(_that.weekday,_that.startsAt,_that.endsAt,_that.venue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int weekday,  String startsAt,  String endsAt,  String venue)?  $default,) {final _that = this;
switch (_that) {
case _SignupTraining() when $default != null:
return $default(_that.weekday,_that.startsAt,_that.endsAt,_that.venue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignupTraining extends SignupTraining {
  const _SignupTraining({required this.weekday, this.startsAt = '19:30', this.endsAt = '21:00', this.venue = ''}): super._();
  factory _SignupTraining.fromJson(Map<String, dynamic> json) => _$SignupTrainingFromJson(json);

@override final  int weekday;
@override@JsonKey() final  String startsAt;
@override@JsonKey() final  String endsAt;
@override@JsonKey() final  String venue;

/// Create a copy of SignupTraining
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupTrainingCopyWith<_SignupTraining> get copyWith => __$SignupTrainingCopyWithImpl<_SignupTraining>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignupTrainingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupTraining&&(identical(other.weekday, weekday) || other.weekday == weekday)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.venue, venue) || other.venue == venue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weekday,startsAt,endsAt,venue);

@override
String toString() {
  return 'SignupTraining(weekday: $weekday, startsAt: $startsAt, endsAt: $endsAt, venue: $venue)';
}


}

/// @nodoc
abstract mixin class _$SignupTrainingCopyWith<$Res> implements $SignupTrainingCopyWith<$Res> {
  factory _$SignupTrainingCopyWith(_SignupTraining value, $Res Function(_SignupTraining) _then) = __$SignupTrainingCopyWithImpl;
@override @useResult
$Res call({
 int weekday, String startsAt, String endsAt, String venue
});




}
/// @nodoc
class __$SignupTrainingCopyWithImpl<$Res>
    implements _$SignupTrainingCopyWith<$Res> {
  __$SignupTrainingCopyWithImpl(this._self, this._then);

  final _SignupTraining _self;
  final $Res Function(_SignupTraining) _then;

/// Create a copy of SignupTraining
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekday = null,Object? startsAt = null,Object? endsAt = null,Object? venue = null,}) {
  return _then(_SignupTraining(
weekday: null == weekday ? _self.weekday : weekday // ignore: cast_nullable_to_non_nullable
as int,startsAt: null == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String,endsAt: null == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String,venue: null == venue ? _self.venue : venue // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
