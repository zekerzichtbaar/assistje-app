import 'package:assistje/core/theme/theme_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _container(Map<String, Object> values) async {
  SharedPreferences.setMockInitialValues(values);
  final prefs = await SharedPreferences.getInstance();
  final container = ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  test('standaard volgt het thema het systeem', () async {
    final container = await _container({});
    expect(container.read(themeModeProvider), ThemeMode.system);
  });

  test('keuze wordt bewaard en weer ingelezen', () async {
    final container = await _container({});
    await container.read(themeModeProvider.notifier).set(ThemeMode.dark);
    expect(container.read(themeModeProvider), ThemeMode.dark);

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(ThemeModeNotifier.storageKey), 'dark');
  });

  test('bewaarde keuze wordt bij opstart gelezen', () async {
    final container = await _container({ThemeModeNotifier.storageKey: 'light'});
    expect(container.read(themeModeProvider), ThemeMode.light);
  });
}
