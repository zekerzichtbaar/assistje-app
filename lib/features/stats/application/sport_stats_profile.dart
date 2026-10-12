import '../data/models/stats_models.dart';

/// Wat de sport van een team aan statistieken bijhoudt, gelezen uit het
/// ruwe sportprofiel van `/me` (`TeamMembership.sport` =
/// `SportProfile::toArray()`). Nergens een hardgecodeerde sport: kolommen en
/// ranglijsten volgen alleen deze vlaggen.
class SportStatsProfile {
  const SportStatsProfile({
    this.tracksScorers = false,
    this.tracksPlayingTime = true,
    this.supportsFlagDuty = false,
    this.postMatchStats = false,
    this.cardTypes = const {},
    this.goalsTerm,
    this.assistsTerm,
  });

  /// Uit het ruwe profiel. Ontbrekende velden krijgen de standaard van
  /// `SportProfile` (speelminuten aan, de rest uit).
  factory SportStatsProfile.fromSport(Map<String, dynamic> sport) {
    final mode = sport['match_stats_mode'];
    final terms = sport['terms'];
    final cards = sport['card_types'];
    String? term(String key) {
      if (terms is! Map) return null;
      final value = terms[key];
      return value is String && value.isNotEmpty ? value : null;
    }

    return SportStatsProfile(
      tracksScorers: switch (sport['tracks_scorers']) {
        final bool v => v,
        _ => mode == 'timeline',
      },
      tracksPlayingTime: switch (sport['tracks_playing_time']) {
        final bool v => v,
        _ => true,
      },
      supportsFlagDuty: sport['supports_flag_duty'] == true,
      postMatchStats: mode == 'postmatch',
      cardTypes: {
        if (cards is List)
          for (final card in cards)
            if (card is Map && card['value'] is String)
              card['value'] as String
            else if (card is String)
              card,
      },
      goalsTerm: term('goals'),
      assistsTerm: term('assists'),
    );
  }

  /// Doelpunten en assists per speler (sporten met een tijdlijn).
  final bool tracksScorers;

  /// Speelminuten (niet bij sporten die op punten spelen).
  final bool tracksPlayingTime;

  /// Vlagdienst (vlag-minuten en -beurten).
  final bool supportsFlagDuty;

  /// Statistiekenblad ná afloop (punten/aces/blocks in de Hall of Fame).
  final bool postMatchStats;

  /// Kaartsoorten die de sport kent (`yellow`, `red`, `green`, …).
  final Set<String> cardTypes;

  /// Het woord voor doelpunten/assists in deze sport (`Goals`, `Punten`).
  final String? goalsTerm;
  final String? assistsTerm;

  bool get showsYellow => cardTypes.contains('yellow');
  bool get showsRed => cardTypes.contains('red');
}

/// Waarop de spelerslijst gesorteerd is.
enum StatsSort {
  /// Het overzicht: hele kaart, op aanwezigheid.
  overview,
  attendanceMatch,
  attendanceTraining,
  matchesPlayed,
  minutes,
  goals,
  assists,
  flagMinutes,
  flagShifts,
  trainingPoints,
  name,
}

/// De sorteerkeuzes die bij [profile] horen (zoals `sortOptionsFor()` in de
/// PWA). [trainingPoints]: alleen als de feature aan staat.
List<StatsSort> availableSorts(
  SportStatsProfile profile, {
  bool trainingPoints = false,
}) => [
  StatsSort.overview,
  if (trainingPoints) StatsSort.trainingPoints,
  StatsSort.attendanceMatch,
  StatsSort.attendanceTraining,
  StatsSort.matchesPlayed,
  if (profile.tracksPlayingTime) StatsSort.minutes,
  if (profile.tracksScorers) ...[StatsSort.goals, StatsSort.assists],
  if (profile.supportsFlagDuty) ...[
    StatsSort.flagMinutes,
    StatsSort.flagShifts,
  ],
  StatsSort.name,
];

/// De waarde van [row] voor sortering [sort] (`null` voor naam/overzicht).
num? statsMetric(StatsRow row, StatsSort sort) => switch (sort) {
  StatsSort.overview => row.attendanceRate,
  StatsSort.attendanceMatch => row.attendanceMatchRate,
  StatsSort.attendanceTraining => row.attendanceTrainingRate,
  StatsSort.matchesPlayed => row.matchesPlayed,
  StatsSort.minutes => row.minutes,
  StatsSort.goals => row.goals,
  StatsSort.assists => row.assists,
  StatsSort.flagMinutes => row.flagMinutes,
  StatsSort.flagShifts => row.flagShifts,
  StatsSort.trainingPoints => row.trainingPoints,
  StatsSort.name => null,
};

/// Een gesorteerde kopie: naam oplopend, al het andere aflopend met naam
/// als tiebreak (stabiel, ook bij gelijke stand).
List<StatsRow> sortStatsRows(List<StatsRow> rows, StatsSort sort) {
  int byName(StatsRow a, StatsRow b) =>
      a.name.toLowerCase().compareTo(b.name.toLowerCase());
  final copy = [...rows];
  copy.sort((a, b) {
    if (sort == StatsSort.name) return byName(a, b);
    final va = statsMetric(a, sort) ?? 0;
    final vb = statsMetric(b, sort) ?? 0;
    final cmp = vb.compareTo(va);
    return cmp != 0 ? cmp : byName(a, b);
  });
  return copy;
}
