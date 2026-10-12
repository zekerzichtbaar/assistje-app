import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/money.dart';
import '../../data/models/fines_models.dart';
import 'fines_ui.dart';

/// Hoogste standaardbedrag van een boetesoort (`amount_cents` 0–100000).
const int maxFineTypeCents = 100000;

/// Hoogste lengte van de naam van een soort (`label` max. 80).
const int maxFineTypeLabelLength = 80;

/// Leest een standaardbedrag (`0`–`€ 1.000`); `null` als het geen geldig
/// bedrag is.
int? parseFineTypeCents(String input) {
  final cents = parseEuroToCents(input);
  if (cents == null || cents < 0 || cents > maxFineTypeCents) return null;
  return cents;
}

/// Een eigen boetesoort toevoegen ([type] `null`) of bewerken: naam en
/// standaardbedrag. [onSubmit] doet het verzoek en geeft de fout terug; bij
/// succes sluit de sheet met `true`.
Future<bool?> showFineTypeSheet(
  BuildContext context, {
  FineType? type,
  required Future<Object?> Function(String label, int amountCents) onSubmit,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: type == null ? l10n.finesTypesAdd : l10n.finesTypeEditTitle,
    scrollable: true,
    builder: (context) => FineTypeForm(type: type, onSubmit: onSubmit),
  );
}

class FineTypeForm extends StatefulWidget {
  const FineTypeForm({super.key, this.type, required this.onSubmit});

  final FineType? type;
  final Future<Object?> Function(String label, int amountCents) onSubmit;

  @override
  State<FineTypeForm> createState() => _FineTypeFormState();
}

class _FineTypeFormState extends State<FineTypeForm> {
  late final _label = TextEditingController(text: widget.type?.label ?? '');

  /// Nieuw: € 5,00 voorgevuld, net als de PWA.
  late final _amount = TextEditingController(
    text: centsToInput(widget.type?.defaultCents ?? 500),
  );
  bool _busy = false;
  bool _tried = false;
  Object? _error;

  @override
  void dispose() {
    _label.dispose();
    _amount.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _tried = true);
    final label = _label.text.trim();
    final cents = parseFineTypeCents(_amount.text);
    if (label.isEmpty || cents == null) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await widget.onSubmit(label, cents);
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    if (finesShowForbidden(context, error)) {
      Navigator.of(context).pop(false);
      return;
    }
    setState(() {
      _busy = false;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final labelStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: t.inkSoft,
    );
    final error = _error;
    final labelError = finesFieldError(error, 'label');
    final amountError = finesFieldError(error, 'amount_cents');

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null && labelError == null && amountError == null)
          FinesFormError(
            finesErrorText(l10n, error),
            key: const ValueKey('fine-type-form-error'),
          ),
        Text(l10n.finesTypeNameLabel, style: labelStyle),
        const SizedBox(height: 4),
        TextField(
          key: const ValueKey('fine-type-form-label'),
          controller: _label,
          autofocus: widget.type == null,
          maxLength: maxFineTypeLabelLength,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            counterText: '',
            hintText: l10n.finesTypeNameHint,
            errorText:
                labelError ??
                (_tried && _label.text.trim().isEmpty
                    ? l10n.finesNameRequired
                    : null),
          ),
        ),
        const SizedBox(height: 12),
        Text(l10n.finesFormAmount, style: labelStyle),
        const SizedBox(height: 4),
        TextField(
          key: const ValueKey('fine-type-form-amount'),
          controller: _amount,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: l10n.finesFormAmountHint,
            errorText:
                amountError ??
                (_tried && parseFineTypeCents(_amount.text) == null
                    ? l10n.finesFormAmountInvalid
                    : null),
          ),
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('fine-type-form-submit'),
          label: widget.type == null ? l10n.finesTypeAddSubmit : l10n.finesSave,
          expand: true,
          loading: _busy,
          onPressed: _busy ? null : _submit,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
