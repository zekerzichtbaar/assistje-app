import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_teams_models.freezed.dart';
part 'training_teams_models.g.dart';

/// Bovengrens op de punten per ploeg of speler (de server bewaakt dezelfde
/// marge: 0–10).
const int maxTeamPoints = 10;

/// Snelknoppen in de uitslag: winst / gelijk / verlies (`QUICK_*` in de PWA).
const int quickWinPoints = 2;
const int quickDrawPoints = 1;
const int quickLossPoints = 0;

/// Waarop de indeling stuurt (`teams.basis`).
enum TrainingBasis {
  strength,
  points,
  random;

  /// De waarde zoals de API hem verwacht.
  String get apiValue => name;
}

/// De training bovenaan het scherm (`data.event`).
@freezed
abstract class TrainingTeamsEvent with _$TrainingTeamsEvent {
  const factory TrainingTeamsEvent({
    required int id,
    @Default('') String title,
    DateTime? startsAt,
  }) = _TrainingTeamsEvent;

  factory TrainingTeamsEvent.fromJson(Map<String, dynamic> json) =>
      _$TrainingTeamsEventFromJson(json);
}

/// Een aanwezige die meedoet (`data.teams.players[]`). `side` `null` = op de
/// bank.
@freezed
abstract class TrainingTeamPlayer with _$TrainingTeamPlayer {
  const factory TrainingTeamPlayer({
    required int id,
    @Default('') String name,
    String? side,

    /// Positiecode uit het sportprofiel (label via `SportInfo`).
    String? position,

    /// Ingestelde speelsterkte (1–5); alleen voor wie mag indelen.
    int? strength,

    /// Afgeleid uit de historie (1–5, met decimalen); alleen voor wie mag
    /// indelen en niet bij basis `random`.
    double? derived,
  }) = _TrainingTeamPlayer;

  factory TrainingTeamPlayer.fromJson(Map<String, dynamic> json) =>
      _$TrainingTeamPlayerFromJson(json);
}

Map<String, int> _scoresFromJson(Object? json) {
  if (json is! Map) return const {};
  return {
    for (final entry in json.entries)
      if (entry.value is num) '${entry.key}': (entry.value as num).toInt(),
  };
}

/// De indeling en de uitslag (`data.teams`).
@freezed
abstract class TrainingTeamsBoard with _$TrainingTeamsBoard {
  const factory TrainingTeamsBoard({
    @Default(false) bool mayAssign,
    @Default(false) bool tracksPoints,
    @Default(false) bool tracksTeams,
    @JsonKey(unknownEnumValue: TrainingBasis.strength)
    @Default(TrainingBasis.strength)
    TrainingBasis basis,

    /// Uitslag per ploeg (`side` → punten). Leeg = nog niets ingevuld.
    @JsonKey(fromJson: _scoresFromJson)
    @Default(<String, int>{})
    Map<String, int> scores,
    @Default(<TrainingTeamPlayer>[]) List<TrainingTeamPlayer> players,
  }) = _TrainingTeamsBoard;

  const TrainingTeamsBoard._();

  factory TrainingTeamsBoard.fromJson(Map<String, dynamic> json) =>
      _$TrainingTeamsBoardFromJson(json);

  /// Wie in een ploeg staat.
  List<TrainingTeamPlayer> get assigned => [
    for (final p in players)
      if (p.side != null) p,
  ];

  /// Wie op de bank zit.
  List<TrainingTeamPlayer> get bench => [
    for (final p in players)
      if (p.side == null) p,
  ];

  bool get hasTeams => players.any((p) => p.side != null);

  /// De spelers van ploeg [side].
  List<TrainingTeamPlayer> playersOf(String side) => [
    for (final p in players)
      if (p.side == side) p,
  ];

  TrainingTeamPlayer? player(int id) {
    for (final p in players) {
      if (p.id == id) return p;
    }
    return null;
  }
}

