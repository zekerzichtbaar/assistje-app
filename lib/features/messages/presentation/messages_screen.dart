import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/deep_links/deep_link_mapper.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/messages_controller.dart';
import '../data/models/messages_models.dart';
import 'widgets/compose_sheet.dart';
import 'widgets/messages_ui.dart';
import 'widgets/template_sheet.dart';

/// Berichten (`Pages/Trainer/Messages/Index` in de PWA), alleen voor de
/// trainer: een push-bericht aan het team sturen, de automatische meldingen
/// aan/uit zetten (en hun tekst aanpassen) en terugkijken wat er verstuurd is.
class MessagesScreen extends ConsumerStatefulWidget {
  const MessagesScreen({super.key});

  @override
  ConsumerState<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends ConsumerState<MessagesScreen> {
  /// Automatische meldingen waarvan de aan/uit-wijziging nog loopt.
  final Set<String> _pending = {};

  MessagesController _controller(int teamId) =>
      ref.read(messagesControllerProvider(teamId).notifier);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showMessagesError(
        context,
        AppLocalizations.of(context).messagesLoadError,
        error,
      );
    }
  }

  Future<void> _compose(int teamId, MessagesOverview overview) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final controller = _controller(teamId);
    final sent = await showComposeSheet(
      context,
      linkTargets: overview.linkTargets,
      onSend: controller.send,
    );
    if ((sent ?? false) && mounted) {
      final latest = ref
          .read(messagesControllerProvider(teamId))
          .value
          ?.messages
          .firstOrNull;
      showMessagesSuccess(
        context,
        l10n.messagesSent,
        body: latest == null
            ? null
            : l10n.messagesSentTo(latest.recipientsCount),
      );
    }
  }

  Future<void> _toggle(int teamId, AutoMessageSetting setting) async {
    if (_pending.contains(setting.key)) return;
    unawaited(Haptics.selection());
    final l10n = AppLocalizations.of(context);
    setState(() => _pending.add(setting.key));
    final error = await _controller(
      teamId,
    ).setEnabled(setting.key, enabled: !setting.enabled);
    if (!mounted) return;
    setState(() => _pending.remove(setting.key));
    if (error != null) {
      showMessagesError(context, l10n.messagesToggleError, error);
    }
  }

  Future<void> _editTemplate(int teamId, AutoMessageSetting setting) async {
    unawaited(Haptics.light());
    final l10n = AppLocalizations.of(context);
    final controller = _controller(teamId);
    final saved = await showTemplateSheet(
      context,
      setting: setting,
      onSave: (title, body) =>
          controller.saveTemplates(setting.key, title: title, body: body),
    );
    if ((saved ?? false) && mounted) {
      showMessagesSuccess(context, l10n.messagesTemplateSaved);
    }
  }

  void _openLink(String url) {
    final target = DeepLinkMapper.map(Uri.parse(url));
    if (target is OpenRoute) {
      unawaited(Haptics.light());
      unawaited(context.push(target.location));
    }
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final async = ref.watch(messagesControllerProvider(teamId));
    final overview = async.value;

    final List<Widget> content;
    if (overview != null) {
      content = _content(teamId, overview);
    } else if (async.hasError) {
      content = [SliverToBoxAdapter(child: _errorState(teamId, async.error))];
    } else {
      content = const [
        SliverToBoxAdapter(
          child: Column(
            key: ValueKey('messages-loading'),
            children: [
              Skeleton(height: 120, radius: AssistjeTokens.radius2xl),
              SizedBox(height: 12),
              SkeletonList(count: 4),
            ],
          ),
        ),
      ];
    }

    return Scaffold(
      key: const ValueKey('messages-screen'),
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
                  l10n.navMessages,
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
          ...content,
        ],
      ),
    );
  }

  Widget _errorState(int teamId, Object? error) {
    final l10n = AppLocalizations.of(context);
    return switch (error) {
      ForbiddenException() => EmptyState(
        key: const ValueKey('messages-forbidden'),
        icon: PhosphorIconsDuotone.lockSimple,
        title: l10n.messagesForbiddenTitle,
        description: l10n.messagesForbiddenBody,
      ),
      NotFoundException() => EmptyState(
        key: const ValueKey('messages-not-found'),
        icon: PhosphorIconsDuotone.megaphoneSimple,
        title: l10n.messagesNotFoundTitle,
        description: l10n.messagesNotFoundBody,
        action: PrimaryButton(
          key: const ValueKey('messages-retry'),
          label: l10n.retry,
          onPressed: () => _refresh(teamId),
        ),
      ),
      _ => EmptyState(
        key: const ValueKey('messages-error'),
        icon: PhosphorIconsDuotone.warningCircle,
        title: l10n.messagesLoadError,
        description: messagesErrorText(l10n, error),
        action: PrimaryButton(
          key: const ValueKey('messages-retry'),
          label: l10n.retry,
          onPressed: () => _refresh(teamId),
        ),
      ),
    };
  }

  List<Widget> _content(int teamId, MessagesOverview overview) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    const gap = SliverToBoxAdapter(child: SizedBox(height: 12));
    final note = TextStyle(fontSize: 13, height: 1.4, color: t.muted);

    return [
      SliverToBoxAdapter(
        child: MessagesSection(
          key: const ValueKey('messages-compose-card'),
          title: l10n.messagesComposeCardTitle,
          icon: PhosphorIconsDuotone.megaphone,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.messagesComposeIntro, style: note),
              const SizedBox(height: 14),
              PrimaryButton(
                key: const ValueKey('messages-compose'),
                label: l10n.messagesComposeOpen,
                icon: const Icon(PhosphorIconsDuotone.paperPlaneTilt, size: 16),
                expand: true,
                onPressed: () => _compose(teamId, overview),
              ),
            ],
          ),
        ),
      ),
      gap,
      SliverToBoxAdapter(
        child: MessagesSection(
          key: const ValueKey('messages-auto-card'),
          title: l10n.messagesAutoTitle,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.messagesAutoIntro, style: note),
              const SizedBox(height: 12),
              if (overview.autoSettings.isEmpty)
                Text(l10n.messagesAutoEmpty, style: note)
              else
                for (final setting in overview.autoSettings)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _AutoSettingRow(
                      setting: setting,
                      pending: _pending.contains(setting.key),
                      onToggle: () => _toggle(teamId, setting),
                      onEdit: setting.templated
                          ? () => _editTemplate(teamId, setting)
                          : null,
                    ),
                  ),
            ],
          ),
        ),
      ),
      gap,
      SliverToBoxAdapter(
        child: MessagesSection(
          key: const ValueKey('messages-history-card'),
          title: l10n.messagesHistoryTitle,
          child: overview.messages.isEmpty
              ? _EmptyLine(
                  l10n.messagesHistoryEmpty,
                  key: const ValueKey('messages-history-empty'),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final message in overview.messages)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _MessageRow(
                          message: message,
                          linkLabel: overview.linkLabel(message.link),
                          onOpen: message.link == null
                              ? null
                              : () => _openLink(message.link!),
                        ),
                      ),
                  ],
                ),
        ),
      ),
      gap,
      SliverToBoxAdapter(
        child: MessagesSection(
          key: const ValueKey('messages-auto-history-card'),
          title: l10n.messagesAutoHistoryTitle,
          child: overview.autoHistory.isEmpty
              ? _EmptyLine(
                  l10n.messagesAutoHistoryEmpty,
                  key: const ValueKey('messages-auto-history-empty'),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final (index, entry) in overview.autoHistory.indexed)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: _AutoHistoryRow(
                          key: ValueKey('messages-auto-history-$index'),
                          entry: entry,
                        ),
                      ),
                  ],
                ),
        ),
      ),
    ];
  }
}

