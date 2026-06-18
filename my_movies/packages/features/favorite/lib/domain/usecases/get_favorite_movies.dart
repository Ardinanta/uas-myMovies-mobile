import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../entities/favorite_movie.dart';
import '../repositories/favorite_repository.dart';

class GetFavoriteMovies {
  const GetFavoriteMovies(this._repository);

  final FavoriteRepository _repository;

  Future<Either<Failure, List<FavoriteMovie>>> call({int page = 1}) {
    return _repository.getFavoriteMovies(page: page);
  }
}
