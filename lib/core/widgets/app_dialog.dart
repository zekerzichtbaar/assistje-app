import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'status_colors.dart';

/// Vraagt bevestiging; `true` als bevestigd.
///
/// Native per platform: op iOS een [CupertinoAlertDialog] (Annuleren links,
/// een destructieve knop in systeemrood), op Android een Material
/// [AlertDialog]. Bij [destructive] is Annuleren de standaardknop (vet op
/// iOS), zodat de veilige keuze de nadruk krijgt.
///
/// [cancelKey]/[confirmKey] staan op de knoppen op beide platformen.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String message,
  required String confirmLabel,
  required String cancelLabel,
  String? title,
  bool destructive = false,
  Key? cancelKey,
  Key? confirmKey,
}) async {
  final cupertino = _isCupertino(context);
  final ok = await showAdaptiveDialog<bool>(
    context: context,
    builder: (context) {
      void pop(bool value) => Navigator.of(context).pop(value);
      final titleWidget = title == null ? null : Text(title);
      if (cupertino) {
        return CupertinoAlertDialog(
          title: titleWidget,
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              key: cancelKey,
              isDefaultAction: destructive,
              onPressed: () => pop(false),
              child: Text(cancelLabel),
            ),
            CupertinoDialogAction(
              key: confirmKey,
              isDestructiveAction: destructive,
              isDefaultAction: !destructive,
              // Donkerder dan systemRed: het half doorzichtige dialoogvlak
              // ligt over de gedimde achtergrond, en systemRed haalt daar
              // geen 4.5:1.
              textStyle: destructive
                  ? const TextStyle(color: StatusColors.red700)
                  : null,
              onPressed: () => pop(true),
              child: Text(confirmLabel),
            ),
          ],
        );
      }
      return AlertDialog(
        title: titleWidget,
        content: Text(message),
        actions: [
          TextButton(
            key: cancelKey,
            onPressed: () => pop(false),
            child: Text(cancelLabel),
          ),
          TextButton(
            key: confirmKey,
            onPressed: () => pop(true),
            style: destructive
                ? TextButton.styleFrom(foregroundColor: StatusColors.red600)
                : null,
            child: Text(confirmLabel),
          ),
        ],
      );
    },
  );
  return ok ?? false;
}

bool _isCupertino(BuildContext context) {
  final platform = Theme.of(context).platform;
  return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
}
