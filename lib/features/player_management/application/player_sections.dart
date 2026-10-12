import '../../team/application/sport_info.dart';
import '../data/models/player_management_models.dart';

/// Een kaart met spelers op het beheerscherm.
class PlayerSection {
  const PlayerSection({
    required this.key,
    required this.label,
    required this.players,
  });

  /// `group-<linie>`, `other` of `guests`.
  final String key;

  /// Linienaam uit het sportprofiel; `null` = "Overig"/"Gasten" (vertaald
  /// door het scherm via [key]).
  final String? label;
  final List<ManagedPlayer> players;
}

/// De indeling van `Trainer/Players/Index.tsx`:
///
/// - **Trainers**: spelers met positie `TR` plus de "coaches" (trainers
///   zónder spelersprofiel). Wie óók speelt staat in zijn linie.
/// - Per linie uit `sport.position_groups` (lege linies vallen weg).
/// - **Overig**: vaste spelers zonder (bekende) linie.
/// - **Gasten**: eigen kaart, los van de linies.
/// - **Toeschouwers** apart (niet hier).
class PlayerSections {
  PlayerSections._({
    required this.trainerPlayers,
    required this.coaches,
    required this.sections,
  });

  factory PlayerSections.of(PlayerManagement data, SportInfo sport) {
    final playerUserIds = {
      for (final p in data.players)
        if (p.userId != null) p.userId,
    };
    final coaches = [
      for (final t in data.trainers)
        if (!playerUserIds.contains(t.id)) t,
    ];
    final guests = [
      for (final p in data.players)
        if (p.isGuest) p,
    ];
    final regulars = [
      for (final p in data.players)
        if (!p.isGuest) p,
    ];
    final used = <int>{};
    final sections = <PlayerSection>[];
    for (final group in sport.positionGroups) {
      final list = [
        for (final p in regulars)
          if (p.position != null && group.codes.contains(p.position)) p,
      ];
      used.addAll(list.map((p) => p.id));
      if (list.isNotEmpty) {
        sections.add(
          PlayerSection(
            key: 'group-${group.key}',
            label: group.label,
            players: list,
          ),
        );
      }
    }
    final trainerPlayers = [
      for (final p in regulars)
        if (p.position == 'TR' && !used.contains(p.id)) p,
    ];
    used.addAll(trainerPlayers.map((p) => p.id));
    final other = [
      for (final p in regulars)
        if (!used.contains(p.id)) p,
    ];
    if (other.isNotEmpty) {
      sections.add(PlayerSection(key: 'other', label: null, players: other));
    }
    if (guests.isNotEmpty) {
      sections.add(PlayerSection(key: 'guests', label: null, players: guests));
    }
    return PlayerSections._(
      trainerPlayers: trainerPlayers,
      coaches: coaches,
      sections: sections,
    );
  }

  /// Spelers met positie `TR` (bovenaan bij de trainers).
  final List<ManagedPlayer> trainerPlayers;

  /// Trainers zonder spelersprofiel.
  final List<ManagedTrainer> coaches;

  /// Linies, Overig en Gasten, in die volgorde.
  final List<PlayerSection> sections;

  bool get hasTrainers => trainerPlayers.isNotEmpty || coaches.isNotEmpty;
}
