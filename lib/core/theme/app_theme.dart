import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'assistje_tokens.dart';
import 'team_color.dart';

/// Bouwt de licht- en donker-[ThemeData] uit een teamkleur.
///
/// Material 3 als basis; de Assistje-tokens zitten erin als [AssistjeTokens]
/// en bepalen de [ColorScheme]-rollen die Material-widgets zelf gebruiken.
/// In donker wordt de opgetilde teamkleur gebruikt (`liftForDark`), precies
/// zoals app.css tussen `--color-primary-light` en `-dark` kiest.
abstract final class AppTheme {
  static const String fontFamily = 'Figtree';

  static ThemeData light(String? teamColorHex) {
    final palette = TeamPalette.fromHex(teamColorHex);
    return _build(
      Brightness.light,
      AssistjeTokens.light(
        primary: palette.light,
        primaryContrast: palette.lightContrast,
      ),
    );
  }

  static ThemeData dark(String? teamColorHex) {
    final palette = TeamPalette.fromHex(teamColorHex);
    return _build(
      Brightness.dark,
      AssistjeTokens.dark(
        primary: palette.dark,
        primaryContrast: palette.darkContrast,
      ),
    );
  }

  static ThemeData _build(Brightness brightness, AssistjeTokens t) {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: t.primary,
          brightness: brightness,
        ).copyWith(
          primary: t.primary,
          onPrimary: t.primaryContrast,
          surface: t.surface,
          onSurface: t.ink,
          onSurfaceVariant: t.muted,
          surfaceContainerLowest: t.surface,
          surfaceContainerLow: t.raised,
          surfaceContainer: t.raised,
          surfaceContainerHigh: t.raised,
          surfaceContainerHighest: t.track,
          outline: t.line,
          outlineVariant: t.lineSoft,
        );

    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      fontFamily: fontFamily,
      scaffoldBackgroundColor: t.sunken,
      canvasColor: t.surface,
      dividerColor: t.line,
      splashFactory: _isCupertino ? NoSplash.splashFactory : null,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(),
        },
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: t.primary,
        scaffoldBackgroundColor: t.sunken,
      ),
      extensions: [t],
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: t.ink,
        displayColor: t.ink,
        fontFamily: fontFamily,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: t.surface,
        foregroundColor: t.ink,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        color: t.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AssistjeTokens.radius2xl),
          side: BorderSide(color: t.surfaceHairline),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: t.primary,
          foregroundColor: t.primaryContrast,
          textStyle: const TextStyle(
            fontFamily: fontFamily,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AssistjeTokens.radiusXl),
          ),
        ),
      ),
    );
  }

  static bool get _isCupertino =>
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS;
}

/// Native scrollgedrag per platform: bounce op iOS, clamp + glow op Android.
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
