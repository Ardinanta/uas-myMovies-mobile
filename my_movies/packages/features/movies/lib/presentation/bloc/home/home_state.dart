import '../../view_models/home_movie_view_model.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  empty,
  failure,
}

class HomeState {
  const HomeState({
    required this.status,
    this.trendingMovies = const [],
    this.popularMovies = const [],
    this.topRatedMovies = const [],
    this.upcomingMovies = const [],
    this.message,
  });

  const HomeState.initial() : this(status: HomeStatus.initial);

  final HomeStatus status;
  final List<HomeMovieViewModel> trendingMovies;
  final List<HomeMovieViewModel> popularMovies;
  final List<HomeMovieViewModel> topRatedMovies;
  final List<HomeMovieViewModel> upcomingMovies;
  final String? message;

  HomeState copyWith({
    HomeStatus? status,
    List<HomeMovieViewModel>? trendingMovies,
    List<HomeMovieViewModel>? popularMovies,
    List<HomeMovieViewModel>? topRatedMovies,
    List<HomeMovieViewModel>? upcomingMovies,
    String? message,
  }) {
    return HomeState(
      status: status ?? this.status,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      message: message,
    );
  }
}
