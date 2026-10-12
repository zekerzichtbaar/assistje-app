import 'live_models.dart';

/// Soort regel in de tijdlijn.
enum LiveFeedKind { goal, sub, card, moment }

/// Eén regel in de tijdlijn: een doelpunt, wissel, kaart of moment, met de
/// kant waar hij hoort (wie het punt krijgt) en de doorlopende stand.
class LiveFeedItem {
  const LiveFeedItem({
    required this.kind,
    required this.id,
    required this.itemKey,
    required this.minute,
    required this.createdAt,
    required this.ours,
    this.goal,
    this.sub,
    this.card,
    this.moment,
    this.score,
  });

  final LiveFeedKind kind;
  final int id;
  final String itemKey;
  final int minute;
  final int createdAt;

  /// Hoort bij ons team (anders bij de tegenstander: tegendoelpunt of eigen
  /// doelpunt).
  final bool ours;

  final LiveGoal? goal;
  final LiveSub? sub;
  final LiveCard? card;
  final LiveMoment? moment;

  /// Stand na dit doelpunt (`2 - 1`), alleen als het verloop compleet is.
  final String? score;
}

/// De tijdlijn van [match], nieuwste bovenaan (zoals de PWA).
///
/// De doorlopende stand staat alleen bij de doelpunten als de som van de
/// gelogde doelpunten de stand op het bord is; een incompleet verloop zou
/// anders een misleidende tussenstand tonen.
List<LiveFeedItem> buildLiveFeed(LiveMatch match) {
  final weAreHome = match.event.weAreHome;
  final ascending = [...match.goals]
    ..sort((a, b) {
      final byMinute = a.minute.compareTo(b.minute);
      return byMinute != 0 ? byMinute : a.id.compareTo(b.id);
    });
  final scores = <int, String>{};
  var home = 0;
  var away = 0;
  for (final goal in ascending) {
    final homeScored = goal.isOurs ? weAreHome : !weAreHome;
    if (homeScored) {
      home++;
    } else {
      away++;
    }
    scores[goal.id] = '$home - $away';
  }
  final complete =
      home == (match.event.homeScore ?? 0) &&
      away == (match.event.awayScore ?? 0);
  if (!complete) scores.clear();

  final items = <LiveFeedItem>[
    for (final g in match.goals)
      LiveFeedItem(
        kind: LiveFeedKind.goal,
        id: g.id,
        itemKey: g.itemKey,
        minute: g.minute,
        createdAt: g.createdAt,
        ours: g.isOurs,
        goal: g,
        score: scores[g.id],
      ),
    for (final s in match.subs)
      LiveFeedItem(
        kind: LiveFeedKind.sub,
        id: s.id,
        itemKey: s.itemKey,
        minute: s.minute,
        createdAt: s.createdAt,
        ours: true,
        sub: s,
      ),
    for (final c in match.cards)
      LiveFeedItem(
        kind: LiveFeedKind.card,
        id: c.id,
        itemKey: c.itemKey,
        minute: c.minute,
        createdAt: c.createdAt,
        ours: true,
        card: c,
      ),
    for (final m in match.moments)
      LiveFeedItem(
        kind: LiveFeedKind.moment,
        id: m.id,
        itemKey: m.itemKey,
        minute: m.minute,
        createdAt: m.createdAt,
        ours: true,
        moment: m,
      ),
  ];
  items.sort((a, b) {
    final byMinute = b.minute.compareTo(a.minute);
    return byMinute != 0 ? byMinute : b.createdAt.compareTo(a.createdAt);
  });
  return items;
}

/// Verwerkt één tik op emoji [emoji] onder [itemKey] alvast in [reactions]
/// (`applyToggle` uit `LiveReactions.tsx`): één reactie per persoon per
/// gebeurtenis. Je eigen stem gaat er overal af en komt er alleen weer op
/// bij een ándere emoji. [order] is de serverrij (`reaction_emoji`).
Map<String, List<LiveReaction>> applyReactionToggle(
  Map<String, List<LiveReaction>> reactions,
  String itemKey,
  String emoji,
  List<String> order,
) {
  final list = reactions[itemKey] ?? const <LiveReaction>[];
  final wasMine = list.any((r) => r.emoji == emoji && r.mine);
  var next = [
    for (final r in list)
      if (r.mine) r.copyWith(count: r.count - 1, mine: false) else r,
  ].where((r) => r.count > 0).toList();
  if (!wasMine) {
    next = next.any((r) => r.emoji == emoji)
        ? [
            for (final r in next)
              r.emoji == emoji ? r.copyWith(count: r.count + 1, mine: true) : r,
          ]
        : [...next, LiveReaction(emoji: emoji, count: 1, mine: true)];
  }
  int rank(String e) {
    final i = order.indexOf(e);
    return i < 0 ? order.length : i;
  }

  next.sort((a, b) => rank(a.emoji).compareTo(rank(b.emoji)));
  final result = {...reactions};
  if (next.isEmpty) {
    result.remove(itemKey);
  } else {
    result[itemKey] = next;
  }
  return result;
}
