// De opmaak van de storebeelden in de huisstijl van assistje.nl: het
// grasveld met maaistroken (mint of zand), zwarte krijtlijnen, koppen in
// Obviously met één woord op een gele markeerpil (zoals de knoppen op de
// site: zwarte rand, harde schaduw) en de echte app in een toestelframe.
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'mascot.dart';

/// Huisstijl van assistje.nl (CSS-variabelen van de site tussen haakjes).
abstract final class Brand {
  /// Het grasveld (`--hero-bg`).
  static const field = Color(0xFF61F6A9);

  /// Het zandveld van de lichte secties (`--field-bg`).
  static const sand = Color(0xFFF5ECDF);

  /// Knoppen en markeringen (`--cta-yellow`).
  static const yellow = Color(0xFFFFFF87);

  /// Tekst (`--foreground`).
  static const ink = Color(0xFF0C120D);

  /// Lijnen, randen en harde schaduwen.
  static const line = Color(0xFF000000);

  /// Maaistroken (`--mow-stripe-ink`, iets voller op een toestelscherm).
  static const stripe = Color(0x0B000000);

  /// De letter van de site; geladen uit STORE_FONT_DIR, anders Figtree.
  static const font = 'Obviously';
  static const fontBold = 'Obviously Bold';
  static const fontFallback = ['Figtree'];
}

/// Achtergrond van een beeld: welk veld.
enum Backdrop {
  field(Brand.field, Brand.yellow),
  sand(Brand.sand, Brand.field);

  const Backdrop(this.color, this.pill);

  final Color color;

  /// Vulling van de markeerpil in de kop.
  final Color pill;
}

/// Toestelsoort van het frame.
enum DeviceKind { iphone, ipad, android }

/// Eén storebeeld.
class StoreSlide {
  const StoreSlide({
    required this.name,
    required this.headline,
    required this.sub,
    required this.backdrop,
    this.mascot = false,
    this.lightStatusBar = false,
  });

  final String name;

  /// Het pilletje boven de kop: "01 Agenda" uit `01-agenda`.
  String get label {
    final i = name.indexOf('-');
    final word = name.substring(i + 1);
    return '${name.substring(0, i)}  ${word[0].toUpperCase()}'
        '${word.substring(1)}';
  }

  /// Regels gescheiden door `\n`; `*woord*` krijgt de accentkleur.
  final String headline;
  final String sub;
  final Backdrop backdrop;
  final bool mascot;

  /// Witte statusbalk (op een donker/groen scherm, bv. de opstelling).
  final bool lightStatusBar;
}

/// De samengestelde afbeelding: kop boven, toestel eronder.
class StoreFrame extends StatelessWidget {
  const StoreFrame({
    super.key,
    required this.slide,
    required this.screen,
    required this.screenSize,
    required this.kind,
    required this.topInset,
  });

  final StoreSlide slide;
  final ui.Image screen;

  /// Logische maat van het gerenderde scherm.
  final Size screenSize;
  final DeviceKind kind;

  /// Hoogte van de statusbalk in de render (logisch).
  final double topInset;

