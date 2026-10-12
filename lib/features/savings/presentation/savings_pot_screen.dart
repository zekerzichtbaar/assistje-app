import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../fines/application/money.dart';
import '../application/savings_controller.dart';
import '../data/models/savings_models.dart';
import 'savings_form_screen.dart';
import 'widgets/savings_grid.dart';
import 'widgets/savings_ui.dart';
import 'widgets/settle_sheet.dart';

/// Eén pot (`Pages/Savings/Show` in de PWA): de "bankpas" met voortgang, de
/// gekoppelde activiteit, de matrix (deelnemers × maanden, of bij eenmalig
/// één vakje per persoon), afrekenen en herinneren. Alleen de
/// penningmeester (`can_manage`) tikt vakjes af, bewerkt en archiveert.
///
/// Wordt vanuit de lijst imperatief gepusht (geen eigen route).
class SavingsPotScreen extends ConsumerStatefulWidget {
  const SavingsPotScreen({
    super.key,
    required this.teamId,
    required this.potId,
    this.now,
  });

  final int teamId;
  final int potId;

  /// Voor tests: "nu" (huidige maand in de matrix).
  final DateTime? now;

  @override
  ConsumerState<SavingsPotScreen> createState() => _SavingsPotScreenState();
}

class _SavingsPotScreenState extends ConsumerState<SavingsPotScreen> {
  SavingsPotRef get _ref => (teamId: widget.teamId, potId: widget.potId);

  SavingsPotController get _controller =>
      ref.read(savingsPotControllerProvider(_ref).notifier);

  Future<void> _refresh() async {
    final error = await _controller.refresh();
    if (error != null && mounted) {
      showSavingsError(
        context,
        AppLocalizations.of(context).savingsPotLoadError,
        error,
      );
    }
  }

  Future<void> _toggle(String key, String ym) async {
    unawaited(Haptics.light());
    final error = await _controller.togglePayment(key, ym);
    if (error != null && mounted) {
      showSavingsError(
        context,
        AppLocalizations.of(context).savingsSaveFailed,
        error,
      );
    }
  }

  Future<void> _refund(SavingsParticipant p) async {
    unawaited(Haptics.light());
    final error = await _controller.setRefunded(p.key, refunded: !p.refunded);
    if (error != null && mounted) {
      showSavingsError(
        context,
        AppLocalizations.of(context).savingsSaveFailed,
        error,
      );
    }
  }

