import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import 'agreements_ui.dart';

/// "Introtekst": vrije tekst boven de afspraken. Leeg opslaan wist hem.
/// [onSave] doet het verzoek en geeft de fout terug; bij succes sluit de
/// sheet met `true`.
Future<bool?> showIntroSheet(
  BuildContext context, {
  String? intro,
  required Future<Object?> Function(String intro) onSave,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: l10n.agreementsIntroTitle,
    scrollable: true,
    builder: (context) => IntroForm(intro: intro, onSave: onSave),
  );
}

class IntroForm extends StatefulWidget {
  const IntroForm({super.key, this.intro, required this.onSave});

  final String? intro;
  final Future<Object?> Function(String intro) onSave;

  @override
  State<IntroForm> createState() => _IntroFormState();
}

class _IntroFormState extends State<IntroForm> {
  late final _intro = TextEditingController(text: widget.intro ?? '');
  bool _busy = false;
  Object? _error;

  @override
  void dispose() {
    _intro.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await widget.onSave(_intro.text);
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
    final fieldError = agreementsFieldError(error, 'intro');

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null && fieldError == null)
          AgreementsFormError(
            agreementsErrorText(l10n, error),
            key: const ValueKey('intro-form-error'),
          ),
        TextField(
          key: const ValueKey('intro-form-text'),
          controller: _intro,
          maxLength: 2000,
          minLines: 5,
          maxLines: 10,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            counterText: '',
            hintText: l10n.agreementsIntroHint,
            hintMaxLines: 4,
            errorText: fieldError,
          ),
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('intro-form-save'),
          label: l10n.agreementsSave,
          expand: true,
          loading: _busy,
          onPressed: _busy ? null : _save,
        ),
        const SizedBox(height: 8),
        TextButton(
          key: const ValueKey('intro-form-cancel'),
          onPressed: _busy ? null : () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(foregroundColor: t.muted),
          child: Text(l10n.agreementsCancel),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
