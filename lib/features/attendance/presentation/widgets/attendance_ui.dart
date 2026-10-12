import 'package:flutter/material.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is,
/// anders een algemene melding.
String attendanceErrorText(AppLocalizations l10n, Object? error) =>
    switch (error) {
      NetworkException() => l10n.errorNetwork,
      final ApiException e when e.message != null => e.message!,
      _ => l10n.errorGeneric,
    };

/// Fouttoast (met trilling).
void showAttendanceError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: attendanceErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Succestoast (met trilling).
void showAttendanceSuccess(BuildContext context, String title) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// Vraagt bevestiging om iets weg te halen — `true` als bevestigd.
Future<bool> confirmAttendanceRemove(
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
          key: const ValueKey('attendance-confirm-cancel'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.attendanceCancel),
        ),
        TextButton(
          key: const ValueKey('attendance-confirm-ok'),
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: StatusColors.red600),
          child: Text(l10n.attendanceRemove),
        ),
      ],
    ),
  );
  return ok ?? false;
}
