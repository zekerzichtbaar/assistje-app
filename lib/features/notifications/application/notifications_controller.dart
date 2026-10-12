import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/auth/auth_controller.dart';
import '../../../core/session/session_providers.dart';
import '../data/models/notification_models.dart';
import '../data/notifications_repository.dart';

/// Wat de inbox van één team op dit moment weet.
class NotificationsState {
  const NotificationsState({
    required this.items,
    this.page = 1,
    this.lastPage = 1,
    this.total = 0,
    this.unreadCount = 0,
    this.loadingMore = false,
  });

  final List<AppNotification> items;

  /// De laatst geladen pagina.
  final int page;
  final int lastPage;
  final int total;
  final int unreadCount;

  /// Loopt er een volgende pagina bij de server?
  final bool loadingMore;

  /// Zijn er nog oudere meldingen bij de server?
  bool get hasMore => page < lastPage;

  NotificationsState copyWith({
    List<AppNotification>? items,
    int? page,
    int? lastPage,
    int? total,
    int? unreadCount,
    bool? loadingMore,
  }) => NotificationsState(
    items: items ?? this.items,
    page: page ?? this.page,
    lastPage: lastPage ?? this.lastPage,
    total: total ?? this.total,
    unreadCount: unreadCount ?? this.unreadCount,
    loadingMore: loadingMore ?? this.loadingMore,
  );
}

/// De inbox van team [teamId]: laden, verversen, doorbladeren (`?page=`),
/// als gelezen markeren (één of alles) en weghalen — alles optimistisch, met
/// terugdraaien bij een fout. Methodes geven de fout terug (of `null`).
///
/// Na een geslaagde wijziging wordt [meProvider] ververst, zodat
/// `unread_notifications_count` (de bel) meeloopt.
class NotificationsController extends AsyncNotifier<NotificationsState> {
  NotificationsController(this.teamId);

  final int teamId;

  NotificationsRepository get _repository =>
      ref.read(notificationsRepositoryProvider);

  @override
  Future<NotificationsState> build() async {
    // Andere gebruiker = verse inbox.
    ref.watch(authControllerProvider);
    final page = await ref.watch(notificationsRepositoryProvider).fetch(teamId);
    return _fromPage(page);
  }

  static NotificationsState _fromPage(NotificationsPage page) =>
      NotificationsState(
        items: page.items,
        page: page.meta.currentPage,
        lastPage: page.meta.lastPage,
        total: page.meta.total,
        unreadCount: page.meta.unreadCount,
      );

  /// Opnieuw vanaf pagina 1. Met data in beeld blijft die staan bij een
  /// fout; de fout komt terug zodat het scherm hem kan melden.
  Future<Object?> refresh() async {
    final current = state.value;
    if (current == null) {
      ref.invalidateSelf();
      try {
        await future;
        return null;
      } on Object catch (error) {
        return error;
      }
    }
    try {
      final page = await _repository.fetch(teamId);
      state = AsyncData(_fromPage(page));
      return null;
    } on Object catch (error) {
      return error;
    }
  }

  /// Haalt de volgende pagina op en plakt hem eronder (dubbele id's — door
  /// nieuwe of weggehaalde meldingen schuift de paginering — vallen weg).
  Future<Object?> loadMore() async {
    final current = state.value;
    if (current == null || current.loadingMore || !current.hasMore) {
      return null;
    }
    state = AsyncData(current.copyWith(loadingMore: true));
    try {
      final page = await _repository.fetch(teamId, page: current.page + 1);
      final latest = state.value ?? current;
      final seen = {for (final n in latest.items) n.id};
      state = AsyncData(
        latest.copyWith(
          items: [
            ...latest.items,
            for (final n in page.items)
              if (!seen.contains(n.id)) n,
          ],
          page: page.meta.currentPage,
          lastPage: page.meta.lastPage,
          total: page.meta.total,
          unreadCount: page.meta.unreadCount,
          loadingMore: false,
        ),
      );
      return null;
    } on Object catch (error) {
      final latest = state.value;
      if (latest != null) {
        state = AsyncData(latest.copyWith(loadingMore: false));
      }
      return error;
    }
  }

