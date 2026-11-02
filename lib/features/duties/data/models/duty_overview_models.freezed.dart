// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'duty_overview_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DutyOverviewRow {

 int get dutyId; int? get dutyTypeId; int? get eventId; bool get matchBound;/// ISO 8601 (`2026-11-08T00:00:00+01:00`). Bewust als tekst: de dag is
/// de clubdag, niet de dag in de tijdzone van het toestel.
 String get date; String? get dutyType; String get title; String? get icon;/// Groepsnaam, of de namen komma-gescheiden.
 String? get groupName; List<String> get playerNames; String? get timeRange;/// `HH:MM` of `null`.
 String? get startsAt; String? get endsAt; String? get notes; bool get done; bool get mine;/// `"Thuis – Uit"` of de titel; `null` zonder wedstrijd.
 String? get eventLabel;
/// Create a copy of DutyOverviewRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyOverviewRowCopyWith<DutyOverviewRow> get copyWith => _$DutyOverviewRowCopyWithImpl<DutyOverviewRow>(this as DutyOverviewRow, _$identity);

  /// Serializes this DutyOverviewRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyOverviewRow&&(identical(other.dutyId, dutyId) || other.dutyId == dutyId)&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.matchBound, matchBound) || other.matchBound == matchBound)&&(identical(other.date, date) || other.date == date)&&(identical(other.dutyType, dutyType) || other.dutyType == dutyType)&&(identical(other.title, title) || other.title == title)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&const DeepCollectionEquality().equals(other.playerNames, playerNames)&&(identical(other.timeRange, timeRange) || other.timeRange == timeRange)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.done, done) || other.done == done)&&(identical(other.mine, mine) || other.mine == mine)&&(identical(other.eventLabel, eventLabel) || other.eventLabel == eventLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dutyId,dutyTypeId,eventId,matchBound,date,dutyType,title,icon,groupName,const DeepCollectionEquality().hash(playerNames),timeRange,startsAt,endsAt,notes,done,mine,eventLabel);

@override
String toString() {
  return 'DutyOverviewRow(dutyId: $dutyId, dutyTypeId: $dutyTypeId, eventId: $eventId, matchBound: $matchBound, date: $date, dutyType: $dutyType, title: $title, icon: $icon, groupName: $groupName, playerNames: $playerNames, timeRange: $timeRange, startsAt: $startsAt, endsAt: $endsAt, notes: $notes, done: $done, mine: $mine, eventLabel: $eventLabel)';
}


}

