import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../../entities/movie.dart';
import '../../repositories/movie_repository.dart';

class GetMovieDetail {
  const GetMovieDetail(this._repository);

  final MovieRepository _repository;

  Future<Either<Failure, Movie>> call(int movieId) {
    return _repository.getMovieDetail(movieId);
  }
}
