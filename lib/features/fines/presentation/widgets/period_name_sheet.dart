import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import 'fines_ui.dart';

/// Hoogste lengte van een periodenaam (`name` max. 80).
const int maxPeriodNameLength = 80;

/// Eén naamveld voor een periode: "Periode hernoemen" (met [initial]) of
/// "Nieuwe periode". [onSubmit] doet het verzoek en geeft de fout terug; bij
/// succes sluit de sheet met `true`. Een 422 blijft in de sheet staan, een
/// 403 sluit hem met een melding.
Future<bool?> showPeriodNameSheet(
  BuildContext context, {
  required String title,
  required String label,
  required String note,
  required String submitLabel,
  String initial = '',
  required Future<Object?> Function(String name) onSubmit,
}) => showAppSheet<bool>(
  context: context,
  title: title,
  scrollable: true,
  builder: (context) => PeriodNameForm(
    label: label,
    note: note,
    submitLabel: submitLabel,
    initial: initial,
    onSubmit: onSubmit,
  ),
);

class PeriodNameForm extends StatefulWidget {
  const PeriodNameForm({
    super.key,
    required this.label,
    required this.note,
    required this.submitLabel,
    this.initial = '',
    required this.onSubmit,
  });

  final String label;
  final String note;
  final String submitLabel;
  final String initial;
  final Future<Object?> Function(String name) onSubmit;

  @override
  State<PeriodNameForm> createState() => _PeriodNameFormState();
}

class _PeriodNameFormState extends State<PeriodNameForm> {
  late final _name = TextEditingController(text: widget.initial);
  bool _busy = false;
  bool _tried = false;
  Object? _error;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  String get _value => _name.text.trim();

  /// Hernoemen naar dezelfde naam heeft geen zin (PWA: knop uit).
  bool get _unchanged =>
      widget.initial.isNotEmpty && _value == widget.initial.trim();

  Future<void> _submit() async {
    setState(() => _tried = true);
    if (_value.isEmpty || _unchanged) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await widget.onSubmit(_value);
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
    final error = _error;
    final fieldError = finesFieldError(error, 'name');

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null && fieldError == null)
          FinesFormError(
            finesErrorText(l10n, error),
            key: const ValueKey('period-form-error'),
          ),
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: t.inkSoft,
          ),
        ),
        const SizedBox(height: 4),
        TextField(
          key: const ValueKey('period-form-name'),
          controller: _name,
          autofocus: true,
          maxLength: maxPeriodNameLength,
          textInputAction: TextInputAction.done,
          onChanged: (_) => setState(() {}),
          onSubmitted: (_) => _busy ? null : _submit(),
          decoration: InputDecoration(
            counterText: '',
            hintText: l10n.finesPeriodNameHint,
            errorText:
                fieldError ??
                (_tried && _value.isEmpty ? l10n.finesNameRequired : null),
          ),
        ),
        const SizedBox(height: 6),
        Text(widget.note, style: TextStyle(fontSize: 13, color: t.muted)),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('period-form-submit'),
          label: widget.submitLabel,
          expand: true,
          loading: _busy,
          onPressed: _busy || _unchanged ? null : _submit,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