  /// Markeert melding [id] als gelezen. Al gelezen = niets te doen.
  Future<Object?> markRead(String id) async {
    final current = state.value;
    final before = current == null ? null : _find(current, id);
    if (current == null || before == null) return const NotFoundException();
    if (before.read) return null;

    _replace(
      before.copyWith(read: true, readAt: DateTime.now()),
      unreadDelta: -1,
    );
    try {
      final result = await _repository.markRead(teamId, id);
      final latest = state.value;
      if (latest != null) {
        state = AsyncData(
          latest.copyWith(
            items: [
              for (final n in latest.items)
                n.id == id ? result.notification : n,
            ],
            unreadCount: result.unreadCount ?? latest.unreadCount,
          ),
        );
      }
      _refreshBell();
      return null;
    } on Object catch (error) {
      final latest = state.value;
      // Alleen terugzetten als de melding er nog (als gelezen) staat.
      if (latest != null && (_find(latest, id)?.read ?? false)) {
        _replace(before, unreadDelta: 1);
      }
      return error;
    }
  }

  /// Markeert alle meldingen van dit team als gelezen.
  Future<Object?> markAllRead() async {
    final current = state.value;
    if (current == null) return null;
    final now = DateTime.now();
    state = AsyncData(
      current.copyWith(
        items: [
          for (final n in current.items)
            n.read ? n : n.copyWith(read: true, readAt: now),
        ],
        unreadCount: 0,
      ),
    );
    try {
      final unread = await _repository.markAllRead(teamId);
      final latest = state.value;
      if (latest != null) {
        state = AsyncData(latest.copyWith(unreadCount: unread));
      }
      _refreshBell();
      return null;
    } on Object catch (error) {
      final latest = state.value ?? current;
      final previous = {for (final n in current.items) n.id: n};
      state = AsyncData(
        latest.copyWith(
          items: [for (final n in latest.items) previous[n.id] ?? n],
          unreadCount: current.unreadCount,
        ),
      );
      return error;
    }
  }

  /// Haalt melding [id] weg. Hij verdwijnt meteen uit de lijst (zodat een
  /// veeg klopt) en komt op zijn plek terug als de server weigert.
  Future<Object?> delete(String id) async {
    final current = state.value;
    if (current == null) return const NotFoundException();
    final index = current.items.indexWhere((n) => n.id == id);
    if (index < 0) return const NotFoundException();
    final removed = current.items[index];

    state = AsyncData(
      current.copyWith(
        items: [...current.items]..removeAt(index),
        total: current.total > 0 ? current.total - 1 : 0,
        unreadCount: _clampUnread(current.unreadCount, removed.read ? 0 : -1),
      ),
    );
    try {
      await _repository.delete(teamId, id);
      _refreshBell();
      return null;
    } on Object catch (error) {
      final latest = state.value;
      if (latest != null && !latest.items.any((n) => n.id == id)) {
        final items = [...latest.items];
        items.insert(index.clamp(0, items.length), removed);
        state = AsyncData(
          latest.copyWith(
            items: items,
            total: latest.total + 1,
            unreadCount: latest.unreadCount + (removed.read ? 0 : 1),
          ),
        );
      }
      return error;
    }
  }

  void _refreshBell() => ref.invalidate(meProvider);

  static AppNotification? _find(NotificationsState state, String id) {
    for (final n in state.items) {
      if (n.id == id) return n;
    }
    return null;
  }

  static int _clampUnread(int count, int delta) {
    final next = count + delta;
    return next < 0 ? 0 : next;
  }

  void _replace(AppNotification notification, {int unreadDelta = 0}) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      current.copyWith(
        items: [
          for (final n in current.items)
            n.id == notification.id ? notification : n,
        ],
        unreadCount: _clampUnread(current.unreadCount, unreadDelta),
      ),
    );
  }
}

/// De inbox per team-id. Geen automatische retry: het scherm toont een fout
/// met "Opnieuw proberen".
final notificationsControllerProvider =
    AsyncNotifierProvider.family<
      NotificationsController,
      NotificationsState,
      int
    >(NotificationsController.new, retry: (retryCount, error) => null);
