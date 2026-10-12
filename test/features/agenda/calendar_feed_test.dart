import 'package:assistje/features/agenda/application/calendar_feed.dart';
import 'package:flutter_test/flutter_test.dart';

const _base = 'https://vogels-3.assistje.nl/calendar/tok123/agenda.ics';

void main() {
  group('buildAgendaFeedUrl', () {
    test('standaard: wedstrijden, trainingen en alle diensten', () {
      expect(
        buildAgendaFeedUrl(
          _base,
          const AgendaFeedSelection(duties: ['canteen', 'wash']),
        ),
        '$_base?matches=1&trainings=1&duties=canteen,wash',
      );
    });

    test('alleen waar ik bij ben', () {
      expect(
        buildAgendaFeedUrl(
          _base,
          const AgendaFeedSelection(trainings: false, onlyMine: true),
        ),
        '$_base?matches=1&mine=1',
      );
    });

    test('alleen diensten', () {
      expect(
        buildAgendaFeedUrl(
          _base,
          const AgendaFeedSelection(
            matches: false,
            trainings: false,
            duties: ['canteen'],
          ),
        ),
        '$_base?duties=canteen',
      );
    });

    test('niets gekozen of geen feed → null', () {
      expect(
        buildAgendaFeedUrl(
          _base,
          const AgendaFeedSelection(matches: false, trainings: false),
        ),
        isNull,
      );
      expect(buildAgendaFeedUrl(null, const AgendaFeedSelection()), isNull);
      expect(buildAgendaFeedUrl('', const AgendaFeedSelection()), isNull);
    });

    test('slugs worden ge-escaped', () {
      expect(
        buildAgendaFeedUrl(
          _base,
          const AgendaFeedSelection(
            matches: false,
            trainings: false,
            duties: ['a&b'],
          ),
        ),
        '$_base?duties=a%26b',
      );
    });
  });

  test('toWebcalUrl vervangt alleen het schema', () {
    expect(
      toWebcalUrl('$_base?matches=1'),
      'webcal://vogels-3.assistje.nl/calendar/tok123/agenda.ics?matches=1',
    );
    expect(
      toWebcalUrl('http://localhost:8000/x.ics'),
      'webcal://localhost:8000/x.ics',
    );
  });
}