/// @nodoc
abstract mixin class $DutyOverviewRowCopyWith<$Res>  {
  factory $DutyOverviewRowCopyWith(DutyOverviewRow value, $Res Function(DutyOverviewRow) _then) = _$DutyOverviewRowCopyWithImpl;
@useResult
$Res call({
 int dutyId, int? dutyTypeId, int? eventId, bool matchBound, String date, String? dutyType, String title, String? icon, String? groupName, List<String> playerNames, String? timeRange, String? startsAt, String? endsAt, String? notes, bool done, bool mine, String? eventLabel
});




}
/// @nodoc
class _$DutyOverviewRowCopyWithImpl<$Res>
    implements $DutyOverviewRowCopyWith<$Res> {
  _$DutyOverviewRowCopyWithImpl(this._self, this._then);

  final DutyOverviewRow _self;
  final $Res Function(DutyOverviewRow) _then;

/// Create a copy of DutyOverviewRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dutyId = null,Object? dutyTypeId = freezed,Object? eventId = freezed,Object? matchBound = null,Object? date = null,Object? dutyType = freezed,Object? title = null,Object? icon = freezed,Object? groupName = freezed,Object? playerNames = null,Object? timeRange = freezed,Object? startsAt = freezed,Object? endsAt = freezed,Object? notes = freezed,Object? done = null,Object? mine = null,Object? eventLabel = freezed,}) {
  return _then(_self.copyWith(
dutyId: null == dutyId ? _self.dutyId : dutyId // ignore: cast_nullable_to_non_nullable
as int,dutyTypeId: freezed == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,matchBound: null == matchBound ? _self.matchBound : matchBound // ignore: cast_nullable_to_non_nullable
as bool,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dutyType: freezed == dutyType ? _self.dutyType : dutyType // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,playerNames: null == playerNames ? _self.playerNames : playerNames // ignore: cast_nullable_to_non_nullable
as List<String>,timeRange: freezed == timeRange ? _self.timeRange : timeRange // ignore: cast_nullable_to_non_nullable
as String?,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,eventLabel: freezed == eventLabel ? _self.eventLabel : eventLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [DutyOverviewRow].
extension DutyOverviewRowPatterns on DutyOverviewRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyOverviewRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyOverviewRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyOverviewRow value)  $default,){
final _that = this;
switch (_that) {
case _DutyOverviewRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyOverviewRow value)?  $default,){
final _that = this;
switch (_that) {
case _DutyOverviewRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int dutyId,  int? dutyTypeId,  int? eventId,  bool matchBound,  String date,  String? dutyType,  String title,  String? icon,  String? groupName,  List<String> playerNames,  String? timeRange,  String? startsAt,  String? endsAt,  String? notes,  bool done,  bool mine,  String? eventLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyOverviewRow() when $default != null:
return $default(_that.dutyId,_that.dutyTypeId,_that.eventId,_that.matchBound,_that.date,_that.dutyType,_that.title,_that.icon,_that.groupName,_that.playerNames,_that.timeRange,_that.startsAt,_that.endsAt,_that.notes,_that.done,_that.mine,_that.eventLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int dutyId,  int? dutyTypeId,  int? eventId,  bool matchBound,  String date,  String? dutyType,  String title,  String? icon,  String? groupName,  List<String> playerNames,  String? timeRange,  String? startsAt,  String? endsAt,  String? notes,  bool done,  bool mine,  String? eventLabel)  $default,) {final _that = this;
switch (_that) {
case _DutyOverviewRow():
return $default(_that.dutyId,_that.dutyTypeId,_that.eventId,_that.matchBound,_that.date,_that.dutyType,_that.title,_that.icon,_that.groupName,_that.playerNames,_that.timeRange,_that.startsAt,_that.endsAt,_that.notes,_that.done,_that.mine,_that.eventLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int dutyId,  int? dutyTypeId,  int? eventId,  bool matchBound,  String date,  String? dutyType,  String title,  String? icon,  String? groupName,  List<String> playerNames,  String? timeRange,  String? startsAt,  String? endsAt,  String? notes,  bool done,  bool mine,  String? eventLabel)?  $default,) {final _that = this;
switch (_that) {
case _DutyOverviewRow() when $default != null:
return $default(_that.dutyId,_that.dutyTypeId,_that.eventId,_that.matchBound,_that.date,_that.dutyType,_that.title,_that.icon,_that.groupName,_that.playerNames,_that.timeRange,_that.startsAt,_that.endsAt,_that.notes,_that.done,_that.mine,_that.eventLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyOverviewRow implements DutyOverviewRow {
  const _DutyOverviewRow({required this.dutyId, this.dutyTypeId, this.eventId, this.matchBound = false, this.date = '', this.dutyType, this.title = '', this.icon, this.groupName, final  List<String> playerNames = const <String>[], this.timeRange, this.startsAt, this.endsAt, this.notes, this.done = false, this.mine = false, this.eventLabel}): _playerNames = playerNames;
  factory _DutyOverviewRow.fromJson(Map<String, dynamic> json) => _$DutyOverviewRowFromJson(json);

@override final  int dutyId;
@override final  int? dutyTypeId;
@override final  int? eventId;
@override@JsonKey() final  bool matchBound;
/// ISO 8601 (`2026-11-08T00:00:00+01:00`). Bewust als tekst: de dag is
/// de clubdag, niet de dag in de tijdzone van het toestel.
@override@JsonKey() final  String date;
@override final  String? dutyType;
@override@JsonKey() final  String title;
@override final  String? icon;
/// Groepsnaam, of de namen komma-gescheiden.
@override final  String? groupName;
 final  List<String> _playerNames;
@override@JsonKey() List<String> get playerNames {
  if (_playerNames is EqualUnmodifiableListView) return _playerNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_playerNames);
}

@override final  String? timeRange;
/// `HH:MM` of `null`.
@override final  String? startsAt;
@override final  String? endsAt;
@override final  String? notes;
@override@JsonKey() final  bool done;
@override@JsonKey() final  bool mine;
/// `"Thuis – Uit"` of de titel; `null` zonder wedstrijd.
@override final  String? eventLabel;

/// Create a copy of DutyOverviewRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyOverviewRowCopyWith<_DutyOverviewRow> get copyWith => __$DutyOverviewRowCopyWithImpl<_DutyOverviewRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyOverviewRowToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyOverviewRow&&(identical(other.dutyId, dutyId) || other.dutyId == dutyId)&&(identical(other.dutyTypeId, dutyTypeId) || other.dutyTypeId == dutyTypeId)&&(identical(other.eventId, eventId) || other.eventId == eventId)&&(identical(other.matchBound, matchBound) || other.matchBound == matchBound)&&(identical(other.date, date) || other.date == date)&&(identical(other.dutyType, dutyType) || other.dutyType == dutyType)&&(identical(other.title, title) || other.title == title)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&const DeepCollectionEquality().equals(other._playerNames, _playerNames)&&(identical(other.timeRange, timeRange) || other.timeRange == timeRange)&&(identical(other.startsAt, startsAt) || other.startsAt == startsAt)&&(identical(other.endsAt, endsAt) || other.endsAt == endsAt)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.done, done) || other.done == done)&&(identical(other.mine, mine) || other.mine == mine)&&(identical(other.eventLabel, eventLabel) || other.eventLabel == eventLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dutyId,dutyTypeId,eventId,matchBound,date,dutyType,title,icon,groupName,const DeepCollectionEquality().hash(_playerNames),timeRange,startsAt,endsAt,notes,done,mine,eventLabel);

@override
String toString() {
  return 'DutyOverviewRow(dutyId: $dutyId, dutyTypeId: $dutyTypeId, eventId: $eventId, matchBound: $matchBound, date: $date, dutyType: $dutyType, title: $title, icon: $icon, groupName: $groupName, playerNames: $playerNames, timeRange: $timeRange, startsAt: $startsAt, endsAt: $endsAt, notes: $notes, done: $done, mine: $mine, eventLabel: $eventLabel)';
}


}

/// @nodoc
abstract mixin class _$DutyOverviewRowCopyWith<$Res> implements $DutyOverviewRowCopyWith<$Res> {
  factory _$DutyOverviewRowCopyWith(_DutyOverviewRow value, $Res Function(_DutyOverviewRow) _then) = __$DutyOverviewRowCopyWithImpl;
@override @useResult
$Res call({
 int dutyId, int? dutyTypeId, int? eventId, bool matchBound, String date, String? dutyType, String title, String? icon, String? groupName, List<String> playerNames, String? timeRange, String? startsAt, String? endsAt, String? notes, bool done, bool mine, String? eventLabel
});




}
/// @nodoc
class __$DutyOverviewRowCopyWithImpl<$Res>
    implements _$DutyOverviewRowCopyWith<$Res> {
  __$DutyOverviewRowCopyWithImpl(this._self, this._then);

  final _DutyOverviewRow _self;
  final $Res Function(_DutyOverviewRow) _then;

/// Create a copy of DutyOverviewRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dutyId = null,Object? dutyTypeId = freezed,Object? eventId = freezed,Object? matchBound = null,Object? date = null,Object? dutyType = freezed,Object? title = null,Object? icon = freezed,Object? groupName = freezed,Object? playerNames = null,Object? timeRange = freezed,Object? startsAt = freezed,Object? endsAt = freezed,Object? notes = freezed,Object? done = null,Object? mine = null,Object? eventLabel = freezed,}) {
  return _then(_DutyOverviewRow(
dutyId: null == dutyId ? _self.dutyId : dutyId // ignore: cast_nullable_to_non_nullable
as int,dutyTypeId: freezed == dutyTypeId ? _self.dutyTypeId : dutyTypeId // ignore: cast_nullable_to_non_nullable
as int?,eventId: freezed == eventId ? _self.eventId : eventId // ignore: cast_nullable_to_non_nullable
as int?,matchBound: null == matchBound ? _self.matchBound : matchBound // ignore: cast_nullable_to_non_nullable
as bool,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,dutyType: freezed == dutyType ? _self.dutyType : dutyType // ignore: cast_nullable_to_non_nullable
as String?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,playerNames: null == playerNames ? _self._playerNames : playerNames // ignore: cast_nullable_to_non_nullable
as List<String>,timeRange: freezed == timeRange ? _self.timeRange : timeRange // ignore: cast_nullable_to_non_nullable
as String?,startsAt: freezed == startsAt ? _self.startsAt : startsAt // ignore: cast_nullable_to_non_nullable
as String?,endsAt: freezed == endsAt ? _self.endsAt : endsAt // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as bool,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,eventLabel: freezed == eventLabel ? _self.eventLabel : eventLabel // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$DutyOverviewGroup {

 int get id; String get name; List<String> get members;/// Jij zit in deze groep.
 bool get mine;
/// Create a copy of DutyOverviewGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyOverviewGroupCopyWith<DutyOverviewGroup> get copyWith => _$DutyOverviewGroupCopyWithImpl<DutyOverviewGroup>(this as DutyOverviewGroup, _$identity);

  /// Serializes this DutyOverviewGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyOverviewGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.mine, mine) || other.mine == mine));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(members),mine);

@override
String toString() {
  return 'DutyOverviewGroup(id: $id, name: $name, members: $members, mine: $mine)';
}


}

/// @nodoc
abstract mixin class $DutyOverviewGroupCopyWith<$Res>  {
  factory $DutyOverviewGroupCopyWith(DutyOverviewGroup value, $Res Function(DutyOverviewGroup) _then) = _$DutyOverviewGroupCopyWithImpl;
@useResult
$Res call({
 int id, String name, List<String> members, bool mine
});




}
/// @nodoc
class _$DutyOverviewGroupCopyWithImpl<$Res>
    implements $DutyOverviewGroupCopyWith<$Res> {
  _$DutyOverviewGroupCopyWithImpl(this._self, this._then);

  final DutyOverviewGroup _self;
  final $Res Function(DutyOverviewGroup) _then;

/// Create a copy of DutyOverviewGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? members = null,Object? mine = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<String>,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DutyOverviewGroup].
extension DutyOverviewGroupPatterns on DutyOverviewGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyOverviewGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyOverviewGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyOverviewGroup value)  $default,){
final _that = this;
switch (_that) {
case _DutyOverviewGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyOverviewGroup value)?  $default,){
final _that = this;
switch (_that) {
case _DutyOverviewGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  List<String> members,  bool mine)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyOverviewGroup() when $default != null:
return $default(_that.id,_that.name,_that.members,_that.mine);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  List<String> members,  bool mine)  $default,) {final _that = this;
switch (_that) {
case _DutyOverviewGroup():
return $default(_that.id,_that.name,_that.members,_that.mine);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  List<String> members,  bool mine)?  $default,) {final _that = this;
switch (_that) {
case _DutyOverviewGroup() when $default != null:
return $default(_that.id,_that.name,_that.members,_that.mine);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyOverviewGroup implements DutyOverviewGroup {
  const _DutyOverviewGroup({required this.id, this.name = '', final  List<String> members = const <String>[], this.mine = false}): _members = members;
  factory _DutyOverviewGroup.fromJson(Map<String, dynamic> json) => _$DutyOverviewGroupFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
 final  List<String> _members;
@override@JsonKey() List<String> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

/// Jij zit in deze groep.
@override@JsonKey() final  bool mine;

/// Create a copy of DutyOverviewGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyOverviewGroupCopyWith<_DutyOverviewGroup> get copyWith => __$DutyOverviewGroupCopyWithImpl<_DutyOverviewGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyOverviewGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyOverviewGroup&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.mine, mine) || other.mine == mine));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_members),mine);

@override
String toString() {
  return 'DutyOverviewGroup(id: $id, name: $name, members: $members, mine: $mine)';
}


}

/// @nodoc
abstract mixin class _$DutyOverviewGroupCopyWith<$Res> implements $DutyOverviewGroupCopyWith<$Res> {
  factory _$DutyOverviewGroupCopyWith(_DutyOverviewGroup value, $Res Function(_DutyOverviewGroup) _then) = __$DutyOverviewGroupCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, List<String> members, bool mine
});




}
/// @nodoc
class __$DutyOverviewGroupCopyWithImpl<$Res>
    implements _$DutyOverviewGroupCopyWith<$Res> {
  __$DutyOverviewGroupCopyWithImpl(this._self, this._then);

  final _DutyOverviewGroup _self;
  final $Res Function(_DutyOverviewGroup) _then;

/// Create a copy of DutyOverviewGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? members = null,Object? mine = null,}) {
  return _then(_DutyOverviewGroup(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<String>,mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$DutyOverviewType {

 int get id; String get name; String? get icon;/// `individual`, `group` of `multi`.
 String get mode;/// Hooguit 8 komende beurten, op datum.
 List<DutyOverviewRow> get upcoming;/// Alle komende beurten (ook die niet in [upcoming] passen).
 int get upcomingTotal; List<DutyOverviewGroup> get groups;
/// Create a copy of DutyOverviewType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyOverviewTypeCopyWith<DutyOverviewType> get copyWith => _$DutyOverviewTypeCopyWithImpl<DutyOverviewType>(this as DutyOverviewType, _$identity);

  /// Serializes this DutyOverviewType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyOverviewType&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other.upcoming, upcoming)&&(identical(other.upcomingTotal, upcomingTotal) || other.upcomingTotal == upcomingTotal)&&const DeepCollectionEquality().equals(other.groups, groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon,mode,const DeepCollectionEquality().hash(upcoming),upcomingTotal,const DeepCollectionEquality().hash(groups));

@override
String toString() {
  return 'DutyOverviewType(id: $id, name: $name, icon: $icon, mode: $mode, upcoming: $upcoming, upcomingTotal: $upcomingTotal, groups: $groups)';
}


}

/// @nodoc
abstract mixin class $DutyOverviewTypeCopyWith<$Res>  {
  factory $DutyOverviewTypeCopyWith(DutyOverviewType value, $Res Function(DutyOverviewType) _then) = _$DutyOverviewTypeCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? icon, String mode, List<DutyOverviewRow> upcoming, int upcomingTotal, List<DutyOverviewGroup> groups
});




}
/// @nodoc
class _$DutyOverviewTypeCopyWithImpl<$Res>
    implements $DutyOverviewTypeCopyWith<$Res> {
  _$DutyOverviewTypeCopyWithImpl(this._self, this._then);

  final DutyOverviewType _self;
  final $Res Function(DutyOverviewType) _then;

/// Create a copy of DutyOverviewType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? icon = freezed,Object? mode = null,Object? upcoming = null,Object? upcomingTotal = null,Object? groups = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<DutyOverviewRow>,upcomingTotal: null == upcomingTotal ? _self.upcomingTotal : upcomingTotal // ignore: cast_nullable_to_non_nullable
as int,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<DutyOverviewGroup>,
  ));
}

}


/// Adds pattern-matching-related methods to [DutyOverviewType].
extension DutyOverviewTypePatterns on DutyOverviewType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyOverviewType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyOverviewType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyOverviewType value)  $default,){
final _that = this;
switch (_that) {
case _DutyOverviewType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyOverviewType value)?  $default,){
final _that = this;
switch (_that) {
case _DutyOverviewType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String? icon,  String mode,  List<DutyOverviewRow> upcoming,  int upcomingTotal,  List<DutyOverviewGroup> groups)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyOverviewType() when $default != null:
return $default(_that.id,_that.name,_that.icon,_that.mode,_that.upcoming,_that.upcomingTotal,_that.groups);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String? icon,  String mode,  List<DutyOverviewRow> upcoming,  int upcomingTotal,  List<DutyOverviewGroup> groups)  $default,) {final _that = this;
switch (_that) {
case _DutyOverviewType():
return $default(_that.id,_that.name,_that.icon,_that.mode,_that.upcoming,_that.upcomingTotal,_that.groups);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String? icon,  String mode,  List<DutyOverviewRow> upcoming,  int upcomingTotal,  List<DutyOverviewGroup> groups)?  $default,) {final _that = this;
switch (_that) {
case _DutyOverviewType() when $default != null:
return $default(_that.id,_that.name,_that.icon,_that.mode,_that.upcoming,_that.upcomingTotal,_that.groups);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyOverviewType extends DutyOverviewType {
  const _DutyOverviewType({required this.id, this.name = '', this.icon, this.mode = 'individual', final  List<DutyOverviewRow> upcoming = const <DutyOverviewRow>[], this.upcomingTotal = 0, final  List<DutyOverviewGroup> groups = const <DutyOverviewGroup>[]}): _upcoming = upcoming,_groups = groups,super._();
  factory _DutyOverviewType.fromJson(Map<String, dynamic> json) => _$DutyOverviewTypeFromJson(json);

@override final  int id;
@override@JsonKey() final  String name;
@override final  String? icon;
/// `individual`, `group` of `multi`.
@override@JsonKey() final  String mode;
/// Hooguit 8 komende beurten, op datum.
 final  List<DutyOverviewRow> _upcoming;
/// Hooguit 8 komende beurten, op datum.
@override@JsonKey() List<DutyOverviewRow> get upcoming {
  if (_upcoming is EqualUnmodifiableListView) return _upcoming;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcoming);
}

/// Alle komende beurten (ook die niet in [upcoming] passen).
@override@JsonKey() final  int upcomingTotal;
 final  List<DutyOverviewGroup> _groups;
@override@JsonKey() List<DutyOverviewGroup> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}


/// Create a copy of DutyOverviewType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyOverviewTypeCopyWith<_DutyOverviewType> get copyWith => __$DutyOverviewTypeCopyWithImpl<_DutyOverviewType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyOverviewTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyOverviewType&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.mode, mode) || other.mode == mode)&&const DeepCollectionEquality().equals(other._upcoming, _upcoming)&&(identical(other.upcomingTotal, upcomingTotal) || other.upcomingTotal == upcomingTotal)&&const DeepCollectionEquality().equals(other._groups, _groups));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,icon,mode,const DeepCollectionEquality().hash(_upcoming),upcomingTotal,const DeepCollectionEquality().hash(_groups));

@override
String toString() {
  return 'DutyOverviewType(id: $id, name: $name, icon: $icon, mode: $mode, upcoming: $upcoming, upcomingTotal: $upcomingTotal, groups: $groups)';
}


}

