import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/auth/auth_controller.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../auth/presentation/widgets/door_scaffold.dart';
import '../../../join/presentation/widgets/join_door.dart';
import '../../application/signup_controller.dart';
import '../../data/models/signup_models.dart';
import 'signup_widgets.dart';

/// "Check je mail" (PWA `Signup/Sent.tsx`): de omgeving staat er, de
/// inloglink ligt in de mailbox. Uitgelogd biedt de app daarnaast een
/// inlogcode aan (`POST /auth/request` met de teamslug → codescherm).
class SignupSentView extends ConsumerStatefulWidget {
  const SignupSentView({required this.sent, super.key});

  final SignupSent sent;

  @override
  ConsumerState<SignupSentView> createState() => _SignupSentViewState();
}

class _SignupSentViewState extends ConsumerState<SignupSentView> {
  bool _busy = false;
  String? _error;

  Future<void> _codeLogin() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(signupFlowProvider).requestLoginCode(widget.sent);
      if (!mounted) return;
      context.goNamed(
        AppRoutes.loginCodeName,
        queryParameters: {'email': widget.sent.email},
      );
    } on Object catch (error) {
      if (mounted) setState(() => _error = signupErrorText(l10n, error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final sent = widget.sent;
    final signedIn = ref.watch(authControllerProvider) == AuthStatus.signedIn;
    final address = sent.team.url.replaceFirst(RegExp('^https?://'), '');
    return Column(
      key: const ValueKey('signup-sent'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SignupHeading(
          title: sent.already
              ? l10n.signupSentAlreadyTitle(sent.team.name)
              : l10n.signupSentTitle(sent.team.name),
          subtitle: sent.already
              ? l10n.signupSentAlreadySubtitle
              : l10n.signupSentSubtitle,
        ),
        DoorPanel(
          key: const Key('signup-sent-email'),
          child: Text(sent.email, textAlign: TextAlign.center),
        ),
        if (address.isNotEmpty) ...[
          const SizedBox(height: 12),
          DoorPanel(
            key: const Key('signup-sent-address'),
            child: Column(
              children: [
                Text(
                  l10n.signupSentAddressLabel,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0x990C120D),
                  ),
                ),
                const SizedBox(height: 2),
                SelectableText(address, textAlign: TextAlign.center),
              ],
            ),
          ),
        ],
        const SizedBox(height: 20),
        if (_error != null) ...[DoorError(_error!), const SizedBox(height: 16)],
        if (!signedIn && sent.email.isNotEmpty)
          DoorButton(
            key: const Key('signup-code-login'),
            label: l10n.signupSentCodeLogin,
            busy: _busy,
            onPressed: _codeLogin,
          )
        else
          DoorButton(
            key: const Key('signup-to-app'),
            label: l10n.signupToApp,
            onPressed: () => context.go(AppRoutes.home),
          ),
        const SizedBox(height: 20),
        DoorFootnote(l10n.signupSentFootnote),
      ],
    );
  }
}

/// "We hebben het" (PWA `Signup/Requested.tsx`): een aanvraag voor een
/// sport die de app niet kent; er is geen omgeving gemaakt.
class SignupRequestedView extends StatelessWidget {
  const SignupRequestedView({
    required this.requested,
    required this.onClose,
    super.key,
  });

  final SignupRequested requested;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      key: const ValueKey('signup-requested'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SignupHeading(
          title: l10n.signupRequestedTitle,
          subtitle: l10n.signupRequestedSubtitle(requested.sport),
        ),
        DoorPanel(
          key: const Key('signup-requested-email'),
          child: Text(requested.email, textAlign: TextAlign.center),
        ),
        const SizedBox(height: 20),
        DoorFootnote(l10n.signupRequestedFootnote),
        const SizedBox(height: 12),
        DoorLinkButton(
          key: const Key('signup-requested-close'),
          label: l10n.signupToApp,
          onPressed: onClose,
        ),
      ],
    );
  }
}
