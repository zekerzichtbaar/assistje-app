import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/messages_repository.dart';
import '../../data/models/messages_models.dart';
import 'messages_ui.dart';

const _fields = ['title', 'body', 'url'];

/// Waarde in de keuzelijst voor "ik typ zelf een link" (zoals `OWN_LINK` in
/// de PWA); het dubbele-punt-voorvoegsel botst nooit met een echt pad.
const _ownLink = '::own';
const _noLink = '';

const titleMaxLength = 120;
const bodyMaxLength = 1000;

/// Nieuw bericht schrijven en (na bevestiging) versturen, zoals het formulier
/// op `Trainer/Messages/Index` in de PWA. [onSend] doet het verzoek en geeft
/// de fout terug; bij succes sluit de sheet met `true`. Met
/// [spectatorsCount] > 0 staat er een schakelaar "Ook naar toeschouwers"
/// (standaard uit).
Future<bool?> showComposeSheet(
  BuildContext context, {
  required List<LinkTargetGroup> linkTargets,
  required Future<Object?> Function(MessageDraft draft) onSend,
  int spectatorsCount = 0,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: l10n.messagesComposeSheetTitle,
    scrollable: true,
    builder: (context) => ComposeMessageForm(
      linkTargets: linkTargets,
      spectatorsCount: spectatorsCount,
      onSend: onSend,
    ),
  );
}

class ComposeMessageForm extends StatefulWidget {
  const ComposeMessageForm({
    super.key,
    required this.linkTargets,
    required this.onSend,
    this.spectatorsCount = 0,
  });

  final List<LinkTargetGroup> linkTargets;
  final int spectatorsCount;
  final Future<Object?> Function(MessageDraft draft) onSend;

  @override
  State<ComposeMessageForm> createState() => _ComposeMessageFormState();
}