/// @nodoc
abstract mixin class _$DutyOverviewTypeCopyWith<$Res> implements $DutyOverviewTypeCopyWith<$Res> {
  factory _$DutyOverviewTypeCopyWith(_DutyOverviewType value, $Res Function(_DutyOverviewType) _then) = __$DutyOverviewTypeCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? icon, String mode, List<DutyOverviewRow> upcoming, int upcomingTotal, List<DutyOverviewGroup> groups
});




}
/// @nodoc
class __$DutyOverviewTypeCopyWithImpl<$Res>
    implements _$DutyOverviewTypeCopyWith<$Res> {
  __$DutyOverviewTypeCopyWithImpl(this._self, this._then);

  final _DutyOverviewType _self;
  final $Res Function(_DutyOverviewType) _then;

/// Create a copy of DutyOverviewType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? icon = freezed,Object? mode = null,Object? upcoming = null,Object? upcomingTotal = null,Object? groups = null,}) {
  return _then(_DutyOverviewType(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as String,upcoming: null == upcoming ? _self._upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<DutyOverviewRow>,upcomingTotal: null == upcomingTotal ? _self.upcomingTotal : upcomingTotal // ignore: cast_nullable_to_non_nullable
as int,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<DutyOverviewGroup>,
  ));
}


}


