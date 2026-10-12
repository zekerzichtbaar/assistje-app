import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/live_feed.dart';
import '../../data/models/live_models.dart';
import 'live_ui.dart';

/// De tijdlijn (Forza-stijl, zoals de PWA): middenkolom met het icoon, aan
/// de kant van wie het punt krijgt de inhoud, aan de andere kant de minuut.
/// Thuis links, uit rechts. Duimpjes onder de regel, aan dezelfde kant.
class LiveTimeline extends StatelessWidget {
  const LiveTimeline({
    super.key,
    required this.match,
    required this.feed,
    required this.onToggleReaction,
    required this.onOpenPicker,
    required this.onDelete,
  });

  final LiveMatch match;
  final List<LiveFeedItem> feed;
  final void Function(String itemKey, String emoji) onToggleReaction;
  final ValueChanged<LiveFeedItem> onOpenPicker;
  final ValueChanged<LiveFeedItem> onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    if (feed.isEmpty) {
      return Padding(
        key: const ValueKey('live-timeline-empty'),
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Text(
          l10n.liveTimelineEmpty,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: t.muted),
        ),
      );
    }
    return AppCard(
      key: const ValueKey('live-timeline'),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Column(
        children: [
          for (var i = 0; i < feed.length; i++) ...[
            if (i > 0) const SizedBox(height: 16),
            _row(context, feed[i]),
          ],
        ],
      ),
    );
  }

  Widget _row(BuildContext context, LiveFeedItem item) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final left = item.ours == match.event.weAreHome;
    final minute = Text(
      "${item.minute}'",
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: t.muted,
        fontFeatures: const [FontFeature.tabularFigures()],
      ),
    );
    final actions = <Widget>[
      if (match.canReact)
        _IconAction(
          key: ValueKey('live-react-${item.itemKey}'),
          icon: PhosphorIconsDuotone.smiley,
          label: l10n.liveReact,
          onTap: () => onOpenPicker(item),
        ),
      if (match.canManage)
        _IconAction(
          key: ValueKey('live-delete-${item.itemKey}'),
          icon: PhosphorIconsBold.trash,
          label: l10n.liveDeleteItem,
          onTap: () => onDelete(item),
        ),
    ];
    final content = _content(context, item, left ? TextAlign.right : null);
    final reactions = match.reactions[item.itemKey] ?? const [];

    Widget side(bool isContent) {
      if (!isContent) {
        return Align(
          alignment: left ? Alignment.centerLeft : Alignment.centerRight,
          child: minute,
        );
      }
      final children = left
          ? [...actions.reversed, Flexible(child: content)]
          : [Flexible(child: content), ...actions];
      return Row(
        mainAxisAlignment: left
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            children[i],
          ],
        ],
      );
    }

    return Column(
      key: ValueKey('live-item-${item.itemKey}'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: side(left)),
            SizedBox(width: 52, child: Center(child: _node(context, item))),
            Expanded(child: side(!left)),
          ],
        ),
        if (reactions.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                Expanded(
                  child: left
                      ? _ReactionRow(
                          itemKey: item.itemKey,
                          reactions: reactions,
                          enabled: match.canReact,
                          alignEnd: true,
                          onToggle: (e) => onToggleReaction(item.itemKey, e),
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(width: 52),
                Expanded(
                  child: left
                      ? const SizedBox.shrink()
                      : _ReactionRow(
                          itemKey: item.itemKey,
                          reactions: reactions,
                          enabled: match.canReact,
                          alignEnd: false,
                          onToggle: (e) => onToggleReaction(item.itemKey, e),
                        ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _node(BuildContext context, LiveFeedItem item) {
    final t = AssistjeTokens.of(context);
    Widget circle(Widget child, {Color? border, Color? fill}) => Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: fill ?? t.surface,
        border: Border.all(color: border ?? t.line, width: 2),
      ),
      child: child,
    );

    switch (item.kind) {
      case LiveFeedKind.goal:
        final goal = item.goal!;
        if (goal.isOwnGoal) {
          return circle(
            const Icon(
              PhosphorIconsDuotone.target,
              size: 20,
              color: StatusColors.red600,
            ),
            border: StatusColors.red100,
            fill: StatusColors.red50,
          );
        }
        if (goal.isOurs && goal.scorerAvatar != null) {
          return AppAvatar(
            name: goal.scorer ?? '',
            imageUrl: goal.scorerAvatar,
            size: 36,
          );
        }
        return circle(
          Icon(PhosphorIconsDuotone.target, size: 20, color: t.ink),
        );
      case LiveFeedKind.sub:
        return circle(
          const Icon(
            PhosphorIconsBold.arrowsLeftRight,
            size: 16,
            color: StatusColors.emerald600,
          ),
        );
      case LiveFeedKind.card:
        return circle(
          Container(
            key: ValueKey('live-card-${item.card!.type}'),
            width: 12,
            height: 16,
            decoration: BoxDecoration(
              color: liveCardColor(item.card!.type),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      case LiveFeedKind.moment:
        return circle(
          Icon(PhosphorIconsDuotone.flag, size: 18, color: t.muted),
        );
    }
  }

  Widget _content(BuildContext context, LiveFeedItem item, TextAlign? align) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final end = align == TextAlign.right;
    final cross = end ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    Text line(String text, TextStyle style, {Key? key}) => Text(
      text,
      key: key,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: align,
      style: style,
    );
    final strong = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w600,
      color: t.ink,
    );
    final small = TextStyle(fontSize: 11, color: t.muted);

    switch (item.kind) {
      case LiveFeedKind.goal:
        final goal = item.goal!;
        final name = goal.scorer ?? l10n.liveOpponentGoal;
        final details = [
          if (goal.penalty) l10n.livePenalty,
          if (goal.assist != null) l10n.liveAssistBy(goal.assist!),
        ].join(' · ');
        return Column(
          crossAxisAlignment: cross,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.score != null) ...[
                  Text(
                    item.score!,
                    style: strong.copyWith(
                      fontWeight: FontWeight.w700,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
                Flexible(child: line(name, strong)),
                if (goal.isOwnGoal) ...[
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: StatusColors.red100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      l10n.liveOwnGoalBadge.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: StatusColors.red700,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (details.isNotEmpty) line(details, small),
          ],
        );
      case LiveFeedKind.sub:
        final sub = item.sub!;
        return Column(
          crossAxisAlignment: cross,
          children: [
            line(
              sub.on ?? '',
              strong.copyWith(fontSize: 14, color: StatusColors.emerald600),
            ),
            line(sub.off ?? '', small.copyWith(color: StatusColors.red500)),
          ],
        );
      case LiveFeedKind.card:
        final card = item.card!;
        return Column(
          crossAxisAlignment: cross,
          children: [
            line(
              card.player ?? '',
              strong.copyWith(fontWeight: FontWeight.w500),
            ),
            line(match.cardLabel(card.type), small),
          ],
        );
      case LiveFeedKind.moment:
        final moment = item.moment!;
        return Column(
          crossAxisAlignment: cross,
          children: [
            line(
              moment.label.isEmpty ? moment.type : moment.label,
              strong.copyWith(color: t.inkSoft),
            ),
            if (moment.player != null) line(moment.player!, small),
          ],
        );
    }
  }
}

class _IconAction extends StatelessWidget {
  const _IconAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, size: 16, color: t.muted),
        ),
      ),
    );
  }
}

