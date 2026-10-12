// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeedbackMessage _$FeedbackMessageFromJson(Map<String, dynamic> json) =>
    _FeedbackMessage(
      id: (json['id'] as num).toInt(),
      direction: json['direction'] as String? ?? 'uit',
      body: json['body'] as String? ?? '',
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$FeedbackMessageToJson(_FeedbackMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'direction': instance.direction,
      'body': instance.body,
      'created_at': instance.createdAt,
    };

_FeedbackItem _$FeedbackItemFromJson(Map<String, dynamic> json) =>
    _FeedbackItem(
      id: (json['id'] as num).toInt(),
      kind: json['kind'] as String?,
      body: json['body'] as String? ?? '',
      status: json['status'] as String?,
      imageUrl: json['image_url'] as String?,
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map((e) => FeedbackMessage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FeedbackMessage>[],
      createdAt: json['created_at'] as String?,
      resolvedAt: json['resolved_at'] as String?,
    );

Map<String, dynamic> _$FeedbackItemToJson(_FeedbackItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'body': instance.body,
      'status': instance.status,
      'image_url': instance.imageUrl,
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt,
      'resolved_at': instance.resolvedAt,
    };
