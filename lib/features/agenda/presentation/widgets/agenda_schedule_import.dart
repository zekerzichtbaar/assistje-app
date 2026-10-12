import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/session/models/team_membership.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../schedule/application/schedule_import_controller.dart';
import '../../../schedule/data/models/schedule_import_models.dart';
import '../../../schedule/presentation/widgets/import_events_sheet.dart';
import '../../data/models/agenda_models.dart';

/// Of [membership] het programma mag importeren: de trainer, en niet in een
/// demoteam (de API weigert dat met `403`).
bool canImportSchedule(TeamMembership membership) =>
    membership.isTrainer && !membership.team.isDemo;

/// Opent "Wedstrijdprogramma" voor dit team; "Wedstrijd inplannen" gaat naar
/// het event-formulier.
Future<void> openScheduleImport(
  BuildContext context,
  TeamMembership membership,
) {
  final router = GoRouter.of(context);
  return showImportEventsSheet(
    context,
    teamId: membership.team.id,
    federation: FederationImport.fromSport(membership.sport),
    onPlan: () => unawaited(router.push(AppRoutes.schedule)),
  );
}

/// Het trofee-knopje naast "+ Nieuw" (trainer): de ingang naar de
/// import-sheet, zoals "Wedstrijdprogramma" in het plusmenu van de PWA.
class AgendaScheduleButton extends StatelessWidget {
  const AgendaScheduleButton({super.key, required this.membership});

  final TeamMembership membership;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return Semantics(
      button: true,
      label: l10n.agendaScheduleButtonLabel,
      child: Material(
        color: t.surface,
        shape: CircleBorder(side: BorderSide(color: t.line)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          key: const ValueKey('agenda-schedule-import'),
          onTap: () {
            unawaited(Haptics.light());
            unawaited(openScheduleImport(context, membership));
          },
          child: Padding(
            padding: const EdgeInsets.all(9),
            child: PhosphorIcon(
              PhosphorIconsDuotone.trophy,
              size: 20,
              color: t.ink,
            ),
          ),
        ),
      ),
    );
  }
}

/// "Doe dat voor mij" met één tik, plus de busy-vlag. Gedeeld door de
/// wegwijzerkaart en de lege agenda.
mixin _RequestSchedule<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  bool requesting = false;

  Future<void> requestSchedule(int teamId) async {
    final l10n = AppLocalizations.of(context);
    setState(() => requesting = true);
    final outcome = await ref
        .read(scheduleImportControllerProvider)
        .request(teamId);
    if (!mounted) return;
    setState(() => requesting = false);
    switch (outcome) {
      case ScheduleImportDone(:final message):
        unawaited(Haptics.success());
        showAppToast(context, title: message, closeLabel: l10n.close);
      case ScheduleImportFailed(:final message, :final error):
        unawaited(Haptics.error());
        showAppToast(
          context,
          title:
              message ??
              switch (error) {
                NetworkException() => l10n.errorNetwork,
                _ => l10n.errorGeneric,
              },
          variant: AppToastVariant.error,
          closeLabel: l10n.close,
        );
    }
  }
}

/// De wegwijzer bovenaan Aankomend (`Agenda.tsx`): trainer zonder één
/// wedstrijd (`needs_schedule`) terwijl de agenda al trainingen heeft.
/// Verdwijnt vanzelf zodra er een wedstrijd staat.
class AgendaScheduleSignpost extends ConsumerStatefulWidget {
  const AgendaScheduleSignpost({
    super.key,
    required this.membership,
    required this.data,
  });

  final TeamMembership membership;
  final AgendaData data;

  @override
  ConsumerState<AgendaScheduleSignpost> createState() =>
      _AgendaScheduleSignpostState();
}

