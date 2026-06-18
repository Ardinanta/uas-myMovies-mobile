import 'package:flutter_test/flutter_test.dart';

import 'package:core_services/core_services.dart';

void main() {
  test('exposes TMDb constants', () {
    expect(TmdbConstants.baseUrl, 'https://api.themoviedb.org/3');
  });

  test('registers TMDb API endpoints', () {
    expect(TmdbApi.nowPlayingMovies, '/movie/now_playing');
    expect(TmdbApi.movieDetail, '/movie/{movieId}');
    expect(TmdbApi.movieDetailById(12), '/movie/12');
    expect(TmdbApi.searchMovies, '/search/movie');
  });

  test('builds TMDb image URL', () {
    expect(
      ImageUrlHelper.tmdbImageUrl('/poster.jpg'),
      'https://image.tmdb.org/t/p/w500/poster.jpg',
    );
    expect(ImageUrlHelper.tmdbImageUrl(null), isNull);
  });

  test('maps missing API key exception into failure', () {
    final failure = ErrorMapper.map(const MissingApiKeyException());

    expect(failure.type, FailureType.missingApiKey);
  });
}
