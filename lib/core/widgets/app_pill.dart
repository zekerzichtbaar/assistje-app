import 'package:flutter/material.dart';

import '../theme/assistje_tokens.dart';

/// Losse ronde chip met geselecteerd-staat (filters, keuzes).
///
/// Niet geselecteerd: `bg-sunken text-ink-soft`; geselecteerd: teamkleur met
/// contrasttekst — dezelfde verhouding als de RSVP-knoppen in de PWA.
class AppPill extends StatelessWidget {
  const AppPill({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.icon,
    this.selectedColor,
    this.selectedForeground,
  });

  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final IconData? icon;

  /// Overschrijft de teamkleur als selectiekleur (bijv. een statuskleur).
  final Color? selectedColor;
  final Color? selectedForeground;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final bg = selected ? (selectedColor ?? t.primary) : t.sunken;
    final fg = selected ? (selectedForeground ?? t.primaryContrast) : t.inkSoft;
    return Semantics(
      button: onTap != null,
      selected: selected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: fg),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: fg,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Eén tab in [AppTabPills].
@immutable
class AppTabPill<T> {
  const AppTabPill({required this.value, required this.label, this.icon});

  final T value;
  final String label;
  final IconData? icon;
}

/// Segmented control als ronde baan met pills (`TabPills.tsx`).
///
/// Baan `bg-track/60` (of vol met [darkTrack]), actieve knop `bg-control`
/// met `shadow-sm` en tekst in de teamkleur.
class AppTabPills<T> extends StatelessWidget {
  const AppTabPills({
    super.key,
    required this.tabs,
    required this.selected,
    required this.onChanged,
    this.fullWidth = false,
    this.darkTrack = false,
  });

  final List<AppTabPill<T>> tabs;
  final T selected;
  final ValueChanged<T> onChanged;
  final bool fullWidth;

  /// Iets donkerdere baan, voor gebruik op een grijze achtergrond.
  final bool darkTrack;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    Widget item(AppTabPill<T> tab) {
      final active = tab.value == selected;
      final fg = active ? t.primary : t.inkSoft;
      final pill = Semantics(
        button: true,
        selected: active,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => onChanged(tab.value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: active ? t.control : const Color(0x00000000),
              borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
              boxShadow: active ? AssistjeTokens.shadowSm : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (tab.icon != null) ...[
                  Icon(tab.icon, size: 16, color: fg),
                  const SizedBox(width: 6),
                ],
                Text(
                  tab.label,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: fg,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      return fullWidth ? Expanded(child: pill) : pill;
    }

    final children = <Widget>[];
    for (var i = 0; i < tabs.length; i++) {
      if (i > 0) children.add(const SizedBox(width: 4));
      children.add(item(tabs[i]));
    }

    final row = Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      children: children,
    );

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: darkTrack ? t.track : t.track.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
      ),
      child: fullWidth
          ? row
          : SingleChildScrollView(scrollDirection: Axis.horizontal, child: row),
    );
  }
}
