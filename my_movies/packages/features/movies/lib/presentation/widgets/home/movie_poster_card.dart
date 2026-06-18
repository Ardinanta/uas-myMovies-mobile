import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../view_models/home_movie_view_model.dart';

class MoviePosterCard extends StatelessWidget {
  const MoviePosterCard({
    super.key,
    required this.movie,
    required this.width,
    required this.onTap,
    this.isLarge = false,
  });

  final HomeMovieViewModel movie;
  final double width;
  final VoidCallback onTap;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.lgBorder,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: AppRadius.lgBorder,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (movie.posterUrl == null)
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: movie.colors
                                .map((color) => Color(color))
                                .toList(),
                          ),
                        ),
                      )
                    else
                      Image.network(
                        movie.posterUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: movie.colors
                                    .map((color) => Color(color))
                                    .toList(),
                              ),
                            ),
                          );
                        },
                      ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.18),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: _RatingChip(rating: movie.rating),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Icon(
                        isLarge
                            ? Icons.theaters_rounded
                            : Icons.movie_creation_rounded,
                        color: AppColors.white.withValues(alpha: 0.78),
                        size: isLarge ? 34 : 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              movie.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySm.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              movie.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodySm.copyWith(
                color: AppColors.mutedSilver,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingChip extends StatelessWidget {
  const _RatingChip({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.14),
        borderRadius: AppRadius.fullBorder,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star_rounded, color: AppColors.gold, size: 12),
            const SizedBox(width: 3),
            Text(
              rating.toStringAsFixed(1),
              style: AppTextStyles.labelCaps.copyWith(
                color: AppColors.gold,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
