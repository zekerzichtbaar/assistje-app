import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../team/presentation/widgets/roster_ui.dart';
import '../../data/models/player_detail_models.dart';

/// Kop van het spelerdetail: grote avatar met rugnummer, naam, positie en
/// markers (geblesseerd, vakantie, gast, aanvoerder, beheerder, jij).
class PlayerHeaderCard extends StatelessWidget {
  const PlayerHeaderCard({
    super.key,
    required this.player,
    required this.positionLabel,
  });

  final PlayerProfile player;
  final String? positionLabel;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final l10n = AppLocalizations.of(context);
    final p = player;
    final fromTeam = p.fromTeam;
    return AppCard(
      key: const ValueKey('player-header'),
      child: Row(
        children: [
          SizedBox(
            width: 68,
            height: 68,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                AppAvatar(name: p.name, imageUrl: p.avatarUrl, size: 64),
                if (p.shirtNumber != null)
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: Container(
                      key: const ValueKey('player-shirt-number'),
                      width: 26,
                      height: 26,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: t.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: t.surface, width: 2),
                      ),
                      child: Text(
                        '${p.shirtNumber}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: t.primaryContrast,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.name,
                  key: const ValueKey('player-name'),
                  style: TextStyle(
                    fontSize: 22,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: t.ink,
                  ),
                ),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (positionLabel != null)
                      Text(
                        positionLabel!,
                        key: const ValueKey('player-position'),
                        style: TextStyle(fontSize: 14, color: t.muted),
                      ),
                    if (p.isInjured)
                      RosterBadge(
                        key: const ValueKey('player-injured'),
                        label: l10n.rosterInjuredBadge,
                        tone: AttendanceTone.injury,
                        large: true,
                      ),
                    if (p.isOnVacation)
                      RosterBadge(
                        key: const ValueKey('player-vacation'),
                        label: l10n.rosterVacationBadge,
                        tone: AttendanceTone.vacation,
                        large: true,
                      ),
                    if (p.isGuest)
                      RosterBadge.amber(
                        key: const ValueKey('player-guest'),
                        label: l10n.rosterGuestBadge,
                        large: true,
                      ),
                    if (p.isCaptain)
                      RosterBadge.amber(
                        key: const ValueKey('player-captain'),
                        label: l10n.playerDetailCaptainBadge,
                        large: true,
                      ),
                    if (p.isTrainer)
                      RosterBadge(
                        key: const ValueKey('player-trainer'),
                        label: l10n.playerDetailTrainerBadge,
                        tone: AttendanceTone.pending,
                        large: true,
                      ),
                    if (p.isSelf)
                      RosterBadge(
                        key: const ValueKey('player-self'),
                        label: l10n.playerDetailSelfBadge,
                        tone: AttendanceTone.present,
                        large: true,
                      ),
                  ],
                ),
                if (fromTeam != null && fromTeam.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      l10n.playerDetailFromTeam(fromTeam),
                      key: const ValueKey('player-from-team'),
                      style: TextStyle(fontSize: 12, color: t.muted),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
