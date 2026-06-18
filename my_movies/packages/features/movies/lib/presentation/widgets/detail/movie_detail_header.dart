import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../view_models/movie_detail_view_model.dart';

class MovieDetailHeader extends StatelessWidget {
  const MovieDetailHeader({
    super.key,
    required this.movie,
    required this.onBackTap,
    required this.onShareTap,
  });

  final MovieDetailViewModel movie;
  final VoidCallback onBackTap;
  final VoidCallback onShareTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (movie.backdropUrl == null)
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff0f2a31),
                    Color(0xff1f2937),
                    Color(0xff22080a),
                  ],
                ),
              ),
            )
          else
            Image.network(
              movie.backdropUrl!,
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
                  Colors.black.withValues(alpha: 0.18),
                  AppColors.background.withValues(alpha: 0.22),
                  AppColors.background,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton.filled(
                    onPressed: onBackTap,
                    icon: const Icon(Icons.arrow_back_rounded),
                    tooltip: 'Kembali',
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.surfaceContainerLowest
                          .withValues(alpha: 0.68),
                      foregroundColor: AppColors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton.filled(
                    onPressed: onShareTap,
                    icon: const Icon(Icons.share_rounded),
                    tooltip: 'Bagikan',
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.surfaceContainerLowest
                          .withValues(alpha: 0.68),
                      foregroundColor: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
