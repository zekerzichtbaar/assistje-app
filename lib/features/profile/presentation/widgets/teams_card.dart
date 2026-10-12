import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/session/models/team.dart';
import '../../../../core/session/session_providers.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/team_leave_controller.dart';
import 'profile_ui.dart';

/// "Mijn teams" (`TeamsSection` in de PWA-profielpagina): de teams waar je in
/// zit, met een uitweg. Nodig sinds een trainer iemand met een bestaand
/// account aan zijn team kan koppelen.
///
/// Alleen zichtbaar bij meer dan één team — met één team zou vertrekken je
/// uitsluiten, en dat weigert de server ook (`422`).
class TeamsCard extends ConsumerStatefulWidget {
  const TeamsCard({super.key});

  @override
  ConsumerState<TeamsCard> createState() => _TeamsCardState();
}

class _TeamsCardState extends ConsumerState<TeamsCard> {
  int? _leaving;

  Future<void> _leave(Team team) async {
    final l10n = AppLocalizations.of(context);
    unawaited(Haptics.light());
    final ok = await confirmProfileAction(
      context,
      title: l10n.profileTeamLeaveTitle(team.name),
      question: l10n.profileTeamLeaveBody,
      confirmLabel: l10n.profileTeamLeave,
    );
    if (!ok || !mounted) return;
    setState(() => _leaving = team.id);
    final error = await ref.read(teamLeaveControllerProvider).leave(team.id);
    if (!mounted) return;
    setState(() => _leaving = null);
    if (error != null) {
      showProfileError(context, l10n.profileTeamLeaveFailed, error);
    } else {
      showProfileSuccess(context, l10n.profileTeamLeft(team.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final teams = ref.watch(meProvider).value?.teams ?? const [];
    final current = ref.watch(currentMembershipProvider);
    if (teams.length < 2) return const SizedBox.shrink();

    return AppCard(
      key: const ValueKey('profile-teams'),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: ProfileCardHeader(
              title: l10n.profileTeamsTitle,
              body: l10n.profileTeamsBody,
            ),
          ),
          const SizedBox(height: 8),
          for (final (index, membership) in teams.indexed) ...[
            if (index > 0) Divider(height: 1, thickness: 1, color: t.lineSoft),
            Padding(
              key: ValueKey('profile-teams-${membership.team.id}'),
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
              child: Row(
                children: [
                  _TeamLogo(team: membership.team),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: membership.team.name,
                        children: [
                          if (current?.team.id == membership.team.id)
                            TextSpan(
                              text: '  ${l10n.profileTeamsCurrent}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: t.muted,
                              ),
                            ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: t.ink,
                      ),
                    ),
                  ),
                  if (_leaving == membership.team.id)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  else
                    TextButton(
                      key: ValueKey(
                        'profile-teams-leave-${membership.team.id}',
                      ),
                      onPressed: _leaving == null
                          ? () => _leave(membership.team)
                          : null,
                      style: TextButton.styleFrom(foregroundColor: t.muted),
                      child: Text(
                        l10n.profileTeamLeave,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

class _TeamLogo extends StatelessWidget {
  const _TeamLogo({required this.team});

  final Team team;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final url = team.logoUrl;
    final placeholder = DecoratedBox(
      decoration: BoxDecoration(
        color: t.raised,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusMd),
      ),
    );
    return SizedBox(
      width: 32,
      height: 32,
      child: url == null
          ? placeholder
          : ClipRRect(
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusMd),
              child: Image.network(
                url,
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => placeholder,
              ),
            ),
    );
  }
}
