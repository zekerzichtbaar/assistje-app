import 'package:assistje/core/theme/app_theme.dart';
import 'package:assistje/core/theme/assistje_tokens.dart';
import 'package:assistje/core/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_harness.dart';

void main() {
  test('PWA-kleuren (Tailwind)', () {
    expect(StatusColors.present, const Color(0xFF059669)); // emerald-600
    expect(StatusColors.absent, const Color(0xFFDC2626)); // red-600
    expect(StatusColors.watch, const Color(0xFFF97316)); // orange-500
    expect(StatusColors.injury, const Color(0xFFEF4444)); // red-500
    expect(StatusColors.vacation, const Color(0xFF0EA5E9)); // sky-500
  });

  test('amber-schaal (Tailwind)', () {
    expect(StatusColors.amber50, const Color(0xFFFFFBEB));
    expect(StatusColors.amber100, const Color(0xFFFEF3C7));
    expect(StatusColors.amber200, const Color(0xFFFDE68A));
    expect(StatusColors.amber300, const Color(0xFFFCD34D));
    expect(StatusColors.amber400, const Color(0xFFFBBF24));
    expect(StatusColors.amber500, const Color(0xFFF59E0B));
    expect(StatusColors.amber600, const Color(0xFFD97706));
    expect(StatusColors.amber700, const Color(0xFFB45309));
    expect(StatusColors.amber800, const Color(0xFF92400E));
    expect(StatusColors.amber900, const Color(0xFF78350F));
    expect(StatusColors.warning, StatusColors.amber500);
  });

  test('API-waarden → tone', () {
    expect(AttendanceTone.fromApi('present'), AttendanceTone.present);
    expect(AttendanceTone.fromApi('absent'), AttendanceTone.absent);
    expect(AttendanceTone.fromApi('nonplay'), AttendanceTone.watch);
    expect(AttendanceTone.fromApi('watch'), AttendanceTone.watch);
    expect(AttendanceTone.fromApi('injury'), AttendanceTone.injury);
    expect(AttendanceTone.fromApi('vacation'), AttendanceTone.vacation);
    expect(AttendanceTone.fromApi(null), AttendanceTone.pending);
    expect(AttendanceTone.fromApi('iets'), AttendanceTone.pending);
  });

  test('licht vs donker zachte tinten', () {
    final light = AppTheme.light(testTeamHex).extension<AssistjeTokens>()!;
    final dark = AppTheme.dark(testTeamHex).extension<AssistjeTokens>()!;
    final l = AttendanceStatusStyle.resolve(
      AttendanceTone.present,
      brightness: Brightness.light,
      tokens: light,
    );
    final d = AttendanceStatusStyle.resolve(
      AttendanceTone.present,
      brightness: Brightness.dark,
      tokens: dark,
    );
    expect(l.solid, StatusColors.emerald600);
    expect(d.solid, StatusColors.emerald600);
    expect(l.softForeground, StatusColors.emerald700);
    expect(d.softForeground, StatusColors.emerald400);
    expect(l.softBackground, StatusColors.emerald100);
    expect(d.softBackground.a, closeTo(0.2, 0.01));
  });

  testBothThemes('of(context) volgt het thema', (tester, dark) async {
    late AttendanceStatusStyle style;
    late AssistjeTokens tokens;
    await pumpThemed(
      tester,
      Builder(
        builder: (context) {
          tokens = AssistjeTokens.of(context);
          style = AttendanceStatusStyle.of(context, AttendanceTone.pending);
          return const SizedBox();
        },
      ),
      dark: dark,
    );
    expect(style.softBackground, tokens.line);
    for (final tone in AttendanceTone.values) {
      expect(
        AttendanceStatusStyle.resolve(
          tone,
          brightness: dark ? Brightness.dark : Brightness.light,
          tokens: tokens,
        ).bar.a,
        greaterThan(0),
      );
    }
  });
}
