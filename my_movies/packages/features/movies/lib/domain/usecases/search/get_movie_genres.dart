import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../../entities/movie_genre.dart';
import '../../repositories/movie_repository.dart';

class GetMovieGenres {
  const GetMovieGenres(this._repository);

  final MovieRepository _repository;

  Future<Either<Failure, List<MovieGenre>>> call() {
    return _repository.getMovieGenres();
  }
}
