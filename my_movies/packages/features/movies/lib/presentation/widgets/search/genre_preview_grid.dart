import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../view_models/home_movie_view_model.dart';
import '../../view_models/movie_genre_view_model.dart';

class GenrePreviewGrid extends StatelessWidget {
  const GenrePreviewGrid({
    super.key,
    required this.genres,
    required this.previewMovies,
    required this.onGenreTap,
  });

  final List<MovieGenreViewModel> genres;
  final Map<int, List<HomeMovieViewModel>> previewMovies;
  final ValueChanged<MovieGenreViewModel> onGenreTap;

  @override
  Widget build(BuildContext context) {
    final visibleGenres = genres.take(4).toList();
    if (visibleGenres.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: visibleGenres.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.82,
        ),
        itemBuilder: (context, index) {
          final genre = visibleGenres[index];
          final movies = previewMovies[genre.id] ?? const [];
          final movie = movies.isEmpty ? null : movies.first;
          return _GenrePreviewCard(
            genre: genre,
            movie: movie,
            onTap: () => onGenreTap(genre),
          );
        },
      ),
    );
  }
}

class _GenrePreviewCard extends StatelessWidget {
  const _GenrePreviewCard({
    required this.genre,
    required this.movie,
    required this.onTap,
  });

  final MovieGenreViewModel genre;
  final HomeMovieViewModel? movie;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.lgBorder,
      child: ClipRRect(
        borderRadius: AppRadius.lgBorder,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (movie?.posterUrl == null)
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.surfaceContainerHigh,
                      AppColors.cinematicRed.withValues(alpha: 0.38),
                    ],
                  ),
                ),
              )
            else
              Image.network(
                movie!.posterUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const DecoratedBox(
                    decoration: BoxDecoration(color: AppColors.card),
                  );
                },
              ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.08),
                    Colors.black.withValues(alpha: 0.76),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    genre.name.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelCaps.copyWith(
                      color: AppColors.cinematicRed,
                      fontSize: 9,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    movie?.title ?? genre.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.titleMd.copyWith(
                      color: AppColors.white,
                      fontSize: 13,
                      height: 1.08,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
