import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is,
/// anders een algemene melding.
String agreementsErrorText(AppLocalizations l10n, Object? error) =>
    switch (error) {
      NetworkException() => l10n.errorNetwork,
      final ApiException e when e.message != null => e.message!,
      _ => l10n.errorGeneric,
    };

/// De veldfout voor [field] uit een 422, of `null`.
String? agreementsFieldError(Object? error, String field) =>
    error is ValidationException ? error.fieldError(field) : null;

/// Een 422 met veldfouten hoort inline in het formulier; al het andere als
/// melding bovenin.
bool isAgreementsFieldError(Object? error, List<String> fields) =>
    error is ValidationException &&
    fields.any((field) => error.fieldError(field) != null);

/// Fouttoast (met trilling).
void showAgreementsError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: agreementsErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Succestoast (met trilling).
void showAgreementsSuccess(BuildContext context, String title) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// Vraagt bevestiging voor verwijderen — `true` als bevestigd.
Future<bool> confirmAgreementsDelete(
  BuildContext context,
  String question,
) async {
  final l10n = AppLocalizations.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(question),
      actions: [
        TextButton(
          key: const ValueKey('agreements-delete-cancel'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.agreementsCancel),
        ),
        TextButton(
          key: const ValueKey('agreements-delete-confirm'),
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: StatusColors.red600),
          child: Text(l10n.agreementsDelete),
        ),
      ],
    ),
  );
  return ok ?? false;
}

/// Het icoon per categorie, zoals `CATEGORY_ICON` in de PWA.
IconData agreementCategoryIcon(String key) => switch (key) {
  'training' => PhosphorIconsBold.barbell,
  'match' => PhosphorIconsBold.soccerBall,
  'attendance' => PhosphorIconsBold.calendarCheck,
  'locker' => PhosphorIconsBold.door,
  'gear' => PhosphorIconsBold.tShirt,
  'money' => PhosphorIconsBold.coins,
  'conduct' => PhosphorIconsBold.handshake,
  _ => PhosphorIconsBold.note,
};

/// Een foutmelding bovenin een formulier.
class AgreementsFormError extends StatelessWidget {
  const AgreementsFormError(this.message, {super.key});

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
