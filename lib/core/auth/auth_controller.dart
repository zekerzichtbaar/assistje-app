import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_repository.dart';
import 'device_name.dart';
import 'token_store.dart';

/// Waar de app staat qua inloggen.
enum AuthStatus {
  /// Bij opstart: het token wordt nog gelezen.
  unknown,
  signedOut,
  signedIn,
}

/// Houdt [AuthStatus] bij. Bij opstart: token aanwezig → ingelogd (een
/// ongeldig token valt via de 401 van `/me` alsnog terug naar uitgelogd).
class AuthController extends Notifier<AuthStatus> {
  @override
  AuthStatus build() {
    unawaited(_restore());
    return AuthStatus.unknown;
  }

  Future<void> _restore() async {
    String? token;
    try {
      token = await ref.read(tokenStoreProvider).read();
    } on Object {
      token = null;
    }
    if (state == AuthStatus.unknown) {
      state = token == null || token.isEmpty
          ? AuthStatus.signedOut
          : AuthStatus.signedIn;
    }
  }

  /// Vraagt een inlogmail met code aan. Gooit een `ApiException`.
  Future<void> requestCode(String email) =>
      ref.read(authRepositoryProvider).requestCode(email);

  /// Logt in met e-mail + code. Gooit een `ApiException` (422/429).
  Future<void> signInWithCode({
    required String email,
    required String code,
  }) async {
    await ref
        .read(authRepositoryProvider)
        .exchangeCode(
          email: email,
          code: code,
          deviceName: ref.read(deviceNameProvider),
        );
    state = AuthStatus.signedIn;
  }

  /// Logt in met het token uit een inloglink (`/magic/{token}`, via een
  /// Universal/App Link). Gooit een `ApiException` (422: link verlopen of al
  /// gebruikt).
  Future<void> signInWithToken(String token) async {
    await ref
        .read(authRepositoryProvider)
        .exchangeToken(token, deviceName: ref.read(deviceNameProvider));
    state = AuthStatus.signedIn;
  }

  /// Neemt een al uitgegeven token over (antwoord van meedoen via de
  /// teamlink of een uitnodiging, in de vorm van `auth/exchange`) en zet de
  /// status op ingelogd. Was er al iemand ingelogd, dan vervangt dit token
  /// het oude (het kan een ander account zijn): de status gaat kort via
  /// [AuthStatus.unknown], zodat `/me` en alle teamdata opnieuw laden.
  Future<void> adoptToken(String accessToken) async {
    if (accessToken.isEmpty) {
      throw ArgumentError.value(accessToken, 'accessToken', 'leeg token');
    }
    await ref.read(authRepositoryProvider).adoptToken(accessToken);
    if (state == AuthStatus.signedIn) state = AuthStatus.unknown;
    state = AuthStatus.signedIn;
  }

  /// Uitloggen: token intrekken bij de server en lokaal wissen.
  Future<void> logout() async {
    state = AuthStatus.signedOut;
    await ref.read(authRepositoryProvider).logout();
  }

  /// Een API-aanroep gaf 401: het token is ongeldig → uitloggen zonder
  /// serveraanroep.
  void handleUnauthorized() {
    if (state == AuthStatus.signedOut) return;
    state = AuthStatus.signedOut;
    unawaited(ref.read(tokenStoreProvider).clear());
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthStatus>(
  AuthController.new,
);
