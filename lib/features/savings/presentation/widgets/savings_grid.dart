import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../fines/application/money.dart';
import '../../data/models/savings_models.dart';
import 'savings_ui.dart';

const double _nameWidth = 150;
const double _cellWidth = 52;
const double _totalWidth = 92;
const double _rowHeight = 44;
const double _headerHeight = 36;

/// Eén vakje: groen met vinkje als betaald, anders leeg. Alleen tikbaar
/// voor de penningmeester; tijdens een verzoek een spinnertje.
class SavingsCell extends StatelessWidget {
  const SavingsCell({
    super.key,
    required this.paid,
    required this.pending,
    required this.semanticLabel,
    this.onTap,
    this.size = 30,
  });

  final bool paid;
  final bool pending;
  final String semanticLabel;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Semantics(
      button: onTap != null,
      checked: paid,
      label: semanticLabel,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: pending ? null : onTap,
        child: SizedBox(
          width: size + 12,
          height: size + 12,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: paid ? StatusColors.emerald500 : t.sunken,
                borderRadius: BorderRadius.circular(size * 0.3),
              ),
              child: pending
                  ? Padding(
                      padding: EdgeInsets.all(size * 0.25),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: paid ? Colors.white : t.muted,
                      ),
                    )
                  : paid
                  ? Icon(
                      PhosphorIconsBold.check,
                      size: size * 0.55,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

/// Naam met rugnummer en "staf"-label.
class _ParticipantName extends StatelessWidget {
  const _ParticipantName({required this.participant});

  final SavingsParticipant participant;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final p = participant;
    return Row(
      children: [
        if (p.shirtNumber != null)
          SizedBox(
            width: 20,
            child: Text(
              '${p.shirtNumber}',
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 12, color: t.muted),
            ),
          ),
        if (p.shirtNumber != null) const SizedBox(width: 6),
        Flexible(
          child: Text(
            p.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: t.ink,
            ),
          ),
        ),
        if (p.isStaff) SavingsStaffBadge(raised: t.raised, color: t.muted),
      ],
    );
  }
}

/// De maandmatrix: deelnemers (vaste kolom) × maanden (horizontaal scrollend)
/// + totaal per rij, met maandtotalen eronder. Scrolt bij openen naar de
/// huidige maand.
class SavingsGrid extends StatefulWidget {
  const SavingsGrid({
    super.key,
    required this.detail,
    required this.pending,
    required this.currentYm,
    required this.onToggle,
  });

  final SavingsPotDetail detail;
  final Set<String> pending;
  final String currentYm;
  final void Function(String key, String ym) onToggle;

  @override
  State<SavingsGrid> createState() => _SavingsGridState();
}

