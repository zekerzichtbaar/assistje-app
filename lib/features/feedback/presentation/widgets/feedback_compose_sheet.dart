import 'dart:async';

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/feedback_image_picker.dart';
import '../../data/feedback_repository.dart';
import '../../data/models/feedback_models.dart';
import 'feedback_ui.dart';

const _fields = ['body', 'kind', 'image'];

const feedbackBodyMinLength = 3;
const feedbackBodyMaxLength = 2000;

/// Nieuwe melding maken, zoals de sheet "Wat is er?" op `Feedback/Index` in
/// de PWA. [onSubmit] doet het verzoek en geeft de fout terug; bij succes
/// sluit de sheet met `true`.
Future<bool?> showFeedbackComposeSheet(
  BuildContext context, {
  required FeedbackImagePicker picker,
  required Future<Object?> Function(FeedbackDraft draft) onSubmit,
}) {
  final l10n = AppLocalizations.of(context);
  return showAppSheet<bool>(
    context: context,
    title: l10n.feedbackSheetTitle,
    scrollable: true,
    builder: (context) =>
        FeedbackComposeForm(picker: picker, onSubmit: onSubmit),
  );
}

class FeedbackComposeForm extends StatefulWidget {
  const FeedbackComposeForm({
    super.key,
    required this.picker,
    required this.onSubmit,
  });

  final FeedbackImagePicker picker;
  final Future<Object?> Function(FeedbackDraft draft) onSubmit;

  @override
  State<FeedbackComposeForm> createState() => _FeedbackComposeFormState();
}

class _FeedbackComposeFormState extends State<FeedbackComposeForm> {
  final _body = TextEditingController();
  FeedbackKind? _kind;
  PickedFeedbackImage? _image;

  /// Fout bij het kiezen (te groot, verkeerd type): lokaal, vóór de server.
  String? _imageProblem;
  bool _busy = false;
  Object? _error;

  @override
  void dispose() {
    _body.dispose();
    super.dispose();
  }

  bool get _canSend =>
      !_busy && _body.text.trim().length >= feedbackBodyMinLength;

  Future<void> _pickImage() async {
    final l10n = AppLocalizations.of(context);
    unawaited(Haptics.light());
    PickedFeedbackImage? picked;
    try {
      picked = await widget.picker.pick();
    } on Object {
      if (mounted) setState(() => _imageProblem = l10n.feedbackImagePickError);
      return;
    }
    if (picked == null || !mounted) return;
    setState(() {
      if (!picked!.hasAllowedType) {
        _image = null;
        _imageProblem = l10n.feedbackImageWrongType;
      } else if (picked.isTooLarge) {
        _image = null;
        _imageProblem = l10n.feedbackImageTooLarge;
      } else {
        _image = picked;
        _imageProblem = null;
      }
    });
  }

