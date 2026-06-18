import '../constants/tmdb_constants.dart';

abstract class ImageUrlHelper {
  const ImageUrlHelper._();

  static String? tmdbImageUrl(
    String? path, {
    String size = 'w500',
  }) {
    if (path == null || path.isEmpty) {
      return null;
    }

    final normalizedBase = TmdbConstants.imageBaseUrl.endsWith('/')
        ? TmdbConstants.imageBaseUrl.substring(
            0,
            TmdbConstants.imageBaseUrl.length - 1,
          )
        : TmdbConstants.imageBaseUrl;
    final normalizedPath = path.startsWith('/') ? path : '/$path';

    return '$normalizedBase/$size$normalizedPath';
  }
}
