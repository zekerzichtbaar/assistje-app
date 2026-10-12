import 'package:freezed_annotation/freezed_annotation.dart';

part 'lineup_models.freezed.dart';
part 'lineup_models.g.dart';

/// Een speler uit `pool[]` of `slots[].player`.
@freezed
abstract class LineupPlayer with _$LineupPlayer {
  const factory LineupPlayer({
    required int id,
    int? shirtNumber,
    @Default('') String name,

    /// Positiecode van de speler (`ST`, `K`); de volledige naam staat in het
    /// sportprofiel (`positions`). Leeg bij gasten zonder positie.
    @Default('') String position,
    @Default(false) bool isGuest,

    /// Bij een gast: het team waar hij vandaan komt.
    String? fromTeam,
    String? avatarUrl,
  }) = _LineupPlayer;

  factory LineupPlayer.fromJson(Map<String, dynamic> json) =>
      _$LineupPlayerFromJson(json);
}

/// Eén bezette plek (`slots[]`).
@freezed
abstract class LineupSlot with _$LineupSlot {
  const factory LineupSlot({
    @Default(0) int id,
    required String slotCode,
    required LineupPlayer player,
  }) = _LineupSlot;

  factory LineupSlot.fromJson(Map<String, dynamic> json) =>
      _$LineupSlotFromJson(json);
}

/// Een positie van de huidige formatie (`formation_slots[]`); [x]/[y] in
/// procenten van het veld, [label] is de korte naam die de API meegeeft.
@freezed
abstract class FormationSlot with _$FormationSlot {
  const factory FormationSlot({
    required String code,
    @Default(50) double x,
    @Default(50) double y,
    @Default('') String label,
  }) = _FormationSlot;

  factory FormationSlot.fromJson(Map<String, dynamic> json) =>
      _$FormationSlotFromJson(json);
}

/// Een kiesbare formatie (`formations[]`).
@freezed
abstract class FormationOption with _$FormationOption {
  const factory FormationOption({
    required String key,
    @Default('') String label,
  }) = _FormationOption;

  factory FormationOption.fromJson(Map<String, dynamic> json) =>
      _$FormationOptionFromJson(json);
}

/// De wedstrijd waar de opstelling bij hoort (`event`).
@freezed
abstract class LineupEvent with _$LineupEvent {
  const factory LineupEvent({
    required int id,
    @Default('') String title,
    String? startsAt,
    String? homeTeam,
    String? awayTeam,
  }) = _LineupEvent;

  factory LineupEvent.fromJson(Map<String, dynamic> json) =>
      _$LineupEventFromJson(json);
}

/// De opstelling van één wedstrijd (vogels3 `docs/api/v1/lineup.md`). Elke
/// schrijfactie geeft dezelfde vorm terug.
@freezed
abstract class Lineup with _$Lineup {
  const factory Lineup({
    @Default('') String sport,

    /// Welke veldtekening: de enige sportkeuze die de app zelf maakt.
    @Default('') String fieldVariant,
    required LineupEvent event,
    @Default(<LineupPlayer>[]) List<LineupPlayer> pool,
    @Default(<LineupSlot>[]) List<LineupSlot> slots,
    @Default('') String formation,
    @Default(<FormationSlot>[]) List<FormationSlot> formationSlots,
    @Default(<FormationOption>[]) List<FormationOption> formations,
    @Default('') String formationLabel,
    @Default(false) bool canEdit,
    int? captainPlayerId,

    /// ISO-tijdstip van delen; `null` = nog niet gedeeld.
    String? publishedAt,
    @Default(false) bool changedSincePublish,
  }) = _Lineup;

  const Lineup._();

  factory Lineup.fromJson(Map<String, dynamic> json) => _$LineupFromJson(json);

  /// Wie op welke positie van de huidige formatie staat (`null` = leeg).
  /// Slots uit een vorige formatie vallen weg, net als in de PWA.
  Map<String, LineupPlayer?> get assignments {
    final map = <String, LineupPlayer?>{
      for (final slot in formationSlots) slot.code: null,
    };
    for (final slot in slots) {
      if (map.containsKey(slot.slotCode)) map[slot.slotCode] = slot.player;
    }
    return map;
  }

  /// Aanwezigen die niet op het veld staan.
  List<LineupPlayer> get bench {
    final onField = {
      for (final player in assignments.values)
        if (player != null) player.id,
    };
    return [
      for (final player in pool)
        if (!onField.contains(player.id)) player,
    ];
  }

  /// Aantal bezette posities.
  int get filled => assignments.values.whereType<LineupPlayer>().length;

  bool get isShared => publishedAt != null;

  DateTime? get publishedAtTime {
    final raw = publishedAt;
    return raw == null ? null : DateTime.tryParse(raw)?.toLocal();
  }

  /// De code van de plek waar speler [playerId] staat, of `null`.
  String? slotOf(int playerId) {
    for (final entry in assignments.entries) {
      if (entry.value?.id == playerId) return entry.key;
    }
    return null;
  }

  /// Een speler uit de pool of het veld.
  LineupPlayer? player(int playerId) {
    for (final player in pool) {
      if (player.id == playerId) return player;
    }
    for (final slot in slots) {
      if (slot.player.id == playerId) return slot.player;
    }
    return null;
  }
}
