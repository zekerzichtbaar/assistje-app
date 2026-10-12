import 'package:flutter/material.dart';

import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../agenda/data/models/agenda_models.dart';

/// Groepslabel per antwoord (`statusLabel` in de PWA).
String eventStatusLabel(AppLocalizations l10n, AttendanceStatus status) =>
    switch (status) {
      AttendanceStatus.present => l10n.eventDetailStatusPresent,
      AttendanceStatus.absent => l10n.eventDetailStatusAbsent,
      AttendanceStatus.nonplay => l10n.eventDetailStatusNonplay,
      AttendanceStatus.pending => l10n.eventDetailStatusPending,
    };

/// Statuskleuren van een antwoord.
AttendanceStatusStyle eventStatusStyle(
  BuildContext context,
  AttendanceStatus status,
) => AttendanceStatusStyle.of(context, AttendanceTone.fromApi(status.name));

/// Een kaart met een kopregel (`bg-raised`, hoofdletters) en een
/// optioneel pilletje rechts, zoals de groepskaarten op de eventpagina.
class EventSectionCard extends StatelessWidget {
  const EventSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.titleColor,
    this.icon,
  });

  final String title;
  final Widget child;
  final Widget? trailing;
  final Color? titleColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final color = titleColor ?? t.muted;
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
                  Icon(icon, size: 16, color: color),
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
                        color: color,
                      ),
                    ),
                  ),
                ),
                ?trailing,
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}

/// Klein getal-pilletje in een statuskleur.
class CountPill extends StatelessWidget {
  const CountPill({
    super.key,
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: foreground,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}