  @override
  Widget build(BuildContext context) {
    final b = slide.backdrop;
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth, h = c.maxHeight;
        final tablet = kind == DeviceKind.ipad;
        final headSize = w * (tablet ? 0.058 : 0.098);
        final headTop = h * (tablet ? 0.045 : 0.05);
        final deviceTop = h * (tablet ? 0.235 : 0.28);
        // Toestel: zo breed als past, de onderkant loopt net uit beeld.
        final aspect = screenSize.height / screenSize.width;
        final bezel = w * (tablet ? 0.018 : 0.026);
        final deviceW = math.min(
          w * (tablet ? 0.86 : 0.78),
          ((h - deviceTop) * 1.03 - 2 * bezel) / aspect + 2 * bezel,
        );
        final stroke = w * (tablet ? 0.0026 : 0.004);
        return CustomPaint(
          painter: FieldPainter(
            color: b.color,
            stripes: tablet ? 8 : 6,
            lineWidth: stroke,
            // Middenlijn met middencirkel achter het toestel, zoals de
            // overgangen tussen de secties op de site.
            halfway: deviceTop + h * (tablet ? 0.2 : 0.22),
            circleRadius: w * (tablet ? 0.25 : 0.42),
          ),
          child: Stack(
            children: [
              Positioned(
                left: w * 0.06,
                right: w * 0.06,
                top: headTop,
                child: Column(
                  children: [
                    _Label(text: slide.label, size: headSize * 0.26),
                    SizedBox(height: headSize * 0.34),
                    _Headline(
                      text: slide.headline,
                      size: headSize,
                      pill: b.pill,
                    ),
                    SizedBox(height: headSize * 0.3),
                    Text(
                      slide.sub,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: Brand.font,
                        fontFamilyFallback: Brand.fontFallback,
                        fontWeight: FontWeight.w400,
                        fontSize: headSize * 0.33,
                        height: 1.3,
                        color: Brand.ink,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: deviceTop,
                left: (w - deviceW) / 2,
                width: deviceW,
                child: _Device(
                  kind: kind,
                  screen: screen,
                  screenSize: screenSize,
                  bezel: bezel,
                  topInset: topInset,
                  lightStatusBar: slide.lightStatusBar,
                ),
              ),
              if (slide.mascot)
                Positioned(
                  right: w * (tablet ? 0.05 : 0.03),
                  top: deviceTop - w * 0.07,
                  width: w * (tablet ? 0.15 : 0.24),
                  height: w * (tablet ? 0.19 : 0.3),
                  child: Transform.rotate(
                    angle: 0.2,
                    child: const Mascot(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Het pilletje boven de kop, als "02 Voordelen" op de site: wit, zwarte
/// rand.
class _Label extends StatelessWidget {
  const _Label({required this.text, required this.size});

  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size * 0.9,
        vertical: size * 0.38,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size * 2),
        border: Border.all(width: size * 0.12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: Brand.fontBold,
          fontFamilyFallback: Brand.fontFallback,
          fontWeight: FontWeight.w700,
          fontSize: size,
          height: 1,
          color: Brand.ink,
        ),
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline({
    required this.text,
    required this.size,
    required this.pill,
  });

  final String text;
  final double size;
  final Color pill;

  TextStyle get _style => TextStyle(
    fontFamily: Brand.fontBold,
    fontFamilyFallback: Brand.fontFallback,
    fontWeight: FontWeight.w700,
    fontSize: size,
    height: 1,
    letterSpacing: -size * 0.01,
    color: Brand.ink,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hoofdletters, zoals de koppen op assistje.nl.
        for (final line in text.toUpperCase().split('\n'))
          FittedBox(fit: BoxFit.scaleDown, child: _line(line)),
      ],
    );
  }

  /// Eén regel; `*woord*` komt op een markeerpil (geel of mint, zwarte rand
  /// en harde schaduw, als de knoppen op de site).
  Widget _line(String line) {
    final parts = line.split('*');
    // Op de basislijn: het woord naast de pil staat op dezelfde regel als de
    // tekst erin, en zo ook (vrijwel) verticaal midden op de pil.
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        for (var i = 0; i < parts.length; i++)
          if (parts[i].trim().isEmpty)
            const SizedBox.shrink()
          else if (i.isOdd)
            Container(
              margin: EdgeInsets.symmetric(vertical: size * 0.08),
              // Accenten op hoofdletters (ÉÉN) steken 0,24 em boven de
              // ascent van Obviously uit, en de eerste letter staat in de
              // ronde hoek: boven en opzij extra lucht. Onder geen padding:
              // daar zit de descent van de font al.
              padding: EdgeInsets.fromLTRB(
                size * 0.42,
                size * 0.46,
                size * 0.42,
                0,
              ),
              decoration: BoxDecoration(
                color: pill,
                borderRadius: BorderRadius.circular(size),
                border: Border.all(width: size * 0.045),
                boxShadow: [
                  BoxShadow(offset: Offset(0, size * 0.07)),
                ],
              ),
              child: Text(
                parts[i].trim(),
                style: _style,
              ),
            )
          else
            Text(
              parts[i],
              style: _style,
            ),
      ],
    );
  }
}

class _Device extends StatelessWidget {
  const _Device({
    required this.kind,
    required this.screen,
    required this.screenSize,
    required this.bezel,
    required this.topInset,
    required this.lightStatusBar,
  });

  final DeviceKind kind;
  final ui.Image screen;
  final Size screenSize;
  final double bezel;
  final double topInset;
  final bool lightStatusBar;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final outerW = c.maxWidth;
        final innerW = outerW - 2 * bezel;
        final scale = innerW / screenSize.width;
        final innerH = screenSize.height * scale;
        final screenRadius = switch (kind) {
          DeviceKind.iphone => innerW * 0.135,
          DeviceKind.ipad => innerW * 0.03,
          DeviceKind.android => innerW * 0.09,
        };
        return Container(
          width: outerW,
          height: innerH + 2 * bezel,
          padding: EdgeInsets.all(bezel),
          decoration: BoxDecoration(
            color: const Color(0xFF0B0D0C),
            borderRadius: BorderRadius.circular(screenRadius + bezel),
            border: Border.all(
              color: const Color(0xFF3A3F3C),
              width: bezel * 0.18,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: outerW * 0.06,
                offset: Offset(0, outerW * 0.025),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(screenRadius),
            child: Stack(
              children: [
                Positioned.fill(
                  child: RawImage(
                    image: screen,
                    fit: BoxFit.fill,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  height: topInset * scale,
                  child: _StatusBar(
                    kind: kind,
                    scale: scale,
                    color: lightStatusBar ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Statusbalk met 9:41, volle balkjes en batterij (Apple-conventie) en het
/// eiland/cameragaatje.
class _StatusBar extends StatelessWidget {
  const _StatusBar({
    required this.kind,
    required this.scale,
    required this.color,
  });

  final DeviceKind kind;
  final double scale;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final s = scale;
    final time = Text(
      '9:41',
      style: TextStyle(
        fontFamily: 'Figtree',
        fontWeight: FontWeight.w700,
        fontSize: (kind == DeviceKind.android ? 14 : 17) * s,
        color: color,
        letterSpacing: -0.2 * s,
      ),
    );
    final icons = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(PhosphorIconsFill.cellSignalFull, size: 17 * s, color: color),
        SizedBox(width: 5 * s),
        Icon(PhosphorIconsBold.wifiHigh, size: 17 * s, color: color),
        SizedBox(width: 5 * s),
        Icon(PhosphorIconsFill.batteryFull, size: 22 * s, color: color),
      ],
    );
    return switch (kind) {
      DeviceKind.iphone => Stack(
        children: [
          Positioned(
            left: 0,
            width: 150 * s,
            top: 0,
            bottom: 0,
            child: Center(child: time),
          ),
          Positioned(
            right: 0,
            width: 150 * s,
            top: 0,
            bottom: 0,
            child: Center(child: icons),
          ),
          // Dynamic Island.
          Align(
            alignment: const Alignment(0, -0.1),
            child: Container(
              width: 124 * s,
              height: 36 * s,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(18 * s),
              ),
            ),
          ),
        ],
      ),
      DeviceKind.ipad => Padding(
        padding: EdgeInsets.symmetric(horizontal: 22 * s),
        child: Row(children: [time, const Spacer(), icons]),
      ),
      DeviceKind.android => Padding(
        padding: EdgeInsets.symmetric(horizontal: 18 * s),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(children: [time, const Spacer(), icons]),
            Container(
              width: 12 * s,
              height: 12 * s,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    };
  }
}

/// Het app-icoon: mascotje op het grasveld van assistje.nl. [rounded] geeft een
/// afgeronde vorm met transparante hoeken (Android-legacy-iconen); iOS en
/// Play ronden zelf af en willen een vol vierkant.
class AppIconArt extends StatelessWidget {
  const AppIconArt({super.key, this.rounded = false, this.mascotHeight = 0.68});

  final bool rounded;
  final double mascotHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) => ClipRRect(
        borderRadius: BorderRadius.circular(rounded ? c.maxWidth * 0.22 : 0),
        child: CustomPaint(
          painter: const FieldPainter(color: Brand.field),
          child: Center(
            child: FractionallySizedBox(
              heightFactor: mascotHeight,
              child: const Mascot(),
            ),
          ),
        ),
      ),
    );
  }
}

/// Een veld van assistje.nl: maaistroken en, desgewenst, een middenlijn
/// op hoogte [halfway] met een middencirkel. Het app-icoon gebruikt alleen de
/// stroken, met dezelfde maten als `ic_launcher_background.xml`.
class FieldPainter extends CustomPainter {
  const FieldPainter({
    required this.color,
    this.stripes = 6,
    this.halfway,
    this.circleRadius,
    this.lineWidth = 0,
    this.circleX,
    this.halfwayLine = true,
  });

  final Color color;
  final int stripes;
  final double? halfway;
  final double? circleRadius;
  final double lineWidth;

  /// Midden van de cirkel; standaard het midden van het beeld.
  final double? circleX;

  /// De middenlijn zelf tekenen (anders alleen de cirkel).
  final bool halfwayLine;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = color);
    final stripe = Paint()..color = Brand.stripe;
    final w = size.width / stripes;
    for (var i = 1; i < stripes; i += 2) {
      canvas.drawRect(Rect.fromLTWH(i * w, 0, w, size.height), stripe);
    }
    final y = halfway;
    if (y == null) return;
    final line = Paint()
      ..color = Brand.line
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;
    if (halfwayLine) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), line);
    }
    final r = circleRadius;
    if (r != null) {
      final centre = Offset(circleX ?? size.width / 2, y);
      canvas
        ..drawCircle(centre, r, line)
        ..drawCircle(
          centre,
          lineWidth * 1.6,
          Paint()..color = Brand.line,
        );
    }
  }

  @override
  bool shouldRepaint(FieldPainter old) =>
      old.color != color ||
      old.stripes != stripes ||
      old.halfway != halfway ||
      old.circleRadius != circleRadius ||
      old.lineWidth != lineWidth ||
      old.circleX != circleX ||
      old.halfwayLine != halfwayLine;
}

/// Play-featuregraphic (1024 × 500): mascotje, naam en belofte, met een
/// telefoon met de agenda rechts.
class FeatureGraphic extends StatelessWidget {
  const FeatureGraphic({
    super.key,
    required this.screen,
    required this.screenSize,
    required this.topInset,
  });

  final ui.Image screen;
  final Size screenSize;
  final double topInset;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const FieldPainter(
        color: Brand.field,
        stripes: 8,
        halfway: 250,
        circleRadius: 190,
        circleX: 784,
        halfwayLine: false,
        lineWidth: 3,
      ),
      child: Stack(
        children: [
          const Positioned(
            left: 48,
            top: 0,
            bottom: 0,
            width: 560,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 96,
                  height: 120,
                  child: Mascot(),
                ),
                SizedBox(height: 20),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'DE TEAM-APP\nVOOR JOUW\nAMATEURTEAM',
                    style: TextStyle(
                      fontFamily: Brand.fontBold,
                      fontFamilyFallback: Brand.fontFallback,
                      fontWeight: FontWeight.w700,
                      fontSize: 62,
                      height: 0.98,
                      letterSpacing: -1,
                      color: Brand.ink,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 90,
            top: 40,
            width: 300,
            child: _Device(
              kind: DeviceKind.iphone,
              screen: screen,
              screenSize: screenSize,
              bezel: 9,
              topInset: topInset,
              lightStatusBar: false,
            ),
          ),
        ],
      ),
    );
  }
}

/// Header van de App Store-productpagina (21:9, logisch 1920 × 823). Apple:
/// één idee, de kern in het midden (randen vallen op smalle schermen weg),
/// korte tekst. Midden: mascotje en de belofte uit de hero van de site;
/// links en rechts telefoons die naar buiten wegvallen.
class HeaderArt extends StatelessWidget {
  const HeaderArt({
    super.key,
    required this.screens,
    required this.screenSize,
    required this.topInset,
    required this.lightStatusBar,
  });

  /// Schermen links (0) en rechts (2); 1 is gereserveerd.
  final List<ui.Image> screens;
  final Size screenSize;
  final double topInset;
  final List<bool> lightStatusBar;

  Widget _phone(int i, double angle) => Transform.rotate(
    angle: angle,
    child: _Device(
      kind: DeviceKind.iphone,
      screen: screens[i],
      screenSize: screenSize,
      bezel: 11,
      topInset: topInset,
      lightStatusBar: lightStatusBar[i],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      // Geen krijtlijnen: die liepen door de kop.
      painter: const FieldPainter(color: Brand.field, stripes: 12),
      child: Stack(
        children: [
          Positioned(left: 130, top: 120, width: 360, child: _phone(0, -0.08)),
          Positioned(right: 130, top: 120, width: 360, child: _phone(2, 0.08)),
          const Positioned.fill(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 160, height: 202, child: Mascot()),
                  SizedBox(height: 40),
                  _Headline(
                    text: 'Je hele team\nin *één app*',
                    size: 100,
                    pill: Brand.yellow,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// "Search Results"-asset van de App Store (3:2, logisch 1920 × 1280): de
/// belofte bovenaan, drie telefoons als waaier eronder, alles rond het
/// midden.
class SearchResultArt extends StatelessWidget {
  const SearchResultArt({
    super.key,
    required this.screens,
    required this.screenSize,
    required this.topInset,
  });

  /// Links, midden, rechts.
  final List<ui.Image> screens;
  final Size screenSize;
  final double topInset;

  Widget _phone(int i) => _Device(
    kind: DeviceKind.iphone,
    screen: screens[i],
    screenSize: screenSize,
    bezel: 12,
    topInset: topInset,
    lightStatusBar: false,
  );

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const FieldPainter(color: Brand.field, stripes: 12),
      child: Stack(
        children: [
          Positioned(
            left: 330,
            top: 560,
            width: 420,
            child: Transform.rotate(angle: -0.12, child: _phone(0)),
          ),
          Positioned(
            right: 330,
            top: 560,
            width: 420,
            child: Transform.rotate(angle: 0.12, child: _phone(2)),
          ),
          Positioned(
            left: 1920 / 2 - 230,
            top: 470,
            width: 460,
            child: _phone(1),
          ),
          Positioned(
            right: 1920 / 2 - 350,
            top: 440,
            width: 170,
            height: 214,
            child: Transform.rotate(angle: 0.2, child: const Mascot()),
          ),
          const Positioned(
            left: 0,
            right: 0,
            top: 90,
            child: _Headline(
              text: 'Je hele team\nin *één app*',
              size: 120,
              pill: Brand.yellow,
            ),
          ),
        ],
      ),
    );
  }
}
