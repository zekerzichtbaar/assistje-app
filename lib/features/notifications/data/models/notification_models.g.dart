// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      id: json['id'] as String,
      type: json['type'] as String? ?? '',
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      url: json['url'] as String?,
      link: json['link'] as String?,
      read: json['read'] as bool? ?? false,
      readAt: json['read_at'] == null
          ? null
          : DateTime.parse(json['read_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$AppNotificationToJson(_AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'body': instance.body,
      'url': instance.url,
      'link': instance.link,
      'read': instance.read,
      'read_at': instance.readAt?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };

_NotificationsMeta _$NotificationsMetaFromJson(Map<String, dynamic> json) =>
    _NotificationsMeta(
      currentPage: (json['current_page'] as num?)?.toInt() ?? 1,
      lastPage: (json['last_page'] as num?)?.toInt() ?? 1,
      perPage: (json['per_page'] as num?)?.toInt() ?? 20,
      total: (json['total'] as num?)?.toInt() ?? 0,
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$NotificationsMetaToJson(_NotificationsMeta instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
      'total': instance.total,
      'unread_count': instance.unreadCount,
    };

_NotificationPreferenceType _$NotificationPreferenceTypeFromJson(
  Map<String, dynamic> json,
) => _NotificationPreferenceType(
  key: json['key'] as String,
  label: json['label'] as String? ?? '',
  description: json['description'] as String? ?? '',
  pouleOnly: json['poule_only'] as bool? ?? false,
  enabled: json['enabled'] as bool? ?? true,
  enabledByDefault: json['default'] as bool? ?? true,
);

Map<String, dynamic> _$NotificationPreferenceTypeToJson(
  _NotificationPreferenceType instance,
) => <String, dynamic>{
  'key': instance.key,
  'label': instance.label,
  'description': instance.description,
  'poule_only': instance.pouleOnly,
  'enabled': instance.enabled,
  'default': instance.enabledByDefault,
};

_NotificationPreferences _$NotificationPreferencesFromJson(
  Map<String, dynamic> json,
) => _NotificationPreferences(
  preferences:
      (json['preferences'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ) ??
      const <String, bool>{},
  types:
      (json['types'] as List<dynamic>?)
          ?.map(
            (e) =>
                NotificationPreferenceType.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <NotificationPreferenceType>[],
);

Map<String, dynamic> _$NotificationPreferencesToJson(
  _NotificationPreferences instance,
) => <String, dynamic>{
  'preferences': instance.preferences,
  'types': instance.types.map((e) => e.toJson()).toList(),
};
