import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class LoginAsGuest {
  const LoginAsGuest(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, AuthSession>> call() {
    return _repository.loginAsGuest();
  }
}
