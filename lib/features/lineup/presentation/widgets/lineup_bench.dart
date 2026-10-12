import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/lineup_models.dart';
import 'lineup_field.dart';
import 'lineup_ui.dart';

/// De bank: wie aanwezig is maar niet op het veld staat. Voor wie mag
/// bewerken is het ook een [DragTarget]: een speler van het veld hierheen
/// slepen haalt hem van het veld.
class LineupBench extends StatelessWidget {
  const LineupBench({
    super.key,
    required this.bench,
    required this.poolEmpty,
    required this.sport,
    required this.canEdit,
    required this.pickedId,
    required this.hint,
    required this.onPick,
    required this.onDropFromField,
  });

  final List<LineupPlayer> bench;

  /// Is er helemaal niemand aanwezig?
  final bool poolEmpty;

  /// Het sportprofiel uit `/me` (positienamen).
  final Map<String, dynamic> sport;
  final bool canEdit;
  final int? pickedId;

  /// Korte uitleg rechts in de kop (alleen voor bewerkers).
  final String? hint;
  final ValueChanged<LineupPlayer> onPick;
  final ValueChanged<LineupPlayer> onDropFromField;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final header = Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Row(
        children: [
          Text(
            (canEdit
                    ? l10n.lineupBench(bench.length)
                    : l10n.lineupSubstitutes(bench.length))
                .toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
              color: t.muted,
            ),
          ),
          const Spacer(),
          if (hint != null)
            Flexible(
              child: Text(
                hint!,
                key: const ValueKey('lineup-hint'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: pickedId != null
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: pickedId != null ? lineupAmberText : t.muted,
                ),
              ),
            ),
        ],
      ),
    );

    final Widget list;
    if (bench.isEmpty) {
      list = Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: SizedBox(
          height: 72,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              poolEmpty ? l10n.lineupPoolEmpty : l10n.lineupBenchEmpty,
              key: const ValueKey('lineup-bench-empty'),
              style: TextStyle(fontSize: 14, color: t.muted),
            ),
          ),
        ),
      );
    } else {
      list = SizedBox(
        height: 96,
        child: ListView.separated(
          key: const ValueKey('lineup-bench-list'),
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          itemCount: bench.length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final player = bench[index];
            final card = _BenchCard(
              player: player,
              subtitle: lineupPlayerSubtitle(l10n, sport, player),
              picked: pickedId == player.id,
            );
            if (!canEdit) return card;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onPick(player),
              child: LongPressDraggable<LineupPlayer>(
                data: player,
                delay: lineupDragDelay,
                feedback: lineupDragPreview(player),
                childWhenDragging: Opacity(opacity: 0.3, child: card),
                child: card,
              ),
            );
          },
        ),
      );
    }

    final content = Column(
      key: const ValueKey('lineup-bench'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [header, list],
    );
    if (!canEdit) return content;
    return DragTarget<LineupPlayer>(
      // Alleen spelers van het veld; een bankspeler terugleggen doet niets.
      onWillAcceptWithDetails: (details) =>
          !bench.any((p) => p.id == details.data.id),
      onAcceptWithDetails: (details) => onDropFromField(details.data),
      builder: (context, candidates, rejected) => AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: candidates.isNotEmpty
            ? lineupAmber.withValues(alpha: 0.12)
            : Colors.transparent,
        child: content,
      ),
    );
  }
}

class _BenchCard extends StatelessWidget {
  const _BenchCard({
    required this.player,
    required this.subtitle,
    required this.picked,
  });

  final LineupPlayer player;
  final String subtitle;
  final bool picked;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final number = player.shirtNumber;
    return SizedBox(
      key: ValueKey('lineup-bench-player-${player.id}'),
      width: 68,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 48,
            height: 44,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                AppAvatar(
                  name: player.name,
                  imageUrl: player.avatarUrl,
                  ring: picked ? lineupAmber : null,
                  ringWidth: picked ? 3 : 2,
                ),
                if (number != null)
                  Positioned(
                    left: 0,
                    top: 0,
                    child: ShirtBadge(number: number, size: 18),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            player.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: t.ink,
              height: 1.2,
            ),
          ),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 10, color: t.muted, height: 1.2),
            ),
        ],
      ),
    );
  }
}

/// De deelbalk onder de bank. Delen is een expliciete actie; is er na het
/// delen nog gesleept, dan wordt de knop weer prominent (amber).
class LineupShareBar extends StatelessWidget {
  const LineupShareBar({
    super.key,
    required this.lineup,
    required this.busy,
    required this.disabled,
    required this.onShare,
  });

  final Lineup lineup;
  final bool busy;
  final bool disabled;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final shared = lineup.isShared;
    final changed = lineup.changedSincePublish;
    final label = busy
        ? l10n.lineupSharing
        : !shared
        ? l10n.lineupShare
        : changed
        ? l10n.lineupShareAgain
        : l10n.lineupSharedState;
    final sharedAt = lineup.publishedAtTime;
    final enabled = !disabled && !(shared && !changed);

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: t.lineSoft)),
      ),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (shared)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                changed
                    ? l10n.lineupChangedSinceShare
                    : sharedAt == null
                    ? l10n.lineupSharedState
                    : l10n.lineupSharedAt(formatLineupShared(sharedAt)),
                key: const ValueKey('lineup-share-status'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: changed ? lineupAmberText : t.muted,
                ),
              ),
            ),
          if (shared && !changed)
            SecondaryButton(
              key: const ValueKey('lineup-share'),
              label: label,
              expand: true,
              onPressed: null,
            )
          else if (changed)
            AppButtonBase(
              key: const ValueKey('lineup-share'),
              label: label,
              background: StatusColors.amber500, // amber-500
              foreground: Colors.white,
              loading: busy,
              expand: true,
              height: 48,
              onPressed: enabled ? onShare : null,
            )
          else
            PrimaryButton(
              key: const ValueKey('lineup-share'),
              label: label,
              loading: busy,
              expand: true,
              onPressed: enabled ? onShare : null,
            ),
        ],
      ),
    );
  }
}
