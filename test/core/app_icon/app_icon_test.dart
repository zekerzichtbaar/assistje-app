import 'package:assistje/core/api/api_client.dart';
import 'package:assistje/core/app_icon/app_icon_service.dart';
import 'package:assistje/core/app_icon/club_logo_repository.dart';
import 'package:assistje/core/session/models/team_membership.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:assistje/core/theme/app_theme.dart';
import 'package:assistje/features/profile/presentation/widgets/app_settings.dart';
import 'package:assistje/l10n/generated/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';
import '../../helpers/fake_http_adapter.dart';

const _channel = MethodChannel(AppIconService.channelName);

/// Nep-native kant. iOS (`mode: alternate`): houdt het huidige icoon bij en
/// weet welke er in de build zitten. Android (`mode: shortcut`): houdt de
/// vastgezette snelkoppelingen bij; [pinError] laat `pinShortcut` falen.
List<MethodCall> _fakeNative({
  Set<String> bundled = const {'ClubIcon-12'},
  bool supported = true,
  String? mode,
  Set<String>? pinned,
  PlatformException? pinError,
}) {
  final calls = <MethodCall>[];
  final shortcuts = pinned ?? <String>{};
  String? current;
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(_channel, (call) async {
        calls.add(call);
        final args = call.arguments as Map?;
        final name = args?['name'] as String?;
        switch (call.method) {
          case 'status':
            if (mode == 'shortcut') {
              return {
                'supported': supported,
                'current': shortcuts.contains(name) ? name : null,
                'available': true,
                'mode': 'shortcut',
              };
            }
            return {
              'supported': supported,
              'current': current,
              'available': bundled.contains(name),
              'mode': ?mode,
            };
          case 'set':
            current = name;
            return null;
          case 'pinShortcut':
            if (pinError != null) throw pinError;
            return shortcuts.add(args!['id'] as String)
                ? 'requested'
                : 'updated';
        }
        return null;
      });
  addTearDown(
    () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_channel, null),
  );
  return calls;
}

/// Clublogo's zonder netwerk.
class _FakeLogos extends ClubLogoRepository {
  _FakeLogos(this.logos) : super(ApiClient(Dio()), Dio());

  final Map<int, String> logos;
  final downloads = <String>[];

  @override
  Future<String?> logoUrl(int clubId) async => logos[clubId];

  @override
  Future<Uint8List> download(String url) async {
    downloads.add(url);
    return Uint8List.fromList([1, 2, 3]);
  }
}

TeamMembership _membership({int? clubId}) {
  final json = ApiFixtures.membership();
  (json['team'] as Map<String, dynamic>)['club_id'] = clubId;
  return TeamMembership.fromJson(json);
}

