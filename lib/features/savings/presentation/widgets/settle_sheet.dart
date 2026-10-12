import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../fines/application/money.dart';
import 'savings_ui.dart';

/// Hoogste werkelijke kosten (zelfde grens als een bedrag: 100000 euro).
const int maxSettleCents = 10000000;

/// "Afrekenen": de werkelijke kosten invullen; toont het verschil met wat er
/// betaald is. [onSubmit] doet het verzoek en geeft de fout terug; bij
/// succes sluit de sheet met `true`.
Future<bool?> showSettleSheet(
  BuildContext context, {
  required int paidCents,
  required bool finesEnabled,
  int? currentCostCents,
  required Future<Object?> Function(int costCents) onSubmit,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: l10n.savingsSettleTitle,
    scrollable: true,
    builder: (context) => SettleForm(
      paidCents: paidCents,
      finesEnabled: finesEnabled,
      currentCostCents: currentCostCents,
      onSubmit: onSubmit,
    ),
  );
}

class SettleForm extends StatefulWidget {
  const SettleForm({
    super.key,
    required this.paidCents,
    required this.finesEnabled,
    required this.onSubmit,
    this.currentCostCents,
  });

  final int paidCents;
  final bool finesEnabled;
  final int? currentCostCents;
  final Future<Object?> Function(int costCents) onSubmit;

  @override
  State<SettleForm> createState() => _SettleFormState();
}

class _SettleFormState extends State<SettleForm> {
  late final _cost = TextEditingController(
    text: widget.currentCostCents == null
        ? ''
        : centsToInput(widget.currentCostCents!),
  );
  bool _busy = false;
  bool _tried = false;
  Object? _error;

  @override
  void dispose() {
    _cost.dispose();
    super.dispose();
  }

  int? get _costCents {
    final cents = parseEuroToCents(_cost.text);
    if (cents == null || cents < 0 || cents > maxSettleCents) return null;
    return cents;
  }

  Future<void> _submit() async {
    setState(() => _tried = true);
    final cost = _costCents;
    if (cost == null) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await widget.onSubmit(cost);
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    unawaited(Haptics.error());
    setState(() {
      _busy = false;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final error = _error;
    final cost = _costCents;
    final diff = cost == null ? null : widget.paidCents - cost;
    final formMessage = savingsFormMessage(l10n, error);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (formMessage != null)
          SavingsFormError(
            formMessage,
            key: const ValueKey('savings-settle-error'),
          ),
        Text(
          l10n.savingsSettlePaid(formatCents(widget.paidCents)),
          key: const ValueKey('savings-settle-paid'),
          style: TextStyle(fontSize: 14, color: t.muted),
        ),
        const SizedBox(height: 12),
        Text(
          l10n.savingsSettleCostLabel,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: t.inkSoft,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          key: const ValueKey('savings-settle-cost'),
          controller: _cost,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: '0,00',
            errorText:
                savingsFieldError(error, 'actual_cost') ??
                (_tried && cost == null ? l10n.savingsSettleCostInvalid : null),
          ),
        ),
        if (diff != null) ...[
          const SizedBox(height: 10),
          Text(
            [
              diff < 0
                  ? l10n.savingsSettleDiffShortage(formatCents(diff.abs()))
                  : l10n.savingsSettleDiffSurplus(formatCents(diff)),
              if (widget.finesEnabled)
                diff < 0
                    ? l10n.savingsSettleDiffFromPot
                    : l10n.savingsSettleDiffToPot,
            ].join('. '),
            key: const ValueKey('savings-settle-diff'),
            style: TextStyle(fontSize: 14, color: t.inkSoft),
          ),
        ],
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('savings-settle-submit'),
          label: l10n.savingsSettleSubmit,
          expand: true,
          loading: _busy,
          onPressed: _busy ? null : _submit,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
