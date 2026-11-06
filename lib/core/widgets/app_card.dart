import 'package:flutter/material.dart';

import '../theme/assistje_tokens.dart';

/// Vlakke kaart: `rounded-2xl bg-surface`, in donker een haarlijn als rand.
///
/// Geen schaduw (de PWA-kaarten zijn plat). Met [onTap] wordt de hele kaart
/// tikbaar en reageert hij direct op je vinger: hij deukt licht in en kleurt
/// een tikje donkerder (iOS, waar geen ripple is) of rimpelt (Android).
class AppCard extends StatefulWidget {
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

  /// Schaal terwijl de kaart ingedrukt is.
  static const double pressedScale = 0.98;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  void didUpdateWidget(AppCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.onTap == null) _pressed = false;
  }

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(widget.radius),
      side: BorderSide(color: t.surfaceHairline),
    );
    final platform = Theme.of(context).platform;
    final cupertino =
        platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;

    final card = Material(
      color: widget.color ?? t.surface,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: widget.onTap == null
          ? Padding(padding: widget.padding, child: widget.child)
          : InkWell(
              onTap: widget.onTap,
              onHighlightChanged: _setPressed,
              // iOS heeft geen ripple: een korte, zachte verdonkering zoals
              // een ingedrukte lijstcel.
              highlightColor: cupertino ? t.ink.withValues(alpha: 0.05) : null,
              child: Padding(padding: widget.padding, child: widget.child),
            ),
    );
    // Altijd dezelfde boom, zodat aan/uit zetten van [onTap] geen state kost.
    return AnimatedScale(
      scale: _pressed ? AppCard.pressedScale : 1,
      duration: Duration(milliseconds: _pressed ? 90 : 160),
      curve: Curves.easeOut,
      child: card,
    );
  }
}
