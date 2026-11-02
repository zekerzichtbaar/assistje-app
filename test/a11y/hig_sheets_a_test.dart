// HIG-audit van de sheets en dialogen (groep A: agenda, aanwezigheid, event,
// opstelling, live, verslag, diensten, programma, trainingsteams, vakanties,
// afspraken). Zelfde controles als hig_audit_test.dart, met de sheet open.
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/agreements/agreements_fixtures.dart';
import '../features/attendance/attendance_fixtures.dart';
import '../features/duties/duties_fixtures.dart';
import '../features/event/event_fixtures.dart';
import '../features/lineup/lineup_fixtures.dart';
import '../features/live/live_fixtures.dart';
import '../features/profile/profile_fixtures.dart';
import '../features/report/report_fixtures.dart';
import '../features/schedule/schedule_import_fixtures.dart';
import '../features/training_teams/training_teams_fixtures.dart';
import '../helpers/api_fixtures.dart';
import '../helpers/fake_http_adapter.dart';
import 'hig_harness.dart';

const _future = '2099-10-11T14:30:00+02:00';

Finder _key(String key) => find.byKey(ValueKey(key));

/// Tikt achter elkaar op [keys]; scrolt zo nodig eerst naar het element.
///
/// Gooit niet: een fout in `open` zou het harnas laten hangen. Een ontbrekend
/// element wordt gelogd (en is zichtbaar op de schermafbeelding).
Future<void> Function(WidgetTester) _taps(List<String> keys) =>
    (t) => _tapAll(t, [for (final k in keys) _key(k)]);

Future<void> _tapAll(WidgetTester t, List<Finder> finders) async {
  for (final finder in finders) {
    try {
      if (finder.evaluate().isEmpty) {
        await t.scrollUntilVisible(
          finder,
          200,
          scrollable: find.byType(Scrollable).hitTestable().first,
          maxScrolls: 30,
        );
      }
      // Midden in beeld, zodat de tik niet onder de tabbalk valt.
      await Scrollable.ensureVisible(t.element(finder.first), alignment: 0.5);
      await t.pump(const Duration(milliseconds: 300));
      await auditTap(t, finder);
    } on Object catch (e) {
      // ignore: avoid_print
      print('AUDIT-OPEN-MISLUKT: $finder: $e');
      return;
    }
  }
}

/// Vervangt het lidmaatschap uit het harnas door [membership].
void _me(FakeHttpAdapter h, Map<String, dynamic> membership) =>
    h.on('GET /me', 200, ApiFixtures.meResponse(teams: [membership]));

/// Een speler in een team met reden-bij-afmelden en carpool aan.
Map<String, dynamic> _player() => ApiFixtures.membership(
  features: {...auditFeatures, 'absence_reason': true, 'carpool': true},
);

Map<String, dynamic> _person(
  String key,
  String name, [
  String kind = 'player',
]) => {'key': key, 'name': name, 'kind': kind};

/// Een event waarin de trainer een dienst kan toewijzen.
Map<String, dynamic> _dutyDetail() => EventFixtures.eventDetail({
  'starts_at': _future,
  'is_trainer': true,
  'duties': [
    {
      'duty_type_id': 3,
      'name': 'Kantine',
      'icon': 'Coffee',
      'mode': 'individual',
      'assignment_id': null,
      'member_key': null,
      'member_keys': <String>[],
      'assignee_absent': false,
      'duty_group_id': null,
      'label': null,
      'member_names': <String>[],
      'notes': null,
      'done': false,
      'mine': false,
      'options': [
        _person('p_17', 'Sam de Vries'),
        _person('u_4', 'Coach Ronald', 'staff'),
      ],
    },
  ],
});

Map<String, dynamic> _liveMember() => LiveFixtures.membership(manager: true);

Map<String, dynamic> _ended() => LiveFixtures.clock(
  isLive: false,
  seconds: 269 * 60,
  endedAt: '2026-10-11T19:00:00+02:00',
  period: 2,
);

/// Een gelijke (1-1) bekerwedstrijd in de live-stand met klok [live].
Map<String, dynamic> _cupLive(
  Map<String, dynamic> live, {
  bool manager = true,
}) => LiveFixtures.response(
  canManage: manager,
  rules: LiveFixtures.cupRules(),
  awayScore: 1,
  live: live,
);

/// Het event-detail van die wedstrijd: een beker.
Map<String, dynamic> _cupDetail() =>
    EventFixtures.eventDetail({'competition': 'cup'});