/// De duimpjes die er al staan; aantikken zet je eigen stem op die emoji.
class _ReactionRow extends StatelessWidget {
  const _ReactionRow({
    required this.itemKey,
    required this.reactions,
    required this.enabled,
    required this.alignEnd,
    required this.onToggle,
  });

  final String itemKey;
  final List<LiveReaction> reactions;
  final bool enabled;
  final bool alignEnd;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Wrap(
      alignment: alignEnd ? WrapAlignment.end : WrapAlignment.start,
      spacing: 4,
      runSpacing: 4,
      children: [
        for (final r in reactions)
          GestureDetector(
            key: ValueKey('live-reaction-$itemKey-${r.emoji}'),
            behavior: HitTestBehavior.opaque,
            onTap: enabled ? () => onToggle(r.emoji) : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: r.mine ? t.primary.withValues(alpha: 0.12) : t.raised,
                border: Border.all(
                  color: r.mine ? t.primary : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
              ),
              child: Text(
                '${r.emoji} ${r.count}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: r.mine ? FontWeight.w700 : FontWeight.w500,
                  color: t.inkSoft,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// De emoji-kiezer (sheet) voor een nieuwe reactie; geeft de gekozen emoji.
class LiveEmojiPicker extends StatelessWidget {
  const LiveEmojiPicker({super.key, required this.emoji, this.mine});

  final List<String> emoji;

  /// De emoji die je al gaf (gemarkeerd).
  final String? mine;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final e in emoji)
            GestureDetector(
              key: ValueKey('live-emoji-$e'),
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(e),
              child: Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: e == mine
                      ? t.primary.withValues(alpha: 0.12)
                      : t.raised,
                  shape: BoxShape.circle,
                ),
                child: Text(e, style: const TextStyle(fontSize: 26)),
              ),
            ),
        ],
      ),
    );
  }
}