  Future<void> _remind(SavingsPot pot) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmSavings(
      context,
      title: l10n.savingsRemindConfirmTitle,
      message: pot.oneOff
          ? l10n.savingsRemindConfirmOneOff
          : l10n.savingsRemindConfirmMonthly,
      confirmLabel: l10n.savingsRemindSend,
    );
    if (!ok || !mounted) return;
    final result = await _controller.remind();
    if (!mounted) return;
    if (result.error != null) {
      showSavingsError(context, l10n.savingsRemindFailed, result.error);
    } else {
      showSavingsSuccess(context, l10n.savingsRemindSent(result.sent));
    }
  }

  Future<void> _edit() async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final controller = _controller;
    final saved = await Navigator.of(context).push(
      MaterialPageRoute<bool>(
        builder: (_) => SavingsFormScreen(
          teamId: widget.teamId,
          potId: widget.potId,
          onSubmit: controller.updatePot,
        ),
      ),
    );
    if ((saved ?? false) && mounted) {
      showSavingsSuccess(context, l10n.savingsUpdated);
    }
  }

  Future<void> _archive(SavingsPot pot) async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmSavings(
      context,
      title: l10n.savingsArchive,
      message: l10n.savingsArchiveConfirm(pot.name),
      confirmLabel: l10n.savingsArchiveAction,
      destructive: true,
    );
    if (!ok || !mounted) return;
    final error = await _controller.archive();
    if (!mounted) return;
    if (error != null) {
      showSavingsError(context, l10n.savingsArchiveFailed, error);
      return;
    }
    showSavingsSuccess(context, l10n.savingsArchived);
    Navigator.of(context).pop();
  }

  Future<void> _settle(SavingsPotDetail detail) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final controller = _controller;
    final done = await showSettleSheet(
      context,
      paidCents: detail.savedCents,
      finesEnabled: detail.finesEnabled,
      currentCostCents: detail.pot.actualCostCents,
      onSubmit: controller.settle,
    );
    if ((done ?? false) && mounted) {
      showSavingsSuccess(context, l10n.savingsSettled);
    }
  }

  Future<void> _unsettle() async {
    final l10n = AppLocalizations.of(context);
    final ok = await confirmSavings(
      context,
      title: l10n.savingsSettleUndoTitle,
      message: l10n.savingsSettleUndoMessage,
      confirmLabel: l10n.savingsSettleUndo,
      destructive: true,
    );
    if (!ok || !mounted) return;
    final error = await _controller.unsettle();
    if (!mounted) return;
    if (error != null) {
      showSavingsError(context, l10n.savingsSaveFailed, error);
    } else {
      showSavingsSuccess(context, l10n.savingsUnsettled);
    }
  }

  void _openEvent(int eventId) {
    final router = ref.read(routerProvider);
    Navigator.of(context).pop();
    unawaited(router.push('/events/$eventId'));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(savingsPotControllerProvider(_ref));
    final state = async.value;
    final detail = state?.detail;

    final Widget body;
    if (state != null && detail != null) {
      body = RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          key: const ValueKey('savings-pot'),
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 32),
          physics: const AlwaysScrollableScrollPhysics(),
          children: _content(state),
        ),
      );
    } else if (async.hasError) {
      body = ListView(
        padding: const EdgeInsets.all(12),
        children: [
          EmptyState(
            key: const ValueKey('savings-pot-error'),
            icon: PhosphorIconsDuotone.warningCircle,
            title: l10n.savingsPotLoadError,
            description: savingsLoadErrorText(l10n, async.error),
            action: PrimaryButton(
              key: const ValueKey('savings-pot-retry'),
              label: l10n.retry,
              onPressed: _refresh,
            ),
          ),
        ],
      );
    } else {
      body = const Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          key: ValueKey('savings-pot-loading'),
          children: [
            Skeleton(height: 168, radius: AssistjeTokens.radius2xl),
            SizedBox(height: 12),
            SkeletonList(count: 4),
          ],
        ),
      );
    }

    final canManage = detail?.canManage ?? false;
    return Scaffold(
      key: const ValueKey('savings-pot-screen'),
      backgroundColor: t.sunken,
      appBar: AppBar(
        backgroundColor: t.sunken,
        title: Text(
          detail?.pot.name ?? l10n.navSavings,
          key: const ValueKey('savings-pot-title'),
        ),
        actions: [
          if (canManage && detail != null) ...[
            IconButton(
              key: const ValueKey('savings-edit'),
              tooltip: l10n.savingsEdit,
              onPressed: _edit,
              icon: const Icon(PhosphorIconsRegular.pencilSimple),
            ),
            IconButton(
              key: const ValueKey('savings-archive'),
              tooltip: l10n.savingsArchive,
              onPressed: () => _archive(detail.pot),
              icon: const Icon(PhosphorIconsRegular.trash),
            ),
          ],
        ],
      ),
      body: SafeArea(top: false, child: body),
    );
  }

  List<Widget> _content(SavingsPotState state) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final detail = state.detail;
    final pot = detail.pot;
    final cancelled = pot.isCancelled;
    final event = pot.event;
    final refunds = detail.refunds;

    return [
      _BankCard(detail: detail),
      if (event != null) ...[
        const SizedBox(height: 14),
        AppCard(
          key: const ValueKey('savings-event'),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          onTap: () => _openEvent(event.id),
          child: Row(
            children: [
              Icon(
                PhosphorIconsRegular.calendarBlank,
                size: 20,
                color: t.muted,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  event.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: t.ink,
                  ),
                ),
              ),
              if (event.startsAt case final startsAt?)
                Text(
                  savingsDateLabel(startsAt),
                  style: TextStyle(fontSize: 12, color: t.muted),
                ),
            ],
          ),
        ),
      ],
      if (cancelled && refunds.isNotEmpty) ...[
        const SizedBox(height: 14),
        AppCard(
          key: const ValueKey('savings-cancelled'),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.savingsCancelledTitle,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: StatusColors.red700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                detail.refundsOpen > 0
                    ? l10n.savingsCancelledRefundsOpen(
                        '${detail.refundsOpen}',
                        '${refunds.length}',
                      )
                    : l10n.savingsCancelledAllRefunded,
                style: TextStyle(fontSize: 14, color: t.inkSoft),
              ),
            ],
          ),
        ),
      ],
      const SizedBox(height: 14),
      if (detail.participants.isEmpty)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
          child: Text(
            pot.scope == SavingsScope.event
                ? (cancelled
                      ? l10n.savingsNoParticipantsEventCancelled
                      : l10n.savingsNoParticipantsEvent)
                : (detail.canManage
                      ? l10n.savingsNoParticipantsManage
                      : l10n.savingsNoParticipants),
            key: const ValueKey('savings-no-participants'),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: t.muted),
          ),
        )
      else if (pot.oneOff)
        SavingsOneOffList(
          detail: detail,
          pending: state.pending,
          onToggle: _toggle,
          onRefund: _refund,
        )
      else
        SavingsGrid(
          detail: detail,
          pending: state.pending,
          currentYm: ymOf(widget.now ?? DateTime.now()),
          onToggle: _toggle,
        ),
      if (detail.showsSettle) ...[
        const SizedBox(height: 14),
        _SettleSection(
          detail: detail,
          onSettle: () => _settle(detail),
          onUndo: _unsettle,
        ),
      ],
      if (detail.canRemind) ...[
        const SizedBox(height: 14),
        Text(
          l10n.savingsTapHint(formatCents(pot.amountCents)),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: t.muted),
        ),
        const SizedBox(height: 10),
        PrimaryButton(
          key: const ValueKey('savings-remind'),
          label: l10n.savingsRemind,
          expand: true,
          icon: const Icon(PhosphorIconsFill.paperPlaneTilt, size: 18),
          onPressed: () => _remind(pot),
        ),
        const SizedBox(height: 6),
        Text(
          pot.oneOff
              ? l10n.savingsRemindHintOneOff
              : l10n.savingsRemindHintMonthly,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11, color: t.muted),
        ),
      ],
    ];
  }
}

