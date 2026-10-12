import 'package:flutter/material.dart';

import '../theme/assistje_tokens.dart';

/// Laadplaceholder (`Skeleton.tsx`): een `bg-line`-blok dat zacht pulseert,
/// net als Tailwind `animate-pulse` (2 s, opacity 1 → 0.5 → 1).
///
/// Zonder extra package: één [AnimationController] per blok. Respecteert
/// "minder beweging" (`MediaQuery.disableAnimations`): dan staat hij stil.
class Skeleton extends StatefulWidget {
  const Skeleton({
    super.key,
    this.width,
    this.height = 16,
    this.radius = AssistjeTokens.radiusMd,
  });

  /// Rond blok (avatar-placeholder).
  const Skeleton.circle({super.key, required double size})
    : width = size,
      height = size,
      radius = AssistjeTokens.radiusFull;

  final double? width;
  final double height;
  final double radius;

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  // Tailwind pulse: cubic-bezier(0.4, 0, 0.6, 1), 50% → opacity .5.
  late final Animation<double> _opacity = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 1, end: 0.5), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 0.5, end: 1), weight: 1),
  ]).chain(CurveTween(curve: const Cubic(0.4, 0, 0.6, 1))).animate(_controller);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return ExcludeSemantics(
      child: FadeTransition(
        opacity: _opacity,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: t.line,
            borderRadius: BorderRadius.circular(widget.radius),
          ),
        ),
      ),
    );
  }
}

/// Eén lijstrij-placeholder: rond avatar-blok plus twee tekstregels
/// (`SkeletonRow` in de PWA).
class SkeletonRow extends StatelessWidget {
  const SkeletonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Skeleton.circle(size: 40),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton(width: 128),
                SizedBox(height: 8),
                Skeleton(width: 192, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// [count] keer een [SkeletonRow] onder elkaar (niet scrollend; zet hem zelf
/// in een lijst of kaart).
class SkeletonList extends StatelessWidget {
  const SkeletonList({super.key, this.count = 5});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [for (var i = 0; i < count; i++) const SkeletonRow()],
    );
  }
}
