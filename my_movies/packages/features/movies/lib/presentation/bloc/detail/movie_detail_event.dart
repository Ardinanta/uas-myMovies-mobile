sealed class MovieDetailEvent {
  const MovieDetailEvent();
}

class MovieDetailStarted extends MovieDetailEvent {
  const MovieDetailStarted(this.movieId);

  final int movieId;
}

class MovieDetailRetried extends MovieDetailEvent {
  const MovieDetailRetried(this.movieId);

  final int movieId;
}
