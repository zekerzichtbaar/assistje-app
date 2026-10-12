import 'dart:async';

import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/features/event/application/event_detail_controller.dart';
import 'package:assistje/features/event/data/models/event_detail_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import '../../helpers/test_app.dart';
import 'event_fixtures.dart';

const _detail = 'GET /teams/3/events/412';
const _agenda = 'GET /teams/3/agenda';
const EventKey _key = (teamId: 3, eventId: 412);
const _future = '2099-10-11T14:30:00+02:00';

String _assign(int typeId) => 'PATCH /teams/3/events/412/duties/$typeId';

Map<String, dynamic> _person(
  String key,
  String name, [
  String kind = 'player',
]) => {'key': key, 'name': name, 'kind': kind};

/// Wat een trainer ziet: elk match-type met opties.
List<Map<String, dynamic>> _trainerDuties({
  List<String> fruit = const ['p_17'],
}) => [
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
  {
    'duty_type_id': 5,
    'name': 'Wassen',
    'icon': 'TShirt',
    'mode': 'group',
    'assignment_id': 90,
    'member_key': null,
    'member_keys': <String>[],
    'assignee_absent': false,
    'duty_group_id': 7,
    'label': 'Groep A',
    'member_names': ['Coach Ronald', 'Sam de Vries'],
    'notes': 'Tas bij de kantine',
    'done': true,
    'mine': false,
    'options': [
      {
        'key': 'g_7',
        'id': 7,
        'name': 'Groep A',
        'members': ['Coach Ronald', 'Sam de Vries'],
      },
    ],
  },
  {
    'duty_type_id': 6,
    'name': 'Fruit',
    'icon': 'Orange',
    'mode': 'multi',
    'assignment_id': 91,
    'member_key': fruit.isEmpty ? null : fruit.first,
    'member_keys': fruit,
    'assignee_absent': false,
    'duty_group_id': null,
    'label': fruit.isEmpty ? null : 'Sam de Vries',
    'member_names': [if (fruit.isNotEmpty) 'Sam de Vries'],
    'notes': null,
    'done': false,
    'mine': false,
    'options': [_person('p_17', 'Sam de Vries'), _person('p_18', 'Kim Jansen')],
  },
];

Map<String, dynamic> _flag() => {
  'shifts': [
    {'key': 'p37', 'player_id': 37, 'user_id': null, 'from_minute': 0},
    {'key': 'p44', 'player_id': 44, 'user_id': null, 'from_minute': 45},
  ],
  'names': ['Kees Jansen', 'Joris Smit'],
  'mine': false,
  'match_minutes': 90,
  'pool': <Object>[],
};

Map<String, dynamic> _trainerDetail({List<String> fruit = const ['p_17']}) =>
    EventFixtures.eventDetail({
      'starts_at': _future,
      'is_trainer': true,
      'duties': _trainerDuties(fruit: fruit),
      'flag': _flag(),
    });

Map<String, dynamic> _assigned() => {
  'data': {'message': 'Toegewezen.', 'assignments': <Object>[]},
};

