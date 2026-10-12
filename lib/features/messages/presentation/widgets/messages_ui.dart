import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is,
/// anders een algemene melding.
String messagesErrorText(AppLocalizations l10n, Object? error) =>
    switch (error) {
      NetworkException() => l10n.errorNetwork,
      final ApiException e when e.message != null => e.message!,
      _ => l10n.errorGeneric,
    };

/// De veldfout voor [field] uit een 422, of `null`.
String? messagesFieldError(Object? error, String field) =>
    error is ValidationException ? error.fieldError(field) : null;

/// Een 422 met veldfouten hoort inline in het formulier; al het andere als
/// melding bovenin.
bool isMessagesFieldError(Object? error, List<String> fields) =>
    error is ValidationException &&
    fields.any((field) => error.fieldError(field) != null);

/// Fouttoast (met trilling).
void showMessagesError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: messagesErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Succestoast (met trilling).
void showMessagesSuccess(BuildContext context, String title, {String? body}) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    message: body,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// `za 11 okt · 14:30`, zoals `fmt()` in de PWA.
String formatMessageTime(DateTime time) =>
    '${DateFormat('EEE d MMM', 'nl').format(time).replaceAll('.', '')}'
    ' · ${DateFormat('HH:mm', 'nl').format(time)}';

/// Kaart met een kop in kleine hoofdletters (`CardTitle` in de PWA).
class MessagesSection extends StatelessWidget {
  const MessagesSection({
    super.key,
    required this.title,
    required this.child,
    this.icon,
  });

  final String title;
  final IconData? icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final icon = this.icon;
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Semantics(
              header: true,
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 14, color: t.muted),
                    const SizedBox(width: 6),
                  ],
                  Expanded(
                    child: Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        color: t.muted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(16), child: child),
        ],
      ),
    );
  }
}

/// Een foutmelding bovenin een formulier.
class MessagesFormError extends StatelessWidget {
  const MessagesFormError(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      message,
      style: const TextStyle(fontSize: 14, color: StatusColors.red600),
    ),
  );
}

/// Label boven een formulierveld.
class MessagesFieldLabel extends StatelessWidget {
  const MessagesFieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: t.muted,
        ),
      ),
    );
  }
}
