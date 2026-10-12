import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_exception.dart';
import 'models/notification_models.dart';

/// Eén pagina van de inbox: meldingen + `meta`.
class NotificationsPage {
  const NotificationsPage({required this.items, required this.meta});

  final List<AppNotification> items;
  final NotificationsMeta meta;
}

/// Een als gelezen gemarkeerde melding plus de nieuwe ongelezen-telling.
class MarkReadResult {
  const MarkReadResult({required this.notification, this.unreadCount});

  final AppNotification notification;
  final int? unreadCount;
}

/// De meldingen-inbox per team (vogels3 `docs/api/v1/notifications.md`).
class NotificationsRepository {
  const NotificationsRepository(this._api);

  final ApiClient _api;

  /// Standaard paginagrootte (`per_page`, server staat 1–50 toe).
  static const int perPage = 20;

  /// `GET teams/{team}/notifications?page=&per_page=` — nieuwste eerst.
  Future<NotificationsPage> fetch(
    int teamId, {
    int page = 1,
    int perPage = NotificationsRepository.perPage,
  }) async {
    final body = await _api.get(
      '/teams/$teamId/notifications',
      query: {'page': page, 'per_page': perPage},
    );
    final data = body['data'];
    if (data is! List) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    final meta = body['meta'];
    return NotificationsPage(
      items: [
        for (final item in data)
          if (item is Map<String, dynamic>) AppNotification.fromJson(item),
      ],
      meta: meta is Map<String, dynamic>
          ? NotificationsMeta.fromJson(meta)
          : NotificationsMeta(currentPage: page, perPage: perPage),
    );
  }

  /// `POST teams/{team}/notifications/{id}/read`.
  Future<MarkReadResult> markRead(int teamId, String id) async {
    final body = await _api.post('/teams/$teamId/notifications/$id/read');
    final data = body['data'];
    if (data is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return MarkReadResult(
      notification: AppNotification.fromJson(data),
      unreadCount: _unreadCount(body),
    );
  }

  /// `POST teams/{team}/notifications/read-all`. Geeft de nieuwe
  /// ongelezen-telling terug (`0` als de server niets meldt).
  Future<int> markAllRead(int teamId) async {
    final body = await _api.post('/teams/$teamId/notifications/read-all');
    return _unreadCount(body) ?? 0;
  }

  /// `DELETE teams/{team}/notifications/{id}` (204).
  Future<void> delete(int teamId, String id) async {
    await _api.delete('/teams/$teamId/notifications/$id');
  }

  static int? _unreadCount(Map<String, dynamic> body) {
    final meta = body['meta'];
    if (meta is! Map<String, dynamic>) return null;
    final count = meta['unread_count'];
    return count is int ? count : null;
  }
}

final notificationsRepositoryProvider = Provider<NotificationsRepository>(
  (ref) => NotificationsRepository(ref.watch(apiClientProvider)),
);