Future<void> _pumpCard(
  WidgetTester tester,
  TeamMembership membership, {
  ClubLogoRepository? logos,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        currentMembershipProvider.overrideWithValue(membership),
        clubLogoRepositoryProvider.overrideWithValue(
          logos ?? _FakeLogos(const {}),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.light('#006837'),
        locale: const Locale('nl'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: const Scaffold(body: AppIconCard()),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

/// Laat de toast (4 s) verlopen, zodat er geen timer blijft hangen.
Future<void> _dismissToast(WidgetTester tester) async {
  await tester.pump(const Duration(seconds: 5));
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppIconService', () {
    setUp(() => debugDefaultTargetPlatformOverride = TargetPlatform.iOS);
    tearDown(() => debugDefaultTargetPlatformOverride = null);

    test('clubicoon in de build: naam en of het actief is', () async {
      _fakeNative(mode: 'alternate');
      final state = await const AppIconService().clubIcon(12);
      expect(state?.name, 'ClubIcon-12');
      expect(state?.active, isFalse);
      expect(state?.mode, AppIconMode.alternate);
    });

    test('oudere iOS-build zonder `mode`: alternate', () async {
      _fakeNative();
      final state = await const AppIconService().clubIcon(12);
      expect(state?.mode, AppIconMode.alternate);
    });

    test('niet in de build of toestel kan het niet: null', () async {
      _fakeNative();
      expect(await const AppIconService().clubIcon(99), isNull);
      _fakeNative(supported: false);
      expect(await const AppIconService().clubIcon(12), isNull);
    });

    test('Android: snelkoppeling met id club-<clubId>', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      final calls = _fakeNative(mode: 'shortcut', pinned: {'club-12'});
      final state = await const AppIconService().clubIcon(12);
      expect(calls.single.arguments, {'name': 'club-12'});
      expect(state?.name, 'club-12');
      expect(state?.mode, AppIconMode.shortcut);
      expect(state?.active, isTrue);
      expect((await const AppIconService().clubIcon(13))?.active, isFalse);
    });

    test('Android: launcher zonder vastzetten → null', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      _fakeNative(mode: 'shortcut', supported: false);
      expect(await const AppIconService().clubIcon(12), isNull);
    });

    test('Android: pinShortcut geeft requested, daarna updated', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      final calls = _fakeNative(mode: 'shortcut');
      final png = Uint8List.fromList([1, 2, 3]);
      const service = AppIconService();
      expect(
        await service.pinShortcut(id: 'club-12', label: 'Vogels 3', png: png),
        PinShortcutResult.requested,
      );
      expect(
        await service.pinShortcut(id: 'club-12', label: 'Vogels 3', png: png),
        PinShortcutResult.updated,
      );
      expect(calls.first.arguments, {
        'id': 'club-12',
        'label': 'Vogels 3',
        'png': png,
      });
    });

    test('andere platformen: geen kanaal en geen icoon', () async {
      final calls = _fakeNative();
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      expect(await const AppIconService().clubIcon(12), isNull);
      expect(calls, isEmpty);
    });
  });

  group('ClubLogoRepository', () {
    test('logo uit /app-icons, zonder SVG, één keer opgehaald', () async {
      final http = FakeHttpAdapter()
        ..on('GET /app-icons', 200, {
          'data': [
            {'club_id': 12, 'logo_url': 'https://assistje.nl/storage/12.png'},
            {'club_id': 13, 'logo_url': 'https://assistje.nl/storage/13.SVG'},
            {'club_id': 14, 'logo_url': null},
          ],
        });
      final dio = Dio(BaseOptions(baseUrl: 'https://assistje.nl/api/v1/'))
        ..httpClientAdapter = http;
      final repo = ClubLogoRepository(ApiClient(dio), dio);

      expect(await repo.logoUrl(12), 'https://assistje.nl/storage/12.png');
      expect(await repo.logoUrl(13), isNull);
      expect(await repo.logoUrl(14), isNull);
      expect(await repo.logoUrl(99), isNull);
      expect(http.requestsTo('GET /app-icons'), hasLength(1));
    });

    test('API-fout: null, en later opnieuw proberen', () async {
      final http = FakeHttpAdapter()..on('GET /app-icons', 500);
      final dio = Dio(BaseOptions(baseUrl: 'https://assistje.nl/api/v1/'))
        ..httpClientAdapter = http;
      final repo = ClubLogoRepository(ApiClient(dio), dio);

      expect(await repo.logoUrl(12), isNull);
      http.on('GET /app-icons', 200, {
        'data': [
          {'club_id': 12, 'logo_url': 'https://assistje.nl/storage/12.png'},
        ],
      });
      expect(await repo.logoUrl(12), 'https://assistje.nl/storage/12.png');
    });
  });

  group('AppIconCard (iOS)', () {
    final ios = TargetPlatformVariant.only(TargetPlatform.iOS);

    testWidgets('aanzetten zet het clubicoon, uitzetten het standaardicoon', (
      tester,
    ) async {
      final calls = _fakeNative(mode: 'alternate');
      await _pumpCard(tester, _membership(clubId: 12));

      expect(find.text('App-icoon'), findsOneWidget);
      await tester.tap(find.byKey(const ValueKey('profile-app-icon-switch')));
      await tester.pumpAndSettle();
      expect(calls.last.method, 'status');
      expect(calls.where((c) => c.method == 'set').single.arguments, {
        'name': 'ClubIcon-12',
      });

      await tester.tap(find.byKey(const ValueKey('profile-app-icon-switch')));
      await tester.pumpAndSettle();
      expect(calls.where((c) => c.method == 'set').last.arguments, {
        'name': null,
      });
    }, variant: ios);

    testWidgets('geen club of wapen niet in de build: geen kaart', (
      tester,
    ) async {
      _fakeNative(mode: 'alternate');
      await _pumpCard(tester, _membership());
      expect(find.byKey(const ValueKey('profile-app-icon')), findsNothing);

      await _pumpCard(tester, _membership(clubId: 99));
      expect(find.byKey(const ValueKey('profile-app-icon')), findsNothing);
    }, variant: ios);
  });

  group('AppIconCard (Android)', () {
    final android = TargetPlatformVariant.only(TargetPlatform.android);
    const logo = 'https://assistje.nl/storage/clubs/12.png';

    testWidgets('logo-voorbeeld en knop zet de snelkoppeling neer', (
      tester,
    ) async {
      final calls = _fakeNative(mode: 'shortcut');
      final logos = _FakeLogos(const {12: logo});
      await _pumpCard(tester, _membership(clubId: 12), logos: logos);

      expect(
        find.byKey(const ValueKey('profile-app-icon-switch')),
        findsNothing,
      );
      expect(
        find.textContaining('Het gewone icoon blijft in je apps staan'),
        findsOneWidget,
      );
      final preview = tester.widget<Image>(
        find.byKey(const ValueKey('profile-app-icon-logo')),
      );
      expect((preview.image as NetworkImage).url, logo);

      await tester.tap(find.text('Zet op beginscherm'));
      await tester.pumpAndSettle();
      expect(logos.downloads, [logo]);
      final pin = calls.singleWhere((c) => c.method == 'pinShortcut');
      expect(pin.arguments, {
        'id': 'club-12',
        'label': 'Vogels 3',
        'png': Uint8List.fromList([1, 2, 3]),
      });
      expect(find.text('Bijna klaar'), findsOneWidget);
      // Staat er nu: de knop werkt hem voortaan bij.
      expect(find.text('Icoon bijwerken'), findsOneWidget);
      await _dismissToast(tester);
    }, variant: android);

    testWidgets('staat er al: bijwerken', (tester) async {
      _fakeNative(mode: 'shortcut', pinned: {'club-12'});
      await _pumpCard(
        tester,
        _membership(clubId: 12),
        logos: _FakeLogos(const {12: logo}),
      );

      await tester.tap(find.text('Icoon bijwerken'));
      await tester.pumpAndSettle();
      expect(find.text('Icoon op je beginscherm bijgewerkt'), findsOneWidget);
      await _dismissToast(tester);
    }, variant: android);

    testWidgets('mislukt: fouttoast', (tester) async {
      _fakeNative(
        mode: 'shortcut',
        pinError: PlatformException(code: 'bad_image'),
      );
      await _pumpCard(
        tester,
        _membership(clubId: 12),
        logos: _FakeLogos(const {12: logo}),
      );

      await tester.tap(find.text('Zet op beginscherm'));
      await tester.pumpAndSettle();
      expect(find.text('Icoon op beginscherm zetten mislukt'), findsOneWidget);
      expect(find.text('Zet op beginscherm'), findsOneWidget);
      await _dismissToast(tester);
    }, variant: android);

    testWidgets(
      'geen logo, geen club of launcher kan het niet: geen kaart',
      (tester) async {
        _fakeNative(mode: 'shortcut');
        await _pumpCard(tester, _membership(clubId: 12));
        expect(find.byKey(const ValueKey('profile-app-icon')), findsNothing);

        await _pumpCard(
          tester,
          _membership(),
          logos: _FakeLogos(const {12: logo}),
        );
        expect(find.byKey(const ValueKey('profile-app-icon')), findsNothing);

        _fakeNative(mode: 'shortcut', supported: false);
        await _pumpCard(
          tester,
          _membership(clubId: 12),
          logos: _FakeLogos(const {12: logo}),
        );
        expect(find.byKey(const ValueKey('profile-app-icon')), findsNothing);
      },
      variant: android,
    );
  });
}
