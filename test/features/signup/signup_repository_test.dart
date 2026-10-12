import 'dart:convert';
import 'dart:typed_data';

import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/signup/data/models/signup_models.dart';
import 'package:assistje/features/signup/data/signup_logo_picker.dart';
import 'package:assistje/features/signup/data/signup_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/test_app.dart';
import 'signup_fixtures.dart';

/// Legt een multipart-verzoek ruw vast (de `FakeHttpAdapter` leest alleen
/// JSON).
class _RawAdapter implements HttpClientAdapter {
  RequestOptions? options;
  String body = '';

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    this.options = options;
    if (requestStream != null) {
      final bytes = await requestStream.expand((c) => c).toList();
      body = latin1.decode(bytes);
    }
    return ResponseBody.fromString(
      jsonEncode(SignupFixtures.sent()),
      202,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

const _draft = SignupDraft(
  sport: 'football',
  clubId: 412,
  clubName: 'Valleivogels',
  designation: ' 3 ',
  name: ' Patrick van Setten ',
  email: ' patrick@example.com ',
  trainings: [
    SignupTraining(weekday: 2, venue: 'Sportpark De Breehoek'),
    SignupTraining(weekday: 4, startsAt: '20:00', endsAt: '21:30'),
  ],
);

void main() {
  late TestBackend backend;
  late SignupRepository repository;

  setUp(() async {
    backend = TestBackend();
    await backend.init();
    final container = ProviderContainer(overrides: backend.overrides);
    addTearDown(container.dispose);
    repository = container.read(signupRepositoryProvider);
  });

  group('GET signup', () {
    test('sporten, deeplinksport en grenzen', () async {
      backend.http.on('GET /signup', 200, SignupFixtures.options());

      final options = await repository.fetchOptions();

      expect(backend.http.requests.single.options.uri.query, isEmpty);
      expect(options.sport, isNull);
      expect(options.sports.map((s) => s.value), [
        'football',
        'volleyball',
        'hockey',
      ]);
      final football = options.sportFor('football')!;
      expect(football.label, 'Voetbal');
      expect(football.designation.question, 'Welk elftal?');
      expect(football.designation.example, '3');
      expect(football.federationImport?.method, 'paste');
      expect(football.hasFeed, isFalse);
      expect(options.sportFor('volleyball')!.hasFeed, isTrue);
      expect(options.sportFor('hockey')!.federationImport, isNull);
      expect(options.limits.trainingsMax, 7);
      expect(options.limits.logoMaxKb, 2048);
      expect(options.limits.logoMimetypes, contains('image/svg+xml'));
      expect(options.limits.clubSearchMinChars, 2);
    });

    test('?sport= gaat mee (getrimd) en komt terug als sport', () async {
      backend.http.on(
        'GET /signup',
        200,
        SignupFixtures.options(sport: 'hockey'),
      );

      final options = await repository.fetchOptions(sport: ' hockey ');

      expect(backend.http.requests.single.options.uri.queryParameters, {
        'sport': 'hockey',
      });
      expect(options.sport, 'hockey');
    });

    test('429 → ThrottledException', () async {
      backend.http.on('GET /signup', 429, SignupFixtures.throttled());
      await expectLater(
        repository.fetchOptions(),
        throwsA(isA<ThrottledException>()),
      );
    });
  });

  group('GET signup/clubs', () {
    test('q + sport, treffers en meta.more', () async {
      backend.http.on('GET /signup/clubs', 200, SignupFixtures.clubs(more: 3));

      final results = await repository.searchClubs(' vogel ', 'football');

      expect(backend.http.requests.single.options.uri.queryParameters, {
        'q': 'vogel',
        'sport': 'football',
      });
      expect(results.more, 3);
      expect(results.clubs, const [
        SignupClub(id: 412, name: 'Valleivogels', place: 'Scherpenzeel'),
        SignupClub(id: 413, name: 'VV Vogelenzang'),
      ]);
    });

    test('lege lijst', () async {
      backend.http.on('GET /signup/clubs', 200, SignupFixtures.noClubs());
      final results = await repository.searchClubs('zz', 'football');
      expect(results.clubs, isEmpty);
      expect(results.more, 0);
    });
  });

  group('GET signup/existing', () {
    test('team gevonden', () async {
      backend.http.on('GET /signup/existing', 200, SignupFixtures.existing());

      final team = await repository.findExisting(
        clubId: 412,
        sport: 'football',
        designation: ' 3 ',
      );

      expect(backend.http.requests.single.options.uri.queryParameters, {
        'club_id': '412',
        'sport': 'football',
        'designation': '3',
      });
      expect(
        team,
        const SignupTeam(
          id: 31,
          name: 'Valleivogels 3',
          slug: 'valleivogels-3',
          sport: 'football',
          url: 'https://valleivogels-3.assistje.nl',
        ),
      );
    });

    test('team: null', () async {
      backend.http.on(
        'GET /signup/existing',
        200,
        SignupFixtures.existing(found: false),
      );
      expect(
        await repository.findExisting(
          clubId: 412,
          sport: 'football',
          designation: '3',
        ),
        isNull,
      );
    });
  });

  group('POST signup', () {
    test('JSON-body volgens de doc → 202 sent', () async {
      backend.http.on('POST /signup', 202, SignupFixtures.sent());

      final sent = await repository.submit(_draft);

      expect(backend.http.requestsTo('POST /signup').single.body, {
        'sport': 'football',
        'club_id': 412,
        'club_name': null,
        'designation': '3',
        'name': 'Patrick van Setten',
        'email': 'patrick@example.com',
        'trainings': [
          {
            'weekday': 2,
            'starts_at': '19:30',
            'ends_at': '21:00',
            'venue': 'Sportpark De Breehoek',
          },
          {
            'weekday': 4,
            'starts_at': '20:00',
            'ends_at': '21:30',
            'venue': null,
          },
        ],
        'schedule_feed_url': null,
        'duplicate_ok': false,
      });
      expect(sent.email, 'patrick@example.com');
      expect(sent.already, isFalse);
      expect(sent.team.slug, 'valleivogels-3');
      expect(sent.team.url, 'https://valleivogels-3.assistje.nl');
    });

    test('ingetypte club + feed + duplicate_ok; already: true', () async {
      backend.http.on('POST /signup', 202, SignupFixtures.sent(already: true));

      final sent = await repository.submit(
        const SignupDraft(
          sport: 'volleyball',
          clubName: ' HV De Proefclub ',
          designation: 'DS1',
          name: 'Patrick',
          email: 'patrick@example.com',
          trainings: [SignupTraining(weekday: 1)],
          scheduleFeedUrl: ' https://api.nevobo.nl/x.ics ',
          duplicateOk: true,
        ),
      );

      final body = backend.http.requestsTo('POST /signup').single.body! as Map;
      expect(body['club_id'], isNull);
      expect(body['club_name'], 'HV De Proefclub');
      expect(body['schedule_feed_url'], 'https://api.nevobo.nl/x.ics');
      expect(body['duplicate_ok'], isTrue);
      expect(sent.already, isTrue);
    });

    test('met logo → multipart (Laravel-velden + logo-bestand)', () async {
      final raw = _RawAdapter();
      final api = ApiClient(
        buildApiDio(
          baseUrl: 'https://assistje.test/api/v1',
          readToken: () async => null,
          onUnauthorized: () {},
          adapter: raw,
        ),
      );

      await SignupRepository(api).submit(
        SignupDraft(
          sport: 'football',
          clubName: 'HV De Proefclub',
          designation: '3',
          name: 'Patrick',
          email: 'patrick@example.com',
          trainings: const [SignupTraining(weekday: 2, venue: 'Veld 1')],
          logo: PickedSignupLogo(
            bytes: Uint8List.fromList('PNGDATA'.codeUnits),
            mimeType: 'image/png',
            name: 'logo.png',
          ),
        ),
      );

      expect(raw.options?.method, 'POST');
      expect(raw.options?.uri.path, '/api/v1/signup');
      expect(
        raw.options?.headers['content-type'] ?? raw.options?.contentType,
        startsWith('multipart/form-data'),
      );
      expect(raw.body, contains('name="club_name"'));
      expect(raw.body, contains('HV De Proefclub'));
      expect(raw.body, contains('name="trainings[0][weekday]"'));
      expect(raw.body, contains('name="trainings[0][starts_at]"'));
      expect(raw.body, contains('name="trainings[0][venue]"'));
      expect(raw.body, contains('name="duplicate_ok"'));
      expect(raw.body, isNot(contains('name="club_id"')));
      expect(raw.body, contains('name="logo"; filename="logo.png"'));
      expect(raw.body, contains('content-type: image/png'));
      expect(raw.body, contains('PNGDATA'));
    });

    test('422 per veld en errors.duplicate', () async {
      backend.http.on(
        'POST /signup',
        422,
        SignupFixtures.validation({
          'duplicate': [SignupFixtures.duplicateMessage],
          'trainings.0.ends_at': ['De eindtijd moet na de begintijd liggen.'],
        }),
      );
      await expectLater(
        repository.submit(_draft),
        throwsA(
          isA<ValidationException>()
              .having(
                (e) => e.fieldError('duplicate'),
                'duplicate',
                SignupFixtures.duplicateMessage,
              )
              .having(
                (e) => e.fieldError('trainings.0.ends_at'),
                'trainings',
                isNotNull,
              ),
        ),
      );
    });

    test('429 na 10 pogingen', () async {
      backend.http.on('POST /signup', 429, SignupFixtures.throttled());
      await expectLater(
        repository.submit(_draft),
        throwsA(isA<ThrottledException>()),
      );
    });
  });

  group('POST signup/other-sport', () {
    test('body getrimd → 202 requested', () async {
      backend.http.on(
        'POST /signup/other-sport',
        202,
        SignupFixtures.requested(),
      );

      final requested = await repository.requestOtherSport(
        sport: ' Handbal ',
        clubName: 'HV De Proefclub',
        name: 'Patrick van Setten',
        email: 'patrick@example.com ',
      );

      expect(backend.http.requestsTo('POST /signup/other-sport').single.body, {
        'sport': 'Handbal',
        'club_name': 'HV De Proefclub',
        'name': 'Patrick van Setten',
        'email': 'patrick@example.com',
      });
      expect(requested.sport, 'Handbal');
      expect(requested.email, 'patrick@example.com');
    });

    test('422 en 429', () async {
      backend.http.on(
        'POST /signup/other-sport',
        422,
        SignupFixtures.validation({
          'email': ['Vul een geldig e-mailadres in.'],
        }),
      );
      await expectLater(
        repository.requestOtherSport(
          sport: 'Handbal',
          clubName: 'X',
          name: 'P',
          email: 'nee',
        ),
        throwsA(
          isA<ValidationException>().having(
            (e) => e.fieldError('email'),
            'email',
            'Vul een geldig e-mailadres in.',
          ),
        ),
      );

      backend.http.on(
        'POST /signup/other-sport',
        429,
        SignupFixtures.throttled(),
      );
      await expectLater(
        repository.requestOtherSport(
          sport: 'Handbal',
          clubName: 'X',
          name: 'P',
          email: 'p@example.com',
        ),
        throwsA(isA<ThrottledException>()),
      );
    });
  });

  group('logo', () {
    test('fits: type en grootte', () {
      final png = PickedSignupLogo(
        bytes: Uint8List(1024),
        mimeType: 'image/png',
        name: 'a.png',
      );
      const types = ['image/png', 'image/jpeg'];
      expect(png.fits(mimetypes: types, maxKb: 1), isTrue);
      expect(png.fits(mimetypes: types, maxKb: 0), isFalse);
      expect(
        PickedSignupLogo(
          bytes: Uint8List(1),
          mimeType: 'image/heic',
          name: 'a.heic',
        ).fits(mimetypes: types, maxKb: 1),
        isFalse,
      );
    });

    test('MIME-type en bestandsnaam', () {
      expect(
        ImagePickerSignupLogoPicker.mimeTypeFor(null, 'x.PNG'),
        'image/png',
      );
      expect(ImagePickerSignupLogoPicker.mimeTypeFor(null, 'x'), 'image/jpeg');
      expect(
        ImagePickerSignupLogoPicker.fileNameFor('IMG_1.HEIC', 'image/jpeg'),
        'IMG_1.jpg',
      );
      expect(
        ImagePickerSignupLogoPicker.fileNameFor('', 'image/png'),
        'logo.png',
      );
    });
  });
}
