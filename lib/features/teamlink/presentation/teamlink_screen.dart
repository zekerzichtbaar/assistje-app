import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/session/session_providers.dart';
import '../../../core/shell/shell_insets.dart';
import '../../../core/theme/assistje_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../player_management/application/share_service.dart';
import '../../player_management/application/teamlink_controller.dart';
import '../../player_management/data/models/player_management_models.dart';
import '../../player_management/presentation/widgets/pm_ui.dart';
import 'widgets/teamlink_qr_sheet.dart';

/// De teamlink (`Trainer/TeamLink.tsx`): de link uit de groepsapp waarmee
/// het team zichzelf aanmeldt. Kopiëren, delen, QR voor de kleedkamer, een
/// verse link maken of intrekken, en wie er via de link binnenkwam.
class TeamlinkScreen extends ConsumerStatefulWidget {
  const TeamlinkScreen({super.key});

  @override
  ConsumerState<TeamlinkScreen> createState() => _TeamlinkScreenState();
}

class _TeamlinkScreenState extends ConsumerState<TeamlinkScreen> {
  bool _busy = false;

  AppLocalizations get _l10n => AppLocalizations.of(context);

  TeamLinkController _controller(int teamId) =>
      ref.read(teamLinkControllerProvider(teamId).notifier);

  Future<void> _refresh(int teamId) async {
    final error = await _controller(teamId).refresh();
    if (error != null && mounted) {
      showPmError(context, _l10n.pmTlLoadError, error);
    }
  }

  Future<void> _write(
    Future<Object?> Function() action, {
    required String success,
  }) async {
    if (_busy) return;
    final l10n = _l10n;
    setState(() => _busy = true);
    final error = await action();
    if (!mounted) return;
    setState(() => _busy = false);
    if (error != null) {
      showPmError(context, l10n.pmActionFailed, error);
    } else {
      showPmSuccess(context, success);
    }
  }

  Future<void> _create(int teamId) =>
      _write(() => _controller(teamId).create(), success: _l10n.pmTlCreated);

  Future<void> _rotate(int teamId) async {
    final l10n = _l10n;
    if (!await confirmPm(
      context,
      title: l10n.pmTlRotateTitle,
      message: l10n.pmTlRotateMessage,
      confirmLabel: l10n.pmTlRotateConfirm,
    )) {
      return;
    }
    await _write(() => _controller(teamId).create(), success: l10n.pmTlCreated);
  }

  Future<void> _revoke(int teamId) async {
    final l10n = _l10n;
    if (!await confirmPm(
      context,
      title: l10n.pmTlRevokeTitle,
      message: l10n.pmTlRevokeMessage,
      confirmLabel: l10n.pmTlRevokeConfirm,
      destructive: true,
    )) {
      return;
    }
    await _write(() => _controller(teamId).revoke(), success: l10n.pmTlRevoked);
  }

  Future<void> _copy(String message) async {
    final l10n = _l10n;
    await ref.read(shareServiceProvider).copy(message);
    if (!mounted) return;
    showPmSuccess(context, l10n.pmTlCopied, message: l10n.pmTlCopiedMessage);
  }

  Future<void> _share(String message, String teamName) async {
    unawaited(Haptics.light());
    final box = context.findRenderObject() as RenderBox?;
    final origin = box == null || !box.hasSize
        ? null
        : box.localToGlobal(Offset.zero) & box.size;
    try {
      await ref
          .read(shareServiceProvider)
          .share(
            message,
            subject: _l10n.pmTlInviteSubject(teamName),
            origin: origin,
          );
    } on Object catch (error) {
      if (mounted) showPmError(context, _l10n.pmActionFailed, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final membership = ref.watch(currentMembershipProvider);
    if (membership == null) return const SizedBox.shrink();
    final teamId = membership.team.id;
    final t = AssistjeTokens.of(context);
    final l10n = _l10n;
    final async = ref.watch(teamLinkControllerProvider(teamId));
    final overview = async.value;
    final readOnly = membership.team.isDemo;

    final List<Widget> children;
    if (overview != null) {
      children = _content(
        teamId,
        membership.team.name,
        overview,
        readOnly: readOnly,
      );
    } else if (async.hasError) {
      children = [_errorState(teamId, async.error)];
    } else {
      children = const [
        Skeleton(
          key: ValueKey('tl-loading'),
          height: 220,
          radius: AssistjeTokens.radius2xl,
        ),
        Skeleton(height: 120, radius: AssistjeTokens.radius2xl),
      ];
    }

    return Scaffold(
      key: const ValueKey('teamlink-screen'),
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
                  l10n.screenTeamlink,
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
          SliverList.separated(
            itemCount: children.length,
            itemBuilder: (context, index) => children[index],
            separatorBuilder: (context, index) => const SizedBox(height: 12),
          ),
        ],
      ),
    );
  }

  Widget _errorState(int teamId, Object? error) {
    final l10n = _l10n;
    return switch (error) {
      ForbiddenException() => EmptyState(
        key: const ValueKey('tl-forbidden'),
        icon: PhosphorIconsDuotone.lockSimple,
        title: l10n.pmForbiddenTitle,
        description: l10n.pmForbidden,
      ),
      _ => EmptyState(
        key: const ValueKey('tl-error'),
        icon: PhosphorIconsDuotone.warningCircle,
        title: l10n.pmTlLoadError,
        description: pmErrorText(l10n, error),
        action: PrimaryButton(
          key: const ValueKey('tl-retry'),
          label: l10n.retry,
          onPressed: () => _refresh(teamId),
        ),
      ),
    };
  }