/// De voortgang als bankpas in de clubkleur, met een ring.
class _BankCard extends StatelessWidget {
  const _BankCard({required this.detail});

  final SavingsPotDetail detail;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final pot = detail.pot;
    final fg = t.primaryContrast;
    final soft = fg.withValues(alpha: 0.7);
    final faint = fg.withValues(alpha: 0.6);
    final saved = detail.savedCents;
    final whole = formatCents(
      saved - saved % 100,
    ).replaceAll('€', '').replaceAll(RegExp(r',\d\d$'), '').trim();
    final frac = (saved % 100).toString().padLeft(2, '0');
    final amount = formatCents(pot.amountCents);
    final ring = detail.ringPercent;
    final periods = detail.periods;
    final event = pot.event;

    final String line;
    if (pot.oneOff) {
      final n = detail.counting.length;
      line = [
        l10n.savingsCardPerPerson(amount),
        if (n > 0) l10n.savingsCardPaidOf('${detail.countingPaid}', '$n'),
      ].join(' · ');
    } else {
      line = [
        l10n.savingsCardPerMonth(amount),
        if (detail.cellsTotal > 0)
          l10n.savingsCardPaidOf(
            '${detail.payments.length}',
            '${detail.cellsTotal}',
          ),
      ].join(' · ');
    }

