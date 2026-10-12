import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/messages/data/messages_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'messages_fixtures.dart';

void main() {
  late FakeHttpAdapter http;
  late MessagesRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = MessagesRepository(
      ApiClient(
        buildApiDio(
          baseUrl: 'https://assistje.test/api/v1',
          readToken: () async => '12|abc',
          onUnauthorized: () {},
          adapter: http,
        ),
      ),
    );
  });

  test('GET leest berichten, instellingen, historie en links', () async {
    http.on('GET /teams/3/messages', 200, MessagesFixtures.overview());

    final overview = await repository.fetch(3);

    final message = overview.messages.single;
    expect(message.id, 31);
    expect(message.title, 'Training afgelast');
    expect(message.link, '/events/412');
    expect(message.recipientsCount, 18);
    expect(message.senderName, 'Coach Ronald');
    expect(message.sentAtTime, DateTime.utc(2026, 10, 9, 15, 42, 10).toLocal());

    expect(overview.autoSettings.map((s) => s.key), [
      'birthday',
      'rsvp_late_cancel',
    ]);
    final birthday = overview.autoSettings.first;
    expect(birthday.enabled, isTrue);
    expect(birthday.templated, isTrue);
    expect(birthday.placeholderTokens, ['{name}', '{age}']);
    expect(birthday.isCustomized, isFalse);
    expect(overview.autoSettings.last.templated, isFalse);

    final history = overview.autoHistory.single;
    expect(history.label, 'Verjaardag');
    expect(history.title, 'Gefeliciteerd Sam!');
    expect(history.recipientsCount, 17);

    expect(overview.linkTargets.map((g) => g.label), [
      'Pagina',
      'Uit de agenda',
    ]);
    expect(overview.linkLabel('/team'), 'Teamgenoten');
    expect(overview.linkLabel('/onbekend'), isNull);
  });

  test('placeholders met accolades blijven enkel', () async {
    http.on('GET /teams/3/messages', 200, {
      'data': {
        'auto_settings': [
          MessagesFixtures.setting(placeholders: ['{name}']),
        ],
      },
    });
    final overview = await repository.fetch(3);
    expect(overview.messages, isEmpty);
    expect(overview.autoSettings.single.placeholderTokens, ['{name}']);
  });

  test('POST stuurt getrimde velden; lege url valt weg', () async {
    http.on('POST /teams/3/messages', 201, MessagesFixtures.sent());

    final sent = await repository.send(
      3,
      const MessageDraft(title: ' Bal mee ', body: 'Iedereen ', url: '  '),
    );

    expect(http.requests.single.body, {'title': 'Bal mee', 'body': 'Iedereen'});
    expect(sent.id, 32);
    expect(sent.link, '/agenda');

    await repository.send(
      3,
      const MessageDraft(title: 'A', body: 'B', url: '/agenda'),
    );
    expect(http.requests.last.body, {
      'title': 'A',
      'body': 'B',
      'url': '/agenda',
    });
  });

  test('PATCH settings stuurt alleen meegegeven velden', () async {
    http.on(
      'PATCH /teams/3/messages/settings',
      200,
      MessagesFixtures.settingRow(),
    );

    final row = await repository.updateSetting(3, 'birthday', enabled: false);
    expect(http.requests.single.body, {'key': 'birthday', 'enabled': false});
    expect(row.enabled, isFalse);
    expect(row.key, 'birthday');

    await repository.updateSetting(
      3,
      'birthday',
      titleTemplate: ' Hoera {name} ',
      bodyTemplate: '  ',
    );
    expect(http.requests.last.body, {
      'key': 'birthday',
      'title_template': 'Hoera {name}',
      'body_template': null,
    });
  });

  test('422, 403 en 404 komen als ApiException', () async {
    http
      ..on('POST /teams/3/messages', 422, {
        'message': 'Vul een titel in.',
        'errors': {
          'title': ['Vul een titel in.'],
        },
      })
      ..on('PATCH /teams/3/messages/settings', 403, {'message': 'Demo.'})
      ..on('GET /teams/3/messages', 404, {'message': 'Niet gevonden.'});

    await expectLater(
      repository.send(3, const MessageDraft(title: '', body: 'x')),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.fieldError('title'),
          'title',
          'Vul een titel in.',
        ),
      ),
    );
    await expectLater(
      repository.updateSetting(3, 'birthday', enabled: true),
      throwsA(isA<ForbiddenException>()),
    );
    await expectLater(repository.fetch(3), throwsA(isA<NotFoundException>()));
  });
}
