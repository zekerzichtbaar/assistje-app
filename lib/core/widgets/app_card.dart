import 'package:flutter/material.dart';

import '../theme/assistje_tokens.dart';

/// Vlakke kaart: `rounded-2xl bg-surface`, in donker een haarlijn als rand.
///
/// Geen schaduw (de PWA-kaarten zijn plat). Met [onTap] wordt de hele kaart
/// tikbaar met een ripple binnen de ronding.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
    this.color,
    this.radius = AssistjeTokens.radius2xl,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  /// Overschrijft `surface` (bijv. `raised` voor een kaart in een kaart).
  final Color? color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
      side: BorderSide(color: t.surfaceHairline),
    );
    return Material(
      color: color ?? t.surface,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: onTap == null
          ? Padding(padding: padding, child: child)
          : InkWell(
              onTap: onTap,
              child: Padding(padding: padding, child: child),
            ),
    );
  }
}
