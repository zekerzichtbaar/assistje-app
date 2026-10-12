import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/session/models/team_membership.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../agenda/application/agenda_controller.dart';
import '../../agenda/data/models/agenda_models.dart';
import '../../agenda/presentation/widgets/absence_reason_sheet.dart';
import '../application/event_detail_controller.dart';
import '../data/models/event_detail_models.dart';
import 'widgets/event_actions.dart';
import 'widgets/event_carpool_section.dart';
import 'widgets/event_detail_skeleton.dart';
import 'widgets/event_duties_section.dart';
import 'widgets/event_info_card.dart';
import 'widgets/event_motm_section.dart';
import 'widgets/event_players_section.dart';
import 'widgets/event_responses_card.dart';
import 'widgets/event_rsvp_section.dart';
import 'widgets/event_trainer_actions.dart';

/// De eventpagina (`Pages/Player/EventDetail.tsx`): info, je eigen RSVP,
/// knoppen naar opstelling/aanwezigheid/live, de opkomst, speler van de
/// wedstrijd, carpool en de lijst per antwoord. Trekken = verversen.
class EventDetailScreen extends ConsumerStatefulWidget {
  const EventDetailScreen({super.key, required this.eventId});

  /// Id van het evenement uit het pad (al geparsed door de router).
  final int eventId;

  @override
  ConsumerState<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends ConsumerState<EventDetailScreen> {
  EventKey _key(int teamId) => (teamId: teamId, eventId: widget.eventId);

  EventDetailController _controller(int teamId) =>
      ref.read(eventDetailControllerProvider(_key(teamId)).notifier);

  String _errorText(Object? error) {
    final l10n = AppLocalizations.of(context);
    return switch (error) {
      NetworkException() => l10n.errorNetwork,
      NotFoundException() => l10n.eventDetailNotFound,
      final ApiException e when e.message != null => e.message!,
      _ => l10n.errorGeneric,
    };
  }

  void _toastError(String title, Object? error) {
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

  Future<void> _rsvp(
    TeamMembership membership,
    AttendanceStatus option, {
    String? reason,
  }) async {
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    if (reason == null) unawaited(Haptics.light());
    final outcome = await _controller(teamId).rsvp(
      option,
      reason: reason,
      askReasonFirst: membership.hasFeature('absence_reason'),
    );
    if (!mounted) return;
    switch (outcome) {
      case RsvpSaved():
        unawaited(Haptics.success());
      case RsvpNeedsReason(:final status, :final message):
        final given = await showAbsenceReasonSheet(
          context,
          status: status,
          error: message,
        );
        if (given == null || !mounted) return;
        await _rsvp(membership, option, reason: given);
      case RsvpFailed(:final error):
        _toastError(l10n.agendaSaveFailed, error);
    }
  }

  Future<void> _vote(int teamId, int? playerId) async {
    final l10n = AppLocalizations.of(context);
    unawaited(playerId == null ? Haptics.light() : Haptics.success());
    final controller = _controller(teamId);
    final error = playerId == null
        ? await controller.unvoteMotm()
        : await controller.voteMotm(playerId);
    if (error != null) _toastError(l10n.eventDetailMotmFailed, error);
  }

  Future<void> _saveCarpool(int teamId, CarpoolChoice choice) async {
    final l10n = AppLocalizations.of(context);
    final error = await _controller(
      teamId,
    ).saveCarpool(choice.mode, seats: choice.seats);
    if (error != null) {
      _toastError(l10n.eventDetailCarpoolFailed, error);
    } else {
      unawaited(Haptics.success());
    }
  }

  Future<void> _removeCarpool(int teamId) async {
    final l10n = AppLocalizations.of(context);
    final error = await _controller(teamId).removeCarpool();
    if (error != null) _toastError(l10n.eventDetailCarpoolRemoveFailed, error);
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(eventDetailControllerProvider(_key(teamId)));
    final event = async.value;

    final List<Widget> content;
    if (event != null) {
      content = _content(membership, event);
    } else if (async.hasError) {
      content = [
        _title(l10n.screenEvent, const Key('placeholder-title')),
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('event-error'),
            icon: PhosphorIconsDuotone.warningCircle,
            title: l10n.eventDetailLoadError,
            description: _errorText(async.error),
            action: PrimaryButton(
              key: const ValueKey('event-retry'),
              label: l10n.retry,
              onPressed: () => _refresh(teamId),
            ),
          ),
        ),
      ];
    } else {
      content = [
        _title(l10n.screenEvent, const Key('placeholder-title')),
        const SliverToBoxAdapter(child: EventDetailSkeleton()),
      ];
    }

    return Scaffold(
      key: const ValueKey('event-detail-screen'),
      backgroundColor: t.sunken,
      body: AppRefresh(
        onRefresh: () => _refresh(teamId),
        padding: EdgeInsets.fromLTRB(
          12,
          ShellInsets.top(context),
          12,
          ShellInsets.bottom(context),
        ),
        slivers: content,
      ),
    );
  }

