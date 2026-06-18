import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../view_models/favorite_movie_view_model.dart';

class FavoriteMovieCard extends StatelessWidget {
  const FavoriteMovieCard({
    super.key,
    required this.movie,
    required this.onTap,
    required this.onRemoveTap,
  });

  final FavoriteMovieViewModel movie;
  final VoidCallback onTap;
  final VoidCallback onRemoveTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xff10212a),
                            Color(0xff1f2937),
                            Color(0xff6d0f16),
                          ],
                        ),
                      ),
                    )
                  else
                    Image.network(
                      movie.posterUrl!,
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
                          Colors.black.withValues(alpha: 0.04),
                          Colors.black.withValues(alpha: 0.72),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkResponse(
                      onTap: onRemoveTap,
                      radius: 20,
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: AppColors.cinematicRed,
                        size: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    bottom: 8,
                    child: _RatingPill(rating: movie.rating),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodySm.copyWith(
              color: AppColors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingPill extends StatelessWidget {
  const _RatingPill({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.58),
        borderRadius: AppRadius.fullBorder,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star_rounded, color: AppColors.gold, size: 11),
            const SizedBox(width: 3),
            Text(
              rating.toStringAsFixed(1),
              style: AppTextStyles.labelCaps.copyWith(
                color: AppColors.gold,
                fontSize: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
