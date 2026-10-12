// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feedback_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FeedbackMessage {

 int get id;/// `uit` = van Assistje naar jou, `in` = jouw reactie.
 String get direction; String get body; String? get createdAt;
/// Create a copy of FeedbackMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedbackMessageCopyWith<FeedbackMessage> get copyWith => _$FeedbackMessageCopyWithImpl<FeedbackMessage>(this as FeedbackMessage, _$identity);

  /// Serializes this FeedbackMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,direction,body,createdAt);

@override
String toString() {
  return 'FeedbackMessage(id: $id, direction: $direction, body: $body, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $FeedbackMessageCopyWith<$Res>  {
  factory $FeedbackMessageCopyWith(FeedbackMessage value, $Res Function(FeedbackMessage) _then) = _$FeedbackMessageCopyWithImpl;
@useResult
$Res call({
 int id, String direction, String body, String? createdAt
});




}
/// @nodoc
class _$FeedbackMessageCopyWithImpl<$Res>
    implements $FeedbackMessageCopyWith<$Res> {
  _$FeedbackMessageCopyWithImpl(this._self, this._then);

  final FeedbackMessage _self;
  final $Res Function(FeedbackMessage) _then;

/// Create a copy of FeedbackMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? direction = null,Object? body = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedbackMessage].
extension FeedbackMessagePatterns on FeedbackMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedbackMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedbackMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedbackMessage value)  $default,){
final _that = this;
switch (_that) {
case _FeedbackMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedbackMessage value)?  $default,){
final _that = this;
switch (_that) {
case _FeedbackMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String direction,  String body,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedbackMessage() when $default != null:
return $default(_that.id,_that.direction,_that.body,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String direction,  String body,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _FeedbackMessage():
return $default(_that.id,_that.direction,_that.body,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String direction,  String body,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _FeedbackMessage() when $default != null:
return $default(_that.id,_that.direction,_that.body,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedbackMessage extends FeedbackMessage {
  const _FeedbackMessage({required this.id, this.direction = 'uit', this.body = '', this.createdAt}): super._();
  factory _FeedbackMessage.fromJson(Map<String, dynamic> json) => _$FeedbackMessageFromJson(json);

@override final  int id;
/// `uit` = van Assistje naar jou, `in` = jouw reactie.
@override@JsonKey() final  String direction;
@override@JsonKey() final  String body;
@override final  String? createdAt;

/// Create a copy of FeedbackMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedbackMessageCopyWith<_FeedbackMessage> get copyWith => __$FeedbackMessageCopyWithImpl<_FeedbackMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedbackMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedbackMessage&&(identical(other.id, id) || other.id == id)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.body, body) || other.body == body)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,direction,body,createdAt);

@override
String toString() {
  return 'FeedbackMessage(id: $id, direction: $direction, body: $body, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$FeedbackMessageCopyWith<$Res> implements $FeedbackMessageCopyWith<$Res> {
  factory _$FeedbackMessageCopyWith(_FeedbackMessage value, $Res Function(_FeedbackMessage) _then) = __$FeedbackMessageCopyWithImpl;
@override @useResult
$Res call({
 int id, String direction, String body, String? createdAt
});




}
/// @nodoc
class __$FeedbackMessageCopyWithImpl<$Res>
    implements _$FeedbackMessageCopyWith<$Res> {
  __$FeedbackMessageCopyWithImpl(this._self, this._then);

  final _FeedbackMessage _self;
  final $Res Function(_FeedbackMessage) _then;

/// Create a copy of FeedbackMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? direction = null,Object? body = null,Object? createdAt = freezed,}) {
  return _then(_FeedbackMessage(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$FeedbackItem {

 int get id; String? get kind; String get body; String? get status;/// Absolute URL die alleen met het bearer-token werkt, of `null`.
 String? get imageUrl; List<FeedbackMessage> get messages; String? get createdAt; String? get resolvedAt;
/// Create a copy of FeedbackItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedbackItemCopyWith<FeedbackItem> get copyWith => _$FeedbackItemCopyWithImpl<FeedbackItem>(this as FeedbackItem, _$identity);

  /// Serializes this FeedbackItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedbackItem&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.body, body) || other.body == body)&&(identical(other.status, status) || other.status == status)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.messages, messages)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,kind,body,status,imageUrl,const DeepCollectionEquality().hash(messages),createdAt,resolvedAt);

@override
String toString() {
  return 'FeedbackItem(id: $id, kind: $kind, body: $body, status: $status, imageUrl: $imageUrl, messages: $messages, createdAt: $createdAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class $FeedbackItemCopyWith<$Res>  {
  factory $FeedbackItemCopyWith(FeedbackItem value, $Res Function(FeedbackItem) _then) = _$FeedbackItemCopyWithImpl;
@useResult
$Res call({
 int id, String? kind, String body, String? status, String? imageUrl, List<FeedbackMessage> messages, String? createdAt, String? resolvedAt
});




}
/// @nodoc
class _$FeedbackItemCopyWithImpl<$Res>
    implements $FeedbackItemCopyWith<$Res> {
  _$FeedbackItemCopyWithImpl(this._self, this._then);

  final FeedbackItem _self;
  final $Res Function(FeedbackItem) _then;

/// Create a copy of FeedbackItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? kind = freezed,Object? body = null,Object? status = freezed,Object? imageUrl = freezed,Object? messages = null,Object? createdAt = freezed,Object? resolvedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,kind: freezed == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<FeedbackMessage>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedbackItem].
extension FeedbackItemPatterns on FeedbackItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedbackItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedbackItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedbackItem value)  $default,){
final _that = this;
switch (_that) {
case _FeedbackItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedbackItem value)?  $default,){
final _that = this;
switch (_that) {
case _FeedbackItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String? kind,  String body,  String? status,  String? imageUrl,  List<FeedbackMessage> messages,  String? createdAt,  String? resolvedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedbackItem() when $default != null:
return $default(_that.id,_that.kind,_that.body,_that.status,_that.imageUrl,_that.messages,_that.createdAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String? kind,  String body,  String? status,  String? imageUrl,  List<FeedbackMessage> messages,  String? createdAt,  String? resolvedAt)  $default,) {final _that = this;
switch (_that) {
case _FeedbackItem():
return $default(_that.id,_that.kind,_that.body,_that.status,_that.imageUrl,_that.messages,_that.createdAt,_that.resolvedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String? kind,  String body,  String? status,  String? imageUrl,  List<FeedbackMessage> messages,  String? createdAt,  String? resolvedAt)?  $default,) {final _that = this;
switch (_that) {
case _FeedbackItem() when $default != null:
return $default(_that.id,_that.kind,_that.body,_that.status,_that.imageUrl,_that.messages,_that.createdAt,_that.resolvedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedbackItem extends FeedbackItem {
  const _FeedbackItem({required this.id, this.kind, this.body = '', this.status, this.imageUrl, final  List<FeedbackMessage> messages = const <FeedbackMessage>[], this.createdAt, this.resolvedAt}): _messages = messages,super._();
  factory _FeedbackItem.fromJson(Map<String, dynamic> json) => _$FeedbackItemFromJson(json);

@override final  int id;
@override final  String? kind;
@override@JsonKey() final  String body;
@override final  String? status;
/// Absolute URL die alleen met het bearer-token werkt, of `null`.
@override final  String? imageUrl;
 final  List<FeedbackMessage> _messages;
@override@JsonKey() List<FeedbackMessage> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override final  String? createdAt;
@override final  String? resolvedAt;

/// Create a copy of FeedbackItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedbackItemCopyWith<_FeedbackItem> get copyWith => __$FeedbackItemCopyWithImpl<_FeedbackItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedbackItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedbackItem&&(identical(other.id, id) || other.id == id)&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.body, body) || other.body == body)&&(identical(other.status, status) || other.status == status)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._messages, _messages)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.resolvedAt, resolvedAt) || other.resolvedAt == resolvedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,kind,body,status,imageUrl,const DeepCollectionEquality().hash(_messages),createdAt,resolvedAt);

@override
String toString() {
  return 'FeedbackItem(id: $id, kind: $kind, body: $body, status: $status, imageUrl: $imageUrl, messages: $messages, createdAt: $createdAt, resolvedAt: $resolvedAt)';
}


}

/// @nodoc
abstract mixin class _$FeedbackItemCopyWith<$Res> implements $FeedbackItemCopyWith<$Res> {
  factory _$FeedbackItemCopyWith(_FeedbackItem value, $Res Function(_FeedbackItem) _then) = __$FeedbackItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String? kind, String body, String? status, String? imageUrl, List<FeedbackMessage> messages, String? createdAt, String? resolvedAt
});




}
/// @nodoc
class __$FeedbackItemCopyWithImpl<$Res>
    implements _$FeedbackItemCopyWith<$Res> {
  __$FeedbackItemCopyWithImpl(this._self, this._then);

  final _FeedbackItem _self;
  final $Res Function(_FeedbackItem) _then;

/// Create a copy of FeedbackItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? kind = freezed,Object? body = null,Object? status = freezed,Object? imageUrl = freezed,Object? messages = null,Object? createdAt = freezed,Object? resolvedAt = freezed,}) {
  return _then(_FeedbackItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,kind: freezed == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<FeedbackMessage>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,resolvedAt: freezed == resolvedAt ? _self.resolvedAt : resolvedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
