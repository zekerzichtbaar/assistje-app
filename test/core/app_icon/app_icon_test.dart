import 'dart:async';

import 'package:assistje/core/app_icon/app_icon_service.dart';
import 'package:assistje/core/auth/auth_controller.dart';
import 'package:assistje/core/session/models/me.dart';
import 'package:assistje/core/session/models/team_membership.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:assistje/core/theme/app_theme.dart';
import 'package:assistje/core/theme/theme_providers.dart';
import 'package:assistje/features/profile/presentation/widgets/app_settings.dart';
import 'package:assistje/l10n/generated/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helpers/api_fixtures.dart';

const _channel = MethodChannel(AppIconService.channelName);

/// Nep-native kant (iOS en Android gedragen zich hetzelfde): houdt het
/// huidige icoon bij en weet welke er in de build zitten.
class _FakeNative {
  _FakeNative({this.supported = true, this.current}) {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_channel, (call) async {
          calls.add(call);
          final name = (call.arguments as Map?)?['name'] as String?;
          switch (call.method) {
            case 'status':
              return {
                'supported': supported,
                'current': current,
                'available': bundled.contains(name),
              };
            case 'set':
              if (failNextSet) {
                failNextSet = false;
                throw PlatformException(code: 'failed');
              }
              current = name;
              return null;
          }
          return null;
        });
    addTearDown(
      () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(_channel, null),
    );
  }

  static const bundled = {'ClubIcon-12', 'ClubIcon-13'};
  final bool supported;
  String? current;
  bool failNextSet = false;
  final calls = <MethodCall>[];

  List<Object?> get sets => [
    for (final c in calls)
      if (c.method == 'set') (c.arguments as Map)['name'],
  ];
}

class _FakeAuth extends AuthController {
  _FakeAuth(this.initial);

  final AuthStatus initial;

  @override
  AuthStatus build() => initial;

  // ignore: use_setters_to_change_properties
  void set(AuthStatus status) => state = status;
}

Map<String, dynamic> _membership({required int teamId, int? clubId}) {
  final json = ApiFixtures.membership(teamId: teamId, name: 'Team $teamId');
  (json['team'] as Map<String, dynamic>)['club_id'] = clubId;
  return json;
}

Me _me(List<Map<String, dynamic>> teams) => Me.fromJson(
  ApiFixtures.meResponse(teams: teams)['data'] as Map<String, dynamic>,
);

