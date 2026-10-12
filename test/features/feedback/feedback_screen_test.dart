import 'dart:typed_data';

import 'package:assistje/app.dart';
import 'package:assistje/core/router/app_router.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/features/feedback/data/feedback_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';
import '../../helpers/pump.dart';
import '../../helpers/shell.dart';
import '../../helpers/test_app.dart';
import 'feedback_fixtures.dart';

const _index = 'GET /teams/3/feedback';
const _store = 'POST /teams/3/feedback';
const _respond = 'POST /teams/3/feedback/88/responses';

/// Geeft wat de test klaarzet terug, zonder de plugin te raken.
class FakeFeedbackImagePicker implements FeedbackImagePicker {
  PickedFeedbackImage? next;
  int calls = 0;

  @override
  Future<PickedFeedbackImage?> pick() async {
    calls++;
    return next;
  }
}

/// Zoals `pumpSignedIn`, maar met een nep-[FeedbackImagePicker], en meteen op
/// `/feedback`.
Future<(FakeHttpAdapter, FakeFeedbackImagePicker)> _open(
  WidgetTester tester, {
  Map<String, dynamic>? list,
  String role = 'player',
  void Function(FakeHttpAdapter http)? setup,
}) async {
  tester.view
    ..physicalSize = const Size(1800, 4200)
    ..devicePixelRatio = 3;
  addTearDown(tester.view.reset);
  final backend = TestBackend(token: '12|abc');
  await backend.init();
  backend.http
    ..on(
      'GET /me',
      200,
      ApiFixtures.meResponse(teams: [ApiFixtures.membership(role: role)]),
    )
    ..on('GET /teams/3/agenda', 200, ApiFixtures.emptyAgendaResponse())
    ..on(_index, 200, list ?? FeedbackFixtures.list());
  setup?.call(backend.http);
  final picker = FakeFeedbackImagePicker();
  final container = ProviderContainer(
    overrides: [
      ...backend.overrides,
      feedbackImagePickerProvider.overrideWithValue(picker),
    ],
    retry: (_, _) => null,
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const AssistjeApp()),
  );
  await pumpUntilFound(tester, find.byKey(const Key('glass-tab-bar')));
  container.read(routerProvider).go(AppRoutes.feedback);
  await pumpUntilFound(tester, find.byKey(const ValueKey('feedback-screen')));
  await tester.pumpAndSettle();
  return (backend.http, picker);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _openSheet(WidgetTester tester) =>
    _tap(tester, find.byKey(const ValueKey('feedback-create')));

Future<void> _enterBody(WidgetTester tester, String text) async {
  await tester.enterText(
    find.byKey(const ValueKey('feedback-compose-body')),
    text,
  );
  await tester.pumpAndSettle();
}

