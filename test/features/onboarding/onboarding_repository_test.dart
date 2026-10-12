import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/onboarding/data/models/onboarding_models.dart';
import 'package:assistje/features/onboarding/data/onboarding_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';
import 'onboarding_fixtures.dart';

void main() {
  late TestBackend backend;
  late OnboardingRepository repository;

  setUp(() async {
    backend = TestBackend(token: '12|abc');
    await backend.init();
    final container = backend.container();
    addTearDown(container.dispose);
    repository = OnboardingRepository(container.read(apiClientProvider));
  });

  test('fetch leest team, stappen, schedule_request en next_match', () async {
    backend.http.on(
      'GET /teams/3/onboarding',
      200,
      OnboardingFixtures.checklist(scheduleRequest: 'pending'),
    );
    final onboarding = await repository.fetch(3);

    expect(onboarding.team.name, 'Vogels 3');
    expect(onboarding.team.needsOnboarding, isTrue);
    expect(onboarding.team.onboardedAt, isNull);
    expect(onboarding.steps.map((s) => s.key), [
      'team',
      'schedule',
      'attendance',
    ]);
    expect(onboarding.steps.first.href, '/players');
    expect(onboarding.steps.first.cta, 'Naar de spelers');
    expect(onboarding.scheduleRequest, ScheduleRequestState.pending);
    expect(onboarding.nextMatch?.id, 412);
    expect(onboarding.nextMatch?.responded, 4);
    expect(onboarding.nextMatch?.roster, 14);
    expect(onboarding.nextMatch?.progress, closeTo(4 / 14, 0.0001));
    expect(onboarding.completed, 2);
    expect(onboarding.left, 1);
    expect(onboarding.currentIndex, 2);
    expect(onboarding.allDone, isFalse);
    expect(onboarding.stateOf(0), OnboardingStepState.done);
    expect(onboarding.stateOf(2), OnboardingStepState.current);
  });

  test('null-velden: geen aanbod en geen wedstrijd', () async {
    backend.http.on(
      'GET /teams/3/onboarding',
      200,
      OnboardingFixtures.checklist(
        teamDone: false,
        scheduleDone: false,
        withMatch: false,
      ),
    );
    final onboarding = await repository.fetch(3);
    expect(onboarding.scheduleRequest, ScheduleRequestState.none);
    expect(onboarding.nextMatch, isNull);
    expect(onboarding.stateOf(0), OnboardingStepState.current);
    expect(onboarding.stateOf(1), OnboardingStepState.upcoming);
    expect(onboarding.stateOf(2), OnboardingStepState.upcoming);
  });

  test('complete post zonder body en leest het nieuwe antwoord', () async {
    backend.http.on(
      'POST /teams/3/onboarding/complete',
      200,
      OnboardingFixtures.completed(),
    );
    final onboarding = await repository.complete(3);
    expect(onboarding.team.needsOnboarding, isFalse);
    expect(onboarding.team.onboardedAt, isNotNull);
    expect(onboarding.allDone, isTrue);
    final request = backend.http
        .requestsTo('POST /teams/3/onboarding/complete')
        .single;
    expect(request.body, isNull);
  });

  test('403 voor een niet-trainer', () async {
    backend.http.on(
      'GET /teams/3/onboarding',
      403,
      OnboardingFixtures.trainerOnly,
    );
    await expectLater(repository.fetch(3), throwsA(isA<ForbiddenException>()));
  });

  test('onverwacht antwoord', () async {
    backend.http.on('GET /teams/3/onboarding', 200, {'data': <Object>[]});
    await expectLater(repository.fetch(3), throwsA(isA<UnknownApiException>()));
  });
}
