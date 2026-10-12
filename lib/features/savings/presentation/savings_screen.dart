import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../fines/application/money.dart';
import '../application/savings_controller.dart';
import '../data/models/savings_models.dart';
import 'savings_form_screen.dart';
import 'savings_pot_screen.dart';
import 'widgets/savings_ui.dart';

/// De Spaarpot (`Pages/Savings/Index` in de PWA): de lopende potten met
/// voortgang naar het doel. Tik = detail (matrix). De penningmeester
/// (`can_manage`) maakt nieuwe potten aan.
class SavingsScreen extends ConsumerStatefulWidget {
  const SavingsScreen({super.key});

  @override
  ConsumerState<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends ConsumerState<SavingsScreen> {
  SavingsListController _controller(int teamId) =>
      ref.read(savingsListControllerProvider(teamId).notifier);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showSavingsError(
        context,
        AppLocalizations.of(context).savingsLoadError,
        error,
      );
    }
  }

  Future<void> _openPot(int teamId, int potId) async {
    unawaited(Haptics.light());
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<void>(
        builder: (_) => SavingsPotScreen(teamId: teamId, potId: potId),
      ),
    );
  }

  Future<void> _newPot(int teamId) async {
    unawaited(Haptics.light());
    final controller = _controller(teamId);
    SavingsPot? pot;
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute<bool>(
        builder: (_) => SavingsFormScreen(
          teamId: teamId,
          onSubmit: (draft) async {
            final result = await controller.createPot(draft);
            pot = result.pot;
            return result.error;
          },
        ),
      ),
    );
    final created = pot;
    if (created == null || !mounted) return;
    showSavingsSuccess(context, AppLocalizations.of(context).savingsCreated);
    await _openPot(teamId, created.id);
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(savingsListControllerProvider(teamId));
    final overview = async.value;

    final List<Widget> content;
    if (overview != null) {
      content = _content(teamId, overview);
    } else if (async.hasError) {
      content = [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('savings-error'),
            icon: PhosphorIconsDuotone.warningCircle,
            title: l10n.savingsLoadError,
            description: savingsLoadErrorText(l10n, async.error),
            action: PrimaryButton(
              key: const ValueKey('savings-retry'),
              label: l10n.retry,
              onPressed: () => _refresh(teamId),
            ),
          ),
        ),
      ];
    } else {
      content = const [
        SliverToBoxAdapter(
          child: Column(
            key: ValueKey('savings-loading'),
            children: [
              Skeleton(height: 120, radius: AssistjeTokens.radius2xl),
              SizedBox(height: 12),
              Skeleton(height: 120, radius: AssistjeTokens.radius2xl),
            ],
          ),
        ),
      ];
    }

    return Scaffold(
      key: const ValueKey('savings-screen'),
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(
                        l10n.navSavings,
                        // Zelfde key als de placeholder: de shell-tests lezen
                        // de schermtitel via `placeholder-title`.
                        key: const Key('placeholder-title'),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: t.ink,
                        ),
                      ),
                    ),
                  ),
                  if (overview?.canManage ?? false)
                    PrimaryButton(
                      key: const ValueKey('savings-new'),
                      label: l10n.savingsNewPot,
                      icon: const Icon(PhosphorIconsBold.plus, size: 16),
                      onPressed: () => _newPot(teamId),
                    ),
                ],
              ),
            ),
          ),
          ...content,
        ],
      ),
    );
  }

  List<Widget> _content(int teamId, SavingsOverview overview) {
    final l10n = AppLocalizations.of(context);
    if (overview.pots.isEmpty) {
      return [
        SliverToBoxAdapter(
          child: EmptyState(
            key: const ValueKey('savings-empty'),
            icon: PhosphorIconsDuotone.piggyBank,
            title: l10n.savingsEmptyTitle,
            description: overview.canManage
                ? l10n.savingsEmptyManage
                : l10n.savingsEmptyRead,
          ),
        ),
      ];
    }
    return [
      SliverList.builder(
        itemCount: overview.pots.length,
        itemBuilder: (context, index) {
          final pot = overview.pots[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _PotTile(pot: pot, onTap: () => _openPot(teamId, pot.id)),
          );
        },
      ),
    ];
  }
}

class _PotTile extends StatelessWidget {
  const _PotTile({required this.pot, required this.onTap});

  final SavingsPotSummary pot;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final amount = formatCents(pot.amountCents);
    final pct = pot.goalPercent;
    final goal = pot.goalCents;

    return AppCard(
      key: ValueKey('savings-pot-${pot.id}'),
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: StatusColors.emerald500.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    PhosphorIconsDuotone.piggyBank,
                    size: 22,
                    color: StatusColors.emerald600,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pot.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: t.ink,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            PhosphorIconsBold.users,
                            size: 13,
                            color: t.muted,
                            semanticLabel: l10n.savingsMemberCount(
                              '${pot.memberCount}',
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              '${pot.memberCount} · '
                              '${pot.isOneOff ? l10n.savingsListOneOff(amount) : l10n.savingsListMonthly(amount, '${pot.months}')}',
                              key: ValueKey('savings-pot-${pot.id}-meta'),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 12, color: t.muted),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(PhosphorIconsBold.caretRight, size: 16, color: t.muted),
              ],
            ),
          ),
          Divider(height: 1, color: t.lineSoft),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                      child: Text(
                        formatCents(pot.savedCents),
                        key: ValueKey('savings-pot-${pot.id}-saved'),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: t.ink,
                          fontFeatures: const [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                    Text(
                      goal != null && pct != null
                          ? l10n.savingsListOfGoal(formatCents(goal), '$pct')
                          : l10n.savingsListSaved,
                      key: ValueKey('savings-pot-${pot.id}-goal'),
                      style: TextStyle(fontSize: 12, color: t.muted),
                    ),
                  ],
                ),
                if (pct != null) ...[
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: pct / 100,
                      minHeight: 8,
                      backgroundColor: t.raised,
                      color: StatusColors.emerald500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
