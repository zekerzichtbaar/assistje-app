import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/messages/application/messages_controller.dart';
import 'package:assistje/features/messages/data/messages_repository.dart';
import 'package:assistje/features/messages/data/models/messages_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'messages_fixtures.dart';

const _index = 'GET /teams/3/messages';
const _store = 'POST /teams/3/messages';
const _settings = 'PATCH /teams/3/messages/settings';

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<void> boot(void Function(FakeHttpAdapter http) setup) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(messagesControllerProvider(3), (_, _) {});
  }

  Future<MessagesController> start(
    void Function(FakeHttpAdapter http) setup,
  ) async {
    await boot(setup);
    await container.read(messagesControllerProvider(3).future);
    return container.read(messagesControllerProvider(3).notifier);
  }

  MessagesOverview current() =>
      container.read(messagesControllerProvider(3)).requireValue;

  int indexCalls() => backend.http.requestsTo(_index).length;

  test('laadt het overzicht', () async {
    await start((http) => http.on(_index, 200, MessagesFixtures.overview()));
    expect(current().messages, hasLength(1));
    expect(current().autoSettings, hasLength(2));
  });

  test('403 bij laden komt als AsyncError', () async {
    await boot((http) => http.on(_index, 403, {'message': 'Alleen trainer.'}));
    await expectLater(
      container.read(messagesControllerProvider(3).future),
      throwsA(isA<ForbiddenException>()),
    );
  });

  test('versturen ververst het overzicht', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, MessagesFixtures.overview(empty: true))
        ..on(_store, 201, MessagesFixtures.sent());
    });
    backend.http.on(
      _index,
      200,
      MessagesFixtures.overview(
        messages: [MessagesFixtures.sent()['data'] as Map<String, dynamic>],
      ),
    );

    final before = indexCalls();
    final error = await controller.send(
      const MessageDraft(title: 'Bal mee', body: 'Iedereen een bal mee.'),
    );

    expect(error, isNull);
    expect(indexCalls(), before + 1);
    expect(current().messages.single.id, 32);
  });

  test('422 bij versturen geeft de fout terug en ververst niet', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, MessagesFixtures.overview())
        ..on(_store, 422, {
          'message': 'De titel is te lang.',
          'errors': {
            'title': ['De titel is te lang.'],
          },
        });
    });

    final before = indexCalls();
    final error = await controller.send(
      const MessageDraft(title: 'x', body: 'y'),
    );

    expect(
      error,
      isA<ValidationException>().having(
        (e) => e.fieldError('title'),
        'title',
        'De titel is te lang.',
      ),
    );
    expect(indexCalls(), before);
    expect(current().messages, hasLength(1));
  });

  test('403 (demo) bij versturen komt terug als fout', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, MessagesFixtures.overview())
        ..on(_store, 403, {'message': 'Demo-team: alleen kijken.'});
    });
    final error = await controller.send(
      const MessageDraft(title: 'x', body: 'y'),
    );
    expect(error, isA<ForbiddenException>());
  });

  test('instelling omzetten: PATCH en daarna verversen', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, MessagesFixtures.overview())
        ..on(_settings, 200, MessagesFixtures.settingRow());
    });
    backend.http.on(
      _index,
      200,
      MessagesFixtures.overview(birthdayEnabled: false),
    );

    final error = await controller.setEnabled('birthday', enabled: false);

    expect(error, isNull);
    expect(backend.http.requestsTo(_settings).single.body, {
      'key': 'birthday',
      'enabled': false,
    });
    expect(current().autoSettings.first.enabled, isFalse);
  });

  test('teksten bewaren stuurt beide templates', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, MessagesFixtures.overview())
        ..on(_settings, 200, MessagesFixtures.settingRow(enabled: true));
    });

    final error = await controller.saveTemplates(
      'birthday',
      title: 'Hoera {name}',
      body: '',
    );

    expect(error, isNull);
    expect(backend.http.requestsTo(_settings).single.body, {
      'key': 'birthday',
      'title_template': 'Hoera {name}',
      'body_template': null,
    });
  });
}