/// @nodoc
mixin _$DutyOverview {

/// Je eigen komende beurten die nog niet afgevinkt zijn.
 List<DutyOverviewRow> get mine; List<DutyOverviewType> get duties;
/// Create a copy of DutyOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DutyOverviewCopyWith<DutyOverview> get copyWith => _$DutyOverviewCopyWithImpl<DutyOverview>(this as DutyOverview, _$identity);

  /// Serializes this DutyOverview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DutyOverview&&const DeepCollectionEquality().equals(other.mine, mine)&&const DeepCollectionEquality().equals(other.duties, duties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(mine),const DeepCollectionEquality().hash(duties));

@override
String toString() {
  return 'DutyOverview(mine: $mine, duties: $duties)';
}


}

/// @nodoc
abstract mixin class $DutyOverviewCopyWith<$Res>  {
  factory $DutyOverviewCopyWith(DutyOverview value, $Res Function(DutyOverview) _then) = _$DutyOverviewCopyWithImpl;
@useResult
$Res call({
 List<DutyOverviewRow> mine, List<DutyOverviewType> duties
});




}
/// @nodoc
class _$DutyOverviewCopyWithImpl<$Res>
    implements $DutyOverviewCopyWith<$Res> {
  _$DutyOverviewCopyWithImpl(this._self, this._then);

  final DutyOverview _self;
  final $Res Function(DutyOverview) _then;

/// Create a copy of DutyOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mine = null,Object? duties = null,}) {
  return _then(_self.copyWith(
mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as List<DutyOverviewRow>,duties: null == duties ? _self.duties : duties // ignore: cast_nullable_to_non_nullable
as List<DutyOverviewType>,
  ));
}

}


