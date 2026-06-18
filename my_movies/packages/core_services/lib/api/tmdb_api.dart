abstract class TmdbApi {
  const TmdbApi._();

  static const String nowPlayingMovies = '/movie/now_playing';

  static const String trendingMovies = '/trending/movie/day';

  static const String popularMovies = '/movie/popular';

  static const String topRatedMovies = '/movie/top_rated';

  static const String upcomingMovies = '/movie/upcoming';

  static const String movieDetail = '/movie/{movieId}';

  static String movieDetailById(int movieId) => '/movie/$movieId';

  static const String searchMovies = '/search/movie';

  static const String favoriteMovies = '/account/{accountId}/favorite/movies';

  static const String favoriteTv = '/account/{accountId}/favorite/tv';
}
