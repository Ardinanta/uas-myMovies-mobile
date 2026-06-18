import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../entities/auth_session.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthSession>> login({
    required String username,
    required String password,
  });

  Future<Either<Failure, AuthSession>> loginAsGuest();

  Future<Either<Failure, AuthSession?>> getSavedSession();

  Future<Either<Failure, void>> logout();
}
