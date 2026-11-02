import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../agenda/presentation/widgets/duty_icons.dart';
import '../application/duty_overview_controller.dart';
import '../data/models/duty_overview_models.dart';
import 'widgets/duties_ui.dart';

/// Diensten voor wie geen trainer is (`Pages/Player/Duties.tsx`, `/diensten`):
/// eerst wat jij moet doen, daarna per dienst wat er gepland staat en wie in
/// welke groep zit. Alleen lezen; een beurt bij een wedstrijd opent die
/// wedstrijd. Plannen blijft bij de trainer op `/duties`.
class DutyOverviewScreen extends ConsumerWidget {
  const DutyOverviewScreen({super.key});

  Future<void> _refresh(BuildContext context, WidgetRef ref, int teamId) async {
    final l10n = AppLocalizations.of(context);
    final error = await ref
        .read(dutyOverviewControllerProvider(teamId).notifier)
        .refresh();
    if (error != null && context.mounted) {
      showDutiesError(context, l10n.dutiesLoadError, error);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(dutyOverviewControllerProvider(teamId));
    final overview = async.value;

    final List<Widget> content;
    if (overview != null) {
      content = _content(context, overview);
    } else if (async.hasError) {
      content = [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('duty-overview-error'),
            icon: PhosphorIconsDuotone.warningCircle,
            title: l10n.dutiesLoadError,
            description: dutiesErrorText(l10n, async.error),
            action: PrimaryButton(
              key: const ValueKey('duty-overview-retry'),
              label: l10n.retry,
              onPressed: () => _refresh(context, ref, teamId),
            ),
          ),
        ),
      ];
    } else {
      content = const [
        SliverToBoxAdapter(
          child: SkeletonList(key: ValueKey('duty-overview-loading')),
        ),
      ];
    }

    return Scaffold(
      key: const ValueKey('duty-overview-screen'),
      backgroundColor: t.sunken,
      body: AppRefresh(
        onRefresh: () => _refresh(context, ref, teamId),
        padding: EdgeInsets.fromLTRB(
          12,
          ShellInsets.top(context),
          12,
          ShellInsets.bottom(context),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
              child: ScreenHeader(
                title: l10n.navDuties,
                // Zelfde key als de placeholder: de shell-tests lezen de
                // schermtitel via `placeholder-title`.
                titleKey: const Key('placeholder-title'),
              ),
            ),
          ),
          ...content,
        ],
      ),
    );
  }

  List<Widget> _content(BuildContext context, DutyOverview overview) {
    final l10n = AppLocalizations.of(context);
    if (overview.duties.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('duty-overview-empty'),
            icon: PhosphorIconsDuotone.flag,
            title: l10n.dutyOverviewEmptyTitle,
            description: l10n.dutyOverviewEmpty,
          ),
        ),
      ];
    }
    final cards = <Widget>[
      DutiesCard(
        key: const ValueKey('duty-overview-mine'),
        title: l10n.dutyOverviewMineTitle,
        child: overview.mine.isEmpty
            ? _Quiet(
                l10n.dutyOverviewMineEmpty,
                key: const ValueKey('duty-overview-mine-empty'),
              )
            : _Rows([
                for (final row in overview.mine)
                  _DutyRow(row: row, showType: true, keyPrefix: 'mine'),
              ]),
      ),
      for (final type in overview.duties) _TypeCard(type: type),
    ];
    return [
      SliverList.separated(
        itemCount: cards.length,
        itemBuilder: (context, index) => cards[index],
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      ),
    ];
  }
}

/// Eén diensttype: wat er gepland staat (hooguit 8, met een verwijzing naar
/// de agenda voor de rest) en bij een groepsdienst wie in welke groep zit.
class _TypeCard extends StatelessWidget {
  const _TypeCard({required this.type});

  final DutyOverviewType type;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final hasGroups = type.groups.isNotEmpty;
    return DutiesCard(
      key: ValueKey('duty-overview-type-${type.id}'),
      title: type.name,
      icon: dutyIconFor(type.icon),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (hasGroups) _SubHeading(l10n.dutyOverviewPlanned),
          if (type.upcoming.isEmpty)
            _Quiet(
              l10n.dutyOverviewNothingPlanned,
              key: ValueKey('duty-overview-type-${type.id}-empty'),
            )
          else
            _Rows([
              for (final row in type.upcoming)
                _DutyRow(row: row, keyPrefix: 'type-${type.id}'),
            ]),
          if (type.more > 0)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                key: ValueKey('duty-overview-type-${type.id}-more'),
                onPressed: () => context.go(AppRoutes.agenda),
                child: Text(l10n.dutyOverviewMore(type.more)),
              ),
            ),
          if (hasGroups) ...[
            _SubHeading(l10n.dutyOverviewGroups),
            _Rows([
              for (final group in type.groups)
                Padding(
                  key: ValueKey('duty-overview-group-${group.id}'),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              group.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: t.ink,
                              ),
                            ),
                          ),
                          if (group.mine) ...[
                            const SizedBox(width: 8),
                            const _MineBadge(),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        group.members.isEmpty
                            ? l10n.dutyOverviewNoMembers
                            : group.members.join(', '),
                        style: TextStyle(fontSize: 13, color: t.muted),
                      ),
                    ],
                  ),
                ),
            ]),
          ],
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

