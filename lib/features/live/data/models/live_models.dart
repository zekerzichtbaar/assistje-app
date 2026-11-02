import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'live_models.freezed.dart';
part 'live_models.g.dart';

/// De klok-state van een wedstrijd (`event.live`). De lopende minuut rekent
/// de app zelf uit, net als `lib/matchClock.ts` in de PWA.
@freezed
abstract class LiveClock with _$LiveClock {
  const factory LiveClock({
    @Default(false) bool isLive,
    @Default(false) bool running,
    DateTime? startedAt,
    @Default(0) int accumulatedSeconds,
    DateTime? endedAt,
    @Default(1) int period,

    /// Minuten waarop de delen eindigen (`[45, 90]`); leeg bij een sport die
    /// niet op tijd speelt. Bij een verlenging lopen ze door
    /// (`[45, 90, 105, 120]`).
    @Default(<int>[]) List<int> periodEnds,

    /// Hoeveel delen de reguliere speeltijd telt; `0` als de server het niet
    /// meestuurt (dan geldt `rules.periods.count`). Een deel daarboven is
    /// verlenging.
    @Default(0) int regularPeriods,

    /// Is de verlenging gestart?
    @Default(false) bool extraTime,

    /// De strafschoppenserie, of `null` als er geen is.
    LiveShootout? shootout,

    /// Wat er achter de uitslag hoort: `n.v.` of `4–3 n.s.` (thuis–uit).
    String? resultSuffix,
  }) = _LiveClock;

  const LiveClock._();

  factory LiveClock.fromJson(Map<String, dynamic> json) =>
      _$LiveClockFromJson(json);

  /// Is de eindfluit gegaan?
  bool get isEnded => endedAt != null;

  /// Loopt de wedstrijd (ook tijdens de rust), nog zonder eindfluit?
  bool get inPlay => isLive && !isEnded;

  /// Is er afgetrapt (lopend of afgelopen)?
  bool get hasStarted => isLive || isEnded;

  /// Rust of onderbreking: begonnen, niet afgelopen, klok stil.
  bool get isPaused => inPlay && !running;

  /// Verstreken seconden op [now].
  int secondsAt(DateTime now) {
    final start = startedAt;
    if (!running || start == null) return accumulatedSeconds;
    final delta = now.difference(start).inSeconds;
    return accumulatedSeconds + (delta < 0 ? 0 : delta);
  }

  /// Lopende wedstrijdminuut op [now].
  int minuteAt(DateTime now) => secondsAt(now) ~/ 60;

  /// Het speeldeel dat loopt, geklemd op wat de sport kent.
  int get currentPeriod {
    final count = periodEnds.isEmpty ? 1 : periodEnds.length;
    return period.clamp(1, count);
  }

  /// De minuut waarop het lopende deel hoort te eindigen, of `null`.
  int? get periodEnd =>
      periodEnds.isEmpty ? null : periodEnds[currentPeriod - 1];

  /// Minuten voorbij het einde van het lopende deel (blessuretijd).
  int stoppageAt(DateTime now) {
    final end = periodEnd;
    if (end == null) return 0;
    final over = minuteAt(now) - end;
    return over > 0 ? over : 0;
  }

  /// `38'` binnen het deel, `45+3'` erbuiten.
  String labelAt(DateTime now) {
    final stoppage = stoppageAt(now);
    final end = periodEnd;
    return stoppage > 0 && end != null
        ? "$end+$stoppage'"
        : "${minuteAt(now)}'";
  }

  /// Loopt er een strafschoppenserie die nog niet beslist is?
  bool get shootoutOpen => shootout != null && shootout!.winner == null;

  /// Het hoeveelste deel van de verlenging dit is (1, 2), of `null` in de
  /// reguliere speeltijd. [regular] is de terugval als de server
  /// `regular_periods` niet meestuurt.
  int? extraPeriod(int regular) {
    final base = regularPeriods > 0 ? regularPeriods : regular;
    if (!extraTime || period <= base) return null;
    return period - base;
  }

  /// `07:42`: minuten en seconden van de gelopen tijd.
  String mmssAt(DateTime now) {
    final secs = secondsAt(now);
    final mm = (secs ~/ 60).toString().padLeft(2, '0');
    final ss = (secs % 60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }
}

/// Eén schot in de strafschoppenserie. [player] alleen bij ons, en alleen
/// als de nemer is ingevuld.
@freezed
abstract class LiveShootoutKick with _$LiveShootoutKick {
  const factory LiveShootoutKick({
    @Default(false) bool scored,
    String? player,
  }) = _LiveShootoutKick;

