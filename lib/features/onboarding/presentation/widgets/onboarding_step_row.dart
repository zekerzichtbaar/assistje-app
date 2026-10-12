import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/onboarding_models.dart';

/// Eén rij in de gegroepeerde lijst (`StepRow` in de PWA). Gedaan = één regel
/// met een vinkje en aantikbaar, nu = open met de ene knop, straks = titel en
/// een regel tekst, gedimd.
class OnboardingStepRow extends StatelessWidget {
  const OnboardingStepRow({
    super.key,
    required this.step,
    required this.state,
    required this.first,
    required this.scheduleRequest,
    required this.waiting,
    required this.onOpen,
  });

  final OnboardingStep step;
  final OnboardingStepState state;
  final bool first;

  /// Alleen voor de `schedule`-stap; anders [ScheduleRequestState.none].
  final ScheduleRequestState scheduleRequest;

  /// Opkomststap zonder komende wedstrijd: niets om naartoe te wijzen.
  final bool waiting;

  final VoidCallback onOpen;

  static IconData _icon(String key) => switch (key) {
    'team' => PhosphorIconsDuotone.usersThree,
    'attendance' => PhosphorIconsDuotone.flagCheckered,
    _ => PhosphorIconsDuotone.calendarPlus,
  };

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final l10n = AppLocalizations.of(context);
    final pending =
        step.key == 'schedule' &&
        scheduleRequest == ScheduleRequestState.pending;
    final title = step.title.endsWith('.')
        ? step.title.substring(0, step.title.length - 1)
        : step.title;
    final subtitle = pending
        ? l10n.onboardingSchedulePending
        : waiting && state == OnboardingStepState.current
        ? l10n.onboardingAttendanceWaiting
        : step.text;

    final tile = Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: state == OnboardingStepState.upcoming
            ? t.raised
            : t.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Icon(
        _icon(step.key),
        size: 20,
        color: state == OnboardingStepState.upcoming ? t.muted : t.primary,
      ),
    );

    final Widget content;
    if (state == OnboardingStepState.done) {
      content = InkWell(
        key: ValueKey('onboarding-step-${step.key}-open'),
        onTap: onOpen,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 52),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                tile,
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 17, color: t.ink),
                      ),
                      if (pending)
                        Text(
                          subtitle,
                          style: TextStyle(fontSize: 13, color: t.muted),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  PhosphorIconsFill.checkCircle,
                  key: ValueKey('onboarding-step-${step.key}-done'),
                  size: 22,
                  color: t.primary,
                ),
                const SizedBox(width: 6),
                Icon(
                  PhosphorIconsBold.caretRight,
                  size: 14,
                  color: t.muted.withValues(alpha: 0.6),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      final current = state == OnboardingStepState.current;
      content = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                tile,
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: current
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: current ? t.ink : t.muted,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        subtitle,
                        maxLines: current ? null : 1,
                        overflow: current ? null : TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.35,
                          color: current ? t.inkSoft : t.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (current && !waiting) ...[
              const SizedBox(height: 14),
              PrimaryButton(
                key: ValueKey('onboarding-step-${step.key}-cta'),
                label: step.cta,
                expand: true,
                onPressed: onOpen,
              ),
            ],
          ],
        ),
      );
    }

    return Semantics(
      container: true,
      child: Stack(
        key: ValueKey('onboarding-step-${step.key}'),
        children: [
          content,
          if (!first)
            Positioned(
              top: 0,
              left: 60,
              right: 0,
              child: Container(height: 1, color: t.lineSoft),
            ),
        ],
      ),
    );
  }
}

/// De noordster: de eerste wedstrijd met hoeveel er al gereageerd hebben
/// (`MatchRow` in de PWA).
class OnboardingMatchRow extends StatelessWidget {
  const OnboardingMatchRow({
    super.key,
    required this.match,
    required this.moment,
    required this.onTap,
  });

  final OnboardingNextMatch match;
  final String moment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final l10n = AppLocalizations.of(context);
    return AppCard(
      key: const ValueKey('onboarding-next-match'),
      radius: AssistjeTokens.radiusXl,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  match.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: t.ink,
                  ),
                ),
                if (moment.isNotEmpty)
                  Text(moment, style: TextStyle(fontSize: 15, color: t.muted)),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    key: const ValueKey('onboarding-next-match-progress'),
                    value: match.progress,
                    minHeight: 4,
                    backgroundColor: t.raised,
                    color: t.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.onboardingResponded(match.responded, match.roster),
                  key: const ValueKey('onboarding-next-match-responded'),
                  style: TextStyle(
                    fontSize: 13,
                    color: t.muted,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Icon(
            PhosphorIconsBold.caretRight,
            size: 14,
            color: t.muted.withValues(alpha: 0.6),
          ),
        ],
      ),
    );
  }
}
