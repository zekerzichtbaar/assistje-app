import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/duties_models.dart';

/// Amber voor "afgemeld" (Tailwind amber-600/400). Lokaal tot de core-
/// opruimslice `StatusColors` uitbreidt met amber/slate.
const Color dutiesAmber600 = StatusColors.amber600;
const Color dutiesAmber400 = StatusColors.amber400;

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is,
/// anders een algemene melding.
String dutiesErrorText(AppLocalizations l10n, Object? error) => switch (error) {
  NetworkException() => l10n.errorNetwork,
  final ApiException e when e.message != null => e.message!,
  _ => l10n.errorGeneric,
};

/// De eerste veldfout uit een 422 voor één van [fields], of `null`.
String? dutiesFieldError(Object? error, List<String> fields) {
  if (error is! ValidationException) return null;
  for (final field in fields) {
    if (error.fieldError(field) case final message?) return message;
  }
  return null;
}

/// Een 422 met een veldfout die het formulier zelf toont (een van [fields]
/// of een veld dat met een van [prefixes] begint, zoals `dates.`).
bool isDutiesFieldError(
  Object? error,
  List<String> fields, {
  List<String> prefixes = const [],
}) =>
    error is ValidationException &&
    error.errors.keys.any(
      (key) => fields.contains(key) || prefixes.any(key.startsWith),
    );

/// Fouttoast (met trilling).
void showDutiesError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: dutiesErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Succestoast (met trilling).
void showDutiesSuccess(BuildContext context, String title, {String? message}) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    message: message,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// Vraagt bevestiging — `true` als bevestigd. [confirmLabel] standaard
/// "Verwijderen" (rood).
Future<bool> confirmDuties(
  BuildContext context,
  String question, {
  String? confirmLabel,
  bool destructive = true,
}) async {
  final l10n = AppLocalizations.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(question),
      actions: [
        TextButton(
          key: const ValueKey('duties-confirm-cancel'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.dutiesCancel),
        ),
        TextButton(
          key: const ValueKey('duties-confirm-ok'),
          onPressed: () => Navigator.of(context).pop(true),
          style: destructive
              ? TextButton.styleFrom(foregroundColor: StatusColors.red600)
              : null,
          child: Text(confirmLabel ?? l10n.dutiesDelete),
        ),
      ],
    ),
  );
  return ok ?? false;
}

/// `2026-10-12` → `zo 12 okt` (zoals `formatDate` in de PWA).
String dutiesDateLabel(String iso) {
  final date = DateTime.tryParse(iso);
  if (date == null) return iso;
  return DateFormat('EEE d MMM', 'nl').format(date).replaceAll('.', '');
}

/// `14:30:00` → `14:30`.
String dutiesTimeLabel(String time) =>
    time.length > 5 ? time.substring(0, 5) : time;

/// Het label van een persoon met zijn soort erachter (`memberLabel`).
String dutiesPersonLabel(AppLocalizations l10n, DutyPerson person) {
  final kind = dutiesKindLabel(l10n, person.kind);
  return kind == null ? person.name : '${person.name} ($kind)';
}

/// "staf"/"toeschouwer"/"gast", of `null` voor een speler.
String? dutiesKindLabel(AppLocalizations l10n, String? kind) => switch (kind) {
  'staff' => l10n.dutiesKindStaff,
  'spectator' => l10n.dutiesKindSpectator,
  'guest' => l10n.dutiesKindGuest,
  _ => null,
};

/// Een kaart met een kopregel (hoofdletters) met optioneel een teller en
/// knoppen rechts, zoals `CardTitle` in de PWA.
class DutiesCard extends StatelessWidget {
  const DutiesCard({
    super.key,
    required this.title,
    required this.child,
    this.count,
    this.actions = const [],
  });

  final String title;
  final int? count;
  final List<Widget> actions;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: t.raised,
            padding: const EdgeInsets.fromLTRB(16, 6, 8, 6),
            constraints: const BoxConstraints(minHeight: 44),
            child: Row(
              children: [
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Text.rich(
                      TextSpan(
                        text: title.toUpperCase(),
                        children: [
                          if (count != null)
                            TextSpan(
                              text: '  $count',
                              style: TextStyle(color: t.muted),
                            ),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                        color: t.inkSoft,
                      ),
                    ),
                  ),
                ),
                ...actions,
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}

/// Klein label boven een formulierveld.
class DutiesFieldLabel extends StatelessWidget {
  const DutiesFieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
          color: t.muted,
        ),
      ),
    );
  }
}

/// Een foutmelding (bovenin een formulier of onder een veld).
class DutiesErrorText extends StatelessWidget {
  const DutiesErrorText(this.message, {super.key, this.bottom = 12});

  final String message;
  final double bottom;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: bottom, top: bottom == 0 ? 4 : 0),
    child: Text(
      message,
      style: const TextStyle(fontSize: 13, color: StatusColors.red600),
    ),
  );
}
