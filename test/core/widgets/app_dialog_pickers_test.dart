import 'package:assistje/core/theme/app_theme.dart';
import 'package:assistje/core/widgets/widgets.dart';
import 'package:assistje/l10n/generated/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_harness.dart';

/// Een app met het Assistje-thema op [platform], Nederlandse copy en een
/// knop die [onOpen] aanroept.
Future<void> _pump(
  WidgetTester tester,
  TargetPlatform platform,
  Future<void> Function(BuildContext context) onOpen,
) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(testTeamHex).copyWith(platform: platform),
      locale: const Locale('nl'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(
        body: Builder(
          builder: (context) => Center(
            child: TextButton(
              onPressed: () => onOpen(context),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

void main() {
  group('showConfirmDialog', () {
    for (final platform in [TargetPlatform.iOS, TargetPlatform.android]) {
      testWidgets('${platform.name}: native dialoog, bevestigen geeft true', (
        tester,
      ) async {
        bool? result;
        await _pump(tester, platform, (context) async {
          result = await showConfirmDialog(
            context,
            message: 'Verwijderen?',
            confirmLabel: 'Verwijder',
            cancelLabel: 'Annuleren',
            destructive: true,
            confirmKey: const ValueKey('ok'),
          );
        });

        expect(
          find.byType(CupertinoAlertDialog),
          platform == TargetPlatform.iOS ? findsOneWidget : findsNothing,
        );
        expect(
          find.byType(AlertDialog),
          platform == TargetPlatform.iOS ? findsNothing : findsOneWidget,
        );
        await tester.tap(find.byKey(const ValueKey('ok')));
        await tester.pumpAndSettle();
        expect(result, isTrue);
      });
    }

    testWidgets('iOS: destructief is rood, Annuleren is de standaardknop', (
      tester,
    ) async {
      bool? result;
      await _pump(tester, TargetPlatform.iOS, (context) async {
        result = await showConfirmDialog(
          context,
          message: 'Verwijderen?',
          confirmLabel: 'Verwijder',
          cancelLabel: 'Annuleren',
          destructive: true,
        );
      });
      final actions = tester
          .widgetList<CupertinoDialogAction>(find.byType(CupertinoDialogAction))
          .toList();
      expect(actions.first.isDefaultAction, isTrue);
      expect(actions.last.isDestructiveAction, isTrue);

      await tester.tap(find.text('Annuleren'));
      await tester.pumpAndSettle();
      expect(result, isFalse);
    });
  });

  group('showAppDatePicker / showAppTimePicker', () {
    testWidgets('iOS: wieltjes met Gereed geven de gekozen datum terug', (
      tester,
    ) async {
      DateTime? result;
      await _pump(tester, TargetPlatform.iOS, (context) async {
        result = await showAppDatePicker(
          context: context,
          initialDate: DateTime(2030),
          firstDate: DateTime(2020),
          lastDate: DateTime(2025, 12, 31),
        );
      });
      expect(find.byType(CupertinoDatePicker), findsOneWidget);
      expect(find.byType(DatePickerDialog), findsNothing);

      await tester.tap(find.byKey(const ValueKey('picker-done')));
      await tester.pumpAndSettle();
      // Het begin lag na lastDate en is daarbinnen getrokken.
      expect(result, DateTime(2025, 12, 31));
    });

    testWidgets('iOS: Annuleren geeft null', (tester) async {
      TimeOfDay? result = const TimeOfDay(hour: 1, minute: 1);
      await _pump(tester, TargetPlatform.iOS, (context) async {
        result = await showAppTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 19, minute: 30),
        );
      });
      expect(find.byType(CupertinoDatePicker), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('picker-cancel')));
      await tester.pumpAndSettle();
      expect(result, isNull);
    });

    testWidgets('iOS: tijd met Gereed geeft de begintijd terug', (
      tester,
    ) async {
      TimeOfDay? result;
      await _pump(tester, TargetPlatform.iOS, (context) async {
        result = await showAppTimePicker(
          context: context,
          initialTime: const TimeOfDay(hour: 19, minute: 30),
        );
      });
      await tester.tap(find.byKey(const ValueKey('picker-done')));
      await tester.pumpAndSettle();
      expect(result, const TimeOfDay(hour: 19, minute: 30));
    });

    testWidgets('Android: de Material-kalender', (tester) async {
      await _pump(tester, TargetPlatform.android, (context) async {
        await showAppDatePicker(
          context: context,
          initialDate: DateTime(2024, 5, 2),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
        );
      });
      expect(find.byType(DatePickerDialog), findsOneWidget);
      expect(find.byType(CupertinoDatePicker), findsNothing);
    });
  });
}
