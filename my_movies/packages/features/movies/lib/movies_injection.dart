import 'package:core_services/core_services.dart';

import 'data/datasources/movie_remote_data_source.dart';
import 'data/repositories/movie_repository_impl.dart';
import 'domain/usecases/get_popular_movies.dart';
import 'domain/usecases/get_top_rated_movies.dart';
import 'domain/usecases/get_trending_movies.dart';
import 'domain/usecases/get_upcoming_movies.dart';
import 'presentation/bloc/home/home_bloc.dart';

HomeBloc createHomeBloc({DioClient? dioClient}) {
  final remoteDataSource = MovieRemoteDataSourceImpl(
    dioClient: dioClient ?? DioClient(),
  );
  final repository = MovieRepositoryImpl(remoteDataSource);

  return HomeBloc(
    getTrendingMovies: GetTrendingMovies(repository),
    getPopularMovies: GetPopularMovies(repository),
    getTopRatedMovies: GetTopRatedMovies(repository),
    getUpcomingMovies: GetUpcomingMovies(repository),
  );
}
