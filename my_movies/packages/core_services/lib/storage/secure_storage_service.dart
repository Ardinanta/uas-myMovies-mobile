import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'local_storage_service.dart';

class SecureStorageService implements LocalStorageService {
  const SecureStorageService({
    FlutterSecureStorage storage = const FlutterSecureStorage(),
  }) : _storage = storage;

  final FlutterSecureStorage _storage;

  @override
  Future<void> saveString(String key, String value) {
    return _storage.write(key: key, value: value);
  }

  @override
  Future<String?> getString(String key) {
    return _storage.read(key: key);
  }

  @override
  Future<void> remove(String key) {
    return _storage.delete(key: key);
  }

  @override
  Future<void> clear() {
    return _storage.deleteAll();
  }
}
