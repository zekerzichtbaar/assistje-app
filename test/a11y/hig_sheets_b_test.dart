// HIG-audit van de sheets en bevestigingsdialogen (groep B: boetes, spaarpot,
// berichten, spelersbeheer, profiel, seizoenen, instellingen, stats,
// teamlink, feedback, ranking). Zelfde controles als hig_audit_test.dart.
// Getagd `a11y`: de contrastmeting leest pixels en klopt alleen met de
// macOS-rasterisatie (op Linux meet hij randpixels van glyphs). CI draait
// deze suite daarom in de macOS-job `a11y`; zie README → "CI".
@Tags(['a11y'])
library;

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/feedback/feedback_fixtures.dart';
import '../features/fines/fines_fixtures.dart';
import '../features/hall_of_fame/hall_of_fame_fixtures.dart';
import '../features/messages/messages_fixtures.dart';
import '../features/player_management/pm_fixtures.dart';
import '../features/profile/profile_fixtures.dart';
import '../features/savings/savings_fixtures.dart';
import '../features/seasons/seasons_fixtures.dart';
import '../features/settings/settings_fixtures.dart';
import '../features/stats/stats_fixtures.dart';
import '../helpers/fake_http_adapter.dart';
import 'hig_harness.dart';

/// Tikt [keys] na elkaar aan. Ontbreekt een key, dan stopt het openen
/// zonder fout (een exception in `open` laat het harnas hangen omdat
/// `FlutterError.onError` dan niet hersteld wordt); de schermafbeelding laat
/// dan zien dat de sheet niet open is.
Future<void> Function(WidgetTester) _taps(List<String> keys) => (t) async {
  for (final key in keys) {
    final finder = find.byKey(ValueKey(key));
    // Lange lijsten bouwen lui: scroll de bovenste lijst tot de key er is.
    for (var i = 0; i < 30 && finder.evaluate().isEmpty; i++) {
      final lists = find.byWidgetPredicate(
        (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
      );
      if (lists.hitTestable().evaluate().isEmpty) break;
      await t.drag(lists.hitTestable().last, const Offset(0, -300));
      await pumpAuditFrames(t);
    }
    if (finder.evaluate().isEmpty) {
      debugPrint('HIG-audit: key "$key" niet gevonden');
      return;
    }
    await auditTap(t, finder);
  }
};

void _fines(FakeHttpAdapter h) => h
  ..on('GET /teams/3/fines', 200, FinesFixtures.treasurerOverview())
  ..on(
    'GET /teams/3/fines/players/17',
    200,
    FinesFixtures.player(canManage: true),
  );

final _sheets = <AuditScreen>[
  // Boetes (penningmeester).
  AuditScreen(
    '/fines',
    label: 'boete-geven',
    setup: _fines,
    open: _taps(['fines-give']),
  ),
  AuditScreen(
    '/fines',
    label: 'beheer',
    setup: _fines,
    open: _taps(['shell-actions']),
  ),
  AuditScreen(
    '/fines',
    label: 'boetetypes',
    // Meting pakt de rand van het bedragveld; de tekst (ink op wit) haalt > 9:1.
    contrastFalsePositives: ['2,50', '1,00'],
    setup: _fines,
    open: _taps(['shell-actions', 'fines-manage-types']),
  ),
  AuditScreen(
    '/fines',
    label: 'periode-hernoemen',
    setup: _fines,
    open: _taps(['shell-actions', 'fines-manage-rename']),
  ),
  AuditScreen(
    '/fines',
    label: 'boetetype-nieuw',
    setup: _fines,
    open: _taps(['shell-actions', 'fines-manage-types', 'fine-types-add']),
  ),
  AuditScreen(
    '/fines',
    label: 'pot-regel',
    setup: _fines,
    open: _taps(['fines-add-pot']),
  ),
  AuditScreen(
    '/fines',
    label: 'persoon',
    setup: _fines,
    open: _taps(['fines-row-p17']),
  ),
  AuditScreen(
    '/fines',
    label: 'boete-bewerken',
    setup: _fines,
    open: _taps(['fines-row-p17', 'fine-501']),
  ),
  AuditScreen(
    '/fines',
    label: 'periode-afsluiten-dialoog',
    setup: _fines,
    open: _taps(['fines-close-period']),
  ),
  // Spaarpot.
  AuditScreen(
    '/savings',
    label: 'afrekenen',
    setup: (h) => h
      ..on(
        'GET /teams/3/savings',
        200,
        SavingsFixtures.overview(pots: [SavingsFixtures.pot7()]),
      )
      ..on('GET /teams/3/savings/7', 200, SavingsFixtures.oneOffDetail()),
    open: _taps(['savings-pot-7', 'savings-settle-open']),
  ),
  AuditScreen(
    '/savings',
    label: 'herinneren-dialoog',
    setup: (h) => h
      ..on(
        'GET /teams/3/savings',
        200,
        SavingsFixtures.overview(pots: [SavingsFixtures.pot7()]),
      )
      ..on('GET /teams/3/savings/7', 200, SavingsFixtures.oneOffDetail()),
    open: _taps(['savings-pot-7', 'savings-remind']),
  ),
  // Berichten.
  AuditScreen(
    '/messages',
    label: 'opstellen',
    // Met toeschouwers, zodat de schakelaar "Ook naar toeschouwers" meedoet.
    setup: (h) => h.on(
      'GET /teams/3/messages',
      200,
      MessagesFixtures.overview(spectators: 3),
    ),
    open: _taps(['messages-compose']),
  ),
  AuditScreen(
    '/messages',
    label: 'sjabloon',
    setup: (h) =>
        h.on('GET /teams/3/messages', 200, MessagesFixtures.overview()),
    open: _taps(['messages-setting-birthday']),
  ),
  // Spelersbeheer.
  AuditScreen(
    '/players',
    label: 'toevoegen',
    setup: (h) => h.on('GET /teams/3/players', 200, PmFixtures.overview()),
    open: _taps(['shell-actions', 'pm-add']),
  ),
  AuditScreen(
    '/players',
    label: 'beheren',
    setup: (h) => h.on('GET /teams/3/players', 200, PmFixtures.overview()),
    open: _taps(['pm-player-12']),
  ),
  AuditScreen(
    '/players',
    label: 'bewerken',
    // Meting pakt de rand van het datumveld; de tekst (inkSoft op wit) haalt > 9:1.
    contrastFalsePositives: ['Geboortedatum'],
    setup: (h) => h.on('GET /teams/3/players', 200, PmFixtures.overview()),
    open: _taps(['pm-player-12', 'pm-manage-edit']),
  ),
  // Profiel.
  AuditScreen(
    '/profile',
    trainer: false,
    label: 'foto',
    setup: (h) => h.on('GET /teams/3/profile', 200, ProfileFixtures.profile()),
    open: _taps(['profile-avatar-new']),
  ),
  AuditScreen(
    '/profile',
    trainer: false,
    label: 'speler-aanmaken',
    setup: (h) => h.on(
      'GET /teams/3/profile',
      200,
      ProfileFixtures.profile(withPlayer: false),
    ),
    open: _taps(['profile-player-activate']),
  ),
  AuditScreen(
    '/profile',
    trainer: false,
    label: 'account-verwijderen',
    // De dagpil is voor de meting onder de vervaging bovenin gescrold; in rust staat hij vrij.
    contrastFalsePositives: ['do'],
    setup: (h) => h.on('GET /teams/3/profile', 200, ProfileFixtures.profile()),
    open: _taps(['profile-delete-open']),
  ),
  // Seizoenen.
  AuditScreen(
    '/seasons',
    label: 'seizoen',
    setup: (h) => h.on('GET /teams/3/seasons', 200, SeasonsFixtures.response()),
    open: _taps(['seasons-edit']),
  ),
  AuditScreen(
    '/seasons',
    label: 'periode',
    setup: (h) => h.on(
      'GET /teams/3/seasons',
      200,
      SeasonsFixtures.response(SeasonsFixtures.data(mode: 'dates')),
    ),
    open: _taps(['seasons-period-add']),
  ),
  AuditScreen(
    '/seasons',
    label: 'afsluiten-dialoog',
    setup: (h) => h.on('GET /teams/3/seasons', 200, SeasonsFixtures.response()),
    open: _taps(['seasons-close']),
  ),
  // Instellingen.
  AuditScreen(
    '/settings',
    label: 'dienst',
    setup: (h) =>
        h.on('GET /teams/3/settings', 200, SettingsFixtures.response()),
    open: (t) async {
      final picker = find.byKey(const ValueKey('settings-tabs'));
      if (picker.evaluate().isEmpty) return;
      await auditTap(t, picker);
      await auditTap(
        t,
        find.byKey(const ValueKey('settings-tab-option-types')),
      );
      await _taps(['shell-actions', 'settings-duty-add'])(t);
    },
  ),
  AuditScreen(
    '/settings',
    label: 'dienst bij wedstrijd',
    // Bestaand type met scope `match`: ook "Alleen uitwedstrijden" en de beurt.
    setup: (h) =>
        h.on('GET /teams/3/settings', 200, SettingsFixtures.response()),
    open: (t) async {
      final picker = find.byKey(const ValueKey('settings-tabs'));
      if (picker.evaluate().isEmpty) return;
      await auditTap(t, picker);
      await auditTap(
        t,
        find.byKey(const ValueKey('settings-tab-option-types')),
      );
      await _taps(['settings-duty-12'])(t);
    },
  ),
  // Stats en ranking.
  AuditScreen(
    '/stats',
    label: 'seizoen',
    setup: (h) => h.on('GET /teams/3/stats', 200, StatsFixtures.response()),
    open: _taps(['stats-season-picker']),
  ),
  AuditScreen(
    '/hall-of-fame',
    label: 'seizoen',
    setup: (h) => h.on('GET /teams/3/hall-of-fame', 200, {
      'data': HallOfFameFixtures.rich(),
    }),
    open: _taps(['hof-season-picker']),
  ),
  // Teamlink.
  AuditScreen(
    '/teamlink',
    label: 'qr',
    setup: (h) => h.on('GET /teams/3/teamlink', 200, PmFixtures.teamLink()),
    open: _taps(['tl-show-qr']),
  ),
  // Feedback.
  AuditScreen(
    '/feedback',
    label: 'nieuw',
    setup: (h) => h.on('GET /teams/3/feedback', 200, FeedbackFixtures.list()),
    open: _taps(['feedback-create']),
  ),
];

void main() => registerAudit(_sheets);
