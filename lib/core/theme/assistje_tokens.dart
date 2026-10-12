import 'package:flutter/material.dart';

/// De Assistje-designtokens als [ThemeExtension].
///
/// Bron: de semantische kleurlaag in vogels3 `resources/css/app.css`
/// (`:root` en `.dark`) en de glazen balk daaronder. Net als in de PWA zegt een
/// token wat iets ís, niet welke kleur het heeft: `surface` is "het vlak waar
/// inhoud op staat", en of dat wit of bijna-zwart is bepaalt het thema.
///
/// Gebruik: `AssistjeTokens.of(context).surface`.
@immutable
class AssistjeTokens extends ThemeExtension<AssistjeTokens> {
  const AssistjeTokens({
    required this.primary,
    required this.primaryContrast,
    required this.surface,
    required this.sunken,
    required this.raised,
    required this.ink,
    required this.inkSoft,
    required this.muted,
    required this.line,
    required this.lineSoft,
    required this.control,
    required this.track,
    required this.glassFill,
    required this.glassSheenTop,
    required this.glassSheenBottom,
    required this.glassEdge,
    required this.glassRing,
    required this.glassShadow,
    required this.surfaceHairline,
    required this.raisedHairline,
  });

  /// Lichte tokens (`:root` in app.css).
  factory AssistjeTokens.light({
    required Color primary,
    required Color primaryContrast,
  }) {
    return AssistjeTokens(
      primary: primary,
      primaryContrast: primaryContrast,
      surface: const Color.fromARGB(255, 255, 255, 255),
      sunken: const Color.fromARGB(255, 243, 244, 246),
      raised: const Color.fromARGB(255, 249, 250, 251),
      ink: const Color.fromARGB(255, 17, 24, 39),
      inkSoft: const Color.fromARGB(255, 55, 65, 81),
      muted: const Color.fromARGB(255, 107, 114, 128),
      line: const Color.fromARGB(255, 229, 231, 235),
      lineSoft: const Color.fromARGB(255, 243, 244, 246),
      control: const Color.fromARGB(255, 255, 255, 255),
      track: const Color.fromARGB(255, 229, 231, 235),
      glassFill: const Color.fromRGBO(255, 255, 255, 0.6),
      glassSheenTop: const Color.fromRGBO(255, 255, 255, 0.55),
      glassSheenBottom: const Color.fromRGBO(255, 255, 255, 0.25),
      glassEdge: const Color.fromRGBO(255, 255, 255, 0.7),
      glassRing: const Color.fromRGBO(0, 0, 0, 0.06),
      glassShadow: const Color.fromRGBO(0, 0, 0, 0.06),
      // In licht doet het kleurverschil het werk; geen haarlijn.
      surfaceHairline: const Color(0x00000000),
      raisedHairline: const Color(0x00000000),
    );
  }

  /// Donkere tokens (`.dark` in app.css): koele ondertoon, diepte uit randen.
  factory AssistjeTokens.dark({
    required Color primary,
    required Color primaryContrast,
  }) {
    return AssistjeTokens(
      primary: primary,
      primaryContrast: primaryContrast,
      surface: const Color.fromARGB(255, 21, 21, 28),
      sunken: const Color.fromARGB(255, 10, 10, 16),
      raised: const Color.fromARGB(255, 31, 31, 41),
      ink: const Color.fromARGB(255, 255, 255, 255),
      inkSoft: const Color.fromARGB(255, 210, 210, 220),
      muted: const Color.fromARGB(255, 140, 140, 155),
      line: const Color.fromARGB(255, 46, 46, 60),
      lineSoft: const Color.fromARGB(255, 34, 34, 44),
      control: const Color.fromARGB(255, 62, 62, 78),
      track: const Color.fromARGB(255, 18, 18, 25),
      glassFill: const Color.fromRGBO(26, 26, 34, 0.76),
      glassSheenTop: const Color.fromRGBO(255, 255, 255, 0.07),
      glassSheenBottom: const Color.fromRGBO(255, 255, 255, 0.02),
      glassEdge: const Color.fromRGBO(255, 255, 255, 0.14),
      glassRing: const Color.fromRGBO(255, 255, 255, 0.12),
      glassShadow: const Color.fromRGBO(0, 0, 0, 0.45),
      surfaceHairline: const Color.fromRGBO(255, 255, 255, 0.055),
      raisedHairline: const Color.fromRGBO(255, 255, 255, 0.035),
    );
  }

  /// Teamkleur (`--color-primary`) en de tekstkleur erop.
  final Color primary;
  final Color primaryContrast;

  /// Vlakken, van ver naar dichtbij.
  final Color surface;
  final Color sunken;
  final Color raised;

