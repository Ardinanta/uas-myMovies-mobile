import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../view_models/home_movie_view_model.dart';
import 'movie_poster_card.dart';

class MovieSection extends StatelessWidget {
  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
    required this.onMovieTap,
    this.actionLabel,
    this.isLarge = false,
  });

  final String title;
  final String? actionLabel;
  final List<HomeMovieViewModel> movies;
  final ValueChanged<HomeMovieViewModel> onMovieTap;
  final bool isLarge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.titleMd.copyWith(
                      color: AppColors.onSurface,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (actionLabel != null)
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      actionLabel!,
                      style: AppTextStyles.labelCaps.copyWith(
                        color: AppColors.cinematicRed,
                        fontSize: 9,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: isLarge ? 150 : 176,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MoviePosterCard(
                  movie: movie,
                  width: isLarge ? 148 : 108,
                  isLarge: isLarge,
                  onTap: () => onMovieTap(movie),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemCount: movies.length,
            ),
          ),
        ],
      ),
    );
  }
}
