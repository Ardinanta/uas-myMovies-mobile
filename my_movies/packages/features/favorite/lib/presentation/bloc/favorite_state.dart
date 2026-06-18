import '../view_models/favorite_movie_view_model.dart';

enum FavoriteStatus {
  initial,
  loading,
  success,
  empty,
  failure,
}

class FavoriteState {
  const FavoriteState({
    required this.status,
    this.movies = const [],
    this.message,
  });

  const FavoriteState.initial() : this(status: FavoriteStatus.initial);

  final FavoriteStatus status;
  final List<FavoriteMovieViewModel> movies;
  final String? message;

  FavoriteState copyWith({
    FavoriteStatus? status,
    List<FavoriteMovieViewModel>? movies,
    String? message,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      message: message,
    );
  }
}
