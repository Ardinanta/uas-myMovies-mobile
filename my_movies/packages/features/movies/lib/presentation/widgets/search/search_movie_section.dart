import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../view_models/home_movie_view_model.dart';
import '../home/movie_poster_card.dart';

class SearchMovieSection extends StatelessWidget {
  const SearchMovieSection({
    super.key,
    required this.title,
    required this.movies,
    required this.onMovieTap,
    this.trailing,
    this.leading,
    this.showAll = false,
  });

  final String title;
  final List<HomeMovieViewModel> movies;
  final ValueChanged<HomeMovieViewModel> onMovieTap;
  final Widget? trailing;
  final Widget? leading;
  final bool showAll;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Row(
            children: [
              ?leading,
              if (leading != null) const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.titleMd.copyWith(
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
        ),
        if (showAll)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 18,
                childAspectRatio: 0.56,
              ),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MoviePosterCard(
                  movie: movie,
                  width: double.infinity,
                  onTap: () => onMovieTap(movie),
                );
              },
            ),
          )
        else
          SizedBox(
            height: 210,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MoviePosterCard(
                  movie: movie,
                  width: 112,
                  onTap: () => onMovieTap(movie),
                );
              },
              separatorBuilder: (_, _) => const SizedBox(width: 14),
              itemCount: movies.length,
            ),
          ),
      ],
    );
  }
}
