import 'dart:math' as math;

import 'package:flutter/material.dart';

/// De kleuren rond het veld (`CHROME` in de PWA): de rand volgt de ondergrond.
@immutable
class FieldChrome {
  const FieldChrome({
    required this.shell,
    required this.header,
    required this.track,
    required this.subtle,
    required this.activeText,
  });

  /// Achtergrond van het scherm rond het veld.
  final Color shell;

  /// Kopbalk.
  final Color header;

  /// Spoor van de formatiekiezer.
  final Color track;

  /// Gedempte tekst op de kopbalk.
  final Color subtle;

  /// Tekstkleur van de gekozen formatie (op wit).
  final Color activeText;
}

/// Tekent een veld van boven gezien. Eén subklasse per `field_variant`; de
/// formatieposities (x/y in procent) liggen er los bovenop.
///
/// Maten komen uit `Components/Lineup/Field.tsx` (Tailwind-pixels bij een
/// telefoon van ~390 pt breed) en schalen mee met de breedte.
abstract class FieldPainter extends CustomPainter {
  const FieldPainter();

  /// Naam voor tests en semantiek (`football`, `neutral`, …).
  String get variant;

  /// Ondergrond: verloop van boven naar onder.
  List<Color> get surface;

  FieldChrome get chrome;

  /// Kleur van de lijnen.
  static const Color line = Colors.white;

  /// Breedte waarop de PWA-maten gelden.
  static const double referenceWidth = 390;

  /// Binnenrand van het veld (`inset-3`).
  static const double inset = 12;

  /// Schaalfactor t.o.v. [referenceWidth], begrensd zodat een tablet geen
  /// reuzenstrafschopgebied krijgt.
  double scale(Size size) =>
      (size.width / referenceWidth).clamp(0.6, 1.6).toDouble();

  /// Lijn met [opacity] en [width] (pt).
  Paint stroke(double opacity, [double width = 2]) => Paint()
    ..color = line.withValues(alpha: opacity)
    ..style = PaintingStyle.stroke
    ..strokeWidth = width;

  Paint fill(double opacity) => Paint()
    ..color = line.withValues(alpha: opacity)
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: surface,
        ).createShader(rect),
    );
    paintMarkings(canvas, size);
    // Vignet voor diepte.
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const RadialGradient(
          radius: 0.75,
          colors: [Color(0x00000000), Color(0x00000000), Color(0x33000000)],
          stops: [0, 0.55, 1],
        ).createShader(rect),
    );
  }

  /// De lijnen van deze sport.
  void paintMarkings(Canvas canvas, Size size);

  /// De buitenlijn op [inset], licht afgerond.
  void paintOutline(Canvas canvas, Size size, double opacity) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(inset, inset, size.width - inset, size.height - inset),
        const Radius.circular(4),
      ),
      stroke(opacity),
    );
  }

  /// Horizontale lijn binnen de buitenlijn op [fraction] van de hoogte.
  void paintCrossLine(
    Canvas canvas,
    Size size,
    double fraction,
    double opacity, [
    double width = 2,
  ]) {
    final y = size.height * fraction;
    canvas.drawLine(
      Offset(inset, y),
      Offset(size.width - inset, y),
      stroke(opacity, width),
    );
  }

  @override
  bool shouldRepaint(covariant FieldPainter oldDelegate) =>
      oldDelegate.runtimeType != runtimeType;
}

/// Kiest de veldtekening bij `field_variant`. De enige plek in de app waar de
/// sport zelf een keuze stuurt; onbekende varianten krijgen een neutraal veld.
FieldPainter fieldPainterFor(String fieldVariant) => switch (fieldVariant) {
  'football' => const FootballFieldPainter(),
  'hockey' => const HockeyFieldPainter(),
  'korfball' => const KorfballFieldPainter(),
  'volleyball' => const VolleyballFieldPainter(),
  _ => const NeutralFieldPainter(),
};

/// Gras (emerald-600 → 700).
const _grass = [Color(0xFF059669), Color(0xFF047857)];

/// Kunstgras/zaal (sky-700 → 800), gedeeld door hockey en volleybal.
const _courtBlue = [Color(0xFF0369A1), Color(0xFF075985)];

