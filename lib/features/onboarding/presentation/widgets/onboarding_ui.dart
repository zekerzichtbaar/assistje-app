import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is (ook
/// de 403 voor niet-trainers en demo), anders een algemene melding.
String onboardingErrorText(AppLocalizations l10n, Object? error) =>
    switch (error) {
      NetworkException() => l10n.errorNetwork,
      final ApiException e when e.message != null => e.message!,
      _ => l10n.errorGeneric,
    };

/// Fouttoast (met trilling).
void showOnboardingError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: onboardingErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// `Zaterdag 11 oktober, 14:30`, zoals `matchMoment()` in de PWA (met
/// hoofdletter, `first-letter:uppercase`).
String formatOnboardingMoment(String? iso) {
  final parsed = iso == null ? null : DateTime.tryParse(iso);
  if (parsed == null) return '';
  final text = DateFormat('EEEE d MMMM, HH:mm', 'nl').format(parsed.toLocal());
  return text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
}
