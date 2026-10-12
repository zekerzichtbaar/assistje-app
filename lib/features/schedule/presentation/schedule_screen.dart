import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/schedule_controller.dart';
import '../data/models/schedule_models.dart';
import 'widgets/schedule_event_form.dart';
import 'widgets/schedule_fields.dart';

/// Het event-formulier van de trainer op `/schedule` (nieuw) en
/// `/schedule?event=<id>` (bewerken). De router geeft alleen het pad; het
/// event-id komt uit de query van de huidige route.
class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key, this.eventId});

  /// Het te bewerken event. `null` = uit de query (`?event=`) lezen.
  final int? eventId;

  /// `?event=12` → 12; anders `null` (nieuw event).
  static int? eventIdFrom(Uri uri) {
    final raw = uri.queryParameters['event'];
    final id = raw == null ? null : int.tryParse(raw);
    return id != null && id > 0 ? id : null;
  }

  @override
  Widget build(BuildContext context) {
    var id = eventId;
    if (id == null && GoRouter.maybeOf(context) != null) {
      id = eventIdFrom(GoRouterState.of(context).uri);
    }
    return _ScheduleBody(key: ValueKey('schedule-$id'), eventId: id);
  }
}

class _ScheduleBody extends ConsumerWidget {
  const _ScheduleBody({super.key, required this.eventId});

  final int? eventId;

  void _saved(
    BuildContext context,
    ScheduleWriteResult result, {
    required bool isEdit,
  }) {
    final l10n = AppLocalizations.of(context);
    final String message;
    if (isEdit) {
      message = result.followingUpdated > 0
          ? l10n.scheduleSavedFollowing(result.followingUpdated)
          : l10n.scheduleSaved;
    } else {
      message = result.seriesCount > 1
          ? l10n.scheduleSeriesCreated(result.seriesCount)
          : l10n.scheduleCreated;
    }
    showScheduleSuccess(context, message);
    if (context.canPop()) {
      context.pop(result.event.id);
    } else {
      context.go(AppRoutes.event(result.event.id));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final ScheduleFormKey key = (teamId: membership.team.id, eventId: eventId);
    final async = ref.watch(scheduleFormControllerProvider(key));
    final data = async.value;
    final isEdit = eventId != null;

    final Widget body;
    if (data != null) {
      body = ScheduleEventForm(
        key: ValueKey('schedule-form-${data.event?.id}'),
        data: data,
        onSubmit: (draft) =>
            ref.read(scheduleFormControllerProvider(key).notifier).save(draft),
        onSaved: (result) => _saved(context, result, isEdit: data.isEdit),
      );
    } else if (async.hasError) {
      final error = async.error;
      body = EmptyState(
        key: const ValueKey('schedule-error'),
        icon: PhosphorIconsDuotone.warningCircle,
        title: l10n.scheduleLoadError,
        description: error is NotFoundException
            ? l10n.scheduleEventNotFound
            : scheduleErrorText(l10n, error),
        action: PrimaryButton(
          key: const ValueKey('schedule-retry'),
          label: l10n.retry,
          onPressed: () =>
              ref.read(scheduleFormControllerProvider(key).notifier).retry(),
        ),
      );
    } else {
      body = const SkeletonList(key: ValueKey('schedule-loading'), count: 4);
    }

    return Scaffold(
      key: const ValueKey('schedule-screen'),
      backgroundColor: t.sunken,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            16,
            ShellInsets.top(context),
            16,
            ShellInsets.bottom(context),
          ),
          children: [
            Semantics(
              header: true,
              child: Text(
                isEdit ? l10n.scheduleEditTitle : l10n.scheduleNewTitle,
                key: const Key('placeholder-title'),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: t.ink,
                ),
              ),
            ),
            const SizedBox(height: 16),
            body,
          ],
        ),
      ),
    );
  }
}
