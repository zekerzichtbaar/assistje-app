import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// De tekst bij een mislukte aanroep: bij 429 onze eigen uitleg, anders
/// Laravels `message` als die er is, anders een algemene melding.
String feedbackErrorText(AppLocalizations l10n, Object? error) =>
    switch (error) {
      NetworkException() => l10n.errorNetwork,
      ThrottledException() => l10n.feedbackThrottled,
      final ApiException e when e.message != null => e.message!,
      _ => l10n.errorGeneric,
    };

/// De veldfout voor [field] uit een 422, of `null`.
String? feedbackFieldError(Object? error, String field) =>
    error is ValidationException ? error.fieldError(field) : null;

/// Een 422 met veldfouten hoort inline in het formulier; al het andere als
/// melding bovenin.
bool isFeedbackFieldError(Object? error, List<String> fields) =>
    error is ValidationException &&
    fields.any((field) => error.fieldError(field) != null);

/// Fouttoast (met trilling).
void showFeedbackError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: feedbackErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Succestoast (met trilling).
void showFeedbackSuccess(BuildContext context, String title) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// `9 okt`, zoals `shortDate()` in de PWA.
String formatFeedbackDate(DateTime time) =>
    DateFormat('d MMM', 'nl').format(time).replaceAll('.', '');

/// Een foutmelding bovenin een formulier.
class FeedbackFormError extends StatelessWidget {
  const FeedbackFormError(this.message, {super.key});

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
