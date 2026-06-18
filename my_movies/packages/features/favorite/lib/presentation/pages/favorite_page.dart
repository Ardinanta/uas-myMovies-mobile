import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/favorite_bloc.dart';
import '../bloc/favorite_event.dart';
import '../bloc/favorite_state.dart';
import '../widgets/favorite_movie_card.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({
    super.key,
    required this.favoriteBloc,
    required this.onHomeTap,
    required this.onSearchTap,
    required this.onProfileTap,
    required this.onMovieTap,
  });

  final FavoriteBloc favoriteBloc;
  final VoidCallback onHomeTap;
  final VoidCallback onSearchTap;
  final VoidCallback onProfileTap;
  final ValueChanged<int> onMovieTap;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => favoriteBloc..add(const FavoriteStarted()),
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: AppBottomNavBar(
          currentItem: AppBottomNavItem.favorite,
          onItemSelected: (item) {
            switch (item) {
              case AppBottomNavItem.home:
                onHomeTap();
              case AppBottomNavItem.search:
                onSearchTap();
              case AppBottomNavItem.favorite:
                break;
              case AppBottomNavItem.profile:
                onProfileTap();
            }
          },
        ),
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              return AppRefreshIndicator(
                onRefresh: () => _refresh(context),
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: _FavoriteHeader(count: state.movies.length),
                    ),
                    switch (state.status) {
                      FavoriteStatus.initial || FavoriteStatus.loading =>
                        const SliverToBoxAdapter(child: _FavoriteLoadingState()),
                      FavoriteStatus.failure => SliverToBoxAdapter(
                        child: _FavoriteErrorState(
                          message: state.message ?? 'Gagal memuat favorite.',
                          onRetry: () {
                            context.read<FavoriteBloc>().add(
                              const FavoriteRetried(),
                            );
                          },
                        ),
                      ),
                      FavoriteStatus.empty => const SliverToBoxAdapter(
                        child: _FavoriteEmptyState(),
                      ),
                      FavoriteStatus.success => SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 96),
                        sliver: SliverGrid.builder(
                          itemCount: state.movies.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 18,
                                mainAxisSpacing: 22,
                                childAspectRatio: 0.58,
                              ),
                          itemBuilder: (context, index) {
                            final movie = state.movies[index];
                            return FavoriteMovieCard(
                              movie: movie,
                              onTap: () => onMovieTap(movie.id),
                              onRemoveTap: () {
                                context.read<FavoriteBloc>().add(
                                  FavoriteMovieRemoved(movie.id),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    },
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _refresh(BuildContext context) async {
    final bloc = context.read<FavoriteBloc>()..add(const FavoriteRetried());
    await bloc.stream.firstWhere(
      (state) => state.status != FavoriteStatus.loading,
    );
  }
}

class _FavoriteHeader extends StatelessWidget {
  const _FavoriteHeader({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'My Favorites',
              style: AppTextStyles.titleMd.copyWith(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Text(
            '$count MOVIES',
            style: AppTextStyles.labelCaps.copyWith(
              color: AppColors.white,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteLoadingState extends StatelessWidget {
  const _FavoriteLoadingState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: CircularProgressIndicator(color: AppColors.cinematicRed),
      ),
    );
  }
}

class _FavoriteErrorState extends StatelessWidget {
  const _FavoriteErrorState({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMd.copyWith(color: AppColors.onSurface),
          ),
          const SizedBox(height: 14),
          FilledButton(onPressed: onRetry, child: const Text('Coba Lagi')),
        ],
      ),
    );
  }
}

class _FavoriteEmptyState extends StatelessWidget {
  const _FavoriteEmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 64, 28, 0),
      child: Text(
        'Belum ada movie favorite. Tekan ikon love pada movie untuk menyimpannya.',
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyMd.copyWith(color: AppColors.mutedSilver),
      ),
    );
  }
}
