import 'package:assistje/core/auth/auth_controller.dart';
import 'package:assistje/core/router/app_routes.dart';
import 'package:assistje/core/router/auth_redirect.dart';
import 'package:assistje/core/session/models/me.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/api_fixtures.dart';

void main() {
  final withTeam = Me.fromJson(
    ApiFixtures.meResponse()['data'] as Map<String, dynamic>,
  );
  final withoutTeam = Me.fromJson(
    ApiFixtures.meResponse(teams: [])['data'] as Map<String, dynamic>,
  );

  String? redirect(AuthStatus status, AsyncValue<Me?> me, String location) =>
      authRedirect(status: status, me: me, location: location);

  test('status onbekend → start', () {
    expect(
      redirect(AuthStatus.unknown, const AsyncLoading(), AppRoutes.home),
      AppRoutes.splash,
    );
    expect(
      redirect(AuthStatus.unknown, const AsyncLoading(), AppRoutes.splash),
      isNull,
    );
  });

  test('uitgelogd → login, behalve op de loginroutes', () {
    const me = AsyncData<Me?>(null);
    expect(redirect(AuthStatus.signedOut, me, AppRoutes.home), AppRoutes.login);
    expect(
      redirect(AuthStatus.signedOut, me, AppRoutes.splash),
      AppRoutes.login,
    );
    expect(redirect(AuthStatus.signedOut, me, AppRoutes.login), isNull);
    expect(
      redirect(
        AuthStatus.signedOut,
        me,
        '${AppRoutes.loginCode}?email=a%40b.nl',
      ),
      isNull,
    );
  });

  test('ingelogd terwijl /me laadt of faalt → start', () {
    expect(
      redirect(AuthStatus.signedIn, const AsyncLoading(), AppRoutes.loginCode),
      AppRoutes.splash,
    );
    expect(
      redirect(
        AuthStatus.signedIn,
        AsyncError<Me?>(Exception('x'), StackTrace.empty),
        AppRoutes.home,
      ),
      AppRoutes.splash,
    );
  });

  test('ingelogd zonder team → geen-team', () {
    final me = AsyncData<Me?>(withoutTeam);
    expect(redirect(AuthStatus.signedIn, me, AppRoutes.home), AppRoutes.noTeam);
    expect(redirect(AuthStatus.signedIn, me, AppRoutes.noTeam), isNull);
  });

  test('ingelogd met team → home vanaf login/start/geen-team', () {
    final me = AsyncData<Me?>(withTeam);
    for (final from in [
      AppRoutes.login,
      AppRoutes.loginCode,
      AppRoutes.splash,
      AppRoutes.noTeam,
    ]) {
      expect(redirect(AuthStatus.signedIn, me, from), AppRoutes.home);
    }
    expect(redirect(AuthStatus.signedIn, me, AppRoutes.home), isNull);
  });

  test('/ is geen scherm: ingelogd → agenda, uitgelogd → login', () {
    expect(AppRoutes.home, AppRoutes.agenda);
    expect(
      redirect(AuthStatus.signedIn, AsyncData<Me?>(withTeam), AppRoutes.root),
      AppRoutes.agenda,
    );
    expect(
      redirect(
        AuthStatus.signedOut,
        const AsyncData<Me?>(null),
        AppRoutes.root,
      ),
      AppRoutes.login,
    );
    // Diepe ingelogde paden blijven staan (rolchecks doet de nav-guard).
    expect(
      redirect(AuthStatus.signedIn, AsyncData<Me?>(withTeam), '/events/12'),
      isNull,
    );
  });

  test('publieke schermen (teamlink, uitnodiging) mogen altijd', () {
    final locations = [
      AppRoutes.joinLink('Xk3abc'),
      AppRoutes.joinConfirmLink(
        'Xk3abc',
        'L' * 64,
        query: {'role': 'player', 'player': '12'},
      ),
      AppRoutes.inviteLink('inv123'),
      AppRoutes.signup,
      AppRoutes.signupLink(sport: 'hockey'),
    ];
    final cases = <(AuthStatus, AsyncValue<Me?>)>[
      (AuthStatus.unknown, const AsyncLoading()),
      (AuthStatus.signedOut, const AsyncData(null)),
      (AuthStatus.signedIn, const AsyncLoading()),
      (AuthStatus.signedIn, AsyncData<Me?>(withoutTeam)),
      (AuthStatus.signedIn, AsyncData<Me?>(withTeam)),
    ];
    for (final location in locations) {
      for (final (status, me) in cases) {
        expect(
          redirect(status, me, location),
          isNull,
          reason: '$status $location',
        );
      }
    }
  });

  test('alleen echte publieke paden zijn publiek', () {
    expect(AppRoutes.isPublic('/meedoen/abc'), isTrue);
    expect(AppRoutes.isPublic('/meedoen/abc/bevestig/xyz?role=player'), isTrue);
    expect(AppRoutes.isPublic('/register/invite/abc'), isTrue);
    expect(AppRoutes.isPublic('/meedoen'), isFalse);
    expect(AppRoutes.isPublic('/meedoen/abc/iets'), isFalse);
    expect(AppRoutes.isPublic('/register/invite'), isFalse);
    expect(AppRoutes.isPublic('/register'), isFalse);
    expect(AppRoutes.isPublic(AppRoutes.agenda), isFalse);
    expect(AppRoutes.isPublic('/aanmelden'), isTrue);
    expect(AppRoutes.isPublic('/aanmelden?sport=hockey'), isTrue);
    expect(AppRoutes.isPublic('/aanmelden/verstuurd'), isFalse);
    expect(
      redirect(AuthStatus.signedOut, const AsyncData(null), '/meedoen'),
      AppRoutes.login,
    );
  });

  test('signupLink: met en zonder sport', () {
    expect(AppRoutes.signupLink(), '/aanmelden');
    expect(AppRoutes.signupLink(sport: ''), '/aanmelden');
    expect(AppRoutes.signupLink(sport: 'hockey'), '/aanmelden?sport=hockey');
    expect(
      AppRoutes.signupLink(sport: 'Korfbal & co'),
      '/aanmelden?sport=Korfbal+%26+co',
    );
  });
}
