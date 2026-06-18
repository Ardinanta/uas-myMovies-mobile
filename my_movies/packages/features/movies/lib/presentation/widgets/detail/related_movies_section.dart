import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../view_models/home_movie_view_model.dart';
import '../home/movie_poster_card.dart';

class RelatedMoviesSection extends StatelessWidget {
  const RelatedMoviesSection({
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

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Related Movies',
              style: AppTextStyles.titleMd.copyWith(
                color: AppColors.white,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 176,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MoviePosterCard(
                  movie: movie,
                  width: 108,
                  onTap: () => onMovieTap(movie),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
