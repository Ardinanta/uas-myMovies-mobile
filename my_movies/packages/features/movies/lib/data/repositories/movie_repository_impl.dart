import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';

import '../../domain/entities/cast_member.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_video.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';

class MovieRepositoryImpl implements MovieRepository {
  const MovieRepositoryImpl(this._remoteDataSource);

  final MovieRemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies({
    int page = 1,
  }) async {
    try {
      final response = await _remoteDataSource.getNowPlayingMovies(page: page);
      return Right(response.results.map((movie) => movie.toEntity()).toList());
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTrendingMovies({
    int page = 1,
  }) async {
    try {
      final response = await _remoteDataSource.getTrendingMovies(page: page);
      return Right(response.results.map((movie) => movie.toEntity()).toList());
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies({
    int page = 1,
  }) async {
    try {
      final response = await _remoteDataSource.getPopularMovies(page: page);
      return Right(response.results.map((movie) => movie.toEntity()).toList());
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies({
    int page = 1,
  }) async {
    try {
      final response = await _remoteDataSource.getTopRatedMovies(page: page);
      return Right(response.results.map((movie) => movie.toEntity()).toList());
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies({
    int page = 1,
  }) async {
    try {
      final response = await _remoteDataSource.getUpcomingMovies(page: page);
      return Right(response.results.map((movie) => movie.toEntity()).toList());
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, Movie>> getMovieDetail(int movieId) async {
    try {
      final movie = await _remoteDataSource.getMovieDetail(movieId);
      return Right(movie.toEntity());
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, List<CastMember>>> getMovieCast(int movieId) async {
    try {
      final response = await _remoteDataSource.getMovieCredits(movieId);
      return Right(response.cast.map((cast) => cast.toEntity()).toList());
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getRelatedMovies({
    required int movieId,
    int page = 1,
  }) async {
    try {
      final response = await _remoteDataSource.getRelatedMovies(
        movieId: movieId,
        page: page,
      );
      return Right(response.results.map((movie) => movie.toEntity()).toList());
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, List<MovieVideo>>> getMovieVideos(int movieId) async {
    try {
      final response = await _remoteDataSource.getMovieVideos(movieId);
      return Right(response.results.map((video) => video.toEntity()).toList());
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies({
    required String query,
    int page = 1,
  }) async {
    try {
      final response = await _remoteDataSource.searchMovies(
        query: query,
        page: page,
      );
      return Right(response.results.map((movie) => movie.toEntity()).toList());
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getFavoriteMovies({
    int page = 1,
  }) async {
    if (!TmdbConstants.hasAccountSession) {
      return const Left(
        Failure(
          message: 'TMDb account id atau session id belum diset.',
          type: FailureType.missingApiKey,
        ),
      );
    }

    try {
      final response = await _remoteDataSource.getFavoriteMovies(page: page);
      return Right(response.results.map((movie) => movie.toEntity()).toList());
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getFavoriteTv({
    int page = 1,
  }) async {
    if (!TmdbConstants.hasAccountSession) {
      return const Left(
        Failure(
          message: 'TMDb account id atau session id belum diset.',
          type: FailureType.missingApiKey,
        ),
      );
    }

    try {
      final response = await _remoteDataSource.getFavoriteTv(page: page);
      return Right(response.results.map((movie) => movie.toEntity()).toList());
    } catch (error) {
      return Left(ErrorMapper.map(error));
    }
  }
}
