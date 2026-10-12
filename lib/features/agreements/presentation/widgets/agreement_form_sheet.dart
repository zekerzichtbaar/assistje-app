import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/agreements_repository.dart';
import '../../data/models/agreements_models.dart';
import 'agreements_ui.dart';

const _fields = ['category', 'title', 'body'];

/// Afspraak toevoegen of (met [agreement]) wijzigen of verwijderen, zoals
/// `AgreementSheet.tsx`. [onSave]/[onDelete] doen het verzoek en geven de
/// fout terug; bij succes sluit de sheet met `true`.
Future<bool?> showAgreementFormSheet(
  BuildContext context, {
  Agreement? agreement,
  required List<AgreementCategory> categories,
  required Future<Object?> Function(AgreementDraft draft) onSave,
  Future<Object?> Function()? onDelete,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: agreement == null
        ? l10n.agreementsFormTitleNew
        : l10n.agreementsFormTitleEdit,
    scrollable: true,
    builder: (context) => AgreementForm(
      agreement: agreement,
      categories: categories,
      onSave: onSave,
      onDelete: onDelete,
    ),
  );
}

class AgreementForm extends StatefulWidget {
  const AgreementForm({
    super.key,
    this.agreement,
    required this.categories,
    required this.onSave,
    this.onDelete,
  });

  final Agreement? agreement;
  final List<AgreementCategory> categories;
  final Future<Object?> Function(AgreementDraft draft) onSave;
  final Future<Object?> Function()? onDelete;

  @override
  State<AgreementForm> createState() => _AgreementFormState();
}

class _AgreementFormState extends State<AgreementForm> {
  late String _category =
      widget.agreement?.category ??
      (widget.categories.isEmpty ? 'other' : widget.categories.first.key);
  late final _title = TextEditingController(
    text: widget.agreement?.title ?? '',
  );
  late final _body = TextEditingController(text: widget.agreement?.body ?? '');
  bool _busy = false;
  bool _tried = false;
  Object? _error;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
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
    unawaited(Haptics.error());
    setState(() {
      _busy = false;
      _error = error;
    });
  }

  Future<void> _save() async {
    setState(() => _tried = true);
    if (_title.text.trim().isEmpty) return;
    await _run(
      () => widget.onSave(
        AgreementDraft(
          category: _category,
          title: _title.text,
          body: _body.text,
        ),
      ),
    );
  }

  Future<void> _delete() async {
    final onDelete = widget.onDelete;
    final agreement = widget.agreement;
    if (onDelete == null || agreement == null) return;
    final l10n = AppLocalizations.of(context);
    if (!await confirmAgreementsDelete(
      context,
      l10n.agreementsDeleteConfirm(agreement.title),
    )) {
      return;
    }
    await _run(onDelete);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final label = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      color: t.muted,
    );
    final error = _error;
    final isEdit = widget.agreement != null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null && !isAgreementsFieldError(error, _fields))
          AgreementsFormError(
            agreementsErrorText(l10n, error),
            key: const ValueKey('agreement-form-error'),
          ),
        Text(l10n.agreementsFormCategory.toUpperCase(), style: label),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final category in widget.categories)
              AppPill(
                key: ValueKey('agreement-form-category-${category.key}'),
                label: category.label,
                selected: category.key == _category,
                onTap: _busy
                    ? null
                    : () {
                        Haptics.selection();
                        setState(() => _category = category.key);
                      },
              ),
          ],
        ),
        if (agreementsFieldError(error, 'category') case final message?)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              message,
              style: const TextStyle(fontSize: 13, color: StatusColors.red600),
            ),
          ),
        const SizedBox(height: 16),
        Text(l10n.agreementsFormTitle.toUpperCase(), style: label),
        const SizedBox(height: 4),
        TextField(
          key: const ValueKey('agreement-form-title'),
          controller: _title,
          maxLength: 120,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            counterText: '',
            hintText: l10n.agreementsFormTitleHint,
            errorText:
                agreementsFieldError(error, 'title') ??
                (_tried && _title.text.trim().isEmpty
                    ? l10n.agreementsFormTitleRequired
                    : null),
          ),
        ),
        const SizedBox(height: 12),
        Text(l10n.agreementsFormBody.toUpperCase(), style: label),
        const SizedBox(height: 4),
        TextField(
          key: const ValueKey('agreement-form-body'),
          controller: _body,
          maxLength: 2000,
          minLines: 3,
          maxLines: 6,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            counterText: '',
            hintText: l10n.agreementsFormBodyHint,
            errorText: agreementsFieldError(error, 'body'),
          ),
        ),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('agreement-form-save'),
          label: isEdit ? l10n.agreementsSave : l10n.agreementsCreate,
          expand: true,
          loading: _busy,
          onPressed: _busy ? null : _save,
        ),
        const SizedBox(height: 8),
        if (widget.onDelete != null)
          TextButton(
            key: const ValueKey('agreement-form-delete'),
            onPressed: _busy ? null : _delete,
            style: TextButton.styleFrom(foregroundColor: StatusColors.red600),
            child: Text(l10n.agreementsDelete),
          )
        else
          TextButton(
            key: const ValueKey('agreement-form-cancel'),
            onPressed: _busy ? null : () => Navigator.of(context).pop(false),
            style: TextButton.styleFrom(foregroundColor: t.muted),
            child: Text(l10n.agreementsCancel),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}