Future<void> _settle() async {
  for (var i = 0; i < 10; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppIconService', () {
    setUp(() => debugDefaultTargetPlatformOverride = TargetPlatform.iOS);
    tearDown(() => debugDefaultTargetPlatformOverride = null);

    test('wapen in de build: naam en of het staat', () async {
      _FakeNative(current: 'ClubIcon-12');
      final state = await const AppIconService().clubIcon(12);
      expect(state?.name, 'ClubIcon-12');
      expect(state?.active, isTrue);
      expect((await const AppIconService().clubIcon(13))?.active, isFalse);
    });

    test('niet in de build of toestel kan het niet: null', () async {
      _FakeNative();
      expect(await const AppIconService().clubIcon(99), isNull);
      _FakeNative(supported: false);
      expect(await const AppIconService().clubIcon(12), isNull);
    });

    test('Android: hetzelfde kanaal en dezelfde namen', () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      final native = _FakeNative();
      await const AppIconService().apply('ClubIcon-12');
      expect(native.sets, ['ClubIcon-12']);
    });

    test('apply: alleen wisselen als het nodig is', () async {
      final native = _FakeNative(current: 'ClubIcon-12');
      const service = AppIconService();
      await service.apply('ClubIcon-12');
      expect(native.sets, isEmpty);
      await service.apply('ClubIcon-13');
      await service.apply(null);
      // Niet in de build → standaardicoon (staat al).
      await service.apply('ClubIcon-99');
      expect(native.sets, ['ClubIcon-13', null]);
    });

    test('andere platformen: geen kanaal', () async {
      final native = _FakeNative();
      debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
      expect(await const AppIconService().clubIcon(12), isNull);
      await const AppIconService().apply('ClubIcon-12');
      expect(native.calls, isEmpty);
    });
  });

  group('appIconSyncProvider', () {
    setUp(() => debugDefaultTargetPlatformOverride = TargetPlatform.iOS);
    tearDown(() => debugDefaultTargetPlatformOverride = null);

    late _FakeNative native;
    late Completer<Me?> me;

    Future<ProviderContainer> start({
      AuthStatus auth = AuthStatus.signedIn,
      Map<String, Object> prefs = const {},
      String? current,
      bool meLoaded = true,
      List<Map<String, dynamic>>? teams,
    }) async {
      SharedPreferences.setMockInitialValues(prefs);
      final shared = await SharedPreferences.getInstance();
      native = _FakeNative(current: current);
      me = Completer<Me?>();
      if (meLoaded) {
        me.complete(_me(teams ?? [_membership(teamId: 3, clubId: 12)]));
      }
      final container = ProviderContainer(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(shared),
          authControllerProvider.overrideWith(() => _FakeAuth(auth)),
          meProvider.overrideWith((ref) => me.future),
        ],
      );
      addTearDown(container.dispose);
      // Zoals `AssistjeApp`.
      container.listen(appIconSyncProvider, (_, _) {});
      await _settle();
      return container;
    }

    test('ingelogd: het wapen van de club van het team', () async {
      await start();
      expect(native.sets, ['ClubIcon-12']);
    });

    test('staat al: geen wissel (geen iOS-melding)', () async {
      await start(current: 'ClubIcon-12');
      expect(native.sets, isEmpty);
    });

    test('koude start: niets zolang inloggen of /me nog loopt', () async {
      await start(auth: AuthStatus.unknown);
      expect(native.calls, isEmpty);

      await start(meLoaded: false, current: 'ClubIcon-12');
      expect(native.calls, isEmpty);
      me.complete(_me([_membership(teamId: 3, clubId: 12)]));
      await _settle();
      expect(native.sets, isEmpty);
    });

    test('teamwissel: het wapen van de nieuwe club', () async {
      final container = await start(
        teams: [
          _membership(teamId: 3, clubId: 12),
          _membership(teamId: 9, clubId: 13),
        ],
      );
      await container.read(currentTeamIdProvider.notifier).select(9);
      await _settle();
      expect(native.sets, ['ClubIcon-12', 'ClubIcon-13']);
    });

    test('team zonder club: standaardicoon', () async {
      await start(current: 'ClubIcon-12', teams: [_membership(teamId: 3)]);
      expect(native.sets, [null]);
    });

    test('uitloggen: terug naar het standaardicoon', () async {
      final container = await start();
      (container.read(authControllerProvider.notifier) as _FakeAuth).set(
        AuthStatus.signedOut,
      );
      await _settle();
      expect(native.sets, ['ClubIcon-12', null]);
    });

    test(
      'wissel mislukt (iOS te vroeg): opnieuw bij terug naar voorgrond',
      () async {
        SharedPreferences.setMockInitialValues({});
        final shared = await SharedPreferences.getInstance();
        native = _FakeNative()..failNextSet = true;
        final container = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(shared),
            authControllerProvider.overrideWith(
              () => _FakeAuth(AuthStatus.signedIn),
            ),
            meProvider.overrideWith(
              (ref) async => _me([_membership(teamId: 3, clubId: 12)]),
            ),
          ],
        );
        addTearDown(container.dispose);
        container.listen(appIconSyncProvider, (_, _) {});
        await _settle();
        expect(native.current, isNull);

        final binding = TestWidgetsFlutterBinding.instance;
        binding
          ..handleAppLifecycleStateChanged(AppLifecycleState.inactive)
          ..handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        await _settle();
        expect(native.current, 'ClubIcon-12');

        // Staat goed: volgende keer voorgrond geen nieuwe wissel.
        final before = native.sets.length;
        binding
          ..handleAppLifecycleStateChanged(AppLifecycleState.inactive)
          ..handleAppLifecycleStateChanged(AppLifecycleState.resumed);
        await _settle();
        expect(native.sets.length, before);
      },
    );

    test('schakelaar uit: standaardicoon, en weer aan: wapen', () async {
      final container = await start(
        prefs: {ClubAppIconEnabledNotifier.storageKey: false},
        current: 'ClubIcon-12',
      );
      expect(native.sets, [null]);
      await container
          .read(clubAppIconEnabledProvider.notifier)
          .set(enabled: true);
      await _settle();
      expect(native.sets, [null, 'ClubIcon-12']);
    });
  });

  group('AppIconCard', () {
    Future<SharedPreferences> pumpCard(
      WidgetTester tester, {
      int? clubId = 12,
    }) async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
            currentMembershipProvider.overrideWithValue(
              TeamMembership.fromJson(_membership(teamId: 3, clubId: clubId)),
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
      return prefs;
    }

    testWidgets(
      'standaard clublogo; kiezen voor Assistje wordt bewaard, en terug',
      (tester) async {
        _FakeNative();
        final prefs = await pumpCard(tester);

        expect(find.text('App-icoon'), findsOneWidget);
        final assistje = find.byKey(const ValueKey('profile-app-icon-default'));
        final club = find.byKey(const ValueKey('profile-app-icon-club'));
        bool selected(Finder f) =>
            isSemantics(isSelected: true).matches(tester.getSemantics(f), {});
        expect(selected(club), isTrue);
        expect(selected(assistje), isFalse);

        await tester.tap(assistje);
        await tester.pumpAndSettle();
        expect(selected(assistje), isTrue);
        expect(selected(club), isFalse);
        expect(prefs.getBool(ClubAppIconEnabledNotifier.storageKey), isFalse);

        await tester.tap(club);
        await tester.pumpAndSettle();
        expect(selected(club), isTrue);
        expect(prefs.getBool(ClubAppIconEnabledNotifier.storageKey), isTrue);
      },
      variant: TargetPlatformVariant.only(TargetPlatform.android),
    );

    testWidgets(
      'geen club of wapen niet in de build: geen kaart',
      (tester) async {
        _FakeNative();
        await pumpCard(tester, clubId: null);
        expect(find.byKey(const ValueKey('profile-app-icon')), findsNothing);

        await pumpCard(tester, clubId: 99);
        expect(find.byKey(const ValueKey('profile-app-icon')), findsNothing);
      },
      variant: TargetPlatformVariant.only(TargetPlatform.iOS),
    );
  });
}
