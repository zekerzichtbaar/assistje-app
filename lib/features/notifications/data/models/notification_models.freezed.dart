// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppNotification {

/// uuid van de melding.
 String get id;/// Soort in snake_case (`lineup_published`, …), voor het icoon.
 String get type; String get title; String get body;/// Webpad (`/events/12/lineup`); de deep-link-mapper maakt er een
/// app-route van. `null` = de melding brengt nergens heen.
 String? get url;/// Dezelfde bestemming absoluut op het teamsubdomein.
 String? get link; bool get read; DateTime? get readAt; DateTime get createdAt;
/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppNotificationCopyWith<AppNotification> get copyWith => _$AppNotificationCopyWithImpl<AppNotification>(this as AppNotification, _$identity);

  /// Serializes this AppNotification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.url, url) || other.url == url)&&(identical(other.link, link) || other.link == link)&&(identical(other.read, read) || other.read == read)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,body,url,link,read,readAt,createdAt);

@override
String toString() {
  return 'AppNotification(id: $id, type: $type, title: $title, body: $body, url: $url, link: $link, read: $read, readAt: $readAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $AppNotificationCopyWith<$Res>  {
  factory $AppNotificationCopyWith(AppNotification value, $Res Function(AppNotification) _then) = _$AppNotificationCopyWithImpl;
@useResult
$Res call({
 String id, String type, String title, String body, String? url, String? link, bool read, DateTime? readAt, DateTime createdAt
});




}
/// @nodoc
class _$AppNotificationCopyWithImpl<$Res>
    implements $AppNotificationCopyWith<$Res> {
  _$AppNotificationCopyWithImpl(this._self, this._then);

  final AppNotification _self;
  final $Res Function(AppNotification) _then;

/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? title = null,Object? body = null,Object? url = freezed,Object? link = freezed,Object? read = null,Object? readAt = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AppNotification].
extension AppNotificationPatterns on AppNotification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppNotification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppNotification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppNotification value)  $default,){
final _that = this;
switch (_that) {
case _AppNotification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppNotification value)?  $default,){
final _that = this;
switch (_that) {
case _AppNotification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String title,  String body,  String? url,  String? link,  bool read,  DateTime? readAt,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppNotification() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.body,_that.url,_that.link,_that.read,_that.readAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String title,  String body,  String? url,  String? link,  bool read,  DateTime? readAt,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _AppNotification():
return $default(_that.id,_that.type,_that.title,_that.body,_that.url,_that.link,_that.read,_that.readAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String title,  String body,  String? url,  String? link,  bool read,  DateTime? readAt,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _AppNotification() when $default != null:
return $default(_that.id,_that.type,_that.title,_that.body,_that.url,_that.link,_that.read,_that.readAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppNotification implements AppNotification {
  const _AppNotification({required this.id, this.type = '', this.title = '', this.body = '', this.url, this.link, this.read = false, this.readAt, required this.createdAt});
  factory _AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);

/// uuid van de melding.
@override final  String id;
/// Soort in snake_case (`lineup_published`, …), voor het icoon.
@override@JsonKey() final  String type;
@override@JsonKey() final  String title;
@override@JsonKey() final  String body;
/// Webpad (`/events/12/lineup`); de deep-link-mapper maakt er een
/// app-route van. `null` = de melding brengt nergens heen.
@override final  String? url;
/// Dezelfde bestemming absoluut op het teamsubdomein.
@override final  String? link;
@override@JsonKey() final  bool read;
@override final  DateTime? readAt;
@override final  DateTime createdAt;

/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppNotificationCopyWith<_AppNotification> get copyWith => __$AppNotificationCopyWithImpl<_AppNotification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppNotificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppNotification&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.url, url) || other.url == url)&&(identical(other.link, link) || other.link == link)&&(identical(other.read, read) || other.read == read)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,title,body,url,link,read,readAt,createdAt);

@override
String toString() {
  return 'AppNotification(id: $id, type: $type, title: $title, body: $body, url: $url, link: $link, read: $read, readAt: $readAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$AppNotificationCopyWith<$Res> implements $AppNotificationCopyWith<$Res> {
  factory _$AppNotificationCopyWith(_AppNotification value, $Res Function(_AppNotification) _then) = __$AppNotificationCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String title, String body, String? url, String? link, bool read, DateTime? readAt, DateTime createdAt
});




}
/// @nodoc
class __$AppNotificationCopyWithImpl<$Res>
    implements _$AppNotificationCopyWith<$Res> {
  __$AppNotificationCopyWithImpl(this._self, this._then);

  final _AppNotification _self;
  final $Res Function(_AppNotification) _then;

/// Create a copy of AppNotification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? title = null,Object? body = null,Object? url = freezed,Object? link = freezed,Object? read = null,Object? readAt = freezed,Object? createdAt = null,}) {
  return _then(_AppNotification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,read: null == read ? _self.read : read // ignore: cast_nullable_to_non_nullable
as bool,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$NotificationsMeta {

 int get currentPage; int get lastPage; int get perPage; int get total; int get unreadCount;
/// Create a copy of NotificationsMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsMetaCopyWith<NotificationsMeta> get copyWith => _$NotificationsMetaCopyWithImpl<NotificationsMeta>(this as NotificationsMeta, _$identity);

  /// Serializes this NotificationsMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsMeta&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.total, total) || other.total == total)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPage,lastPage,perPage,total,unreadCount);

@override
String toString() {
  return 'NotificationsMeta(currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, total: $total, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class $NotificationsMetaCopyWith<$Res>  {
  factory $NotificationsMetaCopyWith(NotificationsMeta value, $Res Function(NotificationsMeta) _then) = _$NotificationsMetaCopyWithImpl;
@useResult
$Res call({
 int currentPage, int lastPage, int perPage, int total, int unreadCount
});




}
/// @nodoc
class _$NotificationsMetaCopyWithImpl<$Res>
    implements $NotificationsMetaCopyWith<$Res> {
  _$NotificationsMetaCopyWithImpl(this._self, this._then);

  final NotificationsMeta _self;
  final $Res Function(NotificationsMeta) _then;

/// Create a copy of NotificationsMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentPage = null,Object? lastPage = null,Object? perPage = null,Object? total = null,Object? unreadCount = null,}) {
  return _then(_self.copyWith(
currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationsMeta].
extension NotificationsMetaPatterns on NotificationsMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationsMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationsMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationsMeta value)  $default,){
final _that = this;
switch (_that) {
case _NotificationsMeta():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationsMeta value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationsMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentPage,  int lastPage,  int perPage,  int total,  int unreadCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationsMeta() when $default != null:
return $default(_that.currentPage,_that.lastPage,_that.perPage,_that.total,_that.unreadCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentPage,  int lastPage,  int perPage,  int total,  int unreadCount)  $default,) {final _that = this;
switch (_that) {
case _NotificationsMeta():
return $default(_that.currentPage,_that.lastPage,_that.perPage,_that.total,_that.unreadCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentPage,  int lastPage,  int perPage,  int total,  int unreadCount)?  $default,) {final _that = this;
switch (_that) {
case _NotificationsMeta() when $default != null:
return $default(_that.currentPage,_that.lastPage,_that.perPage,_that.total,_that.unreadCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationsMeta implements NotificationsMeta {
  const _NotificationsMeta({this.currentPage = 1, this.lastPage = 1, this.perPage = 20, this.total = 0, this.unreadCount = 0});
  factory _NotificationsMeta.fromJson(Map<String, dynamic> json) => _$NotificationsMetaFromJson(json);

@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int lastPage;
@override@JsonKey() final  int perPage;
@override@JsonKey() final  int total;
@override@JsonKey() final  int unreadCount;

/// Create a copy of NotificationsMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationsMetaCopyWith<_NotificationsMeta> get copyWith => __$NotificationsMetaCopyWithImpl<_NotificationsMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationsMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationsMeta&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&(identical(other.total, total) || other.total == total)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentPage,lastPage,perPage,total,unreadCount);

@override
String toString() {
  return 'NotificationsMeta(currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, total: $total, unreadCount: $unreadCount)';
}


}

/// @nodoc
abstract mixin class _$NotificationsMetaCopyWith<$Res> implements $NotificationsMetaCopyWith<$Res> {
  factory _$NotificationsMetaCopyWith(_NotificationsMeta value, $Res Function(_NotificationsMeta) _then) = __$NotificationsMetaCopyWithImpl;
@override @useResult
$Res call({
 int currentPage, int lastPage, int perPage, int total, int unreadCount
});




}
/// @nodoc
class __$NotificationsMetaCopyWithImpl<$Res>
    implements _$NotificationsMetaCopyWith<$Res> {
  __$NotificationsMetaCopyWithImpl(this._self, this._then);

  final _NotificationsMeta _self;
  final $Res Function(_NotificationsMeta) _then;

/// Create a copy of NotificationsMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentPage = null,Object? lastPage = null,Object? perPage = null,Object? total = null,Object? unreadCount = null,}) {
  return _then(_NotificationsMeta(
currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$NotificationPreferenceType {

 String get key; String get label; String get description;/// Alleen tonen als het huidige team een poule heeft (`has_poule`).
 bool get pouleOnly; bool get enabled;/// De standaardstand (`default` in de JSON).
@JsonKey(name: 'default') bool get enabledByDefault;
/// Create a copy of NotificationPreferenceType
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPreferenceTypeCopyWith<NotificationPreferenceType> get copyWith => _$NotificationPreferenceTypeCopyWithImpl<NotificationPreferenceType>(this as NotificationPreferenceType, _$identity);

  /// Serializes this NotificationPreferenceType to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferenceType&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.description, description) || other.description == description)&&(identical(other.pouleOnly, pouleOnly) || other.pouleOnly == pouleOnly)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.enabledByDefault, enabledByDefault) || other.enabledByDefault == enabledByDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label,description,pouleOnly,enabled,enabledByDefault);

@override
String toString() {
  return 'NotificationPreferenceType(key: $key, label: $label, description: $description, pouleOnly: $pouleOnly, enabled: $enabled, enabledByDefault: $enabledByDefault)';
}


}

/// @nodoc
abstract mixin class $NotificationPreferenceTypeCopyWith<$Res>  {
  factory $NotificationPreferenceTypeCopyWith(NotificationPreferenceType value, $Res Function(NotificationPreferenceType) _then) = _$NotificationPreferenceTypeCopyWithImpl;
@useResult
$Res call({
 String key, String label, String description, bool pouleOnly, bool enabled,@JsonKey(name: 'default') bool enabledByDefault
});




}
/// @nodoc
class _$NotificationPreferenceTypeCopyWithImpl<$Res>
    implements $NotificationPreferenceTypeCopyWith<$Res> {
  _$NotificationPreferenceTypeCopyWithImpl(this._self, this._then);

  final NotificationPreferenceType _self;
  final $Res Function(NotificationPreferenceType) _then;

/// Create a copy of NotificationPreferenceType
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? label = null,Object? description = null,Object? pouleOnly = null,Object? enabled = null,Object? enabledByDefault = null,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,pouleOnly: null == pouleOnly ? _self.pouleOnly : pouleOnly // ignore: cast_nullable_to_non_nullable
as bool,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,enabledByDefault: null == enabledByDefault ? _self.enabledByDefault : enabledByDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPreferenceType].
extension NotificationPreferenceTypePatterns on NotificationPreferenceType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPreferenceType value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPreferenceType() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPreferenceType value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferenceType():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPreferenceType value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferenceType() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  String label,  String description,  bool pouleOnly,  bool enabled, @JsonKey(name: 'default')  bool enabledByDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPreferenceType() when $default != null:
return $default(_that.key,_that.label,_that.description,_that.pouleOnly,_that.enabled,_that.enabledByDefault);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  String label,  String description,  bool pouleOnly,  bool enabled, @JsonKey(name: 'default')  bool enabledByDefault)  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferenceType():
return $default(_that.key,_that.label,_that.description,_that.pouleOnly,_that.enabled,_that.enabledByDefault);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  String label,  String description,  bool pouleOnly,  bool enabled, @JsonKey(name: 'default')  bool enabledByDefault)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferenceType() when $default != null:
return $default(_that.key,_that.label,_that.description,_that.pouleOnly,_that.enabled,_that.enabledByDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationPreferenceType implements NotificationPreferenceType {
  const _NotificationPreferenceType({required this.key, this.label = '', this.description = '', this.pouleOnly = false, this.enabled = true, @JsonKey(name: 'default') this.enabledByDefault = true});
  factory _NotificationPreferenceType.fromJson(Map<String, dynamic> json) => _$NotificationPreferenceTypeFromJson(json);

@override final  String key;
@override@JsonKey() final  String label;
@override@JsonKey() final  String description;
/// Alleen tonen als het huidige team een poule heeft (`has_poule`).
@override@JsonKey() final  bool pouleOnly;
@override@JsonKey() final  bool enabled;
/// De standaardstand (`default` in de JSON).
@override@JsonKey(name: 'default') final  bool enabledByDefault;

/// Create a copy of NotificationPreferenceType
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPreferenceTypeCopyWith<_NotificationPreferenceType> get copyWith => __$NotificationPreferenceTypeCopyWithImpl<_NotificationPreferenceType>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationPreferenceTypeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPreferenceType&&(identical(other.key, key) || other.key == key)&&(identical(other.label, label) || other.label == label)&&(identical(other.description, description) || other.description == description)&&(identical(other.pouleOnly, pouleOnly) || other.pouleOnly == pouleOnly)&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.enabledByDefault, enabledByDefault) || other.enabledByDefault == enabledByDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,label,description,pouleOnly,enabled,enabledByDefault);

@override
String toString() {
  return 'NotificationPreferenceType(key: $key, label: $label, description: $description, pouleOnly: $pouleOnly, enabled: $enabled, enabledByDefault: $enabledByDefault)';
}


}

/// @nodoc
abstract mixin class _$NotificationPreferenceTypeCopyWith<$Res> implements $NotificationPreferenceTypeCopyWith<$Res> {
  factory _$NotificationPreferenceTypeCopyWith(_NotificationPreferenceType value, $Res Function(_NotificationPreferenceType) _then) = __$NotificationPreferenceTypeCopyWithImpl;
@override @useResult
$Res call({
 String key, String label, String description, bool pouleOnly, bool enabled,@JsonKey(name: 'default') bool enabledByDefault
});




}
/// @nodoc
class __$NotificationPreferenceTypeCopyWithImpl<$Res>
    implements _$NotificationPreferenceTypeCopyWith<$Res> {
  __$NotificationPreferenceTypeCopyWithImpl(this._self, this._then);

  final _NotificationPreferenceType _self;
  final $Res Function(_NotificationPreferenceType) _then;

/// Create a copy of NotificationPreferenceType
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? label = null,Object? description = null,Object? pouleOnly = null,Object? enabled = null,Object? enabledByDefault = null,}) {
  return _then(_NotificationPreferenceType(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,pouleOnly: null == pouleOnly ? _self.pouleOnly : pouleOnly // ignore: cast_nullable_to_non_nullable
as bool,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,enabledByDefault: null == enabledByDefault ? _self.enabledByDefault : enabledByDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$NotificationPreferences {

 Map<String, bool> get preferences; List<NotificationPreferenceType> get types;
/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPreferencesCopyWith<NotificationPreferences> get copyWith => _$NotificationPreferencesCopyWithImpl<NotificationPreferences>(this as NotificationPreferences, _$identity);

  /// Serializes this NotificationPreferences to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferences&&const DeepCollectionEquality().equals(other.preferences, preferences)&&const DeepCollectionEquality().equals(other.types, types));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(preferences),const DeepCollectionEquality().hash(types));

@override
String toString() {
  return 'NotificationPreferences(preferences: $preferences, types: $types)';
}


}

/// @nodoc
abstract mixin class $NotificationPreferencesCopyWith<$Res>  {
  factory $NotificationPreferencesCopyWith(NotificationPreferences value, $Res Function(NotificationPreferences) _then) = _$NotificationPreferencesCopyWithImpl;
@useResult
$Res call({
 Map<String, bool> preferences, List<NotificationPreferenceType> types
});




}
/// @nodoc
class _$NotificationPreferencesCopyWithImpl<$Res>
    implements $NotificationPreferencesCopyWith<$Res> {
  _$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final NotificationPreferences _self;
  final $Res Function(NotificationPreferences) _then;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? preferences = null,Object? types = null,}) {
  return _then(_self.copyWith(
preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<NotificationPreferenceType>,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPreferences].
extension NotificationPreferencesPatterns on NotificationPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPreferences value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, bool> preferences,  List<NotificationPreferenceType> types)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
return $default(_that.preferences,_that.types);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, bool> preferences,  List<NotificationPreferenceType> types)  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferences():
return $default(_that.preferences,_that.types);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, bool> preferences,  List<NotificationPreferenceType> types)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferences() when $default != null:
return $default(_that.preferences,_that.types);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationPreferences extends NotificationPreferences {
  const _NotificationPreferences({final  Map<String, bool> preferences = const <String, bool>{}, final  List<NotificationPreferenceType> types = const <NotificationPreferenceType>[]}): _preferences = preferences,_types = types,super._();
  factory _NotificationPreferences.fromJson(Map<String, dynamic> json) => _$NotificationPreferencesFromJson(json);

 final  Map<String, bool> _preferences;
@override@JsonKey() Map<String, bool> get preferences {
  if (_preferences is EqualUnmodifiableMapView) return _preferences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_preferences);
}

 final  List<NotificationPreferenceType> _types;
@override@JsonKey() List<NotificationPreferenceType> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}


/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPreferencesCopyWith<_NotificationPreferences> get copyWith => __$NotificationPreferencesCopyWithImpl<_NotificationPreferences>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationPreferencesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPreferences&&const DeepCollectionEquality().equals(other._preferences, _preferences)&&const DeepCollectionEquality().equals(other._types, _types));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_preferences),const DeepCollectionEquality().hash(_types));

@override
String toString() {
  return 'NotificationPreferences(preferences: $preferences, types: $types)';
}


}

/// @nodoc
abstract mixin class _$NotificationPreferencesCopyWith<$Res> implements $NotificationPreferencesCopyWith<$Res> {
  factory _$NotificationPreferencesCopyWith(_NotificationPreferences value, $Res Function(_NotificationPreferences) _then) = __$NotificationPreferencesCopyWithImpl;
@override @useResult
$Res call({
 Map<String, bool> preferences, List<NotificationPreferenceType> types
});




}
/// @nodoc
class __$NotificationPreferencesCopyWithImpl<$Res>
    implements _$NotificationPreferencesCopyWith<$Res> {
  __$NotificationPreferencesCopyWithImpl(this._self, this._then);

  final _NotificationPreferences _self;
  final $Res Function(_NotificationPreferences) _then;

/// Create a copy of NotificationPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? preferences = null,Object? types = null,}) {
  return _then(_NotificationPreferences(
preferences: null == preferences ? _self._preferences : preferences // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<NotificationPreferenceType>,
  ));
}


}

// dart format on
