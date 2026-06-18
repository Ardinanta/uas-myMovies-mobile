abstract class TmdbConstants {
  const TmdbConstants._();

  // static const String apiKey = String.fromEnvironment('TMDB_API_KEY');
  static const String apiKey = "0a444299f0b47b46a981e414e36ac256";
  static const String accountId = String.fromEnvironment('TMDB_ACCOUNT_ID');
  static const String sessionId = String.fromEnvironment('TMDB_SESSION_ID');
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';
  static const String defaultLanguage = 'en-US';

  static bool get hasApiKey => apiKey.trim().isNotEmpty;
  static bool get hasAccountSession {
    return accountId.trim().isNotEmpty && sessionId.trim().isNotEmpty;
  }
}
