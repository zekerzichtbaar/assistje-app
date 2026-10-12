// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'savings_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavingsPotSummary {

 int get id; String get name; int get amountCents; int? get goalCents; int get months; int get memberCount; int get savedCents;
/// Create a copy of SavingsPotSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavingsPotSummaryCopyWith<SavingsPotSummary> get copyWith => _$SavingsPotSummaryCopyWithImpl<SavingsPotSummary>(this as SavingsPotSummary, _$identity);

  /// Serializes this SavingsPotSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavingsPotSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.goalCents, goalCents) || other.goalCents == goalCents)&&(identical(other.months, months) || other.months == months)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.savedCents, savedCents) || other.savedCents == savedCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,amountCents,goalCents,months,memberCount,savedCents);

@override
String toString() {
  return 'SavingsPotSummary(id: $id, name: $name, amountCents: $amountCents, goalCents: $goalCents, months: $months, memberCount: $memberCount, savedCents: $savedCents)';
}


}

/// @nodoc
abstract mixin class $SavingsPotSummaryCopyWith<$Res>  {
  factory $SavingsPotSummaryCopyWith(SavingsPotSummary value, $Res Function(SavingsPotSummary) _then) = _$SavingsPotSummaryCopyWithImpl;
@useResult
$Res call({
 int id, String name, int amountCents, int? goalCents, int months, int memberCount, int savedCents
});




}
/// @nodoc
class _$SavingsPotSummaryCopyWithImpl<$Res>
    implements $SavingsPotSummaryCopyWith<$Res> {
  _$SavingsPotSummaryCopyWithImpl(this._self, this._then);

  final SavingsPotSummary _self;
  final $Res Function(SavingsPotSummary) _then;

/// Create a copy of SavingsPotSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? amountCents = null,Object? goalCents = freezed,Object? months = null,Object? memberCount = null,Object? savedCents = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,goalCents: freezed == goalCents ? _self.goalCents : goalCents // ignore: cast_nullable_to_non_nullable
as int?,months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,savedCents: null == savedCents ? _self.savedCents : savedCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SavingsPotSummary].
extension SavingsPotSummaryPatterns on SavingsPotSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavingsPotSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavingsPotSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavingsPotSummary value)  $default,){
final _that = this;
switch (_that) {
case _SavingsPotSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavingsPotSummary value)?  $default,){
final _that = this;
switch (_that) {
case _SavingsPotSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int amountCents,  int? goalCents,  int months,  int memberCount,  int savedCents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavingsPotSummary() when $default != null:
return $default(_that.id,_that.name,_that.amountCents,_that.goalCents,_that.months,_that.memberCount,_that.savedCents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int amountCents,  int? goalCents,  int months,  int memberCount,  int savedCents)  $default,) {final _that = this;
switch (_that) {
case _SavingsPotSummary():
return $default(_that.id,_that.name,_that.amountCents,_that.goalCents,_that.months,_that.memberCount,_that.savedCents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int amountCents,  int? goalCents,  int months,  int memberCount,  int savedCents)?  $default,) {final _that = this;
switch (_that) {
case _SavingsPotSummary() when $default != null:
return $default(_that.id,_that.name,_that.amountCents,_that.goalCents,_that.months,_that.memberCount,_that.savedCents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavingsPotSummary extends SavingsPotSummary {
  const _SavingsPotSummary({required this.id, this.name = '', this.amountCents = 0, this.goalCents, this.months = 1, this.memberCount = 0, this.savedCents = 0}): super._();
  factory _SavingsPotSummary.fromJson(Map<String, dynamic> json) => _$SavingsPotSummaryFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override@JsonKey() final  int amountCents;
@override final  int? goalCents;
@override@JsonKey() final  int months;
@override@JsonKey() final  int memberCount;
@override@JsonKey() final  int savedCents;

/// Create a copy of SavingsPotSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingsPotSummaryCopyWith<_SavingsPotSummary> get copyWith => __$SavingsPotSummaryCopyWithImpl<_SavingsPotSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavingsPotSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingsPotSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.goalCents, goalCents) || other.goalCents == goalCents)&&(identical(other.months, months) || other.months == months)&&(identical(other.memberCount, memberCount) || other.memberCount == memberCount)&&(identical(other.savedCents, savedCents) || other.savedCents == savedCents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,amountCents,goalCents,months,memberCount,savedCents);

@override
String toString() {
  return 'SavingsPotSummary(id: $id, name: $name, amountCents: $amountCents, goalCents: $goalCents, months: $months, memberCount: $memberCount, savedCents: $savedCents)';
}


}

/// @nodoc
abstract mixin class _$SavingsPotSummaryCopyWith<$Res> implements $SavingsPotSummaryCopyWith<$Res> {
  factory _$SavingsPotSummaryCopyWith(_SavingsPotSummary value, $Res Function(_SavingsPotSummary) _then) = __$SavingsPotSummaryCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int amountCents, int? goalCents, int months, int memberCount, int savedCents
});




}
/// @nodoc
class __$SavingsPotSummaryCopyWithImpl<$Res>
    implements _$SavingsPotSummaryCopyWith<$Res> {
  __$SavingsPotSummaryCopyWithImpl(this._self, this._then);

  final _SavingsPotSummary _self;
  final $Res Function(_SavingsPotSummary) _then;

/// Create a copy of SavingsPotSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? amountCents = null,Object? goalCents = freezed,Object? months = null,Object? memberCount = null,Object? savedCents = null,}) {
  return _then(_SavingsPotSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,goalCents: freezed == goalCents ? _self.goalCents : goalCents // ignore: cast_nullable_to_non_nullable
as int?,months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as int,memberCount: null == memberCount ? _self.memberCount : memberCount // ignore: cast_nullable_to_non_nullable
as int,savedCents: null == savedCents ? _self.savedCents : savedCents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SavingsOverview {

 List<SavingsPotSummary> get pots; bool get canManage;
/// Create a copy of SavingsOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavingsOverviewCopyWith<SavingsOverview> get copyWith => _$SavingsOverviewCopyWithImpl<SavingsOverview>(this as SavingsOverview, _$identity);

  /// Serializes this SavingsOverview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavingsOverview&&const DeepCollectionEquality().equals(other.pots, pots)&&(identical(other.canManage, canManage) || other.canManage == canManage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(pots),canManage);

@override
String toString() {
  return 'SavingsOverview(pots: $pots, canManage: $canManage)';
}


}

/// @nodoc
abstract mixin class $SavingsOverviewCopyWith<$Res>  {
  factory $SavingsOverviewCopyWith(SavingsOverview value, $Res Function(SavingsOverview) _then) = _$SavingsOverviewCopyWithImpl;
@useResult
$Res call({
 List<SavingsPotSummary> pots, bool canManage
});




}
/// @nodoc
class _$SavingsOverviewCopyWithImpl<$Res>
    implements $SavingsOverviewCopyWith<$Res> {
  _$SavingsOverviewCopyWithImpl(this._self, this._then);

  final SavingsOverview _self;
  final $Res Function(SavingsOverview) _then;

/// Create a copy of SavingsOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pots = null,Object? canManage = null,}) {
  return _then(_self.copyWith(
pots: null == pots ? _self.pots : pots // ignore: cast_nullable_to_non_nullable
as List<SavingsPotSummary>,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SavingsOverview].
extension SavingsOverviewPatterns on SavingsOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavingsOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavingsOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavingsOverview value)  $default,){
final _that = this;
switch (_that) {
case _SavingsOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavingsOverview value)?  $default,){
final _that = this;
switch (_that) {
case _SavingsOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SavingsPotSummary> pots,  bool canManage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavingsOverview() when $default != null:
return $default(_that.pots,_that.canManage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SavingsPotSummary> pots,  bool canManage)  $default,) {final _that = this;
switch (_that) {
case _SavingsOverview():
return $default(_that.pots,_that.canManage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SavingsPotSummary> pots,  bool canManage)?  $default,) {final _that = this;
switch (_that) {
case _SavingsOverview() when $default != null:
return $default(_that.pots,_that.canManage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavingsOverview implements SavingsOverview {
  const _SavingsOverview({final  List<SavingsPotSummary> pots = const <SavingsPotSummary>[], this.canManage = false}): _pots = pots;
  factory _SavingsOverview.fromJson(Map<String, dynamic> json) => _$SavingsOverviewFromJson(json);

 final  List<SavingsPotSummary> _pots;
@override@JsonKey() List<SavingsPotSummary> get pots {
  if (_pots is EqualUnmodifiableListView) return _pots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pots);
}

@override@JsonKey() final  bool canManage;

/// Create a copy of SavingsOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingsOverviewCopyWith<_SavingsOverview> get copyWith => __$SavingsOverviewCopyWithImpl<_SavingsOverview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavingsOverviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingsOverview&&const DeepCollectionEquality().equals(other._pots, _pots)&&(identical(other.canManage, canManage) || other.canManage == canManage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_pots),canManage);

@override
String toString() {
  return 'SavingsOverview(pots: $pots, canManage: $canManage)';
}


}

/// @nodoc
abstract mixin class _$SavingsOverviewCopyWith<$Res> implements $SavingsOverviewCopyWith<$Res> {
  factory _$SavingsOverviewCopyWith(_SavingsOverview value, $Res Function(_SavingsOverview) _then) = __$SavingsOverviewCopyWithImpl;
@override @useResult
$Res call({
 List<SavingsPotSummary> pots, bool canManage
});




}
/// @nodoc
class __$SavingsOverviewCopyWithImpl<$Res>
    implements _$SavingsOverviewCopyWith<$Res> {
  __$SavingsOverviewCopyWithImpl(this._self, this._then);

  final _SavingsOverview _self;
  final $Res Function(_SavingsOverview) _then;

/// Create a copy of SavingsOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pots = null,Object? canManage = null,}) {
  return _then(_SavingsOverview(
pots: null == pots ? _self._pots : pots // ignore: cast_nullable_to_non_nullable
as List<SavingsPotSummary>,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SavingsEvent {

 int get id; String get title; DateTime? get startsAt; bool get cancelled;
/// Create a copy of SavingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavingsEventCopyWith<SavingsEvent> get copyWith => _$SavingsEventCopyWithImpl<SavingsEvent>(this as SavingsEvent, _$identity);

  /// Serializes this SavingsEvent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavingsEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.cancelled, cancelled) || other.cancelled == cancelled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt,cancelled);

@override
String toString() {
  return 'SavingsEvent(id: $id, title: $title, startsAt: $startsAt, cancelled: $cancelled)';
}


}

/// @nodoc
abstract mixin class $SavingsEventCopyWith<$Res>  {
  factory $SavingsEventCopyWith(SavingsEvent value, $Res Function(SavingsEvent) _then) = _$SavingsEventCopyWithImpl;
@useResult
$Res call({
 int id, String title, DateTime? startsAt, bool cancelled
});




}
/// @nodoc
class _$SavingsEventCopyWithImpl<$Res>
    implements $SavingsEventCopyWith<$Res> {
  _$SavingsEventCopyWithImpl(this._self, this._then);

  final SavingsEvent _self;
  final $Res Function(SavingsEvent) _then;

/// Create a copy of SavingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,Object? cancelled = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelled: null == cancelled ? _self.cancelled : cancelled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SavingsEvent].
extension SavingsEventPatterns on SavingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavingsEvent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavingsEvent() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavingsEvent value)  $default,){
final _that = this;
switch (_that) {
case _SavingsEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavingsEvent value)?  $default,){
final _that = this;
switch (_that) {
case _SavingsEvent() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  DateTime? startsAt,  bool cancelled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavingsEvent() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.cancelled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  DateTime? startsAt,  bool cancelled)  $default,) {final _that = this;
switch (_that) {
case _SavingsEvent():
return $default(_that.id,_that.title,_that.startsAt,_that.cancelled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  DateTime? startsAt,  bool cancelled)?  $default,) {final _that = this;
switch (_that) {
case _SavingsEvent() when $default != null:
return $default(_that.id,_that.title,_that.startsAt,_that.cancelled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavingsEvent implements SavingsEvent {
  const _SavingsEvent({required this.id, this.title = '', this.startsAt, this.cancelled = false});
  factory _SavingsEvent.fromJson(Map<String, dynamic> json) => _$SavingsEventFromJson(json);

@override final  int id;
@override@JsonKey() final  String title;
@override final  DateTime? startsAt;
@override@JsonKey() final  bool cancelled;

/// Create a copy of SavingsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingsEventCopyWith<_SavingsEvent> get copyWith => __$SavingsEventCopyWithImpl<_SavingsEvent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavingsEventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingsEvent&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.cancelled, cancelled) || other.cancelled == cancelled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,startsAt,cancelled);

@override
String toString() {
  return 'SavingsEvent(id: $id, title: $title, startsAt: $startsAt, cancelled: $cancelled)';
}


}

/// @nodoc
abstract mixin class _$SavingsEventCopyWith<$Res> implements $SavingsEventCopyWith<$Res> {
  factory _$SavingsEventCopyWith(_SavingsEvent value, $Res Function(_SavingsEvent) _then) = __$SavingsEventCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, DateTime? startsAt, bool cancelled
});




}
/// @nodoc
class __$SavingsEventCopyWithImpl<$Res>
    implements _$SavingsEventCopyWith<$Res> {
  __$SavingsEventCopyWithImpl(this._self, this._then);

  final _SavingsEvent _self;
  final $Res Function(_SavingsEvent) _then;

/// Create a copy of SavingsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? startsAt = freezed,Object? cancelled = null,}) {
  return _then(_SavingsEvent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelled: null == cancelled ? _self.cancelled : cancelled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SavingsPot {

 int get id; String get name; int get amountCents; int? get goalCents; int get months; DateTime? get startsOn;@JsonKey(unknownEnumValue: SavingsScope.unknown) SavingsScope get scope; bool get oneOff; SavingsEvent? get event; int? get actualCostCents; DateTime? get settledOn;
/// Create a copy of SavingsPot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavingsPotCopyWith<SavingsPot> get copyWith => _$SavingsPotCopyWithImpl<SavingsPot>(this as SavingsPot, _$identity);

  /// Serializes this SavingsPot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavingsPot&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.goalCents, goalCents) || other.goalCents == goalCents)&&(identical(other.months, months) || other.months == months)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.oneOff, oneOff) || other.oneOff == oneOff)&&(identical(other.event, event) || other.event == event)&&(identical(other.actualCostCents, actualCostCents) || other.actualCostCents == actualCostCents)&&(identical(other.settledOn, settledOn) || other.settledOn == settledOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,amountCents,goalCents,months,startsOn,scope,oneOff,event,actualCostCents,settledOn);

@override
String toString() {
  return 'SavingsPot(id: $id, name: $name, amountCents: $amountCents, goalCents: $goalCents, months: $months, startsOn: $startsOn, scope: $scope, oneOff: $oneOff, event: $event, actualCostCents: $actualCostCents, settledOn: $settledOn)';
}


}

/// @nodoc
abstract mixin class $SavingsPotCopyWith<$Res>  {
  factory $SavingsPotCopyWith(SavingsPot value, $Res Function(SavingsPot) _then) = _$SavingsPotCopyWithImpl;
@useResult
$Res call({
 int id, String name, int amountCents, int? goalCents, int months, DateTime? startsOn,@JsonKey(unknownEnumValue: SavingsScope.unknown) SavingsScope scope, bool oneOff, SavingsEvent? event, int? actualCostCents, DateTime? settledOn
});


$SavingsEventCopyWith<$Res>? get event;

}
/// @nodoc
class _$SavingsPotCopyWithImpl<$Res>
    implements $SavingsPotCopyWith<$Res> {
  _$SavingsPotCopyWithImpl(this._self, this._then);

  final SavingsPot _self;
  final $Res Function(SavingsPot) _then;

/// Create a copy of SavingsPot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? amountCents = null,Object? goalCents = freezed,Object? months = null,Object? startsOn = freezed,Object? scope = null,Object? oneOff = null,Object? event = freezed,Object? actualCostCents = freezed,Object? settledOn = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,goalCents: freezed == goalCents ? _self.goalCents : goalCents // ignore: cast_nullable_to_non_nullable
as int?,months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as int,startsOn: freezed == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime?,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as SavingsScope,oneOff: null == oneOff ? _self.oneOff : oneOff // ignore: cast_nullable_to_non_nullable
as bool,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as SavingsEvent?,actualCostCents: freezed == actualCostCents ? _self.actualCostCents : actualCostCents // ignore: cast_nullable_to_non_nullable
as int?,settledOn: freezed == settledOn ? _self.settledOn : settledOn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of SavingsPot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavingsEventCopyWith<$Res>? get event {
    if (_self.event == null) {
    return null;
  }

  return $SavingsEventCopyWith<$Res>(_self.event!, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// Adds pattern-matching-related methods to [SavingsPot].
extension SavingsPotPatterns on SavingsPot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavingsPot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavingsPot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavingsPot value)  $default,){
final _that = this;
switch (_that) {
case _SavingsPot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavingsPot value)?  $default,){
final _that = this;
switch (_that) {
case _SavingsPot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  int amountCents,  int? goalCents,  int months,  DateTime? startsOn, @JsonKey(unknownEnumValue: SavingsScope.unknown)  SavingsScope scope,  bool oneOff,  SavingsEvent? event,  int? actualCostCents,  DateTime? settledOn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavingsPot() when $default != null:
return $default(_that.id,_that.name,_that.amountCents,_that.goalCents,_that.months,_that.startsOn,_that.scope,_that.oneOff,_that.event,_that.actualCostCents,_that.settledOn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  int amountCents,  int? goalCents,  int months,  DateTime? startsOn, @JsonKey(unknownEnumValue: SavingsScope.unknown)  SavingsScope scope,  bool oneOff,  SavingsEvent? event,  int? actualCostCents,  DateTime? settledOn)  $default,) {final _that = this;
switch (_that) {
case _SavingsPot():
return $default(_that.id,_that.name,_that.amountCents,_that.goalCents,_that.months,_that.startsOn,_that.scope,_that.oneOff,_that.event,_that.actualCostCents,_that.settledOn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  int amountCents,  int? goalCents,  int months,  DateTime? startsOn, @JsonKey(unknownEnumValue: SavingsScope.unknown)  SavingsScope scope,  bool oneOff,  SavingsEvent? event,  int? actualCostCents,  DateTime? settledOn)?  $default,) {final _that = this;
switch (_that) {
case _SavingsPot() when $default != null:
return $default(_that.id,_that.name,_that.amountCents,_that.goalCents,_that.months,_that.startsOn,_that.scope,_that.oneOff,_that.event,_that.actualCostCents,_that.settledOn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavingsPot extends SavingsPot {
  const _SavingsPot({required this.id, this.name = '', this.amountCents = 0, this.goalCents, this.months = 1, this.startsOn, @JsonKey(unknownEnumValue: SavingsScope.unknown) this.scope = SavingsScope.all, this.oneOff = false, this.event, this.actualCostCents, this.settledOn}): super._();
  factory _SavingsPot.fromJson(Map<String, dynamic> json) => _$SavingsPotFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override@JsonKey() final  int amountCents;
@override final  int? goalCents;
@override@JsonKey() final  int months;
@override final  DateTime? startsOn;
@override@JsonKey(unknownEnumValue: SavingsScope.unknown) final  SavingsScope scope;
@override@JsonKey() final  bool oneOff;
@override final  SavingsEvent? event;
@override final  int? actualCostCents;
@override final  DateTime? settledOn;

/// Create a copy of SavingsPot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingsPotCopyWith<_SavingsPot> get copyWith => __$SavingsPotCopyWithImpl<_SavingsPot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavingsPotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingsPot&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.amountCents, amountCents) || other.amountCents == amountCents)&&(identical(other.goalCents, goalCents) || other.goalCents == goalCents)&&(identical(other.months, months) || other.months == months)&&(identical(other.startsOn, startsOn) || other.startsOn == startsOn)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.oneOff, oneOff) || other.oneOff == oneOff)&&(identical(other.event, event) || other.event == event)&&(identical(other.actualCostCents, actualCostCents) || other.actualCostCents == actualCostCents)&&(identical(other.settledOn, settledOn) || other.settledOn == settledOn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,amountCents,goalCents,months,startsOn,scope,oneOff,event,actualCostCents,settledOn);

@override
String toString() {
  return 'SavingsPot(id: $id, name: $name, amountCents: $amountCents, goalCents: $goalCents, months: $months, startsOn: $startsOn, scope: $scope, oneOff: $oneOff, event: $event, actualCostCents: $actualCostCents, settledOn: $settledOn)';
}


}

/// @nodoc
abstract mixin class _$SavingsPotCopyWith<$Res> implements $SavingsPotCopyWith<$Res> {
  factory _$SavingsPotCopyWith(_SavingsPot value, $Res Function(_SavingsPot) _then) = __$SavingsPotCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, int amountCents, int? goalCents, int months, DateTime? startsOn,@JsonKey(unknownEnumValue: SavingsScope.unknown) SavingsScope scope, bool oneOff, SavingsEvent? event, int? actualCostCents, DateTime? settledOn
});


@override $SavingsEventCopyWith<$Res>? get event;

}
/// @nodoc
class __$SavingsPotCopyWithImpl<$Res>
    implements _$SavingsPotCopyWith<$Res> {
  __$SavingsPotCopyWithImpl(this._self, this._then);

  final _SavingsPot _self;
  final $Res Function(_SavingsPot) _then;

/// Create a copy of SavingsPot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? amountCents = null,Object? goalCents = freezed,Object? months = null,Object? startsOn = freezed,Object? scope = null,Object? oneOff = null,Object? event = freezed,Object? actualCostCents = freezed,Object? settledOn = freezed,}) {
  return _then(_SavingsPot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amountCents: null == amountCents ? _self.amountCents : amountCents // ignore: cast_nullable_to_non_nullable
as int,goalCents: freezed == goalCents ? _self.goalCents : goalCents // ignore: cast_nullable_to_non_nullable
as int?,months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as int,startsOn: freezed == startsOn ? _self.startsOn : startsOn // ignore: cast_nullable_to_non_nullable
as DateTime?,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as SavingsScope,oneOff: null == oneOff ? _self.oneOff : oneOff // ignore: cast_nullable_to_non_nullable
as bool,event: freezed == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as SavingsEvent?,actualCostCents: freezed == actualCostCents ? _self.actualCostCents : actualCostCents // ignore: cast_nullable_to_non_nullable
as int?,settledOn: freezed == settledOn ? _self.settledOn : settledOn // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of SavingsPot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavingsEventCopyWith<$Res>? get event {
    if (_self.event == null) {
    return null;
  }

  return $SavingsEventCopyWith<$Res>(_self.event!, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// @nodoc
mixin _$SavingsParticipant {

/// `p<player_id>` of `u<user_id>`.
 String get key; String get name;@JsonKey(unknownEnumValue: SavingsParticipantKind.unknown) SavingsParticipantKind get kind; int? get shirtNumber;/// Betaalde, maar doet niet (meer) mee: krijgt zijn inleg terug.
 bool get refund;@JsonKey(unknownEnumValue: SavingsRefundReason.unknown) SavingsRefundReason? get refundReason; bool get refunded;
/// Create a copy of SavingsParticipant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavingsParticipantCopyWith<SavingsParticipant> get copyWith => _$SavingsParticipantCopyWithImpl<SavingsParticipant>(this as SavingsParticipant, _$identity);

  /// Serializes this SavingsParticipant to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavingsParticipant&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.refund, refund) || other.refund == refund)&&(identical(other.refundReason, refundReason) || other.refundReason == refundReason)&&(identical(other.refunded, refunded) || other.refunded == refunded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name,kind,shirtNumber,refund,refundReason,refunded);

@override
String toString() {
  return 'SavingsParticipant(key: $key, name: $name, kind: $kind, shirtNumber: $shirtNumber, refund: $refund, refundReason: $refundReason, refunded: $refunded)';
}


}

/// @nodoc
abstract mixin class $SavingsParticipantCopyWith<$Res>  {
  factory $SavingsParticipantCopyWith(SavingsParticipant value, $Res Function(SavingsParticipant) _then) = _$SavingsParticipantCopyWithImpl;
@useResult
$Res call({
 String key, String name,@JsonKey(unknownEnumValue: SavingsParticipantKind.unknown) SavingsParticipantKind kind, int? shirtNumber, bool refund,@JsonKey(unknownEnumValue: SavingsRefundReason.unknown) SavingsRefundReason? refundReason, bool refunded
});




}
/// @nodoc
class _$SavingsParticipantCopyWithImpl<$Res>
    implements $SavingsParticipantCopyWith<$Res> {
  _$SavingsParticipantCopyWithImpl(this._self, this._then);

  final SavingsParticipant _self;
  final $Res Function(SavingsParticipant) _then;

/// Create a copy of SavingsParticipant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? name = null,Object? kind = null,Object? shirtNumber = freezed,Object? refund = null,Object? refundReason = freezed,Object? refunded = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SavingsParticipantKind,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,refund: null == refund ? _self.refund : refund // ignore: cast_nullable_to_non_nullable
as bool,refundReason: freezed == refundReason ? _self.refundReason : refundReason // ignore: cast_nullable_to_non_nullable
as SavingsRefundReason?,refunded: null == refunded ? _self.refunded : refunded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SavingsParticipant].
extension SavingsParticipantPatterns on SavingsParticipant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavingsParticipant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavingsParticipant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavingsParticipant value)  $default,){
final _that = this;
switch (_that) {
case _SavingsParticipant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavingsParticipant value)?  $default,){
final _that = this;
switch (_that) {
case _SavingsParticipant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String name, @JsonKey(unknownEnumValue: SavingsParticipantKind.unknown)  SavingsParticipantKind kind,  int? shirtNumber,  bool refund, @JsonKey(unknownEnumValue: SavingsRefundReason.unknown)  SavingsRefundReason? refundReason,  bool refunded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavingsParticipant() when $default != null:
return $default(_that.key,_that.name,_that.kind,_that.shirtNumber,_that.refund,_that.refundReason,_that.refunded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String name, @JsonKey(unknownEnumValue: SavingsParticipantKind.unknown)  SavingsParticipantKind kind,  int? shirtNumber,  bool refund, @JsonKey(unknownEnumValue: SavingsRefundReason.unknown)  SavingsRefundReason? refundReason,  bool refunded)  $default,) {final _that = this;
switch (_that) {
case _SavingsParticipant():
return $default(_that.key,_that.name,_that.kind,_that.shirtNumber,_that.refund,_that.refundReason,_that.refunded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String name, @JsonKey(unknownEnumValue: SavingsParticipantKind.unknown)  SavingsParticipantKind kind,  int? shirtNumber,  bool refund, @JsonKey(unknownEnumValue: SavingsRefundReason.unknown)  SavingsRefundReason? refundReason,  bool refunded)?  $default,) {final _that = this;
switch (_that) {
case _SavingsParticipant() when $default != null:
return $default(_that.key,_that.name,_that.kind,_that.shirtNumber,_that.refund,_that.refundReason,_that.refunded);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavingsParticipant extends SavingsParticipant {
  const _SavingsParticipant({required this.key, this.name = '', @JsonKey(unknownEnumValue: SavingsParticipantKind.unknown) this.kind = SavingsParticipantKind.player, this.shirtNumber, this.refund = false, @JsonKey(unknownEnumValue: SavingsRefundReason.unknown) this.refundReason, this.refunded = false}): super._();
  factory _SavingsParticipant.fromJson(Map<String, dynamic> json) => _$SavingsParticipantFromJson(json);

/// `p<player_id>` of `u<user_id>`.
@override final  String key;
@override@JsonKey() final  String name;
@override@JsonKey(unknownEnumValue: SavingsParticipantKind.unknown) final  SavingsParticipantKind kind;
@override final  int? shirtNumber;
/// Betaalde, maar doet niet (meer) mee: krijgt zijn inleg terug.
@override@JsonKey() final  bool refund;
@override@JsonKey(unknownEnumValue: SavingsRefundReason.unknown) final  SavingsRefundReason? refundReason;
@override@JsonKey() final  bool refunded;

/// Create a copy of SavingsParticipant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingsParticipantCopyWith<_SavingsParticipant> get copyWith => __$SavingsParticipantCopyWithImpl<_SavingsParticipant>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavingsParticipantToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingsParticipant&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.refund, refund) || other.refund == refund)&&(identical(other.refundReason, refundReason) || other.refundReason == refundReason)&&(identical(other.refunded, refunded) || other.refunded == refunded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name,kind,shirtNumber,refund,refundReason,refunded);

@override
String toString() {
  return 'SavingsParticipant(key: $key, name: $name, kind: $kind, shirtNumber: $shirtNumber, refund: $refund, refundReason: $refundReason, refunded: $refunded)';
}


}

/// @nodoc
abstract mixin class _$SavingsParticipantCopyWith<$Res> implements $SavingsParticipantCopyWith<$Res> {
  factory _$SavingsParticipantCopyWith(_SavingsParticipant value, $Res Function(_SavingsParticipant) _then) = __$SavingsParticipantCopyWithImpl;
@override @useResult
$Res call({
 String key, String name,@JsonKey(unknownEnumValue: SavingsParticipantKind.unknown) SavingsParticipantKind kind, int? shirtNumber, bool refund,@JsonKey(unknownEnumValue: SavingsRefundReason.unknown) SavingsRefundReason? refundReason, bool refunded
});




}
/// @nodoc
class __$SavingsParticipantCopyWithImpl<$Res>
    implements _$SavingsParticipantCopyWith<$Res> {
  __$SavingsParticipantCopyWithImpl(this._self, this._then);

  final _SavingsParticipant _self;
  final $Res Function(_SavingsParticipant) _then;

/// Create a copy of SavingsParticipant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? name = null,Object? kind = null,Object? shirtNumber = freezed,Object? refund = null,Object? refundReason = freezed,Object? refunded = null,}) {
  return _then(_SavingsParticipant(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as SavingsParticipantKind,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,refund: null == refund ? _self.refund : refund // ignore: cast_nullable_to_non_nullable
as bool,refundReason: freezed == refundReason ? _self.refundReason : refundReason // ignore: cast_nullable_to_non_nullable
as SavingsRefundReason?,refunded: null == refunded ? _self.refunded : refunded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SavingsPayment {

 String get key; String get ym; int get cents;
/// Create a copy of SavingsPayment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavingsPaymentCopyWith<SavingsPayment> get copyWith => _$SavingsPaymentCopyWithImpl<SavingsPayment>(this as SavingsPayment, _$identity);

  /// Serializes this SavingsPayment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavingsPayment&&(identical(other.key, key) || other.key == key)&&(identical(other.ym, ym) || other.ym == ym)&&(identical(other.cents, cents) || other.cents == cents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,ym,cents);

@override
String toString() {
  return 'SavingsPayment(key: $key, ym: $ym, cents: $cents)';
}


}

/// @nodoc
abstract mixin class $SavingsPaymentCopyWith<$Res>  {
  factory $SavingsPaymentCopyWith(SavingsPayment value, $Res Function(SavingsPayment) _then) = _$SavingsPaymentCopyWithImpl;
@useResult
$Res call({
 String key, String ym, int cents
});




}
/// @nodoc
class _$SavingsPaymentCopyWithImpl<$Res>
    implements $SavingsPaymentCopyWith<$Res> {
  _$SavingsPaymentCopyWithImpl(this._self, this._then);

  final SavingsPayment _self;
  final $Res Function(SavingsPayment) _then;

/// Create a copy of SavingsPayment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? ym = null,Object? cents = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,ym: null == ym ? _self.ym : ym // ignore: cast_nullable_to_non_nullable
as String,cents: null == cents ? _self.cents : cents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SavingsPayment].
extension SavingsPaymentPatterns on SavingsPayment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavingsPayment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavingsPayment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavingsPayment value)  $default,){
final _that = this;
switch (_that) {
case _SavingsPayment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavingsPayment value)?  $default,){
final _that = this;
switch (_that) {
case _SavingsPayment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String ym,  int cents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavingsPayment() when $default != null:
return $default(_that.key,_that.ym,_that.cents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String ym,  int cents)  $default,) {final _that = this;
switch (_that) {
case _SavingsPayment():
return $default(_that.key,_that.ym,_that.cents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String ym,  int cents)?  $default,) {final _that = this;
switch (_that) {
case _SavingsPayment() when $default != null:
return $default(_that.key,_that.ym,_that.cents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavingsPayment implements SavingsPayment {
  const _SavingsPayment({required this.key, required this.ym, this.cents = 0});
  factory _SavingsPayment.fromJson(Map<String, dynamic> json) => _$SavingsPaymentFromJson(json);

@override final  String key;
@override final  String ym;
@override@JsonKey() final  int cents;

/// Create a copy of SavingsPayment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingsPaymentCopyWith<_SavingsPayment> get copyWith => __$SavingsPaymentCopyWithImpl<_SavingsPayment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavingsPaymentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingsPayment&&(identical(other.key, key) || other.key == key)&&(identical(other.ym, ym) || other.ym == ym)&&(identical(other.cents, cents) || other.cents == cents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,ym,cents);

@override
String toString() {
  return 'SavingsPayment(key: $key, ym: $ym, cents: $cents)';
}


}

/// @nodoc
abstract mixin class _$SavingsPaymentCopyWith<$Res> implements $SavingsPaymentCopyWith<$Res> {
  factory _$SavingsPaymentCopyWith(_SavingsPayment value, $Res Function(_SavingsPayment) _then) = __$SavingsPaymentCopyWithImpl;
@override @useResult
$Res call({
 String key, String ym, int cents
});




}
/// @nodoc
class __$SavingsPaymentCopyWithImpl<$Res>
    implements _$SavingsPaymentCopyWith<$Res> {
  __$SavingsPaymentCopyWithImpl(this._self, this._then);

  final _SavingsPayment _self;
  final $Res Function(_SavingsPayment) _then;

/// Create a copy of SavingsPayment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? ym = null,Object? cents = null,}) {
  return _then(_SavingsPayment(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,ym: null == ym ? _self.ym : ym // ignore: cast_nullable_to_non_nullable
as String,cents: null == cents ? _self.cents : cents // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SavingsPotDetail {

 SavingsPot get pot; bool get finesEnabled; List<String> get periods; List<SavingsParticipant> get participants; List<SavingsPayment> get payments; bool get canManage;
/// Create a copy of SavingsPotDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavingsPotDetailCopyWith<SavingsPotDetail> get copyWith => _$SavingsPotDetailCopyWithImpl<SavingsPotDetail>(this as SavingsPotDetail, _$identity);

  /// Serializes this SavingsPotDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavingsPotDetail&&(identical(other.pot, pot) || other.pot == pot)&&(identical(other.finesEnabled, finesEnabled) || other.finesEnabled == finesEnabled)&&const DeepCollectionEquality().equals(other.periods, periods)&&const DeepCollectionEquality().equals(other.participants, participants)&&const DeepCollectionEquality().equals(other.payments, payments)&&(identical(other.canManage, canManage) || other.canManage == canManage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pot,finesEnabled,const DeepCollectionEquality().hash(periods),const DeepCollectionEquality().hash(participants),const DeepCollectionEquality().hash(payments),canManage);

@override
String toString() {
  return 'SavingsPotDetail(pot: $pot, finesEnabled: $finesEnabled, periods: $periods, participants: $participants, payments: $payments, canManage: $canManage)';
}


}

/// @nodoc
abstract mixin class $SavingsPotDetailCopyWith<$Res>  {
  factory $SavingsPotDetailCopyWith(SavingsPotDetail value, $Res Function(SavingsPotDetail) _then) = _$SavingsPotDetailCopyWithImpl;
@useResult
$Res call({
 SavingsPot pot, bool finesEnabled, List<String> periods, List<SavingsParticipant> participants, List<SavingsPayment> payments, bool canManage
});


$SavingsPotCopyWith<$Res> get pot;

}
/// @nodoc
class _$SavingsPotDetailCopyWithImpl<$Res>
    implements $SavingsPotDetailCopyWith<$Res> {
  _$SavingsPotDetailCopyWithImpl(this._self, this._then);

  final SavingsPotDetail _self;
  final $Res Function(SavingsPotDetail) _then;

/// Create a copy of SavingsPotDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pot = null,Object? finesEnabled = null,Object? periods = null,Object? participants = null,Object? payments = null,Object? canManage = null,}) {
  return _then(_self.copyWith(
pot: null == pot ? _self.pot : pot // ignore: cast_nullable_to_non_nullable
as SavingsPot,finesEnabled: null == finesEnabled ? _self.finesEnabled : finesEnabled // ignore: cast_nullable_to_non_nullable
as bool,periods: null == periods ? _self.periods : periods // ignore: cast_nullable_to_non_nullable
as List<String>,participants: null == participants ? _self.participants : participants // ignore: cast_nullable_to_non_nullable
as List<SavingsParticipant>,payments: null == payments ? _self.payments : payments // ignore: cast_nullable_to_non_nullable
as List<SavingsPayment>,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SavingsPotDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavingsPotCopyWith<$Res> get pot {
  
  return $SavingsPotCopyWith<$Res>(_self.pot, (value) {
    return _then(_self.copyWith(pot: value));
  });
}
}


/// Adds pattern-matching-related methods to [SavingsPotDetail].
extension SavingsPotDetailPatterns on SavingsPotDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavingsPotDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavingsPotDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavingsPotDetail value)  $default,){
final _that = this;
switch (_that) {
case _SavingsPotDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavingsPotDetail value)?  $default,){
final _that = this;
switch (_that) {
case _SavingsPotDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SavingsPot pot,  bool finesEnabled,  List<String> periods,  List<SavingsParticipant> participants,  List<SavingsPayment> payments,  bool canManage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavingsPotDetail() when $default != null:
return $default(_that.pot,_that.finesEnabled,_that.periods,_that.participants,_that.payments,_that.canManage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SavingsPot pot,  bool finesEnabled,  List<String> periods,  List<SavingsParticipant> participants,  List<SavingsPayment> payments,  bool canManage)  $default,) {final _that = this;
switch (_that) {
case _SavingsPotDetail():
return $default(_that.pot,_that.finesEnabled,_that.periods,_that.participants,_that.payments,_that.canManage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SavingsPot pot,  bool finesEnabled,  List<String> periods,  List<SavingsParticipant> participants,  List<SavingsPayment> payments,  bool canManage)?  $default,) {final _that = this;
switch (_that) {
case _SavingsPotDetail() when $default != null:
return $default(_that.pot,_that.finesEnabled,_that.periods,_that.participants,_that.payments,_that.canManage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavingsPotDetail extends SavingsPotDetail {
  const _SavingsPotDetail({required this.pot, this.finesEnabled = false, final  List<String> periods = const <String>[], final  List<SavingsParticipant> participants = const <SavingsParticipant>[], final  List<SavingsPayment> payments = const <SavingsPayment>[], this.canManage = false}): _periods = periods,_participants = participants,_payments = payments,super._();
  factory _SavingsPotDetail.fromJson(Map<String, dynamic> json) => _$SavingsPotDetailFromJson(json);

@override final  SavingsPot pot;
@override@JsonKey() final  bool finesEnabled;
 final  List<String> _periods;
@override@JsonKey() List<String> get periods {
  if (_periods is EqualUnmodifiableListView) return _periods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_periods);
}

 final  List<SavingsParticipant> _participants;
@override@JsonKey() List<SavingsParticipant> get participants {
  if (_participants is EqualUnmodifiableListView) return _participants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participants);
}

 final  List<SavingsPayment> _payments;
@override@JsonKey() List<SavingsPayment> get payments {
  if (_payments is EqualUnmodifiableListView) return _payments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payments);
}

@override@JsonKey() final  bool canManage;

/// Create a copy of SavingsPotDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingsPotDetailCopyWith<_SavingsPotDetail> get copyWith => __$SavingsPotDetailCopyWithImpl<_SavingsPotDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavingsPotDetailToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingsPotDetail&&(identical(other.pot, pot) || other.pot == pot)&&(identical(other.finesEnabled, finesEnabled) || other.finesEnabled == finesEnabled)&&const DeepCollectionEquality().equals(other._periods, _periods)&&const DeepCollectionEquality().equals(other._participants, _participants)&&const DeepCollectionEquality().equals(other._payments, _payments)&&(identical(other.canManage, canManage) || other.canManage == canManage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pot,finesEnabled,const DeepCollectionEquality().hash(_periods),const DeepCollectionEquality().hash(_participants),const DeepCollectionEquality().hash(_payments),canManage);

@override
String toString() {
  return 'SavingsPotDetail(pot: $pot, finesEnabled: $finesEnabled, periods: $periods, participants: $participants, payments: $payments, canManage: $canManage)';
}


}

/// @nodoc
abstract mixin class _$SavingsPotDetailCopyWith<$Res> implements $SavingsPotDetailCopyWith<$Res> {
  factory _$SavingsPotDetailCopyWith(_SavingsPotDetail value, $Res Function(_SavingsPotDetail) _then) = __$SavingsPotDetailCopyWithImpl;
@override @useResult
$Res call({
 SavingsPot pot, bool finesEnabled, List<String> periods, List<SavingsParticipant> participants, List<SavingsPayment> payments, bool canManage
});


@override $SavingsPotCopyWith<$Res> get pot;

}
/// @nodoc
class __$SavingsPotDetailCopyWithImpl<$Res>
    implements _$SavingsPotDetailCopyWith<$Res> {
  __$SavingsPotDetailCopyWithImpl(this._self, this._then);

  final _SavingsPotDetail _self;
  final $Res Function(_SavingsPotDetail) _then;

/// Create a copy of SavingsPotDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pot = null,Object? finesEnabled = null,Object? periods = null,Object? participants = null,Object? payments = null,Object? canManage = null,}) {
  return _then(_SavingsPotDetail(
pot: null == pot ? _self.pot : pot // ignore: cast_nullable_to_non_nullable
as SavingsPot,finesEnabled: null == finesEnabled ? _self.finesEnabled : finesEnabled // ignore: cast_nullable_to_non_nullable
as bool,periods: null == periods ? _self._periods : periods // ignore: cast_nullable_to_non_nullable
as List<String>,participants: null == participants ? _self._participants : participants // ignore: cast_nullable_to_non_nullable
as List<SavingsParticipant>,payments: null == payments ? _self._payments : payments // ignore: cast_nullable_to_non_nullable
as List<SavingsPayment>,canManage: null == canManage ? _self.canManage : canManage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SavingsPotDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavingsPotCopyWith<$Res> get pot {
  
  return $SavingsPotCopyWith<$Res>(_self.pot, (value) {
    return _then(_self.copyWith(pot: value));
  });
}
}


/// @nodoc
mixin _$SavingsPlayerOption {

 String get key; String get name; int? get shirtNumber; bool get isGuest;
/// Create a copy of SavingsPlayerOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavingsPlayerOptionCopyWith<SavingsPlayerOption> get copyWith => _$SavingsPlayerOptionCopyWithImpl<SavingsPlayerOption>(this as SavingsPlayerOption, _$identity);

  /// Serializes this SavingsPlayerOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavingsPlayerOption&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name,shirtNumber,isGuest);

@override
String toString() {
  return 'SavingsPlayerOption(key: $key, name: $name, shirtNumber: $shirtNumber, isGuest: $isGuest)';
}


}

/// @nodoc
abstract mixin class $SavingsPlayerOptionCopyWith<$Res>  {
  factory $SavingsPlayerOptionCopyWith(SavingsPlayerOption value, $Res Function(SavingsPlayerOption) _then) = _$SavingsPlayerOptionCopyWithImpl;
@useResult
$Res call({
 String key, String name, int? shirtNumber, bool isGuest
});




}
/// @nodoc
class _$SavingsPlayerOptionCopyWithImpl<$Res>
    implements $SavingsPlayerOptionCopyWith<$Res> {
  _$SavingsPlayerOptionCopyWithImpl(this._self, this._then);

  final SavingsPlayerOption _self;
  final $Res Function(SavingsPlayerOption) _then;

/// Create a copy of SavingsPlayerOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? name = null,Object? shirtNumber = freezed,Object? isGuest = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SavingsPlayerOption].
extension SavingsPlayerOptionPatterns on SavingsPlayerOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavingsPlayerOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavingsPlayerOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavingsPlayerOption value)  $default,){
final _that = this;
switch (_that) {
case _SavingsPlayerOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavingsPlayerOption value)?  $default,){
final _that = this;
switch (_that) {
case _SavingsPlayerOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String name,  int? shirtNumber,  bool isGuest)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavingsPlayerOption() when $default != null:
return $default(_that.key,_that.name,_that.shirtNumber,_that.isGuest);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String name,  int? shirtNumber,  bool isGuest)  $default,) {final _that = this;
switch (_that) {
case _SavingsPlayerOption():
return $default(_that.key,_that.name,_that.shirtNumber,_that.isGuest);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String name,  int? shirtNumber,  bool isGuest)?  $default,) {final _that = this;
switch (_that) {
case _SavingsPlayerOption() when $default != null:
return $default(_that.key,_that.name,_that.shirtNumber,_that.isGuest);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavingsPlayerOption implements SavingsPlayerOption {
  const _SavingsPlayerOption({required this.key, this.name = '', this.shirtNumber, this.isGuest = false});
  factory _SavingsPlayerOption.fromJson(Map<String, dynamic> json) => _$SavingsPlayerOptionFromJson(json);

@override final  String key;
@override@JsonKey() final  String name;
@override final  int? shirtNumber;
@override@JsonKey() final  bool isGuest;

/// Create a copy of SavingsPlayerOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingsPlayerOptionCopyWith<_SavingsPlayerOption> get copyWith => __$SavingsPlayerOptionCopyWithImpl<_SavingsPlayerOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavingsPlayerOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingsPlayerOption&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name)&&(identical(other.shirtNumber, shirtNumber) || other.shirtNumber == shirtNumber)&&(identical(other.isGuest, isGuest) || other.isGuest == isGuest));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name,shirtNumber,isGuest);

@override
String toString() {
  return 'SavingsPlayerOption(key: $key, name: $name, shirtNumber: $shirtNumber, isGuest: $isGuest)';
}


}

/// @nodoc
abstract mixin class _$SavingsPlayerOptionCopyWith<$Res> implements $SavingsPlayerOptionCopyWith<$Res> {
  factory _$SavingsPlayerOptionCopyWith(_SavingsPlayerOption value, $Res Function(_SavingsPlayerOption) _then) = __$SavingsPlayerOptionCopyWithImpl;
@override @useResult
$Res call({
 String key, String name, int? shirtNumber, bool isGuest
});




}
/// @nodoc
class __$SavingsPlayerOptionCopyWithImpl<$Res>
    implements _$SavingsPlayerOptionCopyWith<$Res> {
  __$SavingsPlayerOptionCopyWithImpl(this._self, this._then);

  final _SavingsPlayerOption _self;
  final $Res Function(_SavingsPlayerOption) _then;

/// Create a copy of SavingsPlayerOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? name = null,Object? shirtNumber = freezed,Object? isGuest = null,}) {
  return _then(_SavingsPlayerOption(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,shirtNumber: freezed == shirtNumber ? _self.shirtNumber : shirtNumber // ignore: cast_nullable_to_non_nullable
as int?,isGuest: null == isGuest ? _self.isGuest : isGuest // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$SavingsStaffOption {

 String get key; String get name;
/// Create a copy of SavingsStaffOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavingsStaffOptionCopyWith<SavingsStaffOption> get copyWith => _$SavingsStaffOptionCopyWithImpl<SavingsStaffOption>(this as SavingsStaffOption, _$identity);

  /// Serializes this SavingsStaffOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavingsStaffOption&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name);

@override
String toString() {
  return 'SavingsStaffOption(key: $key, name: $name)';
}


}

/// @nodoc
abstract mixin class $SavingsStaffOptionCopyWith<$Res>  {
  factory $SavingsStaffOptionCopyWith(SavingsStaffOption value, $Res Function(SavingsStaffOption) _then) = _$SavingsStaffOptionCopyWithImpl;
@useResult
$Res call({
 String key, String name
});




}
/// @nodoc
class _$SavingsStaffOptionCopyWithImpl<$Res>
    implements $SavingsStaffOptionCopyWith<$Res> {
  _$SavingsStaffOptionCopyWithImpl(this._self, this._then);

  final SavingsStaffOption _self;
  final $Res Function(SavingsStaffOption) _then;

/// Create a copy of SavingsStaffOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? name = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SavingsStaffOption].
extension SavingsStaffOptionPatterns on SavingsStaffOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavingsStaffOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavingsStaffOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavingsStaffOption value)  $default,){
final _that = this;
switch (_that) {
case _SavingsStaffOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavingsStaffOption value)?  $default,){
final _that = this;
switch (_that) {
case _SavingsStaffOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavingsStaffOption() when $default != null:
return $default(_that.key,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String name)  $default,) {final _that = this;
switch (_that) {
case _SavingsStaffOption():
return $default(_that.key,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String name)?  $default,) {final _that = this;
switch (_that) {
case _SavingsStaffOption() when $default != null:
return $default(_that.key,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavingsStaffOption implements SavingsStaffOption {
  const _SavingsStaffOption({required this.key, this.name = ''});
  factory _SavingsStaffOption.fromJson(Map<String, dynamic> json) => _$SavingsStaffOptionFromJson(json);

@override final  String key;
@override@JsonKey() final  String name;

/// Create a copy of SavingsStaffOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingsStaffOptionCopyWith<_SavingsStaffOption> get copyWith => __$SavingsStaffOptionCopyWithImpl<_SavingsStaffOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavingsStaffOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingsStaffOption&&(identical(other.key, key) || other.key == key)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,name);

@override
String toString() {
  return 'SavingsStaffOption(key: $key, name: $name)';
}


}

/// @nodoc
abstract mixin class _$SavingsStaffOptionCopyWith<$Res> implements $SavingsStaffOptionCopyWith<$Res> {
  factory _$SavingsStaffOptionCopyWith(_SavingsStaffOption value, $Res Function(_SavingsStaffOption) _then) = __$SavingsStaffOptionCopyWithImpl;
@override @useResult
$Res call({
 String key, String name
});




}
/// @nodoc
class __$SavingsStaffOptionCopyWithImpl<$Res>
    implements _$SavingsStaffOptionCopyWith<$Res> {
  __$SavingsStaffOptionCopyWithImpl(this._self, this._then);

  final _SavingsStaffOption _self;
  final $Res Function(_SavingsStaffOption) _then;

/// Create a copy of SavingsStaffOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? name = null,}) {
  return _then(_SavingsStaffOption(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SavingsPeople {

 List<SavingsPlayerOption> get players; List<SavingsStaffOption> get staff;
/// Create a copy of SavingsPeople
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavingsPeopleCopyWith<SavingsPeople> get copyWith => _$SavingsPeopleCopyWithImpl<SavingsPeople>(this as SavingsPeople, _$identity);

  /// Serializes this SavingsPeople to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavingsPeople&&const DeepCollectionEquality().equals(other.players, players)&&const DeepCollectionEquality().equals(other.staff, staff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(players),const DeepCollectionEquality().hash(staff));

@override
String toString() {
  return 'SavingsPeople(players: $players, staff: $staff)';
}


}

/// @nodoc
abstract mixin class $SavingsPeopleCopyWith<$Res>  {
  factory $SavingsPeopleCopyWith(SavingsPeople value, $Res Function(SavingsPeople) _then) = _$SavingsPeopleCopyWithImpl;
@useResult
$Res call({
 List<SavingsPlayerOption> players, List<SavingsStaffOption> staff
});




}
/// @nodoc
class _$SavingsPeopleCopyWithImpl<$Res>
    implements $SavingsPeopleCopyWith<$Res> {
  _$SavingsPeopleCopyWithImpl(this._self, this._then);

  final SavingsPeople _self;
  final $Res Function(SavingsPeople) _then;

/// Create a copy of SavingsPeople
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? players = null,Object? staff = null,}) {
  return _then(_self.copyWith(
players: null == players ? _self.players : players // ignore: cast_nullable_to_non_nullable
as List<SavingsPlayerOption>,staff: null == staff ? _self.staff : staff // ignore: cast_nullable_to_non_nullable
as List<SavingsStaffOption>,
  ));
}

}


/// Adds pattern-matching-related methods to [SavingsPeople].
extension SavingsPeoplePatterns on SavingsPeople {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavingsPeople value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavingsPeople() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavingsPeople value)  $default,){
final _that = this;
switch (_that) {
case _SavingsPeople():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavingsPeople value)?  $default,){
final _that = this;
switch (_that) {
case _SavingsPeople() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SavingsPlayerOption> players,  List<SavingsStaffOption> staff)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavingsPeople() when $default != null:
return $default(_that.players,_that.staff);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SavingsPlayerOption> players,  List<SavingsStaffOption> staff)  $default,) {final _that = this;
switch (_that) {
case _SavingsPeople():
return $default(_that.players,_that.staff);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SavingsPlayerOption> players,  List<SavingsStaffOption> staff)?  $default,) {final _that = this;
switch (_that) {
case _SavingsPeople() when $default != null:
return $default(_that.players,_that.staff);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavingsPeople extends SavingsPeople {
  const _SavingsPeople({final  List<SavingsPlayerOption> players = const <SavingsPlayerOption>[], final  List<SavingsStaffOption> staff = const <SavingsStaffOption>[]}): _players = players,_staff = staff,super._();
  factory _SavingsPeople.fromJson(Map<String, dynamic> json) => _$SavingsPeopleFromJson(json);

 final  List<SavingsPlayerOption> _players;
@override@JsonKey() List<SavingsPlayerOption> get players {
  if (_players is EqualUnmodifiableListView) return _players;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_players);
}

 final  List<SavingsStaffOption> _staff;
@override@JsonKey() List<SavingsStaffOption> get staff {
  if (_staff is EqualUnmodifiableListView) return _staff;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_staff);
}


/// Create a copy of SavingsPeople
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingsPeopleCopyWith<_SavingsPeople> get copyWith => __$SavingsPeopleCopyWithImpl<_SavingsPeople>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavingsPeopleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingsPeople&&const DeepCollectionEquality().equals(other._players, _players)&&const DeepCollectionEquality().equals(other._staff, _staff));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_players),const DeepCollectionEquality().hash(_staff));

@override
String toString() {
  return 'SavingsPeople(players: $players, staff: $staff)';
}


}

/// @nodoc
abstract mixin class _$SavingsPeopleCopyWith<$Res> implements $SavingsPeopleCopyWith<$Res> {
  factory _$SavingsPeopleCopyWith(_SavingsPeople value, $Res Function(_SavingsPeople) _then) = __$SavingsPeopleCopyWithImpl;
@override @useResult
$Res call({
 List<SavingsPlayerOption> players, List<SavingsStaffOption> staff
});




}
/// @nodoc
class __$SavingsPeopleCopyWithImpl<$Res>
    implements _$SavingsPeopleCopyWith<$Res> {
  __$SavingsPeopleCopyWithImpl(this._self, this._then);

  final _SavingsPeople _self;
  final $Res Function(_SavingsPeople) _then;

/// Create a copy of SavingsPeople
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? players = null,Object? staff = null,}) {
  return _then(_SavingsPeople(
players: null == players ? _self._players : players // ignore: cast_nullable_to_non_nullable
as List<SavingsPlayerOption>,staff: null == staff ? _self._staff : staff // ignore: cast_nullable_to_non_nullable
as List<SavingsStaffOption>,
  ));
}


}


/// @nodoc
mixin _$SavingsFormValues {

 int get id; String get name;@JsonKey(unknownEnumValue: SavingsScope.unknown) SavingsScope get scope; bool get includeGuests; num get amount; num? get goal; String get startMonth; int get months; List<String> get members; int? get eventId;
/// Create a copy of SavingsFormValues
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavingsFormValuesCopyWith<SavingsFormValues> get copyWith => _$SavingsFormValuesCopyWithImpl<SavingsFormValues>(this as SavingsFormValues, _$identity);

  /// Serializes this SavingsFormValues to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavingsFormValues&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.includeGuests, includeGuests) || other.includeGuests == includeGuests)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.startMonth, startMonth) || other.startMonth == startMonth)&&(identical(other.months, months) || other.months == months)&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.eventId, eventId) || other.eventId == eventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,scope,includeGuests,amount,goal,startMonth,months,const DeepCollectionEquality().hash(members),eventId);

@override
String toString() {
  return 'SavingsFormValues(id: $id, name: $name, scope: $scope, includeGuests: $includeGuests, amount: $amount, goal: $goal, startMonth: $startMonth, months: $months, members: $members, eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class $SavingsFormValuesCopyWith<$Res>  {
  factory $SavingsFormValuesCopyWith(SavingsFormValues value, $Res Function(SavingsFormValues) _then) = _$SavingsFormValuesCopyWithImpl;
@useResult
$Res call({
 int id, String name,@JsonKey(unknownEnumValue: SavingsScope.unknown) SavingsScope scope, bool includeGuests, num amount, num? goal, String startMonth, int months, List<String> members, int? eventId
});




}
/// @nodoc
class _$SavingsFormValuesCopyWithImpl<$Res>
    implements $SavingsFormValuesCopyWith<$Res> {
  _$SavingsFormValuesCopyWithImpl(this._self, this._then);

  final SavingsFormValues _self;
  final $Res Function(SavingsFormValues) _then;

/// Create a copy of SavingsFormValues
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? scope = null,Object? includeGuests = null,Object? amount = null,Object? goal = freezed,Object? startMonth = null,Object? months = null,Object? members = null,Object? eventId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as SavingsScope,includeGuests: null == includeGuests ? _self.includeGuests : includeGuests // ignore: cast_nullable_to_non_nullable
as bool,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,goal: freezed == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as num?,startMonth: null == startMonth ? _self.startMonth : startMonth // ignore: cast_nullable_to_non_nullable
as String,months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<String>,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SavingsFormValues].
extension SavingsFormValuesPatterns on SavingsFormValues {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavingsFormValues value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavingsFormValues() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavingsFormValues value)  $default,){
final _that = this;
switch (_that) {
case _SavingsFormValues():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavingsFormValues value)?  $default,){
final _that = this;
switch (_that) {
case _SavingsFormValues() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(unknownEnumValue: SavingsScope.unknown)  SavingsScope scope,  bool includeGuests,  num amount,  num? goal,  String startMonth,  int months,  List<String> members,  int? eventId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavingsFormValues() when $default != null:
return $default(_that.id,_that.name,_that.scope,_that.includeGuests,_that.amount,_that.goal,_that.startMonth,_that.months,_that.members,_that.eventId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name, @JsonKey(unknownEnumValue: SavingsScope.unknown)  SavingsScope scope,  bool includeGuests,  num amount,  num? goal,  String startMonth,  int months,  List<String> members,  int? eventId)  $default,) {final _that = this;
switch (_that) {
case _SavingsFormValues():
return $default(_that.id,_that.name,_that.scope,_that.includeGuests,_that.amount,_that.goal,_that.startMonth,_that.months,_that.members,_that.eventId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name, @JsonKey(unknownEnumValue: SavingsScope.unknown)  SavingsScope scope,  bool includeGuests,  num amount,  num? goal,  String startMonth,  int months,  List<String> members,  int? eventId)?  $default,) {final _that = this;
switch (_that) {
case _SavingsFormValues() when $default != null:
return $default(_that.id,_that.name,_that.scope,_that.includeGuests,_that.amount,_that.goal,_that.startMonth,_that.months,_that.members,_that.eventId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavingsFormValues implements SavingsFormValues {
  const _SavingsFormValues({required this.id, this.name = '', @JsonKey(unknownEnumValue: SavingsScope.unknown) this.scope = SavingsScope.all, this.includeGuests = false, this.amount = 0, this.goal, this.startMonth = '', this.months = 1, final  List<String> members = const <String>[], this.eventId}): _members = members;
  factory _SavingsFormValues.fromJson(Map<String, dynamic> json) => _$SavingsFormValuesFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override@JsonKey(unknownEnumValue: SavingsScope.unknown) final  SavingsScope scope;
@override@JsonKey() final  bool includeGuests;
@override@JsonKey() final  num amount;
@override final  num? goal;
@override@JsonKey() final  String startMonth;
@override@JsonKey() final  int months;
 final  List<String> _members;
@override@JsonKey() List<String> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

@override final  int? eventId;

/// Create a copy of SavingsFormValues
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingsFormValuesCopyWith<_SavingsFormValues> get copyWith => __$SavingsFormValuesCopyWithImpl<_SavingsFormValues>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavingsFormValuesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingsFormValues&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.includeGuests, includeGuests) || other.includeGuests == includeGuests)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.startMonth, startMonth) || other.startMonth == startMonth)&&(identical(other.months, months) || other.months == months)&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.eventId, eventId) || other.eventId == eventId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,scope,includeGuests,amount,goal,startMonth,months,const DeepCollectionEquality().hash(_members),eventId);

@override
String toString() {
  return 'SavingsFormValues(id: $id, name: $name, scope: $scope, includeGuests: $includeGuests, amount: $amount, goal: $goal, startMonth: $startMonth, months: $months, members: $members, eventId: $eventId)';
}


}

/// @nodoc
abstract mixin class _$SavingsFormValuesCopyWith<$Res> implements $SavingsFormValuesCopyWith<$Res> {
  factory _$SavingsFormValuesCopyWith(_SavingsFormValues value, $Res Function(_SavingsFormValues) _then) = __$SavingsFormValuesCopyWithImpl;
@override @useResult
$Res call({
 int id, String name,@JsonKey(unknownEnumValue: SavingsScope.unknown) SavingsScope scope, bool includeGuests, num amount, num? goal, String startMonth, int months, List<String> members, int? eventId
});




}
/// @nodoc
class __$SavingsFormValuesCopyWithImpl<$Res>
    implements _$SavingsFormValuesCopyWith<$Res> {
  __$SavingsFormValuesCopyWithImpl(this._self, this._then);

  final _SavingsFormValues _self;
  final $Res Function(_SavingsFormValues) _then;

/// Create a copy of SavingsFormValues
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? scope = null,Object? includeGuests = null,Object? amount = null,Object? goal = freezed,Object? startMonth = null,Object? months = null,Object? members = null,Object? eventId = freezed,}) {
  return _then(_SavingsFormValues(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as SavingsScope,includeGuests: null == includeGuests ? _self.includeGuests : includeGuests // ignore: cast_nullable_to_non_nullable
as bool,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as num,goal: freezed == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as num?,startMonth: null == startMonth ? _self.startMonth : startMonth // ignore: cast_nullable_to_non_nullable
as String,months: null == months ? _self.months : months // ignore: cast_nullable_to_non_nullable
as int,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<String>,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$SavingsFormOptions {

 SavingsPeople get people; List<SavingsEvent> get activities; int? get presetEventId;/// Alleen bij bewerken.
 SavingsFormValues? get pot;
/// Create a copy of SavingsFormOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavingsFormOptionsCopyWith<SavingsFormOptions> get copyWith => _$SavingsFormOptionsCopyWithImpl<SavingsFormOptions>(this as SavingsFormOptions, _$identity);

  /// Serializes this SavingsFormOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavingsFormOptions&&(identical(other.people, people) || other.people == people)&&const DeepCollectionEquality().equals(other.activities, activities)&&(identical(other.presetEventId, presetEventId) || other.presetEventId == presetEventId)&&(identical(other.pot, pot) || other.pot == pot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,people,const DeepCollectionEquality().hash(activities),presetEventId,pot);

@override
String toString() {
  return 'SavingsFormOptions(people: $people, activities: $activities, presetEventId: $presetEventId, pot: $pot)';
}


}

/// @nodoc
abstract mixin class $SavingsFormOptionsCopyWith<$Res>  {
  factory $SavingsFormOptionsCopyWith(SavingsFormOptions value, $Res Function(SavingsFormOptions) _then) = _$SavingsFormOptionsCopyWithImpl;
@useResult
$Res call({
 SavingsPeople people, List<SavingsEvent> activities, int? presetEventId, SavingsFormValues? pot
});


$SavingsPeopleCopyWith<$Res> get people;$SavingsFormValuesCopyWith<$Res>? get pot;

}
/// @nodoc
class _$SavingsFormOptionsCopyWithImpl<$Res>
    implements $SavingsFormOptionsCopyWith<$Res> {
  _$SavingsFormOptionsCopyWithImpl(this._self, this._then);

  final SavingsFormOptions _self;
  final $Res Function(SavingsFormOptions) _then;

/// Create a copy of SavingsFormOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? people = null,Object? activities = null,Object? presetEventId = freezed,Object? pot = freezed,}) {
  return _then(_self.copyWith(
people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as SavingsPeople,activities: null == activities ? _self.activities : activities // ignore: cast_nullable_to_non_nullable
as List<SavingsEvent>,presetEventId: freezed == presetEventId ? _self.presetEventId : presetEventId // ignore: cast_nullable_to_non_nullable
as int?,pot: freezed == pot ? _self.pot : pot // ignore: cast_nullable_to_non_nullable
as SavingsFormValues?,
  ));
}
/// Create a copy of SavingsFormOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavingsPeopleCopyWith<$Res> get people {
  
  return $SavingsPeopleCopyWith<$Res>(_self.people, (value) {
    return _then(_self.copyWith(people: value));
  });
}/// Create a copy of SavingsFormOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavingsFormValuesCopyWith<$Res>? get pot {
    if (_self.pot == null) {
    return null;
  }

  return $SavingsFormValuesCopyWith<$Res>(_self.pot!, (value) {
    return _then(_self.copyWith(pot: value));
  });
}
}


/// Adds pattern-matching-related methods to [SavingsFormOptions].
extension SavingsFormOptionsPatterns on SavingsFormOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavingsFormOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavingsFormOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavingsFormOptions value)  $default,){
final _that = this;
switch (_that) {
case _SavingsFormOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavingsFormOptions value)?  $default,){
final _that = this;
switch (_that) {
case _SavingsFormOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SavingsPeople people,  List<SavingsEvent> activities,  int? presetEventId,  SavingsFormValues? pot)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavingsFormOptions() when $default != null:
return $default(_that.people,_that.activities,_that.presetEventId,_that.pot);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SavingsPeople people,  List<SavingsEvent> activities,  int? presetEventId,  SavingsFormValues? pot)  $default,) {final _that = this;
switch (_that) {
case _SavingsFormOptions():
return $default(_that.people,_that.activities,_that.presetEventId,_that.pot);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SavingsPeople people,  List<SavingsEvent> activities,  int? presetEventId,  SavingsFormValues? pot)?  $default,) {final _that = this;
switch (_that) {
case _SavingsFormOptions() when $default != null:
return $default(_that.people,_that.activities,_that.presetEventId,_that.pot);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavingsFormOptions implements SavingsFormOptions {
  const _SavingsFormOptions({this.people = const SavingsPeople(), final  List<SavingsEvent> activities = const <SavingsEvent>[], this.presetEventId, this.pot}): _activities = activities;
  factory _SavingsFormOptions.fromJson(Map<String, dynamic> json) => _$SavingsFormOptionsFromJson(json);

@override@JsonKey() final  SavingsPeople people;
 final  List<SavingsEvent> _activities;
@override@JsonKey() List<SavingsEvent> get activities {
  if (_activities is EqualUnmodifiableListView) return _activities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activities);
}

@override final  int? presetEventId;
/// Alleen bij bewerken.
@override final  SavingsFormValues? pot;

/// Create a copy of SavingsFormOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingsFormOptionsCopyWith<_SavingsFormOptions> get copyWith => __$SavingsFormOptionsCopyWithImpl<_SavingsFormOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavingsFormOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingsFormOptions&&(identical(other.people, people) || other.people == people)&&const DeepCollectionEquality().equals(other._activities, _activities)&&(identical(other.presetEventId, presetEventId) || other.presetEventId == presetEventId)&&(identical(other.pot, pot) || other.pot == pot));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,people,const DeepCollectionEquality().hash(_activities),presetEventId,pot);

@override
String toString() {
  return 'SavingsFormOptions(people: $people, activities: $activities, presetEventId: $presetEventId, pot: $pot)';
}


}

/// @nodoc
abstract mixin class _$SavingsFormOptionsCopyWith<$Res> implements $SavingsFormOptionsCopyWith<$Res> {
  factory _$SavingsFormOptionsCopyWith(_SavingsFormOptions value, $Res Function(_SavingsFormOptions) _then) = __$SavingsFormOptionsCopyWithImpl;
@override @useResult
$Res call({
 SavingsPeople people, List<SavingsEvent> activities, int? presetEventId, SavingsFormValues? pot
});


@override $SavingsPeopleCopyWith<$Res> get people;@override $SavingsFormValuesCopyWith<$Res>? get pot;

}
/// @nodoc
class __$SavingsFormOptionsCopyWithImpl<$Res>
    implements _$SavingsFormOptionsCopyWith<$Res> {
  __$SavingsFormOptionsCopyWithImpl(this._self, this._then);

  final _SavingsFormOptions _self;
  final $Res Function(_SavingsFormOptions) _then;

/// Create a copy of SavingsFormOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? people = null,Object? activities = null,Object? presetEventId = freezed,Object? pot = freezed,}) {
  return _then(_SavingsFormOptions(
people: null == people ? _self.people : people // ignore: cast_nullable_to_non_nullable
as SavingsPeople,activities: null == activities ? _self._activities : activities // ignore: cast_nullable_to_non_nullable
as List<SavingsEvent>,presetEventId: freezed == presetEventId ? _self.presetEventId : presetEventId // ignore: cast_nullable_to_non_nullable
as int?,pot: freezed == pot ? _self.pot : pot // ignore: cast_nullable_to_non_nullable
as SavingsFormValues?,
  ));
}

/// Create a copy of SavingsFormOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavingsPeopleCopyWith<$Res> get people {
  
  return $SavingsPeopleCopyWith<$Res>(_self.people, (value) {
    return _then(_self.copyWith(people: value));
  });
}/// Create a copy of SavingsFormOptions
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SavingsFormValuesCopyWith<$Res>? get pot {
    if (_self.pot == null) {
    return null;
  }

  return $SavingsFormValuesCopyWith<$Res>(_self.pot!, (value) {
    return _then(_self.copyWith(pot: value));
  });
}
}


/// @nodoc
mixin _$SavingsToggleResult {

 String get key; String get ym; bool get paid; int? get cents;
/// Create a copy of SavingsToggleResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavingsToggleResultCopyWith<SavingsToggleResult> get copyWith => _$SavingsToggleResultCopyWithImpl<SavingsToggleResult>(this as SavingsToggleResult, _$identity);

  /// Serializes this SavingsToggleResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavingsToggleResult&&(identical(other.key, key) || other.key == key)&&(identical(other.ym, ym) || other.ym == ym)&&(identical(other.paid, paid) || other.paid == paid)&&(identical(other.cents, cents) || other.cents == cents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,ym,paid,cents);

@override
String toString() {
  return 'SavingsToggleResult(key: $key, ym: $ym, paid: $paid, cents: $cents)';
}


}

/// @nodoc
abstract mixin class $SavingsToggleResultCopyWith<$Res>  {
  factory $SavingsToggleResultCopyWith(SavingsToggleResult value, $Res Function(SavingsToggleResult) _then) = _$SavingsToggleResultCopyWithImpl;
@useResult
$Res call({
 String key, String ym, bool paid, int? cents
});




}
/// @nodoc
class _$SavingsToggleResultCopyWithImpl<$Res>
    implements $SavingsToggleResultCopyWith<$Res> {
  _$SavingsToggleResultCopyWithImpl(this._self, this._then);

  final SavingsToggleResult _self;
  final $Res Function(SavingsToggleResult) _then;

/// Create a copy of SavingsToggleResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? ym = null,Object? paid = null,Object? cents = freezed,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,ym: null == ym ? _self.ym : ym // ignore: cast_nullable_to_non_nullable
as String,paid: null == paid ? _self.paid : paid // ignore: cast_nullable_to_non_nullable
as bool,cents: freezed == cents ? _self.cents : cents // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SavingsToggleResult].
extension SavingsToggleResultPatterns on SavingsToggleResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavingsToggleResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavingsToggleResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavingsToggleResult value)  $default,){
final _that = this;
switch (_that) {
case _SavingsToggleResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavingsToggleResult value)?  $default,){
final _that = this;
switch (_that) {
case _SavingsToggleResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String ym,  bool paid,  int? cents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavingsToggleResult() when $default != null:
return $default(_that.key,_that.ym,_that.paid,_that.cents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String ym,  bool paid,  int? cents)  $default,) {final _that = this;
switch (_that) {
case _SavingsToggleResult():
return $default(_that.key,_that.ym,_that.paid,_that.cents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String ym,  bool paid,  int? cents)?  $default,) {final _that = this;
switch (_that) {
case _SavingsToggleResult() when $default != null:
return $default(_that.key,_that.ym,_that.paid,_that.cents);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavingsToggleResult implements SavingsToggleResult {
  const _SavingsToggleResult({required this.key, required this.ym, this.paid = false, this.cents});
  factory _SavingsToggleResult.fromJson(Map<String, dynamic> json) => _$SavingsToggleResultFromJson(json);

@override final  String key;
@override final  String ym;
@override@JsonKey() final  bool paid;
@override final  int? cents;

/// Create a copy of SavingsToggleResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingsToggleResultCopyWith<_SavingsToggleResult> get copyWith => __$SavingsToggleResultCopyWithImpl<_SavingsToggleResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavingsToggleResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingsToggleResult&&(identical(other.key, key) || other.key == key)&&(identical(other.ym, ym) || other.ym == ym)&&(identical(other.paid, paid) || other.paid == paid)&&(identical(other.cents, cents) || other.cents == cents));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,ym,paid,cents);

@override
String toString() {
  return 'SavingsToggleResult(key: $key, ym: $ym, paid: $paid, cents: $cents)';
}


}

/// @nodoc
abstract mixin class _$SavingsToggleResultCopyWith<$Res> implements $SavingsToggleResultCopyWith<$Res> {
  factory _$SavingsToggleResultCopyWith(_SavingsToggleResult value, $Res Function(_SavingsToggleResult) _then) = __$SavingsToggleResultCopyWithImpl;
@override @useResult
$Res call({
 String key, String ym, bool paid, int? cents
});




}
/// @nodoc
class __$SavingsToggleResultCopyWithImpl<$Res>
    implements _$SavingsToggleResultCopyWith<$Res> {
  __$SavingsToggleResultCopyWithImpl(this._self, this._then);

  final _SavingsToggleResult _self;
  final $Res Function(_SavingsToggleResult) _then;

/// Create a copy of SavingsToggleResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? ym = null,Object? paid = null,Object? cents = freezed,}) {
  return _then(_SavingsToggleResult(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,ym: null == ym ? _self.ym : ym // ignore: cast_nullable_to_non_nullable
as String,paid: null == paid ? _self.paid : paid // ignore: cast_nullable_to_non_nullable
as bool,cents: freezed == cents ? _self.cents : cents // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$SavingsRefundResult {

 String get key; bool get refunded;
/// Create a copy of SavingsRefundResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavingsRefundResultCopyWith<SavingsRefundResult> get copyWith => _$SavingsRefundResultCopyWithImpl<SavingsRefundResult>(this as SavingsRefundResult, _$identity);

  /// Serializes this SavingsRefundResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavingsRefundResult&&(identical(other.key, key) || other.key == key)&&(identical(other.refunded, refunded) || other.refunded == refunded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,refunded);

@override
String toString() {
  return 'SavingsRefundResult(key: $key, refunded: $refunded)';
}


}

/// @nodoc
abstract mixin class $SavingsRefundResultCopyWith<$Res>  {
  factory $SavingsRefundResultCopyWith(SavingsRefundResult value, $Res Function(SavingsRefundResult) _then) = _$SavingsRefundResultCopyWithImpl;
@useResult
$Res call({
 String key, bool refunded
});




}
/// @nodoc
class _$SavingsRefundResultCopyWithImpl<$Res>
    implements $SavingsRefundResultCopyWith<$Res> {
  _$SavingsRefundResultCopyWithImpl(this._self, this._then);

  final SavingsRefundResult _self;
  final $Res Function(SavingsRefundResult) _then;

/// Create a copy of SavingsRefundResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? refunded = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,refunded: null == refunded ? _self.refunded : refunded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SavingsRefundResult].
extension SavingsRefundResultPatterns on SavingsRefundResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavingsRefundResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavingsRefundResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavingsRefundResult value)  $default,){
final _that = this;
switch (_that) {
case _SavingsRefundResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavingsRefundResult value)?  $default,){
final _that = this;
switch (_that) {
case _SavingsRefundResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  bool refunded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavingsRefundResult() when $default != null:
return $default(_that.key,_that.refunded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  bool refunded)  $default,) {final _that = this;
switch (_that) {
case _SavingsRefundResult():
return $default(_that.key,_that.refunded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  bool refunded)?  $default,) {final _that = this;
switch (_that) {
case _SavingsRefundResult() when $default != null:
return $default(_that.key,_that.refunded);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavingsRefundResult implements SavingsRefundResult {
  const _SavingsRefundResult({required this.key, this.refunded = false});
  factory _SavingsRefundResult.fromJson(Map<String, dynamic> json) => _$SavingsRefundResultFromJson(json);

@override final  String key;
@override@JsonKey() final  bool refunded;

/// Create a copy of SavingsRefundResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavingsRefundResultCopyWith<_SavingsRefundResult> get copyWith => __$SavingsRefundResultCopyWithImpl<_SavingsRefundResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavingsRefundResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavingsRefundResult&&(identical(other.key, key) || other.key == key)&&(identical(other.refunded, refunded) || other.refunded == refunded));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,refunded);

@override
String toString() {
  return 'SavingsRefundResult(key: $key, refunded: $refunded)';
}


}

/// @nodoc
abstract mixin class _$SavingsRefundResultCopyWith<$Res> implements $SavingsRefundResultCopyWith<$Res> {
  factory _$SavingsRefundResultCopyWith(_SavingsRefundResult value, $Res Function(_SavingsRefundResult) _then) = __$SavingsRefundResultCopyWithImpl;
@override @useResult
$Res call({
 String key, bool refunded
});




}
/// @nodoc
class __$SavingsRefundResultCopyWithImpl<$Res>
    implements _$SavingsRefundResultCopyWith<$Res> {
  __$SavingsRefundResultCopyWithImpl(this._self, this._then);

  final _SavingsRefundResult _self;
  final $Res Function(_SavingsRefundResult) _then;

/// Create a copy of SavingsRefundResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? refunded = null,}) {
  return _then(_SavingsRefundResult(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,refunded: null == refunded ? _self.refunded : refunded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
