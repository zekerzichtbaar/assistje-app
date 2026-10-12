import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/widgets/widgets.dart';
import '../../application/wheel_math.dart';
import 'wheel_painter.dart';

/// Het rad met zijn draai-animatie. Draaien via
/// `GlobalKey<WheelSpinnerState>().currentState!.spinTo(index)`: het rad
/// loopt [wheelSpinDuration] uit tot segment `index` onder de wijzer staat,
/// met een tik (haptiek) per segment dat de wijzer passeert.
class WheelSpinner extends StatefulWidget {
  const WheelSpinner({super.key, required this.names, this.semanticLabel});

  /// De namen op het rad, in volgorde van de segmenten.
  final List<String> names;
  final String? semanticLabel;

  @override
  State<WheelSpinner> createState() => WheelSpinnerState();
}

class WheelSpinnerState extends State<WheelSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: wheelSpinDuration,
  )..addListener(_tick);

  double _rotation = 0;
  double _from = 0;
  double _to = 0;
  int _lastSegment = -1;

  /// De huidige rotatie in graden.
  double get rotation => _rotation;

  bool get isSpinning => _controller.isAnimating;

  void _tick() {
    final next = _from + (_to - _from) * wheelEase(_controller.value);
    final segment = segmentAt(next, widget.names.length);
    if (segment != _lastSegment) {
      _lastSegment = segment;
      unawaited(Haptics.selection());
    }
    setState(() => _rotation = next);
  }

  /// Draait naar segment [winnerIndex]; klaar als het rad stilstaat.
  Future<void> spinTo(int winnerIndex) async {
    final count = widget.names.length;
    if (count == 0 || _controller.isAnimating) return;
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    _from = _rotation;
    _to = spinTargetRotation(
      current: _rotation,
      winnerIndex: winnerIndex,
      count: count,
      fullTurns: reduce ? 1 : wheelFullTurns,
    );
    _lastSegment = segmentAt(_rotation, count);
    _controller.duration = reduce
        ? wheelReducedSpinDuration
        : wheelSpinDuration;
    await _controller.forward(from: 0);
    if (mounted) setState(() => _rotation = _to);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.names.length;
    final spinning = _controller.isAnimating;
    return Semantics(
      label: widget.semanticLabel,
      image: true,
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomPaint(
          key: const ValueKey('wheel-canvas'),
          painter: WheelPainter(
            names: widget.names,
            rotation: _rotation,
            pointerTilt: spinning ? pointerTilt(_rotation, count) : 0,
            bulbPhase: spinning ? (_controller.value * 6) % 1 : 0,
            spinning: spinning,
          ),
        ),
      ),
    );
  }
}
