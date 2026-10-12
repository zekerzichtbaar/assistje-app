import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/presentation/widgets/door_scaffold.dart';
import '../application/join_controller.dart';
import '../data/models/join_models.dart';
import 'widgets/join_door.dart';

/// Een uitnodiging van de trainer accepteren (`/register/invite/{token}`),
/// zoals de PWA (`Auth/MagicConfirm` met de invite-actie): begroeting, en pas
/// "Doorgaan" verzilvert de uitnodiging en logt in.
class InviteScreen extends ConsumerStatefulWidget {
  const InviteScreen({required this.token, super.key});

  final String token;

  @override
  ConsumerState<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends ConsumerState<InviteScreen> {
  bool _busy = false;
  String? _error;

  /// Ongeldig gebleken bij het accepteren (`404`/`410`).
  String? _invalid;

  void _goHome() => context.go(AppRoutes.home);

  Future<void> _accept() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(joinFlowProvider).acceptInvite(widget.token);
      if (mounted) _goHome();
    } on Object catch (error) {
      if (!mounted) return;
      setState(() {
        if (isInvalidLinkError(error)) {
          _invalid = joinErrorText(l10n, error);
        } else {
          _error = joinErrorText(l10n, error);
        }
      });
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final invite = ref.watch(inviteInfoProvider(widget.token));
    return KeyedSubtree(
      key: const ValueKey('invite-screen'),
      child: JoinDoor(
        onClose: _goHome,
        child: _invalid != null
            ? _expired(l10n, _invalid!)
            : switch (invite) {
                AsyncData(:final value) =>
                  value.valid
                      ? _welcome(l10n, value)
                      : _expired(l10n, l10n.inviteInvalidFallback),
                AsyncError(:final error) when isInvalidLinkError(error) =>
                  _expired(l10n, joinErrorText(l10n, error)),
                AsyncError(:final error) => JoinMessage(
                  key: const ValueKey('invite-load-error'),
                  title: l10n.inviteInvalidTitle,
                  message: joinErrorText(l10n, error),
                  actionLabel: l10n.joinRetry,
                  onAction: () =>
                      ref.invalidate(inviteInfoProvider(widget.token)),
                ),
                _ => const JoinLoading(),
              },
      ),
    );
  }

  /// De app biedt dan het gewone inloggen met een code aan.
  Widget _expired(AppLocalizations l10n, String message) => JoinMessage(
    key: const ValueKey('invite-invalid'),
    title: l10n.inviteInvalidTitle,
    message: message,
    actionLabel: l10n.inviteToLogin,
    onAction: () => context.go(AppRoutes.login),
  );

  Widget _welcome(AppLocalizations l10n, InviteInfo invite) => Column(
    key: const ValueKey('invite-valid'),
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      DoorHeadline(
        invite.name.isEmpty
            ? l10n.inviteHelloAnonymous
            : l10n.inviteHello(invite.name),
      ),
      const SizedBox(height: 12),
      DoorSubtitle(l10n.inviteSubtitle),
      const SizedBox(height: 28),
      if (_error != null) ...[DoorError(_error!), const SizedBox(height: 16)],
      DoorButton(
        key: const Key('invite-accept'),
        label: l10n.inviteContinue,
        busy: _busy,
        onPressed: _accept,
      ),
    ],
  );
}
