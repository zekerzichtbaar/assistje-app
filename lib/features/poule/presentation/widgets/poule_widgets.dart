import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/api/api_exception.dart';
import '../../../../core/theme/assistje_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../data/models/poule_models.dart';

/// De tekst bij een mislukte aanroep: Laravels `message` als die er is,
/// anders een algemene melding.
String pouleErrorText(AppLocalizations l10n, Object? error) => switch (error) {
  NetworkException() => l10n.errorNetwork,
  final ApiException e when e.message != null => e.message!,
  _ => l10n.errorGeneric,
};

/// `zaterdag 17 oktober` voor een kale datum, of "Datum onbekend".
String pouleDayLabel(AppLocalizations l10n, String? date) {
  final parsed = date == null ? null : DateTime.tryParse(date);
  if (parsed == null) return l10n.pouleDateUnknown;
  return DateFormat('EEEE d MMMM', 'nl').format(parsed);
}

/// `10 okt, 14:05` (lokale tijd).
String pouleUpdatedLabel(DateTime fetchedAt) =>
    DateFormat('d MMM, HH:mm', 'nl').format(fetchedAt.toLocal());

/// Een clublogo (rond, met initialen als het logo ontbreekt of faalt).
class PouleLogo extends StatelessWidget {
  const PouleLogo({super.key, required this.team, this.url, this.size = 24});

  final String team;
  final String? url;
  final double size;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: AppAvatar(name: team, imageUrl: url, size: size),
  );
}

/// De stand als tabel: positie, logo + ploeg, gespeeld, doelsaldo, punten.
/// Onze ploeg licht op in de teamkleur.
class PouleStandingTable extends StatelessWidget {
  const PouleStandingTable({super.key, required this.standing});

  final List<PouleStanding> standing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final headStyle = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.4,
      color: t.muted,
    );

    return AppCard(
      key: const ValueKey('poule-standing'),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ExcludeSemantics(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
              child: Row(
                children: [
                  SizedBox(width: 28, child: Text('#', style: headStyle)),
                  Expanded(
                    child: Text(
                      l10n.pouleColTeam.toUpperCase(),
                      style: headStyle,
                    ),
                  ),
                  _Num(l10n.pouleColPlayed, style: headStyle),
                  _Num(l10n.pouleColGoalDiff, style: headStyle, width: 40),
                  _Num(l10n.pouleColPoints, style: headStyle),
                ],
              ),
            ),
          ),
          for (final row in standing) _StandingRow(row: row),
        ],
      ),
    );
  }
}

class _StandingRow extends StatelessWidget {
  const _StandingRow({required this.row});

  final PouleStanding row;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    final own = row.isOwn;
    final style = TextStyle(
      fontSize: 14,
      fontWeight: own ? FontWeight.w700 : FontWeight.w400,
      color: own ? t.primary : t.ink,
    );
    final diff = row.goalDiff > 0 ? '+${row.goalDiff}' : '${row.goalDiff}';

    return Semantics(
      label: l10n.pouleStandingRow(
        row.position,
        row.team,
        row.points,
        row.played,
      ),
      excludeSemantics: true,
      child: Container(
        key: ValueKey('poule-standing-${row.position}'),
        color: own ? t.primary.withValues(alpha: 0.08) : null,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            SizedBox(width: 28, child: Text('${row.position}', style: style)),
            PouleLogo(team: row.team, url: row.logo),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                row.team,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style,
              ),
            ),
            _Num('${row.played}', style: style.copyWith(color: t.inkSoft)),
            _Num(diff, style: style.copyWith(color: t.inkSoft), width: 40),
            _Num(
              '${row.points}',
              style: style.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class _Num extends StatelessWidget {
  const _Num(this.text, {required this.style, this.width = 32});

  final String text;
  final TextStyle style;
  final double width;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    child: Text(text, textAlign: TextAlign.end, style: style),
  );
}

/// Eén speeldag: kop met de datum en een kaart met de wedstrijden.
class PouleMatchDayCard extends StatelessWidget {
  const PouleMatchDayCard({
    super.key,
    required this.day,
    required this.keyPrefix,
    required this.result,
    required this.onOpenEvent,
  });

  final PouleMatchDay day;

  /// Uitslagen (score of status) of programma (aanvangstijd).
  final bool result;

  /// `poule-result-<n>` of `poule-fixture-<n>`; wedstrijden krijgen
  /// `<keyPrefix>-<index>`.
  final String keyPrefix;
  final ValueChanged<int> onOpenEvent;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final t = AssistjeTokens.of(context);
    return Column(
      key: ValueKey(keyPrefix),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
          child: Semantics(
            header: true,
            child: Text(
              pouleDayLabel(l10n, day.date).toUpperCase(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: t.muted,
              ),
            ),
          ),
        ),
        AppCard(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            children: [
              for (final (index, match) in day.matches.indexed) ...[
                if (index > 0) Divider(height: 1, color: t.lineSoft),
                _MatchRow(
                  key: ValueKey('$keyPrefix-$index'),
                  match: match,
                  result: result,
                  onOpenEvent: onOpenEvent,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MatchRow extends StatelessWidget {
  const _MatchRow({
    super.key,
    required this.match,
    required this.result,
    required this.onOpenEvent,
  });

  final PouleMatch match;

  /// Een uitslag (anders: programma).
  final bool result;
  final ValueChanged<int> onOpenEvent;

  @override
  Widget build(BuildContext context) {
    final t = AssistjeTokens.of(context);
    TextStyle side({required bool own}) => TextStyle(
      fontSize: 14,
      fontWeight: own ? FontWeight.w700 : FontWeight.w400,
      color: own ? t.primary : t.ink,
    );

    final score = match.score;
    final played = score != null && score.isNotEmpty;
    // Uitslagen: de score, of de status (Gestaakt, Afgelast). Programma: de
    // aanvangstijd, met een afwijkende status eronder.
    final middle = played
        ? score.replaceAll('-', ' – ')
        : (result ? match.status : match.time) ??
              match.time ??
              match.status ??
              '–';
    final note = !played && !result && match.time != null ? match.status : null;
    final eventId = match.eventId;

    final row = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        match.home,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
                        style: side(own: match.homeIsOwn),
                      ),
                    ),
                    const SizedBox(width: 8),
                    PouleLogo(team: match.home, url: match.homeLogo),
                  ],
                ),
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 64),
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: played ? t.raised : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  middle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: played ? 15 : 13,
                    fontWeight: played ? FontWeight.w700 : FontWeight.w500,
                    color: played ? t.ink : t.inkSoft,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    PouleLogo(team: match.away, url: match.awayLogo),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        match.away,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: side(own: match.awayIsOwn),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (note != null && note.isNotEmpty && note != 'Gepland')
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(note, style: TextStyle(fontSize: 12, color: t.muted)),
            ),
        ],
      ),
    );

    if (eventId == null) return row;
    return InkWell(
      onTap: () => onOpenEvent(eventId),
      borderRadius: BorderRadius.circular(AssistjeTokens.radius2xl),
      child: row,
    );
  }
}
