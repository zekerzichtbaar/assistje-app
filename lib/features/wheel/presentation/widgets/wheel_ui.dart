import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is,
/// anders een algemene melding.
String wheelErrorText(AppLocalizations l10n, Object? error) => switch (error) {
  NetworkException() => l10n.errorNetwork,
  final ApiException e when e.message != null => e.message!,
  _ => l10n.errorGeneric,
};

/// De inline tekst van een 422 (eerste veldfout, anders `message`), of
/// `null` als [error] geen 422 is.
String? wheelValidationText(AppLocalizations l10n, Object? error) {
  if (error is! ValidationException) return null;
  for (final field in const ['wheel', 'winner_player_id', 'winner_user_id']) {
    if (error.fieldError(field) case final message?) return message;
  }
  return wheelErrorText(l10n, error);
}

/// `10 okt 11:02`.
String wheelSpinDate(DateTime date) =>
    DateFormat('dd MMM HH:mm', 'nl').format(date.toLocal());

/// Fouttoast (met trilling).
void showWheelError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: wheelErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Succestoast (met trilling).
void showWheelSuccess(BuildContext context, String title) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// Vraagt bevestiging voor verwijderen — `true` als bevestigd.
Future<bool> confirmWheelDelete(BuildContext context, String question) async {
  final l10n = AppLocalizations.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(question),
      actions: [
        TextButton(
          key: const ValueKey('wheel-delete-cancel'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.wheelCancel),
        ),
        TextButton(
          key: const ValueKey('wheel-delete-confirm'),
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: StatusColors.red600),
          child: Text(l10n.wheelDelete),
        ),
      ],
    ),
  );
  return ok ?? false;
}

/// Een kop boven een kaartblok.
class WheelCardTitle extends StatelessWidget {
  const WheelCardTitle(this.text, {super.key, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => Semantics(
    header: true,
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
        color: color,
      ),
    ),
  );
}