  Future<void> _send() async {
    if (!_canSend) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await widget.onSubmit(
      FeedbackDraft(body: _body.text, kind: _kind, image: _image),
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final error = _error;
    final imageError = _imageProblem ?? feedbackFieldError(error, 'image');

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (error != null && !isFeedbackFieldError(error, _fields))
          FeedbackFormError(
            feedbackErrorText(l10n, error),
            key: const ValueKey('feedback-compose-error'),
          ),
        // Etiket is optioneel: de drempel moet zo laag mogelijk blijven.
        Row(
          children: [
            Expanded(
              child: _KindOption(
                key: const ValueKey('feedback-kind-issue'),
                label: l10n.feedbackKindIssue,
                icon: PhosphorIconsDuotone.bug,
                selected: _kind == FeedbackKind.issue,
                onTap: _busy ? null : () => _toggleKind(FeedbackKind.issue),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _KindOption(
                key: const ValueKey('feedback-kind-idea'),
                label: l10n.feedbackKindIdea,
                icon: PhosphorIconsDuotone.lightbulb,
                selected: _kind == FeedbackKind.idea,
                onTap: _busy ? null : () => _toggleKind(FeedbackKind.idea),
              ),
            ),
          ],
        ),
        if (feedbackFieldError(error, 'kind') case final kindError?)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              kindError,
              style: const TextStyle(fontSize: 12, color: StatusColors.red600),
            ),
          ),
        const SizedBox(height: 16),
        TextField(
          key: const ValueKey('feedback-compose-body'),
          controller: _body,
          enabled: !_busy,
          autofocus: true,
          maxLength: feedbackBodyMaxLength,
          minLines: 4,
          maxLines: 10,
          textCapitalization: TextCapitalization.sentences,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            counterText: '',
            hintText: l10n.feedbackBodyHint,
            errorText: feedbackFieldError(error, 'body'),
            errorMaxLines: 3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.feedbackContextNote,
          style: TextStyle(fontSize: 12, height: 1.4, color: t.muted),
        ),
        const SizedBox(height: 16),
        if (_image case final image?)
          _ImagePreview(
            image: image,
            onRemove: _busy
                ? null
                : () => setState(() {
                    _image = null;
                    _imageProblem = null;
                  }),
          )
        else
          OutlinedButton.icon(
            key: const ValueKey('feedback-add-image'),
            onPressed: _busy ? null : _pickImage,
            icon: const Icon(PhosphorIconsDuotone.image, size: 16),
            label: Text(l10n.feedbackAddImage),
            style: OutlinedButton.styleFrom(
              foregroundColor: t.inkSoft,
              side: BorderSide(color: t.line),
              minimumSize: const Size.fromHeight(44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
              ),
            ),
          ),
        if (imageError != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              imageError,
              key: const ValueKey('feedback-image-error'),
              style: const TextStyle(fontSize: 12, color: StatusColors.red600),
            ),
          ),
        const SizedBox(height: 16),
        PrimaryButton(
          key: const ValueKey('feedback-compose-send'),
          label: l10n.feedbackSend,
          icon: const Icon(PhosphorIconsDuotone.paperPlaneTilt, size: 16),
          expand: true,
          loading: _busy,
          onPressed: _canSend ? _send : null,
        ),
        const SizedBox(height: 8),
        TextButton(
          key: const ValueKey('feedback-compose-cancel'),
          onPressed: _busy ? null : () => Navigator.of(context).pop(false),
          style: TextButton.styleFrom(foregroundColor: t.muted),
          child: Text(l10n.feedbackCancel),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  void _toggleKind(FeedbackKind kind) {
    unawaited(Haptics.selection());
    setState(() => _kind = _kind == kind ? null : kind);
  }
}

/// Eén etiket-knop ("Er gaat iets mis" / "Ik heb een idee").
class _KindOption extends StatelessWidget {
  const _KindOption({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Semantics(
      button: true,
      selected: selected,
      child: Material(
        color: selected
            ? t.primary.withValues(alpha: 0.06)
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
          side: BorderSide(color: selected ? t.primary : t.line),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16, color: selected ? t.ink : t.inkSoft),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: selected ? t.ink : t.inkSoft,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Voorbeeld van de gekozen afbeelding met een verwijderknop.
class _ImagePreview extends StatelessWidget {
  const _ImagePreview({required this.image, required this.onRemove});

  final PickedFeedbackImage image;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return Container(
      key: const ValueKey('feedback-image-preview'),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: t.line),
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AssistjeTokens.radiusLg),
            child: Image.memory(
              image.bytes,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              gaplessPlayback: true,
              errorBuilder: (context, _, _) => Container(
                width: 56,
                height: 56,
                color: t.sunken,
                child: Icon(PhosphorIconsDuotone.image, color: t.muted),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              image.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: t.inkSoft),
            ),
          ),
          IconButton(
            key: const ValueKey('feedback-remove-image'),
            tooltip: l10n.feedbackRemoveImage,
            onPressed: onRemove,
            icon: Icon(PhosphorIconsBold.x, size: 16, color: t.muted),
          ),
        ],
      ),
    );
  }
}
