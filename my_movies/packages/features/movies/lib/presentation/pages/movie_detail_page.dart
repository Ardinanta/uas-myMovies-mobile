import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/detail/movie_detail_bloc.dart';
import '../bloc/detail/movie_detail_event.dart';
import '../bloc/detail/movie_detail_state.dart';
import '../widgets/detail/movie_cast_section.dart';
import '../widgets/detail/movie_detail_header.dart';
import '../widgets/detail/movie_detail_info_card.dart';
import '../widgets/detail/movie_overview_section.dart';
import '../widgets/detail/related_movies_section.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({
    super.key,
    required this.movieId,
    required this.detailBloc,
    required this.onRelatedMovieTap,
  });

  final int movieId;
  final MovieDetailBloc detailBloc;
  final ValueChanged<int> onRelatedMovieTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => detailBloc..add(MovieDetailStarted(movieId)),
      child: Scaffold(
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            return switch (state.status) {
              MovieDetailStatus.initial || MovieDetailStatus.loading =>
                const _MovieDetailLoading(),
              MovieDetailStatus.failure => _MovieDetailError(
                message: state.message ?? 'Gagal memuat detail movie.',
                onRetry: () {
                  context.read<MovieDetailBloc>().add(
                    MovieDetailRetried(movieId),
                  );
                },
              ),
              MovieDetailStatus.success => _MovieDetailContent(
                state: state,
                onRelatedMovieTap: onRelatedMovieTap,
              ),
            };
          },
        ),
      ),
    );
  }
}

class _MovieDetailContent extends StatelessWidget {
  const _MovieDetailContent({
    required this.state,
    required this.onRelatedMovieTap,
  });

  final MovieDetailState state;
  final ValueChanged<int> onRelatedMovieTap;

  @override
  Widget build(BuildContext context) {
    final movie = state.movie!;

    return AppRefreshIndicator(
      onRefresh: () => _refresh(context, movie.id),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 462,
              child: Stack(
                children: [
                  MovieDetailHeader(
                    movie: movie,
                    onBackTap: () => Navigator.of(context).pop(),
                    onShareTap: () {},
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 266,
                    child: MovieDetailInfoCard(
                      movie: movie,
                      onWatchTap: state.trailerUrl == null
                          ? null
                          : () => _openTrailerVideo(context, state.trailerUrl!),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(
            child: MovieOverviewSection(overview: movie.overview),
          ),
          SliverToBoxAdapter(child: MovieCastSection(cast: state.cast)),
          SliverToBoxAdapter(
            child: RelatedMoviesSection(
              movies: state.relatedMovies,
              onMovieTap: (movie) => onRelatedMovieTap(movie.id),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refresh(BuildContext context, int movieId) async {
    final bloc = context.read<MovieDetailBloc>()..add(MovieDetailRetried(movieId));
    await bloc.stream.firstWhere(
      (state) => state.status != MovieDetailStatus.loading,
    );
  }

  Future<void> _openTrailerVideo(BuildContext context, Uri trailerUrl) async {
    final messenger = ScaffoldMessenger.of(context);
    var launched = false;

    try {
      launched = await launchUrl(
        trailerUrl,
        mode: LaunchMode.externalApplication,
      );
    } catch (_) {
      launched = false;
    }

    if (!launched) {
      launched = await launchUrl(trailerUrl);
    }

    if (!launched) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Trailer belum bisa dibuka.')),
      );
    }
  }
}

class _MovieDetailLoading extends StatelessWidget {
  const _MovieDetailLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.cinematicRed),
    );
  }
}

class _MovieDetailError extends StatelessWidget {
  const _MovieDetailError({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.cinematicRed,
              size: 40,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurface),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Coba Lagi')),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}
