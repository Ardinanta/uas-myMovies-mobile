import 'package:core_services/core_services.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movies/movies.dart';

void main() {
  testWidgets('renders home page content', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(
          homeBloc: HomeBloc(
            getTrendingMovies: GetTrendingMovies(_FakeMovieRepository()),
            getPopularMovies: GetPopularMovies(_FakeMovieRepository()),
            getTopRatedMovies: GetTopRatedMovies(_FakeMovieRepository()),
            getUpcomingMovies: GetUpcomingMovies(_FakeMovieRepository()),
          ),
          onSearchTap: () {},
          onFavoriteTap: () {},
          onProfileTap: () {},
          onMovieTap: (_) {},
        ),
      ),
    );

    await tester.pump();

    expect(find.text('Popular Movies'), findsOneWidget);
    expect(find.text('Top Rated Movies'), findsOneWidget);
    expect(find.text('Upcoming Movies'), findsOneWidget);
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
    return Future.value(
      Right([
        Movie(
          id: 1,
          title: 'Trending Movie',
          overview: 'A trending movie.',
          voteAverage: 8.8,
          releaseDate: DateTime(2024),
        ),
      ]),
    );
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies({int page = 1}) {
    return getTrendingMovies(page: page);
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies({int page = 1}) {
    return getTrendingMovies(page: page);
  }

  @override
  Future<Either<Failure, List<Movie>>> getUpcomingMovies({int page = 1}) {
    return getTrendingMovies(page: page);
  }
}
