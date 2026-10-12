import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/auth_controller.dart';
import '../../../core/router/app_routes.dart';
import '../../../l10n/generated/app_localizations.dart';
import 'auth_error_text.dart';
import 'widgets/door_scaffold.dart';

/// Lengte van de inlogcode.
const int loginCodeLength = 6;

/// Houdt alleen cijfers over en kapt af op [loginCodeLength], zodat plakken van
/// "042 917" of "Code: 042917" gewoon werkt.
class LoginCodeFormatter extends TextInputFormatter {
  const LoginCodeFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > loginCodeLength) {
      digits = digits.substring(0, loginCodeLength);
    }
    return TextEditingValue(
      text: digits,
      selection: TextSelection.collapsed(offset: digits.length),
    );
  }
}

/// Stap 2: de zescijferige code uit de mail.
class LoginCodeScreen extends ConsumerStatefulWidget {
  const LoginCodeScreen({required this.email, super.key});

  final String email;

  @override
  ConsumerState<LoginCodeScreen> createState() => _LoginCodeScreenState();
}

class _LoginCodeScreenState extends ConsumerState<LoginCodeScreen> {
  final _code = TextEditingController();
  bool _busy = false;
  bool _resending = false;
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final code = _code.text;
    if (code.length != loginCodeLength || _busy) return;
    final l10n = AppLocalizations.of(context);
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref
          .read(authControllerProvider.notifier)
          .signInWithCode(email: widget.email, code: code);
      // De router stuurt door zodra de status "ingelogd" is.
    } on Object catch (error) {
      if (!mounted) return;
      setState(() => _error = exchangeErrorText(l10n, error));
      _code.clear();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _resend() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    setState(() {
      _resending = true;
      _error = null;
    });
    try {
      await ref.read(authControllerProvider.notifier).requestCode(widget.email);
      messenger.showSnackBar(SnackBar(content: Text(l10n.loginCodeResent)));
    } on Object catch (error) {
      if (!mounted) return;
      setState(() => _error = requestErrorText(l10n, error));
    } finally {
      if (mounted) setState(() => _resending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    const linkStyle = TextStyle(
      color: DoorColors.ink,
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );

    return DoorScaffold(
      leading: IconButton(
        tooltip: l10n.loginCodeOtherEmail,
        icon: const Icon(Icons.arrow_back, color: DoorColors.ink),
        onPressed: () => context.goNamed(AppRoutes.loginName),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DoorHeadline(l10n.loginCodeHeadline),
          const SizedBox(height: 12),
          Text(
            l10n.loginCodeIntro(widget.email),
            style: const TextStyle(fontSize: 16, color: DoorColors.ink),
          ),
          const SizedBox(height: 28),
          TextField(
            key: const Key('login-code'),
            controller: _code,
            autofocus: true,
            keyboardType: TextInputType.number,
            autofillHints: const [AutofillHints.oneTimeCode],
            inputFormatters: const [LoginCodeFormatter()],
            textAlign: TextAlign.center,
            enabled: !_busy,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              letterSpacing: 12,
              color: DoorColors.ink,
            ),
            decoration: doorInputDecoration(
              label: l10n.loginCodeLabel,
              hint: '••••••',
            ),
            onChanged: (value) {
              if (value.length == loginCodeLength) _submit();
            },
            onSubmitted: (_) => _submit(),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            DoorError(_error!),
          ],
          const SizedBox(height: 20),
          DoorButton(
            label: l10n.loginCodeSubmit,
            busy: _busy,
            onPressed: _submit,
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 16,
            runSpacing: 8,
            children: [
              TextButton(
                onPressed: _resending ? null : _resend,
                child: Text(l10n.loginCodeResend, style: linkStyle),
              ),
              TextButton(
                onPressed: () => context.goNamed(AppRoutes.loginName),
                child: Text(l10n.loginCodeOtherEmail, style: linkStyle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
