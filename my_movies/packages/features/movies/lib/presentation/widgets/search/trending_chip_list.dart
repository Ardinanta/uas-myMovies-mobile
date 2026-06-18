import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../view_models/home_movie_view_model.dart';

class TrendingChipList extends StatelessWidget {
  const TrendingChipList({
    super.key,
    required this.movies,
    required this.onMovieTap,
  });

  final List<HomeMovieViewModel> movies;
  final ValueChanged<HomeMovieViewModel> onMovieTap;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return ActionChip(
            onPressed: () => onMovieTap(movie),
            label: Text(
              movie.title.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            labelStyle: AppTextStyles.labelCaps.copyWith(
              color: AppColors.white,
              fontSize: 9,
            ),
            backgroundColor: AppColors.surfaceContainerHigh,
            side: BorderSide(color: AppColors.white.withValues(alpha: 0.06)),
            shape: const StadiumBorder(),
          );
        },
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemCount: movies.length,
      ),
    );
  }
}
