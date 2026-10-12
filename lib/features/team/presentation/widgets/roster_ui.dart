import 'package:flutter/material.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is,
/// anders een algemene melding.
String rosterErrorText(AppLocalizations l10n, Object? error) => switch (error) {
  NetworkException() => l10n.errorNetwork,
  final ApiException e when e.message != null => e.message!,
  _ => l10n.errorGeneric,
};

/// Toont een fouttoast (met trilling).
void showRosterError(BuildContext context, String title, Object? error) {
  final l10n = AppLocalizations.of(context);
  Haptics.error();
  showAppToast(
    context,
    title: title,
    message: rosterErrorText(l10n, error),
    variant: AppToastVariant.error,
    closeLabel: l10n.close,
  );
}

/// De schermtitel. Zelfde key als de placeholder: de shell-tests lezen de
/// titel via `placeholder-title`.
class RosterScreenTitle extends StatelessWidget {
  const RosterScreenTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
      child: Semantics(
        header: true,
        child: Text(
          text,
          key: const Key('placeholder-title'),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 28,
            height: 1.15,
            fontWeight: FontWeight.w700,
            color: t.ink,
          ),
        ),
      ),
    );
  }
}

/// Klein label in een statuskleur: geblesseerd, vakantie, gast, aanvoerder.
class RosterBadge extends StatelessWidget {
  const RosterBadge({
    super.key,
    required this.label,
    required this.tone,
    this.large = false,
  });

  /// Gast/aanvoerder in amber (zoals de PWA).
  const RosterBadge.amber({super.key, required this.label, this.large = false})
    : tone = null;

  final String label;

  /// `null` = amber.
  final AttendanceTone? tone;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final Color background;
    final Color foreground;
    final tone = this.tone;
    if (tone == null) {
      background = dark
          ? StatusColors.amber500.withValues(alpha: 0.2)
          : StatusColors.amber100;
      foreground = dark ? StatusColors.amber200 : StatusColors.amber900;
    } else {
      final style = AttendanceStatusStyle.of(context, tone);
      background = style.softBackground;
      foreground = style.softForeground;
    }
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: large ? 8 : 6,
        vertical: large ? 2 : 1,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusSm + 2),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: large ? 12 : 10,
          fontWeight: FontWeight.w500,
          color: foreground,
        ),
      ),
    );
  }
}

/// Een kaart met een kopregel (`CardTitle` in de PWA) en rijen eronder.
class RosterSectionCard extends StatelessWidget {
  const RosterSectionCard({
    super.key,
    required this.title,
    required this.children,
    this.icon,
    this.iconColor,
    this.trailing,
  });

  final String title;
  final List<Widget> children;
  final IconData? icon;
  final Color? iconColor;
  final Widget? trailing;

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 16, color: iconColor ?? t.muted),
                  const SizedBox(width: 6),
                ],
                Expanded(
                  child: Semantics(
                    header: true,
                    child: Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                        color: t.muted,
                      ),
                    ),
                  ),
                ),
                ?trailing,
              ],
            ),
          ),
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) Divider(height: 1, thickness: 1, color: t.lineSoft),
            children[i],
          ],
        ],
      ),
    );
  }
}
