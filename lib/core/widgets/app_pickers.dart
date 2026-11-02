import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/assistje_tokens.dart';

/// Kiest een datum, native per platform: op iOS een [CupertinoDatePicker]
/// (draaiwieltjes) onderin met Annuleren/Gereed, op Android de Material-
/// kalender. `null` als de gebruiker annuleert.
///
/// [initialDate] wordt binnen [firstDate]–[lastDate] getrokken.
Future<DateTime?> showAppDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) {
  final initial = initialDate.isBefore(firstDate)
      ? firstDate
      : initialDate.isAfter(lastDate)
      ? lastDate
      : initialDate;
  if (!_isCupertino(context)) {
    return showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: firstDate,
      lastDate: lastDate,
      locale: const Locale('nl'),
    );
  }
  return _showCupertinoPicker<DateTime>(
    context: context,
    initial: initial,
    builder: (onChanged) => CupertinoDatePicker(
      mode: CupertinoDatePickerMode.date,
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: initial,
      minimumDate: firstDate,
      maximumDate: lastDate,
      onDateTimeChanged: (value) =>
          onChanged(DateTime(value.year, value.month, value.day)),
    ),
  );
}

/// Kiest een tijd (altijd 24-uurs), native per platform; `null` bij
/// annuleren.
Future<TimeOfDay?> showAppTimePicker({
  required BuildContext context,
  required TimeOfDay initialTime,
}) async {
  if (!_isCupertino(context)) {
    return showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
  }
  final now = DateTime.now();
  final picked = await _showCupertinoPicker<DateTime>(
    context: context,
    initial: DateTime(
      now.year,
      now.month,
      now.day,
      initialTime.hour,
      initialTime.minute,
    ),
    builder: (onChanged) => CupertinoDatePicker(
      mode: CupertinoDatePickerMode.time,
      use24hFormat: true,
      initialDateTime: DateTime(
        now.year,
        now.month,
        now.day,
        initialTime.hour,
        initialTime.minute,
      ),
      onDateTimeChanged: onChanged,
    ),
  );
  return picked == null ? null : TimeOfDay.fromDateTime(picked);
}

/// Een kiezer onderin het scherm met Annuleren/Gereed erboven, zoals de
/// systeemkiezers op iOS. Geeft de laatst gekozen waarde terug bij Gereed.
Future<T?> _showCupertinoPicker<T>({
  required BuildContext context,
  required T initial,
  required Widget Function(ValueChanged<T> onChanged) builder,
}) {
  var value = initial;
  return showCupertinoModalPopup<T>(
    context: context,
    builder: (context) {
      final tokens = AssistjeTokens.of(context);
      final l10n = AppLocalizations.of(context);
      return Container(
        color: tokens.surface,
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: tokens.line)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      key: const ValueKey('picker-cancel'),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(l10n.cancel),
                    ),
                    CupertinoButton(
                      key: const ValueKey('picker-done'),
                      onPressed: () => Navigator.of(context).pop(value),
                      child: Text(
                        l10n.done,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 216, child: builder((next) => value = next)),
            ],
          ),
        ),
      );
    },
  );
}

bool _isCupertino(BuildContext context) {
  final platform = Theme.of(context).platform;
  return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
}