/// Antwoordt per `?type=`: `wassen` → groepen, anders het individuele type.
FakeResponse _dutiesByType(RecordedRequest r) => FakeResponse(
  200,
  r.options.uri.queryParameters['type'] == 'wassen'
      ? DutiesFixtures.groups()
      : DutiesFixtures.individual(),
);

void _report(
  FakeHttpAdapter h, {
  Map<String, dynamic>? data,
  Map<String, dynamic>? flag,
}) {
  _me(h, ReportFixtures.membership());
  h
    ..on(
      ReportFixtures.get,
      200,
      ReportFixtures.wrap(data ?? ReportFixtures.setsData()),
    )
    ..on(ReportFixtures.eventGet, 200, ReportFixtures.eventDetail(flag: flag));
}

final _sheets = <AuditScreen>[
  // ── Agenda ──────────────────────────────────────────────────────────────
  // De redensheet zelf staat onder Event (zelfde sheet).
  AuditScreen(
    '/agenda',
    trainer: false,
    label: 'agendafeed',
    setup: (h) =>
        h.on('GET /teams/3/agenda', 200, ApiFixtures.agendaResponse()),
    open: _taps(['agenda-calendar']),
  ),
  AuditScreen(
    '/agenda',
    label: 'programma-import',
    setup: (h) {
      _me(h, importTrainer());
      h
        ..on('GET /teams/3/agenda', 200, importAgenda())
        ..on('GET /teams/3/schedule/options', 200, {
          'data': {'team_name': 'Vogels 3'},
        });
    },
    open: _taps(['agenda-schedule-import']),
  ),
  // ── Aanwezigheid ────────────────────────────────────────────────────────
  AuditScreen(
    '/events/412/attendance',
    label: 'status',
    setup: (h) => h
      ..on('GET /teams/3/events/412', 200, EventFixtures.eventDetail())
      ..on(
        'GET /teams/3/events/412/attendance',
        200,
        AttendanceFixtures.attendance(),
      ),
    open: _taps(['attendance-row-player-37']),
  ),
  AuditScreen(
    '/events/412/attendance',
    label: 'gast',
    setup: (h) => h
      ..on('GET /teams/3/events/412', 200, EventFixtures.eventDetail())
      ..on(
        'GET /teams/3/events/412/attendance',
        200,
        AttendanceFixtures.attendance(),
      )
      ..on(
        'GET /teams/3/events/412/guests/options',
        200,
        AttendanceFixtures.options(),
      ),
    open: _taps(['attendance-add-guest']),
  ),
  // ── Event ───────────────────────────────────────────────────────────────
  AuditScreen(
    '/events/412',
    trainer: false,
    label: 'reden',
    setup: (h) {
      _me(h, _player());
      h.on(
        'GET /teams/3/events/412',
        200,
        EventFixtures.withMe({'starts_at': _future, 'my_status': 'present'}),
      );
    },
    open: _taps(['event-rsvp-absent']),
  ),
  AuditScreen(
    '/events/412',
    trainer: false,
    label: 'carpool',
    setup: (h) {
      _me(h, _player());
      h.on(
        'GET /teams/3/events/412',
        200,
        EventFixtures.eventDetail({'starts_at': _future}),
      );
    },
    open: _taps(['carpool-open']),
  ),
  AuditScreen(
    '/events/412',
    label: 'dienst',
    setup: (h) => h.on('GET /teams/3/events/412', 200, _dutyDetail()),
    open: _taps(['event-duty-3']),
  ),
  AuditScreen(
    '/events/412',
    label: 'verwijderen-dialoog',
    setup: (h) => h.on(
      'GET /teams/3/events/412',
      200,
      EventFixtures.eventDetail({'starts_at': _future, 'is_trainer': true}),
    ),
    open: _taps(['event-trainer-delete']),
  ),
  // ── Opstelling ──────────────────────────────────────────────────────────
  AuditScreen(
    '/events/412/lineup',
    label: 'delen',
    setup: (h) => h
      ..on('GET /teams/3/events/412', 200, EventFixtures.eventDetail())
      ..on(LineupFixtures.get, 200, LineupFixtures.response()),
    open: _taps(['lineup-share']),
  ),
  // ── Live ────────────────────────────────────────────────────────────────
  // Het beheerdersscherm zelf (knoppen voor de klok en gebeurtenissen).
  AuditScreen(
    '/events/412/live',
    label: 'beheer',
    setup: (h) {
      _me(h, _liveMember());
      h.on(LiveFixtures.get, 200, LiveFixtures.response(canManage: true));
    },
  ),
  AuditScreen(
    '/events/412/live',
    label: 'beheer-afgelopen',
    // Chip staat voor de meting achter de glazen tabbalk; in rust ink op een licht vlak.
    contrastFalsePositives: ['🔥 4'],
    setup: (h) {
      _me(h, _liveMember());
      h.on(
        LiveFixtures.get,
        200,
        LiveFixtures.response(canManage: true, live: _ended()),
      );
    },
  ),
  AuditScreen(
    '/events/412/live',
    label: 'reageren',
    setup: (h) {
      _me(h, _liveMember());
      h.on(LiveFixtures.get, 200, LiveFixtures.response(canManage: true));
    },
    open: _taps(['live-react-c1840']),
  ),
  AuditScreen(
    '/events/412/live',
    label: 'toevoegen',
    setup: (h) {
      _me(h, _liveMember());
      h.on(LiveFixtures.get, 200, LiveFixtures.response(canManage: true));
    },
    open: _taps(['live-add']),
  ),
  AuditScreen(
    '/events/412/live',
    label: 'speler-kiezen',
    setup: (h) {
      _me(h, _liveMember());
      h.on(LiveFixtures.get, 200, LiveFixtures.response(canManage: true));
    },
    open: _taps(['live-add', 'live-pick-scorer']),
  ),
  AuditScreen(
    '/events/412/live',
    label: 'speelduur',
    setup: (h) {
      _me(h, _liveMember());
      h.on(
        LiveFixtures.get,
        200,
        LiveFixtures.response(canManage: true, live: _ended()),
      );
    },
    open: _taps(['live-duration']),
  ),
  AuditScreen(
    '/events/412/live',
    label: 'bevestigen',
    setup: (h) {
      _me(h, _liveMember());
      h.on(
        LiveFixtures.get,
        200,
        LiveFixtures.response(canManage: true, live: _ended()),
      );
    },
    open: _taps(['live-reset']),
  ),
  // Beker beslissen: verlenging en strafschoppen.
  AuditScreen(
    '/events/412/live',
    label: 'beker-beslissen',
    setup: (h) {
      _me(h, _liveMember());
      h
        ..on(LiveFixtures.get, 200, _cupLive(LiveFixtures.ended()))
        ..on('GET ${LiveFixtures.event}', 200, _cupDetail());
    },
  ),
  AuditScreen(
    '/events/412/live',
    label: 'verlenging',
    setup: (h) {
      _me(h, _liveMember());
      h.on(
        LiveFixtures.get,
        200,
        _cupLive(
          LiveFixtures.clock(
            seconds: 90 * 60,
            period: 2,
            periodEnds: const [45, 90, 105, 120],
            extraTime: true,
          ),
        ),
      );
    },
  ),
  AuditScreen(
    '/events/412/live',
    label: 'klok-gelijkzetten',
    setup: (h) {
      _me(h, _liveMember());
      h.on(LiveFixtures.get, 200, LiveFixtures.response(canManage: true));
    },
    open: _taps(['live-clock-set']),
  ),
  AuditScreen(
    '/events/412/live',
    label: 'strafschoppen',
    contrastFalsePositives: ['🔥 4'],
    setup: (h) {
      _me(h, _liveMember());
      h.on(
        LiveFixtures.get,
        200,
        _cupLive(
          LiveFixtures.ended(
            shootout: LiveFixtures.shootout(
              us: [true, false, true],
              opp: [true, true],
            ),
          ),
        ),
      );
    },
  ),
  AuditScreen(
    '/events/412/live',
    label: 'nemer-kiezen',
    setup: (h) {
      _me(h, _liveMember());
      h.on(
        LiveFixtures.get,
        200,
        _cupLive(
          LiveFixtures.ended(shootout: LiveFixtures.shootout(us: [true])),
        ),
      );
    },
    open: _taps(['live-shooter']),
  ),
  AuditScreen(
    '/events/412/live',
    label: 'strafschoppen-kijker',
    contrastFalsePositives: ['🔥 4'],
    setup: (h) {
      _me(h, LiveFixtures.membership());
      h.on(
        LiveFixtures.get,
        200,
        _cupLive(
          LiveFixtures.ended(
            resultSuffix: '4–3 n.s.',
            shootout: LiveFixtures.shootout(
              us: [true, true, true, true],
              opp: [true, true, false, true, false],
              winner: 'us',
            ),
          ),
          manager: false,
        ),
      );
    },
  ),
  AuditScreen(
    '/events/412/live',
    label: 'moment-tegenstander',
    setup: (h) {
      _me(h, _liveMember());
      h.on(
        LiveFixtures.get,
        200,
        // Zonder kaarten staat "Overige" meteen op een moment, met de
        // kantkeuze in beeld (geen scroll die de pillen half wegschuift).
        LiveFixtures.response(
          canManage: true,
          rules: {...LiveFixtures.cupRules(), 'card_types': <Object>[]},
        ),
      );
    },
    open: (t) => _tapAll(t, [_key('live-add'), find.text('Overige')]),
  ),
  // ── Verslag ─────────────────────────────────────────────────────────────
  AuditScreen(
    '/events/412/report',
    label: 'score',
    setup: (h) => _report(h, data: ReportFixtures.goalsData()),
    open: _taps(['report-edit-score']),
  ),
  AuditScreen(
    '/events/412/report',
    label: 'spelerstats',
    setup: _report,
    open: _taps(['report-stats-card']),
  ),
  AuditScreen(
    '/events/412/report',
    label: 'scout-import',
    setup: _report,
    open: _taps(['report-import']),
  ),
  AuditScreen(
    '/events/412/report',
    label: 'vlaggen',
    setup: (h) => _report(
      h,
      data: ReportFixtures.goalsData(),
      flag: ReportFixtures.flag(),
    ),
    open: _taps(['report-edit-flag']),
  ),
  // ── Diensten ────────────────────────────────────────────────────────────
  AuditScreen(
    '/duties',
    label: 'plannen',
    setup: (h) => h.routes['GET /teams/3/duties'] = _dutiesByType,
    open: _taps(['duties-plan']),
  ),
  // "Eén of meer personen": aanvinken wie er staat.
  AuditScreen(
    '/duties',
    label: 'plannen-een-of-meer',
    setup: (h) => h.on('GET /teams/3/duties', 200, DutiesFixtures.multi()),
    open: _taps(['duties-plan']),
  ),
  AuditScreen(
    '/duties',
    label: 'beurt-wijzigen',
    setup: (h) => h.routes['GET /teams/3/duties'] = _dutiesByType,
    open: _taps(['duties-assignment-120-edit']),
  ),
  AuditScreen(
    '/duties',
    label: 'groep',
    setup: (h) => h.routes['GET /teams/3/duties'] = _dutiesByType,
    open: (t) => _tapAll(t, [find.text('Wassen'), _key('duties-group-add')]),
  ),
  // ── Trainingsteams ──────────────────────────────────────────────────────
  AuditScreen(
    '/events/512/teams',
    label: 'instellingen',
    setup: (h) => h.on(
      'GET /teams/3/events/512/teams',
      200,
      TrainingTeamsFixtures.screen(),
    ),
    open: _taps(['training-open-setup']),
  ),
  AuditScreen(
    '/events/512/teams',
    label: 'sterktes',
    // Meting negeert de verschuiving van de sheet en meet in de waas erboven; echt #646B78 op wit, 5.4:1.
    contrastFalsePositives: ['MF'],
    setup: (h) => h.on(
      'GET /teams/3/events/512/teams',
      200,
      TrainingTeamsFixtures.screen(),
    ),
    open: _taps(['training-open-strengths']),
  ),
  // ── Vakanties ───────────────────────────────────────────────────────────
  AuditScreen(
    '/vacations',
    trainer: false,
    label: 'nieuw',
    setup: (h) => h.on('GET /teams/3/profile', 200, ProfileFixtures.profile()),
    open: _taps(['vacations-add']),
  ),
  // ── Afspraken ───────────────────────────────────────────────────────────
  AuditScreen(
    '/agreements',
    label: 'intro',
    setup: (h) => h.on(
      'GET /teams/3/agreements',
      200,
      AgreementsFixtures.overview(canManage: true, intro: null),
    ),
    open: _taps(['agreements-intro-add']),
  ),
  AuditScreen(
    '/agreements',
    label: 'nieuw',
    setup: (h) => h.on(
      'GET /teams/3/agreements',
      200,
      AgreementsFixtures.overview(canManage: true),
    ),
    open: _taps(['agreements-add']),
  ),
];

void main() => registerAudit(_sheets);
