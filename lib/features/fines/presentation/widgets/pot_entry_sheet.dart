import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/money.dart';
import '../../data/fines_repository.dart';
import '../../data/models/fines_models.dart';
import 'fines_ui.dart';

/// Hoogste bedrag van een potboeking (`amount_cents` ±10000000).
const int maxPotCents = 10000000;

/// "Potboeking": geld erin of eruit, bedrag, omschrijving en datum.
/// Met [entry] is het bewerken (plus verwijderen). [onSave]/[onDelete] doen
/// het verzoek en geven de fout terug; bij succes sluit de sheet met `true`.
Future<bool?> showPotEntrySheet(
  BuildContext context, {
  PotLine? entry,
  required Future<Object?> Function(PotEntryDraft draft) onSave,
  Future<Object?> Function()? onDelete,
  DateTime? today,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: entry == null
        ? l10n.finesPotFormTitleNew
        : l10n.finesPotFormTitleEdit,
    scrollable: true,
    builder: (context) => PotEntryForm(
      entry: entry,
      onSave: onSave,
      onDelete: onDelete,
      today: today,
    ),
  );
}

class PotEntryForm extends StatefulWidget {
  const PotEntryForm({
    super.key,
    this.entry,
    required this.onSave,
    this.onDelete,
    this.today,
  });

  final PotLine? entry;
  final Future<Object?> Function(PotEntryDraft draft) onSave;
  final Future<Object?> Function()? onDelete;
  final DateTime? today;

  @override
  State<PotEntryForm> createState() => _PotEntryFormState();
}

class _PotEntryFormState extends State<PotEntryForm> {
  late bool _out = (widget.entry?.amountCents ?? 0) < 0;
  late final _amount = TextEditingController(
    text: widget.entry == null
        ? ''
        : centsToInput(widget.entry!.amountCents.abs()),
  );
  late final _description = TextEditingController(
    text: widget.entry?.description ?? '',
  );
  late DateTime _date =
      widget.entry?.occurredOn ?? widget.today ?? DateTime.now();
  bool _busy = false;
  bool _tried = false;
  Object? _error;

  @override
  void dispose() {
    _amount.dispose();
    _description.dispose();
    super.dispose();
  }

  /// Altijd positief ingevuld; [_out] bepaalt het teken.
  int? get _cents {
    final cents = parseEuroToCents(_amount.text);
    if (cents == null || cents <= 0 || cents > maxPotCents) return null;
    return _out ? -cents : cents;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && mounted) setState(() => _date = picked);
  }

  Future<void> _run(Future<Object?> Function() request) async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await request();
    if (!mounted) return;
    if (error == null) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _busy = false;
      _error = error;
    });
  }

  Future<void> _save() async {
    setState(() => _tried = true);
    final cents = _cents;
    final description = _description.text.trim();
    if (cents == null || description.isEmpty) return;
    await _run(
      () => widget.onSave(
        PotEntryDraft(
          amountCents: cents,
          description: description,
          occurredOn: _date,
        ),
      ),
    );
  }

  Future<void> _delete() async {
    final onDelete = widget.onDelete;
    if (onDelete == null) return;
    final l10n = AppLocalizations.of(context);
    if (!await confirmFinesDelete(context, l10n.finesDeleteEntryConfirm)) {
      return;
    }
    await _run(onDelete);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final label = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: t.inkSoft,
    );
    final error = _error;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null)
          FinesFormError(
            finesErrorText(l10n, error),
            key: const ValueKey('pot-form-error'),
          ),
        AppTabPills<bool>(
          key: const ValueKey('pot-form-direction'),
          fullWidth: true,
          selected: _out,
          onChanged: (out) {
            Haptics.selection();
            setState(() => _out = out);
          },
          tabs: [
            AppTabPill(value: false, label: l10n.finesPotIn),
            AppTabPill(value: true, label: l10n.finesPotOut),
          ],
        ),
        const SizedBox(height: 16),
        Text(l10n.finesFormAmount, style: label),
        const SizedBox(height: 4),
        TextField(
          key: const ValueKey('pot-form-amount'),
          controller: _amount,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: l10n.finesFormAmountHint,
            errorText:
                finesFieldError(error, 'amount_cents') ??
                (_tried && _cents == null ? l10n.finesPotAmountInvalid : null),
          ),
        ),
        const SizedBox(height: 12),
        Text(l10n.finesPotDescription, style: label),
        const SizedBox(height: 4),
        TextField(
          key: const ValueKey('pot-form-description'),
          controller: _description,
          maxLength: 255,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            counterText: '',
            errorText:
                finesFieldError(error, 'description') ??
                (_tried && _description.text.trim().isEmpty
                    ? l10n.finesPotDescriptionRequired
                    : null),
          ),
        ),
        const SizedBox(height: 12),
        Text(l10n.finesPotDate, style: label),
        const SizedBox(height: 4),
        AppCard(
          key: const ValueKey('pot-form-date'),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          color: t.raised,
          radius: AssistjeTokens.radiusXl,
          onTap: _busy ? null : _pickDate,
          child: Text(
            finesDate(_date),
            style: TextStyle(fontSize: 15, color: t.ink),
          ),
        ),
        if (finesFieldError(error, 'occurred_on') case final dateError?)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              dateError,
              style: const TextStyle(fontSize: 13, color: StatusColors.red600),
            ),
          ),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('pot-form-save'),
          label: l10n.finesSave,
          expand: true,
          loading: _busy,
          onPressed: _busy ? null : _save,
        ),
        if (widget.onDelete != null) ...[
          const SizedBox(height: 8),
          SecondaryButton(
            key: const ValueKey('pot-form-delete'),
            label: l10n.finesDelete,
            expand: true,
            onPressed: _busy ? null : _delete,
          ),
        ],
        const SizedBox(height: 8),
      ],
    );
  }
}