  Widget _title(String text, Key key) {
    final t = AssistjeTokens.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
        child: Semantics(
          header: true,
          child: Text(
            text,
            key: key,
            style: TextStyle(
              fontSize: 26,
              height: 1.15,
              fontWeight: FontWeight.w700,
              color: t.ink,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _content(TeamMembership membership, EventDetail event) {
    final l10n = AppLocalizations.of(context);
    final teamId = membership.team.id;
    final now = DateTime.now();
    final dark = Theme.of(context).brightness == Brightness.dark;
    final actions = eventActionsFor(l10n, event, membership, now: now);
    final motm = event.motm;
    final offers = event.carpoolOffers;
    final isTrainer = membership.isTrainer || event.isTrainer;
    // Bewerken, afgelasten en verwijderen: alleen de trainer, niet in een
    // demoteam (dat mag niet schrijven).
    final manages = membership.isTrainer && !membership.team.isDemo;

    final guestsPresent = event.players
        .where((p) => p.isGuest && p.status == AttendanceStatus.present)
        .length;

    final children = <Widget>[
      if (manages) EventTrainerActions(eventKey: _key(teamId), event: event),
      if (event.isMatch &&
          membership.hasFeature('motm') &&
          motm != null &&
          event.hasRun(now))
        EventMotmSection(
          motm: motm,
          onVote: (id) => _vote(teamId, id),
          onUnvote: () => _vote(teamId, null),
        ),
      EventInfoCard(
        event: event,
        children: [
          if (event.canRsvp && !event.isCancelled)
            EventRsvpSection(
              event: event,
              onRsvp: (option) => _rsvp(membership, option),
            ),
          if (actions.isNotEmpty) EventActionsRow(actions: actions),
        ],
      ),
      if (event.isCancelled)
        Container(
          key: const ValueKey('event-cancelled-notice'),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: dark
                ? StatusColors.red500.withValues(alpha: 0.1)
                : StatusColors.red50,
            borderRadius: BorderRadius.circular(AssistjeTokens.radius2xl),
          ),
          child: Text(
            l10n.eventDetailCancelledNotice,
            style: TextStyle(
              fontSize: 14,
              color: dark ? const Color(0xFFFCA5A5) : const Color(0xFF991B1B),
            ),
          ),
        ),
      EventResponsesCard(counts: event.counts, guestsPresent: guestsPresent),
      if (event.showsDuties)
        EventDutiesSection(
          eventKey: _key(teamId),
          duties: event.duties,
          flag: event.flag,
          canAssign: isTrainer,
          onAssign: (row, key) => _controller(teamId).assignDuty(row, key),
        ),
      if (membership.hasFeature('carpool') &&
          event.isMatch &&
          event.isHome == false &&
          offers != null)
        EventCarpoolSection(
          offers: offers,
          onSave: (choice) => _saveCarpool(teamId, choice),
          onRemove: () => _removeCarpool(teamId),
        ),
      ...buildEventPlayerGroups(context, event.players, isTrainer: isTrainer),
      if (event.players.isEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Text(
            l10n.eventDetailNoPlayers,
            key: const ValueKey('event-no-players'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: AssistjeTokens.of(context).muted,
            ),
          ),
        ),
    ];

    return [
      _title(
        eventDetailTitle(l10n, event),
        const ValueKey('event-detail-title'),
      ),
      SliverList.separated(
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      ),
    ];
  }
}
