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
import '../../team/application/sport_info.dart';
import '../../team/presentation/widgets/roster_ui.dart';
import '../application/player_detail_controller.dart';
import '../data/models/player_detail_models.dart';
import 'widgets/player_header_card.dart';
import 'widgets/player_sections.dart';
import 'widgets/player_stats_section.dart';

/// Het spelerdetail (`/players/{player}` in de PWA): kop met avatar,
/// rugnummer en markers, (voor trainers) e-mail/account, vakanties en vaste
/// afwezige dagen, badges, persoonlijke statistieken (seizoen/carrière) en
/// diensten. Alleen-lezen. Trekken = verversen.
class PlayerDetailScreen extends ConsumerStatefulWidget {
  const PlayerDetailScreen({super.key, required this.playerId});

  /// Id van de speler uit het pad (al geparsed door de router).
  final int playerId;

  @override
  ConsumerState<PlayerDetailScreen> createState() => _PlayerDetailScreenState();
}

class _PlayerDetailScreenState extends ConsumerState<PlayerDetailScreen> {
  PlayerKey _key(int teamId) => (teamId: teamId, playerId: widget.playerId);

  String _errorText(Object? error) {
    final l10n = AppLocalizations.of(context);
    return switch (error) {
      NotFoundException() => l10n.playerDetailNotFound,
      _ => rosterErrorText(l10n, error),
    };
  }

  Future<void> _refresh(int teamId) async {
    final error = await ref
        .read(playerDetailControllerProvider(_key(teamId)).notifier)
        .refresh();
    if (error != null && mounted) {
      showRosterError(
        context,
        AppLocalizations.of(context).rosterRefreshFailed,
        error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(playerDetailControllerProvider(_key(teamId)));
    final detail = async.value;

    final List<Widget> content;
    if (detail != null) {
      content = _content(membership, detail);
    } else if (async.hasError) {
      content = [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('player-error'),
            icon: PhosphorIconsDuotone.warningCircle,
            title: l10n.playerDetailLoadError,
            description: _errorText(async.error),
            action: PrimaryButton(
              key: const ValueKey('player-retry'),
              label: l10n.retry,
              onPressed: () => _refresh(teamId),
            ),
          ),
        ),
      ];
    } else {
      content = const [SliverToBoxAdapter(child: PlayerDetailSkeleton())];
    }

    return Scaffold(
      key: const ValueKey('player-detail-screen'),
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
          SliverToBoxAdapter(child: RosterScreenTitle(l10n.screenPlayer)),
          ...content,
        ],
      ),
    );
  }

  List<Widget> _content(TeamMembership membership, PlayerDetail detail) {
    final sport = SportInfo.of(membership);
    final player = detail.player;
    final stats = detail.personalStats;
    final absences = detail.standingAbsences;

    final children = <Widget>[
      PlayerHeaderCard(
        player: player,
        positionLabel: sport.positionLabel(player.position),
      ),
      if (detail.canManage) PlayerManageCard(player: player),
      if (detail.canManage &&
          (detail.vacations.isNotEmpty ||
              (!player.isGuest && membership.hasFeature('vacations'))))
        PlayerVacationsCard(vacations: detail.vacations),
      if (detail.canManage && absences != null && absences.choices.isNotEmpty)
        PlayerStandingAbsencesCard(name: player.name, absences: absences),
      if (detail.achievements.isNotEmpty)
        PlayerAchievementsCard(achievements: detail.achievements),
      if (stats != null)
        PlayerStatsSection(
          stats: stats,
          sport: sport,
          showTrainingPoints: membership.hasFeature('training_points'),
        ),
      if (detail.duties.isNotEmpty) PlayerDutiesCard(duties: detail.duties),
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
