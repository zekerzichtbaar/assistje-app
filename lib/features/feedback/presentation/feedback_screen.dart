import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/feedback_controller.dart';
import '../data/feedback_image_picker.dart';
import '../data/models/feedback_models.dart';
import 'widgets/feedback_compose_sheet.dart';
import 'widgets/feedback_item_tile.dart';
import 'widgets/feedback_ui.dart';

/// Feedback (`Pages/Feedback/Index` in de PWA), voor elk teamlid: een
/// melding maken (bug of idee, met optionele schermafbeelding), je eigen
/// meldingen met hun status terugzien en reageren op een antwoord.
class FeedbackScreen extends ConsumerStatefulWidget {
  const FeedbackScreen({super.key});

  @override
  ConsumerState<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends ConsumerState<FeedbackScreen> {
  FeedbackController _controller(int teamId) =>
      ref.read(feedbackControllerProvider(teamId).notifier);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showFeedbackError(
        context,
        AppLocalizations.of(context).feedbackLoadError,
        error,
      );
    }
  }

  Future<void> _compose(int teamId) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final controller = _controller(teamId);
    final sent = await showFeedbackComposeSheet(
      context,
      picker: ref.read(feedbackImagePickerProvider),
      onSubmit: controller.submit,
    );
    if ((sent ?? false) && mounted) {
      showFeedbackSuccess(context, l10n.feedbackSent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(feedbackControllerProvider(teamId));
    final items = async.value;

    final Widget list;
    if (items != null) {
      list = _list(teamId, items);
    } else if (async.hasError) {
      list = EmptyState(
        key: const ValueKey('feedback-error'),
        icon: PhosphorIconsDuotone.warningCircle,
        title: l10n.feedbackLoadError,
        description: feedbackErrorText(l10n, async.error),
        action: PrimaryButton(
          key: const ValueKey('feedback-retry'),
          label: l10n.retry,
          onPressed: () => _refresh(teamId),
        ),
      );
    } else {
      list = const SkeletonList(key: ValueKey('feedback-loading'), count: 3);
    }

    return Scaffold(
      key: const ValueKey('feedback-screen'),
      backgroundColor: t.sunken,
      body: AppRefresh(
        onRefresh: () => _refresh(teamId),
        padding: EdgeInsets.fromLTRB(
          12,
          ShellInsets.top(context),
          12,
          ShellInsets.bottom(context),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
              child: Semantics(
                header: true,
                child: Text(
                  l10n.navFeedback,
                  // Zelfde key als de placeholder: de shell-tests lezen de
                  // schermtitel via `placeholder-title`.
                  key: const Key('placeholder-title'),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: t.ink,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AppCard(
              key: const ValueKey('feedback-intro-card'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    l10n.feedbackIntro,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: t.inkSoft,
                    ),
                  ),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    key: const ValueKey('feedback-create'),
                    label: l10n.feedbackCreate,
                    icon: const Icon(PhosphorIconsBold.plus, size: 16),
                    expand: true,
                    onPressed: () => _compose(teamId),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(child: list),
        ],
      ),
    );
  }

  Widget _list(int teamId, List<FeedbackItem> items) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    if (items.isEmpty) {
      return Padding(
        key: const ValueKey('feedback-empty'),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text(
          l10n.feedbackEmpty,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: t.muted),
        ),
      );
    }
    final controller = _controller(teamId);
    return AppCard(
      key: const ValueKey('feedback-list'),
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Semantics(
              header: true,
              child: Text.rich(
                TextSpan(
                  text: l10n.feedbackMine.toUpperCase(),
                  children: [
                    TextSpan(
                      text: '  ${items.length}',
                      style: TextStyle(color: t.muted.withValues(alpha: 0.7)),
                    ),
                  ],
                ),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: t.muted,
                ),
              ),
            ),
          ),
          for (final (index, item) in items.indexed) ...[
            if (index > 0) Divider(height: 1, thickness: 1, color: t.lineSoft),
            FeedbackItemTile(
              key: ValueKey('feedback-tile-${item.id}'),
              item: item,
              onReply: (body) => controller.respond(item.id, body),
            ),
          ],
        ],
      ),
    );
  }
}
