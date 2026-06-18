import 'package:core_services/core_services.dart';

import '../../domain/entities/movie.dart';

class HomeMovieViewModel {
  const HomeMovieViewModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.rating,
    required this.colors,
    this.posterUrl,
    this.backdropUrl,
  });

  factory HomeMovieViewModel.fromMovie(Movie movie) {
    return HomeMovieViewModel(
      id: movie.id,
      title: movie.title,
      subtitle: 'Movie - ${movie.releaseYear}',
      rating: movie.voteAverage,
      posterUrl: ImageUrlHelper.tmdbImageUrl(movie.posterPath),
      backdropUrl: ImageUrlHelper.tmdbImageUrl(movie.backdropPath, size: 'w780'),
      colors: _colorsForMovie(movie.id),
    );
  }

  final int id;
  final String title;
  final String subtitle;
  final double rating;
  final List<int> colors;
  final String? posterUrl;
  final String? backdropUrl;

  static List<int> _colorsForMovie(int id) {
    const palettes = [
      [0xff111827, 0xff7f1d1d],
      [0xff111827, 0xfff97316],
      [0xff0f172a, 0xff2563eb],
      [0xff1f2937, 0xffca8a04],
    ];

    return palettes[id.abs() % palettes.length];
  }
}
