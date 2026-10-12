import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/notification_time.dart';
import '../../data/models/notification_models.dart';

/// Icoon per soort melding (`type`, snake_case van de notificatieklasse in
/// vogels3); onbekend = bel.
IconData notificationTypeIcon(String type) {
  if (type.startsWith('lineup')) return PhosphorIconsDuotone.clipboardText;
  if (type.startsWith('duty')) return PhosphorIconsDuotone.handshake;
  if (type.startsWith('carpool')) return PhosphorIconsDuotone.car;
  if (type.startsWith('birthday')) return PhosphorIconsDuotone.cake;
  if (type.startsWith('live')) return PhosphorIconsDuotone.broadcast;
  if (type.startsWith('motm')) return PhosphorIconsDuotone.trophy;
  if (type.startsWith('rsvp')) return PhosphorIconsDuotone.calendarCheck;
  if (type.startsWith('event') || type.startsWith('schedule')) {
    return PhosphorIconsDuotone.calendarBlank;
  }
  if (type.startsWith('poule')) return PhosphorIconsDuotone.listNumbers;
  if (type.startsWith('season') || type.startsWith('period')) {
    return PhosphorIconsDuotone.flagCheckered;
  }
  if (type.startsWith('title')) return PhosphorIconsDuotone.crown;
  if (type.startsWith('match_report')) return PhosphorIconsDuotone.notePencil;
  if (type.startsWith('player_status')) return PhosphorIconsDuotone.firstAid;
  if (type.startsWith('savings')) return PhosphorIconsDuotone.piggyBank;
  if (type.startsWith('feedback')) return PhosphorIconsDuotone.chatCircle;
  if (type.startsWith('admin')) return PhosphorIconsDuotone.megaphone;
  return PhosphorIconsDuotone.bell;
}

/// Eén melding in de inbox: icoon, titel, tekst en relatieve tijd. Ongelezen
/// = getinte kaart, vette titel en een stip in de teamkleur.
class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    required this.now,
    this.onTap,
  });

  final AppNotification notification;
  final DateTime now;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final l10n = AppLocalizations.of(context);
    final unread = !notification.read;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final tint = unread
        ? Color.alphaBlend(
            t.primary.withValues(alpha: dark ? 0.12 : 0.06),
            t.surface,
          )
        : null;
    final title = notification.title.isNotEmpty
        ? notification.title
        : notification.body;
    final body = notification.title.isNotEmpty ? notification.body : '';

    return Semantics(
      button: onTap != null,
      label: unread ? l10n.notificationsUnreadLabel : null,
      child: AppCard(
        color: tint,
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: t.primary.withValues(alpha: dark ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                notificationTypeIcon(notification.type),
                size: 22,
                color: t.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.3,
                      fontWeight: unread ? FontWeight.w700 : FontWeight.w500,
                      color: t.ink,
                    ),
                  ),
                  if (body.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        body,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.35,
                          color: t.inkSoft,
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      notificationTimeLabel(l10n, notification.createdAt, now),
                      style: TextStyle(fontSize: 12, color: t.muted),
                    ),
                  ),
                ],
              ),
            ),
            if (unread)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Container(
                  key: ValueKey('notification-unread-${notification.id}'),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: t.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Plaatshouders in de vorm van meldingen (eerste keer laden en bijladen).
class NotificationsSkeleton extends StatelessWidget {
  const NotificationsSkeleton({super.key, this.count = 5});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const ValueKey('notifications-skeleton'),
      children: [
        for (var i = 0; i < count; i++)
          const Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: AppCard(padding: EdgeInsets.zero, child: SkeletonRow()),
          ),
      ],
    );
  }
}