void main() {
  group('model', () {
    test('leest duties en flag uit het docs-voorbeeld', () {
      final event = EventDetail.fromJson(EventFixtures.eventDetailData());
      final duty = event.duties.single;
      expect(duty.dutyTypeId, 2);
      expect(duty.name, 'Shirts wassen');
      expect(duty.mode, 'rotate');
      expect(duty.memberKeys, ['p_42']);
      expect(duty.assigneeAbsent, isTrue);
      expect(duty.mine, isTrue);
      expect(duty.label, 'Piet Bakker');
      expect(duty.options, isEmpty);
      expect(duty.isPicked('p_42'), isTrue);
      final flag = event.flag!;
      expect(flag.names, ['Kees Jansen']);
      expect(flag.shifts.single.fromMinute, 0);
      expect(flag.matchMinutes, 90);
      expect(event.showsDuties, isTrue);
    });

    test('geen dienstenkaart bij een training of zonder diensten', () {
      final training = EventDetail.fromJson(
        EventFixtures.eventDetailData({'type': 'training'}),
      );
      expect(training.showsDuties, isFalse);
      final empty = EventDetail.fromJson(
        EventFixtures.eventDetailData({'duties': <Object>[], 'flag': null}),
      );
      expect(empty.showsDuties, isFalse);
      final flagOnly = EventDetail.fromJson(
        EventFixtures.eventDetailData({'duties': <Object>[]}),
      );
      expect(flagOnly.showsDuties, isTrue);
    });

    test('groep: gekozen op duty_group_id', () {
      final event = EventDetail.fromJson(
        _trainerDetail()['data'] as Map<String, dynamic>,
      );
      final wash = event.duties[1];
      expect(wash.isGroup, isTrue);
      expect(wash.isPicked('g_7'), isTrue);
      expect(wash.nobodyPicked, isFalse);
      expect(wash.options.single.id, 7);
      expect(wash.options.single.members, hasLength(2));
      expect(event.duties.first.nobodyPicked, isTrue);
      expect(event.duties.first.options.last.kind, 'staff');
    });
  });

  group('controller', () {
    late TestBackend backend;
    late ProviderContainer container;

    Future<EventDetailController> start(
      void Function(FakeHttpAdapter http) setup,
    ) async {
      backend = TestBackend(token: '12|abc');
      await backend.init();
      backend.http
        ..on(_agenda, 200, ApiFixtures.emptyAgendaResponse())
        ..on(_detail, 200, _trainerDetail());
      setup(backend.http);
      container = backend.container();
      addTearDown(container.dispose);
      container.listen(eventDetailControllerProvider(_key), (_, _) {});
      await container.read(eventDetailControllerProvider(_key).future);
      return container.read(eventDetailControllerProvider(_key).notifier);
    }

    EventDetail current() =>
        container.read(eventDetailControllerProvider(_key)).requireValue;

    test('persoon toewijzen, daarna stil verversen', () async {
      final controller = await start(
        (http) => http.on(_assign(3), 200, _assigned()),
      );
      backend.http.on(_detail, 200, _trainerDetail(fruit: const []));
      final before = backend.http.requestsTo(_detail).length;

      final error = await controller.assignDuty(current().duties.first, 'u_4');

      expect(error, isNull);
      expect(backend.http.requestsTo(_assign(3)).single.body, {
        'member_key': 'u_4',
      });
      expect(backend.http.requestsTo(_detail).length, before + 1);
      expect(current().duties.last.memberKeys, isEmpty);
    });

    test('groep op id, vrijmaken met null', () async {
      final controller = await start(
        (http) => http.on(_assign(5), 200, _assigned()),
      );
      final wash = current().duties[1];

      await controller.assignDuty(wash, 'g_7');
      await controller.assignDuty(wash, null);

      final bodies = [
        for (final r in backend.http.requestsTo(_assign(5))) r.body,
      ];
      expect(bodies, [
        {'duty_group_id': 7},
        {'duty_group_id': null},
      ]);
    });

    test('fout komt terug, detail blijft staan', () async {
      final controller = await start(
        (http) => http.on(_assign(3), 422, {
          'message': 'Deze dienst hoort niet bij een wedstrijd.',
        }),
      );
      final before = backend.http.requestsTo(_detail).length;

      final error = await controller.assignDuty(current().duties.first, 'p_17');

      expect(error, isA<ValidationException>());
      expect(backend.http.requestsTo(_detail).length, before);
    });
  });

  group('scherm', () {
    Future<(ProviderContainer, FakeHttpAdapter)> open(
      WidgetTester tester, {
      required Map<String, dynamic> detail,
      String role = 'player',
      void Function(FakeHttpAdapter http)? setup,
    }) async {
      final (container, backend) = await pumpSignedIn(
        tester,
        teams: [ApiFixtures.membership(role: role)],
        setup: (http) {
          http.on(_detail, 200, detail);
          setup?.call(http);
        },
      );
      unawaited(container.read(routerProvider).push(AppRoutes.event(412)));
      await pumpUntilFound(
        tester,
        find.byKey(const ValueKey('event-detail-screen')),
      );
      await tester.pumpAndSettle();
      return (container, backend.http);
    }

    Future<void> scrollTo(WidgetTester tester, Finder finder) async {
      await tester.scrollUntilVisible(
        finder,
        300,
        scrollable: find
            .descendant(
              of: find.byKey(const ValueKey('event-detail-screen')),
              matching: find.byType(Scrollable),
            )
            .first,
      );
      await tester.pumpAndSettle();
    }

    Finder inDuties(Finder finder) => find.descendant(
      of: find.byKey(const ValueKey('event-duties')),
      matching: finder,
    );

    Future<void> tap(WidgetTester tester, Finder finder) async {
      await tester.ensureVisible(finder);
      await tester.pumpAndSettle();
      await tester.tap(finder);
      await tester.pumpAndSettle();
    }

    testWidgets('speler: diensten en vlag alleen-lezen', (tester) async {
      await open(
        tester,
        detail: EventFixtures.eventDetail({'starts_at': _future}),
      );
      await scrollTo(tester, find.byKey(const ValueKey('event-duties')));

      expect(inDuties(find.text('DIENSTEN')), findsOneWidget);
      expect(inDuties(find.text('Shirts wassen')), findsOneWidget);
      expect(inDuties(find.text('Jij')), findsOneWidget);
      expect(inDuties(find.textContaining('afgemeld')), findsOneWidget);
      expect(inDuties(find.text('Vlaggen')), findsOneWidget);
      expect(inDuties(find.text('Kees Jansen')), findsOneWidget);

      await tap(tester, find.byKey(const ValueKey('event-duty-2')));
      expect(find.text('Shirts wassen toewijzen'), findsNothing);
      await tap(tester, find.byKey(const ValueKey('event-duty-flag')));
      expect(find.byType(BottomSheet), findsNothing);
    });

    testWidgets('geen dienstenkaart bij een training', (tester) async {
      await open(
        tester,
        detail: EventFixtures.eventDetail({
          'starts_at': _future,
          'type': 'training',
        }),
      );
      expect(find.byKey(const ValueKey('event-duties')), findsNothing);
    });

    testWidgets('trainer: persoon toewijzen sluit de sheet en ververst', (
      tester,
    ) async {
      final (_, http) = await open(
        tester,
        detail: _trainerDetail(),
        role: 'trainer',
        setup: (http) => http.on(_assign(3), 200, _assigned()),
      );
      await scrollTo(tester, find.byKey(const ValueKey('event-duties')));

      expect(inDuties(find.text('Nog niemand')), findsOneWidget);
      expect(
        inDuties(find.text('Coach Ronald, Sam de Vries · Tas bij de kantine')),
        findsOneWidget,
      );
      expect(inDuties(find.text('gedaan')), findsOneWidget);
      expect(inDuties(find.text("wissel vanaf 45'")), findsOneWidget);
      expect(inDuties(find.text('Kees Jansen → Joris Smit')), findsOneWidget);

      final before = http.requestsTo(_detail).length;
      await tap(tester, find.byKey(const ValueKey('event-duty-3')));
      expect(find.text('Kantine toewijzen'), findsOneWidget);
      expect(find.textContaining('staf'), findsOneWidget);

      await tap(tester, find.byKey(const ValueKey('event-duty-option-u_4')));
      expect(http.requestsTo(_assign(3)).single.body, {'member_key': 'u_4'});
      expect(find.text('Kantine toewijzen'), findsNothing);
      expect(http.requestsTo(_detail).length, before + 1);
    });

    testWidgets('trainer: multi blijft open en volgt de vinkjes', (
      tester,
    ) async {
      final (_, http) = await open(
        tester,
        detail: _trainerDetail(),
        role: 'trainer',
        setup: (http) => http.on(_assign(6), 200, _assigned()),
      );
      await scrollTo(tester, find.byKey(const ValueKey('event-duties')));

      await tap(tester, find.byKey(const ValueKey('event-duty-6')));
      expect(find.text('Fruit toewijzen'), findsOneWidget);
      expect(
        find.descendant(
          of: find.byKey(const ValueKey('event-duty-option-p_17')),
          matching: find.byKey(const ValueKey('event-duty-option-check')),
        ),
        findsOneWidget,
      );

      // Na de tik komt Sam er (volgens de server) af.
      http.on(_detail, 200, _trainerDetail(fruit: const []));
      await tap(tester, find.byKey(const ValueKey('event-duty-option-p_17')));
      expect(http.requestsTo(_assign(6)).single.body, {'member_key': 'p_17'});
      expect(find.text('Fruit toewijzen'), findsOneWidget);
      expect(
        find.descendant(
          of: find.byKey(const ValueKey('event-duty-option-none')),
          matching: find.byKey(const ValueKey('event-duty-option-check')),
        ),
        findsOneWidget,
      );
    });

    testWidgets('trainer: fout bij toewijzen geeft een toast', (tester) async {
      await open(
        tester,
        detail: _trainerDetail(),
        role: 'trainer',
        setup: (http) =>
            http.on(_assign(5), 403, {'message': 'Dit is een demo-team.'}),
      );
      await scrollTo(tester, find.byKey(const ValueKey('event-duties')));

      await tap(tester, find.byKey(const ValueKey('event-duty-5')));
      await tap(tester, find.byKey(const ValueKey('event-duty-option-none')));
      expect(find.text('Toewijzen mislukt'), findsOneWidget);
      expect(find.text('Dit is een demo-team.'), findsOneWidget);
      // De sheet blijft open om het opnieuw te proberen.
      expect(find.text('Wassen toewijzen'), findsOneWidget);
    });
  });
}
