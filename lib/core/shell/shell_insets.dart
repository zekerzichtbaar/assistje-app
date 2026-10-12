import 'package:flutter/widgets.dart';

/// Ruimte die schermen in de shell vrij moeten houden voor de zwevende pills
/// (boven) en de glazen tabbalk (onder), inclusief de veilige zones.
abstract final class ShellInsets {
  /// Hoogte van een zwevende pill.
  static const double pillSize = 44;

  /// Afstand van de pills tot de veilige zone bovenin.
  static const double pillTopGap = 8;

  /// Hoogte van de tabbalk zonder de veilige zone.
  static const double tabBarHeight = 64;

  /// Bovenkant van de inhoud: onder de pills.
  static double top(BuildContext context) =>
      MediaQuery.paddingOf(context).top + pillTopGap + pillSize + 12;

  /// Onderkant van de inhoud: boven de tabbalk.
  static double bottom(BuildContext context) =>
      tabBarBottomGap(context) + tabBarHeight + 16;

  /// Afstand van de tabbalk tot de onderrand (70% van de veilige zone, net
  /// als `max(env(safe-area-inset-bottom)*0.7, 0.5rem)` in de PWA).
  static double tabBarBottomGap(BuildContext context) {
    final safe = MediaQuery.paddingOf(context).bottom * 0.7;
    return safe < 8 ? 8 : safe;
  }
}
