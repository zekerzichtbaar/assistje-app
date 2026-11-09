import 'package:assistje/core/session/models/team_membership.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:assistje/core/store/review_prompt.dart';
import 'package:assistje/core/store/store_links.dart';
import 'package:assistje/core/theme/theme_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/api_fixtures.dart';

class _FakeRequester implements ReviewRequester {
  bool available = true;
  int requests = 0;

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<void> requestReview() async => requests++;

  @override
  Future<void> openStoreListing() async {}
}

void main() {
  late _FakeRequester requester;
  late DateTime now;

  Future<ProviderContainer> make({
    bool demo = false,
    Map<String, Object> prefs = const {},
  }) async {
    SharedPreferences.setMockInitialValues(prefs);
    final instance = await SharedPreferences.getInstance();
    final json = ApiFixtures.membership(teamId: 1, name: 'JO11-1');
    (json['team'] as Map<String, dynamic>)['is_demo'] = demo;
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(instance),
        currentMembershipProvider.overrideWithValue(
          TeamMembership.fromJson(json),
        ),
        reviewRequesterProvider.overrideWithValue(requester),
        reviewClockProvider.overrideWithValue(() => now),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUp(() {
    requester = _FakeRequester();
    now = DateTime(2026, 11, 1, 12);
  });

  test('vraagt pas na 3 blije momenten en 3 dagen', () async {
    final c = await make();
    final prompt = c.read(reviewPromptProvider);

    expect(await prompt.positiveMoment(), isFalse);
    expect(await prompt.positiveMoment(), isFalse);
    // Drie momenten, maar de app staat er nog geen 3 dagen op.
    expect(await prompt.positiveMoment(), isFalse);

    now = now.add(const Duration(days: 3));
    expect(await prompt.positiveMoment(), isTrue);
    expect(requester.requests, 1);
  });

  test('daarna 120 dagen niet opnieuw', () async {
    final c = await make();
    final prompt = c.read(reviewPromptProvider);
    for (var i = 0; i < 3; i++) {
      await prompt.positiveMoment();
    }
    now = now.add(const Duration(days: 4));
    expect(await prompt.positiveMoment(), isTrue);

    now = now.add(const Duration(days: 30));
    for (var i = 0; i < 5; i++) {
      expect(await prompt.positiveMoment(), isFalse);
    }

    now = now.add(const Duration(days: 91));
    expect(await prompt.positiveMoment(), isTrue);
    expect(requester.requests, 2);
  });

  test('nooit in een demoteam (App Review)', () async {
    final c = await make(
      demo: true,
      prefs: {ReviewPrompt.firstSeenKey: 0, ReviewPrompt.momentsKey: 10},
    );
    expect(await c.read(reviewPromptProvider).positiveMoment(), isFalse);
    expect(requester.requests, 0);
  });

  test('niet als de systeemvraag niet beschikbaar is', () async {
    requester.available = false;
    final c = await make(
      prefs: {ReviewPrompt.firstSeenKey: 0, ReviewPrompt.momentsKey: 10},
    );
    expect(await c.read(reviewPromptProvider).positiveMoment(), isFalse);
    expect(requester.requests, 0);
  });

  test('deellink: App Store op iOS, de site elders', () {
    expect(
      StoreLinks.shareLink(platform: TargetPlatform.iOS).toString(),
      'https://apps.apple.com/nl/app/assistje/id6830074966',
    );
    expect(
      StoreLinks.shareLink(platform: TargetPlatform.android).toString(),
      'https://assistje.nl',
    );
  });
}
