import '../../view_models/home_movie_view_model.dart';
import '../../view_models/movie_detail_view_model.dart';

enum MovieDetailStatus {
  initial,
  loading,
  success,
  failure,
}

class MovieDetailState {
  const MovieDetailState({
    required this.status,
    this.movie,
    this.cast = const [],
    this.relatedMovies = const [],
    this.trailerUrl,
    this.message,
  });

  const MovieDetailState.initial() : this(status: MovieDetailStatus.initial);

  final MovieDetailStatus status;
  final MovieDetailViewModel? movie;
  final List<CastMemberViewModel> cast;
  final List<HomeMovieViewModel> relatedMovies;
  final Uri? trailerUrl;
  final String? message;

  MovieDetailState copyWith({
    MovieDetailStatus? status,
    MovieDetailViewModel? movie,
    List<CastMemberViewModel>? cast,
    List<HomeMovieViewModel>? relatedMovies,
    Uri? trailerUrl,
    String? message,
  }) {
    return MovieDetailState(
      status: status ?? this.status,
      movie: movie ?? this.movie,
      cast: cast ?? this.cast,
      relatedMovies: relatedMovies ?? this.relatedMovies,
      trailerUrl: trailerUrl ?? this.trailerUrl,
      message: message,
    );
  }
}
