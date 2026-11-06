import 'package:flutter/material.dart';

import 'skeleton.dart';

/// Laat inhoud zacht binnenkomen als hij de skeleton vervangt: korte fade
/// plus een paar pixels omhoog, in plaats van een harde wissel.
///
/// Alleen als de inhoud een skeleton vervangt. Staat de data er al bij het
/// openen (bewaard), dan verschijnt hij meteen: dat is wat native apps ook
/// doen. Respecteert "minder beweging".
class Reveal extends StatefulWidget {
  const Reveal({super.key, required this.child, this.offset = 8});

  final Widget child;

  /// Hoeveel pixels de inhoud omhoog schuift tijdens het binnenkomen.
  final double offset;

  static const Duration duration = Duration(milliseconds: 260);

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Reveal.duration,
    value: 1,
  );
  late final Animation<double> _curve = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );
  bool _decided = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_decided) return;
    _decided = true;
    if (shouldReveal(context)) _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curve,
      child: widget.child,
      builder: (context, child) => Opacity(
        opacity: _curve.value,
        child: Transform.translate(
          offset: Offset(0, (1 - _curve.value) * widget.offset),
          child: child,
        ),
      ),
    );
  }
}

/// Sliver-variant van [Reveal] (alleen de fade; slivers schuiven niet).
class SliverReveal extends StatefulWidget {
  const SliverReveal({super.key, required this.sliver});

  final Widget sliver;

  @override
  State<SliverReveal> createState() => _SliverRevealState();
}

class _SliverRevealState extends State<SliverReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Reveal.duration,
    value: 1,
  );
  late final Animation<double> _curve = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );
  bool _decided = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_decided) return;
    _decided = true;
    if (shouldReveal(context)) _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      SliverFadeTransition(opacity: _curve, sliver: widget.sliver);
}

/// Of inhoud die nu in beeld komt moet infaden: alleen als hij een
/// skeleton vervangt (zie [ShimmerController.skeletonRecentlyVisible]) en
/// niet bij "minder beweging".
bool shouldReveal(BuildContext context) {
  if (MediaQuery.disableAnimationsOf(context)) return false;
  return ShimmerScope.maybeOf(context)?.skeletonRecentlyVisible ?? false;
}