  List<Widget> _content(
    int teamId,
    String teamName,
    TeamLinkOverview overview, {
    required bool readOnly,
  }) {
    final l10n = _l10n;
    final t = AssistjeTokens.of(context);
    final link = overview.link;
    final dayMonth = DateFormat('d MMMM', 'nl');

    final Widget linkCard;
    if (link == null) {
      final revoked = overview.linkState == TeamLinkState.revoked;
      linkCard = AppCard(
        key: ValueKey('tl-${revoked ? 'revoked' : 'expired'}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PhosphorIcon(
                  revoked
                      ? PhosphorIconsDuotone.prohibit
                      : PhosphorIconsDuotone.clock,
                  size: 20,
                  color: t.muted,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        revoked ? l10n.pmTlRevokedTitle : l10n.pmTlExpiredTitle,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: t.ink,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        revoked
                            ? l10n.pmTlRevokedBody
                            : l10n.pmTlExpiredBody('${overview.expiresDays}'),
                        style: TextStyle(fontSize: 14, color: t.muted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (!readOnly) ...[
              const SizedBox(height: 14),
              SecondaryButton(
                key: const ValueKey('tl-create'),
                label: l10n.pmTlCreate,
                expand: true,
                loading: _busy,
                icon: const PhosphorIcon(
                  PhosphorIconsBold.linkSimple,
                  size: 18,
                ),
                onPressed: _busy ? null : () => _create(teamId),
              ),
            ],
          ],
        ),
      );
    } else {
      final message = l10n.pmTlInviteMessage(teamName, link.url);
      linkCard = AppCard(
        key: const ValueKey('tl-active'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.pmTlIntro,
              style: TextStyle(fontSize: 14, color: t.muted),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: t.raised,
                borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
              ),
              child: SelectableText(
                link.url,
                key: const ValueKey('tl-url'),
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'monospace',
                  color: t.ink,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    key: const ValueKey('tl-copy'),
                    label: l10n.pmTlCopy,
                    expand: true,
                    icon: const PhosphorIcon(PhosphorIconsBold.copy, size: 18),
                    onPressed: () => _copy(message),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: PrimaryButton(
                    key: const ValueKey('tl-share'),
                    label: l10n.pmTlShare,
                    expand: true,
                    icon: const PhosphorIcon(
                      PhosphorIconsBold.shareNetwork,
                      size: 18,
                    ),
                    onPressed: () => _share(message, teamName),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SecondaryButton(
              key: const ValueKey('tl-show-qr'),
              label: l10n.pmTlShowQr,
              expand: true,
              icon: const PhosphorIcon(PhosphorIconsBold.qrCode, size: 18),
              onPressed: () => showTeamLinkQrSheet(
                context,
                url: link.url,
                teamName: teamName,
              ),
            ),
            if (link.expiresAt != null) ...[
              const SizedBox(height: 14),
              Text(
                l10n.pmTlExpires(
                  dayMonth.format(link.expiresAt!.toLocal()),
                  '${overview.expiresDays}',
                ),
                key: const ValueKey('tl-expires'),
                style: TextStyle(fontSize: 12, color: t.muted),
              ),
            ],
            if (!readOnly) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  TextButton.icon(
                    key: const ValueKey('tl-rotate'),
                    onPressed: _busy ? null : () => _rotate(teamId),
                    icon: const PhosphorIcon(
                      PhosphorIconsBold.arrowsClockwise,
                      size: 16,
                    ),
                    label: Text(l10n.pmTlRotate),
                  ),
                  TextButton.icon(
                    key: const ValueKey('tl-revoke'),
                    onPressed: _busy ? null : () => _revoke(teamId),
                    icon: const PhosphorIcon(
                      PhosphorIconsBold.prohibit,
                      size: 16,
                    ),
                    label: Text(l10n.pmTlRevoke),
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    }

    return [
      if (readOnly)
        PmNotice(
          key: const ValueKey('tl-read-only'),
          icon: PhosphorIconsDuotone.eye,
          text: l10n.pmReadOnlyDemo,
        ),
      linkCard,
      AppCard(
        key: const ValueKey('tl-joined'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.pmTlJoinedTitle,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: t.ink,
              ),
            ),
            const SizedBox(height: 8),
            if (overview.joined.isEmpty)
              Text(
                l10n.pmTlJoinedEmpty,
                style: TextStyle(fontSize: 14, color: t.muted),
              )
            else
              for (var i = 0; i < overview.joined.length; i++) ...[
                if (i > 0) Divider(height: 1, color: t.lineSoft),
                _JoinedRow(person: overview.joined[i], format: dayMonth),
              ],
          ],
        ),
      ),
      if (overview.joined.isEmpty)
        Text(
          l10n.pmTlJoinedHint,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: t.muted),
        ),
    ];
  }
}

class _JoinedRow extends StatelessWidget {
  const _JoinedRow({required this.person, required this.format});

  final TeamLinkJoin person;
  final DateFormat format;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final role = person.isSpectator
        ? l10n.pmTlRoleSpectator
        : l10n.pmTlRolePlayer;
    final when = person.joinedAt == null
        ? ''
        : ' · ${format.format(person.joinedAt!.toLocal())}';
    return Padding(
      key: ValueKey('tl-joined-${person.id}'),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          AppAvatar(name: person.name, imageUrl: person.avatarUrl, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              person.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: t.ink,
              ),
            ),
          ),
          Text('$role$when', style: TextStyle(fontSize: 12, color: t.muted)),
        ],
      ),
    );
  }
}
