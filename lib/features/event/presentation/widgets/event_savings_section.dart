import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/event_detail_models.dart';
import 'event_section_card.dart';

/// `€ 10` of `€ 2,50` (als `savingsEuros` in de PWA: centen alleen als ze er
/// zijn).
String eventEuros(int cents) {
  final euros = cents ~/ 100;
  final rest = cents.abs() % 100;
  return rest == 0 ? '€ $euros' : '€ $euros,${rest.toString().padLeft(2, '0')}';
}

/// De inleg bij een activiteit (`SavingsSection` in de PWA): bedrag p.p.,
/// wie er betaald heeft en de weg naar de pot. Zonder pot krijgt alleen de
/// penningmeester ([canStart]) een ingang. Een pot zonder bedrag is een
/// afvinklijst: geen geld, "afgevinkt" in plaats van "betaald".
class EventSavingsSection extends StatelessWidget {
  const EventSavingsSection({
    super.key,
    required this.pot,
    required this.canStart,
    required this.cancelled,
    required this.onOpen,
    required this.onStart,
  });

  final EventSavingsPot? pot;
  final bool canStart;
  final bool cancelled;
  final ValueChanged<int> onOpen;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final pot = this.pot;

    if (pot == null) {
      if (!canStart) return const SizedBox.shrink();
      return EventSectionCard(
        key: const ValueKey('event-savings'),
        title: l10n.eventSavingsTitle,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(
                l10n.eventSavingsIntro,
                style: TextStyle(fontSize: 14, color: t.inkSoft),
              ),
              SecondaryButton(
                key: const ValueKey('event-savings-start'),
                label: l10n.eventSavingsStart,
                icon: const Icon(PhosphorIconsDuotone.piggyBank),
                onPressed: onStart,
              ),
            ],
          ),
        ),
      );
    }

    final dark = Theme.of(context).brightness == Brightness.dark;
    final String? mine;
    if (pot.iRefunded) {
      mine = l10n.eventSavingsRefunded;
    } else if (pot.iRefund) {
      mine = cancelled
          ? l10n.eventSavingsRefundCancelled
          : l10n.eventSavingsRefund;
    } else if (pot.iPaid == true) {
      mine = pot.withoutAmount
          ? l10n.eventSavingsIChecked
          : l10n.eventSavingsIPaid;
    } else if (pot.iPaid == false) {
      mine = pot.withoutAmount
          ? l10n.eventSavingsNotChecked
          : l10n.eventSavingsNotPaid;
    } else {
      mine = null;
    }

    final noMoney = pot.withoutAmount;
    final amount = eventEuros(pot.amountCents);
    final headline = noMoney
        ? pot.name
        : pot.oneOff
        ? l10n.eventSavingsAmount(amount, pot.name)
        : l10n.eventSavingsAmountMonthly(amount, pot.name);
    final status = noMoney
        ? l10n.eventSavingsChecked(pot.paidCount, pot.participantCount)
        : pot.oneOff && pot.openCents > 0
        ? l10n.eventSavingsPaidOpen(
            pot.paidCount,
            pot.participantCount,
            eventEuros(pot.openCents),
          )
        : l10n.eventSavingsPaid(pot.paidCount, pot.participantCount);

    return EventSectionCard(
      key: const ValueKey('event-savings'),
      title: noMoney ? l10n.eventSavingsChecklistTitle : l10n.eventSavingsTitle,
      child: InkWell(
        key: const ValueKey('event-savings-pot'),
        onTap: () => onOpen(pot.id),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: dark
                      ? StatusColors.emerald500.withValues(alpha: 0.1)
                      : StatusColors.emerald50,
                ),
                child: Icon(
                  noMoney
                      ? PhosphorIconsDuotone.checkSquare
                      : PhosphorIconsDuotone.piggyBank,
                  size: 22,
                  color: dark
                      ? StatusColors.emerald400
                      : StatusColors.emerald700,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      headline,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: t.ink,
                      ),
                    ),
                    if (cancelled)
                      Text(
                        noMoney
                            ? l10n.eventSavingsCancelledChecklist
                            : l10n.eventSavingsCancelled,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: dark
                              ? const Color(0xFFFCA5A5)
                              : StatusColors.red700,
                        ),
                      )
                    else
                      Text(
                        status,
                        style: TextStyle(fontSize: 14, color: t.muted),
                      ),
                    if (mine != null)
                      Text(
                        mine,
                        style: TextStyle(
                          fontSize: 14,
                          color: pot.iRefund
                              ? (dark
                                    ? StatusColors.amber300
                                    : StatusColors.amber700)
                              : t.inkSoft,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(PhosphorIconsBold.caretRight, size: 16, color: t.muted),
            ],
          ),
        ),
      ),
    );
  }
}
