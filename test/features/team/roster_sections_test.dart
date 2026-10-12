import 'package:assistje/features/team/application/roster_sections.dart';
import 'package:assistje/features/team/application/sport_info.dart';
import 'package:assistje/features/team/data/models/roster_models.dart';
import 'package:flutter_test/flutter_test.dart';

import 'roster_fixtures.dart';

RosterPlayer _p(int id, String? position, {bool guest = false}) =>
    RosterPlayer(id: id, name: 'P$id', position: position, isGuest: guest);

void main() {
  final football = SportInfo(RosterFixtures.footballSport());

  group('SportInfo', () {
    test('positienaam uit de sport, anders de code, leeg = null', () {
      expect(football.positionLabel('CM'), 'Centrale middenvelder');
      expect(football.positionLabel('TR'), 'TR');
      expect(football.positionLabel(null), isNull);
      expect(football.positionLabel('  '), isNull);
    });

    test('linies, termen, kaarten, scorers', () {
      expect(football.positionGroups.map((g) => g.key), [
        'gk',
        'def',
        'mid',
        'att',
      ]);
      expect(football.positionGroups.first.codes, ['K', 'GK']);
      expect(football.term('goals'), 'Goals');
      expect(football.term('nope'), isNull);
      expect(football.cardTypes, {'yellow', 'red'});
      expect(football.tracksScorers, isTrue);
      expect(football.fieldVariant, 'football');
    });

    test('lege sport valt neutraal terug', () {
      const empty = SportInfo({});
      expect(empty.positionLabel('X'), 'X');
      expect(empty.positionGroups, isEmpty);
      expect(empty.cardTypes, isNull);
      expect(empty.tracksScorers, isTrue);
      expect(empty.term('goals'), isNull);
    });
  });

  group('RosterSections', () {
    test('vaste spelers per linie, Overig, gasten apart', () {
      final roster = TeamRoster(
        players: [
          _p(1, 'K'),
          _p(2, 'ST'),
          _p(3, 'CB'),
          _p(4, 'TR'),
          _p(5, null),
          _p(6, 'GK'),
          _p(7, 'CM', guest: true),
        ],
      );

      final sections = RosterSections.of(roster, football);

      expect(sections.lines.map((l) => l.key), ['gk', 'def', 'att']);
      expect(sections.lines.first.label, 'Keepers');
      expect(sections.lines.first.players.map((p) => p.id), [1, 6]);
      expect(sections.lines[1].players.map((p) => p.id), [3]);
      expect(sections.lines[2].players.map((p) => p.id), [2]);
      expect(sections.other.map((p) => p.id), [4, 5]);
      expect(sections.guests.map((p) => p.id), [7]);
    });

    test('sport zonder linies: alles vast onder Overig', () {
      final roster = TeamRoster(players: [_p(1, 'K'), _p(2, null)]);
      final sections = RosterSections.of(roster, const SportInfo({}));
      expect(sections.lines, isEmpty);
      expect(sections.other.map((p) => p.id), [1, 2]);
      expect(sections.guests, isEmpty);
    });
  });
}
