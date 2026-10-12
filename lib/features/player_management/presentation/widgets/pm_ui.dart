import 'package:flutter/material.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/player_management_models.dart';

/// De tekst bij een mislukte aanroep: Laravels `message` (of de eerste
/// veldfout) als die er is, anders een algemene melding.
String pmErrorText(AppLocalizations l10n, Object? error) => switch (error) {
  NetworkException() => l10n.errorNetwork,
  final ApiException e when e.message != null => e.message!,
  final ApiException e when e.errors.isNotEmpty =>
    e.errors.values.expand((m) => m).firstOrNull ?? l10n.errorGeneric,
  _ => l10n.errorGeneric,
};

/// De eerste veldfout voor [field] bij een 422, anders `null`.
String? pmFieldError(Object? error, String field) =>
    error is ValidationException ? error.fieldError(field) : null;

/// Fouttoast (met trilling).
void showPmError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: pmErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Succestoast (met trilling).
void showPmSuccess(BuildContext context, String title, {String? message}) {
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
Future<bool> confirmPm(
  BuildContext context, {
  required String message,
  String? title,
  String? confirmLabel,
  bool destructive = false,
}) async {
  final l10n = AppLocalizations.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: title == null ? null : Text(title),
      content: Text(message),
      actions: [
        TextButton(
          key: const ValueKey('pm-confirm-cancel'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.pmCancel),
        ),
        TextButton(
          key: const ValueKey('pm-confirm-ok'),
          onPressed: () => Navigator.of(context).pop(true),
          style: destructive
              ? TextButton.styleFrom(foregroundColor: StatusColors.red600)
              : null,
          child: Text(confirmLabel ?? l10n.pmConfirm),
        ),
      ],
    ),
  );
  return ok ?? false;
}

/// Naam van een bevoegdheid.
String abilityLabel(AppLocalizations l10n, String ability) => switch (ability) {
  PlayerAbility.lineup => l10n.pmAbilityLineup,
  PlayerAbility.trainingPoints => l10n.pmAbilityTrainingPoints,
  PlayerAbility.fines => l10n.pmAbilityFines,
  _ => ability,
};

/// Uitleg bij een bevoegdheid.
String abilityHint(AppLocalizations l10n, String ability) => switch (ability) {
  PlayerAbility.lineup => l10n.pmAbilityLineupHint,
  PlayerAbility.trainingPoints => l10n.pmAbilityTrainingPointsHint,
  PlayerAbility.fines => l10n.pmAbilityFinesHint,
  _ => '',
};

/// De functie (feature) waar een bevoegdheid bij hoort, of `null`.
String? abilityFeature(String ability) => switch (ability) {
  PlayerAbility.trainingPoints => 'training_points',
  PlayerAbility.fines => 'fines',
  _ => null,
};

/// Label van een uitnodigingsstand.
String inviteStatusLabel(AppLocalizations l10n, InviteStatus status) =>
    switch (status) {
      InviteStatus.none => l10n.pmInviteNone,
      InviteStatus.pending => l10n.pmInvitePending,
      InviteStatus.accepted || InviteStatus.unknown => l10n.pmInviteAccepted,
    };

/// Kleur van het stipje bij de avatar (`statusDotClass`).
Color inviteStatusColor(AssistjeTokens t, InviteStatus status) =>
    switch (status) {
      InviteStatus.none => t.muted.withValues(alpha: 0.6),
      InviteStatus.pending => StatusColors.amber400,
      InviteStatus.accepted || InviteStatus.unknown => StatusColors.emerald500,
    };

/// Een rij met titel, uitleg en schakelaar (`Toggle` in de PWA).
class PmToggleRow extends StatelessWidget {
  const PmToggleRow({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final bool value;

  /// `null` = uitgeschakeld.
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
      decoration: BoxDecoration(
        color: t.raised,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: t.ink,
                  ),
                ),
                if (subtitle != null && subtitle!.isNotEmpty)
                  Text(
                    subtitle!,
                    style: TextStyle(fontSize: 12, color: t.muted),
                  ),
              ],
            ),
          ),
          Switch.adaptive(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

/// Een melding in een gekleurd vlak (alleen-lezen, uitleg).
class PmNotice extends StatelessWidget {
  const PmNotice({super.key, required this.text, this.icon});

  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: t.raised,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: t.inkSoft),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 14, color: t.inkSoft)),
          ),
        ],
      ),
    );
  }
}

/// Een eenvoudige e-mailcheck (de server valideert echt).
bool looksLikeEmail(String value) =>
    RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim());

/// Een veldlabel boven een invoerveld.
class PmFieldLabel extends StatelessWidget {
  const PmFieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: t.inkSoft,
        ),
      ),
    );
  }
}
