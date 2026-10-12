import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:assistje/features/onboarding/application/onboarding_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/test_app.dart';
import 'onboarding_fixtures.dart';

const _show = 'GET /teams/3/onboarding';
const _complete = 'POST /teams/3/onboarding/complete';

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  Future<OnboardingController> start(
    void Function(FakeHttpAdapter http) setup,
  ) async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    backend.http.on(
      'GET /me',
      200,
      ApiFixtures.meResponse(
        teams: [ApiFixtures.membership(role: 'trainer', onboardingOpen: true)],
      ),
    );
    setup(backend.http);
    container = backend.container();
    addTearDown(container.dispose);
    container
      ..listen(onboardingControllerProvider(3), (_, _) {})
      ..listen(meProvider, (_, _) {});
    await container.read(meProvider.future);
    await container.read(onboardingControllerProvider(3).future);
    return container.read(onboardingControllerProvider(3).notifier);
  }

  test('laadt de checklist', () async {
    await start((http) => http.on(_show, 200, OnboardingFixtures.checklist()));
    final value = container.read(onboardingControllerProvider(3)).requireValue;
    expect(value.steps, hasLength(3));
    expect(value.left, 1);
  });

  test('complete zet de nieuwe stand en haalt /me opnieuw op', () async {
    final controller = await start((http) {
      http
        ..on(_show, 200, OnboardingFixtures.checklist())
        ..on(_complete, 200, OnboardingFixtures.completed());
    });
    final meLoads = backend.http.requestsTo('GET /me').length;

    final error = await controller.complete();

    expect(error, isNull);
    final value = container.read(onboardingControllerProvider(3)).requireValue;
    expect(value.team.needsOnboarding, isFalse);
    await container.read(meProvider.future);
    expect(backend.http.requestsTo('GET /me').length, meLoads + 1);
  });

  test('complete geeft de fout terug (demo 403) en laat /me staan', () async {
    final controller = await start((http) {
      http
        ..on(_show, 200, OnboardingFixtures.checklist())
        ..on(_complete, 403, {'message': 'Dit is een demo.'});
    });
    final meLoads = backend.http.requestsTo('GET /me').length;

    final error = await controller.complete();

    expect(error, isA<ForbiddenException>());
    expect(
      container.read(onboardingControllerProvider(3)).requireValue.allDone,
      isFalse,
    );
    expect(backend.http.requestsTo('GET /me').length, meLoads);
  });

  test('refresh houdt data vast bij een fout', () async {
    final controller = await start(
      (http) => http.on(_show, 200, OnboardingFixtures.checklist()),
    );
    backend.http.on(_show, 500, {'message': 'Kapot.'});
    final error = await controller.refresh();
    expect(error, isA<ServerException>());
    expect(container.read(onboardingControllerProvider(3)).hasValue, isTrue);
  });
}
