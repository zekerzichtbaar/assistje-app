import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/shell.dart';
import 'notification_fixtures.dart';

const _list = 'GET /teams/3/notifications';
const _prefs = 'GET /notification-preferences';
const _patch = 'PATCH /notification-preferences';
const _id = NotificationFixtures.lineupId;

Future<void> _open(
  WidgetTester tester,
  String location, {
  required void Function(FakeHttpAdapter http) setup,
  bool hasPoule = false,
}) async {
  final (container, _) = await pumpSignedIn(
    tester,
    teams: [ApiFixtures.membership(unread: 2, hasPoule: hasPoule)],
    setup: setup,
  );
  container.read(routerProvider).go(location);
  await tester.pumpAndSettle();
}

void main() {
  group('Meldingen', () {
    testWidgets('lijst: ongelezen gemarkeerd, telling, alles gelezen', (
      tester,
    ) async {
      late FakeHttpAdapter api;
      await _open(
        tester,
        AppRoutes.notifications,
        setup: (http) {
          api = http;
          http.on(
            _list,
            200,
            NotificationFixtures.page(
              items: [
                NotificationFixtures.notification(),
                NotificationFixtures.notification(
                  id: 'old',
                  title: 'Oude melding',
                  read: true,
                ),
              ],
            ),
          );
          http.on(
            'POST /teams/3/notifications/read-all',
            200,
            NotificationFixtures.readAllResponse(marked: 1),
          );
        },
      );

      expect(find.text('Meldingen'), findsOneWidget);
      expect(find.text('📋 De opstelling is bekend'), findsOneWidget);
      expect(find.text('Oude melding'), findsOneWidget);
      expect(find.text('1 ongelezen'), findsOneWidget);
      expect(find.byKey(const ValueKey('notification-unread-$_id')), findsOne);
      expect(
        find.byKey(const ValueKey('notification-unread-old')),
        findsNothing,
      );
      expect(
        api.requestsTo(_list).single.options.uri.queryParameters['page'],
        '1',
      );

      await tester.tap(find.byKey(const ValueKey('notifications-read-all')));
      await tester.pumpAndSettle();
      expect(
        api.requestsTo('POST /teams/3/notifications/read-all'),
        hasLength(1),
      );
      expect(
        find.byKey(const ValueKey('notification-unread-$_id')),
        findsNothing,
      );
      expect(
        find.byKey(const ValueKey('notifications-read-all')),
        findsNothing,
      );
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
    });

    testWidgets('tik: als gelezen en naar de app-route van de url', (
      tester,
    ) async {
      late FakeHttpAdapter api;
      final (container, _) = await pumpSignedIn(
        tester,
        teams: [ApiFixtures.membership(unread: 1)],
        setup: (http) {
          api = http;
          http.on(_list, 200, NotificationFixtures.page());
          http.on(
            'POST /teams/3/notifications/$_id/read',
            200,
            NotificationFixtures.readResponse(unread: 0),
          );
        },
      );
      final router = container.read(routerProvider);
      router.go(AppRoutes.notifications);
      await tester.pumpAndSettle();

      await tester.tap(find.text('📋 De opstelling is bekend'));
      await tester.pumpAndSettle();

      expect(
        api.requestsTo('POST /teams/3/notifications/$_id/read'),
        hasLength(1),
      );
      expect(router.state.uri.path, '/events/123/lineup');
    });

    testWidgets('tik op een link die de app niet kent: blijft in de inbox', (
      tester,
    ) async {
      final (container, _) = await pumpSignedIn(
        tester,
        teams: [ApiFixtures.membership()],
        setup: (http) => http.on(
          _list,
          200,
          NotificationFixtures.page(
            items: [
              NotificationFixtures.notification(
                url: '/admin/teams',
                read: true,
              ),
            ],
          ),
        ),
      );
      final router = container.read(routerProvider);
      router.go(AppRoutes.notifications);
      await tester.pumpAndSettle();

      await tester.tap(find.text('📋 De opstelling is bekend'));
      await tester.pumpAndSettle();
      expect(router.state.uri.path, AppRoutes.notifications);
    });

    testWidgets('vegen haalt weg (DELETE) met toast', (tester) async {
      late FakeHttpAdapter api;
      await _open(
        tester,
        AppRoutes.notifications,
        setup: (http) {
          api = http;
          http.on(
            _list,
            200,
            NotificationFixtures.page(items: NotificationFixtures.many(2)),
          );
          http.on('DELETE /teams/3/notifications/n-0', 204);
        },
      );

      await tester.fling(find.text('Melding 0'), const Offset(-500, 0), 1500);
      await tester.pumpAndSettle();
      // Na de veeg loopt de DELETE pas na de inklap-animatie.
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();

      expect(api.requestsTo('DELETE /teams/3/notifications/n-0'), hasLength(1));
      expect(find.text('Melding 0'), findsNothing);
      expect(find.text('Melding 1'), findsOneWidget);
      expect(find.text('Melding verwijderd'), findsOneWidget);
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
    });

    testWidgets('bijladen via de knop onderaan (?page=2)', (tester) async {
      late FakeHttpAdapter api;
      await _open(
        tester,
        AppRoutes.notifications,
        setup: (http) {
          api = http;
          http.routes[_list] = (request) {
            final page = request.options.uri.queryParameters['page'];
            return FakeResponse(
              200,
              page == '2'
                  ? NotificationFixtures.page(
                      items: NotificationFixtures.many(1, offset: 3),
                      currentPage: 2,
                      lastPage: 2,
                    )
                  : NotificationFixtures.page(
                      items: NotificationFixtures.many(3),
                      lastPage: 2,
                    ),
            );
          };
        },
      );

      await tester.tap(find.byKey(const ValueKey('notifications-more')));
      await tester.pumpAndSettle();
      expect(api.requestsTo(_list), hasLength(2));
      expect(find.text('Melding 3'), findsOneWidget);
      expect(find.byKey(const ValueKey('notifications-more')), findsNothing);
    });

    testWidgets('leeg', (tester) async {
      await _open(
        tester,
        AppRoutes.notifications,
        setup: (http) =>
            http.on(_list, 200, NotificationFixtures.page(items: const [])),
      );
      expect(find.byKey(const ValueKey('notifications-empty')), findsOneWidget);
      expect(find.text('Geen meldingen'), findsOneWidget);
    });

    testWidgets('fout + opnieuw proberen', (tester) async {
      late FakeHttpAdapter api;
      await _open(
        tester,
        AppRoutes.notifications,
        setup: (http) {
          api = http;
          http.on(_list, 500, {'message': 'Kapot'});
        },
      );
      expect(find.byKey(const ValueKey('notifications-error')), findsOneWidget);

      api.on(_list, 200, NotificationFixtures.page());
      await tester.tap(find.byKey(const ValueKey('notifications-retry')));
      await tester.pumpAndSettle();
      expect(find.text('📋 De opstelling is bekend'), findsOneWidget);
    });
  });

  group('Pushvoorkeuren', () {
    testWidgets('catalogus op volgorde; poule verborgen zonder poule', (
      tester,
    ) async {
      await _open(
        tester,
        AppRoutes.notificationPreferences,
        setup: (http) =>
            http.on(_prefs, 200, NotificationFixtures.preferences()),
      );
      expect(find.text('Pushmeldingen'), findsOneWidget);
      expect(find.text('Diensten'), findsOneWidget);
      expect(find.text('Uitleg bij Diensten.'), findsOneWidget);
      expect(
        find.byKey(const ValueKey('pref-duty_unavailable')),
        findsOneWidget,
      );
      expect(find.byKey(const ValueKey('pref-poule_results')), findsNothing);
      expect(
        find.byWidgetPredicate(
          (w) => w is Switch && w.key.toString().contains('pref-'),
        ),
        findsNWidgets(16),
      );
    });

    testWidgets('met poule: ook de poule-categorie', (tester) async {
      await _open(
        tester,
        AppRoutes.notificationPreferences,
        hasPoule: true,
        setup: (http) =>
            http.on(_prefs, 200, NotificationFixtures.preferences()),
      );
      expect(find.byKey(const ValueKey('pref-poule_results')), findsOneWidget);
    });

    testWidgets('schakelen stuurt PATCH; fout draait terug', (tester) async {
      late FakeHttpAdapter api;
      await _open(
        tester,
        AppRoutes.notificationPreferences,
        setup: (http) {
          api = http;
          http.on(_prefs, 200, NotificationFixtures.preferences());
          http.on(
            _patch,
            200,
            NotificationFixtures.preferences(overrides: {'lineup': false}),
          );
        },
      );
      Switch lineup() =>
          tester.widget<Switch>(find.byKey(const ValueKey('pref-lineup')));
      expect(lineup().value, isTrue);

      await tester.tap(find.byKey(const ValueKey('pref-lineup')));
      await tester.pumpAndSettle();
      expect(api.requestsTo(_patch).single.body, {
        'key': 'lineup',
        'enabled': false,
      });
      expect(lineup().value, isFalse);

      api.on(_patch, 500, {'message': 'Kapot'});
      await tester.tap(find.byKey(const ValueKey('pref-lineup')));
      await tester.pumpAndSettle();
      expect(lineup().value, isFalse);
      expect(find.text('Opslaan lukte niet. Probeer opnieuw.'), findsOneWidget);
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
    });

    testWidgets('fout bij laden', (tester) async {
      await _open(
        tester,
        AppRoutes.notificationPreferences,
        setup: (http) => http.on(_prefs, 500, {'message': 'Kapot'}),
      );
      expect(
        find.byKey(const ValueKey('notification-preferences-error')),
        findsOneWidget,
      );
    });
  });
}
