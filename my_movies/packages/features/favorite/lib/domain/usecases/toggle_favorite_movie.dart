import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';
import 'package:movies/movies.dart';

import '../repositories/favorite_repository.dart';

class ToggleFavoriteMovie {
  const ToggleFavoriteMovie(this._repository);

  final FavoriteRepository _repository;

  Future<Either<Failure, bool>> call(Movie movie) {
    return _repository.toggleFavorite(movie);
  }
}
