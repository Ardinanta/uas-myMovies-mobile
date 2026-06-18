import 'package:core_services/core_services.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/repositories/movie_repository.dart';
import 'domain/usecases/detail/get_movie_cast.dart';
import 'domain/usecases/detail/get_movie_detail.dart';
import 'domain/usecases/detail/get_movie_videos.dart';
import 'domain/usecases/detail/get_related_movies.dart';
import 'domain/usecases/home/get_popular_movies.dart';
import 'domain/usecases/home/get_top_rated_movies.dart';
import 'domain/usecases/home/get_trending_movies.dart';
import 'domain/usecases/home/get_upcoming_movies.dart';
import 'domain/usecases/search/get_movie_genres.dart';
import 'domain/usecases/search/get_movies_by_genre.dart';
import 'domain/usecases/search/search_movies.dart';
import 'presentation/bloc/home/home_bloc.dart';
import 'presentation/bloc/detail/movie_detail_bloc.dart';
import 'presentation/bloc/search/search_bloc.dart';

final moviesSl = GetIt.instance;

void setupMoviesDependencies({GetIt? getIt}) {
  final sl = getIt ?? moviesSl;

  setupCoreServicesDependencies(getIt: sl);

  if (!sl.isRegistered<MovieRemoteDataSource>()) {
    sl.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(dioClient: sl<DioClient>()),
    );
  }

  if (!sl.isRegistered<MovieRepository>()) {
    sl.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(sl<MovieRemoteDataSource>()),
    );
  }

  if (!sl.isRegistered<GetTrendingMovies>()) {
    sl.registerLazySingleton<GetTrendingMovies>(
      () => GetTrendingMovies(sl<MovieRepository>()),
    );
  }
  if (!sl.isRegistered<GetPopularMovies>()) {
    sl.registerLazySingleton<GetPopularMovies>(
      () => GetPopularMovies(sl<MovieRepository>()),
    );
  }
  if (!sl.isRegistered<GetTopRatedMovies>()) {
    sl.registerLazySingleton<GetTopRatedMovies>(
      () => GetTopRatedMovies(sl<MovieRepository>()),
    );
  }
  if (!sl.isRegistered<GetUpcomingMovies>()) {
    sl.registerLazySingleton<GetUpcomingMovies>(
      () => GetUpcomingMovies(sl<MovieRepository>()),
    );
  }
  if (!sl.isRegistered<GetMovieGenres>()) {
    sl.registerLazySingleton<GetMovieGenres>(
      () => GetMovieGenres(sl<MovieRepository>()),
    );
  }
  if (!sl.isRegistered<GetMoviesByGenre>()) {
    sl.registerLazySingleton<GetMoviesByGenre>(
      () => GetMoviesByGenre(sl<MovieRepository>()),
    );
  }
  if (!sl.isRegistered<SearchMovies>()) {
    sl.registerLazySingleton<SearchMovies>(
      () => SearchMovies(sl<MovieRepository>()),
    );
  }
  if (!sl.isRegistered<GetMovieDetail>()) {
    sl.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(sl<MovieRepository>()),
    );
  }
  if (!sl.isRegistered<GetMovieCast>()) {
    sl.registerLazySingleton<GetMovieCast>(
      () => GetMovieCast(sl<MovieRepository>()),
    );
  }
  if (!sl.isRegistered<GetRelatedMovies>()) {
    sl.registerLazySingleton<GetRelatedMovies>(
      () => GetRelatedMovies(sl<MovieRepository>()),
    );
  }
  if (!sl.isRegistered<GetMovieVideos>()) {
    sl.registerLazySingleton<GetMovieVideos>(
      () => GetMovieVideos(sl<MovieRepository>()),
    );
  }

  if (!sl.isRegistered<HomeBloc>()) {
    sl.registerFactory<HomeBloc>(
      () => HomeBloc(
        getTrendingMovies: sl<GetTrendingMovies>(),
        getPopularMovies: sl<GetPopularMovies>(),
        getTopRatedMovies: sl<GetTopRatedMovies>(),
        getUpcomingMovies: sl<GetUpcomingMovies>(),
      ),
    );
  }

  if (!sl.isRegistered<MovieDetailBloc>()) {
    sl.registerFactory<MovieDetailBloc>(
      () => MovieDetailBloc(
        getMovieDetail: sl<GetMovieDetail>(),
        getMovieCast: sl<GetMovieCast>(),
        getRelatedMovies: sl<GetRelatedMovies>(),
        getMovieVideos: sl<GetMovieVideos>(),
      ),
    );
  }

  if (!sl.isRegistered<SearchBloc>()) {
    sl.registerFactory<SearchBloc>(
      () => SearchBloc(
        getTrendingMovies: sl<GetTrendingMovies>(),
        getPopularMovies: sl<GetPopularMovies>(),
        getMovieGenres: sl<GetMovieGenres>(),
        getMoviesByGenre: sl<GetMoviesByGenre>(),
        searchMovies: sl<SearchMovies>(),
      ),
    );
  }
}

HomeBloc createHomeBloc({DioClient? dioClient}) {
  if (dioClient == null) {
    setupMoviesDependencies();
    return moviesSl<HomeBloc>();
  }

  final remoteDataSource = MovieRemoteDataSourceImpl(
    dioClient: dioClient,
  );
  final repository = MovieRepositoryImpl(remoteDataSource);

  return HomeBloc(
    getTrendingMovies: GetTrendingMovies(repository),
    getPopularMovies: GetPopularMovies(repository),
    getTopRatedMovies: GetTopRatedMovies(repository),
    getUpcomingMovies: GetUpcomingMovies(repository),
  );
}

MovieDetailBloc createMovieDetailBloc({DioClient? dioClient}) {
  if (dioClient == null) {
    setupMoviesDependencies();
    return moviesSl<MovieDetailBloc>();
  }

  final remoteDataSource = MovieRemoteDataSourceImpl(
    dioClient: dioClient,
  );
  final repository = MovieRepositoryImpl(remoteDataSource);

  return MovieDetailBloc(
    getMovieDetail: GetMovieDetail(repository),
    getMovieCast: GetMovieCast(repository),
    getRelatedMovies: GetRelatedMovies(repository),
    getMovieVideos: GetMovieVideos(repository),
  );
}

SearchBloc createSearchBloc({DioClient? dioClient}) {
  if (dioClient == null) {
    setupMoviesDependencies();
    return moviesSl<SearchBloc>();
  }

  final remoteDataSource = MovieRemoteDataSourceImpl(
    dioClient: dioClient,
  );
  final repository = MovieRepositoryImpl(remoteDataSource);

  return SearchBloc(
    getTrendingMovies: GetTrendingMovies(repository),
    getPopularMovies: GetPopularMovies(repository),
    getMovieGenres: GetMovieGenres(repository),
    getMoviesByGenre: GetMoviesByGenre(repository),
    searchMovies: SearchMovies(repository),
  );
}
