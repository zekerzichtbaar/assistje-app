import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/router/app_routes.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/presentation/widgets/door_scaffold.dart';
import '../application/join_controller.dart';
import '../data/models/join_models.dart';
import 'widgets/join_door.dart';

/// De knop uit `JoinConfirmMail` (`/meedoen/{token}/bevestig/{login}`), zoals
/// de PWA (`Pages/Join/Confirm.tsx`): een tussenscherm, pas "Doe mee" koppelt
/// het bestaande account aan het team en logt in.
class JoinConfirmScreen extends ConsumerStatefulWidget {
  const JoinConfirmScreen({
    required this.token,
    required this.login,
    this.query = '',
    super.key,
  });

  final String token;
  final String login;

  /// De query uit de maillink (`role=player&player=12`), ongewijzigd.
  final String query;

  @override
  ConsumerState<JoinConfirmScreen> createState() => _JoinConfirmScreenState();
}

class _JoinConfirmScreenState extends ConsumerState<JoinConfirmScreen> {
  bool _busy = false;
  String? _error;

  JoinConfirmKey get _key =>
      (token: widget.token, login: widget.login, query: widget.query);

  void _goHome() => context.go(AppRoutes.home);

  Future<void> _submit(JoinConfirmation confirmation) async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref
          .read(joinFlowProvider)
          .confirm(widget.token, widget.login, confirmation);
      if (mounted) _goHome();
    } on Object catch (error) {
      if (!mounted) return;
      setState(
        () => _error =
            (error is ValidationException ? error.fieldError('login') : null) ??
            joinErrorText(l10n, error),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final confirmation = ref.watch(joinConfirmationProvider(_key));
    return KeyedSubtree(
      key: const ValueKey('join-confirm-screen'),
      child: JoinDoor(
        onClose: _goHome,
        child: switch (confirmation) {
          AsyncData(:final value) =>
            value.valid ? _confirm(l10n, value) : _expired(l10n),
          AsyncError(:final error) => JoinMessage(
            key: const ValueKey('join-invalid'),
            title: l10n.joinInvalidTitle,
            message: joinErrorText(l10n, error),
            actionLabel: isInvalidLinkError(error)
                ? l10n.joinToApp
                : l10n.joinRetry,
            onAction: isInvalidLinkError(error)
                ? _goHome
                : () => ref.invalidate(joinConfirmationProvider(_key)),
          ),
          _ => const JoinLoading(),
        },
      ),
    );
  }

  Widget _expired(AppLocalizations l10n) => JoinMessage(
    key: const ValueKey('join-confirm-expired'),
    title: l10n.joinConfirmInvalidTitle,
    message: l10n.joinConfirmInvalidSubtitle,
    secondaryLabel: l10n.joinConfirmToTeamlink,
    onSecondary: () => context.go(AppRoutes.joinLink(widget.token)),
  );

  Widget _confirm(AppLocalizations l10n, JoinConfirmation confirmation) {
    final playerName = confirmation.playerName;
    final as = confirmation.isSpectator
        ? l10n.joinConfirmAsSpectator
        : playerName != null && playerName.isNotEmpty
        ? l10n.joinConfirmAsPlayerNamed(playerName)
        : l10n.joinConfirmAsPlayer;
    return Column(
      key: const ValueKey('join-confirm-valid'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DoorHeadline(l10n.joinConfirmHello(confirmation.userName ?? '')),
        const SizedBox(height: 12),
        DoorSubtitle(l10n.joinConfirmSubtitle(confirmation.team.name, as)),
        const SizedBox(height: 28),
        if (_error != null) ...[DoorError(_error!), const SizedBox(height: 16)],
        DoorButton(
          key: const Key('join-confirm-submit'),
          label: l10n.joinSubmit,
          busy: _busy,
          onPressed: () => _submit(confirmation),
        ),
        const SizedBox(height: 20),
        DoorFootnote(l10n.joinConfirmFootnote),
      ],
    );
  }
}
