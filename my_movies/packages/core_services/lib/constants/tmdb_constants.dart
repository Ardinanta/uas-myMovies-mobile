abstract class TmdbConstants {
  const TmdbConstants._();

  static const String apiKey = String.fromEnvironment(
    '0a444299f0b47b46a981e414e36ac256',
  );
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p';
  static const String defaultLanguage = 'en-US';

  static bool get hasApiKey => apiKey.trim().isNotEmpty;
}