/// Laat een eventuele toast uitlopen (geen hangende timers).
Future<void> _drainToast(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('toont meldingen met status, gesprek en afbeelding-placeholder '
      '(ook voor toeschouwers)', (tester) async {
    final (http, _) = await _open(tester, role: 'spectator');

    expect(currentTitle(tester), 'Feedback');
    expect(
      find.text("De knop 'Aanwezig' doet niks op mijn telefoon"),
      findsOneWidget,
    );
    expect(find.text('Opgepakt'), findsOneWidget);
    expect(find.text('Opgelost'), findsOneWidget);
    expect(find.text('Donkere modus graag!'), findsOneWidget);
    expect(find.text('Welke telefoon heb je?'), findsOneWidget);
    expect(find.text('Een Pixel 8.'), findsOneWidget);
    expect(find.text('ANTWOORD'), findsOneWidget);
    expect(find.text('JOUW REACTIE'), findsOneWidget);
    // Reageren alleen waar al geantwoord is.
    expect(find.byKey(const ValueKey('feedback-reply-88')), findsOneWidget);
    expect(find.byKey(const ValueKey('feedback-reply-87')), findsNothing);
    // De afbeelding wordt met het token opgehaald; 404 → placeholder.
    expect(
      find.byKey(const ValueKey('feedback-image-placeholder-88')),
      findsOneWidget,
    );
    final image = http.requestsTo('GET /teams/3/feedback/88/image').single;
    expect(image.authorization, 'Bearer 12|abc');
  });

  testWidgets('lege lijst', (tester) async {
    await _open(tester, list: FeedbackFixtures.list(empty: true));
    expect(find.byKey(const ValueKey('feedback-empty')), findsOneWidget);
    expect(find.byKey(const ValueKey('feedback-list')), findsNothing);
    expect(find.byKey(const ValueKey('feedback-create')), findsOneWidget);
  });

  testWidgets('laadfout met opnieuw proberen', (tester) async {
    final (http, _) = await _open(
      tester,
      setup: (http) => http.on(_index, 500, {'message': 'Kapot.'}),
    );
    expect(find.byKey(const ValueKey('feedback-error')), findsOneWidget);

    http.on(_index, 200, FeedbackFixtures.list());
    await _tap(tester, find.byKey(const ValueKey('feedback-retry')));
    expect(find.text('Donkere modus graag!'), findsOneWidget);
  });

  testWidgets('melding insturen met etiket', (tester) async {
    final (http, _) = await _open(
      tester,
      setup: (http) => http.on(_store, 201, FeedbackFixtures.created()),
    );

    await _openSheet(tester);
    expect(find.text('Wat is er?'), findsOneWidget);
    // Te kort: versturen staat uit.
    await _enterBody(tester, 'ab');
    await _tap(tester, find.byKey(const ValueKey('feedback-compose-send')));
    expect(http.requestsTo(_store), isEmpty);

    await _tap(tester, find.byKey(const ValueKey('feedback-kind-issue')));
    await _enterBody(tester, 'Het rooster laadt niet');
    await _tap(tester, find.byKey(const ValueKey('feedback-compose-send')));

    expect(http.requestsTo(_store).single.body, {
      'body': 'Het rooster laadt niet',
      'kind': 'issue',
    });
    expect(find.text('Wat is er?'), findsNothing);
    expect(find.text('Bedankt! Je melding staat erin.'), findsOneWidget);
    expect(find.byKey(const ValueKey('feedback-item-89')), findsOneWidget);
    await _drainToast(tester);
  });

  testWidgets('422 toont de veldfout in de sheet', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_store, 422, {
        'message': 'Ongeldig.',
        'errors': {
          'body': ['Je melding is te lang.'],
        },
      }),
    );

    await _openSheet(tester);
    await _enterBody(tester, 'Iets te veel tekst');
    await _tap(tester, find.byKey(const ValueKey('feedback-compose-send')));

    expect(find.text('Je melding is te lang.'), findsOneWidget);
    expect(find.text('Wat is er?'), findsOneWidget);
    expect(find.byKey(const ValueKey('feedback-compose-error')), findsNothing);
  });

  testWidgets('429 toont de wacht-melding', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_store, 429, {'message': 'Too Many Attempts.'}),
    );

    await _openSheet(tester);
    await _enterBody(tester, 'Nog een melding');
    await _tap(tester, find.byKey(const ValueKey('feedback-compose-send')));

    expect(
      find.byKey(const ValueKey('feedback-compose-error')),
      findsOneWidget,
    );
    expect(find.textContaining('Wacht een minuutje'), findsOneWidget);
  });

  testWidgets('afbeelding kiezen: HEIC geweigerd, PNG voorbeeld en weghalen', (
    tester,
  ) async {
    final (_, picker) = await _open(tester);
    await _openSheet(tester);

    picker.next = PickedFeedbackImage(
      bytes: Uint8List(8),
      mimeType: 'image/heic',
      name: 'IMG_1.heic',
    );
    await _tap(tester, find.byKey(const ValueKey('feedback-add-image')));
    expect(find.text('Kies een PNG, JPEG of WebP.'), findsOneWidget);
    expect(find.byKey(const ValueKey('feedback-image-preview')), findsNothing);

    picker.next = PickedFeedbackImage(
      bytes: Uint8List(PickedFeedbackImage.maxBytes + 1),
      mimeType: 'image/png',
      name: 'groot.png',
    );
    await _tap(tester, find.byKey(const ValueKey('feedback-add-image')));
    expect(
      find.text('Deze afbeelding is groter dan 5 MB. Kies een kleinere.'),
      findsOneWidget,
    );

    picker.next = PickedFeedbackImage(
      bytes: Uint8List(8),
      mimeType: 'image/png',
      name: 'scherm.png',
    );
    await _tap(tester, find.byKey(const ValueKey('feedback-add-image')));
    expect(
      find.byKey(const ValueKey('feedback-image-preview')),
      findsOneWidget,
    );
    expect(find.text('scherm.png'), findsOneWidget);
    expect(find.byKey(const ValueKey('feedback-image-error')), findsNothing);

    await _tap(tester, find.byKey(const ValueKey('feedback-remove-image')));
    expect(find.byKey(const ValueKey('feedback-image-preview')), findsNothing);
    expect(find.byKey(const ValueKey('feedback-add-image')), findsOneWidget);
    expect(picker.calls, 3);
  });

  testWidgets('reageren op een antwoord', (tester) async {
    final (http, _) = await _open(
      tester,
      setup: (http) =>
          http.on(_respond, 201, FeedbackFixtures.responded('Nog steeds.')),
    );

    await _tap(tester, find.byKey(const ValueKey('feedback-reply-88')));
    await tester.enterText(
      find.byKey(const ValueKey('feedback-reply-body-88')),
      'Nog steeds.',
    );
    await tester.pumpAndSettle();
    await _tap(tester, find.byKey(const ValueKey('feedback-reply-send-88')));

    expect(http.requestsTo(_respond).single.body, {'body': 'Nog steeds.'});
    expect(find.text('Nog steeds.'), findsOneWidget);
    expect(find.byKey(const ValueKey('feedback-reply-body-88')), findsNothing);
    expect(find.text('Je reactie is verstuurd.'), findsOneWidget);
    await _drainToast(tester);
  });

  testWidgets('reageren met 422 toont de veldfout', (tester) async {
    await _open(
      tester,
      setup: (http) => http.on(_respond, 422, {
        'message': 'Ongeldig.',
        'errors': {
          'body': ['Er is nog niet geantwoord.'],
        },
      }),
    );

    await _tap(tester, find.byKey(const ValueKey('feedback-reply-88')));
    await tester.enterText(
      find.byKey(const ValueKey('feedback-reply-body-88')),
      'Hallo?',
    );
    await tester.pumpAndSettle();
    await _tap(tester, find.byKey(const ValueKey('feedback-reply-send-88')));

    expect(find.text('Er is nog niet geantwoord.'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('feedback-reply-body-88')),
      findsOneWidget,
    );
  });
}
