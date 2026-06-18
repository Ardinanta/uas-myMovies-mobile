import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../entities/cast_member.dart';
import '../entities/movie.dart';
import '../entities/movie_video.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies({int page = 1});

  Future<Either<Failure, List<Movie>>> getTrendingMovies({int page = 1});

  Future<Either<Failure, List<Movie>>> getPopularMovies({int page = 1});

  Future<Either<Failure, List<Movie>>> getTopRatedMovies({int page = 1});

  Future<Either<Failure, List<Movie>>> getUpcomingMovies({int page = 1});

  Future<Either<Failure, Movie>> getMovieDetail(int movieId);

  Future<Either<Failure, List<CastMember>>> getMovieCast(int movieId);

  Future<Either<Failure, List<Movie>>> getRelatedMovies({
    required int movieId,
    int page = 1,
  });

  Future<Either<Failure, List<MovieVideo>>> getMovieVideos(int movieId);

  Future<Either<Failure, List<Movie>>> searchMovies({
    required String query,
    int page = 1,
  });

  Future<Either<Failure, List<Movie>>> getFavoriteMovies({int page = 1});

  Future<Either<Failure, List<Movie>>> getFavoriteTv({int page = 1});
}