class _EmptyLine extends StatelessWidget {
  const _EmptyLine(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 14, color: AssistjeTokens.of(context).muted),
    ),
  );
}

/// Eén automatische melding: naam (tik = tekst aanpassen) en een schakelaar.
class _AutoSettingRow extends StatelessWidget {
  const _AutoSettingRow({
    required this.setting,
    required this.pending,
    required this.onToggle,
    this.onEdit,
  });

  final AutoMessageSetting setting;
  final bool pending;
  final VoidCallback onToggle;
  final VoidCallback? onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final onEdit = this.onEdit;
    return Material(
      color: t.raised,
      borderRadius: BorderRadius.circular(AssistjeTokens.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: ValueKey('messages-setting-${setting.key}'),
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 6, 8, 6),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      setting.label,
                      style: TextStyle(fontSize: 14, color: t.ink),
                    ),
                    if (onEdit != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Row(
                          children: [
                            Icon(
                              PhosphorIconsBold.pencilSimple,
                              size: 11,
                              color: t.muted,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                setting.isCustomized
                                    ? l10n.messagesAutoCustom
                                    : l10n.messagesAutoEdit,
                                style: TextStyle(fontSize: 12, color: t.muted),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Semantics(
                label: setting.label,
                child: Switch.adaptive(
                  key: ValueKey('messages-toggle-${setting.key}'),
                  value: setting.enabled,
                  activeTrackColor: StatusColors.emerald500,
                  onChanged: pending ? null : (_) => onToggle(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Eén handmatig verstuurd bericht.
class _MessageRow extends StatelessWidget {
  const _MessageRow({required this.message, this.linkLabel, this.onOpen});

  final TeamMessage message;
  final String? linkLabel;
  final VoidCallback? onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final sentAt = message.sentAtTime;
    final link = message.link;
    final meta = [
      if (message.senderName case final name? when name.trim().isNotEmpty)
        l10n.messagesBy(name),
      l10n.messagesRecipients(message.recipientsCount),
    ].join(' · ');

    return Material(
      color: t.raised,
      borderRadius: BorderRadius.circular(AssistjeTokens.radiusLg),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        key: ValueKey('messages-message-${message.id}'),
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      message.title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: t.ink,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    sentAt == null
                        ? l10n.messagesSending
                        : formatMessageTime(sentAt),
                    style: TextStyle(fontSize: 12, color: t.muted),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                message.body,
                style: TextStyle(fontSize: 14, height: 1.4, color: t.inkSoft),
              ),
              const SizedBox(height: 4),
              Text(meta, style: TextStyle(fontSize: 12, color: t.muted)),
              if (link != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIconsBold.arrowRight,
                        size: 11,
                        color: onOpen == null ? t.muted : t.primary,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          linkLabel ?? link,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: onOpen == null ? t.muted : t.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Eén automatische verzendronde.
class _AutoHistoryRow extends StatelessWidget {
  const _AutoHistoryRow({super.key, required this.entry});

  final AutoHistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final sentAt = entry.sentAtTime;
    final title = entry.title;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: t.raised,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: t.sunken,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      entry.label,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: t.inkSoft,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                [
                  if (sentAt != null) formatMessageTime(sentAt),
                  l10n.messagesAutoHistoryCount(entry.recipientsCount),
                ].join(' · '),
                style: TextStyle(fontSize: 12, color: t.muted),
              ),
            ],
          ),
          if (title != null && title.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(title, style: TextStyle(fontSize: 14, color: t.ink)),
            ),
        ],
      ),
    );
  }
}
