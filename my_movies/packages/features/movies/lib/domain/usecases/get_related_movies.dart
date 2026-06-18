import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetRelatedMovies {
  const GetRelatedMovies(this._repository);

  final MovieRepository _repository;

  Future<Either<Failure, List<Movie>>> call({
    required int movieId,
    int page = 1,
  }) {
    return _repository.getRelatedMovies(movieId: movieId, page: page);
  }
}
