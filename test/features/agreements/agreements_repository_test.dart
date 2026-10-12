import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/agreements/data/agreements_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'agreements_fixtures.dart';

void main() {
  late FakeHttpAdapter http;
  late AgreementsRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = AgreementsRepository(
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

  test('leest groepen, intro, categorieën en can_manage', () async {
    http.on('GET /teams/3/agreements', 200, AgreementsFixtures.overview());

    final overview = await repository.fetch(3);

    expect(overview.groups.map((g) => g.key), ['training', 'money']);
    expect(overview.groups.first.label, 'Trainingen');
    expect(overview.groups.first.items.map((a) => a.id), [3, 1]);
    expect(overview.groups.first.items.last.body, 'Omgekleed op het veld.');
    expect(overview.groups.first.items.first.body, isNull);
    expect(overview.intro, 'Zo doen we het bij Vogels 3.');
    expect(overview.introText, 'Zo doen we het bij Vogels 3.');
    expect(overview.categories, hasLength(8));
    expect(overview.categories.last.key, 'other');
    expect(overview.canManage, isFalse);
    expect(overview.isEmpty, isFalse);
  });

  test('lege lijst en lege intro', () async {
    http.on(
      'GET /teams/3/agreements',
      200,
      AgreementsFixtures.overview(empty: true, intro: '  '),
    );
    final overview = await repository.fetch(3);
    expect(overview.isEmpty, isTrue);
    expect(overview.introText, isNull);
  });

  test('POST stuurt alle velden, lege body als null', () async {
    http.on('POST /teams/3/agreements', 201, AgreementsFixtures.saved());

    final saved = await repository.create(
      3,
      const AgreementDraft(
        category: 'training',
        title: ' Ballen opruimen ',
        body: '   ',
      ),
    );

    expect(http.requests.single.body, {
      'category': 'training',
      'title': 'Ballen opruimen',
      'body': null,
    });
    expect(saved.id, 7);
    expect(saved.categoryLabel, 'Trainingen');
    expect(saved.sortOrder, 3);
  });

  test('PATCH en DELETE op de afspraak', () async {
    http
      ..on('PATCH /teams/3/agreements/7', 200, AgreementsFixtures.saved())
      ..on('DELETE /teams/3/agreements/7', 204);

    await repository.update(
      3,
      7,
      const AgreementDraft(category: 'money', title: 'X', body: 'Uitleg'),
    );
    await repository.delete(3, 7);

    expect(http.requests.first.body, {
      'category': 'money',
      'title': 'X',
      'body': 'Uitleg',
    });
    expect(http.requests.last.method, 'DELETE');
  });

  test('intro bijwerken geeft de opgeslagen tekst terug', () async {
    http.on('PATCH /teams/3/agreements/intro', 200, {
      'data': {'intro': null},
    });
    expect(await repository.updateIntro(3, '  '), isNull);
    expect(http.requests.single.body, {'intro': ''});
  });

  test('422 en 403 komen als ApiException', () async {
    http
      ..on('POST /teams/3/agreements', 422, {
        'message': 'Vul een titel in.',
        'errors': {
          'title': ['Vul een titel in.'],
        },
      })
      ..on('DELETE /teams/3/agreements/1', 403, {'message': 'Geen toegang.'});

    await expectLater(
      repository.create(3, const AgreementDraft(category: 'x', title: '')),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.fieldError('title'),
          'title',
          'Vul een titel in.',
        ),
      ),
    );
    await expectLater(
      repository.delete(3, 1),
      throwsA(isA<ForbiddenException>()),
    );
  });
}
