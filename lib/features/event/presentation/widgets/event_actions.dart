import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/session/models/team_membership.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/event_detail_models.dart';

/// Eén knop naar een sub-scherm van het event.
class EventAction {
  const EventAction({
    required this.id,
    required this.label,
    required this.icon,
    required this.path,
    this.primary = false,
  });

  /// Sleutel in tests: `event-action-<id>`.
  final String id;
  final String label;
  final IconData icon;
  final String path;
  final bool primary;
}

/// Welke knoppen bij dit event horen voor [membership] (de rijen
/// `TrainerActionLink` in `EventDetail.tsx`).
List<EventAction> eventActionsFor(
  AppLocalizations l10n,
  EventDetail event,
  TeamMembership membership, {
  required DateTime now,
}) {
  final base = AppRoutes.event(event.id);
  final trainer = membership.isTrainer || event.isTrainer;
  final canLineup = trainer || membership.can('lineup');
  final postMatch = membership.sport['match_stats_mode'] == 'postmatch';
  final upcoming = event.startsAt.isAfter(now);

  final attendance = EventAction(
    id: 'attendance',
    label: l10n.eventDetailActionAttendance,
    icon: PhosphorIconsDuotone.usersThree,
    path: '$base/attendance',
  );

  final actions = <EventAction>[];
  if (event.isMatch) {
    if (event.isLive || event.hasEnded) {
      actions.add(
        EventAction(
          id: 'live',
          label: l10n.eventDetailActionLive,
          icon: PhosphorIconsDuotone.broadcast,
          path: '$base/live',
          primary: event.isLive,
        ),
      );
    }
    if (trainer || event.lineupShared || canLineup) {
      actions.add(
        EventAction(
          id: 'lineup',
          label: canLineup
              ? l10n.eventDetailActionLineup
              : l10n.eventDetailActionViewLineup,
          icon: PhosphorIconsDuotone.courtBasketball,
          path: '$base/lineup',
          primary: upcoming && !event.isLive,
        ),
      );
    }
    if (canLineup && postMatch) {
      actions.add(
        EventAction(
          id: 'report',
          label: l10n.eventDetailActionReport,
          icon: PhosphorIconsDuotone.chartBar,
          path: '$base/report',
        ),
      );
    }
    if (trainer) actions.add(attendance);
  } else if (event.isTraining) {
    if (trainer) actions.add(attendance);
    if (event.canAssignTeams) {
      actions.add(
        EventAction(
          id: 'teams',
          label: l10n.eventDetailActionTeams,
          icon: PhosphorIconsDuotone.shuffle,
          path: '$base/teams',
        ),
      );
    }
  } else if (trainer && !event.isCancelled) {
    actions.add(attendance);
  }
  return actions;
}

/// Rij met knoppen naar opstelling, verslag, aanwezigheid, live en teams.
class EventActionsRow extends StatelessWidget {
  const EventActionsRow({super.key, required this.actions});

  final List<EventAction> actions;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      key: const ValueKey('event-actions'),
      spacing: 8,
      runSpacing: 8,
      children: [for (final a in actions) _ActionPill(action: a)],
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({required this.action});

  final EventAction action;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final bg = action.primary ? t.primary : t.raised;
    final fg = action.primary ? t.primaryContrast : t.ink;
    return Semantics(
      button: true,
      child: Material(
        color: bg,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: ValueKey('event-action-${action.id}'),
          onTap: () => context.push(action.path),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                PhosphorIcon(action.icon, size: 16, color: fg),
                const SizedBox(width: 6),
                Text(
                  action.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: fg,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
