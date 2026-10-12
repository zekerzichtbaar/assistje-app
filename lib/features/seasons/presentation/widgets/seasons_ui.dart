import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// `2026-08-01` → `1 aug.` (`DATE_FMT` in SeasonTab.tsx); `?` als leeg.
String formatSeasonDate(String? iso) {
  if (iso == null || iso.isEmpty) return '?';
  final date = DateTime.tryParse(iso);
  if (date == null) return iso;
  return DateFormat('d MMM', 'nl').format(date);
}

/// `DateTime` → `YYYY-MM-DD`.
String isoSeasonDate(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

/// `YYYY-MM-DD` → `DateTime` (of `null`).
DateTime? parseSeasonDate(String? iso) {
  if (iso == null || iso.isEmpty) return null;
  final date = DateTime.tryParse(iso);
  return date == null ? null : DateTime(date.year, date.month, date.day);
}

/// De tekst bij een mislukte aanroep: Laravels `message` (of de eerste
/// veldfout) als die er is, anders een algemene melding.
String seasonsErrorText(AppLocalizations l10n, Object? error) =>
    switch (error) {
      NetworkException() => l10n.errorNetwork,
      ForbiddenException() => l10n.seasonsReadOnlyForbidden,
      final ApiException e when e.errors.isNotEmpty =>
        e.errors.values.expand((m) => m).firstOrNull ?? l10n.errorGeneric,
      final ApiException e when e.message != null => e.message!,
      _ => l10n.errorGeneric,
    };

/// De eerste veldfout voor een van [fields] bij een 422, anders `null`.
String? seasonsFieldError(Object? error, List<String> fields) {
  if (error is! ValidationException) return null;
  for (final field in fields) {
    final message = error.fieldError(field);
    if (message != null) return message;
  }
  return null;
}

/// Een 422 met alleen een `message` ("kan nu niet").
bool isSeasonsFormLevel(Object? error) =>
    error is ValidationException &&
    error.errors.isEmpty &&
    error.message != null;

/// Fouttoast (met trilling).
void showSeasonsError(BuildContext context, Object? error, {String? title}) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title ?? l10n.seasonsSaveFailed,
    message: seasonsErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Succestoast (met trilling).
void showSeasonsSuccess(BuildContext context, String title, {String? message}) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    message: message,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// Vraagt bevestiging — `true` als bevestigd. [destructive] kleurt de knop
/// rood.
Future<bool> confirmSeasons(
  BuildContext context, {
  required String message,
  required String confirmLabel,
  bool destructive = false,
}) async {
  final l10n = AppLocalizations.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          key: const ValueKey('seasons-confirm-cancel'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.seasonsCancel),
        ),
        TextButton(
          key: const ValueKey('seasons-confirm-ok'),
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

/// Een tikbaar datumveld met label, waarde (of placeholder) en veldfout.
class SeasonDateField extends StatelessWidget {
  const SeasonDateField({
    super.key,
    required this.label,
    required this.value,
    required this.placeholder,
    required this.onTap,
    this.error,
    this.onClear,
    this.clearLabel,
  });

  final String label;
  final DateTime? value;
  final String placeholder;
  final VoidCallback? onTap;
  final String? error;

  /// Optioneel: de datum leegmaken (`null` = geen knop).
  final VoidCallback? onClear;
  final String? clearLabel;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final value = this.value;
    final text = value == null
        ? placeholder
        : DateFormat('EEEE d MMMM y', 'nl').format(value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: t.inkSoft,
          ),
        ),
        const SizedBox(height: 6),
        Semantics(
          button: true,
          label: label,
          value: value == null ? null : text,
          child: Material(
            color: t.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: error != null ? StatusColors.red600 : t.line,
              ),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Icon(PhosphorIconsRegular.calendarBlank, color: t.muted),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ExcludeSemantics(
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 15,
                            color: value == null ? t.muted : t.ink,
                          ),
                        ),
                      ),
                    ),
                    if (onClear != null && value != null)
                      IconButton(
                        tooltip: clearLabel,
                        visualDensity: VisualDensity.compact,
                        onPressed: onClear,
                        icon: Icon(
                          PhosphorIconsBold.x,
                          size: 16,
                          color: t.muted,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 4),
          Text(
            error!,
            style: const TextStyle(fontSize: 13, color: StatusColors.red600),
          ),
        ],
      ],
    );
  }
}

/// Opent de datumkiezer rond [initial] (of vandaag).
Future<DateTime?> pickSeasonDate(
  BuildContext context, {
  DateTime? initial,
  DateTime? first,
}) {
  final now = DateTime.now();
  final firstDate = first ?? DateTime(now.year - 10);
  final lastDate = DateTime(now.year + 10, 12, 31);
  var start = initial ?? DateTime(now.year, now.month, now.day);
  if (start.isBefore(firstDate)) start = firstDate;
  if (start.isAfter(lastDate)) start = lastDate;
  return showDatePicker(
    context: context,
    initialDate: start,
    firstDate: firstDate,
    lastDate: lastDate,
    locale: const Locale('nl'),
  );
}

/// Een melding bovenaan een formulier (422 met alleen `message`).
class SeasonsFormError extends StatelessWidget {
  const SeasonsFormError(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Text(
      text,
      style: const TextStyle(fontSize: 14, color: StatusColors.red600),
    ),
  );
}
