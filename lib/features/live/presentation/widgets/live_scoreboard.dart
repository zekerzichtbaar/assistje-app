import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/live_models.dart';
import 'live_ui.dart';

/// Het scorebord bovenaan (`LiveScoreboard` in `EventDetail.tsx`): status,
/// meekijkers en volgen in de kop, daaronder thuis – klok – uit en bij een
/// set-scoremodel de setstanden.
class LiveScoreboard extends StatelessWidget {
  const LiveScoreboard({
    super.key,
    required this.match,
    required this.now,
    required this.onToggleFollow,
    this.footer = const [],
  });

  final LiveMatch match;
  final DateTime now;
  final VoidCallback onToggleFollow;

  /// Extra secties onder de stand (klokbediening, "Gebeurtenis").
  final List<Widget> footer;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final clock = match.clock;
    final event = match.event;
    final names = LivePeriodNames.of(l10n, match.rules);
    final inPlay = clock.inPlay;

    final String status;
    if (inPlay) {
      status = l10n.liveBadge;
    } else if (clock.isEnded || event.homeScore != null) {
      status = l10n.liveStatusReport;
    } else {
      status = l10n.liveStatusNotStarted;
    }

    String? sub;
    if (clock.isPaused) {
      sub = names.breakLabel;
    } else if (inPlay && names.count > 1 && names.part.isNotEmpty) {
      sub = l10n.livePeriodOrdinal(clock.currentPeriod, names.part);
    } else if (clock.isEnded) {
      sub = l10n.liveEnded;
    }

    final scoreStyle = TextStyle(
      fontSize: 34,
      height: 1,
      fontWeight: FontWeight.w700,
      color: t.ink,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
    final teamStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: t.muted,
    );

    return AppCard(
      key: const ValueKey('live-scoreboard'),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
            child: Row(
              children: [
                if (inPlay)
                  _LiveBadge(label: status)
                else
                  Text(
                    status.toUpperCase(),
                    key: const ValueKey('live-status'),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: t.muted,
                    ),
                  ),
                const SizedBox(width: 8),
                // Pas vanaf twee: "1 kijkt mee" tegen de enige kijker is
                // geen gezelschap.
                if (inPlay && match.liveViewers >= 2)
                  Flexible(
                    child: Row(
                      key: const ValueKey('live-viewers'),
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          PhosphorIconsDuotone.eye,
                          size: 14,
                          color: t.muted,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            l10n.liveViewers(match.liveViewers),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: t.muted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const Spacer(),
                if (inPlay)
                  _FollowButton(
                    following: match.followingLive,
                    onTap: onToggleFollow,
                  ),
              ],
            ),
          ),
          Divider(height: 1, color: t.lineSoft),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    event.homeTeam ?? l10n.liveHome,
                    key: const ValueKey('live-home-team'),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: teamStyle,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${event.homeScore ?? 0}',
                  key: const ValueKey('live-home-score'),
                  style: scoreStyle,
                ),
                SizedBox(
                  width: 84,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (clock.hasStarted)
                        Text(
                          inPlay
                              ? clock.labelAt(now)
                              : "${clock.minuteAt(now)}'",
                          key: const ValueKey('live-clock'),
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: inPlay && clock.running
                                ? StatusColors.emerald600
                                : t.inkSoft,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        )
                      else
                        Text(
                          '–',
                          style: TextStyle(fontSize: 20, color: t.muted),
                        ),
                      if (sub != null)
                        Text(
                          sub,
                          key: const ValueKey('live-period'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, color: t.muted),
                        ),
                    ],
                  ),
                ),
                Text(
                  '${event.awayScore ?? 0}',
                  key: const ValueKey('live-away-score'),
                  style: scoreStyle,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    event.awayTeam ?? l10n.liveAway,
                    key: const ValueKey('live-away-team'),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: teamStyle,
                  ),
                ),
              ],
            ),
          ),
          if (event.sets.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final set in event.sets)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: t.raised,
                        borderRadius: BorderRadius.circular(
                          AssistjeTokens.radiusFull,
                        ),
                      ),
                      child: Text(
                        '${set.homePoints}-${set.awayPoints}',
                        style: TextStyle(
                          fontSize: 12,
                          color: t.muted,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          for (final section in footer) ...[
            Divider(height: 1, color: t.lineSoft),
            section,
          ],
        ],
      ),
    );
  }
}

class _LiveBadge extends StatelessWidget {
  const _LiveBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Container(
    key: const ValueKey('live-badge'),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: StatusColors.emerald500,
      borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

class _FollowButton extends StatelessWidget {
  const _FollowButton({required this.following, required this.onTap});

  final bool following;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final fg = following ? t.primaryContrast : t.inkSoft;
    return Semantics(
      button: true,
      toggled: following,
      child: GestureDetector(
        key: const ValueKey('live-follow'),
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: following ? t.primary : t.surface,
            border: following ? null : Border.all(color: t.line),
            borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                following
                    ? PhosphorIconsFill.bellRinging
                    : PhosphorIconsDuotone.bell,
                size: 15,
                color: fg,
              ),
              const SizedBox(width: 6),
              Text(
                following ? l10n.liveFollowOn : l10n.liveFollowOff,
                key: const ValueKey('live-follow-label'),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: fg,
                ),
              ),
              if (following) ...[
                const SizedBox(width: 4),
                Icon(PhosphorIconsBold.check, size: 13, color: fg),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