/// Eén beurt. Met [showType] (Jouw beurten) staan icoon en diensttype
/// voorop; anders wie het doet, met "Jij" als jij erbij bent. Bij een
/// wedstrijd tik je door naar die wedstrijd.
class _DutyRow extends StatelessWidget {
  const _DutyRow({
    required this.row,
    required this.keyPrefix,
    this.showType = false,
  });

  final DutyOverviewRow row;
  final String keyPrefix;
  final bool showType;

  /// Wanneer, en waarbij: datum, tijd, wedstrijd en notitie op één regel.
  String _whenLine() {
    final day = row.date.length >= 10 ? row.date.substring(0, 10) : row.date;
    final start = row.startsAt == null ? null : dutiesTimeLabel(row.startsAt!);
    final end = row.endsAt == null ? null : dutiesTimeLabel(row.endsAt!);
    final time = start == null ? null : (end == null ? start : '$start – $end');
    return [
      if (day.isNotEmpty) dutiesDateLabel(day),
      ?time,
      ?row.eventLabel,
      if ((row.notes ?? '').trim().isNotEmpty) row.notes!.trim(),
    ].join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    // Bij een groep staat de groepsnaam voorop; bij personen zijn de namen
    // het hele verhaal.
    final who =
        row.groupName ??
        (row.playerNames.isNotEmpty
            ? row.playerNames.join(', ')
            : l10n.dutyOverviewNobody);
    final eventId = row.eventId;

    final body = ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 52),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            if (showType) ...[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: row.mine
                      ? (dark
                            ? StatusColors.emerald500.withValues(alpha: 0.15)
                            : StatusColors.emerald50)
                      : t.sunken,
                ),
                child: Icon(
                  dutyIconFor(row.icon, row.dutyType),
                  size: 18,
                  color: row.mine
                      ? (dark
                            ? StatusColors.emerald400
                            : StatusColors.emerald600)
                      : t.muted,
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 2,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        showType ? row.title : who,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: t.ink,
                        ),
                      ),
                      if (!showType && row.mine) const _MineBadge(),
                      if (row.done)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              PhosphorIconsBold.check,
                              size: 12,
                              color: t.muted,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              l10n.dutiesDone,
                              style: TextStyle(fontSize: 11, color: t.muted),
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _whenLine(),
                    style: TextStyle(fontSize: 13, color: t.muted),
                  ),
                ],
              ),
            ),
            if (eventId != null) ...[
              const SizedBox(width: 8),
              PhosphorIcon(
                PhosphorIconsBold.caretRight,
                size: 14,
                color: t.muted,
              ),
            ],
          ],
        ),
      ),
    );

    final key = ValueKey('duty-overview-$keyPrefix-${row.dutyId}');
    if (eventId == null) return KeyedSubtree(key: key, child: body);
    return Semantics(
      button: true,
      child: InkWell(
        key: key,
        onTap: () => context.push(AppRoutes.event(eventId)),
        child: body,
      ),
    );
  }
}

/// "Jij": jij staat op deze beurt of in deze groep.
class _MineBadge extends StatelessWidget {
  const _MineBadge();

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: dark
            ? StatusColors.emerald500.withValues(alpha: 0.15)
            : StatusColors.emerald50,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
      ),
      child: Text(
        AppLocalizations.of(context).dutyOverviewMine,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: dark ? StatusColors.emerald400 : StatusColors.emerald700,
        ),
      ),
    );
  }
}

/// Rijen met haarlijnen ertussen.
class _Rows extends StatelessWidget {
  const _Rows(this.children);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0)
            Divider(height: 1, indent: 16, endIndent: 16, color: t.lineSoft),
          children[i],
        ],
      ],
    );
  }
}

/// Kopje binnen een kaart ("Gepland", "Groepen").
class _SubHeading extends StatelessWidget {
  const _SubHeading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Semantics(
        header: true,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: t.muted,
          ),
        ),
      ),
    );
  }
}

/// Een rustige regel tekst als er niets is.
class _Quiet extends StatelessWidget {
  const _Quiet(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    child: Text(
      text,
      style: TextStyle(fontSize: 14, color: AssistjeTokens.of(context).muted),
    ),
  );
}
