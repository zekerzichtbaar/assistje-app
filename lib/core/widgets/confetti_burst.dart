import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../theme/assistje_tokens.dart';
import 'status_colors.dart';

/// Legt een confetti-kanon over [child] (wrapper om het `confetti`-package).
///
/// Afvuren via `ConfettiBurst.of(context).fire()` vanuit een widget
/// eronder, of via een `GlobalKey<ConfettiBurstState>`. De kleuren zijn de
/// teamkleur plus de vrolijke PWA-accenten (smaragd, amber, lucht, roos).
class ConfettiBurst extends StatefulWidget {
  const ConfettiBurst({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 900),
    this.numberOfParticles = 24,
    this.alignment = Alignment.topCenter,
    this.colors,
  });

  final Widget child;

  /// Hoe lang het kanon blijft schieten.
  final Duration duration;
  final int numberOfParticles;

  /// Waar de explosie begint.
  final Alignment alignment;

  /// Overschrijft de standaardkleuren.
  final List<Color>? colors;

  /// De dichtstbijzijnde [ConfettiBurst] boven [context].
  static ConfettiBurstState of(BuildContext context) {
    final state = context.findAncestorStateOfType<ConfettiBurstState>();
    assert(state != null, 'Geen ConfettiBurst boven deze context.');
    return state!;
  }

  @override
  State<ConfettiBurst> createState() => ConfettiBurstState();
}

class ConfettiBurstState extends State<ConfettiBurst> {
  late final ConfettiController _controller = ConfettiController(
    duration: widget.duration,
  );

  /// Speelt de burst nu (opnieuw) af. Doet niets bij "minder beweging".
  void fire() {
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) return;
    _controller.play();
  }

  /// Stopt direct (deeltjes in de lucht vallen nog uit).
  void stop() => _controller.stop();

  /// Of het kanon nu schiet.
  bool get isPlaying => _controller.state == ConfettiControllerState.playing;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: IgnorePointer(
            child: Align(
              alignment: widget.alignment,
              child: ConfettiWidget(
                confettiController: _controller,
                blastDirectionality: BlastDirectionality.explosive,
                numberOfParticles: widget.numberOfParticles,
                emissionFrequency: 0.05,
                gravity: 0.25,
                minimumSize: const Size(8, 4),
                maximumSize: const Size(14, 7),
                colors:
                    widget.colors ??
                    [
                      t.primary,
                      StatusColors.emerald500,
                      StatusColors.amber200,
                      StatusColors.sky400,
                      StatusColors.rose500,
                    ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
