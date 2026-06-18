import 'package:core_services/core_services.dart';

import '../../domain/entities/favorite_movie.dart';

class FavoriteMovieViewModel {
  const FavoriteMovieViewModel({
    required this.id,
    required this.title,
    required this.rating,
    this.subtitle,
    this.posterUrl,
  });

  factory FavoriteMovieViewModel.fromEntity(FavoriteMovie favorite) {
    final movie = favorite.movie;
    return FavoriteMovieViewModel(
      id: movie.id,
      title: movie.title,
      rating: movie.voteAverage,
      subtitle: movie.releaseYear == '-' ? null : movie.releaseYear,
      posterUrl: ImageUrlHelper.tmdbImageUrl(movie.posterPath),
    );
  }

  final int id;
  final String title;
  final double rating;
  final String? subtitle;
  final String? posterUrl;
}
