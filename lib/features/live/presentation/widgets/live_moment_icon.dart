import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../core/widgets/widgets.dart';

/// Het icoon bij een moment (`lib/momentIcons.tsx` in de PWA). De lookup
/// gaat op het type uit de feed, ook op `woodwork` (wordt niet meer
/// aangeboden bij voetbal/hockey, maar staat in oude verslagen en is nog
/// van korfbal).
///
/// - `penalty_awarded`: het doel met de stip ervoor (stip rood);
/// - `penalty_saved`: een hand;
/// - `post` / `crossbar` / `woodwork`: een doel van voren met het geraakte
///   stuk in rood (paal, lat of allebei);
/// - `big_chance`: een vlam;
/// - de rest (`penalty_missed`, onbekend): verboden-teken.
class LiveMomentIcon extends StatelessWidget {
  const LiveMomentIcon({
    super.key,
    required this.type,
    required this.color,
    this.size = 18,
  });

  final String type;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final _GoalHit? hit = switch (type) {
      'post' => _GoalHit.post,
      'crossbar' => _GoalHit.bar,
      'woodwork' => _GoalHit.both,
      _ => null,
    };
    if (hit != null || type == 'penalty_awarded') {
      return SizedBox.square(
        key: ValueKey('live-moment-icon-$type'),
        dimension: size,
        child: CustomPaint(
          painter: hit != null
              ? _GoalFramePainter(hit: hit, color: color)
              : _PenaltySpotPainter(color: color),
        ),
      );
    }
    return Icon(
      switch (type) {
        'penalty_saved' => PhosphorIconsDuotone.handPalm,
        'big_chance' => PhosphorIconsDuotone.fire,
        _ => PhosphorIconsDuotone.prohibit,
      },
      key: ValueKey('live-moment-icon-$type'),
      size: size,
      color: color,
    );
  }
}

enum _GoalHit { bar, post, both }

/// Een doel van voren op een 24×24-raster (zoals de SVG in de PWA): de
/// linkerpaal en/of de lat rood, de rest in de tekstkleur.
class _GoalFramePainter extends CustomPainter {
  const _GoalFramePainter({required this.hit, required this.color});

  final _GoalHit hit;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24;
    Paint stroke(Color c) => Paint()
      ..color = c
      ..strokeWidth = 2.5 * s
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final postRed = hit == _GoalHit.post || hit == _GoalHit.both;
    final barRed = hit == _GoalHit.bar || hit == _GoalHit.both;
    canvas
      ..drawLine(
        Offset(4 * s, 19 * s),
        Offset(4 * s, 6 * s),
        stroke(postRed ? StatusColors.red600 : color),
      )
      ..drawLine(Offset(20 * s, 19 * s), Offset(20 * s, 6 * s), stroke(color))
      ..drawLine(
        Offset(4 * s, 6 * s),
        Offset(20 * s, 6 * s),
        stroke(barRed ? StatusColors.red600 : color),
      );
  }

  @override
  bool shouldRepaint(_GoalFramePainter old) =>
      old.hit != hit || old.color != color;
}

/// Toegekende strafschop: het doel met de (rode) stip ervoor.
class _PenaltySpotPainter extends CustomPainter {
  const _PenaltySpotPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 24;
    final frame = Path()
      ..moveTo(4 * s, 13 * s)
      ..lineTo(4 * s, 4 * s)
      ..lineTo(20 * s, 4 * s)
      ..lineTo(20 * s, 13 * s);
    canvas
      ..drawPath(
        frame,
        Paint()
          ..color = color
          ..strokeWidth = 2 * s
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke,
      )
      ..drawCircle(
        Offset(12 * s, 19 * s),
        2.25 * s,
        Paint()..color = StatusColors.red600,
      );
  }

  @override
  bool shouldRepaint(_PenaltySpotPainter old) => old.color != color;
}
