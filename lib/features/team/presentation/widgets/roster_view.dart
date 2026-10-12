import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/session/session_providers.dart';
import '../../../../core/shell/shell_insets.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/roster_controller.dart';
import '../../application/roster_sections.dart';
import '../../application/sport_info.dart';
import '../../data/models/roster_models.dart';
import 'roster_tiles.dart';
import 'roster_ui.dart';

/// De selectie zoals `/team` in de PWA: (teamafspraken), coaches, de
/// spelers per linie van de sport, Overig en Gasten. Tik op een speler =
/// spelerdetail. Trekken = verversen.
///
/// Gedeeld door `/team` (iedereen) en `/players` (trainer-menu "Spelers");
/// alleen [title] en [screenKey] verschillen.
class RosterView extends ConsumerStatefulWidget {
  const RosterView({super.key, required this.title, required this.screenKey});

  final String title;

  /// Key van de `Scaffold` (bv. `team-screen`).
  final String screenKey;

  @override
  ConsumerState<RosterView> createState() => _RosterViewState();
}

class _RosterViewState extends ConsumerState<RosterView> {
  Future<void> _refresh(int teamId) async {
    final error = await ref
        .read(rosterControllerProvider(teamId).notifier)
        .refresh();
    if (error != null && mounted) {
      showRosterError(
        context,
        AppLocalizations.of(context).rosterRefreshFailed,
        error,
      );
    }
  }

  void _openPlayer(RosterPlayer player) {
    unawaited(Haptics.selection());
    unawaited(context.push(AppRoutes.player(player.id)));
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final provider = rosterControllerProvider(teamId);
    // Onder een gepusht detail (bv. een deeplink naar /players/7) ligt dit
    // scherm verborgen (TickerMode uit): dan nog niet laden, pas zodra het
    // in beeld komt. Al geladen data blijft gewoon gevolgd.
    final AsyncValue<TeamRoster> async =
        TickerMode.valuesOf(context).enabled || ref.exists(provider)
        ? ref.watch(provider)
        : const AsyncLoading<TeamRoster>();
    final roster = async.value;

    final List<Widget> content;
    if (roster != null) {
      content = _content(
        roster,
        SportInfo.of(membership),
        showAgreements: membership.hasFeature('agreements'),
      );
    } else if (async.hasError) {
      content = [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('roster-error'),
            icon: PhosphorIconsDuotone.warningCircle,
            title: l10n.rosterLoadError,
            description: rosterErrorText(l10n, async.error),
            action: PrimaryButton(
              key: const ValueKey('roster-retry'),
              label: l10n.retry,
              onPressed: () => _refresh(teamId),
            ),
          ),
        ),
      ];
    } else {
      content = const [SliverToBoxAdapter(child: RosterSkeleton())];
    }

    return Scaffold(
      key: ValueKey(widget.screenKey),
      backgroundColor: t.sunken,
      body: AppRefresh(
        onRefresh: () => _refresh(teamId),
        padding: EdgeInsets.fromLTRB(
          12,
          ShellInsets.top(context),
          12,
          ShellInsets.bottom(context),
        ),
        slivers: [
          SliverToBoxAdapter(child: RosterScreenTitle(widget.title)),
          ...content,
        ],
      ),
    );
  }

  List<Widget> _content(
    TeamRoster roster,
    SportInfo sport, {
    required bool showAgreements,
  }) {
    final l10n = AppLocalizations.of(context);
    final sections = RosterSections.of(roster, sport);

    Widget playerTile(RosterPlayer p) => RosterPlayerTile(
      player: p,
      positionLabel: sport.positionLabel(p.position),
      onTap: () => _openPlayer(p),
    );

    final cards = <Widget>[
      if (showAgreements) const _AgreementsLink(),
      if (roster.isEmpty)
        EmptyState(
          key: const ValueKey('roster-empty'),
          icon: PhosphorIconsDuotone.usersThree,
          title: l10n.rosterEmpty,
          description: l10n.rosterEmptyHint,
        ),
      if (roster.coaches.isNotEmpty)
        RosterSectionCard(
          key: const ValueKey('roster-section-coaches'),
          title: l10n.rosterCoachesTitle(roster.coaches.length),
          children: [for (final c in roster.coaches) RosterCoachTile(coach: c)],
        ),
      for (final line in sections.lines)
        RosterSectionCard(
          key: ValueKey('roster-section-${line.key}'),
          title: line.label,
          children: [for (final p in line.players) playerTile(p)],
        ),
      if (sections.other.isNotEmpty)
        RosterSectionCard(
          key: const ValueKey('roster-section-other'),
          title: l10n.rosterOther,
          children: [for (final p in sections.other) playerTile(p)],
        ),
      if (sections.guests.isNotEmpty)
        RosterSectionCard(
          key: const ValueKey('roster-section-guests'),
          title: l10n.rosterGuests,
          children: [for (final p in sections.guests) playerTile(p)],
        ),
    ];

    return [
      SliverList.separated(
        itemCount: cards.length,
        itemBuilder: (context, index) => cards[index],
        separatorBuilder: (context, index) => const SizedBox(height: 14),
      ),
    ];
  }
}

/// Link naar de teamafspraken (feature `agreements`), zoals in de PWA.
class _AgreementsLink extends StatelessWidget {
  const _AgreementsLink();

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final l10n = AppLocalizations.of(context);
    return AppCard(
      key: const ValueKey('roster-agreements'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      onTap: () {
        unawaited(Haptics.selection());
        unawaited(context.push(AppRoutes.agreements));
      },
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: t.raised,
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
            ),
            child: Icon(
              PhosphorIconsDuotone.scroll,
              size: 20,
              color: t.inkSoft,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.navAgreements,
                  style: TextStyle(fontWeight: FontWeight.w600, color: t.ink),
                ),
                Text(
                  l10n.rosterAgreementsSubtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12, color: t.muted),
                ),
              ],
            ),
          ),
          Icon(PhosphorIconsBold.caretRight, size: 16, color: t.muted),
        ],
      ),
    );
  }
}