  factory LiveShootoutKick.fromJson(Map<String, dynamic> json) =>
      _$LiveShootoutKickFromJson(json);
}

/// De strafschoppenserie (`event.live.shootout`, `lib/shootout.ts` in de
/// PWA): per kant de schoten op volgorde, `us`/`opp` (niet thuis/uit).
/// [winner] is `us` of `opp` zodra de serie beslist is.
@freezed
abstract class LiveShootout with _$LiveShootout {
  const factory LiveShootout({
    @Default(<LiveShootoutKick>[]) List<LiveShootoutKick> us,
    @Default(<LiveShootoutKick>[]) List<LiveShootoutKick> opp,
    String? winner,
  }) = _LiveShootout;

  const LiveShootout._();

  factory LiveShootout.fromJson(Map<String, dynamic> json) =>
      _$LiveShootoutFromJson(json);

  /// Eerst vijf per kant, daarna sudden death.
  static const int rounds = 5;

  /// Raak geschoten door ons.
  int get usScore => us.where((k) => k.scored).length;

  /// Raak geschoten door de tegenstander.
  int get oppScore => opp.where((k) => k.scored).length;

  bool get hasKicks => us.isNotEmpty || opp.isNotEmpty;

  /// Hoeveel bolletjes per rij: minstens vijf, daarna zoveel als er genomen
  /// zijn.
  int get slots => [rounds, us.length, opp.length].reduce(math.max);
}

/// Een setstand (`event.sets[]`) bij een set-scoremodel.
@freezed
abstract class LiveSet with _$LiveSet {
  const factory LiveSet({
    @Default(0) int setNumber,
    @Default(0) int homePoints,
    @Default(0) int awayPoints,
  }) = _LiveSet;

  factory LiveSet.fromJson(Map<String, dynamic> json) =>
      _$LiveSetFromJson(json);
}

/// De wedstrijd zelf (`event`).
@freezed
abstract class LiveEvent with _$LiveEvent {
  const factory LiveEvent({
    required int id,
    @Default('match') String type,
    @Default('') String title,
    DateTime? startsAt,
    String? homeTeam,
    String? awayTeam,
    int? homeScore,
    int? awayScore,
    @Default(true) bool weAreHome,
    @Default(<LiveSet>[]) List<LiveSet> sets,
    @Default(LiveClock()) LiveClock live,
    String? shareUrl,
  }) = _LiveEvent;

  factory LiveEvent.fromJson(Map<String, dynamic> json) =>
      _$LiveEventFromJson(json);
}

/// Hoe de delen van de sport heten (`rules.periods`): "Helft"/"Helften" bij
/// voetbal, "Kwart"/"Kwarten" bij hockey.
@freezed
abstract class LivePeriods with _$LivePeriods {
  const factory LivePeriods({
    @Default(1) int count,
    @Default('') String label,
    @Default('') String plural,
    int? minutes,
  }) = _LivePeriods;

  factory LivePeriods.fromJson(Map<String, dynamic> json) =>
      _$LivePeriodsFromJson(json);
}

/// Een kiesbare soort kaart of moment (`rules.card_types[]`,
/// `rules.moment_types[]`).
@freezed
abstract class LiveTypeOption with _$LiveTypeOption {
  const factory LiveTypeOption({
    required String type,
    @Default('') String label,
  }) = _LiveTypeOption;

  factory LiveTypeOption.fromJson(Map<String, dynamic> json) =>
      _$LiveTypeOptionFromJson(json);
}

/// De verlenging die de sport kent (`rules.extra_time`): `2 × 15` bij
/// voetbal.
@freezed
abstract class LiveExtraTime with _$LiveExtraTime {
  const factory LiveExtraTime({
    @Default(2) int count,
    @Default(15) int minutes,
  }) = _LiveExtraTime;

