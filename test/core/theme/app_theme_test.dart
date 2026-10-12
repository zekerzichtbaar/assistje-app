import 'package:assistje/core/theme/app_theme.dart';
import 'package:assistje/core/theme/assistje_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('licht thema gebruikt de clubkleur en de lichte tokens', () {
    final theme = AppTheme.light('#E30613');
    final tokens = theme.extension<AssistjeTokens>()!;

    expect(theme.brightness, Brightness.light);
    expect(theme.colorScheme.primary, const Color(0xFFE30613));
    expect(theme.colorScheme.onPrimary, const Color(0xFFFFFFFF));
    expect(tokens.surface, const Color(0xFFFFFFFF));
    expect(tokens.sunken, const Color.fromARGB(255, 243, 244, 246));
    expect(theme.scaffoldBackgroundColor, tokens.sunken);
  });

  test('donker thema gebruikt de opgetilde clubkleur en donkere tokens', () {
    final theme = AppTheme.dark('#006837');
    final tokens = theme.extension<AssistjeTokens>()!;

    expect(theme.brightness, Brightness.dark);
    expect(theme.colorScheme.primary, const Color(0xFF13EC86));
    expect(theme.colorScheme.onPrimary, const Color(0xFF000000));
    expect(tokens.surface, const Color.fromARGB(255, 21, 21, 28));
    expect(tokens.ink, const Color(0xFFFFFFFF));
  });

  test('iOS krijgt Cupertino-paginaovergangen', () {
    final theme = AppTheme.light(null);
    expect(
      theme.pageTransitionsTheme.builders[TargetPlatform.iOS],
      isA<CupertinoPageTransitionsBuilder>(),
    );
  });
}
