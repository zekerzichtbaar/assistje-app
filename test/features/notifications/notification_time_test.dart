import 'package:assistje/features/notifications/application/notification_time.dart';
import 'package:assistje/l10n/generated/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() => initializeDateFormatting('nl'));
  final l10n = lookupAppLocalizations(const Locale('nl'));
  final now = DateTime(2026, 10, 9, 18, 30);
  String label(DateTime at) => notificationTimeLabel(l10n, at, now);

  test('relatieve tijd in het Nederlands', () {
    expect(label(now.subtract(const Duration(seconds: 20))), 'zojuist');
    expect(label(now.subtract(const Duration(minutes: 5))), '5 min geleden');
    expect(label(now.subtract(const Duration(hours: 2))), '2 uur geleden');
    expect(label(DateTime(2026, 10, 8, 20)), 'gisteren');
    expect(label(DateTime(2026, 10, 6, 9)), '3 dagen geleden');
    expect(label(DateTime(2026, 9, 12, 9)), '12 sep');
    expect(label(DateTime(2025, 9, 12, 9)), '12 sep 2025');
  });

  test('kort na middernacht: gisteravond telt in uren', () {
    final late = DateTime(2026, 10, 9, 1, 30);
    expect(
      notificationTimeLabel(l10n, DateTime(2026, 10, 8, 23), late),
      '2 uur geleden',
    );
  });
}
