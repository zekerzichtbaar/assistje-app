import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/training_teams_models.dart';

/// Kleuren van één ploeg (`SIDES` in `lib/trainingTeams.ts`): een stip, tekst
/// en een zachte achtergrond.
class SideStyle {
  const SideStyle(this.dot, this.text, this.soft, this.darkText);

  final Color dot;
  final Color text;
  final Color soft;
  final Color darkText;

  /// Zes kanten met een eigen kleur (Tailwind blue/orange/emerald/violet/
  /// rose/amber), op volgorde van `sides`.
  static const List<SideStyle> palette = [
    SideStyle(
      Color(0xFF3B82F6),
      Color(0xFF1D4ED8),
      Color(0xFFEFF6FF),
      Color(0xFF93C5FD),
    ),
    SideStyle(
      Color(0xFFF97316),
      Color(0xFFC2410C),
      Color(0xFFFFF7ED),
      Color(0xFFFDBA74),
    ),
    SideStyle(
      Color(0xFF10B981),
      Color(0xFF047857),
      Color(0xFFECFDF5),
      Color(0xFF6EE7B7),
    ),
    SideStyle(
      Color(0xFF8B5CF6),
      Color(0xFF6D28D9),
      Color(0xFFF5F3FF),
      Color(0xFFC4B5FD),
    ),
    SideStyle(
      Color(0xFFF43F5E),
      Color(0xFFBE123C),
      Color(0xFFFFF1F2),
      Color(0xFFFDA4AF),
    ),
    SideStyle(
      StatusColors.amber500,
      StatusColors.amber700,
      StatusColors.amber50,
      StatusColors.amber300,
    ),
  ];

  /// De stijl van ploeg nummer [number] (1-based).
  static SideStyle of(int number) =>
      palette[(number - 1).clamp(0, palette.length - 1)];

  Color textOn(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkText : text;

  Color softOn(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? dot.withValues(alpha: 0.15)
      : soft;
}

/// "Team n" voor ploeg [side].
String sideLabel(AppLocalizations l10n, TrainingTeams data, String side) =>
    l10n.trainingTeamsSideLabel(data.sideNumber(side));

/// Label en uitleg per basis.
(String, String) basisCopy(AppLocalizations l10n, TrainingBasis basis) =>
    switch (basis) {
      TrainingBasis.strength => (
        l10n.trainingTeamsBasisStrength,
        l10n.trainingTeamsBasisStrengthHint,
      ),
      TrainingBasis.points => (
        l10n.trainingTeamsBasisPoints,
        l10n.trainingTeamsBasisPointsHint,
      ),
      TrainingBasis.random => (
        l10n.trainingTeamsBasisRandom,
        l10n.trainingTeamsBasisRandomHint,
      ),
    };

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is,
/// anders een algemene melding.
String trainingTeamsErrorText(AppLocalizations l10n, Object? error) =>
    switch (error) {
      NetworkException() => l10n.errorNetwork,
      final ApiException e when e.message != null => e.message!,
      _ => l10n.errorGeneric,
    };

/// Fouttoast (met trilling).
void showTrainingTeamsError(
  BuildContext context,
  Object? error, {
  String? title,
}) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title ?? l10n.trainingTeamsSaveFailed,
    message: trainingTeamsErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// Succestoast (met trilling).
void showTrainingTeamsSuccess(BuildContext context, String title) {
  Haptics.success();
  showAppToast(
    context,
    title: title,
    closeLabel: AppLocalizations.of(context).close,
  );
}

/// Vraagt bevestiging voor iets destructiefs — `true` als bevestigd.
Future<bool> confirmTrainingTeams(
  BuildContext context, {
  required String question,
  required String confirmLabel,
}) async {
  final l10n = AppLocalizations.of(context);
  final ok = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(question),
      actions: [
        TextButton(
          key: const ValueKey('training-teams-confirm-cancel'),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.trainingTeamsCancel),
        ),
        TextButton(
          key: const ValueKey('training-teams-confirm-ok'),
          onPressed: () => Navigator.of(context).pop(true),
          style: TextButton.styleFrom(foregroundColor: StatusColors.red600),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return ok ?? false;
}

/// Een kaart met een kopregel en een icoon (`CardTitle` in de PWA).
class TrainingCard extends StatelessWidget {
  const TrainingCard({
    super.key,
    required this.title,
    required this.icon,
    required this.children,
    this.iconColor,
    this.titleTrailing,
  });

  final String title;
  final IconData icon;
  final Color? iconColor;
  final Widget? titleTrailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              children: [
                PhosphorIcon(icon, size: 16, color: iconColor ?? t.primary),
                const SizedBox(width: 8),
                Flexible(
                  child: Semantics(
                    header: true,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: t.ink,
                      ),
                    ),
                  ),
                ),
                if (titleTrailing != null) ...[
                  const SizedBox(width: 6),
                  titleTrailing!,
                ],
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}

/// Een kleine grijze knop met icoon (`bg-raised` in de PWA).
class SoftButton extends StatelessWidget {
  const SoftButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.background,
    this.foreground,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final fg = foreground ?? t.inkSoft;
    return Opacity(
      opacity: onPressed == null ? 0.5 : 1,
      child: Material(
        color: background ?? t.raised,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  PhosphorIcon(icon!, size: 15, color: fg),
                  const SizedBox(width: 6),
                ],
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: fg,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Min/plus-knopje van de steppers.
class StepButton extends StatelessWidget {
  const StepButton({
    super.key,
    required this.icon,
    required this.semanticLabel,
    required this.onPressed,
  });

  final IconData icon;
  final String semanticLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Semantics(
      button: true,
      label: semanticLabel,
      excludeSemantics: true,
      child: Opacity(
        opacity: onPressed == null ? 0.3 : 1,
        child: Material(
          color: t.raised,
          borderRadius: BorderRadius.circular(8),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onPressed,
            child: SizedBox(
              width: 32,
              height: 32,
              child: Center(
                child: PhosphorIcon(icon, size: 14, color: t.inkSoft),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
