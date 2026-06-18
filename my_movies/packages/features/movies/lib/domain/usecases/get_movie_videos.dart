import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../entities/movie_video.dart';
import '../repositories/movie_repository.dart';

class GetMovieVideos {
  const GetMovieVideos(this._repository);

  final MovieRepository _repository;

  Future<Either<Failure, List<MovieVideo>>> call(int movieId) {
    return _repository.getMovieVideos(movieId);
  }
}