class _ComposeMessageFormState extends State<ComposeMessageForm> {
  final _title = TextEditingController();
  final _body = TextEditingController();
  final _ownUrl = TextEditingController();
  String _choice = _noLink;
  bool _includeSpectators = false;
  bool _busy = false;
  bool _tried = false;
  Object? _error;

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    _ownUrl.dispose();
    super.dispose();
  }

  String? get _url => switch (_choice) {
    _noLink => null,
    _ownLink => _ownUrl.text,
    final value => value,
  };

  /// Alleen aan te zetten als het team toeschouwers heeft.
  bool get _withSpectators => _includeSpectators && widget.spectatorsCount > 0;

  Future<bool> _confirm() async {
    final l10n = AppLocalizations.of(context);
    return showConfirmDialog(
      context,
      message: _withSpectators
          ? l10n.messagesSendConfirmWithSpectators
          : l10n.messagesSendConfirm,
      confirmLabel: l10n.messagesSendConfirmOk,
      cancelLabel: l10n.messagesCancel,
      cancelKey: const ValueKey('messages-confirm-cancel'),
      confirmKey: const ValueKey('messages-confirm-send'),
    );
  }

  Future<void> _send() async {
    setState(() => _tried = true);
    if (_title.text.trim().isEmpty || _body.text.trim().isEmpty) return;
    FocusScope.of(context).unfocus();
    if (!await _confirm() || !mounted) return;

    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await widget.onSend(
      MessageDraft(
        title: _title.text,
        body: _body.text,
        url: _url,
        includeSpectators: _withSpectators,
      ),
    );
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

  List<DropdownMenuItem<String>> _linkItems(AssistjeTokens t) {
    final l10n = AppLocalizations.of(context);
    Widget label(String text, {bool header = false}) => Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: header
          ? TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: t.muted,
            )
          : null,
    );
    final seen = <String>{_noLink, _ownLink};
    return [
      DropdownMenuItem(value: _noLink, child: label(l10n.messagesLinkNone)),
      for (final (index, group) in widget.linkTargets.indexed) ...[
        DropdownMenuItem(
          value: '::group-$index',
          enabled: false,
          child: label(group.label.toUpperCase(), header: true),
        ),
        for (final option in group.options)
          if (seen.add(option.value))
            DropdownMenuItem(
              value: option.value,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: label(option.label),
              ),
            ),
      ],
      DropdownMenuItem(value: _ownLink, child: label(l10n.messagesLinkOwn)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final error = _error;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null && !isMessagesFieldError(error, _fields))
          MessagesFormError(
            messagesErrorText(l10n, error),
            key: const ValueKey('messages-compose-error'),
          ),
        MessagesFieldLabel(l10n.messagesFieldTitle),
        TextField(
          key: const ValueKey('messages-compose-title'),
          controller: _title,
          enabled: !_busy,
          maxLength: titleMaxLength,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            counterText: '',
            hintText: l10n.messagesFieldTitleHint,
            errorText:
                messagesFieldError(error, 'title') ??
                (_tried && _title.text.trim().isEmpty
                    ? l10n.messagesFieldTitleRequired
                    : null),
          ),
        ),
        const SizedBox(height: 12),
        MessagesFieldLabel(l10n.messagesFieldBody),
        TextField(
          key: const ValueKey('messages-compose-body'),
          controller: _body,
          enabled: !_busy,
          maxLength: bodyMaxLength,
          minLines: 3,
          maxLines: 8,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            counterText: l10n.messagesBodyCounter(_body.text.length),
            hintText: l10n.messagesFieldBodyHint,
            errorText:
                messagesFieldError(error, 'body') ??
                (_tried && _body.text.trim().isEmpty
                    ? l10n.messagesFieldBodyRequired
                    : null),
          ),
        ),
        const SizedBox(height: 12),
        MessagesFieldLabel(l10n.messagesFieldLink),
        DropdownButtonFormField<String>(
          key: const ValueKey('messages-compose-link'),
          initialValue: _choice,
          isExpanded: true,
          items: _linkItems(t),
          onChanged: _busy
              ? null
              : (value) => setState(() => _choice = value ?? _noLink),
          decoration: InputDecoration(
            errorText: _choice == _ownLink
                ? null
                : messagesFieldError(error, 'url'),
          ),
        ),
        if (_choice == _ownLink) ...[
          const SizedBox(height: 8),
          TextField(
            key: const ValueKey('messages-compose-own-url'),
            controller: _ownUrl,
            enabled: !_busy,
            maxLength: 255,
            keyboardType: TextInputType.url,
            autocorrect: false,
            decoration: InputDecoration(
              counterText: '',
              hintText: l10n.messagesLinkOwnHint,
              errorText: messagesFieldError(error, 'url'),
            ),
          ),
        ],
        if (widget.spectatorsCount > 0) ...[
          const SizedBox(height: 12),
          _SpectatorsSwitch(
            count: widget.spectatorsCount,
            value: _includeSpectators,
            onChanged: _busy
                ? null
                : (value) => setState(() => _includeSpectators = value),
          ),
        ],
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('messages-compose-send'),
          label: _withSpectators
              ? l10n.messagesSendWithSpectators
              : l10n.messagesSend,
          icon: const Icon(PhosphorIconsDuotone.paperPlaneTilt, size: 16),
          expand: true,
          loading: _busy,
          onPressed: _busy ? null : _send,
        ),
        const SizedBox(height: 8),
        TextButton(
          key: const ValueKey('messages-compose-cancel'),
          onPressed: _busy ? null : () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(foregroundColor: t.muted),
          child: Text(l10n.messagesCancel),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

/// "Ook naar toeschouwers" met het aantal eronder; de hele rij is tikbaar.
class _SpectatorsSwitch extends StatelessWidget {
  const _SpectatorsSwitch({
    required this.count,
    required this.value,
    required this.onChanged,
  });

  final int count;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final onChanged = this.onChanged;
    return MergeSemantics(
      child: InkWell(
        onTap: onChanged == null ? null : () => onChanged(!value),
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusLg),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.messagesIncludeSpectators,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: t.inkSoft,
                      ),
                    ),
                    Text(
                      l10n.messagesSpectatorsCount(count),
                      style: TextStyle(fontSize: 12, color: t.muted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Switch.adaptive(
                key: const ValueKey('messages-compose-spectators'),
                value: value,
                onChanged: onChanged == null
                    ? null
                    : (v) {
                        unawaited(Haptics.selection());
                        onChanged(v);
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
