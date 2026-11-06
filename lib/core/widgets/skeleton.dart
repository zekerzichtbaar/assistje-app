import 'package:flutter/material.dart';

import '../theme/assistje_tokens.dart';

/// Eén klok voor alle skeletons in de app, zodat de glans als één golf over
/// het scherm loopt (zoals native placeholders) in plaats van dat elk blok
/// los pulseert.
///
/// Staat bovenin de app (`MaterialApp.builder`). De klok tikt alleen zolang
/// er een [Skeleton] in beeld is en staat stil bij "minder beweging".
/// Zonder [ShimmerScope] (bijv. in een losse widgettest) is een skeleton een
/// stil blok.
class ShimmerScope extends StatefulWidget {
  const ShimmerScope({super.key, required this.child});

  final Widget child;

  /// Duur van één golf inclusief de rust erna.
  static const Duration period = Duration(milliseconds: 1600);

  static ShimmerController? maybeOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<_ShimmerInherited>()?.controller;

  @override
  State<ShimmerScope> createState() => _ShimmerScopeState();
}

/// De gedeelde klok; [progress] loopt 0 → 1 per golf.
class ShimmerController {
  ShimmerController._(this._controller);

  final AnimationController _controller;
  int _users = 0;
  bool _reduceMotion = false;
  DateTime? _lastGone;

  Animation<double> get progress => _controller;

  /// Of er nu een skeleton in beeld is, of er net eentje verdween. Dan komt
  /// er inhoud in de plaats van een laadstand en mag die infaden ([Reveal]);
  /// stond de data er al (bewaard), dan verschijnt hij meteen.
  bool get skeletonRecentlyVisible =>
      _users > 0 ||
      (_lastGone != null &&
          DateTime.now().difference(_lastGone!) <
              const Duration(milliseconds: 200));

  void _attach() {
    _users++;
    _sync();
  }

  /// [gone]: de skeleton is weg (vervangen door inhoud), niet alleen
  /// buiten beeld geraakt.
  void _detach({required bool gone}) {
    _users--;
    if (gone && _users == 0) _lastGone = DateTime.now();
    _sync();
  }

  void _setReduceMotion(bool value) {
    _reduceMotion = value;
    _sync();
  }

  void _sync() {
    final run = _users > 0 && !_reduceMotion;
    if (run && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!run && _controller.isAnimating) {
      _controller
        ..stop()
        ..value = 0;
    }
  }
}