const _greenChrome = FieldChrome(
  shell: Color(0xFF047857), // emerald-700
  header: Color(0xFF065F46), // emerald-800
  track: Color(0x66064E3B), // emerald-900/40
  subtle: Color(0xFFA7F3D0), // emerald-200
  activeText: Color(0xFF065F46),
);

const _blueChrome = FieldChrome(
  shell: Color(0xFF075985), // sky-800
  header: Color(0xFF0C4A6E), // sky-900
  track: Color(0x66082F49), // sky-950/40
  subtle: Color(0xFFBAE6FD), // sky-200
  activeText: Color(0xFF0C4A6E),
);

/// Voetbalveld: maaistrepen, middencirkel en twee strafschopgebieden.
class FootballFieldPainter extends FieldPainter {
  const FootballFieldPainter();

  @override
  String get variant => 'football-pitch';

  @override
  List<Color> get surface => _grass;

  @override
  FieldChrome get chrome => _greenChrome;

  @override
  void paintMarkings(Canvas canvas, Size size) {
    final s = scale(size);
    // Maaistrepen: 9% licht, 9% niet.
    final band = size.height * 0.09;
    for (var y = 0.0; y < size.height; y += band * 2) {
      canvas.drawRect(Rect.fromLTWH(0, y, size.width, band), fill(0.06));
    }
    paintOutline(canvas, size, 0.6);
    paintCrossLine(canvas, size, 0.5, 0.6);
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      40 * s,
      stroke(0.6),
    );
    // Strafschopgebieden: 160 × 96, tegen de achterlijnen.
    final boxW = 160 * s;
    final boxH = 96 * s;
    final left = (size.width - boxW) / 2;
    final top = Path()
      ..moveTo(left, 0)
      ..lineTo(left, boxH)
      ..lineTo(left + boxW, boxH)
      ..lineTo(left + boxW, 0);
    final bottom = Path()
      ..moveTo(left, size.height)
      ..lineTo(left, size.height - boxH)
      ..lineTo(left + boxW, size.height - boxH)
      ..lineTo(left + boxW, size.height);
    canvas
      ..drawPath(top, stroke(0.6))
      ..drawPath(bottom, stroke(0.6));
  }
}

/// Hockeyveld: de cirkels (D) bij de doelen en de 23-meterlijnen.
class HockeyFieldPainter extends FieldPainter {
  const HockeyFieldPainter();

  @override
  String get variant => 'hockey-field';

  @override
  List<Color> get surface => _courtBlue;

  @override
  FieldChrome get chrome => _blueChrome;

  @override
  void paintMarkings(Canvas canvas, Size size) {
    final s = scale(size);
    paintOutline(canvas, size, 0.7);
    paintCrossLine(canvas, size, 0.5, 0.7);
    // 23-meterlijnen op een kwart en driekwart.
    paintCrossLine(canvas, size, 0.25, 0.5, 1);
    paintCrossLine(canvas, size, 0.75, 0.5, 1);
    // De cirkels: 224 breed, 128 diep, alleen de helft in het veld.
    final w = 224 * s;
    final h = 128 * s;
    final cx = size.width / 2;
    final r = w / 2;
    const top = FieldPainter.inset;
    final bottom = size.height - FieldPainter.inset;
    final straight = math.max(0, h - r).toDouble();
    final upper = Path()
      ..moveTo(cx - r, top)
      ..lineTo(cx - r, top + straight)
      ..arcToPoint(
        Offset(cx + r, top + straight),
        radius: Radius.elliptical(r, math.min(r, h)),
        clockwise: false,
      )
      ..lineTo(cx + r, top);
    final lower = Path()
      ..moveTo(cx - r, bottom)
      ..lineTo(cx - r, bottom - straight)
      ..arcToPoint(
        Offset(cx + r, bottom - straight),
        radius: Radius.elliptical(r, math.min(r, h)),
      )
      ..lineTo(cx + r, bottom);
    canvas
      ..drawPath(upper, stroke(0.7))
      ..drawPath(lower, stroke(0.7));
    // Doelen als streepje op de achterlijn: 64 × 4.
    final goalW = 64 * s;
    canvas
      ..drawRect(Rect.fromLTWH(cx - goalW / 2, top, goalW, 4), fill(0.8))
      ..drawRect(
        Rect.fromLTWH(cx - goalW / 2, bottom - 4, goalW, 4),
        fill(0.8),
      );
  }
}

