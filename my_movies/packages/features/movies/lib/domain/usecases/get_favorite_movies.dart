import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetFavoriteMovies {
  const GetFavoriteMovies(this._repository);

  final MovieRepository _repository;

  Future<Either<Failure, List<Movie>>> call({int page = 1}) {
    return _repository.getFavoriteMovies(page: page);
  }
}
