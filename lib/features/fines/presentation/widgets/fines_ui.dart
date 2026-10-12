import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/fines_models.dart';

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is
/// (bv. "Periode is afgesloten."), anders een algemene melding.
String finesErrorText(AppLocalizations l10n, Object? error) => switch (error) {
  NetworkException() => l10n.errorNetwork,
  final ApiException e when e.message != null => e.message!,
  _ => l10n.errorGeneric,
};

/// De veldfout voor [field] uit een 422, of `null`.
String? finesFieldError(Object? error, String field) =>
    error is ValidationException ? error.fieldError(field) : null;

/// `9 okt 2026`.
String finesDate(DateTime date) =>
    DateFormat('d MMM y', 'nl').format(date.toLocal());

/// Toont een fouttoast (met trilling).
void showFinesError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: finesErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Toont een succestoast (met trilling).
void showFinesSuccess(BuildContext context, String title) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// Vraagt "Echt verwijderen?" — `true` als bevestigd.
Future<bool> confirmFinesDelete(BuildContext context, String question) async {
  final l10n = AppLocalizations.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(question),
      actions: [
        TextButton(
          key: const ValueKey('fines-delete-cancel'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.finesCancel),
        ),
        TextButton(
          key: const ValueKey('fines-delete-confirm'),
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: StatusColors.red600),
          child: Text(l10n.finesDelete),
        ),
      ],
    ),
  );
  return ok ?? false;
}

/// Vraagt bevestiging met een eigen knoptekst ([confirmLabel]); `true` als
/// bevestigd. [destructive] kleurt de knop rood.
Future<bool> confirmFinesAction(
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
          key: const ValueKey('fines-confirm-cancel'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.finesCancel),
        ),
        TextButton(
          key: const ValueKey('fines-confirm-ok'),
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

/// Een 403 op een beheeractie (geen penningmeester meer, of een demoteam):
/// toont de alleen-lezen-melding. `true` als [error] zo'n 403 was.
bool finesShowForbidden(BuildContext context, Object? error) {
  if (error is! ForbiddenException) return false;
  showFinesError(
    context,
    AppLocalizations.of(context).finesManageForbidden,
    error,
  );
  return true;
}

/// Label van een boetestatus.
String fineStatusLabel(AppLocalizations l10n, FineStatus status) =>
    switch (status) {
      FineStatus.open => l10n.finesStatusOpen,
      FineStatus.paid => l10n.finesStatusPaid,
      FineStatus.waived => l10n.finesStatusWaived,
      FineStatus.unknown => l10n.finesStatusUnknown,
    };

/// Klein label in de kleur van de status (open rood, betaald groen,
/// kwijtgescholden grijs).
class FineStatusBadge extends StatelessWidget {
  const FineStatusBadge({super.key, required this.status});

  final FineStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (bg, fg) = switch (status) {
      FineStatus.open => (StatusColors.red100, StatusColors.red700),
      FineStatus.paid => (StatusColors.emerald100, StatusColors.emerald700),
      FineStatus.waived ||
      FineStatus.unknown => (const Color(0xFFF1F5F9), const Color(0xFF475569)),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        fineStatusLabel(l10n, status).toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
          color: fg,
        ),
      ),
    );
  }
}

/// Een kop boven een blok (`Per persoon`, `Pot`).
class FinesSectionTitle extends StatelessWidget {
  const FinesSectionTitle(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
    child: Semantics(
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
    ),
  );
}

/// Een foutmelding bovenin een formulier.
class FinesFormError extends StatelessWidget {
  const FinesFormError(this.message, {super.key});

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
