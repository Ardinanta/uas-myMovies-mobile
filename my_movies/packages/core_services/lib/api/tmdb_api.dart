class TmdbApi {
  const TmdbApi();

  String get nowPlayingMovies => '/movie/now_playing';

  String movieDetail(int movieId) => '/movie/$movieId';

  String get searchMovies => '/search/movie';
}
