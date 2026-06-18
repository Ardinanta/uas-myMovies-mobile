import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/movies.dart';

void main() {
  test('returns empty list when query is blank', () async {
    final useCase = SearchMovies(_FakeMovieRepository());

    final result = await useCase(query: '   ');

    expect(result.isRight, isTrue);
    expect(result.right, isEmpty);
  });
}

class _FakeMovieRepository implements MovieRepository {
  @override
  Future<Either<Failure, Movie>> getMovieDetail(int movieId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CastMember>>> getMovieCast(int movieId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getRelatedMovies({
    required int movieId,
    int page = 1,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MovieVideo>>> getMovieVideos(int movieId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies({int page = 1}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MovieGenre>>> getMovieGenres() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getMoviesByGenre({
    required int genreId,
    int page = 1,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> searchMovies({
    required String query,
    int page = 1,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getTrendingMovies({int page = 1}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies({int page = 1}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies({int page = 1}) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies({int page = 1}) {
    throw UnimplementedError();
  }
}
