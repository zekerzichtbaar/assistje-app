import 'package:flutter/material.dart';

import '../theme/assistje_tokens.dart';

/// De Tailwind-kleuren die de PWA voor statussen gebruikt.
///
/// Geen thema-tokens: aanwezig/afwezig/kijken zien er in elk team hetzelfde
/// uit, los van de teamkleur. Namen volgen de Tailwind-schaal zodat je de
/// PWA-klassen 1-op-1 kunt terugvinden.
abstract final class StatusColors {
  static const Color emerald50 = Color(0xFFECFDF5);
  static const Color emerald100 = Color(0xFFD1FAE5);
  static const Color emerald400 = Color(0xFF34D399);
  static const Color emerald500 = Color(0xFF10B981);
  static const Color emerald600 = Color(0xFF059669);
  static const Color emerald700 = Color(0xFF047857);

  static const Color red50 = Color(0xFFFEF2F2);
  static const Color red100 = Color(0xFFFEE2E2);
  static const Color red400 = Color(0xFFF87171);
  static const Color red500 = Color(0xFFEF4444);
  static const Color red600 = Color(0xFFDC2626);
  static const Color red700 = Color(0xFFB91C1C);

  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange400 = Color(0xFFFB923C);
  static const Color orange500 = Color(0xFFF97316);
  static const Color orange700 = Color(0xFFC2410C);

  static const Color sky100 = Color(0xFFE0F2FE);
  static const Color sky200 = Color(0xFFBAE6FD);
  static const Color sky400 = Color(0xFF38BDF8);
  static const Color sky500 = Color(0xFF0EA5E9);
  static const Color sky700 = Color(0xFF0369A1);

  /// Amber (Tailwind `amber-*`): waarschuwingen, "nog te doen", MOTM/goud.
  static const Color amber50 = Color(0xFFFFFBEB);
  static const Color amber100 = Color(0xFFFEF3C7);
  static const Color amber200 = Color(0xFFFDE68A);
  static const Color amber300 = Color(0xFFFCD34D);
  static const Color amber400 = Color(0xFFFBBF24);
  static const Color amber500 = Color(0xFFF59E0B);
  static const Color amber600 = Color(0xFFD97706);
  static const Color amber700 = Color(0xFFB45309);
  static const Color amber800 = Color(0xFF92400E);
  static const Color amber900 = Color(0xFF78350F);

  static const Color rose100 = Color(0xFFFFE4E6);
  static const Color rose500 = Color(0xFFF43F5E);

  // Semantische aliassen.
  static const Color present = emerald600;
  static const Color absent = red600;
  static const Color watch = orange500;
  static const Color injury = red500;
  static const Color vacation = sky500;
  static const Color success = emerald500;
  static const Color error = red500;
  static const Color info = sky500;

  /// Waarschuwing / openstaand (`amber-500`).
  static const Color warning = amber500;
}

/// Aanwezigheidsstatus zoals de API hem levert, plus "nog niet gereageerd".
///
/// `watch` is wat de PWA `nonplay` noemt ("Kijken").
enum AttendanceTone {
  present,
  absent,
  watch,
  injury,
  vacation,
  pending;

  /// Vertaalt een API-waarde (`present`, `absent`, `nonplay`/`watch`,
  /// `injury`, `vacation`); alles anders telt als [pending].
  static AttendanceTone fromApi(String? value) {
    switch (value) {
      case 'present':
        return AttendanceTone.present;
      case 'absent':
        return AttendanceTone.absent;
      case 'nonplay':
      case 'watch':
        return AttendanceTone.watch;
      case 'injury':
      case 'injured':
        return AttendanceTone.injury;
      case 'vacation':
        return AttendanceTone.vacation;
      default:
        return AttendanceTone.pending;
    }
  }
}

/// Kleurenset voor één aanwezigheidsstatus, per thema.
///
/// - [solid] + [onSolid]: gekozen RSVP-knop (`bg-emerald-600 text-white`).
/// - [softBackground] + [softForeground]: tel-pilletje / banner
///   (`bg-emerald-100 text-emerald-700`, in donker `/20` + `-400`).
/// - [bar]: segment in de samenvattingsbalk (`bg-emerald-500`).
@immutable
class AttendanceStatusStyle {
  const AttendanceStatusStyle({
    required this.solid,
    required this.onSolid,
    required this.softBackground,
    required this.softForeground,
    required this.bar,
  });

  final Color solid;
  final Color onSolid;
  final Color softBackground;
  final Color softForeground;
  final Color bar;

  /// Stijl voor [tone] in het huidige thema van [context].
  static AttendanceStatusStyle of(BuildContext context, AttendanceTone tone) {
    final tokens = AssistjeTokens.of(context);
    return resolve(
      tone,
      brightness: Theme.of(context).brightness,
      tokens: tokens,
    );
  }

  /// Zelfde als [of], zonder `BuildContext` (handig in tests en painters).
  static AttendanceStatusStyle resolve(
    AttendanceTone tone, {
    required Brightness brightness,
    required AssistjeTokens tokens,
  }) {
    final dark = brightness == Brightness.dark;
    const white = Color(0xFFFFFFFF);
    switch (tone) {
      case AttendanceTone.present:
        return AttendanceStatusStyle(
          solid: StatusColors.emerald600,
          onSolid: white,
          softBackground: dark
              ? StatusColors.emerald500.withValues(alpha: 0.2)
              : StatusColors.emerald100,
          softForeground: dark
              ? StatusColors.emerald400
              : StatusColors.emerald700,
          bar: StatusColors.emerald500,
        );
      case AttendanceTone.absent:
        return AttendanceStatusStyle(
          solid: StatusColors.red600,
          onSolid: white,
          softBackground: dark
              ? StatusColors.red500.withValues(alpha: 0.2)
              : StatusColors.red100,
          softForeground: dark ? StatusColors.red400 : StatusColors.red700,
          bar: StatusColors.red500,
        );
      case AttendanceTone.watch:
        return AttendanceStatusStyle(
          solid: StatusColors.orange500,
          onSolid: white,
          softBackground: dark
              ? StatusColors.orange500.withValues(alpha: 0.2)
              : StatusColors.orange100,
          softForeground: dark
              ? StatusColors.orange400
              : StatusColors.orange700,
          bar: StatusColors.orange400,
        );
      case AttendanceTone.injury:
        return AttendanceStatusStyle(
          solid: StatusColors.red500,
          onSolid: white,
          softBackground: dark
              ? StatusColors.red500.withValues(alpha: 0.15)
              : StatusColors.red50,
          softForeground: dark ? StatusColors.red400 : StatusColors.red700,
          bar: StatusColors.red500,
        );
      case AttendanceTone.vacation:
        return AttendanceStatusStyle(
          solid: StatusColors.sky500,
          onSolid: white,
          softBackground: dark
              ? StatusColors.sky500.withValues(alpha: 0.15)
              : const Color(0xFFF0F9FF),
          softForeground: dark ? StatusColors.sky400 : StatusColors.sky700,
          bar: StatusColors.sky500,
        );
      case AttendanceTone.pending:
        return AttendanceStatusStyle(
          solid: tokens.sunken,
          onSolid: tokens.inkSoft,
          softBackground: tokens.line,
          softForeground: tokens.inkSoft,
          bar: tokens.muted.withValues(alpha: 0.6),
        );
    }
  }
}
