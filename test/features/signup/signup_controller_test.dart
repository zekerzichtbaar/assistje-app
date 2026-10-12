import 'package:assistje/features/signup/application/signup_controller.dart';
import 'package:assistje/features/signup/data/models/signup_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';
import 'signup_fixtures.dart';

void main() {
  late TestBackend backend;
  late ProviderContainer container;

  setUp(() async {
    backend = TestBackend();
    await backend.init();
    container = backend.container();
    addTearDown(container.dispose);
  });

  group('stappen', () {
    final options = SignupOptions.fromJson(
      SignupFixtures.options()['data'] as Map<String, dynamic>,
    );

    test('zonder sport uit de link: begin bij de sportkeuze', () {
      expect(signupSteps(sportFromLink: false, chosen: null), [
        SignupStep.sport,
        SignupStep.club,
        SignupStep.team,
        SignupStep.you,
        SignupStep.trainings,
      ]);
    });

    test('sport uit de link: geen sportstap; feed-sport: programmastap', () {
      expect(
        signupSteps(
          sportFromLink: true,
          chosen: options.sportFor('volleyball'),
        ),
        [
          SignupStep.club,
          SignupStep.team,
          SignupStep.you,
          SignupStep.trainings,
          SignupStep.programme,
        ],
      );
      // `paste` (voetbal) en geen import (hockey): geen programmastap.
      for (final sport in ['football', 'hockey']) {
        expect(
          signupSteps(sportFromLink: true, chosen: options.sportFor(sport)),
          isNot(contains(SignupStep.programme)),
          reason: sport,
        );
      }
    });

    test('veldfout → stap', () {
      expect(signupStepOf('sport'), SignupStep.sport);
      expect(signupStepOf('club_id'), SignupStep.club);
      expect(signupStepOf('club_name'), SignupStep.club);
      expect(signupStepOf('logo'), SignupStep.club);
      expect(signupStepOf('designation'), SignupStep.team);
      expect(signupStepOf('duplicate'), SignupStep.team);
      expect(signupStepOf('email'), SignupStep.you);
      expect(signupStepOf('trainings.1.ends_at'), SignupStep.trainings);
      expect(signupStepOf('schedule_feed_url'), SignupStep.programme);
      expect(signupStepOf('iets'), isNull);
    });

    test('training achterstevoren', () {
      expect(const SignupTraining(weekday: 1).isBackwards, isFalse);
      expect(
        const SignupTraining(
          weekday: 1,
          startsAt: '21:00',
          endsAt: '20:00',
        ).isBackwards,
        isTrue,
      );
      expect(
        const SignupTraining(
          weekday: 1,
          startsAt: '20:00',
          endsAt: '20:00',
        ).isBackwards,
        isTrue,
      );
    });
  });

  test('signupOptionsProvider laadt per sport uit de link', () async {
    backend.http.on(
      'GET /signup',
      200,
      SignupFixtures.options(sport: 'hockey'),
    );

    final options = await container.read(
      signupOptionsProvider('hockey').future,
    );

    expect(options.sport, 'hockey');
    expect(backend.http.requests.single.options.uri.queryParameters, {
      'sport': 'hockey',
    });
  });

  group('SignupFlow', () {
    test('findExisting: een fout leest als "nee"', () async {
      backend.http.on('GET /signup/existing', 500, {'message': 'Server Error'});
      expect(
        await container
            .read(signupFlowProvider)
            .findExisting(clubId: 412, sport: 'football', designation: '3'),
        isNull,
      );

      backend.http.on('GET /signup/existing', 200, SignupFixtures.existing());
      final found = await container
          .read(signupFlowProvider)
          .findExisting(clubId: 412, sport: 'football', designation: '3');
      expect(found?.name, 'Valleivogels 3');
    });

    test('requestLoginCode: auth/request met e-mail en teamslug', () async {
      backend.http.on('POST /auth/request', 202, {'message': 'ok'});
      final sent = SignupSent.fromJson(
        SignupFixtures.sent()['data'] as Map<String, dynamic>,
      );

      await container.read(signupFlowProvider).requestLoginCode(sent);

      expect(backend.http.requestsTo('POST /auth/request').single.body, {
        'email': 'patrick@example.com',
        'team': 'valleivogels-3',
      });
    });
  });
}
