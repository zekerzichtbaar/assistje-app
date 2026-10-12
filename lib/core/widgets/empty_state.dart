import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../theme/assistje_tokens.dart';
import 'status_colors.dart';

/// Standaard "leeg"-blok (`EmptyState.tsx`): duotone-icoon in een zacht
/// afgerond vlak met decoratieve stipjes, titel, toelichting en een
/// optionele actie.
///
/// Geef een Phosphor-duotone-icoon mee, bijv. `PhosphorIconsDuotone.calendarBlank`.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? description;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;

    Widget dot(double size, Color color) => Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: -24,
                  top: 8,
                  child: dot(
                    12,
                    dark
                        ? StatusColors.emerald500.withValues(alpha: 0.2)
                        : StatusColors.emerald100,
                  ),
                ),
                Positioned(
                  right: -28,
                  top: 24,
                  child: dot(8, StatusColors.amber200),
                ),
                Positioned(
                  left: -12,
                  bottom: -4,
                  child: dot(6, StatusColors.sky200),
                ),
                Positioned(
                  right: 8,
                  bottom: -12,
                  child: dot(
                    10,
                    dark
                        ? StatusColors.rose500.withValues(alpha: 0.2)
                        : StatusColors.rose100,
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AssistjeTokens.radius3xl,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [t.raised, t.surface, t.raised],
                    ),
                    border: Border.all(color: t.ink.withValues(alpha: 0.1)),
                    boxShadow: AssistjeTokens.shadowSm,
                  ),
                  alignment: Alignment.center,
                  child: PhosphorIcon(icon, size: 36, color: t.muted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: t.ink,
            ),
          ),
          if (description != null)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, height: 1.6, color: t.muted),
                ),
              ),
            ),
          if (action != null)
            Padding(padding: const EdgeInsets.only(top: 20), child: action),
        ],
      ),
    );
  }
}
