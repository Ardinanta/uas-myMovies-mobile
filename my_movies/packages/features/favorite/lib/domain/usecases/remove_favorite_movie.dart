import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../repositories/favorite_repository.dart';

class RemoveFavoriteMovie {
  const RemoveFavoriteMovie(this._repository);

  final FavoriteRepository _repository;

  Future<Either<Failure, void>> call(int movieId) {
    return _repository.removeFavorite(movieId);
  }
}
