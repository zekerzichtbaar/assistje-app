import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/api_client.dart';
import '../api/api_exception.dart';
import '../session/models/user.dart';
import 'token_store.dart';

/// Inloggen via mail + zescijferige code of via de link uit de mail, en
/// uitloggen.
class AuthRepository {
  const AuthRepository(this._api, this._tokens);

  final ApiClient _api;
  final TokenStore _tokens;

  /// `POST /auth/request` — stuurt de inlogmail met link en code.
  Future<void> requestCode(String email, {String? team}) async {
    await _api.post('/auth/request', data: {'email': email, 'team': ?team});
  }

  /// `POST /auth/exchange` — wisselt e-mail + code in voor een token, en
  /// bewaart dat token.
  Future<User> exchangeCode({
    required String email,
    required String code,
    required String deviceName,
  }) => _exchange({'email': email, 'code': code, 'device_name': deviceName});

  /// `POST /auth/exchange` — wisselt het token uit een inloglink
  /// (`/magic/{token}`) in voor een Sanctum-token, en bewaart dat token.
  /// Verlopen of al gebruikte link → `ValidationException` (`errors.token`).
  Future<User> exchangeToken(String token, {required String deviceName}) =>
      _exchange({'token': token, 'device_name': deviceName});

  Future<User> _exchange(Map<String, String> body) async {
    final response = await _api.post('/auth/exchange', data: body);
    final token = tokenFrom(response);
    await _tokens.write(token);
    return User.fromJson(
      (response['data'] as Map<String, dynamic>)['user']
          as Map<String, dynamic>,
    );
  }

  /// Het Sanctum-token uit een antwoord in de vorm van `POST /auth/exchange`
  /// (`{data: {token, token_type, user}}`) — ook de vorm van meedoen via de
  /// teamlink en een uitnodiging accepteren. Anders `UnknownApiException`.
  static String tokenFrom(Map<String, dynamic> body) {
    final data = body['data'];
    if (data is! Map<String, dynamic> ||
        data['token'] is! String ||
        (data['token'] as String).isEmpty ||
        data['user'] is! Map<String, dynamic>) {
      throw const UnknownApiException(message: 'Onverwacht antwoord.');
    }
    return data['token'] as String;
  }

  /// Bewaart een token dat de server al uitgaf (meedoen, uitnodiging) als
  /// het token van dit toestel.
  Future<void> adoptToken(String token) => _tokens.write(token);

  /// `POST /auth/logout` — trekt het token in. Lukt dat niet (offline, al
  /// ingetrokken), dan wordt het token lokaal toch gewist.
  Future<void> logout() async {
    try {
      if (await _tokens.read() != null) await _api.post('/auth/logout');
    } on ApiException {
      // Lokaal uitloggen gaat altijd door.
    } finally {
      await _tokens.clear();
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(
    ref.watch(apiClientProvider),
    ref.watch(tokenStoreProvider),
  ),
);
