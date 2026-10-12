import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../application/wheel_math.dart';

/// Casino-goud uit de PWA.
const Color wheelGold = Color(0xFFD4AF37);
const Color wheelGoldLight = Color(0xFFF0D666);
const Color wheelGoldDark = Color(0xFFA07B1E);
const Color _black = Color(0xFF0A0A0A);
const Color _segmentDark = Color(0xFF111111);
const Color _segmentLight = Color(0xFFFAFAFA);

/// Tekent het rad zoals de SVG in `Pages/Wheel.tsx`: zwarte rand met dubbele
/// gouden ring en lampjes, zwart-witte segmenten met namen, gouden naaf met
/// het aantal deelnemers, en bovenaan de gouden wijzer.
///
/// Alles in een 100×100-coördinatenstelsel (zoals de `viewBox`), geschaald
/// naar de canvasgrootte. [rotation] in graden (met de klok mee),
/// [pointerTilt] in graden, [bulbPhase] 0..1 laat de lampjes rondlopen.
class WheelPainter extends CustomPainter {
  WheelPainter({
    required this.names,
    required this.rotation,
    this.pointerTilt = 0,
    this.bulbPhase = 0,
    this.spinning = false,
  });

  final List<String> names;
  final double rotation;
  final double pointerTilt;
  final double bulbPhase;
  final bool spinning;

  static const int bulbCount = 24;

  static Offset _polar(double r, double angleDeg) {
    final rad = (angleDeg - 90) * math.pi / 180;
    return Offset(50 + r * math.cos(rad), 50 + r * math.sin(rad));
  }

  @override
  void paint(Canvas canvas, Size size) {
    final side = math.min(size.width, size.height);
    canvas
      ..save()
      ..translate((size.width - side) / 2, (size.height - side) / 2)
      ..scale(side / 100);

    const center = Offset(50, 50);
    final ringShader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [wheelGoldLight, wheelGold, wheelGoldDark],
    ).createShader(const Rect.fromLTWH(0, 0, 100, 100));
    final hubShader = const RadialGradient(
      center: Alignment(0, -0.2),
      radius: 0.6,
      colors: [wheelGoldLight, wheelGold, wheelGoldDark],
      stops: [0, 0.7, 1],
    ).createShader(Rect.fromCircle(center: center, radius: 10));

    // Schaduw onder het rad.
    canvas.drawCircle(
      center.translate(0, 3),
      49,
      Paint()
        ..color = const Color(0x40000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
    );

    // Rand: zwart, goud, zwart, goud.
    canvas
      ..drawCircle(center, 49.5, Paint()..color = _black)
      ..drawCircle(center, 48.5, Paint()..shader = ringShader)
      ..drawCircle(center, 44.5, Paint()..color = _black)
      ..drawCircle(center, 43.5, Paint()..shader = ringShader)
      ..drawCircle(
        center,
        42,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.4
          ..color = wheelGoldDark,
      );

    _paintBulbs(canvas);

    // Het draaiende deel.
    canvas
      ..save()
      ..translate(50, 50)
      ..rotate(rotation * math.pi / 180)
      ..translate(-50, -50);
    _paintSegments(canvas, hubShader);
    canvas.restore();

    // Naaf met het aantal.
    canvas
      ..drawCircle(center, 10, Paint()..color = _black)
      ..drawCircle(center, 9, Paint()..shader = hubShader)
      ..drawCircle(center, 6.5, Paint()..color = _black);
    _paintText(
      canvas,
      '${names.length}',
      center,
      fontSize: 5,
      color: wheelGoldLight,
      weight: FontWeight.w900,
    );

    _paintPointer(canvas);
    canvas.restore();
  }

  void _paintBulbs(Canvas canvas) {
    for (var i = 0; i < bulbCount; i++) {
      final pos = _polar(46.5, i * 360 / bulbCount);
      // Een lichtje dat rondloopt (tijdens het draaien) of om-en-om brandt.
      final distance = ((i / bulbCount) - bulbPhase) % 1;
      final lit = spinning ? distance < 0.18 : i.isEven;
      canvas
        ..drawCircle(pos, 1.3, Paint()..color = wheelGoldDark)
        ..drawCircle(
          pos,
          1.3,
          Paint()
            ..shader = RadialGradient(
              colors: lit
                  ? const [Color(0xFFFFF7D0), wheelGoldLight, wheelGoldDark]
                  : const [wheelGoldLight, wheelGoldDark],
              stops: lit ? const [0, 0.4, 1] : const [0, 1],
            ).createShader(Rect.fromCircle(center: pos, radius: 1.3))
            ..color = Color.fromRGBO(0, 0, 0, lit ? 1 : 0.45),
        );
    }
  }

