import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/feedback/application/feedback_controller.dart';
import 'package:assistje/features/feedback/data/feedback_repository.dart';
import 'package:assistje/features/feedback/data/models/feedback_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'feedback_fixtures.dart';

const _index = 'GET /teams/3/feedback';
const _store = 'POST /teams/3/feedback';
const _respond = 'POST /teams/3/feedback/88/responses';

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<void> boot(void Function(FakeHttpAdapter http) setup) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(feedbackControllerProvider(3), (_, _) {});
  }

  Future<FeedbackController> start(
    void Function(FakeHttpAdapter http) setup,
  ) async {
    await boot(setup);
    await container.read(feedbackControllerProvider(3).future);
    return container.read(feedbackControllerProvider(3).notifier);
  }

  List<FeedbackItem> current() =>
      container.read(feedbackControllerProvider(3)).requireValue;

  test('laadt de meldingen', () async {
    await start((http) => http.on(_index, 200, FeedbackFixtures.list()));
    expect(current().map((i) => i.id), [88, 87]);
  });

  test('laadfout komt als AsyncError', () async {
    await boot((http) => http.on(_index, 500, {'message': 'Kapot.'}));
    await expectLater(
      container.read(feedbackControllerProvider(3).future),
      throwsA(isA<ServerException>()),
    );
  });

  test('insturen zet de nieuwe melding bovenaan zonder te herladen', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, FeedbackFixtures.list())
        ..on(_store, 201, FeedbackFixtures.created());
    });

    final loads = backend.http.requestsTo(_index).length;
    final error = await controller.submit(
      const FeedbackDraft(body: 'Het rooster laadt niet'),
    );

    expect(error, isNull);
    expect(current().map((i) => i.id), [89, 88, 87]);
    expect(backend.http.requestsTo(_index), hasLength(loads));
  });

  test('insturen op een lege lijst', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, FeedbackFixtures.list(empty: true))
        ..on(_store, 201, FeedbackFixtures.created());
    });
    await controller.submit(const FeedbackDraft(body: 'Eerste'));
    expect(current().single.id, 89);
  });

  test('insturen geeft 422/429 terug en laat de lijst staan', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, FeedbackFixtures.list())
        ..on(_store, 422, {
          'message': 'Ongeldig.',
          'errors': {
            'body': ['Minimaal 3 tekens.'],
          },
        });
    });

    expect(
      await controller.submit(const FeedbackDraft(body: 'ab')),
      isA<ValidationException>(),
    );
    backend.http.on(_store, 429, {'message': 'Too Many Attempts.'});
    expect(
      await controller.submit(const FeedbackDraft(body: 'abc')),
      isA<ThrottledException>(),
    );
    expect(current().map((i) => i.id), [88, 87]);
  });

  test('reageren vervangt de melding op zijn plek', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, FeedbackFixtures.list())
        ..on(_respond, 201, FeedbackFixtures.responded('Nog steeds.'));
    });

    final error = await controller.respond(88, 'Nog steeds.');

    expect(error, isNull);
    expect(current().map((i) => i.id), [88, 87]);
    expect(current().first.messages.last.body, 'Nog steeds.');
  });

  test('reageren met fout geeft de fout terug', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, FeedbackFixtures.list())
        ..on(_respond, 403, {'message': 'Niet jouw melding.'});
    });
    expect(await controller.respond(88, 'Hoi'), isA<ForbiddenException>());
    expect(current().first.messages, hasLength(2));
  });

  test('refresh houdt data bij een fout', () async {
    final controller = await start(
      (http) => http.on(_index, 200, FeedbackFixtures.list()),
    );
    backend.http.on(_index, 500, {'message': 'Kapot.'});
    expect(await controller.refresh(), isA<ServerException>());
    expect(current(), hasLength(2));
  });
}
