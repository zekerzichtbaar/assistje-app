import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/session/models/team_membership.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/agenda_controller.dart';
import '../application/agenda_items.dart';
import '../data/agenda_repository.dart';
import '../data/models/agenda_models.dart';
import 'widgets/absence_reason_sheet.dart';
import 'widgets/agenda_add_event_button.dart';
import 'widgets/agenda_schedule_import.dart';
import 'widgets/agenda_skeleton.dart';
import 'widgets/birthday_card.dart';
import 'widgets/calendar_subscribe_sheet.dart';
import 'widgets/duty_card.dart';
import 'widgets/event_card.dart';

/// Tabbladen van de agenda.
enum AgendaTab { upcoming, past, tasks }

/// De Agenda-tab, 1-op-1 met `Pages/Player/Agenda.tsx`: Aankomend (met
/// jarigen en diensten), Verleden en Mijn taken; inline RSVP, trekken om te
/// verversen en "Nog 30 tonen".
class AgendaScreen extends ConsumerStatefulWidget {
  const AgendaScreen({super.key});

  @override
  ConsumerState<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends ConsumerState<AgendaScreen> {
  static const int _pageSize = AgendaRepository.pageSize;

  AgendaTab _tab = AgendaTab.upcoming;
  int _shown = _pageSize;
  int? _teamId;
  Timer? _liveTimer;
  bool _autoMoreArmed = true;

  @override
  void dispose() {
    _liveTimer?.cancel();
    super.dispose();
  }

  AgendaController _controller(int teamId) =>
      ref.read(agendaControllerProvider(teamId).notifier);

  void _selectTab(AgendaTab tab) {
    if (tab == _tab) return;
    Haptics.selection();
    setState(() {
      _tab = tab;
      _shown = _pageSize;
    });
  }

  String _errorText(Object? error) {
    final l10n = AppLocalizations.of(context);
    return switch (error) {
      NetworkException() => l10n.errorNetwork,
      final ApiException e when e.message != null => e.message!,
      _ => l10n.errorGeneric,
    };
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

  /// Zolang er een wedstrijd live is, elke 20 seconden stil verversen (zoals
  /// de PWA), zodat de tussenstand meeloopt.
  void _syncLiveTimer(int teamId, bool anyLive) {
    if (anyLive && _liveTimer == null) {
      _liveTimer = Timer.periodic(const Duration(seconds: 20), (_) {
        final state = ref.read(agendaControllerProvider(teamId)).value;
        if (state != null && !state.loadingMore) {
          unawaited(_controller(teamId).refresh());
        }
      });
    } else if (!anyLive && _liveTimer != null) {
      _liveTimer!.cancel();
      _liveTimer = null;
    }
  }

  Future<void> _showMore(int teamId, AgendaState state) async {
    if (state.loadingMore) return;
    final loaded = _tab == AgendaTab.upcoming
        ? state.data.upcoming.length
        : state.data.past.length;
    final total = _tab == AgendaTab.upcoming
        ? state.upcomingTotal
        : state.pastTotal;
    final next = _shown + _pageSize;
    setState(() => _shown = next);
    // Alleen naar de server als dit tabblad tegen zijn venster aan loopt.
    if (next > loaded && total > loaded) {
      final error = await _controller(teamId).loadMore();
      if (error != null && mounted) {
        showAppToast(
          context,
          title: _errorText(error),
          variant: AppToastVariant.error,
          closeLabel: AppLocalizations.of(context).close,
        );
      }
    }
  }

  Future<void> _rsvp(
    TeamMembership membership,
    AgendaEvent event,
    AttendanceStatus option, {
    String? reason,
  }) async {
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    if (reason == null) unawaited(Haptics.light());
    final outcome = await _controller(teamId).rsvp(
      event.id,
      option,
      reason: reason,
      askReasonFirst: membership.hasFeature('absence_reason'),
    );
    if (!mounted) return;
    switch (outcome) {
      case RsvpSaved():
        break;
      case RsvpNeedsReason(:final status, :final message):
        final given = await showAbsenceReasonSheet(
          context,
          status: status,
          error: message,
        );
        if (given == null || !mounted) return;
        await _rsvp(membership, event, option, reason: given);
      case RsvpFailed():
        unawaited(Haptics.error());
        showAppToast(
          context,
          title: l10n.agendaSaveFailed,
          message: outcome.message,
          variant: AppToastVariant.error,
          closeLabel: l10n.close,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    if (_teamId != teamId) {
      // Teamwissel: terug naar het begin.
      _teamId = teamId;
      _tab = AgendaTab.upcoming;
      _shown = _pageSize;
      _liveTimer?.cancel();
      _liveTimer = null;
    }

    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(agendaControllerProvider(teamId));
    final state = async.value;
    _syncLiveTimer(teamId, state?.data.upcoming.any((e) => e.isLive) ?? false);

    final List<Widget> content;
    if (state != null) {
      content = _content(membership, state);
    } else if (async.hasError) {
      content = [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('agenda-error'),
            icon: PhosphorIconsDuotone.warningCircle,
            title: l10n.agendaLoadError,
            description: _errorText(async.error),
            action: PrimaryButton(
              key: const ValueKey('agenda-retry'),
              label: l10n.retry,
              onPressed: () => _refresh(teamId),
            ),
          ),
        ),
      ];
    } else {
      content = const [SliverToBoxAdapter(child: AgendaSkeleton(count: 4))];
    }

    return Scaffold(
      key: const ValueKey('agenda-screen'),
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
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Semantics(
                        header: true,
                        child: Text(
                          l10n.navAgenda,
                          key: const ValueKey('agenda-title'),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: t.ink,
                          ),
                        ),
                      ),
                    ),
                    // Iedereen mag de agenda-feed abonneren (zoals de PWA),
                    // zolang het team er een heeft.
                    if (state?.data.agendaFeedUrl != null)
                      AgendaCalendarButton(data: state!.data),
                    // Alleen de trainer zet events in de agenda; een demoteam
                    // mag niet schrijven.
                    if (membership.isTrainer && !membership.team.isDemo) ...[
                      // Het programma importeren: in de PWA
                      // "Wedstrijdprogramma" in het plusmenu.
                      const SizedBox(width: 8),
                      AgendaScheduleButton(membership: membership),
                      const SizedBox(width: 8),
                      const AgendaAddEventButton(),
                    ],
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppTabPills<AgendaTab>(
                  key: const ValueKey('agenda-tabs'),
                  fullWidth: true,
                  darkTrack: true,
                  selected: _tab,
                  onChanged: _selectTab,
                  tabs: [
                    AppTabPill(
                      value: AgendaTab.upcoming,
                      label: l10n.agendaTabUpcoming,
                    ),
                    AppTabPill(
                      value: AgendaTab.past,
                      label: l10n.agendaTabPast,
                    ),
                    AppTabPill(
                      value: AgendaTab.tasks,
                      label: l10n.agendaTabTasks,
                    ),
                  ],
                ),
              ),
            ),
            ...content,
          ],
        ),
      ),
    );
  }

  /// Zelf bijladen zodra de onderkant in zicht komt — het gevoel van een
  /// native lijst. De knop blijft staan voor offline en voorleessoftware.
  void _onScroll(ScrollNotification n, int teamId, AgendaState? state) {
    if (state == null || _tab == AgendaTab.tasks) return;
    final after = n.metrics.extentAfter;
    if (after > 600) {
      _autoMoreArmed = true;
      return;
    }
    if (n is ScrollUpdateNotification &&
        after < 300 &&
        _autoMoreArmed &&
        _remaining(state) > 0 &&
        !state.loadingMore) {
      _autoMoreArmed = false;
      unawaited(_showMore(teamId, state));
    }
  }

  List<AgendaItem> _items(AgendaState state) => switch (_tab) {
    AgendaTab.upcoming => buildAgendaItems(
      events: state.data.upcoming,
      duties: state.data.upcomingDuties,
      birthdays: state.data.birthdays,
    ),
    AgendaTab.past => buildAgendaItems(
      events: state.data.past,
      duties: state.data.pastDuties,
      descending: true,
    ),
    AgendaTab.tasks => const [],
  };

  /// Wat er nog onder de streep ligt: hier, plus wat de server buiten het
  /// venster hield.
  int _remaining(AgendaState state) {
    final all = _items(state).length;
    final visible = all < _shown ? all : _shown;
    final loaded = _tab == AgendaTab.upcoming
        ? state.data.upcoming.length
        : state.data.past.length;
    final total = _tab == AgendaTab.upcoming
        ? state.upcomingTotal
        : state.pastTotal;
    return all - visible + (total - loaded);
  }

  List<Widget> _content(TeamMembership membership, AgendaState state) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final teamId = membership.team.id;
    final data = state.data;
    final meInjured =
        membership.hasFeature('injuries') && (data.me?.isInjured ?? false);

    Widget spaced(Widget child) =>
        Padding(padding: const EdgeInsets.only(bottom: 6), child: child);

    Widget quiet(String text, Key key) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Text(
        text,
        key: key,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: t.muted),
      ),
    );

    if (_tab == AgendaTab.tasks) {
      if (data.myTasks.isEmpty) {
        return [
          SliverToBoxAdapter(
            child: quiet(l10n.agendaNoTasks, const ValueKey('agenda-no-tasks')),
          ),
        ];
      }
      return [
        SliverList.builder(
          itemCount: data.myTasks.length,
          itemBuilder: (context, index) {
            final duty = data.myTasks[index];
            final eventId = duty.eventId;
            return spaced(
              DutyCard(
                key: ValueKey('task-${duty.key}'),
                duty: duty,
                onTap: eventId == null
                    ? null
                    : () => context.push(AppRoutes.event(eventId)),
              ),
            );
          },
        ),
      ];
    }

    final all = _items(state);
    final items = all.length > _shown ? all.sublist(0, _shown) : all;
    final remaining = _remaining(state);

    final slivers = <Widget>[];
    final importer = canImportSchedule(membership);
    // De wegwijzer: trainer zonder één wedstrijd terwijl de trainingen er al
    // staan. Verdwijnt vanzelf zodra er een wedstrijd is.
    if (_tab == AgendaTab.upcoming &&
        importer &&
        data.needsSchedule &&
        items.isNotEmpty) {
      slivers.add(
        SliverToBoxAdapter(
          child: AgendaScheduleSignpost(membership: membership, data: data),
        ),
      );
    }
    if (items.isEmpty) {
      slivers.add(
        SliverToBoxAdapter(
          child: _tab == AgendaTab.upcoming && importer
              ? AgendaTrainerEmptyState(membership: membership, data: data)
              : _tab == AgendaTab.upcoming
              ? EmptyState(
                  key: const ValueKey('agenda-empty'),
                  icon: PhosphorIconsDuotone.calendarBlank,
                  title: l10n.agendaEmptyTitle,
                  description: membership.isTrainer
                      ? l10n.agendaEmptyTrainer
                      : l10n.agendaEmptyPlayer,
                )
              : quiet(l10n.agendaNoEvents, const ValueKey('agenda-no-events')),
        ),
      );
    }

    slivers.add(
      SliverList.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return spaced(switch (item) {
            AgendaEventItem(:final event, :final dutyChips) => EventCard(
              key: ValueKey(item.key),
              event: event,
              dutyChips: dutyChips,
              showRsvp: _tab == AgendaTab.upcoming,
              canRsvpFallback: data.canRsvp,
              meInjured: meInjured,
              onTap: () => context.push(AppRoutes.event(event.id)),
              onRsvp: (option) => _rsvp(membership, event, option),
            ),
            AgendaDutyItem(:final duty) => DutyCard(
              key: ValueKey(item.key),
              duty: duty,
            ),
            AgendaBirthdayItem(:final birthday) => BirthdayCard(
              key: ValueKey(item.key),
              birthday: birthday,
            ),
          });
        },
      ),
    );

    if (remaining > 0) {
      slivers.add(
        SliverToBoxAdapter(
          child: state.loadingMore
              ? AgendaSkeleton(withRsvp: _tab == AgendaTab.upcoming)
              : AppCard(
                  key: const ValueKey('agenda-more'),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  onTap: () => _showMore(teamId, state),
                  child: Column(
                    children: [
                      Text(
                        l10n.agendaShowMore(
                          remaining < _pageSize ? remaining : _pageSize,
                        ),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: t.inkSoft,
                        ),
                      ),
                      if (remaining > _pageSize)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            l10n.agendaRemaining(remaining),
                            style: TextStyle(fontSize: 12, color: t.muted),
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
