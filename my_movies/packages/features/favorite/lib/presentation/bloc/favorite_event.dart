sealed class FavoriteEvent {
  const FavoriteEvent();
}

class FavoriteStarted extends FavoriteEvent {
  const FavoriteStarted();
}

class FavoriteRetried extends FavoriteEvent {
  const FavoriteRetried();
}

class FavoriteMovieRemoved extends FavoriteEvent {
  const FavoriteMovieRemoved(this.movieId);

  final int movieId;
}
