import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Tailwind amber-600 (wachtend e-mailadres).
const Color profileAmber600 = StatusColors.amber600;

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is
/// (ook de demo-403), anders een algemene melding. Bij een avatar-422 wint de
/// veldfout (`Ongeldig formaat.`), net als in de PWA.
String profileErrorText(AppLocalizations l10n, Object? error) =>
    switch (error) {
      NetworkException() => l10n.errorNetwork,
      final ApiException e when e.fieldError('avatar') != null => e.fieldError(
        'avatar',
      )!,
      final ApiException e when e.message != null => e.message!,
      _ => l10n.errorGeneric,
    };

/// De veldfout voor [field] uit een 422, of `null`.
String? profileFieldError(Object? error, String field) =>
    error is ValidationException ? error.fieldError(field) : null;

/// `YYYY-MM-DD` → [DateTime] (lokaal, middernacht), of `null`.
DateTime? parseProfileDate(String? value) {
  if (value == null || value.isEmpty) return null;
  return DateTime.tryParse(value);
}

/// [DateTime] → `YYYY-MM-DD`.
String formatProfileIsoDate(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

/// `05 apr 2001`.
String formatProfileDate(String? value) {
  final date = parseProfileDate(value);
  if (date == null) return value ?? '';
  return DateFormat('dd MMM y', 'nl').format(date);
}

/// Toont een fouttoast (met trilling).
void showProfileError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: profileErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Toont een succestoast (met trilling).
void showProfileSuccess(BuildContext context, String title, {String? body}) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    message: body,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// Vraagt een destructieve bevestiging — `true` als bevestigd.
Future<bool> confirmProfileAction(
  BuildContext context, {
  required String question,
  required String confirmLabel,
  String? title,
}) async {
  final l10n = AppLocalizations.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: title == null ? null : Text(title),
      content: Text(question),
      actions: [
        TextButton(
          key: const ValueKey('profile-confirm-cancel'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.profileCancel),
        ),
        TextButton(
          key: const ValueKey('profile-confirm-ok'),
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: StatusColors.red600),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return ok ?? false;
}

/// Kop + uitleg bovenaan een kaart (`font-medium text-ink` + `text-xs
/// text-muted`), met optioneel een icoon.
class ProfileCardHeader extends StatelessWidget {
  const ProfileCardHeader({
    super.key,
    required this.title,
    this.body,
    this.icon,
    this.iconColor,
    this.titleColor,
    this.bodyColor,
  });

  final String title;
  final String? body;
  final IconData? icon;
  final Color? iconColor;
  final Color? titleColor;
  final Color? bodyColor;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: iconColor ?? t.primary),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: titleColor ?? t.ink,
                ),
              ),
            ),
          ],
        ),
        if (body != null) ...[
          const SizedBox(height: 2),
          Text(
            body!,
            style: TextStyle(fontSize: 12, color: bodyColor ?? t.muted),
          ),
        ],
      ],
    );
  }
}

/// Een rode, destructieve pill-knop.
class ProfileDangerButton extends StatelessWidget {
  const ProfileDangerButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.expand = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final bool expand;
  final Widget? icon;

  @override
  Widget build(BuildContext context) => AppButtonBase(
    label: label,
    onPressed: onPressed,
    loading: loading,
    expand: expand,
    icon: icon,
    background: StatusColors.red600,
    foreground: Colors.white,
    horizontalPadding: 16,
  );
}
