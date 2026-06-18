import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_popular_movies.dart';
import '../../../domain/usecases/get_top_rated_movies.dart';
import '../../../domain/usecases/get_trending_movies.dart';
import '../../../domain/usecases/get_upcoming_movies.dart';
import '../../view_models/home_movie_view_model.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetTrendingMovies getTrendingMovies,
    required GetPopularMovies getPopularMovies,
    required GetTopRatedMovies getTopRatedMovies,
    required GetUpcomingMovies getUpcomingMovies,
  }) : _getTrendingMovies = getTrendingMovies,
       _getPopularMovies = getPopularMovies,
       _getTopRatedMovies = getTopRatedMovies,
       _getUpcomingMovies = getUpcomingMovies,
       super(const HomeState.initial()) {
    on<HomeStarted>(_onStarted);
    on<HomeRetried>(_onStarted);
  }

  final GetTrendingMovies _getTrendingMovies;
  final GetPopularMovies _getPopularMovies;
  final GetTopRatedMovies _getTopRatedMovies;
  final GetUpcomingMovies _getUpcomingMovies;

  Future<void> _onStarted(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    final trendingResult = await _getTrendingMovies();
    final popularResult = await _getPopularMovies();
    final topRatedResult = await _getTopRatedMovies();
    final upcomingResult = await _getUpcomingMovies();

    final failure = trendingResult.fold((failure) => failure, (_) => null) ??
        popularResult.fold((failure) => failure, (_) => null) ??
        topRatedResult.fold((failure) => failure, (_) => null) ??
        upcomingResult.fold((failure) => failure, (_) => null);

    if (failure != null) {
      emit(
        state.copyWith(
          status: HomeStatus.failure,
          message: failure.message,
        ),
      );
      return;
    }

    final trending = trendingResult.right;
    final popular = popularResult.right;
    final topRated = topRatedResult.right;
    final upcoming = upcomingResult.right;

    final trendingViewModels = trending
        .take(10)
        .map(HomeMovieViewModel.fromMovie)
        .toList();
    final popularViewModels = popular.map(HomeMovieViewModel.fromMovie).toList();
    final topRatedViewModels = topRated
        .map(HomeMovieViewModel.fromMovie)
        .toList();
    final upcomingViewModels = upcoming
        .map(HomeMovieViewModel.fromMovie)
        .toList();

    emit(
      state.copyWith(
        status: trendingViewModels.isEmpty &&
                popularViewModels.isEmpty &&
                topRatedViewModels.isEmpty &&
                upcomingViewModels.isEmpty
            ? HomeStatus.empty
            : HomeStatus.success,
        trendingMovies: trendingViewModels,
        popularMovies: popularViewModels,
        topRatedMovies: topRatedViewModels,
        upcomingMovies: upcomingViewModels,
      ),
    );
  }
}
