import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../repositories/auth_repository.dart';

class LogoutFromTmdb {
  const LogoutFromTmdb(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, void>> call() {
    return _repository.logout();
  }
}