/// Adds pattern-matching-related methods to [DutyOverview].
extension DutyOverviewPatterns on DutyOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DutyOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DutyOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DutyOverview value)  $default,){
final _that = this;
switch (_that) {
case _DutyOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DutyOverview value)?  $default,){
final _that = this;
switch (_that) {
case _DutyOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DutyOverviewRow> mine,  List<DutyOverviewType> duties)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DutyOverview() when $default != null:
return $default(_that.mine,_that.duties);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DutyOverviewRow> mine,  List<DutyOverviewType> duties)  $default,) {final _that = this;
switch (_that) {
case _DutyOverview():
return $default(_that.mine,_that.duties);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DutyOverviewRow> mine,  List<DutyOverviewType> duties)?  $default,) {final _that = this;
switch (_that) {
case _DutyOverview() when $default != null:
return $default(_that.mine,_that.duties);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DutyOverview implements DutyOverview {
  const _DutyOverview({final  List<DutyOverviewRow> mine = const <DutyOverviewRow>[], final  List<DutyOverviewType> duties = const <DutyOverviewType>[]}): _mine = mine,_duties = duties;
  factory _DutyOverview.fromJson(Map<String, dynamic> json) => _$DutyOverviewFromJson(json);

/// Je eigen komende beurten die nog niet afgevinkt zijn.
 final  List<DutyOverviewRow> _mine;
/// Je eigen komende beurten die nog niet afgevinkt zijn.
@override@JsonKey() List<DutyOverviewRow> get mine {
  if (_mine is EqualUnmodifiableListView) return _mine;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mine);
}

 final  List<DutyOverviewType> _duties;
@override@JsonKey() List<DutyOverviewType> get duties {
  if (_duties is EqualUnmodifiableListView) return _duties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_duties);
}


/// Create a copy of DutyOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DutyOverviewCopyWith<_DutyOverview> get copyWith => __$DutyOverviewCopyWithImpl<_DutyOverview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DutyOverviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DutyOverview&&const DeepCollectionEquality().equals(other._mine, _mine)&&const DeepCollectionEquality().equals(other._duties, _duties));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_mine),const DeepCollectionEquality().hash(_duties));

@override
String toString() {
  return 'DutyOverview(mine: $mine, duties: $duties)';
}


}

/// @nodoc
abstract mixin class _$DutyOverviewCopyWith<$Res> implements $DutyOverviewCopyWith<$Res> {
  factory _$DutyOverviewCopyWith(_DutyOverview value, $Res Function(_DutyOverview) _then) = __$DutyOverviewCopyWithImpl;
@override @useResult
$Res call({
 List<DutyOverviewRow> mine, List<DutyOverviewType> duties
});




}
/// @nodoc
class __$DutyOverviewCopyWithImpl<$Res>
    implements _$DutyOverviewCopyWith<$Res> {
  __$DutyOverviewCopyWithImpl(this._self, this._then);

  final _DutyOverview _self;
  final $Res Function(_DutyOverview) _then;

/// Create a copy of DutyOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mine = null,Object? duties = null,}) {
  return _then(_DutyOverview(
mine: null == mine ? _self._mine : mine // ignore: cast_nullable_to_non_nullable
as List<DutyOverviewRow>,duties: null == duties ? _self._duties : duties // ignore: cast_nullable_to_non_nullable
as List<DutyOverviewType>,
  ));
}


}

// dart format on
