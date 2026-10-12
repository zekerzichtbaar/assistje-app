import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../l10n/generated/app_localizations.dart';
import '../session/models/team_membership.dart';
import '../session/session_providers.dart';
import '../theme/assistje_tokens.dart';
import '../theme/team_color.dart';

/// De rol als Nederlands label.
String roleLabel(AppLocalizations l10n, TeamRole role) => switch (role) {
  TeamRole.trainer => l10n.roleTrainer,
  TeamRole.player => l10n.rolePlayer,
  TeamRole.spectator => l10n.roleSpectator,
  TeamRole.unknown => l10n.roleUnknown,
};

/// De teams uit `/me` om tussen te wisselen (zonder roundtrip). Staat
/// bovenin het menu.
class TeamSwitcher extends ConsumerWidget {
  const TeamSwitcher({super.key, required this.onSwitched});

  /// Na een wissel (naar een ánder team).
  final VoidCallback onSwitched;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final tokens = AssistjeTokens.of(context);
    final current = ref.watch(currentMembershipProvider);
    final teams = ref.watch(meProvider).value?.teams ?? const [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 6),
          child: Text(
            l10n.homeSwitchTeam,
            style: TextStyle(
              color: tokens.muted,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        for (final membership in teams)
          _TeamTile(
            membership: membership,
            selected: membership.team.id == current?.team.id,
            onTap: () async {
              if (membership.team.id == current?.team.id) {
                onSwitched();
                return;
              }
              await ref
                  .read(currentTeamIdProvider.notifier)
                  .select(membership.team.id);
              onSwitched();
            },
          ),
      ],
    );
  }
}

class _TeamTile extends StatelessWidget {
  const _TeamTile({
    required this.membership,
    required this.selected,
    required this.onTap,
  });

  final TeamMembership membership;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = AssistjeTokens.of(context);
    final l10n = AppLocalizations.of(context);
    return InkWell(
      key: ValueKey('team-${membership.team.id}'),
      borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: TeamColor.toColor(
                  membership.team.primaryColor ?? TeamColor.fallbackHex,
                ),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    membership.team.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: tokens.ink,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    roleLabel(l10n, membership.role),
                    style: TextStyle(color: tokens.muted, fontSize: 13),
                  ),
                ],
              ),
            ),
            if (selected)
              PhosphorIcon(
                PhosphorIconsBold.check,
                size: 18,
                color: tokens.primary,
              ),
          ],
        ),
      ),
    );
  }
}
