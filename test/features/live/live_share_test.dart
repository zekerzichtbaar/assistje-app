import 'package:assistje/features/live/application/live_share.dart';
import 'package:assistje/features/live/data/models/live_models.dart';
import 'package:assistje/l10n/generated/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final l10n = lookupAppLocalizations(const Locale('nl'));
  const url = 'https://test-team.assistje.nl/live/Xk3';
  final live = LiveClock(isLive: true, startedAt: DateTime(2026, 10, 11));
  final ended = LiveClock(
    isLive: true,
    startedAt: DateTime(2026, 10, 11),
    endedAt: DateTime(2026, 10, 11, 16),
  );

  LiveEvent event({
    LiveClock clock = const LiveClock(),
    String? shareUrl = url,
    String? home = 'Vogels 3',
    String? away = 'De Buren',
    int? homeScore = 2,
    int? awayScore = 1,
  }) => LiveEvent(
    id: 412,
    homeTeam: home,
    awayTeam: away,
    homeScore: homeScore,
    awayScore: awayScore,
    live: clock,
    shareUrl: shareUrl,
  );

  group('canShareLive', () {
    test('alleen met link en als hij loopt of afgelopen is', () {
      expect(canShareLive(event(clock: live)), isTrue);
      expect(canShareLive(event(clock: ended)), isTrue);
      expect(canShareLive(event()), isFalse, reason: 'nog niet begonnen');
      expect(canShareLive(event(clock: live, shareUrl: null)), isFalse);
    });
  });

  group('liveShareMessage', () {
    test('live: uitnodiging om mee te kijken', () {
      expect(
        liveShareMessage(l10n, event(clock: live), teamName: 'Vogels 3'),
        'Volg Vogels 3 - De Buren live!\n\n'
        'Bekijk de stand en het verloop realtime (geen app nodig):\n$url',
      );
    });

    test('afgelopen: de uitslag', () {
      expect(
        liveShareMessage(l10n, event(clock: ended), teamName: 'Vogels 3'),
        'Vogels 3 - De Buren\n2 - 1\n\n'
        'Bekijk het wedstrijdverslag (geen app nodig):\n$url',
      );
    });

    test('afgelopen zonder stand: 0 - 0', () {
      expect(
        liveShareMessage(
          l10n,
          event(clock: ended, homeScore: null, awayScore: null),
          teamName: 'Vogels 3',
        ),
        startsWith('Vogels 3 - De Buren\n0 - 0\n'),
      );
    });

    test('zonder teams: de teamnaam', () {
      expect(
        liveShareMessage(
          l10n,
          event(clock: live, home: null, away: null),
          teamName: 'Zwaluwen VR1',
        ),
        startsWith('Volg Zwaluwen VR1 live!'),
      );
      expect(
        liveShareMessage(
          l10n,
          event(clock: live, home: '', away: ''),
          teamName: 'Zwaluwen VR1',
        ),
        startsWith('Volg Zwaluwen VR1 live!'),
      );
    });

    test('één team bekend: getrimd zoals de PWA', () {
      expect(
        liveShareMessage(l10n, event(clock: live, away: null), teamName: 'X'),
        startsWith('Volg Vogels 3 - live!'),
      );
    });

    test('sportneutraal: geen emoji vooraan', () {
      final message = liveShareMessage(
        l10n,
        event(clock: live),
        teamName: 'X',
      )!;
      expect(message.startsWith('Volg'), isTrue);
    });

    test('niets te delen: null', () {
      expect(liveShareMessage(l10n, event(), teamName: 'X'), isNull);
      expect(
        liveShareMessage(
          l10n,
          event(clock: ended, shareUrl: null),
          teamName: 'X',
        ),
        isNull,
      );
    });
  });
}
