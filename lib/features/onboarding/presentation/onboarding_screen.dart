import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/deep_links/deep_link_mapper.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/onboarding_controller.dart';
import '../data/models/onboarding_models.dart';
import 'widgets/onboarding_step_row.dart';
import 'widgets/onboarding_ui.dart';

/// "Aan de slag" (`Pages/Onboarding/Index` in de PWA): de checklist van een
/// nog niet ingericht team, voor de trainer. Drie stappen (alleen de eerste
/// open stap heeft een knop), de eerste wedstrijd met hoeveel spelers al
/// reageerden, en "Naar de app" om af te ronden.
///
/// Een startpunt, geen slagboom: het scherm staat in het menu zolang
/// `onboarding_open` in `/me` aan staat; de app stuurt er niet automatisch
/// heen.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  bool _completing = false;

  OnboardingController _controller(int teamId) =>
      ref.read(onboardingControllerProvider(teamId).notifier);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showOnboardingError(
        context,
        AppLocalizations.of(context).onboardingLoadError,
        error,
      );
    }
  }

  /// Een webpad uit de checklist (`/players`, `/agenda`, `/events/412`) op
  /// het eigen scherm openen.
  void _open(String href) {
    final target = DeepLinkMapper.map(Uri.parse(href));
    if (target is OpenRoute) {
      unawaited(Haptics.light());
      unawaited(context.push(target.location));
    }
  }

  Future<void> _complete(int teamId) async {
    if (_completing) return;
    setState(() => _completing = true);
    unawaited(Haptics.light());
    final error = await _controller(teamId).complete();
    if (!mounted) return;
    setState(() => _completing = false);
    if (error != null) {
      showOnboardingError(
        context,
        AppLocalizations.of(context).onboardingCompleteFailed,
        error,
      );
      return;
    }
    unawaited(Haptics.success());
    context.go(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(onboardingControllerProvider(teamId));
    final onboarding = async.value;

    final List<Widget> body;
    if (onboarding != null) {
      body = _checklist(
        teamId,
        onboarding,
        logoUrl: membership.team.logoUrl,
        logoFills: membership.team.logoFills,
      );
    } else if (async.hasError) {
      body = [
        EmptyState(
          key: const ValueKey('onboarding-error'),
          icon: PhosphorIconsDuotone.warningCircle,
          title: l10n.onboardingLoadError,
          description: onboardingErrorText(l10n, async.error),
          action: PrimaryButton(
            key: const ValueKey('onboarding-retry'),
            label: l10n.retry,
            onPressed: () => _refresh(teamId),
          ),
        ),
      ];
    } else {
      body = const [
        SkeletonList(key: ValueKey('onboarding-loading'), count: 3),
      ];
    }

    return Scaffold(
      key: const ValueKey('onboarding-screen'),
      backgroundColor: t.sunken,
      body: AppRefresh(
        onRefresh: () => _refresh(teamId),
        padding: EdgeInsets.fromLTRB(
          16,
          ShellInsets.top(context),
          16,
          ShellInsets.bottom(context),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
              child: Semantics(
                header: true,
                child: Text(
                  l10n.navOnboarding,
                  // Zelfde key als de placeholder: de shell-tests lezen de
                  // schermtitel via `placeholder-title`.
                  key: const Key('placeholder-title'),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: t.ink,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: body,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _checklist(
    int teamId,
    Onboarding onboarding, {
    String? logoUrl,
    bool logoFills = false,
  }) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final match = onboarding.nextMatch;
    final steps = onboarding.steps;

    return [
      // Grote titel op de achtergrond, zoals iOS een scherm opent.
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: t.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: t.surfaceHairline),
              ),
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.center,
              child: logoUrl == null
                  ? Icon(
                      PhosphorIconsDuotone.rocket,
                      size: 32,
                      color: t.primary,
                    )
                  : Padding(
                      padding: EdgeInsets.all(logoFills ? 0 : 8),
                      child: Image.network(
                        logoUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) => Icon(
                          PhosphorIconsDuotone.rocket,
                          size: 32,
                          color: t.primary,
                        ),
                      ),
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.onboardingWelcome,
                    style: TextStyle(fontSize: 15, color: t.muted),
                  ),
                  Text(
                    onboarding.team.name,
                    key: const ValueKey('onboarding-team-name'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 28,
                      height: 1.15,
                      fontWeight: FontWeight.w700,
                      color: t.ink,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          onboarding.allDone
              ? l10n.onboardingAllDone
              : l10n.onboardingStepsLeft(onboarding.left),
          key: const ValueKey('onboarding-summary'),
          style: TextStyle(fontSize: 15, height: 1.35, color: t.inkSoft),
        ),
      ),
      _Caption(
        l10n.onboardingStepsCaption(onboarding.completed, steps.length),
        key: const ValueKey('onboarding-steps-caption'),
      ),
      AppCard(
        key: const ValueKey('onboarding-steps'),
        radius: AssistjeTokens.radiusXl,
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final (index, step) in steps.indexed)
              OnboardingStepRow(
                step: step,
                state: onboarding.stateOf(index),
                first: index == 0,
                scheduleRequest: step.key == 'schedule'
                    ? onboarding.scheduleRequest
                    : ScheduleRequestState.none,
                waiting: step.key == 'attendance' && match == null,
                onOpen: () => _open(step.href),
              ),
          ],
        ),
      ),
      if (match != null) ...[
        _Caption(l10n.onboardingFirstMatch),
        OnboardingMatchRow(
          match: match,
          moment: formatOnboardingMoment(match.startsAt),
          onTap: () => _open(AppRoutes.event(match.id)),
        ),
      ],
      const SizedBox(height: 32),
      if (onboarding.allDone)
        PrimaryButton(
          key: const ValueKey('onboarding-finish'),
          label: l10n.onboardingFinish,
          expand: true,
          loading: _completing,
          onPressed: () => _complete(teamId),
        )
      else
        Center(
          child: TextButton(
            key: const ValueKey('onboarding-skip'),
            onPressed: _completing ? null : () => _complete(teamId),
            child: Text(
              l10n.onboardingSkip,
              style: TextStyle(
                fontSize: 15,
                color: t.muted,
                decoration: TextDecoration.underline,
                decorationColor: t.muted,
              ),
            ),
          ),
        ),
    ];
  }
}

/// Kop boven een groep (`SectionCaption` in de PWA).
class _Caption extends StatelessWidget {
  const _Caption(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 6),
      child: Semantics(
        header: true,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.4,
            color: t.muted,
          ),
        ),
      ),
    );
  }
}