class _AgendaScheduleSignpostState extends ConsumerState<AgendaScheduleSignpost>
    with _RequestSchedule {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final request = ScheduleRequestState.parse(widget.data.scheduleRequest);
    final feed = ScheduleFeedState.fromJson(widget.data.scheduleFeed);

    final String title;
    final String body;
    if (request != null) {
      title = l10n.scheduleRequestTitle;
      body = l10n.scheduleRequestBody;
    } else if (feed?.failed ?? false) {
      title = l10n.agendaSignpostFeedFailedTitle;
      body = l10n.agendaSignpostFeedFailedBody;
    } else {
      title = l10n.agendaSignpostTitle;
      body = feed != null
          ? l10n.agendaSignpostBodyFeed
          : l10n.agendaSignpostBody;
    }

    final String buttonLabel;
    if (request != null) {
      buttonLabel = requesting
          ? l10n.scheduleImportBusy
          : l10n.scheduleRequestButton;
    } else if (feed?.failed ?? false) {
      buttonLabel = l10n.agendaSignpostCheckLink;
    } else if (feed != null) {
      buttonLabel = l10n.agendaSignpostPasteLink;
    } else {
      buttonLabel = l10n.agendaScheduleAdd;
    }

    return Container(
      key: const ValueKey('agenda-schedule-signpost'),
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: t.surface,
        borderRadius: BorderRadius.circular(AssistjeTokens.radius2xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: t.raised,
                  borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
                ),
                alignment: Alignment.center,
                child: PhosphorIcon(
                  PhosphorIconsDuotone.trophy,
                  size: 24,
                  color: t.muted,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.agendaSignpostEyebrow.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: t.muted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: t.ink,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      body,
                      style: TextStyle(fontSize: 14, color: t.inkSoft),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (request == ScheduleRequestState.pending)
            Text(
              l10n.scheduleRequestPending,
              key: const ValueKey('agenda-schedule-pending'),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: t.inkSoft,
              ),
            )
          else
            PrimaryButton(
              key: const ValueKey('agenda-schedule-signpost-button'),
              label: buttonLabel,
              expand: true,
              onPressed: requesting
                  ? null
                  : request != null
                  ? () => requestSchedule(widget.membership.team.id)
                  : () => openScheduleImport(context, widget.membership),
            ),
          if (request != null) _PlanSelfLink(),
        ],
      ),
    );
  }
}

/// De lege Aankomend-agenda voor de trainer: mogen wij het programma erin
/// zetten, dan is dát de kop en de knop ("Doe dat voor mij" met "Zelf
/// inplannen" eronder); anders "Programma erbij" naar de sheet.
class AgendaTrainerEmptyState extends ConsumerStatefulWidget {
  const AgendaTrainerEmptyState({
    super.key,
    required this.membership,
    required this.data,
  });

  final TeamMembership membership;
  final AgendaData data;

  @override
  ConsumerState<AgendaTrainerEmptyState> createState() =>
      _AgendaTrainerEmptyStateState();
}

class _AgendaTrainerEmptyStateState
    extends ConsumerState<AgendaTrainerEmptyState>
    with _RequestSchedule {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final request = ScheduleRequestState.parse(widget.data.scheduleRequest);

    final Widget action;
    if (request == null) {
      action = PrimaryButton(
        key: const ValueKey('agenda-empty-schedule'),
        label: l10n.agendaScheduleAdd,
        onPressed: () => openScheduleImport(context, widget.membership),
      );
    } else {
      action = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (request == ScheduleRequestState.pending)
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Text(
                l10n.scheduleRequestPending,
                key: const ValueKey('agenda-schedule-pending'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: t.inkSoft,
                ),
              ),
            )
          else
            PrimaryButton(
              key: const ValueKey('agenda-empty-request'),
              label: requesting
                  ? l10n.scheduleImportBusy
                  : l10n.scheduleRequestButton,
              onPressed: requesting
                  ? null
                  : () => requestSchedule(widget.membership.team.id),
            ),
          _PlanSelfLink(),
        ],
      );
    }

    return EmptyState(
      key: const ValueKey('agenda-empty'),
      icon: PhosphorIconsDuotone.calendarBlank,
      title: request != null
          ? l10n.scheduleRequestTitle
          : l10n.agendaEmptyTitle,
      description: request != null
          ? l10n.scheduleRequestBody
          : l10n.agendaEmptyTrainer,
      action: action,
    );
  }
}

/// "Zelf inplannen": rechtstreeks naar het wedstrijdformulier, niet naar de
/// sheet (daar staat het aanbod ook in, en dan draait de keuze in rondjes).
class _PlanSelfLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Center(
        child: TextButton(
          key: const ValueKey('agenda-plan-self'),
          onPressed: () => unawaited(context.push(AppRoutes.schedule)),
          style: TextButton.styleFrom(foregroundColor: t.inkSoft),
          child: Text(
            AppLocalizations.of(context).agendaPlanSelf,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    );
  }
}