  void _paintSegments(Canvas canvas, Shader hubShader) {
    const center = Offset(50, 50);
    final count = names.length;
    if (count == 0) {
      canvas.drawCircle(center, 41, Paint()..shader = hubShader);
      return;
    }
    final seg = segmentAngle(count);
    final isOdd = count.isOdd;
    final rect = Rect.fromCircle(center: center, radius: 41);
    for (var i = 0; i < count; i++) {
      final isLight = !isOdd && i.isEven;
      final start = (i * seg - 90) * math.pi / 180;
      final sweep = seg * math.pi / 180;
      final path = Path()
        ..moveTo(50, 50)
        ..arcTo(rect, start, sweep, false)
        ..close();
      canvas
        ..drawPath(
          path,
          Paint()..color = isLight ? _segmentLight : _segmentDark,
        )
        ..drawPath(
          path,
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = isOdd ? 0.8 : 0.3
            ..color = wheelGold,
        );
    }
    final fontSize = count > 12
        ? 2.6
        : count > 8
        ? 3.2
        : 3.8;
    final maxChars = seg < 25
        ? 7
        : seg < 35
        ? 10
        : 13;
    for (var i = 0; i < count; i++) {
      final isLight = !isOdd && i.isEven;
      final mid = i * seg + seg / 2;
      final pos = _polar(25, mid);
      canvas
        ..save()
        ..translate(pos.dx, pos.dy)
        ..rotate(mid * math.pi / 180);
      _paintText(
        canvas,
        shortWheelName(names[i], maxChars),
        Offset.zero,
        fontSize: fontSize,
        color: isLight ? _segmentDark : _segmentLight,
        weight: FontWeight.w700,
      );
      canvas.restore();
    }
  }

  void _paintPointer(Canvas canvas) {
    // SVG-pad `M 10 26 L 0 6 Q 0 0 10 0 Q 20 0 20 6 Z` (20×28) op schaal
    // 0,3, met het draaipunt op (10, 2,24) — `transform-origin: 50% 8%`.
    canvas
      ..save()
      ..translate(50, 0)
      ..rotate(pointerTilt * math.pi / 180);
    final path = Path()
      ..moveTo(0, 7.13)
      ..lineTo(-3, 1.13)
      ..quadraticBezierTo(-3, -0.67, 0, -0.67)
      ..quadraticBezierTo(3, -0.67, 3, 1.13)
      ..close();
    canvas
      ..drawShadow(path, const Color(0x66000000), 1, false)
      ..drawPath(
        path,
        Paint()
          ..shader = const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [wheelGoldLight, wheelGold, wheelGoldDark],
            stops: [0, 0.6, 1],
          ).createShader(const Rect.fromLTWH(-3, -0.67, 6, 7.8)),
      )
      ..drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.15
          ..color = wheelGoldDark,
      )
      ..drawCircle(
        const Offset(0, 1.13),
        0.6,
        Paint()..color = wheelGoldLight.withValues(alpha: 0.9),
      )
      ..restore();
  }

  static void _paintText(
    Canvas canvas,
    String text,
    Offset center, {
    required double fontSize,
    required Color color,
    required FontWeight weight,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: weight,
          color: color,
          height: 1,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();
    painter.paint(
      canvas,
      center - Offset(painter.width / 2, painter.height / 2),
    );
    painter.dispose();
  }

  @override
  bool shouldRepaint(WheelPainter oldDelegate) =>
      oldDelegate.rotation != rotation ||
      oldDelegate.pointerTilt != pointerTilt ||
      oldDelegate.bulbPhase != bulbPhase ||
      oldDelegate.spinning != spinning ||
      !_sameNames(oldDelegate.names, names);

  static bool _sameNames(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
