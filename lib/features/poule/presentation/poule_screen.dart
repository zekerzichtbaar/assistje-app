import 'dart:async';

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
import '../application/poule_controller.dart';
import '../data/models/poule_models.dart';
import 'widgets/poule_widgets.dart';

/// Welk deel van de poule in beeld is.
enum PouleTab { standing, results, fixtures }

/// De Poule (`Pages/Poule` in de PWA): stand, uitslagen en programma uit de
/// laatste Sportlink-sync. Zonder poulecode (`has_poule: false` of een 404)
/// een lege staat.
class PouleScreen extends ConsumerStatefulWidget {
  const PouleScreen({super.key});

  @override
  ConsumerState<PouleScreen> createState() => _PouleScreenState();
}

class _PouleScreenState extends ConsumerState<PouleScreen> {
  PouleTab _tab = PouleTab.standing;

  Future<void> _refresh(int teamId) async {
    final error = await ref
        .read(pouleControllerProvider(teamId).notifier)
        .refresh();
    if (error != null && mounted && error is! NotFoundException) {
      final l10n = AppLocalizations.of(context);
      unawaited(Haptics.error());
      showAppToast(
        context,
        title: l10n.pouleLoadError,
        message: pouleErrorText(l10n, error),
        variant: AppToastVariant.error,
        closeLabel: l10n.close,
      );
    }
  }

  void _openEvent(int eventId) {
    unawaited(Haptics.light());
    unawaited(context.push(AppRoutes.event(eventId)));
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);

    Poule? poule;
    final List<Widget> content;
    if (!membership.hasPoule) {
      content = [_noPoule(l10n)];
    } else {
      final async = ref.watch(pouleControllerProvider(teamId));
      poule = async.value;
      if (poule != null) {
        content = _content(poule);
      } else if (async.error is NotFoundException) {
        content = [_noPoule(l10n)];
      } else if (async.hasError) {
        content = [
          SliverToBoxAdapter(
            child: EmptyState(
              key: const ValueKey('poule-error'),
              icon: PhosphorIconsDuotone.warningCircle,
              title: l10n.pouleLoadError,
              description: pouleErrorText(l10n, async.error),
              action: PrimaryButton(
                key: const ValueKey('poule-retry'),
                label: l10n.retry,
                onPressed: () => _refresh(teamId),
              ),
            ),
          ),
        ];
      } else {
        content = const [
          SliverToBoxAdapter(
            child: Column(
              key: ValueKey('poule-loading'),
              children: [
                Skeleton(height: 36, radius: AssistjeTokens.radiusFull),
                SizedBox(height: 12),
                SkeletonList(count: 6),
              ],
            ),
          ),
        ];
      }
    }

    return Scaffold(
      key: const ValueKey('poule-screen'),
      backgroundColor: t.sunken,
      body: AppRefresh(
        onRefresh: () =>
            membership.hasPoule ? _refresh(teamId) : Future.value(),
        padding: EdgeInsets.fromLTRB(
          12,
          ShellInsets.top(context),
          12,
          ShellInsets.bottom(context),
        ),
        slivers: [_header(l10n, t, poule), ...content],
      ),
    );
  }

  Widget _header(AppLocalizations l10n, AssistjeTokens t, Poule? poule) {
    final subtitle = [
      poule?.pouleLabel,
      poule?.competition,
    ].whereType<String>().where((s) => s.trim().isNotEmpty).join(' · ');
    final fetchedAt = poule?.fetchedAt;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              header: true,
              child: Text(
                l10n.navPoule,
                // Zelfde key als de placeholder: de shell-tests lezen de
                // schermtitel via `placeholder-title`.
                key: const Key('placeholder-title'),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: t.ink,
                ),
              ),
            ),
            if (subtitle.isNotEmpty)
              Text(
                subtitle,
                key: const ValueKey('poule-subtitle'),
                style: TextStyle(fontSize: 14, color: t.inkSoft),
              ),
            if (fetchedAt != null)
              Text(
                l10n.pouleUpdatedAt(pouleUpdatedLabel(fetchedAt)),
                key: const ValueKey('poule-updated'),
                style: TextStyle(fontSize: 12, color: t.muted),
              ),
          ],
        ),
      ),
    );
  }

  Widget _noPoule(AppLocalizations l10n) => SliverToBoxAdapter(
    child: EmptyState(
      key: const ValueKey('poule-none'),
      icon: PhosphorIconsDuotone.trophy,
      title: l10n.pouleNoPouleTitle,
      description: l10n.pouleNoPouleBody,
    ),
  );

  List<Widget> _content(Poule poule) {
    final l10n = AppLocalizations.of(context);
    if (poule.neverSynced) {
      return [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('poule-not-synced'),
            icon: PhosphorIconsDuotone.hourglass,
            title: l10n.pouleNotSyncedTitle,
            description: l10n.pouleNotSyncedBody,
          ),
        ),
      ];
    }

    Widget empty(String key, String text) => SliverToBoxAdapter(
      child: EmptyState(
        key: ValueKey(key),
        icon: PhosphorIconsDuotone.soccerBall,
        title: text,
      ),
    );

    final List<Widget> body = switch (_tab) {
      PouleTab.standing =>
        poule.standing.isEmpty
            ? [empty('poule-standing-empty', l10n.pouleNoStanding)]
            : [
                SliverToBoxAdapter(
                  child: PouleStandingTable(standing: poule.standing),
                ),
              ],
      PouleTab.results =>
        poule.results.isEmpty
            ? [empty('poule-results-empty', l10n.pouleNoResults)]
            : _days(poule.results, 'poule-result', result: true),
      PouleTab.fixtures =>
        poule.fixtures.isEmpty
            ? [empty('poule-fixtures-empty', l10n.pouleNoFixtures)]
            : _days(poule.fixtures, 'poule-fixture', result: false),
    };

    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppTabPills<PouleTab>(
            key: const ValueKey('poule-tabs'),
            fullWidth: true,
            darkTrack: true,
            selected: _tab,
            onChanged: (tab) {
              if (tab == _tab) return;
              unawaited(Haptics.selection());
              setState(() => _tab = tab);
            },
            tabs: [
              AppTabPill(
                value: PouleTab.standing,
                label: l10n.pouleTabStanding,
              ),
              AppTabPill(value: PouleTab.results, label: l10n.pouleTabResults),
              AppTabPill(
                value: PouleTab.fixtures,
                label: l10n.pouleTabFixtures,
              ),
            ],
          ),
        ),
      ),
      ...body,
    ];
  }

  List<Widget> _days(
    List<PouleMatchDay> days,
    String prefix, {
    required bool result,
  }) => [
    SliverList.builder(
      itemCount: days.length,
      itemBuilder: (context, index) => PouleMatchDayCard(
        day: days[index],
        keyPrefix: '$prefix-$index',
        result: result,
        onOpenEvent: _openEvent,
      ),
    ),
  ];
}
