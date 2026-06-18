import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class LoginWithTmdb {
  const LoginWithTmdb(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, AuthSession>> call({
    required String username,
    required String password,
  }) {
    return _repository.login(username: username, password: password);
  }
}
