import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is,
/// anders een algemene melding.
String reportErrorText(AppLocalizations l10n, Object? error) => switch (error) {
  NetworkException() => l10n.errorNetwork,
  final ApiException e when e.message != null => e.message!,
  _ => l10n.errorGeneric,
};

/// De veldfout voor [field] uit een 422, of `null`.
String? reportFieldError(Object? error, String field) =>
    error is ValidationException ? error.fieldError(field) : null;

/// Fouttoast (met trilling).
void showReportError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: reportErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Succestoast (met trilling).
void showReportSuccess(BuildContext context, String title) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// Na een fout in een sheet: een 422 staat al in de sheet; al het andere
/// krijgt een toast (de sheet blijft open).
void reportSheetFailure(BuildContext context, Object error) {
  if (error is ValidationException) {
    Haptics.error();
    return;
  }
  showReportError(context, AppLocalizations.of(context).reportSaveError, error);
}

/// "Halley DS1 - Vogels DS1", of de titel zonder "Wedstrijd — ".
String reportMatchLabel(String title, String? home, String? away) {
  if ((home ?? '').isNotEmpty && (away ?? '').isNotEmpty) {
    return '$home - $away';
  }
  return title.replaceFirst(
    RegExp(r'^wedstrijd\s*[—-]\s*', caseSensitive: false),
    '',
  );
}

/// De groep van een statkolom (`serve_errors` → `serve`), of `null` voor de
/// hoofdcijfers (`points`, `aces`, `blocks`). Alleen bekende voorvoegsels;
/// een onbekende kolom komt bij de hoofdcijfers.
String? statGroupOf(String column) {
  final i = column.indexOf('_');
  if (i <= 0) return null;
  final prefix = column.substring(0, i);
  return _statGroups.contains(prefix) ? prefix : null;
}

const _statGroups = {'sets', 'serve', 'reception', 'attack'};

/// De kolommen per groep, in de volgorde van [columns] (de hoofdcijfers
/// onder de sleutel `''`).
Map<String, List<String>> groupStatColumns(List<String> columns) {
  final groups = <String, List<String>>{};
  for (final column in columns) {
    (groups[statGroupOf(column) ?? ''] ??= []).add(column);
  }
  return groups;
}

/// De kolommen naast de naam in het blad: de hoofdcijfers (hoogstens drie).
List<String> headlineStatColumns(List<String> columns) {
  final main = groupStatColumns(columns)[''] ?? const <String>[];
  return (main.isEmpty ? columns : main).take(3).toList();
}

/// Kort label voor een kolom; onbekende kolommen leesbaar gemaakt.
String statLabel(AppLocalizations l10n, String column) {
  switch (column) {
    case 'points':
      return l10n.reportStatPoints;
    case 'aces':
      return l10n.reportStatAces;
    case 'blocks':
      return l10n.reportStatBlocks;
  }
  final group = statGroupOf(column);
  final suffix = group == null ? column : column.substring(group.length + 1);
  return switch (suffix) {
    'played' => l10n.reportStatPlayed,
    'attempts' => l10n.reportStatAttempts,
    'errors' => l10n.reportStatErrors,
    'positive' => l10n.reportStatPositive,
    'blocked' => l10n.reportStatBlocked,
    'kills' => l10n.reportStatKills,
    _ => _humanize(suffix),
  };
}

/// Label van een groep uit [groupStatColumns].
String statGroupLabel(AppLocalizations l10n, String group) => switch (group) {
  '' => l10n.reportStatGroupMain,
  'sets' => l10n.reportStatGroupSets,
  'serve' => l10n.reportStatGroupServe,
  'reception' => l10n.reportStatGroupReception,
  'attack' => l10n.reportStatGroupAttack,
  _ => _humanize(group),
};

String _humanize(String key) {
  final text = key.replaceAll('_', ' ').trim();
  return text.isEmpty ? key : text[0].toUpperCase() + text.substring(1);
}

/// Kleine sectietitel in hoofdletters (zoals de PWA-labels).
class ReportLabel extends StatelessWidget {
  const ReportLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.6,
      color: AssistjeTokens.of(context).muted,
    ),
  );
}

/// Een fout bovenin een sheet.
class ReportFormError extends StatelessWidget {
  const ReportFormError(this.message, {super.key});

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

/// Een getalveld van hoogstens [digits] cijfers (leeg mag).
class ReportNumberField extends StatelessWidget {
  const ReportNumberField({
    super.key,
    required this.controller,
    this.digits = 2,
    this.width = 64,
    this.fontSize = 18,
    this.errorText,
    this.semanticLabel,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController controller;
  final int digits;
  final double width;
  final double fontSize;
  final String? errorText;
  final String? semanticLabel;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    child: Semantics(
      label: semanticLabel,
      textField: true,
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textInputAction: textInputAction,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(digits),
        ],
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 10,
          ),
          errorText: errorText,
          errorMaxLines: 3,
        ),
      ),
    ),
  );
}

/// Leeg veld → `null`, anders het getal.
int? parseReportNumber(String text) =>
    text.trim().isEmpty ? null : int.tryParse(text.trim());
