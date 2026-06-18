import 'package:core_services/core_services.dart';

import '../../domain/entities/auth_session.dart';

abstract class AuthLocalDataSource {
  Future<void> saveSession(AuthSession session);

  Future<AuthSession?> getSession();

  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  const AuthLocalDataSourceImpl(this._storage);

  final LocalStorageService _storage;

  @override
  Future<void> saveSession(AuthSession session) async {
    await _storage.saveString(AuthStorageKeys.sessionId, session.sessionId);
    await _storage.saveString(
      AuthStorageKeys.accountId,
      session.accountId.toString(),
    );
    await _storage.saveString(AuthStorageKeys.username, session.username);
    await _storage.saveString(AuthStorageKeys.isGuest, '${session.isGuest}');

    final name = session.name;
    if (name != null && name.isNotEmpty) {
      await _storage.saveString(AuthStorageKeys.name, name);
    } else {
      await _storage.remove(AuthStorageKeys.name);
    }
  }

  @override
  Future<AuthSession?> getSession() async {
    final sessionId = await _storage.getString(AuthStorageKeys.sessionId);
    final accountIdText = await _storage.getString(AuthStorageKeys.accountId);
    final username = await _storage.getString(AuthStorageKeys.username);
    final isGuestText = await _storage.getString(AuthStorageKeys.isGuest);

    if (sessionId == null || accountIdText == null || username == null) {
      return null;
    }

    final accountId = int.tryParse(accountIdText);
    if (accountId == null) {
      return null;
    }

    return AuthSession(
      sessionId: sessionId,
      accountId: accountId,
      username: username,
      name: await _storage.getString(AuthStorageKeys.name),
      isGuest: isGuestText == 'true',
    );
  }

  @override
  Future<void> clearSession() async {
    await _storage.remove(AuthStorageKeys.sessionId);
    await _storage.remove(AuthStorageKeys.accountId);
    await _storage.remove(AuthStorageKeys.username);
    await _storage.remove(AuthStorageKeys.name);
    await _storage.remove(AuthStorageKeys.isGuest);
  }
}
