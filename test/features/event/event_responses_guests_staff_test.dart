import 'package:assistje/core/theme/app_theme.dart';
import 'package:assistje/features/agenda/data/models/agenda_models.dart';
import 'package:assistje/features/event/data/models/event_detail_models.dart';
import 'package:assistje/features/event/presentation/widgets/event_players_section.dart';
import 'package:assistje/features/event/presentation/widgets/event_responses_card.dart';
import 'package:assistje/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Finder _key(String k) => find.byKey(ValueKey(k));

Future<void> _pump(
  WidgetTester tester,
  WidgetBuilder builder, {
  bool dark = false,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: dark ? AppTheme.dark(null) : AppTheme.light(null),
      locale: const Locale('nl'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Scaffold(
        body: SingleChildScrollView(child: Builder(builder: builder)),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

String _legendCount(WidgetTester tester, AttendanceStatus s) {
  final texts = tester.widgetList<Text>(
    find.descendant(
      of: _key('event-count-${s.name}'),
      matching: find.byType(Text),
    ),
  );
  // Label, getal, eventueel chipjes: het getal is de tweede.
  return texts.elementAt(1).data!;
}

EventPlayer _p(
  int id,
  EventPlayerKind kind,
  AttendanceStatus status, {
  String? name,
}) => EventPlayer(
  id: id,
  kind: kind,
  rowKey: '${kind.name}$id',
  name: name ?? '${kind.name} $id',
  isGuest: kind == EventPlayerKind.guest,
  status: status,
);

void main() {
  group('EventResponsesCard', () {
    testWidgets('staf en gasten tellen op in Aanwezig, met chipjes', (
      tester,
    ) async {
      await _pump(
        tester,
        (_) => const EventResponsesCard(
          counts: AttendanceCounts(present: 13, absent: 1, pending: 2),
          playerCounts: AttendanceCounts(present: 11, absent: 1, pending: 2),
          guestsPresent: 1,
          staffPresent: 2,
        ),
      );

      // 11 spelers + 2 staf + 1 gast.
      expect(_legendCount(tester, AttendanceStatus.present), '14');
      expect(_legendCount(tester, AttendanceStatus.absent), '1');
      expect(
        find.descendant(
          of: _key('event-count-staff-chip'),
          matching: find.text('2 staf'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: _key('event-count-guests-chip'),
          matching: find.text('1 gast'),
        ),
        findsOneWidget,
      );
      // Staf vóór de gasten.
      expect(
        tester.getTopLeft(_key('event-count-staff-chip')).dx,
        lessThan(tester.getTopLeft(_key('event-count-guests-chip')).dx),
      );
      // De breuk blijft over iedereen die moet reageren.
      expect(find.text('14 van 16 gereageerd'), findsOneWidget);
    });

    testWidgets('zonder staf geen stafchip; meervoud gasten', (tester) async {
      await _pump(
        tester,
        (_) => const EventResponsesCard(
          counts: AttendanceCounts(absent: 3),
          playerCounts: AttendanceCounts(absent: 3),
          guestsPresent: 2,
        ),
      );

      // Niemand uit de selectie, wél gasten: Aanwezig blijft staan.
      expect(_legendCount(tester, AttendanceStatus.present), '2');
      expect(_key('event-count-staff-chip'), findsNothing);
      expect(find.text('2 gasten'), findsOneWidget);
    });

    testWidgets('chipjes: minstens 11 pt, ook in donker', (tester) async {
      await _pump(
        tester,
        (_) => const EventResponsesCard(
          counts: AttendanceCounts(present: 3),
          guestsPresent: 1,
          staffPresent: 1,
        ),
        dark: true,
      );
      for (final chip in [
        'event-count-staff-chip',
        'event-count-guests-chip',
      ]) {
        final text = tester.widget<Text>(
          find.descendant(of: _key(chip), matching: find.byType(Text)),
        );
        expect(text.style!.fontSize, greaterThanOrEqualTo(11));
      }
    });
  });

  group('buildEventPlayerGroups', () {
    final players = [
      _p(1, EventPlayerKind.player, AttendanceStatus.present, name: 'Kees'),
      _p(2, EventPlayerKind.guest, AttendanceStatus.present, name: 'Gast Aan'),
      _p(3, EventPlayerKind.guest, AttendanceStatus.pending, name: 'Gast Uit'),
      _p(4, EventPlayerKind.staff, AttendanceStatus.present, name: 'Coach'),
    ];

    testWidgets('aanwezige gast onder Aanwezig met label; blok houdt de rest', (
      tester,
    ) async {
      await _pump(
        tester,
        (context) => Column(
          children: buildEventPlayerGroups(context, players, isTrainer: true),
        ),
      );

      final present = _key('event-group-present');
      expect(
        find.descendant(of: present, matching: find.text('Gast Aan')),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: present,
          matching: _key('event-player-guest-badge-guest2'),
        ),
        findsOneWidget,
      );
      // Teller van Aanwezig telt de gast mee.
      expect(
        find.descendant(of: present, matching: find.text('2')),
        findsOneWidget,
      );

      final guests = _key('event-group-guests');
      expect(
        find.descendant(of: guests, matching: find.text('Gast Uit')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: guests, matching: find.text('Gast Aan')),
        findsNothing,
      );
      // Alleen het aantal, geen breuk.
      expect(
        find.descendant(of: guests, matching: find.text('1')),
        findsOneWidget,
      );
      // Staf staat nog altijd in zijn eigen blok.
      expect(
        find.descendant(of: present, matching: find.text('Coach')),
        findsNothing,
      );
    });

    testWidgets('geen trainer: geen gastenblok, aanwezige gast wel zichtbaar', (
      tester,
    ) async {
      await _pump(
        tester,
        (context) => Column(
          children: buildEventPlayerGroups(context, players, isTrainer: false),
        ),
      );

      expect(_key('event-group-guests'), findsNothing);
      expect(find.text('Gast Aan'), findsOneWidget);
      expect(find.text('Gast Uit'), findsNothing);
    });
  });
}