  /// Tekst, van zwaar naar licht.
  final Color ink;
  final Color inkSoft;
  final Color muted;

  /// Randen.
  final Color line;
  final Color lineSoft;

  /// Segmented controls: actieve knop en de baan eronder.
  final Color control;
  final Color track;

  /// Glazen tabbar/pills.
  final Color glassFill;
  final Color glassSheenTop;
  final Color glassSheenBottom;
  final Color glassEdge;
  final Color glassRing;
  final Color glassShadow;

  /// Haarlijn om een `surface`/`raised`-vlak (alleen in donker zichtbaar).
  final Color surfaceHairline;
  final Color raisedHairline;

  // Radii: de Tailwind-schaal zoals de PWA hem gebruikt.
  static const double radiusSm = 2; // rounded-sm
  static const double radiusMd = 6; // rounded-md
  static const double radiusLg = 8; // rounded-lg
  static const double radiusXl = 12; // rounded-xl
  static const double radius2xl = 16; // rounded-2xl
  static const double radius3xl = 24; // rounded-3xl
  static const double radiusFull = 9999; // rounded-full

  /// Tailwind `shadow-sm`.
  static const List<BoxShadow> shadowSm = [
    BoxShadow(color: Color(0x0D000000), offset: Offset(0, 1), blurRadius: 2),
  ];

  /// Tailwind `shadow`.
  static const List<BoxShadow> shadow = [
    BoxShadow(color: Color(0x1A000000), offset: Offset(0, 1), blurRadius: 3),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: -1,
    ),
  ];

  /// Tailwind `shadow-md`.
  static const List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x1A000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -2,
    ),
  ];

  static AssistjeTokens of(BuildContext context) =>
      Theme.of(context).extension<AssistjeTokens>()!;

  @override
  AssistjeTokens copyWith({
    Color? primary,
    Color? primaryContrast,
    Color? surface,
    Color? sunken,
    Color? raised,
    Color? ink,
    Color? inkSoft,
    Color? muted,
    Color? line,
    Color? lineSoft,
    Color? control,
    Color? track,
    Color? glassFill,
    Color? glassSheenTop,
    Color? glassSheenBottom,
    Color? glassEdge,
    Color? glassRing,
    Color? glassShadow,
    Color? surfaceHairline,
    Color? raisedHairline,
  }) {
    return AssistjeTokens(
      primary: primary ?? this.primary,
      primaryContrast: primaryContrast ?? this.primaryContrast,
      surface: surface ?? this.surface,
      sunken: sunken ?? this.sunken,
      raised: raised ?? this.raised,
      ink: ink ?? this.ink,
      inkSoft: inkSoft ?? this.inkSoft,
      muted: muted ?? this.muted,
      line: line ?? this.line,
      lineSoft: lineSoft ?? this.lineSoft,
      control: control ?? this.control,
      track: track ?? this.track,
      glassFill: glassFill ?? this.glassFill,
      glassSheenTop: glassSheenTop ?? this.glassSheenTop,
      glassSheenBottom: glassSheenBottom ?? this.glassSheenBottom,
      glassEdge: glassEdge ?? this.glassEdge,
      glassRing: glassRing ?? this.glassRing,
      glassShadow: glassShadow ?? this.glassShadow,
      surfaceHairline: surfaceHairline ?? this.surfaceHairline,
      raisedHairline: raisedHairline ?? this.raisedHairline,
    );
  }

  @override
  AssistjeTokens lerp(covariant AssistjeTokens? other, double t) {
    if (other == null) return this;
    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    return AssistjeTokens(
      primary: c(primary, other.primary),
      primaryContrast: c(primaryContrast, other.primaryContrast),
      surface: c(surface, other.surface),
      sunken: c(sunken, other.sunken),
      raised: c(raised, other.raised),
      ink: c(ink, other.ink),
      inkSoft: c(inkSoft, other.inkSoft),
      muted: c(muted, other.muted),
      line: c(line, other.line),
      lineSoft: c(lineSoft, other.lineSoft),
      control: c(control, other.control),
      track: c(track, other.track),
      glassFill: c(glassFill, other.glassFill),
      glassSheenTop: c(glassSheenTop, other.glassSheenTop),
      glassSheenBottom: c(glassSheenBottom, other.glassSheenBottom),
      glassEdge: c(glassEdge, other.glassEdge),
      glassRing: c(glassRing, other.glassRing),
      glassShadow: c(glassShadow, other.glassShadow),
      surfaceHairline: c(surfaceHairline, other.surfaceHairline),
      raisedHairline: c(raisedHairline, other.raisedHairline),
    );
  }
}
