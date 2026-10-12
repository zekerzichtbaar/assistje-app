import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/event_detail_models.dart';
import 'event_section_card.dart';

const Color _amber400 = StatusColors.amber400;
const Color _amber500 = StatusColors.amber500;
const Color _amber600 = StatusColors.amber600;

/// Speler van de wedstrijd (`MotmSection` in de PWA): stemmen zolang het
/// open is (uitslag verborgen), daarna de winnaar en de stand.
class EventMotmSection extends StatelessWidget {
  const EventMotmSection({
    super.key,
    required this.motm,
    required this.onVote,
    required this.onUnvote,
  });

  final MotmState motm;
  final ValueChanged<int> onVote;
  final VoidCallback onUnvote;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final closes = motm.closesAt;

    final Widget body;
    if (motm.opensAfter) {
      body = _quiet(t, l10n.eventDetailMotmOpensAfter, 'motm-opens-after');
    } else if (motm.isOpen) {
      body = _voting(context, l10n, t);
    } else if (motm.tally.isEmpty) {
      body = _quiet(t, l10n.eventDetailMotmNoVotes, 'motm-no-votes');
    } else {
      body = _result(context, l10n, t);
    }

    return EventSectionCard(
      key: const ValueKey('event-motm'),
      title: l10n.eventDetailMotmTitle,
      icon: PhosphorIconsDuotone.trophy,
      titleColor: _amber600,
      trailing: motm.isOpen && closes != null
          ? Text(
              l10n.eventDetailMotmCloses(
                DateFormat('d MMM HH:mm', 'nl').format(closes.toLocal()),
              ),
              style: TextStyle(fontSize: 11, color: t.muted),
            )
          : null,
      child: body,
    );
  }

  Widget _quiet(AssistjeTokens t, String text, String key) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    child: Text(
      text,
      key: ValueKey(key),
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, color: t.muted),
    ),
  );

  Widget _voting(
    BuildContext context,
    AppLocalizations l10n,
    AssistjeTokens t,
  ) {
    final options = [
      for (final p in motm.eligible)
        if (p.id != motm.selfId) p,
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            motm.selfId != null
                ? l10n.eventDetailMotmPrompt
                : l10n.eventDetailMotmPromptNoSelf,
            style: TextStyle(fontSize: 14, color: t.inkSoft),
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 10.0;
              final columns = constraints.maxWidth >= 480 ? 4 : 3;
              final width =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;
              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: [
                  for (final p in options)
                    SizedBox(
                      width: width,
                      child: _Candidate(
                        candidate: p,
                        mine: motm.myVote == p.id,
                        onTap: motm.canVote
                            ? () => motm.myVote == p.id
                                  ? onUnvote()
                                  : onVote(p.id)
                            : null,
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          Text(
            l10n.eventDetailMotmHidden,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: t.muted),
          ),
        ],
      ),
    );
  }

  Widget _result(
    BuildContext context,
    AppLocalizations l10n,
    AssistjeTokens t,
  ) {
    final byId = {for (final e in motm.eligible) e.id: e};
    final total = motm.tally.fold<int>(0, (sum, r) => sum + r.votes);
    final top = motm.tally.first.votes;
    final winners = motm.tally.where((r) => r.votes == top).toList();
    final first = byId[winners.first.playerId];
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: AppAvatar(
              name: first?.name ?? '—',
              imageUrl: first?.avatarUrl,
              size: 56,
              ring: _amber400,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            winners.map((w) => byId[w.playerId]?.name ?? '—').join(', '),
            key: const ValueKey('motm-winner'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: t.ink,
            ),
          ),
          Text(
            l10n.eventDetailMotmVotes(top),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: t.muted),
          ),
          const SizedBox(height: 16),
          for (final r in motm.tally)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  SizedBox(
                    width: 112,
                    child: Text(
                      byId[r.playerId]?.name ?? '—',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: t.inkSoft),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        AssistjeTokens.radiusFull,
                      ),
                      child: LinearProgressIndicator(
                        value: total > 0 ? r.votes / total : 0,
                        minHeight: 8,
                        color: _amber500,
                        backgroundColor: dark
                            ? _amber500.withValues(alpha: 0.2)
                            : StatusColors.amber100,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 32,
                    child: Text(
                      '${r.votes}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: dark
                            ? StatusColors.amber300
                            : StatusColors.amber800,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      ),
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

class _Candidate extends StatelessWidget {
  const _Candidate({
    required this.candidate,
    required this.mine,
    required this.onTap,
  });

  final MotmCandidate candidate;
  final bool mine;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Semantics(
      button: true,
      selected: mine,
      label: candidate.name,
      excludeSemantics: true,
      child: GestureDetector(
        key: ValueKey('motm-candidate-${candidate.id}'),
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: mine
                ? (dark
                      ? _amber500.withValues(alpha: 0.15)
                      : StatusColors.amber50)
                : null,
            border: Border.all(color: mine ? _amber400 : t.line),
            borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
          ),
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  AppAvatar(
                    name: candidate.name,
                    imageUrl: candidate.avatarUrl,
                    ring: mine ? _amber400 : null,
                  ),
                  if (mine)
                    Positioned(
                      right: -4,
                      top: -4,
                      child: Container(
                        key: const ValueKey('motm-my-vote'),
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: _amber400,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 11,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                candidate.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: t.inkSoft,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