/// Korfbalveld: twee vakken, een korf op een zesde van elke achterlijn en de
/// strafworpstippen; verder leeg.
class KorfballFieldPainter extends FieldPainter {
  const KorfballFieldPainter();

  @override
  String get variant => 'korfball-field';

  @override
  List<Color> get surface => const [Color(0xFF0F766E), Color(0xFF115E59)];

  @override
  FieldChrome get chrome => const FieldChrome(
    shell: Color(0xFF115E59), // teal-800
    header: Color(0xFF134E4A), // teal-900
    track: Color(0x66042F2E), // teal-950/40
    subtle: Color(0xFF99F6E4), // teal-200
    activeText: Color(0xFF134E4A),
  );

  @override
  void paintMarkings(Canvas canvas, Size size) {
    final s = scale(size);
    paintOutline(canvas, size, 0.7);
    // De vakgrens, even zwaar als de buitenlijn.
    paintCrossLine(canvas, size, 0.5, 0.7);
    final cx = size.width / 2;
    for (final y in [0.17, 0.83]) {
      canvas.drawCircle(Offset(cx, size.height * y), 14 * s, stroke(0.9));
    }
    for (final y in [0.27, 0.73]) {
      canvas.drawCircle(Offset(cx, size.height * y), 3 * s, fill(0.8));
    }
  }
}

/// Volleybalcourt: de eigen speelhelft met het net bovenaan en de
/// aanvalslijn; wat onder de achterlijn staat (libero) valt buiten het veld.
class VolleyballFieldPainter extends FieldPainter {
  const VolleyballFieldPainter();

  @override
  String get variant => 'volleyball-court';

  @override
  List<Color> get surface => _courtBlue;

  @override
  FieldChrome get chrome => _blueChrome;

  @override
  void paintMarkings(Canvas canvas, Size size) {
    const side = 24.0;
    final netY = size.height * 0.08;
    canvas.drawRect(
      Rect.fromLTRB(side, netY, size.width - side, size.height * 0.85),
      stroke(0.8),
    );
    // Aanvalslijn op drie meter van het net.
    canvas.drawLine(
      Offset(side, size.height * 0.45),
      Offset(size.width - side, size.height * 0.45),
      stroke(0.8),
    );
    // Het net: band met paaltjes die aan weerszijden uitsteken.
    const inner = FieldPainter.inset;
    final net = Rect.fromLTRB(inner, netY - 6, size.width - inner, netY + 6);
    canvas
      ..drawRect(net, fill(0.25))
      ..drawLine(net.topLeft, net.topRight, stroke(1))
      ..drawLine(net.bottomLeft, net.bottomRight, stroke(1))
      ..drawRect(Rect.fromLTWH(inner, netY - 12, 3, 24), fill(0.9))
      ..drawRect(
        Rect.fromLTWH(size.width - inner - 3, netY - 12, 3, 24),
        fill(0.9),
      );
  }
}

/// Een sport die deze appversie niet kent: alleen buitenlijn en middenlijn,
/// op een neutrale ondergrond (slate).
class NeutralFieldPainter extends FieldPainter {
  const NeutralFieldPainter();

  @override
  String get variant => 'neutral';

  @override
  List<Color> get surface => const [Color(0xFF475569), Color(0xFF334155)];

  @override
  FieldChrome get chrome => const FieldChrome(
    shell: Color(0xFF334155), // slate-700
    header: Color(0xFF1E293B), // slate-800
    track: Color(0x66020617), // slate-950/40
    subtle: Color(0xFFCBD5E1), // slate-300
    activeText: Color(0xFF1E293B),
  );

  @override
  void paintMarkings(Canvas canvas, Size size) {
    paintOutline(canvas, size, 0.6);
    paintCrossLine(canvas, size, 0.5, 0.6);
  }
}
