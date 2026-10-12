import '../data/models/roster_models.dart';
import 'sport_info.dart';

/// Een linie met de vaste spelers die erin vallen.
class RosterLine {
  const RosterLine({
    required this.key,
    required this.label,
    required this.players,
  });

  final String key;
  final String label;
  final List<RosterPlayer> players;
}

/// De selectie ingedeeld zoals `/team` in de PWA: vaste spelers per linie
/// van de sport, wat in geen linie past onder "Overig", en de gasten apart.
/// De volgorde binnen een groep is die van de server (op rugnummer).
class RosterSections {
  const RosterSections({
    required this.lines,
    required this.other,
    required this.guests,
  });

  factory RosterSections.of(TeamRoster roster, SportInfo sport) {
    final regulars = roster.players.where((p) => !p.isGuest).toList();
    final used = <int>{};
    final lines = <RosterLine>[];
    for (final group in sport.positionGroups) {
      final list = [
        for (final p in regulars)
          if (!used.contains(p.id) && group.codes.contains(p.position)) p,
      ];
      used.addAll(list.map((p) => p.id));
      if (list.isNotEmpty) {
        lines.add(
          RosterLine(key: group.key, label: group.label, players: list),
        );
      }
    }
    return RosterSections(
      lines: lines,
      other: [
        for (final p in regulars)
          if (!used.contains(p.id)) p,
      ],
      guests: roster.players.where((p) => p.isGuest).toList(),
    );
  }

  final List<RosterLine> lines;

  /// Vaste spelers zonder herkenbare linie (geen positie, onbekende code).
  final List<RosterPlayer> other;
  final List<RosterPlayer> guests;
}
