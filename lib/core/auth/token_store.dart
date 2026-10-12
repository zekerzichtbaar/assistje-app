import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Bewaart het Sanctum-token van dit toestel.
abstract interface class TokenStore {
  Future<String?> read();
  Future<void> write(String token);
  Future<void> clear();
}

/// [TokenStore] op de Keychain / Android Keystore, met een cache in geheugen
/// zodat niet elk API-verzoek de secure storage raakt.
class SecureTokenStore implements TokenStore {
  SecureTokenStore([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  static const String storageKey = 'api_token';

  final FlutterSecureStorage _storage;
  String? _cached;
  bool _loaded = false;

  @override
  Future<String?> read() async {
    if (!_loaded) {
      _cached = await _storage.read(key: storageKey);
      _loaded = true;
    }
    return _cached;
  }

  @override
  Future<void> write(String token) async {
    _cached = token;
    _loaded = true;
    await _storage.write(key: storageKey, value: token);
  }

  @override
  Future<void> clear() async {
    _cached = null;
    _loaded = true;
    await _storage.delete(key: storageKey);
  }
}

final tokenStoreProvider = Provider<TokenStore>((ref) => SecureTokenStore());