    TextStyle caption() => TextStyle(
      fontSize: 9,
      fontWeight: FontWeight.w600,
      letterSpacing: 1.1,
      color: faint,
    );
    TextStyle value() => TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: fg,
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    Widget? left;
    if (pot.oneOff) {
      final startsAt = event?.startsAt;
      left = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (event != null ? l10n.savingsCardActivity : l10n.savingsCardMonth)
                .toUpperCase(),
            style: caption(),
          ),
          const SizedBox(height: 4),
          Text(
            event != null
                ? [
                    if (startsAt != null) savingsDateLabel(startsAt),
                    if (event.cancelled) l10n.savingsCancelledSuffix,
                  ].join(' · ')
                : (periods.isEmpty ? '' : savingsMonthLabel(periods.first)),
            key: const ValueKey('savings-card-when'),
            style: value(),
          ),
        ],
      );
    } else if (periods.isNotEmpty) {
      left = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.savingsCardDuration.toUpperCase(), style: caption()),
          const SizedBox(height: 4),
          Text(
            '${savingsMonthLabel(periods.first)} – '
            '${savingsMonthLabel(periods.last)}',
            key: const ValueKey('savings-card-when'),
            style: value(),
          ),
        ],
      );
    }

    final target = detail.targetCents;
    return Container(
      key: const ValueKey('savings-card'),
      constraints: const BoxConstraints(minHeight: 168),
      decoration: BoxDecoration(
        color: t.primary,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: fg.withValues(alpha: 0.2)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.alphaBlend(Colors.white.withValues(alpha: 0.18), t.primary),
            t.primary,
            Color.alphaBlend(Colors.black.withValues(alpha: 0.16), t.primary),
          ],
          stops: const [0, 0.48, 1],
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pot.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: fg,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Semantics(
                      label: formatCents(saved),
                      excludeSemantics: true,
                      child: Text.rich(
                        key: const ValueKey('savings-card-saved'),
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '€ ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: soft,
                              ),
                            ),
                            TextSpan(
                              text: whole,
                              style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w700,
                                height: 1,
                                color: fg,
                              ),
                            ),
                            TextSpan(
                              text: ',$frac',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: soft,
                              ),
                            ),
                          ],
                        ),
                        style: const TextStyle(
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      line,
                      key: const ValueKey('savings-card-line'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: soft),
                    ),
                  ],
                ),
              ),
              if (ring != null)
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 4),
                  child: SizedBox(
                    width: 84,
                    height: 84,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CircularProgressIndicator(
                          value: ring / 100,
                          strokeWidth: 7,
                          strokeCap: StrokeCap.round,
                          color: fg,
                          backgroundColor: fg.withValues(alpha: 0.25),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$ring%',
                              key: const ValueKey('savings-ring'),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: fg,
                              ),
                            ),
                            Text(
                              (pot.goalCents != null
                                      ? l10n.savingsRingGoal
                                      : l10n.savingsRingPaid)
                                  .toUpperCase(),
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1,
                                color: soft,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: left ?? const SizedBox.shrink()),
              if (target > 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      (pot.goalCents != null
                              ? l10n.savingsCardGoal
                              : l10n.savingsCardFull)
                          .toUpperCase(),
                      style: caption(),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatCents(target),
                      key: const ValueKey('savings-card-target'),
                      style: value(),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Afrekenen na afloop: de werkelijke kosten, het verschil naar de teampot.
class _SettleSection extends StatelessWidget {
  const _SettleSection({
    required this.detail,
    required this.onSettle,
    required this.onUndo,
  });

  final SavingsPotDetail detail;
  final VoidCallback onSettle;
  final VoidCallback onUndo;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final pot = detail.pot;
    final diff = detail.settleDiffCents;
    final fines = detail.finesEnabled;

    final Widget summary;
    if (diff != null) {
      summary = Text.rich(
        key: const ValueKey('savings-settle-summary'),
        TextSpan(
          children: [
            TextSpan(
              text:
                  '${l10n.savingsSettleCost(formatCents(pot.actualCostCents ?? 0))} · ',
            ),
            TextSpan(
              text: diff < 0
                  ? l10n.savingsSettleShortage(formatCents(diff.abs()))
                  : l10n.savingsSettleSurplus(formatCents(diff)),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: diff < 0 ? StatusColors.red600 : StatusColors.emerald700,
              ),
            ),
            if (fines)
              TextSpan(
                text:
                    ' ${diff < 0 ? l10n.savingsSettleFromPot : l10n.savingsSettleToPot}',
              ),
          ],
        ),
        style: TextStyle(fontSize: 12, color: t.muted),
      );
    } else {
      summary = Text(
        pot.isCancelled
            ? (fines
                  ? l10n.savingsSettleCancelledFines
                  : l10n.savingsSettleCancelledNoFines)
            : (fines
                  ? l10n.savingsSettleHintFines
                  : l10n.savingsSettleHintNoFines),
        key: const ValueKey('savings-settle-summary'),
        style: TextStyle(fontSize: 12, color: t.muted),
      );
    }

    return AppCard(
      key: const ValueKey('savings-settle'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: t.raised,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  PhosphorIconsRegular.receipt,
                  size: 18,
                  color: t.inkSoft,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.savingsSettleTitle,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: t.ink,
                      ),
                    ),
                    summary,
                  ],
                ),
              ),
            ],
          ),
          if (detail.canManage) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    key: const ValueKey('savings-settle-open'),
                    label: pot.isSettled
                        ? l10n.savingsSettleChange
                        : l10n.savingsSettleEnter,
                    expand: true,
                    onPressed: onSettle,
                  ),
                ),
                if (pot.isSettled) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: SecondaryButton(
                      key: const ValueKey('savings-settle-undo'),
                      label: l10n.savingsSettleUndo,
                      expand: true,
                      onPressed: onUndo,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
