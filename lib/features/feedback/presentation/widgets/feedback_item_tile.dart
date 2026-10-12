import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/feedback_controller.dart';
import '../../data/models/feedback_models.dart';
import 'feedback_ui.dart';

/// Eén melding in "Mijn meldingen": icoon, tekst, status en datum, de
/// schermafbeelding en het gesprek met "Reageren".
class FeedbackItemTile extends StatelessWidget {
  const FeedbackItemTile({
    super.key,
    required this.item,
    required this.onReply,
  });

  final FeedbackItem item;

  /// Verstuurt een reactie; geeft de fout terug (of `null`).
  final Future<Object?> Function(String body) onReply;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final status = item.statusValue;
    final resolved = status == FeedbackStatus.resolved;
    final created = item.createdAtTime;
    final resolvedAt = item.resolvedAtTime;
    final image = item.image;

    return Padding(
      key: ValueKey('feedback-item-${item.id}'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: resolved
                  ? StatusColors.emerald500.withValues(alpha: 0.15)
                  : t.sunken,
            ),
            child: Icon(
              _icon(item),
              size: 16,
              color: resolved ? StatusColors.emerald600 : t.muted,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.body,
                  style: TextStyle(fontSize: 14, height: 1.4, color: t.ink),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _StatusBadge(
                      key: ValueKey('feedback-status-${item.id}'),
                      status: status,
                    ),
                    if (created != null)
                      Text(
                        formatFeedbackDate(created),
                        style: TextStyle(fontSize: 12, color: t.muted),
                      ),
                    if (resolved && resolvedAt != null)
                      Text(
                        l10n.feedbackResolvedOn(formatFeedbackDate(resolvedAt)),
                        style: TextStyle(fontSize: 12, color: t.muted),
                      ),
                  ],
                ),
                if (image != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: FeedbackImageThumb(itemId: item.id, url: image),
                  ),
                if (item.canReply) _Conversation(item: item, onReply: onReply),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static IconData _icon(FeedbackItem item) {
    if (item.statusValue == FeedbackStatus.resolved) {
      return PhosphorIconsBold.check;
    }
    return switch (item.kindValue) {
      FeedbackKind.schedule => PhosphorIconsDuotone.calendarPlus,
      FeedbackKind.idea => PhosphorIconsDuotone.lightbulb,
      _ => PhosphorIconsDuotone.bug,
    };
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({super.key, required this.status});

  final FeedbackStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final (label, background, foreground) = switch (status) {
      FeedbackStatus.received => (l10n.feedbackStatusNew, t.sunken, t.inkSoft),
      FeedbackStatus.inProgress => (
        l10n.feedbackStatusInProgress,
        StatusColors.amber500.withValues(alpha: dark ? 0.15 : 0.12),
        dark ? StatusColors.amber400 : StatusColors.amber700,
      ),
      FeedbackStatus.resolved => (
        l10n.feedbackStatusResolved,
        StatusColors.emerald500.withValues(alpha: dark ? 0.15 : 0.12),
        dark ? StatusColors.emerald400 : StatusColors.emerald700,
      ),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: foreground,
        ),
      ),
    );
  }
}

/// De meegestuurde schermafbeelding. De bytes komen via de app-dio (met het
/// bearer-token); laden = skeleton, fout = placeholder. Tik = groot.
class FeedbackImageThumb extends ConsumerWidget {
  const FeedbackImageThumb({
    super.key,
    required this.itemId,
    required this.url,
  });

  final int itemId;
  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(feedbackImageProvider(url));

