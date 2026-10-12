import 'dart:typed_data';

import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/api/api_exception.dart';
import 'package:assistje/features/feedback/data/feedback_image_picker.dart';
import 'package:assistje/features/feedback/data/feedback_repository.dart';
import 'package:assistje/features/feedback/data/models/feedback_models.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'feedback_fixtures.dart';

Dio _dio(HttpClientAdapter adapter) => buildApiDio(
  baseUrl: 'https://assistje.test/api/v1',
  readToken: () async => '12|abc',
  onUnauthorized: () {},
  adapter: adapter,
);

FeedbackRepository _repository(HttpClientAdapter adapter) {
  final dio = _dio(adapter);
  return FeedbackRepository(ApiClient(dio), dio);
}

void main() {
  late FakeHttpAdapter http;
  late FeedbackRepository repository;

  setUp(() {
    http = FakeHttpAdapter();
    repository = _repository(http);
  });

  test('GET leest meldingen met gesprek, status en afbeelding', () async {
    http.on('GET /teams/3/feedback', 200, FeedbackFixtures.list());

    final items = await repository.fetch(3);

    expect(items, hasLength(2));
    final first = items.first;
    expect(first.id, 88);
    expect(first.kindValue, FeedbackKind.issue);
    expect(first.statusValue, FeedbackStatus.inProgress);
    expect(
      first.image,
      'https://assistje.test/api/v1/teams/3/feedback/88/image',
    );
    expect(first.messages.map((m) => m.isMine), [false, true]);
    expect(first.canReply, isTrue);
    expect(first.createdAtTime, DateTime.utc(2026, 10, 9, 11, 45).toLocal());
    expect(first.resolvedAtTime, isNull);

    final idea = items.last;
    expect(idea.kindValue, FeedbackKind.idea);
    expect(idea.statusValue, FeedbackStatus.resolved);
    expect(idea.image, isNull);
    expect(idea.canReply, isFalse);
    expect(idea.resolvedAtTime, DateTime.utc(2026, 10, 5, 7).toLocal());
  });

  test('onbekende kind/status en kapotte items worden mild gelezen', () async {
    http.on('GET /teams/3/feedback', 200, {
      'data': [
        {'id': 1, 'kind': null, 'status': 'raar', 'body': 'x'},
        {'kind': 'issue'},
        'onzin',
        {'id': 2, 'kind': 'schedule', 'image_url': '  '},
      ],
    });

    final items = await repository.fetch(3);

    expect(items.map((i) => i.id), [1, 2]);
    expect(items.first.kindValue, FeedbackKind.none);
    expect(items.first.statusValue, FeedbackStatus.received);
    expect(items.first.messages, isEmpty);
    expect(items.last.kindValue, FeedbackKind.schedule);
    expect(items.last.image, isNull);
  });

  test('POST zonder afbeelding gaat als JSON met getrimde body', () async {
    http.on('POST /teams/3/feedback', 201, FeedbackFixtures.created());

    final item = await repository.submit(
      3,
      const FeedbackDraft(
        body: '  Het rooster laadt niet ',
        kind: FeedbackKind.issue,
      ),
    );

    expect(http.requests.single.body, {
      'body': 'Het rooster laadt niet',
      'kind': 'issue',
    });
    expect(item.id, 89);
    expect(item.statusValue, FeedbackStatus.received);

    await repository.submit(3, const FeedbackDraft(body: 'Zonder etiket'));
    expect(http.requests.last.body, {'body': 'Zonder etiket'});
  });

  test('POST met afbeelding gaat als multipart met veld image', () async {
    final raw = RawAdapter(status: 201, json: FeedbackFixtures.created());
    final repository = _repository(raw);

    await repository.submit(
      3,
      FeedbackDraft(
        body: 'Kijk maar',
        kind: FeedbackKind.idea,
        image: PickedFeedbackImage(
          bytes: Uint8List.fromList('PNGDATA'.codeUnits),
          mimeType: 'image/png',
          name: 'scherm.png',
        ),
      ),
    );

    expect(raw.options?.method, 'POST');
    expect(raw.options?.uri.path, '/api/v1/teams/3/feedback');
    expect(
      raw.options?.headers['content-type'] ?? raw.options?.contentType,
      startsWith('multipart/form-data'),
    );
    expect(raw.options?.headers['Authorization'], 'Bearer 12|abc');
    expect(raw.body, contains('name="body"'));
    expect(raw.body, contains('Kijk maar'));
    expect(raw.body, contains('name="kind"'));
    expect(raw.body, contains('idea'));
    expect(raw.body, contains('name="image"; filename="scherm.png"'));
    expect(raw.body, contains('content-type: image/png'));
    expect(raw.body, contains('PNGDATA'));
  });

  test('POST 422 geeft veldfouten, 429 een ThrottledException', () async {
    http.on('POST /teams/3/feedback', 422, {
      'message': 'Ongeldig.',
      'errors': {
        'image': ['De afbeelding mag niet groter zijn dan 5 MB.'],
      },
    });
    await expectLater(
      repository.submit(3, const FeedbackDraft(body: 'Hallo')),
      throwsA(
        isA<ValidationException>().having(
          (e) => e.fieldError('image'),
          'image',
          'De afbeelding mag niet groter zijn dan 5 MB.',
        ),
      ),
    );

    http.on('POST /teams/3/feedback', 429, {'message': 'Too Many Attempts.'});
    await expectLater(
      repository.submit(3, const FeedbackDraft(body: 'Hallo')),
      throwsA(isA<ThrottledException>()),
    );
  });

  test('POST responses stuurt de reactie en geeft de melding terug', () async {
    http.on(
      'POST /teams/3/feedback/88/responses',
      201,
      FeedbackFixtures.responded('Nog steeds kapot.'),
    );

    final item = await repository.respond(3, 88, ' Nog steeds kapot. ');

    expect(http.requests.single.body, {'body': 'Nog steeds kapot.'});
    expect(item.messages.last.body, 'Nog steeds kapot.');
    expect(item.messages.last.isMine, isTrue);
  });

  test('POST responses vóór een antwoord: 422', () async {
    http.on('POST /teams/3/feedback/89/responses', 422, {
      'message': 'Er is nog niet geantwoord.',
      'errors': {
        'body': ['Er is nog niet geantwoord.'],
      },
    });
    await expectLater(
      repository.respond(3, 89, 'Hallo?'),
      throwsA(isA<ValidationException>()),
    );
  });

  test('GET image haalt de bytes op met het bearer-token', () async {
    final png = [0x89, 0x50, 0x4E, 0x47, 1, 2, 3];
    final raw = RawAdapter(bytes: png);
    final repository = _repository(raw);

    final bytes = await repository.image(
      'https://assistje.test/api/v1/teams/3/feedback/88/image',
    );

    expect(bytes, png);
    expect(raw.options?.method, 'GET');
    expect(
      raw.options?.uri.toString(),
      'https://assistje.test/api/v1/teams/3/feedback/88/image',
    );
    expect(raw.options?.headers['Authorization'], 'Bearer 12|abc');
    expect(raw.options?.responseType, ResponseType.bytes);
  });

  test('GET image 404/403 wordt een ApiException', () async {
    await expectLater(
      _repository(
        RawAdapter(status: 404, json: {'message': 'Not found.'}),
      ).image('https://assistje.test/api/v1/teams/3/feedback/88/image'),
      throwsA(isA<NotFoundException>()),
    );
    await expectLater(
      _repository(
        RawAdapter(status: 403, json: {'message': 'Nee.'}),
      ).image('https://assistje.test/api/v1/teams/3/feedback/88/image'),
      throwsA(isA<ForbiddenException>()),
    );
  });

  group('ImagePickerFeedbackImagePicker', () {
    test('mimeTypeFor valt terug op extensie, dan JPEG', () {
      expect(
        ImagePickerFeedbackImagePicker.mimeTypeFor('image/webp', 'a'),
        'image/webp',
      );
      expect(
        ImagePickerFeedbackImagePicker.mimeTypeFor(null, 'a.PNG'),
        'image/png',
      );
      expect(
        ImagePickerFeedbackImagePicker.mimeTypeFor(null, 'a.heic'),
        'image/heic',
      );
      expect(
        ImagePickerFeedbackImagePicker.mimeTypeFor(null, 'a'),
        'image/jpeg',
      );
    });

    test('fileNameFor laat de extensie bij het type passen', () {
      expect(
        ImagePickerFeedbackImagePicker.fileNameFor('IMG_1.HEIC', 'image/jpeg'),
        'IMG_1.jpg',
      );
      expect(
        ImagePickerFeedbackImagePicker.fileNameFor('foto.jpeg', 'image/jpeg'),
        'foto.jpeg',
      );
      expect(
        ImagePickerFeedbackImagePicker.fileNameFor('', 'image/png'),
        'schermafbeelding.png',
      );
    });

    test('PickedFeedbackImage controleert type en 5 MB', () {
      final ok = PickedFeedbackImage(
        bytes: Uint8List(10),
        mimeType: 'image/jpeg',
        name: 'a.jpg',
      );
      expect(ok.hasAllowedType, isTrue);
      expect(ok.isTooLarge, isFalse);
      final heic = PickedFeedbackImage(
        bytes: Uint8List(10),
        mimeType: 'image/heic',
        name: 'a.heic',
      );
      expect(heic.hasAllowedType, isFalse);
      final big = PickedFeedbackImage(
        bytes: Uint8List(PickedFeedbackImage.maxBytes + 1),
        mimeType: 'image/png',
        name: 'a.png',
      );
      expect(big.isTooLarge, isTrue);
    });
  });
}
