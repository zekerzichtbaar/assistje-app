import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/notifications/data/notification_preferences_repository.dart';
import 'package:assistje/features/notifications/data/notifications_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'notification_fixtures.dart';

void main() {
  late FakeHttpAdapter http;
  late ApiClient api;

  setUp(() {
    http = FakeHttpAdapter();
    api = ApiClient(
      buildApiDio(
        baseUrl: 'https://assistje.test/api/v1',
        readToken: () async => '12|abc',
        onUnauthorized: () {},
        adapter: http,
      ),
    );
  });

  group('NotificationsRepository', () {
    late NotificationsRepository repository;
    setUp(() => repository = NotificationsRepository(api));

    test('GET leest het voorbeeld uit de docs, met page/per_page', () async {
      http.on(
        'GET /teams/3/notifications',
        200,
        NotificationFixtures.page(lastPage: 3, total: 47, unread: 4),
      );

      final page = await repository.fetch(3, page: 2);

      expect(http.requests.single.options.uri.queryParameters, {
        'page': '2',
        'per_page': '20',
      });
      final n = page.items.single;
      expect(n.id, NotificationFixtures.lineupId);
      expect(n.type, 'lineup_published');
      expect(n.title, '📋 De opstelling is bekend');
      expect(n.body, 'Zaterdag tegen VV Noord: je staat in de basis.');
      expect(n.url, '/events/123/lineup');
      expect(n.link, 'https://vogels-3.assistje.nl/events/123/lineup');
      expect(n.read, isFalse);
      expect(n.readAt, isNull);
      expect(n.createdAt, DateTime.parse('2026-10-09T18:02:11+02:00'));
      expect(page.meta.currentPage, 1);
      expect(page.meta.lastPage, 3);
      expect(page.meta.perPage, 20);
      expect(page.meta.total, 47);
      expect(page.meta.unreadCount, 4);
    });

    test('type/url null worden leeg/null', () async {
      http.on(
        'GET /teams/3/notifications',
        200,
        NotificationFixtures.page(
          items: [NotificationFixtures.notification(type: null, url: null)],
        ),
      );
      final n = (await repository.fetch(3)).items.single;
      expect(n.type, '');
      expect(n.url, isNull);
      expect(n.link, isNull);
    });

    test('POST read geeft melding + ongelezen-telling', () async {
      http.on(
        'POST /teams/3/notifications/${NotificationFixtures.lineupId}/read',
        200,
        NotificationFixtures.readResponse(),
      );
      final result = await repository.markRead(
        3,
        NotificationFixtures.lineupId,
      );
      expect(result.notification.read, isTrue);
      expect(
        result.notification.readAt,
        DateTime.parse('2026-10-09T18:05:40+02:00'),
      );
      expect(result.unreadCount, 3);
    });

    test('POST read-all geeft de nieuwe telling', () async {
      http.on(
        'POST /teams/3/notifications/read-all',
        200,
        NotificationFixtures.readAllResponse(),
      );
      expect(await repository.markAllRead(3), 0);
      expect(http.requests.single.method, 'POST');
    });

    test('DELETE: 204 zonder body; 403 op een demo', () async {
      http.on('DELETE /teams/3/notifications/abc', 204);
      await repository.delete(3, 'abc');
      expect(
        http.requestsTo('DELETE /teams/3/notifications/abc'),
        hasLength(1),
      );

      http.on('DELETE /teams/3/notifications/abc', 403, {
        'message': 'Niet in de demo.',
      });
      await expectLater(
        repository.delete(3, 'abc'),
        throwsA(isA<ForbiddenException>()),
      );
    });
  });

  group('NotificationPreferencesRepository', () {
    late NotificationPreferencesRepository repository;
    setUp(() => repository = NotificationPreferencesRepository(api));

    test('GET leest kaart en catalogus (17, op volgorde)', () async {
      http.on(
        'GET /notification-preferences',
        200,
        NotificationFixtures.preferences(),
      );
      final prefs = await repository.fetch();
      expect(prefs.types, hasLength(17));
      expect(prefs.types.first.key, 'duty_reminder');
      expect(prefs.types.first.label, 'Diensten');
      final poule = prefs.types.firstWhere((t) => t.key == 'poule_results');
      expect(poule.pouleOnly, isTrue);
      expect(poule.enabled, isFalse);
      expect(poule.enabledByDefault, isFalse);
      expect(prefs.preferences['lineup'], isTrue);
      expect(prefs.isEnabled('poule_results'), isFalse);
    });

    test('PATCH stuurt key + enabled en leest de nieuwe stand', () async {
      http.on(
        'PATCH /notification-preferences',
        200,
        NotificationFixtures.preferences(overrides: {'lineup': false}),
      );
      final prefs = await repository.update('lineup', enabled: false);
      expect(http.requests.single.body, {'key': 'lineup', 'enabled': false});
      expect(prefs.isEnabled('lineup'), isFalse);
    });
  });
}
