import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../repositories/favorite_repository.dart';

class IsMovieFavorite {
  const IsMovieFavorite(this._repository);

  final FavoriteRepository _repository;

  Future<Either<Failure, bool>> call(int movieId) {
    return _repository.isFavorite(movieId);
  }
}
