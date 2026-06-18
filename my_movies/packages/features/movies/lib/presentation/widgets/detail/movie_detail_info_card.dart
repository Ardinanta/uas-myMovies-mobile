import 'package:core_ui/core_ui.dart';
import 'package:favorite/favorite.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/movie.dart';
import '../../view_models/movie_detail_view_model.dart';

class MovieDetailInfoCard extends StatefulWidget {
  const MovieDetailInfoCard({
    super.key,
    required this.movie,
    required this.onWatchTap,
  });

  final MovieDetailViewModel movie;
  final VoidCallback? onWatchTap;

  @override
  State<MovieDetailInfoCard> createState() => _MovieDetailInfoCardState();
}

class _MovieDetailInfoCardState extends State<MovieDetailInfoCard> {
  bool _isFavorite = false;
  bool _isSaved = false;
  bool _isFavoriteLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  @override
  void didUpdateWidget(MovieDetailInfoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.movie.id != widget.movie.id) {
      _loadFavoriteStatus();
    }
  }

  Future<void> _loadFavoriteStatus() async {
    setState(() => _isFavoriteLoading = true);
    setupFavoriteDependencies();

    final result = await GetIt.instance<IsMovieFavorite>()(widget.movie.id);
    if (!mounted) {
      return;
    }

    setState(() {
      _isFavorite = result.isRight && result.right;
      _isFavoriteLoading = false;
    });
  }

  Future<void> _toggleFavorite() async {
    if (_isFavoriteLoading) {
      return;
    }

    setState(() => _isFavoriteLoading = true);

    final movie = Movie(
      id: widget.movie.id,
      title: widget.movie.title,
      overview: widget.movie.overview,
      voteAverage: widget.movie.rating,
      posterPath: widget.movie.posterPath,
      backdropPath: widget.movie.backdropPath,
      releaseDate: widget.movie.releaseDate,
    );
    final result = await GetIt.instance<ToggleFavoriteMovie>()(movie);

    if (!mounted) {
      return;
    }

    result.fold(
      (failure) {
        setState(() => _isFavoriteLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(failure.message)),
        );
      },
      (isFavorite) {
        setState(() {
          _isFavorite = isFavorite;
          _isFavoriteLoading = false;
        });
      },
    );
  }

  void _toggleSaved() {
    setState(() => _isSaved = !_isSaved);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.94),
        borderRadius: AppRadius.lgBorder,
        border: Border.all(color: AppColors.white.withValues(alpha: 0.06)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.32),
            blurRadius: 24,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _RatingPill(rating: widget.movie.rating),
                const SizedBox(width: 8),
                Text(
                  widget.movie.releaseYear,
                  style: AppTextStyles.bodySm.copyWith(
                    color: AppColors.mutedSilver,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              widget.movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.headlineLgMobile.copyWith(
                color: AppColors.white,
                fontSize: 24,
                height: 1.05,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Movie',
              style: AppTextStyles.labelCaps.copyWith(
                color: AppColors.mutedSilver,
                fontSize: 9,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: widget.onWatchTap,
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: Text(
                      widget.onWatchTap == null
                          ? 'Trailer Tidak Tersedia'
                          : 'Watch Trailer',
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton.filled(
                  onPressed: _isFavoriteLoading ? null : _toggleFavorite,
                  icon: _isFavoriteLoading
                      ? const SizedBox.square(
                          dimension: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                          ),
                        )
                      : Icon(
                          _isFavorite
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                        ),
                  tooltip: _isFavorite ? 'Hapus Favorite' : 'Favorite',
                  style: IconButton.styleFrom(
                    backgroundColor: _isFavorite
                        ? AppColors.cinematicRed.withValues(alpha: 0.18)
                        : AppColors.surfaceContainerHigh,
                    foregroundColor: _isFavorite
                        ? AppColors.cinematicRed
                        : AppColors.white,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _toggleSaved,
                  icon: Icon(
                    _isSaved
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                  ),
                  tooltip: _isSaved ? 'Hapus Simpan' : 'Simpan',
                  style: IconButton.styleFrom(
                    backgroundColor: _isSaved
                        ? AppColors.gold.withValues(alpha: 0.18)
                        : AppColors.surfaceContainerHigh,
                    foregroundColor: _isSaved ? AppColors.gold : AppColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
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
        color: AppColors.gold.withValues(alpha: 0.14),
        borderRadius: AppRadius.fullBorder,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star_rounded, color: AppColors.gold, size: 14),
            const SizedBox(width: 4),
            Text(
              rating.toStringAsFixed(1),
              style: AppTextStyles.labelCaps.copyWith(
                color: AppColors.gold,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
