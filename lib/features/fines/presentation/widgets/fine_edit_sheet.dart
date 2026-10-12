import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/money.dart';
import '../../data/models/fines_models.dart';
import 'fine_form_sheet.dart' show maxFineCents;
import 'fines_ui.dart';

/// Wijzigingen aan een boete.
class FineEdit {
  const FineEdit({
    required this.amountCents,
    required this.description,
    required this.status,
  });

  final int amountCents;

  /// `null` = omschrijving wissen.
  final String? description;
  final FineStatus status;
}

/// "Boete bewerken": bedrag, omschrijving, status en verwijderen (met
/// bevestiging). [onSave]/[onDelete] doen het verzoek en geven de fout
/// terug; bij succes sluit de sheet met `true`.
Future<bool?> showFineEditSheet(
  BuildContext context, {
  required Fine fine,
  required Future<Object?> Function(FineEdit edit) onSave,
  required Future<Object?> Function() onDelete,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: l10n.finesEditTitle,
    scrollable: true,
    builder: (context) =>
        FineEditForm(fine: fine, onSave: onSave, onDelete: onDelete),
  );
}

class FineEditForm extends StatefulWidget {
  const FineEditForm({
    super.key,
    required this.fine,
    required this.onSave,
    required this.onDelete,
  });

  final Fine fine;
  final Future<Object?> Function(FineEdit edit) onSave;
  final Future<Object?> Function() onDelete;

  @override
  State<FineEditForm> createState() => _FineEditFormState();
}

class _FineEditFormState extends State<FineEditForm> {
  late final _amount = TextEditingController(
    text: centsToInput(widget.fine.amountCents),
  );
  late final _description = TextEditingController(
    text: widget.fine.description ?? '',
  );
  late FineStatus _status = widget.fine.status == FineStatus.unknown
      ? FineStatus.open
      : widget.fine.status;
  bool _busy = false;
  bool _tried = false;
  Object? _error;

  @override
  void dispose() {
    _amount.dispose();
    _description.dispose();
    super.dispose();
  }

  int? get _cents {
    final cents = parseEuroToCents(_amount.text);
    if (cents == null || cents < 0 || cents > maxFineCents) return null;
    return cents;
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
    if (cents == null) return;
    final description = _description.text.trim();
    await _run(
      () => widget.onSave(
        FineEdit(
          amountCents: cents,
          description: description.isEmpty ? null : description,
          status: _status,
        ),
      ),
    );
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context);
    if (!await confirmFinesDelete(context, l10n.finesDeleteFineConfirm)) {
      return;
    }
    await _run(widget.onDelete);
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
            key: const ValueKey('fine-edit-error'),
          ),
        Text(
          widget.fine.typeLabel,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: t.ink,
          ),
        ),
        const SizedBox(height: 16),
        Text(l10n.finesEditStatus, style: label),
        const SizedBox(height: 8),
        // Pills die meeschalen (lange labels, grote tekst) in plaats van
        // een vaste segmentbaan.
        Wrap(
          key: const ValueKey('fine-edit-status'),
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final status in const [
              FineStatus.open,
              FineStatus.paid,
              FineStatus.waived,
            ])
              AppPill(
                key: ValueKey('fine-status-${status.name}'),
                label: fineStatusLabel(l10n, status),
                selected: _status == status,
                onTap: () {
                  Haptics.selection();
                  setState(() => _status = status);
                },
              ),
          ],
        ),
        const SizedBox(height: 16),
        Text(l10n.finesFormAmount, style: label),
        const SizedBox(height: 4),
        TextField(
          key: const ValueKey('fine-edit-amount'),
          controller: _amount,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: l10n.finesFormAmountHint,
            errorText:
                finesFieldError(error, 'amount_cents') ??
                (_tried && _cents == null ? l10n.finesFormAmountInvalid : null),
          ),
        ),
        const SizedBox(height: 12),
        Text(l10n.finesFormDescription, style: label),
        const SizedBox(height: 4),
        TextField(
          key: const ValueKey('fine-edit-description'),
          controller: _description,
          maxLength: 255,
          decoration: InputDecoration(
            counterText: '',
            errorText: finesFieldError(error, 'description'),
          ),
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('fine-edit-save'),
          label: l10n.finesSave,
          expand: true,
          loading: _busy,
          onPressed: _busy ? null : _save,
        ),
        const SizedBox(height: 8),
        SecondaryButton(
          key: const ValueKey('fine-edit-delete'),
          label: l10n.finesDelete,
          expand: true,
          onPressed: _busy ? null : _delete,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
