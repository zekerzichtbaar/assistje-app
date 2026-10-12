import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/messages_models.dart';
import 'messages_ui.dart';

const _fields = ['title_template', 'body_template'];

/// Eigen titel/tekst van een automatische melding, zoals het uitklapblok
/// van `AutoSettingRow` in de PWA. Leeg = standaardtekst. [onSave] doet het
/// verzoek en geeft de fout terug; bij succes sluit de sheet met `true`.
Future<bool?> showTemplateSheet(
  BuildContext context, {
  required AutoMessageSetting setting,
  required Future<Object?> Function(String title, String body) onSave,
}) => showAppSheet<bool>(
  context: context,
  title: setting.label,
  scrollable: true,
  builder: (context) => TemplateForm(setting: setting, onSave: onSave),
);

class TemplateForm extends StatefulWidget {
  const TemplateForm({super.key, required this.setting, required this.onSave});

  final AutoMessageSetting setting;
  final Future<Object?> Function(String title, String body) onSave;

  @override
  State<TemplateForm> createState() => _TemplateFormState();
}

class _TemplateFormState extends State<TemplateForm> {
  late final _title = TextEditingController(text: widget.setting.titleTemplate);
  late final _body = TextEditingController(text: widget.setting.bodyTemplate);
  final _titleFocus = FocusNode();
  final _bodyFocus = FocusNode();

  /// Het veld waar een placeholder in komt: het laatst gefocuste.
  late TextEditingController _target = _title;
  bool _busy = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _titleFocus.addListener(() {
      if (_titleFocus.hasFocus) _target = _title;
    });
    _bodyFocus.addListener(() {
      if (_bodyFocus.hasFocus) _target = _body;
    });
  }

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    _titleFocus.dispose();
    _bodyFocus.dispose();
    super.dispose();
  }

  bool get _dirty =>
      _title.text != widget.setting.titleTemplate ||
      _body.text != widget.setting.bodyTemplate;

  /// Voegt [token] in op de cursor van het actieve veld (of achteraan).
  void _insert(String token) {
    unawaited(Haptics.selection());
    final controller = _target;
    final value = controller.value;
    final selection = value.selection;
    final start = selection.isValid ? selection.start : value.text.length;
    final end = selection.isValid ? selection.end : value.text.length;
    final text = value.text.replaceRange(start, end, token);
    controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: start + token.length),
    );
    setState(() {});
  }

  void _reset() {
    _title.text = widget.setting.titleTemplate;
    _body.text = widget.setting.bodyTemplate;
    setState(() => _error = null);
  }

  Future<void> _save() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await widget.onSave(_title.text, _body.text);
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
    final tokens = widget.setting.placeholderTokens;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null && !isMessagesFieldError(error, _fields))
          MessagesFormError(
            messagesErrorText(l10n, error),
            key: const ValueKey('messages-template-error'),
          ),
        MessagesFieldLabel(l10n.messagesTemplateTitle),
        TextField(
          key: const ValueKey('messages-template-title'),
          controller: _title,
          focusNode: _titleFocus,
          enabled: !_busy,
          maxLength: 200,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            counterText: '',
            hintText: l10n.messagesTemplateDefault,
            errorText: messagesFieldError(error, 'title_template'),
          ),
        ),
        const SizedBox(height: 12),
        MessagesFieldLabel(l10n.messagesTemplateBody),
        TextField(
          key: const ValueKey('messages-template-body'),
          controller: _body,
          focusNode: _bodyFocus,
          enabled: !_busy,
          maxLength: 1000,
          minLines: 2,
          maxLines: 6,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            counterText: '',
            hintText: l10n.messagesTemplateDefault,
            errorText: messagesFieldError(error, 'body_template'),
          ),
        ),
        if (tokens.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            l10n.messagesTemplatePlaceholders,
            style: TextStyle(fontSize: 12, color: t.muted),
          ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final token in tokens)
                AppPill(
                  key: ValueKey('messages-template-token-$token'),
                  label: token,
                  onTap: _busy ? null : () => _insert(token),
                ),
            ],
          ),
        ],
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('messages-template-save'),
          label: l10n.messagesTemplateSave,
          expand: true,
          loading: _busy,
          onPressed: _busy || !_dirty ? null : _save,
        ),
        const SizedBox(height: 8),
        if (_dirty)
          TextButton(
            key: const ValueKey('messages-template-reset'),
            onPressed: _busy ? null : _reset,
            style: TextButton.styleFrom(foregroundColor: t.muted),
            child: Text(l10n.messagesTemplateReset),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}
