import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_models.freezed.dart';
part 'notification_models.g.dart';

/// Eén melding uit de inbox (vogels3 `docs/api/v1/notifications.md`).
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    /// uuid van de melding.
    required String id,

    /// Soort in snake_case (`lineup_published`, …), voor het icoon.
    @Default('') String type,
    @Default('') String title,
    @Default('') String body,

    /// Webpad (`/events/12/lineup`); de deep-link-mapper maakt er een
    /// app-route van. `null` = de melding brengt nergens heen.
    String? url,

    /// Dezelfde bestemming absoluut op het teamsubdomein.
    String? link,
    @Default(false) bool read,
    DateTime? readAt,
    required DateTime createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}

/// `meta` van `GET teams/{team}/notifications`.
@freezed
abstract class NotificationsMeta with _$NotificationsMeta {
  const factory NotificationsMeta({
    @Default(1) int currentPage,
    @Default(1) int lastPage,
    @Default(20) int perPage,
    @Default(0) int total,
    @Default(0) int unreadCount,
  }) = _NotificationsMeta;

  factory NotificationsMeta.fromJson(Map<String, dynamic> json) =>
      _$NotificationsMetaFromJson(json);
}

/// Eén categorie in het pushvoorkeurenscherm (`types[]`).
@freezed
abstract class NotificationPreferenceType with _$NotificationPreferenceType {
  const factory NotificationPreferenceType({
    required String key,
    @Default('') String label,
    @Default('') String description,

    /// Alleen tonen als het huidige team een poule heeft (`has_poule`).
    @Default(false) bool pouleOnly,
    @Default(true) bool enabled,

    /// De standaardstand (`default` in de JSON).
    @JsonKey(name: 'default') @Default(true) bool enabledByDefault,
  }) = _NotificationPreferenceType;

  factory NotificationPreferenceType.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferenceTypeFromJson(json);
}

/// `GET`/`PATCH notification-preferences`: de snelle kaart plus de catalogus
/// in schermvolgorde.
@freezed
abstract class NotificationPreferences with _$NotificationPreferences {
  const factory NotificationPreferences({
    @Default(<String, bool>{}) Map<String, bool> preferences,
    @Default(<NotificationPreferenceType>[])
    List<NotificationPreferenceType> types,
  }) = _NotificationPreferences;

  const NotificationPreferences._();

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesFromJson(json);

  /// Staat categorie [key] aan? Onbekend = aan (zoals de server standaard).
  bool isEnabled(String key) {
    for (final type in types) {
      if (type.key == key) return type.enabled;
    }
    return preferences[key] ?? true;
  }

  /// Dezelfde stand met [key] op [enabled], in kaart én catalogus.
  NotificationPreferences withValue(String key, {required bool enabled}) =>
      copyWith(
        preferences: {...preferences, key: enabled},
        types: [
          for (final type in types)
            type.key == key ? type.copyWith(enabled: enabled) : type,
        ],
      );
}
