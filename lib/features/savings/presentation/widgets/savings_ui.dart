import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is
/// (bv. "De activiteit is afgelast; …"), anders een algemene melding.
String savingsErrorText(AppLocalizations l10n, Object? error) =>
    switch (error) {
      NetworkException() => l10n.errorNetwork,
      final ApiException e when e.message != null => e.message!,
      _ => l10n.errorGeneric,
    };

/// De tekst bij een laadfout: 403/404 met een eigen uitleg.
String savingsLoadErrorText(AppLocalizations l10n, Object? error) =>
    switch (error) {
      ForbiddenException() => l10n.savingsForbidden,
      NotFoundException() => l10n.savingsNotFound,
      _ => savingsErrorText(l10n, error),
    };

/// De veldfout voor [field] uit een 422, of `null`.
String? savingsFieldError(Object? error, String field) =>
    error is ValidationException ? error.fieldError(field) : null;

/// Een 422 zonder veldfouten (alleen `message`), anders `null`.
String? savingsFormMessage(AppLocalizations l10n, Object? error) {
  if (error == null) return null;
  if (error is ValidationException && error.errors.isNotEmpty) return null;
  return savingsErrorText(l10n, error);
}

/// `nov '26` uit `2026-11`.
String savingsMonthLabel(String ym) {
  final date = parseYm(ym);
  if (date == null) return ym;
  final month = DateFormat('MMM', 'nl').format(date).replaceAll('.', '');
  return "$month '${(date.year % 100).toString().padLeft(2, '0')}";
}

/// `november 2026` uit `2026-11`.
String savingsMonthLong(String ym) {
  final date = parseYm(ym);
  return date == null ? ym : DateFormat('MMMM y', 'nl').format(date);
}

/// `za 21 nov`.
String savingsDateLabel(DateTime date) =>
    DateFormat('EEE d MMM', 'nl').format(date.toLocal()).replaceAll('.', '');

/// `za 21 nov 2026`.
String savingsDateLongLabel(DateTime date) =>
    DateFormat('EEE d MMM y', 'nl').format(date.toLocal()).replaceAll('.', '');

/// `YYYY-MM` van [date].
String ymOf(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}';

/// `2026-11` → 1 november 2026; `null` als het geen maand is.
DateTime? parseYm(String ym) {
  final match = RegExp(r'^(\d{4})-(\d{2})$').firstMatch(ym);
  if (match == null) return null;
  return DateTime(int.parse(match[1]!), int.parse(match[2]!));
}

/// Een maand [delta] verder dan [ym].
String shiftYm(String ym, int delta) {
  final date = parseYm(ym) ?? DateTime.now();
  return ymOf(DateTime(date.year, date.month + delta));
}

/// Toont een fouttoast (met trilling).
void showSavingsError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: savingsErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Toont een succestoast (met trilling).
void showSavingsSuccess(BuildContext context, String title) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// Vraagt bevestiging; `true` als bevestigd.
Future<bool> confirmSavings(
  BuildContext context, {
  required String title,
  required String message,
  required String confirmLabel,
  bool destructive = false,
}) async {
  final l10n = AppLocalizations.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          key: const ValueKey('savings-confirm-cancel'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.savingsCancel),
        ),
        TextButton(
          key: const ValueKey('savings-confirm-ok'),
          onPressed: () => Navigator.of(context).pop(true),
          style: destructive
              ? TextButton.styleFrom(foregroundColor: StatusColors.red600)
              : null,
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return ok ?? false;
}

/// Een foutmelding bovenin een formulier.
class SavingsFormError extends StatelessWidget {
  const SavingsFormError(this.message, {super.key});

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

/// Klein "staf"-label achter een naam.
class SavingsStaffBadge extends StatelessWidget {
  const SavingsStaffBadge({super.key, required this.raised, this.color});

  final Color raised;
  final Color? color;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(left: 6),
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
    decoration: BoxDecoration(
      color: raised,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      AppLocalizations.of(context).savingsStaffBadge,
      style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: color),
    ),
  );
}
