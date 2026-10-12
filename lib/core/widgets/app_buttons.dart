import 'package:flutter/material.dart';

import '../theme/assistje_tokens.dart';

/// Hoofdactie: pill in de teamkleur (`PrimaryButton.tsx`).
///
/// `h-10 rounded-full px-5 text-sm font-semibold`, krimpt bij indrukken
/// (`active:scale-95`) en is half doorzichtig als hij uit staat.
/// Met [loading] toont hij een spinner en negeert hij tikken.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool loading;

  /// Volle breedte (voor formulieren en sheets).
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return AppButtonBase(
      label: label,
      onPressed: onPressed,
      icon: icon,
      loading: loading,
      expand: expand,
      background: t.primary,
      foreground: t.primaryContrast,
    );
  }
}

/// Secundaire actie: witte pill met rand (`Button.tsx` variant secondary).
class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.loading = false,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool loading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return AppButtonBase(
      label: label,
      onPressed: onPressed,
      icon: icon,
      loading: loading,
      expand: expand,
      background: t.surface,
      foreground: t.ink,
      border: t.line,
      fontWeight: FontWeight.w500,
      horizontalPadding: 16,
    );
  }
}

/// Gedeelde pill-knop achter [PrimaryButton] en [SecondaryButton].
///
/// Publiek voor varianten (bijv. een rode destructieve knop), maar schermen
/// gebruiken bij voorkeur de twee hierboven.
class AppButtonBase extends StatefulWidget {
  const AppButtonBase({
    super.key,
    required this.label,
    required this.onPressed,
    required this.background,
    required this.foreground,
    this.icon,
    this.loading = false,
    this.expand = false,
    this.border,
    this.fontWeight = FontWeight.w600,
    this.horizontalPadding = 20,
    this.height = 40,
  });

  final String label;
  final VoidCallback? onPressed;
  final Color background;
  final Color foreground;
  final Widget? icon;
  final bool loading;
  final bool expand;
  final Color? border;
  final FontWeight fontWeight;
  final double horizontalPadding;
  final double height;

  @override
  State<AppButtonBase> createState() => _AppButtonBaseState();
}

class _AppButtonBaseState extends State<AppButtonBase> {
  bool _pressed = false;

  bool get _enabled => widget.onPressed != null && !widget.loading;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final fg = widget.foreground;
    final content = Row(
      mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.loading)
          SizedBox.square(
            dimension: 16,
            child: CircularProgressIndicator(
              key: const ValueKey('app-button-spinner'),
              strokeWidth: 2,
              color: fg,
            ),
          )
        else if (widget.icon != null)
          IconTheme.merge(
            data: IconThemeData(color: fg, size: 18),
            child: widget.icon!,
          ),
        if (widget.loading || widget.icon != null) const SizedBox(width: 8),
        Flexible(
          child: Text(
            widget.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: fg,
              fontSize: 14,
              fontWeight: widget.fontWeight,
            ),
          ),
        ),
      ],
    );

    return Semantics(
      button: true,
      enabled: _enabled,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: _enabled ? (_) => _setPressed(true) : null,
        onTapUp: _enabled ? (_) => _setPressed(false) : null,
        onTapCancel: _enabled ? () => _setPressed(false) : null,
        onTap: _enabled ? widget.onPressed : null,
        child: AnimatedScale(
          scale: _pressed ? 0.95 : 1,
          duration: const Duration(milliseconds: 120),
          child: AnimatedOpacity(
            // Alleen "uit" is half doorzichtig; laden houdt de kleur vol.
            opacity: widget.onPressed == null ? 0.5 : 1,
            duration: const Duration(milliseconds: 150),
            child: Container(
              height: widget.height,
              width: widget.expand ? double.infinity : null,
              padding: EdgeInsets.symmetric(
                horizontal: widget.horizontalPadding,
              ),
              decoration: BoxDecoration(
                color: widget.background,
                borderRadius: BorderRadius.circular(AssistjeTokens.radiusFull),
                border: widget.border == null
                    ? null
                    : Border.all(color: widget.border!),
              ),
              alignment: Alignment.center,
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}
