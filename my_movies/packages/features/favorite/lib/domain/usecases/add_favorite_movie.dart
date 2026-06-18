import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';
import 'package:movies/movies.dart';

import '../repositories/favorite_repository.dart';

class AddFavoriteMovie {
  const AddFavoriteMovie(this._repository);

  final FavoriteRepository _repository;

  Future<Either<Failure, void>> call(Movie movie) {
    return _repository.addFavorite(movie);
  }
}