    Widget placeholder() => Container(
      key: ValueKey('feedback-image-placeholder-$itemId'),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: t.sunken,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
        border: Border.all(color: t.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(PhosphorIconsDuotone.imageBroken, size: 16, color: t.muted),
          const SizedBox(width: 6),
          Text(
            l10n.feedbackImageUnavailable,
            style: TextStyle(fontSize: 12, color: t.muted),
          ),
        ],
      ),
    );

    return switch (async) {
      AsyncData(:final value) => Semantics(
        image: true,
        label: l10n.feedbackImageAlt,
        child: GestureDetector(
          key: ValueKey('feedback-image-$itemId'),
          onTap: () {
            unawaited(Haptics.light());
            unawaited(_openFull(context, value, l10n.close));
          },
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 160, maxWidth: 240),
            child: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                border: Border.all(color: t.line),
                borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
                child: Image.memory(
                  value,
                  fit: BoxFit.contain,
                  gaplessPlayback: true,
                  errorBuilder: (context, _, _) => placeholder(),
                ),
              ),
            ),
          ),
        ),
      ),
      AsyncError() => placeholder(),
      _ => Skeleton(
        key: ValueKey('feedback-image-loading-$itemId'),
        width: 120,
        height: 90,
        radius: AssistjeTokens.radiusXl,
      ),
    };
  }

  static Future<void> _openFull(
    BuildContext context,
    Uint8List bytes,
    String closeLabel,
  ) => showDialog<void>(
    context: context,
    barrierColor: Colors.black87,
    builder: (context) => Dialog.fullscreen(
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
              maxScale: 5,
              child: Center(child: Image.memory(bytes)),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: IconButton(
                key: const ValueKey('feedback-image-close'),
                tooltip: closeLabel,
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(PhosphorIconsBold.x, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

/// Het gesprek onder een melding en het veld om erop te reageren. Zonder dat
/// veld liep het dood (PWA-commentaar): je las het antwoord en kon er niets
/// mee terug.
class _Conversation extends StatefulWidget {
  const _Conversation({required this.item, required this.onReply});

  final FeedbackItem item;
  final Future<Object?> Function(String body) onReply;

  @override
  State<_Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<_Conversation> {
  final _body = TextEditingController();
  bool _replying = false;
  bool _busy = false;
  Object? _error;

  @override
  void dispose() {
    _body.dispose();
    super.dispose();
  }

  void _cancel() => setState(() {
    _body.clear();
    _replying = false;
    _error = null;
  });

  Future<void> _send() async {
    if (_busy || _body.text.trim().isEmpty) return;
    final l10n = AppLocalizations.of(context);
    FocusScope.of(context).unfocus();
    setState(() {
      _busy = true;
      _error = null;
    });
    final error = await widget.onReply(_body.text);
    if (!mounted) return;
    if (error == null) {
      setState(() {
        _busy = false;
        _replying = false;
        _body.clear();
      });
      showFeedbackSuccess(context, l10n.feedbackReplySent);
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
    final id = widget.item.id;
    final error = _error;
    final fieldError = feedbackFieldError(error, 'body');

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final message in widget.item.messages)
            Container(
              key: ValueKey('feedback-message-${message.id}'),
              margin: const EdgeInsets.only(bottom: 6),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: message.isMine
                    ? t.sunken.withValues(alpha: 0.7)
                    : t.raised,
                borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (message.isMine
                            ? l10n.feedbackYourReply
                            : l10n.feedbackAnswer)
                        .toUpperCase(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      color: t.muted,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message.body,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: t.inkSoft,
                    ),
                  ),
                ],
              ),
            ),
          if (_replying) ...[
            const SizedBox(height: 4),
            if (error != null && fieldError == null)
              FeedbackFormError(
                feedbackErrorText(l10n, error),
                key: ValueKey('feedback-reply-error-$id'),
              ),
            TextField(
              key: ValueKey('feedback-reply-body-$id'),
              controller: _body,
              enabled: !_busy,
              autofocus: true,
              minLines: 3,
              maxLines: 6,
              maxLength: 2000,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                counterText: '',
                hintText: l10n.feedbackReplyHint,
                errorText: fieldError,
                errorMaxLines: 3,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    key: ValueKey('feedback-reply-send-$id'),
                    label: l10n.feedbackReplySend,
                    expand: true,
                    loading: _busy,
                    onPressed: _busy || _body.text.trim().isEmpty
                        ? null
                        : _send,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  key: ValueKey('feedback-reply-cancel-$id'),
                  onPressed: _busy ? null : _cancel,
                  style: TextButton.styleFrom(foregroundColor: t.muted),
                  child: Text(l10n.feedbackCancel),
                ),
              ],
            ),
          ] else
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton(
                key: ValueKey('feedback-reply-$id'),
                onPressed: () {
                  unawaited(Haptics.light());
                  setState(() => _replying = true);
                },
                style: TextButton.styleFrom(
                  foregroundColor: t.muted,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 36),
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
                child: Text(l10n.feedbackReply),
              ),
            ),
        ],
      ),
    );
  }
}