/// Eén regel in de puntenlijst (`data.scoring[]`).
@freezed
abstract class ScoringRow with _$ScoringRow {
  const factory ScoringRow({
    required int id,
    @Default('') String name,
    int? shirtNumber,
    String? avatarUrl,

    /// Wat de partijvorm opleverde; `null` = nog niets.
    int? scored,

    /// Inclusief het aanwezigheidspunt als het team dat rekent.
    @Default(0) int points,
  }) = _ScoringRow;

  factory ScoringRow.fromJson(Map<String, dynamic> json) =>
      _$ScoringRowFromJson(json);
}

/// Terug te zetten in de puntenlijst (`data.scoring_available[]`).
@freezed
abstract class ScoringOption with _$ScoringOption {
  const factory ScoringOption({
    required int id,
    @Default('') String name,
    int? shirtNumber,
  }) = _ScoringOption;

  factory ScoringOption.fromJson(Map<String, dynamic> json) =>
      _$ScoringOptionFromJson(json);
}

/// Het complete scherm (`GET …/events/{event}/teams` en elke schrijfactie op
/// de training).
@freezed
abstract class TrainingTeams with _$TrainingTeams {
  const factory TrainingTeams({
    required TrainingTeamsEvent event,

    /// De mogelijke ploegcodes, in volgorde.
    @Default(<String>[]) List<String> sides,
    @Default(2) int maxTeams,
    @Default(TrainingTeamsBoard()) TrainingTeamsBoard teams,
    @Default(<ScoringRow>[]) List<ScoringRow> scoring,
    @Default(<ScoringOption>[]) List<ScoringOption> scoringAvailable,
  }) = _TrainingTeams;

  const TrainingTeams._();

  factory TrainingTeams.fromJson(Map<String, dynamic> json) =>
      _$TrainingTeamsFromJson(json);

  /// Alleen de ploegen die bezet zijn, in de volgorde van [sides] — bij twee
  /// teams geen vier lege kolommen.
  List<String> get usedSides => [
    for (final s in sides)
      if (teams.players.any((p) => p.side == s)) s,
  ];

  /// Volgnummer (1-based) van ploeg [side] voor het label "Team n".
  int sideNumber(String side) {
    final index = sides.indexOf(side);
    return index < 0 ? 1 : index + 1;
  }

  /// [player] van plek ruilen met [other] (de bank telt als plek).
  TrainingTeams swapped(int player, int other) {
    final a = teams.player(player);
    final b = teams.player(other);
    if (a == null || b == null) return this;
    return copyWith(
      teams: teams.copyWith(
        players: [
          for (final p in teams.players)
            if (p.id == a.id)
              p.copyWith(side: b.side)
            else if (p.id == b.id)
              p.copyWith(side: a.side)
            else
              p,
        ],
      ),
    );
  }

  /// [player] naar ploeg [side] (of `null`: de bank).
  TrainingTeams moved(int player, String? side) => copyWith(
    teams: teams.copyWith(
      players: [
        for (final p in teams.players)
          if (p.id == player) p.copyWith(side: side) else p,
      ],
    ),
  );

  /// De uitslag vervangen door [scores] (ontbrekende ploegen zijn leeg).
  TrainingTeams withScores(Map<String, int> scores) =>
      copyWith(teams: teams.copyWith(scores: Map.unmodifiable(scores)));

  /// De speelsterkte van [player] op [strength] (of leeg).
  TrainingTeams withStrength(int player, int? strength) => copyWith(
    teams: teams.copyWith(
      players: [
        for (final p in teams.players)
          if (p.id == player) p.copyWith(strength: strength) else p,
      ],
    ),
  );

  TrainingTeams withBasis(TrainingBasis basis) =>
      copyWith(teams: teams.copyWith(basis: basis));

  /// De partijpunten van [player] op [scored]; `points` schuift mee.
  TrainingTeams withPlayerScore(int player, int scored) => copyWith(
    scoring: [
      for (final r in scoring)
        if (r.id == player)
          r.copyWith(
            scored: scored,
            points: r.points + scored - (r.scored ?? 0),
          )
        else
          r,
    ],
  );
}
