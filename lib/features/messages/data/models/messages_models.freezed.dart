// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'messages_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TeamMessage {

 int get id; String get title; String get body;/// Webpad (`/agenda`, `/events/412`), zelfde als `data.url` in de push.
 String? get url;/// ISO-tijdstip; `null` zolang het bericht nog verstuurd wordt.
 String? get sentAt; int get recipientsCount; String? get senderName;
/// Create a copy of TeamMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeamMessageCopyWith<TeamMessage> get copyWith => _$TeamMessageCopyWithImpl<TeamMessage>(this as TeamMessage, _$identity);

  /// Serializes this TeamMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeamMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.url, url) || other.url == url)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.recipientsCount, recipientsCount) || other.recipientsCount == recipientsCount)&&(identical(other.senderName, senderName) || other.senderName == senderName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,url,sentAt,recipientsCount,senderName);

@override
String toString() {
  return 'TeamMessage(id: $id, title: $title, body: $body, url: $url, sentAt: $sentAt, recipientsCount: $recipientsCount, senderName: $senderName)';
}


}

/// @nodoc
abstract mixin class $TeamMessageCopyWith<$Res>  {
  factory $TeamMessageCopyWith(TeamMessage value, $Res Function(TeamMessage) _then) = _$TeamMessageCopyWithImpl;
@useResult
$Res call({
 int id, String title, String body, String? url, String? sentAt, int recipientsCount, String? senderName
});




}
/// @nodoc
class _$TeamMessageCopyWithImpl<$Res>
    implements $TeamMessageCopyWith<$Res> {
  _$TeamMessageCopyWithImpl(this._self, this._then);

  final TeamMessage _self;
  final $Res Function(TeamMessage) _then;

/// Create a copy of TeamMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = null,Object? url = freezed,Object? sentAt = freezed,Object? recipientsCount = null,Object? senderName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,recipientsCount: null == recipientsCount ? _self.recipientsCount : recipientsCount // ignore: cast_nullable_to_non_nullable
as int,senderName: freezed == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TeamMessage].
extension TeamMessagePatterns on TeamMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeamMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeamMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeamMessage value)  $default,){
final _that = this;
switch (_that) {
case _TeamMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeamMessage value)?  $default,){
final _that = this;
switch (_that) {
case _TeamMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String title,  String body,  String? url,  String? sentAt,  int recipientsCount,  String? senderName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeamMessage() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.url,_that.sentAt,_that.recipientsCount,_that.senderName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String title,  String body,  String? url,  String? sentAt,  int recipientsCount,  String? senderName)  $default,) {final _that = this;
switch (_that) {
case _TeamMessage():
return $default(_that.id,_that.title,_that.body,_that.url,_that.sentAt,_that.recipientsCount,_that.senderName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String title,  String body,  String? url,  String? sentAt,  int recipientsCount,  String? senderName)?  $default,) {final _that = this;
switch (_that) {
case _TeamMessage() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.url,_that.sentAt,_that.recipientsCount,_that.senderName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeamMessage extends TeamMessage {
  const _TeamMessage({required this.id, this.title = '', this.body = '', this.url, this.sentAt, this.recipientsCount = 0, this.senderName}): super._();
  factory _TeamMessage.fromJson(Map<String, dynamic> json) => _$TeamMessageFromJson(json);

@override final  int id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String body;
/// Webpad (`/agenda`, `/events/412`), zelfde als `data.url` in de push.
@override final  String? url;
/// ISO-tijdstip; `null` zolang het bericht nog verstuurd wordt.
@override final  String? sentAt;
@override@JsonKey() final  int recipientsCount;
@override final  String? senderName;

/// Create a copy of TeamMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeamMessageCopyWith<_TeamMessage> get copyWith => __$TeamMessageCopyWithImpl<_TeamMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeamMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeamMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.url, url) || other.url == url)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.recipientsCount, recipientsCount) || other.recipientsCount == recipientsCount)&&(identical(other.senderName, senderName) || other.senderName == senderName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,url,sentAt,recipientsCount,senderName);

@override
String toString() {
  return 'TeamMessage(id: $id, title: $title, body: $body, url: $url, sentAt: $sentAt, recipientsCount: $recipientsCount, senderName: $senderName)';
}


}

/// @nodoc
abstract mixin class _$TeamMessageCopyWith<$Res> implements $TeamMessageCopyWith<$Res> {
  factory _$TeamMessageCopyWith(_TeamMessage value, $Res Function(_TeamMessage) _then) = __$TeamMessageCopyWithImpl;
@override @useResult
$Res call({
 int id, String title, String body, String? url, String? sentAt, int recipientsCount, String? senderName
});




}
/// @nodoc
class __$TeamMessageCopyWithImpl<$Res>
    implements _$TeamMessageCopyWith<$Res> {
  __$TeamMessageCopyWithImpl(this._self, this._then);

  final _TeamMessage _self;
  final $Res Function(_TeamMessage) _then;

/// Create a copy of TeamMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = null,Object? url = freezed,Object? sentAt = freezed,Object? recipientsCount = null,Object? senderName = freezed,}) {
  return _then(_TeamMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,recipientsCount: null == recipientsCount ? _self.recipientsCount : recipientsCount // ignore: cast_nullable_to_non_nullable
as int,senderName: freezed == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$AutoMessageSetting {

 String get key; String get label; bool get enabled; String get titleTemplate; String get bodyTemplate; List<String> get placeholders;/// `false` = alleen aan/uit, geen eigen tekst.
 bool get templated;
/// Create a copy of AutoMessageSetting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutoMessageSettingCopyWith<AutoMessageSetting> get copyWith => _$AutoMessageSettingCopyWithImpl<AutoMessageSetting>(this as AutoMessageSetting, _$identity);

  /// Serializes this AutoMessageSetting to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutoMessageSetting&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.titleTemplate, titleTemplate) || other.titleTemplate == titleTemplate)&&(identical(other.bodyTemplate, bodyTemplate) || other.bodyTemplate == bodyTemplate)&&const DeepCollectionEquality().equals(other.placeholders, placeholders)&&(identical(other.templated, templated) || other.templated == templated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label,enabled,titleTemplate,bodyTemplate,const DeepCollectionEquality().hash(placeholders),templated);

@override
String toString() {
  return 'AutoMessageSetting(key: $key, label: $label, enabled: $enabled, titleTemplate: $titleTemplate, bodyTemplate: $bodyTemplate, placeholders: $placeholders, templated: $templated)';
}


}

/// @nodoc
abstract mixin class $AutoMessageSettingCopyWith<$Res>  {
  factory $AutoMessageSettingCopyWith(AutoMessageSetting value, $Res Function(AutoMessageSetting) _then) = _$AutoMessageSettingCopyWithImpl;
@useResult
$Res call({
 String key, String label, bool enabled, String titleTemplate, String bodyTemplate, List<String> placeholders, bool templated
});




}
/// @nodoc
class _$AutoMessageSettingCopyWithImpl<$Res>
    implements $AutoMessageSettingCopyWith<$Res> {
  _$AutoMessageSettingCopyWithImpl(this._self, this._then);

  final AutoMessageSetting _self;
  final $Res Function(AutoMessageSetting) _then;

/// Create a copy of AutoMessageSetting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,Object? enabled = null,Object? titleTemplate = null,Object? bodyTemplate = null,Object? placeholders = null,Object? templated = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,titleTemplate: null == titleTemplate ? _self.titleTemplate : titleTemplate // ignore: cast_nullable_to_non_nullable
as String,bodyTemplate: null == bodyTemplate ? _self.bodyTemplate : bodyTemplate // ignore: cast_nullable_to_non_nullable
as String,placeholders: null == placeholders ? _self.placeholders : placeholders // ignore: cast_nullable_to_non_nullable
as List<String>,templated: null == templated ? _self.templated : templated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AutoMessageSetting].
extension AutoMessageSettingPatterns on AutoMessageSetting {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AutoMessageSetting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AutoMessageSetting() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AutoMessageSetting value)  $default,){
final _that = this;
switch (_that) {
case _AutoMessageSetting():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AutoMessageSetting value)?  $default,){
final _that = this;
switch (_that) {
case _AutoMessageSetting() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String label,  bool enabled,  String titleTemplate,  String bodyTemplate,  List<String> placeholders,  bool templated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AutoMessageSetting() when $default != null:
return $default(_that.key,_that.label,_that.enabled,_that.titleTemplate,_that.bodyTemplate,_that.placeholders,_that.templated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String label,  bool enabled,  String titleTemplate,  String bodyTemplate,  List<String> placeholders,  bool templated)  $default,) {final _that = this;
switch (_that) {
case _AutoMessageSetting():
return $default(_that.key,_that.label,_that.enabled,_that.titleTemplate,_that.bodyTemplate,_that.placeholders,_that.templated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String label,  bool enabled,  String titleTemplate,  String bodyTemplate,  List<String> placeholders,  bool templated)?  $default,) {final _that = this;
switch (_that) {
case _AutoMessageSetting() when $default != null:
return $default(_that.key,_that.label,_that.enabled,_that.titleTemplate,_that.bodyTemplate,_that.placeholders,_that.templated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AutoMessageSetting extends AutoMessageSetting {
  const _AutoMessageSetting({required this.key, this.label = '', this.enabled = true, this.titleTemplate = '', this.bodyTemplate = '', final  List<String> placeholders = const <String>[], this.templated = true}): _placeholders = placeholders,super._();
  factory _AutoMessageSetting.fromJson(Map<String, dynamic> json) => _$AutoMessageSettingFromJson(json);

@override final  String key;
@override@JsonKey() final  String label;
@override@JsonKey() final  bool enabled;
@override@JsonKey() final  String titleTemplate;
@override@JsonKey() final  String bodyTemplate;
 final  List<String> _placeholders;
@override@JsonKey() List<String> get placeholders {
  if (_placeholders is EqualUnmodifiableListView) return _placeholders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_placeholders);
}

/// `false` = alleen aan/uit, geen eigen tekst.
@override@JsonKey() final  bool templated;

/// Create a copy of AutoMessageSetting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutoMessageSettingCopyWith<_AutoMessageSetting> get copyWith => __$AutoMessageSettingCopyWithImpl<_AutoMessageSetting>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AutoMessageSettingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutoMessageSetting&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.titleTemplate, titleTemplate) || other.titleTemplate == titleTemplate)&&(identical(other.bodyTemplate, bodyTemplate) || other.bodyTemplate == bodyTemplate)&&const DeepCollectionEquality().equals(other._placeholders, _placeholders)&&(identical(other.templated, templated) || other.templated == templated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label,enabled,titleTemplate,bodyTemplate,const DeepCollectionEquality().hash(_placeholders),templated);

@override
String toString() {
  return 'AutoMessageSetting(key: $key, label: $label, enabled: $enabled, titleTemplate: $titleTemplate, bodyTemplate: $bodyTemplate, placeholders: $placeholders, templated: $templated)';
}


}

/// @nodoc
abstract mixin class _$AutoMessageSettingCopyWith<$Res> implements $AutoMessageSettingCopyWith<$Res> {
  factory _$AutoMessageSettingCopyWith(_AutoMessageSetting value, $Res Function(_AutoMessageSetting) _then) = __$AutoMessageSettingCopyWithImpl;
@override @useResult
$Res call({
 String key, String label, bool enabled, String titleTemplate, String bodyTemplate, List<String> placeholders, bool templated
});




}
/// @nodoc
class __$AutoMessageSettingCopyWithImpl<$Res>
    implements _$AutoMessageSettingCopyWith<$Res> {
  __$AutoMessageSettingCopyWithImpl(this._self, this._then);

  final _AutoMessageSetting _self;
  final $Res Function(_AutoMessageSetting) _then;

/// Create a copy of AutoMessageSetting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,Object? enabled = null,Object? titleTemplate = null,Object? bodyTemplate = null,Object? placeholders = null,Object? templated = null,}) {
  return _then(_AutoMessageSetting(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,titleTemplate: null == titleTemplate ? _self.titleTemplate : titleTemplate // ignore: cast_nullable_to_non_nullable
as String,bodyTemplate: null == bodyTemplate ? _self.bodyTemplate : bodyTemplate // ignore: cast_nullable_to_non_nullable
as String,placeholders: null == placeholders ? _self._placeholders : placeholders // ignore: cast_nullable_to_non_nullable
as List<String>,templated: null == templated ? _self.templated : templated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$AutoHistoryEntry {

 String get type; String get label; String? get title; String? get body; String? get sentAt; int get recipientsCount;
/// Create a copy of AutoHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AutoHistoryEntryCopyWith<AutoHistoryEntry> get copyWith => _$AutoHistoryEntryCopyWithImpl<AutoHistoryEntry>(this as AutoHistoryEntry, _$identity);

  /// Serializes this AutoHistoryEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AutoHistoryEntry&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.recipientsCount, recipientsCount) || other.recipientsCount == recipientsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,label,title,body,sentAt,recipientsCount);

@override
String toString() {
  return 'AutoHistoryEntry(type: $type, label: $label, title: $title, body: $body, sentAt: $sentAt, recipientsCount: $recipientsCount)';
}


}

/// @nodoc
abstract mixin class $AutoHistoryEntryCopyWith<$Res>  {
  factory $AutoHistoryEntryCopyWith(AutoHistoryEntry value, $Res Function(AutoHistoryEntry) _then) = _$AutoHistoryEntryCopyWithImpl;
@useResult
$Res call({
 String type, String label, String? title, String? body, String? sentAt, int recipientsCount
});




}
/// @nodoc
class _$AutoHistoryEntryCopyWithImpl<$Res>
    implements $AutoHistoryEntryCopyWith<$Res> {
  _$AutoHistoryEntryCopyWithImpl(this._self, this._then);

  final AutoHistoryEntry _self;
  final $Res Function(AutoHistoryEntry) _then;

/// Create a copy of AutoHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? label = null,Object? title = freezed,Object? body = freezed,Object? sentAt = freezed,Object? recipientsCount = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,recipientsCount: null == recipientsCount ? _self.recipientsCount : recipientsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AutoHistoryEntry].
extension AutoHistoryEntryPatterns on AutoHistoryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AutoHistoryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AutoHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AutoHistoryEntry value)  $default,){
final _that = this;
switch (_that) {
case _AutoHistoryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AutoHistoryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _AutoHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String type,  String label,  String? title,  String? body,  String? sentAt,  int recipientsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AutoHistoryEntry() when $default != null:
return $default(_that.type,_that.label,_that.title,_that.body,_that.sentAt,_that.recipientsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String type,  String label,  String? title,  String? body,  String? sentAt,  int recipientsCount)  $default,) {final _that = this;
switch (_that) {
case _AutoHistoryEntry():
return $default(_that.type,_that.label,_that.title,_that.body,_that.sentAt,_that.recipientsCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String type,  String label,  String? title,  String? body,  String? sentAt,  int recipientsCount)?  $default,) {final _that = this;
switch (_that) {
case _AutoHistoryEntry() when $default != null:
return $default(_that.type,_that.label,_that.title,_that.body,_that.sentAt,_that.recipientsCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AutoHistoryEntry extends AutoHistoryEntry {
  const _AutoHistoryEntry({this.type = '', this.label = '', this.title, this.body, this.sentAt, this.recipientsCount = 0}): super._();
  factory _AutoHistoryEntry.fromJson(Map<String, dynamic> json) => _$AutoHistoryEntryFromJson(json);

@override@JsonKey() final  String type;
@override@JsonKey() final  String label;
@override final  String? title;
@override final  String? body;
@override final  String? sentAt;
@override@JsonKey() final  int recipientsCount;

/// Create a copy of AutoHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AutoHistoryEntryCopyWith<_AutoHistoryEntry> get copyWith => __$AutoHistoryEntryCopyWithImpl<_AutoHistoryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AutoHistoryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AutoHistoryEntry&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.recipientsCount, recipientsCount) || other.recipientsCount == recipientsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,label,title,body,sentAt,recipientsCount);

@override
String toString() {
  return 'AutoHistoryEntry(type: $type, label: $label, title: $title, body: $body, sentAt: $sentAt, recipientsCount: $recipientsCount)';
}


}

/// @nodoc
abstract mixin class _$AutoHistoryEntryCopyWith<$Res> implements $AutoHistoryEntryCopyWith<$Res> {
  factory _$AutoHistoryEntryCopyWith(_AutoHistoryEntry value, $Res Function(_AutoHistoryEntry) _then) = __$AutoHistoryEntryCopyWithImpl;
@override @useResult
$Res call({
 String type, String label, String? title, String? body, String? sentAt, int recipientsCount
});




}
/// @nodoc
class __$AutoHistoryEntryCopyWithImpl<$Res>
    implements _$AutoHistoryEntryCopyWith<$Res> {
  __$AutoHistoryEntryCopyWithImpl(this._self, this._then);

  final _AutoHistoryEntry _self;
  final $Res Function(_AutoHistoryEntry) _then;

/// Create a copy of AutoHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? label = null,Object? title = freezed,Object? body = freezed,Object? sentAt = freezed,Object? recipientsCount = null,}) {
  return _then(_AutoHistoryEntry(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as String?,recipientsCount: null == recipientsCount ? _self.recipientsCount : recipientsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$LinkTarget {

 String get value; String get label;
/// Create a copy of LinkTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinkTargetCopyWith<LinkTarget> get copyWith => _$LinkTargetCopyWithImpl<LinkTarget>(this as LinkTarget, _$identity);

  /// Serializes this LinkTarget to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkTarget&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,label);

@override
String toString() {
  return 'LinkTarget(value: $value, label: $label)';
}


}

/// @nodoc
abstract mixin class $LinkTargetCopyWith<$Res>  {
  factory $LinkTargetCopyWith(LinkTarget value, $Res Function(LinkTarget) _then) = _$LinkTargetCopyWithImpl;
@useResult
$Res call({
 String value, String label
});




}
/// @nodoc
class _$LinkTargetCopyWithImpl<$Res>
    implements $LinkTargetCopyWith<$Res> {
  _$LinkTargetCopyWithImpl(this._self, this._then);

  final LinkTarget _self;
  final $Res Function(LinkTarget) _then;

/// Create a copy of LinkTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,Object? label = null,}) {
  return _then(_self.copyWith(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LinkTarget].
extension LinkTargetPatterns on LinkTarget {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LinkTarget value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LinkTarget() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LinkTarget value)  $default,){
final _that = this;
switch (_that) {
case _LinkTarget():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LinkTarget value)?  $default,){
final _that = this;
switch (_that) {
case _LinkTarget() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String value,  String label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LinkTarget() when $default != null:
return $default(_that.value,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String value,  String label)  $default,) {final _that = this;
switch (_that) {
case _LinkTarget():
return $default(_that.value,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String value,  String label)?  $default,) {final _that = this;
switch (_that) {
case _LinkTarget() when $default != null:
return $default(_that.value,_that.label);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LinkTarget implements LinkTarget {
  const _LinkTarget({required this.value, this.label = ''});
  factory _LinkTarget.fromJson(Map<String, dynamic> json) => _$LinkTargetFromJson(json);

@override final  String value;
@override@JsonKey() final  String label;

/// Create a copy of LinkTarget
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LinkTargetCopyWith<_LinkTarget> get copyWith => __$LinkTargetCopyWithImpl<_LinkTarget>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LinkTargetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinkTarget&&(identical(other.value, value) || other.value == value)&&(identical(other.label, label) || other.label == label));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,value,label);

@override
String toString() {
  return 'LinkTarget(value: $value, label: $label)';
}


}

/// @nodoc
abstract mixin class _$LinkTargetCopyWith<$Res> implements $LinkTargetCopyWith<$Res> {
  factory _$LinkTargetCopyWith(_LinkTarget value, $Res Function(_LinkTarget) _then) = __$LinkTargetCopyWithImpl;
@override @useResult
$Res call({
 String value, String label
});




}
/// @nodoc
class __$LinkTargetCopyWithImpl<$Res>
    implements _$LinkTargetCopyWith<$Res> {
  __$LinkTargetCopyWithImpl(this._self, this._then);

  final _LinkTarget _self;
  final $Res Function(_LinkTarget) _then;

/// Create a copy of LinkTarget
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,Object? label = null,}) {
  return _then(_LinkTarget(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LinkTargetGroup {

 String get label; List<LinkTarget> get options;
/// Create a copy of LinkTargetGroup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinkTargetGroupCopyWith<LinkTargetGroup> get copyWith => _$LinkTargetGroupCopyWithImpl<LinkTargetGroup>(this as LinkTargetGroup, _$identity);

  /// Serializes this LinkTargetGroup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkTargetGroup&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other.options, options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,const DeepCollectionEquality().hash(options));

@override
String toString() {
  return 'LinkTargetGroup(label: $label, options: $options)';
}


}

/// @nodoc
abstract mixin class $LinkTargetGroupCopyWith<$Res>  {
  factory $LinkTargetGroupCopyWith(LinkTargetGroup value, $Res Function(LinkTargetGroup) _then) = _$LinkTargetGroupCopyWithImpl;
@useResult
$Res call({
 String label, List<LinkTarget> options
});




}
/// @nodoc
class _$LinkTargetGroupCopyWithImpl<$Res>
    implements $LinkTargetGroupCopyWith<$Res> {
  _$LinkTargetGroupCopyWithImpl(this._self, this._then);

  final LinkTargetGroup _self;
  final $Res Function(LinkTargetGroup) _then;

/// Create a copy of LinkTargetGroup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? options = null,}) {
  return _then(_self.copyWith(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<LinkTarget>,
  ));
}

}


/// Adds pattern-matching-related methods to [LinkTargetGroup].
extension LinkTargetGroupPatterns on LinkTargetGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LinkTargetGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LinkTargetGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LinkTargetGroup value)  $default,){
final _that = this;
switch (_that) {
case _LinkTargetGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LinkTargetGroup value)?  $default,){
final _that = this;
switch (_that) {
case _LinkTargetGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  List<LinkTarget> options)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LinkTargetGroup() when $default != null:
return $default(_that.label,_that.options);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  List<LinkTarget> options)  $default,) {final _that = this;
switch (_that) {
case _LinkTargetGroup():
return $default(_that.label,_that.options);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  List<LinkTarget> options)?  $default,) {final _that = this;
switch (_that) {
case _LinkTargetGroup() when $default != null:
return $default(_that.label,_that.options);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LinkTargetGroup implements LinkTargetGroup {
  const _LinkTargetGroup({this.label = '', final  List<LinkTarget> options = const <LinkTarget>[]}): _options = options;
  factory _LinkTargetGroup.fromJson(Map<String, dynamic> json) => _$LinkTargetGroupFromJson(json);

@override@JsonKey() final  String label;
 final  List<LinkTarget> _options;
@override@JsonKey() List<LinkTarget> get options {
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_options);
}


/// Create a copy of LinkTargetGroup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LinkTargetGroupCopyWith<_LinkTargetGroup> get copyWith => __$LinkTargetGroupCopyWithImpl<_LinkTargetGroup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LinkTargetGroupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinkTargetGroup&&(identical(other.label, label) || other.label == label)&&const DeepCollectionEquality().equals(other._options, _options));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,label,const DeepCollectionEquality().hash(_options));

@override
String toString() {
  return 'LinkTargetGroup(label: $label, options: $options)';
}


}

/// @nodoc
abstract mixin class _$LinkTargetGroupCopyWith<$Res> implements $LinkTargetGroupCopyWith<$Res> {
  factory _$LinkTargetGroupCopyWith(_LinkTargetGroup value, $Res Function(_LinkTargetGroup) _then) = __$LinkTargetGroupCopyWithImpl;
@override @useResult
$Res call({
 String label, List<LinkTarget> options
});




}
/// @nodoc
class __$LinkTargetGroupCopyWithImpl<$Res>
    implements _$LinkTargetGroupCopyWith<$Res> {
  __$LinkTargetGroupCopyWithImpl(this._self, this._then);

  final _LinkTargetGroup _self;
  final $Res Function(_LinkTargetGroup) _then;

/// Create a copy of LinkTargetGroup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? options = null,}) {
  return _then(_LinkTargetGroup(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<LinkTarget>,
  ));
}


}


/// @nodoc
mixin _$MessagesOverview {

 List<TeamMessage> get messages; List<AutoMessageSetting> get autoSettings; List<AutoHistoryEntry> get autoHistory; List<LinkTargetGroup> get linkTargets;
/// Create a copy of MessagesOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessagesOverviewCopyWith<MessagesOverview> get copyWith => _$MessagesOverviewCopyWithImpl<MessagesOverview>(this as MessagesOverview, _$identity);

  /// Serializes this MessagesOverview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessagesOverview&&const DeepCollectionEquality().equals(other.messages, messages)&&const DeepCollectionEquality().equals(other.autoSettings, autoSettings)&&const DeepCollectionEquality().equals(other.autoHistory, autoHistory)&&const DeepCollectionEquality().equals(other.linkTargets, linkTargets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(messages),const DeepCollectionEquality().hash(autoSettings),const DeepCollectionEquality().hash(autoHistory),const DeepCollectionEquality().hash(linkTargets));

@override
String toString() {
  return 'MessagesOverview(messages: $messages, autoSettings: $autoSettings, autoHistory: $autoHistory, linkTargets: $linkTargets)';
}


}

/// @nodoc
abstract mixin class $MessagesOverviewCopyWith<$Res>  {
  factory $MessagesOverviewCopyWith(MessagesOverview value, $Res Function(MessagesOverview) _then) = _$MessagesOverviewCopyWithImpl;
@useResult
$Res call({
 List<TeamMessage> messages, List<AutoMessageSetting> autoSettings, List<AutoHistoryEntry> autoHistory, List<LinkTargetGroup> linkTargets
});




}
/// @nodoc
class _$MessagesOverviewCopyWithImpl<$Res>
    implements $MessagesOverviewCopyWith<$Res> {
  _$MessagesOverviewCopyWithImpl(this._self, this._then);

  final MessagesOverview _self;
  final $Res Function(MessagesOverview) _then;

/// Create a copy of MessagesOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? messages = null,Object? autoSettings = null,Object? autoHistory = null,Object? linkTargets = null,}) {
  return _then(_self.copyWith(
messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<TeamMessage>,autoSettings: null == autoSettings ? _self.autoSettings : autoSettings // ignore: cast_nullable_to_non_nullable
as List<AutoMessageSetting>,autoHistory: null == autoHistory ? _self.autoHistory : autoHistory // ignore: cast_nullable_to_non_nullable
as List<AutoHistoryEntry>,linkTargets: null == linkTargets ? _self.linkTargets : linkTargets // ignore: cast_nullable_to_non_nullable
as List<LinkTargetGroup>,
  ));
}

}


/// Adds pattern-matching-related methods to [MessagesOverview].
extension MessagesOverviewPatterns on MessagesOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessagesOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessagesOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessagesOverview value)  $default,){
final _that = this;
switch (_that) {
case _MessagesOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessagesOverview value)?  $default,){
final _that = this;
switch (_that) {
case _MessagesOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TeamMessage> messages,  List<AutoMessageSetting> autoSettings,  List<AutoHistoryEntry> autoHistory,  List<LinkTargetGroup> linkTargets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessagesOverview() when $default != null:
return $default(_that.messages,_that.autoSettings,_that.autoHistory,_that.linkTargets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TeamMessage> messages,  List<AutoMessageSetting> autoSettings,  List<AutoHistoryEntry> autoHistory,  List<LinkTargetGroup> linkTargets)  $default,) {final _that = this;
switch (_that) {
case _MessagesOverview():
return $default(_that.messages,_that.autoSettings,_that.autoHistory,_that.linkTargets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TeamMessage> messages,  List<AutoMessageSetting> autoSettings,  List<AutoHistoryEntry> autoHistory,  List<LinkTargetGroup> linkTargets)?  $default,) {final _that = this;
switch (_that) {
case _MessagesOverview() when $default != null:
return $default(_that.messages,_that.autoSettings,_that.autoHistory,_that.linkTargets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessagesOverview extends MessagesOverview {
  const _MessagesOverview({final  List<TeamMessage> messages = const <TeamMessage>[], final  List<AutoMessageSetting> autoSettings = const <AutoMessageSetting>[], final  List<AutoHistoryEntry> autoHistory = const <AutoHistoryEntry>[], final  List<LinkTargetGroup> linkTargets = const <LinkTargetGroup>[]}): _messages = messages,_autoSettings = autoSettings,_autoHistory = autoHistory,_linkTargets = linkTargets,super._();
  factory _MessagesOverview.fromJson(Map<String, dynamic> json) => _$MessagesOverviewFromJson(json);

 final  List<TeamMessage> _messages;
@override@JsonKey() List<TeamMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

 final  List<AutoMessageSetting> _autoSettings;
@override@JsonKey() List<AutoMessageSetting> get autoSettings {
  if (_autoSettings is EqualUnmodifiableListView) return _autoSettings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_autoSettings);
}

 final  List<AutoHistoryEntry> _autoHistory;
@override@JsonKey() List<AutoHistoryEntry> get autoHistory {
  if (_autoHistory is EqualUnmodifiableListView) return _autoHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_autoHistory);
}

 final  List<LinkTargetGroup> _linkTargets;
@override@JsonKey() List<LinkTargetGroup> get linkTargets {
  if (_linkTargets is EqualUnmodifiableListView) return _linkTargets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_linkTargets);
}


/// Create a copy of MessagesOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessagesOverviewCopyWith<_MessagesOverview> get copyWith => __$MessagesOverviewCopyWithImpl<_MessagesOverview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessagesOverviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessagesOverview&&const DeepCollectionEquality().equals(other._messages, _messages)&&const DeepCollectionEquality().equals(other._autoSettings, _autoSettings)&&const DeepCollectionEquality().equals(other._autoHistory, _autoHistory)&&const DeepCollectionEquality().equals(other._linkTargets, _linkTargets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages),const DeepCollectionEquality().hash(_autoSettings),const DeepCollectionEquality().hash(_autoHistory),const DeepCollectionEquality().hash(_linkTargets));

@override
String toString() {
  return 'MessagesOverview(messages: $messages, autoSettings: $autoSettings, autoHistory: $autoHistory, linkTargets: $linkTargets)';
}


}

/// @nodoc
abstract mixin class _$MessagesOverviewCopyWith<$Res> implements $MessagesOverviewCopyWith<$Res> {
  factory _$MessagesOverviewCopyWith(_MessagesOverview value, $Res Function(_MessagesOverview) _then) = __$MessagesOverviewCopyWithImpl;
@override @useResult
$Res call({
 List<TeamMessage> messages, List<AutoMessageSetting> autoSettings, List<AutoHistoryEntry> autoHistory, List<LinkTargetGroup> linkTargets
});




}
/// @nodoc
class __$MessagesOverviewCopyWithImpl<$Res>
    implements _$MessagesOverviewCopyWith<$Res> {
  __$MessagesOverviewCopyWithImpl(this._self, this._then);

  final _MessagesOverview _self;
  final $Res Function(_MessagesOverview) _then;

/// Create a copy of MessagesOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? messages = null,Object? autoSettings = null,Object? autoHistory = null,Object? linkTargets = null,}) {
  return _then(_MessagesOverview(
messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<TeamMessage>,autoSettings: null == autoSettings ? _self._autoSettings : autoSettings // ignore: cast_nullable_to_non_nullable
as List<AutoMessageSetting>,autoHistory: null == autoHistory ? _self._autoHistory : autoHistory // ignore: cast_nullable_to_non_nullable
as List<AutoHistoryEntry>,linkTargets: null == linkTargets ? _self._linkTargets : linkTargets // ignore: cast_nullable_to_non_nullable
as List<LinkTargetGroup>,
  ));
}


}

// dart format on
