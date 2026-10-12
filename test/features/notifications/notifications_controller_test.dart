import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:assistje/features/notifications/application/notification_preferences_controller.dart';
import 'package:assistje/features/notifications/application/notifications_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'notification_fixtures.dart';

const _list = 'GET /teams/3/notifications';
const _readAll = 'POST /teams/3/notifications/read-all';
String _read(String id) => 'POST /teams/3/notifications/$id/read';
String _delete(String id) => 'DELETE /teams/3/notifications/$id';
const _prefs = 'GET /notification-preferences';
const _patch = 'PATCH /notification-preferences';

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<void> boot(void Function(FakeHttpAdapter http) setup) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http.on(
      'GET /me',
      200,
      ApiFixtures.meResponse(teams: [ApiFixtures.membership(unread: 2)]),
    );
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(meProvider, (_, _) {});
    await container.read(meProvider.future);
  }

  group('NotificationsController', () {
    Future<NotificationsController> start(
      void Function(FakeHttpAdapter http) setup,
    ) async {
      await boot(setup);
      container.listen(notificationsControllerProvider(3), (_, _) {});
      await container.read(notificationsControllerProvider(3).future);
      return container.read(notificationsControllerProvider(3).notifier);
    }

    NotificationsState state() =>
        container.read(notificationsControllerProvider(3)).requireValue;

    test('bladert met ?page= en plakt zonder dubbelen', () async {
      final controller = await start((http) {
        http.routes[_list] = (request) {
          final page = request.options.uri.queryParameters['page'];
          return page == '2'
              ? FakeResponse(
                  200,
                  NotificationFixtures.page(
                    // n-19 schoof door een nieuwe melding naar pagina 2.
                    items: NotificationFixtures.many(20, offset: 19),
                    currentPage: 2,
                    lastPage: 2,
                    total: 39,
                    unread: 39,
                  ),
                )
              : FakeResponse(
                  200,
                  NotificationFixtures.page(
                    items: NotificationFixtures.many(20),
                    lastPage: 2,
                    total: 39,
                    unread: 39,
                  ),
                );
        };
      });

      expect(state().items, hasLength(20));
      expect(state().hasMore, isTrue);
      expect(state().unreadCount, 39);

      expect(await controller.loadMore(), isNull);
      expect(
        backend.http.requests.last.options.uri.queryParameters['page'],
        '2',
      );
      expect(state().items, hasLength(39));
      expect(state().items.map((n) => n.id).toSet(), hasLength(39));
      expect(state().hasMore, isFalse);

      // Niets meer: geen extra verzoek.
      final before = backend.http.requestsTo(_list).length;
      expect(await controller.loadMore(), isNull);
      expect(backend.http.requestsTo(_list), hasLength(before));
    });

    test('bijladen mislukt: lijst blijft, fout komt terug', () async {
      final controller = await start(
        (http) => http.on(
          _list,
          200,
          NotificationFixtures.page(
            items: NotificationFixtures.many(20),
            lastPage: 2,
          ),
        ),
      );
      backend.http.on(_list, 500, {'message': 'Kapot'});
      expect(await controller.loadMore(), isA<ServerException>());
      expect(state().items, hasLength(20));
      expect(state().loadingMore, isFalse);
      expect(state().page, 1);
    });

    test(
      'gelezen: optimistisch, daarna de serverstand en /me ververst',
      () async {
        const id = NotificationFixtures.lineupId;
        late bool readDuringRequest;
        final controller = await start((http) {
          http.on(_list, 200, NotificationFixtures.page());
          http.routes[_read(id)] = (_) {
            readDuringRequest = state().items.single.read;
            return FakeResponse(
              200,
              NotificationFixtures.readResponse(unread: 0),
            );
          };
        });
        final meCalls = backend.http.requestsTo('GET /me').length;

        expect(await controller.markRead(id), isNull);
        expect(readDuringRequest, isTrue);
        expect(state().items.single.read, isTrue);
        expect(state().unreadCount, 0);
        // De bel (unread_notifications_count in /me) loopt mee.
        await container.read(meProvider.future);
        expect(backend.http.requestsTo('GET /me'), hasLength(meCalls + 1));
      },
    );

    test('gelezen mislukt: teruggedraaid', () async {
      const id = NotificationFixtures.lineupId;
      final controller = await start((http) {
        http.on(_list, 200, NotificationFixtures.page());
        http.on(_read(id), 500, {'message': 'Kapot'});
      });
      expect(await controller.markRead(id), isA<ServerException>());
      expect(state().items.single.read, isFalse);
      expect(state().unreadCount, 1);
    });

    test('alles gelezen en terugdraaien', () async {
      final controller = await start((http) {
        http.on(
          _list,
          200,
          NotificationFixtures.page(
            items: [
              ...NotificationFixtures.many(2),
              ...NotificationFixtures.many(1, offset: 2, read: true),
            ],
          ),
        );
        http.on(_readAll, 500, {'message': 'Kapot'});
      });
      expect(state().unreadCount, 2);

      expect(await controller.markAllRead(), isA<ServerException>());
      expect(state().items.where((n) => !n.read), hasLength(2));
      expect(state().unreadCount, 2);

      backend.http.on(_readAll, 200, NotificationFixtures.readAllResponse());
      expect(await controller.markAllRead(), isNull);
      expect(state().items.every((n) => n.read), isTrue);
      expect(state().unreadCount, 0);
    });

    test('weghalen: meteen weg; bij een fout op dezelfde plek terug', () async {
      final controller = await start((http) {
        http.on(
          _list,
          200,
          NotificationFixtures.page(items: NotificationFixtures.many(3)),
        );
        http.on(_delete('n-1'), 403, {'message': 'Niet in de demo.'});
        http.on(_delete('n-2'), 204);
      });

      final pending = controller.delete('n-1');
      // Synchroon weg (voor de veeg).
      expect(state().items.map((n) => n.id), ['n-0', 'n-2']);
      expect(await pending, isA<ForbiddenException>());
      expect(state().items.map((n) => n.id), ['n-0', 'n-1', 'n-2']);
      expect(state().unreadCount, 3);
      expect(state().total, 3);

      expect(await controller.delete('n-2'), isNull);
      expect(state().items.map((n) => n.id), ['n-0', 'n-1']);
      expect(state().unreadCount, 2);
      expect(state().total, 2);
    });
  });

  group('NotificationPreferencesController', () {
    Future<NotificationPreferencesController> start(
      void Function(FakeHttpAdapter http) setup,
    ) async {
      await boot(setup);
      container.listen(notificationPreferencesControllerProvider, (_, _) {});
      await container.read(notificationPreferencesControllerProvider.future);
      return container.read(notificationPreferencesControllerProvider.notifier);
    }

    bool enabled(String key) => container
        .read(notificationPreferencesControllerProvider)
        .requireValue
        .isEnabled(key);

    test('schakelen: optimistisch, PATCH, serverstand', () async {
      late bool duringRequest;
      final controller = await start((http) {
        http.on(_prefs, 200, NotificationFixtures.preferences());
        http.routes[_patch] = (_) {
          duringRequest = enabled('lineup');
          return FakeResponse(
            200,
            NotificationFixtures.preferences(overrides: {'lineup': false}),
          );
        };
      });

      expect(await controller.toggle('lineup', enabled: false), isNull);
      expect(duringRequest, isFalse);
      expect(enabled('lineup'), isFalse);
      expect(backend.http.requestsTo(_patch).single.body, {
        'key': 'lineup',
        'enabled': false,
      });
    });

    test('schakelen mislukt: teruggedraaid', () async {
      final controller = await start((http) {
        http.on(_prefs, 200, NotificationFixtures.preferences());
        http.on(_patch, 422, {
          'message': 'Onbekende categorie.',
          'errors': {
            'key': ['Onbekende categorie.'],
          },
        });
      });
      expect(
        await controller.toggle('birthday', enabled: false),
        isA<ValidationException>(),
      );
      expect(enabled('birthday'), isTrue);
    });
  });
}
