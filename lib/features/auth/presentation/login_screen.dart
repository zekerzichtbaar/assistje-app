import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/auth_controller.dart';
import '../../../core/router/app_routes.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../join/presentation/widgets/join_door.dart';
import 'auth_error_text.dart';
import 'widgets/door_scaffold.dart';

final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

/// Stap 1: e-mailadres → inlogmail met code.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final email = _email.text.trim();
    if (!_emailPattern.hasMatch(email)) {
      setState(() => _error = l10n.loginEmailInvalid);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(authControllerProvider.notifier).requestCode(email);
      if (!mounted) return;
      context.goNamed(
        AppRoutes.loginCodeName,
        queryParameters: {'email': email},
      );
    } on Object catch (error) {
      if (!mounted) return;
      setState(() => _error = requestErrorText(l10n, error));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DoorScaffold(
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DoorHeadline(l10n.loginHeadline),
            const SizedBox(height: 12),
            Text(
              l10n.loginIntro,
              style: const TextStyle(fontSize: 16, color: DoorColors.ink),
            ),
            const SizedBox(height: 28),
            TextField(
              key: const Key('login-email'),
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              autocorrect: false,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _submit(),
              style: const TextStyle(fontSize: 17, color: DoorColors.ink),
              decoration: doorInputDecoration(
                label: l10n.loginEmailLabel,
                hint: l10n.loginEmailHint,
              ),
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              DoorError(_error!),
            ],
            const SizedBox(height: 20),
            DoorButton(
              label: l10n.loginSendCode,
              busy: _busy,
              onPressed: _submit,
            ),
            const SizedBox(height: 12),
            DoorLinkButton(
              key: const Key('login-signup'),
              label: l10n.signupEntryLogin,
              onPressed: _busy ? null : () => context.go(AppRoutes.signup),
            ),
          ],
        ),
      ),
    );
  }
}
