import '../../../core/api/api_exception.dart';
import '../../../l10n/generated/app_localizations.dart';

/// Vertaalt een fout bij het aanvragen van een code naar copy.
String requestErrorText(AppLocalizations l10n, Object error) {
  return switch (error) {
    ThrottledException() => l10n.loginRequestThrottled,
    ValidationException() =>
      error.fieldError('email') ?? l10n.loginEmailInvalid,
    NetworkException() => l10n.errorNetwork,
    _ => l10n.errorGeneric,
  };
}

/// Vertaalt een fout bij het inwisselen van de code naar copy.
String exchangeErrorText(AppLocalizations l10n, Object error) {
  return switch (error) {
    ThrottledException() => l10n.loginCodeLocked,
    ValidationException() => l10n.loginCodeInvalid,
    NetworkException() => l10n.errorNetwork,
    _ => l10n.errorGeneric,
  };
}
