import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/session/models/team_membership.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_bar.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../agenda/application/agenda_controller.dart';
import '../../agenda/data/models/agenda_models.dart';
import '../../agenda/presentation/widgets/absence_reason_sheet.dart';
import '../../savings/data/models/savings_models.dart';
import '../../savings/data/savings_repository.dart';
import '../../savings/presentation/savings_form_screen.dart';
import '../../savings/presentation/savings_pot_screen.dart';
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
import 'widgets/event_savings_section.dart';
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

  /// De spaarpot van deze activiteit openen (zoals vanuit de Spaarpot).
  Future<void> _openPot(int teamId, int potId) async {
    unawaited(Haptics.light());
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (_) => SavingsPotScreen(teamId: teamId, potId: potId),
      ),
    );
    if (mounted) await _refresh(teamId);
  }

  /// "Inleg vragen": het spaarpotformulier met deze activiteit voorgezet;
  /// daarna de nieuwe pot openen.
  Future<void> _startSavings(int teamId) async {
    unawaited(Haptics.light());
    final repository = ref.read(savingsRepositoryProvider);
    SavingsPot? created;
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<bool>(
        builder: (_) => SavingsFormScreen(
          teamId: teamId,
          eventId: widget.eventId,
          onSubmit: (draft) async {
            try {
              created = await repository.createPot(teamId, draft);
              return null;
            } on Object catch (error) {
              return error;
            }
          },
        ),
      ),
    );
    final pot = created;
    if (pot == null || !mounted) return;
    showAppToast(
      context,
      title: AppLocalizations.of(context).eventSavingsCreated,
      closeLabel: AppLocalizations.of(context).close,
    );
    await _openPot(teamId, pot.id);
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
      content = [
        SliverReveal(
          sliver: SliverMainAxisGroup(slivers: _content(membership, event)),
        ),
      ];
    } else if (async.hasError) {
      content = [
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
      content = [const SliverToBoxAdapter(child: EventDetailSkeleton())];
    }

    final scaffold = Scaffold(
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

    // Titel in de topbar; de beheeracties onder de ⋯. Bewerken, afgelasten
    // en verwijderen: alleen de trainer, niet in een demoteam (dat mag niet
    // schrijven).
    final title = event == null
        ? l10n.screenEvent
        : eventDetailTitle(l10n, event);
    final titleKey = event == null
        ? const Key('placeholder-title')
        : const ValueKey('event-detail-title');
    if (event != null && membership.isTrainer && !membership.team.isDemo) {
      return EventTrainerActions(
        eventKey: _key(teamId),
        event: event,
        title: title,
        titleKey: titleKey,
        child: scaffold,
      );
    }
    return ShellBar(title: title, titleKey: titleKey, child: scaffold);
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

    final guestsPresent = event.players
        .where((p) => p.isGuest && p.status == AttendanceStatus.present)
        .length;
    // Bij een activiteit telt ook de staf mee: daar gaat het om wie er komt,
    // niet om wie er kan spelen.
    final staffPresent = event.type == EventType.activity
        ? event.players
              .where(
                (p) =>
                    p.kind == EventPlayerKind.staff &&
                    p.status == AttendanceStatus.present,
              )
              .length
        : 0;

    final children = <Widget>[
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
      EventResponsesCard(
        counts: event.counts,
        playerCounts: event.playerCounts,
        guestsPresent: guestsPresent,
        staffPresent: staffPresent,
      ),
      if (event.type == EventType.activity)
        EventSavingsSection(
          pot: event.savingsPot,
          canStart: event.canStartSavings,
          cancelled: event.isCancelled,
          onOpen: (potId) => _openPot(teamId, potId),
          onStart: () => _startSavings(teamId),
        ),
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
      SliverList.separated(
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      ),
    ];
  }
}
