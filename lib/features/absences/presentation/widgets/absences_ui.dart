import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/shell/shell_insets.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is
/// (ook de demo-403 en "Geen spelersprofiel gekoppeld."), anders een
/// algemene melding.
String absencesErrorText(AppLocalizations l10n, Object? error) =>
    switch (error) {
      NetworkException() => l10n.errorNetwork,
      final ApiException e when e.message != null => e.message!,
      _ => l10n.errorGeneric,
    };

/// De veldfout voor [field] uit een 422, of `null`.
String? absencesFieldError(Object? error, String field) =>
    error is ValidationException ? error.fieldError(field) : null;

/// Een 422 zonder veldfouten (bv. "Geen spelersprofiel gekoppeld."): die
/// hoort in het formulier, niet in een toast.
bool isFormLevelValidation(Object? error) =>
    error is ValidationException && error.errors.isEmpty;

/// `YYYY-MM-DD` → [DateTime] (lokaal, middernacht), of `null`.
DateTime? parseAbsenceDate(String? value) {
  if (value == null || value.isEmpty) return null;
  return DateTime.tryParse(value);
}

/// [DateTime] → `YYYY-MM-DD`.
String isoAbsenceDate(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

/// `za 20 dec 2026`.
String formatAbsenceDate(String? value) {
  final date = parseAbsenceDate(value);
  if (date == null) return value ?? '';
  return DateFormat('EEE d MMM y', 'nl').format(date);
}

/// `maandag` … `zondag` voor een ISO-weekdag (0 telt als zondag).
String weekdayName(int weekday) {
  final iso = weekday == 0 ? 7 : weekday;
  // 1 januari 2024 was een maandag.
  return DateFormat('EEEE', 'nl').format(DateTime(2024, 1, iso.clamp(1, 7)));
}

/// Toont een fouttoast (met trilling).
void showAbsencesError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: absencesErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Toont een succestoast (met trilling).
void showAbsencesSuccess(BuildContext context, String title) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// Het geraamte van een afwezigheidsscherm: grijze achtergrond, ruimte voor
/// de shell-pills, pull-to-refresh en een titel (`placeholder-title`, zodat
/// de shell-tests hem lezen) met uitleg.
class AbsencesScaffold extends StatelessWidget {
  const AbsencesScaffold({
    super.key,
    required this.title,
    required this.onRefresh,
    required this.slivers,
    this.intro,
  });

  final String title;
  final String? intro;
  final Future<void> Function() onRefresh;
  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Scaffold(
      backgroundColor: t.sunken,
      body: AppRefresh(
        onRefresh: onRefresh,
        padding: EdgeInsets.fromLTRB(
          12,
          ShellInsets.top(context),
          12,
          ShellInsets.bottom(context),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Semantics(
                    header: true,
                    child: Text(
                      title,
                      key: const Key('placeholder-title'),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: t.ink,
                      ),
                    ),
                  ),
                  if (intro != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      intro!,
                      style: TextStyle(fontSize: 14, color: t.muted),
                    ),
                  ],
                ],
              ),
            ),
          ),
          ...slivers,
        ],
      ),
    );
  }
}

/// Laden: een paar grijze rijen.
class AbsencesSkeleton extends StatelessWidget {
  const AbsencesSkeleton({super.key});

  @override
  Widget build(BuildContext context) => const SkeletonList(count: 3);
}
