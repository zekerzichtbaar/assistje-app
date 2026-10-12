import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/agreements/application/agreements_controller.dart';
import 'package:assistje/features/agreements/data/agreements_repository.dart';
import 'package:assistje/features/agreements/data/models/agreements_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'agreements_fixtures.dart';

const _index = 'GET /teams/3/agreements';

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<AgreementsController> start(
    void Function(FakeHttpAdapter http) setup,
  ) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(agreementsControllerProvider(3), (_, _) {});
    await container.read(agreementsControllerProvider(3).future);
    return container.read(agreementsControllerProvider(3).notifier);
  }

  AgreementsOverview current() =>
      container.read(agreementsControllerProvider(3)).requireValue;

  int indexCalls() => backend.http.requestsTo(_index).length;

  test('laadt de afspraken', () async {
    await start((http) => http.on(_index, 200, AgreementsFixtures.overview()));
    expect(current().groups, hasLength(2));
  });

  test('laadfout komt als AsyncError', () async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http.on(_index, 404, {'message': 'Niet gevonden.'});
    container = backend.container();
    addTearDown(container.dispose);
    container.listen(agreementsControllerProvider(3), (_, _) {});
    await expectLater(
      container.read(agreementsControllerProvider(3).future),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('toevoegen ververst de lijst', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, AgreementsFixtures.overview(canManage: true))
        ..on('POST /teams/3/agreements', 201, AgreementsFixtures.saved());
    });

    final before = indexCalls();
    final error = await controller.createAgreement(
      const AgreementDraft(category: 'training', title: 'Ballen opruimen'),
    );

    expect(error, isNull);
    expect(indexCalls(), before + 1);
  });

  test('mislukte write geeft de fout terug en ververst niet', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, AgreementsFixtures.overview(canManage: true))
        ..on('PATCH /teams/3/agreements/intro', 403, {
          'message': 'Geen toegang.',
        });
    });

    final before = indexCalls();
    final error = await controller.updateIntro('Nieuw');

    expect(error, isA<ForbiddenException>());
    expect(indexCalls(), before);
    expect(current().intro, 'Zo doen we het bij Vogels 3.');
  });

  test('verversen met fout houdt de data', () async {
    final controller = await start(
      (http) => http.on(_index, 200, AgreementsFixtures.overview()),
    );
    backend.http.on(_index, 500, {'message': 'Kapot.'});

    final error = await controller.refresh();

    expect(error, isA<ServerException>());
    expect(current().groups, hasLength(2));
  });

  test('wijzigen en verwijderen', () async {
    final controller = await start((http) {
      http
        ..on(_index, 200, AgreementsFixtures.overview(canManage: true))
        ..on('PATCH /teams/3/agreements/1', 200, AgreementsFixtures.saved())
        ..on('DELETE /teams/3/agreements/1', 204);
    });

    final before = indexCalls();
    expect(
      await controller.updateAgreement(
        1,
        const AgreementDraft(category: 'match', title: 'Op tijd'),
      ),
      isNull,
    );
    expect(await controller.deleteAgreement(1), isNull);
    expect(indexCalls(), before + 2);
  });
}
