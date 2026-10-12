// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TeamMessage _$TeamMessageFromJson(Map<String, dynamic> json) => _TeamMessage(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String? ?? '',
  body: json['body'] as String? ?? '',
  url: json['url'] as String?,
  sentAt: json['sent_at'] as String?,
  recipientsCount: (json['recipients_count'] as num?)?.toInt() ?? 0,
  senderName: json['sender_name'] as String?,
);

Map<String, dynamic> _$TeamMessageToJson(_TeamMessage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'url': instance.url,
      'sent_at': instance.sentAt,
      'recipients_count': instance.recipientsCount,
      'sender_name': instance.senderName,
    };

_AutoMessageSetting _$AutoMessageSettingFromJson(Map<String, dynamic> json) =>
    _AutoMessageSetting(
      key: json['key'] as String,
      label: json['label'] as String? ?? '',
      enabled: json['enabled'] as bool? ?? true,
      titleTemplate: json['title_template'] as String? ?? '',
      bodyTemplate: json['body_template'] as String? ?? '',
      placeholders:
          (json['placeholders'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      templated: json['templated'] as bool? ?? true,
    );

Map<String, dynamic> _$AutoMessageSettingToJson(_AutoMessageSetting instance) =>
    <String, dynamic>{
      'key': instance.key,
      'label': instance.label,
      'enabled': instance.enabled,
      'title_template': instance.titleTemplate,
      'body_template': instance.bodyTemplate,
      'placeholders': instance.placeholders,
      'templated': instance.templated,
    };

_AutoHistoryEntry _$AutoHistoryEntryFromJson(Map<String, dynamic> json) =>
    _AutoHistoryEntry(
      type: json['type'] as String? ?? '',
      label: json['label'] as String? ?? '',
      title: json['title'] as String?,
      body: json['body'] as String?,
      sentAt: json['sent_at'] as String?,
      recipientsCount: (json['recipients_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AutoHistoryEntryToJson(_AutoHistoryEntry instance) =>
    <String, dynamic>{
      'type': instance.type,
      'label': instance.label,
      'title': instance.title,
      'body': instance.body,
      'sent_at': instance.sentAt,
      'recipients_count': instance.recipientsCount,
    };

_LinkTarget _$LinkTargetFromJson(Map<String, dynamic> json) => _LinkTarget(
  value: json['value'] as String,
  label: json['label'] as String? ?? '',
);

Map<String, dynamic> _$LinkTargetToJson(_LinkTarget instance) =>
    <String, dynamic>{'value': instance.value, 'label': instance.label};

_LinkTargetGroup _$LinkTargetGroupFromJson(Map<String, dynamic> json) =>
    _LinkTargetGroup(
      label: json['label'] as String? ?? '',
      options:
          (json['options'] as List<dynamic>?)
              ?.map((e) => LinkTarget.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <LinkTarget>[],
    );

Map<String, dynamic> _$LinkTargetGroupToJson(_LinkTargetGroup instance) =>
    <String, dynamic>{
      'label': instance.label,
      'options': instance.options.map((e) => e.toJson()).toList(),
    };

_MessagesOverview _$MessagesOverviewFromJson(Map<String, dynamic> json) =>
    _MessagesOverview(
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map((e) => TeamMessage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TeamMessage>[],
      autoSettings:
          (json['auto_settings'] as List<dynamic>?)
              ?.map(
                (e) => AutoMessageSetting.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <AutoMessageSetting>[],
      autoHistory:
          (json['auto_history'] as List<dynamic>?)
              ?.map((e) => AutoHistoryEntry.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AutoHistoryEntry>[],
      linkTargets:
          (json['link_targets'] as List<dynamic>?)
              ?.map((e) => LinkTargetGroup.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <LinkTargetGroup>[],
    );

Map<String, dynamic> _$MessagesOverviewToJson(_MessagesOverview instance) =>
    <String, dynamic>{
      'messages': instance.messages.map((e) => e.toJson()).toList(),
      'auto_settings': instance.autoSettings.map((e) => e.toJson()).toList(),
      'auto_history': instance.autoHistory.map((e) => e.toJson()).toList(),
      'link_targets': instance.linkTargets.map((e) => e.toJson()).toList(),
    };
