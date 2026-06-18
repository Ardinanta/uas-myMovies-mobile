abstract class LocalStorageService {
  Future<void> saveString(String key, String value);

  Future<String?> getString(String key);

  Future<void> remove(String key);

  Future<void> clear();
}

class InMemoryLocalStorageService implements LocalStorageService {
  final Map<String, String> _storage = <String, String>{};

  @override
  Future<void> saveString(String key, String value) async {
    _storage[key] = value;
  }

  @override
  Future<String?> getString(String key) async {
    return _storage[key];
  }

  @override
  Future<void> remove(String key) async {
    _storage.remove(key);
  }

  @override
  Future<void> clear() async {
    _storage.clear();
  }
}