class _SavingsGridState extends State<SavingsGrid> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final index = widget.detail.periods.indexOf(widget.currentYm);
      if (index <= 0 || !_scroll.hasClients) return;
      final max = _scroll.position.maxScrollExtent;
      final offset = index * _cellWidth;
      _scroll.jumpTo(offset > max ? max : offset);
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final detail = widget.detail;
    final periods = detail.periods;
    final paid = detail.paid;
    final canManage = detail.canManage;

    final headStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: t.muted,
    );
    final footStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: t.inkSoft,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
    Widget divider() => Container(height: 1, color: t.lineSoft);

    final names = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: _headerHeight,
          color: t.raised,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.centerLeft,
          child: Text(
            l10n.savingsGridParticipant.toUpperCase(),
            style: headStyle.copyWith(letterSpacing: 0.6),
          ),
        ),
        for (final p in detail.participants) ...[
          Container(
            height: _rowHeight,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            child: _ParticipantName(participant: p),
          ),
          divider(),
        ],
        Container(
          height: _headerHeight,
          color: t.raised,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.centerLeft,
          child: Text(
            l10n.savingsGridPerMonth.toUpperCase(),
            style: headStyle.copyWith(letterSpacing: 0.6),
          ),
        ),
      ],
    );

    final cells = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: _headerHeight,
          color: t.raised,
          child: Row(
            children: [
              for (final ym in periods)
                SizedBox(
                  width: _cellWidth,
                  child: Text(
                    savingsMonthLabel(ym),
                    key: ValueKey('savings-month-$ym'),
                    textAlign: TextAlign.center,
                    style: headStyle.copyWith(
                      color: ym == widget.currentYm ? t.primary : t.muted,
                    ),
                  ),
                ),
              SizedBox(
                width: _totalWidth,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    l10n.savingsGridTotal.toUpperCase(),
                    textAlign: TextAlign.right,
                    style: headStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
        for (final p in detail.participants) ...[
          SizedBox(
            height: _rowHeight,
            child: Row(
              children: [
                for (final ym in periods)
                  SizedBox(
                    width: _cellWidth,
                    child: SavingsCell(
                      key: ValueKey('savings-cell-${p.key}-$ym'),
                      paid: paid.containsKey(cellKey(p.key, ym)),
                      pending: widget.pending.contains(cellKey(p.key, ym)),
                      size: 28,
                      semanticLabel: paid.containsKey(cellKey(p.key, ym))
                          ? l10n.savingsCellPaid(p.name, savingsMonthLabel(ym))
                          : l10n.savingsCellUnpaid(
                              p.name,
                              savingsMonthLabel(ym),
                            ),
                      onTap: canManage
                          ? () => widget.onToggle(p.key, ym)
                          : null,
                    ),
                  ),
                SizedBox(
                  width: _totalWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      formatCents(detail.rowCents(p.key)),
                      key: ValueKey('savings-row-total-${p.key}'),
                      textAlign: TextAlign.right,
                      style: footStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: periods.length * _cellWidth + _totalWidth,
            child: divider(),
          ),
        ],
        Container(
          height: _headerHeight,
          color: t.raised,
          child: Row(
            children: [
              for (final ym in periods)
                SizedBox(
                  width: _cellWidth,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        formatCents(detail.columnCents(ym)),
                        key: ValueKey('savings-col-total-$ym'),
                        style: footStyle.copyWith(fontSize: 11),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                width: _totalWidth,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    formatCents(detail.savedCents),
                    key: const ValueKey('savings-grid-total'),
                    textAlign: TextAlign.right,
                    style: footStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return AppCard(
      key: const ValueKey('savings-grid'),
      padding: EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AssistjeTokens.radius2xl),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: _nameWidth, child: names),
            Container(
              width: 1,
              height:
                  _headerHeight * 2 +
                  detail.participants.length * (_rowHeight + 1),
              color: t.lineSoft,
            ),
            Expanded(
              child: SingleChildScrollView(
                key: const ValueKey('savings-grid-scroll'),
                controller: _scroll,
                scrollDirection: Axis.horizontal,
                child: cells,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Eenmalige inleg: één vakje per persoon. Wie na betalen afmeldde staat er
/// nog voor het terugbetalen (geen vakje maar "Terugbetaald").
class SavingsOneOffList extends StatelessWidget {
  const SavingsOneOffList({
    super.key,
    required this.detail,
    required this.pending,
    required this.onToggle,
    required this.onRefund,
  });

  final SavingsPotDetail detail;
  final Set<String> pending;
  final void Function(String key, String ym) onToggle;
  final void Function(SavingsParticipant participant) onRefund;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final ym = detail.oneOffYm;
    final canManage = detail.canManage;
    final cancelled = detail.pot.isCancelled;

    String refundLabel(SavingsParticipant p) {
      if (p.refunded) return l10n.savingsRefunded;
      return switch (p.refundReason) {
        SavingsRefundReason.absent => l10n.savingsRefundAbsent,
        SavingsRefundReason.left => l10n.savingsRefundLeft,
        SavingsRefundReason.cancelled => l10n.savingsRefundCancelled,
        _ => l10n.savingsRefundOther,
      };
    }

    return AppCard(
      key: const ValueKey('savings-oneoff'),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (index, p) in detail.participants.indexed) ...[
            if (index > 0) Divider(height: 1, color: t.lineSoft),
            Padding(
              key: ValueKey('savings-oneoff-${p.key}'),
              padding: const EdgeInsets.fromLTRB(12, 4, 8, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ParticipantName(participant: p),
                        if (p.refund)
                          Padding(
                            padding: EdgeInsets.only(
                              top: 2,
                              left: p.shirtNumber == null ? 0 : 26,
                            ),
                            child: Text(
                              refundLabel(p),
                              key: ValueKey('savings-refund-label-${p.key}'),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: p.refunded
                                    ? t.muted
                                    : StatusColors.amber700,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (p.refund)
                    canManage
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: p.refunded
                                ? SecondaryButton(
                                    key: ValueKey('savings-refund-${p.key}'),
                                    label: l10n.savingsRefundUndo,
                                    loading: pending.contains(
                                      'refund|${p.key}',
                                    ),
                                    onPressed: () => onRefund(p),
                                  )
                                : AppButtonBase(
                                    key: ValueKey('savings-refund-${p.key}'),
                                    label: l10n.savingsMarkRefunded,
                                    background: StatusColors.amber200,
                                    foreground: StatusColors.amber800,
                                    loading: pending.contains(
                                      'refund|${p.key}',
                                    ),
                                    onPressed: () => onRefund(p),
                                  ),
                          )
                        : const SizedBox(height: 44)
                  else if (ym != null)
                    SavingsCell(
                      key: ValueKey('savings-cell-${p.key}-$ym'),
                      paid: detail.isPaid(p.key, ym),
                      pending: pending.contains(cellKey(p.key, ym)),
                      size: 36,
                      semanticLabel: detail.isPaid(p.key, ym)
                          ? l10n.savingsCellPaid(p.name, savingsMonthLabel(ym))
                          : l10n.savingsCellUnpaid(
                              p.name,
                              savingsMonthLabel(ym),
                            ),
                      onTap: canManage ? () => onToggle(p.key, ym) : null,
                    ),
                ],
              ),
            ),
          ],
          if (!cancelled)
            Container(
              color: t.raised,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Text(
                l10n.savingsOneOffFooter(
                  '${detail.countingPaid}',
                  '${detail.counting.length}',
                  formatCents(detail.openCents),
                ),
                key: const ValueKey('savings-oneoff-footer'),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: t.inkSoft,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
