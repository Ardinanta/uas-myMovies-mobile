import 'package:core_services/core_services.dart';

import '../../domain/entities/cast_member.dart';
import '../../domain/entities/movie.dart';

class MovieDetailViewModel {
  const MovieDetailViewModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.rating,
    required this.releaseYear,
    this.posterUrl,
    this.backdropUrl,
  });

  factory MovieDetailViewModel.fromMovie(Movie movie) {
    return MovieDetailViewModel(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      rating: movie.voteAverage,
      releaseYear: movie.releaseYear,
      posterUrl: ImageUrlHelper.tmdbImageUrl(movie.posterPath),
      backdropUrl: ImageUrlHelper.tmdbImageUrl(movie.backdropPath, size: 'w780'),
    );
  }

  final int id;
  final String title;
  final String overview;
  final double rating;
  final String releaseYear;
  final String? posterUrl;
  final String? backdropUrl;
}

class CastMemberViewModel {
  const CastMemberViewModel({
    required this.id,
    required this.name,
    required this.character,
    this.profileUrl,
  });

  factory CastMemberViewModel.fromEntity(CastMember cast) {
    return CastMemberViewModel(
      id: cast.id,
      name: cast.name,
      character: cast.character,
      profileUrl: ImageUrlHelper.tmdbImageUrl(cast.profilePath, size: 'w185'),
    );
  }

  final int id;
  final String name;
  final String character;
  final String? profileUrl;
}