class _ShimmerScopeState extends State<ShimmerScope>
    with SingleTickerProviderStateMixin {
  late final ShimmerController _shimmer = ShimmerController._(
    AnimationController(vsync: this, duration: ShimmerScope.period),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _shimmer._setReduceMotion(MediaQuery.disableAnimationsOf(context));
  }

  @override
  void dispose() {
    _shimmer._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _ShimmerInherited(controller: _shimmer, child: widget.child);
}

class _ShimmerInherited extends InheritedWidget {
  const _ShimmerInherited({required this.controller, required super.child});

  final ShimmerController controller;

  @override
  bool updateShouldNotify(_ShimmerInherited oldWidget) =>
      controller != oldWidget.controller;
}

/// Laadplaceholder: een blok in de `line`-kleur waar een zachte glans
/// overheen loopt (gedeeld via [ShimmerScope]).
///
/// Verschijnt pas na een kort moment ([appearDelay]) en fadet dan in: laadt
/// de data sneller, dan zie je geen flits van grijze blokken.
/// Respecteert "minder beweging": dan staat hij er meteen en stil.
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

  /// Hoe lang een skeleton onzichtbaar blijft voordat hij infadet.
  static const Duration appearDelay = Duration(milliseconds: 120);
  static const Duration _appearFade = Duration(milliseconds: 220);

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _appear = AnimationController(
    vsync: this,
    duration: Skeleton.appearDelay + Skeleton._appearFade,
  );
  late final Animation<double> _opacity = CurvedAnimation(
    parent: _appear,
    curve: Interval(
      Skeleton.appearDelay.inMicroseconds /
          (Skeleton.appearDelay + Skeleton._appearFade).inMicroseconds,
      1,
      curve: Curves.easeOut,
    ),
  );

  ShimmerController? _shimmer;

  /// Telt mee voor de gedeelde klok: alleen zolang hij echt in beeld is
  /// (een andere tab of een route eronder zet [TickerMode] uit).
  bool _attached = false;
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final shimmer = ShimmerScope.maybeOf(context);
    final onScreen = TickerMode.valuesOf(context).enabled;
    final attach = shimmer != null && onScreen;
    if (!identical(shimmer, _shimmer) || attach != _attached) {
      if (_attached) _shimmer!._detach(gone: false);
      _shimmer = shimmer;
      _attached = attach;
      if (attach) shimmer._attach();
    }
    if (!_started) {
      _started = true;
      if (MediaQuery.disableAnimationsOf(context)) {
        _appear.value = 1;
      } else {
        _appear.forward();
      }
    }
  }

  @override
  void dispose() {
    if (_attached) _shimmer!._detach(gone: true);
    _appear.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    final shimmer = _shimmer;
    final radius = BorderRadius.circular(widget.radius);
    Widget block = Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(color: t.line, borderRadius: radius),
    );
    if (shimmer != null && !MediaQuery.disableAnimationsOf(context)) {
      final dark = Theme.of(context).brightness == Brightness.dark;
      block = CustomPaint(
        foregroundPainter: _ShimmerPainter(
          progress: shimmer.progress,
          box: () => context.findRenderObject() as RenderBox?,
          screen: MediaQuery.sizeOf(context),
          highlight: Colors.white.withValues(alpha: dark ? 0.07 : 0.6),
          radius: radius,
        ),
        child: block,
      );
    }
    return ExcludeSemantics(
      child: FadeTransition(opacity: _opacity, child: block),
    );
  }
}

/// Tekent de glansband op de plek waar hij op het scherm staat: zo lopen
/// alle blokken als één diagonale golf mee.
class _ShimmerPainter extends CustomPainter {
  _ShimmerPainter({
    required this.progress,
    required this.box,
    required this.screen,
    required this.highlight,
    required this.radius,
  }) : super(repaint: progress);

  final Animation<double> progress;
  final RenderBox? Function() box;
  final Size screen;
  final Color highlight;
  final BorderRadius radius;

  static const double _band = 120;

  /// Hoeveel de golf per pixel naar beneden achterloopt (diagonaal).
  static const double _tilt = 0.35;

  static const Curve _sweep = Interval(0, 0.7, curve: Curves.easeInOut);

  @override
  void paint(Canvas canvas, Size size) {
    final t = _sweep.transform(progress.value);
    if (t <= 0 || t >= 1) return;
    final render = box();
    final origin = render != null && render.attached && render.hasSize
        ? render.localToGlobal(Offset.zero)
        : Offset.zero;
    // Band loopt van links buiten beeld tot rechts buiten beeld, plus de
    // vertraging voor blokken lager op het scherm.
    final travel = screen.width + 2 * _band + screen.height * _tilt;
    final centerGlobal = -_band + t * travel - origin.dy * _tilt;
    final center = centerGlobal - origin.dx;
    if (center + _band < 0 || center - _band > size.width) return;

    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader =
          LinearGradient(
            colors: [
              highlight.withValues(alpha: 0),
              highlight,
              highlight.withValues(alpha: 0),
            ],
          ).createShader(
            Rect.fromLTRB(center - _band, 0, center + _band, size.height),
          );
    canvas.drawRRect(radius.toRRect(rect), paint);
  }

  @override
  bool shouldRepaint(_ShimmerPainter old) =>
      old.highlight != highlight ||
      old.screen != screen ||
      old.radius != radius ||
      old.progress != progress;
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