  factory LiveExtraTime.fromJson(Map<String, dynamic> json) =>
      _$LiveExtraTimeFromJson(json);
}

/// Wat de knoppenbalk mag aanbieden (`rules`).
@freezed
abstract class LiveRules with _$LiveRules {
  const factory LiveRules({
    @Default('goals') String scoreModel,
    @Default(false) bool tracksScorers,
    LivePeriods? periods,
    @Default(<LiveTypeOption>[]) List<LiveTypeOption> cardTypes,
    @Default(<LiveTypeOption>[]) List<LiveTypeOption> momentTypes,

    /// De verlenging bij een gelijke beker, of `null` (sport kent die niet).
    LiveExtraTime? extraTime,

    /// Beslist de sport een gelijke beker met strafschoppen?
    @Default(false) bool hasShootout,
  }) = _LiveRules;

  factory LiveRules.fromJson(Map<String, dynamic> json) =>
      _$LiveRulesFromJson(json);
}

/// Een doelpunt (`goals[]`): `goal`, `own_goal` of `opponent_goal`.
@freezed
abstract class LiveGoal with _$LiveGoal {
  const factory LiveGoal({
    required int id,
    required String itemKey,
    @Default(0) int minute,
    @Default('goal') String type,
    @Default(false) bool penalty,
    String? scorer,
    String? scorerAvatar,
    String? assist,
    @Default(0) int createdAt,
  }) = _LiveGoal;

  const LiveGoal._();

  factory LiveGoal.fromJson(Map<String, dynamic> json) =>
      _$LiveGoalFromJson(json);

  /// Telt voor ons team (geen eigen doelpunt of tegendoelpunt).
  bool get isOurs => type == 'goal';

  bool get isOwnGoal => type == 'own_goal';
}

/// Een wissel (`subs[]`).
@freezed
abstract class LiveSub with _$LiveSub {
  const factory LiveSub({
    required int id,
    required String itemKey,
    @Default(0) int minute,
    String? on,
    String? off,
    @Default(0) int createdAt,
  }) = _LiveSub;

  factory LiveSub.fromJson(Map<String, dynamic> json) =>
      _$LiveSubFromJson(json);
}

/// Een kaart (`cards[]`).
@freezed
abstract class LiveCard with _$LiveCard {
  const factory LiveCard({
    required int id,
    required String itemKey,
    @Default(0) int minute,
    @Default('') String type,
    String? player,
    @Default(0) int createdAt,
  }) = _LiveCard;

  factory LiveCard.fromJson(Map<String, dynamic> json) =>
      _$LiveCardFromJson(json);
}

/// Een moment zonder gevolgen voor de stand (`moments[]`).
@freezed
abstract class LiveMoment with _$LiveMoment {
  const factory LiveMoment({
    required int id,
    required String itemKey,
    @Default(0) int minute,
    @Default('') String type,
    @Default('') String label,

    /// `us` of `opp`; bij `opp` is [player] de naam van de tegenstander.
    @Default('us') String side,
    String? player,
    @Default(0) int createdAt,
  }) = _LiveMoment;

  const LiveMoment._();

  /// Van ons (anders van de tegenstander).
  bool get isOurs => side != 'opp';

  factory LiveMoment.fromJson(Map<String, dynamic> json) =>
      _$LiveMomentFromJson(json);
}

/// Eén emoji onder een gebeurtenis.
@freezed
abstract class LiveReaction with _$LiveReaction {
  const factory LiveReaction({
    required String emoji,
    @Default(0) int count,
    @Default(false) bool mine,
  }) = _LiveReaction;

  factory LiveReaction.fromJson(Map<String, dynamic> json) =>
      _$LiveReactionFromJson(json);
}

/// Een speler in de kiezers (`pickers.present[]` / `pickers.all_players[]`).
@freezed
abstract class LivePickerPlayer with _$LivePickerPlayer {
  const factory LivePickerPlayer({
    required int id,
    @Default('') String name,
    int? shirtNumber,
    @Default(false) bool onField,
  }) = _LivePickerPlayer;

  factory LivePickerPlayer.fromJson(Map<String, dynamic> json) =>
      _$LivePickerPlayerFromJson(json);
}

/// Spelerskeuze voor wie bijhoudt (`pickers`).
@freezed
abstract class LivePickers with _$LivePickers {
  const factory LivePickers({
    @Default(false) bool hasLineup,
    @Default(<LivePickerPlayer>[]) List<LivePickerPlayer> present,
    @Default(<LivePickerPlayer>[]) List<LivePickerPlayer> allPlayers,
  }) = _LivePickers;

  const LivePickers._();

