abstract class TmdbApi {
  const TmdbApi._();

  //movies
  static const String nowPlayingMovies = '/movie/now_playing';
  static const String trendingMovies = '/trending/movie/day';
  static const String popularMovies = '/movie/popular';
  static const String topRatedMovies = '/movie/top_rated';
  static const String upcomingMovies = '/movie/upcoming';
  static const String movieDetail = '/movie/{movieId}';
  static String movieDetailById(int movieId) => '/movie/$movieId';
  static const String movieCredits = '/movie/{movieId}/credits';
  static const String relatedMovies = '/movie/{movieId}/recommendations';
  static const String movieVideos = '/movie/{movieId}/videos';
  static const String searchMovies = '/search/movie';

  //auth
  static const String createRequestToken = '/authentication/token/new';
  static const String validateRequestTokenWithLogin =
      '/authentication/token/validate_with_login';
  static const String createSession = '/authentication/session/new';
  static const String createGuestSession = '/authentication/guest_session/new';

  //account
  static const String account = '/account';
  static const String favoriteMovies = '/account/{accountId}/favorite/movies';
  static const String favoriteTv = '/account/{accountId}/favorite/tv';
}
