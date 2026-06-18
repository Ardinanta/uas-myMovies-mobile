import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, AuthSession>> login({
    required String username,
    required String password,
  }) async {
    try {
      final token = await _remoteDataSource.createRequestToken();
      final validatedToken = await _remoteDataSource
          .validateRequestTokenWithLogin(
            username: username,
            password: password,
            requestToken: token.requestToken,
          );
      final session = await _remoteDataSource.createSession(
        validatedToken.requestToken,
      );
      final account = await _remoteDataSource.getAccount(session.sessionId);

      final authSession = AuthSession(
        sessionId: session.sessionId,
        accountId: account.id,
        username: account.username,
        name: account.name,
      );

      await _localDataSource.saveSession(authSession);
      return Right(authSession);
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, AuthSession>> loginAsGuest() async {
    try {
      final guestSession = await _remoteDataSource.createGuestSession();
      final authSession = AuthSession(
        sessionId: guestSession.guestSessionId,
        accountId: 0,
        username: 'Guest',
        isGuest: true,
      );

      await _localDataSource.saveSession(authSession);
      return Right(authSession);
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, AuthSession?>> getSavedSession() async {
    try {
      return Right(await _localDataSource.getSession());
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final session = await _localDataSource.getSession();
      try {
        if (session != null && !session.isGuest) {
          await _remoteDataSource.deleteSession(session.sessionId);
        }
      } catch (_) {
        // Local logout must still succeed when the remote session is expired.
      }

      await _localDataSource.clearSession();
      return const Right(null);
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }
}
