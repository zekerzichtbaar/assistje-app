import 'package:flutter/material.dart';

import '../theme/assistje_tokens.dart';

/// Ronde avatar (`Avatar.tsx`): initialen op `raised`, met de foto eroverheen
/// zodra die geladen is. Faalt de foto, dan blijven de initialen staan.
///
/// Optioneel een gekleurde [ring] (bijv. teamkleur of status) en een
/// [statusColor]-stip rechtsonder.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    required this.name,
    this.imageUrl,
    this.size = 40,
    this.ring,
    this.ringWidth = 2,
    this.statusColor,
  });

  final String name;
  final String? imageUrl;

  /// Diameter. PWA-maten: xs 24, sm 32, smd 36, md 40, lg 56, xl 80.
  final double size;
  final Color? ring;
  final double ringWidth;
  final Color? statusColor;

  /// Max. twee initialen uit de eerste twee woorden, in hoofdletters; `?` als
  /// er niets bruikbaars is.
  static String initialsOf(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    final out = parts.take(2).map((p) => p.characters.first).join();
    return out.isEmpty ? '?' : out.toUpperCase();
  }

  double get _fontSize {
    if (size <= 24) return 10;
    if (size <= 36) return 11;
    if (size <= 40) return 12;
    if (size <= 56) return 16;
    return 18;
  }

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final url = imageUrl;

    final circle = Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: t.raised,
        shape: BoxShape.circle,
        boxShadow: AssistjeTokens.shadowSm,
        // ring-1 ring-ink/10, of de opgegeven ring.
        border: Border.all(
          color: ring ?? t.ink.withValues(alpha: 0.1),
          width: ring == null ? 1 : ringWidth,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Text(
              initialsOf(name),
              style: TextStyle(
                fontSize: _fontSize,
                fontWeight: FontWeight.w500,
                color: t.inkSoft,
              ),
            ),
          ),
          if (url != null && url.isNotEmpty)
            Image.network(
              url,
              fit: BoxFit.cover,
              excludeFromSemantics: true,
              frameBuilder: (context, child, frame, sync) {
                if (sync) return child;
                return AnimatedOpacity(
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: child,
                );
              },
              errorBuilder: (context, error, stack) => const SizedBox.shrink(),
            ),
        ],
      ),
    );

    final dot = statusColor;
    if (dot == null) return Semantics(label: name, child: circle);

    final dotSize = (size * 0.28).clamp(8.0, 16.0);
    return Semantics(
      label: name,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            circle,
            Positioned(
              right: -1,
              bottom: -1,
              child: Container(
                key: const ValueKey('app-avatar-status'),
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(
                  color: dot,
                  shape: BoxShape.circle,
                  border: Border.all(color: t.surface, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
