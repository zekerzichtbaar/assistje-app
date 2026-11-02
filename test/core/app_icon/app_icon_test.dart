import 'package:assistje/core/app_icon/app_icon_service.dart';
import 'package:assistje/core/session/models/team_membership.dart';
import 'package:assistje/core/session/session_providers.dart';
import 'package:assistje/core/theme/app_theme.dart';
import 'package:assistje/features/profile/presentation/widgets/app_settings.dart';
import 'package:assistje/l10n/generated/app_localizations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';

const _channel = MethodChannel(AppIconService.channelName);

/// Nep-native kant: houdt het huidige icoon bij en weet welke er in de
/// build zitten.
List<MethodCall> _fakeNative({
  Set<String> bundled = const {'ClubIcon-12'},
  bool supported = true,
}) {
  final calls = <MethodCall>[];
  String? current;
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
            current = name;
            return null;
        }
        return null;
      });
  addTearDown(
    () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(_channel, null),
  );
  return calls;
}

TeamMembership _membership({int? clubId}) {
  final json = ApiFixtures.membership();
  (json['team'] as Map<String, dynamic>)['club_id'] = clubId;
  return TeamMembership.fromJson(json);
}

Future<void> _pumpCard(WidgetTester tester, TeamMembership membership) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [currentMembershipProvider.overrideWithValue(membership)],
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

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppIconService', () {
    setUp(() => debugDefaultTargetPlatformOverride = TargetPlatform.iOS);
    tearDown(() => debugDefaultTargetPlatformOverride = null);

    test('clubicoon in de build: naam en of het actief is', () async {
      _fakeNative();
      final state = await const AppIconService().clubIcon(12);
      expect(state?.name, 'ClubIcon-12');
      expect(state?.active, isFalse);
    });

    test('niet in de build of toestel kan het niet: null', () async {
      _fakeNative();
      expect(await const AppIconService().clubIcon(99), isNull);
      _fakeNative(supported: false);
      expect(await const AppIconService().clubIcon(12), isNull);
    });

    test('op Android geen kanaal en geen icoon', () async {
      final calls = _fakeNative();
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      expect(await const AppIconService().clubIcon(12), isNull);
      expect(calls, isEmpty);
    });
  });

  group('AppIconCard', () {
    final ios = TargetPlatformVariant.only(TargetPlatform.iOS);

    testWidgets('aanzetten zet het clubicoon, uitzetten het standaardicoon', (
      tester,
    ) async {
      final calls = _fakeNative();
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
      _fakeNative();
      await _pumpCard(tester, _membership());
      expect(find.byKey(const ValueKey('profile-app-icon')), findsNothing);

      await _pumpCard(tester, _membership(clubId: 99));
      expect(find.byKey(const ValueKey('profile-app-icon')), findsNothing);
    }, variant: ios);
  });
}
