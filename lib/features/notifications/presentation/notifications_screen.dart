import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/deep_links/deep_link_mapper.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/notifications_controller.dart';
import '../data/models/notification_models.dart';
import 'widgets/notification_tile.dart';

/// De meldingen-inbox van het actieve team (de bel in de PWA): nieuwste
/// eerst, zelf bijladen onderaan, tik = gelezen + openen, vegen = weghalen,
/// "Alles gelezen" bovenaan.
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  bool _autoMoreArmed = true;
  Object? _loadMoreError;

  NotificationsController _controller(int teamId) =>
      ref.read(notificationsControllerProvider(teamId).notifier);

  String _errorText(Object? error) {
    final l10n = AppLocalizations.of(context);
    return switch (error) {
      NetworkException() => l10n.errorNetwork,
      final ApiException e when e.message != null => e.message!,
      _ => l10n.errorGeneric,
    };
  }

  void _toastError(String title, Object error) {
    if (!mounted) return;
    unawaited(Haptics.error());
    showAppToast(
      context,
      title: title,
      message: error is ApiException ? error.message : null,
      variant: AppToastVariant.error,
      closeLabel: AppLocalizations.of(context).close,
    );
  }

  Future<void> _refresh(int teamId) async {
    setState(() => _loadMoreError = null);
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showAppToast(
        context,
        title: _errorText(error),
        variant: AppToastVariant.error,
        closeLabel: AppLocalizations.of(context).close,
      );
    }
  }

  Future<void> _loadMore(int teamId) async {
    setState(() => _loadMoreError = null);
    final error = await _controller(teamId).loadMore();
    if (mounted && error != null) setState(() => _loadMoreError = error);
  }

  /// Tik: meteen als gelezen (optimistisch) en naar de bijbehorende
  /// app-route. Een link die de app niet kan tonen opent niets: je blijft
  /// in de inbox.
  void _open(int teamId, AppNotification notification) {
    unawaited(Haptics.light());
    if (!notification.read) {
      final l10n = AppLocalizations.of(context);
      unawaited(
        _controller(teamId).markRead(notification.id).then((error) {
          if (error != null) {
            _toastError(l10n.notificationsMarkReadFailed, error);
          }
        }),
      );
    }
    final url = notification.url;
    final uri = url == null ? null : Uri.tryParse(url);
    if (uri == null) return;
    final target = DeepLinkMapper.map(uri, teamId: teamId);
    if (target is! OpenRoute) return;
    final path = Uri.parse(target.location).path;
    // Tab-wortels via go (de tak van de tabshell); al het andere erbovenop,
    // zodat "terug" weer in de inbox uitkomt.
    if (AppRoutes.tabRoots.contains(path) || path == AppRoutes.home) {
      context.go(target.location);
    } else {
      unawaited(context.push(target.location));
    }
  }

  Future<void> _markAllRead(int teamId) async {
    final l10n = AppLocalizations.of(context);
    unawaited(Haptics.light());
    final error = await _controller(teamId).markAllRead();
    if (!mounted) return;
    if (error != null) {
      _toastError(l10n.notificationsMarkAllReadFailed, error);
    } else {
      unawaited(Haptics.success());
      showAppToast(
        context,
        title: l10n.notificationsAllReadDone,
        closeLabel: l10n.close,
      );
    }
  }

  Future<void> _delete(int teamId, AppNotification notification) async {
    final l10n = AppLocalizations.of(context);
    unawaited(Haptics.light());
    final error = await _controller(teamId).delete(notification.id);
    if (!mounted) return;
    if (error != null) {
      _toastError(l10n.notificationsDeleteFailed, error);
    } else {
      showAppToast(
        context,
        title: l10n.notificationsDeleted,
        closeLabel: l10n.close,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(notificationsControllerProvider(teamId));
    final state = async.value;

    final List<Widget> content;
    if (state != null) {
      content = _content(teamId, state);
    } else if (async.hasError) {
      content = [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('notifications-error'),
            icon: PhosphorIconsDuotone.warningCircle,
            title: l10n.notificationsLoadError,
            description: _errorText(async.error),
            action: PrimaryButton(
              key: const ValueKey('notifications-retry'),
              label: l10n.retry,
              onPressed: () => _refresh(teamId),
            ),
          ),
        ),
      ];
    } else {
      content = const [SliverToBoxAdapter(child: NotificationsSkeleton())];
    }

    return Scaffold(
      key: const ValueKey('notifications-screen'),
      backgroundColor: t.sunken,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          _onScroll(notification, teamId, state);
          return false;
        },
        child: AppRefresh(
          onRefresh: () => _refresh(teamId),
          padding: EdgeInsets.fromLTRB(
            12,
            ShellInsets.top(context),
            12,
            ShellInsets.bottom(context),
          ),
          slivers: [_header(teamId, state), ...content],
        ),
      ),
    );
  }

  Widget _header(int teamId, NotificationsState? state) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final unread = state?.unreadCount ?? 0;
    final anyUnread = unread > 0 || (state?.items.any((n) => !n.read) ?? false);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(
                    header: true,
                    child: Text(
                      l10n.screenNotifications,
                      key: const Key('placeholder-title'),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: t.ink,
                      ),
                    ),
                  ),
                  if (unread > 0)
                    Text(
                      l10n.notificationsUnreadCount(unread),
                      key: const ValueKey('notifications-unread-count'),
                      style: TextStyle(fontSize: 14, color: t.muted),
                    ),
                ],
              ),
            ),
            if (state != null && anyUnread)
              TextButton(
                key: const ValueKey('notifications-read-all'),
                onPressed: () => _markAllRead(teamId),
                style: TextButton.styleFrom(foregroundColor: t.primary),
                child: Text(
                  l10n.notificationsMarkAllRead,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Zelf bijladen zodra de onderkant in zicht komt.
  void _onScroll(ScrollNotification n, int teamId, NotificationsState? state) {
    if (state == null) return;
    final after = n.metrics.extentAfter;
    if (after > 600) {
      _autoMoreArmed = true;
      return;
    }
    if (n is ScrollUpdateNotification &&
        after < 300 &&
        _autoMoreArmed &&
        _loadMoreError == null &&
        state.hasMore &&
        !state.loadingMore) {
      _autoMoreArmed = false;
      unawaited(_loadMore(teamId));
    }
  }

  List<Widget> _content(int teamId, NotificationsState state) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    if (state.items.isEmpty && !state.hasMore) {
      return [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('notifications-empty'),
            icon: PhosphorIconsDuotone.bellSimple,
            title: l10n.notificationsEmptyTitle,
            description: l10n.notificationsEmptyDescription,
          ),
        ),
      ];
    }

    final now = DateTime.now();
    final slivers = <Widget>[
      SliverList.builder(
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          final notification = state.items[index];
          return Padding(
            key: ValueKey('notification-${notification.id}'),
            padding: const EdgeInsets.only(bottom: 6),
            child: Dismissible(
              key: ValueKey('dismiss-${notification.id}'),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => _delete(teamId, notification),
              background: _DeleteBackground(
                label: l10n.notificationsDeleteAction,
              ),
              child: NotificationTile(
                notification: notification,
                now: now,
                onTap: () => _open(teamId, notification),
              ),
            ),
          );
        },
      ),
    ];

    if (state.loadingMore) {
      slivers.add(
        const SliverToBoxAdapter(child: NotificationsSkeleton(count: 2)),
      );
    } else if (state.hasMore) {
      final error = _loadMoreError;
      slivers.add(
        SliverToBoxAdapter(
          child: AppCard(
            key: const ValueKey('notifications-more'),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            onTap: () => _loadMore(teamId),
            child: Column(
              children: [
                if (error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      l10n.notificationsLoadMoreError,
                      key: const ValueKey('notifications-more-error'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        color: StatusColors.red500,
                      ),
                    ),
                  ),
                Text(
                  error != null ? l10n.retry : l10n.notificationsLoadMore,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: t.inkSoft,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return slivers;
  }
}

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: StatusColors.red500,
        borderRadius: BorderRadius.circular(AssistjeTokens.radius2xl),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(PhosphorIconsBold.trash, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}