  factory LivePickers.fromJson(Map<String, dynamic> json) =>
      _$LivePickersFromJson(json);

  /// De aanwezigen, of de hele selectie als niemand aanwezig is.
  List<LivePickerPlayer> get players => present.isEmpty ? allPlayers : present;

  /// Op het veld (alleen met een opstelling).
  List<LivePickerPlayer> get onField => hasLineup
      ? [
          for (final p in players)
            if (p.onField) p,
        ]
      : const [];

  /// Niet op het veld (alleen met een opstelling).
  List<LivePickerPlayer> get bench => hasLineup
      ? [
          for (final p in players)
            if (!p.onField) p,
        ]
      : players;
}

/// Leest `reactions`: altijd een object, maar een lege PHP-array komt als
/// `[]` binnen.
class LiveReactionsConverter
    implements JsonConverter<Map<String, List<LiveReaction>>, Object?> {
  const LiveReactionsConverter();

  @override
  Map<String, List<LiveReaction>> fromJson(Object? json) {
    if (json is! Map) return const {};
    return {
      for (final entry in json.entries)
        if (entry.value is List)
          '${entry.key}': [
            for (final r in entry.value as List)
              if (r is Map<String, dynamic>) LiveReaction.fromJson(r),
          ],
    };
  }

  @override
  Object? toJson(Map<String, List<LiveReaction>> object) => {
    for (final entry in object.entries)
      entry.key: [for (final r in entry.value) r.toJson()],
  };
}

/// De hele live-stand (`GET …/live` en het antwoord van elke schrijfactie).
@freezed
abstract class LiveMatch with _$LiveMatch {
  const factory LiveMatch({
    @Default('') String sport,
    required LiveEvent event,
    @Default(LiveRules()) LiveRules rules,
    @Default(<LiveGoal>[]) List<LiveGoal> goals,
    @Default(<LiveSub>[]) List<LiveSub> subs,
    @Default(<LiveCard>[]) List<LiveCard> cards,
    @Default(<LiveMoment>[]) List<LiveMoment> moments,
    @LiveReactionsConverter()
    @Default(<String, List<LiveReaction>>{})
    Map<String, List<LiveReaction>> reactions,
    @Default(false) bool canReact,
    @Default(<String>[]) List<String> reactionEmoji,
    @Default(0) int liveViewers,
    @Default(false) bool followingLive,
    @Default(false) bool canManage,
    LivePickers? pickers,
  }) = _LiveMatch;

  const LiveMatch._();

  factory LiveMatch.fromJson(Map<String, dynamic> json) =>
      _$LiveMatchFromJson(json);

  LiveClock get clock => event.live;

  /// Staat het gelijk op het bord (met een ingevulde stand)?
  bool get isTied =>
      event.homeScore != null && event.homeScore == event.awayScore;

  /// De naam van de tegenstander, of `null` als die er niet is.
  String? get opponentName => event.weAreHome ? event.awayTeam : event.homeTeam;

  /// Een gelijke beker beslissen kan nu: na de eindfluit, gelijk, de sport
  /// kent strafschoppen en er is nog geen serie (`Event::canBeDecided()`;
  /// [isCup] komt uit het event-detail, de live-stand kent de competitie
  /// niet).
  bool canDecide({required bool isCup}) =>
      isCup &&
      clock.isEnded &&
      isTied &&
      rules.hasShootout &&
      clock.shootout == null;

  /// Verlenging aanbieden: als [canDecide], de sport kent hem en hij is nog
  /// niet gespeeld.
  bool canStartExtraTime({required bool isCup}) =>
      canDecide(isCup: isCup) && rules.extraTime != null && !clock.extraTime;

  /// Staat er al iets in het verslag?
  bool get hasEntries =>
      goals.isNotEmpty ||
      subs.isNotEmpty ||
      cards.isNotEmpty ||
      moments.isNotEmpty;

  /// De minuten van alles wat vastgelegd is.
  List<int> get entryMinutes => [
    for (final g in goals) g.minute,
    for (final s in subs) s.minute,
    for (final c in cards) c.minute,
    for (final m in moments) m.minute,
  ];

  /// Het label van kaartsoort [type] uit `rules.card_types`.
  String cardLabel(String type) {
    for (final option in rules.cardTypes) {
      if (option.type == type && option.label.isNotEmpty) return option.label;
    }
    return type;
  }
}
